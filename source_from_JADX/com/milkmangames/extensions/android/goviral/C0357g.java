package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

final class C0357g implements FREFunction {
    final /* synthetic */ C0351a f373a;

    C0357g(C0351a c0351a) {
        this.f373a = c0351a;
    }

    public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
        FREObject fREObject = null;
        Log.d("[GVExtension]", "Check granted--.");
        try {
            String asString = fREObjectArr[0].getAsString();
            Log.d("[GVExtension]", "RES:" + asString);
            C0351a c0351a = this.f373a;
            fREObject = FREObject.newObject(C0351a.m403a(asString));
        } catch (Exception e) {
            Log.d("[GVExtension]", "Fail.");
            Log.e("[GVExtension]", e.getMessage());
        }
        Log.d("[GVExtension]", "Return " + fREObject);
        return fREObject;
    }
}
