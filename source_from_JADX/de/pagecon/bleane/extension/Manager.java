package de.pagecon.bleane.extension;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.os.Handler;
import android.os.Looper;
import de.pagecon.bleane.cc2540.DongleManager;
import de.pagecon.bleane.cc2540.DongleManagerListener;
import de.pagecon.bleane.nativ.NativeManager;
import de.pagecon.bleane.nativ.NativeManagerListener;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class Manager {
    private static final boolean DEBUG_MODE = false;
    public static final int DONGLE_BLE_HW_ENABLED = 2;
    public static final int DONGLE_BLE_HW_SELECTED = 2;
    public static final int ERROR_BLE_ALREADY_ENABLED = -13;
    public static final int ERROR_BLE_CONNECT_FAILED = -7;
    public static final int ERROR_BLE_DEVICE_ALREADY_CONNECTED = -5;
    public static final int ERROR_BLE_DEVICE_NOT_CONNECTED = -6;
    public static final int f399x9af1bb7 = -14;
    public static final int ERROR_BLE_DEVICE_UNKNOWN = -17;
    public static final int ERROR_BLE_DISCONNECT_FAILED = -8;
    public static final int ERROR_BLE_INVALID_CHARACTERISTIC_UUID = -16;
    public static final int ERROR_BLE_INVALID_DEVICE_ID = -4;
    public static final int ERROR_BLE_INVALID_SERVICE_UUID = -15;
    public static final int ERROR_BLE_NOT_ENABLED = -2;
    public static final int ERROR_BLE_NOT_SUPPORTED = -1;
    public static final int ERROR_BLE_OPERATION_FAILED = -3;
    public static final int ERROR_BLE_OPERATION_NOT_SUPPORTED = -20;
    public static final int ERROR_BLE_READ_FAILED = -11;
    public static final int ERROR_BLE_START_SCAN_FAILED = -18;
    public static final int ERROR_BLE_STILL_SCANNING = -21;
    public static final int ERROR_BLE_STOP_SCAN_FAILED = -19;
    public static final int ERROR_BLE_WRITE_FAILED = -12;
    public static final int INTERNAL_AND_DONGLE_BLE_HW_ENABLED = 3;
    public static final int INTERNAL_BLE_HW_ENABLED = 1;
    public static final int INTERNAL_BLE_HW_SELECTED = 1;
    public static final int NO_BLE_HW_ENABLED = 0;
    public static final int NO_BLE_HW_SELECTED = 0;
    public static final int SUCCESS = 0;
    public static final String TAG = "Ble ANE Android Layer";
    public static Manager instance = null;
    private DongleManagerListener dongleListener = new DongleListener();
    public DongleManager dongleManager = null;
    public BleHWListener hwListener;
    public ManagerListener managerListener;
    private NativeManagerListener nativeListener = new NativeListener();
    public NativeManager nativeManager = null;
    private int selectedBleHW = 0;

    class DongleListener implements DongleManagerListener {
        DongleListener() {
        }

        public void dataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
            Manager.this.notifyDataReceived(id, serviceUUID, charUUID, data);
        }

        public void dataWritten(String id, String serviceUUID, String charUUID) {
            Manager.this.notifyDataWritten(id, serviceUUID, charUUID);
        }

        public void deviceConnected(String id, String primaryServiceUUID) {
            Manager.this.notifyDeviceConnected(id, primaryServiceUUID);
        }

        public void deviceDiscovered(String id, String primaryServiceUUID, String name) {
            Manager.this.notifyDeviceDiscovered(id, primaryServiceUUID, name);
        }

        public void error(int errCode, String message, String id, String serviceUUID, String charUUID) {
            Manager.this.notifyError(errCode, message, id, serviceUUID, charUUID);
        }

        public void deviceDisconnected(String id) {
            Manager.this.notifyDeviceDisconnected(id);
        }

        public void idsChecked(List<String> validIds) {
            Manager.this.notifyIdsChecked(validIds);
        }

        public void info(String info) {
            Manager.this.notifyInfo(info);
        }

        public void bleEnabledStateChanged(boolean enabled) {
            Manager.this.notifyBleEnabledStateChanged(Manager.this.getEnabledBleHw());
        }

        public void bleEnabledStateChanged(int enabled) {
        }

        public void scanningStateChanged(boolean scanningState) {
            if (Manager.this.selectedBleHW == 2) {
                Manager.this.notifyScanningStateChanged(scanningState);
            }
        }

        public void connectionRequestsCanceled() {
            Manager.this.notifyConnectionRequestsCanceled();
        }
    }

    class NativeListener implements NativeManagerListener {
        NativeListener() {
        }

        public void dataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
            Manager.this.notifyDataReceived(id, serviceUUID, charUUID, data);
        }

        public void dataWritten(String id, String serviceUUID, String charUUID) {
            Manager.this.notifyDataWritten(id, serviceUUID, charUUID);
        }

        public void deviceConnected(String id, String primaryServiceUUID) {
            Manager.this.notifyDeviceConnected(id, primaryServiceUUID);
        }

        public void deviceDiscovered(String id, String primaryServiceUUID, String name) {
            Manager.this.notifyDeviceDiscovered(id, primaryServiceUUID, name);
        }

        public void error(int errCode, String message, String id, String serviceUUID, String charUUID) {
            Manager.this.notifyError(errCode, message, id, serviceUUID, charUUID);
        }

        public void deviceDisconnected(String id) {
            Manager.this.notifyDeviceDisconnected(id);
        }

        public void idsChecked(List<String> validIds) {
            Manager.this.notifyIdsChecked(validIds);
        }

        public void info(String info) {
            Manager.this.notifyInfo(info);
        }

        public void bleEnabledStateChanged(boolean enabled) {
            Manager.this.notifyBleEnabledStateChanged(Manager.this.getEnabledBleHw());
        }

        public void bleEnabledStateChanged(int enabled) {
        }

        public void scanningStateChanged(boolean scanningState) {
            if (Manager.this.selectedBleHW == 1) {
                Manager.this.notifyScanningStateChanged(scanningState);
            }
        }

        public void connectionRequestsCanceled() {
            Manager.this.notifyConnectionRequestsCanceled();
        }
    }

    public static final void cLog(String msg) {
    }

    private void notifyDataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
        final String str = id;
        final String str2 = serviceUUID;
        final String str3 = charUUID;
        final byte[] bArr = data;
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.dataReceived(str, str2, str3, bArr);
            }
        });
    }

    private void notifyDataWritten(final String id, final String serviceUUID, final String charUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.dataWritten(id, serviceUUID, charUUID);
            }
        });
    }

    private void notifyDeviceConnected(final String id, final String primaryServiceUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.deviceConnected(id, primaryServiceUUID);
            }
        });
    }

    private void notifyDeviceDiscovered(final String id, final String primaryServiceUUID, final String name) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.deviceDiscovered(id, primaryServiceUUID, name);
            }
        });
    }

    private void notifyError(int errCode, String message, String id, String serviceUUID, String charUUID) {
        final int i = errCode;
        final String str = message;
        final String str2 = id;
        final String str3 = serviceUUID;
        final String str4 = charUUID;
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.error(i, str, str2, str3, str4);
            }
        });
    }

    private void notifyDeviceDisconnected(final String id) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.deviceDisconnected(id);
            }
        });
    }

    private void notifyIdsChecked(final List<String> validIds) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.idsChecked(validIds);
            }
        });
    }

    public void notifyInfo(String info) {
    }

    private void notifyBleEnabledStateChanged(final int enabled) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.bleEnabledStateChanged(enabled);
            }
        });
    }

    private void notifyScanningStateChanged(final boolean scanningState) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.scanningStateChanged(scanningState);
            }
        });
    }

    private void notifyConnectionRequestsCanceled() {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                Manager.this.managerListener.connectionRequestsCanceled();
            }
        });
    }

    public static Manager create(Activity activity, ManagerListener managerListener, BleHWListener hwListener) {
        if (instance == null) {
            instance = new Manager(activity, managerListener, hwListener);
        }
        return instance;
    }

    private Manager(Activity activity, ManagerListener managerListener, BleHWListener hwListener) {
        this.managerListener = managerListener;
        this.hwListener = hwListener;
        this.dongleManager = DongleManager.create(activity, this.dongleListener);
        this.nativeManager = NativeManager.create(activity, this.nativeListener);
        if (!isBleSupported()) {
            notifyError(-1, "BLE is not supported on this Device", null, null, null);
        }
        checkSwitchHW();
    }

    private void checkSwitchHW() {
        int lastSelectedBleHW = this.selectedBleHW;
        if (this.dongleManager.isBleSupported() && this.nativeManager.isBleSupported()) {
            if (this.dongleManager.isBleEnabled()) {
                this.selectedBleHW = 2;
            } else {
                this.selectedBleHW = 1;
            }
        } else if (this.dongleManager.isBleSupported() && !this.nativeManager.isBleSupported()) {
            this.selectedBleHW = 2;
        } else if (!this.dongleManager.isBleSupported() && this.nativeManager.isBleSupported()) {
            this.selectedBleHW = 1;
        } else if (!(this.dongleManager.isBleSupported() || this.nativeManager.isBleSupported())) {
            this.selectedBleHW = 0;
        }
        if (lastSelectedBleHW != this.selectedBleHW && this.selectedBleHW != 0) {
            if (this.selectedBleHW == 1) {
                if (this.dongleManager != null) {
                    this.dongleManager.finalise(false);
                }
                this.nativeManager.initialise();
                notifyInfo("Switched to internal");
            } else if (this.selectedBleHW == 2) {
                if (this.nativeManager != null) {
                    this.nativeManager.finalise(false);
                }
                this.dongleManager.initialise();
                notifyInfo("Switched to dongle");
            }
            this.hwListener.selectedBleHWChanged(this.selectedBleHW);
        }
    }

    public void finalise(boolean shutDown) {
        this.nativeManager.finalise(shutDown);
        this.dongleManager.finalise(shutDown);
    }

    public void reset() {
        if (this.selectedBleHW == 2) {
            this.dongleManager.reset();
        }
    }

    public void setBleNotificationFilterParams(boolean filterDuplicates, int filterDuration) {
        this.nativeManager.setBleNotificationFilterParams(filterDuplicates, filterDuration);
    }

    public boolean isBleSupported() {
        return this.dongleManager.isBleSupported() || this.nativeManager.isBleSupported();
    }

    public int getEnabledBleHw() {
        if (!this.dongleManager.isBleEnabled() && !this.nativeManager.isBleEnabled()) {
            return 0;
        }
        if (!this.dongleManager.isBleEnabled() && this.nativeManager.isBleEnabled()) {
            return 1;
        }
        if (this.dongleManager.isBleEnabled() && !this.nativeManager.isBleEnabled()) {
            return 2;
        }
        if (this.dongleManager.isBleEnabled() && this.nativeManager.isBleEnabled()) {
            return 3;
        }
        return 0;
    }

    public int getSelectedBleHw() {
        return this.selectedBleHW;
    }

    public int askUserToEnableBle() {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.askUserToEnableBle();
            case 2:
                return this.dongleManager.askUserToEnableBle();
            default:
                return -3;
        }
    }

    public int startScan(List<String> serviceUUIDs) {
        checkSwitchHW();
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.startScan(serviceUUIDs);
            case 2:
                return this.dongleManager.startScan(serviceUUIDs);
            default:
                return -3;
        }
    }

    public void stopScan() {
        switch (this.selectedBleHW) {
            case 1:
                this.nativeManager.stopScan();
                return;
            case 2:
                this.dongleManager.stopScan();
                return;
            default:
                return;
        }
    }

    public int connect(List<String> deviceIds) {
        checkSwitchHW();
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.connect(deviceIds);
            case 2:
                return this.dongleManager.connect(deviceIds);
            default:
                return -3;
        }
    }

    public int cancelConnectionRequests() {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.cancelConnectionRequests();
            case 2:
                return this.dongleManager.cancelConnectionRequests();
            default:
                return -3;
        }
    }

    public int disconnect(String id) {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.disconnect(id);
            case 2:
                return this.dongleManager.disconnect(id);
            default:
                return -3;
        }
    }

    public int read(String id, String serviceUUID, String charUUID) {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.read(id, serviceUUID, charUUID);
            case 2:
                return this.dongleManager.read(id, serviceUUID, charUUID);
            default:
                return -3;
        }
    }

    public int write(String id, String serviceUUID, String charUUID, byte[] data) {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.write(id, serviceUUID, charUUID, data);
            case 2:
                return this.dongleManager.write(id, serviceUUID, charUUID, data);
            default:
                return -3;
        }
    }

    public int setNotify(String id, String serviceUUID, String charUUID, boolean enabled) {
        if (!isBleSupported()) {
            return -1;
        }
        switch (this.selectedBleHW) {
            case 0:
                return -3;
            case 1:
                return this.nativeManager.setNotify(id, serviceUUID, charUUID, enabled);
            case 2:
                return this.dongleManager.setNotify(id, serviceUUID, charUUID, enabled);
            default:
                return -3;
        }
    }

    public void checkIds(List<String> ids) {
        if (isBleSupported()) {
            List<String> validIds = new ArrayList();
            for (String id : ids) {
                if (BluetoothAdapter.checkBluetoothAddress(id.toUpperCase(Locale.US))) {
                    validIds.add(id);
                }
            }
            notifyIdsChecked(validIds);
        }
    }
}
