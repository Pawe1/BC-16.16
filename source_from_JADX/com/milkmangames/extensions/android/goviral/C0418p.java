package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.MessageDialog;
import com.milkmangames.extensions.android.goviral.C0403a.C0380d;

final class C0418p extends C0380d {
    final /* synthetic */ C0403a f396a;

    C0418p(C0403a c0403a) {
        this.f396a = c0403a;
        super(c0403a);
    }

    protected final FREObject mo332a(FREObject[] fREObjectArr) {
        fREObjectArr[0].getAsBool();
        C0403a c0403a = this.f396a;
        return FREObject.newObject(MessageDialog.canShow(ShareLinkContent.class));
    }
}
