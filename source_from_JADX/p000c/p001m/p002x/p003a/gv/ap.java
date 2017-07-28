package p000c.p001m.p002x.p003a.gv;

import android.transition.Transition;
import android.view.View;
import android.view.ViewTreeObserver.OnPreDrawListener;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;

final class ap implements OnPreDrawListener {
    final /* synthetic */ View f73a;
    final /* synthetic */ Transition f74b;
    final /* synthetic */ ArrayList f75c;
    final /* synthetic */ Transition f76d;
    final /* synthetic */ ArrayList f77e;
    final /* synthetic */ Transition f78f;
    final /* synthetic */ ArrayList f79g;
    final /* synthetic */ Map f80h;
    final /* synthetic */ ArrayList f81i;
    final /* synthetic */ Transition f82j;
    final /* synthetic */ View f83k;

    ap(View view, Transition transition, ArrayList arrayList, Transition transition2, ArrayList arrayList2, Transition transition3, ArrayList arrayList3, Map map, ArrayList arrayList4, Transition transition4, View view2) {
        this.f73a = view;
        this.f74b = transition;
        this.f75c = arrayList;
        this.f76d = transition2;
        this.f77e = arrayList2;
        this.f78f = transition3;
        this.f79g = arrayList3;
        this.f80h = map;
        this.f81i = arrayList4;
        this.f82j = transition4;
        this.f83k = view2;
    }

    public final boolean onPreDraw() {
        this.f73a.getViewTreeObserver().removeOnPreDrawListener(this);
        if (this.f74b != null) {
            al.m82a(this.f74b, this.f75c);
        }
        if (this.f76d != null) {
            al.m82a(this.f76d, this.f77e);
        }
        if (this.f78f != null) {
            al.m82a(this.f78f, this.f79g);
        }
        for (Entry entry : this.f80h.entrySet()) {
            ((View) entry.getValue()).setTransitionName((String) entry.getKey());
        }
        int size = this.f81i.size();
        for (int i = 0; i < size; i++) {
            this.f82j.excludeTarget((View) this.f81i.get(i), false);
        }
        this.f82j.excludeTarget(this.f83k, false);
        return true;
    }
}
