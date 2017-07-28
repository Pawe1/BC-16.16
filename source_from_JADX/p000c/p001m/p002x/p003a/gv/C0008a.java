package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.Context;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.Build.VERSION;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.view.View;
import p000c.p001m.p002x.p003a.gv.C0045c.C0006a;
import p000c.p001m.p002x.p003a.gv.C0047d.C0046a;

public final class C0008a extends ar {

    public interface C0005a {
        void onRequestPermissionsResult(int i, String[] strArr, int[] iArr);
    }

    private static class C0007b extends C0006a {
        private ap f0a;

        public C0007b(ap apVar) {
            this.f0a = apVar;
        }

        public final Parcelable mo1a(View view, Matrix matrix, RectF rectF) {
            return this.f0a.m61a(view, matrix, rectF);
        }

        public final View mo2a(Context context, Parcelable parcelable) {
            ap apVar = this.f0a;
            return ap.m56a(context, parcelable);
        }

        public final void mo3a() {
            ap apVar = this.f0a;
            ap.m57a();
        }

        public final void mo4b() {
            ap apVar = this.f0a;
            ap.m58b();
        }

        public final void mo5c() {
            ap apVar = this.f0a;
            ap.m59c();
        }

        public final void mo6d() {
            ap apVar = this.f0a;
            ap.m60d();
        }
    }

    private static C0006a m12a(ap apVar) {
        return apVar != null ? new C0007b(apVar) : null;
    }

    public static void m13a(Activity activity, ap apVar) {
        if (VERSION.SDK_INT >= 21) {
            C0045c.m188a(activity, C0008a.m12a(apVar));
        }
    }

    public static void m14a(Activity activity, String[] strArr, int i) {
        if (VERSION.SDK_INT >= 23) {
            if (activity instanceof C0046a) {
                ((C0046a) activity).validateRequestPermissionsRequestCode(i);
            }
            activity.requestPermissions(strArr, i);
        } else if (activity instanceof C0005a) {
            new Handler(Looper.getMainLooper()).post(new C0017b(strArr, activity, i));
        }
    }

    public static void m15b(Activity activity, ap apVar) {
        if (VERSION.SDK_INT >= 21) {
            C0045c.m189b(activity, C0008a.m12a(apVar));
        }
    }
}
