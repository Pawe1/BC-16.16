package com.sigmasport.protocol;

import android.nfc.Tag;
import android.nfc.tech.NfcA;
import com.nxp.NxpNtag;
import com.nxp.NxpNtag.R_W_Methods;
import com.sigmasport.FlashRecords;
import com.sigmasport.RecordsBase;
import com.sigmasport.helper.ByteArrayHelper;
import com.sigmasport.misc.ChecksumUtil;
import de.pagecon.ane.exceptions.NfcReadException;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

public class SigmaProtocolMsgNtagHandler {
    NxpNtag mNxpTag;

    public SigmaProtocolMsgNtagHandler(Tag tag) throws IOException {
        this.mNxpTag = new NxpNtag(NfcA.get(tag));
    }

    public void connect() throws IOException {
        if (!this.mNxpTag.isConnected()) {
            Manager.cLog("connect to mNxpTag: " + this.mNxpTag.toString());
            this.mNxpTag.connect();
        }
    }

    public Boolean isConnected() {
        if (this.mNxpTag == null) {
            return Boolean.valueOf(false);
        }
        return Boolean.valueOf(this.mNxpTag.isConnected());
    }

    public void close() throws IOException {
        Manager.cLog("close SigmaProtocolMsgNtagHandler mNxpTag: " + this.mNxpTag.toString());
        if (this.mNxpTag != null) {
            this.mNxpTag.close();
        }
    }

    public void enterFifoMode(int fifoBit) throws IOException {
        Manager.cLog("enterFifoMode (Bit: " + fifoBit + ") mNxpTag: " + this.mNxpTag.toString());
        byte[] data = this.mNxpTag.fast_read((byte) 20, (byte) 20);
        if (data != null && data.length == 4) {
            data[1] = (byte) (data[1] | ((byte) fifoBit));
            data[3] = ChecksumUtil.calculateCrcValue(data, (byte) 1);
            this.mNxpTag.write(data, (byte) 20);
        }
    }

    public byte[] readPDTP(FlashRecords flashRecord) throws IOException, NfcReadException {
        byte[] data = flashRecord.getCommandBytes();
        if (flashRecord.dataLength <= 0) {
            flashRecord.dataLength = 1;
        }
        byte[] sram = new byte[64];
        byte[] readResult = new byte[0];
        System.arraycopy(data, 0, sram, 0, data.length);
        Manager.cLog("Schreibe Command mit write_SRAM! (" + ByteArrayHelper.bytesToHex(data) + " // " + data.length + ")");
        this.mNxpTag.write_SRAM(sram, R_W_Methods.Polling_Mode);
        int expectedDataSize = flashRecord.dataLength + 5;
        int sramBlock = (int) Math.ceil(((double) expectedDataSize) / 64.0d);
        Manager.cLog("expectedDataSize: " + expectedDataSize);
        Manager.cLog("sramBlock: " + sramBlock);
        readResult = new byte[expectedDataSize];
        int i = 0;
        while (i < sramBlock) {
            int rxDataLen;
            if (expectedDataSize > 64) {
                rxDataLen = 64;
                expectedDataSize -= 64;
            } else {
                rxDataLen = expectedDataSize;
            }
            try {
                sram = this.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode, flashRecord.readDelay, flashRecord.readBlockDelay);
                RecordsBase tmpResult = new RecordsBase(i * 64, (i + 1) * 64);
                tmpResult.setBytes(sram);
                Manager.dispatchNfcStepResult(tmpResult);
                Manager.cLog("try catch read_SRam end... (" + i + ")");
                System.arraycopy(sram, 0, readResult, i * 64, rxDataLen);
                Manager.cLog("Block " + (i + 1) + " / " + sramBlock + " \t[" + rxDataLen + " ::: " + flashRecord.dataLength + " ::: " + expectedDataSize + " ::: " + sram.length + "]: " + ByteArrayHelper.bytesToHex(sram));
                i++;
            } catch (Exception e) {
                Manager.cLog("Error while reading SRam in readPDTP! (" + i + " / " + rxDataLen + ")");
                NfcReadException newException = new NfcReadException(e.getMessage());
                newException.blocksRead = i;
                newException.readResult = readResult;
                throw newException;
            }
        }
        return readResult;
    }

    public byte[] writePDTP(byte[] data) throws IOException, NfcReadException {
        byte[] readResult = new byte[0];
        byte[] sram = new byte[64];
        byte cmd = data[0];
        byte subCmd = data[1];
        switch (cmd) {
            case de.pagecon.bleane.extension.Manager.ERROR_BLE_READ_FAILED /*-11*/:
                Manager.cLog("cmd: NFC_SET_ERASE_CMD");
                if (subCmd != (byte) 1) {
                    return readResult;
                }
                Manager.cLog("subCmd: NFC_SET_ERASE_BLOCK_CMD === " + subCmd);
                System.arraycopy(data, 0, sram, 0, data.length);
                this.mNxpTag.write_SRAM(sram, R_W_Methods.Polling_Mode);
                Manager.cLog("SF Block erase rqst cmd issue!");
                try {
                    Thread.sleep(2100);
                } catch (InterruptedException e) {
                    Manager.cLog("InterruptedException e: " + e.getMessage());
                    e.printStackTrace();
                }
                sram = this.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode);
                readResult = new byte[sram.length];
                System.arraycopy(sram, 0, readResult, 0, sram.length);
                Manager.cLog("read data: " + toHexString(readResult));
                return readResult;
            case de.pagecon.bleane.extension.Manager.ERROR_BLE_CONNECT_FAILED /*-7*/:
                Manager.cLog("cmd: NFC_SET_SF_CMD");
                int dataLen = data.length;
                int txLen = 0;
                int txIdx = 0;
                Manager.cLog("dataLen: " + dataLen);
                while (dataLen != 0) {
                    if (dataLen / 64 > 0) {
                        txLen = 64;
                    } else {
                        try {
                            txLen = dataLen % 64;
                        } catch (Exception e2) {
                            Manager.cLog("Error while writing SRam in writePDTP! (txIdx: " + txIdx + " | txLen: " + txLen + " | dataLen: " + dataLen + ")");
                            throw new NfcReadException(e2.getMessage());
                        }
                    }
                    System.arraycopy(data, txIdx, sram, 0, txLen);
                    this.mNxpTag.write_SRAM(sram, R_W_Methods.Polling_Mode);
                    Manager.cLog("txIdx: " + txIdx + " | txLen: " + txLen + " | dataLen: " + dataLen);
                    RecordsBase tmpResult = new RecordsBase(txIdx, txIdx + txLen);
                    tmpResult.setBytes(sram);
                    Manager.dispatchNfcStepResult(tmpResult);
                    txIdx += txLen;
                    dataLen -= txLen;
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e3) {
                        Manager.cLog("InterruptedException e: " + e3.getMessage());
                        e3.printStackTrace();
                    }
                }
                sram = this.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode);
                readResult = new byte[sram.length];
                System.arraycopy(sram, 0, readResult, 0, sram.length);
                Manager.cLog("read data: " + toHexString(readResult));
                return readResult;
            default:
                return readResult;
        }
    }

    private String toHexString(byte[] data) {
        String hexString = new String();
        for (int index = 0; index < data.length; index++) {
            hexString = new StringBuilder(String.valueOf(hexString)).append(String.format("%02x", new Object[]{Byte.valueOf(data[index])})).toString();
        }
        return hexString;
    }
}
