package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.widget.ShareDialog;
import com.milkmangames.extensions.android.goviral.C0351a.C0328d;

final class C0362l extends C0328d {
    final /* synthetic */ C0351a f378a;

    C0362l(C0351a c0351a) {
        this.f378a = c0351a;
        super(c0351a);
    }

    protected final FREObject mo297a(FREObject[] fREObjectArr) {
        C0351a c0351a = this.f378a;
        return FREObject.newObject(ShareDialog.canShow(ShareOpenGraphContent.class));
    }
}
