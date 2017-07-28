package p000c.p001m.p002x.p003a.gv;

import java.util.Map;

final class aw extends ba<K, V> {
    final /* synthetic */ av f95a;

    aw(av avVar) {
        this.f95a = avVar;
    }

    protected final int mo8a() {
        return this.f95a.h;
    }

    protected final int mo9a(Object obj) {
        return this.f95a.m79a(obj);
    }

    protected final Object mo10a(int i, int i2) {
        return this.f95a.g[(i << 1) + i2];
    }

    protected final V mo11a(int i, V v) {
        return this.f95a.m80a(i, (Object) v);
    }

    protected final void mo12a(int i) {
        this.f95a.m85d(i);
    }

    protected final void mo13a(K k, V v) {
        this.f95a.put(k, v);
    }

    protected final int mo14b(Object obj) {
        return this.f95a.m82b(obj);
    }

    protected final Map<K, V> mo15b() {
        return this.f95a;
    }

    protected final void mo16c() {
        this.f95a.clear();
    }
}
