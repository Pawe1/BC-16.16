package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.AccessToken;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookServiceException;
import com.facebook.login.LoginResult;

final class C0352b implements FacebookCallback<LoginResult> {
    final /* synthetic */ C0351a f364a;

    C0352b(C0351a c0351a) {
        this.f364a = c0351a;
    }

    public final void onCancel() {
        boolean z = false;
        Log.d("[GVExtension]", "Handler cancel");
        boolean z2 = true;
        if (this.f364a.f353k != null) {
            Log.d("[GVExtension]", "permission for graph request failed");
            this.f364a.m452a(2, "Could not get write permissions", this.f364a.f351i, this.f364a.f354l, false, "", this.f364a.f350h == null ? "" : this.f364a.f350h);
            this.f364a.f353k = null;
            this.f364a.f350h = null;
            return;
        }
        if (this.f364a.f352j != null) {
            Log.d("[GVExtension]", "Refreshing permissions failed.");
            this.f364a.dispatchStatusEventAsync("305", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f364a.f352j = null;
            z2 = false;
        }
        if (this.f364a.f349g != null) {
            Log.d("[GVExtension]", "Requested new publish permissions failed.");
            this.f364a.dispatchStatusEventAsync("303", "{\"permissions\":\"" + this.f364a.f350h + "\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f364a.f350h = null;
            z2 = false;
        }
        if (this.f364a.f350h != null) {
            Log.d("[GVExtension]", "Requested new read permissions failed.");
            this.f364a.dispatchStatusEventAsync("301", "{\"permissions\":\"" + this.f364a.f349g.concat(",") + "\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f364a.f349g = null;
        } else {
            z = z2;
        }
        if (z) {
            Log.d("[GVExtension]", "Login canceled");
            this.f364a.dispatchStatusEventAsync("7", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
        }
    }

    public final void onError(FacebookException facebookException) {
        boolean z;
        Object obj = 1;
        Object obj2 = null;
        Log.d("[GVExtension]", "handler error");
        String str = null;
        int i = 9001;
        String localizedMessage = facebookException.getLocalizedMessage();
        if (facebookException instanceof FacebookServiceException) {
            String str2;
            boolean z2;
            FacebookServiceException facebookServiceException = (FacebookServiceException) facebookException;
            String errorUserMessage = facebookServiceException.getRequestError().getErrorUserMessage();
            if (errorUserMessage != null) {
                str2 = errorUserMessage;
                z2 = true;
            } else {
                str2 = "";
                z2 = false;
            }
            z = z2;
            str = str2;
            i = facebookServiceException.getRequestError().getErrorCode();
        } else {
            z = false;
        }
        if (this.f364a.f353k != null) {
            Log.d("[GVExtension]", "Pending graph request has failed.");
            this.f364a.m452a(2, "Could not get write permissions", this.f364a.f351i, this.f364a.f354l, z, str, this.f364a.f350h == null ? "" : this.f364a.f350h);
            this.f364a.f353k = null;
            this.f364a.f350h = null;
            return;
        }
        if (this.f364a.f352j != null) {
            Log.d("[GVExtension]", "Refreshing permissions failed.");
            this.f364a.dispatchStatusEventAsync("305", "{\"permissions\":\"\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f364a.f352j = null;
            obj = null;
        }
        if (this.f364a.f349g != null) {
            Log.d("[GVExtension]", "Requested new publish permissions failed.");
            this.f364a.dispatchStatusEventAsync("303", "{\"permissions\":\"" + this.f364a.f350h + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f364a.f350h = null;
            obj = null;
        }
        if (this.f364a.f350h != null) {
            Log.d("[GVExtension]", "Requested new read permissions failed.");
            this.f364a.dispatchStatusEventAsync("301", "{\"permissions\":\"" + this.f364a.f349g.concat(",") + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f364a.f349g = null;
        } else {
            obj2 = obj;
        }
        if (obj2 != null) {
            Log.d("[GVExtension]", "Login has failed.");
            this.f364a.dispatchStatusEventAsync("8", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        if (this.f364a.f353k != null) {
            Log.d("[GVExtension]", "Running pending publish task on token update.");
            this.f364a.f353k.executeAsync();
            this.f364a.f353k = null;
        } else if (this.f364a.f352j != null) {
            Log.d("[GVExtension]", "Refreshed permissions for session.");
            C0351a c0351a = this.f364a;
            this.f364a.dispatchStatusEventAsync("304", C0351a.m381a(AccessToken.getCurrentAccessToken().getPermissions()));
            this.f364a.f352j = null;
        } else if (this.f364a.f349g != null) {
            Log.d("[GVExtension]", "Got new read permissions.");
            this.f364a.dispatchStatusEventAsync("300", this.f364a.f349g.concat(","));
            this.f364a.f349g = null;
        } else if (this.f364a.f350h != null) {
            Log.d("[GVExtension]", "Got new publish permissions.");
            this.f364a.dispatchStatusEventAsync("302", this.f364a.f350h.concat(","));
            this.f364a.f350h = null;
        } else if (AccessToken.getCurrentAccessToken() != null) {
            Log.d("[GVExtension]", "callback login with token");
            if (this.f364a.f363u) {
                Log.d("[GVExtension]", "Already dispatched token initial.");
                return;
            }
            Log.d("[GVExtension]", "callback login token initial");
            this.f364a.dispatchStatusEventAsync("5", "");
            this.f364a.f362t = true;
            this.f364a.f363u = true;
        } else {
            Log.d("[GVExtension]", "callback login nil token");
        }
    }
}
