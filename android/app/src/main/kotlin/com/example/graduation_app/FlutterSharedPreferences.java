package com.example.graduation_app;

import android.content.Context;
import android.content.SharedPreferences;

public class FlutterSharedPreferences {
    private static FlutterSharedPreferences instance = null;
    private SharedPreferences prefs = null;

    public static FlutterSharedPreferences getInstance(Context context) {
        if (instance == null){
            instance = new FlutterSharedPreferences(context);
        }
        return instance;
    }

    private FlutterSharedPreferences(Context context) {
        prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
    }

    public SharedPreferences getPrefs() {
        return prefs;
    }
    
    public final String vpn4 = prefs.getString("vpn4", "10.1.10.1");
    public final String vpn6 = prefs.getString("vpn6", "fd00:1:fd00:1:fd00:1:fd00:1");
    public final boolean enabled = prefs.getBoolean("enabled", false);
    public final boolean subnet = prefs.getBoolean("subnet", false);
    public final boolean tethering = prefs.getBoolean("tethering", false);
    public final boolean lan = prefs.getBoolean("lan", false);
    public final boolean ip6 = prefs.getBoolean("ip6", true);
    public final boolean filter = prefs.getBoolean("filter", false);
    public final boolean filter_udp = prefs.getBoolean("filter_udp", false);
    public final boolean system = prefs.getBoolean("manage_system", false);
    public final boolean log = prefs.getBoolean("log", false);
    public final boolean log_app = prefs.getBoolean("log_app", false);
}
