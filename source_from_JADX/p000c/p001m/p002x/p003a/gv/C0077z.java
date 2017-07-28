package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.animation.Animation;
import p000c.p001m.p002x.p003a.gv.C0074w.C0072a;

final class C0077z extends C0072a {
    final /* synthetic */ C0058n f302a;
    final /* synthetic */ C0074w f303b;

    C0077z(C0074w c0074w, View view, Animation animation, C0058n c0058n) {
        this.f303b = c0074w;
        this.f302a = c0058n;
        super(view, animation);
    }

    public final void onAnimationEnd(Animation animation) {
        super.onAnimationEnd(animation);
        if (this.f302a.mAnimatingAway != null) {
            this.f302a.mAnimatingAway = null;
            this.f303b.m329a(this.f302a, this.f302a.mStateAfterAnimating, 0, 0, false);
        }
    }
}
