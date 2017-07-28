package de.pagecon.ane.functions;

import android.provider.Settings.Secure;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.notificationlistenerservice.Manager;

public class GetNotificationsEnabled implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ GetNotificationsEnabled +++");
        FREObject result = null;
        try {
            boolean enabled = Secure.getString(Manager.instance.activity.getContentResolver(), "enabled_notification_listeners").contains(Manager.instance.activity.getApplicationContext().getPackageName());
            Manager.cLog("Notifications enabled: " + enabled);
            result = FREObject.newObject(enabled);
        } catch (Exception e) {
            Manager.cLog("Error in GetNotificationsEnabled: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
