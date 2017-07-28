package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialogException;
import com.facebook.FacebookException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.FacebookServiceException;
import com.facebook.share.widget.AppInviteDialog.Result;

final class C0374x implements FacebookCallback<Result> {
    final /* synthetic */ String f393a;
    final /* synthetic */ C0351a f394b;

    C0374x(C0351a c0351a, String str) {
        this.f394b = c0351a;
        this.f393a = str;
    }

    public final void onCancel() {
        this.f394b.m454a("appinvite", this.f393a);
    }

    public final void onError(FacebookException facebookException) {
        if (facebookException instanceof FacebookOperationCanceledException) {
            this.f394b.m454a("apprequests", this.f393a);
        } else if (facebookException instanceof FacebookDialogException) {
            Log.d("[GVExtension]", "DialogException.");
            FacebookDialogException facebookDialogException = (FacebookDialogException) facebookException;
            this.f394b.m451a(facebookDialogException.getErrorCode(), facebookDialogException.getMessage(), "appinvite", this.f393a);
        } else if (facebookException instanceof FacebookServiceException) {
            Log.d("[GVExtension]", "Service exception..-.");
            FacebookServiceException facebookServiceException = (FacebookServiceException) facebookException;
            Log.d("[GVExtension]", "SEM:" + facebookServiceException.getMessage());
            Log.d("[GVExtension]", "RE:" + facebookServiceException.getRequestError());
            Log.d("[GVExtension]", "REC:" + facebookServiceException.getRequestError().getErrorCode());
            Log.d("[GVExtension]", "RECM:" + facebookServiceException.getRequestError().getErrorMessage());
            if (facebookServiceException.getMessage().toLowerCase().contains("user cancel")) {
                this.f394b.m454a("appinvite", this.f393a);
            } else {
                this.f394b.m451a(facebookServiceException.getRequestError().getErrorCode(), facebookServiceException.getMessage(), "appinvite", this.f393a);
            }
        } else {
            Log.d("[GVExtension]", "Facebook inivite dialog exception:" + facebookException.getCause());
            Log.d("[GVExtension]", facebookException.toString());
            this.f394b.m451a(facebookException.hashCode(), facebookException.getMessage(), "appinvite", this.f393a);
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        this.f394b.m453a("appinvite", ((Result) obj).getData(), this.f393a);
    }
}
