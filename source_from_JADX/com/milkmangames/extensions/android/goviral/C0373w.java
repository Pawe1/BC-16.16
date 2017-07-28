package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;

final class C0373w implements FacebookCallback<Result> {
    final /* synthetic */ String f391a;
    final /* synthetic */ C0351a f392b;

    C0373w(C0351a c0351a, String str) {
        this.f392b = c0351a;
        this.f391a = str;
    }

    public final void onCancel() {
        this.f392b.m454a("share", this.f391a);
    }

    public final void onError(FacebookException facebookException) {
        this.f392b.m451a(400, facebookException.getMessage(), "share", this.f391a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", "share");
        this.f392b.m453a("share", bundle, this.f391a);
    }
}
