package de.pagecon.usb;

public interface ManagerListener {
    void dataReceived(int i, byte[] bArr);

    void debugInfo(String str);

    void deviceAttached(SigmaDevice sigmaDevice);

    void deviceConnected(SigmaDevice sigmaDevice);

    void deviceConnectionFailed(SigmaDevice sigmaDevice);

    void deviceConnectionLost(SigmaDevice sigmaDevice);

    void deviceDetached(SigmaDevice sigmaDevice);

    void deviceDisconnected(SigmaDevice sigmaDevice);
}
