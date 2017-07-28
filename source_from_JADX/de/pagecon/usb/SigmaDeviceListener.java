package de.pagecon.usb;

public interface SigmaDeviceListener {
    void dataReadFromDevice(int i, byte[] bArr);

    void debugInfo(String str);

    void disconnected(SigmaDevice sigmaDevice);
}
