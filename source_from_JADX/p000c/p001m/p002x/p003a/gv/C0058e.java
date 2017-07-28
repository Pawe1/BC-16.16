package p000c.p001m.p002x.p003a.gv;

import android.app.Activity;
import android.app.SharedElementCallback;
import android.content.Context;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.Parcelable;
import android.view.View;
import java.util.List;
import java.util.Map;

final class C0058e {

    public static abstract class C0053a {
        public abstract Parcelable mo46a(View view, Matrix matrix, RectF rectF);

        public abstract View mo47a(Context context, Parcelable parcelable);

        public abstract void mo48a();

        public abstract void mo49b();

        public abstract void mo50c();

        public abstract void mo51d();
    }

    private static class C0057b extends SharedElementCallback {
        private C0053a f233a;

        public C0057b(C0053a c0053a) {
            this.f233a = c0053a;
        }

        public final Parcelable onCaptureSharedElementSnapshot(View view, Matrix matrix, RectF rectF) {
            return this.f233a.mo46a(view, matrix, rectF);
        }

        public final View onCreateSnapshotView(Context context, Parcelable parcelable) {
            return this.f233a.mo47a(context, parcelable);
        }

        public final void onMapSharedElements(List<String> list, Map<String, View> map) {
            this.f233a.mo51d();
        }

        public final void onRejectSharedElements(List<View> list) {
            this.f233a.mo50c();
        }

        public final void onSharedElementEnd(List<String> list, List<View> list2, List<View> list3) {
            this.f233a.mo49b();
        }

        public final void onSharedElementStart(List<String> list, List<View> list2, List<View> list3) {
            this.f233a.mo48a();
        }
    }

    private static SharedElementCallback m262a(C0053a c0053a) {
        return c0053a != null ? new C0057b(c0053a) : null;
    }

    public static void m263a(Activity activity, C0053a c0053a) {
        activity.setEnterSharedElementCallback(C0058e.m262a(c0053a));
    }

    public static void m264b(Activity activity, C0053a c0053a) {
        activity.setExitSharedElementCallback(C0058e.m262a(c0053a));
    }
}
