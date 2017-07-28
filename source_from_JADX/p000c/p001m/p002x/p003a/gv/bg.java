package p000c.p001m.p002x.p003a.gv;

import java.util.Map;

public class bg<K, V> {
    static Object[] f130b;
    static int f131c;
    static Object[] f132d;
    static int f133e;
    int[] f134f = bc.f142a;
    Object[] f135g = bc.f144c;
    int f136h = 0;

    private int m130a() {
        int i = this.f136h;
        if (i == 0) {
            return -1;
        }
        int a = bc.m166a(this.f134f, i, 0);
        if (a < 0 || this.f135g[a << 1] == null) {
            return a;
        }
        int i2 = a + 1;
        while (i2 < i && this.f134f[i2] == 0) {
            if (this.f135g[i2 << 1] == null) {
                return i2;
            }
            i2++;
        }
        a--;
        while (a >= 0 && this.f134f[a] == 0) {
            if (this.f135g[a << 1] == null) {
                return a;
            }
            a--;
        }
        return i2 ^ -1;
    }

    private int m131a(Object obj, int i) {
        int i2 = this.f136h;
        if (i2 == 0) {
            return -1;
        }
        int a = bc.m166a(this.f134f, i2, i);
        if (a < 0 || obj.equals(this.f135g[a << 1])) {
            return a;
        }
        int i3 = a + 1;
        while (i3 < i2 && this.f134f[i3] == i) {
            if (obj.equals(this.f135g[i3 << 1])) {
                return i3;
            }
            i3++;
        }
        a--;
        while (a >= 0 && this.f134f[a] == i) {
            if (obj.equals(this.f135g[a << 1])) {
                return a;
            }
            a--;
        }
        return i3 ^ -1;
    }

    private static void m132a(int[] iArr, Object[] objArr, int i) {
        int i2;
        if (iArr.length == 8) {
            synchronized (ba.class) {
                if (f133e < 10) {
                    objArr[0] = f132d;
                    objArr[1] = iArr;
                    for (i2 = (i << 1) - 1; i2 >= 2; i2--) {
                        objArr[i2] = null;
                    }
                    f132d = objArr;
                    f133e++;
                }
            }
        } else if (iArr.length == 4) {
            synchronized (ba.class) {
                if (f131c < 10) {
                    objArr[0] = f130b;
                    objArr[1] = iArr;
                    for (i2 = (i << 1) - 1; i2 >= 2; i2--) {
                        objArr[i2] = null;
                    }
                    f130b = objArr;
                    f131c++;
                }
            }
        }
    }

    private void m133e(int i) {
        Object[] objArr;
        if (i == 8) {
            synchronized (ba.class) {
                if (f132d != null) {
                    objArr = f132d;
                    this.f135g = objArr;
                    f132d = (Object[]) objArr[0];
                    this.f134f = (int[]) objArr[1];
                    objArr[1] = null;
                    objArr[0] = null;
                    f133e--;
                    return;
                }
            }
        } else if (i == 4) {
            synchronized (ba.class) {
                if (f130b != null) {
                    objArr = f130b;
                    this.f135g = objArr;
                    f130b = (Object[]) objArr[0];
                    this.f134f = (int[]) objArr[1];
                    objArr[1] = null;
                    objArr[0] = null;
                    f131c--;
                    return;
                }
            }
        }
        this.f134f = new int[i];
        this.f135g = new Object[(i << 1)];
    }

    public final int m134a(Object obj) {
        return obj == null ? m130a() : m131a(obj, obj.hashCode());
    }

    public final V m135a(int i, V v) {
        int i2 = (i << 1) + 1;
        V v2 = this.f135g[i2];
        this.f135g[i2] = v;
        return v2;
    }

    public final void m136a(int i) {
        if (this.f134f.length < i) {
            Object obj = this.f134f;
            Object obj2 = this.f135g;
            m133e(i);
            if (this.f136h > 0) {
                System.arraycopy(obj, 0, this.f134f, 0, this.f136h);
                System.arraycopy(obj2, 0, this.f135g, 0, this.f136h << 1);
            }
            bg.m132a(obj, obj2, this.f136h);
        }
    }

    final int m137b(Object obj) {
        int i = 1;
        int i2 = this.f136h * 2;
        Object[] objArr = this.f135g;
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

    public final K m138b(int i) {
        return this.f135g[i << 1];
    }

    public final V m139c(int i) {
        return this.f135g[(i << 1) + 1];
    }

    public void clear() {
        if (this.f136h != 0) {
            bg.m132a(this.f134f, this.f135g, this.f136h);
            this.f134f = bc.f142a;
            this.f135g = bc.f144c;
            this.f136h = 0;
        }
    }

    public boolean containsKey(Object obj) {
        return m134a(obj) >= 0;
    }

    public boolean containsValue(Object obj) {
        return m137b(obj) >= 0;
    }

    public final V m140d(int i) {
        int i2 = 8;
        V v = this.f135g[(i << 1) + 1];
        if (this.f136h <= 1) {
            bg.m132a(this.f134f, this.f135g, this.f136h);
            this.f134f = bc.f142a;
            this.f135g = bc.f144c;
            this.f136h = 0;
        } else if (this.f134f.length <= 8 || this.f136h >= this.f134f.length / 3) {
            this.f136h--;
            if (i < this.f136h) {
                System.arraycopy(this.f134f, i + 1, this.f134f, i, this.f136h - i);
                System.arraycopy(this.f135g, (i + 1) << 1, this.f135g, i << 1, (this.f136h - i) << 1);
            }
            this.f135g[this.f136h << 1] = null;
            this.f135g[(this.f136h << 1) + 1] = null;
        } else {
            if (this.f136h > 8) {
                i2 = this.f136h + (this.f136h >> 1);
            }
            Object obj = this.f134f;
            Object obj2 = this.f135g;
            m133e(i2);
            this.f136h--;
            if (i > 0) {
                System.arraycopy(obj, 0, this.f134f, 0, i);
                System.arraycopy(obj2, 0, this.f135g, 0, i << 1);
            }
            if (i < this.f136h) {
                System.arraycopy(obj, i + 1, this.f134f, i, this.f136h - i);
                System.arraycopy(obj2, (i + 1) << 1, this.f135g, i << 1, (this.f136h - i) << 1);
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
        while (i < this.f136h) {
            try {
                Object b = m138b(i);
                Object c = m139c(i);
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
        int a = m134a(obj);
        return a >= 0 ? this.f135g[(a << 1) + 1] : null;
    }

    public final int hashCode() {
        int[] iArr = this.f134f;
        Object[] objArr = this.f135g;
        int i = this.f136h;
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
        return this.f136h <= 0;
    }

    public V put(K k, V v) {
        int a;
        int i;
        int i2 = 8;
        if (k == null) {
            a = m130a();
            i = 0;
        } else {
            i = k.hashCode();
            a = m131a((Object) k, i);
        }
        if (a >= 0) {
            int i3 = (a << 1) + 1;
            V v2 = this.f135g[i3];
            this.f135g[i3] = v;
            return v2;
        }
        a ^= -1;
        if (this.f136h >= this.f134f.length) {
            if (this.f136h >= 8) {
                i2 = this.f136h + (this.f136h >> 1);
            } else if (this.f136h < 4) {
                i2 = 4;
            }
            Object obj = this.f134f;
            Object obj2 = this.f135g;
            m133e(i2);
            if (this.f134f.length > 0) {
                System.arraycopy(obj, 0, this.f134f, 0, obj.length);
                System.arraycopy(obj2, 0, this.f135g, 0, obj2.length);
            }
            bg.m132a(obj, obj2, this.f136h);
        }
        if (a < this.f136h) {
            System.arraycopy(this.f134f, a, this.f134f, a + 1, this.f136h - a);
            System.arraycopy(this.f135g, a << 1, this.f135g, (a + 1) << 1, (this.f136h - a) << 1);
        }
        this.f134f[a] = i;
        this.f135g[a << 1] = k;
        this.f135g[(a << 1) + 1] = v;
        this.f136h++;
        return null;
    }

    public V remove(Object obj) {
        int a = m134a(obj);
        return a >= 0 ? m140d(a) : null;
    }

    public int size() {
        return this.f136h;
    }

    public final String toString() {
        if (isEmpty()) {
            return "{}";
        }
        StringBuilder stringBuilder = new StringBuilder(this.f136h * 28);
        stringBuilder.append('{');
        for (int i = 0; i < this.f136h; i++) {
            if (i > 0) {
                stringBuilder.append(", ");
            }
            bg b = m138b(i);
            if (b != this) {
                stringBuilder.append(b);
            } else {
                stringBuilder.append("(this Map)");
            }
            stringBuilder.append('=');
            b = m139c(i);
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
