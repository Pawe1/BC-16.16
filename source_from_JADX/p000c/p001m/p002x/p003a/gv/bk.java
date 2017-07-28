package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.LayoutInflater.Factory2;
import android.view.View;
import java.lang.reflect.Field;
import p000c.p001m.p002x.p003a.gv.bj.C0033a;

final class bk {
    private static Field f166a;
    private static boolean f167b;

    static class C0034a extends C0033a implements Factory2 {
        C0034a(bl blVar) {
            super(blVar);
        }

        public final View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
            return this.a.mo23a(view, str, context, attributeSet);
        }
    }

    static void m185a(LayoutInflater layoutInflater, Factory2 factory2) {
        if (!f167b) {
            try {
                Field declaredField = LayoutInflater.class.getDeclaredField("mFactory2");
                f166a = declaredField;
                declaredField.setAccessible(true);
            } catch (Throwable e) {
                Log.e("LayoutInflaterCompatHC", "forceSetFactory2 Could not find field 'mFactory2' on class " + LayoutInflater.class.getName() + "; inflation may have unexpected results.", e);
            }
            f167b = true;
        }
        if (f166a != null) {
            try {
                f166a.set(layoutInflater, factory2);
            } catch (Throwable e2) {
                Log.e("LayoutInflaterCompatHC", "forceSetFactory2 could not set the Factory2 on LayoutInflater " + layoutInflater + "; inflation may have unexpected results.", e2);
            }
        }
    }
}
