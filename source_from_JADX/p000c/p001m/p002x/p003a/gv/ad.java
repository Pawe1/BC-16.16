package p000c.p001m.p002x.p003a.gv;

import android.view.View;
import android.view.animation.Animation;
import p000c.p001m.p002x.p003a.gv.aa.C0011a;

final class ad extends C0011a {
    final /* synthetic */ C0073r f44a;
    final /* synthetic */ aa f45b;

    ad(aa aaVar, View view, Animation animation, C0073r c0073r) {
        this.f45b = aaVar;
        this.f44a = c0073r;
        super(view, animation);
    }

    public final void onAnimationEnd(Animation animation) {
        super.onAnimationEnd(animation);
        if (this.f44a.mAnimatingAway != null) {
            this.f44a.mAnimatingAway = null;
            this.f45b.m34a(this.f44a, this.f44a.mStateAfterAnimating, 0, 0, false);
        }
    }
}
