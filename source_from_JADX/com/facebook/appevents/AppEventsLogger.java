package com.facebook.appevents;

import android.app.Activity;
import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import com.facebook.AccessToken;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphRequest.Callback;
import com.facebook.HttpMethod;
import com.facebook.LoggingBehavior;
import com.facebook.appevents.internal.ActivityLifecycleTracker;
import com.facebook.internal.AttributionIdentifiers;
import com.facebook.internal.BundleJSONConverter;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.Logger;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import com.facebook.share.internal.ShareConstants;
import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.FileNotFoundException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigDecimal;
import java.util.Currency;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Executor;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AppEventsLogger {
    public static final String ACTION_APP_EVENTS_FLUSHED = "com.facebook.sdk.APP_EVENTS_FLUSHED";
    public static final String APP_EVENTS_EXTRA_FLUSH_RESULT = "com.facebook.sdk.APP_EVENTS_FLUSH_RESULT";
    public static final String APP_EVENTS_EXTRA_NUM_EVENTS_FLUSHED = "com.facebook.sdk.APP_EVENTS_NUM_EVENTS_FLUSHED";
    private static final String APP_EVENT_NAME_PUSH_OPENED = "fb_mobile_push_opened";
    public static final String APP_EVENT_PREFERENCES = "com.facebook.sdk.appEventPreferences";
    private static final String APP_EVENT_PUSH_PARAMETER_ACTION = "fb_push_action";
    private static final String APP_EVENT_PUSH_PARAMETER_CAMPAIGN = "fb_push_campaign";
    private static final int APP_SUPPORTS_ATTRIBUTION_ID_RECHECK_PERIOD_IN_SECONDS = 86400;
    private static final int FLUSH_APP_SESSION_INFO_IN_SECONDS = 30;
    private static final String PUSH_PAYLOAD_CAMPAIGN_KEY = "campaign";
    private static final String PUSH_PAYLOAD_KEY = "fb_push_payload";
    private static final String SOURCE_APPLICATION_HAS_BEEN_SET_BY_THIS_INTENT = "_fbSourceApplicationHasBeenSet";
    private static final String TAG = AppEventsLogger.class.getCanonicalName();
    private static String anonymousAppDeviceGUID;
    private static ScheduledThreadPoolExecutor backgroundExecutor;
    private static String externalAnalyticsUserID;
    private static FlushBehavior flushBehavior = FlushBehavior.AUTO;
    private static boolean isActivateAppEventRequested;
    private static boolean isOpenedByApplink;
    private static String pushNotificationsRegistrationId;
    private static String sourceApplication;
    private static Object staticLock = new Object();
    private final AccessTokenAppIdPair accessTokenAppId;
    private final String contextName;

    final class C02103 implements Runnable {
        final /* synthetic */ String val$applicationID;
        final /* synthetic */ Callback val$callback;
        final /* synthetic */ Bundle val$parameters;
        final /* synthetic */ String val$userID;

        C02103(String str, Bundle bundle, String str2, Callback callback) {
            this.val$userID = str;
            this.val$parameters = bundle;
            this.val$applicationID = str2;
            this.val$callback = callback;
        }

        public final void run() {
            Bundle bundle = new Bundle();
            bundle.putString("user_unique_id", this.val$userID);
            bundle.putBundle("custom_data", this.val$parameters);
            AttributionIdentifiers attributionIdentifiers = AttributionIdentifiers.getAttributionIdentifiers(FacebookSdk.getApplicationContext());
            if (!(attributionIdentifiers == null || attributionIdentifiers.getAndroidAdvertiserId() == null)) {
                bundle.putString("advertiser_id", attributionIdentifiers.getAndroidAdvertiserId());
            }
            Bundle bundle2 = new Bundle();
            try {
                JSONObject convertToJSON = BundleJSONConverter.convertToJSON(bundle);
                JSONArray jSONArray = new JSONArray();
                jSONArray.put(convertToJSON);
                bundle2.putString(ShareConstants.WEB_DIALOG_PARAM_DATA, jSONArray.toString());
                GraphRequest graphRequest = new GraphRequest(AccessToken.getCurrentAccessToken(), String.format(Locale.US, "%s/user_properties", new Object[]{this.val$applicationID}), bundle2, HttpMethod.POST, this.val$callback);
                graphRequest.setSkipClientToken(true);
                graphRequest.executeAsync();
            } catch (Throwable e) {
                throw new FacebookException("Failed to construct request", e);
            }
        }
    }

    final class C02114 implements Runnable {
        C02114() {
        }

        public final void run() {
            Set<String> hashSet = new HashSet();
            for (AccessTokenAppIdPair applicationId : AppEventQueue.getKeySet()) {
                hashSet.add(applicationId.getApplicationId());
            }
            for (String queryAppSettings : hashSet) {
                FetchedAppSettingsManager.queryAppSettings(queryAppSettings, true);
            }
        }
    }

    public enum FlushBehavior {
        AUTO,
        EXPLICIT_ONLY
    }

    static class PersistedAppSessionInfo {
        private static final String PERSISTED_SESSION_INFO_FILENAME = "AppEventsLogger.persistedsessioninfo";
        private static final Runnable appSessionInfoFlushRunnable = new C02121();
        private static Map<AccessTokenAppIdPair, FacebookTimeSpentData> appSessionInfoMap;
        private static boolean hasChanges = false;
        private static boolean isLoaded = false;
        private static final Object staticLock = new Object();

        final class C02121 implements Runnable {
            C02121() {
            }

            public final void run() {
                PersistedAppSessionInfo.saveAppSessionInformation(FacebookSdk.getApplicationContext());
            }
        }

        PersistedAppSessionInfo() {
        }

        private static FacebookTimeSpentData getTimeSpentData(Context context, AccessTokenAppIdPair accessTokenAppIdPair) {
            restoreAppSessionInformation(context);
            FacebookTimeSpentData facebookTimeSpentData = (FacebookTimeSpentData) appSessionInfoMap.get(accessTokenAppIdPair);
            if (facebookTimeSpentData != null) {
                return facebookTimeSpentData;
            }
            facebookTimeSpentData = new FacebookTimeSpentData();
            appSessionInfoMap.put(accessTokenAppIdPair, facebookTimeSpentData);
            return facebookTimeSpentData;
        }

        static void onResume(Context context, AccessTokenAppIdPair accessTokenAppIdPair, AppEventsLogger appEventsLogger, long j, String str) {
            synchronized (staticLock) {
                getTimeSpentData(context, accessTokenAppIdPair).onResume(appEventsLogger, j, str);
                onTimeSpentDataUpdate();
            }
        }

        static void onSuspend(Context context, AccessTokenAppIdPair accessTokenAppIdPair, AppEventsLogger appEventsLogger, long j) {
            synchronized (staticLock) {
                getTimeSpentData(context, accessTokenAppIdPair).onSuspend(appEventsLogger, j);
                onTimeSpentDataUpdate();
            }
        }

        private static void onTimeSpentDataUpdate() {
            if (!hasChanges) {
                hasChanges = true;
                AppEventsLogger.backgroundExecutor.schedule(appSessionInfoFlushRunnable, 30, TimeUnit.SECONDS);
            }
        }

        private static void restoreAppSessionInformation(Context context) {
            Closeable objectInputStream;
            Exception e;
            Closeable closeable = null;
            synchronized (staticLock) {
                if (!isLoaded) {
                    try {
                        objectInputStream = new ObjectInputStream(context.openFileInput(PERSISTED_SESSION_INFO_FILENAME));
                        try {
                            appSessionInfoMap = (HashMap) objectInputStream.readObject();
                            Logger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "App session info loaded");
                            Utility.closeQuietly(objectInputStream);
                            context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                            if (appSessionInfoMap == null) {
                                appSessionInfoMap = new HashMap();
                            }
                            isLoaded = true;
                            hasChanges = false;
                        } catch (FileNotFoundException e2) {
                            closeable = objectInputStream;
                            Utility.closeQuietly(closeable);
                            context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                            if (appSessionInfoMap == null) {
                                appSessionInfoMap = new HashMap();
                            }
                            isLoaded = true;
                            hasChanges = false;
                        } catch (Exception e3) {
                            e = e3;
                            try {
                                Log.w(AppEventsLogger.TAG, "Got unexpected exception restoring app session info: " + e.toString());
                                Utility.closeQuietly(objectInputStream);
                                context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                                if (appSessionInfoMap == null) {
                                    appSessionInfoMap = new HashMap();
                                }
                                isLoaded = true;
                                hasChanges = false;
                            } catch (Throwable th) {
                                Throwable th2 = th;
                                Utility.closeQuietly(objectInputStream);
                                context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                                if (appSessionInfoMap == null) {
                                    appSessionInfoMap = new HashMap();
                                }
                                isLoaded = true;
                                hasChanges = false;
                                throw th2;
                            }
                        }
                    } catch (FileNotFoundException e4) {
                        Utility.closeQuietly(closeable);
                        context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                        if (appSessionInfoMap == null) {
                            appSessionInfoMap = new HashMap();
                        }
                        isLoaded = true;
                        hasChanges = false;
                    } catch (Exception e5) {
                        Exception exception = e5;
                        objectInputStream = null;
                        e = exception;
                        Log.w(AppEventsLogger.TAG, "Got unexpected exception restoring app session info: " + e.toString());
                        Utility.closeQuietly(objectInputStream);
                        context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                        if (appSessionInfoMap == null) {
                            appSessionInfoMap = new HashMap();
                        }
                        isLoaded = true;
                        hasChanges = false;
                    } catch (Throwable th3) {
                        Throwable th4 = th3;
                        objectInputStream = null;
                        th2 = th4;
                        Utility.closeQuietly(objectInputStream);
                        context.deleteFile(PERSISTED_SESSION_INFO_FILENAME);
                        if (appSessionInfoMap == null) {
                            appSessionInfoMap = new HashMap();
                        }
                        isLoaded = true;
                        hasChanges = false;
                        throw th2;
                    }
                }
            }
        }

        static void saveAppSessionInformation(Context context) {
            Exception e;
            Throwable th;
            synchronized (staticLock) {
                if (hasChanges) {
                    Closeable objectOutputStream;
                    try {
                        objectOutputStream = new ObjectOutputStream(new BufferedOutputStream(context.openFileOutput(PERSISTED_SESSION_INFO_FILENAME, 0)));
                        try {
                            objectOutputStream.writeObject(appSessionInfoMap);
                            hasChanges = false;
                            Logger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "App session info saved");
                            Utility.closeQuietly(objectOutputStream);
                        } catch (Exception e2) {
                            e = e2;
                            try {
                                Log.w(AppEventsLogger.TAG, "Got unexpected exception while writing app session info: " + e.toString());
                                Utility.closeQuietly(objectOutputStream);
                            } catch (Throwable th2) {
                                th = th2;
                                Utility.closeQuietly(objectOutputStream);
                                throw th;
                            }
                        }
                    } catch (Exception e3) {
                        e = e3;
                        objectOutputStream = null;
                        Log.w(AppEventsLogger.TAG, "Got unexpected exception while writing app session info: " + e.toString());
                        Utility.closeQuietly(objectOutputStream);
                    } catch (Throwable th3) {
                        th = th3;
                        objectOutputStream = null;
                        Utility.closeQuietly(objectOutputStream);
                        throw th;
                    }
                }
            }
        }
    }

    private AppEventsLogger(Context context, String str, AccessToken accessToken) {
        this(Utility.getActivityName(context), str, accessToken);
    }

    protected AppEventsLogger(String str, String str2, AccessToken accessToken) {
        Validate.sdkInitialized();
        this.contextName = str;
        if (accessToken == null) {
            accessToken = AccessToken.getCurrentAccessToken();
        }
        if (accessToken == null || !(str2 == null || str2.equals(accessToken.getApplicationId()))) {
            if (str2 == null) {
                str2 = Utility.getMetadataApplicationId(FacebookSdk.getApplicationContext());
            }
            this.accessTokenAppId = new AccessTokenAppIdPair(null, str2);
        } else {
            this.accessTokenAppId = new AccessTokenAppIdPair(accessToken);
        }
        initializeTimersIfNeeded();
    }

    public static void activateApp(Application application) {
        activateApp(application, null);
    }

    public static void activateApp(Application application, String str) {
        if (FacebookSdk.isInitialized()) {
            AnalyticsUserIDStore.initStore();
            if (str == null) {
                str = FacebookSdk.getApplicationId();
            }
            FacebookSdk.publishInstallAsync(application, str);
            ActivityLifecycleTracker.startTracking(application, str);
            return;
        }
        throw new FacebookException("The Facebook sdk must be initialized before calling activateApp");
    }

    @Deprecated
    public static void activateApp(Context context) {
        if (ActivityLifecycleTracker.isTracking()) {
            Log.w(TAG, "activateApp events are being logged automatically. There's no need to call activateApp explicitly, this is safe to remove.");
            return;
        }
        FacebookSdk.sdkInitialize(context);
        activateApp(context, Utility.getMetadataApplicationId(context));
    }

    @Deprecated
    public static void activateApp(Context context, String str) {
        if (ActivityLifecycleTracker.isTracking()) {
            Log.w(TAG, "activateApp events are being logged automatically. There's no need to call activateApp explicitly, this is safe to remove.");
        } else if (context == null || str == null) {
            throw new IllegalArgumentException("Both context and applicationId must be non-null");
        } else {
            AnalyticsUserIDStore.initStore();
            if (context instanceof Activity) {
                setSourceApplication((Activity) context);
            } else {
                resetSourceApplication();
                Log.d(AppEventsLogger.class.getName(), "To set source application the context of activateApp must be an instance of Activity");
            }
            FacebookSdk.publishInstallAsync(context, str);
            AppEventsLogger appEventsLogger = new AppEventsLogger(context, str, null);
            final long currentTimeMillis = System.currentTimeMillis();
            final String sourceApplication = getSourceApplication();
            backgroundExecutor.execute(new Runnable(appEventsLogger) {
                final /* synthetic */ AppEventsLogger val$logger;

                public final void run() {
                    this.val$logger.logAppSessionResumeEvent(currentTimeMillis, sourceApplication);
                }
            });
        }
    }

    public static void clearUserID() {
        AnalyticsUserIDStore.setUserID(null);
    }

    @Deprecated
    public static void deactivateApp(Context context) {
        if (ActivityLifecycleTracker.isTracking()) {
            Log.w(TAG, "deactivateApp events are being logged automatically. There's no need to call deactivateApp, this is safe to remove.");
        } else {
            deactivateApp(context, Utility.getMetadataApplicationId(context));
        }
    }

    @Deprecated
    public static void deactivateApp(Context context, String str) {
        if (ActivityLifecycleTracker.isTracking()) {
            Log.w(TAG, "deactivateApp events are being logged automatically. There's no need to call deactivateApp, this is safe to remove.");
        } else if (context == null || str == null) {
            throw new IllegalArgumentException("Both context and applicationId must be non-null");
        } else {
            resetSourceApplication();
            AppEventsLogger appEventsLogger = new AppEventsLogger(context, str, null);
            final long currentTimeMillis = System.currentTimeMillis();
            backgroundExecutor.execute(new Runnable(appEventsLogger) {
                final /* synthetic */ AppEventsLogger val$logger;

                public final void run() {
                    this.val$logger.logAppSessionSuspendEvent(currentTimeMillis);
                }
            });
        }
    }

    static void eagerFlush() {
        if (getFlushBehavior() != FlushBehavior.EXPLICIT_ONLY) {
            AppEventQueue.flush(FlushReason.EAGER_FLUSHING_EVENT);
        }
    }

    static Executor getAnalyticsExecutor() {
        if (backgroundExecutor == null) {
            initializeTimersIfNeeded();
        }
        return backgroundExecutor;
    }

    public static String getAnonymousAppDeviceGUID(Context context) {
        if (anonymousAppDeviceGUID == null) {
            synchronized (staticLock) {
                if (anonymousAppDeviceGUID == null) {
                    String string = context.getSharedPreferences(APP_EVENT_PREFERENCES, 0).getString("anonymousAppDeviceGUID", null);
                    anonymousAppDeviceGUID = string;
                    if (string == null) {
                        anonymousAppDeviceGUID = "XZ" + UUID.randomUUID().toString();
                        context.getSharedPreferences(APP_EVENT_PREFERENCES, 0).edit().putString("anonymousAppDeviceGUID", anonymousAppDeviceGUID).apply();
                    }
                }
            }
        }
        return anonymousAppDeviceGUID;
    }

    public static FlushBehavior getFlushBehavior() {
        FlushBehavior flushBehavior;
        synchronized (staticLock) {
            flushBehavior = flushBehavior;
        }
        return flushBehavior;
    }

    static String getPushNotificationsRegistrationId() {
        String str;
        synchronized (staticLock) {
            str = pushNotificationsRegistrationId;
        }
        return str;
    }

    static String getSourceApplication() {
        String str = "Unclassified";
        if (isOpenedByApplink) {
            str = "Applink";
        }
        return sourceApplication != null ? str + "(" + sourceApplication + ")" : str;
    }

    public static String getUserID() {
        return AnalyticsUserIDStore.getUserID();
    }

    private static void initializeTimersIfNeeded() {
        synchronized (staticLock) {
            if (backgroundExecutor != null) {
                return;
            }
            backgroundExecutor = new ScheduledThreadPoolExecutor(1);
            backgroundExecutor.scheduleAtFixedRate(new C02114(), 0, 86400, TimeUnit.SECONDS);
        }
    }

    private void logAppSessionResumeEvent(long j, String str) {
        PersistedAppSessionInfo.onResume(FacebookSdk.getApplicationContext(), this.accessTokenAppId, this, j, str);
    }

    private void logAppSessionSuspendEvent(long j) {
        PersistedAppSessionInfo.onSuspend(FacebookSdk.getApplicationContext(), this.accessTokenAppId, this, j);
    }

    private static void logEvent(Context context, AppEvent appEvent, AccessTokenAppIdPair accessTokenAppIdPair) {
        AppEventQueue.add(accessTokenAppIdPair, appEvent);
        if (!appEvent.getIsImplicit() && !isActivateAppEventRequested) {
            if (appEvent.getName() == AppEventsConstants.EVENT_NAME_ACTIVATED_APP) {
                isActivateAppEventRequested = true;
            } else {
                Logger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "Warning: Please call AppEventsLogger.activateApp(...)from the long-lived activity's onResume() methodbefore logging other app events.");
            }
        }
    }

    private void logEvent(String str, Double d, Bundle bundle, boolean z, UUID uuid) {
        try {
            logEvent(FacebookSdk.getApplicationContext(), new AppEvent(this.contextName, str, d, bundle, z, uuid), this.accessTokenAppId);
        } catch (JSONException e) {
            Logger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "JSON encoding for app event failed: '%s'", e.toString());
        } catch (FacebookException e2) {
            Logger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "Invalid app event: %s", e2.toString());
        }
    }

    public static AppEventsLogger newLogger(Context context) {
        return new AppEventsLogger(context, null, null);
    }

    public static AppEventsLogger newLogger(Context context, AccessToken accessToken) {
        return new AppEventsLogger(context, null, accessToken);
    }

    public static AppEventsLogger newLogger(Context context, String str) {
        return new AppEventsLogger(context, str, null);
    }

    public static AppEventsLogger newLogger(Context context, String str, AccessToken accessToken) {
        return new AppEventsLogger(context, str, accessToken);
    }

    private static void notifyDeveloperError(String str) {
        Logger.log(LoggingBehavior.DEVELOPER_ERRORS, "AppEvents", str);
    }

    public static void onContextStop() {
        AppEventQueue.persistToDisk();
    }

    static void resetSourceApplication() {
        sourceApplication = null;
        isOpenedByApplink = false;
    }

    public static void setFlushBehavior(FlushBehavior flushBehavior) {
        synchronized (staticLock) {
            flushBehavior = flushBehavior;
        }
    }

    public static void setPushNotificationsRegistrationId(String str) {
        synchronized (staticLock) {
            pushNotificationsRegistrationId = str;
        }
    }

    private static void setSourceApplication(Activity activity) {
        ComponentName callingActivity = activity.getCallingActivity();
        if (callingActivity != null) {
            String packageName = callingActivity.getPackageName();
            if (packageName.equals(activity.getPackageName())) {
                resetSourceApplication();
                return;
            }
            sourceApplication = packageName;
        }
        Intent intent = activity.getIntent();
        if (intent == null || intent.getBooleanExtra(SOURCE_APPLICATION_HAS_BEEN_SET_BY_THIS_INTENT, false)) {
            resetSourceApplication();
            return;
        }
        Bundle bundleExtra = intent.getBundleExtra("al_applink_data");
        if (bundleExtra == null) {
            resetSourceApplication();
            return;
        }
        isOpenedByApplink = true;
        bundleExtra = bundleExtra.getBundle("referer_app_link");
        if (bundleExtra == null) {
            sourceApplication = null;
            return;
        }
        sourceApplication = bundleExtra.getString("package");
        intent.putExtra(SOURCE_APPLICATION_HAS_BEEN_SET_BY_THIS_INTENT, true);
    }

    static void setSourceApplication(String str, boolean z) {
        sourceApplication = str;
        isOpenedByApplink = z;
    }

    public static void setUserID(String str) {
        AnalyticsUserIDStore.setUserID(str);
    }

    public static void updateUserProperties(Bundle bundle, Callback callback) {
        updateUserProperties(bundle, FacebookSdk.getApplicationId(), callback);
    }

    public static void updateUserProperties(Bundle bundle, String str, Callback callback) {
        String userID = getUserID();
        if (userID == null || userID.isEmpty()) {
            Logger.log(LoggingBehavior.APP_EVENTS, TAG, "AppEventsLogger userID cannot be null or empty");
        } else {
            getAnalyticsExecutor().execute(new C02103(userID, bundle, str, callback));
        }
    }

    public void flush() {
        AppEventQueue.flush(FlushReason.EXPLICIT);
    }

    public String getApplicationId() {
        return this.accessTokenAppId.getApplicationId();
    }

    public boolean isValidForAccessToken(AccessToken accessToken) {
        return this.accessTokenAppId.equals(new AccessTokenAppIdPair(accessToken));
    }

    public void logEvent(String str) {
        logEvent(str, null);
    }

    public void logEvent(String str, double d) {
        logEvent(str, d, null);
    }

    public void logEvent(String str, double d, Bundle bundle) {
        logEvent(str, Double.valueOf(d), bundle, false, ActivityLifecycleTracker.getCurrentSessionGuid());
    }

    public void logEvent(String str, Bundle bundle) {
        logEvent(str, null, bundle, false, ActivityLifecycleTracker.getCurrentSessionGuid());
    }

    public void logPurchase(BigDecimal bigDecimal, Currency currency) {
        logPurchase(bigDecimal, currency, null);
    }

    public void logPurchase(BigDecimal bigDecimal, Currency currency, Bundle bundle) {
        if (bigDecimal == null) {
            notifyDeveloperError("purchaseAmount cannot be null");
        } else if (currency == null) {
            notifyDeveloperError("currency cannot be null");
        } else {
            if (bundle == null) {
                bundle = new Bundle();
            }
            bundle.putString(AppEventsConstants.EVENT_PARAM_CURRENCY, currency.getCurrencyCode());
            logEvent(AppEventsConstants.EVENT_NAME_PURCHASED, bigDecimal.doubleValue(), bundle);
            eagerFlush();
        }
    }

    public void logPushNotificationOpen(Bundle bundle) {
        logPushNotificationOpen(bundle, null);
    }

    public void logPushNotificationOpen(Bundle bundle, String str) {
        String str2 = null;
        try {
            String string = bundle.getString(PUSH_PAYLOAD_KEY);
            if (!Utility.isNullOrEmpty(string)) {
                str2 = new JSONObject(string).getString(PUSH_PAYLOAD_CAMPAIGN_KEY);
                if (str2 == null) {
                    Logger.log(LoggingBehavior.DEVELOPER_ERRORS, TAG, "Malformed payload specified for logging a push notification open.");
                    return;
                }
                Bundle bundle2 = new Bundle();
                bundle2.putString(APP_EVENT_PUSH_PARAMETER_CAMPAIGN, str2);
                if (str != null) {
                    bundle2.putString(APP_EVENT_PUSH_PARAMETER_ACTION, str);
                }
                logEvent(APP_EVENT_NAME_PUSH_OPENED, bundle2);
            }
        } catch (JSONException e) {
        }
    }

    public void logSdkEvent(String str, Double d, Bundle bundle) {
        logEvent(str, d, bundle, true, ActivityLifecycleTracker.getCurrentSessionGuid());
    }
}
