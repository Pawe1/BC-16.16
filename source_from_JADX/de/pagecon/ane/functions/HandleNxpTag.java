package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.Tag;
import android.nfc.tech.NfcA;
import android.os.AsyncTask;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.nxp.NxpNtag;
import com.nxp.NxpNtag.R_W_Methods;
import com.sigmasport.NxpTagCmd;
import com.sigmasport.nfctag.NfcTag;
import de.pagecon.ane.nfc.ExtensionContext;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

@TargetApi(10)
public class HandleNxpTag implements FREFunction {

    private class ProcessNxpTagCmd extends AsyncTask<NxpTagCmd, Void, NxpTagCmd> {
        private ProcessNxpTagCmd() {
        }

        protected NxpTagCmd doInBackground(NxpTagCmd... params) {
            NxpTagCmd nxpTagCmd = params[0];
            if (Manager.mNxpTag != null) {
                try {
                    switch (nxpTagCmd.getNxpMethod()) {
                        case 10:
                            if (!Manager.mNxpTag.isConnected()) {
                                Manager.mNxpTag.connect();
                                break;
                            }
                            break;
                        case 11:
                            nxpTagCmd.retData = Boolean.valueOf(Manager.mNxpTag.isConnected());
                            break;
                        case 20:
                            Manager.mNxpTag.close();
                            break;
                        case NxpTagCmd.METHOD_WRITE /*30*/:
                            Manager.mNxpTag.write(nxpTagCmd.data, (byte) nxpTagCmd.block);
                            break;
                        case NxpTagCmd.METHOD_FAST_READ /*31*/:
                            nxpTagCmd.retData = Manager.mNxpTag.fast_read((byte) nxpTagCmd.startAddr, (byte) nxpTagCmd.endAddr);
                            break;
                        case NxpTagCmd.METHOD_WRITE_SRAM /*40*/:
                            Manager.mNxpTag.write_SRAM(nxpTagCmd.data, R_W_Methods.Polling_Mode);
                            break;
                        case NxpTagCmd.METHOD_READ_SRAM /*41*/:
                            nxpTagCmd.retData = Manager.mNxpTag.read_SRam(1, R_W_Methods.Fast_Mode, nxpTagCmd.readDelay);
                            break;
                    }
                    if (nxpTagCmd.retData != null) {
                        Manager.dispatchNfcResult(nxpTagCmd, ExtensionContext.EVENT_NFC_NXPTAG_RESULT);
                    }
                } catch (IOException e) {
                }
            }
            return null;
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ HandleNxpTag: START call");
        FREObject returnSuccess = null;
        FREObject returnError = null;
        try {
            returnSuccess = FREObject.newObject(true);
            returnError = FREObject.newObject(false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        NxpTagCmd nxpTagCmd = new NxpTagCmd();
        try {
            nxpTagCmd.setNxpMethod(freObjects[0].getAsInt());
            nxpTagCmd.readDelay = freObjects[1].getAsInt();
        } catch (Exception e2) {
            nxpTagCmd.errorMessage = e2.getMessage();
            nxpTagCmd.errorCode = 1;
            Manager.dispose();
            Manager.dispatchNfcError(nxpTagCmd);
            e2.printStackTrace();
        }
        Intent mintent = freContext.getActivity().getIntent();
        if (mintent == null) {
            return returnError;
        }
        if (Manager.mTag == null) {
            Manager.cLog("create Tag Manager.mTag");
            Manager.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
        }
        if (Manager.mTag == null) {
            return returnError;
        }
        if (Manager.mNfcTag == null) {
            Manager.cLog("create NfcTag Manager.mNfcTag");
            Manager.mNfcTag = new NfcTag(Manager.mTag);
        }
        if (Manager.mNfcTag == null) {
            return returnError;
        }
        if (Manager.mNfcTag.getTagManufacturer() != 1) {
            nxpTagCmd.errorMessage = "Wrong manufacturer...";
            Manager.dispose();
            Manager.dispatchNfcError(nxpTagCmd);
            return returnError;
        }
        if (Manager.mNxpTag == null) {
            Manager.cLog("create NxpNtag Manager.mNxpTag");
            Manager.mNxpTag = new NxpNtag(NfcA.get(Manager.mTag));
        }
        if (Manager.mNxpTag != null) {
            return returnSuccess;
        }
        return returnError;
    }
}
