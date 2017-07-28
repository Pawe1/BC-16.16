package de.pagecon.bleane.cc2540.usb;

import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.os.Handler;
import android.os.Looper;
import de.pagecon.bleane.extension.Manager;
import java.util.ArrayList;
import java.util.HashMap;

public class UsbManager implements SigmaUsbDeviceListener {
    private static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    protected static final int ALREADY_CONNECTED = 11;
    protected static final int DEVICE_NOT_FOUND = 14;
    protected static final int REQUESTING_PERMISSION = 13;
    protected static final int TRYING_TO_CONNECT = 12;
    private static UsbManager singleInstance = null;
    private HashMap<Integer, SigmaUsbDevice> mConnectedDevices = new HashMap();
    private Context mContext;
    private UsbManagerListener mListener;
    private PendingIntent mPermissionIntent;
    private android.hardware.usb.UsbManager mUsbManager;
    private final BroadcastReceiver mUsbReceiver = new C04061();

    class C04061 extends BroadcastReceiver {
        C04061() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            UsbDevice device;
            if (UsbManager.ACTION_USB_PERMISSION.equals(action)) {
                if (intent.getBooleanExtra("permission", false)) {
                    UsbManager.this.connectDevice((UsbDevice) intent.getParcelableExtra("device"));
                    return;
                }
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device != null) {
                    Manager.cLog("permission denied for usb device " + device);
                    UsbManager.this.mListener.debugInfo("permission denied for Usb device " + device);
                }
            } else if ("android.hardware.usb.action.USB_DEVICE_ATTACHED".equals(action)) {
                Manager.cLog("usb device attached");
                UsbManager.this.mListener.debugInfo("usb device attached");
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device == null) {
                    return;
                }
                if (SigmaUsbDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                    Manager.cLog("sigma usb device found");
                    UsbManager.this.mListener.debugInfo("sigma usb device found");
                    UsbManager.this.mListener.deviceAttached(new SigmaUsbDevice(device));
                    return;
                }
                Manager.cLog("usb device not supported");
                UsbManager.this.mListener.debugInfo("usb device not supported");
            } else if ("android.hardware.usb.action.USB_DEVICE_DETACHED".equals(action)) {
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device != null && SigmaUsbDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                    SigmaUsbDevice sd = UsbManager.this.tearDownDevice(new SigmaUsbDevice(device).getID().intValue());
                    if (sd != null) {
                        UsbManager.this.mListener.deviceConnectionLost(sd);
                    }
                    Manager.cLog("device detached: " + device.getDeviceId());
                    UsbManager.this.mListener.deviceDetached(new SigmaUsbDevice(device));
                }
            }
        }
    }

    public static UsbManager createManager(Context context, UsbManagerListener listener) {
        if (singleInstance != null) {
            singleInstance.setListener(listener);
            return singleInstance;
        }
        singleInstance = new UsbManager(context, listener);
        return singleInstance;
    }

    private UsbManager(Context context, UsbManagerListener listener) {
        this.mContext = context;
        this.mListener = listener;
        this.mPermissionIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent(ACTION_USB_PERMISSION), 0);
        IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
        filter.addAction("android.hardware.usb.action.USB_DEVICE_ATTACHED");
        filter.addAction("android.hardware.usb.action.USB_DEVICE_DETACHED");
        this.mContext.registerReceiver(this.mUsbReceiver, filter);
        this.mUsbManager = (android.hardware.usb.UsbManager) this.mContext.getSystemService("usb");
    }

    public void shutDown() {
        reset();
        this.mContext.unregisterReceiver(this.mUsbReceiver);
        this.mUsbManager = null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private de.pagecon.bleane.cc2540.usb.SigmaUsbDevice connectDevice(final android.hardware.usb.UsbDevice r6) {
        /*
        r5 = this;
        monitor-enter(r5);
        if (r6 == 0) goto L_0x0059;
    L_0x0003:
        r2 = r5.mUsbManager;	 Catch:{ all -> 0x0094 }
        r1 = r2.openDevice(r6);	 Catch:{ all -> 0x0094 }
        if (r1 == 0) goto L_0x005c;
    L_0x000b:
        r0 = de.pagecon.bleane.cc2540.usb.SigmaUsbDevice.connectSigmaDevice(r6, r1, r5);	 Catch:{ all -> 0x0094 }
        if (r0 == 0) goto L_0x0043;
    L_0x0011:
        r2 = r5.mConnectedDevices;	 Catch:{ all -> 0x0094 }
        r3 = r0.getID();	 Catch:{ all -> 0x0094 }
        r2.put(r3, r0);	 Catch:{ all -> 0x0094 }
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0094 }
        r3 = "Connected Sigma Device with ID ";
        r2.<init>(r3);	 Catch:{ all -> 0x0094 }
        r3 = r0.getID();	 Catch:{ all -> 0x0094 }
        r2 = r2.append(r3);	 Catch:{ all -> 0x0094 }
        r2 = r2.toString();	 Catch:{ all -> 0x0094 }
        de.pagecon.bleane.extension.Manager.cLog(r2);	 Catch:{ all -> 0x0094 }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x0094 }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x0094 }
        r2.<init>(r3);	 Catch:{ all -> 0x0094 }
        r3 = new de.pagecon.bleane.cc2540.usb.UsbManager$2;	 Catch:{ all -> 0x0094 }
        r3.<init>(r0);	 Catch:{ all -> 0x0094 }
        r2.post(r3);	 Catch:{ all -> 0x0094 }
        monitor-exit(r5);	 Catch:{ all -> 0x0094 }
    L_0x0042:
        return r0;
    L_0x0043:
        r2 = "Creating Sigma Device failed";
        de.pagecon.bleane.extension.Manager.cLog(r2);	 Catch:{ all -> 0x0094 }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x0094 }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x0094 }
        r2.<init>(r3);	 Catch:{ all -> 0x0094 }
        r3 = new de.pagecon.bleane.cc2540.usb.UsbManager$3;	 Catch:{ all -> 0x0094 }
        r3.<init>(r6);	 Catch:{ all -> 0x0094 }
        r2.post(r3);	 Catch:{ all -> 0x0094 }
    L_0x0059:
        monitor-exit(r5);	 Catch:{ all -> 0x0094 }
        r0 = 0;
        goto L_0x0042;
    L_0x005c:
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0094 }
        r3 = "open usb device failed ";
        r2.<init>(r3);	 Catch:{ all -> 0x0094 }
        r2 = r2.append(r6);	 Catch:{ all -> 0x0094 }
        r2 = r2.toString();	 Catch:{ all -> 0x0094 }
        de.pagecon.bleane.extension.Manager.cLog(r2);	 Catch:{ all -> 0x0094 }
        r2 = r5.mListener;	 Catch:{ all -> 0x0094 }
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0094 }
        r4 = "open usb device failed ";
        r3.<init>(r4);	 Catch:{ all -> 0x0094 }
        r3 = r3.append(r6);	 Catch:{ all -> 0x0094 }
        r3 = r3.toString();	 Catch:{ all -> 0x0094 }
        r2.debugInfo(r3);	 Catch:{ all -> 0x0094 }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x0094 }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x0094 }
        r2.<init>(r3);	 Catch:{ all -> 0x0094 }
        r3 = new de.pagecon.bleane.cc2540.usb.UsbManager$4;	 Catch:{ all -> 0x0094 }
        r3.<init>(r6);	 Catch:{ all -> 0x0094 }
        r2.post(r3);	 Catch:{ all -> 0x0094 }
        goto L_0x0059;
    L_0x0094:
        r2 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0094 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: de.pagecon.bleane.cc2540.usb.UsbManager.connectDevice(android.hardware.usb.UsbDevice):de.pagecon.bleane.cc2540.usb.SigmaUsbDevice");
    }

    private SigmaUsbDevice tearDownDevice(int deviceID) {
        SigmaUsbDevice sd = (SigmaUsbDevice) this.mConnectedDevices.remove(Integer.valueOf(deviceID));
        if (sd == null) {
            return null;
        }
        sd.tearDown();
        return sd;
    }

    public void dataReadFromDevice(int deviceID, byte[] data) {
        this.mListener.dataReceived(deviceID, data);
    }

    public void disconnected(final SigmaUsbDevice sd) {
        this.mConnectedDevices.remove(sd.getID());
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                UsbManager.this.mListener.deviceDisconnected(sd);
            }
        });
    }

    public void debugInfo(String info) {
        this.mListener.debugInfo(info);
    }

    private void setListener(UsbManagerListener listener) {
        this.mListener = listener;
    }

    public void setSupportedDeviceIDs(ArrayList<VIDPIDPair> supportedDevices) {
        SigmaUsbDevice.setSupportedDeviceIDs(supportedDevices);
    }

    public ArrayList<SigmaUsbDevice> getAttachedDevices() {
        ArrayList<SigmaUsbDevice> devices = new ArrayList();
        HashMap<String, UsbDevice> deviceList = this.mUsbManager.getDeviceList();
        Manager.cLog(new StringBuilder(String.valueOf(deviceList.values().size())).append(" usb devices found").toString());
        this.mListener.debugInfo(new StringBuilder(String.valueOf(deviceList.values().size())).append(" usb devices found").toString());
        for (UsbDevice device : deviceList.values()) {
            if (SigmaUsbDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                devices.add(new SigmaUsbDevice(device));
            }
        }
        return devices;
    }

    public ArrayList<SigmaUsbDevice> getConnectedDevices() {
        ArrayList<SigmaUsbDevice> devices = new ArrayList();
        for (SigmaUsbDevice sd : this.mConnectedDevices.values()) {
            if (!sd.disconnectionPending.booleanValue()) {
                devices.add(sd);
            }
        }
        return devices;
    }

    public int connectDevice(int deviceID) {
        for (SigmaUsbDevice sd : this.mConnectedDevices.values()) {
            if (sd.getID().intValue() == deviceID) {
                return 11;
            }
        }
        for (UsbDevice device : this.mUsbManager.getDeviceList().values()) {
            if (SigmaUsbDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue() && device.getDeviceId() == deviceID) {
                if (this.mUsbManager.hasPermission(device)) {
                    connectDevice(device);
                    return 12;
                }
                this.mUsbManager.requestPermission(device, this.mPermissionIntent);
                return 13;
            }
        }
        return 14;
    }

    public void disconnectDevice(int deviceID) {
        SigmaUsbDevice sd = (SigmaUsbDevice) this.mConnectedDevices.get(Integer.valueOf(deviceID));
        if (sd != null) {
            sd.disconnect();
        }
    }

    public void reset() {
        for (Integer intValue : this.mConnectedDevices.keySet()) {
            disconnectDevice(intValue.intValue());
        }
    }

    public Boolean sendData(int deviceID, byte[] data) {
        SigmaUsbDevice sd = (SigmaUsbDevice) this.mConnectedDevices.get(Integer.valueOf(deviceID));
        if (sd != null) {
            return sd.sendData(data);
        }
        return Boolean.valueOf(false);
    }
}
