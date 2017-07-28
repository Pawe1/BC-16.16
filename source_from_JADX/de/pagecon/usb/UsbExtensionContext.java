package de.pagecon.usb;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class UsbExtensionContext extends FREContext implements ManagerListener {
    private static final String ACTION_DATA_RECEIVED = "dataReceived";
    private static final String ACTION_DEBUG_INFO = "debugInfo";
    private static final String ACTION_DEVICE_ATTACHED = "deviceAttached";
    private static final String ACTION_DEVICE_CONNECTED = "deviceConnected";
    private static final String ACTION_DEVICE_CONNECTION_FAILED = "deviceConnectionFailed";
    private static final String ACTION_DEVICE_CONNECTION_LOST = "deviceConnectionLost";
    private static final String ACTION_DEVICE_DETACHED = "deviceDetached";
    private static final String ACTION_DEVICE_DISCONNECTED = "deviceDisconnected";
    protected static final int ALREADY_CONNECTED = 11;
    private static final String DATA = "data";
    private static final String DEVICE_ID = "deviceID";
    protected static final int DEVICE_NOT_FOUND = 14;
    private static final String DEVICE_PID = "devicePID";
    private static final String DEVICE_VID = "deviceVID";
    protected static final int REQUESTING_PERMISSION = 13;
    protected static final int TRYING_TO_CONNECT = 12;
    private static final String tag = "USB-ANE Android Layer";
    private Boolean debugMode = Boolean.valueOf(false);
    private Map<String, FREFunction> functionMap = new HashMap();
    private Manager manager = null;

    class C04561 implements FREFunction {
        C04561() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                UsbExtensionContext.this.debugMode = Boolean.valueOf(arg1[0].getAsBool());
            } catch (Exception e) {
                Log.i(UsbExtensionContext.tag, "exception in setDebugMode(): " + e.getMessage());
                e.printStackTrace();
            }
            return null;
        }
    }

    class C04572 implements FREFunction {
        C04572() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                Log.i(UsbExtensionContext.tag, "setSupportedDevices() before Manager call");
                UsbExtensionContext.this.debugInfo("setSupportedDevices() before Manager call");
                JSONArray devicesArray = new JSONArray(arg1[0].getAsString());
                int length = devicesArray.length();
                ArrayList<VIDPIDPair> supportedDevices = new ArrayList();
                for (int k = 0; k < length; k += 2) {
                    supportedDevices.add(new VIDPIDPair(devicesArray.getInt(k), devicesArray.getInt(k + 1)));
                }
                UsbExtensionContext.this.debugInfo("supported device: " + supportedDevices);
                UsbExtensionContext.this.getManager().setSupportedDeviceIDs(supportedDevices);
            } catch (Exception e) {
                Log.i(UsbExtensionContext.tag, "exception in setSupportedDevices(): " + e.getMessage());
                UsbExtensionContext.this.debugInfo("exception in setSupportedDevices(): " + e.getMessage());
                e.printStackTrace();
            }
            return null;
        }
    }

    class C04583 implements FREFunction {
        C04583() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                ArrayList<SigmaDevice> sigmaDevices = UsbExtensionContext.this.getManager().getAttachedDevices();
                JSONArray devices = new JSONArray();
                Iterator it = sigmaDevices.iterator();
                while (it.hasNext()) {
                    SigmaDevice sd = (SigmaDevice) it.next();
                    JSONObject obj = new JSONObject();
                    try {
                        obj.put(UsbExtensionContext.DEVICE_ID, sd.getID());
                        obj.put(UsbExtensionContext.DEVICE_VID, sd.getVendorID());
                        obj.put(UsbExtensionContext.DEVICE_PID, sd.getProductID());
                        devices.put(obj);
                    } catch (JSONException e) {
                    }
                }
                return FREObject.newObject(devices.toString());
            } catch (FREWrongThreadException e2) {
                Log.i(UsbExtensionContext.tag, "exception in getAttachedDevices(): " + e2.getMessage());
                UsbExtensionContext.this.debugInfo("exception in getAttachedDevices(): " + e2.getMessage());
                e2.printStackTrace();
                return null;
            }
        }
    }

    class C04594 implements FREFunction {
        C04594() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                ArrayList<SigmaDevice> sigmaDevices = UsbExtensionContext.this.getManager().getConnectedDevices();
                JSONArray devices = new JSONArray();
                Iterator it = sigmaDevices.iterator();
                while (it.hasNext()) {
                    SigmaDevice sd = (SigmaDevice) it.next();
                    JSONObject obj = new JSONObject();
                    try {
                        obj.put(UsbExtensionContext.DEVICE_ID, sd.getID());
                        obj.put(UsbExtensionContext.DEVICE_VID, sd.getVendorID());
                        obj.put(UsbExtensionContext.DEVICE_PID, sd.getProductID());
                        devices.put(obj);
                    } catch (JSONException e) {
                    }
                }
                return FREObject.newObject(devices.toString());
            } catch (FREWrongThreadException e2) {
                Log.i(UsbExtensionContext.tag, "exception in getConnectedDevices(): " + e2.getMessage());
                UsbExtensionContext.this.debugInfo("exception in getConnectedDevices(): " + e2.getMessage());
                e2.printStackTrace();
                return null;
            }
        }
    }

    class C04605 implements FREFunction {
        C04605() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                Log.i(UsbExtensionContext.tag, "connectDevice() before Manager call");
                UsbExtensionContext.this.debugInfo("connectDevice() before Manager call");
                return FREObject.newObject(UsbExtensionContext.this.getManager().connectDevice(arg1[0].getAsInt()));
            } catch (Exception e) {
                Log.i(UsbExtensionContext.tag, "exception in connectDevice(): " + e.getMessage());
                UsbExtensionContext.this.debugInfo("exception in connectDevice(): " + e.getMessage());
                e.printStackTrace();
                return null;
            }
        }
    }

    class C04616 implements FREFunction {
        C04616() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                Log.i(UsbExtensionContext.tag, "disconnectDevice() before Manager call");
                UsbExtensionContext.this.debugInfo("disconnectDevice() before Manager call");
                UsbExtensionContext.this.getManager().disconnectDevice(arg1[0].getAsInt());
            } catch (Exception e) {
                Log.i(UsbExtensionContext.tag, "exception in disconnectDevice(): " + e.getMessage());
                UsbExtensionContext.this.debugInfo("exception in disconnectDevice(): " + e.getMessage());
                e.printStackTrace();
            }
            return null;
        }
    }

    class C04627 implements FREFunction {
        C04627() {
        }

        public FREObject call(FREContext arg0, FREObject[] arg1) {
            try {
                byte[] data = null;
                JSONArray dataArray = new JSONArray(arg1[1].getAsString());
                int length = dataArray.length();
                data = new byte[length];
                for (int i = 0; i < length; i++) {
                    data[i] = (byte) dataArray.getInt(i);
                }
                Log.i(UsbExtensionContext.tag, "sendData() before Manager call");
                UsbExtensionContext.this.debugInfo("sendData() before Manager call");
                return FREObject.newObject(UsbExtensionContext.this.getManager().sendData(arg1[0].getAsInt(), data).booleanValue());
            } catch (Exception e) {
                Log.i(UsbExtensionContext.tag, "exception in sendData(): " + e.getMessage());
                UsbExtensionContext.this.debugInfo("exception in sendData(): " + e.getMessage());
                e.printStackTrace();
                return null;
            }
        }
    }

    private Manager getManager() {
        if (this.manager == null) {
            this.manager = Manager.createManager(getActivity(), this);
        }
        return this.manager;
    }

    public UsbExtensionContext() {
        this.functionMap.put("setDebugMode", new C04561());
        this.functionMap.put("setSupportedDevices", new C04572());
        this.functionMap.put("getAttachedDevices", new C04583());
        this.functionMap.put("getConnectedDevices", new C04594());
        this.functionMap.put("connectDevice", new C04605());
        this.functionMap.put("disconnectDevice", new C04616());
        this.functionMap.put("sendData", new C04627());
    }

    public void dispose() {
        getManager().reset();
    }

    public Map<String, FREFunction> getFunctions() {
        return this.functionMap;
    }

    public void dataReceived(int deviceID, byte[] data) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, deviceID);
            JSONArray jsonArray = new JSONArray();
            for (byte b : data) {
                jsonArray.put(b);
            }
            json.put("data", jsonArray);
            dispatchStatusEventAsync(ACTION_DATA_RECEIVED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in dataReceived: " + e.getMessage());
            debugInfo("exception in dataReceived: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceConnected(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_CONNECTED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceConnected: " + e.getMessage());
            debugInfo("exception in deviceConnected: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceDisconnected(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_DISCONNECTED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceDisconnected: " + e.getMessage());
            debugInfo("exception in deviceDisconnected: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceConnectionLost(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_CONNECTION_LOST, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceConnectionLost: " + e.getMessage());
            debugInfo("exception in deviceConnectionLost: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceAttached(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_ATTACHED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceAttached: " + e.getMessage());
            debugInfo("exception in deviceAttached: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceDetached(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_DETACHED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceDetachedSafely: " + e.getMessage());
            debugInfo("exception in deviceDetachedSafely: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deviceConnectionFailed(SigmaDevice sd) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, sd.getID());
            json.put(DEVICE_VID, sd.getVendorID());
            json.put(DEVICE_PID, sd.getProductID());
            dispatchStatusEventAsync(ACTION_DEVICE_CONNECTION_FAILED, json.toString());
        } catch (Exception e) {
            Log.i(tag, "exception in deviceConnectionFailed: " + e.getMessage());
            debugInfo("exception in deviceConnectionFailed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void debugInfo(String info) {
        if (this.debugMode.booleanValue()) {
            try {
                dispatchStatusEventAsync(ACTION_DEBUG_INFO, "USB-ANE Android Layer: " + info);
            } catch (Exception e) {
                Log.i(tag, "exception in debugInfo: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
