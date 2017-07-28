package p000c.p001m.p002x.p003a.gv;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

abstract class ba<K, V> {
    C0019b f92b;
    C0020c f93c;
    C0022e f94d;

    final class C0018a<T> implements Iterator<T> {
        final int f104a;
        int f105b;
        int f106c;
        boolean f107d = false;
        final /* synthetic */ ba f108e;

        C0018a(ba baVar, int i) {
            this.f108e = baVar;
            this.f104a = i;
            this.f105b = baVar.mo8a();
        }

        public final boolean hasNext() {
            return this.f106c < this.f105b;
        }

        public final T next() {
            T a = this.f108e.mo10a(this.f106c, this.f104a);
            this.f106c++;
            this.f107d = true;
            return a;
        }

        public final void remove() {
            if (this.f107d) {
                this.f106c--;
                this.f105b--;
                this.f107d = false;
                this.f108e.mo12a(this.f106c);
                return;
            }
            throw new IllegalStateException();
        }
    }

    final class C0019b implements Set<Entry<K, V>> {
        final /* synthetic */ ba f109a;

        C0019b(ba baVar) {
            this.f109a = baVar;
        }

        public final /* synthetic */ boolean add(Object obj) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends Entry<K, V>> collection) {
            int a = this.f109a.mo8a();
            for (Entry entry : collection) {
                this.f109a.mo13a(entry.getKey(), entry.getValue());
            }
            return a != this.f109a.mo8a();
        }

        public final void clear() {
            this.f109a.mo16c();
        }

        public final boolean contains(Object obj) {
            if (!(obj instanceof Entry)) {
                return false;
            }
            Entry entry = (Entry) obj;
            int a = this.f109a.mo9a(entry.getKey());
            return a >= 0 ? ax.m112a(this.f109a.mo10a(a, 1), entry.getValue()) : false;
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
            return ba.m89a((Set) this, obj);
        }

        public final int hashCode() {
            int a = this.f109a.mo8a() - 1;
            int i = 0;
            while (a >= 0) {
                Object a2 = this.f109a.mo10a(a, 0);
                Object a3 = this.f109a.mo10a(a, 1);
                a--;
                i += (a3 == null ? 0 : a3.hashCode()) ^ (a2 == null ? 0 : a2.hashCode());
            }
            return i;
        }

        public final boolean isEmpty() {
            return this.f109a.mo8a() == 0;
        }

        public final Iterator<Entry<K, V>> iterator() {
            return new C0021d(this.f109a);
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
            return this.f109a.mo8a();
        }

        public final Object[] toArray() {
            throw new UnsupportedOperationException();
        }

        public final <T> T[] toArray(T[] tArr) {
            throw new UnsupportedOperationException();
        }
    }

    final class C0020c implements Set<K> {
        final /* synthetic */ ba f110a;

        C0020c(ba baVar) {
            this.f110a = baVar;
        }

        public final boolean add(K k) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends K> collection) {
            throw new UnsupportedOperationException();
        }

        public final void clear() {
            this.f110a.mo16c();
        }

        public final boolean contains(Object obj) {
            return this.f110a.mo9a(obj) >= 0;
        }

        public final boolean containsAll(Collection<?> collection) {
            Map b = this.f110a.mo15b();
            for (Object containsKey : collection) {
                if (!b.containsKey(containsKey)) {
                    return false;
                }
            }
            return true;
        }

        public final boolean equals(Object obj) {
            return ba.m89a((Set) this, obj);
        }

        public final int hashCode() {
            int i = 0;
            for (int a = this.f110a.mo8a() - 1; a >= 0; a--) {
                Object a2 = this.f110a.mo10a(a, 0);
                i += a2 == null ? 0 : a2.hashCode();
            }
            return i;
        }

        public final boolean isEmpty() {
            return this.f110a.mo8a() == 0;
        }

        public final Iterator<K> iterator() {
            return new C0018a(this.f110a, 0);
        }

        public final boolean remove(Object obj) {
            int a = this.f110a.mo9a(obj);
            if (a < 0) {
                return false;
            }
            this.f110a.mo12a(a);
            return true;
        }

        public final boolean removeAll(Collection<?> collection) {
            Map b = this.f110a.mo15b();
            int size = b.size();
            for (Object remove : collection) {
                b.remove(remove);
            }
            return size != b.size();
        }

        public final boolean retainAll(Collection<?> collection) {
            return ba.m88a(this.f110a.mo15b(), (Collection) collection);
        }

        public final int size() {
            return this.f110a.mo8a();
        }

        public final Object[] toArray() {
            return this.f110a.m99b(0);
        }

        public final <T> T[] toArray(T[] tArr) {
            return this.f110a.m96a((Object[]) tArr, 0);
        }
    }

    final class C0021d implements Iterator<Entry<K, V>>, Entry<K, V> {
        int f111a;
        int f112b;
        boolean f113c = false;
        final /* synthetic */ ba f114d;

        C0021d(ba baVar) {
            this.f114d = baVar;
            this.f111a = baVar.mo8a() - 1;
            this.f112b = -1;
        }

        public final boolean equals(Object obj) {
            if (!this.f113c) {
                throw new IllegalStateException("This container does not support retaining Map.Entry objects");
            } else if (!(obj instanceof Entry)) {
                return false;
            } else {
                Entry entry = (Entry) obj;
                return ax.m112a(entry.getKey(), this.f114d.mo10a(this.f112b, 0)) && ax.m112a(entry.getValue(), this.f114d.mo10a(this.f112b, 1));
            }
        }

        public final K getKey() {
            if (this.f113c) {
                return this.f114d.mo10a(this.f112b, 0);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final V getValue() {
            if (this.f113c) {
                return this.f114d.mo10a(this.f112b, 1);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final boolean hasNext() {
            return this.f112b < this.f111a;
        }

        public final int hashCode() {
            int i = 0;
            if (this.f113c) {
                Object a = this.f114d.mo10a(this.f112b, 0);
                Object a2 = this.f114d.mo10a(this.f112b, 1);
                int hashCode = a == null ? 0 : a.hashCode();
                if (a2 != null) {
                    i = a2.hashCode();
                }
                return i ^ hashCode;
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final /* bridge */ /* synthetic */ Object next() {
            this.f112b++;
            this.f113c = true;
            return this;
        }

        public final void remove() {
            if (this.f113c) {
                this.f114d.mo12a(this.f112b);
                this.f112b--;
                this.f111a--;
                this.f113c = false;
                return;
            }
            throw new IllegalStateException();
        }

        public final V setValue(V v) {
            if (this.f113c) {
                return this.f114d.mo11a(this.f112b, (Object) v);
            }
            throw new IllegalStateException("This container does not support retaining Map.Entry objects");
        }

        public final String toString() {
            return getKey() + "=" + getValue();
        }
    }

    final class C0022e implements Collection<V> {
        final /* synthetic */ ba f115a;

        C0022e(ba baVar) {
            this.f115a = baVar;
        }

        public final boolean add(V v) {
            throw new UnsupportedOperationException();
        }

        public final boolean addAll(Collection<? extends V> collection) {
            throw new UnsupportedOperationException();
        }

        public final void clear() {
            this.f115a.mo16c();
        }

        public final boolean contains(Object obj) {
            return this.f115a.mo14b(obj) >= 0;
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
            return this.f115a.mo8a() == 0;
        }

        public final Iterator<V> iterator() {
            return new C0018a(this.f115a, 1);
        }

        public final boolean remove(Object obj) {
            int b = this.f115a.mo14b(obj);
            if (b < 0) {
                return false;
            }
            this.f115a.mo12a(b);
            return true;
        }

        public final boolean removeAll(Collection<?> collection) {
            int i = 0;
            int a = this.f115a.mo8a();
            boolean z = false;
            while (i < a) {
                if (collection.contains(this.f115a.mo10a(i, 1))) {
                    this.f115a.mo12a(i);
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
            int a = this.f115a.mo8a();
            boolean z = false;
            while (i < a) {
                if (!collection.contains(this.f115a.mo10a(i, 1))) {
                    this.f115a.mo12a(i);
                    i--;
                    a--;
                    z = true;
                }
                i++;
            }
            return z;
        }

        public final int size() {
            return this.f115a.mo8a();
        }

        public final Object[] toArray() {
            return this.f115a.m99b(1);
        }

        public final <T> T[] toArray(T[] tArr) {
            return this.f115a.m96a((Object[]) tArr, 1);
        }
    }

    ba() {
    }

    public static <K, V> boolean m88a(Map<K, V> map, Collection<?> collection) {
        int size = map.size();
        Iterator it = map.keySet().iterator();
        while (it.hasNext()) {
            if (!collection.contains(it.next())) {
                it.remove();
            }
        }
        return size != map.size();
    }

    public static <T> boolean m89a(Set<T> set, Object obj) {
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

    protected abstract int mo8a();

    protected abstract int mo9a(Object obj);

    protected abstract Object mo10a(int i, int i2);

    protected abstract V mo11a(int i, V v);

    protected abstract void mo12a(int i);

    protected abstract void mo13a(K k, V v);

    public final <T> T[] m96a(T[] tArr, int i) {
        int a = mo8a();
        T[] tArr2 = tArr.length < a ? (Object[]) Array.newInstance(tArr.getClass().getComponentType(), a) : tArr;
        for (int i2 = 0; i2 < a; i2++) {
            tArr2[i2] = mo10a(i2, i);
        }
        if (tArr2.length > a) {
            tArr2[a] = null;
        }
        return tArr2;
    }

    protected abstract int mo14b(Object obj);

    protected abstract Map<K, V> mo15b();

    public final Object[] m99b(int i) {
        int a = mo8a();
        Object[] objArr = new Object[a];
        for (int i2 = 0; i2 < a; i2++) {
            objArr[i2] = mo10a(i2, i);
        }
        return objArr;
    }

    protected abstract void mo16c();
}
