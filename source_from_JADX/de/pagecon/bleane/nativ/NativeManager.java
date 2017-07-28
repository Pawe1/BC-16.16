package de.pagecon.bleane.nativ;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothAdapter.LeScanCallback;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanFilter.Builder;
import android.bluetooth.le.ScanRecord;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build.VERSION;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelUuid;
import android.util.Log;
import de.pagecon.bleane.extension.HelperActivity;
import de.pagecon.bleane.extension.Manager;
import de.pagecon.bleane.util.Helper;
import de.pagecon.bleane.util.NotificationFilter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

public class NativeManager {
    private static final int REQUEST_LOCATION = 2;
    private static final String baseUUID = "0000xxxx-0000-1000-8000-00805f9b34fb";
    public static NativeManager instance = null;
    private Activity activity;
    private NativeBleDeviceList discoveredDevices;
    private GattCallback gattCallback;
    private NativeBleDeviceList knownDevices;
    public NativeManagerListener listener;
    private BluetoothAdapter mBluetoothAdapter;
    private BluetoothManager mBluetoothManager;
    private final BroadcastReceiver mReceiver = new C04711();
    private NotificationFilter notiFilter = null;
    private ScanCallback scanCallback;
    private List<String> serviceUUIDs;

    class C04711 extends BroadcastReceiver {
        C04711() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            Manager.cLog("ACTION: " + action);
            if (action.equals("android.bluetooth.adapter.action.STATE_CHANGED")) {
                Iterator it;
                NativeBleDevice device;
                BluetoothGatt gatt;
                switch (intent.getIntExtra("android.bluetooth.adapter.extra.STATE", Integer.MIN_VALUE)) {
                    case 10:
                        NativeManager.instance.notifyBleEnabledStateChanged(false);
                        it = NativeManager.this.knownDevices.iterator();
                        while (it.hasNext()) {
                            device = (NativeBleDevice) it.next();
                            gatt = device.getBluetoothGatt();
                            if (gatt != null) {
                                gatt.close();
                                device.setBluetoothGatt(null);
                            }
                            device.setConnecting(false);
                            device.disconnectionAlreadyNotified = false;
                        }
                        return;
                    case 12:
                        NativeManager.instance.notifyBleEnabledStateChanged(true);
                        it = NativeManager.this.knownDevices.iterator();
                        while (it.hasNext()) {
                            device = (NativeBleDevice) it.next();
                            gatt = device.getBluetoothGatt();
                            if (gatt != null) {
                                gatt.close();
                                device.setBluetoothGatt(null);
                            }
                            device.setConnecting(false);
                            device.disconnectionAlreadyNotified = false;
                        }
                        return;
                    default:
                        return;
                }
            } else if (action.equals("android.bluetooth.device.action.BOND_STATE_CHANGED")) {
                BluetoothDevice device2 = (BluetoothDevice) intent.getParcelableExtra("android.bluetooth.device.extra.DEVICE");
                int state = intent.getIntExtra("android.bluetooth.device.extra.BOND_STATE", Integer.MIN_VALUE);
                int prevState = intent.getIntExtra("android.bluetooth.device.extra.PREVIOUS_BOND_STATE", Integer.MIN_VALUE);
                if (state == 12 && prevState == 11) {
                    Manager.cLog("[ACTION_BOND_STATE_CHANGED] [BOND_BONDED] finish");
                    NativeManager.instance.notifyDevicePaired(device2.getAddress(), null);
                } else if (state == 10 && prevState == 12) {
                    Manager.cLog("[ACTION_BOND_STATE_CHANGED] [BOND_NONE] cancel");
                    NativeManager.instance.notifyDeviceNotPaired(device2.getAddress(), null);
                } else if (state == 10 && prevState == 11) {
                    Manager.cLog("[ACTION_BOND_STATE_CHANGED] [BOND_NONE] cancel");
                    NativeManager.instance.notifyDeviceNotPaired(device2.getAddress(), null);
                }
            }
        }
    }

    class GattCallback extends BluetoothGattCallback {
        GattCallback() {
        }

        public void onConnectionStateChange(BluetoothGatt gatt, int status, int newState) {
            NativeManager.this.notifyInfo("connection state changed: status: " + status + ", newState: " + newState);
            if (gatt != null) {
                String id = gatt.getDevice().getAddress();
                NativeBleDevice device = NativeManager.this.knownDevices.findDevice(id);
                if (device != null) {
                    if (device.getBluetoothGatt() != gatt) {
                        device.setBluetoothGatt(gatt);
                        NativeManager.this.notifyInfo("Native Manager: gatt changed!!!");
                    }
                    switch (newState) {
                        case 0:
                            device.setConnecting(false);
                            gatt.close();
                            device.setBluetoothGatt(null);
                            if (!device.disconnectionAlreadyNotified) {
                                NativeManager.this.notifyDeviceDisconnected(id);
                                return;
                            }
                            return;
                        case 1:
                            device.setConnecting(true);
                            if (status != 0) {
                                NativeManager.this.notifyError(-7, "connecting failed", id, null, null);
                                return;
                            } else {
                                NativeManager.this.notifyInfo("Native Manager: device connecting");
                                return;
                            }
                        case 2:
                            device.setConnecting(false);
                            device.disconnectionAlreadyNotified = false;
                            if (status != 0) {
                                NativeManager.this.notifyError(-7, "connection failed", id, null, null);
                                return;
                            }
                            NativeManager.this._cancelConnectionRequests();
                            NativeManager.this.notifyInfo("Native Manager: device connected");
                            boolean success = gatt.discoverServices();
                            return;
                        case 3:
                            device.setConnecting(false);
                            if (status != 0) {
                                NativeManager.this.notifyError(-8, "disconnecting failed", id, null, null);
                                return;
                            } else {
                                NativeManager.this.notifyInfo("Native Manager: device disconnecting");
                                return;
                            }
                        default:
                            return;
                    }
                }
                NativeManager.this.notifyInfo("Native Manager: connection state of unknown device changed!!!");
                return;
            }
            NativeManager.this.notifyInfo("Native Manager: connection state of unidentifiable device changed (gatt == null)!!!");
        }

        public void onServicesDiscovered(BluetoothGatt gatt, int status) {
            if (gatt != null) {
                String id = gatt.getDevice().getAddress();
                NativeBleDevice device = NativeManager.this.knownDevices.findDevice(id);
                for (BluetoothGattService service : gatt.getServices()) {
                    Log.i("UUID", service.getUuid().toString());
                }
                if (device != null) {
                    if (device.getBluetoothGatt() != gatt) {
                        device.setBluetoothGatt(gatt);
                        NativeManager.this.notifyInfo("Native Manager: gatt changed!!!");
                    }
                    if (status != 0) {
                        NativeManager.this.notifyError(-7, "connection failed on service discovery, disconnecting", id, null, null);
                        gatt.disconnect();
                        return;
                    } else if (device != null) {
                        device.setServicesDiscovered(true);
                        NativeManager.this.notifyDeviceConnected(id, device.getPrimaryServiceUuid());
                        return;
                    } else {
                        return;
                    }
                }
                NativeManager.this.notifyInfo("Native Manager: services of unknown device discovered!!!");
                return;
            }
            NativeManager.this.notifyInfo("Native Manager: services of unidentifiable device discovered (gatt == null)!!!");
        }

        public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
            if (gatt != null) {
                String id = gatt.getDevice().getAddress();
                NativeBleDevice device = NativeManager.this.knownDevices.findDevice(id);
                if (device != null) {
                    if (device.getBluetoothGatt() != gatt) {
                        device.setBluetoothGatt(gatt);
                        NativeManager.this.notifyInfo("Native Manager: gatt changed!!!");
                    }
                    String serviceUUID = NativeManager.this.stringFromUUID(characteristic.getService().getUuid());
                    String characteristicUUID = NativeManager.this.stringFromUUID(characteristic.getUuid());
                    if (status != 0) {
                        NativeManager.this.notifyError(-11, "read failed", id, serviceUUID, characteristicUUID);
                        return;
                    }
                    NativeManager.this.notifyDataReceived(id, serviceUUID, characteristicUUID, characteristic.getValue());
                    return;
                }
                NativeManager.this.notifyInfo("Native Manager: characteristics of unknown device read!!!");
                return;
            }
            NativeManager.this.notifyInfo("Native Manager: characteristics of unidentifiable device read (gatt == null)!!!");
        }

        public void onCharacteristicWrite(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
            if (gatt != null) {
                String id = gatt.getDevice().getAddress();
                NativeBleDevice device = NativeManager.this.knownDevices.findDevice(id);
                if (device != null) {
                    if (device.getBluetoothGatt() != gatt) {
                        device.setBluetoothGatt(gatt);
                        NativeManager.this.notifyInfo("Native Manager: gatt changed!!!");
                    }
                    String serviceUUID = NativeManager.this.stringFromUUID(characteristic.getService().getUuid());
                    String characteristicUUID = NativeManager.this.stringFromUUID(characteristic.getUuid());
                    if (status != 0) {
                        NativeManager.this.notifyError(-12, "write failed", id, serviceUUID, characteristicUUID);
                        return;
                    } else {
                        NativeManager.this.notifyDataWritten(id, serviceUUID, characteristicUUID);
                        return;
                    }
                }
                NativeManager.this.notifyInfo("Native Manager: characteristic of unknown device written!!!");
                return;
            }
            NativeManager.this.notifyInfo("Native Manager: characteristic of unidentifiable device written (gatt == null)!!!");
        }

        public void onCharacteristicChanged(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic) {
            if (gatt != null) {
                String id = gatt.getDevice().getAddress();
                NativeBleDevice device = NativeManager.this.knownDevices.findDevice(id);
                if (device != null) {
                    if (device.getBluetoothGatt() != gatt) {
                        device.setBluetoothGatt(gatt);
                        NativeManager.this.notifyInfo("Native Manager: gatt changed!!!");
                    }
                    String serviceUUID = NativeManager.this.stringFromUUID(characteristic.getService().getUuid());
                    String characteristicUUID = NativeManager.this.stringFromUUID(characteristic.getUuid());
                    byte[] value = characteristic.getValue();
                    if (NativeManager.this.notiFilter == null || !NativeManager.this.notiFilter.filterNotification(id, characteristicUUID, value)) {
                        NativeManager.this.notifyDataReceived(id, serviceUUID, characteristicUUID, value);
                        return;
                    }
                    return;
                }
                NativeManager.this.notifyInfo("Native Manager: characteristic of unknown device has notified!!!");
                return;
            }
            NativeManager.this.notifyInfo("Native Manager: characteristic of unidentifiable device has notified (gatt == null)!!!");
        }

        public void onDescriptorRead(BluetoothGatt gatt, BluetoothGattDescriptor descriptor, int status) {
        }

        public void onDescriptorWrite(BluetoothGatt gatt, BluetoothGattDescriptor descriptor, int status) {
        }

        public void onReliableWriteCompleted(BluetoothGatt gatt, int status) {
        }

        public void onReadRemoteRssi(BluetoothGatt gatt, int rssi, int status) {
        }
    }

    class ScanCallback extends android.bluetooth.le.ScanCallback implements LeScanCallback {
        ScanCallback() {
        }

        public void onScanResult(int callbackType, ScanResult result) {
            BluetoothDevice device = result.getDevice();
            ScanRecord scanRecord = result.getScanRecord();
            Manager.cLog("onScanResult device: " + device.getAddress());
            onScanDevice(device, scanRecord.getBytes());
        }

        public void onBatchScanResults(List<ScanResult> list) {
        }

        public void onLeScan(BluetoothDevice device, int rssi, byte[] scanRecord) {
            Manager.cLog("onLeScan");
            onScanDevice(device, scanRecord);
        }

        private void onScanDevice(BluetoothDevice device, byte[] scanRecord) {
            if (NativeManager.this.discoveredDevices.findDevice(device.getAddress()) == null) {
                AdvPackageParser parser = new AdvPackageParser(scanRecord);
                String localName = parser.getLocalName();
                List<String> primaryServiceUUIDs = parser.getPrimaryServiceUUIDs();
                if (primaryServiceUUIDs != null && primaryServiceUUIDs.size() > 0) {
                    String hwAddress;
                    String primaryServiceUuid;
                    NativeBleDevice currentDevice;
                    if (NativeManager.this.serviceUUIDs == null || NativeManager.this.serviceUUIDs.size() <= 0) {
                        hwAddress = device.getAddress();
                        primaryServiceUuid = (String) primaryServiceUUIDs.get(0);
                        currentDevice = new NativeBleDevice(device, primaryServiceUuid, NativeManager.this.mBluetoothManager);
                        if (!NativeManager.this.discoveredDevices.contains(currentDevice)) {
                            if (!NativeManager.this.knownDevices.contains(currentDevice)) {
                                NativeManager.this.knownDevices.add(currentDevice);
                            }
                            NativeManager.this.discoveredDevices.add(currentDevice);
                            NativeManager.this.notifyDeviceDiscovered(hwAddress, primaryServiceUuid, localName);
                            return;
                        }
                        return;
                    }
                    for (String serviceUUID : NativeManager.this.serviceUUIDs) {
                        for (String foundServiceUuid : primaryServiceUUIDs) {
                            if (Helper.stringEqualsIgnoreCase(serviceUUID, foundServiceUuid)) {
                                hwAddress = device.getAddress();
                                primaryServiceUuid = serviceUUID;
                                currentDevice = new NativeBleDevice(device, serviceUUID, NativeManager.this.mBluetoothManager);
                                if (!NativeManager.this.discoveredDevices.contains(currentDevice)) {
                                    if (!NativeManager.this.knownDevices.contains(currentDevice)) {
                                        NativeManager.this.knownDevices.add(currentDevice);
                                    }
                                    NativeManager.this.discoveredDevices.add(currentDevice);
                                    NativeManager.this.notifyDeviceDiscovered(hwAddress, primaryServiceUuid, localName);
                                    return;
                                }
                                return;
                            }
                        }
                    }
                }
            }
        }
    }

    private void notifyDataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
        final String str = id;
        final String str2 = serviceUUID;
        final String str3 = charUUID;
        final byte[] bArr = data;
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.dataReceived(str, str2, str3, bArr);
            }
        });
    }

    private void notifyDataWritten(final String id, final String serviceUUID, final String charUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.dataWritten(id, serviceUUID, charUUID);
            }
        });
    }

    private void notifyDeviceConnected(final String id, final String primaryServiceUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.deviceConnected(id, primaryServiceUUID);
            }
        });
    }

    private void notifyDeviceDiscovered(final String id, final String primaryServiceUUID, final String name) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.deviceDiscovered(id, primaryServiceUUID, name);
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
                NativeManager.this.listener.error(i, str, str2, str3, str4);
            }
        });
    }

    private void notifyDeviceDisconnected(final String id) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.deviceDisconnected(id);
            }
        });
    }

    public void notifyInfo(final String info) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.info(info);
            }
        });
    }

    private void notifyBleEnabledStateChanged(final boolean enabled) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.bleEnabledStateChanged(enabled);
            }
        });
    }

    private void notifyScanningStateChanged(final boolean scanningState) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.scanningStateChanged(scanningState);
            }
        });
    }

    private void notifyConnectionRequestsCanceled() {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.connectionRequestsCanceled();
            }
        });
    }

    private void notifyDevicePaired(final String id, final String primaryServiceUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.devicePaired(id, primaryServiceUUID);
            }
        });
    }

    private void notifyDeviceNotPaired(final String id, final String primaryServiceUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                NativeManager.this.listener.deviceNotPaired(id, primaryServiceUUID);
            }
        });
    }

    public static NativeManager create(Activity activity, NativeManagerListener listener) {
        Manager.cLog("NativeManager.create called");
        if (instance == null) {
            instance = new NativeManager(activity, listener);
        }
        return instance;
    }

    private NativeManager(Activity activity, NativeManagerListener listener) {
        Manager.cLog("NativeManager constructor called");
        this.activity = activity;
        this.listener = listener;
        this.knownDevices = new NativeBleDeviceList();
        if (isBleSupported()) {
            this.gattCallback = new GattCallback();
            this.scanCallback = new ScanCallback();
            initialise();
        }
    }

    public void initialise() {
        Manager.cLog("NativeManager.initialize called");
        this.knownDevices = new NativeBleDeviceList();
        this.discoveredDevices = new NativeBleDeviceList();
        this.serviceUUIDs = null;
        if (isBleSupported() && this.mBluetoothAdapter == null) {
            this.mBluetoothManager = (BluetoothManager) this.activity.getSystemService("bluetooth");
            this.mBluetoothAdapter = this.mBluetoothManager.getAdapter();
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.bluetooth.adapter.action.STATE_CHANGED");
            filter.addAction("android.bluetooth.device.action.BOND_STATE_CHANGED");
            this.activity.registerReceiver(this.mReceiver, filter);
        }
    }

    public void finalise(boolean shutDown) {
        Manager.cLog("NativeManager.finalize called");
        stopScan();
        Iterator it = this.knownDevices.iterator();
        while (it.hasNext()) {
            NativeBleDevice bleDevice = (NativeBleDevice) it.next();
            BluetoothGatt gatt = bleDevice.getBluetoothGatt();
            if (gatt != null) {
                if (bleDevice.isConnected() || bleDevice.isConnecting()) {
                    bleDevice.disconnectionAlreadyNotified = true;
                    gatt.disconnect();
                    notifyDeviceDisconnected(bleDevice.getId());
                }
                gatt.close();
                bleDevice.setBluetoothGatt(null);
            }
            bleDevice.setConnecting(false);
        }
        this.knownDevices = new NativeBleDeviceList();
        this.discoveredDevices = new NativeBleDeviceList();
        this.serviceUUIDs = null;
        if (shutDown) {
            this.activity.unregisterReceiver(this.mReceiver);
            this.mBluetoothManager = null;
            this.mBluetoothAdapter = null;
        }
    }

    private UUID uuidFromString(String uuidString) {
        try {
            if (uuidString.length() > 4) {
                return UUID.fromString(uuidString);
            }
            return UUID.fromString(baseUUID.replace("xxxx", uuidString));
        } catch (Exception e) {
            return null;
        }
    }

    private String stringFromUUID(UUID uuid) {
        String uuidString = uuid.toString();
        if (Helper.stringEqualsIgnoreCase(uuidString.substring(0, 4) + "xxxx" + uuidString.substring(8, uuidString.length()), baseUUID)) {
            return uuidString.substring(4, 8);
        }
        return uuidString;
    }

    public void setBleNotificationFilterParams(boolean filterDuplicates, int filterDuration) {
        Manager.cLog("NativeManager.setBleNotificationFilterParams called");
        this.notiFilter = new NotificationFilter(filterDuplicates, filterDuration);
    }

    public boolean isBleSupported() {
        Manager.cLog("NativeManager.isBleSupported called");
        if (VERSION.SDK_INT >= 18) {
            return this.activity.getPackageManager().hasSystemFeature("android.hardware.bluetooth_le");
        }
        return false;
    }

    public boolean isBleEnabled() {
        Manager.cLog("NativeManager.isBleEnabled called");
        return this.mBluetoothAdapter != null && this.mBluetoothAdapter.isEnabled();
    }

    public int askUserToEnableBle() {
        Manager.cLog("NativeManager.askUserToEnableBle called");
        if (isBleEnabled()) {
            return -13;
        }
        this.activity.startActivity(new Intent(this.activity, HelperActivity.class));
        return 0;
    }

    public int startScan(List<String> serviceUUIDs) {
        Manager.cLog("NativeManager.startScan called");
        if (!isBleEnabled()) {
            return -2;
        }
        int result;
        if (serviceUUIDs != null) {
            for (String serviceUuid : serviceUUIDs) {
                if (uuidFromString(serviceUuid) == null) {
                    return -15;
                }
            }
        }
        this.discoveredDevices = new NativeBleDeviceList();
        this.serviceUUIDs = serviceUUIDs;
        Manager.cLog("Build.VERSION.SDK_INT: " + VERSION.SDK_INT);
        if (VERSION.SDK_INT >= 21) {
            BluetoothLeScanner leScanner = this.mBluetoothAdapter.getBluetoothLeScanner();
            List<ScanFilter> filters = new ArrayList();
            Manager.cLog("check serviceUUIDs...");
            if (serviceUUIDs != null) {
                Manager.cLog("serviceUUIDs != null");
                for (String serviceUuid2 : serviceUUIDs) {
                    Manager.cLog("serviceUuid: " + serviceUuid2);
                    Builder builder = new Builder();
                    builder.setServiceUuid(new ParcelUuid(uuidFromString(serviceUuid2)));
                    filters.add(builder.build());
                }
            }
            ScanSettings.Builder builder2 = new ScanSettings.Builder();
            builder2.setScanMode(1);
            builder2.setReportDelay(0);
            leScanner.startScan(filters, builder2.build(), this.scanCallback);
            result = 0;
        } else if (this.mBluetoothAdapter.startLeScan(this.scanCallback)) {
            result = 0;
        } else {
            result = -3;
        }
        if (result == 0) {
            notifyScanningStateChanged(true);
            Manager.cLog("NativeManager started scanning");
            return result;
        }
        Manager.cLog("NativeManager start scanning failed");
        return result;
    }

    public void stopScan() {
        Manager.cLog("NativeManager.stopScan called");
        if (isBleEnabled()) {
            if (VERSION.SDK_INT < 21) {
                this.mBluetoothAdapter.stopLeScan(this.scanCallback);
            } else {
                this.mBluetoothAdapter.getBluetoothLeScanner().stopScan(this.scanCallback);
            }
            this.serviceUUIDs = null;
            notifyScanningStateChanged(false);
        }
    }

    public int connect(List<String> deviceIds) {
        Manager.cLog("NativeManager.connect called");
        if (!isBleEnabled()) {
            return -2;
        }
        List<NativeBleDevice> devicesToConnect = new ArrayList();
        Boolean allDevicesAlreadyConnected = Boolean.valueOf(true);
        for (String deviceId : deviceIds) {
            String deviceId2 = deviceId2.toUpperCase(Locale.US);
            if (!BluetoothAdapter.checkBluetoothAddress(deviceId2.toUpperCase(Locale.US))) {
                return -4;
            }
            NativeBleDevice bleDevice = this.knownDevices.findDevice(deviceId2);
            BluetoothDevice bluetoothDevice = this.mBluetoothAdapter.getRemoteDevice(deviceId2);
            if (bleDevice == null) {
                bleDevice = new NativeBleDevice(bluetoothDevice, this.mBluetoothManager);
                this.knownDevices.add(bleDevice);
            } else {
                bleDevice.setBluetoothDevice(bluetoothDevice);
            }
            if (!(bleDevice.isConnected() || bleDevice.isConnecting())) {
                bleDevice.disconnectionAlreadyNotified = false;
                devicesToConnect.add(bleDevice);
                allDevicesAlreadyConnected = Boolean.valueOf(false);
            }
        }
        if (allDevicesAlreadyConnected.booleanValue()) {
            return -5;
        }
        for (NativeBleDevice device : devicesToConnect) {
            BluetoothGatt gatt = device.getBluetoothGatt();
            if (gatt == null) {
                BluetoothGatt bluetoothGatt = device.getBluetoothDevice().connectGatt(this.activity, false, this.gattCallback);
                if (bluetoothGatt == null) {
                    return -3;
                }
                device.setConnecting(true);
                device.setBluetoothGatt(bluetoothGatt);
            } else if (!gatt.connect()) {
                return -3;
            } else {
                device.setConnecting(true);
            }
        }
        return 0;
    }

    public int cancelConnectionRequests() {
        Manager.cLog("NativeManager.cancelConnectionRequests called");
        int result = _cancelConnectionRequests();
        if (result != 0) {
            return result;
        }
        notifyConnectionRequestsCanceled();
        return 0;
    }

    public int _cancelConnectionRequests() {
        Manager.cLog("NativeManager._cancelConnectionRequests called");
        if (!isBleEnabled()) {
            return -2;
        }
        Iterator it = this.knownDevices.iterator();
        while (it.hasNext()) {
            NativeBleDevice bleDevice = (NativeBleDevice) it.next();
            if (!bleDevice.isConnected()) {
                BluetoothGatt gatt = bleDevice.getBluetoothGatt();
                if (gatt != null) {
                    gatt.disconnect();
                    gatt.close();
                    bleDevice.setBluetoothGatt(null);
                }
                bleDevice.disconnectionAlreadyNotified = false;
            }
            bleDevice.setConnecting(false);
        }
        return 0;
    }

    public int disconnect(String id) {
        Manager.cLog("NativeManager.disconnect called");
        if (!isBleEnabled()) {
            return -2;
        }
        id = id.toUpperCase(Locale.US);
        if (!BluetoothAdapter.checkBluetoothAddress(id.toUpperCase(Locale.US))) {
            return -4;
        }
        NativeBleDevice bleDevice = this.knownDevices.findDevice(id);
        if (bleDevice == null) {
            return -6;
        }
        bleDevice.setConnecting(false);
        BluetoothGatt gatt = bleDevice.getBluetoothGatt();
        if (bleDevice.isConnected()) {
            bleDevice.disconnectionAlreadyNotified = false;
            if (gatt == null) {
                return -3;
            }
            gatt.disconnect();
            return 0;
        }
        if (gatt != null) {
            gatt.disconnect();
        }
        bleDevice.disconnectionAlreadyNotified = true;
        notifyDeviceDisconnected(bleDevice.getId());
        return 0;
    }

    public int read(String id, String serviceUUID, String charUUID) {
        Manager.cLog("NativeManager.read called");
        if (!isBleEnabled()) {
            return -2;
        }
        NativeBleDevice bleDevice = this.knownDevices.findDevice(id);
        if (bleDevice == null) {
            return -6;
        }
        UUID suuid = uuidFromString(serviceUUID);
        UUID cuuid = uuidFromString(charUUID);
        if (suuid == null) {
            return -15;
        }
        if (cuuid == null) {
            return -16;
        }
        int result = bleDevice.isReadyForGattOperation(suuid, cuuid);
        if (result < 0) {
            return result;
        }
        if (bleDevice.getBluetoothGatt().readCharacteristic(bleDevice.getBluetoothGatt().getService(suuid).getCharacteristic(cuuid))) {
            return 0;
        }
        return -3;
    }

    public int write(String id, String serviceUUID, String charUUID, byte[] data) {
        Manager.cLog("NativeManager.write called");
        if (!isBleEnabled()) {
            return -2;
        }
        NativeBleDevice bleDevice = this.knownDevices.findDevice(id);
        if (bleDevice == null) {
            return -6;
        }
        UUID suuid = uuidFromString(serviceUUID);
        UUID cuuid = uuidFromString(charUUID);
        if (suuid == null) {
            return -15;
        }
        if (cuuid == null) {
            return -16;
        }
        int result = bleDevice.isReadyForGattOperation(suuid, cuuid);
        if (result < 0) {
            return result;
        }
        BluetoothGattCharacteristic characteristic = bleDevice.getBluetoothGatt().getService(suuid).getCharacteristic(cuuid);
        characteristic.setValue(data);
        if (bleDevice.getBluetoothGatt().writeCharacteristic(characteristic)) {
            return 0;
        }
        return -3;
    }

    public int setNotify(String id, String serviceUUID, String charUUID, boolean enabled) {
        Manager.cLog("NativeManager.setNotify called");
        if (!isBleEnabled()) {
            return -2;
        }
        NativeBleDevice bleDevice = this.knownDevices.findDevice(id);
        if (bleDevice == null) {
            return -6;
        }
        UUID suuid = uuidFromString(serviceUUID);
        UUID cuuid = uuidFromString(charUUID);
        if (suuid == null) {
            return -15;
        }
        if (cuuid == null) {
            return -16;
        }
        int result = bleDevice.isReadyForGattOperation(suuid, cuuid);
        if (result < 0) {
            return result;
        }
        BluetoothGattCharacteristic characteristic = bleDevice.getBluetoothGatt().getService(suuid).getCharacteristic(cuuid);
        BluetoothGattDescriptor descriptor = characteristic.getDescriptor(uuidFromString("00002902-0000-1000-8000-00805f9b34fb"));
        if (descriptor == null) {
            return -3;
        }
        boolean success = bleDevice.getBluetoothGatt().setCharacteristicNotification(characteristic, enabled);
        if (success) {
            success = descriptor.setValue(BluetoothGattDescriptor.ENABLE_NOTIFICATION_VALUE);
        }
        if (success) {
            success = bleDevice.getBluetoothGatt().writeDescriptor(descriptor);
        }
        if (success) {
            return 0;
        }
        return -3;
    }
}
