package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.FacebookRequestError;
import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;

final class C0405c implements Callback {
    final /* synthetic */ String f379a;
    final /* synthetic */ String f380b;
    final /* synthetic */ String f381c;
    final /* synthetic */ C0403a f382d;

    C0405c(C0403a c0403a, String str, String str2, String str3) {
        this.f382d = c0403a;
        this.f379a = str;
        this.f380b = str2;
        this.f381c = str3;
    }

    public final void onCompleted(GraphResponse graphResponse) {
        Log.d("[GVExtension]", "Complete graph.");
        String str = this.f379a;
        if (graphResponse.getConnection() != null) {
            try {
                str = graphResponse.getConnection().getURL().toString();
            } catch (Exception e) {
                str = this.f379a;
            }
        }
        FacebookRequestError error = graphResponse.getError();
        if (error != null) {
            boolean z = error.getErrorUserMessage() != null;
            this.f382d.m465a(error.getErrorCode(), error.getErrorMessage(), str, this.f381c, z, z ? error.getErrorUserMessage() : "", this.f380b);
            return;
        }
        this.f382d.m468a(graphResponse.getRawResponse(), str, this.f381c);
    }
}
