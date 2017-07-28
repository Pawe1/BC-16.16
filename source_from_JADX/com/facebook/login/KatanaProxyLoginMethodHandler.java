package com.facebook.login;

import android.content.Intent;
import android.os.Parcel;
import android.os.Parcelable.Creator;
import com.facebook.internal.NativeProtocol;
import com.facebook.login.LoginClient.Request;

class KatanaProxyLoginMethodHandler extends NativeAppLoginMethodHandler {
    public static final Creator<KatanaProxyLoginMethodHandler> CREATOR = new C02771();

    final class C02771 implements Creator {
        C02771() {
        }

        public final KatanaProxyLoginMethodHandler createFromParcel(Parcel parcel) {
            return new KatanaProxyLoginMethodHandler(parcel);
        }

        public final KatanaProxyLoginMethodHandler[] newArray(int i) {
            return new KatanaProxyLoginMethodHandler[i];
        }
    }

    KatanaProxyLoginMethodHandler(Parcel parcel) {
        super(parcel);
    }

    KatanaProxyLoginMethodHandler(LoginClient loginClient) {
        super(loginClient);
    }

    public int describeContents() {
        return 0;
    }

    String getNameForLogging() {
        return "katana_proxy_auth";
    }

    boolean tryAuthorize(Request request) {
        String e2e = LoginClient.getE2E();
        Intent createProxyAuthIntent = NativeProtocol.createProxyAuthIntent(this.loginClient.getActivity(), request.getApplicationId(), request.getPermissions(), e2e, request.isRerequest(), request.hasPublishPermission(), request.getDefaultAudience(), getClientState(request.getAuthId()));
        addLoggingExtra("e2e", e2e);
        return tryIntent(createProxyAuthIntent, LoginClient.getLoginRequestCode());
    }

    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
    }
}
