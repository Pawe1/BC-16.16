package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.widget.AppInviteDialog;

final class C0356f implements FREFunction {
    final /* synthetic */ C0351a f372a;

    C0356f(C0351a c0351a) {
        this.f372a = c0351a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        try {
            C0351a c0351a = this.f372a;
            fREObject = FREObject.newObject(AppInviteDialog.canShow());
        } catch (Exception e) {
            Log.d("[GVExtension]", "Fail.");
            Log.e("[GVExtension]", e.getMessage());
        }
        return fREObject;
    }
}
