package de.pagecon.ane.notificationlistenerservice;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.provider.Settings.Secure;
import android.util.Log;
import de.pagecon.ane.services.MyNLNotificationService;

public class Manager {
    public static Manager instance = null;
    private static Boolean notificationsEnabled = Boolean.valueOf(false);
    public Activity activity;
    public ManagerListener managerListener;

    public static final void cLog(String msg) {
        if (BaseConfig.DEBUG_MODE_ON) {
            Log.i(BaseConfig.TAG, msg);
        }
    }

    public static void dispose() {
        cLog("dispose");
    }

    public static Manager create(Activity activity, ManagerListener managerListener) {
        cLog("Manager create instance");
        if (instance == null) {
            instance = new Manager(activity, managerListener);
        }
        return instance;
    }

    public static Boolean getNotificationsEnabled() {
        return notificationsEnabled;
    }

    public static void setNotificationsEnabled(Boolean notificationsEnabled) {
        if (notificationsEnabled != notificationsEnabled) {
            notificationsEnabled = notificationsEnabled;
            if (instance != null) {
                instance.managerListener.dispatchNotificationStatusChanged(notificationsEnabled);
            }
        }
    }

    public static Boolean refreshNotificationsEnabled() {
        cLog("refreshNotificationsEnabled");
        Boolean enabled = Boolean.valueOf(false);
        if (instance != null) {
            enabled = Boolean.valueOf(false);
            if (instance.activity != null) {
                try {
                    ContentResolver contentResolver = instance.activity.getContentResolver();
                    String packageName = instance.activity.getApplicationContext().getPackageName();
                    String checkPackageName = "";
                    checkPackageName = Secure.getString(contentResolver, "enabled_notification_listeners");
                    if (checkPackageName != null) {
                        enabled = Boolean.valueOf(checkPackageName.contains(packageName));
                    }
                } catch (Exception e) {
                    cLog("FEHLER " + e.getMessage());
                }
            }
        }
        setNotificationsEnabled(enabled);
        return enabled;
    }

    private Manager(Activity activity, ManagerListener managerListener) {
        this.activity = activity;
        this.managerListener = managerListener;
        try {
            cLog("try to start service [NotificationService] ...");
            this.activity.startService(new Intent(this.activity, MyNLNotificationService.class));
        } catch (Exception e) {
            cLog("[NotificationService] Error while starting service... " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void finalize() {
        if (instance != null) {
            cLog("Manager: calling finalize() to unbind service...");
        }
    }
}
