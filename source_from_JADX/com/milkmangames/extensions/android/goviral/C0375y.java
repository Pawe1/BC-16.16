package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialogException;
import com.facebook.FacebookException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.FacebookServiceException;
import com.facebook.share.widget.GameRequestDialog.Result;

final class C0375y implements FacebookCallback<Result> {
    final /* synthetic */ String f395a;
    final /* synthetic */ C0351a f396b;

    C0375y(C0351a c0351a, String str) {
        this.f396b = c0351a;
        this.f395a = str;
    }

    public final void onCancel() {
        this.f396b.m454a("apprequests", this.f395a);
    }

    public final void onError(FacebookException facebookException) {
        if (facebookException instanceof FacebookOperationCanceledException) {
            this.f396b.m454a("apprequests", this.f395a);
        } else if (facebookException instanceof FacebookDialogException) {
            Log.d("[GVExtension]", "DialogException.");
            FacebookDialogException facebookDialogException = (FacebookDialogException) facebookException;
            this.f396b.m451a(facebookDialogException.getErrorCode(), facebookDialogException.getMessage(), "apprequests", this.f395a);
        } else if (facebookException instanceof FacebookServiceException) {
            Log.d("[GVExtension]", "Service exception..-.");
            FacebookServiceException facebookServiceException = (FacebookServiceException) facebookException;
            Log.d("[GVExtension]", "SEM:" + facebookServiceException.getMessage());
            Log.d("[GVExtension]", "RE:" + facebookServiceException.getRequestError());
            Log.d("[GVExtension]", "REC:" + facebookServiceException.getRequestError().getErrorCode());
            Log.d("[GVExtension]", "RECM:" + facebookServiceException.getRequestError().getErrorMessage());
            if (facebookServiceException.getMessage().toLowerCase().contains("user cancel")) {
                this.f396b.m454a("apprequests", this.f395a);
            } else {
                this.f396b.m451a(facebookServiceException.getRequestError().getErrorCode(), facebookServiceException.getMessage(), "apprequests", this.f395a);
            }
        } else {
            Log.d("[GVExtension]", "Facebook request dialog exception:" + facebookException.getCause());
            Log.d("[GVExtension]", facebookException.toString());
            this.f396b.m451a(facebookException.hashCode(), facebookException.getMessage(), "apprequests", this.f395a);
        }
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        if (result.getRequestId() == null) {
            this.f396b.m454a("apprequests", this.f395a);
        } else {
            this.f396b.m453a("apprequests", result.getResultsBundle(), this.f395a);
        }
    }
}
