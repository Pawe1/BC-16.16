package p000c.p001m.p002x.p003a.gv;

import android.os.Bundle;
import android.util.Log;
import java.io.PrintWriter;
import java.lang.reflect.Modifier;
import p000c.p001m.p002x.p003a.gv.aq.C0016a;
import p000c.p001m.p002x.p003a.gv.aw.C0017a;
import p000c.p001m.p002x.p003a.gv.aw.C0018b;

final class ar extends aq {
    static boolean f99a = false;
    final bh<C0019a> f100b = new bh();
    final bh<C0019a> f101c = new bh();
    final String f102d;
    boolean f103e;
    boolean f104f;
    private C0080y f105g;

    final class C0019a implements C0017a<Object>, C0018b<Object> {
        final int f84a;
        final Bundle f85b;
        C0016a<Object> f86c;
        aw<Object> f87d;
        boolean f88e;
        boolean f89f;
        Object f90g;
        boolean f91h;
        boolean f92i;
        boolean f93j;
        boolean f94k;
        boolean f95l;
        boolean f96m;
        C0019a f97n;
        final /* synthetic */ ar f98o;

        final void m93a() {
            if (ar.f99a) {
                Log.v("LoaderManager", "  Stopping: " + this);
            }
            this.f91h = false;
            if (!this.f92i && this.f87d != null && this.f96m) {
                this.f96m = false;
                this.f87d.m118a((C0018b) this);
                this.f87d.m121b(this);
                this.f87d.m120b();
            }
        }

        final void m94a(aw<Object> awVar, Object obj) {
            String str;
            if (this.f86c != null) {
                if (this.f98o.f105g != null) {
                    String str2 = this.f98o.f105g.f303d.f35v;
                    this.f98o.f105g.f303d.f35v = "onLoadFinished";
                    str = str2;
                } else {
                    str = null;
                }
                try {
                    if (ar.f99a) {
                        StringBuilder append = new StringBuilder("  onLoadFinished in ").append(awVar).append(": ");
                        StringBuilder stringBuilder = new StringBuilder(64);
                        bd.m168a(obj, stringBuilder);
                        stringBuilder.append("}");
                        Log.v("LoaderManager", append.append(stringBuilder.toString()).toString());
                    }
                    C0016a c0016a = this.f86c;
                    this.f89f = true;
                } finally {
                    if (this.f98o.f105g != null) {
                        this.f98o.f105g.f303d.f35v = str;
                    }
                }
            }
        }

        public final void m95a(String str, PrintWriter printWriter) {
            while (true) {
                printWriter.print(str);
                printWriter.print("mId=");
                printWriter.print(this.f84a);
                printWriter.print(" mArgs=");
                printWriter.println(this.f85b);
                printWriter.print(str);
                printWriter.print("mCallbacks=");
                printWriter.println(this.f86c);
                printWriter.print(str);
                printWriter.print("mLoader=");
                printWriter.println(this.f87d);
                if (this.f87d != null) {
                    this.f87d.m119a(str + "  ", printWriter);
                }
                if (this.f88e || this.f89f) {
                    printWriter.print(str);
                    printWriter.print("mHaveData=");
                    printWriter.print(this.f88e);
                    printWriter.print("  mDeliveredData=");
                    printWriter.println(this.f89f);
                    printWriter.print(str);
                    printWriter.print("mData=");
                    printWriter.println(this.f90g);
                }
                printWriter.print(str);
                printWriter.print("mStarted=");
                printWriter.print(this.f91h);
                printWriter.print(" mReportNextStart=");
                printWriter.print(this.f94k);
                printWriter.print(" mDestroyed=");
                printWriter.println(this.f95l);
                printWriter.print(str);
                printWriter.print("mRetaining=");
                printWriter.print(this.f92i);
                printWriter.print(" mRetainingStarted=");
                printWriter.print(this.f93j);
                printWriter.print(" mListenerRegistered=");
                printWriter.println(this.f96m);
                if (this.f97n != null) {
                    printWriter.print(str);
                    printWriter.println("Pending Loader ");
                    printWriter.print(this.f97n);
                    printWriter.println(":");
                    this = this.f97n;
                    str = str + "  ";
                } else {
                    return;
                }
            }
        }

        final void m96b() {
            C0018b c0018b;
            String str;
            C0016a c0016a = null;
            Object obj = null;
            while (true) {
                if (ar.f99a) {
                    Log.v("LoaderManager", "  Destroying: " + c0018b);
                }
                c0018b.f95l = true;
                boolean z = c0018b.f89f;
                c0018b.f89f = obj;
                if (c0018b.f86c != null && c0018b.f87d != null && c0018b.f88e && z) {
                    if (ar.f99a) {
                        Log.v("LoaderManager", "  Reseting: " + c0018b);
                    }
                    if (c0018b.f98o.f105g != null) {
                        String str2 = c0018b.f98o.f105g.f303d.f35v;
                        c0018b.f98o.f105g.f303d.f35v = "onLoaderReset";
                        str = str2;
                    } else {
                        Object obj2 = c0016a;
                    }
                    try {
                        C0016a c0016a2 = c0018b.f86c;
                        aw awVar = c0018b.f87d;
                    } finally {
                        c0016a = c0018b.f98o.f105g;
                        if (c0016a != null) {
                            c0016a = c0018b.f98o.f105g.f303d;
                            c0016a.f35v = str;
                        }
                    }
                }
                c0018b.f86c = c0016a;
                c0018b.f90g = c0016a;
                c0018b.f88e = obj;
                if (c0018b.f87d != null) {
                    if (c0018b.f96m) {
                        c0018b.f96m = obj;
                        c0018b.f87d.m118a(c0018b);
                        c0018b.f87d.m121b(c0018b);
                    }
                    c0018b.f87d.m122c();
                }
                if (c0018b.f97n != null) {
                    c0018b = c0018b.f97n;
                } else {
                    return;
                }
            }
        }

        public final String toString() {
            StringBuilder stringBuilder = new StringBuilder(64);
            stringBuilder.append("LoaderInfo{");
            stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
            stringBuilder.append(" #");
            stringBuilder.append(this.f84a);
            stringBuilder.append(" : ");
            bd.m168a(this.f87d, stringBuilder);
            stringBuilder.append("}}");
            return stringBuilder.toString();
        }
    }

    ar(String str, C0080y c0080y, boolean z) {
        this.f102d = str;
        this.f105g = c0080y;
        this.f103e = z;
    }

    final void m98a(C0080y c0080y) {
        this.f105g = c0080y;
    }

    public final void m99a(String str, PrintWriter printWriter) {
        int i = 0;
        if (this.f100b.m172a() > 0) {
            printWriter.print(str);
            printWriter.println("Active Loaders:");
            String str2 = str + "    ";
            for (int i2 = 0; i2 < this.f100b.m172a(); i2++) {
                C0019a c0019a = (C0019a) this.f100b.m178d(i2);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(this.f100b.m177c(i2));
                printWriter.print(": ");
                printWriter.println(c0019a.toString());
                c0019a.m95a(str2, printWriter);
            }
        }
        if (this.f101c.m172a() > 0) {
            printWriter.print(str);
            printWriter.println("Inactive Loaders:");
            String str3 = str + "    ";
            while (i < this.f101c.m172a()) {
                c0019a = (C0019a) this.f101c.m178d(i);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(this.f101c.m177c(i));
                printWriter.print(": ");
                printWriter.println(c0019a.toString());
                c0019a.m95a(str3, printWriter);
                i++;
            }
        }
    }

    public final boolean mo30a() {
        int a = this.f100b.m172a();
        boolean z = false;
        for (int i = 0; i < a; i++) {
            C0019a c0019a = (C0019a) this.f100b.m178d(i);
            int i2 = (!c0019a.f91h || c0019a.f89f) ? 0 : 1;
            z |= i2;
        }
        return z;
    }

    final void m101b() {
        if (f99a) {
            Log.v("LoaderManager", "Starting in " + this);
        }
        if (this.f103e) {
            Throwable runtimeException = new RuntimeException("here");
            runtimeException.fillInStackTrace();
            Log.w("LoaderManager", "Called doStart when already started: " + this, runtimeException);
            return;
        }
        this.f103e = true;
        for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
            C0017a c0017a = (C0019a) this.f100b.m178d(a);
            if (c0017a.f92i && c0017a.f93j) {
                c0017a.f91h = true;
            } else if (c0017a.f91h) {
                continue;
            } else {
                c0017a.f91h = true;
                if (f99a) {
                    Log.v("LoaderManager", "  Starting: " + c0017a);
                }
                if (c0017a.f87d == null && c0017a.f86c != null) {
                    C0016a c0016a = c0017a.f86c;
                    int i = c0017a.f84a;
                    Bundle bundle = c0017a.f85b;
                    c0017a.f87d = c0016a.m91a();
                }
                if (c0017a.f87d == null) {
                    continue;
                } else if (!c0017a.f87d.getClass().isMemberClass() || Modifier.isStatic(c0017a.f87d.getClass().getModifiers())) {
                    if (!c0017a.f96m) {
                        c0017a.f87d.m116a(c0017a.f84a, (C0018b) c0017a);
                        c0017a.f87d.m117a(c0017a);
                        c0017a.f96m = true;
                    }
                    c0017a.f87d.m115a();
                } else {
                    throw new IllegalArgumentException("Object returned from onCreateLoader must not be a non-static inner member class: " + c0017a.f87d);
                }
            }
        }
    }

    final void m102c() {
        if (f99a) {
            Log.v("LoaderManager", "Stopping in " + this);
        }
        if (this.f103e) {
            for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
                ((C0019a) this.f100b.m178d(a)).m93a();
            }
            this.f103e = false;
            return;
        }
        Throwable runtimeException = new RuntimeException("here");
        runtimeException.fillInStackTrace();
        Log.w("LoaderManager", "Called doStop when not started: " + this, runtimeException);
    }

    final void m103d() {
        if (f99a) {
            Log.v("LoaderManager", "Retaining in " + this);
        }
        if (this.f103e) {
            this.f104f = true;
            this.f103e = false;
            for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
                C0019a c0019a = (C0019a) this.f100b.m178d(a);
                if (f99a) {
                    Log.v("LoaderManager", "  Retaining: " + c0019a);
                }
                c0019a.f92i = true;
                c0019a.f93j = c0019a.f91h;
                c0019a.f91h = false;
                c0019a.f86c = null;
            }
            return;
        }
        Throwable runtimeException = new RuntimeException("here");
        runtimeException.fillInStackTrace();
        Log.w("LoaderManager", "Called doRetain when not started: " + this, runtimeException);
    }

    final void m104e() {
        if (this.f104f) {
            if (f99a) {
                Log.v("LoaderManager", "Finished Retaining in " + this);
            }
            this.f104f = false;
            for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
                C0019a c0019a = (C0019a) this.f100b.m178d(a);
                if (c0019a.f92i) {
                    if (f99a) {
                        Log.v("LoaderManager", "  Finished Retaining: " + c0019a);
                    }
                    c0019a.f92i = false;
                    if (!(c0019a.f91h == c0019a.f93j || c0019a.f91h)) {
                        c0019a.m93a();
                    }
                }
                if (c0019a.f91h && c0019a.f88e && !c0019a.f94k) {
                    c0019a.m94a(c0019a.f87d, c0019a.f90g);
                }
            }
        }
    }

    final void m105f() {
        for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
            ((C0019a) this.f100b.m178d(a)).f94k = true;
        }
    }

    final void m106g() {
        for (int a = this.f100b.m172a() - 1; a >= 0; a--) {
            C0019a c0019a = (C0019a) this.f100b.m178d(a);
            if (c0019a.f91h && c0019a.f94k) {
                c0019a.f94k = false;
                if (c0019a.f88e) {
                    c0019a.m94a(c0019a.f87d, c0019a.f90g);
                }
            }
        }
    }

    final void m107h() {
        int a;
        if (!this.f104f) {
            if (f99a) {
                Log.v("LoaderManager", "Destroying Active in " + this);
            }
            for (a = this.f100b.m172a() - 1; a >= 0; a--) {
                ((C0019a) this.f100b.m178d(a)).m96b();
            }
            this.f100b.m175b();
        }
        if (f99a) {
            Log.v("LoaderManager", "Destroying Inactive in " + this);
        }
        for (a = this.f101c.m172a() - 1; a >= 0; a--) {
            ((C0019a) this.f101c.m178d(a)).m96b();
        }
        this.f101c.m175b();
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append("LoaderManager{");
        stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
        stringBuilder.append(" in ");
        bd.m168a(this.f105g, stringBuilder);
        stringBuilder.append("}}");
        return stringBuilder.toString();
    }
}
