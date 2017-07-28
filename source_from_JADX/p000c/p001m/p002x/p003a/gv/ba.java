package p000c.p001m.p002x.p003a.gv;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import p000c.p001m.p002x.p003a.gv.bf.C0025b;
import p000c.p001m.p002x.p003a.gv.bf.C0026c;
import p000c.p001m.p002x.p003a.gv.bf.C0028e;

public class ba<K, V> extends bg<K, V> implements Map<K, V> {
    bf<K, V> f137a;

    private bf<K, V> m141a() {
        if (this.f137a == null) {
            this.f137a = new bb(this);
        }
        return this.f137a;
    }

    public final boolean m142a(Collection<?> collection) {
        return bf.m143a((Map) this, (Collection) collection);
    }

    public Set<Entry<K, V>> entrySet() {
        bf a = m141a();
        if (a.f138b == null) {
            a.f138b = new C0025b(a);
        }
        return a.f138b;
    }

    public Set<K> keySet() {
        bf a = m141a();
        if (a.f139c == null) {
            a.f139c = new C0026c(a);
        }
        return a.f139c;
    }

    public void putAll(Map<? extends K, ? extends V> map) {
        m136a(this.h + map.size());
        for (Entry entry : map.entrySet()) {
            put(entry.getKey(), entry.getValue());
        }
    }

    public Collection<V> values() {
        bf a = m141a();
        if (a.f140d == null) {
            a.f140d = new C0028e(a);
        }
        return a.f140d;
    }
}
