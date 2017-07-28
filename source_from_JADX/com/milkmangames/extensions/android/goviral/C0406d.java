package com.milkmangames.extensions.android.goviral;

import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import com.facebook.appevents.AppEventsConstants;

final class C0406d implements OnClickListener {
    final /* synthetic */ String f383a;
    final /* synthetic */ C0403a f384b;

    C0406d(C0403a c0403a, String str) {
        this.f384b = c0403a;
        this.f383a = str;
    }

    public final void onClick(DialogInterface dialogInterface, int i) {
        C0403a.m408a(this.f384b, "Android hash", "", "Your android hash key is below.  You'll need to enter it in the facebook developer site.  After doing so, you can switch to the regular ANE file.  Remember that this key is different when you build with a debug or release android p12 keystore file- so you'll need to do this again before release and set the release key on the facebook site. KEY:    " + this.f383a, false, "", "", AppEventsConstants.EVENT_PARAM_VALUE_NO);
    }
}
