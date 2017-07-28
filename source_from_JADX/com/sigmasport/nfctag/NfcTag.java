package com.sigmasport.nfctag;

import android.nfc.FormatException;
import android.nfc.NdefMessage;
import android.nfc.Tag;
import android.nfc.tech.NfcA;
import android.util.Log;
import com.nxp.Get_version_response.Prod;
import com.nxp.NxpNtag;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;
import java.util.Arrays;

public class NfcTag {
    static final byte AMS_IC_MANUFACTURER_ID = (byte) 63;
    static final byte[] AS3953_DEFAULT_CC;
    static final byte CC_MAGIC_BYTE = (byte) -31;
    private static final boolean DEBUG = true;
    static final byte NDEF_MESSAGE_TLV_TAG = (byte) 3;
    public static final int NFC_TAG_MANUAFACTUER_AMS = 0;
    public static final int NFC_TAG_MANUAFACTUER_NXP = 1;
    static final byte NXP_IC_MANUFACTURER_ID = (byte) 4;
    private static final String TAG = "NFC ANE Android Layer";
    NxpNtag mNxpTag;
    private int mTagManufacturer;

    static {
        byte[] bArr = new byte[4];
        bArr[0] = CC_MAGIC_BYTE;
        bArr[1] = (byte) 17;
        bArr[2] = (byte) 27;
        AS3953_DEFAULT_CC = bArr;
    }

    private String toHexString(byte[] data) {
        String hexString = new String();
        for (int index = 0; index < data.length; index++) {
            hexString = new StringBuilder(String.valueOf(hexString)).append(String.format("%02x", new Object[]{Byte.valueOf(data[index])})).toString();
        }
        return hexString;
    }

    public NfcTag(Tag tag) {
        Log.i(TAG, "new NfcTag()");
        byte[] uid = tag.getId();
        String uidStr = "";
        int uidLen = uid.length;
        for (int uidIdx = 0; uidLen != uidIdx; uidIdx++) {
            uidStr = new StringBuilder(String.valueOf(new StringBuilder(String.valueOf(uidStr)).append(String.format("0x%02x", new Object[]{Byte.valueOf(uid[uidIdx])})).toString())).append(" ").toString();
        }
        Log.i(TAG, "uid: " + uidStr);
        if (uid[0] == (byte) 4) {
            this.mNxpTag = new NxpNtag(NfcA.get(tag));
            this.mTagManufacturer = 1;
        }
    }

    public Tag getTag() {
        if (this.mNxpTag != null) {
            return this.mNxpTag.getTag();
        }
        return null;
    }

    public void connect() throws IOException {
        if (this.mNxpTag != null) {
            if (this.mNxpTag.isConnected()) {
                this.mNxpTag.close();
            }
            this.mNxpTag.connect();
        }
    }

    public void close() throws IOException {
        Manager.cLog("close NfcTag mNxpTag: " + this.mNxpTag.toString());
        if (this.mNxpTag != null) {
            this.mNxpTag.close();
        }
    }

    public boolean isConnected() {
        if (this.mNxpTag != null) {
            return this.mNxpTag.isConnected();
        }
        return false;
    }

    public byte[] getEepromBlock() throws IOException {
        byte[] result = null;
        if (this.mNxpTag != null) {
            return this.mNxpTag.readEeprom(getUserDataStartAddress(), getUserDataSize());
        }
        return result;
    }

    public byte[] getEepromBlock(int startAdd, int endAddr, boolean isSingleSector) throws IOException {
        byte[] result = null;
        if (this.mNxpTag != null) {
            return this.mNxpTag.read_EEPROM(startAdd, endAddr, isSingleSector);
        }
        return result;
    }

    public byte[] getEepromBlock(int startAdd, int endAddr) throws IOException {
        byte[] result = null;
        if (this.mNxpTag != null) {
            return this.mNxpTag.read_EEPROM(startAdd, endAddr, false);
        }
        return result;
    }

    public void writeEepromBlock(int startAdd, byte[] data) throws IOException {
        if (this.mNxpTag != null) {
            this.mNxpTag.writeEeprom(startAdd, data);
        }
    }

    public int getTagManufacturer() {
        return this.mTagManufacturer;
    }

    public byte[] getVersion() throws IOException {
        byte[] result = null;
        if (this.mNxpTag != null) {
            return this.mNxpTag.getVersion();
        }
        return result;
    }

    public int getUserDataStartAddress() {
        if (this.mNxpTag != null) {
            return this.mNxpTag.getUserDataStartAddress();
        }
        return 0;
    }

    public void setUserDataSize(int size) {
        if (this.mNxpTag != null) {
            this.mNxpTag.setSigmaUserDataSize(size);
        }
    }

    public int getUserDataSize() {
        if (this.mNxpTag != null) {
            return this.mNxpTag.getSigmaUserDataSize();
        }
        return 0;
    }

    public NdefMessage getNdefMessage() throws FormatException, IOException {
        if (this.mNxpTag == null) {
            throw new FormatException("Tag is not AMS or NXP chipset");
        } else if (this.mNxpTag.readEeprom(this.mNxpTag.getUserDataStartAddress() - 1, 4)[0] != CC_MAGIC_BYTE) {
            Log.e(TAG, "Capability Container magic byte incorrect");
            throw new FormatException("Tag does not contain any valid NDEF Message");
        } else {
            byte[] tlvNdef = this.mNxpTag.readEeprom(this.mNxpTag.getUserDataStartAddress(), 4);
            if (tlvNdef[0] != (byte) 3) {
                Log.e(TAG, "data does not start with an NDEF Message TLV tag");
                throw new FormatException("Tag does not contain any valid NDEF Message");
            }
            int remainder;
            int endAddr = tlvNdef[1] / 4;
            if (tlvNdef[1] % 4 == 0) {
                remainder = 0;
            } else {
                remainder = 1;
            }
            int startAddr = this.mNxpTag.getUserDataStartAddress() + 1;
            byte[] data = this.mNxpTag.read_EEPROM(startAddr, endAddr + ((startAddr + remainder) - 1), false);
            byte[] result = new byte[(data.length + tlvNdef.length)];
            System.arraycopy(tlvNdef, 0, result, 0, tlvNdef.length);
            System.arraycopy(data, 0, result, tlvNdef.length, data.length);
            return new NdefMessage(Arrays.copyOfRange(result, 2, (result[1] & 255) + 2));
        }
    }

    public void writeSigmaNdefMessage(NdefMessage msg) throws IOException, FormatException {
        Log.d(TAG, "writeNdefMessage-writeEeprom");
        byte[] data = msg.toByteArray();
        byte[] ndefTlv = new byte[(data.length + 2)];
        ndefTlv[0] = (byte) 3;
        ndefTlv[1] = (byte) data.length;
        System.arraycopy(data, 0, ndefTlv, 2, data.length);
        if (this.mNxpTag != null) {
            this.mNxpTag.writeEeprom(this.mNxpTag.getUserDataStartAddress(), ndefTlv);
        }
    }

    public int getMaxSize() {
        return getUserDataSize();
    }

    public int getMaxNdefSize() {
        if (this.mNxpTag != null) {
            return this.mNxpTag.getNdefUserDataSize();
        }
        return getUserDataSize();
    }

    public void determineNdefMessageSize(Prod product) throws IOException {
        if (this.mNxpTag != null) {
            this.mNxpTag.determineNdefMessageSize(product);
        }
    }
}
