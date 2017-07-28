package p000c.p001m.p002x.p003a.gv;

import android.content.Intent;
import android.os.Bundle;

public final class bk {
    public static Bundle m146a(Intent intent) {
        Bundle bundleExtra = intent.getBundleExtra("al_applink_data");
        return bundleExtra == null ? null : bundleExtra.getBundle("extras");
    }
}
