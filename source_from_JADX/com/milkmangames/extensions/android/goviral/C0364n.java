package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREObject;
import com.milkmangames.extensions.android.goviral.C0351a.C0328d;

final class C0364n extends C0328d {
    final /* synthetic */ C0351a f380a;

    C0364n(C0351a c0351a) {
        this.f380a = c0351a;
        super(c0351a);
    }

    protected final FREObject mo297a(FREObject[] fREObjectArr) {
        FREArray fREArray = (FREArray) fREObjectArr[0];
        FREArray fREArray2 = (FREArray) fREObjectArr[1];
        FREArray fREArray3 = (FREArray) fREObjectArr[2];
        FREArray fREArray4 = (FREArray) fREObjectArr[3];
        String asString = fREObjectArr[4].getAsString();
        String asString2 = fREObjectArr[5].getAsString();
        FREBitmapData fREBitmapData = (FREBitmapData) fREObjectArr[6];
        String asString3 = fREObjectArr[7].getAsString();
        Bundle a = C0351a.m379a(fREArray, fREArray2);
        C0351a.m379a(fREArray3, fREArray4);
        C0351a.m390a(this.f380a, asString, asString2, a, fREBitmapData, asString3);
        return null;
    }
}
