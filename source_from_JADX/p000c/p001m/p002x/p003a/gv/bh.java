package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.support.v4.view.ViewPropertyAnimatorCompat;
import android.view.View;
import java.util.WeakHashMap;

public final class bh {
    static final C0029k f127a;

    interface C0029k {
        int mo18a(View view);

        void mo19a(View view, int i);

        boolean mo20b(View view);

        void mo21c(View view);
    }

    static class C0030a implements C0029k {
        WeakHashMap<View, ViewPropertyAnimatorCompat> f125a = null;

        C0030a() {
        }

        public int mo18a(View view) {
            return 0;
        }

        public void mo19a(View view, int i) {
        }

        public boolean mo20b(View view) {
            return true;
        }

        public void mo21c(View view) {
        }
    }

    static class C0031b extends C0030a {
        C0031b() {
        }
    }

    static class C0032c extends C0031b {
        C0032c() {
        }
    }

    static class C0033d extends C0032c {
        C0033d() {
        }

        public final int mo18a(View view) {
            return view.getLayerType();
        }

        public final void mo19a(View view, int i) {
            view.setLayerType(i, null);
        }

        public final void mo21c(View view) {
            view.setSaveFromParentEnabled(false);
        }
    }

    static class C0034e extends C0033d {
        static boolean f126b = false;

        C0034e() {
        }
    }

    static class C0035f extends C0034e {
        C0035f() {
        }

        public final boolean mo20b(View view) {
            return view.hasOverlappingRendering();
        }
    }

    static class C0036g extends C0035f {
        C0036g() {
        }
    }

    static class C0037h extends C0036g {
        C0037h() {
        }
    }

    static class C0038i extends C0037h {
        C0038i() {
        }
    }

    static class C0039j extends C0038i {
        C0039j() {
        }
    }

    static {
        int i = VERSION.SDK_INT;
        if (i >= 21) {
            f127a = new C0039j();
        } else if (i >= 19) {
            f127a = new C0038i();
        } else if (i >= 17) {
            f127a = new C0036g();
        } else if (i >= 16) {
            f127a = new C0035f();
        } else if (i >= 14) {
            f127a = new C0034e();
        } else if (i >= 11) {
            f127a = new C0033d();
        } else if (i >= 9) {
            f127a = new C0032c();
        } else if (i >= 7) {
            f127a = new C0031b();
        } else {
            f127a = new C0030a();
        }
    }

    public static int m140a(View view) {
        return f127a.mo18a(view);
    }

    public static void m141a(View view, int i) {
        f127a.mo19a(view, i);
    }

    public static void m142b(View view) {
        f127a.mo21c(view);
    }

    public static boolean m143c(View view) {
        return f127a.mo20b(view);
    }
}
