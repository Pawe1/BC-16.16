package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;

final class C0424v implements FacebookCallback<Result> {
    final /* synthetic */ String f403a;
    final /* synthetic */ C0403a f404b;

    C0424v(C0403a c0403a, String str) {
        this.f404b = c0403a;
        this.f403a = str;
    }

    public final void onCancel() {
        this.f404b.m467a("message", this.f403a);
    }

    public final void onError(FacebookException facebookException) {
        this.f404b.m464a(400, facebookException.getMessage(), "message", this.f403a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", "message");
        this.f404b.m466a("message", bundle, this.f403a);
    }
}
