package p000c.p001m.p002x.p003a.gv;

import android.os.Bundle;
import android.util.Log;
import java.io.PrintWriter;
import java.lang.reflect.Modifier;
import p000c.p001m.p002x.p003a.gv.am.C0011a;
import p000c.p001m.p002x.p003a.gv.as.C0012a;
import p000c.p001m.p002x.p003a.gv.as.C0013b;

final class an extends am {
    static boolean f54a = false;
    final bc<C0014a> f55b = new bc();
    final bc<C0014a> f56c = new bc();
    final String f57d;
    boolean f58e;
    boolean f59f;
    private C0065u f60g;

    final class C0014a implements C0012a<Object>, C0013b<Object> {
        final int f39a;
        final Bundle f40b;
        C0011a<Object> f41c;
        as<Object> f42d;
        boolean f43e;
        boolean f44f;
        Object f45g;
        boolean f46h;
        boolean f47i;
        boolean f48j;
        boolean f49k;
        boolean f50l;
        boolean f51m;
        C0014a f52n;
        final /* synthetic */ an f53o;

        final void m40a() {
            if (an.f54a) {
                Log.v("LoaderManager", "  Stopping: " + this);
            }
            this.f46h = false;
            if (!this.f47i && this.f42d != null && this.f51m) {
                this.f51m = false;
                this.f42d.m65a((C0013b) this);
                this.f42d.m68b(this);
                this.f42d.m67b();
            }
        }

        final void m41a(as<Object> asVar, Object obj) {
            String str;
            if (this.f41c != null) {
                if (this.f53o.f60g != null) {
                    String str2 = this.f53o.f60g.f254d.f293u;
                    this.f53o.f60g.f254d.f293u = "onLoadFinished";
                    str = str2;
                } else {
                    str = null;
                }
                try {
                    if (an.f54a) {
                        StringBuilder append = new StringBuilder("  onLoadFinished in ").append(asVar).append(": ");
                        StringBuilder stringBuilder = new StringBuilder(64);
                        ay.m113a(obj, stringBuilder);
                        stringBuilder.append("}");
                        Log.v("LoaderManager", append.append(stringBuilder.toString()).toString());
                    }
                    C0011a c0011a = this.f41c;
                    this.f44f = true;
                } finally {
                    if (this.f53o.f60g != null) {
                        this.f53o.f60g.f254d.f293u = str;
                    }
                }
            }
        }

        public final void m42a(String str, PrintWriter printWriter) {
            while (true) {
                printWriter.print(str);
                printWriter.print("mId=");
                printWriter.print(this.f39a);
                printWriter.print(" mArgs=");
                printWriter.println(this.f40b);
                printWriter.print(str);
                printWriter.print("mCallbacks=");
                printWriter.println(this.f41c);
                printWriter.print(str);
                printWriter.print("mLoader=");
                printWriter.println(this.f42d);
                if (this.f42d != null) {
                    this.f42d.m66a(str + "  ", printWriter);
                }
                if (this.f43e || this.f44f) {
                    printWriter.print(str);
                    printWriter.print("mHaveData=");
                    printWriter.print(this.f43e);
                    printWriter.print("  mDeliveredData=");
                    printWriter.println(this.f44f);
                    printWriter.print(str);
                    printWriter.print("mData=");
                    printWriter.println(this.f45g);
                }
                printWriter.print(str);
                printWriter.print("mStarted=");
                printWriter.print(this.f46h);
                printWriter.print(" mReportNextStart=");
                printWriter.print(this.f49k);
                printWriter.print(" mDestroyed=");
                printWriter.println(this.f50l);
                printWriter.print(str);
                printWriter.print("mRetaining=");
                printWriter.print(this.f47i);
                printWriter.print(" mRetainingStarted=");
                printWriter.print(this.f48j);
                printWriter.print(" mListenerRegistered=");
                printWriter.println(this.f51m);
                if (this.f52n != null) {
                    printWriter.print(str);
                    printWriter.println("Pending Loader ");
                    printWriter.print(this.f52n);
                    printWriter.println(":");
                    this = this.f52n;
                    str = str + "  ";
                } else {
                    return;
                }
            }
        }

        final void m43b() {
            C0013b c0013b;
            String str;
            C0011a c0011a = null;
            Object obj = null;
            while (true) {
                if (an.f54a) {
                    Log.v("LoaderManager", "  Destroying: " + c0013b);
                }
                c0013b.f50l = true;
                boolean z = c0013b.f44f;
                c0013b.f44f = obj;
                if (c0013b.f41c != null && c0013b.f42d != null && c0013b.f43e && z) {
                    if (an.f54a) {
                        Log.v("LoaderManager", "  Reseting: " + c0013b);
                    }
                    if (c0013b.f53o.f60g != null) {
                        String str2 = c0013b.f53o.f60g.f254d.f293u;
                        c0013b.f53o.f60g.f254d.f293u = "onLoaderReset";
                        str = str2;
                    } else {
                        Object obj2 = c0011a;
                    }
                    try {
                        C0011a c0011a2 = c0013b.f41c;
                        as asVar = c0013b.f42d;
                    } finally {
                        c0011a = c0013b.f53o.f60g;
                        if (c0011a != null) {
                            c0011a = c0013b.f53o.f60g.f254d;
                            c0011a.f293u = str;
                        }
                    }
                }
                c0013b.f41c = c0011a;
                c0013b.f45g = c0011a;
                c0013b.f43e = obj;
                if (c0013b.f42d != null) {
                    if (c0013b.f51m) {
                        c0013b.f51m = obj;
                        c0013b.f42d.m65a(c0013b);
                        c0013b.f42d.m68b(c0013b);
                    }
                    c0013b.f42d.m69c();
                }
                if (c0013b.f52n != null) {
                    c0013b = c0013b.f52n;
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
            stringBuilder.append(this.f39a);
            stringBuilder.append(" : ");
            ay.m113a(this.f42d, stringBuilder);
            stringBuilder.append("}}");
            return stringBuilder.toString();
        }
    }

    an(String str, C0065u c0065u, boolean z) {
        this.f57d = str;
        this.f60g = c0065u;
        this.f58e = z;
    }

    final void m45a(C0065u c0065u) {
        this.f60g = c0065u;
    }

    public final void m46a(String str, PrintWriter printWriter) {
        int i = 0;
        if (this.f55b.m117a() > 0) {
            printWriter.print(str);
            printWriter.println("Active Loaders:");
            String str2 = str + "    ";
            for (int i2 = 0; i2 < this.f55b.m117a(); i2++) {
                C0014a c0014a = (C0014a) this.f55b.m119b(i2);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(this.f55b.m118a(i2));
                printWriter.print(": ");
                printWriter.println(c0014a.toString());
                c0014a.m42a(str2, printWriter);
            }
        }
        if (this.f56c.m117a() > 0) {
            printWriter.print(str);
            printWriter.println("Inactive Loaders:");
            String str3 = str + "    ";
            while (i < this.f56c.m117a()) {
                c0014a = (C0014a) this.f56c.m119b(i);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(this.f56c.m118a(i));
                printWriter.print(": ");
                printWriter.println(c0014a.toString());
                c0014a.m42a(str3, printWriter);
                i++;
            }
        }
    }

    public final boolean mo7a() {
        int a = this.f55b.m117a();
        boolean z = false;
        for (int i = 0; i < a; i++) {
            C0014a c0014a = (C0014a) this.f55b.m119b(i);
            int i2 = (!c0014a.f46h || c0014a.f44f) ? 0 : 1;
            z |= i2;
        }
        return z;
    }

    final void m48b() {
        if (f54a) {
            Log.v("LoaderManager", "Starting in " + this);
        }
        if (this.f58e) {
            Throwable runtimeException = new RuntimeException("here");
            runtimeException.fillInStackTrace();
            Log.w("LoaderManager", "Called doStart when already started: " + this, runtimeException);
            return;
        }
        this.f58e = true;
        for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
            C0012a c0012a = (C0014a) this.f55b.m119b(a);
            if (c0012a.f47i && c0012a.f48j) {
                c0012a.f46h = true;
            } else if (c0012a.f46h) {
                continue;
            } else {
                c0012a.f46h = true;
                if (f54a) {
                    Log.v("LoaderManager", "  Starting: " + c0012a);
                }
                if (c0012a.f42d == null && c0012a.f41c != null) {
                    C0011a c0011a = c0012a.f41c;
                    int i = c0012a.f39a;
                    Bundle bundle = c0012a.f40b;
                    c0012a.f42d = c0011a.m38a();
                }
                if (c0012a.f42d == null) {
                    continue;
                } else if (!c0012a.f42d.getClass().isMemberClass() || Modifier.isStatic(c0012a.f42d.getClass().getModifiers())) {
                    if (!c0012a.f51m) {
                        c0012a.f42d.m63a(c0012a.f39a, (C0013b) c0012a);
                        c0012a.f42d.m64a(c0012a);
                        c0012a.f51m = true;
                    }
                    c0012a.f42d.m62a();
                } else {
                    throw new IllegalArgumentException("Object returned from onCreateLoader must not be a non-static inner member class: " + c0012a.f42d);
                }
            }
        }
    }

    final void m49c() {
        if (f54a) {
            Log.v("LoaderManager", "Stopping in " + this);
        }
        if (this.f58e) {
            for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
                ((C0014a) this.f55b.m119b(a)).m40a();
            }
            this.f58e = false;
            return;
        }
        Throwable runtimeException = new RuntimeException("here");
        runtimeException.fillInStackTrace();
        Log.w("LoaderManager", "Called doStop when not started: " + this, runtimeException);
    }

    final void m50d() {
        if (f54a) {
            Log.v("LoaderManager", "Retaining in " + this);
        }
        if (this.f58e) {
            this.f59f = true;
            this.f58e = false;
            for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
                C0014a c0014a = (C0014a) this.f55b.m119b(a);
                if (f54a) {
                    Log.v("LoaderManager", "  Retaining: " + c0014a);
                }
                c0014a.f47i = true;
                c0014a.f48j = c0014a.f46h;
                c0014a.f46h = false;
                c0014a.f41c = null;
            }
            return;
        }
        Throwable runtimeException = new RuntimeException("here");
        runtimeException.fillInStackTrace();
        Log.w("LoaderManager", "Called doRetain when not started: " + this, runtimeException);
    }

    final void m51e() {
        if (this.f59f) {
            if (f54a) {
                Log.v("LoaderManager", "Finished Retaining in " + this);
            }
            this.f59f = false;
            for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
                C0014a c0014a = (C0014a) this.f55b.m119b(a);
                if (c0014a.f47i) {
                    if (f54a) {
                        Log.v("LoaderManager", "  Finished Retaining: " + c0014a);
                    }
                    c0014a.f47i = false;
                    if (!(c0014a.f46h == c0014a.f48j || c0014a.f46h)) {
                        c0014a.m40a();
                    }
                }
                if (c0014a.f46h && c0014a.f43e && !c0014a.f49k) {
                    c0014a.m41a(c0014a.f42d, c0014a.f45g);
                }
            }
        }
    }

    final void m52f() {
        for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
            ((C0014a) this.f55b.m119b(a)).f49k = true;
        }
    }

    final void m53g() {
        for (int a = this.f55b.m117a() - 1; a >= 0; a--) {
            C0014a c0014a = (C0014a) this.f55b.m119b(a);
            if (c0014a.f46h && c0014a.f49k) {
                c0014a.f49k = false;
                if (c0014a.f43e) {
                    c0014a.m41a(c0014a.f42d, c0014a.f45g);
                }
            }
        }
    }

    final void m54h() {
        int a;
        if (!this.f59f) {
            if (f54a) {
                Log.v("LoaderManager", "Destroying Active in " + this);
            }
            for (a = this.f55b.m117a() - 1; a >= 0; a--) {
                ((C0014a) this.f55b.m119b(a)).m43b();
            }
            this.f55b.m120b();
        }
        if (f54a) {
            Log.v("LoaderManager", "Destroying Inactive in " + this);
        }
        for (a = this.f56c.m117a() - 1; a >= 0; a--) {
            ((C0014a) this.f56c.m119b(a)).m43b();
        }
        this.f56c.m120b();
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append("LoaderManager{");
        stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
        stringBuilder.append(" in ");
        ay.m113a(this.f60g, stringBuilder);
        stringBuilder.append("}}");
        return stringBuilder.toString();
    }
}
