package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.LayoutInflater.Factory2;
import android.view.View;
import java.lang.reflect.Field;
import p000c.p001m.p002x.p003a.gv.be.C0027a;

final class bf {
    private static Field f123a;
    private static boolean f124b;

    static class C0028a extends C0027a implements Factory2 {
        C0028a(bg bgVar) {
            super(bgVar);
        }

        public final View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
            return this.a.mo57a(view, str, context, attributeSet);
        }
    }

    static void m126a(LayoutInflater layoutInflater, Factory2 factory2) {
        if (!f124b) {
            try {
                Field declaredField = LayoutInflater.class.getDeclaredField("mFactory2");
                f123a = declaredField;
                declaredField.setAccessible(true);
            } catch (Throwable e) {
                Log.e("LayoutInflaterCompatHC", "forceSetFactory2 Could not find field 'mFactory2' on class " + LayoutInflater.class.getName() + "; inflation may have unexpected results.", e);
            }
            f124b = true;
        }
        if (f123a != null) {
            try {
                f123a.set(layoutInflater, factory2);
            } catch (Throwable e2) {
                Log.e("LayoutInflaterCompatHC", "forceSetFactory2 could not set the Factory2 on LayoutInflater " + layoutInflater + "; inflation may have unexpected results.", e2);
            }
        }
    }
}
