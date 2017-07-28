package p000c.p001m.p002x.p003a.gv;

import android.graphics.Rect;
import android.transition.Transition;
import android.transition.Transition.EpicenterCallback;
import p000c.p001m.p002x.p003a.gv.al.C0014a;

final class ao extends EpicenterCallback {
    final /* synthetic */ C0014a f71a;
    private Rect f72b;

    ao(C0014a c0014a) {
        this.f71a = c0014a;
    }

    public final Rect onGetEpicenter(Transition transition) {
        if (this.f72b == null && this.f71a.f62a != null) {
            this.f72b = al.m88b(this.f71a.f62a);
        }
        return this.f72b;
    }
}
