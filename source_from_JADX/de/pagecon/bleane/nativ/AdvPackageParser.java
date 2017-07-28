package de.pagecon.bleane.nativ;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AdvPackageParser {
    protected static final char[] hexArray = "0123456789ABCDEF".toCharArray();
    private String localName = "";
    private List<String> primaryServiceUUIDs = new ArrayList();

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[(bytes.length * 2)];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 255;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[(j * 2) + 1] = hexArray[v & 15];
        }
        return new String(hexChars);
    }

    public static String createUuid(byte[] data) {
        String uuid = bytesToHex(data);
        if (uuid.length() == 4) {
            return uuid.substring(0, 4);
        }
        if (uuid.length() == 16 || uuid.length() != 32) {
            return uuid;
        }
        return uuid.substring(0, 8) + "-" + uuid.substring(8, 12) + "-" + uuid.substring(12, 16) + "-" + uuid.substring(16, 20) + "-" + uuid.substring(20, 32);
    }

    public AdvPackageParser(byte[] scanRecord) {
        if (scanRecord.length != 0) {
            int currentIndex = 0;
            while (currentIndex < scanRecord.length) {
                byte length = scanRecord[currentIndex];
                byte type = scanRecord[currentIndex + 1];
                if (type == (byte) 8 || type == (byte) 9) {
                    this.localName = new String(Arrays.copyOfRange(scanRecord, currentIndex + 2, (currentIndex + length) + 1));
                } else if (type == (byte) 2 || type == (byte) 3 || type == (byte) 4 || type == (byte) 5 || type == (byte) 6 || type == (byte) 7) {
                    int serviceUUIDLength = 0;
                    if (type == (byte) 2 || type == (byte) 3) {
                        serviceUUIDLength = 2;
                    }
                    if (type == (byte) 4 || type == (byte) 5) {
                        serviceUUIDLength = 4;
                    }
                    if (type == (byte) 6 || type == (byte) 7) {
                        serviceUUIDLength = 16;
                    }
                    for (int currentServiceIndex = currentIndex + 2; currentServiceIndex < currentIndex + length; currentServiceIndex += serviceUUIDLength) {
                        byte[] reversedServiceUuid = Arrays.copyOfRange(scanRecord, currentServiceIndex, currentServiceIndex + serviceUUIDLength);
                        byte[] serviceUuid = new byte[reversedServiceUuid.length];
                        for (int i = 0; i < reversedServiceUuid.length; i++) {
                            serviceUuid[(reversedServiceUuid.length - 1) - i] = reversedServiceUuid[i];
                        }
                        this.primaryServiceUUIDs.add(createUuid(serviceUuid));
                    }
                }
                currentIndex = (currentIndex + length) + 1;
                if (currentIndex >= scanRecord.length) {
                    return;
                }
                if (scanRecord[currentIndex] == (byte) 0) {
                    return;
                }
            }
        }
    }

    public List<String> getPrimaryServiceUUIDs() {
        return this.primaryServiceUUIDs;
    }

    public String getLocalName() {
        return this.localName;
    }
}
