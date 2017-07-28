package de.pagecon.ane.nfc;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.nfc.NfcAdapter;
import android.nfc.NfcManager;
import android.nfc.Tag;
import android.util.Log;
import com.sigmasport.RecordsBase;
import com.sigmasport.nfctag.NfcTag;
import com.sigmasport.protocol.SigmaProtocolMsgNtagHandler;

public class Manager {
    public static boolean DEBUG_MODE = true;
    public static final int SUCCESS = 0;
    public static final String TAG = "NFC ANE Android Layer";
    public static Manager instance = null;
    public static Boolean keepTagOpen = Boolean.valueOf(false);
    public static NfcTag mNfcTag;
    public static SigmaProtocolMsgNtagHandler mNtagHandler;
    public static Tag mTag;
    public Activity activity;
    public Intent intent;
    public int mEnterFifoModeDelay;
    public IntentFilter[] mFilters;
    public PendingIntent mPendingIntent;
    public int mReadSettingDataDelay;
    private final BroadcastReceiver mReceiver = new C03781();
    public String[][] mTechLists;
    public ManagerListener managerListener;
    public NfcAdapter nfcAdapter;
    public NfcManager nfcManager;

    class C03781 extends BroadcastReceiver {
        C03781() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("android.nfc.action.ADAPTER_STATE_CHANGED")) {
                switch (intent.getIntExtra("android.nfc.extra.ADAPTER_STATE", 1)) {
                    case 1:
                        Manager.this.managerListener.nfcStatusChanged(Boolean.valueOf(false));
                        return;
                    case 3:
                        Manager.this.managerListener.nfcStatusChanged(Boolean.valueOf(true));
                        return;
                    default:
                        return;
                }
            }
        }
    }

    public static final void cLog(String msg) {
        if (DEBUG_MODE) {
            Log.i(TAG, msg);
        }
    }

    public static void dispose() {
        cLog("dispose");
        mTag = null;
        mNfcTag = null;
        mNtagHandler = null;
    }

    public static Manager create(Activity activity, ManagerListener managerListener) {
        cLog("Manager create instance");
        if (instance == null) {
            instance = new Manager(activity, managerListener);
        }
        return instance;
    }

    private Manager(Activity activity, ManagerListener managerListener) {
        this.activity = activity;
        this.managerListener = managerListener;
        this.nfcAdapter = NfcAdapter.getDefaultAdapter(activity);
        this.mReadSettingDataDelay = BaseConfig.READ_SETTING_DATA_DELAY_TIMEOUT;
        this.mEnterFifoModeDelay = BaseConfig.ENTER_FIFO_MODE_DELAY_TIMEOUT;
        try {
            this.activity.registerReceiver(this.mReceiver, new IntentFilter("android.nfc.action.ADAPTER_STATE_CHANGED"));
        } catch (RuntimeException e) {
            cLog(e.getLocalizedMessage());
            e.printStackTrace();
        }
    }

    public static void dispatchNfcStepResult(RecordsBase nfcRecord) {
        instance.managerListener.dispatchNfcResult(nfcRecord.toJson(), ExtensionContext.EVENT_NFC_STEP_RESULT_READY);
    }

    public static void dispatchNfcError(RecordsBase nfcRecord) {
        instance.managerListener.dispatchNfcResult(nfcRecord.toJson(), ExtensionContext.EVENT_NFC_ERROR);
    }

    public static void dispatchNfcCloseTagReady() {
        instance.managerListener.dispatchNfcResult(new RecordsBase(0, 0).toJson(), ExtensionContext.EVENT_NFC_CLOSE_TAG_READY);
    }

    public static void dispatchNfcResult(RecordsBase nfcRecord, String eventType) {
        if (nfcRecord.errorCode > 0 || nfcRecord.errorMessage.length() > 0) {
            eventType = ExtensionContext.EVENT_NFC_ERROR;
        }
        instance.managerListener.dispatchNfcResult(nfcRecord.toJson(), eventType);
    }

    public void enableNfcForegroundDispatch() {
        if (this.nfcAdapter != null) {
            this.nfcAdapter.enableForegroundDispatch(this.activity, this.mPendingIntent, this.mFilters, this.mTechLists);
        }
    }

    public void finalize() {
        if (instance != null) {
            cLog("Manager: calling finalize() to unbind service...");
        }
    }
}
