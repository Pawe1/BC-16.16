package de.pagecon.bleane.cc2540.usb;

public interface SigmaUsbDeviceListener {
    void dataReadFromDevice(int i, byte[] bArr);

    void debugInfo(String str);

    void disconnected(SigmaUsbDevice sigmaUsbDevice);
}
