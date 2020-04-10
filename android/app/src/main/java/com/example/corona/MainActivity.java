package com.example.corona;

import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class  MainActivity extends FlutterActivity {

  private Intent forService;

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    forService = new Intent(MainActivity.this,MyService.class);

    new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),"com.example.corona")
            .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if(methodCall.method.equals("startService")){
                  startService();
                  result.success("Service Started");
                }
              }
            });


  }

//  @Override
//  protected void onDestroy() {
//    super.onDestroy();
//    stopService(forService);
//  }

  private void startService(){
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
      startForegroundService(forService);
    } else {
      startService(forService);
    }
  }
}
