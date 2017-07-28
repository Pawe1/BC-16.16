package de.pagecon.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import de.pagecon.ane.nfc.Manager;

public class NDEFIntentFunction implements FREFunction {
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Manager.cLog("+++ NDEFIntentFunction +++");
        String NDEFmessage = "null";
        NDEFmessage = new String(freContext.getActivity().getIntent().getParcelableArrayExtra("android.nfc.extra.NDEF_MESSAGES")[0].getRecords()[0].getPayload());
        Manager.cLog("Intent..ANE... =" + NDEFmessage);
        try {
            return FREObject.newObject(NDEFmessage);
        } catch (Exception e) {
            Manager.cLog("Error in NDEFIntentFunction: " + e.getMessage());
            return null;
        }
    }
}
