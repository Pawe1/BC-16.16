package de.pagecon.bleane.util;

/* compiled from: NotificationFilter */
class NotificationInfo {
    long timeStamp = 0;
    byte[] value = new byte[0];

    public NotificationInfo(long timeStamp, byte[] value) {
        this.timeStamp = timeStamp;
        this.value = value;
    }
}
