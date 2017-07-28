package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

final class C0358h implements FREFunction {
    final /* synthetic */ C0351a f374a;

    C0358h(C0351a c0351a) {
        this.f374a = c0351a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        try {
            C0351a c0351a = this.f374a;
            fREObject = FREObject.newObject(C0351a.m417e());
        } catch (Exception e) {
            Log.e("[GVExtension]", e.getMessage());
        }
        return fREObject;
    }
}
