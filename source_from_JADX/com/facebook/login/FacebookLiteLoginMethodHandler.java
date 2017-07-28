package com.facebook.login;

import android.content.Intent;
import android.os.Parcel;
import android.os.Parcelable.Creator;
import com.facebook.internal.NativeProtocol;
import com.facebook.login.LoginClient.Request;

class FacebookLiteLoginMethodHandler extends NativeAppLoginMethodHandler {
    public static final Creator<FacebookLiteLoginMethodHandler> CREATOR = new C02731();

    final class C02731 implements Creator {
        C02731() {
        }

        public final FacebookLiteLoginMethodHandler createFromParcel(Parcel parcel) {
            return new FacebookLiteLoginMethodHandler(parcel);
        }

        public final FacebookLiteLoginMethodHandler[] newArray(int i) {
            return new FacebookLiteLoginMethodHandler[i];
        }
    }

    FacebookLiteLoginMethodHandler(Parcel parcel) {
        super(parcel);
    }

    FacebookLiteLoginMethodHandler(LoginClient loginClient) {
        super(loginClient);
    }

    public int describeContents() {
        return 0;
    }

    String getNameForLogging() {
        return "fb_lite_login";
    }

    boolean tryAuthorize(Request request) {
        String e2e = LoginClient.getE2E();
        Intent createFacebookLiteIntent = NativeProtocol.createFacebookLiteIntent(this.loginClient.getActivity(), request.getApplicationId(), request.getPermissions(), e2e, request.isRerequest(), request.hasPublishPermission(), request.getDefaultAudience(), getClientState(request.getAuthId()));
        addLoggingExtra("e2e", e2e);
        return tryIntent(createFacebookLiteIntent, LoginClient.getLoginRequestCode());
    }

    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
    }
}
