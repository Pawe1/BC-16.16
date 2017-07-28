package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.Sharer.Result;
import com.facebook.share.internal.ShareConstants;
import com.facebook.share.widget.ShareDialog;

final class C0425w implements FacebookCallback<Result> {
    final /* synthetic */ String f405a;
    final /* synthetic */ C0403a f406b;

    C0425w(C0403a c0403a, String str) {
        this.f406b = c0403a;
        this.f405a = str;
    }

    public final void onCancel() {
        this.f406b.m467a(ShareDialog.WEB_SHARE_DIALOG, this.f405a);
    }

    public final void onError(FacebookException facebookException) {
        this.f406b.m464a(400, facebookException.getMessage(), ShareDialog.WEB_SHARE_DIALOG, this.f405a);
    }

    public final /* synthetic */ void onSuccess(Object obj) {
        Result result = (Result) obj;
        Bundle bundle = new Bundle();
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_POST_ID, result.getPostId());
        bundle.putString("gvDialogType", ShareDialog.WEB_SHARE_DIALOG);
        this.f406b.m466a(ShareDialog.WEB_SHARE_DIALOG, bundle, this.f405a);
    }
}
