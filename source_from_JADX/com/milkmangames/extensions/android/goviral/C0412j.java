package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREObject;
import com.milkmangames.extensions.android.goviral.C0403a.C0380d;

final class C0412j extends C0380d {
    final /* synthetic */ C0403a f390a;

    C0412j(C0403a c0403a) {
        this.f390a = c0403a;
        super(c0403a);
    }

    protected final FREObject mo332a(FREObject[] fREObjectArr) {
        FREArray fREArray = (FREArray) fREObjectArr[0];
        FREArray fREArray2 = (FREArray) fREObjectArr[1];
        String asString = fREObjectArr[2].getAsString();
        int asInt = fREObjectArr[3].getAsInt();
        C0403a.m397a(this.f390a, C0403a.m392a(fREArray, fREArray2), asString, asInt);
        return null;
    }
}
