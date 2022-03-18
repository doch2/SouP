package com.itlabxor.soup;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.ebest.api.SocketManager;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements ActivityCompat.OnRequestPermissionsResultCallback {
    private String PLATFORMCHANNEL = "com.itlabxor.soup/xingapi";

    SocketManager manager;
    ProcMessageHandler handler;
    int m_nHandle = -1;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        handler = new ProcMessageHandler();
        manager = ((ApplicationManager) getApplication()).getSockInstance();

        manager.setRes(this, "res");
        m_nHandle = manager.setHandler(this, handler);

        manager.checkPermission(this, handler);


        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), PLATFORMCHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("checkPermission")) {
                                manager.checkPermission(this, handler);
                                result.success(true);
                            }
                        }
                );
    }
}
