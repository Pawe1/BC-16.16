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
public class WriteNfcFlash implements FREFunction {

    private class WriteFlashTask extends AsyncTask<FlashRecords, Void, FlashRecords> {
        private WriteFlashTask() {
        }

        protected FlashRecords doInBackground(FlashRecords... params) {
            Process.setThreadPriority(-2);
            FlashRecords flashRecord = params[0];
            flashRecord.init();
            if (Manager.mNfcTag.getTagManufacturer() == 1) {
                try {
                    Thread.sleep((long) Manager.instance.mReadSettingDataDelay);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                try {
                    if (!Manager.mNtagHandler.isConnected().booleanValue()) {
                        Manager.mNtagHandler.connect();
                        Manager.mNtagHandler.enterFifoMode(flashRecord.fifoBit);
                        Thread.sleep((long) Manager.instance.mEnterFifoModeDelay);
                    }
                    Boolean hasErrors = Boolean.valueOf(true);
                    int errorCount = 0;
                    byte[] tmpBytes = new byte[(flashRecord.dataLength + 5)];
                    Manager.instance.setDefaults();
                    while (hasErrors.booleanValue() && errorCount < 3) {
                        try {
                            hasErrors = Boolean.valueOf(false);
                            tmpBytes = Manager.mNtagHandler.writePDTP(flashRecord.getCommandBytes());
                            Manager.cLog("tmpBytes: " + tmpBytes.length);
                            flashRecord.setBytes(tmpBytes);
                            Manager.cLog("writePDTP did work! copy data!");
                            Manager.cLog("flashRecord.dataLength " + flashRecord.dataLength);
                        } catch (NfcReadException e2) {
                            hasErrors = Boolean.valueOf(true);
                            flashRecord.errorMessage = e2.toString();
                        } catch (Exception e3) {
                            hasErrors = Boolean.valueOf(true);
                            flashRecord.errorMessage = e3.getMessage();
                        }
                        if (hasErrors.booleanValue()) {
                            errorCount++;
                            Manager.dispatchNfcReset(flashRecord);
                            Manager manager = Manager.instance;
                            manager.mWriteSleepTime += 50;
                            Manager.cLog("[WRITE ERROR] (" + errorCount + ")" + flashRecord.errorMessage + " ::: increasing mWriteSleepTime to " + Manager.instance.mWriteSleepTime);
                        }
                    }
                    flashRecord.setCommandByteString("");
                    if (hasErrors.booleanValue()) {
                        Manager.dispatchNfcError(flashRecord);
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                        throw new IOException(flashRecord.errorMessage);
                    }
                    Manager.dispatchNfcResult(flashRecord, ExtensionContext.EVENT_NFC_WRITE_FLASH_READY);
                    if (!Manager.keepTagOpen.booleanValue()) {
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
        Manager.cLog("+++ WriteNfcFlash: START call");
        FlashRecords flashRecord = new FlashRecords(0, 0, "", Boolean.valueOf(false));
        try {
            String commandString = freObjects[0].getAsString();
            Boolean keepTagOpen = Boolean.valueOf(freObjects[1].getAsBool());
            int readDelay = freObjects[2].getAsInt();
            int fifoBit = freObjects[3].getAsInt();
            FlashRecords flashRecord2 = new FlashRecords(0, 0, commandString, Boolean.valueOf(false));
            try {
                flashRecord2.readDelay = readDelay;
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
            new WriteFlashTask().execute(new FlashRecords[]{flashRecord});
        } catch (IllegalStateException e5) {
            flashRecord.errorMessage = e5.getMessage();
            Manager.dispose();
            Manager.dispatchNfcError(flashRecord);
            e5.printStackTrace();
        }
        return null;
    }
}
