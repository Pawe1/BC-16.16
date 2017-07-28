package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import java.io.PrintWriter;

public abstract class C0065u<E> extends C0062s {
    private final Activity f251a;
    final Context f252b;
    final int f253c;
    final C0074w f254d;
    private final Handler f255e;
    private bb<String, am> f256f;
    private an f257g;
    private boolean f258h;
    private boolean f259i;

    private C0065u(Activity activity, Context context, Handler handler) {
        this.f254d = new C0074w();
        this.f251a = activity;
        this.f252b = context;
        this.f255e = handler;
        this.f253c = 0;
    }

    C0065u(C0068q c0068q) {
        this(c0068q, c0068q, c0068q.mHandler);
    }

    public View mo38a(int i) {
        return null;
    }

    final an m226a(String str, boolean z, boolean z2) {
        if (this.f256f == null) {
            this.f256f = new bb();
        }
        an anVar = (an) this.f256f.get(str);
        if (anVar != null) {
            anVar.m45a(this);
            return anVar;
        } else if (!z2) {
            return anVar;
        } else {
            anVar = new an(str, this, z);
            this.f256f.put(str, anVar);
            return anVar;
        }
    }

    final void m227a(bb<String, am> bbVar) {
        this.f256f = bbVar;
    }

    void mo40a(C0058n c0058n) {
    }

    public void mo41a(C0058n c0058n, Intent intent, int i) {
        if (i != -1) {
            throw new IllegalStateException("Starting activity with a requestCode requires a FragmentActivity host");
        }
        this.f252b.startActivity(intent);
    }

    public void mo42a(C0058n c0058n, String[] strArr, int i) {
    }

    final void m231a(String str, PrintWriter printWriter) {
        printWriter.print(str);
        printWriter.print("mLoadersStarted=");
        printWriter.println(this.f259i);
        if (this.f257g != null) {
            printWriter.print(str);
            printWriter.print("Loader Manager ");
            printWriter.print(Integer.toHexString(System.identityHashCode(this.f257g)));
            printWriter.println(":");
            this.f257g.m46a(str + "  ", printWriter);
        }
    }

    public void mo43a(String str, PrintWriter printWriter, String[] strArr) {
    }

    final void m233a(boolean z) {
        if (this.f257g != null && this.f259i) {
            this.f259i = false;
            if (z) {
                this.f257g.m50d();
            } else {
                this.f257g.m49c();
            }
        }
    }

    public boolean mo39a() {
        return true;
    }

    public boolean mo44a(String str) {
        return false;
    }

    final void m236b(String str) {
        if (this.f256f != null) {
            an anVar = (an) this.f256f.get(str);
            if (anVar != null && !anVar.f59f) {
                anVar.m54h();
                this.f256f.remove(str);
            }
        }
    }

    public boolean mo45b() {
        return true;
    }

    public LayoutInflater mo46c() {
        return (LayoutInflater) this.f252b.getSystemService("layout_inflater");
    }

    public void mo47d() {
    }

    public boolean mo48e() {
        return true;
    }

    public int mo49f() {
        return this.f253c;
    }

    public abstract E mo50g();

    final Activity m243h() {
        return this.f251a;
    }

    final Handler m244i() {
        return this.f255e;
    }

    final an m245j() {
        if (this.f257g != null) {
            return this.f257g;
        }
        this.f258h = true;
        this.f257g = m226a("(root)", this.f259i, true);
        return this.f257g;
    }

    final void m246k() {
        if (!this.f259i) {
            this.f259i = true;
            if (this.f257g != null) {
                this.f257g.m48b();
            } else if (!this.f258h) {
                this.f257g = m226a("(root)", this.f259i, false);
                if (!(this.f257g == null || this.f257g.f58e)) {
                    this.f257g.m48b();
                }
            }
            this.f258h = true;
        }
    }

    final void m247l() {
        if (this.f257g != null) {
            this.f257g.m54h();
        }
    }

    final void m248m() {
        if (this.f256f != null) {
            int size = this.f256f.size();
            an[] anVarArr = new an[size];
            for (int i = size - 1; i >= 0; i--) {
                anVarArr[i] = (an) this.f256f.m84c(i);
            }
            for (int i2 = 0; i2 < size; i2++) {
                an anVar = anVarArr[i2];
                anVar.m51e();
                anVar.m53g();
            }
        }
    }

    final bb<String, am> m249n() {
        int i;
        int i2 = 0;
        if (this.f256f != null) {
            int size = this.f256f.size();
            an[] anVarArr = new an[size];
            for (int i3 = size - 1; i3 >= 0; i3--) {
                anVarArr[i3] = (an) this.f256f.m84c(i3);
            }
            i = 0;
            while (i2 < size) {
                an anVar = anVarArr[i2];
                if (anVar.f59f) {
                    i = 1;
                } else {
                    anVar.m54h();
                    this.f256f.remove(anVar.f57d);
                }
                i2++;
            }
        } else {
            i = 0;
        }
        return i != 0 ? this.f256f : null;
    }
}
