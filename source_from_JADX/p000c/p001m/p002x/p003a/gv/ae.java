package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;

final class ae implements Parcelable {
    public static final Creator<ae> CREATOR = new af();
    final String f6a;
    final int f7b;
    final boolean f8c;
    final int f9d;
    final int f10e;
    final String f11f;
    final boolean f12g;
    final boolean f13h;
    final Bundle f14i;
    Bundle f15j;
    C0058n f16k;

    public ae(Parcel parcel) {
        boolean z = true;
        this.f6a = parcel.readString();
        this.f7b = parcel.readInt();
        this.f8c = parcel.readInt() != 0;
        this.f9d = parcel.readInt();
        this.f10e = parcel.readInt();
        this.f11f = parcel.readString();
        this.f12g = parcel.readInt() != 0;
        if (parcel.readInt() == 0) {
            z = false;
        }
        this.f13h = z;
        this.f14i = parcel.readBundle();
        this.f15j = parcel.readBundle();
    }

    public ae(C0058n c0058n) {
        this.f6a = c0058n.getClass().getName();
        this.f7b = c0058n.mIndex;
        this.f8c = c0058n.mFromLayout;
        this.f9d = c0058n.mFragmentId;
        this.f10e = c0058n.mContainerId;
        this.f11f = c0058n.mTag;
        this.f12g = c0058n.mRetainInstance;
        this.f13h = c0058n.mDetached;
        this.f14i = c0058n.mArguments;
    }

    public final C0058n m16a(C0065u c0065u, C0058n c0058n) {
        if (this.f16k != null) {
            return this.f16k;
        }
        Context context = c0065u.f252b;
        if (this.f14i != null) {
            this.f14i.setClassLoader(context.getClassLoader());
        }
        this.f16k = C0058n.instantiate(context, this.f6a, this.f14i);
        if (this.f15j != null) {
            this.f15j.setClassLoader(context.getClassLoader());
            this.f16k.mSavedFragmentState = this.f15j;
        }
        this.f16k.setIndex(this.f7b, c0058n);
        this.f16k.mFromLayout = this.f8c;
        this.f16k.mRestored = true;
        this.f16k.mFragmentId = this.f9d;
        this.f16k.mContainerId = this.f10e;
        this.f16k.mTag = this.f11f;
        this.f16k.mRetainInstance = this.f12g;
        this.f16k.mDetached = this.f13h;
        this.f16k.mFragmentManager = c0065u.f254d;
        if (C0074w.f272a) {
            Log.v("FragmentManager", "Instantiated fragment " + this.f16k);
        }
        return this.f16k;
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        int i2 = 1;
        parcel.writeString(this.f6a);
        parcel.writeInt(this.f7b);
        parcel.writeInt(this.f8c ? 1 : 0);
        parcel.writeInt(this.f9d);
        parcel.writeInt(this.f10e);
        parcel.writeString(this.f11f);
        parcel.writeInt(this.f12g ? 1 : 0);
        if (!this.f13h) {
            i2 = 0;
        }
        parcel.writeInt(i2);
        parcel.writeBundle(this.f14i);
        parcel.writeBundle(this.f15j);
    }
}
