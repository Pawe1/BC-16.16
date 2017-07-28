package com.facebook.login;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.facebook.C0196R;
import com.facebook.login.LoginClient.OnCompletedListener;
import com.facebook.login.LoginClient.Request;
import com.facebook.login.LoginClient.Result;
import p000c.p001m.p002x.p003a.gv.C0073r;

public class LoginFragment extends C0073r {
    static final String EXTRA_REQUEST = "request";
    private static final String NULL_CALLING_PKG_ERROR_MSG = "Cannot call LoginFragment with a null calling package. This can occur if the launchMode of the caller is singleInstance.";
    static final String REQUEST_KEY = "com.facebook.LoginFragment:Request";
    static final String RESULT_KEY = "com.facebook.LoginFragment:Result";
    private static final String SAVED_LOGIN_CLIENT = "loginClient";
    private static final String TAG = "LoginFragment";
    private String callingPackage;
    private LoginClient loginClient;
    private Request request;

    class C02811 implements OnCompletedListener {
        C02811() {
        }

        public void onCompleted(Result result) {
            LoginFragment.this.onLoginClientCompleted(result);
        }
    }

    private void initializeCallingPackage(Activity activity) {
        ComponentName callingActivity = activity.getCallingActivity();
        if (callingActivity != null) {
            this.callingPackage = callingActivity.getPackageName();
        }
    }

    private void onLoginClientCompleted(Result result) {
        this.request = null;
        int i = result.code == Code.CANCEL ? 0 : -1;
        Bundle bundle = new Bundle();
        bundle.putParcelable(RESULT_KEY, result);
        Intent intent = new Intent();
        intent.putExtras(bundle);
        if (isAdded()) {
            getActivity().setResult(i, intent);
            getActivity().finish();
        }
    }

    protected LoginClient createLoginClient() {
        return new LoginClient((C0073r) this);
    }

    LoginClient getLoginClient() {
        return this.loginClient;
    }

    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        this.loginClient.onActivityResult(i, i2, intent);
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        if (bundle != null) {
            this.loginClient = (LoginClient) bundle.getParcelable(SAVED_LOGIN_CLIENT);
            this.loginClient.setFragment(this);
        } else {
            this.loginClient = createLoginClient();
        }
        this.loginClient.setOnCompletedListener(new C02811());
        Activity activity = getActivity();
        if (activity != null) {
            initializeCallingPackage(activity);
            if (activity.getIntent() != null) {
                this.request = (Request) activity.getIntent().getBundleExtra(REQUEST_KEY).getParcelable("request");
            }
        }
    }

    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        final View inflate = layoutInflater.inflate(C0196R.layout.com_facebook_login_fragment, viewGroup, false);
        this.loginClient.setBackgroundProcessingListener(new BackgroundProcessingListener() {
            public void onBackgroundProcessingStarted() {
                inflate.findViewById(C0196R.id.com_facebook_login_activity_progress_bar).setVisibility(0);
            }

            public void onBackgroundProcessingStopped() {
                inflate.findViewById(C0196R.id.com_facebook_login_activity_progress_bar).setVisibility(8);
            }
        });
        return inflate;
    }

    public void onDestroy() {
        this.loginClient.cancelCurrentHandler();
        super.onDestroy();
    }

    public void onPause() {
        super.onPause();
        getActivity().findViewById(C0196R.id.com_facebook_login_activity_progress_bar).setVisibility(8);
    }

    public void onResume() {
        super.onResume();
        if (this.callingPackage == null) {
            Log.e(TAG, NULL_CALLING_PKG_ERROR_MSG);
            getActivity().finish();
            return;
        }
        this.loginClient.startOrContinueAuth(this.request);
    }

    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        bundle.putParcelable(SAVED_LOGIN_CLIENT, this.loginClient);
    }
}
