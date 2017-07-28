package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;

final class C0372v implements FacebookCallback<Result> {
    final /* synthetic */ String f389a;
    final /* synthetic */ C0351a f390b;

    C0372v(C0351a c0351a, String str) {
        this.f390b = c0351a;
        this.f389a = str;
    }

    public final void onCancel() {
        this.f390b.m454a("message", this.f389a);
    }

    public final void onError(FacebookException facebookException) {
        this.f390b.m451a(400, facebookException.getMessage(), "message", this.f389a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", "message");
        this.f390b.m453a("message", bundle, this.f389a);
    }
}
