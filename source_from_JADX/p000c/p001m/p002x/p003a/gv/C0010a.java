package p000c.p001m.p002x.p003a.gv;

import android.content.Intent;
import android.os.Bundle;
import java.util.ArrayList;

public final class C0010a {
    public final Intent f4a;
    public final Bundle f5b;

    public static final class C0009a {
        private final Intent f0a;
        private ArrayList<Bundle> f1b;
        private Bundle f2c;
        private ArrayList<Bundle> f3d;

        public C0009a() {
            this((byte) 0);
        }

        private C0009a(byte b) {
            this.f0a = new Intent("android.intent.action.VIEW");
            this.f1b = null;
            this.f2c = null;
            this.f3d = null;
            Bundle bundle = new Bundle();
            C0071o.m296a(bundle, "android.support.customtabs.extra.SESSION");
            this.f0a.putExtras(bundle);
        }

        public final C0010a m0a() {
            if (this.f1b != null) {
                this.f0a.putParcelableArrayListExtra("android.support.customtabs.extra.MENU_ITEMS", this.f1b);
            }
            if (this.f3d != null) {
                this.f0a.putParcelableArrayListExtra("android.support.customtabs.extra.TOOLBAR_ITEMS", this.f3d);
            }
            return new C0010a(this.f0a, this.f2c);
        }
    }

    private C0010a(Intent intent, Bundle bundle) {
        this.f4a = intent;
        this.f5b = bundle;
    }
}
