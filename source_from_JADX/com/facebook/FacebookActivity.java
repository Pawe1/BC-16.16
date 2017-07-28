package com.facebook;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import com.facebook.internal.FacebookDialogFragment;
import com.facebook.internal.NativeProtocol;
import com.facebook.login.LoginFragment;
import p000c.p001m.p002x.p003a.gv.C0058n;
import p000c.p001m.p002x.p003a.gv.C0068q;
import p000c.p001m.p002x.p003a.gv.C0071v;

public class FacebookActivity extends C0068q {
    private static String FRAGMENT_TAG = "SingleFragment";
    public static String PASS_THROUGH_CANCEL_ACTION = "PassThrough";
    private C0058n singleFragment;

    private void handlePassThroughError() {
        Intent intent = getIntent();
        setResult(0, NativeProtocol.createProtocolResultIntent(intent, null, NativeProtocol.getExceptionFromErrorData(NativeProtocol.getMethodArgumentsFromIntent(intent))));
        finish();
    }

    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (this.singleFragment != null) {
            this.singleFragment.onConfigurationChanged(configuration);
        }
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(C0253R.layout.com_facebook_activity_layout);
        Intent intent = getIntent();
        if (PASS_THROUGH_CANCEL_ACTION.equals(intent.getAction())) {
            handlePassThroughError();
            return;
        }
        C0071v supportFragmentManager = getSupportFragmentManager();
        C0058n a = supportFragmentManager.mo59a(FRAGMENT_TAG);
        if (a == null) {
            if (FacebookDialogFragment.TAG.equals(intent.getAction())) {
                a = new FacebookDialogFragment();
                a.setRetainInstance(true);
                a.show(supportFragmentManager, FRAGMENT_TAG);
            } else {
                a = new LoginFragment();
                a.setRetainInstance(true);
                supportFragmentManager.mo58a().mo24a(C0253R.id.com_facebook_fragment_container, a, FRAGMENT_TAG).mo23a();
            }
        }
        this.singleFragment = a;
    }
}
