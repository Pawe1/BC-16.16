package p000c.p001m.p002x.p003a.gv;

import android.content.Intent;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

final class bw implements InvocationHandler {
    final /* synthetic */ by f182a;
    final /* synthetic */ bv f183b;

    bw(bv bvVar, by byVar) {
        this.f183b = bvVar;
        this.f182a = byVar;
    }

    public final Object invoke(Object obj, Method method, Object[] objArr) {
        String name = method.getName();
        if (name.equals("onActivityResult")) {
            this.f182a.mo286a(((Integer) objArr[0]).intValue(), ((Integer) objArr[1]).intValue(), (Intent) objArr[2]);
        } else if (name.equals("equals")) {
            bw bwVar = objArr[0];
            return bwVar == null ? Boolean.valueOf(false) : bwVar == this ? Boolean.valueOf(true) : Boolean.valueOf(false);
        }
        return null;
    }
}
