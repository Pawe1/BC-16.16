package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.os.Handler;
import android.os.Looper;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

final class bn {
    static final int f171a;
    static final int f172b = ((f174e * 2) + 1);
    private static final bn f173c = new bn();
    private static final int f174e;
    private final Executor f175d = new C0048a();

    private static class C0048a implements Executor {
        private C0048a() {
        }

        public final void execute(Runnable runnable) {
            new Handler(Looper.getMainLooper()).post(runnable);
        }
    }

    static {
        int availableProcessors = Runtime.getRuntime().availableProcessors();
        f174e = availableProcessors;
        f171a = availableProcessors + 1;
    }

    private bn() {
    }

    public static ExecutorService m202a() {
        ExecutorService threadPoolExecutor = new ThreadPoolExecutor(f171a, f172b, 1, TimeUnit.SECONDS, new LinkedBlockingQueue());
        if (VERSION.SDK_INT >= 9) {
            threadPoolExecutor.allowCoreThreadTimeOut(true);
        }
        return threadPoolExecutor;
    }

    public static Executor m203b() {
        return f173c.f175d;
    }
}
