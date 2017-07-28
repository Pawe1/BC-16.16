package de.pagecon.ane.services;

import android.app.Activity;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import de.pagecon.ane.notificationlistenerservice.Manager;

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
            Manager.cLog("[NotificationService] onActivityCreated" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_CREATE, activity.getLocalClassName());
            }
        }

        public void onActivityStarted(Activity activity) {
            Manager.cLog("[NotificationService] onActivityStarted" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_START, activity.getLocalClassName());
            }
        }

        public void onActivityResumed(Activity activity) {
            Manager.cLog("[NotificationService] onActivityResumed" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_RESUME, activity.getLocalClassName());
            }
        }

        public void onActivityPaused(Activity activity) {
            Manager.cLog("[NotificationService] onActivityPaused" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_PAUSE, activity.getLocalClassName());
            }
        }

        public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
            Manager.cLog("[NotificationService] onActivitySaveInstanceState" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_SAVEINSTANCE, activity.getLocalClassName());
            }
        }

        public void onActivityStopped(Activity activity) {
            Manager.cLog("[NotificationService] onActivityStopped" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_STOP, activity.getLocalClassName());
            }
        }

        public void onActivityDestroyed(Activity activity) {
            Manager.cLog("[NotificationService] onActivityDestroyed" + activity.getLocalClassName());
            if (Manager.instance != null && Manager.instance.managerListener != null) {
                Manager.instance.managerListener.dispatchNativeApplicationState(APPLICATION_STATE_DESTROY, activity.getLocalClassName());
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
        Manager.cLog("[NotificationService] onCreate 1");
        getApplication().registerActivityLifecycleCallbacks(this.mCallbacks);
        super.onCreate();
        Manager.cLog("[NotificationService] onCreate 2");
        Manager.refreshNotificationsEnabled();
    }

    public void onDestroy() {
        Manager.cLog("[NotificationService] onDestroy 1");
        super.onDestroy();
        getApplication().unregisterActivityLifecycleCallbacks(this.mCallbacks);
        Manager.cLog("[NotificationService] onDestroy 2");
        Manager.refreshNotificationsEnabled();
    }

    public void onNotificationPosted(StatusBarNotification sbn) {
        Manager.cLog("[NotificationService] onNotificationPosted");
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
