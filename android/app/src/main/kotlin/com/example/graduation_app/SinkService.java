package com.example.graduation_app;

import android.annotation.SuppressLint;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.VpnService;
import android.os.ParcelFileDescriptor;
import android.preference.PreferenceManager;
import android.widget.Toast;

import java.io.IOException;
import java.util.List;
import java.util.HashMap;

@SuppressLint("NewApi")
public class SinkService extends VpnService {
    private static LogService logService = new LogService();
    private ParcelFileDescriptor vpn = null;
    //private Thread vpnThread;
    private static final String EXTRA_COMMAND = "Command";
    private static HashMap<String, Boolean> _wifiRules = new HashMap<String, Boolean>();
    private static HashMap<String, Boolean> _mobileNetworkRules = new HashMap<String, Boolean>();
    private HashMap<String, Boolean> mapHostsBlocked = new HashMap<>();

    private static Object jni_lock = new Object();
    private static long jni_context = 0;

    private HostUtil hostUtil = new HostUtil(this);

    private enum Command {start, reload, stop}

    private native long jni_init(int sdk);
    private native void jni_start(long context, int loglevel);
    private native void jni_run(long context, int tun, boolean fwd53, int rcode);
    private native void jni_stop(long context);
    private native void jni_clear(long context);
    private native int jni_get_mtu();
    private native int[] jni_get_stats(long context);
    private static native void jni_pcap(String name, int record_size, int file_size);
    private native void jni_socks5(String addr, int port, String username, String password);
    private native void jni_done(long context);

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // Get enabled
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        boolean enabled = prefs.getBoolean("enabled", false);

        Command cmd = (intent == null ? Command.start : (Command) intent.getSerializableExtra(EXTRA_COMMAND));
        logService.LogI_1("Start intent=" + intent + " command=" + cmd + " enabled=" + enabled + " vpn=" + (vpn != null));

        // Process command
        switch (cmd) {
            case start:
                if (enabled && vpn == null)
                    vpn = vpnStart();
                break;

            case reload:
                // Seamless handover
                ParcelFileDescriptor prev = vpn;
                if (enabled)
                    vpn = vpnStart();
                if (prev != null)
                    vpnStop(prev);
                break;

            case stop:
                if (vpn != null) {
                    vpnStop(vpn);
                    vpn = null;
                }
                stopSelf();
                break;
        }

        return START_STICKY;
    }

    public static void clearRules(){
        _wifiRules = new HashMap<String, Boolean>();
        _mobileNetworkRules = new HashMap<String, Boolean>();
    }

    public static HashMap<String, Boolean> getWifiRules(){
        return _wifiRules;
    }

    public static HashMap<String, Boolean> getMobileNetworkRules(){
        return _mobileNetworkRules;
    }

    private ParcelFileDescriptor vpnStart() {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);

        logService.LogI_1("Starting");

        // Build VPN service
        final Builder builder = new Builder();
        builder.setSession("LocalVPN");
        builder.addAddress("10.1.10.1", 32);
        builder.addAddress("fd00:1:fd00:1:fd00:1:fd00:1", 128);
        builder.addRoute("0.0.0.0", 0);
        builder.addRoute("0:0:0:0:0:0:0:0", 0);

        if(setInitialRules(builder) != 0){
            logService.LogE_1("Set Initial Rules Error\n");
        }

        // Build configure intent
        Intent configure = new Intent(this, MainActivity.class);
        PendingIntent pi = PendingIntent.getActivity(this, 0, configure, PendingIntent.FLAG_UPDATE_CURRENT);
        builder.setConfigureIntent(pi);

        // Start VPN service
        try {
            return builder.establish();
        } catch (Throwable ex) {
            logService.LogE_1(ex.toString());

            // Disable firewall
            prefs.edit().putBoolean("enabled", false).apply();

            // Feedback
            Util.toast(ex.toString(), Toast.LENGTH_LONG, this);

            return null;
        }
    }

    // private Builder getBuilder(){
    // }

    private int setInitialRules(Builder builder){
        // Check if Wi-Fi
        boolean wifi = Util.isWifiActive(this);
        logService.LogI_1("wifi=" + wifi);

        HashMap<String, Boolean> _map = null;
        if(wifi) {
            _map = _wifiRules;
        } else{
            _map = _mobileNetworkRules;
        }

        for (HashMap.Entry<String, Boolean> entry : _map.entrySet()) {
            String key = entry.getKey();
            Boolean value = entry.getValue();

            try {
                if(value == true){
                    builder.addDisallowedApplication(key);
                }
            } catch (PackageManager.NameNotFoundException ex) {
                logService.LogE_1(ex.toString());
                return -1;
            }
        }

        return 0;
    }

    private void vpnStop(ParcelFileDescriptor pfd) {
        logService.LogI_1("Stopping");
        try {
            pfd.close();
        } catch (IOException ex) {
            logService.LogE_1(ex.toString());
        }
    }

    private BroadcastReceiver connectivityChangedReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            logService.LogI_1("Received " + intent);
            //Util.logExtras(intent);
            if (intent.hasExtra(ConnectivityManager.EXTRA_NETWORK_TYPE) &&
                    intent.getIntExtra(ConnectivityManager.EXTRA_NETWORK_TYPE, ConnectivityManager.TYPE_DUMMY) == ConnectivityManager.TYPE_WIFI)
                reload(null, SinkService.this);
        }
    };

    private BroadcastReceiver packageAddedReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            logService.LogI_1("Received " + intent);
            //Util.logExtras(intent);
            reload(null, SinkService.this);
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();
        logService.LogI_1("Create");

        // Listen for connectivity updates
        IntentFilter ifConnectivity = new IntentFilter();
        ifConnectivity.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
        registerReceiver(connectivityChangedReceiver, ifConnectivity);

        // Listen for added applications
        IntentFilter ifPackage = new IntentFilter();
        ifPackage.addAction(Intent.ACTION_PACKAGE_ADDED);
        ifPackage.addDataScheme("package");
        registerReceiver(packageAddedReceiver, ifPackage);
    }

    @Override
    public void onDestroy() {
        logService.LogI_1("Destroy");

        if (vpn != null) {
            vpnStop(vpn);
            vpn = null;
        }

        unregisterReceiver(connectivityChangedReceiver);
        unregisterReceiver(packageAddedReceiver);

        super.onDestroy();
    }

    @Override
    public void onRevoke() {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        
        logService.LogI_1("Revoke");

        if (vpn != null) {
            vpnStop(vpn);
            vpn = null;
        }

        // Disable firewall
        prefs.edit().putBoolean("enabled", false).apply();

        super.onRevoke();
    }

    public static void start(Context context) {
        logService.LogI_1("VPN Service Started");
        Intent intent = new Intent(context, SinkService.class);
        intent.putExtra(EXTRA_COMMAND, Command.start);
        context.startService(intent);
    }

    public static void reload(String network, Context context) {
        if (network == null || ("Wifi".equals(network) ? Util.isWifiActive(context) : !Util.isWifiActive(context))) {
            Intent intent = new Intent(context, SinkService.class);
            intent.putExtra(EXTRA_COMMAND, Command.reload);
            context.startService(intent);
        }
    }

    public static void stop(Context context) {
        Intent intent = new Intent(context, SinkService.class);
        intent.putExtra(EXTRA_COMMAND, Command.stop);
        context.startService(intent);
    }
    
}
