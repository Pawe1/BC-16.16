package p000c.p001m.p002x.p003a.gv;

import java.io.PrintWriter;

public final class aw<D> {
    int f108a;
    C0018b<D> f109b;
    C0017a<D> f110c;
    boolean f111d;
    boolean f112e;
    boolean f113f;
    boolean f114g;
    boolean f115h;

    public interface C0017a<D> {
    }

    public interface C0018b<D> {
    }

    public final void m115a() {
        this.f111d = true;
        this.f113f = false;
        this.f112e = false;
    }

    public final void m116a(int i, C0018b<D> c0018b) {
        if (this.f109b != null) {
            throw new IllegalStateException("There is already a listener registered");
        }
        this.f109b = c0018b;
        this.f108a = i;
    }

    public final void m117a(C0017a<D> c0017a) {
        if (this.f110c != null) {
            throw new IllegalStateException("There is already a listener registered");
        }
        this.f110c = c0017a;
    }

    public final void m118a(C0018b<D> c0018b) {
        if (this.f109b == null) {
            throw new IllegalStateException("No listener register");
        } else if (this.f109b != c0018b) {
            throw new IllegalArgumentException("Attempting to unregister the wrong listener");
        } else {
            this.f109b = null;
        }
    }

    public final void m119a(String str, PrintWriter printWriter) {
        printWriter.print(str);
        printWriter.print("mId=");
        printWriter.print(this.f108a);
        printWriter.print(" mListener=");
        printWriter.println(this.f109b);
        if (this.f111d || this.f114g || this.f115h) {
            printWriter.print(str);
            printWriter.print("mStarted=");
            printWriter.print(this.f111d);
            printWriter.print(" mContentChanged=");
            printWriter.print(this.f114g);
            printWriter.print(" mProcessingChange=");
            printWriter.println(this.f115h);
        }
        if (this.f112e || this.f113f) {
            printWriter.print(str);
            printWriter.print("mAbandoned=");
            printWriter.print(this.f112e);
            printWriter.print(" mReset=");
            printWriter.println(this.f113f);
        }
    }

    public final void m120b() {
        this.f111d = false;
    }

    public final void m121b(C0017a<D> c0017a) {
        if (this.f110c == null) {
            throw new IllegalStateException("No listener register");
        } else if (this.f110c != c0017a) {
            throw new IllegalArgumentException("Attempting to unregister the wrong listener");
        } else {
            this.f110c = null;
        }
    }

    public final void m122c() {
        this.f113f = true;
        this.f111d = false;
        this.f112e = false;
        this.f114g = false;
        this.f115h = false;
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(64);
        bd.m168a(this, stringBuilder);
        stringBuilder.append(" id=");
        stringBuilder.append(this.f108a);
        stringBuilder.append("}");
        return stringBuilder.toString();
    }
}
