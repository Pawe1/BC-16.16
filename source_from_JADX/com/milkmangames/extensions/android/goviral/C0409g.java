package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

final class C0409g implements FREFunction {
    final /* synthetic */ C0403a f387a;

    C0409g(C0403a c0403a) {
        this.f387a = c0403a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        Log.d("[GVExtension]", "Check granted--.");
        try {
            String asString = fREObjectArr[0].getAsString();
            Log.d("[GVExtension]", "RES:" + asString);
            C0403a c0403a = this.f387a;
            fREObject = FREObject.newObject(C0403a.m417a(asString));
        } catch (Exception e) {
            Log.d("[GVExtension]", "Fail.");
            Log.e("[GVExtension]", e.getMessage());
        }
        Log.d("[GVExtension]", "Return " + fREObject);
        return fREObject;
    }
}
