package p000c.p001m.p002x.p003a.gv;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import p000c.p001m.p002x.p003a.gv.ba.C0019b;
import p000c.p001m.p002x.p003a.gv.ba.C0020c;
import p000c.p001m.p002x.p003a.gv.ba.C0022e;

public class av<K, V> extends bb<K, V> implements Map<K, V> {
    ba<K, V> f91a;

    private ba<K, V> m86a() {
        if (this.f91a == null) {
            this.f91a = new aw(this);
        }
        return this.f91a;
    }

    public final boolean m87a(Collection<?> collection) {
        return ba.m88a((Map) this, (Collection) collection);
    }

    public Set<Entry<K, V>> entrySet() {
        ba a = m86a();
        if (a.f92b == null) {
            a.f92b = new C0019b(a);
        }
        return a.f92b;
    }

    public Set<K> keySet() {
        ba a = m86a();
        if (a.f93c == null) {
            a.f93c = new C0020c(a);
        }
        return a.f93c;
    }

    public void putAll(Map<? extends K, ? extends V> map) {
        m81a(this.h + map.size());
        for (Entry entry : map.entrySet()) {
            put(entry.getKey(), entry.getValue());
        }
    }

    public Collection<V> values() {
        ba a = m86a();
        if (a.f94d == null) {
            a.f94d = new C0022e(a);
        }
        return a.f94d;
    }
}
