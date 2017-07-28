package com.milkmangames.extensions.android.goviral;

import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import com.facebook.appevents.AppEventsConstants;

final class C0354d implements OnClickListener {
    final /* synthetic */ String f369a;
    final /* synthetic */ C0351a f370b;

    C0354d(C0351a c0351a, String str) {
        this.f370b = c0351a;
        this.f369a = str;
    }

    public final void onClick(DialogInterface dialogInterface, int i) {
        C0351a.m394a(this.f370b, "Android hash", "", "Your android hash key is below.  You'll need to enter it in the facebook developer site.  After doing so, you can switch to the regular ANE file.  Remember that this key is different when you build with a debug or release android p12 keystore file- so you'll need to do this again before release and set the release key on the facebook site. KEY:    " + this.f369a, false, "", "", AppEventsConstants.EVENT_PARAM_VALUE_NO);
    }
}
