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

    // var hostQ : Queue<HashMap<String,String>> = LinkedList();
    var hostQ : Queue<HashMap<String,String>> = LinkedList();
    val timer = Timer()
    // private val REQUEST_VPN = 1;
    // private var handler : Handler = Handler();
    // lateinit var allNetConnection: MutableList<NatSession>;
    // lateinit var timer: ScheduledExecutorService;

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
    
    // fun closeVPN() {
    //     // VpnServiceHelper.changeVpnRunningStatus(this,false);
    //     VpnServiceHelper.stopVPN();
    // }

    // fun startVPN() {
    //     var PERMISSION_EXTERNAL_STORAGE = 1;
    //     ActivityCompat.requestPermissions(this,arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),PERMISSION_EXTERNAL_STORAGE);

    //     VpnServiceHelper.changeVpnRunningStatus(this,true);

    //     val fixedRateTimer = fixedRateTimer("timer",false,0,5000){
    //         this@MainActivity.runOnUiThread {
    //             getDataX()
    //         }
    //     }
    // }

    // fun reloadVPN() {
    //     VpnServiceHelper.reloadVPN(this);
    // }

    // fun getDataX() {
    //     ThreadProxy.getInstance().execute(object : Runnable {
    //         override fun run() {
    //             getData();
    //         }
    //     })
    // };

    // fun getData() {
    //     try{
    //         allNetConnection = VpnServiceHelper.getAllSession();
    //     } catch(e: Exception){
    //         return;
    //     }
    //     if (allNetConnection == null) {
    //         handler.post(object: Runnable{
    //             override fun run() {
    //                 refreshView(allNetConnection);
    //             }
    //         });
    //         return;
    //     }

    //     var iterator : MutableIterator<NatSession> = allNetConnection.iterator();
    //     var packageName : String = context.getPackageName();

    //     var sp = getContext().getSharedPreferences(VPNConstants.VPN_SP_NAME, Context.MODE_PRIVATE);
    //     var isShowUDP : Boolean = sp.getBoolean(VPNConstants.IS_UDP_SHOW, false);
    //     var selectPackage : String? = sp.getString("default_package_id", null);

    //     while(iterator.hasNext()) {
    //         var next : NatSession = iterator.next();
    //         if (next.bytesSent == 0 && next.receiveByteNum == 0L) {
    //             iterator.remove();
    //             continue;
    //         }
    //         if (NatSession.UDP.equals(next.type) && !isShowUDP) {
    //             iterator.remove();
    //             continue;
    //         }

    //         var appInfo : AppInfo = next.appInfo;

    //         if (appInfo != null) {
    //             var appPackageName : String = appInfo.pkgs.getAt(0);
    //             if (packageName.equals(appPackageName)) {
    //                 iterator.remove();
    //                 continue;
    //             }
    //             if((selectPackage != null && !selectPackage.equals(appPackageName))){
    //                 iterator.remove();
    //             }
    //         }
    //     }
    //     if (handler == null) {
    //         return;
    //     }
    //     handler.post(object: Runnable {
    //         override fun run() {
    //             refreshView(allNetConnection);
    //         }
    //     });
    // }

    // fun refreshView(allNetConnection: MutableList<NatSession>) {
    //     println("---")
    //     for(x in allNetConnection){
    //         println("leaderAppName: " + x.getAppInfo().leaderAppName);
    //         println("RemoteHost: " + x.getRemoteHost());
    //         println("RequestURL: " + x.getRequestUrl());
    //     }
    //     println("---")
    // }
}