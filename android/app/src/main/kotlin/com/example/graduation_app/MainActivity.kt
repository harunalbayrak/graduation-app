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
// import java.util.List;

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

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "method0" -> {
                    val args1 = call.argument("wifiRules") as? HashMap<String, Boolean>?
                    val args2 = call.argument("mobileNetworkRules") as? HashMap<String, Boolean>?

                    printHashMap(args1);
                    printHashMap(args2);

                    result.success(10)
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
}