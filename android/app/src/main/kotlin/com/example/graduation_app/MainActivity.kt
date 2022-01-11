package com.example.graduation_app

import android.Manifest;
import androidx.core.app.ActivityCompat;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.VpnService;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.MenuItem;
import android.widget.Toast;
import org.jetbrains.anko.doAsync;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

// import com.minhui.vpn.processparse.AppInfo;
// import com.minhui.vpn.nat.NatSession;
// import com.minhui.vpn.service.FirewallVpnService;
// import com.minhui.vpn.utils.VpnServiceHelper;
// import com.minhui.vpn.ProxyConfig;
// import com.minhui.vpn.VPNConstants;
// import com.minhui.vpn.utils.ThreadProxy;

import com.timedancing.easyfirewall.core.util.VpnServiceHelper;
import com.timedancing.easyfirewall.core.service.FirewallVpnService;
import com.timedancing.easyfirewall.core.ProxyConfig;
import com.timedancing.easyfirewall.core.filter.DomainFilter;
import com.timedancing.easyfirewall.filter.BlackListFilter;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.Queue;
import java.util.LinkedList;
//import java.util.Iterator;

import kotlin.concurrent.fixedRateTimer;

class MainActivity: FlutterActivity() {
    private val CHANNEL = "LOCAL_VPN_CHANNEL";
    private var running = true;

    var hostQ : Queue<HashMap<String,String>> = LinkedList();
    val timer = Timer()

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "connectVPN" -> {
                    startVPN()
                }
                "initialRules" -> {
                    var args1 = call.argument("wifiRules") as? HashMap<String, Boolean>?
                    var args2 = call.argument("mobileNetworkRules") as? HashMap<String, Boolean>?

                    try{
                        FirewallVpnService.getWifiRules().putAll(args1 as HashMap<String, Boolean>)
                        FirewallVpnService.getMobileNetworkRules().putAll(args2 as HashMap<String, Boolean>)
                    } catch(e: Throwable){
                        println(e.message);
                        println(e.cause);
                        result.success(-1)
                    }
                    result.success(0)
                }
                "editRule" -> {
                    val args1 = call.argument("package") as String?;
                    val args2 = call.argument("networkType") as String?;
                    val args3 = call.argument("ruleBool") as Boolean?;

                    doAsync{
                        if (running) {
                            if(args2 is String && args2.equals("Wifi")){
                                FirewallVpnService.getWifiRules().replace(args1 as String, args3 as Boolean);
                            } else{
                                FirewallVpnService.getMobileNetworkRules().replace(args1 as String, args3 as Boolean);
                            }
                            reloadVPN();
                        }
                    }
                }
                "getFromQueue" -> {
                    getQueueFromProxyConfig()
                    result.success(hostQ);
                }
                "clearQueue" -> {
                    hostQ.clear();
                }
                "addBlockedHost" -> {
                    val args1 = call.argument("blockedHost") as String?;

                    BlackListFilter.addBlockedHost(args1);
                }
                "removeBlockedHost" -> {
                    val args1 = call.argument("blockedHost") as String?;

                    BlackListFilter.removeBlockedHost(args1);
                }
                "disconnectVPN" -> {
                    try{
                        closeVPN()
                    } catch(e: Exception) {
                        println(e.message);
                        result.success(-1)
                    }
                    result.success(0)
                }
                else -> {
                    Log.d("MainActivity", "fail");
                }
            }
        }
    }

    fun startVPN(){
        var PERMISSION_EXTERNAL_STORAGE = 1;
        ActivityCompat.requestPermissions(this,arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),PERMISSION_EXTERNAL_STORAGE);

        VpnServiceHelper.setMainContext(this);

        VpnServiceHelper.changeVpnRunningStatus(this, true);
        running = true;
    }

    fun reloadVPN() {
        VpnServiceHelper.reloadVPN(this);
    }

    fun closeVPN(){
        VpnServiceHelper.changeVpnRunningStatus(this, false);
        running = false;
    }

    fun getQueueFromProxyConfig(){
        var _queue = ProxyConfig.getQueue();
        copyQueueAndAdd(_queue);
        ProxyConfig.clearQueue();
    }

    fun copyQueueAndAdd(queue: Queue<HashMap<String, String>>) {
        for(q in queue){
            var xx = q.clone();
            hostQ.add(xx as HashMap<String, String>);
        }
    }
}