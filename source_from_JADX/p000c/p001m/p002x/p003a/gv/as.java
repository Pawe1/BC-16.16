package p000c.p001m.p002x.p003a.gv;

import java.io.PrintWriter;

public final class as<D> {
    int f63a;
    C0013b<D> f64b;
    C0012a<D> f65c;
    boolean f66d;
    boolean f67e;
    boolean f68f;
    boolean f69g;
    boolean f70h;

    public interface C0012a<D> {
    }

    public interface C0013b<D> {
    }

    public final void m62a() {
        this.f66d = true;
        this.f68f = false;
        this.f67e = false;
    }

    public final void m63a(int i, C0013b<D> c0013b) {
        if (this.f64b != null) {
            throw new IllegalStateException("There is already a listener registered");
        }
        this.f64b = c0013b;
        this.f63a = i;
    }

    public final void m64a(C0012a<D> c0012a) {
        if (this.f65c != null) {
            throw new IllegalStateException("There is already a listener registered");
        }
        this.f65c = c0012a;
    }

    public final void m65a(C0013b<D> c0013b) {
        if (this.f64b == null) {
            throw new IllegalStateException("No listener register");
        } else if (this.f64b != c0013b) {
            throw new IllegalArgumentException("Attempting to unregister the wrong listener");
        } else {
            this.f64b = null;
        }
    }

    public final void m66a(String str, PrintWriter printWriter) {
        printWriter.print(str);
        printWriter.print("mId=");
        printWriter.print(this.f63a);
        printWriter.print(" mListener=");
        printWriter.println(this.f64b);
        if (this.f66d || this.f69g || this.f70h) {
            printWriter.print(str);
            printWriter.print("mStarted=");
            printWriter.print(this.f66d);
            printWriter.print(" mContentChanged=");
            printWriter.print(this.f69g);
            printWriter.print(" mProcessingChange=");
            printWriter.println(this.f70h);
        }
        if (this.f67e || this.f68f) {
            printWriter.print(str);
            printWriter.print("mAbandoned=");
            printWriter.print(this.f67e);
            printWriter.print(" mReset=");
            printWriter.println(this.f68f);
        }
    }

    public final void m67b() {
        this.f66d = false;
    }

    public final void m68b(C0012a<D> c0012a) {
        if (this.f65c == null) {
            throw new IllegalStateException("No listener register");
        } else if (this.f65c != c0012a) {
            throw new IllegalArgumentException("Attempting to unregister the wrong listener");
        } else {
            this.f65c = null;
        }
    }

    public final void m69c() {
        this.f68f = true;
        this.f66d = false;
        this.f67e = false;
        this.f69g = false;
        this.f70h = false;
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(64);
        ay.m113a(this, stringBuilder);
        stringBuilder.append(" id=");
        stringBuilder.append(this.f63a);
        stringBuilder.append("}");
        return stringBuilder.toString();
    }
}
