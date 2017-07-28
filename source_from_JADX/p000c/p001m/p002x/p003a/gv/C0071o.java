package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.os.Bundle;

public final class C0071o {
    public static void m296a(Bundle bundle, String str) {
        if (VERSION.SDK_INT >= 18) {
            bundle.putBinder(str, null);
        } else {
            C0072p.m297a(bundle, str);
        }
    }
}
