package com.sigmasport.misc;

import android.annotation.SuppressLint;

public class ConvertData {
    private static final short BYTE_MASK = (short) 255;

    public static long byteToLong(byte[] data) {
        long result = (((long) (data[0] & 255)) + ((long) ((data[1] & 255) << 8))) + ((long) ((data[2] & 255) << 16));
        if (data.length == 4) {
            return result + (((long) (data[3] & 255)) << 24);
        }
        if (data.length == 5) {
            return (result + (((long) (data[3] & 255)) << 24)) + (((long) (data[4] & 255)) << 32);
        }
        if (data.length == 6) {
            return ((result + (((long) (data[3] & 255)) << 24)) + (((long) (data[4] & 255)) << 32)) + (((long) (data[5] & 255)) << 40);
        }
        return result;
    }

    public static short byteToShort(byte[] data) {
        return (short) (((data[1] & 255) << 8) + ((short) (data[0] & 255)));
    }

    public static int byteToInt(byte[] data) {
        int result = (data[0] & 255) + ((data[1] & 255) << 8);
        if (data.length == 3) {
            return result + ((data[2] & 255) << 16);
        }
        if (data.length == 4) {
            return (result + ((data[2] & 255) << 16)) + ((data[3] & 255) << 24);
        }
        return result;
    }

    public static byte[] uIntegerToByte(long value) {
        return new byte[]{(byte) ((int) (value & 255)), (byte) ((int) ((value >> 8) & 255)), (byte) ((int) ((value >> 16) & 255)), (byte) ((int) ((value >> 24) & 255))};
    }

    public static byte[] integerToByte(int value) {
        return new byte[]{(byte) (value & 255), (byte) ((value >> 8) & 255), (byte) ((value >> 16) & 255), (byte) ((value >> 24) & 255)};
    }

    public static byte[] shortToByte(short value) {
        return new byte[]{(byte) (value & 255), (byte) ((value >> 8) & 255)};
    }

    public static double roundingDouble(double value) {
        if (value - ((double) ((int) value)) >= 0.5d) {
            return Math.ceil(value);
        }
        return Math.floor(value);
    }

    public static double roundingDouble(double value, double roundingThreshold) {
        if (value - ((double) ((int) value)) >= roundingThreshold) {
            return Math.ceil(value);
        }
        return Math.floor(value);
    }

    public static double roundingDouble3Decimal(double value, double roundingThreshold) {
        if (value - ((double) ((int) value)) >= roundingThreshold) {
            return value + roundingThreshold;
        }
        return value - roundingThreshold;
    }

    @SuppressLint({"DefaultLocale"})
    public static double roundingTwoDecimalDouble(double value) {
        return Double.parseDouble(String.format("%.2f", new Object[]{Double.valueOf(value)}));
    }

    public static double extractDecimal(double value, int divider, double roundingThreshold) {
        double decimalResult = (value - ((double) ((int) value))) * ((double) divider);
        if (decimalResult - ((double) ((int) decimalResult)) >= roundingThreshold) {
            decimalResult = Math.ceil(decimalResult);
        } else {
            decimalResult = Math.floor(decimalResult);
        }
        return decimalResult / ((double) divider);
    }

    public static String convertAsciiToString(byte[] data) {
        String result = new String();
        StringBuffer sb = new StringBuffer();
        for (byte b : data) {
            sb.append((char) b);
        }
        return sb.toString();
    }

    public static byte[] convertStringToAscii(String data) {
        char[] chars = data.toCharArray();
        byte[] asciiArray = new byte[chars.length];
        for (int i = 0; i < chars.length; i++) {
            asciiArray[i] = (byte) chars[i];
        }
        return asciiArray;
    }

    public static String convertHexToString(byte[] inData, boolean isOrderAscending) {
        int i = 0;
        String result = new String();
        StringBuffer sb = new StringBuffer();
        byte[] data = new byte[inData.length];
        if (isOrderAscending) {
            int len = inData.length;
            int idx = 0;
            while (len > 0) {
                len--;
                int idx2 = idx + 1;
                data[len] = inData[idx];
                idx = idx2;
            }
        } else {
            System.arraycopy(inData, 0, data, 0, inData.length);
        }
        int length = data.length;
        while (i < length) {
            byte b = data[i];
            for (int j = 0; j < 2; j++) {
                byte halfByte;
                if (j == 0) {
                    halfByte = (byte) ((b >> 4) & 15);
                } else {
                    halfByte = (byte) (b & 15);
                }
                if (halfByte >= (byte) 10) {
                    halfByte = (byte) ((halfByte - 10) + 65);
                } else {
                    halfByte = (byte) (halfByte + 48);
                }
                sb.append((char) halfByte);
            }
            i++;
        }
        return sb.toString();
    }

    public static byte[] convertStringToHex(String data, boolean isOrderAscending) {
        if (data == null || data.length() % 2 == 1) {
            throw new IllegalArgumentException();
        }
        int i;
        char[] chars = data.toCharArray();
        char[] computeChar = new char[chars.length];
        byte[] asciiArray = new byte[(chars.length / 2)];
        if (isOrderAscending) {
            int idx = 0;
            for (int len = chars.length; len > 0; len -= 2) {
                computeChar[len - 1] = chars[idx + 1];
                computeChar[len - 2] = chars[idx];
                idx += 2;
            }
        } else {
            for (i = 0; i < chars.length; i += 2) {
                computeChar[i + 1] = chars[i + 1];
                computeChar[i] = chars[i];
            }
        }
        for (i = 0; i < computeChar.length; i += 2) {
            asciiArray[i / 2] = (byte) ((Character.digit(computeChar[i], 16) << 4) + Character.digit(computeChar[i + 1], 16));
        }
        return asciiArray;
    }
}
