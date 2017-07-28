package de.pagecon.bleane;

import android.app.Activity;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.bleane.extension.BleHWListener;
import de.pagecon.bleane.extension.Manager;
import de.pagecon.bleane.extension.ManagerListener;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

public class BleExtensionContext extends FREContext implements ManagerListener, BleHWListener {
    private static final String ACTION_CONNECTION_REQUESTS_CANCELED = "connectionRequestsCanceled";
    private static final String ACTION_DATA_RECEIVED = "dataReceived";
    private static final String ACTION_DATA_SEND = "dataSend";
    private static final String ACTION_DEVICE_CONNECTED = "deviceConnected";
    private static final String ACTION_DEVICE_DISCONNECTED = "deviceDisconnected";
    private static final String ACTION_DEVICE_DISCOVERED = "deviceDiscovered";
    private static final String ACTION_ENABLED_STATE_CHANGED = "enabledStateChanged";
    private static final String ACTION_ERROR = "error";
    private static final String ACTION_IDS_CHECKED = "idsChecked";
    private static final String ACTION_INFO = "info";
    private static final String ACTION_SCANNING_STATE_CHANGED = "scanningStateChanged";
    private static final String ACTION_SELECTED_STATE_CHANGED = "selectedStateChanged";
    private static final String CHARACTERISTIC_UUID = "cuuid";
    private static final String DATA = "data";
    private static final String DEVICE_ID = "did";
    private static final String DEVICE_NAME = "name";
    private static final String ENABLED_STATE = "enabledState";
    private static final String ERROR_CODE = "err";
    private static final String IDS = "ids";
    private static final String INFO = "info";
    private static final String MSG = "msg";
    private static final String PRIMARY_SERVICE_UUID = "psuuid";
    private static final String SCANNING_STATE = "scanningState";
    private static final String SELECTED_STATE = "selectedState";
    private static final String SERVICE_UUID = "suuid";
    private Map<String, FREFunction> functionMap;

    class C03811 implements FREFunction {
        C03811() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            BleExtensionContext.this.getManager().reset();
            return null;
        }
    }

    class C03822 implements FREFunction {
        C03822() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                return FREObject.newObject(BleExtensionContext.this.getManager().isBleSupported());
            } catch (Exception e) {
                Manager.cLog("Exception in isBleSupported: " + e.getMessage());
                return null;
            }
        }
    }

    class C03833 implements FREFunction {
        C03833() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                return FREObject.newObject(BleExtensionContext.this.getManager().getEnabledBleHw());
            } catch (Exception e) {
                Manager.cLog("Exception in getEnabledBleHw: " + e.getMessage());
                return null;
            }
        }
    }

    class C03844 implements FREFunction {
        C03844() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                return FREObject.newObject(BleExtensionContext.this.getManager().getSelectedBleHw());
            } catch (Exception e) {
                Manager.cLog("Exception in getSelectedBleHw: " + e.getMessage());
                return null;
            }
        }
    }

    class C03855 implements FREFunction {
        C03855() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                BleExtensionContext.this.getManager().setBleNotificationFilterParams(freObjects[0].getAsBool(), freObjects[1].getAsInt());
            } catch (Exception e) {
                Manager.cLog("Exception in setBleNotificationFilterParams: " + e.getMessage());
            }
            return null;
        }
    }

    class C03866 implements FREFunction {
        C03866() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                return FREObject.newObject(BleExtensionContext.this.getManager().askUserToEnableBle());
            } catch (Exception e) {
                Manager.cLog("Exception in askUserToEnableBle: " + e.getMessage());
                return null;
            }
        }
    }

    class C03877 implements FREFunction {
        C03877() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                FREArray serviceUuids = freObjects[0];
                List<String> suuids = new ArrayList();
                for (int i = 0; ((long) i) < serviceUuids.getLength(); i++) {
                    suuids.add(serviceUuids.getObjectAt((long) i).getAsString());
                }
                return FREObject.newObject(BleExtensionContext.this.getManager().startScan(suuids));
            } catch (Exception e) {
                Manager.cLog("Exception in startScan: " + e.getMessage());
                return null;
            }
        }
    }

    class C03888 implements FREFunction {
        C03888() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            FREObject fREObject = null;
            try {
                BleExtensionContext.this.getManager().stopScan();
                fREObject = FREObject.newObject(null);
            } catch (Exception e) {
                Manager.cLog("Exception in stopScan: " + e.getMessage());
            }
            return fREObject;
        }
    }

    class C03899 implements FREFunction {
        C03899() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            try {
                FREArray deviceIds = freObjects[0];
                List<String> duuids = new ArrayList();
                for (int i = 0; ((long) i) < deviceIds.getLength(); i++) {
                    duuids.add(deviceIds.getObjectAt((long) i).getAsString().toUpperCase(Locale.US));
                }
                return FREObject.newObject(BleExtensionContext.this.getManager().connect(duuids));
            } catch (Exception e) {
                Manager.cLog("Exception in connect: " + e.getMessage());
                return null;
            }
        }
    }

    private Manager getManager() {
        Manager.cLog("getManager called");
        if (Manager.instance == null) {
            Manager.cLog("Manager instance was null, creating..");
            Activity a = getActivity();
            Manager.cLog("getActivity done: " + a);
            Manager.create(a, this, this);
        }
        return Manager.instance;
    }

    public BleExtensionContext() {
        Manager.cLog("BleExtensionContext constructor called");
        if (Manager.instance != null) {
            Manager.instance.managerListener = this;
            Manager.instance.hwListener = this;
        }
        this.functionMap = new HashMap();
        this.functionMap.put("reset", new C03811());
        this.functionMap.put("isBleSupported", new C03822());
        this.functionMap.put("getEnabledBleHw", new C03833());
        this.functionMap.put("getSelectedBleHw", new C03844());
        this.functionMap.put("setBleNotificationFilterParams", new C03855());
        this.functionMap.put("askUserToEnableBle", new C03866());
        this.functionMap.put("startScan", new C03877());
        this.functionMap.put("stopScan", new C03888());
        this.functionMap.put("connect", new C03899());
        this.functionMap.put("cancelConnectionRequests", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    BleExtensionContext.this.info("entering cancelConnectionRequests");
                    return FREObject.newObject(BleExtensionContext.this.getManager().cancelConnectionRequests());
                } catch (Exception e) {
                    Manager.cLog("Exception in cancelConnectionRequests: " + e.getMessage());
                    return null;
                }
            }
        });
        this.functionMap.put("disconnect", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    return FREObject.newObject(BleExtensionContext.this.getManager().disconnect(freObjects[0].getAsString().toUpperCase(Locale.US)));
                } catch (Exception e) {
                    Manager.cLog("Exception in disconnect: " + e.getMessage());
                    return null;
                }
            }
        });
        this.functionMap.put("read", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    return FREObject.newObject(BleExtensionContext.this.getManager().read(freObjects[0].getAsString().toUpperCase(Locale.US), freObjects[1].getAsString(), freObjects[2].getAsString()));
                } catch (Exception e) {
                    Manager.cLog("Exception in read: " + e.getMessage());
                    return null;
                }
            }
        });
        this.functionMap.put("write", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    String id = freObjects[0].getAsString().toUpperCase(Locale.US);
                    String suuid = freObjects[1].getAsString();
                    String cuuid = freObjects[2].getAsString();
                    FREArray d = freObjects[3];
                    byte[] data = new byte[((int) d.getLength())];
                    for (int i = 0; ((long) i) < d.getLength(); i++) {
                        data[i] = (byte) d.getObjectAt((long) i).getAsInt();
                    }
                    return FREObject.newObject(BleExtensionContext.this.getManager().write(id, suuid, cuuid, data));
                } catch (Exception e) {
                    Manager.cLog("Exception in write: " + e.getMessage());
                    return null;
                }
            }
        });
        this.functionMap.put("setNotify", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    return FREObject.newObject(BleExtensionContext.this.getManager().setNotify(freObjects[0].getAsString().toUpperCase(Locale.US), freObjects[1].getAsString(), freObjects[2].getAsString(), freObjects[3].getAsBool()));
                } catch (Exception e) {
                    Manager.cLog("Exception in setNotify: " + e.getMessage());
                    return null;
                }
            }
        });
        this.functionMap.put("checkIds", new FREFunction() {
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    FREArray array = freObjects[0];
                    List<String> ids = new ArrayList();
                    for (int i = 0; ((long) i) < array.getLength(); i++) {
                        ids.add(array.getObjectAt((long) i).getAsString().toUpperCase(Locale.US));
                    }
                    Manager.cLog("checking ID: " + ids.toString());
                    BleExtensionContext.this.getManager().checkIds(ids);
                    return FREObject.newObject(null);
                } catch (Exception e) {
                    Manager.cLog("Exception in checkIds: " + e.getMessage());
                    return null;
                }
            }
        });
    }

    public Map<String, FREFunction> getFunctions() {
        return this.functionMap;
    }

    public void dispose() {
        Manager.cLog("dispose ExtensionContext called");
    }

    public void dataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
        try {
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, id.toLowerCase(Locale.US));
            json.put(SERVICE_UUID, serviceUUID);
            json.put(CHARACTERISTIC_UUID, charUUID);
            JSONArray jsonArray = new JSONArray();
            for (byte b : data) {
                jsonArray.put(b);
            }
            json.put("data", jsonArray);
            dispatchStatusEventAsync(ACTION_DATA_RECEIVED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dataWritten(String id, String serviceUUID, String charUUID) {
        try {
            id = id.toLowerCase(Locale.US);
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, id);
            json.put(SERVICE_UUID, serviceUUID);
            json.put(CHARACTERISTIC_UUID, charUUID);
            dispatchStatusEventAsync(ACTION_DATA_SEND, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deviceConnected(String id, String primaryServiceUUID) {
        try {
            id = id.toLowerCase(Locale.US);
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, id);
            dispatchStatusEventAsync(ACTION_DEVICE_CONNECTED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deviceDiscovered(String id, String primaryServiceUUID, String name) {
        try {
            id = id.toLowerCase(Locale.US);
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, id);
            json.put(PRIMARY_SERVICE_UUID, primaryServiceUUID);
            json.put("name", name);
            dispatchStatusEventAsync(ACTION_DEVICE_DISCOVERED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void error(int errCode, String message, String id, String serviceUUID, String charUUID) {
        if (message == null) {
            try {
                message = "";
            } catch (Exception e) {
                e.printStackTrace();
                return;
            }
        }
        if (id == null) {
            id = "";
        }
        if (serviceUUID == null) {
            serviceUUID = "";
        }
        if (charUUID == null) {
            charUUID = "";
        }
        id = id.toLowerCase(Locale.US);
        JSONObject json = new JSONObject();
        json.put(ERROR_CODE, errCode);
        json.put(MSG, message);
        json.put(DEVICE_ID, id);
        json.put(SERVICE_UUID, serviceUUID);
        json.put(CHARACTERISTIC_UUID, charUUID);
        dispatchStatusEventAsync("error", json.toString());
    }

    public void deviceDisconnected(String id) {
        try {
            id = id.toLowerCase(Locale.US);
            JSONObject json = new JSONObject();
            json.put(DEVICE_ID, id);
            dispatchStatusEventAsync(ACTION_DEVICE_DISCONNECTED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void idsChecked(List<String> validIds) {
        try {
            JSONObject json = new JSONObject();
            JSONArray jsonArray = new JSONArray();
            for (String id : validIds) {
                jsonArray.put(id.toLowerCase(Locale.US));
            }
            json.put(IDS, jsonArray);
            dispatchStatusEventAsync(ACTION_IDS_CHECKED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void info(String info) {
        try {
            JSONObject json = new JSONObject();
            json.put("info", info);
            dispatchStatusEventAsync("info", json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void bleEnabledStateChanged(int enabled) {
        try {
            JSONObject json = new JSONObject();
            json.put(ENABLED_STATE, enabled);
            dispatchStatusEventAsync(ACTION_ENABLED_STATE_CHANGED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void scanningStateChanged(boolean scanningState) {
        try {
            JSONObject json = new JSONObject();
            json.put(SCANNING_STATE, scanningState);
            dispatchStatusEventAsync(ACTION_SCANNING_STATE_CHANGED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void connectionRequestsCanceled() {
        try {
            dispatchStatusEventAsync(ACTION_CONNECTION_REQUESTS_CANCELED, "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void selectedBleHWChanged(int selected) {
        try {
            JSONObject json = new JSONObject();
            json.put(SELECTED_STATE, selected);
            dispatchStatusEventAsync(ACTION_SELECTED_STATE_CHANGED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
