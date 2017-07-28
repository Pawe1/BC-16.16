package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.os.Build.VERSION;
import android.util.AttributeSet;
import android.view.View;

abstract class C0070n extends C0069m {
    C0070n() {
    }

    public View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        View dispatchFragmentsOnCreateView = dispatchFragmentsOnCreateView(view, str, context, attributeSet);
        return (dispatchFragmentsOnCreateView != null || VERSION.SDK_INT < 11) ? dispatchFragmentsOnCreateView : super.onCreateView(view, str, context, attributeSet);
    }
}
