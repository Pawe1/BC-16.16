package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import p000c.p001m.p002x.p003a.gv.C0063g.C0062b;

final class C0066j implements OnPreDrawListener {
    final /* synthetic */ View f280a;
    final /* synthetic */ C0062b f281b;
    final /* synthetic */ int f282c;
    final /* synthetic */ Object f283d;
    final /* synthetic */ C0063g f284e;

    C0066j(C0063g c0063g, View view, C0062b c0062b, int i, Object obj) {
        this.f284e = c0063g;
        this.f280a = view;
        this.f281b = c0062b;
        this.f282c = i;
        this.f283d = obj;
    }

    public final boolean onPreDraw() {
        this.f280a.getViewTreeObserver().removeOnPreDrawListener(this);
        this.f284e.m272a(this.f281b, this.f282c, this.f283d);
        return true;
    }
}
