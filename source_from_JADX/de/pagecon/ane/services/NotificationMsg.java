package de.pagecon.ane.services;

import de.pagecon.ane.notificationlistenerservice.Manager;
import org.json.JSONException;
import org.json.JSONObject;

public class NotificationMsg {
    public static final String FIELD_ERRORCODE = "errorCode";
    public static final String FIELD_ERRORMESSAGE = "errorMessage";
    public static final String FIELD_NOTIFICATIONID = "notificationId";
    public static final String FIELD_NOTIFICATIONMESSAGE = "notificationMessage";
    public int errorCode = 0;
    public String errorMessage = "";
    public int notificationId = 0;
    public String notificationMessage = "";

    public NotificationMsg(int notificationId, String notificationMessage) {
        this.notificationId = notificationId;
        this.notificationMessage = notificationMessage;
    }

    public String toJson() {
        JSONObject json = new JSONObject();
        try {
            json.put(FIELD_NOTIFICATIONID, this.notificationId);
            json.put(FIELD_NOTIFICATIONMESSAGE, this.notificationMessage.trim());
            json.put("errorMessage", this.errorMessage.trim());
            json.put("errorCode", this.errorCode);
        } catch (JSONException e) {
            Manager.cLog("NotificationMsg.toJson() Error: " + e.getMessage());
            e.printStackTrace();
        }
        return json.toString();
    }
}
