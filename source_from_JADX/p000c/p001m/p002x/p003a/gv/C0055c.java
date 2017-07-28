package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.view.View;
import p000c.p001m.p002x.p003a.gv.C0058e.C0053a;
import p000c.p001m.p002x.p003a.gv.C0060f.C0059a;

public final class C0055c extends av {

    public interface C0052a {
        void onRequestPermissionsResult(int i, String[] strArr, int[] iArr);
    }

    private static class C0054b extends C0053a {
        private at f222a;

        public C0054b(at atVar) {
            this.f222a = atVar;
        }

        public final Parcelable mo46a(View view, Matrix matrix, RectF rectF) {
            return this.f222a.m114a(view, matrix, rectF);
        }

        public final View mo47a(Context context, Parcelable parcelable) {
            at atVar = this.f222a;
            return at.m109a(context, parcelable);
        }

        public final void mo48a() {
            at atVar = this.f222a;
            at.m110a();
        }

        public final void mo49b() {
            at atVar = this.f222a;
            at.m111b();
        }

        public final void mo50c() {
            at atVar = this.f222a;
            at.m112c();
        }

        public final void mo51d() {
            at atVar = this.f222a;
            at.m113d();
        }
    }

    private static C0053a m252a(at atVar) {
        return atVar != null ? new C0054b(atVar) : null;
    }

    public static void m253a(Activity activity, Intent intent, int i, Bundle bundle) {
        if (VERSION.SDK_INT >= 16) {
            activity.startActivityForResult(intent, i, bundle);
        } else {
            activity.startActivityForResult(intent, i);
        }
    }

    public static void m254a(Activity activity, at atVar) {
        if (VERSION.SDK_INT >= 21) {
            C0058e.m263a(activity, C0055c.m252a(atVar));
        }
    }

    public static void m255a(Activity activity, String[] strArr, int i) {
        if (VERSION.SDK_INT >= 23) {
            if (activity instanceof C0059a) {
                ((C0059a) activity).validateRequestPermissionsRequestCode(i);
            }
            activity.requestPermissions(strArr, i);
        } else if (activity instanceof C0052a) {
            new Handler(Looper.getMainLooper()).post(new C0056d(strArr, activity, i));
        }
    }

    public static void m256b(Activity activity, at atVar) {
        if (VERSION.SDK_INT >= 21) {
            C0058e.m264b(activity, C0055c.m252a(atVar));
        }
    }
}
