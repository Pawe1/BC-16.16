package p000c.p001m.p002x.p003a.gv;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

final class ag implements Parcelable {
    public static final Creator<ag> CREATOR = new ah();
    ai[] f48a;
    int[] f49b;
    C0067k[] f50c;

    public ag(Parcel parcel) {
        this.f48a = (ai[]) parcel.createTypedArray(ai.CREATOR);
        this.f49b = parcel.createIntArray();
        this.f50c = (C0067k[]) parcel.createTypedArray(C0067k.CREATOR);
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        parcel.writeTypedArray(this.f48a, i);
        parcel.writeIntArray(this.f49b);
        parcel.writeTypedArray(this.f50c, i);
    }
}
