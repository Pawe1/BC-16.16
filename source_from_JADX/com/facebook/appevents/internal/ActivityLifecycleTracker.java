package com.facebook.appevents.internal;

import android.app.Activity;
import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.appevents.internal.SourceApplicationInfo.Factory;
import com.facebook.internal.FetchedAppSettings;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.Utility;
import de.pagecon.ane.nfc.BaseConfig;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class ActivityLifecycleTracker {
    private static final String INCORRECT_IMPL_WARNING = "Unexpected activity pause without a matching activity resume. Logging data may be incorrect. Make sure you call activateApp from your Application's onCreate method";
    private static final long INTERRUPTION_THRESHOLD_MILLISECONDS = 1000;
    private static final String TAG = ActivityLifecycleTracker.class.getCanonicalName();
    private static String appId;
    private static long currentActivityAppearTime;
    private static volatile ScheduledFuture currentFuture;
    private static volatile SessionInfo currentSession;
    private static AtomicInteger foregroundActivityCount = new AtomicInteger(0);
    private static final ScheduledExecutorService singleThreadExecutor = Executors.newSingleThreadScheduledExecutor();
    private static AtomicBoolean tracking = new AtomicBoolean(false);

    final class C02151 implements ActivityLifecycleCallbacks {
        C02151() {
        }

        public final void onActivityCreated(Activity activity, Bundle bundle) {
            AppEventUtility.assertIsMainThread();
            ActivityLifecycleTracker.onActivityCreated(activity);
        }

        public final void onActivityDestroyed(Activity activity) {
        }

        public final void onActivityPaused(Activity activity) {
            AppEventUtility.assertIsMainThread();
            ActivityLifecycleTracker.onActivityPaused(activity);
        }

        public final void onActivityResumed(Activity activity) {
            AppEventUtility.assertIsMainThread();
            ActivityLifecycleTracker.onActivityResumed(activity);
        }

        public final void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        }

        public final void onActivityStarted(Activity activity) {
        }

        public final void onActivityStopped(Activity activity) {
            AppEventsLogger.onContextStop();
        }
    }

    final class C02162 implements Runnable {
        final /* synthetic */ String val$activityName;
        final /* synthetic */ Context val$applicationContext;
        final /* synthetic */ long val$currentTime;
        final /* synthetic */ SourceApplicationInfo val$sourceApplicationInfo;

        C02162(Context context, String str, long j, SourceApplicationInfo sourceApplicationInfo) {
            this.val$applicationContext = context;
            this.val$activityName = str;
            this.val$currentTime = j;
            this.val$sourceApplicationInfo = sourceApplicationInfo;
        }

        public final void run() {
            if (ActivityLifecycleTracker.currentSession == null) {
                SessionInfo storedSessionInfo = SessionInfo.getStoredSessionInfo();
                if (storedSessionInfo != null) {
                    SessionLogger.logDeactivateApp(this.val$applicationContext, this.val$activityName, storedSessionInfo, ActivityLifecycleTracker.appId);
                }
                ActivityLifecycleTracker.currentSession = new SessionInfo(Long.valueOf(this.val$currentTime), null);
                ActivityLifecycleTracker.currentSession.setSourceApplicationInfo(this.val$sourceApplicationInfo);
                SessionLogger.logActivateApp(this.val$applicationContext, this.val$activityName, this.val$sourceApplicationInfo, ActivityLifecycleTracker.appId);
            }
        }
    }

    final class C02173 implements Runnable {
        final /* synthetic */ String val$activityName;
        final /* synthetic */ Context val$applicationContext;
        final /* synthetic */ long val$currentTime;

        C02173(long j, Context context, String str) {
            this.val$currentTime = j;
            this.val$applicationContext = context;
            this.val$activityName = str;
        }

        public final void run() {
            if (ActivityLifecycleTracker.currentSession == null) {
                ActivityLifecycleTracker.currentSession = new SessionInfo(Long.valueOf(this.val$currentTime), null);
                SessionLogger.logActivateApp(this.val$applicationContext, this.val$activityName, null, ActivityLifecycleTracker.appId);
            } else if (ActivityLifecycleTracker.currentSession.getSessionLastEventTime() != null) {
                long longValue = this.val$currentTime - ActivityLifecycleTracker.currentSession.getSessionLastEventTime().longValue();
                if (longValue > ((long) (ActivityLifecycleTracker.getSessionTimeoutInSeconds() * BaseConfig.READ_SETTING_DATA_DELAY_TIMEOUT))) {
                    SessionLogger.logDeactivateApp(this.val$applicationContext, this.val$activityName, ActivityLifecycleTracker.currentSession, ActivityLifecycleTracker.appId);
                    SessionLogger.logActivateApp(this.val$applicationContext, this.val$activityName, null, ActivityLifecycleTracker.appId);
                    ActivityLifecycleTracker.currentSession = new SessionInfo(Long.valueOf(this.val$currentTime), null);
                } else if (longValue > ActivityLifecycleTracker.INTERRUPTION_THRESHOLD_MILLISECONDS) {
                    ActivityLifecycleTracker.currentSession.incrementInterruptionCount();
                }
            }
            ActivityLifecycleTracker.currentSession.setSessionLastEventTime(Long.valueOf(this.val$currentTime));
            ActivityLifecycleTracker.currentSession.writeSessionToDisk();
        }
    }

    final class C02194 implements Runnable {
        final /* synthetic */ String val$activityName;
        final /* synthetic */ Context val$applicationContext;
        final /* synthetic */ long val$currentTime;

        class C02181 implements Runnable {
            C02181() {
            }

            public void run() {
                if (ActivityLifecycleTracker.foregroundActivityCount.get() <= 0) {
                    SessionLogger.logDeactivateApp(C02194.this.val$applicationContext, C02194.this.val$activityName, ActivityLifecycleTracker.currentSession, ActivityLifecycleTracker.appId);
                    SessionInfo.clearSavedSessionFromDisk();
                    ActivityLifecycleTracker.currentSession = null;
                }
                ActivityLifecycleTracker.currentFuture = null;
            }
        }

        C02194(long j, Context context, String str) {
            this.val$currentTime = j;
            this.val$applicationContext = context;
            this.val$activityName = str;
        }

        public final void run() {
            long j = 0;
            if (ActivityLifecycleTracker.currentSession == null) {
                ActivityLifecycleTracker.currentSession = new SessionInfo(Long.valueOf(this.val$currentTime), null);
            }
            ActivityLifecycleTracker.currentSession.setSessionLastEventTime(Long.valueOf(this.val$currentTime));
            if (ActivityLifecycleTracker.foregroundActivityCount.get() <= 0) {
                ActivityLifecycleTracker.currentFuture = ActivityLifecycleTracker.singleThreadExecutor.schedule(new C02181(), (long) ActivityLifecycleTracker.getSessionTimeoutInSeconds(), TimeUnit.SECONDS);
            }
            long access$700 = ActivityLifecycleTracker.currentActivityAppearTime;
            if (access$700 > 0) {
                j = (this.val$currentTime - access$700) / ActivityLifecycleTracker.INTERRUPTION_THRESHOLD_MILLISECONDS;
            }
            AutomaticAnalyticsLogger.logActivityTimeSpentEvent(this.val$activityName, j);
            ActivityLifecycleTracker.currentSession.writeSessionToDisk();
        }
    }

    private static void cancelCurrentTask() {
        if (currentFuture != null) {
            currentFuture.cancel(false);
        }
        currentFuture = null;
    }

    public static UUID getCurrentSessionGuid() {
        return currentSession != null ? currentSession.getSessionId() : null;
    }

    private static int getSessionTimeoutInSeconds() {
        FetchedAppSettings appSettingsWithoutQuery = FetchedAppSettingsManager.getAppSettingsWithoutQuery(FacebookSdk.getApplicationId());
        return appSettingsWithoutQuery == null ? Constants.getDefaultAppEventsSessionTimeoutInSeconds() : appSettingsWithoutQuery.getSessionTimeoutInSeconds();
    }

    public static boolean isTracking() {
        return tracking.get();
    }

    public static void onActivityCreated(Activity activity) {
        singleThreadExecutor.execute(new C02162(activity.getApplicationContext(), Utility.getActivityName(activity), System.currentTimeMillis(), Factory.create(activity)));
    }

    private static void onActivityPaused(Activity activity) {
        if (foregroundActivityCount.decrementAndGet() < 0) {
            foregroundActivityCount.set(0);
            Log.w(TAG, INCORRECT_IMPL_WARNING);
        }
        cancelCurrentTask();
        singleThreadExecutor.execute(new C02194(System.currentTimeMillis(), activity.getApplicationContext(), Utility.getActivityName(activity)));
    }

    public static void onActivityResumed(Activity activity) {
        foregroundActivityCount.incrementAndGet();
        cancelCurrentTask();
        long currentTimeMillis = System.currentTimeMillis();
        currentActivityAppearTime = currentTimeMillis;
        singleThreadExecutor.execute(new C02173(currentTimeMillis, activity.getApplicationContext(), Utility.getActivityName(activity)));
    }

    public static void startTracking(Application application, String str) {
        if (tracking.compareAndSet(false, true)) {
            appId = str;
            application.registerActivityLifecycleCallbacks(new C02151());
        }
    }
}
