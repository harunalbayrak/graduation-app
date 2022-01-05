package com.example.graduation_app;

import android.util.Log;

public class LogService{
    private static final String TAG_1 = "LOCAL_VPN.Service";
    private static final String TAG_2 = "LOCAL_VPN.Receiver";
    
    public void LogI_1(String log){
        Log.i(TAG_1, log);
    }

    public void LogE_1(String log){
        Log.e(TAG_1, log);
    }

    public void LogI_2(String log){
        Log.i(TAG_2, log);
    }

    public void LogE_2(String log){
        Log.e(TAG_2, log);
    }
}
