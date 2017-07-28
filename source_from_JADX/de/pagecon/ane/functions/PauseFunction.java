package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

@TargetApi(10)
public class PauseFunction implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ PauseFunction +++");
        try {
            if (Manager.instance.nfcAdapter != null) {
                Manager.cLog("disableForegroundDispatch");
                Manager.instance.nfcAdapter.disableForegroundDispatch(freContext.getActivity());
            }
        } catch (Exception e) {
            Manager.cLog("Error in PauseFunction: " + e.getMessage());
        }
        return null;
    }
}
