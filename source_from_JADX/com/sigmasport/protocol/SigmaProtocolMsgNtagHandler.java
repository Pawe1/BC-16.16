package com.sigmasport.protocol;

import android.nfc.Tag;
import android.nfc.tech.NfcA;
import com.nxp.NxpNtag;
import com.nxp.NxpNtag.R_W_Methods;
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
        this.mNxpTag.close();
    }

    public void enterFifoMode() throws IOException {
        Manager.cLog("enterFifoMode mNxpTag: " + this.mNxpTag.toString());
        byte[] data = this.mNxpTag.fast_read((byte) 20, (byte) 20);
        if (data != null && data.length == 4) {
            data[1] = (byte) (data[1] | 16);
            data[3] = ChecksumUtil.calculateCrcValue(data, (byte) 1);
            this.mNxpTag.write(data, (byte) 20);
        }
    }

    public byte[] readPDTP(byte[] data, int dataSize, int cmd) throws IOException, NfcReadException {
        if (dataSize <= 0) {
            dataSize = 1;
        }
        byte[] sram = new byte[64];
        byte[] readResult = new byte[0];
        System.arraycopy(data, 0, sram, 0, data.length);
        Manager.cLog("Schreibe Command mit write_SRAM! (" + ByteArrayHelper.bytesToHex(data) + " // " + data.length + ")");
        this.mNxpTag.write_SRAM(sram, R_W_Methods.Polling_Mode);
        Manager.cLog("Command geschrieben mit write_SRAM!");
        String debugCmd = "";
        switch (cmd) {
            case 1:
                debugCmd = "NFC_GET_LIST_PH_CMD";
                break;
            case 3:
                debugCmd = "NFC_GET_PH_INFO_CMD";
                break;
            case 4:
                debugCmd = "NFC_GET_LOG_DATA_CMD";
                break;
        }
        Manager.cLog("[" + debugCmd + "]");
        switch (cmd) {
            case 1:
                sram = this.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode);
                readResult = new byte[7];
                System.arraycopy(sram, 0, readResult, 0, readResult.length);
                Manager.cLog("[" + debugCmd + "] sram: " + ByteArrayHelper.bytesToHex(sram));
                return readResult;
            case 3:
            case 4:
                int expectedDataSize = dataSize + 5;
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
                        sram = this.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode);
                        RecordsBase tmpResult = new RecordsBase(i * 64, (i + 1) * 64);
                        tmpResult.setBytes(sram);
                        Manager.dispatchNfcStepResult(tmpResult);
                        Manager.cLog("try catch read_SRam end... (" + i + ")");
                        System.arraycopy(sram, 0, readResult, i * 64, rxDataLen);
                        Manager.cLog("[" + debugCmd + "] Block " + (i + 1) + " / " + sramBlock + " \t[" + rxDataLen + " ::: " + dataSize + " ::: " + expectedDataSize + " ::: " + sram.length + "]: " + ByteArrayHelper.bytesToHex(sram));
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
            default:
                return readResult;
        }
    }
}
