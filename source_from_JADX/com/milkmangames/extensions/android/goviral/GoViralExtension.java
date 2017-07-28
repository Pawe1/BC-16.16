package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GoViralExtension implements FREExtension {
    public static void main(String[] strArr) {
    }

    public FREContext createContext(String str) {
        Log.i("[GVExtension]", "try create context");
        return new C0351a();
    }

    public void dispose() {
    }

    public void initialize() {
    }
}
