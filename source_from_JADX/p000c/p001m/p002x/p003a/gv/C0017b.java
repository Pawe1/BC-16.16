package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.pm.PackageManager;
import p000c.p001m.p002x.p003a.gv.C0008a.C0005a;

final class C0017b implements Runnable {
    final /* synthetic */ String[] f101a;
    final /* synthetic */ Activity f102b;
    final /* synthetic */ int f103c;

    C0017b(String[] strArr, Activity activity, int i) {
        this.f101a = strArr;
        this.f102b = activity;
        this.f103c = i;
    }

    public final void run() {
        int[] iArr = new int[this.f101a.length];
        PackageManager packageManager = this.f102b.getPackageManager();
        String packageName = this.f102b.getPackageName();
        int length = this.f101a.length;
        for (int i = 0; i < length; i++) {
            iArr[i] = packageManager.checkPermission(this.f101a[i], packageName);
        }
        ((C0005a) this.f102b).onRequestPermissionsResult(this.f103c, this.f101a, iArr);
    }
}
