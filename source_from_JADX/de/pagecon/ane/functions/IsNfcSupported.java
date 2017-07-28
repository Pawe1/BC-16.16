package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

public class IsNfcSupported implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        FREObject result = null;
        try {
            Manager.cLog("+++ IsNfcSupported +++");
            boolean supported = Manager.instance.nfcAdapter != null;
            Manager.cLog("nfcSupported: " + supported);
            result = FREObject.newObject(supported);
        } catch (Exception e) {
            Manager.cLog("Error in IsNfcSupported: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
