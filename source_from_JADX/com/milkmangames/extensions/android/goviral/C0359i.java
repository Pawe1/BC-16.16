package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.ShareDialog;
import com.milkmangames.extensions.android.goviral.C0351a.C0328d;

final class C0359i extends C0328d {
    final /* synthetic */ C0351a f375a;

    C0359i(C0351a c0351a) {
        this.f375a = c0351a;
        super(c0351a);
    }

    protected final FREObject mo297a(FREObject[] fREObjectArr) {
        fREObjectArr[0].getAsBool();
        C0351a c0351a = this.f375a;
        return FREObject.newObject(ShareDialog.canShow(ShareLinkContent.class));
    }
}
