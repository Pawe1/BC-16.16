package p000c.p001m.p002x.p003a.gv;

public final class bh<E> implements Cloneable {
    private static final Object f159a = new Object();
    private boolean f160b;
    private int[] f161c;
    private Object[] f162d;
    private int f163e;

    public bh() {
        this(10);
    }

    public bh(int i) {
        this.f160b = false;
        if (i == 0) {
            this.f161c = bc.f142a;
            this.f162d = bc.f144c;
        } else {
            int a = bc.m165a(i);
            this.f161c = new int[a];
            this.f162d = new Object[a];
        }
        this.f163e = 0;
    }

    private bh<E> m170c() {
        try {
            bh<E> bhVar = (bh) super.clone();
            try {
                bhVar.f161c = (int[]) this.f161c.clone();
                bhVar.f162d = (Object[]) this.f162d.clone();
                return bhVar;
            } catch (CloneNotSupportedException e) {
                return bhVar;
            }
        } catch (CloneNotSupportedException e2) {
            return null;
        }
    }

    private void m171d() {
        int i = this.f163e;
        int[] iArr = this.f161c;
        Object[] objArr = this.f162d;
        int i2 = 0;
        for (int i3 = 0; i3 < i; i3++) {
            Object obj = objArr[i3];
            if (obj != f159a) {
                if (i3 != i2) {
                    iArr[i2] = iArr[i3];
                    objArr[i2] = obj;
                    objArr[i3] = null;
                }
                i2++;
            }
        }
        this.f160b = false;
        this.f163e = i2;
    }

    public final int m172a() {
        if (this.f160b) {
            m171d();
        }
        return this.f163e;
    }

    public final E m173a(int i) {
        int a = bc.m166a(this.f161c, this.f163e, i);
        return (a < 0 || this.f162d[a] == f159a) ? null : this.f162d[a];
    }

    public final void m174a(int i, E e) {
        int a = bc.m166a(this.f161c, this.f163e, i);
        if (a >= 0) {
            this.f162d[a] = e;
            return;
        }
        a ^= -1;
        if (a >= this.f163e || this.f162d[a] != f159a) {
            if (this.f160b && this.f163e >= this.f161c.length) {
                m171d();
                a = bc.m166a(this.f161c, this.f163e, i) ^ -1;
            }
            if (this.f163e >= this.f161c.length) {
                int a2 = bc.m165a(this.f163e + 1);
                Object obj = new int[a2];
                Object obj2 = new Object[a2];
                System.arraycopy(this.f161c, 0, obj, 0, this.f161c.length);
                System.arraycopy(this.f162d, 0, obj2, 0, this.f162d.length);
                this.f161c = obj;
                this.f162d = obj2;
            }
            if (this.f163e - a != 0) {
                System.arraycopy(this.f161c, a, this.f161c, a + 1, this.f163e - a);
                System.arraycopy(this.f162d, a, this.f162d, a + 1, this.f163e - a);
            }
            this.f161c[a] = i;
            this.f162d[a] = e;
            this.f163e++;
            return;
        }
        this.f161c[a] = i;
        this.f162d[a] = e;
    }

    public final void m175b() {
        int i = this.f163e;
        Object[] objArr = this.f162d;
        for (int i2 = 0; i2 < i; i2++) {
            objArr[i2] = null;
        }
        this.f163e = 0;
        this.f160b = false;
    }

    public final void m176b(int i) {
        int a = bc.m166a(this.f161c, this.f163e, i);
        if (a >= 0 && this.f162d[a] != f159a) {
            this.f162d[a] = f159a;
            this.f160b = true;
        }
    }

    public final int m177c(int i) {
        if (this.f160b) {
            m171d();
        }
        return this.f161c[i];
    }

    public final /* synthetic */ Object clone() {
        return m170c();
    }

    public final E m178d(int i) {
        if (this.f160b) {
            m171d();
        }
        return this.f162d[i];
    }

    public final int m179e(int i) {
        if (this.f160b) {
            m171d();
        }
        return bc.m166a(this.f161c, this.f163e, i);
    }

    public final String toString() {
        if (m172a() <= 0) {
            return "{}";
        }
        StringBuilder stringBuilder = new StringBuilder(this.f163e * 28);
        stringBuilder.append('{');
        for (int i = 0; i < this.f163e; i++) {
            if (i > 0) {
                stringBuilder.append(", ");
            }
            stringBuilder.append(m177c(i));
            stringBuilder.append('=');
            bh d = m178d(i);
            if (d != this) {
                stringBuilder.append(d);
            } else {
                stringBuilder.append("(this Map)");
            }
        }
        stringBuilder.append('}');
        return stringBuilder.toString();
    }
}
