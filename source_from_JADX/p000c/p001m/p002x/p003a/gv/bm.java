package p000c.p001m.p002x.p003a.gv;

import java.util.Locale;

public final class bm {
    private final Object f145a;
    private boolean f146b;

    public final boolean m150a() {
        boolean z;
        synchronized (this.f145a) {
            z = this.f146b;
        }
        return z;
    }

    public final String toString() {
        return String.format(Locale.US, "%s@%s[cancellationRequested=%s]", new Object[]{getClass().getName(), Integer.toHexString(hashCode()), Boolean.toString(this.f146b)});
    }
}
