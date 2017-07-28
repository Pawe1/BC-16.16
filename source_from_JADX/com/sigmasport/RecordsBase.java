package com.sigmasport;

import com.sigmasport.helper.ByteArrayHelper;
import de.pagecon.ane.nfc.Manager;
import org.json.JSONException;
import org.json.JSONObject;

public class RecordsBase {
    public static final String FIELD_BYTESTRING = "byteString";
    public static final String FIELD_END_ADDR = "endAddr";
    public static final String FIELD_ERRORCODE = "errorCode";
    public static final String FIELD_ERRORMESSAGE = "errorMessage";
    public static final String FIELD_START_ADDR = "startAddr";
    protected String byteString = "";
    public int endAddr = 0;
    public int errorCode = 0;
    public String errorMessage = "";
    public int startAddr = 0;

    public RecordsBase(int startAddr, int endAddr) {
        this.startAddr = startAddr;
        this.endAddr = endAddr;
    }

    public void appendBytes(byte[] bytes) {
        this.byteString += ByteArrayHelper.bytesToHex(bytes).trim() + " ";
    }

    public void setBytes(byte[] bytes) {
        this.byteString = ByteArrayHelper.bytesToHex(bytes).trim();
    }

    public byte[] getBytes() {
        return ByteArrayHelper.hexToByte(this.byteString.trim());
    }

    public String getByteString() {
        return this.byteString.trim();
    }

    public void setByteString(String byteString) {
        this.byteString = byteString;
    }

    public static String convertIntToHexByteString(String intByteString) {
        String hexByteString = "";
        String leadingZeros = "00";
        for (String valueOf : intByteString.split(" ")) {
            String hexValue = Integer.toHexString(Integer.valueOf(valueOf).intValue());
            hexByteString = new StringBuilder(String.valueOf(hexByteString)).append(" ").append(new StringBuilder(String.valueOf(leadingZeros)).append(hexValue).toString().substring(hexValue.length()).toUpperCase()).toString();
        }
        return hexByteString.trim();
    }

    public String toJson() {
        JSONObject json = new JSONObject();
        try {
            json.put(FIELD_START_ADDR, this.startAddr);
            json.put(FIELD_END_ADDR, this.endAddr);
            json.put(FIELD_BYTESTRING, this.byteString.trim());
            json.put(FIELD_ERRORMESSAGE, this.errorMessage.trim());
            json.put(FIELD_ERRORCODE, this.errorCode);
        } catch (JSONException e) {
            Manager.cLog("EepromRecords.toJson() Error: " + e.getMessage());
            e.printStackTrace();
        }
        return json.toString();
    }
}
