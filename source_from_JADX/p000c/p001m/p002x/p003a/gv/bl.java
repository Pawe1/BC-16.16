package p000c.p001m.p002x.p003a.gv;

import java.util.Locale;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

final class bl {
    private static final bl f141a = new bl();
    private final ExecutorService f142b;
    private final ScheduledExecutorService f143c;
    private final Executor f144d;

    private static class C0042a implements Executor {
        private ThreadLocal<Integer> f140a;

        private C0042a() {
            this.f140a = new ThreadLocal();
        }

        private int m147a() {
            Integer num = (Integer) this.f140a.get();
            if (num == null) {
                num = Integer.valueOf(0);
            }
            int intValue = num.intValue() - 1;
            if (intValue == 0) {
                this.f140a.remove();
            } else {
                this.f140a.set(Integer.valueOf(intValue));
            }
            return intValue;
        }

        public final void execute(Runnable runnable) {
            Integer num = (Integer) this.f140a.get();
            if (num == null) {
                num = Integer.valueOf(0);
            }
            int intValue = num.intValue() + 1;
            this.f140a.set(Integer.valueOf(intValue));
            if (intValue <= 15) {
                try {
                    runnable.run();
                } catch (Throwable th) {
                    m147a();
                }
            } else {
                bl.m148a().execute(runnable);
            }
            m147a();
        }
    }

    private bl() {
        String property = System.getProperty("java.runtime.name");
        this.f142b = !(property == null ? false : property.toLowerCase(Locale.US).contains("android")) ? Executors.newCachedThreadPool() : bi.m144a();
        this.f143c = Executors.newSingleThreadScheduledExecutor();
        this.f144d = new C0042a();
    }

    public static ExecutorService m148a() {
        return f141a.f142b;
    }

    static Executor m149b() {
        return f141a.f144d;
    }
}
