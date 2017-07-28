package com.facebook.internal;

import android.app.Activity;
import android.util.Log;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialog;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0058n;

public abstract class FacebookDialogBase<CONTENT, RESULT> implements FacebookDialog<CONTENT, RESULT> {
    protected static final Object BASE_AUTOMATIC_MODE = new Object();
    private static final String TAG = "FacebookDialog";
    private final Activity activity;
    private final C0058n fragment;
    private List<ModeHandler> modeHandlers;
    private int requestCode;

    protected abstract class ModeHandler {
        protected ModeHandler() {
        }

        public abstract boolean canShow(CONTENT content);

        public abstract AppCall createAppCall(CONTENT content);

        public Object getMode() {
            return FacebookDialogBase.BASE_AUTOMATIC_MODE;
        }
    }

    protected FacebookDialogBase(Activity activity, int i) {
        Validate.notNull(activity, "activity");
        this.activity = activity;
        this.fragment = null;
        this.requestCode = i;
    }

    protected FacebookDialogBase(C0058n c0058n, int i) {
        Validate.notNull(c0058n, "fragment");
        this.fragment = c0058n;
        this.activity = null;
        this.requestCode = i;
        if (c0058n.getActivity() == null) {
            throw new IllegalArgumentException("Cannot use a fragment that is not attached to an activity");
        }
    }

    private List<ModeHandler> cachedModeHandlers() {
        if (this.modeHandlers == null) {
            this.modeHandlers = getOrderedModeHandlers();
        }
        return this.modeHandlers;
    }

    private AppCall createAppCallForMode(CONTENT content, Object obj) {
        AppCall createAppCall;
        Object obj2 = obj == BASE_AUTOMATIC_MODE ? 1 : null;
        for (ModeHandler modeHandler : cachedModeHandlers()) {
            if ((obj2 != null || Utility.areObjectsEqual(modeHandler.getMode(), obj)) && modeHandler.canShow(content)) {
                try {
                    createAppCall = modeHandler.createAppCall(content);
                    break;
                } catch (FacebookException e) {
                    createAppCall = createBaseAppCall();
                    DialogPresenter.setupAppCallForValidationError(createAppCall, e);
                }
            }
        }
        createAppCall = null;
        if (createAppCall != null) {
            return createAppCall;
        }
        createAppCall = createBaseAppCall();
        DialogPresenter.setupAppCallForCannotShowError(createAppCall);
        return createAppCall;
    }

    public boolean canShow(CONTENT content) {
        return canShowImpl(content, BASE_AUTOMATIC_MODE);
    }

    protected boolean canShowImpl(CONTENT content, Object obj) {
        boolean z = obj == BASE_AUTOMATIC_MODE;
        for (ModeHandler modeHandler : cachedModeHandlers()) {
            if ((z || Utility.areObjectsEqual(modeHandler.getMode(), obj)) && modeHandler.canShow(content)) {
                return true;
            }
        }
        return false;
    }

    protected abstract AppCall createBaseAppCall();

    protected Activity getActivityContext() {
        return this.activity != null ? this.activity : this.fragment != null ? this.fragment.getActivity() : null;
    }

    protected abstract List<ModeHandler> getOrderedModeHandlers();

    public int getRequestCode() {
        return this.requestCode;
    }

    public final void registerCallback(CallbackManager callbackManager, FacebookCallback<RESULT> facebookCallback) {
        if (callbackManager instanceof CallbackManagerImpl) {
            registerCallbackImpl((CallbackManagerImpl) callbackManager, facebookCallback);
            return;
        }
        throw new FacebookException("Unexpected CallbackManager, please use the provided Factory.");
    }

    public final void registerCallback(CallbackManager callbackManager, FacebookCallback<RESULT> facebookCallback, int i) {
        setRequestCode(i);
        registerCallback(callbackManager, facebookCallback);
    }

    protected abstract void registerCallbackImpl(CallbackManagerImpl callbackManagerImpl, FacebookCallback<RESULT> facebookCallback);

    protected void setRequestCode(int i) {
        if (FacebookSdk.isFacebookRequestCode(i)) {
            throw new IllegalArgumentException("Request code " + i + " cannot be within the range reserved by the Facebook SDK.");
        }
        this.requestCode = i;
    }

    public void show(CONTENT content) {
        showImpl(content, BASE_AUTOMATIC_MODE);
    }

    protected void showImpl(CONTENT content, Object obj) {
        AppCall createAppCallForMode = createAppCallForMode(content, obj);
        if (createAppCallForMode == null) {
            String str = "No code path should ever result in a null appCall";
            Log.e(TAG, str);
            if (FacebookSdk.isDebugEnabled()) {
                throw new IllegalStateException(str);
            }
        } else if (this.fragment != null) {
            DialogPresenter.present(createAppCallForMode, this.fragment);
        } else {
            DialogPresenter.present(createAppCallForMode, this.activity);
        }
    }
}
