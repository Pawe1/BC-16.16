package p000c.p001m.p002x.p003a.gv;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

final class cc implements InvocationHandler {
    final /* synthetic */ cd f228a;
    final /* synthetic */ ca f229b;

    cc(ca caVar, cd cdVar) {
        this.f229b = caVar;
        this.f228a = cdVar;
    }

    public final Object invoke(Object obj, Method method, Object[] objArr) {
        String name = method.getName();
        cd cdVar;
        if (name.equals("onActivityStateChanged")) {
            name = objArr[0].toString();
            if (name.equals("STARTED")) {
                this.f228a.mo323a();
            } else if (name.equals("RESTARTED")) {
                cdVar = this.f228a;
            } else if (name.equals("RESUMED")) {
                this.f228a.mo325b();
            } else if (name.equals("PAUSED")) {
                cdVar = this.f228a;
            } else if (name.equals("STOPPED")) {
                cdVar = this.f228a;
            } else if (name.equals("DESTROYED")) {
                this.f228a.mo326c();
            }
        } else if (name.equals("onConfigurationChanged")) {
            cdVar = this.f228a;
        } else if (name.equals("equals")) {
            cc ccVar = objArr[0];
            return ccVar == null ? Boolean.valueOf(false) : ccVar == this ? Boolean.valueOf(true) : Boolean.valueOf(false);
        }
        return null;
    }
}
