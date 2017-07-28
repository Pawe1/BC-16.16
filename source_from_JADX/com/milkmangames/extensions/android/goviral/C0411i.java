package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.ShareDialog;
import com.milkmangames.extensions.android.goviral.C0403a.C0380d;

final class C0411i extends C0380d {
    final /* synthetic */ C0403a f389a;

    C0411i(C0403a c0403a) {
        this.f389a = c0403a;
        super(c0403a);
    }

    protected final FREObject mo332a(FREObject[] fREObjectArr) {
        fREObjectArr[0].getAsBool();
        C0403a c0403a = this.f389a;
        return FREObject.newObject(ShareDialog.canShow(ShareLinkContent.class));
    }
}
