package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;

final class ai implements Parcelable {
    public static final Creator<ai> CREATOR = new aj();
    final String f51a;
    final int f52b;
    final boolean f53c;
    final int f54d;
    final int f55e;
    final String f56f;
    final boolean f57g;
    final boolean f58h;
    final Bundle f59i;
    Bundle f60j;
    C0073r f61k;

    public ai(Parcel parcel) {
        boolean z = true;
        this.f51a = parcel.readString();
        this.f52b = parcel.readInt();
        this.f53c = parcel.readInt() != 0;
        this.f54d = parcel.readInt();
        this.f55e = parcel.readInt();
        this.f56f = parcel.readString();
        this.f57g = parcel.readInt() != 0;
        if (parcel.readInt() == 0) {
            z = false;
        }
        this.f58h = z;
        this.f59i = parcel.readBundle();
        this.f60j = parcel.readBundle();
    }

    public ai(C0073r c0073r) {
        this.f51a = c0073r.getClass().getName();
        this.f52b = c0073r.mIndex;
        this.f53c = c0073r.mFromLayout;
        this.f54d = c0073r.mFragmentId;
        this.f55e = c0073r.mContainerId;
        this.f56f = c0073r.mTag;
        this.f57g = c0073r.mRetainInstance;
        this.f58h = c0073r.mDetached;
        this.f59i = c0073r.mArguments;
    }

    public final C0073r m69a(C0080y c0080y, C0073r c0073r) {
        if (this.f61k != null) {
            return this.f61k;
        }
        Context context = c0080y.f301b;
        if (this.f59i != null) {
            this.f59i.setClassLoader(context.getClassLoader());
        }
        this.f61k = C0073r.instantiate(context, this.f51a, this.f59i);
        if (this.f60j != null) {
            this.f60j.setClassLoader(context.getClassLoader());
            this.f61k.mSavedFragmentState = this.f60j;
        }
        this.f61k.setIndex(this.f52b, c0073r);
        this.f61k.mFromLayout = this.f53c;
        this.f61k.mRestored = true;
        this.f61k.mFragmentId = this.f54d;
        this.f61k.mContainerId = this.f55e;
        this.f61k.mTag = this.f56f;
        this.f61k.mRetainInstance = this.f57g;
        this.f61k.mDetached = this.f58h;
        this.f61k.mFragmentManager = c0080y.f303d;
        if (aa.f14a) {
            Log.v("FragmentManager", "Instantiated fragment " + this.f61k);
        }
        return this.f61k;
    }

    public final int describeContents() {
        return 0;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        int i2 = 1;
        parcel.writeString(this.f51a);
        parcel.writeInt(this.f52b);
        parcel.writeInt(this.f53c ? 1 : 0);
        parcel.writeInt(this.f54d);
        parcel.writeInt(this.f55e);
        parcel.writeString(this.f56f);
        parcel.writeInt(this.f57g ? 1 : 0);
        if (!this.f58h) {
            i2 = 0;
        }
        parcel.writeInt(i2);
        parcel.writeBundle(this.f59i);
        parcel.writeBundle(this.f60j);
    }
}
