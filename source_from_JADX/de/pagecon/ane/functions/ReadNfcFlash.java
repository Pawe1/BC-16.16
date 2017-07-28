package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.Tag;
import android.os.AsyncTask;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.internal.ServerProtocol;
import com.sigmasport.FlashRecords;
import com.sigmasport.nfctag.NfcTag;
import com.sigmasport.protocol.SigmaProtocolMsgNtagHandler;
import de.pagecon.ane.exceptions.NfcReadException;
import de.pagecon.ane.nfc.ExtensionContext;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

@TargetApi(10)
public class ReadNfcFlash implements FREFunction {
    private static int MAXIMUM_RETRIES = 10;
    private static int RETRY_WAIT_TIME_MS = 300;

    private class ReadFlashTask extends AsyncTask<FlashRecords, Void, FlashRecords> {
        private ReadFlashTask() {
        }

        protected FlashRecords doInBackground(FlashRecords... params) {
            int retries;
            FlashRecords flashRecord = params[0];
            Manager.cLog("bgprocess: FlashRecord: " + flashRecord.toJson());
            try {
                Thread.sleep((long) Manager.instance.mReadSettingDataDelay);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (Manager.mNfcTag.getTagManufacturer() == 1) {
                Boolean hasErrors;
                try {
                    if (!Manager.mNtagHandler.isConnected().booleanValue()) {
                        Manager.mNtagHandler.connect();
                        Manager.mNtagHandler.enterFifoMode();
                        Thread.sleep((long) Manager.instance.mEnterFifoModeDelay);
                    }
                    hasErrors = Boolean.valueOf(true);
                    retries = 0;
                    byte[] tmpBytes = new byte[(flashRecord.dataLength + 5)];
                    while (hasErrors.booleanValue()) {
                        Manager.cLog("start loop: " + retries);
                        hasErrors = Boolean.valueOf(false);
                        tmpBytes = Manager.mNtagHandler.readPDTP(flashRecord.getCommandBytes(), flashRecord.dataLength, flashRecord.cmd);
                        Manager.cLog("tmpBytes: " + tmpBytes.length);
                        flashRecord.setBytes(tmpBytes);
                        Manager.cLog("readPDTP did work! copy data!");
                        Manager.cLog("flashRecord.dataLength " + flashRecord.dataLength);
                        Manager.cLog("end loop: " + retries);
                    }
                    if (!hasErrors.booleanValue()) {
                        Manager.dispatchNfcResult(flashRecord, ExtensionContext.EVENT_NFC_READ_FLASH_READY);
                    }
                    if (!Manager.keepTagOpen.booleanValue()) {
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                    }
                } catch (NfcReadException e2) {
                    Manager.cLog("[NfcReadException] " + e2.toString());
                    hasErrors = Boolean.valueOf(true);
                    retries++;
                    if (retries >= ReadNfcFlash.MAXIMUM_RETRIES) {
                        flashRecord.errorMessage = "Communication failed after " + retries + " retries. (max: " + ReadNfcFlash.MAXIMUM_RETRIES + ") Error: " + e2.getMessage();
                        Manager.dispatchNfcError(flashRecord);
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                        throw new IOException(flashRecord.errorMessage);
                    }
                    Manager.cLog("Communication faild... try again... " + retries);
                    Thread.sleep((long) ReadNfcFlash.RETRY_WAIT_TIME_MS);
                } catch (Exception e3) {
                    Manager.cLog("[ERROR] " + e3.getMessage());
                    hasErrors = Boolean.valueOf(true);
                    retries++;
                    if (retries >= ReadNfcFlash.MAXIMUM_RETRIES) {
                        flashRecord.errorMessage = "Communication failed after " + retries + " retries. (max: " + ReadNfcFlash.MAXIMUM_RETRIES + ") Error: " + e3.getMessage();
                        Manager.dispatchNfcError(flashRecord);
                        Manager.mNtagHandler.close();
                        Manager.mNfcTag.close();
                        Manager.dispose();
                        throw new IOException(flashRecord.errorMessage);
                    }
                    Manager.cLog("Communication faild... try again... " + retries);
                    Thread.sleep((long) ReadNfcFlash.RETRY_WAIT_TIME_MS);
                } catch (IOException e4) {
                    e4.printStackTrace();
                    flashRecord.errorMessage = e4.getMessage();
                    Manager.dispose();
                    Manager.dispatchNfcError(flashRecord);
                } catch (NfcReadException e22) {
                    e22.printStackTrace();
                    flashRecord.errorMessage = e22.getMessage();
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
        FlashRecords flashRecord = new FlashRecords(0, 0, "");
        try {
            FlashRecords flashRecord2 = new FlashRecords(freObjects[0].getAsInt(), freObjects[1].getAsInt(), freObjects[2].getAsString());
            try {
                Manager.keepTagOpen = Boolean.valueOf(freObjects[3].getAsBool());
                Manager.cLog("keepTagOpen: " + (Manager.keepTagOpen.booleanValue() ? ServerProtocol.DIALOG_RETURN_SCOPES_TRUE : "false"));
                flashRecord = flashRecord2;
            } catch (Exception e2) {
                e = e2;
                flashRecord = flashRecord2;
                flashRecord.errorMessage = e.getMessage();
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
                    Manager.dispose();
                    Manager.dispatchNfcError(flashRecord);
                    e3.printStackTrace();
                }
                Manager.cLog("create NfcTag mTag");
                Manager.mNfcTag = new NfcTag(Manager.mTag);
                if (Manager.mNfcTag != null) {
                    Manager.cLog("mNfcTag: " + Manager.mNfcTag.toString());
                    try {
                        new ReadFlashTask().execute(new FlashRecords[]{flashRecord});
                    } catch (IllegalStateException e4) {
                        flashRecord.errorMessage = e4.getMessage();
                        Manager.dispose();
                        Manager.dispatchNfcError(flashRecord);
                        e4.printStackTrace();
                    }
                }
                return null;
            }
        } catch (Exception e5) {
            e = e5;
            flashRecord.errorMessage = e.getMessage();
            Manager.dispose();
            Manager.dispatchNfcError(flashRecord);
            e.printStackTrace();
            mintent = freContext.getActivity().getIntent();
            Manager.cLog("create Tag mTag");
            Manager.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
            Manager.cLog("create SigmaProtocolMsgNtagHandler mNtagHandler");
            Manager.mNtagHandler = new SigmaProtocolMsgNtagHandler(Manager.mTag);
            Manager.cLog("create NfcTag mTag");
            Manager.mNfcTag = new NfcTag(Manager.mTag);
            if (Manager.mNfcTag != null) {
                Manager.cLog("mNfcTag: " + Manager.mNfcTag.toString());
                new ReadFlashTask().execute(new FlashRecords[]{flashRecord});
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
        if (!(mintent == null || Manager.mTag == null)) {
            if (!Manager.keepTagOpen.booleanValue() || Manager.mNfcTag == null) {
                Manager.cLog("create NfcTag mTag");
                Manager.mNfcTag = new NfcTag(Manager.mTag);
            }
            if (Manager.mNfcTag != null) {
                Manager.cLog("mNfcTag: " + Manager.mNfcTag.toString());
                new ReadFlashTask().execute(new FlashRecords[]{flashRecord});
            }
        }
        return null;
    }
}
