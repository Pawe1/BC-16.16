package com.facebook.internal;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import com.facebook.appevents.AppEventsLogger;
import p000c.p001m.p002x.p003a.gv.ax;

public class BoltsMeasurementEventListener extends BroadcastReceiver {
    private static final String BOLTS_MEASUREMENT_EVENT_PREFIX = "bf_";
    private static final String MEASUREMENT_EVENT_ARGS_KEY = "event_args";
    private static final String MEASUREMENT_EVENT_NAME_KEY = "event_name";
    private static final String MEASUREMENT_EVENT_NOTIFICATION_NAME = "com.parse.bolts.measurement_event";
    private static BoltsMeasurementEventListener _instance;
    private Context applicationContext;

    private BoltsMeasurementEventListener(Context context) {
        this.applicationContext = context.getApplicationContext();
    }

    private void close() {
        ax.m123a(this.applicationContext).m125a((BroadcastReceiver) this);
    }

    public static BoltsMeasurementEventListener getInstance(Context context) {
        if (_instance != null) {
            return _instance;
        }
        BoltsMeasurementEventListener boltsMeasurementEventListener = new BoltsMeasurementEventListener(context);
        _instance = boltsMeasurementEventListener;
        boltsMeasurementEventListener.open();
        return _instance;
    }

    private void open() {
        ax.m123a(this.applicationContext).m126a(this, new IntentFilter(MEASUREMENT_EVENT_NOTIFICATION_NAME));
    }

    protected void finalize() {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    public void onReceive(Context context, Intent intent) {
        AppEventsLogger newLogger = AppEventsLogger.newLogger(context);
        String stringBuilder = new StringBuilder(BOLTS_MEASUREMENT_EVENT_PREFIX).append(intent.getStringExtra(MEASUREMENT_EVENT_NAME_KEY)).toString();
        Bundle bundleExtra = intent.getBundleExtra(MEASUREMENT_EVENT_ARGS_KEY);
        Bundle bundle = new Bundle();
        for (String str : bundleExtra.keySet()) {
            bundle.putString(str.replaceAll("[^0-9a-zA-Z _-]", "-").replaceAll("^[ -]*", "").replaceAll("[ -]*$", ""), (String) bundleExtra.get(str));
        }
        newLogger.logEvent(stringBuilder, bundle);
    }
}
