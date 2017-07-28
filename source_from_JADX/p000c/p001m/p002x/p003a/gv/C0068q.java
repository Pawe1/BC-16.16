package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0008a.C0005a;
import p000c.p001m.p002x.p003a.gv.C0047d.C0046a;

public class C0068q extends C0057l implements C0005a, C0046a {
    static final String FRAGMENTS_TAG = "android:support:fragments";
    private static final int HONEYCOMB = 11;
    static final int MSG_REALLY_STOPPED = 1;
    static final int MSG_RESUME_PENDING = 2;
    private static final String TAG = "FragmentActivity";
    boolean mCreated;
    final C0070t mFragments = C0070t.m263a(new C0066a(this));
    final Handler mHandler = new C0069r(this);
    boolean mOptionsMenuInvalidated;
    boolean mReallyStopped;
    boolean mRequestedPermissionsFromFragment;
    boolean mResumed;
    boolean mRetaining;
    boolean mStopped;

    class C0066a extends C0065u<C0068q> {
        final /* synthetic */ C0068q f260a;

        public C0066a(C0068q c0068q) {
            this.f260a = c0068q;
            super(c0068q);
        }

        public final View mo38a(int i) {
            return this.f260a.findViewById(i);
        }

        public final void mo40a(C0058n c0058n) {
            this.f260a.onAttachFragment(c0058n);
        }

        public final void mo41a(C0058n c0058n, Intent intent, int i) {
            this.f260a.startActivityFromFragment(c0058n, intent, i);
        }

        public final void mo42a(C0058n c0058n, String[] strArr, int i) {
            this.f260a.requestPermissionsFromFragment(c0058n, strArr, i);
        }

        public final void mo43a(String str, PrintWriter printWriter, String[] strArr) {
            this.f260a.dump(str, null, printWriter, strArr);
        }

        public final boolean mo39a() {
            Window window = this.f260a.getWindow();
            return (window == null || window.peekDecorView() == null) ? false : true;
        }

        public final boolean mo44a(String str) {
            return VERSION.SDK_INT >= 23 ? this.f260a.shouldShowRequestPermissionRationale(str) : false;
        }

        public final boolean mo45b() {
            return !this.f260a.isFinishing();
        }

        public final LayoutInflater mo46c() {
            return this.f260a.getLayoutInflater().cloneInContext(this.f260a);
        }

        public final void mo47d() {
            this.f260a.supportInvalidateOptionsMenu();
        }

        public final boolean mo48e() {
            return this.f260a.getWindow() != null;
        }

        public final int mo49f() {
            Window window = this.f260a.getWindow();
            return window == null ? 0 : window.getAttributes().windowAnimations;
        }

        public final /* bridge */ /* synthetic */ Object mo50g() {
            return this.f260a;
        }
    }

    static final class C0067b {
        Object f261a;
        List<C0058n> f262b;
        bb<String, am> f263c;

        C0067b() {
        }
    }

    private void dumpViewHierarchy(String str, PrintWriter printWriter, View view) {
        printWriter.print(str);
        if (view == null) {
            printWriter.println("null");
            return;
        }
        printWriter.println(C0068q.viewToString(view));
        if (view instanceof ViewGroup) {
            ViewGroup viewGroup = (ViewGroup) view;
            int childCount = viewGroup.getChildCount();
            if (childCount > 0) {
                String str2 = str + "  ";
                for (int i = 0; i < childCount; i++) {
                    dumpViewHierarchy(str2, printWriter, viewGroup.getChildAt(i));
                }
            }
        }
    }

    private void requestPermissionsFromFragment(C0058n c0058n, String[] strArr, int i) {
        if (i == -1) {
            C0008a.m14a(this, strArr, i);
        } else if ((i & -256) != 0) {
            throw new IllegalArgumentException("Can only use lower 8 bits for requestCode");
        } else {
            this.mRequestedPermissionsFromFragment = true;
            C0008a.m14a(this, strArr, ((c0058n.mIndex + 1) << 8) + (i & 255));
        }
    }

    private static String viewToString(View view) {
        char c = 'F';
        char c2 = '.';
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append(view.getClass().getName());
        stringBuilder.append('{');
        stringBuilder.append(Integer.toHexString(System.identityHashCode(view)));
        stringBuilder.append(' ');
        switch (view.getVisibility()) {
            case 0:
                stringBuilder.append('V');
                break;
            case 4:
                stringBuilder.append('I');
                break;
            case 8:
                stringBuilder.append('G');
                break;
            default:
                stringBuilder.append('.');
                break;
        }
        stringBuilder.append(view.isFocusable() ? 'F' : '.');
        stringBuilder.append(view.isEnabled() ? 'E' : '.');
        stringBuilder.append(view.willNotDraw() ? '.' : 'D');
        stringBuilder.append(view.isHorizontalScrollBarEnabled() ? 'H' : '.');
        stringBuilder.append(view.isVerticalScrollBarEnabled() ? 'V' : '.');
        stringBuilder.append(view.isClickable() ? 'C' : '.');
        stringBuilder.append(view.isLongClickable() ? 'L' : '.');
        stringBuilder.append(' ');
        if (!view.isFocused()) {
            c = '.';
        }
        stringBuilder.append(c);
        stringBuilder.append(view.isSelected() ? 'S' : '.');
        if (view.isPressed()) {
            c2 = 'P';
        }
        stringBuilder.append(c2);
        stringBuilder.append(' ');
        stringBuilder.append(view.getLeft());
        stringBuilder.append(',');
        stringBuilder.append(view.getTop());
        stringBuilder.append('-');
        stringBuilder.append(view.getRight());
        stringBuilder.append(',');
        stringBuilder.append(view.getBottom());
        int id = view.getId();
        if (id != -1) {
            stringBuilder.append(" #");
            stringBuilder.append(Integer.toHexString(id));
            Resources resources = view.getResources();
            if (!(id == 0 || resources == null)) {
                String str;
                switch (-16777216 & id) {
                    case 16777216:
                        str = "android";
                        break;
                    case 2130706432:
                        str = "app";
                        break;
                    default:
                        try {
                            str = resources.getResourcePackageName(id);
                            break;
                        } catch (NotFoundException e) {
                            break;
                        }
                }
                String resourceTypeName = resources.getResourceTypeName(id);
                String resourceEntryName = resources.getResourceEntryName(id);
                stringBuilder.append(" ");
                stringBuilder.append(str);
                stringBuilder.append(":");
                stringBuilder.append(resourceTypeName);
                stringBuilder.append("/");
                stringBuilder.append(resourceEntryName);
            }
        }
        stringBuilder.append("}");
        return stringBuilder.toString();
    }

    final View dispatchFragmentsOnCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        return this.mFragments.m264a(view, str, context, attributeSet);
    }

    void doReallyStop(boolean z) {
        if (!this.mReallyStopped) {
            this.mReallyStopped = true;
            this.mRetaining = z;
            this.mHandler.removeMessages(1);
            onReallyStop();
        }
    }

    public void dump(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        int i = VERSION.SDK_INT;
        printWriter.print(str);
        printWriter.print("Local FragmentActivity ");
        printWriter.print(Integer.toHexString(System.identityHashCode(this)));
        printWriter.println(" State:");
        String str2 = str + "  ";
        printWriter.print(str2);
        printWriter.print("mCreated=");
        printWriter.print(this.mCreated);
        printWriter.print("mResumed=");
        printWriter.print(this.mResumed);
        printWriter.print(" mStopped=");
        printWriter.print(this.mStopped);
        printWriter.print(" mReallyStopped=");
        printWriter.println(this.mReallyStopped);
        this.mFragments.m270a(str2, fileDescriptor, printWriter);
        this.mFragments.m265a().mo61a(str, fileDescriptor, printWriter, strArr);
        printWriter.print(str);
        printWriter.println("View Hierarchy:");
        dumpViewHierarchy(str + "  ", printWriter, getWindow().getDecorView());
    }

    public Object getLastCustomNonConfigurationInstance() {
        C0067b c0067b = (C0067b) getLastNonConfigurationInstance();
        return c0067b != null ? c0067b.f261a : null;
    }

    public C0071v getSupportFragmentManager() {
        return this.mFragments.m265a();
    }

    public am getSupportLoaderManager() {
        return this.mFragments.m275b();
    }

    protected void onActivityResult(int i, int i2, Intent intent) {
        this.mFragments.m280e();
        int i3 = i >> 16;
        if (i3 != 0) {
            i3--;
            int c = this.mFragments.m278c();
            if (c == 0 || i3 < 0 || i3 >= c) {
                Log.w(TAG, "Activity result fragment index out of range: 0x" + Integer.toHexString(i));
                return;
            }
            C0058n c0058n = (C0058n) this.mFragments.m266a(new ArrayList(c)).get(i3);
            if (c0058n == null) {
                Log.w(TAG, "Activity result no fragment exists for index: 0x" + Integer.toHexString(i));
                return;
            } else {
                c0058n.onActivityResult(65535 & i, i2, intent);
                return;
            }
        }
        super.onActivityResult(i, i2, intent);
    }

    public void onAttachFragment(C0058n c0058n) {
    }

    public void onBackPressed() {
        if (!this.mFragments.m265a().mo62b()) {
            supportFinishAfterTransition();
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.mFragments.m267a(configuration);
    }

    protected void onCreate(Bundle bundle) {
        this.mFragments.m279d();
        super.onCreate(bundle);
        C0067b c0067b = (C0067b) getLastNonConfigurationInstance();
        if (c0067b != null) {
            this.mFragments.m269a(c0067b.f263c);
        }
        if (bundle != null) {
            this.mFragments.m268a(bundle.getParcelable(FRAGMENTS_TAG), c0067b != null ? c0067b.f262b : null);
        }
        this.mFragments.m283h();
    }

    public boolean onCreatePanelMenu(int i, Menu menu) {
        if (i != 0) {
            return super.onCreatePanelMenu(i, menu);
        }
        return VERSION.SDK_INT >= 11 ? super.onCreatePanelMenu(i, menu) | this.mFragments.m273a(menu, getMenuInflater()) : true;
    }

    public /* bridge */ /* synthetic */ View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        return super.onCreateView(view, str, context, attributeSet);
    }

    public /* bridge */ /* synthetic */ View onCreateView(String str, Context context, AttributeSet attributeSet) {
        return super.onCreateView(str, context, attributeSet);
    }

    protected void onDestroy() {
        super.onDestroy();
        doReallyStop(false);
        this.mFragments.m290o();
        this.mFragments.m294s();
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (VERSION.SDK_INT >= 5 || i != 4 || keyEvent.getRepeatCount() != 0) {
            return super.onKeyDown(i, keyEvent);
        }
        onBackPressed();
        return true;
    }

    public void onLowMemory() {
        super.onLowMemory();
        this.mFragments.m291p();
    }

    public boolean onMenuItemSelected(int i, MenuItem menuItem) {
        if (super.onMenuItemSelected(i, menuItem)) {
            return true;
        }
        switch (i) {
            case 0:
                return this.mFragments.m274a(menuItem);
            case 6:
                return this.mFragments.m277b(menuItem);
            default:
                return false;
        }
    }

    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        this.mFragments.m280e();
    }

    public void onPanelClosed(int i, Menu menu) {
        switch (i) {
            case 0:
                this.mFragments.m276b(menu);
                break;
        }
        super.onPanelClosed(i, menu);
    }

    protected void onPause() {
        super.onPause();
        this.mResumed = false;
        if (this.mHandler.hasMessages(2)) {
            this.mHandler.removeMessages(2);
            onResumeFragments();
        }
        this.mFragments.m287l();
    }

    protected void onPostResume() {
        super.onPostResume();
        this.mHandler.removeMessages(2);
        onResumeFragments();
        this.mFragments.m292q();
    }

    protected boolean onPrepareOptionsPanel(View view, Menu menu) {
        return super.onPreparePanel(0, view, menu);
    }

    public boolean onPreparePanel(int i, View view, Menu menu) {
        if (i != 0 || menu == null) {
            return super.onPreparePanel(i, view, menu);
        }
        if (this.mOptionsMenuInvalidated) {
            this.mOptionsMenuInvalidated = false;
            menu.clear();
            onCreatePanelMenu(i, menu);
        }
        return onPrepareOptionsPanel(view, menu) | this.mFragments.m272a(menu);
    }

    void onReallyStop() {
        this.mFragments.m271a(this.mRetaining);
        this.mFragments.m289n();
    }

    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        int i2 = (i >> 8) & 255;
        if (i2 != 0) {
            i2--;
            int c = this.mFragments.m278c();
            if (c == 0 || i2 < 0 || i2 >= c) {
                Log.w(TAG, "Activity result fragment index out of range: 0x" + Integer.toHexString(i));
                return;
            }
            C0058n c0058n = (C0058n) this.mFragments.m266a(new ArrayList(c)).get(i2);
            if (c0058n == null) {
                Log.w(TAG, "Activity result no fragment exists for index: 0x" + Integer.toHexString(i));
            } else {
                c0058n.onRequestPermissionsResult(i & 255, strArr, iArr);
            }
        }
    }

    protected void onResume() {
        super.onResume();
        this.mHandler.sendEmptyMessage(2);
        this.mResumed = true;
        this.mFragments.m292q();
    }

    protected void onResumeFragments() {
        this.mFragments.m286k();
    }

    public Object onRetainCustomNonConfigurationInstance() {
        return null;
    }

    public final Object onRetainNonConfigurationInstance() {
        if (this.mStopped) {
            doReallyStop(true);
        }
        Object onRetainCustomNonConfigurationInstance = onRetainCustomNonConfigurationInstance();
        List g = this.mFragments.m282g();
        bb u = this.mFragments.m296u();
        if (g == null && u == null && onRetainCustomNonConfigurationInstance == null) {
            return null;
        }
        C0067b c0067b = new C0067b();
        c0067b.f261a = onRetainCustomNonConfigurationInstance;
        c0067b.f262b = g;
        c0067b.f263c = u;
        return c0067b;
    }

    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        Parcelable f = this.mFragments.m281f();
        if (f != null) {
            bundle.putParcelable(FRAGMENTS_TAG, f);
        }
    }

    protected void onStart() {
        super.onStart();
        this.mStopped = false;
        this.mReallyStopped = false;
        this.mHandler.removeMessages(1);
        if (!this.mCreated) {
            this.mCreated = true;
            this.mFragments.m284i();
        }
        this.mFragments.m280e();
        this.mFragments.m292q();
        this.mFragments.m293r();
        this.mFragments.m285j();
        this.mFragments.m295t();
    }

    public void onStateNotSaved() {
        this.mFragments.m280e();
    }

    protected void onStop() {
        super.onStop();
        this.mStopped = true;
        this.mHandler.sendEmptyMessage(1);
        this.mFragments.m288m();
    }

    public void setEnterSharedElementCallback(ap apVar) {
        C0008a.m13a(this, apVar);
    }

    public void setExitSharedElementCallback(ap apVar) {
        C0008a.m15b(this, apVar);
    }

    public void startActivityForResult(Intent intent, int i) {
        if (i == -1 || (-65536 & i) == 0) {
            super.startActivityForResult(intent, i);
            return;
        }
        throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
    }

    public void startActivityFromFragment(C0058n c0058n, Intent intent, int i) {
        if (i == -1) {
            super.startActivityForResult(intent, -1);
        } else if ((-65536 & i) != 0) {
            throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
        } else {
            super.startActivityForResult(intent, ((c0058n.mIndex + 1) << 16) + (65535 & i));
        }
    }

    public void supportFinishAfterTransition() {
        if (VERSION.SDK_INT >= 21) {
            finishAfterTransition();
        } else {
            finish();
        }
    }

    public void supportInvalidateOptionsMenu() {
        if (VERSION.SDK_INT >= 11) {
            invalidateOptionsMenu();
        } else {
            this.mOptionsMenuInvalidated = true;
        }
    }

    public void supportPostponeEnterTransition() {
        if (VERSION.SDK_INT >= 21) {
            postponeEnterTransition();
        }
    }

    public void supportStartPostponedEnterTransition() {
        if (VERSION.SDK_INT >= 21) {
            startPostponedEnterTransition();
        }
    }

    public final void validateRequestPermissionsRequestCode(int i) {
        if (this.mRequestedPermissionsFromFragment) {
            this.mRequestedPermissionsFromFragment = false;
        } else if ((i & -256) != 0) {
            throw new IllegalArgumentException("Can only use lower 8 bits for requestCode");
        }
    }
}
