package com.sigmasport.misc;

public class ChecksumUtil {
    private static final short BYTE_MASK = (short) 255;
    private static final String TAG = ChecksumUtil.class.getName();
    private static final boolean debug = false;

    public static boolean determineProductTypeValidity(byte[] data) {
        byte checksumBitMask;
        boolean result = false;
        int len = data.length - 1;
        short checksumCal = (short) 0;
        byte productType = (byte) (data[0] & 15);
        if (productType == (byte) 0) {
            checksumBitMask = (byte) -1;
        } else if (productType == (byte) 2) {
            checksumBitMask = (byte) 15;
        } else if (productType != (byte) 1) {
            return false;
        } else {
            checksumBitMask = (byte) -1;
        }
        byte checksum = (byte) ((data[len] >> 0) & checksumBitMask);
        for (int i = 0; i != len; i++) {
            checksumCal = (short) (((byte) (data[i] & 255)) ^ checksumCal);
        }
        if (checksum == ((byte) (checksumCal & checksumBitMask))) {
            result = true;
        }
        return result;
    }

    public static boolean determineDataValidity(byte[] data, byte checksumBit, byte checksumBitMask) {
        byte checksumCal = (byte) 0;
        int len = data.length - 1;
        byte checksum = (byte) ((data[len] >> checksumBit) & checksumBitMask);
        for (int i = 0; i != len; i++) {
            checksumCal = (byte) ((data[i] & -1) + checksumCal);
        }
        if (checksum == ((byte) ((checksumCal >> checksumBit) & checksumBitMask))) {
            return true;
        }
        return false;
    }

    public static boolean determineDataValidity(byte[] data, byte lastByteDataBitMask, byte checksumBit, byte checksumBitMask) {
        byte checksumCal = (byte) 0;
        int len = data.length;
        byte checksum = (byte) ((data[len - 1] >> checksumBit) & checksumBitMask);
        for (int i = 0; i < len; i++) {
            if (i == len - 1) {
                checksumCal = (byte) ((data[i] & lastByteDataBitMask) + checksumCal);
                break;
            }
            checksumCal = (byte) ((data[i] & -1) + checksumCal);
        }
        if (checksum == ((byte) (checksumCal & checksumBitMask))) {
            return true;
        }
        return false;
    }

    public static boolean determineDataValidity(byte[] data, int checksumIdx, byte byteDataBitMask, byte checksumBit, byte checksumBitMask) {
        byte checksumCal = (byte) 0;
        int len = data.length;
        byte checksum = (byte) ((data[checksumIdx] >> checksumBit) & checksumBitMask);
        for (int i = 0; i < len; i++) {
            if (checksumIdx == 0 || checksumIdx == len - 1) {
                checksumCal = (byte) ((data[i] & byteDataBitMask) + checksumCal);
                if (checksumIdx == len - 1) {
                    break;
                }
            } else {
                checksumCal = (byte) ((data[i] & -1) + checksumCal);
            }
        }
        if (checksum == ((byte) (checksumCal & checksumBitMask))) {
            return true;
        }
        return false;
    }

    public static boolean determineDataValidity(byte data, byte checksumBit, byte checksumBitMask) {
        if (((byte) ((data & checksumBitMask) >> checksumBit)) == ((byte) ((data & checksumBitMask) >> checksumBit))) {
            return true;
        }
        return false;
    }

    public static byte calculateCrcValue(byte data, byte checksumBit, byte checksumBitMask) {
        return (byte) (((byte) (data & checksumBitMask)) << checksumBit);
    }

    public static byte calculateCrcValue(byte[] data, int startIdx, byte bitMask, byte checkSumBit, byte lastByteBitMask) {
        int checksumLength;
        byte calChecksum = (byte) 0;
        if (lastByteBitMask != (byte) 0) {
            checksumLength = data.length;
        } else {
            checksumLength = data.length - 1;
        }
        for (int i = startIdx; i < checksumLength; i++) {
            calChecksum = (byte) (data[i] + calChecksum);
        }
        return (byte) ((calChecksum << checkSumBit) & bitMask);
    }

    public static boolean determineDataValidityXorCrc(byte[] data, byte checksumBit, byte checksumBitMask) {
        byte checksumCal = (byte) 0;
        int len = data.length - 1;
        byte checksum = (byte) ((data[len] >> checksumBit) & checksumBitMask);
        for (int i = 0; i != len; i++) {
            checksumCal = (byte) ((data[i] & 255) ^ checksumCal);
        }
        if (checksum == ((byte) ((checksumCal >> checksumBit) & checksumBitMask))) {
            return true;
        }
        return false;
    }

    public static byte calculateXorCrcValue(byte[] data, int startIdx, byte bitMask, byte checkSumBit, byte lastByteBitMask) {
        int checksumLength;
        byte calChecksum = (byte) 0;
        if (lastByteBitMask != (byte) 0) {
            checksumLength = data.length;
        } else {
            checksumLength = data.length - 1;
        }
        for (int i = startIdx; i < checksumLength; i++) {
            calChecksum = (byte) (data[i] ^ calChecksum);
        }
        return (byte) (((byte) (calChecksum << checkSumBit)) & bitMask);
    }

    public static boolean determineDataValidity(byte[] data, byte lastByteDataBitMask, byte checksumBit, byte checksumBitMask, byte checksumConstant) {
        byte checksumCal = (byte) 0;
        int len = data.length;
        byte checksum = (byte) ((data[len - 1] >> checksumBit) & checksumBitMask);
        for (int i = 0; i < len; i++) {
            if (i == len - 1) {
                checksumCal = (byte) ((data[i] & lastByteDataBitMask) + checksumCal);
                break;
            }
            checksumCal = (byte) ((data[i] & -1) + checksumCal);
        }
        if (checksum == ((byte) (((byte) (checksumCal + checksumConstant)) & checksumBitMask))) {
            return true;
        }
        return false;
    }

    public static boolean determineDataValidity(byte[] data, byte checksumConstant) {
        byte checksumCal = (byte) 0;
        int len = data.length - 1;
        byte checksum = data[len];
        for (int i = 0; i != len; i++) {
            checksumCal = (byte) ((data[i] & -1) + checksumCal);
        }
        if (((byte) (checksumCal + checksumConstant)) == checksum) {
            return true;
        }
        return false;
    }

    public static byte calculateCrcValue(byte[] data, byte checksumConstant) {
        byte calChecksum = (byte) 0;
        for (int i = 0; i < data.length - 1; i++) {
            calChecksum = (byte) (data[i] + calChecksum);
        }
        return (byte) (calChecksum + checksumConstant);
    }
}
