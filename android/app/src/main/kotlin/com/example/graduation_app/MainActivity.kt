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
    private val running = true;
    private val REQUEST_VPN = 1;

    var wifiRules : java.util.HashMap<String,Boolean> = HashMap<String,Boolean>() 
    var mobileNetworkRules : java.util.HashMap<String,Boolean> = HashMap<String,Boolean>() 

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "method0" -> {
                    var args1 = call.argument("wifiRules") as? HashMap<String, Boolean>?
                    var args2 = call.argument("mobileNetworkRules") as? HashMap<String, Boolean>?

                    try{
                        wifiRules.putAll(args1 as HashMap<String, Boolean>)
                        mobileNetworkRules.putAll(args2 as HashMap<String, Boolean>)
                    } catch(e: Throwable){
                        println(e.message);
                        println(e.cause);
                        result.success(-1)
                    }

                    result.success(0)
                }
                "connectVPN" -> {
                    connectVPN()
                }
                "initialRules" -> {

                }
                "editWifiRule" -> {

                }
                "editMobileNetworkRule" -> {
                    
                }
                "addWhitelist" -> {
                    val args1 = call.argument("rule") as? HashMap<String, Boolean>?
                    
                    whiteList(args1)
                }
                "resetRules" -> {
                    val args1 = call.argument("rule") as? String?
                    
                    reset(args1 as String)
                }
                "setRuleReload" -> {
                    val args1 = call.argument("package") as String?;
                    val args2 = call.argument("networkType") as String?;
                    val args3 = call.argument("ruleBool") as Boolean?;

                    doAsync {
                        if (running) {
                            var prefs = this.getSharedPreferences(args2 as String, Context.MODE_PRIVATE);
                            prefs.edit().putBoolean(args1 as String, args3 as Boolean).apply();
                            SinkService.reload(args2,this,wifiRules,mobileNetworkRules);
                        }
                    }.execute()
                }
                "disconnectVPN" -> {
                    SinkService.stop(this);
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
                SinkService.start(this,wifiRules,mobileNetworkRules);

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
                SinkService.reload(key,this,wifiRules,mobileNetworkRules);
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
            SinkService.reload(network,this,wifiRules,mobileNetworkRules);
        } catch (e: Throwable) {
            println(e.message);
            println(e.cause);
            return -1;
        }

        return 0;
    }
}

class doAsync(val handler: () -> Unit) : AsyncTask<Void, Void, Void>() {
    override fun doInBackground(vararg params: Void?): Void? {
        handler()
        return null
    }
}