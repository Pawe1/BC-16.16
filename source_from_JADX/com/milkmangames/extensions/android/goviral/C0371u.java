package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;

final class C0371u implements FacebookCallback<Result> {
    final /* synthetic */ String f387a;
    final /* synthetic */ C0351a f388b;

    C0371u(C0351a c0351a, String str) {
        this.f388b = c0351a;
        this.f387a = str;
    }

    public final void onCancel() {
        this.f388b.m454a("graph", this.f387a);
    }

    public final void onError(FacebookException facebookException) {
        this.f388b.m451a(400, facebookException.getMessage(), "graph", this.f387a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", "graph");
        this.f388b.m453a("graph", bundle, this.f387a);
    }
}
