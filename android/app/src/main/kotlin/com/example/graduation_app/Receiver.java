package com.example.graduation_app;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.VpnService;
import android.os.Build;
import android.util.Log;

public class Receiver extends BroadcastReceiver {
    private static LogService logService = new LogService();

    @Override
    public void onReceive(final Context context, Intent intent) {
        logService.LogI_2("Received " + intent);
        //Util.logExtras(TAG, intent);

        // Start service
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ICE_CREAM_SANDWICH) {
            if (VpnService.prepare(context) == null)
                SinkService.start(context);
        }
    }
}