package de.pagecon.bleane.cc2540.usb;

public interface UsbManagerListener {
    void dataReceived(int i, byte[] bArr);

    void debugInfo(String str);

    void deviceAttached(SigmaUsbDevice sigmaUsbDevice);

    void deviceConnected(SigmaUsbDevice sigmaUsbDevice);

    void deviceConnectionFailed(SigmaUsbDevice sigmaUsbDevice);

    void deviceConnectionLost(SigmaUsbDevice sigmaUsbDevice);

    void deviceDetached(SigmaUsbDevice sigmaUsbDevice);

    void deviceDisconnected(SigmaUsbDevice sigmaUsbDevice);
}
