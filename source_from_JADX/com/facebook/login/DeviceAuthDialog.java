package com.facebook.login;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.Html;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import com.facebook.AccessToken;
import com.facebook.AccessTokenSource;
import com.facebook.C0196R;
import com.facebook.FacebookActivity;
import com.facebook.FacebookException;
import com.facebook.FacebookRequestError;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphRequest.Callback;
import com.facebook.GraphRequestAsyncTask;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.devicerequests.internal.DeviceRequestsHelper;
import com.facebook.internal.AnalyticsEvents;
import com.facebook.internal.FetchedAppSettings;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.ImageDownloader;
import com.facebook.internal.ImageRequest;
import com.facebook.internal.ImageRequest.Builder;
import com.facebook.internal.ImageResponse;
import com.facebook.internal.ServerProtocol;
import com.facebook.internal.SmartLoginOption;
import com.facebook.internal.Utility;
import com.facebook.internal.Utility.PermissionsPair;
import com.facebook.internal.Validate;
import com.facebook.login.LoginClient.Request;
import com.facebook.share.internal.ShareConstants;
import java.util.Date;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import org.json.JSONObject;
import p000c.p001m.p002x.p003a.gv.C0074q;

public class DeviceAuthDialog extends C0074q {
    private static final String DEVICE_LOGIN_ENDPOINT = "device/login";
    private static final String DEVICE_LOGIN_STATUS_ENDPOINT = "device/login_status";
    private static final int LOGIN_ERROR_SUBCODE_AUTHORIZATION_DECLINED = 1349173;
    private static final int LOGIN_ERROR_SUBCODE_AUTHORIZATION_PENDING = 1349174;
    private static final int LOGIN_ERROR_SUBCODE_CODE_EXPIRED = 1349152;
    private static final int LOGIN_ERROR_SUBCODE_EXCESSIVE_POLLING = 1349172;
    private static final String REQUEST_STATE_KEY = "request_state";
    private AtomicBoolean completed = new AtomicBoolean();
    private TextView confirmationCode;
    private volatile GraphRequestAsyncTask currentGraphRequestPoll;
    private volatile RequestState currentRequestState;
    private DeviceAuthMethodHandler deviceAuthMethodHandler;
    private Dialog dialog;
    private boolean isBeingDestroyed = false;
    private boolean isRetry = false;
    private Request mRequest = null;
    private ProgressBar progressBar;
    private volatile ScheduledFuture scheduledPoll;

    class C02631 implements Callback {
        C02631() {
        }

        public void onCompleted(GraphResponse graphResponse) {
            if (!DeviceAuthDialog.this.isBeingDestroyed) {
                if (graphResponse.getError() != null) {
                    DeviceAuthDialog.this.onError(graphResponse.getError().getException());
                    return;
                }
                JSONObject jSONObject = graphResponse.getJSONObject();
                RequestState requestState = new RequestState();
                try {
                    requestState.setUserCode(jSONObject.getString("user_code"));
                    requestState.setRequestCode(jSONObject.getString("code"));
                    requestState.setInterval(jSONObject.getLong("interval"));
                    DeviceAuthDialog.this.setCurrentRequestState(requestState);
                } catch (Throwable e) {
                    DeviceAuthDialog.this.onError(new FacebookException(e));
                }
            }
        }
    }

    class C02653 implements OnClickListener {
        C02653() {
        }

        public void onClick(View view) {
            DeviceAuthDialog.this.onCancel();
        }
    }

    class C02664 implements Runnable {
        C02664() {
        }

        public void run() {
            DeviceAuthDialog.this.poll();
        }
    }

    class C02675 implements Callback {
        C02675() {
        }

        public void onCompleted(GraphResponse graphResponse) {
            if (!DeviceAuthDialog.this.completed.get()) {
                FacebookRequestError error = graphResponse.getError();
                if (error != null) {
                    switch (error.getSubErrorCode()) {
                        case DeviceAuthDialog.LOGIN_ERROR_SUBCODE_CODE_EXPIRED /*1349152*/:
                        case DeviceAuthDialog.LOGIN_ERROR_SUBCODE_AUTHORIZATION_DECLINED /*1349173*/:
                            DeviceAuthDialog.this.onCancel();
                            return;
                        case DeviceAuthDialog.LOGIN_ERROR_SUBCODE_EXCESSIVE_POLLING /*1349172*/:
                        case DeviceAuthDialog.LOGIN_ERROR_SUBCODE_AUTHORIZATION_PENDING /*1349174*/:
                            DeviceAuthDialog.this.schedulePoll();
                            return;
                        default:
                            DeviceAuthDialog.this.onError(graphResponse.getError().getException());
                            return;
                    }
                }
                try {
                    DeviceAuthDialog.this.onSuccess(graphResponse.getJSONObject().getString("access_token"));
                } catch (Throwable e) {
                    DeviceAuthDialog.this.onError(new FacebookException(e));
                }
            }
        }
    }

    class C02686 implements DialogInterface.OnClickListener {
        C02686() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            DeviceAuthDialog.this.dialog.setContentView(DeviceAuthDialog.this.initializeContentView(false));
            DeviceAuthDialog.this.startLogin(DeviceAuthDialog.this.mRequest);
        }
    }

    private static class RequestState implements Parcelable {
        public static final Creator<RequestState> CREATOR = new C02711();
        private long interval;
        private long lastPoll;
        private String requestCode;
        private String userCode;

        final class C02711 implements Creator<RequestState> {
            C02711() {
            }

            public final RequestState createFromParcel(Parcel parcel) {
                return new RequestState(parcel);
            }

            public final RequestState[] newArray(int i) {
                return new RequestState[i];
            }
        }

        RequestState() {
        }

        protected RequestState(Parcel parcel) {
            this.userCode = parcel.readString();
            this.requestCode = parcel.readString();
            this.interval = parcel.readLong();
            this.lastPoll = parcel.readLong();
        }

        public int describeContents() {
            return 0;
        }

        public long getInterval() {
            return this.interval;
        }

        public String getRequestCode() {
            return this.requestCode;
        }

        public String getUserCode() {
            return this.userCode;
        }

        public void setInterval(long j) {
            this.interval = j;
        }

        public void setLastPoll(long j) {
            this.lastPoll = j;
        }

        public void setRequestCode(String str) {
            this.requestCode = str;
        }

        public void setUserCode(String str) {
            this.userCode = str;
        }

        public boolean withinLastRefreshWindow() {
            return this.lastPoll != 0 && (new Date().getTime() - this.lastPoll) - (this.interval * 1000) < 0;
        }

        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeString(this.userCode);
            parcel.writeString(this.requestCode);
            parcel.writeLong(this.interval);
            parcel.writeLong(this.lastPoll);
        }
    }

    private void appendIconToTextView(final TextView textView, String str) {
        ImageDownloader.downloadAsync(new Builder(getContext(), Uri.parse(str)).setCallback(new ImageRequest.Callback() {
            public void onCompleted(ImageResponse imageResponse) {
                if (imageResponse.getBitmap() != null) {
                    textView.setCompoundDrawablesWithIntrinsicBounds(null, null, new BitmapDrawable(DeviceAuthDialog.this.getResources(), Bitmap.createScaledBitmap(imageResponse.getBitmap(), 24, 24, false)), null);
                }
            }
        }).build());
    }

    private void completeLogin(String str, PermissionsPair permissionsPair, String str2) {
        this.deviceAuthMethodHandler.onSuccess(str2, FacebookSdk.getApplicationId(), str, permissionsPair.getGrantedPermissions(), permissionsPair.getDeclinedPermissions(), AccessTokenSource.DEVICE_AUTH, null, null);
        this.dialog.dismiss();
    }

    private GraphRequest getPollRequest() {
        Bundle bundle = new Bundle();
        bundle.putString("code", this.currentRequestState.getRequestCode());
        return new GraphRequest(null, DEVICE_LOGIN_STATUS_ENDPOINT, bundle, HttpMethod.POST, new C02675());
    }

    private View initializeContentView(boolean z) {
        View inflate;
        LayoutInflater layoutInflater = getActivity().getLayoutInflater();
        if (z) {
            inflate = layoutInflater.inflate(C0196R.layout.com_facebook_smart_device_dialog_fragment, null);
            FetchedAppSettings appSettingsWithoutQuery = FetchedAppSettingsManager.getAppSettingsWithoutQuery(FacebookSdk.getApplicationId());
            if (appSettingsWithoutQuery.getSmartLoginBookmarkIconURL() != null) {
                appendIconToTextView((TextView) inflate.findViewById(C0196R.id.com_facebook_smart_instructions_2), appSettingsWithoutQuery.getSmartLoginBookmarkIconURL());
            }
            if (appSettingsWithoutQuery.getSmartLoginMenuIconURL() != null) {
                appendIconToTextView((TextView) inflate.findViewById(C0196R.id.com_facebook_smart_instructions_1), appSettingsWithoutQuery.getSmartLoginMenuIconURL());
            }
        } else {
            inflate = layoutInflater.inflate(C0196R.layout.com_facebook_device_auth_dialog_fragment, null);
        }
        this.progressBar = (ProgressBar) inflate.findViewById(C0196R.id.progress_bar);
        this.confirmationCode = (TextView) inflate.findViewById(C0196R.id.confirmation_code);
        ((Button) inflate.findViewById(C0196R.id.cancel_button)).setOnClickListener(new C02653());
        ((TextView) inflate.findViewById(C0196R.id.com_facebook_device_auth_instructions)).setText(Html.fromHtml(getString(C0196R.string.com_facebook_device_auth_instructions)));
        return inflate;
    }

    private void onCancel() {
        if (this.completed.compareAndSet(false, true)) {
            if (this.currentRequestState != null) {
                DeviceRequestsHelper.cleanUpAdvertisementService(this.currentRequestState.getUserCode());
            }
            if (this.deviceAuthMethodHandler != null) {
                this.deviceAuthMethodHandler.onCancel();
            }
            this.dialog.dismiss();
        }
    }

    private void onError(FacebookException facebookException) {
        if (this.completed.compareAndSet(false, true)) {
            if (this.currentRequestState != null) {
                DeviceRequestsHelper.cleanUpAdvertisementService(this.currentRequestState.getUserCode());
            }
            this.deviceAuthMethodHandler.onError(facebookException);
            this.dialog.dismiss();
        }
    }

    private void onSuccess(final String str) {
        Bundle bundle = new Bundle();
        bundle.putString(GraphRequest.FIELDS_PARAM, "id,permissions,name");
        new GraphRequest(new AccessToken(str, FacebookSdk.getApplicationId(), AppEventsConstants.EVENT_PARAM_VALUE_NO, null, null, null, null, null), "me", bundle, HttpMethod.GET, new Callback() {
            public void onCompleted(GraphResponse graphResponse) {
                if (!DeviceAuthDialog.this.completed.get()) {
                    if (graphResponse.getError() != null) {
                        DeviceAuthDialog.this.onError(graphResponse.getError().getException());
                        return;
                    }
                    try {
                        JSONObject jSONObject = graphResponse.getJSONObject();
                        String string = jSONObject.getString(ShareConstants.WEB_DIALOG_PARAM_ID);
                        PermissionsPair handlePermissionResponse = Utility.handlePermissionResponse(jSONObject);
                        String string2 = jSONObject.getString("name");
                        DeviceRequestsHelper.cleanUpAdvertisementService(DeviceAuthDialog.this.currentRequestState.getUserCode());
                        if (!FetchedAppSettingsManager.getAppSettingsWithoutQuery(FacebookSdk.getApplicationId()).getSmartLoginOptions().contains(SmartLoginOption.RequireConfirm) || DeviceAuthDialog.this.isRetry) {
                            DeviceAuthDialog.this.completeLogin(string, handlePermissionResponse, str);
                            return;
                        }
                        DeviceAuthDialog.this.isRetry = true;
                        DeviceAuthDialog.this.presentConfirmation(string, handlePermissionResponse, str, string2);
                    } catch (Throwable e) {
                        DeviceAuthDialog.this.onError(new FacebookException(e));
                    }
                }
            }
        }).executeAsync();
    }

    private void poll() {
        this.currentRequestState.setLastPoll(new Date().getTime());
        this.currentGraphRequestPoll = getPollRequest().executeAsync();
    }

    private void presentConfirmation(final String str, final PermissionsPair permissionsPair, final String str2, String str3) {
        CharSequence string = getResources().getString(C0196R.string.com_facebook_smart_login_confirmation_title);
        String string2 = getResources().getString(C0196R.string.com_facebook_smart_login_confirmation_continue_as);
        CharSequence string3 = getResources().getString(C0196R.string.com_facebook_smart_login_confirmation_cancel);
        CharSequence format = String.format(string2, new Object[]{str3});
        AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
        builder.setMessage(string).setCancelable(true).setNegativeButton(format, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialogInterface, int i) {
                DeviceAuthDialog.this.completeLogin(str, permissionsPair, str2);
            }
        }).setPositiveButton(string3, new C02686());
        builder.create().show();
    }

    private void schedulePoll() {
        this.scheduledPoll = DeviceAuthMethodHandler.getBackgroundExecutor().schedule(new C02664(), this.currentRequestState.getInterval(), TimeUnit.SECONDS);
    }

    private void setCurrentRequestState(RequestState requestState) {
        this.currentRequestState = requestState;
        this.confirmationCode.setText(requestState.getUserCode());
        this.confirmationCode.setVisibility(0);
        this.progressBar.setVisibility(8);
        if (!this.isRetry && DeviceRequestsHelper.startAdvertisementService(requestState.getUserCode())) {
            AppEventsLogger.newLogger(getContext()).logSdkEvent(AnalyticsEvents.EVENT_SMART_LOGIN_SERVICE, null, null);
        }
        if (requestState.withinLastRefreshWindow()) {
            schedulePoll();
        } else {
            poll();
        }
    }

    public Dialog onCreateDialog(Bundle bundle) {
        this.dialog = new Dialog(getActivity(), C0196R.style.com_facebook_auth_dialog);
        getActivity().getLayoutInflater();
        boolean z = DeviceRequestsHelper.isAvailable() && !this.isRetry;
        this.dialog.setContentView(initializeContentView(z));
        return this.dialog;
    }

    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View onCreateView = super.onCreateView(layoutInflater, viewGroup, bundle);
        this.deviceAuthMethodHandler = (DeviceAuthMethodHandler) ((LoginFragment) ((FacebookActivity) getActivity()).getCurrentFragment()).getLoginClient().getCurrentHandler();
        if (bundle != null) {
            RequestState requestState = (RequestState) bundle.getParcelable(REQUEST_STATE_KEY);
            if (requestState != null) {
                setCurrentRequestState(requestState);
            }
        }
        return onCreateView;
    }

    public void onDestroy() {
        this.isBeingDestroyed = true;
        this.completed.set(true);
        super.onDestroy();
        if (this.currentGraphRequestPoll != null) {
            this.currentGraphRequestPoll.cancel(true);
        }
        if (this.scheduledPoll != null) {
            this.scheduledPoll.cancel(true);
        }
    }

    public void onDismiss(DialogInterface dialogInterface) {
        super.onDismiss(dialogInterface);
        if (!this.isBeingDestroyed) {
            onCancel();
        }
    }

    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        if (this.currentRequestState != null) {
            bundle.putParcelable(REQUEST_STATE_KEY, this.currentRequestState);
        }
    }

    public void startLogin(Request request) {
        this.mRequest = request;
        Bundle bundle = new Bundle();
        bundle.putString("scope", TextUtils.join(",", request.getPermissions()));
        String deviceRedirectUriString = request.getDeviceRedirectUriString();
        if (deviceRedirectUriString != null) {
            bundle.putString(ServerProtocol.DIALOG_PARAM_REDIRECT_URI, deviceRedirectUriString);
        }
        bundle.putString("access_token", Validate.hasAppID() + "|" + Validate.hasClientToken());
        bundle.putString(DeviceRequestsHelper.DEVICE_INFO_PARAM, DeviceRequestsHelper.getDeviceInfo());
        new GraphRequest(null, DEVICE_LOGIN_ENDPOINT, bundle, HttpMethod.POST, new C02631()).executeAsync();
    }
}
