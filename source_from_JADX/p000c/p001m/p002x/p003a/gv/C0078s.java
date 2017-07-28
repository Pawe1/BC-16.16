package p000c.p001m.p002x.p003a.gv;

import android.view.View;

final class C0078s extends C0077w {
    final /* synthetic */ C0073r f299a;

    C0078s(C0073r c0073r) {
        this.f299a = c0073r;
    }

    public final View mo67a(int i) {
        if (this.f299a.mView != null) {
            return this.f299a.mView.findViewById(i);
        }
        throw new IllegalStateException("Fragment does not have a view");
    }

    public final boolean mo68a() {
        return this.f299a.mView != null;
    }
}
