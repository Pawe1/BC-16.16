package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import p000c.p001m.p002x.p003a.gv.C0050e.C0049b;

final class C0053h implements OnPreDrawListener {
    final /* synthetic */ View f233a;
    final /* synthetic */ C0049b f234b;
    final /* synthetic */ int f235c;
    final /* synthetic */ Object f236d;
    final /* synthetic */ C0050e f237e;

    C0053h(C0050e c0050e, View view, C0049b c0049b, int i, Object obj) {
        this.f237e = c0050e;
        this.f233a = view;
        this.f234b = c0049b;
        this.f235c = i;
        this.f236d = obj;
    }

    public final boolean onPreDraw() {
        this.f233a.getViewTreeObserver().removeOnPreDrawListener(this);
        this.f237e.m197a(this.f234b, this.f235c, this.f236d);
        return true;
    }
}
