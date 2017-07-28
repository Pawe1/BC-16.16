package de.pagecon.ane.notificationlistenerservice;

import android.service.notification.StatusBarNotification;

public interface ManagerListener {
    void dispatchNativeApplicationState(String str, String str2);

    void dispatchNotification(StatusBarNotification statusBarNotification);

    void dispatchNotificationStatusChanged(Boolean bool);
}
