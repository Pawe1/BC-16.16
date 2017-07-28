package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookRequestError;
import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;

final class C0353c implements Callback {
    final /* synthetic */ String f365a;
    final /* synthetic */ String f366b;
    final /* synthetic */ String f367c;
    final /* synthetic */ C0351a f368d;

    C0353c(C0351a c0351a, String str, String str2, String str3) {
        this.f368d = c0351a;
        this.f365a = str;
        this.f366b = str2;
        this.f367c = str3;
    }

    public final void onCompleted(GraphResponse graphResponse) {
        Log.d("[GVExtension]", "Complete graph.");
        String str = this.f365a;
        if (graphResponse.getConnection() != null) {
            try {
                str = graphResponse.getConnection().getURL().toString();
            } catch (Exception e) {
                str = this.f365a;
            }
        }
        FacebookRequestError error = graphResponse.getError();
        if (error != null) {
            boolean z = error.getErrorUserMessage() != null;
            this.f368d.m452a(error.getErrorCode(), error.getErrorMessage(), str, this.f367c, z, z ? error.getErrorUserMessage() : "", this.f366b);
            return;
        }
        this.f368d.m455a(graphResponse.getRawResponse(), str, this.f367c);
    }
}
