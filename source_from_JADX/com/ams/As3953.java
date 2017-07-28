package com.ams;

import android.nfc.Tag;
import android.nfc.tech.NfcA;
import android.nfc.tech.TagTechnology;
import android.os.Build;
import com.sigmasport.misc.NfcProprietaryCmd;
import java.io.IOException;
import java.util.Arrays;

public class As3953 implements TagTechnology {
    static final byte AMS_AS3953_CHIP_TYPE = (byte) 16;
    static final byte AMS_IC_MANUFACTURER_ID = (byte) 63;
    private static final boolean DEBUG = false;
    static final byte ERR_CODING = (byte) 97;
    static final byte ERR_LOCKED = (byte) 98;
    static final byte ERR_OK = (byte) -112;
    static final byte ERR_POWER_FAIL = (byte) 99;
    static final byte PROPRIETARY_COMMAND_PFB = (byte) 85;
    static final byte READ_COMMAND = (byte) 2;
    private static final String TAG = "com.ams.As3953";
    static final byte WAKE_UP_COMMAND = (byte) 1;
    static final byte WRITE_COMMAND = (byte) 4;
    boolean mHasPDTP;
    NfcA mNfcA;
    private String mPhoneManufacturer = Build.MANUFACTURER;

    private String toHexString(byte[] data) {
        String hexString = new String();
        for (int index = 0; index < data.length; index++) {
            hexString = new StringBuilder(String.valueOf(hexString)).append(String.format("%02x", new Object[]{Byte.valueOf(data[index])})).toString();
        }
        return hexString;
    }

    private As3953(NfcA nfca) {
        this.mNfcA = nfca;
    }

    private int fwiToMilliseconds(int fwi) {
        return (((1 << fwi) * 4096) / 13560) + 1;
    }

    private void activateLayer4() throws IOException {
        byte[] ats = this.mNfcA.transceive(new byte[]{(byte) -32, Byte.MIN_VALUE});
        if (this.mPhoneManufacturer.equalsIgnoreCase("Xiaomi")) {
            if (ats.length > 6) {
                throw new IOException("ISO 14443-4 activation of AS3953 failed");
            }
        } else if (ats.length != 5) {
            throw new IOException("ISO 14443-4 activation of AS3953 failed");
        }
        this.mNfcA.setTimeout(fwiToMilliseconds((ats[3] & 240) >> 4));
    }

    public static As3953 get(Tag tag) {
        if (!Arrays.asList(tag.getTechList()).contains("android.nfc.tech.NfcA")) {
            return null;
        }
        byte[] uid = tag.getId();
        if (uid.length >= 2 && uid[0] == AMS_IC_MANUFACTURER_ID && uid[1] == AMS_AS3953_CHIP_TYPE) {
            return new As3953(NfcA.get(tag));
        }
        return null;
    }

    public void close() throws IOException {
        byte[] sDeselect = new byte[]{(byte) -62};
        byte[] sDeselectResponse = new byte[0];
        try {
            if (this.mNfcA.isConnected()) {
                sDeselectResponse = this.mNfcA.transceive(sDeselect);
            }
        } catch (IOException e) {
        }
        this.mNfcA.close();
    }

    public void connect() throws IOException {
        try {
            this.mNfcA.connect();
        } catch (IOException e) {
            String errorMessage = "Fail to connect Nfc tag";
            if (e.getMessage() == null) {
                throw new IOException(errorMessage);
            }
        }
        activateLayer4();
    }

    public Tag getTag() {
        return this.mNfcA.getTag();
    }

    public boolean isConnected() {
        return this.mNfcA.isConnected();
    }

    public void wakeUp() throws IOException {
        this.mNfcA.transceive(new byte[]{PROPRIETARY_COMMAND_PFB, (byte) 1});
    }

    public byte[] readEeprom(int address, int length) throws IOException {
        if (length == 0) {
            return new byte[0];
        }
        int inPtr = 0;
        int numWordsToRead = ((length - 1) / 4) + 1;
        byte[] result = new byte[(numWordsToRead * 4)];
        while (numWordsToRead > 0) {
            int chunkSize;
            if (numWordsToRead > 8) {
                chunkSize = 8;
            } else {
                chunkSize = numWordsToRead;
            }
            byte[] readResult = this.mNfcA.transceive(new byte[]{PROPRIETARY_COMMAND_PFB, (byte) 2, (byte) (address * 2), (byte) chunkSize});
            if (this.mPhoneManufacturer.equalsIgnoreCase("Xiaomi")) {
                if (readResult.length - 1 != (chunkSize * 4) + 2) {
                    throw new IOException("AS3953 EEPROM read failed: incorrect response length");
                }
            } else if (readResult.length != (chunkSize * 4) + 2) {
                throw new IOException("AS3953 EEPROM read failed: incorrect response length");
            }
            if (readResult[0] != PROPRIETARY_COMMAND_PFB) {
                throw new IOException("AS3953 EEPROM read failed: PFB format error");
            } else if (readResult[1] == ERR_CODING) {
                throw new IOException("AS3953 EEPROM read failed: read command coding error");
            } else if (readResult[1] != ERR_OK) {
                throw new IOException("AS3953 EEPROM read failed: unkown error");
            } else {
                System.arraycopy(readResult, 2, result, inPtr, chunkSize * 4);
                address += chunkSize;
                inPtr += chunkSize * 4;
                numWordsToRead -= chunkSize;
            }
        }
        return result;
    }

    public void writeEeprom(int address, byte[] data) throws IOException {
        if (data.length != 0) {
            int wordsToWrite = ((data.length - 1) / 4) + 1;
            int wordsWritten = 0;
            int address2 = address;
            while (wordsWritten < wordsToWrite) {
                byte[] writeCommand = new byte[7];
                writeCommand[0] = PROPRIETARY_COMMAND_PFB;
                writeCommand[1] = (byte) 4;
                address = address2 + 1;
                writeCommand[2] = (byte) (address2 * 2);
                System.arraycopy(data, wordsWritten * 4, writeCommand, 3, Math.min(data.length - (wordsWritten * 4), 4));
                byte[] writeResult = this.mNfcA.transceive(writeCommand);
                if (writeResult.length < 2) {
                    throw new IOException("AS3953 EEPROM write failed: tag response too short");
                } else if (writeResult[0] != PROPRIETARY_COMMAND_PFB) {
                    throw new IOException("AS3953 EEPROM write failed: tag response PFB incorrect");
                } else if (writeResult[1] == ERR_CODING) {
                    throw new IOException("AS3953 EEPROM write failed: write command coding error");
                } else if (writeResult[1] == ERR_LOCKED) {
                    throw new IOException("AS3953 EEPROM write failed: word is locked");
                } else if (writeResult[1] == ERR_POWER_FAIL) {
                    throw new IOException("AS3953 EEPROM write failed: power check fail");
                } else if (writeResult[1] != ERR_OK) {
                    throw new IOException("AS3953 EEPROM write failed: unkown error");
                } else {
                    wordsWritten++;
                    address2 = address;
                }
            }
            address = address2;
        }
    }

    public void pdtpWrite(byte[] data_in) throws IOException {
        int packet_id = 0;
        if (data_in.length != 0) {
            byte[] data = new byte[(data_in.length + 4)];
            data[0] = (byte) (data.length >> 24);
            data[1] = (byte) (data.length >> 16);
            data[2] = (byte) (data.length >> 8);
            data[3] = (byte) data.length;
            System.arraycopy(data_in, 0, data, 4, data_in.length);
            byte[] result = this.mNfcA.transceive(new byte[]{NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID, NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_RX_INIT, (byte) (data_in.length >> 24), (byte) (data_in.length >> 16), (byte) (data_in.length >> 8), (byte) data_in.length});
            if (result.length < 3 || result[2] != (byte) 0) {
                throw new IOException("AS3953 PDTP write: could not init");
            }
            int i = 0;
            while (i < data.length) {
                int packet_size;
                if (data.length - i > 238) {
                    packet_size = 238;
                } else {
                    packet_size = data.length - i;
                }
                byte[] writeCommand = new byte[]{NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID, NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_RX, (byte) (packet_id >> 24), (byte) (packet_id >> 16), (byte) (packet_id >> 8), (byte) (packet_id >> 0), (byte) packet_size};
                byte[] tx = new byte[(writeCommand.length + packet_size)];
                System.arraycopy(writeCommand, 0, tx, 0, writeCommand.length);
                System.arraycopy(data, i, tx, writeCommand.length, packet_size);
                i += packet_size;
                packet_id++;
                byte[] writeResult = this.mNfcA.transceive(tx);
                if (writeResult.length < 3) {
                    throw new IOException("AS3953 PDTP write failed: tag response too short");
                } else if (writeResult[0] != NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID) {
                    throw new IOException("AS3953 PDTP write failed: tag response PFB incorrect");
                } else if (writeResult[1] != NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_RX) {
                    throw new IOException("AS3953 PDTP write failed: incorrect command in response");
                } else if (writeResult[2] != (byte) 0) {
                    throw new IOException("AS3953 returned an error");
                }
            }
        }
    }

    public byte[] pdtpRead() throws IOException {
        int packet_id = 0;
        int rxed = 0;
        int retries = 0;
        byte[] result = new byte[0];
        byte[] readResult = new byte[0];
        byte[] startRx = new byte[]{NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID, NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_TX_INIT};
        for (int count = 0; count < 10; count++) {
            result = this.mNfcA.transceive(startRx);
            if (result.length >= 7 && result[2] == (byte) 0) {
                break;
            }
            try {
                Thread.sleep(5);
            } catch (Exception e) {
            }
        }
        if (result.length < 7 || result[2] != (byte) 0) {
            throw new IOException("AS3953 PDTP read failed: Could not init");
        }
        int data_size = ((((result[3] & 255) << 24) | ((result[4] & 255) << 16)) | ((result[5] & 255) << 8)) | (result[6] & 255);
        result = new byte[data_size];
        while (rxed < data_size && retries < 10) {
            readResult = this.mNfcA.transceive(new byte[]{NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID, NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_TX, (byte) (packet_id >> 24), (byte) (packet_id >> 16), (byte) (packet_id >> 8), (byte) (packet_id >> 0)});
            retries++;
            if (readResult.length < 8) {
                try {
                    Thread.sleep(5);
                } catch (Exception e2) {
                }
            } else {
                int packet_size = readResult[7] & 255;
                if (packet_size > 0) {
                    retries = 0;
                }
                System.arraycopy(readResult, 8, result, rxed, packet_size);
                rxed += packet_size;
                packet_id++;
            }
        }
        if (readResult.length < 8) {
            throw new IOException("AS3953 PDTP read failed: tag response too short");
        } else if (readResult[0] != NfcProprietaryCmd.NFC_HF_CMD_HEADER_ID) {
            throw new IOException("AS3953 PDTP read failed: tag response PFB incorrect");
        } else if (readResult[1] != NfcProprietaryCmd.NFC_HF_CMD_ID_DATA_TX) {
            throw new IOException("AS3953 PDTP read failed: incorrect command in response");
        } else if (readResult[2] != (byte) 0) {
            throw new IOException("AS3953 returned an error");
        } else if (rxed == data_size) {
            return Arrays.copyOfRange(result, 4, result.length);
        } else {
            throw new IOException("AS3953 PDTP read failed: unexpected data size");
        }
    }

    public int getNdefUserDataSize() {
        if (this.mHasPDTP) {
            return 4000000;
        }
        return 44;
    }

    public int getSigmaUserDataSize() {
        if (this.mHasPDTP) {
            return 4000000;
        }
        return 108;
    }

    public int getUserDataStartAddress() {
        return 5;
    }

    public boolean getHasPDTP() {
        return this.mHasPDTP;
    }
}
