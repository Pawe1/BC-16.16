package de.pagecon.ane.notificationlistenerservice;

import android.annotation.TargetApi;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.service.notification.StatusBarNotification;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.internal.ServerProtocol;
import com.facebook.share.internal.ShareConstants;
import de.pagecon.ane.functions.GetNativeAneVersion;
import de.pagecon.ane.functions.GetNotificationsEnabled;
import de.pagecon.ane.functions.OpenSecuritySettings;
import de.pagecon.ane.functions.SetNotificationDebugMode;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import org.json.JSONObject;

@TargetApi(21)
public class ExtensionContext extends FREContext implements ManagerListener {
    public static final String EVENT_APPLICATION_STATE_CHANGED = "eventApplicateionStateChanged";
    public static final String EVENT_NOTIFICATION = "eventNotification";
    public static final String EVENT_STATUS_CHANGED = "eventNotificationStatusChanged";
    private Map<String, FREFunction> functionMap;
    private ExtensionContext instance;
    private Boolean isInitialized = Boolean.valueOf(false);

    class C03801 implements FREFunction {
        C03801() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            if (!ExtensionContext.this.isInitialized.booleanValue()) {
                Manager.cLog("initializing NotificationListenerServiceANE v5 ...");
                if (Manager.instance == null) {
                    try {
                        Manager.create(ExtensionContext.this.getActivity(), ExtensionContext.this.instance);
                    } catch (Exception e) {
                        Manager.cLog("Exception Error while trying to create Manager instance..." + e.getMessage());
                    } finally {
                        Manager.cLog("Manager instance created...");
                    }
                }
                ExtensionContext.this.isInitialized = Boolean.valueOf(true);
            }
            return null;
        }
    }

    public ExtensionContext(String extensionName) {
        Manager.cLog("ExtensionContext");
        this.instance = this;
        this.functionMap = new HashMap();
        this.functionMap.put("initialize", new C03801());
        this.functionMap.put("setNotificationDebugMode", new SetNotificationDebugMode());
        this.functionMap.put("openSecuritySettings", new OpenSecuritySettings());
        this.functionMap.put("getNotificationsEnabled", new GetNotificationsEnabled());
        this.functionMap.put("getNativeAneVersion", new GetNativeAneVersion());
        for (Entry<String, FREFunction> entry : this.functionMap.entrySet()) {
            Manager.cLog("+++ ExtensionContext functionMap: " + ((String) entry.getKey()) + " / " + ((FREFunction) entry.getValue()).toString());
        }
    }

    public void dispose() {
    }

    public Map<String, FREFunction> getFunctions() {
        return this.functionMap;
    }

    public void dispatchNotification(StatusBarNotification sbn) {
        Manager.cLog("[StatusBarNotification]: " + sbn.getId() + " - " + sbn.getNotification().toString());
        try {
            JSONObject json = new JSONObject();
            String pack = sbn.getPackageName();
            String ticker = sbn.getNotification().tickerText.toString();
            Bundle extras = sbn.getNotification().extras;
            String title = extras.getString("android.title");
            String titleBig = extras.getString("android.title.big");
            CharSequence cstext = extras.getCharSequence("android.text");
            String text = cstext != null ? cstext.toString() : "";
            CharSequence cstextBig = extras.getCharSequence("android.bigText");
            String textBig = cstextBig != null ? cstextBig.toString() : "";
            CharSequence csinfoText = extras.getCharSequence("android.infoText");
            String infoText = csinfoText != null ? csinfoText.toString() : "";
            CharSequence cssubText = extras.getCharSequence("android.subText");
            String subText = cssubText != null ? cssubText.toString() : "";
            CharSequence cssummaryText = extras.getCharSequence("android.summaryText");
            String summaryText = cssummaryText != null ? cssummaryText.toString() : "";
            CharSequence[] csextraTextLines = extras.getCharSequenceArray("android.textLines");
            String extraTextLines = csextraTextLines != null ? csextraTextLines.toString() : "";
            json.put(ShareConstants.WEB_DIALOG_PARAM_ID, sbn.getId());
            json.put("tag", sbn.getTag());
            json.put("postTime", sbn.getPostTime());
            json.put("packageName", pack);
            json.put("tickerText", ticker);
            json.put(ShareConstants.WEB_DIALOG_PARAM_TITLE, title);
            json.put("titleBig", titleBig);
            json.put("text", text);
            json.put("textBig", textBig);
            json.put("infoText", infoText);
            json.put("subText", subText);
            json.put("summaryText", summaryText);
            json.put("extraTextLines", extraTextLines);
            json.put(ServerProtocol.DIALOG_PARAM_SDK_VERSION, VERSION.SDK_INT);
            if (VERSION.SDK_INT >= 21) {
                json.put("groupKey", sbn.getGroupKey());
                json.put("category", sbn.getNotification().category);
                json.put("group", sbn.getNotification().getGroup());
            } else {
                json.put("groupKey", "");
                json.put("category", 0);
                json.put("group", "");
            }
            dispatchStatusEventAsync(EVENT_NOTIFICATION, json.toString());
        } catch (Exception e) {
            Manager.cLog("[StatusBarNotification] ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void dispatchNotificationStatusChanged(Boolean notificationsEnabled) {
        Manager.cLog("[notificationsEnabled changed]: " + notificationsEnabled.toString());
        try {
            JSONObject json = new JSONObject();
            json.put("notificationsEnabled", notificationsEnabled);
            dispatchStatusEventAsync(EVENT_STATUS_CHANGED, json.toString());
        } catch (Exception e) {
            Manager.cLog("[notificationsEnabled changed] ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void dispatchNativeApplicationState(String state) {
        Manager.cLog("[dispatchNativeApplicationState changed]: " + state);
        try {
            JSONObject json = new JSONObject();
            json.put("state", state);
            dispatchStatusEventAsync(EVENT_APPLICATION_STATE_CHANGED, json.toString());
        } catch (Exception e) {
            Manager.cLog("[dispatchNativeApplicationState changed] ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
