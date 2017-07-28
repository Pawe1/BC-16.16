package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import p000c.p001m.p002x.p003a.gv.C0063g.C0062b;

final class C0065i implements OnPreDrawListener {
    final /* synthetic */ View f272a;
    final /* synthetic */ Object f273b;
    final /* synthetic */ ArrayList f274c;
    final /* synthetic */ C0062b f275d;
    final /* synthetic */ boolean f276e;
    final /* synthetic */ C0073r f277f;
    final /* synthetic */ C0073r f278g;
    final /* synthetic */ C0063g f279h;

    C0065i(C0063g c0063g, View view, Object obj, ArrayList arrayList, C0062b c0062b, boolean z, C0073r c0073r, C0073r c0073r2) {
        this.f279h = c0063g;
        this.f272a = view;
        this.f273b = obj;
        this.f274c = arrayList;
        this.f275d = c0062b;
        this.f276e = z;
        this.f277f = c0073r;
        this.f278g = c0073r2;
    }

    public final boolean onPreDraw() {
        this.f272a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f273b != null) {
            al.m82a(this.f273b, this.f274c);
            this.f274c.clear();
            ba a = C0063g.m267a(this.f279h, this.f275d, this.f276e, this.f277f);
            al.m80a(this.f273b, this.f275d.f246d, a, this.f274c);
            C0063g.m275a(this.f279h, a, this.f275d);
            C0063g c0063g = this.f279h;
            C0062b c0062b = this.f275d;
            C0063g.m277a(this.f277f, this.f278g, this.f276e, a);
        }
        return true;
    }
}
