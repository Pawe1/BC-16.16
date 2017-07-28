package p000c.p001m.p002x.p003a.gv;

import android.util.Log;
import com.adobe.fre.FREContext;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public final class ca {
    private static String f223c = "[MMGAPA]";
    FREContext f224a;
    cd f225b;

    public ca(FREContext fREContext) {
        this.f224a = fREContext;
    }

    public final void m257a(cd cdVar) {
        this.f225b = cdVar;
        try {
            Field declaredField = this.f224a.getActivity().getClass().getDeclaredField("sAndroidActivityWrapper");
            declaredField.setAccessible(true);
            Object obj = declaredField.get(null);
            if (obj == null) {
                obj = null;
            }
            if (obj == null) {
                Log.e(f223c, "Could not discover AIR container.");
                return;
            }
            try {
                Class[] declaredClasses = obj.getClass().getDeclaredClasses();
                for (int i = 0; i < declaredClasses.length; i++) {
                    Object newProxyInstance;
                    Method[] methods;
                    int i2;
                    if (declaredClasses[i].getName().contains("ActivityResultCallback")) {
                        newProxyInstance = Proxy.newProxyInstance(declaredClasses[i].getClassLoader(), new Class[]{declaredClasses[i]}, new cb(this, cdVar));
                        methods = obj.getClass().getMethods();
                        for (i2 = 0; i2 < methods.length; i2++) {
                            if (methods[i2].getName().contains("addActivityResultListener")) {
                                methods[i2].invoke(obj, new Object[]{newProxyInstance});
                            }
                        }
                    } else if (declaredClasses[i].getName().contains("StateChangeCallback")) {
                        newProxyInstance = Proxy.newProxyInstance(declaredClasses[i].getClassLoader(), new Class[]{declaredClasses[i]}, new cc(this, cdVar));
                        methods = obj.getClass().getMethods();
                        for (i2 = 0; i2 < methods.length; i2++) {
                            if (methods[i2].getName().contains("addActivityStateChangeListner")) {
                                methods[i2].invoke(obj, new Object[]{newProxyInstance});
                            }
                        }
                    }
                }
            } catch (InvocationTargetException e) {
                Log.e(f223c, "Invocation target exception.");
            } catch (Exception e2) {
                Log.e(f223c, "Failed to get the statechange class.");
            }
        } catch (Exception e3) {
            Log.e(f223c, "Exception hooking AIR container.");
            e3.printStackTrace();
        }
    }
}
