package com.adobe.air;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.provider.Settings.Secure;
import com.adobe.air.AndroidGcmResultReceiver.Receiver;
import com.adobe.air.utils.Utils;
import com.adobe.app.AppManager;
import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.HitBuilders.AppViewBuilder;
import com.google.android.gms.analytics.Tracker;
import com.google.android.gms.common.GooglePlayServicesUtil;
import java.io.InputStream;
import java.util.Date;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Random;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

public class AdobeAIRMainActivity extends Activity implements Receiver {
    private static final String AIR_PROPERTIES_URL = "airPropertiesUrl";
    public static final String ENABLE_MY_GAMES = "EnableMyGames";
    private static final String MSG_ID = "msgId";
    private static final String NEW_UI_ANALYTICS_URL = "http://www.adobe.com/airgames/3/";
    private static final String NOTIFICATION_ANALYTICS_URL = "https://www.adobe.com/gamepreview/?game=notification/notificationClicked.html_";
    private static final int PLAY_SERVICES_RESOLUTION_REQUEST = 9000;
    public static final String PROPERTY_DEFAULT_ACTIVITY = "AIRDefaultActivity";
    private static final String PROPERTY_ENABLE_MY_GAMES_PERCENTAGE = "MyGamesPercentage";
    private static final String PROPERTY_FIRST_LAUNCH = "firstLaunch";
    private static final String PROPERTY_ID = "UA-54849355-1";
    private static final String PROPERTY_NEW_UI_PERCENTAGE = "NewUIPercentage";
    private static final String PROPERTY_RANDOM_NO = "AirRandomNumber";
    public static long RATE_LIMIT = 86400000;
    public static final String RESULT_RECEIVER = "resultReceiver";
    private static final String TAG = "AdobeAIRMainActivity";
    private String mAirPropsFileUrl = "http://s3-us-west-1.amazonaws.com/gamepreview/prod/airandroid/air.properties";
    private AdobeAIRWebView mAnalyticsWebView = null;
    private Context mCtx = null;
    private int mEnableMyGamesThreshold = 100;
    private boolean mIsGameListDefaultActivity = true;
    private boolean mIsNewUISupported = false;
    private int mNewUIThreshold = 100;
    private AdobeAIRWebView mNotificationWebView = null;
    private int mRandomNumber;
    private AndroidGcmResultReceiver mReceiver = null;
    private Tracker mTracker = null;

    class C01001 implements Runnable {
        C01001() {
        }

        public void run() {
            try {
                InputStream content = new DefaultHttpClient().execute(new HttpGet(AdobeAIRMainActivity.this.mAirPropsFileUrl)).getEntity().getContent();
                Properties properties = new Properties();
                properties.load(content);
                if (properties != null) {
                    String property = properties.getProperty(AdobeAIRMainActivity.PROPERTY_NEW_UI_PERCENTAGE);
                    if (property != null) {
                        try {
                            AdobeAIRMainActivity.this.mNewUIThreshold = Integer.parseInt(property);
                            AdobeAIRMainActivity.this.mIsGameListDefaultActivity = AdobeAIRMainActivity.this.mRandomNumber > AdobeAIRMainActivity.this.mNewUIThreshold;
                        } catch (Exception e) {
                        }
                    }
                    try {
                        property = properties.getProperty(AdobeAIRMainActivity.PROPERTY_ENABLE_MY_GAMES_PERCENTAGE);
                        if (property != null) {
                            AdobeAIRMainActivity.this.mEnableMyGamesThreshold = Integer.parseInt(property);
                        }
                    } catch (Exception e2) {
                    }
                    AdobeAIRMainActivity.this.updateSharedPrefForDefaultActivity();
                }
            } catch (Exception e3) {
            }
        }
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.mCtx = this;
        copyActivityLevelPrefsToApplicationLevel();
        verifyNewUISupport();
        if (isFirstLaunch()) {
            updateSharedPrefForInitialLaunch();
            decideDefaultActivity();
            updateSharedPrefForDefaultActivity();
        } else {
            SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this.mCtx);
            this.mIsGameListDefaultActivity = defaultSharedPreferences.getBoolean(PROPERTY_DEFAULT_ACTIVITY, true);
            if (isWidgetShown()) {
                this.mRandomNumber = 0;
                this.mIsGameListDefaultActivity = false;
                Editor edit = defaultSharedPreferences.edit();
                edit.putBoolean(PROPERTY_DEFAULT_ACTIVITY, this.mIsGameListDefaultActivity);
                edit.commit();
            } else {
                this.mRandomNumber = defaultSharedPreferences.getInt(PROPERTY_RANDOM_NO, 100);
            }
            this.mNewUIThreshold = defaultSharedPreferences.getInt(PROPERTY_NEW_UI_PERCENTAGE, this.mNewUIThreshold);
            this.mEnableMyGamesThreshold = defaultSharedPreferences.getInt(PROPERTY_ENABLE_MY_GAMES_PERCENTAGE, this.mEnableMyGamesThreshold);
        }
        Tracker tracker = getTracker();
        tracker.setScreenName(TAG);
        tracker.send(new AppViewBuilder().build());
        startService(new Intent(this, ShakeListenerService.class));
        startActivity(new Intent(this, StaticPageActivity.class));
    }

    private void copyActivityLevelPrefsToApplicationLevel() {
        Editor edit = PreferenceManager.getDefaultSharedPreferences(this.mCtx).edit();
        SharedPreferences sharedPreferences = getSharedPreferences(AdobeAIR.class.getSimpleName(), 0);
        for (Entry entry : sharedPreferences.getAll().entrySet()) {
            Object value = entry.getValue();
            if (value instanceof String) {
                edit.putString((String) entry.getKey(), value.toString());
            } else if (value instanceof Long) {
                edit.putLong((String) entry.getKey(), ((Long) value).longValue());
            } else if (value instanceof Integer) {
                edit.putInt((String) entry.getKey(), ((Integer) value).intValue());
            } else if (value instanceof Boolean) {
                edit.putBoolean((String) entry.getKey(), ((Boolean) value).booleanValue());
            }
        }
        edit.commit();
        Editor edit2 = sharedPreferences.edit();
        edit2.clear();
        edit2.commit();
    }

    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Bundle extras = intent.getExtras();
        if (extras == null || !extras.containsKey("gameUrl")) {
            launchDefaultActivity();
        } else {
            String string = extras.getString("gameUrl");
            this.mNotificationWebView = new AdobeAIRWebView(this.mCtx);
            this.mNotificationWebView.create();
            this.mNotificationWebView.loadUrl(string);
            if (extras.containsKey(MSG_ID)) {
                this.mNotificationWebView.loadAnalyticsUrl(NOTIFICATION_ANALYTICS_URL + extras.getString(MSG_ID));
            }
        }
        decideDefaultActivityForNextLaunch();
    }

    public void onBackPressed() {
        launchDefaultActivity();
    }

    private void launchDefaultActivity() {
        boolean z = false;
        Intent intent = new Intent();
        if (this.mIsGameListDefaultActivity) {
            intent.setClassName(this, "com.adobe.air.AdobeAIR");
        } else {
            intent.setClassName(this, "com.adobe.mobile_playpanel.LeadingPageActivity");
            if (AppManager.doesDeviceHaveExcessiveApps(this)) {
                intent.putExtra(ENABLE_MY_GAMES, false);
            } else {
                String str = ENABLE_MY_GAMES;
                if (this.mRandomNumber <= this.mEnableMyGamesThreshold) {
                    z = true;
                }
                intent.putExtra(str, z);
            }
            this.mAnalyticsWebView = new AdobeAIRWebView(this.mCtx);
            this.mAnalyticsWebView.createAnalyticsWebView();
            this.mAnalyticsWebView.loadAnalyticsUrl(NEW_UI_ANALYTICS_URL);
        }
        startActivity(intent);
    }

    private boolean isFirstLaunch() {
        return PreferenceManager.getDefaultSharedPreferences(this.mCtx).getBoolean(PROPERTY_FIRST_LAUNCH, true);
    }

    private void updateSharedPrefForInitialLaunch() {
        Editor edit = PreferenceManager.getDefaultSharedPreferences(this.mCtx).edit();
        edit.putBoolean(PROPERTY_FIRST_LAUNCH, false);
        edit.commit();
    }

    private void updateSharedPrefForDefaultActivity() {
        Editor edit = PreferenceManager.getDefaultSharedPreferences(this.mCtx).edit();
        edit.putBoolean(PROPERTY_DEFAULT_ACTIVITY, this.mIsGameListDefaultActivity);
        if (this.mIsNewUISupported) {
            edit.putInt(PROPERTY_RANDOM_NO, this.mRandomNumber);
            edit.putInt(PROPERTY_NEW_UI_PERCENTAGE, this.mNewUIThreshold);
            if (AppManager.doesDeviceHaveExcessiveApps(this)) {
                edit.putInt(PROPERTY_ENABLE_MY_GAMES_PERCENTAGE, 0);
            } else {
                edit.putInt(PROPERTY_ENABLE_MY_GAMES_PERCENTAGE, this.mEnableMyGamesThreshold);
            }
        }
        edit.commit();
    }

    private void decideDefaultActivity() {
        boolean z = false;
        if (this.mIsNewUISupported) {
            try {
                if (isWidgetShown()) {
                    this.mRandomNumber = 0;
                } else {
                    this.mRandomNumber = generateRandomNumber();
                }
            } catch (NumberFormatException e) {
                this.mRandomNumber = 100;
            }
            if (this.mRandomNumber > this.mNewUIThreshold) {
                z = true;
            }
            this.mIsGameListDefaultActivity = z;
            return;
        }
        this.mIsGameListDefaultActivity = true;
    }

    private void verifyNewUISupport() {
        if (VERSION.SDK_INT >= 10) {
            this.mIsNewUISupported = true;
        }
    }

    private int generateRandomNumber() throws NumberFormatException {
        Random random;
        String string = Secure.getString(getApplicationContext().getContentResolver(), "android_id");
        if (string == null) {
            random = new Random();
        } else {
            long hashCode = (long) string.hashCode();
            random = new Random(new Date().getTime() + hashCode);
        }
        return random.nextInt(100);
    }

    private void decideDefaultActivityForNextLaunch() {
        if (this.mIsNewUISupported && Utils.isNetworkAvailable(getApplicationContext())) {
            configureTestEnv();
            new Thread(new C01001()).start();
        }
    }

    private void registerForNotifications() {
        this.mReceiver = new AndroidGcmResultReceiver(new Handler());
        this.mReceiver.setReceiver(this);
        Intent intent = new Intent(this.mCtx, AndroidGcmRegistrationService.class);
        intent.putExtra(RESULT_RECEIVER, this.mReceiver);
        this.mCtx.startService(intent);
    }

    public void onReceiveResult(int i, Bundle bundle) {
        GooglePlayServicesUtil.getErrorDialog(i, (Activity) this.mCtx, PLAY_SERVICES_RESOLUTION_REQUEST).show();
    }

    private void configureTestEnv() {
        try {
            Bundle bundle = getPackageManager().getActivityInfo(getComponentName(), 128).metaData;
            if (bundle != null) {
                String string = bundle.getString(AIR_PROPERTIES_URL);
                if (string != null && !string.isEmpty()) {
                    this.mAirPropsFileUrl = string;
                }
            }
        } catch (NameNotFoundException e) {
        } catch (NullPointerException e2) {
        }
    }

    private boolean isWidgetShown() {
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        if (defaultSharedPreferences.getBoolean("widgetShown", false) || defaultSharedPreferences.getBoolean("featuredWidgetShown", false)) {
            return true;
        }
        return false;
    }

    private synchronized Tracker getTracker() {
        if (this.mTracker == null) {
            GoogleAnalytics instance = GoogleAnalytics.getInstance(this);
            instance.enableAutoActivityReports(getApplication());
            this.mTracker = instance.newTracker(PROPERTY_ID);
        }
        return this.mTracker;
    }

    protected void onStart() {
        super.onStart();
        GoogleAnalytics.getInstance(this).reportActivityStart(this);
    }

    protected void onStop() {
        super.onStop();
        GoogleAnalytics.getInstance(this).reportActivityStop(this);
    }
}
