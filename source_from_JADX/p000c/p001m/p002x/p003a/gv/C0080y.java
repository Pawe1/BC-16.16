package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import java.io.PrintWriter;

public abstract class C0080y<E> extends C0077w {
    private final Activity f300a;
    final Context f301b;
    final int f302c;
    final aa f303d;
    private final Handler f304e;
    private bg<String, aq> f305f;
    private boolean f306g;
    private ar f307h;
    private boolean f308i;
    private boolean f309j;

    private C0080y(Activity activity, Context context, Handler handler) {
        this.f303d = new aa();
        this.f300a = activity;
        this.f301b = context;
        this.f304e = handler;
        this.f302c = 0;
    }

    C0080y(C0083u c0083u) {
        this(c0083u, c0083u, c0083u.mHandler);
    }

    public View mo67a(int i) {
        return null;
    }

    final ar m303a(String str, boolean z, boolean z2) {
        if (this.f305f == null) {
            this.f305f = new bg();
        }
        ar arVar = (ar) this.f305f.get(str);
        if (arVar != null) {
            arVar.m98a(this);
            return arVar;
        } else if (!z2) {
            return arVar;
        } else {
            arVar = new ar(str, this, z);
            this.f305f.put(str, arVar);
            return arVar;
        }
    }

    final void m304a(bg<String, aq> bgVar) {
        this.f305f = bgVar;
    }

    void mo69a(C0073r c0073r) {
    }

    public void mo70a(C0073r c0073r, Intent intent, int i, Bundle bundle) {
        if (i != -1) {
            throw new IllegalStateException("Starting activity with a requestCode requires a FragmentActivity host");
        }
        this.f301b.startActivity(intent);
    }

    public void mo71a(C0073r c0073r, String[] strArr, int i) {
    }

    final void m308a(String str, PrintWriter printWriter) {
        printWriter.print(str);
        printWriter.print("mLoadersStarted=");
        printWriter.println(this.f309j);
        if (this.f307h != null) {
            printWriter.print(str);
            printWriter.print("Loader Manager ");
            printWriter.print(Integer.toHexString(System.identityHashCode(this.f307h)));
            printWriter.println(":");
            this.f307h.m99a(str + "  ", printWriter);
        }
    }

    public void mo72a(String str, PrintWriter printWriter, String[] strArr) {
    }

    final void m310a(boolean z) {
        this.f306g = z;
        if (this.f307h != null && this.f309j) {
            this.f309j = false;
            if (z) {
                this.f307h.m103d();
            } else {
                this.f307h.m102c();
            }
        }
    }

    public boolean mo68a() {
        return true;
    }

    public boolean mo73a(String str) {
        return false;
    }

    final void m313b(String str) {
        if (this.f305f != null) {
            ar arVar = (ar) this.f305f.get(str);
            if (arVar != null && !arVar.f104f) {
                arVar.m107h();
                this.f305f.remove(str);
            }
        }
    }

    public boolean mo74b() {
        return true;
    }

    public LayoutInflater mo75c() {
        return (LayoutInflater) this.f301b.getSystemService("layout_inflater");
    }

    public void mo76d() {
    }

    public boolean mo77e() {
        return true;
    }

    public int mo78f() {
        return this.f302c;
    }

    public abstract E mo79g();

    final Activity m320h() {
        return this.f300a;
    }

    final Handler m321i() {
        return this.f304e;
    }

    final ar m322j() {
        if (this.f307h != null) {
            return this.f307h;
        }
        this.f308i = true;
        this.f307h = m303a("(root)", this.f309j, true);
        return this.f307h;
    }

    final boolean m323k() {
        return this.f306g;
    }

    final void m324l() {
        if (!this.f309j) {
            this.f309j = true;
            if (this.f307h != null) {
                this.f307h.m101b();
            } else if (!this.f308i) {
                this.f307h = m303a("(root)", this.f309j, false);
                if (!(this.f307h == null || this.f307h.f103e)) {
                    this.f307h.m101b();
                }
            }
            this.f308i = true;
        }
    }

    final void m325m() {
        if (this.f307h != null) {
            this.f307h.m107h();
        }
    }

    final void m326n() {
        if (this.f305f != null) {
            int size = this.f305f.size();
            ar[] arVarArr = new ar[size];
            for (int i = size - 1; i >= 0; i--) {
                arVarArr[i] = (ar) this.f305f.m139c(i);
            }
            for (int i2 = 0; i2 < size; i2++) {
                ar arVar = arVarArr[i2];
                arVar.m104e();
                arVar.m106g();
            }
        }
    }

    final bg<String, aq> m327o() {
        int i;
        int i2 = 0;
        if (this.f305f != null) {
            int size = this.f305f.size();
            ar[] arVarArr = new ar[size];
            for (int i3 = size - 1; i3 >= 0; i3--) {
                arVarArr[i3] = (ar) this.f305f.m139c(i3);
            }
            i = 0;
            while (i2 < size) {
                ar arVar = arVarArr[i2];
                if (arVar.f104f) {
                    i = 1;
                } else {
                    arVar.m107h();
                    this.f305f.remove(arVar.f102d);
                }
                i2++;
            }
        } else {
            i = 0;
        }
        return i != 0 ? this.f305f : null;
    }
}
