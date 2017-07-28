package p000c.p001m.p002x.p003a.gv;

import android.transition.Transition;
import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;

final class al implements OnPreDrawListener {
    final /* synthetic */ View f28a;
    final /* synthetic */ Transition f29b;
    final /* synthetic */ ArrayList f30c;
    final /* synthetic */ Transition f31d;
    final /* synthetic */ ArrayList f32e;
    final /* synthetic */ Transition f33f;
    final /* synthetic */ ArrayList f34g;
    final /* synthetic */ Map f35h;
    final /* synthetic */ ArrayList f36i;
    final /* synthetic */ Transition f37j;
    final /* synthetic */ View f38k;

    al(View view, Transition transition, ArrayList arrayList, Transition transition2, ArrayList arrayList2, Transition transition3, ArrayList arrayList3, Map map, ArrayList arrayList4, Transition transition4, View view2) {
        this.f28a = view;
        this.f29b = transition;
        this.f30c = arrayList;
        this.f31d = transition2;
        this.f32e = arrayList2;
        this.f33f = transition3;
        this.f34g = arrayList3;
        this.f35h = map;
        this.f36i = arrayList4;
        this.f37j = transition4;
        this.f38k = view2;
    }

    public final boolean onPreDraw() {
        this.f28a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f29b != null) {
            ah.m29a(this.f29b, this.f30c);
        }
        if (this.f31d != null) {
            ah.m29a(this.f31d, this.f32e);
        }
        if (this.f33f != null) {
            ah.m29a(this.f33f, this.f34g);
        }
        for (Entry entry : this.f35h.entrySet()) {
            ((View) entry.getValue()).setTransitionName((String) entry.getKey());
        }
        int size = this.f36i.size();
        for (int i = 0; i < size; i++) {
            this.f37j.excludeTarget((View) this.f36i.get(i), false);
        }
        this.f37j.excludeTarget(this.f38k, false);
        return true;
    }
}
