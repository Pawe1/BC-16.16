package p000c.p001m.p002x.p003a.gv;

import android.view.View;

final class C0063o extends C0062s {
    final /* synthetic */ C0058n f250a;

    C0063o(C0058n c0058n) {
        this.f250a = c0058n;
    }

    public final View mo38a(int i) {
        if (this.f250a.mView != null) {
            return this.f250a.mView.findViewById(i);
        }
        throw new IllegalStateException("Fragment does not have a view");
    }

    public final boolean mo39a() {
        return this.f250a.mView != null;
    }
}
