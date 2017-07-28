package de.pagecon.bleane.extension;

import java.util.List;

public interface ManagerListener {
    void bleEnabledStateChanged(int i);

    void connectionRequestsCanceled();

    void dataReceived(String str, String str2, String str3, byte[] bArr);

    void dataWritten(String str, String str2, String str3);

    void deviceConnected(String str, String str2);

    void deviceDisconnected(String str);

    void deviceDiscovered(String str, String str2, String str3);

    void deviceNotPaired(String str, String str2);

    void devicePaired(String str, String str2);

    void error(int i, String str, String str2, String str3, String str4);

    void idsChecked(List<String> list);

    void info(String str);

    void scanningStateChanged(boolean z);
}
