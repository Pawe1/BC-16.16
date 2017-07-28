package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.AccessToken;
import com.facebook.AccessTokenTracker;

final class C0415m extends AccessTokenTracker {
    final /* synthetic */ C0403a f393a;

    C0415m(C0403a c0403a) {
        this.f393a = c0403a;
    }

    protected final void onCurrentAccessTokenChanged(AccessToken accessToken, AccessToken accessToken2) {
        Log.d("[GVExtension]", "Token change " + accessToken + " to " + accessToken2);
        if (accessToken != null && accessToken2 == null) {
            this.f393a.f377u = false;
            try {
                this.f393a.dispatchStatusEventAsync("6", "");
            } catch (Exception e) {
                Log.e("[GVExtension]", "AIR Runtime Error Dispatching Permission logout event");
            }
        } else if (accessToken != null || accessToken2 == null) {
            if (accessToken2 != null && !this.f393a.f376t) {
                this.f393a.f376t = true;
                if (!this.f393a.f377u) {
                    try {
                        this.f393a.dispatchStatusEventAsync("5", "");
                    } catch (Exception e2) {
                        Log.e("[GVExtension]", "AIR Runtime Error Dispatching Permission login event 2");
                    }
                    this.f393a.f377u = true;
                    this.f393a.f376t = true;
                }
            } else if (this.f393a.f366j != null) {
                Log.d("[GVExtension]", "Refreshed permissions for session.");
                if (AccessToken.getCurrentAccessToken() != null) {
                    try {
                        C0403a c0403a = this.f393a;
                        this.f393a.dispatchStatusEventAsync("304", C0403a.m394a(AccessToken.getCurrentAccessToken().getPermissions()));
                    } catch (Exception e3) {
                        Log.e("[GVExtension]", "AIR Runtime Error Dispatching Permission refresh event");
                    }
                    this.f393a.f366j = null;
                }
            }
        } else if (!this.f393a.f377u) {
            try {
                this.f393a.dispatchStatusEventAsync("5", "");
            } catch (Exception e4) {
                Log.e("[GVExtension]", "AIR Runtime Error Dispatching Permission login event 3");
            }
            this.f393a.f377u = true;
            this.f393a.f376t = true;
        }
    }
}
