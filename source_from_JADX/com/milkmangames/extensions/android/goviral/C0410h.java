package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

final class C0410h implements FREFunction {
    final /* synthetic */ C0403a f388a;

    C0410h(C0403a c0403a) {
        this.f388a = c0403a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        try {
            C0403a c0403a = this.f388a;
            fREObject = FREObject.newObject(C0403a.m430e());
        } catch (Exception e) {
            Log.e("[GVExtension]", e.getMessage());
        }
        return fREObject;
    }
}
