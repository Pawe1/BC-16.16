package de.pagecon.bleane.cc2540.usb;

import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbEndpoint;
import android.hardware.usb.UsbInterface;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.Looper;
import de.pagecon.bleane.extension.Manager;
import java.util.ArrayList;
import java.util.List;

public class SigmaUsbDevice {
    private static final int BUFFER_SIZE = 512;
    protected static final char[] hexArray = "0123456789ABCDEF".toCharArray();
    private static ArrayList<VIDPIDPair> mSupportedDevices = new ArrayList();
    private Boolean disconnected = Boolean.valueOf(false);
    public Boolean disconnectionPending = Boolean.valueOf(false);
    private int mDeviceClass;
    private final UsbDeviceConnection mDeviceConnection;
    private int mDeviceID;
    private String mDeviceName;
    private int mDeviceProtocol;
    private int mDeviceSubClass;
    private final UsbEndpoint mEndpointIn;
    private final UsbEndpoint mEndpointOut;
    private final UsbInterface mInterface;
    private SigmaUsbDeviceListener mListener;
    private int mProductID;
    private ReaderThread mReaderThread = new ReaderThread();
    private int mVendorID;
    private List<WriterTask> writeOperations = new ArrayList();
    private Boolean writerStopped = Boolean.valueOf(false);

    class C03991 implements Runnable {
        C03991() {
        }

        public void run() {
            if (!SigmaUsbDevice.this.disconnected.booleanValue()) {
                SigmaUsbDevice.this.writeOperations = new ArrayList();
                if (!(SigmaUsbDevice.this.mDeviceConnection == null || SigmaUsbDevice.this.mInterface == null)) {
                    SigmaUsbDevice.this.mDeviceConnection.releaseInterface(SigmaUsbDevice.this.mInterface);
                }
                if (SigmaUsbDevice.this.mDeviceConnection != null) {
                    SigmaUsbDevice.this.mDeviceConnection.close();
                }
                if (SigmaUsbDevice.this.mListener != null) {
                    SigmaUsbDevice.this.mListener.disconnected(SigmaUsbDevice.this);
                }
                SigmaUsbDevice.this.disconnected = Boolean.valueOf(true);
            }
        }
    }

    private class ReaderThread extends Thread {
        public boolean mStopReader;

        class C04001 implements Runnable {
            C04001() {
            }

            public void run() {
                SigmaUsbDevice.this.mListener.debugInfo("Reader Thread cancelled");
            }
        }

        private ReaderThread() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r8 = this;
            r7 = 0;
        L_0x0001:
            monitor-enter(r8);
            r3 = r8.mStopReader;	 Catch:{ all -> 0x0081 }
            if (r3 == 0) goto L_0x001e;
        L_0x0006:
            r3 = "Reader Thread cancelled";
            de.pagecon.bleane.extension.Manager.cLog(r3);	 Catch:{ all -> 0x0081 }
            r3 = new android.os.Handler;	 Catch:{ all -> 0x0081 }
            r4 = android.os.Looper.getMainLooper();	 Catch:{ all -> 0x0081 }
            r3.<init>(r4);	 Catch:{ all -> 0x0081 }
            r4 = new de.pagecon.bleane.cc2540.usb.SigmaUsbDevice$ReaderThread$1;	 Catch:{ all -> 0x0081 }
            r4.<init>();	 Catch:{ all -> 0x0081 }
            r3.post(r4);	 Catch:{ all -> 0x0081 }
            monitor-exit(r8);	 Catch:{ all -> 0x0081 }
            return;
        L_0x001e:
            monitor-exit(r8);	 Catch:{ all -> 0x0081 }
            r3 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
            r2 = new byte[r3];
            r3 = de.pagecon.bleane.cc2540.usb.SigmaUsbDevice.this;
            r3 = r3.mDeviceConnection;
            r4 = de.pagecon.bleane.cc2540.usb.SigmaUsbDevice.this;
            r4 = r4.mEndpointIn;
            r5 = r2.length;
            r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r0 = r3.bulkTransfer(r4, r2, r5, r6);
            if (r0 < 0) goto L_0x0001;
        L_0x0038:
            r1 = new byte[r0];
            r3 = r1.length;
            java.lang.System.arraycopy(r2, r7, r1, r7, r3);
            r3 = de.pagecon.bleane.cc2540.usb.SigmaUsbDevice.this;
            r3 = r3.mListener;
            if (r3 == 0) goto L_0x0057;
        L_0x0046:
            r3 = new android.os.Handler;
            r4 = android.os.Looper.getMainLooper();
            r3.<init>(r4);
            r4 = new de.pagecon.bleane.cc2540.usb.SigmaUsbDevice$ReaderThread$2;
            r4.<init>(r1);
            r3.post(r4);
        L_0x0057:
            r3 = new java.lang.StringBuilder;
            r4 = "read ";
            r3.<init>(r4);
            r3 = r3.append(r0);
            r4 = " successfully";
            r3 = r3.append(r4);
            r3 = r3.toString();
            de.pagecon.bleane.extension.Manager.cLog(r3);
            r3 = new android.os.Handler;
            r4 = android.os.Looper.getMainLooper();
            r3.<init>(r4);
            r4 = new de.pagecon.bleane.cc2540.usb.SigmaUsbDevice$ReaderThread$3;
            r4.<init>(r0);
            r3.post(r4);
            goto L_0x0001;
        L_0x0081:
            r3 = move-exception;
            monitor-exit(r8);	 Catch:{ all -> 0x0081 }
            throw r3;
            */
            throw new UnsupportedOperationException("Method not decompiled: de.pagecon.bleane.cc2540.usb.SigmaUsbDevice.ReaderThread.run():void");
        }
    }

    private class WriterTask extends AsyncTask<Void, Void, Boolean> {
        private byte[] data;

        class C04031 implements Runnable {
            C04031() {
            }

            public void run() {
                SigmaUsbDevice.this.mListener.debugInfo("attempting to write Data");
            }
        }

        class C04042 implements Runnable {
            C04042() {
            }

            public void run() {
                SigmaUsbDevice.this.mListener.debugInfo("Sending data not possible as there is no Connection or no Endpoint");
            }
        }

        public WriterTask(byte[] data) {
            this.data = data;
        }

        protected Boolean doInBackground(Void... params) {
            Manager.cLog("attempting to write Data");
            new Handler(Looper.getMainLooper()).post(new C04031());
            if (SigmaUsbDevice.this.mDeviceConnection == null || SigmaUsbDevice.this.mEndpointOut == null) {
                Manager.cLog("Sending data not possible as there is no Connection or no Endpoint");
                new Handler(Looper.getMainLooper()).post(new C04042());
                return Boolean.valueOf(false);
            } else if (this.data == null) {
                try {
                    Thread.sleep(200);
                    return Boolean.valueOf(true);
                } catch (InterruptedException e) {
                    return Boolean.valueOf(false);
                }
            } else {
                final int writeCount = SigmaUsbDevice.this.mDeviceConnection.bulkTransfer(SigmaUsbDevice.this.mEndpointOut, this.data, this.data.length, 0);
                if (writeCount < 0) {
                    return Boolean.valueOf(false);
                }
                Manager.cLog(new StringBuilder(String.valueOf(writeCount)).append(" bytes sent").toString());
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    public void run() {
                        SigmaUsbDevice.this.mListener.debugInfo(writeCount + " bytes sent");
                    }
                });
                return Boolean.valueOf(true);
            }
        }

        protected void onPostExecute(Boolean result) {
            SigmaUsbDevice.this.onWriteTaskFinished(result);
            super.onPostExecute(result);
        }

        protected void onCancelled() {
            Manager.cLog("Write Task cancelled");
            SigmaUsbDevice.this.mListener.debugInfo("Write Task cancelled");
            super.onCancelled();
        }
    }

    public static void setSupportedDeviceIDs(ArrayList<VIDPIDPair> supportedDevices) {
        mSupportedDevices = supportedDevices;
    }

    public static Boolean isDeviceSupported(VIDPIDPair device) {
        return Boolean.valueOf(mSupportedDevices.contains(device));
    }

    public static SigmaUsbDevice connectSigmaDevice(UsbDevice device, UsbDeviceConnection deviceConnection, SigmaUsbDeviceListener listener) {
        if (!(deviceConnection == null || device == null)) {
            if (isDeviceSupported(new VIDPIDPair(device.getVendorId(), device.getProductId())).booleanValue()) {
                for (int i = 0; i < device.getInterfaceCount(); i++) {
                    UsbInterface intf = device.getInterface(i);
                    UsbEndpoint endpointIn = null;
                    UsbEndpoint endpointOut = null;
                    if (deviceConnection.claimInterface(intf, true)) {
                        for (int j = 0; j < intf.getEndpointCount(); j++) {
                            int i2;
                            int i3;
                            UsbEndpoint endpoint = intf.getEndpoint(j);
                            if (endpoint.getDirection() == 0) {
                                endpointOut = endpoint;
                            } else if (endpoint.getDirection() == 128) {
                                endpointIn = endpoint;
                            }
                            if (endpointIn != null) {
                                i2 = 1;
                            } else {
                                i2 = 0;
                            }
                            if (endpointOut != null) {
                                i3 = 1;
                            } else {
                                i3 = 0;
                            }
                            if ((i3 & i2) != 0) {
                                return new SigmaUsbDevice(device, deviceConnection, intf, endpointIn, endpointOut, listener);
                            }
                        }
                        if (!deviceConnection.releaseInterface(intf)) {
                            Manager.cLog("release interface failed");
                        }
                    } else {
                        Manager.cLog("claim interface failed");
                    }
                }
            } else {
                Manager.cLog("device not supported");
            }
            deviceConnection.close();
        }
        return null;
    }

    public SigmaUsbDevice(UsbDevice device, UsbDeviceConnection conn, UsbInterface intf, UsbEndpoint endpointIn, UsbEndpoint endpointOut, SigmaUsbDeviceListener listener) {
        this.mDeviceClass = device.getDeviceClass();
        this.mDeviceSubClass = device.getDeviceSubclass();
        this.mDeviceID = device.getDeviceId();
        this.mVendorID = device.getVendorId();
        this.mProductID = device.getProductId();
        this.mDeviceProtocol = device.getDeviceProtocol();
        this.mDeviceName = device.getDeviceName();
        this.mDeviceConnection = conn;
        this.mInterface = intf;
        this.mEndpointIn = endpointIn;
        this.mEndpointOut = endpointOut;
        this.mListener = listener;
        this.mReaderThread.start();
        Manager.cLog("Reader thread started");
        this.mListener.debugInfo("Reader thread started");
    }

    public SigmaUsbDevice(UsbDevice device) {
        this.mDeviceClass = device.getDeviceClass();
        this.mDeviceSubClass = device.getDeviceSubclass();
        this.mDeviceID = device.getDeviceId();
        this.mVendorID = device.getVendorId();
        this.mProductID = device.getProductId();
        this.mDeviceProtocol = device.getDeviceProtocol();
        this.mDeviceName = device.getDeviceName();
        this.mDeviceConnection = null;
        this.mInterface = null;
        this.mEndpointIn = null;
        this.mEndpointOut = null;
    }

    public Integer getID() {
        return Integer.valueOf(this.mDeviceID);
    }

    public int getDeviceClass() {
        return this.mDeviceClass;
    }

    public int getDeviceSubClass() {
        return this.mDeviceSubClass;
    }

    public int getVendorID() {
        return this.mVendorID;
    }

    public int getProductID() {
        return this.mProductID;
    }

    public int getDeviceProtocol() {
        return this.mDeviceProtocol;
    }

    public String getDeviceName() {
        return this.mDeviceName;
    }

    public String toString() {
        return "ID: " + this.mDeviceID + " vID: " + this.mVendorID + " pID: " + this.mProductID;
    }

    public void disconnect() {
        tearDown();
        checkDisconnection();
    }

    public void tearDown() {
        if (!this.disconnected.booleanValue() && !this.disconnectionPending.booleanValue()) {
            this.disconnectionPending = Boolean.valueOf(true);
            if (this.writeOperations.size() == 0) {
                this.writerStopped = Boolean.valueOf(true);
            }
            for (WriterTask wt : this.writeOperations) {
                wt.cancel(true);
            }
            if (this.mReaderThread != null) {
                synchronized (this.mReaderThread) {
                    this.mReaderThread.mStopReader = true;
                }
                this.mReaderThread = null;
            }
        }
    }

    private void checkDisconnection() {
        if (!this.disconnected.booleanValue() && this.writerStopped.booleanValue()) {
            new Handler(Looper.getMainLooper()).post(new C03991());
        }
    }

    public Boolean sendData(byte[] data) {
        if (this.disconnected.booleanValue() || this.disconnectionPending.booleanValue()) {
            return Boolean.valueOf(false);
        }
        if (data != null) {
            data = (byte[]) data.clone();
        }
        this.writeOperations.add(new WriterTask(data));
        if (this.writeOperations.size() == 1) {
            Manager.cLog("starting write operation");
            this.mListener.debugInfo("starting write operation");
            ((WriterTask) this.writeOperations.get(0)).execute(new Void[0]);
        } else {
            Manager.cLog("write operation scheduled, " + this.writeOperations.size() + " write operations pending");
            this.mListener.debugInfo("write operation scheduled, " + this.writeOperations.size() + " write operations pending");
        }
        return Boolean.valueOf(true);
    }

    private void onWriteTaskFinished(Boolean result) {
        this.writeOperations.remove(0);
        if (this.disconnectionPending.booleanValue()) {
            this.writerStopped = Boolean.valueOf(true);
            checkDisconnection();
            return;
        }
        if (result.booleanValue()) {
            Manager.cLog("write task finished successfully, " + this.writeOperations.size() + " write operations pending");
            this.mListener.debugInfo("write task finished successfully, " + this.writeOperations.size() + " write operations pending");
        } else {
            Manager.cLog("write task failed");
            this.mListener.debugInfo("write task failed");
        }
        if (this.writeOperations.size() > 0) {
            Manager.cLog("starting next write operation");
            this.mListener.debugInfo("starting next write operation");
            ((WriterTask) this.writeOperations.get(0)).execute(new Void[0]);
        }
    }

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[(bytes.length * 2)];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 255;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[(j * 2) + 1] = hexArray[v & 15];
        }
        return new String(hexChars);
    }
}
