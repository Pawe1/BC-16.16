package p000c.p001m.p002x.p003a.gv;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

final class bx implements InvocationHandler {
    final /* synthetic */ by f184a;
    final /* synthetic */ bv f185b;

    bx(bv bvVar, by byVar) {
        this.f185b = bvVar;
        this.f184a = byVar;
    }

    public final Object invoke(Object obj, Method method, Object[] objArr) {
        String name = method.getName();
        by byVar;
        if (name.equals("onActivityStateChanged")) {
            name = objArr[0].toString();
            if (name.equals("STARTED")) {
                this.f184a.mo285a();
            } else if (name.equals("RESTARTED")) {
                byVar = this.f184a;
            } else if (name.equals("RESUMED")) {
                this.f184a.mo287b();
            } else if (name.equals("PAUSED")) {
                byVar = this.f184a;
            } else if (name.equals("STOPPED")) {
                byVar = this.f184a;
            } else if (name.equals("DESTROYED")) {
                this.f184a.mo288c();
            }
        } else if (name.equals("onConfigurationChanged")) {
            byVar = this.f184a;
        } else if (name.equals("equals")) {
            bx bxVar = objArr[0];
            return bxVar == null ? Boolean.valueOf(false) : bxVar == this ? Boolean.valueOf(true) : Boolean.valueOf(false);
        }
        return null;
    }
}
