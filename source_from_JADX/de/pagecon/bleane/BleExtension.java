package de.pagecon.bleane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import de.pagecon.bleane.extension.Manager;

public class BleExtension implements FREExtension {
    public FREContext createContext(String s) {
        Manager.cLog("Extension create context called");
        return new BleExtensionContext();
    }

    public void initialize() {
        Manager.cLog("initialize Extension called");
    }

    public void dispose() {
        Manager.cLog("dispose Extension called");
        Manager.instance.finalise(true);
    }
}
