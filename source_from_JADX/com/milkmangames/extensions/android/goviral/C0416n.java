package com.milkmangames.extensions.android.goviral;

import android.os.Bundle;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREObject;
import com.milkmangames.extensions.android.goviral.C0403a.C0380d;

final class C0416n extends C0380d {
    final /* synthetic */ C0403a f394a;

    C0416n(C0403a c0403a) {
        this.f394a = c0403a;
        super(c0403a);
    }

    protected final FREObject mo332a(FREObject[] fREObjectArr) {
        FREArray fREArray = (FREArray) fREObjectArr[0];
        FREArray fREArray2 = (FREArray) fREObjectArr[1];
        FREArray fREArray3 = (FREArray) fREObjectArr[2];
        FREArray fREArray4 = (FREArray) fREObjectArr[3];
        String asString = fREObjectArr[4].getAsString();
        String asString2 = fREObjectArr[5].getAsString();
        FREBitmapData fREBitmapData = (FREBitmapData) fREObjectArr[6];
        String asString3 = fREObjectArr[7].getAsString();
        Bundle a = C0403a.m392a(fREArray, fREArray2);
        C0403a.m392a(fREArray3, fREArray4);
        C0403a.m404a(this.f394a, asString, asString2, a, fREBitmapData, asString3);
        return null;
    }
}
