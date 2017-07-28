package p000c.p001m.p002x.p003a.gv;

import android.content.Intent;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

final class cb implements InvocationHandler {
    final /* synthetic */ cd f226a;
    final /* synthetic */ ca f227b;

    cb(ca caVar, cd cdVar) {
        this.f227b = caVar;
        this.f226a = cdVar;
    }

    public final Object invoke(Object obj, Method method, Object[] objArr) {
        String name = method.getName();
        if (name.equals("onActivityResult")) {
            this.f226a.mo324a(((Integer) objArr[0]).intValue(), ((Integer) objArr[1]).intValue(), (Intent) objArr[2]);
        } else if (name.equals("equals")) {
            cb cbVar = objArr[0];
            return cbVar == null ? Boolean.valueOf(false) : cbVar == this ? Boolean.valueOf(true) : Boolean.valueOf(false);
        }
        return null;
    }
}
