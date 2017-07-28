package de.pagecon.ane.services;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import de.pagecon.ane.notificationlistenerservice.Manager;

@TargetApi(21)
public class MyNLNotificationService extends NotificationListenerService {
    private final MyActivityLifecycleCallbacks mCallbacks = new MyActivityLifecycleCallbacks();

    public static class MyActivityLifecycleCallbacks implements ActivityLifecycleCallbacks {
        public static String APPLICATION_STATE_CREATE = "create";
        public static String APPLICATION_STATE_DESTROY = "destroy";
        public static String APPLICATION_STATE_PAUSE = "pause";
        public static String APPLICATION_STATE_RESUME = "resume";
        public static String APPLICATION_STATE_SAVEINSTANCE = "saveinstance";
        public static String APPLICATION_STATE_START = "start";
        public static String APPLICATION_STATE_STOP = "stop";
        public static String APPLICATION_STATE_UNKNOWN = "unknown";

        public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_CREATE);
            }
        }

        public void onActivityStarted(Activity activity) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_START);
            }
        }

        public void onActivityResumed(Activity activity) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_RESUME);
            }
        }

        public void onActivityPaused(Activity activity) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_PAUSE);
            }
        }

        public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_SAVEINSTANCE);
            }
        }

        public void onActivityStopped(Activity activity) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_STOP);
            }
        }

        public void onActivityDestroyed(Activity activity) {
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_DESTROY);
            }
        }
    }

    public IBinder onBind(Intent intent) {
        Manager.cLog("[NotificationService] onBind");
        Manager.refreshNotificationsEnabled();
        return super.onBind(intent);
    }

    public boolean onUnbind(Intent mIntent) {
        Manager.cLog("[NotificationService] onUnbind");
        Manager.refreshNotificationsEnabled();
        return super.onUnbind(mIntent);
    }

    public void onCreate() {
        getApplication().registerActivityLifecycleCallbacks(this.mCallbacks);
        super.onCreate();
        Manager.cLog("[NotificationService] onCreate");
        Manager.refreshNotificationsEnabled();
    }

    public void onDestroy() {
        super.onDestroy();
        getApplication().unregisterActivityLifecycleCallbacks(this.mCallbacks);
        Manager.cLog("[NotificationService] onDestroy");
        Manager.refreshNotificationsEnabled();
    }

    public void onNotificationPosted(StatusBarNotification sbn) {
        try {
            if (Manager.instance == null) {
                Manager.cLog("ERROR: Manager.instance is null");
            } else if (Manager.instance.managerListener == null) {
                Manager.cLog("ERROR: Manager.instance.managerListener is null");
            } else {
                Manager.instance.managerListener.dispatchNotification(sbn);
            }
        } catch (Exception e) {
            Manager.cLog("[NotificationService] Error while dispatchNotification()... " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void onNotificationRemoved(StatusBarNotification sbn) {
        Manager.cLog("[NotificationService] onNotificationRemoved");
        Manager.cLog("ID :" + sbn.getId() + "\t" + sbn.getNotification().tickerText + "\t" + sbn.getPackageName());
    }

    public void onListenerConnected() {
        Manager.cLog("[NotificationService] onListenerConnected");
        Manager.refreshNotificationsEnabled();
        super.onListenerConnected();
    }
}
