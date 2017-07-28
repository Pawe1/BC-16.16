package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.widget.AppInviteDialog;

final class C0408f implements FREFunction {
    final /* synthetic */ C0403a f386a;

    C0408f(C0403a c0403a) {
        this.f386a = c0403a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        try {
            C0403a c0403a = this.f386a;
            fREObject = FREObject.newObject(AppInviteDialog.canShow());
        } catch (Exception e) {
            Log.d("[GVExtension]", "Fail.");
            Log.e("[GVExtension]", e.getMessage());
        }
        return fREObject;
    }
}
