package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.media.session.MediaController;
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
import p000c.p001m.p002x.p003a.gv.C0055c.C0052a;
import p000c.p001m.p002x.p003a.gv.C0060f.C0059a;

public class C0083u extends C0070n implements C0052a, C0059a {
    static final String ALLOCATED_REQUEST_INDICIES_TAG = "android:support:request_indicies";
    static final String FRAGMENTS_TAG = "android:support:fragments";
    private static final int HONEYCOMB = 11;
    static final int MAX_NUM_PENDING_FRAGMENT_ACTIVITY_RESULTS = 65534;
    static final int MSG_REALLY_STOPPED = 1;
    static final int MSG_RESUME_PENDING = 2;
    static final String NEXT_CANDIDATE_REQUEST_INDEX_TAG = "android:support:next_request_index";
    static final String REQUEST_FRAGMENT_WHO_TAG = "android:support:request_fragment_who";
    private static final String TAG = "FragmentActivity";
    boolean mCreated;
    final C0085x mFragments = C0085x.m341a(new C0081a(this));
    final Handler mHandler = new C0084v(this);
    az mMediaController;
    int mNextCandidateRequestIndex;
    boolean mOptionsMenuInvalidated;
    bh<String> mPendingFragmentActivityResults;
    boolean mReallyStopped;
    boolean mRequestedPermissionsFromFragment;
    boolean mResumed;
    boolean mRetaining;
    boolean mStartedActivityFromFragment;
    boolean mStopped;

    class C0081a extends C0080y<C0083u> {
        final /* synthetic */ C0083u f310a;

        public C0081a(C0083u c0083u) {
            this.f310a = c0083u;
            super(c0083u);
        }

        public final View mo67a(int i) {
            return this.f310a.findViewById(i);
        }

        public final void mo69a(C0073r c0073r) {
            this.f310a.onAttachFragment(c0073r);
        }

        public final void mo70a(C0073r c0073r, Intent intent, int i, Bundle bundle) {
            this.f310a.startActivityFromFragment(c0073r, intent, i, bundle);
        }

        public final void mo71a(C0073r c0073r, String[] strArr, int i) {
            this.f310a.requestPermissionsFromFragment(c0073r, strArr, i);
        }

        public final void mo72a(String str, PrintWriter printWriter, String[] strArr) {
            this.f310a.dump(str, null, printWriter, strArr);
        }

        public final boolean mo68a() {
            Window window = this.f310a.getWindow();
            return (window == null || window.peekDecorView() == null) ? false : true;
        }

        public final boolean mo73a(String str) {
            return VERSION.SDK_INT >= 23 ? this.f310a.shouldShowRequestPermissionRationale(str) : false;
        }

        public final boolean mo74b() {
            return !this.f310a.isFinishing();
        }

        public final LayoutInflater mo75c() {
            return this.f310a.getLayoutInflater().cloneInContext(this.f310a);
        }

        public final void mo76d() {
            this.f310a.supportInvalidateOptionsMenu();
        }

        public final boolean mo77e() {
            return this.f310a.getWindow() != null;
        }

        public final int mo78f() {
            Window window = this.f310a.getWindow();
            return window == null ? 0 : window.getAttributes().windowAnimations;
        }

        public final /* bridge */ /* synthetic */ Object mo79g() {
            return this.f310a;
        }
    }

    static final class C0082b {
        Object f311a;
        List<C0073r> f312b;
        bg<String, aq> f313c;

        C0082b() {
        }
    }

    private int allocateRequestIndex(C0073r c0073r) {
        if (this.mPendingFragmentActivityResults.m172a() >= MAX_NUM_PENDING_FRAGMENT_ACTIVITY_RESULTS) {
            throw new IllegalStateException("Too many pending Fragment activity results.");
        }
        while (this.mPendingFragmentActivityResults.m179e(this.mNextCandidateRequestIndex) >= 0) {
            this.mNextCandidateRequestIndex = (this.mNextCandidateRequestIndex + 1) % MAX_NUM_PENDING_FRAGMENT_ACTIVITY_RESULTS;
        }
        int i = this.mNextCandidateRequestIndex;
        this.mPendingFragmentActivityResults.m174a(i, c0073r.mWho);
        this.mNextCandidateRequestIndex = (this.mNextCandidateRequestIndex + 1) % MAX_NUM_PENDING_FRAGMENT_ACTIVITY_RESULTS;
        return i;
    }

    private void dumpViewHierarchy(String str, PrintWriter printWriter, View view) {
        printWriter.print(str);
        if (view == null) {
            printWriter.println("null");
            return;
        }
        printWriter.println(C0083u.viewToString(view));
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

    private void requestPermissionsFromFragment(C0073r c0073r, String[] strArr, int i) {
        if (i == -1) {
            C0055c.m255a(this, strArr, i);
        } else if ((i & -256) != 0) {
            throw new IllegalArgumentException("Can only use lower 8 bits for requestCode");
        } else {
            this.mRequestedPermissionsFromFragment = true;
            C0055c.m255a(this, strArr, ((c0073r.mIndex + 1) << 8) + (i & 255));
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
        return this.mFragments.m342a(view, str, context, attributeSet);
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
        this.mFragments.m349a(str2, fileDescriptor, printWriter);
        this.mFragments.m344a().mo27a(str, fileDescriptor, printWriter, strArr);
        printWriter.print(str);
        printWriter.println("View Hierarchy:");
        dumpViewHierarchy(str + "  ", printWriter, getWindow().getDecorView());
    }

    public Object getLastCustomNonConfigurationInstance() {
        C0082b c0082b = (C0082b) getLastNonConfigurationInstance();
        return c0082b != null ? c0082b.f311a : null;
    }

    public C0013z getSupportFragmentManager() {
        return this.mFragments.m344a();
    }

    public aq getSupportLoaderManager() {
        return this.mFragments.m354b();
    }

    public final az getSupportMediaController() {
        return this.mMediaController;
    }

    protected void onActivityResult(int i, int i2, Intent intent) {
        this.mFragments.m359e();
        int i3 = i >> 16;
        if (i3 != 0) {
            int i4 = i3 - 1;
            String str = (String) this.mPendingFragmentActivityResults.m173a(i4);
            this.mPendingFragmentActivityResults.m176b(i4);
            if (str == null) {
                Log.w(TAG, "Activity result delivered for unknown Fragment.");
                return;
            }
            C0073r a = this.mFragments.m343a(str);
            if (a == null) {
                Log.w(TAG, "Activity result no fragment exists for who: " + str);
                return;
            } else {
                a.onActivityResult(65535 & i, i2, intent);
                return;
            }
        }
        super.onActivityResult(i, i2, intent);
    }

    public void onAttachFragment(C0073r c0073r) {
    }

    public void onBackPressed() {
        if (!this.mFragments.m344a().mo28b()) {
            supportFinishAfterTransition();
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.mFragments.m346a(configuration);
    }

    protected void onCreate(Bundle bundle) {
        this.mFragments.m358d();
        super.onCreate(bundle);
        C0082b c0082b = (C0082b) getLastNonConfigurationInstance();
        if (c0082b != null) {
            this.mFragments.m348a(c0082b.f313c);
        }
        if (bundle != null) {
            this.mFragments.m347a(bundle.getParcelable(FRAGMENTS_TAG), c0082b != null ? c0082b.f312b : null);
            if (bundle.containsKey(NEXT_CANDIDATE_REQUEST_INDEX_TAG)) {
                this.mNextCandidateRequestIndex = bundle.getInt(NEXT_CANDIDATE_REQUEST_INDEX_TAG);
                int[] intArray = bundle.getIntArray(ALLOCATED_REQUEST_INDICIES_TAG);
                String[] stringArray = bundle.getStringArray(REQUEST_FRAGMENT_WHO_TAG);
                if (intArray == null || stringArray == null || intArray.length != stringArray.length) {
                    Log.w(TAG, "Invalid requestCode mapping in savedInstanceState.");
                } else {
                    this.mPendingFragmentActivityResults = new bh(intArray.length);
                    for (int i = 0; i < intArray.length; i++) {
                        this.mPendingFragmentActivityResults.m174a(intArray[i], stringArray[i]);
                    }
                }
            }
        }
        if (this.mPendingFragmentActivityResults == null) {
            this.mPendingFragmentActivityResults = new bh();
            this.mNextCandidateRequestIndex = 0;
        }
        this.mFragments.m362h();
    }

    public boolean onCreatePanelMenu(int i, Menu menu) {
        if (i != 0) {
            return super.onCreatePanelMenu(i, menu);
        }
        return VERSION.SDK_INT >= 11 ? super.onCreatePanelMenu(i, menu) | this.mFragments.m352a(menu, getMenuInflater()) : true;
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
        this.mFragments.m369o();
        this.mFragments.m373s();
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
        this.mFragments.m370p();
    }

    public boolean onMenuItemSelected(int i, MenuItem menuItem) {
        if (super.onMenuItemSelected(i, menuItem)) {
            return true;
        }
        switch (i) {
            case 0:
                return this.mFragments.m353a(menuItem);
            case 6:
                return this.mFragments.m356b(menuItem);
            default:
                return false;
        }
    }

    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        this.mFragments.m359e();
    }

    public void onPanelClosed(int i, Menu menu) {
        switch (i) {
            case 0:
                this.mFragments.m355b(menu);
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
        this.mFragments.m366l();
    }

    protected void onPostResume() {
        super.onPostResume();
        this.mHandler.removeMessages(2);
        onResumeFragments();
        this.mFragments.m371q();
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
        return onPrepareOptionsPanel(view, menu) | this.mFragments.m351a(menu);
    }

    void onReallyStop() {
        this.mFragments.m350a(this.mRetaining);
        this.mFragments.m368n();
    }

    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        int i2 = (i >> 8) & 255;
        if (i2 != 0) {
            i2--;
            int c = this.mFragments.m357c();
            if (c == 0 || i2 < 0 || i2 >= c) {
                Log.w(TAG, "Activity result fragment index out of range: 0x" + Integer.toHexString(i));
                return;
            }
            C0073r c0073r = (C0073r) this.mFragments.m345a(new ArrayList(c)).get(i2);
            if (c0073r == null) {
                Log.w(TAG, "Activity result no fragment exists for index: 0x" + Integer.toHexString(i));
            } else {
                c0073r.onRequestPermissionsResult(i & 255, strArr, iArr);
            }
        }
    }

    protected void onResume() {
        super.onResume();
        this.mHandler.sendEmptyMessage(2);
        this.mResumed = true;
        this.mFragments.m371q();
    }

    protected void onResumeFragments() {
        this.mFragments.m365k();
    }

    public Object onRetainCustomNonConfigurationInstance() {
        return null;
    }

    public final Object onRetainNonConfigurationInstance() {
        if (this.mStopped) {
            doReallyStop(true);
        }
        Object onRetainCustomNonConfigurationInstance = onRetainCustomNonConfigurationInstance();
        List g = this.mFragments.m361g();
        bg u = this.mFragments.m375u();
        if (g == null && u == null && onRetainCustomNonConfigurationInstance == null) {
            return null;
        }
        C0082b c0082b = new C0082b();
        c0082b.f311a = onRetainCustomNonConfigurationInstance;
        c0082b.f312b = g;
        c0082b.f313c = u;
        return c0082b;
    }

    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        Parcelable f = this.mFragments.m360f();
        if (f != null) {
            bundle.putParcelable(FRAGMENTS_TAG, f);
        }
        if (this.mPendingFragmentActivityResults.m172a() > 0) {
            bundle.putInt(NEXT_CANDIDATE_REQUEST_INDEX_TAG, this.mNextCandidateRequestIndex);
            int[] iArr = new int[this.mPendingFragmentActivityResults.m172a()];
            String[] strArr = new String[this.mPendingFragmentActivityResults.m172a()];
            for (int i = 0; i < this.mPendingFragmentActivityResults.m172a(); i++) {
                iArr[i] = this.mPendingFragmentActivityResults.m177c(i);
                strArr[i] = (String) this.mPendingFragmentActivityResults.m178d(i);
            }
            bundle.putIntArray(ALLOCATED_REQUEST_INDICIES_TAG, iArr);
            bundle.putStringArray(REQUEST_FRAGMENT_WHO_TAG, strArr);
        }
    }

    protected void onStart() {
        super.onStart();
        this.mStopped = false;
        this.mReallyStopped = false;
        this.mHandler.removeMessages(1);
        if (!this.mCreated) {
            this.mCreated = true;
            this.mFragments.m363i();
        }
        this.mFragments.m359e();
        this.mFragments.m371q();
        this.mFragments.m372r();
        this.mFragments.m364j();
        this.mFragments.m374t();
    }

    public void onStateNotSaved() {
        this.mFragments.m359e();
    }

    protected void onStop() {
        super.onStop();
        this.mStopped = true;
        this.mHandler.sendEmptyMessage(1);
        this.mFragments.m367m();
    }

    public void setEnterSharedElementCallback(at atVar) {
        C0055c.m254a(this, atVar);
    }

    public void setExitSharedElementCallback(at atVar) {
        C0055c.m256b(this, atVar);
    }

    public final void setSupportMediaController(az azVar) {
        this.mMediaController = azVar;
        if (VERSION.SDK_INT >= 21) {
            setMediaController((MediaController) azVar.m129a());
        }
    }

    public void startActivityForResult(Intent intent, int i) {
        if (this.mStartedActivityFromFragment || i == -1 || (-65536 & i) == 0) {
            super.startActivityForResult(intent, i);
            return;
        }
        throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
    }

    public void startActivityFromFragment(C0073r c0073r, Intent intent, int i) {
        startActivityFromFragment(c0073r, intent, i, null);
    }

    public void startActivityFromFragment(C0073r c0073r, Intent intent, int i, Bundle bundle) {
        this.mStartedActivityFromFragment = true;
        if (i == -1) {
            try {
                C0055c.m253a(this, intent, -1, bundle);
            } finally {
                this.mStartedActivityFromFragment = false;
            }
        } else if ((-65536 & i) != 0) {
            throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
        } else {
            C0055c.m253a(this, intent, ((allocateRequestIndex(c0073r) + 1) << 16) + (65535 & i), bundle);
            this.mStartedActivityFromFragment = false;
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
