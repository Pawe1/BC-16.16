package p000c.p001m.p002x.p003a.gv;

import android.graphics.Rect;
import android.transition.Transition;
import android.transition.Transition.EpicenterCallback;
import p000c.p001m.p002x.p003a.gv.ah.C0009a;

final class ak extends EpicenterCallback {
    final /* synthetic */ C0009a f26a;
    private Rect f27b;

    ak(C0009a c0009a) {
        this.f26a = c0009a;
    }

    public final Rect onGetEpicenter(Transition transition) {
        if (this.f27b == null && this.f26a.f17a != null) {
            this.f27b = ah.m35b(this.f26a.f17a);
        }
        return this.f27b;
    }
}
