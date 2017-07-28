package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialogException;
import com.facebook.FacebookException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.FacebookServiceException;
import com.facebook.share.widget.GameRequestDialog.Result;

final class C0427y implements FacebookCallback<Result> {
    final /* synthetic */ String f409a;
    final /* synthetic */ C0403a f410b;

    C0427y(C0403a c0403a, String str) {
        this.f410b = c0403a;
        this.f409a = str;
    }

    public final void onCancel() {
        this.f410b.m467a("apprequests", this.f409a);
    }

    public final void onError(FacebookException facebookException) {
        if (facebookException instanceof FacebookOperationCanceledException) {
            this.f410b.m467a("apprequests", this.f409a);
        } else if (facebookException instanceof FacebookDialogException) {
            Log.d("[GVExtension]", "DialogException.");
            FacebookDialogException facebookDialogException = (FacebookDialogException) facebookException;
            this.f410b.m464a(facebookDialogException.getErrorCode(), facebookDialogException.getMessage(), "apprequests", this.f409a);
        } else if (facebookException instanceof FacebookServiceException) {
            Log.d("[GVExtension]", "Service exception..-.");
            FacebookServiceException facebookServiceException = (FacebookServiceException) facebookException;
            Log.d("[GVExtension]", "SEM:" + facebookServiceException.getMessage());
            Log.d("[GVExtension]", "RE:" + facebookServiceException.getRequestError());
            Log.d("[GVExtension]", "REC:" + facebookServiceException.getRequestError().getErrorCode());
            Log.d("[GVExtension]", "RECM:" + facebookServiceException.getRequestError().getErrorMessage());
            if (facebookServiceException.getMessage().toLowerCase().contains("user cancel")) {
                this.f410b.m467a("apprequests", this.f409a);
            } else {
                this.f410b.m464a(facebookServiceException.getRequestError().getErrorCode(), facebookServiceException.getMessage(), "apprequests", this.f409a);
            }
        } else {
            Log.d("[GVExtension]", "Facebook request dialog exception:" + facebookException.getCause());
            Log.d("[GVExtension]", facebookException.toString());
            this.f410b.m464a(facebookException.hashCode(), facebookException.getMessage(), "apprequests", this.f409a);
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        if (result.getRequestId() == null) {
            this.f410b.m467a("apprequests", this.f409a);
        } else {
            this.f410b.m466a("apprequests", result.getResultsBundle(), this.f409a);
        }
    }
}
