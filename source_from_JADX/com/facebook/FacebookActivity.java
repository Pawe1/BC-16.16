package com.facebook;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.Log;
import com.facebook.internal.FacebookDialogFragment;
import com.facebook.internal.NativeProtocol;
import com.facebook.login.LoginFragment;
import com.facebook.share.internal.DeviceShareDialogFragment;
import com.facebook.share.model.ShareContent;
import p000c.p001m.p002x.p003a.gv.C0013z;
import p000c.p001m.p002x.p003a.gv.C0073r;
import p000c.p001m.p002x.p003a.gv.C0083u;

public class FacebookActivity extends C0083u {
    private static String FRAGMENT_TAG = "SingleFragment";
    public static String PASS_THROUGH_CANCEL_ACTION = "PassThrough";
    private static final String TAG = FacebookActivity.class.getName();
    private C0073r singleFragment;

    private void handlePassThroughError() {
        setResult(0, NativeProtocol.createProtocolResultIntent(getIntent(), null, NativeProtocol.getExceptionFromErrorData(NativeProtocol.getMethodArgumentsFromIntent(getIntent()))));
        finish();
    }

    public C0073r getCurrentFragment() {
        return this.singleFragment;
    }

    protected C0073r getFragment() {
        Intent intent = getIntent();
        C0013z supportFragmentManager = getSupportFragmentManager();
        C0073r a = supportFragmentManager.mo25a(FRAGMENT_TAG);
        if (a != null) {
            return a;
        }
        if (FacebookDialogFragment.TAG.equals(intent.getAction())) {
            a = new FacebookDialogFragment();
            a.setRetainInstance(true);
            a.show(supportFragmentManager, FRAGMENT_TAG);
            return a;
        } else if (DeviceShareDialogFragment.TAG.equals(intent.getAction())) {
            C0073r deviceShareDialogFragment = new DeviceShareDialogFragment();
            deviceShareDialogFragment.setRetainInstance(true);
            deviceShareDialogFragment.setShareContent((ShareContent) intent.getParcelableExtra("content"));
            deviceShareDialogFragment.show(supportFragmentManager, FRAGMENT_TAG);
            return deviceShareDialogFragment;
        } else {
            a = new LoginFragment();
            a.setRetainInstance(true);
            supportFragmentManager.mo24a().mo53a(C0196R.id.com_facebook_fragment_container, a, FRAGMENT_TAG).mo52a();
            return a;
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (this.singleFragment != null) {
            this.singleFragment.onConfigurationChanged(configuration);
        }
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Intent intent = getIntent();
        if (!FacebookSdk.isInitialized()) {
            Log.d(TAG, "Facebook SDK not initialized. Make sure you call sdkInitialize inside your Application's onCreate method.");
            FacebookSdk.sdkInitialize(getApplicationContext());
        }
        setContentView(C0196R.layout.com_facebook_activity_layout);
        if (PASS_THROUGH_CANCEL_ACTION.equals(intent.getAction())) {
            handlePassThroughError();
        } else {
            this.singleFragment = getFragment();
        }
    }
}
