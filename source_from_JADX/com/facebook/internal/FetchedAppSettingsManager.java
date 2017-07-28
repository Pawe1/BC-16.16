package com.facebook.internal;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.appevents.internal.AutomaticAnalyticsLogger;
import com.facebook.appevents.internal.Constants;
import com.facebook.internal.FetchedAppSettings.DialogFeatureConfig;
import com.facebook.share.internal.ShareConstants;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;
import org.json.JSONArray;
import org.json.JSONObject;

public final class FetchedAppSettingsManager {
    private static final String APPLICATION_FIELDS = "fields";
    private static final String APP_SETTINGS_PREFS_KEY_FORMAT = "com.facebook.internal.APP_SETTINGS.%s";
    private static final String APP_SETTINGS_PREFS_STORE = "com.facebook.internal.preferences.APP_SETTINGS";
    private static final String APP_SETTING_ANDROID_SDK_ERROR_CATEGORIES = "android_sdk_error_categories";
    private static final String APP_SETTING_APP_EVENTS_FEATURE_BITMASK = "app_events_feature_bitmask";
    private static final String APP_SETTING_APP_EVENTS_SESSION_TIMEOUT = "app_events_session_timeout";
    private static final String APP_SETTING_CUSTOM_TABS_ENABLED = "gdpv4_chrome_custom_tabs_enabled";
    private static final String APP_SETTING_DIALOG_CONFIGS = "android_dialog_configs";
    private static final String[] APP_SETTING_FIELDS = new String[]{APP_SETTING_SUPPORTS_IMPLICIT_SDK_LOGGING, APP_SETTING_NUX_CONTENT, APP_SETTING_NUX_ENABLED, APP_SETTING_CUSTOM_TABS_ENABLED, APP_SETTING_DIALOG_CONFIGS, APP_SETTING_ANDROID_SDK_ERROR_CATEGORIES, APP_SETTING_APP_EVENTS_SESSION_TIMEOUT, APP_SETTING_APP_EVENTS_FEATURE_BITMASK, APP_SETTING_SMART_LOGIN_OPTIONS, SMART_LOGIN_BOOKMARK_ICON_URL, SMART_LOGIN_MENU_ICON_URL};
    private static final String APP_SETTING_NUX_CONTENT = "gdpv4_nux_content";
    private static final String APP_SETTING_NUX_ENABLED = "gdpv4_nux_enabled";
    private static final String APP_SETTING_SMART_LOGIN_OPTIONS = "seamless_login";
    private static final String APP_SETTING_SUPPORTS_IMPLICIT_SDK_LOGGING = "supports_implicit_sdk_logging";
    private static final int AUTOMATIC_LOGGING_ENABLED_BITMASK_FIELD = 8;
    private static final String SMART_LOGIN_BOOKMARK_ICON_URL = "smart_login_bookmark_icon_url";
    private static final String SMART_LOGIN_MENU_ICON_URL = "smart_login_menu_icon_url";
    private static Map<String, FetchedAppSettings> fetchedAppSettings = new ConcurrentHashMap();
    private static AtomicBoolean loadingSettings = new AtomicBoolean(false);

    final class C02421 implements Runnable {
        final /* synthetic */ String val$applicationId;
        final /* synthetic */ Context val$context;
        final /* synthetic */ String val$settingsKey;

        C02421(Context context, String str, String str2) {
            this.val$context = context;
            this.val$settingsKey = str;
            this.val$applicationId = str2;
        }

        public final void run() {
            JSONObject jSONObject;
            SharedPreferences sharedPreferences = this.val$context.getSharedPreferences(FetchedAppSettingsManager.APP_SETTINGS_PREFS_STORE, 0);
            String string = sharedPreferences.getString(this.val$settingsKey, null);
            if (!Utility.isNullOrEmpty(string)) {
                try {
                    jSONObject = new JSONObject(string);
                } catch (Exception e) {
                    Utility.logd("FacebookSDK", e);
                    jSONObject = null;
                }
                if (jSONObject != null) {
                    FetchedAppSettingsManager.parseAppSettingsFromJSON(this.val$applicationId, jSONObject);
                }
            }
            jSONObject = FetchedAppSettingsManager.getAppSettingsQueryResponse(this.val$applicationId);
            if (jSONObject != null) {
                FetchedAppSettingsManager.parseAppSettingsFromJSON(this.val$applicationId, jSONObject);
                sharedPreferences.edit().putString(this.val$settingsKey, jSONObject.toString()).apply();
            }
            AutomaticAnalyticsLogger.logActivateAppEvent();
            FetchedAppSettingsManager.loadingSettings.set(false);
        }
    }

    private static JSONObject getAppSettingsQueryResponse(String str) {
        Bundle bundle = new Bundle();
        bundle.putString("fields", TextUtils.join(",", APP_SETTING_FIELDS));
        GraphRequest newGraphPathRequest = GraphRequest.newGraphPathRequest(null, str, null);
        newGraphPathRequest.setSkipClientToken(true);
        newGraphPathRequest.setParameters(bundle);
        return newGraphPathRequest.executeAndWait().getJSONObject();
    }

    public static FetchedAppSettings getAppSettingsWithoutQuery(String str) {
        return str != null ? (FetchedAppSettings) fetchedAppSettings.get(str) : null;
    }

    public static void loadAppSettingsAsync() {
        Context applicationContext = FacebookSdk.getApplicationContext();
        String applicationId = FacebookSdk.getApplicationId();
        boolean compareAndSet = loadingSettings.compareAndSet(false, true);
        if (!Utility.isNullOrEmpty(applicationId) && !fetchedAppSettings.containsKey(applicationId) && compareAndSet) {
            FacebookSdk.getExecutor().execute(new C02421(applicationContext, String.format(APP_SETTINGS_PREFS_KEY_FORMAT, new Object[]{applicationId}), applicationId));
        }
    }

    private static FetchedAppSettings parseAppSettingsFromJSON(String str, JSONObject jSONObject) {
        JSONArray optJSONArray = jSONObject.optJSONArray(APP_SETTING_ANDROID_SDK_ERROR_CATEGORIES);
        FetchedAppSettings fetchedAppSettings = new FetchedAppSettings(jSONObject.optBoolean(APP_SETTING_SUPPORTS_IMPLICIT_SDK_LOGGING, false), jSONObject.optString(APP_SETTING_NUX_CONTENT, ""), jSONObject.optBoolean(APP_SETTING_NUX_ENABLED, false), jSONObject.optBoolean(APP_SETTING_CUSTOM_TABS_ENABLED, false), jSONObject.optInt(APP_SETTING_APP_EVENTS_SESSION_TIMEOUT, Constants.getDefaultAppEventsSessionTimeoutInSeconds()), SmartLoginOption.parseOptions(jSONObject.optLong(APP_SETTING_SMART_LOGIN_OPTIONS)), parseDialogConfigurations(jSONObject.optJSONObject(APP_SETTING_DIALOG_CONFIGS)), (jSONObject.optInt(APP_SETTING_APP_EVENTS_FEATURE_BITMASK, 0) & 8) != 0, optJSONArray == null ? FacebookRequestErrorClassification.getDefaultErrorClassification() : FacebookRequestErrorClassification.createFromJSON(optJSONArray), jSONObject.optString(SMART_LOGIN_BOOKMARK_ICON_URL), jSONObject.optString(SMART_LOGIN_MENU_ICON_URL));
        fetchedAppSettings.put(str, fetchedAppSettings);
        return fetchedAppSettings;
    }

    private static Map<String, Map<String, DialogFeatureConfig>> parseDialogConfigurations(JSONObject jSONObject) {
        Map hashMap = new HashMap();
        if (jSONObject != null) {
            JSONArray optJSONArray = jSONObject.optJSONArray(ShareConstants.WEB_DIALOG_PARAM_DATA);
            if (optJSONArray != null) {
                for (int i = 0; i < optJSONArray.length(); i++) {
                    DialogFeatureConfig parseDialogConfig = DialogFeatureConfig.parseDialogConfig(optJSONArray.optJSONObject(i));
                    if (parseDialogConfig != null) {
                        String dialogName = parseDialogConfig.getDialogName();
                        Map map = (Map) hashMap.get(dialogName);
                        if (map == null) {
                            map = new HashMap();
                            hashMap.put(dialogName, map);
                        }
                        map.put(parseDialogConfig.getFeatureName(), parseDialogConfig);
                    }
                }
            }
        }
        return hashMap;
    }

    public static FetchedAppSettings queryAppSettings(String str, boolean z) {
        if (!z && fetchedAppSettings.containsKey(str)) {
            return (FetchedAppSettings) fetchedAppSettings.get(str);
        }
        JSONObject appSettingsQueryResponse = getAppSettingsQueryResponse(str);
        return appSettingsQueryResponse == null ? null : parseAppSettingsFromJSON(str, appSettingsQueryResponse);
    }
}
