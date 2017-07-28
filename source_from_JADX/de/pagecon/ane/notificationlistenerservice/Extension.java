package de.pagecon.ane.notificationlistenerservice;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class Extension implements FREExtension {
    public FREContext createContext(String s) {
        Manager.cLog("createContext " + s);
        return new ExtensionContext(s);
    }

    public void dispose() {
    }

    protected void finalize() throws Throwable {
        if (Manager.instance != null) {
            Manager.instance.finalize();
        }
    }

    public void initialize() {
    }
}
