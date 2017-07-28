package com.facebook.devicerequests.internal;

import android.annotation.TargetApi;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdManager.RegistrationListener;
import android.net.nsd.NsdServiceInfo;
import android.os.Build;
import android.os.Build.VERSION;
import com.facebook.FacebookSdk;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.SmartLoginOption;
import java.util.HashMap;
import org.json.JSONException;
import org.json.JSONObject;

public class DeviceRequestsHelper {
    static final String DEVICE_INFO_DEVICE = "device";
    static final String DEVICE_INFO_MODEL = "model";
    public static final String DEVICE_INFO_PARAM = "device_info";
    static final String SDK_FLAVOR = "android";
    static final String SDK_HEADER = "fbsdk";
    static final String SERVICE_TYPE = "_fb._tcp.";
    private static HashMap<String, RegistrationListener> deviceRequestsListeners = new HashMap();

    final class C02241 implements RegistrationListener {
        final /* synthetic */ String val$nsdServiceName;
        final /* synthetic */ String val$userCode;

        C02241(String str, String str2) {
            this.val$nsdServiceName = str;
            this.val$userCode = str2;
        }

        public final void onRegistrationFailed(NsdServiceInfo nsdServiceInfo, int i) {
            DeviceRequestsHelper.cleanUpAdvertisementService(this.val$userCode);
        }

        public final void onServiceRegistered(NsdServiceInfo nsdServiceInfo) {
            if (!this.val$nsdServiceName.equals(nsdServiceInfo.getServiceName())) {
                DeviceRequestsHelper.cleanUpAdvertisementService(this.val$userCode);
            }
        }

        public final void onServiceUnregistered(NsdServiceInfo nsdServiceInfo) {
        }

        public final void onUnregistrationFailed(NsdServiceInfo nsdServiceInfo, int i) {
        }
    }

    public static void cleanUpAdvertisementService(String str) {
        cleanUpAdvertisementServiceImpl(str);
    }

    @TargetApi(16)
    private static void cleanUpAdvertisementServiceImpl(String str) {
        RegistrationListener registrationListener = (RegistrationListener) deviceRequestsListeners.get(str);
        if (registrationListener != null) {
            ((NsdManager) FacebookSdk.getApplicationContext().getSystemService("servicediscovery")).unregisterService(registrationListener);
            deviceRequestsListeners.remove(str);
        }
    }

    public static String getDeviceInfo() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put(DEVICE_INFO_DEVICE, Build.DEVICE);
            jSONObject.put(DEVICE_INFO_MODEL, Build.MODEL);
        } catch (JSONException e) {
        }
        return jSONObject.toString();
    }

    public static boolean isAvailable() {
        return VERSION.SDK_INT >= 16 && FetchedAppSettingsManager.getAppSettingsWithoutQuery(FacebookSdk.getApplicationId()).getSmartLoginOptions().contains(SmartLoginOption.Enabled);
    }

    public static boolean startAdvertisementService(String str) {
        return isAvailable() ? startAdvertisementServiceImpl(str) : false;
    }

    @TargetApi(16)
    private static boolean startAdvertisementServiceImpl(String str) {
        if (!deviceRequestsListeners.containsKey(str)) {
            String replace = FacebookSdk.getSdkVersion().replace('.', '|');
            r2 = new Object[3];
            r2[1] = String.format("%s-%s", new Object[]{SDK_FLAVOR, replace});
            r2[2] = str;
            String format = String.format("%s_%s_%s", r2);
            NsdServiceInfo nsdServiceInfo = new NsdServiceInfo();
            nsdServiceInfo.setServiceType(SERVICE_TYPE);
            nsdServiceInfo.setServiceName(format);
            nsdServiceInfo.setPort(80);
            NsdManager nsdManager = (NsdManager) FacebookSdk.getApplicationContext().getSystemService("servicediscovery");
            RegistrationListener c02241 = new C02241(format, str);
            deviceRequestsListeners.put(str, c02241);
            nsdManager.registerService(nsdServiceInfo, 1, c02241);
        }
        return true;
    }
}
