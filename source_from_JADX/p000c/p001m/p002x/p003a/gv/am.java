package p000c.p001m.p002x.p003a.gv;

import android.graphics.Rect;
import android.transition.Transition;
import android.transition.Transition.EpicenterCallback;

final class am extends EpicenterCallback {
    final /* synthetic */ Rect f63a;

    am(Rect rect) {
        this.f63a = rect;
    }

    public final Rect onGetEpicenter(Transition transition) {
        return this.f63a;
    }
}
