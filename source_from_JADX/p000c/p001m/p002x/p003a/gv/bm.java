package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.support.v4.view.ViewPropertyAnimatorCompat;
import android.view.View;
import java.util.WeakHashMap;

public final class bm {
    static final C0035m f170a;

    interface C0035m {
        int mo41a(View view);

        void mo42a(View view, int i);

        boolean mo43b(View view);

        void mo44c(View view);
    }

    static class C0036a implements C0035m {
        WeakHashMap<View, ViewPropertyAnimatorCompat> f168a = null;

        C0036a() {
        }

        public int mo41a(View view) {
            return 0;
        }

        public void mo42a(View view, int i) {
        }

        public boolean mo43b(View view) {
            return true;
        }

        public void mo44c(View view) {
        }
    }

    static class C0037b extends C0036a {
        C0037b() {
        }
    }

    static class C0038c extends C0037b {
        C0038c() {
        }
    }

    static class C0039d extends C0038c {
        C0039d() {
        }

        public final int mo41a(View view) {
            return view.getLayerType();
        }

        public final void mo42a(View view, int i) {
            view.setLayerType(i, null);
        }

        public final void mo44c(View view) {
            view.setSaveFromParentEnabled(false);
        }
    }

    static class C0040f extends C0039d {
        static boolean f169b = false;

        C0040f() {
        }
    }

    static class C0041e extends C0040f {
        C0041e() {
        }
    }

    static class C0042g extends C0041e {
        C0042g() {
        }

        public final boolean mo43b(View view) {
            return view.hasOverlappingRendering();
        }
    }

    static class C0043h extends C0042g {
        C0043h() {
        }
    }

    static class C0044i extends C0043h {
        C0044i() {
        }
    }

    static class C0045j extends C0044i {
        C0045j() {
        }
    }

    static class C0046k extends C0045j {
        C0046k() {
        }
    }

    static class C0047l extends C0046k {
        C0047l() {
        }
    }

    static {
        int i = VERSION.SDK_INT;
        if (i >= 23) {
            f170a = new C0047l();
        } else if (i >= 21) {
            f170a = new C0046k();
        } else if (i >= 19) {
            f170a = new C0045j();
        } else if (i >= 17) {
            f170a = new C0043h();
        } else if (i >= 16) {
            f170a = new C0042g();
        } else if (i >= 15) {
            f170a = new C0041e();
        } else if (i >= 14) {
            f170a = new C0040f();
        } else if (i >= 11) {
            f170a = new C0039d();
        } else if (i >= 9) {
            f170a = new C0038c();
        } else if (i >= 7) {
            f170a = new C0037b();
        } else {
            f170a = new C0036a();
        }
    }

    public static int m198a(View view) {
        return f170a.mo41a(view);
    }

    public static void m199a(View view, int i) {
        f170a.mo42a(view, i);
    }

    public static void m200b(View view) {
        f170a.mo44c(view);
    }

    public static boolean m201c(View view) {
        return f170a.mo43b(view);
    }
}
