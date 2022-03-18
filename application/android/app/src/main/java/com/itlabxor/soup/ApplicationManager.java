package com.itlabxor.soup;

import android.app.Application;

import com.ebest.api.SocketManager;

public class ApplicationManager extends Application {
    private SocketManager sock = new SocketManager();

    public SocketManager getSockInstance() {
        return sock;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        sock.init(this, getApplicationContext());
    }
}