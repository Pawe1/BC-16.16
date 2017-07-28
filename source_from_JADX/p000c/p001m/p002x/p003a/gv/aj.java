package p000c.p001m.p002x.p003a.gv;

import android.transition.Transition;
import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import p000c.p001m.p002x.p003a.gv.ah.C0010b;

final class aj implements OnPreDrawListener {
    final /* synthetic */ View f19a;
    final /* synthetic */ Transition f20b;
    final /* synthetic */ View f21c;
    final /* synthetic */ C0010b f22d;
    final /* synthetic */ Map f23e;
    final /* synthetic */ Map f24f;
    final /* synthetic */ ArrayList f25g;

    aj(View view, Transition transition, View view2, C0010b c0010b, Map map, Map map2, ArrayList arrayList) {
        this.f19a = view;
        this.f20b = transition;
        this.f21c = view2;
        this.f22d = c0010b;
        this.f23e = map;
        this.f24f = map2;
        this.f25g = arrayList;
    }

    public final boolean onPreDraw() {
        this.f19a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f20b != null) {
            this.f20b.removeTarget(this.f21c);
        }
        View a = this.f22d.mo28a();
        if (a != null) {
            if (!this.f23e.isEmpty()) {
                ah.m31a(this.f24f, a);
                this.f24f.keySet().retainAll(this.f23e.values());
                for (Entry entry : this.f23e.entrySet()) {
                    View view = (View) this.f24f.get((String) entry.getValue());
                    if (view != null) {
                        view.setTransitionName((String) entry.getKey());
                    }
                }
            }
            if (this.f20b != null) {
                ah.m37b(this.f25g, a);
                this.f25g.removeAll(this.f24f.values());
                this.f25g.add(this.f21c);
                ah.m36b(this.f20b, this.f25g);
            }
        }
        return true;
    }
}
