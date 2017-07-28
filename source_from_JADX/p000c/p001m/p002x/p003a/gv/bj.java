package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater.Factory;
import android.view.View;

final class bj {

    static class C0033a implements Factory {
        final bl f165a;

        C0033a(bl blVar) {
            this.f165a = blVar;
        }

        public View onCreateView(String str, Context context, AttributeSet attributeSet) {
            return this.f165a.mo23a(null, str, context, attributeSet);
        }

        public final String toString() {
            return getClass().getName() + "{" + this.f165a + "}";
        }
    }
}
