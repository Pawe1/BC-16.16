package p000c.p001m.p002x.p003a.gv;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

final class ac implements Parcelable {
    public static final Creator<ac> CREATOR = new ad();
    ae[] f3a;
    int[] f4b;
    C0054i[] f5c;

    public ac(Parcel parcel) {
        this.f3a = (ae[]) parcel.createTypedArray(ae.CREATOR);
        this.f4b = parcel.createIntArray();
        this.f5c = (C0054i[]) parcel.createTypedArray(C0054i.CREATOR);
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        parcel.writeTypedArray(this.f3a, i);
        parcel.writeIntArray(this.f4b);
        parcel.writeTypedArray(this.f5c, i);
    }
}
