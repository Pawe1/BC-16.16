package de.pagecon.bleane.nativ;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothManager;
import java.util.UUID;

public class NativeBleDevice {
    private BluetoothDevice bluetoothDevice;
    private BluetoothGatt bluetoothGatt;
    private BluetoothManager bluetoothManager;
    public boolean disconnectionAlreadyNotified;
    private boolean isConnecting;
    private String primaryServiceUuid;
    private boolean servicesDiscovered;

    public NativeBleDevice(BluetoothDevice bluetoothDevice, String primaryServiceUuid, BluetoothManager bluetoothManager) {
        this.servicesDiscovered = false;
        this.isConnecting = false;
        this.disconnectionAlreadyNotified = false;
        this.bluetoothManager = bluetoothManager;
        this.bluetoothDevice = bluetoothDevice;
        this.primaryServiceUuid = primaryServiceUuid;
    }

    public NativeBleDevice(BluetoothDevice device, BluetoothManager bluetoothManager) {
        this(device, "", bluetoothManager);
    }

    public String getPrimaryServiceUuid() {
        return this.primaryServiceUuid;
    }

    public void setPrimaryServiceUuid(String primaryServiceUuid) {
        this.primaryServiceUuid = primaryServiceUuid;
    }

    public BluetoothDevice getBluetoothDevice() {
        return this.bluetoothDevice;
    }

    public void setBluetoothDevice(BluetoothDevice bluetoothDevice) {
        this.bluetoothDevice = bluetoothDevice;
    }

    public String getId() {
        return this.bluetoothDevice.getAddress().toString();
    }

    public BluetoothGatt getBluetoothGatt() {
        return this.bluetoothGatt;
    }

    public void setBluetoothGatt(BluetoothGatt bluetoothGatt) {
        this.bluetoothGatt = bluetoothGatt;
    }

    public boolean isServicesDiscovered() {
        return this.servicesDiscovered;
    }

    public void setServicesDiscovered(boolean servicesDiscovered) {
        this.servicesDiscovered = servicesDiscovered;
    }

    public boolean isConnected() {
        if (this.bluetoothManager.getDevicesMatchingConnectionStates(7, new int[]{2}).contains(this.bluetoothDevice)) {
            return true;
        }
        return false;
    }

    public void setConnecting(boolean connecting) {
        this.isConnecting = connecting;
    }

    public boolean isConnecting() {
        return this.isConnecting;
    }

    public int isReady() {
        if (isConnected() && this.bluetoothGatt != null && isServicesDiscovered()) {
            return 0;
        }
        return -6;
    }

    public boolean containsServiceAndCharacteristic(UUID suuid, UUID cuuid) {
        if (this.bluetoothGatt.getService(suuid) == null || this.bluetoothGatt.getService(suuid).getCharacteristic(cuuid) == null) {
            return false;
        }
        return true;
    }

    public int isReadyForGattOperation(UUID primaryServiceUUID, UUID charUUID) {
        int ret = isReady();
        if (ret < 0) {
            return ret;
        }
        if (containsServiceAndCharacteristic(primaryServiceUUID, charUUID)) {
            return 0;
        }
        return -14;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        if (this.bluetoothDevice.equals(((NativeBleDevice) o).bluetoothDevice)) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return this.bluetoothDevice.hashCode();
    }
}
