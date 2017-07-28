package p000c.p001m.p002x.p003a.gv;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.util.Log;
import java.util.ArrayList;
import p000c.p001m.p002x.p003a.gv.C0050e.C0048a;

final class C0054i implements Parcelable {
    public static final Creator<C0054i> CREATOR = new C0055j();
    final int[] f238a;
    final int f239b;
    final int f240c;
    final String f241d;
    final int f242e;
    final int f243f;
    final CharSequence f244g;
    final int f245h;
    final CharSequence f246i;
    final ArrayList<String> f247j;
    final ArrayList<String> f248k;

    public C0054i(Parcel parcel) {
        this.f238a = parcel.createIntArray();
        this.f239b = parcel.readInt();
        this.f240c = parcel.readInt();
        this.f241d = parcel.readString();
        this.f242e = parcel.readInt();
        this.f243f = parcel.readInt();
        this.f244g = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.f245h = parcel.readInt();
        this.f246i = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
        this.f247j = parcel.createStringArrayList();
        this.f248k = parcel.createStringArrayList();
    }

    public C0054i(C0050e c0050e) {
        int i = 0;
        for (C0048a c0048a = c0050e.f203c; c0048a != null; c0048a = c0048a.f187a) {
            if (c0048a.f195i != null) {
                i += c0048a.f195i.size();
            }
        }
        this.f238a = new int[(i + (c0050e.f205e * 7))];
        if (c0050e.f212l) {
            i = 0;
            for (C0048a c0048a2 = c0050e.f203c; c0048a2 != null; c0048a2 = c0048a2.f187a) {
                int i2 = i + 1;
                this.f238a[i] = c0048a2.f189c;
                int i3 = i2 + 1;
                this.f238a[i2] = c0048a2.f190d != null ? c0048a2.f190d.mIndex : -1;
                int i4 = i3 + 1;
                this.f238a[i3] = c0048a2.f191e;
                i2 = i4 + 1;
                this.f238a[i4] = c0048a2.f192f;
                i4 = i2 + 1;
                this.f238a[i2] = c0048a2.f193g;
                i2 = i4 + 1;
                this.f238a[i4] = c0048a2.f194h;
                if (c0048a2.f195i != null) {
                    int size = c0048a2.f195i.size();
                    i4 = i2 + 1;
                    this.f238a[i2] = size;
                    i2 = 0;
                    while (i2 < size) {
                        i3 = i4 + 1;
                        this.f238a[i4] = ((C0058n) c0048a2.f195i.get(i2)).mIndex;
                        i2++;
                        i4 = i3;
                    }
                    i = i4;
                } else {
                    i = i2 + 1;
                    this.f238a[i2] = 0;
                }
            }
            this.f239b = c0050e.f210j;
            this.f240c = c0050e.f211k;
            this.f241d = c0050e.f214n;
            this.f242e = c0050e.f216p;
            this.f243f = c0050e.f217q;
            this.f244g = c0050e.f218r;
            this.f245h = c0050e.f219s;
            this.f246i = c0050e.f220t;
            this.f247j = c0050e.f221u;
            this.f248k = c0050e.f222v;
            return;
        }
        throw new IllegalStateException("Not on back stack");
    }

    public final C0050e m220a(C0074w c0074w) {
        C0050e c0050e = new C0050e(c0074w);
        int i = 0;
        int i2 = 0;
        while (i2 < this.f238a.length) {
            C0048a c0048a = new C0048a();
            int i3 = i2 + 1;
            c0048a.f189c = this.f238a[i2];
            if (C0074w.f272a) {
                Log.v("FragmentManager", "Instantiate " + c0050e + " op #" + i + " base fragment #" + this.f238a[i3]);
            }
            int i4 = i3 + 1;
            i2 = this.f238a[i3];
            if (i2 >= 0) {
                c0048a.f190d = (C0058n) c0074w.f278f.get(i2);
            } else {
                c0048a.f190d = null;
            }
            i3 = i4 + 1;
            c0048a.f191e = this.f238a[i4];
            i4 = i3 + 1;
            c0048a.f192f = this.f238a[i3];
            i3 = i4 + 1;
            c0048a.f193g = this.f238a[i4];
            int i5 = i3 + 1;
            c0048a.f194h = this.f238a[i3];
            i4 = i5 + 1;
            int i6 = this.f238a[i5];
            if (i6 > 0) {
                c0048a.f195i = new ArrayList(i6);
                i3 = 0;
                while (i3 < i6) {
                    if (C0074w.f272a) {
                        Log.v("FragmentManager", "Instantiate " + c0050e + " set remove fragment #" + this.f238a[i4]);
                    }
                    i5 = i4 + 1;
                    c0048a.f195i.add((C0058n) c0074w.f278f.get(this.f238a[i4]));
                    i3++;
                    i4 = i5;
                }
            }
            c0050e.m215a(c0048a);
            i++;
            i2 = i4;
        }
        c0050e.f210j = this.f239b;
        c0050e.f211k = this.f240c;
        c0050e.f214n = this.f241d;
        c0050e.f216p = this.f242e;
        c0050e.f212l = true;
        c0050e.f217q = this.f243f;
        c0050e.f218r = this.f244g;
        c0050e.f219s = this.f245h;
        c0050e.f220t = this.f246i;
        c0050e.f221u = this.f247j;
        c0050e.f222v = this.f248k;
        c0050e.m213a(1);
        return c0050e;
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        parcel.writeIntArray(this.f238a);
        parcel.writeInt(this.f239b);
        parcel.writeInt(this.f240c);
        parcel.writeString(this.f241d);
        parcel.writeInt(this.f242e);
        parcel.writeInt(this.f243f);
        TextUtils.writeToParcel(this.f244g, parcel, 0);
        parcel.writeInt(this.f245h);
        TextUtils.writeToParcel(this.f246i, parcel, 0);
        parcel.writeStringList(this.f247j);
        parcel.writeStringList(this.f248k);
    }
}
