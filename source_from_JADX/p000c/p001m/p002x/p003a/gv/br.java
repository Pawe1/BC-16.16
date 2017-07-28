package p000c.p001m.p002x.p003a.gv;

import java.util.Locale;

public final class br {
    private final Object f188a;
    private boolean f189b;

    public final boolean m208a() {
        boolean z;
        synchronized (this.f188a) {
            z = this.f189b;
        }
        return z;
    }

    public final String toString() {
        return String.format(Locale.US, "%s@%s[cancellationRequested=%s]", new Object[]{getClass().getName(), Integer.toHexString(hashCode()), Boolean.toString(this.f189b)});
    }
}
