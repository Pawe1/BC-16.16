package p000c.p001m.p002x.p003a.gv;

import android.graphics.Rect;
import android.transition.Transition;
import android.transition.Transition.EpicenterCallback;

final class ai extends EpicenterCallback {
    final /* synthetic */ Rect f18a;

    ai(Rect rect) {
        this.f18a = rect;
    }

    public final Rect onGetEpicenter(Transition transition) {
        return this.f18a;
    }
}
