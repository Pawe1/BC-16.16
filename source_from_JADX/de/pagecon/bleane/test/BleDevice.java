package de.pagecon.bleane.test;

class BleDevice {
    public String deviceID = "";
    public String localName = "";
    public String primaryServiceUuid = "";

    BleDevice(String localName, String deviceID, String primaryServiceUuid) {
        this.localName = localName;
        this.deviceID = deviceID;
        this.primaryServiceUuid = primaryServiceUuid;
    }

    public String toString() {
        return this.localName + "\nDevice: " + this.deviceID + "\nPrimary Service: " + this.primaryServiceUuid;
    }
}
