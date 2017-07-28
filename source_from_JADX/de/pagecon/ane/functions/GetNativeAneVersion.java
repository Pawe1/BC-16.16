package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.notificationlistenerservice.Manager;

public class GetNativeAneVersion implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ GetNativeAneVersion +++");
        FREObject result = null;
        try {
            result = FREObject.newObject(6);
        } catch (Exception e) {
            Manager.cLog("Error in GetNativeAneVersion: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
