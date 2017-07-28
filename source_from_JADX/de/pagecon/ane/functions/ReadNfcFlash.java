package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.Tag;
import android.os.AsyncTask;
import android.os.Process;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sigmasport.FlashRecords;
import com.sigmasport.nfctag.NfcTag;
import com.sigmasport.protocol.SigmaProtocolMsgNtagHandler;
import de.pagecon.ane.ErrorCodes;
import de.pagecon.ane.exceptions.NfcReadException;
import de.pagecon.ane.nfc.ExtensionContext;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

@TargetApi(14)
public class ReadNfcFlash implements FREFunction {
    private static int MAXIMUM_RETRIES = 10;
    private static int RETRY_WAIT_TIME_MS = 20;

    private class ReadFlashTask extends AsyncTask<FlashRecords, Void, FlashRecords> {
        private ReadFlashTask() {
        }

        protected FlashRecords doInBackground(FlashRecords... params) {
            Process.setThreadPriority(-2);
            FlashRecords flashRecord = params[0];
            try {
                Thread.sleep((long) Manager.instance.mReadSettingDataDelay);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (Manager.mNfcTag.getTagManufacturer() == 1) {
                try {
                    if (!Manager.mNtagHandler.isConnected().booleanValue()) {
                        Manager.mNtagHandler.connect();
                        Manager.mNtagHandler.enterFifoMode(flashRecord.fifoBit);
                        Thread.sleep((long) Manager.instance.mEnterFifoModeDelay);
                    }
                    Boolean hasErrors = Boolean.valueOf(true);
                    int retries = 0;
                    byte[] tmpBytes = new byte[(flashRecord.dataLength + 5)];
                    String errorMessage = "";
                    while (hasErrors.booleanValue() && retries < ReadNfcFlash.MAXIMUM_RETRIES) {
                        hasErrors = Boolean.valueOf(false);
                        retries++;
                        Manager.cLog("start loop: " + retries);
                        try {
                            tmpBytes = Manager.mNtagHandler.readPDTP(flashRecord);
                            Manager.cLog("tmpBytes: " + tmpBytes.length);
                            flashRecord.setBytes(tmpBytes);
                            Manager.cLog("readPDTP did work! copy data!");
                            Manager.cLog("flashRecord.dataLength " + flashRecord.dataLength);
                        } catch (NfcReadException e2) {
                            hasErrors = Boolean.valueOf(true);
                            errorMessage = "[NfcReadException] Communication failed after " + retries + " retries. (max: " + ReadNfcFlash.MAXIMUM_RETRIES + ") Error: " + e2.getMessage();
                            Manager.cLog("[NfcReadException] " + e2.toString());
                        } catch (Exception e3) {
                            hasErrors = Boolean.valueOf(true);
                            errorMessage = "[ERROR] Communication failed after " + retries + " retries. (max: " + ReadNfcFlash.MAXIMUM_RETRIES + ") Error: " + e3.getMessage();
                            Manager.cLog("[ERROR] " + e3.getMessage());
                        }
                        if (hasErrors.booleanValue()) {
                            Manager.cLog("[ERROR] Communication faild... try again... " + retries);
                            Thread.sleep((long) ReadNfcFlash.RETRY_WAIT_TIME_MS);
                        }
                        Manager.cLog("end loop: " + retries);
                    }
                    if (hasErrors.booleanValue()) {
                        flashRecord.errorMessage = errorMessage;
                        Manager.dispatchNfcError(flashRecord);
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                        throw new IOException(flashRecord.errorMessage);
                    }
                    Manager.dispatchNfcResult(flashRecord, ExtensionContext.EVENT_NFC_READ_FLASH_READY);
                    if (!Manager.keepTagOpen.booleanValue()) {
                        Manager.cLog("keepTagOpen == false => close Tag");
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                    }
                } catch (IOException e4) {
                    e4.printStackTrace();
                    flashRecord.errorMessage = e4.getMessage();
                    Manager.dispose();
                    Manager.dispatchNfcError(flashRecord);
                } catch (InterruptedException e5) {
                    e5.printStackTrace();
                    flashRecord.errorMessage = e5.getMessage();
                    Manager.dispose();
                    Manager.dispatchNfcError(flashRecord);
                }
            } else {
                flashRecord.errorMessage = "Wrong manufacturer...";
                Manager.dispose();
                Manager.dispatchNfcError(flashRecord);
            }
            return null;
        }

        protected void onPreExecute() {
            super.onPreExecute();
        }

        protected void onPostExecute(FlashRecords result) {
            super.onPostExecute(result);
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Exception e;
        Intent mintent;
        Manager.cLog("+++ ReadNfcFlash: START call");
        FlashRecords flashRecord = new FlashRecords(0, 0, "", Boolean.valueOf(true));
        try {
            int startAddr = freObjects[0].getAsInt();
            int endAddr = freObjects[1].getAsInt();
            String commandString = freObjects[2].getAsString();
            Boolean keepTagOpen = Boolean.valueOf(freObjects[3].getAsBool());
            int readDelay = freObjects[4].getAsInt();
            int fifoBit = freObjects[5].getAsInt();
            int readBlockDelay = freObjects[6].getAsInt();
            FlashRecords flashRecord2 = new FlashRecords(startAddr, endAddr, commandString, Boolean.valueOf(true));
            try {
                flashRecord2.readDelay = readDelay;
                flashRecord2.readBlockDelay = readBlockDelay;
                flashRecord2.fifoBit = fifoBit;
                Manager.keepTagOpen = keepTagOpen;
                flashRecord = flashRecord2;
            } catch (Exception e2) {
                e = e2;
                flashRecord = flashRecord2;
                flashRecord.errorMessage = e.getMessage();
                flashRecord.errorCode = 1;
                Manager.dispose();
                Manager.dispatchNfcError(flashRecord);
                e.printStackTrace();
                mintent = freContext.getActivity().getIntent();
                Manager.cLog("create Tag mTag");
                Manager.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
                try {
                    Manager.cLog("create SigmaProtocolMsgNtagHandler mNtagHandler");
                    Manager.mNtagHandler = new SigmaProtocolMsgNtagHandler(Manager.mTag);
                } catch (IOException e3) {
                    flashRecord.errorMessage = e3.getMessage();
                    flashRecord.errorCode = ErrorCodes.ERR_INIT_SIGMA_PROTOCOL_MSG_NTAG_HANDLER_FAILED;
                    Manager.dispose();
                    Manager.dispatchNfcError(flashRecord);
                    e3.printStackTrace();
                }
                if (mintent != null) {
                }
                return null;
            }
        } catch (Exception e4) {
            e = e4;
            flashRecord.errorMessage = e.getMessage();
            flashRecord.errorCode = 1;
            Manager.dispose();
            Manager.dispatchNfcError(flashRecord);
            e.printStackTrace();
            mintent = freContext.getActivity().getIntent();
            Manager.cLog("create Tag mTag");
            Manager.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
            Manager.cLog("create SigmaProtocolMsgNtagHandler mNtagHandler");
            Manager.mNtagHandler = new SigmaProtocolMsgNtagHandler(Manager.mTag);
            if (mintent != null) {
            }
            return null;
        }
        mintent = freContext.getActivity().getIntent();
        if (!Manager.keepTagOpen.booleanValue() || Manager.mTag == null) {
            Manager.cLog("create Tag mTag");
            Manager.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
        }
        if (!Manager.keepTagOpen.booleanValue() || Manager.mNtagHandler == null) {
            Manager.cLog("create SigmaProtocolMsgNtagHandler mNtagHandler");
            Manager.mNtagHandler = new SigmaProtocolMsgNtagHandler(Manager.mTag);
        }
        if (mintent != null || Manager.mTag == null) {
            return null;
        }
        if (!Manager.keepTagOpen.booleanValue() || Manager.mNfcTag == null) {
            Manager.cLog("create NfcTag mTag");
            Manager.mNfcTag = new NfcTag(Manager.mTag);
        }
        if (Manager.mNfcTag == null) {
            return null;
        }
        Manager.cLog("mNfcTag: " + Manager.mNfcTag.toString());
        try {
            ReadNfcFlash readNfcFlash = this;
            new ReadFlashTask().execute(new FlashRecords[]{flashRecord});
        } catch (IllegalStateException e5) {
            flashRecord.errorMessage = e5.getMessage();
            Manager.dispose();
            Manager.dispatchNfcError(flashRecord);
            e5.printStackTrace();
        }
        return null;
    }
}
