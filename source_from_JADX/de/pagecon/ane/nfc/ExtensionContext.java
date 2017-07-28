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
import de.pagecon.ane.functions.GetNativeNfcAneVersion;
import de.pagecon.ane.functions.HandleNxpTag;
import de.pagecon.ane.functions.IsNfcEnabled;
import de.pagecon.ane.functions.IsNfcSupported;
import de.pagecon.ane.functions.PauseFunction;
import de.pagecon.ane.functions.ReadNfcEeprom;
import de.pagecon.ane.functions.ReadNfcFlash;
import de.pagecon.ane.functions.ResumeFunction;
import de.pagecon.ane.functions.SetDebugMode;
import de.pagecon.ane.functions.WriteNfcEeprom;
import de.pagecon.ane.functions.WriteNfcFlash;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import org.json.JSONObject;

public class ExtensionContext extends FREContext implements ManagerListener {
    public static final String EVENT_NFC_CLOSE_TAG_READY = "eventNfcCloseTagReady";
    public static final String EVENT_NFC_ERROR = "eventNfcError";
    public static final String EVENT_NFC_NXPTAG_RESULT = "eventNfcNxpTagResult";
    public static final String EVENT_NFC_READ_EEPROM_READY = "eventNfcReadEepromReady";
    public static final String EVENT_NFC_READ_FLASH_READY = "eventNfcReadFlashReady";
    public static final String EVENT_NFC_STATUS_CHANGED = "eventNfcStatusChanged";
    public static final String EVENT_NFC_STEP_RESULT_READY = "eventNfcStepResultReady";
    public static final String EVENT_NFC_STEP_RESULT_RESET = "eventNfcStepResultReset";
    public static final String EVENT_NFC_WRITE_EEPROM_READY = "eventNfcWriteEepromReady";
    public static final String EVENT_NFC_WRITE_FLASH_READY = "eventNfcWriteFlashReady";
    private Map<String, FREFunction> functionMap = new HashMap();
    private ExtensionContext instance = this;
    private Boolean isInitialized = Boolean.valueOf(false);

    class C04291 implements FREFunction {
        C04291() {
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
        this.functionMap.put("initNfc", new C04291());
        this.functionMap.put("nativePause", new PauseFunction());
        this.functionMap.put("nativeResume", new ResumeFunction());
        this.functionMap.put("isNfcSupported", new IsNfcSupported());
        this.functionMap.put("isNfcEnabled", new IsNfcEnabled());
        this.functionMap.put("readNfcEeprom", new ReadNfcEeprom());
        this.functionMap.put("readNfcFlash", new ReadNfcFlash());
        this.functionMap.put("writeNfcEeprom", new WriteNfcEeprom());
        this.functionMap.put("writeNfcFlash", new WriteNfcFlash());
        this.functionMap.put("setDebugMode", new SetDebugMode());
        this.functionMap.put("closeNfcTag", new CloseNfcTag());
        this.functionMap.put("askForNfc", new AskForNfc());
        this.functionMap.put("handleNxpTag", new HandleNxpTag());
        this.functionMap.put("getNativeNfcAneVersion", new GetNativeNfcAneVersion());
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
        try {
            dispatchStatusEventAsync(eventType, json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
