package p000c.p001m.p002x.p003a.gv;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.util.Log;
import java.util.ArrayList;
import p000c.p001m.p002x.p003a.gv.C0063g.C0061a;

final class C0067k implements Parcelable {
    public static final Creator<C0067k> CREATOR = new C0068l();
    final int[] f285a;
    final int f286b;
    final int f287c;
    final String f288d;
    final int f289e;
    final int f290f;
    final CharSequence f291g;
    final int f292h;
    final CharSequence f293i;
    final ArrayList<String> f294j;
    final ArrayList<String> f295k;

    public C0067k(Parcel parcel) {
        this.f285a = parcel.createIntArray();
        this.f286b = parcel.readInt();
        this.f287c = parcel.readInt();
        this.f288d = parcel.readString();
        this.f289e = parcel.readInt();
        this.f290f = parcel.readInt();
        this.f291g = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.f292h = parcel.readInt();
        this.f293i = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.f294j = parcel.createStringArrayList();
        this.f295k = parcel.createStringArrayList();
    }

    public C0067k(C0063g c0063g) {
        int i = 0;
        for (C0061a c0061a = c0063g.f250c; c0061a != null; c0061a = c0061a.f234a) {
            if (c0061a.f242i != null) {
                i += c0061a.f242i.size();
            }
        }
        this.f285a = new int[(i + (c0063g.f252e * 7))];
        if (c0063g.f259l) {
            i = 0;
            for (C0061a c0061a2 = c0063g.f250c; c0061a2 != null; c0061a2 = c0061a2.f234a) {
                int i2 = i + 1;
                this.f285a[i] = c0061a2.f236c;
                int i3 = i2 + 1;
                this.f285a[i2] = c0061a2.f237d != null ? c0061a2.f237d.mIndex : -1;
                int i4 = i3 + 1;
                this.f285a[i3] = c0061a2.f238e;
                i2 = i4 + 1;
                this.f285a[i4] = c0061a2.f239f;
                i4 = i2 + 1;
                this.f285a[i2] = c0061a2.f240g;
                i2 = i4 + 1;
                this.f285a[i4] = c0061a2.f241h;
                if (c0061a2.f242i != null) {
                    int size = c0061a2.f242i.size();
                    i4 = i2 + 1;
                    this.f285a[i2] = size;
                    i2 = 0;
                    while (i2 < size) {
                        i3 = i4 + 1;
                        this.f285a[i4] = ((C0073r) c0061a2.f242i.get(i2)).mIndex;
                        i2++;
                        i4 = i3;
                    }
                    i = i4;
                } else {
                    i = i2 + 1;
                    this.f285a[i2] = 0;
                }
            }
            this.f286b = c0063g.f257j;
            this.f287c = c0063g.f258k;
            this.f288d = c0063g.f261n;
            this.f289e = c0063g.f263p;
            this.f290f = c0063g.f264q;
            this.f291g = c0063g.f265r;
            this.f292h = c0063g.f266s;
            this.f293i = c0063g.f267t;
            this.f294j = c0063g.f268u;
            this.f295k = c0063g.f269v;
            return;
        }
        throw new IllegalStateException("Not on back stack");
    }

    public final C0063g m295a(aa aaVar) {
        C0063g c0063g = new C0063g(aaVar);
        int i = 0;
        int i2 = 0;
        while (i2 < this.f285a.length) {
            C0061a c0061a = new C0061a();
            int i3 = i2 + 1;
            c0061a.f236c = this.f285a[i2];
            if (aa.f14a) {
                Log.v("FragmentManager", "Instantiate " + c0063g + " op #" + i + " base fragment #" + this.f285a[i3]);
            }
            int i4 = i3 + 1;
            i2 = this.f285a[i3];
            if (i2 >= 0) {
                c0061a.f237d = (C0073r) aaVar.f20f.get(i2);
            } else {
                c0061a.f237d = null;
            }
            i3 = i4 + 1;
            c0061a.f238e = this.f285a[i4];
            i4 = i3 + 1;
            c0061a.f239f = this.f285a[i3];
            i3 = i4 + 1;
            c0061a.f240g = this.f285a[i4];
            int i5 = i3 + 1;
            c0061a.f241h = this.f285a[i3];
            i4 = i5 + 1;
            int i6 = this.f285a[i5];
            if (i6 > 0) {
                c0061a.f242i = new ArrayList(i6);
                i3 = 0;
                while (i3 < i6) {
                    if (aa.f14a) {
                        Log.v("FragmentManager", "Instantiate " + c0063g + " set remove fragment #" + this.f285a[i4]);
                    }
                    i5 = i4 + 1;
                    c0061a.f242i.add((C0073r) aaVar.f20f.get(this.f285a[i4]));
                    i3++;
                    i4 = i5;
                }
            }
            c0063g.m290a(c0061a);
            i++;
            i2 = i4;
        }
        c0063g.f257j = this.f286b;
        c0063g.f258k = this.f287c;
        c0063g.f261n = this.f288d;
        c0063g.f263p = this.f289e;
        c0063g.f259l = true;
        c0063g.f264q = this.f290f;
        c0063g.f265r = this.f291g;
        c0063g.f266s = this.f292h;
        c0063g.f267t = this.f293i;
        c0063g.f268u = this.f294j;
        c0063g.f269v = this.f295k;
        c0063g.m288a(1);
        return c0063g;
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        parcel.writeIntArray(this.f285a);
        parcel.writeInt(this.f286b);
        parcel.writeInt(this.f287c);
        parcel.writeString(this.f288d);
        parcel.writeInt(this.f289e);
        parcel.writeInt(this.f290f);
        TextUtils.writeToParcel(this.f291g, parcel, 0);
        parcel.writeInt(this.f292h);
        TextUtils.writeToParcel(this.f293i, parcel, 0);
        parcel.writeStringList(this.f294j);
        parcel.writeStringList(this.f295k);
    }
}
