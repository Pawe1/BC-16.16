package com.ams;

import android.nfc.FormatException;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.Tag;
import android.nfc.tech.TagTechnology;
import android.util.Log;
import java.io.IOException;
import java.util.Arrays;

public class As3953Ndef implements TagTechnology {
    public static final String AMS_TYPE_AS3953 = "com.ams.ndef.as3953";
    static final byte CC_MAGIC_BYTE = (byte) -31;
    static final int CC_SIZE = 4;
    static final byte[] DEFAULT_CC;
    static final byte LOCK_CONTROL_TLV_TAG = (byte) 1;
    static final byte MEMORY_CONTROL_TLV_TAG = (byte) 2;
    static final byte NDEF_MESSAGE_TLV_TAG = (byte) 3;
    static final byte NULL_TLV_TAG = (byte) 0;
    static final byte PROPRIETARY_TLV_TAG = (byte) -3;
    static final String TAG = As3953Ndef.class.getName();
    static final byte TERMINATOR_TLV_TAG = (byte) -2;
    As3953 mAs3953;
    byte[] mCc;

    static {
        byte[] bArr = new byte[4];
        bArr[0] = CC_MAGIC_BYTE;
        bArr[1] = (byte) 17;
        bArr[2] = (byte) 27;
        DEFAULT_CC = bArr;
    }

    private As3953Ndef(As3953 as3953) {
        this.mAs3953 = as3953;
    }

    public void close() throws IOException {
        this.mAs3953.close();
    }

    public void connect() throws IOException {
        this.mAs3953.connect();
        if (!this.mAs3953.mHasPDTP) {
            this.mCc = this.mAs3953.readEeprom(this.mAs3953.getUserDataStartAddress() + 16, 4);
        }
    }

    public Tag getTag() {
        return this.mAs3953.getTag();
    }

    public boolean isConnected() {
        return this.mAs3953.isConnected();
    }

    public static As3953Ndef get(Tag tag) {
        As3953 as3953 = As3953.get(tag);
        if (as3953 != null) {
            return new As3953Ndef(as3953);
        }
        return null;
    }

    public boolean canMakeReadOnly() {
        return false;
    }

    public NdefMessage getCachedNdefMessage() {
        return null;
    }

    public NdefMessage getNdefMessage() throws FormatException, IOException {
        if (this.mAs3953.mHasPDTP) {
            return new NdefMessage(new NdefRecord[]{new NdefRecord((short) 5, new byte[0], new byte[0], this.mAs3953.pdtpRead())});
        }
        byte[] cc = this.mAs3953.readEeprom(this.mAs3953.getUserDataStartAddress() + 16, 4);
        byte[] data = this.mAs3953.readEeprom((this.mAs3953.getUserDataStartAddress() + 16) + 1, this.mAs3953.getNdefUserDataSize() - 4);
        if (cc[0] != CC_MAGIC_BYTE) {
            Log.e(TAG, "Capability Container magic byte incorrect");
            throw new FormatException("Tag does not contain any valid NDEF Message");
        } else if (data[0] == (byte) 3) {
            return new NdefMessage(Arrays.copyOfRange(data, 2, (data[1] & 255) + 2));
        } else {
            Log.e(TAG, "data does not start with an NDEF Message TLV tag");
            throw new FormatException("Tag does not contain any valid NDEF Message");
        }
    }

    public byte[] getEepromBlock() throws IOException {
        Log.d(TAG, "getEepromBlock");
        return this.mAs3953.readEeprom(this.mAs3953.getUserDataStartAddress(), this.mAs3953.getSigmaUserDataSize());
    }

    public void writeEepromUserDataBlock(byte[] data) throws IOException {
        Log.d(TAG, "writeEepromUserDataBlock");
        this.mAs3953.writeEeprom(this.mAs3953.getUserDataStartAddress(), data);
    }

    public void writeSigmaSetting(int address, byte[] data) throws IOException {
        Log.d(TAG, "writeSigmaSetting: address=" + address);
        this.mAs3953.writeEeprom(address, data);
    }

    public int getMaxSize() {
        return (this.mAs3953.getNdefUserDataSize() - 4) - 2;
    }

    public String getType() {
        return AMS_TYPE_AS3953;
    }

    public boolean isWritable() {
        return true;
    }

    public boolean makeReadOnly() throws IOException {
        return false;
    }

    public void writeNdefMessage(NdefMessage msg) throws IOException, FormatException {
        if (this.mAs3953.mHasPDTP) {
            Log.d(TAG, "writeNdefMessage-pdtpWrite");
            this.mAs3953.pdtpWrite(msg.getRecords()[0].getPayload());
            return;
        }
        Log.d(TAG, "writeNdefMessage-writeEeprom");
        byte[] data = msg.toByteArray();
        byte[] ndefTlv = new byte[(data.length + 2)];
        ndefTlv[0] = (byte) 3;
        ndefTlv[1] = (byte) data.length;
        System.arraycopy(data, 0, ndefTlv, 2, data.length);
        if (ndefTlv.length + DEFAULT_CC.length > this.mAs3953.getNdefUserDataSize()) {
            throw new FormatException("NdefMessage too large for the tag");
        }
        this.mAs3953.writeEeprom(this.mAs3953.getUserDataStartAddress() + 16, DEFAULT_CC);
        this.mAs3953.writeEeprom((this.mAs3953.getUserDataStartAddress() + 16) + 1, ndefTlv);
    }

    public void writeSigmaNdefMessage(NdefMessage msg) throws IOException, FormatException {
        Log.d(TAG, "writeNdefMessage-writeEeprom");
        byte[] data = msg.toByteArray();
        byte[] ndefTlv = new byte[(data.length + 2)];
        ndefTlv[0] = (byte) 3;
        ndefTlv[1] = (byte) data.length;
        System.arraycopy(data, 0, ndefTlv, 2, data.length);
        if (ndefTlv.length + DEFAULT_CC.length > this.mAs3953.getNdefUserDataSize()) {
            throw new FormatException("NdefMessage too large for the tag");
        }
        this.mAs3953.writeEeprom(this.mAs3953.getUserDataStartAddress() + 16, DEFAULT_CC);
        this.mAs3953.writeEeprom((this.mAs3953.getUserDataStartAddress() + 16) + 1, ndefTlv);
    }
}
