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
import com.facebook.share.internal.WebDialogParameters;
import com.facebook.share.model.AppGroupCreationContent;
import java.util.ArrayList;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0073r;

@Deprecated
public class CreateAppGroupDialog extends FacebookDialogBase<AppGroupCreationContent, Result> {
    private static final int DEFAULT_REQUEST_CODE = RequestCodeOffset.AppGroupCreate.toRequestCode();
    private static final String GAME_GROUP_CREATION_DIALOG = "game_group_create";

    @Deprecated
    public static final class Result {
        private final String id;

        private Result(String str) {
            this.id = str;
        }

        public final String getId() {
            return this.id;
        }
    }

    private class WebHandler extends ModeHandler {
        private WebHandler() {
            super();
        }

        public boolean canShow(AppGroupCreationContent appGroupCreationContent, boolean z) {
            return true;
        }

        public AppCall createAppCall(AppGroupCreationContent appGroupCreationContent) {
            AppCall createBaseAppCall = CreateAppGroupDialog.this.createBaseAppCall();
            DialogPresenter.setupAppCallForWebDialog(createBaseAppCall, CreateAppGroupDialog.GAME_GROUP_CREATION_DIALOG, WebDialogParameters.create(appGroupCreationContent));
            return createBaseAppCall;
        }
    }

    @Deprecated
    public CreateAppGroupDialog(Activity activity) {
        super(activity, DEFAULT_REQUEST_CODE);
    }

    @Deprecated
    public CreateAppGroupDialog(Fragment fragment) {
        this(new FragmentWrapper(fragment));
    }

    @Deprecated
    public CreateAppGroupDialog(C0073r c0073r) {
        this(new FragmentWrapper(c0073r));
    }

    private CreateAppGroupDialog(FragmentWrapper fragmentWrapper) {
        super(fragmentWrapper, DEFAULT_REQUEST_CODE);
    }

    @Deprecated
    public static boolean canShow() {
        return true;
    }

    @Deprecated
    public static void show(Activity activity, AppGroupCreationContent appGroupCreationContent) {
        new CreateAppGroupDialog(activity).show(appGroupCreationContent);
    }

    @Deprecated
    public static void show(Fragment fragment, AppGroupCreationContent appGroupCreationContent) {
        show(new FragmentWrapper(fragment), appGroupCreationContent);
    }

    @Deprecated
    public static void show(C0073r c0073r, AppGroupCreationContent appGroupCreationContent) {
        show(new FragmentWrapper(c0073r), appGroupCreationContent);
    }

    private static void show(FragmentWrapper fragmentWrapper, AppGroupCreationContent appGroupCreationContent) {
        new CreateAppGroupDialog(fragmentWrapper).show(appGroupCreationContent);
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
        final ResultProcessor c03631 = facebookCallback == null ? null : new ResultProcessor(facebookCallback) {
            public void onSuccess(AppCall appCall, Bundle bundle) {
                facebookCallback.onSuccess(new Result(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_ID)));
            }
        };
        callbackManagerImpl.registerCallback(getRequestCode(), new Callback() {
            public boolean onActivityResult(int i, Intent intent) {
                return ShareInternalUtility.handleActivityResult(CreateAppGroupDialog.this.getRequestCode(), i, intent, c03631);
            }
        });
    }
}
