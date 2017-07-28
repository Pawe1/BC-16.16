package p000c.p001m.p002x.p003a.gv;

import java.util.Map;

public class bb<K, V> {
    static Object[] f84b;
    static int f85c;
    static Object[] f86d;
    static int f87e;
    int[] f88f = ax.f96a;
    Object[] f89g = ax.f98c;
    int f90h = 0;

    private int m75a() {
        int i = this.f90h;
        if (i == 0) {
            return -1;
        }
        int a = ax.m111a(this.f88f, i, 0);
        if (a < 0 || this.f89g[a << 1] == null) {
            return a;
        }
        int i2 = a + 1;
        while (i2 < i && this.f88f[i2] == 0) {
            if (this.f89g[i2 << 1] == null) {
                return i2;
            }
            i2++;
        }
        a--;
        while (a >= 0 && this.f88f[a] == 0) {
            if (this.f89g[a << 1] == null) {
                return a;
            }
            a--;
        }
        return i2 ^ -1;
    }

    private int m76a(Object obj, int i) {
        int i2 = this.f90h;
        if (i2 == 0) {
            return -1;
        }
        int a = ax.m111a(this.f88f, i2, i);
        if (a < 0 || obj.equals(this.f89g[a << 1])) {
            return a;
        }
        int i3 = a + 1;
        while (i3 < i2 && this.f88f[i3] == i) {
            if (obj.equals(this.f89g[i3 << 1])) {
                return i3;
            }
            i3++;
        }
        a--;
        while (a >= 0 && this.f88f[a] == i) {
            if (obj.equals(this.f89g[a << 1])) {
                return a;
            }
            a--;
        }
        return i3 ^ -1;
    }

    private static void m77a(int[] iArr, Object[] objArr, int i) {
        int i2;
        if (iArr.length == 8) {
            synchronized (av.class) {
                if (f87e < 10) {
                    objArr[0] = f86d;
                    objArr[1] = iArr;
                    for (i2 = (i << 1) - 1; i2 >= 2; i2--) {
                        objArr[i2] = null;
                    }
                    f86d = objArr;
                    f87e++;
                }
            }
        } else if (iArr.length == 4) {
            synchronized (av.class) {
                if (f85c < 10) {
                    objArr[0] = f84b;
                    objArr[1] = iArr;
                    for (i2 = (i << 1) - 1; i2 >= 2; i2--) {
                        objArr[i2] = null;
                    }
                    f84b = objArr;
                    f85c++;
                }
            }
        }
    }

    private void m78e(int i) {
        Object[] objArr;
        if (i == 8) {
            synchronized (av.class) {
                if (f86d != null) {
                    objArr = f86d;
                    this.f89g = objArr;
                    f86d = (Object[]) objArr[0];
                    this.f88f = (int[]) objArr[1];
                    objArr[1] = null;
                    objArr[0] = null;
                    f87e--;
                    return;
                }
            }
        } else if (i == 4) {
            synchronized (av.class) {
                if (f84b != null) {
                    objArr = f84b;
                    this.f89g = objArr;
                    f84b = (Object[]) objArr[0];
                    this.f88f = (int[]) objArr[1];
                    objArr[1] = null;
                    objArr[0] = null;
                    f85c--;
                    return;
                }
            }
        }
        this.f88f = new int[i];
        this.f89g = new Object[(i << 1)];
    }

    public final int m79a(Object obj) {
        return obj == null ? m75a() : m76a(obj, obj.hashCode());
    }

    public final V m80a(int i, V v) {
        int i2 = (i << 1) + 1;
        V v2 = this.f89g[i2];
        this.f89g[i2] = v;
        return v2;
    }

    public final void m81a(int i) {
        if (this.f88f.length < i) {
            Object obj = this.f88f;
            Object obj2 = this.f89g;
            m78e(i);
            if (this.f90h > 0) {
                System.arraycopy(obj, 0, this.f88f, 0, this.f90h);
                System.arraycopy(obj2, 0, this.f89g, 0, this.f90h << 1);
            }
            bb.m77a(obj, obj2, this.f90h);
        }
    }

    final int m82b(Object obj) {
        int i = 1;
        int i2 = this.f90h * 2;
        Object[] objArr = this.f89g;
        if (obj == null) {
            while (i < i2) {
                if (objArr[i] == null) {
                    return i >> 1;
                }
                i += 2;
            }
        } else {
            while (i < i2) {
                if (obj.equals(objArr[i])) {
                    return i >> 1;
                }
                i += 2;
            }
        }
        return -1;
    }

    public final K m83b(int i) {
        return this.f89g[i << 1];
    }

    public final V m84c(int i) {
        return this.f89g[(i << 1) + 1];
    }

    public void clear() {
        if (this.f90h != 0) {
            bb.m77a(this.f88f, this.f89g, this.f90h);
            this.f88f = ax.f96a;
            this.f89g = ax.f98c;
            this.f90h = 0;
        }
    }

    public boolean containsKey(Object obj) {
        return m79a(obj) >= 0;
    }

    public boolean containsValue(Object obj) {
        return m82b(obj) >= 0;
    }

    public final V m85d(int i) {
        int i2 = 8;
        V v = this.f89g[(i << 1) + 1];
        if (this.f90h <= 1) {
            bb.m77a(this.f88f, this.f89g, this.f90h);
            this.f88f = ax.f96a;
            this.f89g = ax.f98c;
            this.f90h = 0;
        } else if (this.f88f.length <= 8 || this.f90h >= this.f88f.length / 3) {
            this.f90h--;
            if (i < this.f90h) {
                System.arraycopy(this.f88f, i + 1, this.f88f, i, this.f90h - i);
                System.arraycopy(this.f89g, (i + 1) << 1, this.f89g, i << 1, (this.f90h - i) << 1);
            }
            this.f89g[this.f90h << 1] = null;
            this.f89g[(this.f90h << 1) + 1] = null;
        } else {
            if (this.f90h > 8) {
                i2 = this.f90h + (this.f90h >> 1);
            }
            Object obj = this.f88f;
            Object obj2 = this.f89g;
            m78e(i2);
            this.f90h--;
            if (i > 0) {
                System.arraycopy(obj, 0, this.f88f, 0, i);
                System.arraycopy(obj2, 0, this.f89g, 0, i << 1);
            }
            if (i < this.f90h) {
                System.arraycopy(obj, i + 1, this.f88f, i, this.f90h - i);
                System.arraycopy(obj2, (i + 1) << 1, this.f89g, i << 1, (this.f90h - i) << 1);
            }
        }
        return v;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Map)) {
            return false;
        }
        Map map = (Map) obj;
        if (size() != map.size()) {
            return false;
        }
        int i = 0;
        while (i < this.f90h) {
            try {
                Object b = m83b(i);
                Object c = m84c(i);
                Object obj2 = map.get(b);
                if (c == null) {
                    if (obj2 != null || !map.containsKey(b)) {
                        return false;
                    }
                } else if (!c.equals(obj2)) {
                    return false;
                }
                i++;
            } catch (NullPointerException e) {
                return false;
            } catch (ClassCastException e2) {
                return false;
            }
        }
        return true;
    }

    public V get(Object obj) {
        int a = m79a(obj);
        return a >= 0 ? this.f89g[(a << 1) + 1] : null;
    }

    public final int hashCode() {
        int[] iArr = this.f88f;
        Object[] objArr = this.f89g;
        int i = this.f90h;
        int i2 = 1;
        int i3 = 0;
        int i4 = 0;
        while (i3 < i) {
            Object obj = objArr[i2];
            i4 += (obj == null ? 0 : obj.hashCode()) ^ iArr[i3];
            i3++;
            i2 += 2;
        }
        return i4;
    }

    public boolean isEmpty() {
        return this.f90h <= 0;
    }

    public V put(K k, V v) {
        int a;
        int i;
        int i2 = 8;
        if (k == null) {
            a = m75a();
            i = 0;
        } else {
            i = k.hashCode();
            a = m76a((Object) k, i);
        }
        if (a >= 0) {
            int i3 = (a << 1) + 1;
            V v2 = this.f89g[i3];
            this.f89g[i3] = v;
            return v2;
        }
        a ^= -1;
        if (this.f90h >= this.f88f.length) {
            if (this.f90h >= 8) {
                i2 = this.f90h + (this.f90h >> 1);
            } else if (this.f90h < 4) {
                i2 = 4;
            }
            Object obj = this.f88f;
            Object obj2 = this.f89g;
            m78e(i2);
            if (this.f88f.length > 0) {
                System.arraycopy(obj, 0, this.f88f, 0, obj.length);
                System.arraycopy(obj2, 0, this.f89g, 0, obj2.length);
            }
            bb.m77a(obj, obj2, this.f90h);
        }
        if (a < this.f90h) {
            System.arraycopy(this.f88f, a, this.f88f, a + 1, this.f90h - a);
            System.arraycopy(this.f89g, a << 1, this.f89g, (a + 1) << 1, (this.f90h - a) << 1);
        }
        this.f88f[a] = i;
        this.f89g[a << 1] = k;
        this.f89g[(a << 1) + 1] = v;
        this.f90h++;
        return null;
    }

    public V remove(Object obj) {
        int a = m79a(obj);
        return a >= 0 ? m85d(a) : null;
    }

    public int size() {
        return this.f90h;
    }

    public final String toString() {
        if (isEmpty()) {
            return "{}";
        }
        StringBuilder stringBuilder = new StringBuilder(this.f90h * 28);
        stringBuilder.append('{');
        for (int i = 0; i < this.f90h; i++) {
            if (i > 0) {
                stringBuilder.append(", ");
            }
            bb b = m83b(i);
            if (b != this) {
                stringBuilder.append(b);
            } else {
                stringBuilder.append("(this Map)");
            }
            stringBuilder.append('=');
            b = m84c(i);
            if (b != this) {
                stringBuilder.append(b);
            } else {
                stringBuilder.append("(this Map)");
            }
        }
        stringBuilder.append('}');
        return stringBuilder.toString();
    }
}
