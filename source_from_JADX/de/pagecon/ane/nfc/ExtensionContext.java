package de.pagecon.ane.nfc;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.nfc.NfcAdapter;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.functions.AskForNfc;
import de.pagecon.ane.functions.CloseNfcTag;
import de.pagecon.ane.functions.IsNfcEnabled;
import de.pagecon.ane.functions.IsNfcSupported;
import de.pagecon.ane.functions.NDEFIntentFunction;
import de.pagecon.ane.functions.PauseFunction;
import de.pagecon.ane.functions.ReadNfcEeprom;
import de.pagecon.ane.functions.ReadNfcFlash;
import de.pagecon.ane.functions.ResumeFunction;
import de.pagecon.ane.functions.SetDebugMode;
import de.pagecon.ane.functions.WriteNfcEeprom;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import org.json.JSONObject;

public class ExtensionContext extends FREContext implements ManagerListener {
    private static final String CTX_NAME = "ExtensionContext";
    public static final String EVENT_NFC_CLOSE_TAG_READY = "eventNfcCloseTagReady";
    public static final String EVENT_NFC_ERROR = "eventNfcError";
    public static final String EVENT_NFC_READ_EEPROM_READY = "eventNfcReadEepromReady";
    public static final String EVENT_NFC_READ_FLASH_READY = "eventNfcReadFlashReady";
    public static final String EVENT_NFC_STATUS_CHANGED = "eventNfcStatusChanged";
    public static final String EVENT_NFC_STEP_RESULT_READY = "eventNfcStepResultReady";
    public static final String EVENT_NFC_WRITE_EEPROM_READY = "eventNfcWriteEepromReady";
    public static String NFC_FOREGROUND_DISPATCH_INTENT_KEY = "NFC_FOREGROUND_DISPATCH__INTENT_KEY";
    public static String NFC_FOREGROUND_DISPATCH_INTENT_VALUE = "NFC_FOREGROUND_DISPATCH__INTENT_VALUE";
    private Map<String, FREFunction> functionMap;
    private ExtensionContext instance = this;
    private Boolean isInitialized = Boolean.valueOf(false);
    private String tag;

    class C03771 implements FREFunction {
        C03771() {
        }

        public FREObject call(FREContext freContext, FREObject[] freObjects) {
            if (!ExtensionContext.this.isInitialized.booleanValue()) {
                if (Manager.instance == null) {
                    try {
                        Activity a = ExtensionContext.this.getActivity();
                        Manager.create(a, ExtensionContext.this.instance);
                        Manager.instance.nfcAdapter = NfcAdapter.getDefaultAdapter(a);
                        if (Manager.instance.nfcAdapter == null) {
                            Manager.cLog("nfcAdapter is null !!!");
                        }
                        Intent intent = new Intent(a, a.getClass());
                        intent.addFlags(536870912);
                        Manager.instance.intent = intent;
                        Manager.instance.mPendingIntent = PendingIntent.getActivity(a, 0, intent, 0);
                        ResumeFunction.onResume(a);
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
        this.tag = new StringBuilder(String.valueOf(extensionName)).append(".").append(CTX_NAME).toString();
        this.functionMap = new HashMap();
        this.functionMap.put("initNfc", new C03771());
        this.functionMap.put("nativePause", new PauseFunction());
        this.functionMap.put("nativeResume", new ResumeFunction());
        this.functionMap.put("intent", new NDEFIntentFunction());
        this.functionMap.put("isNfcSupported", new IsNfcSupported());
        this.functionMap.put("isNfcEnabled", new IsNfcEnabled());
        this.functionMap.put("readNfcEeprom", new ReadNfcEeprom());
        this.functionMap.put("readNfcFlash", new ReadNfcFlash());
        this.functionMap.put("writeNfcEeprom", new WriteNfcEeprom());
        this.functionMap.put("setDebugMode", new SetDebugMode());
        this.functionMap.put("closeNfcTag", new CloseNfcTag());
        this.functionMap.put("askForNfc", new AskForNfc());
        for (Entry<String, FREFunction> entry : this.functionMap.entrySet()) {
            Manager.cLog("+++ ExtensionContext functionMap: " + ((String) entry.getKey()) + " / " + ((FREFunction) entry.getValue()).toString());
        }
    }

    public void dispose() {
        Manager.cLog("dispose ExtensionContext called");
    }

    public Map<String, FREFunction> getFunctions() {
        Manager.cLog("+++ Map.getFunctions()");
        return this.functionMap;
    }

    public String getIdentifier() {
        return this.tag;
    }

    public void nfcStatusChanged(Boolean status) {
        Manager.cLog("nfcStatusChanged: " + status.toString());
        try {
            JSONObject json = new JSONObject();
            json.put(EVENT_NFC_STATUS_CHANGED, status);
            dispatchStatusEventAsync(EVENT_NFC_STATUS_CHANGED, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dispatchNfcResult(String json, String eventType) {
        Manager.cLog("[NFC EVENT=" + eventType + "]: " + json);
        try {
            dispatchStatusEventAsync(eventType, json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
