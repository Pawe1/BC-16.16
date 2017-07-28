package de.pagecon.bleane.cc2540;

import de.pagecon.bleane.util.Helper;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map.Entry;

public class BleDevice {
    private static final char[] hexArray = "0123456789ABCDEF".toCharArray();
    private HashMap<String, Integer> characteristics = new HashMap();
    private int connHandle = 65535;
    private String deviceId = "";
    public Boolean discoveryNotified = Boolean.valueOf(false);
    private byte[] hwAddress = null;
    public String name = "";
    public Boolean notifyDiscovery = Boolean.valueOf(false);
    public String primaryServiceUuid = "";

    public static Boolean isHexChar(char ch) {
        if (ch >= '0' && ch <= '9') {
            return Boolean.valueOf(true);
        }
        if (ch >= 'A' && ch <= 'F') {
            return Boolean.valueOf(true);
        }
        if (ch < 'a' || ch > 'f') {
            return Boolean.valueOf(false);
        }
        return Boolean.valueOf(true);
    }

    public static String byteArrayToAddressString(byte[] bytes) {
        char[] address = new char[(bytes.length * 3)];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 255;
            address[j * 3] = hexArray[v >>> 4];
            address[(j * 3) + 1] = hexArray[v & 15];
            address[(j * 3) + 2] = ':';
        }
        return new String(Arrays.copyOf(address, (bytes.length * 3) - 1));
    }

    private static byte[] addressStringToByteArray(String addressString) {
        byte[] data = new byte[6];
        int i = 0;
        int j = 0;
        while (i < addressString.length()) {
            char c = addressString.charAt(i);
            if (isHexChar(c).booleanValue()) {
                data[j] = (byte) ((Character.digit(c, 16) << 4) + Character.digit(addressString.charAt(i + 1), 16));
                j++;
                i += 2;
            } else {
                i++;
            }
        }
        return data;
    }

    synchronized Boolean isScanInfoComplete() {
        Boolean valueOf;
        valueOf = (this.name.isEmpty() || this.deviceId.isEmpty() || this.primaryServiceUuid.isEmpty()) ? Boolean.valueOf(false) : Boolean.valueOf(true);
        return valueOf;
    }

    synchronized Boolean equals(BleDevice otherDevice) {
        return Boolean.valueOf(Helper.stringEqualsIgnoreCase(this.deviceId, otherDevice.deviceId));
    }

    synchronized String getDeviceId() {
        return this.deviceId;
    }

    synchronized void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
        this.hwAddress = addressStringToByteArray(deviceId);
    }

    synchronized byte[] getHwAddress() {
        return this.hwAddress;
    }

    synchronized void setHwAddress(byte[] hwAddress) {
        this.hwAddress = hwAddress;
        this.deviceId = byteArrayToAddressString(this.hwAddress);
    }

    synchronized Boolean isConnected() {
        return this.connHandle != 65535 ? Boolean.valueOf(true) : Boolean.valueOf(false);
    }

    synchronized Integer getHandleForCharacteristicUuid(String characteristicUuid) {
        return (Integer) this.characteristics.get(characteristicUuid);
    }

    synchronized void addCharacteristicHandle(String characteristicUuid, int handle) {
        this.characteristics.put(characteristicUuid, Integer.valueOf(handle));
    }

    synchronized String getCharacteristicUuidForHandle(int charHandle) {
        String uuid;
        uuid = "";
        if (this.characteristics.size() != 0 && charHandle != 255) {
            for (Entry<String, Integer> pairs : this.characteristics.entrySet()) {
                if (((Integer) pairs.getValue()).equals(Integer.valueOf(charHandle))) {
                    uuid = (String) pairs.getKey();
                    break;
                }
            }
        }
        uuid = "";
        return uuid;
    }

    synchronized int getConnectionHandle() {
        return this.connHandle;
    }

    synchronized void setConnectionHandle(int val) {
        this.characteristics.clear();
        this.connHandle = val;
    }
}
