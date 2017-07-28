package com.adobe.air;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.os.SystemClock;
import com.adobe.air.AndroidActivityWrapper.ActivityState;

class ConfigDownloadListener {
    private static String LOG_TAG = "ConfigDownloadListener";
    private static ConfigDownloadListener sListener = null;
    private long lastPauseTime = SystemClock.uptimeMillis();
    private StateChangeCallback mActivityStateCB = new C01212();
    private BroadcastReceiver mDownloadConfigRecv = new C01201();

    class C01201 extends BroadcastReceiver {
        private String LOG_TAG = "ConfigDownloadListenerBR";

        C01201() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onReceive(android.content.Context r7, android.content.Intent r8) {
            /*
            r6 = this;
            r0 = 1;
            r1 = r8.getAction();
            r2 = "com.adobe.air.DownloadConfigComplete";
            r1 = r1.equals(r2);
            if (r1 == 0) goto L_0x0035;
        L_0x000d:
            r1 = 0;
            r2 = r6.isInitialStickyBroadcast();
            if (r2 == 0) goto L_0x002a;
        L_0x0014:
            r2 = r8.getExtras();
            if (r2 == 0) goto L_0x0036;
        L_0x001a:
            r3 = "com.adobe.air.DownloadConfigCompleteTime";
            r2 = r2.getLong(r3);
            r4 = com.adobe.air.ConfigDownloadListener.this;
            r4 = r4.lastPauseTime;
            r2 = (r4 > r2 ? 1 : (r4 == r2 ? 0 : -1));
            if (r2 >= 0) goto L_0x0036;
        L_0x002a:
            if (r0 == 0) goto L_0x0035;
        L_0x002c:
            r0 = com.adobe.air.AndroidActivityWrapper.GetAndroidActivityWrapper();
            if (r0 == 0) goto L_0x0035;
        L_0x0032:
            r0.applyDownloadedConfig();
        L_0x0035:
            return;
        L_0x0036:
            r0 = r1;
            goto L_0x002a;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.ConfigDownloadListener.1.onReceive(android.content.Context, android.content.Intent):void");
        }
    }

    class C01212 implements StateChangeCallback {
        C01212() {
        }

        public void onActivityStateChanged(ActivityState activityState) {
            Activity activity = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity();
            if (activityState == ActivityState.PAUSED) {
                activity.unregisterReceiver(ConfigDownloadListener.this.mDownloadConfigRecv);
                ConfigDownloadListener.this.lastPauseTime = SystemClock.uptimeMillis();
            } else if (activityState == ActivityState.RESUMED) {
                activity.registerReceiver(ConfigDownloadListener.this.mDownloadConfigRecv, new IntentFilter(AIRService.INTENT_CONFIG_DOWNLOADED));
            }
        }

        public void onConfigurationChanged(Configuration configuration) {
        }
    }

    private ConfigDownloadListener() {
        AndroidActivityWrapper.GetAndroidActivityWrapper().addActivityStateChangeListner(this.mActivityStateCB);
    }

    public static ConfigDownloadListener GetConfigDownloadListener() {
        if (sListener == null) {
            sListener = new ConfigDownloadListener();
        }
        return sListener;
    }
}
