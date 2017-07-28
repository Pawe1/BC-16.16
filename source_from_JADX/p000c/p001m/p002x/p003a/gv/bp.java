package p000c.p001m.p002x.p003a.gv;

import android.content.Intent;
import android.os.Bundle;
import com.facebook.applinks.AppLinkData;

public final class bp {
    public static Bundle m204a(Intent intent) {
        Bundle bundleExtra = intent.getBundleExtra("al_applink_data");
        return bundleExtra == null ? null : bundleExtra.getBundle(AppLinkData.ARGUMENTS_EXTRAS_KEY);
    }
}
