package p000c.p001m.p002x.p003a.gv;

import android.util.Log;
import java.io.Writer;

public final class az extends Writer {
    private final String f99a;
    private StringBuilder f100b = new StringBuilder(128);

    public az(String str) {
        this.f99a = str;
    }

    private void m114a() {
        if (this.f100b.length() > 0) {
            Log.d(this.f99a, this.f100b.toString());
            this.f100b.delete(0, this.f100b.length());
        }
    }

    public final void close() {
        m114a();
    }

    public final void flush() {
        m114a();
    }

    public final void write(char[] cArr, int i, int i2) {
        for (int i3 = 0; i3 < i2; i3++) {
            char c = cArr[i + i3];
            if (c == '\n') {
                m114a();
            } else {
                this.f100b.append(c);
            }
        }
    }
}
