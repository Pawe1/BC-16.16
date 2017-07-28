package com.adobe.air;

import android.app.IntentService;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v4.app.NotificationCompat.Builder;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class AndroidGcmIntentService extends IntentService {
    private static final String CLOUDFRONT = "cloudfront";
    private static final String GAMESPACE = "gamespace";
    private static final String GAME_URL = "gameUrl";
    private static final String MSG_ID = "msgId";
    private static final String PROPERTY_NOTIFICATION_TIMESTAMP = "notficationTimestamp";
    private static final String TAG = "AndroidGcmIntentService";
    private static int sUniqueId = 0;
    private String mGameDesc = null;
    private String mGameIconUrl = null;
    private String mGameTitle = null;
    private String mGameUrl = null;
    private String mGameUrlPrefix = null;
    private String mHost = null;
    private String mMsgId = null;

    public AndroidGcmIntentService() {
        super(TAG);
    }

    protected void onHandleIntent(Intent intent) {
        String str = "";
        Bundle extras = intent.getExtras();
        if (extras != null && extras.containsKey("message")) {
            str = extras.getString("message");
        }
        if (!str.isEmpty()) {
            if ("gcm".equals(GoogleCloudMessaging.getInstance(this).getMessageType(intent))) {
                handleNotification(str);
            }
        }
        AndroidGcmBroadcastReceiver.completeWakefulIntent(intent);
    }

    private void handleNotification(String str) {
        if (isNotificationValid()) {
            try {
                JSONObject jSONObject = new JSONObject(str);
                this.mGameTitle = jSONObject.getString("gameTitle");
                this.mGameDesc = jSONObject.getString("gameDesc");
                this.mGameIconUrl = jSONObject.getString("gameIconUrl");
                this.mGameUrl = jSONObject.getString(GAME_URL);
                this.mGameUrlPrefix = jSONObject.getString("gameUrlPrefix");
                this.mMsgId = jSONObject.getString(MSG_ID);
                if (this.mGameTitle != null && this.mGameDesc != null && this.mGameIconUrl != null && this.mGameUrl != null && this.mGameUrlPrefix != null && this.mMsgId != null) {
                    if (this.mGameUrlPrefix.equals(GAMESPACE)) {
                        this.mHost = "http://gamespace.adobe.com";
                    } else if (this.mGameUrlPrefix.equals(CLOUDFRONT)) {
                        this.mHost = "https://dh8vjmvwgc27o.cloudfront.net";
                    }
                    this.mGameUrl = this.mHost + "/" + this.mGameUrl;
                    this.mGameIconUrl = this.mHost + "/" + this.mGameIconUrl;
                    sendNotification();
                }
            } catch (Exception e) {
            }
        }
    }

    private void sendNotification() {
        Intent intent = new Intent(this, AdobeAIRMainActivity.class);
        intent.putExtra(GAME_URL, this.mGameUrl);
        intent.putExtra(MSG_ID, this.mMsgId);
        intent.setFlags(603979776);
        int i = sUniqueId + 1;
        sUniqueId = i;
        PendingIntent activity = PendingIntent.getActivity(this, i, intent, 1073741824);
        Builder builder = new Builder(this);
        builder.setSmallIcon(2130837795);
        builder.setContentTitle(this.mGameTitle);
        builder.setContentText(this.mGameDesc);
        builder.setContentIntent(activity);
        builder.setAutoCancel(true);
        Bitmap bitmapFromURL = getBitmapFromURL(this.mGameIconUrl);
        if (bitmapFromURL != null) {
            builder.setLargeIcon(bitmapFromURL);
        }
        ((NotificationManager) getSystemService("notification")).notify(sUniqueId, builder.build());
    }

    private boolean isNotificationValid() {
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        long j = defaultSharedPreferences.getLong(PROPERTY_NOTIFICATION_TIMESTAMP, Long.MIN_VALUE);
        long currentTimeMillis = System.currentTimeMillis();
        if (j != Long.MIN_VALUE && currentTimeMillis - j <= AdobeAIRMainActivity.RATE_LIMIT) {
            return false;
        }
        Editor edit = defaultSharedPreferences.edit();
        edit.putLong(PROPERTY_NOTIFICATION_TIMESTAMP, currentTimeMillis);
        edit.commit();
        return true;
    }

    private Bitmap getBitmapFromURL(String str) {
        try {
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(str).openConnection();
            httpURLConnection.setDoInput(true);
            httpURLConnection.connect();
            return BitmapFactory.decodeStream(httpURLConnection.getInputStream());
        } catch (Exception e) {
            return null;
        }
    }
}
