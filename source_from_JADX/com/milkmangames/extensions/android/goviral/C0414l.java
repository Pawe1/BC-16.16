package com.milkmangames.extensions.android.goviral;

import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.widget.ShareDialog;
import com.milkmangames.extensions.android.goviral.C0403a.C0380d;

final class C0414l extends C0380d {
    final /* synthetic */ C0403a f392a;

    C0414l(C0403a c0403a) {
        this.f392a = c0403a;
        super(c0403a);
    }

    protected final FREObject mo332a(FREObject[] fREObjectArr) {
        C0403a c0403a = this.f392a;
        return FREObject.newObject(ShareDialog.canShow(ShareOpenGraphContent.class));
    }
}
