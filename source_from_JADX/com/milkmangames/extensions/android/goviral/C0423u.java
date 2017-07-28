package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;

final class C0423u implements FacebookCallback<Result> {
    final /* synthetic */ String f401a;
    final /* synthetic */ C0403a f402b;

    C0423u(C0403a c0403a, String str) {
        this.f402b = c0403a;
        this.f401a = str;
    }

    public final void onCancel() {
        this.f402b.m467a("graph", this.f401a);
    }

    public final void onError(FacebookException facebookException) {
        this.f402b.m464a(400, facebookException.getMessage(), "graph", this.f401a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", "graph");
        this.f402b.m466a("graph", bundle, this.f401a);
    }
}
