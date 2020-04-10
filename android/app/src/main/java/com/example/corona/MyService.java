package com.example.corona;

import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

public class MyService extends Service {

    @Override
    public void onCreate() {
        super.onCreate();

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O || true){
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this,"messages")
                    .setContentText("We are here to help. Take rest, Take Care.")
                    .setContentTitle("Corona Tracker")
                    .setSmallIcon(R.drawable.common_full_open_on_phone);

            startForeground(101,builder.build());
        }

    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}