package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialogException;
import com.facebook.FacebookException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.FacebookServiceException;
import com.facebook.share.widget.AppInviteDialog.Result;

final class C0426x implements FacebookCallback<Result> {
    final /* synthetic */ String f407a;
    final /* synthetic */ C0403a f408b;

    C0426x(C0403a c0403a, String str) {
        this.f408b = c0403a;
        this.f407a = str;
    }

    public final void onCancel() {
        this.f408b.m467a("appinvite", this.f407a);
    }

    public final void onError(FacebookException facebookException) {
        if (facebookException instanceof FacebookOperationCanceledException) {
            this.f408b.m467a("apprequests", this.f407a);
        } else if (facebookException instanceof FacebookDialogException) {
            Log.d("[GVExtension]", "DialogException.");
            FacebookDialogException facebookDialogException = (FacebookDialogException) facebookException;
            this.f408b.m464a(facebookDialogException.getErrorCode(), facebookDialogException.getMessage(), "appinvite", this.f407a);
        } else if (facebookException instanceof FacebookServiceException) {
            Log.d("[GVExtension]", "Service exception..-.");
            FacebookServiceException facebookServiceException = (FacebookServiceException) facebookException;
            Log.d("[GVExtension]", "SEM:" + facebookServiceException.getMessage());
            Log.d("[GVExtension]", "RE:" + facebookServiceException.getRequestError());
            Log.d("[GVExtension]", "REC:" + facebookServiceException.getRequestError().getErrorCode());
            Log.d("[GVExtension]", "RECM:" + facebookServiceException.getRequestError().getErrorMessage());
            if (facebookServiceException.getMessage().toLowerCase().contains("user cancel")) {
                this.f408b.m467a("appinvite", this.f407a);
            } else {
                this.f408b.m464a(facebookServiceException.getRequestError().getErrorCode(), facebookServiceException.getMessage(), "appinvite", this.f407a);
            }
        } else {
            Log.d("[GVExtension]", "Facebook inivite dialog exception:" + facebookException.getCause());
            Log.d("[GVExtension]", facebookException.toString());
            this.f408b.m464a(facebookException.hashCode(), facebookException.getMessage(), "appinvite", this.f407a);
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        this.f408b.m466a("appinvite", ((Result) obj).getData(), this.f407a);
    }
}
