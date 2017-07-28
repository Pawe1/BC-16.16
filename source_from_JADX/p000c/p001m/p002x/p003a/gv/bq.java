package p000c.p001m.p002x.p003a.gv;

import java.util.Locale;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

final class bq {
    private static final bq f184a = new bq();
    private final ExecutorService f185b;
    private final ScheduledExecutorService f186c;
    private final Executor f187d;

    private static class C0050a implements Executor {
        private ThreadLocal<Integer> f183a;

        private C0050a() {
            this.f183a = new ThreadLocal();
        }

        private int m205a() {
            Integer num = (Integer) this.f183a.get();
            if (num == null) {
                num = Integer.valueOf(0);
            }
            int intValue = num.intValue() - 1;
            if (intValue == 0) {
                this.f183a.remove();
            } else {
                this.f183a.set(Integer.valueOf(intValue));
            }
            return intValue;
        }

        public final void execute(Runnable runnable) {
            Integer num = (Integer) this.f183a.get();
            if (num == null) {
                num = Integer.valueOf(0);
            }
            int intValue = num.intValue() + 1;
            this.f183a.set(Integer.valueOf(intValue));
            if (intValue <= 15) {
                try {
                    runnable.run();
                } catch (Throwable th) {
                    m205a();
                }
            } else {
                bq.m206a().execute(runnable);
            }
            m205a();
        }
    }

    private bq() {
        String property = System.getProperty("java.runtime.name");
        this.f185b = !(property == null ? false : property.toLowerCase(Locale.US).contains("android")) ? Executors.newCachedThreadPool() : bn.m202a();
        this.f186c = Executors.newSingleThreadScheduledExecutor();
        this.f187d = new C0050a();
    }

    public static ExecutorService m206a() {
        return f184a.f185b;
    }

    static Executor m207b() {
        return f184a.f187d;
    }
}
