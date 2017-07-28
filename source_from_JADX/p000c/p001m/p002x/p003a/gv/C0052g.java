package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import p000c.p001m.p002x.p003a.gv.C0050e.C0049b;

final class C0052g implements OnPreDrawListener {
    final /* synthetic */ View f225a;
    final /* synthetic */ Object f226b;
    final /* synthetic */ ArrayList f227c;
    final /* synthetic */ C0049b f228d;
    final /* synthetic */ boolean f229e;
    final /* synthetic */ C0058n f230f;
    final /* synthetic */ C0058n f231g;
    final /* synthetic */ C0050e f232h;

    C0052g(C0050e c0050e, View view, Object obj, ArrayList arrayList, C0049b c0049b, boolean z, C0058n c0058n, C0058n c0058n2) {
        this.f232h = c0050e;
        this.f225a = view;
        this.f226b = obj;
        this.f227c = arrayList;
        this.f228d = c0049b;
        this.f229e = z;
        this.f230f = c0058n;
        this.f231g = c0058n2;
    }

    public final boolean onPreDraw() {
        this.f225a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f226b != null) {
            ah.m29a(this.f226b, this.f227c);
            this.f227c.clear();
            av a = C0050e.m192a(this.f232h, this.f228d, this.f229e, this.f230f);
            ah.m27a(this.f226b, this.f228d.f199d, a, this.f227c);
            C0050e.m200a(this.f232h, a, this.f228d);
            C0050e c0050e = this.f232h;
            C0049b c0049b = this.f228d;
            C0050e.m202a(this.f230f, this.f231g, this.f229e, a);
        }
        return true;
    }
}
