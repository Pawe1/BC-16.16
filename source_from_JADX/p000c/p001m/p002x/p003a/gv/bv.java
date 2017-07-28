package p000c.p001m.p002x.p003a.gv;

import android.util.Log;
import com.adobe.fre.FREContext;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public final class bv {
    private static String f179c = "[MMGAPA]";
    FREContext f180a;
    by f181b;

    public bv(FREContext fREContext) {
        this.f180a = fREContext;
    }

    public final void m182a(by byVar) {
        this.f181b = byVar;
        try {
            Field declaredField = this.f180a.getActivity().getClass().getDeclaredField("sAndroidActivityWrapper");
            declaredField.setAccessible(true);
            Object obj = declaredField.get(null);
            if (obj == null) {
                obj = null;
            }
            if (obj == null) {
                Log.e(f179c, "Could not discover AIR container.");
                return;
            }
            try {
                Class[] declaredClasses = obj.getClass().getDeclaredClasses();
                for (int i = 0; i < declaredClasses.length; i++) {
                    Object newProxyInstance;
                    Method[] methods;
                    int i2;
                    if (declaredClasses[i].getName().contains("ActivityResultCallback")) {
                        newProxyInstance = Proxy.newProxyInstance(declaredClasses[i].getClassLoader(), new Class[]{declaredClasses[i]}, new bw(this, byVar));
                        methods = obj.getClass().getMethods();
                        for (i2 = 0; i2 < methods.length; i2++) {
                            if (methods[i2].getName().contains("addActivityResultListener")) {
                                methods[i2].invoke(obj, new Object[]{newProxyInstance});
                            }
                        }
                    } else if (declaredClasses[i].getName().contains("StateChangeCallback")) {
                        newProxyInstance = Proxy.newProxyInstance(declaredClasses[i].getClassLoader(), new Class[]{declaredClasses[i]}, new bx(this, byVar));
                        methods = obj.getClass().getMethods();
                        for (i2 = 0; i2 < methods.length; i2++) {
                            if (methods[i2].getName().contains("addActivityStateChangeListner")) {
                                methods[i2].invoke(obj, new Object[]{newProxyInstance});
                            }
                        }
                    }
                }
            } catch (InvocationTargetException e) {
                Log.e(f179c, "Invocation target exception.");
            } catch (Exception e2) {
                Log.e(f179c, "Failed to get the statechange class.");
            }
        } catch (Exception e3) {
            Log.e(f179c, "Exception hooking AIR container.");
            e3.printStackTrace();
        }
    }
}
