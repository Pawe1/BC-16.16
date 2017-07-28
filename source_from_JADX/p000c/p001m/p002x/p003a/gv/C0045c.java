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

final class C0045c {

    public static abstract class C0006a {
        public abstract Parcelable mo1a(View view, Matrix matrix, RectF rectF);

        public abstract View mo2a(Context context, Parcelable parcelable);

        public abstract void mo3a();

        public abstract void mo4b();

        public abstract void mo5c();

        public abstract void mo6d();
    }

    private static class C0044b extends SharedElementCallback {
        private C0006a f186a;

        public C0044b(C0006a c0006a) {
            this.f186a = c0006a;
        }

        public final Parcelable onCaptureSharedElementSnapshot(View view, Matrix matrix, RectF rectF) {
            return this.f186a.mo1a(view, matrix, rectF);
        }

        public final View onCreateSnapshotView(Context context, Parcelable parcelable) {
            return this.f186a.mo2a(context, parcelable);
        }

        public final void onMapSharedElements(List<String> list, Map<String, View> map) {
            this.f186a.mo6d();
        }

        public final void onRejectSharedElements(List<View> list) {
            this.f186a.mo5c();
        }

        public final void onSharedElementEnd(List<String> list, List<View> list2, List<View> list3) {
            this.f186a.mo4b();
        }

        public final void onSharedElementStart(List<String> list, List<View> list2, List<View> list3) {
            this.f186a.mo3a();
        }
    }

    private static SharedElementCallback m187a(C0006a c0006a) {
        return c0006a != null ? new C0044b(c0006a) : null;
    }

    public static void m188a(Activity activity, C0006a c0006a) {
        activity.setEnterSharedElementCallback(C0045c.m187a(c0006a));
    }

    public static void m189b(Activity activity, C0006a c0006a) {
        activity.setExitSharedElementCallback(C0045c.m187a(c0006a));
    }
}
