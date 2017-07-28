package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.AccessToken;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookServiceException;
import com.facebook.login.LoginResult;

final class C0404b implements FacebookCallback<LoginResult> {
    final /* synthetic */ C0403a f378a;

    C0404b(C0403a c0403a) {
        this.f378a = c0403a;
    }

    public final void onCancel() {
        boolean z = false;
        Log.d("[GVExtension]", "Handler cancel");
        boolean z2 = true;
        if (this.f378a.f367k != null) {
            Log.d("[GVExtension]", "permission for graph request failed");
            this.f378a.m465a(2, "Could not get write permissions", this.f378a.f365i, this.f378a.f368l, false, "", this.f378a.f364h == null ? "" : this.f378a.f364h);
            this.f378a.f367k = null;
            this.f378a.f364h = null;
            return;
        }
        if (this.f378a.f366j != null) {
            Log.d("[GVExtension]", "Refreshing permissions failed.");
            this.f378a.dispatchStatusEventAsync("305", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f378a.f366j = null;
            z2 = false;
        }
        if (this.f378a.f363g != null) {
            Log.d("[GVExtension]", "Requested new read permissions failed.");
            this.f378a.dispatchStatusEventAsync("301", "{\"permissions\":\"" + this.f378a.f363g + "\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f378a.f363g = null;
            z2 = false;
        }
        if (this.f378a.f364h != null) {
            Log.d("[GVExtension]", "Requested new publish permissions failed.");
            this.f378a.dispatchStatusEventAsync("303", "{\"permissions\":\"" + this.f378a.f364h + "\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
            this.f378a.f364h = null;
        } else {
            z = z2;
        }
        if (z) {
            Log.d("[GVExtension]", "Login canceled");
            this.f378a.dispatchStatusEventAsync("7", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":0,\"gvErr\":\"canceled\",\"gvUserMessage\":\"\"}");
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
        if (this.f378a.f367k != null) {
            Log.d("[GVExtension]", "Pending graph request has failed.");
            this.f378a.m465a(2, "Could not get write permissions", this.f378a.f365i, this.f378a.f368l, z, str, this.f378a.f364h == null ? "" : this.f378a.f364h);
            this.f378a.f367k = null;
            this.f378a.f364h = null;
            return;
        }
        if (this.f378a.f366j != null) {
            Log.d("[GVExtension]", "Refreshing permissions failed.");
            this.f378a.dispatchStatusEventAsync("305", "{\"permissions\":\"\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f378a.f366j = null;
            obj = null;
        }
        if (this.f378a.f363g != null) {
            Log.d("[GVExtension]", "Requested new publish permissions failed.");
            this.f378a.dispatchStatusEventAsync("303", "{\"permissions\":\"" + this.f378a.f364h + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f378a.f364h = null;
            obj = null;
        }
        if (this.f378a.f364h != null) {
            Log.d("[GVExtension]", "Requested new read permissions failed.");
            this.f378a.dispatchStatusEventAsync("301", "{\"permissions\":\"" + this.f378a.f363g.concat(",") + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
            this.f378a.f363g = null;
        } else {
            obj2 = obj;
        }
        if (obj2 != null) {
            Log.d("[GVExtension]", "Login has failed.");
            this.f378a.dispatchStatusEventAsync("8", "{\"permissions\":\"\",\"gvShouldNotify\":false,\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + localizedMessage + "\",\"gvUserMessage\":\"" + str + "\"}");
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        if (this.f378a.f367k != null) {
            Log.d("[GVExtension]", "Running pending publish task on token update.");
            this.f378a.f367k.executeAsync();
            this.f378a.f367k = null;
        } else if (this.f378a.f366j != null) {
            Log.d("[GVExtension]", "Refreshed permissions for session.");
            try {
                C0403a c0403a = this.f378a;
                this.f378a.dispatchStatusEventAsync("304", C0403a.m394a(AccessToken.getCurrentAccessToken().getPermissions()));
            } catch (Exception e) {
                Log.e("[GVExtension]", "AIR Runtime exception dispatching permission event 1");
            }
            this.f378a.f366j = null;
        } else if (this.f378a.f363g != null) {
            Log.d("[GVExtension]", "Got new read permissions.");
            try {
                this.f378a.dispatchStatusEventAsync("300", this.f378a.f363g.concat(","));
            } catch (Exception e2) {
                Log.e("[GVExtension]", "AIR Runtime exception dispatching permission event 2");
            }
            this.f378a.f363g = null;
        } else if (this.f378a.f364h != null) {
            Log.d("[GVExtension]", "Got new publish permissions.");
            try {
                this.f378a.dispatchStatusEventAsync("302", this.f378a.f364h.concat(","));
            } catch (Exception e3) {
                Log.e("[GVExtension]", "AIR Runtime exception dispatching permission event 3");
            }
            this.f378a.f364h = null;
        } else if (AccessToken.getCurrentAccessToken() != null) {
            Log.d("[GVExtension]", "callback login with token");
            if (this.f378a.f377u) {
                Log.d("[GVExtension]", "Already dispatched token initial.");
                return;
            }
            Log.d("[GVExtension]", "callback login token initial");
            try {
                this.f378a.dispatchStatusEventAsync("5", "");
            } catch (Exception e4) {
                Log.e("[GVExtension]", "AIR Runtime exception dispatching permission event 4");
            }
            this.f378a.f376t = true;
            this.f378a.f377u = true;
        } else {
            Log.d("[GVExtension]", "callback login nil token");
        }
    }
}
