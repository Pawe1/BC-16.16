package de.pagecon.ane.notificationlistenerservice;

import android.annotation.TargetApi;
import android.service.notification.StatusBarNotification;

@TargetApi(21)
public interface ManagerListener {
    void dispatchNativeApplicationState(String str);

    void dispatchNotification(StatusBarNotification statusBarNotification);

    void dispatchNotificationStatusChanged(Boolean bool);
}
