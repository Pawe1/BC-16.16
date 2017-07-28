package de.pagecon.ane.functions;

import android.content.Intent;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.notificationlistenerservice.Manager;

public class OpenSecuritySettings implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ OpenSecuritySettings +++");
        try {
            Manager.instance.activity.startActivity(new Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"));
        } catch (Exception e) {
            Manager.cLog("Error in OpenSecuritySettings: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
