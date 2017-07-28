package com.ams;

import android.net.Uri;
import android.nfc.FormatException;
import android.nfc.NdefRecord;
import android.util.Log;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;

public class NdefRecordParser {
    static final String TAG = NdefRecordParser.class.getName();
    static String[] uriPrefix = new String[]{"", "http://www.", "https://www.", "http://", "https://", "tel:", "mailto", "ftp://anonymous:anonymous@", "ftp://ftp.", "ftps://", "sftp://", "smb://", "nfc://", "ftp://", "dav://", "news:", "telnet://", "imap:", "rtsp://", "urn:", "pop:", "sip:", "sips:", "tftp:", "btspp://", "btl2cap://", "btgoep://", "tcpobex://", "irdaobex://", "file://", "urn:epc:id:", "urn:epc:tag:", "urn:epc:pat:", "urn:epc:raw:", "urn:epc:", "urn:nfc:"};

    static String absoluteUriRecordToString(NdefRecord record) {
        return Uri.decode(new String(record.getType()));
    }

    static String externalTypeRecordToString(NdefRecord record) {
        return "urn:nfc:ext:" + new String(record.getType());
    }

    static String mimeMediaRecordToString(NdefRecord record) {
        String str = new String(record.getType());
        if (str.equals("text/plain")) {
            return new String(record.getPayload());
        }
        return str;
    }

    static String wellKnownRecordToString(NdefRecord record) throws FormatException {
        if (record.getType().length < 1) {
            throw new FormatException("invalid NDEF Record format");
        } else if (record.getType()[0] == (byte) 84) {
            payload = record.getPayload();
            if (payload.length < 1) {
                throw new FormatException("invalid NDEF Record format");
            }
            String encoding = (payload[0] & 128) == 128 ? "UTF-16" : "UTF-8";
            int languageCodeLength = payload[0] & 63;
            if (payload.length < languageCodeLength + 1) {
                throw new FormatException("invalid NDEF Record format");
            }
            try {
                return new String(Arrays.copyOfRange(payload, languageCodeLength + 1, payload.length), encoding);
            } catch (UnsupportedEncodingException e) {
                Log.e(TAG, "Catched Unsupported encoding exception when trying to decode RTD-URI NDEF Record");
                return new String();
            }
        } else if (record.getType()[0] != (byte) 85) {
            return "urn:wkt:" + new String(record.getType());
        } else {
            payload = record.getPayload();
            if (payload.length < 1) {
                throw new FormatException("invalid NDEF Record format");
            }
            int uriPrefixIndex = payload[0] & 255;
            if (uriPrefixIndex < uriPrefix.length) {
                return new StringBuilder(String.valueOf(uriPrefix[uriPrefixIndex])).append(new String(Arrays.copyOfRange(payload, 1, payload.length))).toString();
            }
            Log.w(TAG, "URI-RTD NDEF Record contained unkown URI prefix code: " + uriPrefixIndex);
            return new String(Arrays.copyOfRange(payload, 1, payload.length));
        }
    }

    public static String ndefRecordToString(NdefRecord record) throws FormatException {
        if (record.getTnf() == (short) 3) {
            return absoluteUriRecordToString(record);
        }
        if (record.getTnf() == (short) 0) {
            return new String("empty NDEF Record");
        }
        if (record.getTnf() == (short) 4) {
            return externalTypeRecordToString(record);
        }
        if (record.getTnf() == (short) 2) {
            return mimeMediaRecordToString(record);
        }
        if (record.getTnf() == (short) 6) {
            return new String("chunked NDEF Record");
        }
        if (record.getTnf() == (short) 5) {
            return new String("unkown NDEF Record type name format");
        }
        if (record.getTnf() == (short) 1) {
            return wellKnownRecordToString(record);
        }
        throw new FormatException("unkown NDEF Record TNF value");
    }
}
