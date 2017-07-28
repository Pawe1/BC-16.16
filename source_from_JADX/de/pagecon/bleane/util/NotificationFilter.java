package de.pagecon.bleane.util;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class NotificationFilter {
    private boolean filterDuplicates = false;
    private int filterDuration = -1;
    Map<String, NotificationInfo> lastNotifications = new HashMap();

    public NotificationFilter(boolean filterDuplicates, int filterDuration) {
        this.filterDuplicates = filterDuplicates;
        this.filterDuration = filterDuration;
    }

    public boolean filterNotification(String deviceId, String characteristicUuid, byte[] value) {
        if (this.filterDuplicates || this.filterDuration > 0) {
            long now;
            NotificationInfo lastNoti;
            if (!this.filterDuplicates || this.filterDuration <= 0) {
                if (this.filterDuration > 0) {
                    if (value != null) {
                        now = System.currentTimeMillis();
                        lastNoti = (NotificationInfo) this.lastNotifications.get(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString());
                        this.lastNotifications.put(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString(), new NotificationInfo(now, value));
                        if (lastNoti != null && now - lastNoti.timeStamp <= ((long) this.filterDuration)) {
                            return true;
                        }
                    }
                } else if (this.filterDuplicates && value != null) {
                    lastNoti = (NotificationInfo) this.lastNotifications.get(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString());
                    this.lastNotifications.put(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString(), new NotificationInfo(System.currentTimeMillis(), value));
                    if (lastNoti != null) {
                        return Arrays.equals(lastNoti.value, value) ? true : true;
                    }
                }
            } else if (value != null) {
                now = System.currentTimeMillis();
                lastNoti = (NotificationInfo) this.lastNotifications.get(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString());
                this.lastNotifications.put(new StringBuilder(String.valueOf(deviceId)).append(characteristicUuid).toString(), new NotificationInfo(now, value));
                if (lastNoti != null && now - lastNoti.timeStamp <= ((long) this.filterDuration) && Arrays.equals(lastNoti.value, value)) {
                    return true;
                }
            }
        }
        return false;
    }
}
