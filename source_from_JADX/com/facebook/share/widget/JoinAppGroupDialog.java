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
import com.facebook.share.internal.ResultProcessor;
import com.facebook.share.internal.ShareConstants;
import com.facebook.share.internal.ShareInternalUtility;
import java.util.ArrayList;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0073r;

@Deprecated
public class JoinAppGroupDialog extends FacebookDialogBase<String, Result> {
    private static final int DEFAULT_REQUEST_CODE = RequestCodeOffset.AppGroupJoin.toRequestCode();
    private static final String JOIN_GAME_GROUP_DIALOG = "game_group_join";

    @Deprecated
    public static final class Result {
        private final Bundle data;

        private Result(Bundle bundle) {
            this.data = bundle;
        }

        public final Bundle getData() {
            return this.data;
        }
    }

    private class WebHandler extends ModeHandler {
        private WebHandler() {
            super();
        }

        public boolean canShow(String str, boolean z) {
            return true;
        }

        public AppCall createAppCall(String str) {
            AppCall createBaseAppCall = JoinAppGroupDialog.this.createBaseAppCall();
            Bundle bundle = new Bundle();
            bundle.putString(ShareConstants.WEB_DIALOG_PARAM_ID, str);
            DialogPresenter.setupAppCallForWebDialog(createBaseAppCall, JoinAppGroupDialog.JOIN_GAME_GROUP_DIALOG, bundle);
            return createBaseAppCall;
        }
    }

    @Deprecated
    public JoinAppGroupDialog(Activity activity) {
        super(activity, DEFAULT_REQUEST_CODE);
    }

    @Deprecated
    public JoinAppGroupDialog(Fragment fragment) {
        this(new FragmentWrapper(fragment));
    }

    @Deprecated
    public JoinAppGroupDialog(C0073r c0073r) {
        this(new FragmentWrapper(c0073r));
    }

    private JoinAppGroupDialog(FragmentWrapper fragmentWrapper) {
        super(fragmentWrapper, DEFAULT_REQUEST_CODE);
    }

    @Deprecated
    public static boolean canShow() {
        return true;
    }

    @Deprecated
    public static void show(Activity activity, String str) {
        new JoinAppGroupDialog(activity).show(str);
    }

    @Deprecated
    public static void show(Fragment fragment, String str) {
        show(new FragmentWrapper(fragment), str);
    }

    @Deprecated
    public static void show(C0073r c0073r, String str) {
        show(new FragmentWrapper(c0073r), str);
    }

    private static void show(FragmentWrapper fragmentWrapper, String str) {
        new JoinAppGroupDialog(fragmentWrapper).show(str);
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
        final ResultProcessor c03681 = facebookCallback == null ? null : new ResultProcessor(facebookCallback) {
            public void onSuccess(AppCall appCall, Bundle bundle) {
                facebookCallback.onSuccess(new Result(bundle));
            }
        };
        callbackManagerImpl.registerCallback(getRequestCode(), new Callback() {
            public boolean onActivityResult(int i, Intent intent) {
                return ShareInternalUtility.handleActivityResult(JoinAppGroupDialog.this.getRequestCode(), i, intent, c03681);
            }
        });
    }
}
