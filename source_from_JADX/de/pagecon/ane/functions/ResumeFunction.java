package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.app.Activity;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

@TargetApi(10)
public class ResumeFunction implements FREFunction {
    public static void onResume(Activity a) {
        if (Manager.instance.nfcAdapter != null) {
            Manager.instance.nfcAdapter.enableForegroundDispatch(a, Manager.instance.mPendingIntent, null, null);
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ ResumeFunction +++");
        try {
            onResume(freContext.getActivity());
        } catch (Exception e) {
            Manager.cLog("Error in PauseFunction: " + e.getMessage());
        }
        return null;
    }
}
