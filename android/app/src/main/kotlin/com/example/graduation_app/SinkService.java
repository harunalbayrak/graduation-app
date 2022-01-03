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
import android.util.Log;
import android.widget.Toast;

import java.io.IOException;
import java.util.List;
import java.util.HashMap;

@SuppressLint("NewApi")
public class SinkService extends VpnService {
    private static final String TAG = "LOCAL_VPN.Service";
    private ParcelFileDescriptor vpn = null;
    private static final String EXTRA_COMMAND = "Command";
    private enum Command {start, reload, stop}

    private static HashMap<String, Boolean> _wifiRules = new HashMap<String, Boolean>();
    private static HashMap<String, Boolean> _mobileNetworkRules = new HashMap<String, Boolean>();

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i(TAG, "pika");
        // Get enabled
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        boolean enabled = prefs.getBoolean("enabled", false);

        // Get command
        Command cmd = (intent == null ? Command.start : (Command) intent.getSerializableExtra(EXTRA_COMMAND));
        Log.i(TAG, "Start intent=" + intent + " command=" + cmd + " enabled=" + enabled + " vpn=" + (vpn != null));

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

    public int changeRule(){

        return 0;
    }

    private ParcelFileDescriptor vpnStart() {
        Log.i(TAG, "Starting");

        // Build VPN service
        final Builder builder = new Builder();
        builder.setSession("local_vpn");
        builder.addAddress("10.1.10.1", 32);
        builder.addAddress("fd00:1:fd00:1:fd00:1:fd00:1", 128);
        builder.addRoute("0.0.0.0", 0);
        builder.addRoute("0:0:0:0:0:0:0:0", 0);

        if(setInitialRules(builder) != 0){
            Log.e(TAG, "Set Initial Rules Error\n");
        }

        // Build configure intent
        Intent configure = new Intent(this, MainActivity.class);
        PendingIntent pi = PendingIntent.getActivity(this, 0, configure, PendingIntent.FLAG_UPDATE_CURRENT);
        builder.setConfigureIntent(pi);

        // Start VPN service
        try {
            return builder.establish();
        } catch (Throwable ex) {
            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));

            // Disable firewall
            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
            prefs.edit().putBoolean("enabled", false).apply();

            // Feedback
            Util.toast(ex.toString(), Toast.LENGTH_LONG, this);

            return null;
        }
    }

    private int setInitialRules(Builder builder){
        // Check if Wi-Fi
        boolean wifi = Util.isWifiActive(this);
        Log.i(TAG, "wifi=" + wifi);

        HashMap<String, Boolean> _map = null;
        if(wifi) {
            _map = _wifiRules;
        } else{
            _map = _mobileNetworkRules;
        }

        System.out.println("Size: " + _map.size());

        for (HashMap.Entry<String, Boolean> entry : _map.entrySet()) {
            String key = entry.getKey();
            Boolean value = entry.getValue();

            System.out.println("-> " + key + ": " + value.toString());
            
            try {
                if(value == false){
                    builder.addAllowedApplication(key);
                } else{
                    builder.addDisallowedApplication(key);
                }
                /*if(value == true){
                    builder.addDisallowedApplication(key);
                } else{
                    builder.addAllowedApplication(key);
                    //System.out.println(key);
                }*/
            } catch (PackageManager.NameNotFoundException ex) {
                Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                return -1;
            }
        }

        return 0;
    }

    private void vpnStop(ParcelFileDescriptor pfd) {
        Log.i(TAG, "Stopping");
        try {
            pfd.close();
        } catch (IOException ex) {
            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
        }
    }

    private BroadcastReceiver connectivityChangedReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Log.i(TAG, "Received " + intent);
            Util.logExtras(TAG, intent);
            if (intent.hasExtra(ConnectivityManager.EXTRA_NETWORK_TYPE) &&
                    intent.getIntExtra(ConnectivityManager.EXTRA_NETWORK_TYPE, ConnectivityManager.TYPE_DUMMY) == ConnectivityManager.TYPE_WIFI)
                reload(null, SinkService.this);
        }
    };

    private BroadcastReceiver packageAddedReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Log.i(TAG, "Received " + intent);
            Util.logExtras(TAG, intent);
            reload(null, SinkService.this);
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Create");

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
        Log.i(TAG, "Destroy");

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
        Log.i(TAG, "Revoke");

        if (vpn != null) {
            vpnStop(vpn);
            vpn = null;
        }

        // Disable firewall
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        prefs.edit().putBoolean("enabled", false).apply();

        super.onRevoke();
    }

    public static void start(Context context) {
        Log.e(TAG,"LESS GOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
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
