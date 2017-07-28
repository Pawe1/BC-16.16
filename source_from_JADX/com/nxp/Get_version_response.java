package com.nxp;

import de.pagecon.ane.nfc.BaseConfig;

public class Get_version_response {
    public static final Get_version_response NTAG_I2C_1k;
    public static final Get_version_response NTAG_I2C_2k;
    public static final Get_version_response NTAG_I2C_Plus_1k;
    public static final Get_version_response NTAG_I2C_Plus_2k;
    public static final Get_version_response TNPI_3230;
    public static final Get_version_response TNPI_6230;
    private byte major_product_version;
    private byte minor_product_version;
    private byte product_subtype;
    private byte product_type;
    private byte protocol_type;
    private byte storage_size;
    private byte vendor_ID;

    public enum Prod {
        NTAG_I2C_1k(888, 4, 255),
        NTAG_I2C_Plus_1k(888, 4, 255),
        NTAG_I2C_2k(1904, 4, 511),
        NTAG_I2C_Plus_2k(1904, 4, 511),
        Unknown(0, 0, 0),
        TNPI_6230(2000, 0, 0),
        TNPI_3230(BaseConfig.READ_SETTING_DATA_DELAY_TIMEOUT, 0, 0);
        
        private int mem_size;
        private int user_data_end_addr;
        private int user_data_start_addr;

        private Prod(int mem_size, int start_addr, int end_addr) {
            this.mem_size = mem_size;
            this.user_data_start_addr = start_addr;
            this.user_data_end_addr = end_addr;
        }

        public int getMemsize() {
            return this.mem_size;
        }

        public int getUserDataStarAddr() {
            return this.user_data_start_addr;
        }

        public int getUserDataEndAddr() {
            return this.user_data_end_addr;
        }

        public int getDataStartAddr() {
            return 0;
        }
    }

    static {
        byte[] bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 4;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 1;
        bArr[5] = (byte) 1;
        bArr[6] = (byte) 19;
        bArr[7] = (byte) 3;
        NTAG_I2C_1k = new Get_version_response(bArr);
        bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 4;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 2;
        bArr[6] = (byte) 21;
        bArr[7] = (byte) 3;
        NTAG_I2C_2k = new Get_version_response(bArr);
        bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 4;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 2;
        bArr[5] = (byte) 2;
        bArr[6] = (byte) 19;
        bArr[7] = (byte) 3;
        NTAG_I2C_Plus_1k = new Get_version_response(bArr);
        bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 4;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 2;
        bArr[5] = (byte) 2;
        bArr[6] = (byte) 21;
        bArr[7] = (byte) 3;
        NTAG_I2C_Plus_2k = new Get_version_response(bArr);
        bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 5;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 1;
        bArr[5] = (byte) 1;
        bArr[6] = (byte) 21;
        bArr[7] = (byte) 3;
        TNPI_6230 = new Get_version_response(bArr);
        bArr = new byte[8];
        bArr[1] = (byte) 4;
        bArr[2] = (byte) 5;
        bArr[3] = (byte) 5;
        bArr[4] = (byte) 1;
        bArr[5] = (byte) 1;
        bArr[6] = (byte) 19;
        bArr[7] = (byte) 3;
        TNPI_3230 = new Get_version_response(bArr);
    }

    public Prod Get_Product() {
        if (equals(NTAG_I2C_1k)) {
            return Prod.NTAG_I2C_1k;
        }
        if (equals(NTAG_I2C_Plus_1k)) {
            return Prod.NTAG_I2C_Plus_1k;
        }
        if (equals(NTAG_I2C_2k)) {
            return Prod.NTAG_I2C_2k;
        }
        if (equals(NTAG_I2C_Plus_2k)) {
            return Prod.NTAG_I2C_Plus_2k;
        }
        if (equals(TNPI_6230)) {
            return Prod.TNPI_6230;
        }
        if (equals(TNPI_3230)) {
            return Prod.TNPI_3230;
        }
        return Prod.Unknown;
    }

    public Get_version_response(byte[] Data) {
        this.vendor_ID = Data[1];
        this.product_type = Data[2];
        this.product_subtype = Data[3];
        this.major_product_version = Data[4];
        this.minor_product_version = Data[5];
        this.storage_size = Data[6];
        this.protocol_type = Data[7];
    }

    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (other.getClass() != getClass()) {
            return false;
        }
        Get_version_response temp = (Get_version_response) other;
        if (temp.vendor_ID == this.vendor_ID && temp.product_type == this.product_type && temp.product_subtype == this.product_subtype && temp.major_product_version == this.major_product_version && temp.minor_product_version == this.minor_product_version && temp.storage_size == this.storage_size) {
            return true;
        }
        return false;
    }

    public byte getVendor_ID() {
        return this.vendor_ID;
    }

    public byte getProduct_type() {
        return this.product_type;
    }

    public byte getProduct_subtype() {
        return this.product_subtype;
    }

    public byte getMajor_product_version() {
        return this.major_product_version;
    }

    public byte getMinor_product_version() {
        return this.minor_product_version;
    }

    public byte getStorage_size() {
        return this.storage_size;
    }

    public byte getProtocol_type() {
        return this.protocol_type;
    }
}
