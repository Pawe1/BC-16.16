package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.os.Handler;
import android.os.Looper;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

final class bi {
    static final int f128a;
    static final int f129b = ((f131e * 2) + 1);
    private static final bi f130c = new bi();
    private static final int f131e;
    private final Executor f132d = new C0040a();

    private static class C0040a implements Executor {
        private C0040a() {
        }

        public final void execute(Runnable runnable) {
            new Handler(Looper.getMainLooper()).post(runnable);
        }
    }

    static {
        int availableProcessors = Runtime.getRuntime().availableProcessors();
        f131e = availableProcessors;
        f128a = availableProcessors + 1;
    }

    private bi() {
    }

    public static ExecutorService m144a() {
        ExecutorService threadPoolExecutor = new ThreadPoolExecutor(f128a, f129b, 1, TimeUnit.SECONDS, new LinkedBlockingQueue());
        if (VERSION.SDK_INT >= 9) {
            threadPoolExecutor.allowCoreThreadTimeOut(true);
        }
        return threadPoolExecutor;
    }

    public static Executor m145b() {
        return f130c.f132d;
    }
}
