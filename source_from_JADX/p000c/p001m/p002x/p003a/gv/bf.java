package p000c.p001m.p002x.p003a.gv;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

abstract class bf<K, V> {
    C0025b f138b;
    C0026c f139c;
    C0028e f140d;

    final class C0024a<T> implements Iterator<T> {
        final int f147a;
        int f148b;
        int f149c;
        boolean f150d = false;
        final /* synthetic */ bf f151e;

        C0024a(bf bfVar, int i) {
            this.f151e = bfVar;
            this.f147a = i;
            this.f148b = bfVar.mo31a();
        }

        public final boolean hasNext() {
            return this.f149c < this.f148b;
        }

        public final T next() {
            T a = this.f151e.mo33a(this.f149c, this.f147a);
            this.f149c++;
            this.f150d = true;
            return a;
        }

        public final void remove() {
            if (this.f150d) {
                this.f149c--;
                this.f148b--;
                this.f150d = false;
                this.f151e.mo35a(this.f149c);
                return;
            }
            throw new IllegalStateException();
        }
    }

    final class C0025b implements Set<Entry<K, V>> {
        final /* synthetic */ bf f152a;

        C0025b(bf bfVar) {
            this.f152a = bfVar;
        }

        public final /* synthetic */ boolean add(Object obj) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends Entry<K, V>> collection) {
            int a = this.f152a.mo31a();
            for (Entry entry : collection) {
                this.f152a.mo36a(entry.getKey(), entry.getValue());
            }
            return a != this.f152a.mo31a();
        }

        public final void clear() {
            this.f152a.mo39c();
        }

        public final boolean contains(Object obj) {
            if (!(obj instanceof Entry)) {
                return false;
            }
            Entry entry = (Entry) obj;
            int a = this.f152a.mo32a(entry.getKey());
            return a >= 0 ? bc.m167a(this.f152a.mo33a(a, 1), entry.getValue()) : false;
        }

        public final boolean containsAll(Collection<?> collection) {
            for (Object contains : collection) {
                if (!contains(contains)) {
                    return false;
                }
            }
            return true;
        }

        public final boolean equals(Object obj) {
            return bf.m144a((Set) this, obj);
        }

        public final int hashCode() {
            int a = this.f152a.mo31a() - 1;
            int i = 0;
            while (a >= 0) {
                Object a2 = this.f152a.mo33a(a, 0);
                Object a3 = this.f152a.mo33a(a, 1);
                a--;
                i += (a3 == null ? 0 : a3.hashCode()) ^ (a2 == null ? 0 : a2.hashCode());
            }
            return i;
        }

        public final boolean isEmpty() {
            return this.f152a.mo31a() == 0;
        }

        public final Iterator<Entry<K, V>> iterator() {
            return new C0027d(this.f152a);
        }

        public final boolean remove(Object obj) {
            throw new UnsupportedOperationException();
        }

        public final boolean removeAll(Collection<?> collection) {
            throw new UnsupportedOperationException();
        }

        public final boolean retainAll(Collection<?> collection) {
            throw new UnsupportedOperationException();
        }

        public final int size() {
            return this.f152a.mo31a();
        }

        public final Object[] toArray() {
            throw new UnsupportedOperationException();
        }

        public final <T> T[] toArray(T[] tArr) {
            throw new UnsupportedOperationException();
        }
    }

    final class C0026c implements Set<K> {
        final /* synthetic */ bf f153a;

        C0026c(bf bfVar) {
            this.f153a = bfVar;
        }

        public final boolean add(K k) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends K> collection) {
            throw new UnsupportedOperationException();
        }

        public final void clear() {
            this.f153a.mo39c();
        }

        public final boolean contains(Object obj) {
            return this.f153a.mo32a(obj) >= 0;
        }

        public final boolean containsAll(Collection<?> collection) {
            Map b = this.f153a.mo38b();
            for (Object containsKey : collection) {
                if (!b.containsKey(containsKey)) {
                    return false;
                }
            }
            return true;
        }

        public final boolean equals(Object obj) {
            return bf.m144a((Set) this, obj);
        }

        public final int hashCode() {
            int i = 0;
            for (int a = this.f153a.mo31a() - 1; a >= 0; a--) {
                Object a2 = this.f153a.mo33a(a, 0);
                i += a2 == null ? 0 : a2.hashCode();
            }
            return i;
        }

        public final boolean isEmpty() {
            return this.f153a.mo31a() == 0;
        }

        public final Iterator<K> iterator() {
            return new C0024a(this.f153a, 0);
        }

        public final boolean remove(Object obj) {
            int a = this.f153a.mo32a(obj);
            if (a < 0) {
                return false;
            }
            this.f153a.mo35a(a);
            return true;
        }

        public final boolean removeAll(Collection<?> collection) {
            Map b = this.f153a.mo38b();
            int size = b.size();
            for (Object remove : collection) {
                b.remove(remove);
            }
            return size != b.size();
        }

        public final boolean retainAll(Collection<?> collection) {
            return bf.m143a(this.f153a.mo38b(), (Collection) collection);
        }

        public final int size() {
            return this.f153a.mo31a();
        }

        public final Object[] toArray() {
            return this.f153a.m154b(0);
        }

        public final <T> T[] toArray(T[] tArr) {
            return this.f153a.m151a((Object[]) tArr, 0);
        }
    }

    final class C0027d implements Iterator<Entry<K, V>>, Entry<K, V> {
        int f154a;
        int f155b;
        boolean f156c = false;
        final /* synthetic */ bf f157d;

        C0027d(bf bfVar) {
            this.f157d = bfVar;
            this.f154a = bfVar.mo31a() - 1;
            this.f155b = -1;
        }

        public final boolean equals(Object obj) {
            if (!this.f156c) {
                throw new IllegalStateException("This container does not support retaining Map.Entry objects");
            } else if (!(obj instanceof Entry)) {
                return false;
            } else {
                Entry entry = (Entry) obj;
                return bc.m167a(entry.getKey(), this.f157d.mo33a(this.f155b, 0)) && bc.m167a(entry.getValue(), this.f157d.mo33a(this.f155b, 1));
            }
        }

        public final K getKey() {
            if (this.f156c) {
                return this.f157d.mo33a(this.f155b, 0);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final V getValue() {
            if (this.f156c) {
                return this.f157d.mo33a(this.f155b, 1);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final boolean hasNext() {
            return this.f155b < this.f154a;
        }

        public final int hashCode() {
            int i = 0;
            if (this.f156c) {
                Object a = this.f157d.mo33a(this.f155b, 0);
                Object a2 = this.f157d.mo33a(this.f155b, 1);
                int hashCode = a == null ? 0 : a.hashCode();
                if (a2 != null) {
                    i = a2.hashCode();
                }
                return i ^ hashCode;
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final /* bridge */ /* synthetic */ Object next() {
            this.f155b++;
            this.f156c = true;
            return this;
        }

        public final void remove() {
            if (this.f156c) {
                this.f157d.mo35a(this.f155b);
                this.f155b--;
                this.f154a--;
                this.f156c = false;
                return;
            }
            throw new IllegalStateException();
        }

        public final V setValue(V v) {
            if (this.f156c) {
                return this.f157d.mo34a(this.f155b, (Object) v);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final String toString() {
            return getKey() + "=" + getValue();
        }
    }

    final class C0028e implements Collection<V> {
        final /* synthetic */ bf f158a;

        C0028e(bf bfVar) {
            this.f158a = bfVar;
        }

        public final boolean add(V v) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends V> collection) {
            throw new UnsupportedOperationException();
        }

        public final void clear() {
            this.f158a.mo39c();
        }

        public final boolean contains(Object obj) {
            return this.f158a.mo37b(obj) >= 0;
        }

        public final boolean containsAll(Collection<?> collection) {
            for (Object contains : collection) {
                if (!contains(contains)) {
                    return false;
                }
            }
            return true;
        }

        public final boolean isEmpty() {
            return this.f158a.mo31a() == 0;
        }

        public final Iterator<V> iterator() {
            return new C0024a(this.f158a, 1);
        }

        public final boolean remove(Object obj) {
            int b = this.f158a.mo37b(obj);
            if (b < 0) {
                return false;
            }
            this.f158a.mo35a(b);
            return true;
        }

        public final boolean removeAll(Collection<?> collection) {
            int i = 0;
            int a = this.f158a.mo31a();
            boolean z = false;
            while (i < a) {
                if (collection.contains(this.f158a.mo33a(i, 1))) {
                    this.f158a.mo35a(i);
                    i--;
                    a--;
                    z = true;
                }
                i++;
            }
            return z;
        }

        public final boolean retainAll(Collection<?> collection) {
            int i = 0;
            int a = this.f158a.mo31a();
            boolean z = false;
            while (i < a) {
                if (!collection.contains(this.f158a.mo33a(i, 1))) {
                    this.f158a.mo35a(i);
                    i--;
                    a--;
                    z = true;
                }
                i++;
            }
            return z;
        }

        public final int size() {
            return this.f158a.mo31a();
        }

        public final Object[] toArray() {
            return this.f158a.m154b(1);
        }

        public final <T> T[] toArray(T[] tArr) {
            return this.f158a.m151a((Object[]) tArr, 1);
        }
    }

    bf() {
    }

    public static <K, V> boolean m143a(Map<K, V> map, Collection<?> collection) {
        int size = map.size();
        Iterator it = map.keySet().iterator();
        while (it.hasNext()) {
            if (!collection.contains(it.next())) {
                it.remove();
            }
        }
        return size != map.size();
    }

    public static <T> boolean m144a(Set<T> set, Object obj) {
        if (set == obj) {
            return true;
        }
        if (!(obj instanceof Set)) {
            return false;
        }
        Set set2 = (Set) obj;
        try {
            return set.size() == set2.size() && set.containsAll(set2);
        } catch (NullPointerException e) {
            return false;
        } catch (ClassCastException e2) {
            return false;
        }
    }

    protected abstract int mo31a();

    protected abstract int mo32a(Object obj);

    protected abstract Object mo33a(int i, int i2);

    protected abstract V mo34a(int i, V v);

    protected abstract void mo35a(int i);

    protected abstract void mo36a(K k, V v);

    public final <T> T[] m151a(T[] tArr, int i) {
        int a = mo31a();
        T[] tArr2 = tArr.length < a ? (Object[]) Array.newInstance(tArr.getClass().getComponentType(), a) : tArr;
        for (int i2 = 0; i2 < a; i2++) {
            tArr2[i2] = mo33a(i2, i);
        }
        if (tArr2.length > a) {
            tArr2[a] = null;
        }
        return tArr2;
    }

    protected abstract int mo37b(Object obj);

    protected abstract Map<K, V> mo38b();

    public final Object[] m154b(int i) {
        int a = mo31a();
        Object[] objArr = new Object[a];
        for (int i2 = 0; i2 < a; i2++) {
            objArr[i2] = mo33a(i2, i);
        }
        return objArr;
    }

    protected abstract void mo39c();
}
