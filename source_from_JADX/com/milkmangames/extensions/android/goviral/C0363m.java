package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.AccessToken;
import com.facebook.AccessTokenTracker;

final class C0363m extends AccessTokenTracker {
    final /* synthetic */ C0351a f379a;

    C0363m(C0351a c0351a) {
        this.f379a = c0351a;
    }

    protected final void onCurrentAccessTokenChanged(AccessToken accessToken, AccessToken accessToken2) {
        Log.d("[GVExtension]", "Token change " + accessToken + " to " + accessToken2);
        if (accessToken != null && accessToken2 == null) {
            this.f379a.f363u = false;
            this.f379a.dispatchStatusEventAsync("6", "");
        } else if (accessToken != null || accessToken2 == null) {
            if (accessToken2 != null && !this.f379a.f362t) {
                this.f379a.f362t = true;
                if (!this.f379a.f363u) {
                    this.f379a.dispatchStatusEventAsync("5", "");
                    this.f379a.f363u = true;
                    this.f379a.f362t = true;
                }
            } else if (this.f379a.f352j != null) {
                Log.d("[GVExtension]", "Refreshed permissions for session.");
                C0351a c0351a = this.f379a;
                this.f379a.dispatchStatusEventAsync("304", C0351a.m381a(AccessToken.getCurrentAccessToken().getPermissions()));
                this.f379a.f352j = null;
            }
        } else if (!this.f379a.f363u) {
            this.f379a.dispatchStatusEventAsync("5", "");
            this.f379a.f363u = true;
            this.f379a.f362t = true;
        }
    }
}
