package de.pagecon.ane.nfc;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class Extension implements FREExtension {
    public FREContext createContext(String s) {
        Manager.cLog("Extension create context called: " + s);
        return new ExtensionContext(s);
    }

    public void dispose() {
        Manager.cLog("dispose Extension called");
    }

    protected void finalize() throws Throwable {
        Manager.cLog("finalize");
        if (Manager.instance != null) {
            Manager.instance.finalize();
        }
    }

    public void initialize() {
        Manager.cLog("initialize Extension called");
    }
}
