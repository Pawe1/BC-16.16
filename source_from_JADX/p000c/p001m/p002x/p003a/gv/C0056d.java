package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.pm.PackageManager;
import p000c.p001m.p002x.p003a.gv.C0055c.C0052a;

final class C0056d implements Runnable {
    final /* synthetic */ String[] f230a;
    final /* synthetic */ Activity f231b;
    final /* synthetic */ int f232c;

    C0056d(String[] strArr, Activity activity, int i) {
        this.f230a = strArr;
        this.f231b = activity;
        this.f232c = i;
    }

    public final void run() {
        int[] iArr = new int[this.f230a.length];
        PackageManager packageManager = this.f231b.getPackageManager();
        String packageName = this.f231b.getPackageName();
        int length = this.f230a.length;
        for (int i = 0; i < length; i++) {
            iArr[i] = packageManager.checkPermission(this.f230a[i], packageName);
        }
        ((C0052a) this.f231b).onRequestPermissionsResult(this.f232c, this.f230a, iArr);
    }
}
