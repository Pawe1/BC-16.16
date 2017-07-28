package de.pagecon.ane.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.BaseConfig;
import de.pagecon.ane.nfc.Manager;

public class SetDebugMode implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ SetDebugMode +++");
        try {
            Manager.DEBUG_MODE = freObjects[0].getAsBool();
            Log.i(BaseConfig.TAG, "+++ SetDebugMode => " + (Manager.DEBUG_MODE ? "an" : "aus"));
        } catch (Exception e) {
            Log.i(BaseConfig.TAG, "Error in SetDebugMode: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
