package de.pagecon.usb;

import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import java.util.ArrayList;
import java.util.HashMap;

public class Manager implements SigmaDeviceListener {
    private static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    private static Manager singleInstance = null;
    private HashMap<Integer, SigmaDevice> mConnectedDevices = new HashMap();
    private Context mContext;
    private ManagerListener mListener;
    private UsbManager mManager;
    private PendingIntent mPermissionIntent;
    private final BroadcastReceiver mUsbReceiver = new C04821();

    class C04821 extends BroadcastReceiver {
        C04821() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            UsbDevice device;
            if (Manager.ACTION_USB_PERMISSION.equals(action)) {
                if (intent.getBooleanExtra("permission", false)) {
                    Manager.this.connectDevice((UsbDevice) intent.getParcelableExtra("device"));
                    return;
                }
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device != null) {
                    Log.d("USB-ANE Android Layer", "permission denied for device " + device);
                    Manager.this.mListener.debugInfo("permission denied for device " + device);
                }
            } else if ("android.hardware.usb.action.USB_DEVICE_ATTACHED".equals(action)) {
                Log.i("USB-ANE Android Layer", "device attached");
                Manager.this.mListener.debugInfo("device attached");
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device == null) {
                    return;
                }
                if (SigmaDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                    Log.i("USB-ANE Android Layer", "sigma device found");
                    Manager.this.mListener.debugInfo("sigma device found");
                    Manager.this.mListener.deviceAttached(new SigmaDevice(device));
                    return;
                }
                Log.i("USB-ANE Android Layer", "device not supported");
                Manager.this.mListener.debugInfo("device not supported");
            } else if ("android.hardware.usb.action.USB_DEVICE_DETACHED".equals(action)) {
                device = (UsbDevice) intent.getParcelableExtra("device");
                if (device != null && SigmaDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                    SigmaDevice sd = Manager.this.tearDownDevice(new SigmaDevice(device).getID().intValue());
                    if (sd != null) {
                        Manager.this.mListener.deviceConnectionLost(sd);
                    }
                    Log.i("USB-ANE Android Layer", "device detached: " + device.getDeviceId());
                    Manager.this.mListener.deviceDetached(new SigmaDevice(device));
                }
            }
        }
    }

    public static Manager createManager(Context context, ManagerListener listener) {
        if (singleInstance != null) {
            singleInstance.setListener(listener);
            return singleInstance;
        }
        singleInstance = new Manager(context, listener);
        return singleInstance;
    }

    private Manager(Context context, ManagerListener listener) {
        this.mContext = context;
        this.mListener = listener;
        this.mPermissionIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent(ACTION_USB_PERMISSION), 0);
        IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
        filter.addAction("android.hardware.usb.action.USB_DEVICE_ATTACHED");
        filter.addAction("android.hardware.usb.action.USB_DEVICE_DETACHED");
        this.mContext.registerReceiver(this.mUsbReceiver, filter);
        this.mManager = (UsbManager) this.mContext.getSystemService("usb");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private de.pagecon.usb.SigmaDevice connectDevice(final android.hardware.usb.UsbDevice r6) {
        /*
        r5 = this;
        monitor-enter(r5);
        if (r6 == 0) goto L_0x005d;
    L_0x0003:
        r2 = r5.mManager;	 Catch:{ all -> 0x009a }
        r1 = r2.openDevice(r6);	 Catch:{ all -> 0x009a }
        if (r1 == 0) goto L_0x0060;
    L_0x000b:
        r0 = de.pagecon.usb.SigmaDevice.connectSigmaDevice(r6, r1, r5);	 Catch:{ all -> 0x009a }
        if (r0 == 0) goto L_0x0045;
    L_0x0011:
        r2 = r5.mConnectedDevices;	 Catch:{ all -> 0x009a }
        r3 = r0.getID();	 Catch:{ all -> 0x009a }
        r2.put(r3, r0);	 Catch:{ all -> 0x009a }
        r2 = "USB-ANE Android Layer";
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009a }
        r4 = "Connected Sigma Device with ID ";
        r3.<init>(r4);	 Catch:{ all -> 0x009a }
        r4 = r0.getID();	 Catch:{ all -> 0x009a }
        r3 = r3.append(r4);	 Catch:{ all -> 0x009a }
        r3 = r3.toString();	 Catch:{ all -> 0x009a }
        android.util.Log.i(r2, r3);	 Catch:{ all -> 0x009a }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x009a }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x009a }
        r2.<init>(r3);	 Catch:{ all -> 0x009a }
        r3 = new de.pagecon.usb.Manager$2;	 Catch:{ all -> 0x009a }
        r3.<init>(r0);	 Catch:{ all -> 0x009a }
        r2.post(r3);	 Catch:{ all -> 0x009a }
        monitor-exit(r5);	 Catch:{ all -> 0x009a }
    L_0x0044:
        return r0;
    L_0x0045:
        r2 = "USB-ANE Android Layer";
        r3 = "Creating Sigma Device failed";
        android.util.Log.i(r2, r3);	 Catch:{ all -> 0x009a }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x009a }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x009a }
        r2.<init>(r3);	 Catch:{ all -> 0x009a }
        r3 = new de.pagecon.usb.Manager$3;	 Catch:{ all -> 0x009a }
        r3.<init>(r6);	 Catch:{ all -> 0x009a }
        r2.post(r3);	 Catch:{ all -> 0x009a }
    L_0x005d:
        monitor-exit(r5);	 Catch:{ all -> 0x009a }
        r0 = 0;
        goto L_0x0044;
    L_0x0060:
        r2 = "USB-ANE Android Layer";
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009a }
        r4 = "open device failed ";
        r3.<init>(r4);	 Catch:{ all -> 0x009a }
        r3 = r3.append(r6);	 Catch:{ all -> 0x009a }
        r3 = r3.toString();	 Catch:{ all -> 0x009a }
        android.util.Log.i(r2, r3);	 Catch:{ all -> 0x009a }
        r2 = r5.mListener;	 Catch:{ all -> 0x009a }
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009a }
        r4 = "open device failed ";
        r3.<init>(r4);	 Catch:{ all -> 0x009a }
        r3 = r3.append(r6);	 Catch:{ all -> 0x009a }
        r3 = r3.toString();	 Catch:{ all -> 0x009a }
        r2.debugInfo(r3);	 Catch:{ all -> 0x009a }
        r2 = new android.os.Handler;	 Catch:{ all -> 0x009a }
        r3 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x009a }
        r2.<init>(r3);	 Catch:{ all -> 0x009a }
        r3 = new de.pagecon.usb.Manager$4;	 Catch:{ all -> 0x009a }
        r3.<init>(r6);	 Catch:{ all -> 0x009a }
        r2.post(r3);	 Catch:{ all -> 0x009a }
        goto L_0x005d;
    L_0x009a:
        r2 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x009a }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: de.pagecon.usb.Manager.connectDevice(android.hardware.usb.UsbDevice):de.pagecon.usb.SigmaDevice");
    }

    private SigmaDevice tearDownDevice(int deviceID) {
        SigmaDevice sd = (SigmaDevice) this.mConnectedDevices.remove(Integer.valueOf(deviceID));
        if (sd == null) {
            return null;
        }
        sd.tearDown();
        return sd;
    }

    public void dataReadFromDevice(int deviceID, byte[] data) {
        this.mListener.dataReceived(deviceID, data);
    }

    public void disconnected(final SigmaDevice sd) {
        this.mConnectedDevices.remove(sd.getID());
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.mListener.deviceDisconnected(sd);
            }
        });
    }

    public void debugInfo(String info) {
        this.mListener.debugInfo(info);
    }

    private void setListener(ManagerListener listener) {
        this.mListener = listener;
    }

    public void setSupportedDeviceIDs(ArrayList<VIDPIDPair> supportedDevices) {
        SigmaDevice.setSupportedDeviceIDs(supportedDevices);
    }

    public ArrayList<SigmaDevice> getAttachedDevices() {
        ArrayList<SigmaDevice> devices = new ArrayList();
        HashMap<String, UsbDevice> deviceList = this.mManager.getDeviceList();
        Log.i("USB-ANE Android Layer", new StringBuilder(String.valueOf(deviceList.values().size())).append(" devices found").toString());
        this.mListener.debugInfo(new StringBuilder(String.valueOf(deviceList.values().size())).append(" devices found").toString());
        for (UsbDevice device : deviceList.values()) {
            if (SigmaDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                devices.add(new SigmaDevice(device));
            }
        }
        return devices;
    }

    public ArrayList<SigmaDevice> getConnectedDevices() {
        ArrayList<SigmaDevice> devices = new ArrayList();
        for (SigmaDevice sd : this.mConnectedDevices.values()) {
            if (!sd.disconnectionPending.booleanValue()) {
                devices.add(sd);
            }
        }
        return devices;
    }

    public int connectDevice(int deviceID) {
        for (SigmaDevice sd : this.mConnectedDevices.values()) {
            if (sd.getID().intValue() == deviceID) {
                return 11;
            }
        }
        for (UsbDevice device : this.mManager.getDeviceList().values()) {
            if (SigmaDevice.isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue() && device.getDeviceId() == deviceID) {
                if (this.mManager.hasPermission(device)) {
                    connectDevice(device);
                    return 12;
                }
                this.mManager.requestPermission(device, this.mPermissionIntent);
                return 13;
            }
        }
        return 14;
    }

    public void disconnectDevice(int deviceID) {
        SigmaDevice sd = (SigmaDevice) this.mConnectedDevices.get(Integer.valueOf(deviceID));
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
        SigmaDevice sd = (SigmaDevice) this.mConnectedDevices.get(Integer.valueOf(deviceID));
        if (sd != null) {
            return sd.sendData(data);
        }
        return Boolean.valueOf(false);
    }
}
