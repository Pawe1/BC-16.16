package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.BaseConfig;
import de.pagecon.ane.nfc.Manager;

public class GetNativeNfcAneVersion implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ GetNativeAneVersion +++");
        FREObject result = null;
        try {
            result = FREObject.newObject(BaseConfig.ANE_NATIVE_VERSION);
        } catch (Exception e) {
            Manager.cLog("Error in GetNativeAneVersion: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
