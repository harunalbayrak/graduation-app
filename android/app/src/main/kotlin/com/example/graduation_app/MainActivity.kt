package com.example.graduation_app

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.VpnService;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.MenuItem;
import android.widget.Toast;
import org.jetbrains.anko.doAsync

// import java.io.File;
// import java.util.ArrayList;

import java.util.HashMap;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "LOCAL_VPN_CHANNEL";
    private val TAG = "Firewall.Main";
    private var running = true;
    private val REQUEST_VPN = 1;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "connectVPN" -> {
                    connectVPN()
                }
                "initialRules" -> {
                    var args1 = call.argument("wifiRules") as? HashMap<String, Boolean>?
                    var args2 = call.argument("mobileNetworkRules") as? HashMap<String, Boolean>?

                    try{
                        SinkService.getWifiRules().putAll(args1 as HashMap<String, Boolean>)
                        SinkService.getMobileNetworkRules().putAll(args2 as HashMap<String, Boolean>)
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
                    var Context = this;

                    doAsync{
                        if (running) {
                            if(args2 is String && args2.equals("Wifi")){
                                SinkService.getWifiRules().replace(args1 as String, args3 as Boolean);
                            } else{
                                SinkService.getMobileNetworkRules().replace(args1 as String, args3 as Boolean);
                            }
                            SinkService.reload(args2,Context);
                        }
                    }
                }
                "addWhitelist" -> {
                    val args1 = call.argument("rule") as? HashMap<String, Boolean>?
                    
                    whiteList(args1)
                }
                "resetRules" -> {
                    val args1 = call.argument("rule") as? String?
                    
                    reset(args1 as String)
                }
                "disconnectVPN" -> {
                    SinkService.stop(this);
                    SinkService.clearRules();
                    running = false;
                }
                else -> {
                    Log.d("MainActivity", "fail");
                }
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?){
        if (requestCode == REQUEST_VPN) {
            // Update enabled state
            val prefs = PreferenceManager.getDefaultSharedPreferences(this);
            prefs.edit().putBoolean("enabled", resultCode == RESULT_OK).apply();

            // Start service
            if (resultCode == RESULT_OK)
                SinkService.start(this);

        } else
            super.onActivityResult(requestCode, resultCode, data);
    }

    fun connectVPN(){
        var prefs = PreferenceManager.getDefaultSharedPreferences(this);
        var isChecked = true;

        if (isChecked) {
            Log.i(TAG, "Switch on");
            var prepare = VpnService.prepare(this);
            if (prepare == null) {
                Log.e(TAG, "Prepare done");
                onActivityResult(REQUEST_VPN, RESULT_OK, null);
            } else {
                Log.i(TAG, "Start intent=" + prepare);
                try {
                    startActivityForResult(prepare, REQUEST_VPN);
                } catch (e: Throwable) {
                    //Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                    println("null");
                    onActivityResult(REQUEST_VPN, RESULT_CANCELED, null);
                    //Toast.makeText(this, ex.toString(), Toast.LENGTH_LONG).show();
                }
            }
        } else {
            Log.i(TAG, "Switch off");
            prefs.edit().putBoolean("enabled", false).apply();
            SinkService.stop(this);
        }
    }

    fun whiteList(map: Map<String, Boolean>?): Int{
        var prefs = PreferenceManager.getDefaultSharedPreferences(this);

        try{
            for ((key, value) in map as Map<String, Boolean>) {
                prefs.edit().putBoolean("whitelist_"+key, value).apply();
                SinkService.reload(key,this);
            }
        } catch (e: Throwable) {
            println(e.message);
            println(e.cause);
            return -1;
        }

        return 0;
    }

    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    fun reset(network: String): Int {
        var other = getSharedPreferences(network, Context.MODE_PRIVATE);
        var edit = other.edit();
        
        try{
            for (key in other.getAll().keys)
                edit.remove(key);
            edit.apply();
            SinkService.reload(network,this);
        } catch (e: Throwable) {
            println(e.message);
            println(e.cause);
            return -1;
        }

        return 0;
    }
}