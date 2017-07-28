package p000c.p001m.p002x.p003a.gv;

public final class bc<E> implements Cloneable {
    private static final Object f116a = new Object();
    private boolean f117b;
    private int[] f118c;
    private Object[] f119d;
    private int f120e;

    public bc() {
        this((byte) 0);
    }

    private bc(byte b) {
        this.f117b = false;
        ax.m110a();
        this.f118c = new int[13];
        this.f119d = new Object[13];
        this.f120e = 0;
    }

    private bc<E> m115c() {
        try {
            bc<E> bcVar = (bc) super.clone();
            try {
                bcVar.f118c = (int[]) this.f118c.clone();
                bcVar.f119d = (Object[]) this.f119d.clone();
                return bcVar;
            } catch (CloneNotSupportedException e) {
                return bcVar;
            }
        } catch (CloneNotSupportedException e2) {
            return null;
        }
    }

    private void m116d() {
        int i = this.f120e;
        int[] iArr = this.f118c;
        Object[] objArr = this.f119d;
        int i2 = 0;
        for (int i3 = 0; i3 < i; i3++) {
            Object obj = objArr[i3];
            if (obj != f116a) {
                if (i3 != i2) {
                    iArr[i2] = iArr[i3];
                    objArr[i2] = obj;
                    objArr[i3] = null;
                }
                i2++;
            }
        }
        this.f117b = false;
        this.f120e = i2;
    }

    public final int m117a() {
        if (this.f117b) {
            m116d();
        }
        return this.f120e;
    }

    public final int m118a(int i) {
        if (this.f117b) {
            m116d();
        }
        return this.f118c[i];
    }

    public final E m119b(int i) {
        if (this.f117b) {
            m116d();
        }
        return this.f119d[i];
    }

    public final void m120b() {
        int i = this.f120e;
        Object[] objArr = this.f119d;
        for (int i2 = 0; i2 < i; i2++) {
            objArr[i2] = null;
        }
        this.f120e = 0;
        this.f117b = false;
    }

    public final /* synthetic */ Object clone() {
        return m115c();
    }

    public final String toString() {
        if (m117a() <= 0) {
            return "{}";
        }
        StringBuilder stringBuilder = new StringBuilder(this.f120e * 28);
        stringBuilder.append('{');
        for (int i = 0; i < this.f120e; i++) {
            if (i > 0) {
                stringBuilder.append(", ");
            }
            stringBuilder.append(m118a(i));
            stringBuilder.append('=');
            bc b = m119b(i);
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
