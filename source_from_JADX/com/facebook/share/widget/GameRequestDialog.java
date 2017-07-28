package com.facebook.share.widget;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import com.facebook.FacebookCallback;
import com.facebook.internal.AppCall;
import com.facebook.internal.CallbackManagerImpl;
import com.facebook.internal.CallbackManagerImpl.Callback;
import com.facebook.internal.CallbackManagerImpl.RequestCodeOffset;
import com.facebook.internal.DialogPresenter;
import com.facebook.internal.FacebookDialogBase;
import com.facebook.internal.FragmentWrapper;
import com.facebook.share.internal.GameRequestValidation;
import com.facebook.share.internal.ResultProcessor;
import com.facebook.share.internal.ShareConstants;
import com.facebook.share.internal.ShareInternalUtility;
import com.facebook.share.internal.WebDialogParameters;
import com.facebook.share.model.GameRequestContent;
import java.util.ArrayList;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0073r;

public class GameRequestDialog extends FacebookDialogBase<GameRequestContent, Result> {
    private static final int DEFAULT_REQUEST_CODE = RequestCodeOffset.GameRequest.toRequestCode();
    private static final String GAME_REQUEST_DIALOG = "apprequests";

    public static final class Result {
        String requestId;
        Bundle resultsBundle;
        List<String> to;

        private Result(Bundle bundle) {
            this.resultsBundle = bundle;
            this.requestId = bundle.getString(ShareConstants.WEB_DIALOG_RESULT_PARAM_REQUEST_ID);
            this.to = new ArrayList();
            while (true) {
                if (bundle.containsKey(String.format(ShareConstants.WEB_DIALOG_RESULT_PARAM_TO_ARRAY_MEMBER, new Object[]{Integer.valueOf(this.to.size())}))) {
                    this.to.add(bundle.getString(String.format(ShareConstants.WEB_DIALOG_RESULT_PARAM_TO_ARRAY_MEMBER, new Object[]{Integer.valueOf(this.to.size())})));
                } else {
                    return;
                }
            }
        }

        public final String getRequestId() {
            return this.requestId;
        }

        public final List<String> getRequestRecipients() {
            return this.to;
        }

        public final Bundle getResultsBundle() {
            return this.resultsBundle;
        }
    }

    private class WebHandler extends ModeHandler {
        private WebHandler() {
            super();
        }

        public boolean canShow(GameRequestContent gameRequestContent, boolean z) {
            return true;
        }

        public AppCall createAppCall(GameRequestContent gameRequestContent) {
            GameRequestValidation.validate(gameRequestContent);
            AppCall createBaseAppCall = GameRequestDialog.this.createBaseAppCall();
            DialogPresenter.setupAppCallForWebDialog(createBaseAppCall, GameRequestDialog.GAME_REQUEST_DIALOG, WebDialogParameters.create(gameRequestContent));
            return createBaseAppCall;
        }
    }

    public GameRequestDialog(Activity activity) {
        super(activity, DEFAULT_REQUEST_CODE);
    }

    public GameRequestDialog(Fragment fragment) {
        this(new FragmentWrapper(fragment));
    }

    public GameRequestDialog(C0073r c0073r) {
        this(new FragmentWrapper(c0073r));
    }

    private GameRequestDialog(FragmentWrapper fragmentWrapper) {
        super(fragmentWrapper, DEFAULT_REQUEST_CODE);
    }

    public static boolean canShow() {
        return true;
    }

    public static void show(Activity activity, GameRequestContent gameRequestContent) {
        new GameRequestDialog(activity).show(gameRequestContent);
    }

    public static void show(Fragment fragment, GameRequestContent gameRequestContent) {
        show(new FragmentWrapper(fragment), gameRequestContent);
    }

    public static void show(C0073r c0073r, GameRequestContent gameRequestContent) {
        show(new FragmentWrapper(c0073r), gameRequestContent);
    }

    private static void show(FragmentWrapper fragmentWrapper, GameRequestContent gameRequestContent) {
        new GameRequestDialog(fragmentWrapper).show(gameRequestContent);
    }

    protected AppCall createBaseAppCall() {
        return new AppCall(getRequestCode());
    }

    protected List<ModeHandler> getOrderedModeHandlers() {
        List arrayList = new ArrayList();
        arrayList.add(new WebHandler());
        return arrayList;
    }

    protected void registerCallbackImpl(CallbackManagerImpl callbackManagerImpl, final FacebookCallback<Result> facebookCallback) {
        final ResultProcessor c03661 = facebookCallback == null ? null : new ResultProcessor(facebookCallback) {
            public void onSuccess(AppCall appCall, Bundle bundle) {
                if (bundle != null) {
                    facebookCallback.onSuccess(new Result(bundle));
                } else {
                    onCancel(appCall);
                }
            }
        };
        callbackManagerImpl.registerCallback(getRequestCode(), new Callback() {
            public boolean onActivityResult(int i, Intent intent) {
                return ShareInternalUtility.handleActivityResult(GameRequestDialog.this.getRequestCode(), i, intent, c03661);
            }
        });
    }
}
