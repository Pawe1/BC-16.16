package com.sigmasport;

import com.sigmasport.helper.ByteArrayHelper;
import de.pagecon.ane.nfc.Manager;
import org.json.JSONException;
import org.json.JSONObject;

public class FlashRecords extends RecordsBase {
    public static final String FIELD_CMD = "cmd";
    public static final String FIELD_COMMANDBYTESTRING = "commandByteString";
    public static final String FIELD_DATALENGTH = "dataLength";
    public static final String FIELD_FIFO_BIT = "fifoBit";
    public static final String FIELD_READ_DELAY = "readDelay";
    public int cmd;
    protected String commandByteString = "";
    private String commandString = "";
    public int dataLength = 0;
    public int fifoBit;
    public int readBlockDelay;
    public int readDelay;

    public FlashRecords(int startAddr, int endAddr, String commandString, Boolean autoInit) {
        super(startAddr, endAddr);
        if (this.endAddr > this.startAddr) {
            this.dataLength = (this.endAddr - this.startAddr) + 1;
        }
        if (this.startAddr > 0 && this.endAddr == 0) {
            this.dataLength = this.startAddr;
        }
        if (commandString.length() != 0) {
            this.commandString = commandString.trim();
            if (autoInit.booleanValue()) {
                init();
            }
        }
    }

    public void init() {
        this.cmd = Integer.valueOf(this.commandString.split(" ")[1]).intValue();
        setCommandByteString(RecordsBase.convertIntToHexByteString(this.commandString));
    }

    public String getCommandString() {
        return this.commandString;
    }

    public void setCommandByteString(String commandByteString) {
        this.commandByteString = commandByteString;
    }

    public byte[] getCommandBytes() {
        return ByteArrayHelper.hexToByte(this.commandByteString.trim());
    }

    public String toJson() {
        JSONObject json = new JSONObject();
        try {
            json.put(RecordsBase.FIELD_START_ADDR, this.startAddr);
            json.put(RecordsBase.FIELD_END_ADDR, this.endAddr);
            json.put(FIELD_DATALENGTH, this.dataLength);
            json.put(FIELD_COMMANDBYTESTRING, this.commandByteString);
            json.put(FIELD_CMD, this.cmd);
            json.put(FIELD_READ_DELAY, this.readDelay);
            json.put(FIELD_FIFO_BIT, this.fifoBit);
            json.put(RecordsBase.FIELD_BYTESTRING, this.byteString.trim());
            json.put(RecordsBase.FIELD_ERRORMESSAGE, this.errorMessage.trim());
            json.put(RecordsBase.FIELD_ERRORCODE, this.errorCode);
        } catch (JSONException e) {
            Manager.cLog("EepromRecords.toJson() Error: " + e.getMessage());
            e.printStackTrace();
        }
        return json.toString();
    }
}
