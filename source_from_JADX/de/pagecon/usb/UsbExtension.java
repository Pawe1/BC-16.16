package de.pagecon.usb;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class UsbExtension implements FREExtension {
    public FREContext createContext(String arg0) {
        return new UsbExtensionContext();
    }

    public void dispose() {
    }

    public void initialize() {
    }
}
