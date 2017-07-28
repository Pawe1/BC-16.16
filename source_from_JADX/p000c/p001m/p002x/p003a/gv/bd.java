package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.view.LayoutInflater;
import android.view.LayoutInflater.Factory;
import android.view.LayoutInflater.Factory2;
import p000c.p001m.p002x.p003a.gv.be.C0027a;
import p000c.p001m.p002x.p003a.gv.bf.C0028a;

public final class bd {
    static final C0023a f121a;

    interface C0023a {
        void mo17a(LayoutInflater layoutInflater, bg bgVar);
    }

    static class C0024b implements C0023a {
        C0024b() {
        }

        public void mo17a(LayoutInflater layoutInflater, bg bgVar) {
            layoutInflater.setFactory(bgVar != null ? new C0027a(bgVar) : null);
        }
    }

    static class C0025c extends C0024b {
        C0025c() {
        }

        public void mo17a(LayoutInflater layoutInflater, bg bgVar) {
            Factory2 c0028a = bgVar != null ? new C0028a(bgVar) : null;
            layoutInflater.setFactory2(c0028a);
            Factory factory = layoutInflater.getFactory();
            if (factory instanceof Factory2) {
                bf.m126a(layoutInflater, (Factory2) factory);
            } else {
                bf.m126a(layoutInflater, c0028a);
            }
        }
    }

    static class C0026d extends C0025c {
        C0026d() {
        }

        public final void mo17a(LayoutInflater layoutInflater, bg bgVar) {
            layoutInflater.setFactory2(bgVar != null ? new C0028a(bgVar) : null);
        }
    }

    static {
        int i = VERSION.SDK_INT;
        if (i >= 21) {
            f121a = new C0026d();
        } else if (i >= 11) {
            f121a = new C0025c();
        } else {
            f121a = new C0024b();
        }
    }

    public static void m125a(LayoutInflater layoutInflater, bg bgVar) {
        f121a.mo17a(layoutInflater, bgVar);
    }
}
