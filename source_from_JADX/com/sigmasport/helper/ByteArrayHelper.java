package com.sigmasport.helper;

public class ByteArrayHelper {
    public static String bytesToHex(byte[] data) {
        StringBuffer buf = new StringBuffer();
        for (byte byteToHex : data) {
            buf.append(byteToHex(byteToHex));
            buf.append(" ");
        }
        return buf.toString().trim();
    }

    public static String byteToHex(byte data) {
        StringBuffer buf = new StringBuffer();
        buf.append(toHexChar((data >>> 4) & 15));
        buf.append(toHexChar(data & 15));
        return buf.toString().trim();
    }

    public static char toHexChar(int i) {
        if (i < 0 || i > 9) {
            return (char) ((i - 10) + 97);
        }
        return (char) (i + 48);
    }

    public static byte[] hexToByte(String hexString) {
        String s = hexString.replace(" ", "");
        int len = s.length();
        byte[] data = new byte[(len / 2)];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));
        }
        return data;
    }

    public String toHexString(byte[] data) {
        String hexString = new String();
        for (int index = 0; index < data.length; index++) {
            hexString = new StringBuilder(String.valueOf(hexString)).append(String.format("%02x", new Object[]{Byte.valueOf(data[index])})).toString();
        }
        return hexString;
    }
}
