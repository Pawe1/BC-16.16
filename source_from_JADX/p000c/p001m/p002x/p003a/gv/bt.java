package p000c.p001m.p002x.p003a.gv;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;

public final class bt<TResult> {
    public static final ExecutorService f191a = bq.m206a();
    public static final Executor f192b = bn.m203b();
    private static final Executor f193c = bq.m207b();
    private final Object f194d = new Object();
    private boolean f195e;
    private boolean f196f;
    private TResult f197g;
    private Exception f198h;
    private List<bs<TResult, Void>> f199i = new ArrayList();

    public class C0051a {
        final /* synthetic */ bt f190a;

        private C0051a(bt btVar) {
            this.f190a = btVar;
        }

        private boolean m209b(Exception exception) {
            boolean z;
            synchronized (this.f190a.f194d) {
                if (this.f190a.f195e) {
                    z = false;
                } else {
                    this.f190a.f195e = true;
                    this.f190a.f198h = exception;
                    this.f190a.f194d.notifyAll();
                    bt.m231e(this.f190a);
                    z = true;
                }
            }
            return z;
        }

        private boolean m210b(TResult tResult) {
            boolean z;
            synchronized (this.f190a.f194d) {
                if (this.f190a.f195e) {
                    z = false;
                } else {
                    this.f190a.f195e = true;
                    this.f190a.f197g = tResult;
                    this.f190a.f194d.notifyAll();
                    bt.m231e(this.f190a);
                    z = true;
                }
            }
            return z;
        }

        private boolean m211c() {
            boolean z;
            synchronized (this.f190a.f194d) {
                if (this.f190a.f195e) {
                    z = false;
                } else {
                    this.f190a.f195e = true;
                    this.f190a.f196f = true;
                    this.f190a.f194d.notifyAll();
                    bt.m231e(this.f190a);
                    z = true;
                }
            }
            return z;
        }

        public final bt<TResult> m212a() {
            return this.f190a;
        }

        public final void m213a(Exception exception) {
            if (!m209b(exception)) {
                throw new IllegalStateException("Cannot set the error on a completed task.");
            }
        }

        public final void m214a(TResult tResult) {
            if (!m210b((Object) tResult)) {
                throw new IllegalStateException("Cannot set the result of a completed task.");
            }
        }

        public final void m215b() {
            if (!m211c()) {
                throw new IllegalStateException("Cannot cancel a completed task.");
            }
        }
    }

    private bt() {
    }

    public static <TResult> C0051a m216a() {
        bt btVar = new bt();
        btVar.getClass();
        return new C0051a();
    }

    private <TContinuationResult> bt<TContinuationResult> m217a(bs<TResult, TContinuationResult> bsVar, Executor executor) {
        C0051a a = bt.m216a();
        synchronized (this.f194d) {
            boolean g = m233g();
            if (!g) {
                this.f199i.add(new bz(this, a, bsVar, executor));
            }
        }
        if (g) {
            bt.m227c(a, bsVar, this, executor, null);
        }
        return a.f190a;
    }

    public static <TResult> bt<TResult> m218a(Exception exception) {
        C0051a a = bt.m216a();
        a.m213a(exception);
        return a.f190a;
    }

    public static <TResult> bt<TResult> m219a(TResult tResult) {
        C0051a a = bt.m216a();
        a.m214a((Object) tResult);
        return a.f190a;
    }

    private <TContinuationResult> bt<TContinuationResult> m224b(bs<TResult, bt<TContinuationResult>> bsVar, Executor executor) {
        C0051a a = bt.m216a();
        synchronized (this.f194d) {
            boolean g = m233g();
            if (!g) {
                this.f199i.add(new bu(this, a, bsVar, executor));
            }
        }
        if (g) {
            bt.m229d(a, bsVar, this, executor, null);
        }
        return a.f190a;
    }

    private static <TContinuationResult, TResult> void m227c(C0051a c0051a, bs<TResult, TContinuationResult> bsVar, bt<TResult> btVar, Executor executor, br brVar) {
        executor.execute(new bw(brVar, c0051a, bsVar, btVar));
    }

    private static <TContinuationResult, TResult> void m229d(C0051a c0051a, bs<TResult, bt<TContinuationResult>> bsVar, bt<TResult> btVar, Executor executor, br brVar) {
        executor.execute(new bx(brVar, c0051a, bsVar, btVar));
    }

    static /* synthetic */ void m231e(bt btVar) {
        synchronized (btVar.f194d) {
            for (bs then : btVar.f199i) {
                try {
                    then.then(btVar);
                } catch (RuntimeException e) {
                    throw e;
                } catch (Throwable e2) {
                    throw new RuntimeException(e2);
                }
            }
            btVar.f199i = null;
        }
        return;
    }

    public static <TResult> bt<TResult> m232f() {
        C0051a a = bt.m216a();
        a.m215b();
        return a.f190a;
    }

    private boolean m233g() {
        boolean z;
        synchronized (this.f194d) {
            z = this.f195e;
        }
        return z;
    }

    public final <TContinuationResult> bt<TContinuationResult> m234a(bs<TResult, TContinuationResult> bsVar) {
        return m217a((bs) bsVar, f193c);
    }

    public final <TContinuationResult> bt<TContinuationResult> m235b(bs<TResult, TContinuationResult> bsVar) {
        return m224b(new bv(this, bsVar), f193c);
    }

    public final boolean m236b() {
        boolean z;
        synchronized (this.f194d) {
            z = this.f196f;
        }
        return z;
    }

    public final boolean m237c() {
        boolean z;
        synchronized (this.f194d) {
            z = this.f198h != null;
        }
        return z;
    }

    public final TResult m238d() {
        TResult tResult;
        synchronized (this.f194d) {
            tResult = this.f197g;
        }
        return tResult;
    }

    public final Exception m239e() {
        Exception exception;
        synchronized (this.f194d) {
            exception = this.f198h;
        }
        return exception;
    }
}
