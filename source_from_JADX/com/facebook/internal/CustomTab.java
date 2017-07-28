package com.facebook.internal;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Build.VERSION;
import android.os.Bundle;
import com.facebook.FacebookSdk;
import p000c.p001m.p002x.p003a.gv.C0010a;
import p000c.p001m.p002x.p003a.gv.C0010a.C0009a;

public class CustomTab {
    private Uri uri;

    public CustomTab(String str, Bundle bundle) {
        if (bundle == null) {
            bundle = new Bundle();
        }
        this.uri = Utility.buildUri(ServerProtocol.getDialogAuthority(), FacebookSdk.getGraphApiVersion() + "/dialog/" + str, bundle);
    }

    public void openCustomTab(Activity activity, String str) {
        C0010a a = new C0009a().m0a();
        a.f4a.setPackage(str);
        a.f4a.addFlags(1073741824);
        a.f4a.setData(this.uri);
        Intent intent = a.f4a;
        Bundle bundle = a.f5b;
        if (VERSION.SDK_INT >= 16) {
            activity.startActivity(intent, bundle);
        } else {
            activity.startActivity(intent);
        }
    }
}
