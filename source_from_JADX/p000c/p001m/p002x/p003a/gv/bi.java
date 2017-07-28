package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.view.LayoutInflater;
import android.view.LayoutInflater.Factory;
import android.view.LayoutInflater.Factory2;
import p000c.p001m.p002x.p003a.gv.bj.C0033a;
import p000c.p001m.p002x.p003a.gv.bk.C0034a;

public final class bi {
    static final C0029a f164a;

    interface C0029a {
        void mo40a(LayoutInflater layoutInflater, bl blVar);
    }

    static class C0030b implements C0029a {
        C0030b() {
        }

        public void mo40a(LayoutInflater layoutInflater, bl blVar) {
            layoutInflater.setFactory(blVar != null ? new C0033a(blVar) : null);
        }
    }

    static class C0031c extends C0030b {
        C0031c() {
        }

        public void mo40a(LayoutInflater layoutInflater, bl blVar) {
            Factory2 c0034a = blVar != null ? new C0034a(blVar) : null;
            layoutInflater.setFactory2(c0034a);
            Factory factory = layoutInflater.getFactory();
            if (factory instanceof Factory2) {
                bk.m185a(layoutInflater, (Factory2) factory);
            } else {
                bk.m185a(layoutInflater, c0034a);
            }
        }
    }

    static class C0032d extends C0031c {
        C0032d() {
        }

        public final void mo40a(LayoutInflater layoutInflater, bl blVar) {
            layoutInflater.setFactory2(blVar != null ? new C0034a(blVar) : null);
        }
    }

    static {
        int i = VERSION.SDK_INT;
        if (i >= 21) {
            f164a = new C0032d();
        } else if (i >= 11) {
            f164a = new C0031c();
        } else {
            f164a = new C0030b();
        }
    }

    public static void m184a(LayoutInflater layoutInflater, bl blVar) {
        f164a.mo40a(layoutInflater, blVar);
    }
}
