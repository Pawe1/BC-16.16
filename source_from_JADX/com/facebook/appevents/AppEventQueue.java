package com.facebook.appevents;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import com.facebook.FacebookRequestError;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;
import com.facebook.LoggingBehavior;
import com.facebook.appevents.AppEventsLogger.FlushBehavior;
import com.facebook.internal.FetchedAppSettings;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.Logger;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import org.json.JSONArray;
import org.json.JSONException;
import p000c.p001m.p002x.p003a.gv.ax;

class AppEventQueue {
    private static final int FLUSH_PERIOD_IN_SECONDS = 15;
    private static final int NUM_LOG_EVENTS_TO_TRY_TO_FLUSH_AFTER = 100;
    private static final String TAG = AppEventQueue.class.getName();
    private static volatile AppEventCollection appEventCollection = new AppEventCollection();
    private static final Runnable flushRunnable = new C02021();
    private static ScheduledFuture scheduledFuture;
    private static final ScheduledExecutorService singleThreadExecutor = Executors.newSingleThreadScheduledExecutor();

    final class C02021 implements Runnable {
        C02021() {
        }

        public final void run() {
            AppEventQueue.scheduledFuture = null;
            if (AppEventsLogger.getFlushBehavior() != FlushBehavior.EXPLICIT_ONLY) {
                AppEventQueue.flushAndWait(FlushReason.TIMER);
            }
        }
    }

    final class C02032 implements Runnable {
        C02032() {
        }

        public final void run() {
            AppEventStore.persistEvents(AppEventQueue.appEventCollection);
            AppEventQueue.appEventCollection = new AppEventCollection();
        }
    }

    final class C02043 implements Runnable {
        final /* synthetic */ FlushReason val$reason;

        C02043(FlushReason flushReason) {
            this.val$reason = flushReason;
        }

        public final void run() {
            AppEventQueue.flushAndWait(this.val$reason);
        }
    }

    final class C02054 implements Runnable {
        final /* synthetic */ AccessTokenAppIdPair val$accessTokenAppId;
        final /* synthetic */ AppEvent val$appEvent;

        C02054(AccessTokenAppIdPair accessTokenAppIdPair, AppEvent appEvent) {
            this.val$accessTokenAppId = accessTokenAppIdPair;
            this.val$appEvent = appEvent;
        }

        public final void run() {
            AppEventQueue.appEventCollection.addEvent(this.val$accessTokenAppId, this.val$appEvent);
            if (AppEventsLogger.getFlushBehavior() != FlushBehavior.EXPLICIT_ONLY && AppEventQueue.appEventCollection.getEventCount() > 100) {
                AppEventQueue.flushAndWait(FlushReason.EVENT_THRESHOLD);
            } else if (AppEventQueue.scheduledFuture == null) {
                AppEventQueue.scheduledFuture = AppEventQueue.singleThreadExecutor.schedule(AppEventQueue.flushRunnable, 15, TimeUnit.SECONDS);
            }
        }
    }

    final class C02065 implements Callback {
        final /* synthetic */ AccessTokenAppIdPair val$accessTokenAppId;
        final /* synthetic */ SessionEventsState val$appEvents;
        final /* synthetic */ FlushStatistics val$flushState;
        final /* synthetic */ GraphRequest val$postRequest;

        C02065(AccessTokenAppIdPair accessTokenAppIdPair, GraphRequest graphRequest, SessionEventsState sessionEventsState, FlushStatistics flushStatistics) {
            this.val$accessTokenAppId = accessTokenAppIdPair;
            this.val$postRequest = graphRequest;
            this.val$appEvents = sessionEventsState;
            this.val$flushState = flushStatistics;
        }

        public final void onCompleted(GraphResponse graphResponse) {
            AppEventQueue.handleResponse(this.val$accessTokenAppId, this.val$postRequest, graphResponse, this.val$appEvents, this.val$flushState);
        }
    }

    final class C02076 implements Runnable {
        final /* synthetic */ AccessTokenAppIdPair val$accessTokenAppId;
        final /* synthetic */ SessionEventsState val$appEvents;

        C02076(AccessTokenAppIdPair accessTokenAppIdPair, SessionEventsState sessionEventsState) {
            this.val$accessTokenAppId = accessTokenAppIdPair;
            this.val$appEvents = sessionEventsState;
        }

        public final void run() {
            AppEventStore.persistEvents(this.val$accessTokenAppId, this.val$appEvents);
        }
    }

    AppEventQueue() {
    }

    public static void add(AccessTokenAppIdPair accessTokenAppIdPair, AppEvent appEvent) {
        singleThreadExecutor.execute(new C02054(accessTokenAppIdPair, appEvent));
    }

    private static GraphRequest buildRequestForSession(AccessTokenAppIdPair accessTokenAppIdPair, SessionEventsState sessionEventsState, boolean z, FlushStatistics flushStatistics) {
        FetchedAppSettings queryAppSettings = FetchedAppSettingsManager.queryAppSettings(accessTokenAppIdPair.getApplicationId(), false);
        GraphRequest newPostRequest = GraphRequest.newPostRequest(null, String.format("%s/activities", new Object[]{r0}), null, null);
        Bundle parameters = newPostRequest.getParameters();
        if (parameters == null) {
            parameters = new Bundle();
        }
        parameters.putString("access_token", accessTokenAppIdPair.getAccessTokenString());
        String pushNotificationsRegistrationId = AppEventsLogger.getPushNotificationsRegistrationId();
        if (pushNotificationsRegistrationId != null) {
            parameters.putString("device_token", pushNotificationsRegistrationId);
        }
        newPostRequest.setParameters(parameters);
        int populateRequest = sessionEventsState.populateRequest(newPostRequest, FacebookSdk.getApplicationContext(), queryAppSettings != null ? queryAppSettings.supportsImplicitLogging() : false, z);
        if (populateRequest == 0) {
            return null;
        }
        flushStatistics.numEvents = populateRequest + flushStatistics.numEvents;
        newPostRequest.setCallback(new C02065(accessTokenAppIdPair, newPostRequest, sessionEventsState, flushStatistics));
        return newPostRequest;
    }

    public static void flush(FlushReason flushReason) {
        singleThreadExecutor.execute(new C02043(flushReason));
    }

    static void flushAndWait(FlushReason flushReason) {
        appEventCollection.addPersistedEvents(AppEventStore.readAndClearStore());
        try {
            FlushStatistics sendEventsToServer = sendEventsToServer(flushReason, appEventCollection);
            if (sendEventsToServer != null) {
                Intent intent = new Intent(AppEventsLogger.ACTION_APP_EVENTS_FLUSHED);
                intent.putExtra(AppEventsLogger.APP_EVENTS_EXTRA_NUM_EVENTS_FLUSHED, sendEventsToServer.numEvents);
                intent.putExtra(AppEventsLogger.APP_EVENTS_EXTRA_FLUSH_RESULT, sendEventsToServer.result);
                ax.m123a(FacebookSdk.getApplicationContext()).m127a(intent);
            }
        } catch (Throwable e) {
            Log.w(TAG, "Caught unexpected exception while flushing app events: ", e);
        }
    }

    public static Set<AccessTokenAppIdPair> getKeySet() {
        return appEventCollection.keySet();
    }

    private static void handleResponse(AccessTokenAppIdPair accessTokenAppIdPair, GraphRequest graphRequest, GraphResponse graphResponse, SessionEventsState sessionEventsState, FlushStatistics flushStatistics) {
        FlushResult flushResult;
        FacebookRequestError error = graphResponse.getError();
        String str = "Success";
        FlushResult flushResult2 = FlushResult.SUCCESS;
        String str2;
        if (error == null) {
            str2 = str;
            flushResult = flushResult2;
        } else if (error.getErrorCode() == -1) {
            Object obj = "Failed: No Connectivity";
            flushResult = FlushResult.NO_CONNECTIVITY;
        } else {
            str2 = String.format("Failed:\n  Response: %s\n  Error %s", new Object[]{graphResponse.toString(), error.toString()});
            flushResult = FlushResult.SERVER_ERROR;
        }
        if (FacebookSdk.isLoggingBehaviorEnabled(LoggingBehavior.APP_EVENTS)) {
            String jSONArray;
            try {
                jSONArray = new JSONArray((String) graphRequest.getTag()).toString(2);
            } catch (JSONException e) {
                jSONArray = "<Can't encode events for debug logging>";
            }
            Logger.log(LoggingBehavior.APP_EVENTS, TAG, "Flush completed\nParams: %s\n  Result: %s\n  Events JSON: %s", graphRequest.getGraphObject().toString(), obj, jSONArray);
        }
        sessionEventsState.clearInFlightAndStats(error != null);
        if (flushResult == FlushResult.NO_CONNECTIVITY) {
            FacebookSdk.getExecutor().execute(new C02076(accessTokenAppIdPair, sessionEventsState));
        }
        if (flushResult != FlushResult.SUCCESS && flushStatistics.result != FlushResult.NO_CONNECTIVITY) {
            flushStatistics.result = flushResult;
        }
    }

    public static void persistToDisk() {
        singleThreadExecutor.execute(new C02032());
    }

    private static FlushStatistics sendEventsToServer(FlushReason flushReason, AppEventCollection appEventCollection) {
        FlushStatistics flushStatistics = new FlushStatistics();
        boolean limitEventAndDataUsage = FacebookSdk.getLimitEventAndDataUsage(FacebookSdk.getApplicationContext());
        List<GraphRequest> arrayList = new ArrayList();
        for (AccessTokenAppIdPair accessTokenAppIdPair : appEventCollection.keySet()) {
            GraphRequest buildRequestForSession = buildRequestForSession(accessTokenAppIdPair, appEventCollection.get(accessTokenAppIdPair), limitEventAndDataUsage, flushStatistics);
            if (buildRequestForSession != null) {
                arrayList.add(buildRequestForSession);
            }
        }
        if (arrayList.size() <= 0) {
            return null;
        }
        Logger.log(LoggingBehavior.APP_EVENTS, TAG, "Flushing %d events due to %s.", Integer.valueOf(flushStatistics.numEvents), flushReason.toString());
        for (GraphRequest buildRequestForSession2 : arrayList) {
            buildRequestForSession2.executeAndWait();
        }
        return flushStatistics;
    }
}
