package p000c.p001m.p002x.p003a.gv;

import android.util.Log;
import java.io.Writer;

public final class be extends Writer {
    private final String f145a;
    private StringBuilder f146b = new StringBuilder(128);

    public be(String str) {
        this.f145a = str;
    }

    private void m169a() {
        if (this.f146b.length() > 0) {
            Log.d(this.f145a, this.f146b.toString());
            this.f146b.delete(0, this.f146b.length());
        }
    }

    public final void close() {
        m169a();
    }

    public final void flush() {
        m169a();
    }

    public final void write(char[] cArr, int i, int i2) {
        for (int i3 = 0; i3 < i2; i3++) {
            char c = cArr[i + i3];
            if (c == '\n') {
                m169a();
            } else {
                this.f146b.append(c);
            }
        }
    }
}
