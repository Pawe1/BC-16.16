package com.sigmasport;

import android.nfc.FormatException;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.Tag;
import android.nfc.tech.Ndef;
import android.util.Log;
import java.io.IOException;
import java.util.Arrays;

public class SigmaNdefMessage {
    private static final String TAG = SigmaNdefMessage.class.getName();

    public static byte[] readByte(Tag tag) throws IOException, FormatException, NullPointerException {
        String errorMessage;
        Ndef ndefTag = Ndef.get(tag);
        if (ndefTag == null) {
            Log.d(TAG, "ndefTag == null");
        } else if (!ndefTag.isConnected()) {
            try {
                ndefTag.connect();
                NdefRecord[] records = ndefTag.getNdefMessage().getRecords();
                for (int i = 0; i < records.length; i++) {
                    for (NdefRecord record : records) {
                        if (new String(record.getType()).equals("text/plain")) {
                            int payloadLen = record.getPayload().length;
                            byte[] payloadByte = new byte[payloadLen];
                            for (int k = 0; k < payloadLen; k++) {
                                payloadByte[k] = record.getPayload()[k];
                            }
                            ndefTag.close();
                            System.out.println(payloadByte);
                            return payloadByte;
                        }
                    }
                }
            } catch (NullPointerException e) {
                ndefTag.close();
                errorMessage = "Ndef record is null";
                if (e.getMessage() == null) {
                    throw new NullPointerException(errorMessage);
                }
            } catch (IOException e2) {
                errorMessage = "Fail to connect Ndef tag";
                if (e2.getMessage() == null) {
                    throw new IOException(errorMessage);
                }
            }
        }
        return null;
    }

    public static boolean write(Tag tag, NdefRecord record) throws Exception {
        return write(tag, new NdefMessage(new NdefRecord[]{record}));
    }

    private static boolean write(Tag tag, NdefMessage msg) throws IOException, FormatException {
        String errorMessage;
        if (!Arrays.asList(tag.getTechList()).contains(Ndef.class.getName())) {
            return false;
        }
        Ndef ndefTag = Ndef.get(tag);
        if (ndefTag != null) {
            if (!ndefTag.isConnected()) {
                try {
                    ndefTag.connect();
                } catch (IOException e) {
                    errorMessage = "Fail to connect Ndef tag";
                    if (e.getMessage() == null) {
                        throw new IOException(errorMessage);
                    }
                }
            }
            int msgSize = msg.toByteArray().length;
            int maxSize = ndefTag.getMaxSize();
            if (msgSize > maxSize) {
                throw new FormatException("Ndef message-size of " + (((double) msgSize) / 1000.0d) + "kb is too big, maximum Ndef message size on this device is " + (((double) maxSize) / 1000.0d) + "kb");
            }
            try {
                ndefTag.writeNdefMessage(msg);
            } catch (IOException e2) {
                errorMessage = "Fail to write Ndef tag";
                if (e2.getMessage() == null) {
                    throw new IOException(errorMessage);
                }
            }
            ndefTag.close();
            return true;
        }
        throw new IOException("Tag cannot store NDEF Messages");
    }

    public static byte[] readByte(Ndef ndefTag) throws IOException, FormatException {
        try {
            NdefRecord[] records = ndefTag.getNdefMessage().getRecords();
            Log.d(TAG, "records= " + records[0]);
            for (int i = 0; i < records.length; i++) {
                for (NdefRecord record : records) {
                    if (new String(record.getType()).equals("text/plain")) {
                        int payloadLen = record.getPayload().length;
                        byte[] payloadByte = new byte[payloadLen];
                        for (int k = 0; k < payloadLen; k++) {
                            payloadByte[k] = record.getPayload()[k];
                        }
                        return payloadByte;
                    }
                }
            }
        } catch (IOException e) {
            errorMessage = "Ndef tag no records";
            if (e.getMessage() == null) {
                String errorMessage;
                throw new IOException(errorMessage);
            }
        }
        return null;
    }

    public static boolean write(Ndef ndefTag, NdefRecord record) throws Exception {
        return write(ndefTag, new NdefMessage(new NdefRecord[]{record}));
    }

    private static boolean write(Ndef ndefTag, NdefMessage msg) throws IOException, FormatException {
        int msgSize = msg.toByteArray().length;
        int maxSize = ndefTag.getMaxSize();
        if (msgSize > maxSize) {
            throw new FormatException("Ndef message-size of " + (((double) msgSize) / 1000.0d) + "kb is too big, maximum Ndef message size on this device is " + (((double) maxSize) / 1000.0d) + "kb");
        }
        Log.d(TAG, "as3953Ndef.writeNdefMessage(msg)");
        try {
            ndefTag.writeNdefMessage(msg);
        } catch (IOException e) {
            String errorMessage = "Fail to write Ndef tag";
            if (e.getMessage() == null) {
                throw new IOException(errorMessage);
            }
        }
        return false;
    }
}
