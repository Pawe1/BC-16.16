package p000c.p001m.p002x.p003a.gv;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;

public final class bo<TResult> {
    public static final ExecutorService f148a = bl.m148a();
    public static final Executor f149b = bi.m145b();
    private static final Executor f150c = bl.m149b();
    private final Object f151d = new Object();
    private boolean f152e;
    private boolean f153f;
    private TResult f154g;
    private Exception f155h;
    private List<bn<TResult, Void>> f156i = new ArrayList();

    public class C0043a {
        final /* synthetic */ bo f147a;

        private C0043a(bo boVar) {
            this.f147a = boVar;
        }

        private boolean m151b(Exception exception) {
            boolean z;
            synchronized (this.f147a.f151d) {
                if (this.f147a.f152e) {
                    z = false;
                } else {
                    this.f147a.f152e = true;
                    this.f147a.f155h = exception;
                    this.f147a.f151d.notifyAll();
                    bo.m173e(this.f147a);
                    z = true;
                }
            }
            return z;
        }

        private boolean m152b(TResult tResult) {
            boolean z;
            synchronized (this.f147a.f151d) {
                if (this.f147a.f152e) {
                    z = false;
                } else {
                    this.f147a.f152e = true;
                    this.f147a.f154g = tResult;
                    this.f147a.f151d.notifyAll();
                    bo.m173e(this.f147a);
                    z = true;
                }
            }
            return z;
        }

        private boolean m153c() {
            boolean z;
            synchronized (this.f147a.f151d) {
                if (this.f147a.f152e) {
                    z = false;
                } else {
                    this.f147a.f152e = true;
                    this.f147a.f153f = true;
                    this.f147a.f151d.notifyAll();
                    bo.m173e(this.f147a);
                    z = true;
                }
            }
            return z;
        }

        public final bo<TResult> m154a() {
            return this.f147a;
        }

        public final void m155a(Exception exception) {
            if (!m151b(exception)) {
                throw new IllegalStateException("Cannot set the error on a completed task.");
            }
        }

        public final void m156a(TResult tResult) {
            if (!m152b((Object) tResult)) {
                throw new IllegalStateException("Cannot set the result of a completed task.");
            }
        }

        public final void m157b() {
            if (!m153c()) {
                throw new IllegalStateException("Cannot cancel a completed task.");
            }
        }
    }

    private bo() {
    }

    public static <TResult> C0043a m158a() {
        bo boVar = new bo();
        boVar.getClass();
        return new C0043a();
    }

    private <TContinuationResult> bo<TContinuationResult> m159a(bn<TResult, TContinuationResult> bnVar, Executor executor) {
        C0043a a = bo.m158a();
        synchronized (this.f151d) {
            boolean g = m175g();
            if (!g) {
                this.f156i.add(new bu(this, a, bnVar, executor));
            }
        }
        if (g) {
            bo.m169c(a, bnVar, this, executor, null);
        }
        return a.f147a;
    }

    public static <TResult> bo<TResult> m160a(Exception exception) {
        C0043a a = bo.m158a();
        a.m155a(exception);
        return a.f147a;
    }

    public static <TResult> bo<TResult> m161a(TResult tResult) {
        C0043a a = bo.m158a();
        a.m156a((Object) tResult);
        return a.f147a;
    }

    private <TContinuationResult> bo<TContinuationResult> m166b(bn<TResult, bo<TContinuationResult>> bnVar, Executor executor) {
        C0043a a = bo.m158a();
        synchronized (this.f151d) {
            boolean g = m175g();
            if (!g) {
                this.f156i.add(new bp(this, a, bnVar, executor));
            }
        }
        if (g) {
            bo.m171d(a, bnVar, this, executor, null);
        }
        return a.f147a;
    }

    private static <TContinuationResult, TResult> void m169c(C0043a c0043a, bn<TResult, TContinuationResult> bnVar, bo<TResult> boVar, Executor executor, bm bmVar) {
        executor.execute(new br(bmVar, c0043a, bnVar, boVar));
    }

    private static <TContinuationResult, TResult> void m171d(C0043a c0043a, bn<TResult, bo<TContinuationResult>> bnVar, bo<TResult> boVar, Executor executor, bm bmVar) {
        executor.execute(new bs(bmVar, c0043a, bnVar, boVar));
    }

    static /* synthetic */ void m173e(bo boVar) {
        synchronized (boVar.f151d) {
            for (bn then : boVar.f156i) {
                try {
                    then.then(boVar);
                } catch (RuntimeException e) {
                    throw e;
                } catch (Throwable e2) {
                    throw new RuntimeException(e2);
                }
            }
            boVar.f156i = null;
        }
        return;
    }

    public static <TResult> bo<TResult> m174f() {
        C0043a a = bo.m158a();
        a.m157b();
        return a.f147a;
    }

    private boolean m175g() {
        boolean z;
        synchronized (this.f151d) {
            z = this.f152e;
        }
        return z;
    }

    public final <TContinuationResult> bo<TContinuationResult> m176a(bn<TResult, TContinuationResult> bnVar) {
        return m159a((bn) bnVar, f150c);
    }

    public final <TContinuationResult> bo<TContinuationResult> m177b(bn<TResult, TContinuationResult> bnVar) {
        return m166b(new bq(this, bnVar), f150c);
    }

    public final boolean m178b() {
        boolean z;
        synchronized (this.f151d) {
            z = this.f153f;
        }
        return z;
    }

    public final boolean m179c() {
        boolean z;
        synchronized (this.f151d) {
            z = this.f155h != null;
        }
        return z;
    }

    public final TResult m180d() {
        TResult tResult;
        synchronized (this.f151d) {
            tResult = this.f154g;
        }
        return tResult;
    }

    public final Exception m181e() {
        Exception exception;
        synchronized (this.f151d) {
            exception = this.f155h;
        }
        return exception;
    }
}
