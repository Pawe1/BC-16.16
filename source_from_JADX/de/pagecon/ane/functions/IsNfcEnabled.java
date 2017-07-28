package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

public class IsNfcEnabled implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        FREObject result = null;
        try {
            Manager.cLog("+++ IsNfcEnabled +++");
            boolean enabled = Manager.instance.nfcAdapter.isEnabled();
            Manager.cLog("nfcEnabled: " + enabled);
            result = FREObject.newObject(enabled);
        } catch (Exception e) {
            Manager.cLog("Error in IsNfcEnabled: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
