package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

public class SetDebugMode implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ SetDebugMode +++");
        try {
            Manager.DEBUG_MODE = freObjects[0].getAsBool();
        } catch (Exception e) {
            Manager.cLog("Error in SetDebugMode: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
