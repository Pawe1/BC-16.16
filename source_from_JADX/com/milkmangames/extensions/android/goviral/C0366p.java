package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.MessageDialog;
import com.milkmangames.extensions.android.goviral.C0351a.C0328d;

final class C0366p extends C0328d {
    final /* synthetic */ C0351a f382a;

    C0366p(C0351a c0351a) {
        this.f382a = c0351a;
        super(c0351a);
    }

    protected final FREObject mo297a(FREObject[] fREObjectArr) {
        fREObjectArr[0].getAsBool();
        C0351a c0351a = this.f382a;
        return FREObject.newObject(MessageDialog.canShow(ShareLinkContent.class));
    }
}
