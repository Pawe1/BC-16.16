package com.adobe.air.wand.message.json;

import com.adobe.air.wand.message.Message;
import com.adobe.air.wand.message.Message.Type;
import com.adobe.air.wand.message.MessageDataArray;
import com.adobe.air.wand.message.MessageDataObject;
import com.adobe.air.wand.message.MessageManager;
import com.adobe.air.wand.message.Notification;
import com.adobe.air.wand.message.Request;
import com.adobe.air.wand.message.Request.Data;
import com.adobe.air.wand.message.Request.Header;
import com.adobe.air.wand.message.Response;
import com.adobe.air.wand.message.Response.Status;
import com.facebook.internal.AnalyticsEvents;
import com.facebook.share.internal.ShareConstants;
import org.json.JSONObject;

public class JSONMessageManager extends MessageManager {
    public MessageDataObject createDataObject() {
        return new JSONMessageDataObject();
    }

    public MessageDataArray createDataArray() {
        return new JSONMessageDataArray();
    }

    public String serializeMessage(Message message) throws Exception {
        return createJSONMessage(message).toString();
    }

    public Message deserializeWandMessage(String str) throws Exception {
        return createWandMessage(new JSONObject(str));
    }

    public Request createWandRequest(String str, String str2, MessageDataArray messageDataArray) throws Exception {
        Header header = new Header(str, str2, System.currentTimeMillis());
        if (messageDataArray == null) {
            messageDataArray = new JSONMessageDataArray();
        }
        return new Request(header, new Data(messageDataArray));
    }

    public Response createWandResponse(String str, String str2, MessageDataObject messageDataObject, Status status) throws Exception {
        Response.Header header = new Response.Header(str, str2, System.currentTimeMillis(), status);
        if (messageDataObject == null) {
            messageDataObject = new JSONMessageDataObject();
        }
        return new Response(header, new Response.Data(messageDataObject));
    }

    public Notification createWandNotification(String str, MessageDataObject messageDataObject) throws Exception {
        Notification.Header header = new Notification.Header(str, System.currentTimeMillis());
        if (messageDataObject == null) {
            messageDataObject = new JSONMessageDataObject();
        }
        return new Notification(header, new Notification.Data(messageDataObject));
    }

    private static Message createWandMessage(JSONObject jSONObject) throws Exception {
        Message message;
        synchronized (jSONObject) {
            JSONObject jSONObject2 = jSONObject.getJSONObject("header");
            JSONObject jSONObject3 = jSONObject.getJSONObject(ShareConstants.WEB_DIALOG_PARAM_DATA);
            String string = jSONObject2.getString(ShareConstants.WEB_DIALOG_PARAM_TITLE);
            String string2 = jSONObject2.getString("type");
            long j = jSONObject2.getLong("timestamp");
            message = null;
            if (string2.equals(Type.REQUEST.toString())) {
                message = new Request(new Header(string, jSONObject2.getString("taskID"), j), new Data(new JSONMessageDataArray(jSONObject3.getJSONArray("arguments"))));
            } else if (string2.equals(Type.RESPONSE.toString())) {
                Status status;
                string2 = jSONObject2.getString("taskID");
                String string3 = jSONObject2.getString(AnalyticsEvents.PARAMETER_SHARE_DIALOG_CONTENT_STATUS);
                if (string3.equals(Status.SUCCESS.toString())) {
                    status = Status.SUCCESS;
                } else if (string3.equals(Status.ERROR.toString())) {
                    status = Status.ERROR;
                } else {
                    throw new Exception("Unable to fetch Response status");
                }
                message = new Response(new Response.Header(string, string2, j, status), new Response.Data(new JSONMessageDataObject(jSONObject3.getJSONObject("result"))));
            } else if (string2.equals(Type.NOTIFICATION.toString())) {
                message = new Notification(new Notification.Header(string, j), new Notification.Data(new JSONMessageDataObject(jSONObject3.getJSONObject("notification"))));
            }
        }
        return message;
    }

    private static JSONObject createJSONMessage(Message message) throws Exception {
        JSONObject jSONObject;
        synchronized (message) {
            Message.Header header;
            Type type = message.getHeader().getType();
            JSONObject jSONObject2 = new JSONObject();
            JSONObject jSONObject3 = new JSONObject();
            switch (type) {
                case REQUEST:
                    header = (Header) message.getHeader();
                    Data data = (Data) message.getData();
                    jSONObject2.put("taskID", header.getTaskID());
                    jSONObject3.put("arguments", ((JSONMessageDataArray) data.getArguments()).mJSONArray);
                    break;
                case RESPONSE:
                    Response.Header header2 = (Response.Header) message.getHeader();
                    Response.Data data2 = (Response.Data) message.getData();
                    jSONObject2.put(AnalyticsEvents.PARAMETER_SHARE_DIALOG_CONTENT_STATUS, header2.getStatus().toString());
                    jSONObject2.put("taskID", header2.getTaskID());
                    jSONObject3.put("result", ((JSONMessageDataObject) data2.getResult()).mJSONObject);
                    break;
                case NOTIFICATION:
                    Notification.Header header3 = (Notification.Header) message.getHeader();
                    jSONObject3.put("notification", ((JSONMessageDataObject) ((Notification.Data) message.getData()).getNotification()).mJSONObject);
                    break;
                default:
                    throw new Exception("Unsupported message type");
            }
            jSONObject2.put(ShareConstants.WEB_DIALOG_PARAM_TITLE, header.getTitle());
            jSONObject2.put("type", header.getType().toString());
            jSONObject2.put("timestamp", header.getTimestamp());
            jSONObject = new JSONObject();
            jSONObject.put("header", jSONObject2);
            jSONObject.put(ShareConstants.WEB_DIALOG_PARAM_DATA, jSONObject3);
        }
        return jSONObject;
    }
}
