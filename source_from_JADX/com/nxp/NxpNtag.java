package com.nxp;

import android.nfc.Tag;
import android.nfc.tech.NfcA;
import android.nfc.tech.TagTechnology;
import android.os.Build;
import android.util.Log;
import com.nxp.Get_version_response.Prod;
import com.sigmasport.misc.NfcProprietaryCmd;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;
import java.util.Arrays;

public class NxpNtag implements TagTechnology {
    private static final boolean DEBUG = true;
    static final String TAG = NxpNtag.class.getName();
    private final int DYNAMIC_LOCK_BYTE_CONFIG_SIZE = 4;
    private final int EEPROM_BLOCK_SIZE = 16;
    private final byte EEPROM_PAGE_SIZE = (byte) 4;
    private Sector mEepromSector;
    Get_version_response mGetVersion;
    NfcA mNfcA;
    private String mPhoneManufacturer;
    private String mPhoneModel;
    private int mSigmaNdefDataSize;
    private int mSigmaUserDataSize;

    public enum CR_Offset implements Byte_enum {
        NC_REG((byte) 0),
        LAST_NDEF_PAGE((byte) 1),
        SM_REG((byte) 2),
        WDT_LS((byte) 3),
        WDT_MS((byte) 4),
        I2C_CLOCK_STR((byte) 5),
        REG_LOCK((byte) 6),
        FIXED((byte) 7);
        
        byte value;

        private CR_Offset(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    private enum DynamicLockByteAddr implements Byte_enum {
        NTAG_I2C_1K((byte) -30),
        NTAG_I2C_2K((byte) -32);
        
        byte value;

        private DynamicLockByteAddr(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    public enum NC_Reg_Func implements Byte_enum {
        PTHRU_DIR((byte) 1),
        SRAM_MIRROR_ON_OFF((byte) 2),
        FD_ON(NfcProprietaryCmd.SET_BC_ROX6_SETTING_DATA_RQST_CMD),
        FD_OFF((byte) 48),
        PTHRU_ON_OFF((byte) 64),
        I2C_RST_ON_OFF(Byte.MIN_VALUE);
        
        byte value;

        private NC_Reg_Func(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    public enum NS_Reg_Func implements Byte_enum {
        RF_FIELD_PRESENT((byte) 1),
        EEPROM_WR_BUSY((byte) 2),
        EEPROM_WR_ERR((byte) 4),
        SRAM_RF_READY((byte) 8),
        SRAM_I2C_READY((byte) 16),
        RF_LOCKED((byte) 32),
        I2C_LOCKED((byte) 64),
        NDEF_DATA_READ(Byte.MIN_VALUE);
        
        byte value;

        private NS_Reg_Func(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    public enum Register implements Byte_enum {
        Session((byte) -8),
        Configuration((byte) -24),
        SRAM_Begin((byte) -16),
        User_memory_Begin((byte) 4),
        UID((byte) 0);
        
        byte value;

        private Register(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    public enum R_W_Methods {
        Fast_Mode,
        Polling_Mode,
        Error
    }

    public enum Sector implements Byte_enum {
        Sector0((byte) 0),
        Sector1((byte) 1),
        Sector2((byte) 2),
        Sector3((byte) 3);
        
        byte value;

        private Sector(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    private enum SectorSize implements Integer_enum {
        NTAG_I2C_1K(64),
        NTAG_I2C_2K(128);
        
        int value;

        private SectorSize(int value) {
            this.value = value;
        }

        public int getValue() {
            return this.value;
        }
    }

    public enum SR_Offset implements Byte_enum {
        NC_REG((byte) 0),
        LAST_NDEF_PAGE((byte) 1),
        SM_REG((byte) 2),
        WDT_LS((byte) 3),
        WDT_MS((byte) 4),
        I2C_CLOCK_STR((byte) 5),
        NS_REG((byte) 6),
        FIXED((byte) 7);
        
        byte value;

        private SR_Offset(byte value) {
            this.value = value;
        }

        public byte getValue() {
            return this.value;
        }
    }

    private String toHexString(byte[] data) {
        String hexString = new String();
        for (int index = 0; index < data.length; index++) {
            hexString = new StringBuilder(String.valueOf(hexString)).append(String.format("%02x", new Object[]{Byte.valueOf(data[index])})).toString();
        }
        return hexString;
    }

    public NxpNtag(NfcA nfca) {
        this.mNfcA = nfca;
        this.mPhoneManufacturer = Build.MANUFACTURER;
        this.mPhoneModel = Build.MODEL;
    }

    public static NxpNtag get(Tag tag) {
        Log.d(TAG, "Atag txrxsize" + NfcA.get(tag).getMaxTransceiveLength());
        if (tag.getId().length < 2) {
            return null;
        }
        Log.d(TAG, "uid: " + String.format("0x%x", new Object[]{Byte.valueOf(uid[0])}) + " " + String.format("0x%x", new Object[]{Byte.valueOf(uid[1])}));
        return new NxpNtag(NfcA.get(tag));
    }

    public void close() throws IOException {
        this.mNfcA.close();
    }

    public void connect() throws IOException {
        try {
            this.mNfcA.connect();
            this.mEepromSector = Sector.Sector0;
            Get_Product();
        } catch (IOException e) {
            String errorMessage = "Fail to connect Nfc tag";
            Log.d(TAG, errorMessage);
            if (e.getMessage() == null) {
                throw new IOException(errorMessage);
            }
        }
    }

    public Tag getTag() {
        return this.mNfcA.getTag();
    }

    public boolean isConnected() {
        return this.mNfcA.isConnected();
    }

    public Prod Get_Product() throws IOException {
        if (this.mGetVersion == null) {
            if (this.mPhoneManufacturer.equalsIgnoreCase("samsung") && this.mPhoneModel.equalsIgnoreCase("GT-I9300I")) {
                byte[] version = new byte[8];
                version[1] = (byte) 4;
                version[2] = (byte) 4;
                version[3] = (byte) 5;
                version[4] = (byte) 2;
                version[5] = (byte) 2;
                version[6] = (byte) 19;
                version[7] = (byte) 3;
                this.mGetVersion = new Get_version_response(version);
            } else {
                this.mGetVersion = new Get_version_response(getVersion());
            }
        }
        return this.mGetVersion.Get_Product();
    }

    public byte[] getSessionRegisters() throws IOException {
        SectorSelect(Sector.Sector3);
        return read(Register.Session.getValue());
    }

    public byte[] getConfigRegisters() throws IOException {
        if (Get_Product() == Prod.NTAG_I2C_1k || Get_Product() == Prod.NTAG_I2C_Plus_1k || Get_Product() == Prod.NTAG_I2C_Plus_2k) {
            SectorSelect(Sector.Sector0);
        } else if (Get_Product() == Prod.NTAG_I2C_2k) {
            SectorSelect(Sector.Sector1);
        } else {
            throw new IOException();
        }
        return read(Register.Configuration.getValue());
    }

    public byte getConfigRegister(CR_Offset off) throws IOException {
        return getConfigRegisters()[off.getValue()];
    }

    public byte getSessionRegister(SR_Offset off) throws IOException {
        byte[] register = getSessionRegisters();
        if (register.length < 8) {
            return (byte) 0;
        }
        return register[off.getValue()];
    }

    public void waitforI2Cwrite() throws IOException {
        SectorSelect(Sector.Sector3);
        do {
        } while ((getSessionRegister(SR_Offset.NS_REG) & NS_Reg_Func.SRAM_RF_READY.getValue()) == 0);
    }

    public void waitforI2Cread() throws IOException {
        SectorSelect(Sector.Sector3);
        do {
        } while ((getSessionRegister(SR_Offset.NS_REG) & NS_Reg_Func.SRAM_I2C_READY.getValue()) == NS_Reg_Func.SRAM_I2C_READY.getValue());
    }

    public byte[] readEeprom(int address, int length) throws IOException {
        if (length == 0) {
            return new byte[0];
        }
        boolean isSectorChanged = false;
        int readLen = 0;
        int numBlockToRead = ((length - 1) / 16) + 1;
        int readAddr = address;
        byte[] result = new byte[(numBlockToRead * 16)];
        while (numBlockToRead > 0) {
            System.arraycopy(this.mNfcA.transceive(new byte[]{(byte) 48, (byte) readAddr}), 0, result, readLen * 16, 16);
            numBlockToRead--;
            readLen++;
            readAddr++;
            if (readAddr >= 256 && !isSectorChanged) {
                SectorSelect(Sector.Sector1);
                isSectorChanged = true;
            }
        }
        return result;
    }

    public byte[] read_EEPROM(int abs_start, int abs_end, boolean isSingleSector) throws IOException {
        int max_fast_read = (getMaxTransceiveLength() - 2) / 4;
        int fetch_start = abs_start;
        byte[] data = new byte[(((abs_end - abs_start) + 1) * 4)];
        byte[] temp = null;
        int idx = 0;
        boolean isSectorChanged = false;
        if ((abs_start & 65280) != 0) {
            SectorSelect(Sector.Sector1);
        } else {
            SectorSelect(Sector.Sector0);
        }
        while (fetch_start <= abs_end) {
            int fetch_end = (fetch_start + max_fast_read) - 1;
            if (fetch_end > abs_end) {
                fetch_end = abs_end;
            }
            if ((fetch_start & 65280) != (fetch_end & 65280)) {
                fetch_end = (fetch_start & 65280) + 255;
            }
            if (this.mPhoneManufacturer.equalsIgnoreCase("samsung") && this.mPhoneModel.equalsIgnoreCase("GT-I9300I")) {
                temp = fast_read_samsung_I9300I(fetch_start, fetch_end);
            } else {
                temp = fast_read((byte) (fetch_start & 255), (byte) (fetch_end & 255));
            }
            System.arraycopy(temp, 0, data, idx, temp.length);
            idx += temp.length;
            fetch_start = fetch_end + 1;
            if (this.mPhoneManufacturer.equalsIgnoreCase("samsung") && this.mPhoneModel.equalsIgnoreCase("GT-I9300I") && fetch_start > 234) {
                break;
            } else if (!(isSingleSector || isSectorChanged || (fetch_start & 65280) == (fetch_end & 65280))) {
                SectorSelect(Sector.Sector1);
                isSectorChanged = true;
            }
        }
        return data;
    }

    public void writeEeprom(int address, byte[] data) throws IOException {
        if (data.length != 0) {
            byte blockStartAddr;
            int wordsToWrite = ((data.length - 1) / 4) + 1;
            byte[] blockData = new byte[4];
            if ((address & 256) != 0) {
                blockStartAddr = (byte) (address & 255);
                SectorSelect(Sector.Sector1);
            } else {
                blockStartAddr = (byte) address;
                SectorSelect(Sector.Sector0);
            }
            for (int wordsWritten = 0; wordsWritten < wordsToWrite; wordsWritten++) {
                byte blockAddr = (byte) (((byte) wordsWritten) + blockStartAddr);
                System.arraycopy(data, wordsWritten * 4, blockData, 0, Math.min(data.length - (wordsWritten * 4), 4));
                write(blockData, blockAddr);
            }
        }
    }

    public void write_SRAM_Block(byte[] data) throws IOException {
        byte[] TxBuffer = new byte[4];
        int index = 0;
        if (this.mGetVersion.Get_Product() == Prod.NTAG_I2C_2k) {
            SectorSelect(Sector.Sector1);
        } else {
            SectorSelect(Sector.Sector0);
        }
        int i = 0;
        while (i < 16) {
            int d_i = 0;
            int index2 = index;
            while (d_i < 4) {
                if (index2 < data.length) {
                    index = index2 + 1;
                    TxBuffer[d_i] = data[index2];
                } else {
                    TxBuffer[d_i] = (byte) 0;
                    index = index2;
                }
                d_i++;
                index2 = index;
            }
            write(TxBuffer, (byte) (Register.SRAM_Begin.getValue() + i));
            i++;
            index = index2;
        }
    }

    public void write_SRAM(byte[] data, R_W_Methods method) throws IOException {
        int Blocks = (int) Math.ceil(((double) data.length) / 64.0d);
        for (int i = 0; i < Blocks; i++) {
            write_SRAM_Block(data);
            if (method == R_W_Methods.Polling_Mode) {
                waitforI2Cread();
            } else {
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            if (data.length > 64) {
                data = Arrays.copyOfRange(data, 64, data.length);
            }
        }
    }

    public byte[] read_SRAM_Block() throws IOException {
        byte[] answer = new byte[0];
        if (this.mGetVersion.Get_Product() == Prod.NTAG_I2C_2k) {
            SectorSelect(Sector.Sector1);
        } else {
            SectorSelect(Sector.Sector0);
        }
        return fast_read((byte) -16, (byte) -1);
    }

    public byte[] read_SRAM_Block(byte startAddr, byte endAddr) throws IOException {
        byte[] answer = new byte[0];
        if (this.mGetVersion.Get_Product() == Prod.NTAG_I2C_2k) {
            SectorSelect(Sector.Sector1);
        } else {
            SectorSelect(Sector.Sector0);
        }
        return fast_read(startAddr, endAddr);
    }

    public byte[] read_SRam(int Blocks, R_W_Methods Method) throws IOException {
        byte[] answer = new byte[(Blocks * 64)];
        for (int i = 0; i < Blocks; i++) {
            if (Method == R_W_Methods.Polling_Mode) {
                waitforI2Cwrite();
            } else {
                try {
                    Thread.sleep(6);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            byte[] temp = read_SRAM_Block();
            Manager.cLog("read sram data(" + i + "): " + temp.length);
            System.arraycopy(temp, 0, answer, i * 64, temp.length);
        }
        return answer;
    }

    public byte[] getVersion() throws IOException {
        return this.mNfcA.transceive(new byte[]{(byte) 96});
    }

    public void determineNdefMessageSize(Prod product) throws IOException {
        byte addr;
        int sectorByteSize = 0;
        if (product == Prod.NTAG_I2C_1k || product == Prod.NTAG_I2C_Plus_1k) {
            SectorSelect(Sector.Sector0);
            addr = DynamicLockByteAddr.NTAG_I2C_1K.getValue();
            sectorByteSize = SectorSize.NTAG_I2C_1K.getValue();
        } else if (product == Prod.NTAG_I2C_2k || product == Prod.NTAG_I2C_Plus_2k) {
            SectorSelect(Sector.Sector1);
            addr = DynamicLockByteAddr.NTAG_I2C_2K.getValue();
            sectorByteSize = SectorSize.NTAG_I2C_2K.getValue();
        } else {
            addr = DynamicLockByteAddr.NTAG_I2C_1K.getValue();
        }
        byte[] answer = read(addr);
        int sectorIdx = 0;
        int i = 0;
        while (i < 2) {
            byte j = (byte) 0;
            while (j < (byte) 8) {
                if (((answer[i] >> j) & 1) != 0) {
                    i = 4;
                    break;
                } else {
                    sectorIdx++;
                    j = (byte) (j + 1);
                }
            }
            i++;
        }
        this.mSigmaNdefDataSize = (sectorIdx * sectorByteSize) + 48;
        if (this.mSigmaNdefDataSize > this.mSigmaUserDataSize) {
            this.mSigmaNdefDataSize = this.mSigmaUserDataSize;
        }
    }

    public void SectorSelect(Sector sector) throws IOException {
        byte[] command = new byte[1];
        if (this.mEepromSector != sector) {
            try {
                this.mNfcA.transceive(new byte[]{(byte) -62, (byte) -1});
            } catch (IOException e) {
            }
            command = new byte[]{sector.getValue(), (byte) 0, (byte) 0, (byte) 0};
            this.mNfcA.setTimeout(1);
            try {
                this.mNfcA.transceive(command);
            } catch (IOException e2) {
            }
            this.mNfcA.setTimeout(600);
            this.mEepromSector = sector;
        }
    }

    public void write(byte[] data, byte BlockNr) throws IOException {
        byte[] answer = new byte[0];
        byte[] command = new byte[(data.length + 2)];
        command[0] = (byte) -94;
        command[1] = BlockNr;
        System.arraycopy(data, 0, command, 2, data.length);
        answer = this.mNfcA.transceive(command);
    }

    public byte[] read(byte BlockNr) throws IOException {
        return this.mNfcA.transceive(new byte[]{(byte) 48, BlockNr});
    }

    public byte[] fast_read(byte StartAddr, byte EndAddr) throws IOException {
        byte[] answer = new byte[0];
        return this.mNfcA.transceive(new byte[]{(byte) 58, StartAddr, EndAddr});
    }

    public byte[] fast_read_samsung_I9300I(int startAddr, int endAddr) throws IOException {
        byte[] data = new byte[(((endAddr - startAddr) + 1) * 4)];
        byte[] command = new byte[2];
        command[0] = (byte) 48;
        byte absAddr = (byte) (startAddr & 255);
        int idx = 0;
        int totalSize = data.length;
        while (totalSize != 0) {
            int size;
            command[1] = absAddr;
            int addr = absAddr & 255;
            if (addr >= 234 && addr < 240) {
                size = 1;
                totalSize--;
            } else if (totalSize >= 16) {
                totalSize -= 16;
                size = 16;
            } else {
                size = totalSize;
                totalSize -= size;
            }
            System.arraycopy(this.mNfcA.transceive(command), 0, data, idx, size);
            absAddr = (byte) (absAddr + 4);
            idx += size;
            if ((absAddr & 255) == 234) {
                Log.d(TAG, "addr: " + (absAddr & 255));
                break;
            }
        }
        return data;
    }

    public int getNdefUserDataSize() {
        return this.mSigmaNdefDataSize;
    }

    public void setSigmaUserDataSize(int size) {
        this.mSigmaUserDataSize = size;
    }

    public int getSigmaUserDataSize() {
        return this.mSigmaUserDataSize;
    }

    public int getUserDataStartAddress() {
        return 4;
    }

    public int getMaxTransceiveLength() {
        return this.mNfcA.getMaxTransceiveLength();
    }
}
