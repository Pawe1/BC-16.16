package de.pagecon.bleane.cc2540;

import de.pagecon.bleane.util.Helper;
import java.util.Iterator;
import java.util.LinkedList;

public class TS_BleDeviceList {
    private LinkedList<BleDevice> devices = new LinkedList();

    synchronized int getSize() {
        return this.devices.size();
    }

    synchronized void clear() {
        Iterator it = this.devices.iterator();
        while (it.hasNext()) {
            ((BleDevice) it.next()).discoveryNotified = Boolean.valueOf(false);
        }
        this.devices.clear();
    }

    synchronized void addDevice(BleDevice device) {
        this.devices.add(device);
    }

    synchronized void removeDevice(BleDevice device) {
        this.devices.remove(device);
    }

    synchronized BleDevice findDevice(String deviceId) {
        BleDevice device;
        BleDevice dev;
        device = null;
        Iterator it = this.devices.iterator();
        do {
            if (!it.hasNext()) {
                break;
            }
            dev = (BleDevice) it.next();
        } while (!Helper.stringEqualsIgnoreCase(dev.getDeviceId(), deviceId));
        device = dev;
        return device;
    }

    synchronized BleDevice findDevice(int connHandle) {
        BleDevice device;
        BleDevice dev;
        device = null;
        Iterator it = this.devices.iterator();
        do {
            if (!it.hasNext()) {
                break;
            }
            dev = (BleDevice) it.next();
        } while (dev.getConnectionHandle() != connHandle);
        device = dev;
        return device;
    }

    synchronized BleDevice getDeviceAtIndex(int index) {
        BleDevice bleDevice;
        if (index >= 0) {
            if (index < this.devices.size()) {
                bleDevice = (BleDevice) this.devices.get(index);
            }
        }
        bleDevice = null;
        return bleDevice;
    }
}
