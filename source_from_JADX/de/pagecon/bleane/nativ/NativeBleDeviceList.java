package de.pagecon.bleane.nativ;

import java.util.Iterator;
import java.util.LinkedList;

public class NativeBleDeviceList extends LinkedList<NativeBleDevice> {
    private static final long serialVersionUID = 1;

    public NativeBleDevice findDevice(String id) {
        Iterator<NativeBleDevice> iterator = iterator();
        while (iterator.hasNext()) {
            NativeBleDevice bleDevice = (NativeBleDevice) iterator.next();
            if (bleDevice.getId().toString().equalsIgnoreCase(id)) {
                return bleDevice;
            }
        }
        return null;
    }
}
