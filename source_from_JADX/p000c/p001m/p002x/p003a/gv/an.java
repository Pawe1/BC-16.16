package p000c.p001m.p002x.p003a.gv;

import android.transition.Transition;
import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import p000c.p001m.p002x.p003a.gv.al.C0015b;

final class an implements OnPreDrawListener {
    final /* synthetic */ View f64a;
    final /* synthetic */ Transition f65b;
    final /* synthetic */ View f66c;
    final /* synthetic */ C0015b f67d;
    final /* synthetic */ Map f68e;
    final /* synthetic */ Map f69f;
    final /* synthetic */ ArrayList f70g;

    an(View view, Transition transition, View view2, C0015b c0015b, Map map, Map map2, ArrayList arrayList) {
        this.f64a = view;
        this.f65b = transition;
        this.f66c = view2;
        this.f67d = c0015b;
        this.f68e = map;
        this.f69f = map2;
        this.f70g = arrayList;
    }

    public final boolean onPreDraw() {
        this.f64a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f65b != null) {
            this.f65b.removeTarget(this.f66c);
        }
        View a = this.f67d.mo57a();
        if (a != null) {
            if (!this.f68e.isEmpty()) {
                al.m84a(this.f69f, a);
                this.f69f.keySet().retainAll(this.f68e.values());
                for (Entry entry : this.f68e.entrySet()) {
                    View view = (View) this.f69f.get((String) entry.getValue());
                    if (view != null) {
                        view.setTransitionName((String) entry.getKey());
                    }
                }
            }
            if (this.f65b != null) {
                al.m90b(this.f70g, a);
                this.f70g.removeAll(this.f69f.values());
                this.f70g.add(this.f66c);
                al.m89b(this.f65b, this.f70g);
            }
        }
        return true;
    }
}
