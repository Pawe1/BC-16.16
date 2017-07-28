package p000c.p001m.p002x.p003a.gv;

import java.util.Map;

final class bb extends bf<K, V> {
    final /* synthetic */ ba f141a;

    bb(ba baVar) {
        this.f141a = baVar;
    }

    protected final int mo31a() {
        return this.f141a.h;
    }

    protected final int mo32a(Object obj) {
        return this.f141a.m134a(obj);
    }

    protected final Object mo33a(int i, int i2) {
        return this.f141a.g[(i << 1) + i2];
    }

    protected final V mo34a(int i, V v) {
        return this.f141a.m135a(i, (Object) v);
    }

    protected final void mo35a(int i) {
        this.f141a.m140d(i);
    }

    protected final void mo36a(K k, V v) {
        this.f141a.put(k, v);
    }

    protected final int mo37b(Object obj) {
        return this.f141a.m137b(obj);
    }

    protected final Map<K, V> mo38b() {
        return this.f141a;
    }

    protected final void mo39c() {
        this.f141a.clear();
    }
}
