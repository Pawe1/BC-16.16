package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.os.AsyncTask;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sigmasport.FlashRecords;
import de.pagecon.ane.ErrorCodes;
import de.pagecon.ane.nfc.Manager;

@TargetApi(10)
public class CloseNfcTag implements FREFunction {
    FlashRecords flashRecord = new FlashRecords(0, 0, "", Boolean.valueOf(true));

    private class CloseNfcTagTask extends AsyncTask<Void, Void, Void> {
        private CloseNfcTagTask() {
        }

        protected Void doInBackground(Void... params) {
            try {
                Manager.keepTagOpen = Boolean.valueOf(false);
                if (Manager.mNtagHandler != null) {
                    Manager.mNtagHandler.close();
                }
                if (Manager.mNfcTag != null) {
                    Manager.mNfcTag.close();
                }
                Manager.dispose();
                Manager.dispatchNfcCloseTagReady();
            } catch (Exception e) {
                CloseNfcTag.this.flashRecord.errorMessage = e.getMessage();
                CloseNfcTag.this.flashRecord.errorCode = ErrorCodes.ERR_CLOSE_NFC_TAG_FAILED;
                Manager.dispatchNfcError(CloseNfcTag.this.flashRecord);
                e.printStackTrace();
            }
            return null;
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ CloseNfcTag: START call");
        try {
            new CloseNfcTagTask().execute(new Void[0]);
        } catch (IllegalStateException e) {
            this.flashRecord.errorMessage = e.getMessage();
            this.flashRecord.errorCode = ErrorCodes.ERR_ASYNC_TASK_FAILED;
            Manager.dispatchNfcError(this.flashRecord);
            e.printStackTrace();
        }
        return null;
    }
}
