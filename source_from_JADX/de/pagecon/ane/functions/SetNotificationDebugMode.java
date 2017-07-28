package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.notificationlistenerservice.BaseConfig;
import de.pagecon.ane.notificationlistenerservice.Manager;

public class SetNotificationDebugMode implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ SetNotificationDebugMode +++");
        try {
            BaseConfig.DEBUG_MODE_ON = freObjects[0].getAsBool();
        } catch (Exception e) {
            Manager.cLog("Error in SetNotificationDebugMode: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
