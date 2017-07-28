package com.facebook.internal;

import android.content.Intent;
import java.util.UUID;

public class AppCall {
    private static AppCall currentPendingCall;
    private UUID callId;
    private int requestCode;
    private Intent requestIntent;

    public AppCall(int i) {
        this(i, UUID.randomUUID());
    }

    public AppCall(int i, UUID uuid) {
        this.callId = uuid;
        this.requestCode = i;
    }

    public static synchronized AppCall finishPendingCall(UUID uuid, int i) {
        AppCall currentPendingCall;
        synchronized (AppCall.class) {
            currentPendingCall = getCurrentPendingCall();
            if (currentPendingCall != null && currentPendingCall.getCallId().equals(uuid) && currentPendingCall.getRequestCode() == i) {
                setCurrentPendingCall(null);
            } else {
                currentPendingCall = null;
            }
        }
        return currentPendingCall;
    }

    public static AppCall getCurrentPendingCall() {
        return currentPendingCall;
    }

    private static synchronized boolean setCurrentPendingCall(AppCall appCall) {
        boolean z;
        synchronized (AppCall.class) {
            AppCall currentPendingCall = getCurrentPendingCall();
            currentPendingCall = appCall;
            z = currentPendingCall != null;
        }
        return z;
    }

    public UUID getCallId() {
        return this.callId;
    }

    public int getRequestCode() {
        return this.requestCode;
    }

    public Intent getRequestIntent() {
        return this.requestIntent;
    }

    public boolean setPending() {
        return setCurrentPendingCall(this);
    }

    public void setRequestCode(int i) {
        this.requestCode = i;
    }

    public void setRequestIntent(Intent intent) {
        this.requestIntent = intent;
    }
}
