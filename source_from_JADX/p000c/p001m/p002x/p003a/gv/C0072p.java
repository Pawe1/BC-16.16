package p000c.p001m.p002x.p003a.gv;

import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

final class C0072p {
    private static Method f296a;
    private static boolean f297b;

    public static void m297a(Bundle bundle, String str) {
        if (!f297b) {
            try {
                Method method = Bundle.class.getMethod("putIBinder", new Class[]{String.class, IBinder.class});
                f296a = method;
                method.setAccessible(true);
            } catch (Throwable e) {
                Throwable e2;
                Log.i("BundleCompatDonut", "Failed to retrieve putIBinder method", e2);
            }
            f297b = true;
        }
        if (f296a != null) {
            try {
                f296a.invoke(bundle, new Object[]{str, null});
                return;
            } catch (InvocationTargetException e3) {
                e2 = e3;
            } catch (IllegalAccessException e4) {
                e2 = e4;
            } catch (IllegalArgumentException e5) {
                e2 = e5;
            }
        } else {
            return;
        }
        Log.i("BundleCompatDonut", "Failed to invoke putIBinder via reflection", e2);
        f296a = null;
    }
}
