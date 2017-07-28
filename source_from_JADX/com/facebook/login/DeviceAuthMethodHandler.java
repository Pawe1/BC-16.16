package com.facebook.login;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import com.facebook.AccessToken;
import com.facebook.AccessTokenSource;
import com.facebook.login.LoginClient.Request;
import com.facebook.login.LoginClient.Result;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.ScheduledThreadPoolExecutor;

class DeviceAuthMethodHandler extends LoginMethodHandler {
    public static final Creator<DeviceAuthMethodHandler> CREATOR = new C02721();
    private static ScheduledThreadPoolExecutor backgroundExecutor;

    final class C02721 implements Creator {
        C02721() {
        }

        public final DeviceAuthMethodHandler createFromParcel(Parcel parcel) {
            return new DeviceAuthMethodHandler(parcel);
        }

        public final DeviceAuthMethodHandler[] newArray(int i) {
            return new DeviceAuthMethodHandler[i];
        }
    }

    protected DeviceAuthMethodHandler(Parcel parcel) {
        super(parcel);
    }

    DeviceAuthMethodHandler(LoginClient loginClient) {
        super(loginClient);
    }

    public static synchronized ScheduledThreadPoolExecutor getBackgroundExecutor() {
        ScheduledThreadPoolExecutor scheduledThreadPoolExecutor;
        synchronized (DeviceAuthMethodHandler.class) {
            if (backgroundExecutor == null) {
                backgroundExecutor = new ScheduledThreadPoolExecutor(1);
            }
            scheduledThreadPoolExecutor = backgroundExecutor;
        }
        return scheduledThreadPoolExecutor;
    }

    private void showDialog(Request request) {
        DeviceAuthDialog deviceAuthDialog = new DeviceAuthDialog();
        deviceAuthDialog.show(this.loginClient.getActivity().getSupportFragmentManager(), "login_with_facebook");
        deviceAuthDialog.startLogin(request);
    }

    public int describeContents() {
        return 0;
    }

    String getNameForLogging() {
        return "device_auth";
    }

    public void onCancel() {
        this.loginClient.completeAndValidate(Result.createCancelResult(this.loginClient.getPendingRequest(), "User canceled log in."));
    }

    public void onError(Exception exception) {
        this.loginClient.completeAndValidate(Result.createErrorResult(this.loginClient.getPendingRequest(), null, exception.getMessage()));
    }

    public void onSuccess(String str, String str2, String str3, Collection<String> collection, Collection<String> collection2, AccessTokenSource accessTokenSource, Date date, Date date2) {
        this.loginClient.completeAndValidate(Result.createTokenResult(this.loginClient.getPendingRequest(), new AccessToken(str, str2, str3, collection, collection2, accessTokenSource, date, date2)));
    }

    boolean tryAuthorize(Request request) {
        showDialog(request);
        return true;
    }

    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
    }
}
