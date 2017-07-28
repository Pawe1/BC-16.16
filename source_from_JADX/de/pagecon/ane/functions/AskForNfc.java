package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.content.Intent;
import android.os.Build.VERSION;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

@TargetApi(10)
public class AskForNfc implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ AskForNfc: START call");
        try {
            if (VERSION.SDK_INT >= 16) {
                freContext.getActivity().startActivity(new Intent("android.settings.NFC_SETTINGS"));
            } else {
                freContext.getActivity().startActivity(new Intent("android.settings.WIRELESS_SETTINGS"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
