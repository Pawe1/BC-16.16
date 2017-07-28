package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.FragmentManager.OnBackStackChangedListener;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.ScaleAnimation;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0050e.C0049b;

final class C0074w extends C0071v implements bg {
    static final Interpolator f269A = new DecelerateInterpolator(1.5f);
    static final Interpolator f270B = new AccelerateInterpolator(2.5f);
    static final Interpolator f271C = new AccelerateInterpolator(1.5f);
    static boolean f272a = false;
    static final boolean f273b;
    static final Interpolator f274z = new DecelerateInterpolator(2.5f);
    ArrayList<Runnable> f275c;
    Runnable[] f276d;
    boolean f277e;
    ArrayList<C0058n> f278f;
    ArrayList<C0058n> f279g;
    ArrayList<Integer> f280h;
    ArrayList<C0050e> f281i;
    ArrayList<C0058n> f282j;
    ArrayList<C0050e> f283k;
    ArrayList<Integer> f284l;
    ArrayList<OnBackStackChangedListener> f285m;
    int f286n = 0;
    C0065u f287o;
    C0062s f288p;
    C0058n f289q;
    boolean f290r;
    boolean f291s;
    boolean f292t;
    String f293u;
    boolean f294v;
    Bundle f295w = null;
    SparseArray<Parcelable> f296x = null;
    Runnable f297y = new C0075x(this);

    static class C0072a implements AnimationListener {
        private boolean f266a = false;
        private View f267b;

        public C0072a(View view, Animation animation) {
            if (view != null && animation != null) {
                this.f267b = view;
            }
        }

        public void onAnimationEnd(Animation animation) {
            if (this.f266a) {
                this.f267b.post(new ab(this));
            }
        }

        public void onAnimationRepeat(Animation animation) {
        }

        public void onAnimationStart(Animation animation) {
            this.f266a = C0074w.m309a(this.f267b, animation);
            if (this.f266a) {
                this.f267b.post(new aa(this));
            }
        }
    }

    static class C0073b {
        public static final int[] f268a = new int[]{16842755, 16842960, 16842961};
    }

    static {
        boolean z = false;
        if (VERSION.SDK_INT >= 11) {
            z = true;
        }
        f273b = z;
    }

    C0074w() {
    }

    private static Animation m303a(float f, float f2) {
        Animation alphaAnimation = new AlphaAnimation(f, f2);
        alphaAnimation.setInterpolator(f269A);
        alphaAnimation.setDuration(220);
        return alphaAnimation;
    }

    private static Animation m304a(float f, float f2, float f3, float f4) {
        Animation animationSet = new AnimationSet(false);
        Animation scaleAnimation = new ScaleAnimation(f, f2, f, f2, 1, 0.5f, 1, 0.5f);
        scaleAnimation.setInterpolator(f274z);
        scaleAnimation.setDuration(220);
        animationSet.addAnimation(scaleAnimation);
        scaleAnimation = new AlphaAnimation(f3, f4);
        scaleAnimation.setInterpolator(f269A);
        scaleAnimation.setDuration(220);
        animationSet.addAnimation(scaleAnimation);
        return animationSet;
    }

    private Animation m305a(C0058n c0058n, int i, boolean z, int i2) {
        Animation onCreateAnimation = c0058n.onCreateAnimation(i, z, c0058n.mNextAnim);
        if (onCreateAnimation != null) {
            return onCreateAnimation;
        }
        if (c0058n.mNextAnim != 0) {
            onCreateAnimation = AnimationUtils.loadAnimation(this.f287o.f252b, c0058n.mNextAnim);
            if (onCreateAnimation != null) {
                return onCreateAnimation;
            }
        }
        if (i == 0) {
            return null;
        }
        Object obj = -1;
        switch (i) {
            case 4097:
                if (!z) {
                    obj = 2;
                    break;
                }
                obj = 1;
                break;
            case 4099:
                if (!z) {
                    obj = 6;
                    break;
                }
                obj = 5;
                break;
            case 8194:
                if (!z) {
                    obj = 4;
                    break;
                }
                obj = 3;
                break;
        }
        if (obj < null) {
            return null;
        }
        Context context;
        switch (obj) {
            case 1:
                context = this.f287o.f252b;
                return C0074w.m304a(1.125f, 1.0f, 0.0f, 1.0f);
            case 2:
                context = this.f287o.f252b;
                return C0074w.m304a(1.0f, 0.975f, 1.0f, 0.0f);
            case 3:
                context = this.f287o.f252b;
                return C0074w.m304a(0.975f, 1.0f, 0.0f, 1.0f);
            case 4:
                context = this.f287o.f252b;
                return C0074w.m304a(1.0f, 1.075f, 1.0f, 0.0f);
            case 5:
                context = this.f287o.f252b;
                return C0074w.m303a(0.0f, 1.0f);
            case 6:
                context = this.f287o.f252b;
                return C0074w.m303a(1.0f, 0.0f);
            default:
                if (i2 == 0 && this.f287o.mo48e()) {
                    i2 = this.f287o.mo49f();
                }
                return i2 == 0 ? null : null;
        }
    }

    private C0058n m306a(Bundle bundle, String str) {
        int i = bundle.getInt(str, -1);
        if (i == -1) {
            return null;
        }
        if (i >= this.f278f.size()) {
            m308a(new IllegalStateException("Fragment no longer exists for key " + str + ": index " + i));
        }
        C0058n c0058n = (C0058n) this.f278f.get(i);
        if (c0058n != null) {
            return c0058n;
        }
        m308a(new IllegalStateException("Fragment no longer exists for key " + str + ": index " + i));
        return c0058n;
    }

    private void m307a(int i, C0050e c0050e) {
        synchronized (this) {
            if (this.f283k == null) {
                this.f283k = new ArrayList();
            }
            int size = this.f283k.size();
            if (i < size) {
                if (f272a) {
                    Log.v("FragmentManager", "Setting back stack index " + i + " to " + c0050e);
                }
                this.f283k.set(i, c0050e);
            } else {
                while (size < i) {
                    this.f283k.add(null);
                    if (this.f284l == null) {
                        this.f284l = new ArrayList();
                    }
                    if (f272a) {
                        Log.v("FragmentManager", "Adding available back stack index " + size);
                    }
                    this.f284l.add(Integer.valueOf(size));
                    size++;
                }
                if (f272a) {
                    Log.v("FragmentManager", "Adding back stack index " + i + " with " + c0050e);
                }
                this.f283k.add(c0050e);
            }
        }
    }

    private void m308a(RuntimeException runtimeException) {
        Log.e("FragmentManager", runtimeException.getMessage());
        Log.e("FragmentManager", "Activity state:");
        PrintWriter printWriter = new PrintWriter(new az("FragmentManager"));
        if (this.f287o != null) {
            try {
                this.f287o.mo43a("  ", printWriter, new String[0]);
            } catch (Throwable e) {
                Log.e("FragmentManager", "Failed dumping state", e);
            }
        } else {
            try {
                mo61a("  ", null, printWriter, new String[0]);
            } catch (Throwable e2) {
                Log.e("FragmentManager", "Failed dumping state", e2);
            }
        }
        throw runtimeException;
    }

    static boolean m309a(View view, Animation animation) {
        if (bh.m140a(view) != 0 || !bh.m143c(view)) {
            return false;
        }
        boolean z;
        if (animation instanceof AlphaAnimation) {
            z = true;
        } else {
            if (animation instanceof AnimationSet) {
                List animations = ((AnimationSet) animation).getAnimations();
                for (int i = 0; i < animations.size(); i++) {
                    if (animations.get(i) instanceof AlphaAnimation) {
                        z = true;
                        break;
                    }
                }
            }
            z = false;
        }
        return z;
    }

    private static void m310b(View view, Animation animation) {
        if (view != null && animation != null && C0074w.m309a(view, animation)) {
            animation.setAnimationListener(new C0072a(view, animation));
        }
    }

    private void m311b(C0058n c0058n) {
        m329a(c0058n, this.f286n, 0, 0, false);
    }

    public static int m312c(int i) {
        switch (i) {
            case 4097:
                return 8194;
            case 4099:
                return 4099;
            case 8194:
                return 4097;
            default:
                return 0;
        }
    }

    private void m313c(C0058n c0058n) {
        if (c0058n.mInnerView != null) {
            if (this.f296x == null) {
                this.f296x = new SparseArray();
            } else {
                this.f296x.clear();
            }
            c0058n.mInnerView.saveHierarchyState(this.f296x);
            if (this.f296x.size() > 0) {
                c0058n.mSavedViewState = this.f296x;
                this.f296x = null;
            }
        }
    }

    private void m314d(int i) {
        m324a(i, 0, 0, false);
    }

    private C0058n m315e(int i) {
        int size;
        C0058n c0058n;
        if (this.f279g != null) {
            for (size = this.f279g.size() - 1; size >= 0; size--) {
                c0058n = (C0058n) this.f279g.get(size);
                if (c0058n != null && c0058n.mFragmentId == i) {
                    return c0058n;
                }
            }
        }
        if (this.f278f != null) {
            for (size = this.f278f.size() - 1; size >= 0; size--) {
                c0058n = (C0058n) this.f278f.get(size);
                if (c0058n != null && c0058n.mFragmentId == i) {
                    return c0058n;
                }
            }
        }
        return null;
    }

    private void m316r() {
        if (this.f278f != null) {
            for (int i = 0; i < this.f278f.size(); i++) {
                C0058n c0058n = (C0058n) this.f278f.get(i);
                if (c0058n != null) {
                    m327a(c0058n);
                }
            }
        }
    }

    private void m317s() {
        if (this.f291s) {
            throw new IllegalStateException("Can not perform this action after onSaveInstanceState");
        } else if (this.f293u != null) {
            throw new IllegalStateException("Can not perform this action inside of " + this.f293u);
        }
    }

    private void m318t() {
        if (this.f285m != null) {
            for (int i = 0; i < this.f285m.size(); i++) {
                this.f285m.get(i);
            }
        }
    }

    public final int m319a(C0050e c0050e) {
        int size;
        synchronized (this) {
            if (this.f284l == null || this.f284l.size() <= 0) {
                if (this.f283k == null) {
                    this.f283k = new ArrayList();
                }
                size = this.f283k.size();
                if (f272a) {
                    Log.v("FragmentManager", "Setting back stack index " + size + " to " + c0050e);
                }
                this.f283k.add(c0050e);
            } else {
                size = ((Integer) this.f284l.remove(this.f284l.size() - 1)).intValue();
                if (f272a) {
                    Log.v("FragmentManager", "Adding back stack index " + size + " with " + c0050e);
                }
                this.f283k.set(size, c0050e);
            }
        }
        return size;
    }

    public final View mo57a(View view, String str, Context context, AttributeSet attributeSet) {
        if (!"fragment".equals(str)) {
            return null;
        }
        String attributeValue = attributeSet.getAttributeValue(null, "class");
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, C0073b.f268a);
        String string = attributeValue == null ? obtainStyledAttributes.getString(0) : attributeValue;
        int resourceId = obtainStyledAttributes.getResourceId(1, -1);
        String string2 = obtainStyledAttributes.getString(2);
        obtainStyledAttributes.recycle();
        if (!C0058n.isSupportFragmentClass(this.f287o.f252b, string)) {
            return null;
        }
        int id = view != null ? view.getId() : 0;
        if (id == -1 && resourceId == -1 && string2 == null) {
            throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Must specify unique android:id, android:tag, or have a parent with an id for " + string);
        }
        C0058n c0058n;
        C0058n e = resourceId != -1 ? m315e(resourceId) : null;
        if (e == null && string2 != null) {
            e = mo59a(string2);
        }
        if (e == null && id != -1) {
            e = m315e(id);
        }
        if (f272a) {
            Log.v("FragmentManager", "onCreateView: id=0x" + Integer.toHexString(resourceId) + " fname=" + string + " existing=" + e);
        }
        if (e == null) {
            C0058n instantiate = C0058n.instantiate(context, string);
            instantiate.mFromLayout = true;
            instantiate.mFragmentId = resourceId != 0 ? resourceId : id;
            instantiate.mContainerId = id;
            instantiate.mTag = string2;
            instantiate.mInLayout = true;
            instantiate.mFragmentManager = this;
            instantiate.mHost = this.f287o;
            instantiate.onInflate(this.f287o.f252b, attributeSet, instantiate.mSavedFragmentState);
            m330a(instantiate, true);
            c0058n = instantiate;
        } else if (e.mInLayout) {
            throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Duplicate id 0x" + Integer.toHexString(resourceId) + ", tag " + string2 + ", or parent id 0x" + Integer.toHexString(id) + " with another fragment for " + string);
        } else {
            e.mInLayout = true;
            if (!e.mRetaining) {
                e.onInflate(this.f287o.f252b, attributeSet, e.mSavedFragmentState);
            }
            c0058n = e;
        }
        if (this.f286n > 0 || !c0058n.mFromLayout) {
            m311b(c0058n);
        } else {
            m329a(c0058n, 1, 0, 0, false);
        }
        if (c0058n.mView == null) {
            throw new IllegalStateException("Fragment " + string + " did not create a view.");
        }
        if (resourceId != 0) {
            c0058n.mView.setId(resourceId);
        }
        if (c0058n.mView.getTag() == null) {
            c0058n.mView.setTag(string2);
        }
        return c0058n.mView;
    }

    public final ag mo58a() {
        return new C0050e(this);
    }

    public final C0058n mo59a(String str) {
        int size;
        C0058n c0058n;
        if (!(this.f279g == null || str == null)) {
            for (size = this.f279g.size() - 1; size >= 0; size--) {
                c0058n = (C0058n) this.f279g.get(size);
                if (c0058n != null && str.equals(c0058n.mTag)) {
                    return c0058n;
                }
            }
        }
        if (!(this.f278f == null || str == null)) {
            for (size = this.f278f.size() - 1; size >= 0; size--) {
                c0058n = (C0058n) this.f278f.get(size);
                if (c0058n != null && str.equals(c0058n.mTag)) {
                    return c0058n;
                }
            }
        }
        return null;
    }

    public final void mo60a(int i) {
        if (i < 0) {
            throw new IllegalArgumentException("Bad id: " + i);
        }
        m332a(new C0076y(this, i), false);
    }

    final void m324a(int i, int i2, int i3, boolean z) {
        if (this.f287o == null && i != 0) {
            throw new IllegalStateException("No host");
        } else if (z || this.f286n != i) {
            this.f286n = i;
            if (this.f278f != null) {
                int i4 = 0;
                int i5 = 0;
                while (i4 < this.f278f.size()) {
                    int a;
                    C0058n c0058n = (C0058n) this.f278f.get(i4);
                    if (c0058n != null) {
                        m329a(c0058n, i, i2, i3, false);
                        if (c0058n.mLoaderManager != null) {
                            a = i5 | c0058n.mLoaderManager.mo7a();
                            i4++;
                            i5 = a;
                        }
                    }
                    a = i5;
                    i4++;
                    i5 = a;
                }
                if (i5 == 0) {
                    m316r();
                }
                if (this.f290r && this.f287o != null && this.f286n == 5) {
                    this.f287o.mo47d();
                    this.f290r = false;
                }
            }
        }
    }

    public final void m325a(Configuration configuration) {
        if (this.f279g != null) {
            for (int i = 0; i < this.f279g.size(); i++) {
                C0058n c0058n = (C0058n) this.f279g.get(i);
                if (c0058n != null) {
                    c0058n.performConfigurationChanged(configuration);
                }
            }
        }
    }

    final void m326a(Parcelable parcelable, List<C0058n> list) {
        if (parcelable != null) {
            ac acVar = (ac) parcelable;
            if (acVar.f3a != null) {
                int i;
                C0058n c0058n;
                int i2;
                if (list != null) {
                    for (i = 0; i < list.size(); i++) {
                        c0058n = (C0058n) list.get(i);
                        if (f272a) {
                            Log.v("FragmentManager", "restoreAllState: re-attaching retained " + c0058n);
                        }
                        ae aeVar = acVar.f3a[c0058n.mIndex];
                        aeVar.f16k = c0058n;
                        c0058n.mSavedViewState = null;
                        c0058n.mBackStackNesting = 0;
                        c0058n.mInLayout = false;
                        c0058n.mAdded = false;
                        c0058n.mTarget = null;
                        if (aeVar.f15j != null) {
                            aeVar.f15j.setClassLoader(this.f287o.f252b.getClassLoader());
                            c0058n.mSavedViewState = aeVar.f15j.getSparseParcelableArray("android:view_state");
                            c0058n.mSavedFragmentState = aeVar.f15j;
                        }
                    }
                }
                this.f278f = new ArrayList(acVar.f3a.length);
                if (this.f280h != null) {
                    this.f280h.clear();
                }
                for (i2 = 0; i2 < acVar.f3a.length; i2++) {
                    ae aeVar2 = acVar.f3a[i2];
                    if (aeVar2 != null) {
                        C0058n a = aeVar2.m16a(this.f287o, this.f289q);
                        if (f272a) {
                            Log.v("FragmentManager", "restoreAllState: active #" + i2 + ": " + a);
                        }
                        this.f278f.add(a);
                        aeVar2.f16k = null;
                    } else {
                        this.f278f.add(null);
                        if (this.f280h == null) {
                            this.f280h = new ArrayList();
                        }
                        if (f272a) {
                            Log.v("FragmentManager", "restoreAllState: avail #" + i2);
                        }
                        this.f280h.add(Integer.valueOf(i2));
                    }
                }
                if (list != null) {
                    for (int i3 = 0; i3 < list.size(); i3++) {
                        c0058n = (C0058n) list.get(i3);
                        if (c0058n.mTargetIndex >= 0) {
                            if (c0058n.mTargetIndex < this.f278f.size()) {
                                c0058n.mTarget = (C0058n) this.f278f.get(c0058n.mTargetIndex);
                            } else {
                                Log.w("FragmentManager", "Re-attaching retained fragment " + c0058n + " target no longer exists: " + c0058n.mTargetIndex);
                                c0058n.mTarget = null;
                            }
                        }
                    }
                }
                if (acVar.f4b != null) {
                    this.f279g = new ArrayList(acVar.f4b.length);
                    for (i = 0; i < acVar.f4b.length; i++) {
                        c0058n = (C0058n) this.f278f.get(acVar.f4b[i]);
                        if (c0058n == null) {
                            m308a(new IllegalStateException("No instantiated fragment for index #" + acVar.f4b[i]));
                        }
                        c0058n.mAdded = true;
                        if (f272a) {
                            Log.v("FragmentManager", "restoreAllState: added #" + i + ": " + c0058n);
                        }
                        if (this.f279g.contains(c0058n)) {
                            throw new IllegalStateException("Already added!");
                        }
                        this.f279g.add(c0058n);
                    }
                } else {
                    this.f279g = null;
                }
                if (acVar.f5c != null) {
                    this.f281i = new ArrayList(acVar.f5c.length);
                    for (i2 = 0; i2 < acVar.f5c.length; i2++) {
                        C0050e a2 = acVar.f5c[i2].m220a(this);
                        if (f272a) {
                            Log.v("FragmentManager", "restoreAllState: back stack #" + i2 + " (index " + a2.f216p + "): " + a2);
                            a2.m217a("  ", new PrintWriter(new az("FragmentManager")), false);
                        }
                        this.f281i.add(a2);
                        if (a2.f216p >= 0) {
                            m307a(a2.f216p, a2);
                        }
                    }
                    return;
                }
                this.f281i = null;
            }
        }
    }

    public final void m327a(C0058n c0058n) {
        if (!c0058n.mDeferStart) {
            return;
        }
        if (this.f277e) {
            this.f294v = true;
            return;
        }
        c0058n.mDeferStart = false;
        m329a(c0058n, this.f286n, 0, 0, false);
    }

    public final void m328a(C0058n c0058n, int i, int i2) {
        if (f272a) {
            Log.v("FragmentManager", "remove: " + c0058n + " nesting=" + c0058n.mBackStackNesting);
        }
        boolean z = !c0058n.isInBackStack();
        if (!c0058n.mDetached || z) {
            if (this.f279g != null) {
                this.f279g.remove(c0058n);
            }
            if (c0058n.mHasMenu && c0058n.mMenuVisible) {
                this.f290r = true;
            }
            c0058n.mAdded = false;
            c0058n.mRemoving = true;
            m329a(c0058n, z ? 0 : 1, i, i2, false);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    final void m329a(p000c.p001m.p002x.p003a.gv.C0058n r10, int r11, int r12, int r13, boolean r14) {
        /*
        r9 = this;
        r8 = 4;
        r6 = 3;
        r3 = 0;
        r5 = 1;
        r7 = 0;
        r0 = r10.mAdded;
        if (r0 == 0) goto L_0x000d;
    L_0x0009:
        r0 = r10.mDetached;
        if (r0 == 0) goto L_0x0010;
    L_0x000d:
        if (r11 <= r5) goto L_0x0010;
    L_0x000f:
        r11 = r5;
    L_0x0010:
        r0 = r10.mRemoving;
        if (r0 == 0) goto L_0x001a;
    L_0x0014:
        r0 = r10.mState;
        if (r11 <= r0) goto L_0x001a;
    L_0x0018:
        r11 = r10.mState;
    L_0x001a:
        r0 = r10.mDeferStart;
        if (r0 == 0) goto L_0x0025;
    L_0x001e:
        r0 = r10.mState;
        if (r0 >= r8) goto L_0x0025;
    L_0x0022:
        if (r11 <= r6) goto L_0x0025;
    L_0x0024:
        r11 = r6;
    L_0x0025:
        r0 = r10.mState;
        if (r0 >= r11) goto L_0x0256;
    L_0x0029:
        r0 = r10.mFromLayout;
        if (r0 == 0) goto L_0x0032;
    L_0x002d:
        r0 = r10.mInLayout;
        if (r0 != 0) goto L_0x0032;
    L_0x0031:
        return;
    L_0x0032:
        r0 = r10.mAnimatingAway;
        if (r0 == 0) goto L_0x0040;
    L_0x0036:
        r10.mAnimatingAway = r7;
        r2 = r10.mStateAfterAnimating;
        r0 = r9;
        r1 = r10;
        r4 = r3;
        r0.m329a(r1, r2, r3, r4, r5);
    L_0x0040:
        r0 = r10.mState;
        switch(r0) {
            case 0: goto L_0x0048;
            case 1: goto L_0x0130;
            case 2: goto L_0x01f9;
            case 3: goto L_0x01f9;
            case 4: goto L_0x0216;
            default: goto L_0x0045;
        };
    L_0x0045:
        r10.mState = r11;
        goto L_0x0031;
    L_0x0048:
        r0 = f272a;
        if (r0 == 0) goto L_0x0060;
    L_0x004c:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0060:
        r0 = r10.mSavedFragmentState;
        if (r0 == 0) goto L_0x00a6;
    L_0x0064:
        r0 = r10.mSavedFragmentState;
        r1 = r9.f287o;
        r1 = r1.f252b;
        r1 = r1.getClassLoader();
        r0.setClassLoader(r1);
        r0 = r10.mSavedFragmentState;
        r1 = "android:view_state";
        r0 = r0.getSparseParcelableArray(r1);
        r10.mSavedViewState = r0;
        r0 = r10.mSavedFragmentState;
        r1 = "android:target_state";
        r0 = r9.m306a(r0, r1);
        r10.mTarget = r0;
        r0 = r10.mTarget;
        if (r0 == 0) goto L_0x0093;
    L_0x0089:
        r0 = r10.mSavedFragmentState;
        r1 = "android:target_req_state";
        r0 = r0.getInt(r1, r3);
        r10.mTargetRequestCode = r0;
    L_0x0093:
        r0 = r10.mSavedFragmentState;
        r1 = "android:user_visible_hint";
        r0 = r0.getBoolean(r1, r5);
        r10.mUserVisibleHint = r0;
        r0 = r10.mUserVisibleHint;
        if (r0 != 0) goto L_0x00a6;
    L_0x00a1:
        r10.mDeferStart = r5;
        if (r11 <= r6) goto L_0x00a6;
    L_0x00a5:
        r11 = r6;
    L_0x00a6:
        r0 = r9.f287o;
        r10.mHost = r0;
        r0 = r9.f289q;
        r10.mParentFragment = r0;
        r0 = r9.f289q;
        if (r0 == 0) goto L_0x00e0;
    L_0x00b2:
        r0 = r9.f289q;
        r0 = r0.mChildFragmentManager;
    L_0x00b6:
        r10.mFragmentManager = r0;
        r10.mCalled = r3;
        r0 = r9.f287o;
        r0 = r0.f252b;
        r10.onAttach(r0);
        r0 = r10.mCalled;
        if (r0 != 0) goto L_0x00e5;
    L_0x00c5:
        r0 = new c.m.x.a.gv.aq;
        r1 = new java.lang.StringBuilder;
        r2 = "Fragment ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r2 = " did not call through to super.onAttach()";
        r1 = r1.append(r2);
        r1 = r1.toString();
        r0.<init>(r1);
        throw r0;
    L_0x00e0:
        r0 = r9.f287o;
        r0 = r0.f254d;
        goto L_0x00b6;
    L_0x00e5:
        r0 = r10.mParentFragment;
        if (r0 != 0) goto L_0x00ee;
    L_0x00e9:
        r0 = r9.f287o;
        r0.mo40a(r10);
    L_0x00ee:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x00f7;
    L_0x00f2:
        r0 = r10.mSavedFragmentState;
        r10.performCreate(r0);
    L_0x00f7:
        r10.mRetaining = r3;
        r0 = r10.mFromLayout;
        if (r0 == 0) goto L_0x0130;
    L_0x00fd:
        r0 = r10.mSavedFragmentState;
        r0 = r10.getLayoutInflater(r0);
        r1 = r10.mSavedFragmentState;
        r0 = r10.performCreateView(r0, r7, r1);
        r10.mView = r0;
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0245;
    L_0x010f:
        r0 = r10.mView;
        r10.mInnerView = r0;
        r0 = android.os.Build.VERSION.SDK_INT;
        r1 = 11;
        if (r0 < r1) goto L_0x023b;
    L_0x0119:
        r0 = r10.mView;
        p000c.p001m.p002x.p003a.gv.bh.m142b(r0);
    L_0x011e:
        r0 = r10.mHidden;
        if (r0 == 0) goto L_0x0129;
    L_0x0122:
        r0 = r10.mView;
        r1 = 8;
        r0.setVisibility(r1);
    L_0x0129:
        r0 = r10.mView;
        r1 = r10.mSavedFragmentState;
        r10.onViewCreated(r0, r1);
    L_0x0130:
        if (r11 <= r5) goto L_0x01f9;
    L_0x0132:
        r0 = f272a;
        if (r0 == 0) goto L_0x014a;
    L_0x0136:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto ACTIVITY_CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x014a:
        r0 = r10.mFromLayout;
        if (r0 != 0) goto L_0x01e9;
    L_0x014e:
        r0 = r10.mContainerId;
        if (r0 == 0) goto L_0x03db;
    L_0x0152:
        r0 = r9.f288p;
        r1 = r10.mContainerId;
        r0 = r0.mo38a(r1);
        r0 = (android.view.ViewGroup) r0;
        if (r0 != 0) goto L_0x019d;
    L_0x015e:
        r1 = r10.mRestored;
        if (r1 != 0) goto L_0x019d;
    L_0x0162:
        r1 = new java.lang.IllegalArgumentException;
        r2 = new java.lang.StringBuilder;
        r3 = "No view found for id 0x";
        r2.<init>(r3);
        r3 = r10.mContainerId;
        r3 = java.lang.Integer.toHexString(r3);
        r2 = r2.append(r3);
        r3 = " (";
        r2 = r2.append(r3);
        r3 = r10.getResources();
        r4 = r10.mContainerId;
        r3 = r3.getResourceName(r4);
        r2 = r2.append(r3);
        r3 = ") for fragment ";
        r2 = r2.append(r3);
        r2 = r2.append(r10);
        r2 = r2.toString();
        r1.<init>(r2);
        r9.m308a(r1);
    L_0x019d:
        r10.mContainer = r0;
        r1 = r10.mSavedFragmentState;
        r1 = r10.getLayoutInflater(r1);
        r2 = r10.mSavedFragmentState;
        r1 = r10.performCreateView(r1, r0, r2);
        r10.mView = r1;
        r1 = r10.mView;
        if (r1 == 0) goto L_0x0253;
    L_0x01b1:
        r1 = r10.mView;
        r10.mInnerView = r1;
        r1 = android.os.Build.VERSION.SDK_INT;
        r2 = 11;
        if (r1 < r2) goto L_0x0249;
    L_0x01bb:
        r1 = r10.mView;
        p000c.p001m.p002x.p003a.gv.bh.m142b(r1);
    L_0x01c0:
        if (r0 == 0) goto L_0x01d7;
    L_0x01c2:
        r1 = r9.m305a(r10, r12, r5, r13);
        if (r1 == 0) goto L_0x01d2;
    L_0x01c8:
        r2 = r10.mView;
        p000c.p001m.p002x.p003a.gv.C0074w.m310b(r2, r1);
        r2 = r10.mView;
        r2.startAnimation(r1);
    L_0x01d2:
        r1 = r10.mView;
        r0.addView(r1);
    L_0x01d7:
        r0 = r10.mHidden;
        if (r0 == 0) goto L_0x01e2;
    L_0x01db:
        r0 = r10.mView;
        r1 = 8;
        r0.setVisibility(r1);
    L_0x01e2:
        r0 = r10.mView;
        r1 = r10.mSavedFragmentState;
        r10.onViewCreated(r0, r1);
    L_0x01e9:
        r0 = r10.mSavedFragmentState;
        r10.performActivityCreated(r0);
        r0 = r10.mView;
        if (r0 == 0) goto L_0x01f7;
    L_0x01f2:
        r0 = r10.mSavedFragmentState;
        r10.restoreViewState(r0);
    L_0x01f7:
        r10.mSavedFragmentState = r7;
    L_0x01f9:
        if (r11 <= r6) goto L_0x0216;
    L_0x01fb:
        r0 = f272a;
        if (r0 == 0) goto L_0x0213;
    L_0x01ff:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto STARTED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0213:
        r10.performStart();
    L_0x0216:
        if (r11 <= r8) goto L_0x0045;
    L_0x0218:
        r0 = f272a;
        if (r0 == 0) goto L_0x0230;
    L_0x021c:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto RESUMED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0230:
        r10.mResumed = r5;
        r10.performResume();
        r10.mSavedFragmentState = r7;
        r10.mSavedViewState = r7;
        goto L_0x0045;
    L_0x023b:
        r0 = r10.mView;
        r0 = p000c.p001m.p002x.p003a.gv.ao.m55a(r0);
        r10.mView = r0;
        goto L_0x011e;
    L_0x0245:
        r10.mInnerView = r7;
        goto L_0x0130;
    L_0x0249:
        r1 = r10.mView;
        r1 = p000c.p001m.p002x.p003a.gv.ao.m55a(r1);
        r10.mView = r1;
        goto L_0x01c0;
    L_0x0253:
        r10.mInnerView = r7;
        goto L_0x01e9;
    L_0x0256:
        r0 = r10.mState;
        if (r0 <= r11) goto L_0x0045;
    L_0x025a:
        r0 = r10.mState;
        switch(r0) {
            case 1: goto L_0x0261;
            case 2: goto L_0x02d5;
            case 3: goto L_0x02b8;
            case 4: goto L_0x029b;
            case 5: goto L_0x027b;
            default: goto L_0x025f;
        };
    L_0x025f:
        goto L_0x0045;
    L_0x0261:
        if (r11 > 0) goto L_0x0045;
    L_0x0263:
        r0 = r9.f292t;
        if (r0 == 0) goto L_0x0272;
    L_0x0267:
        r0 = r10.mAnimatingAway;
        if (r0 == 0) goto L_0x0272;
    L_0x026b:
        r0 = r10.mAnimatingAway;
        r10.mAnimatingAway = r7;
        r0.clearAnimation();
    L_0x0272:
        r0 = r10.mAnimatingAway;
        if (r0 == 0) goto L_0x0340;
    L_0x0276:
        r10.mStateAfterAnimating = r11;
        r11 = r5;
        goto L_0x0045;
    L_0x027b:
        r0 = 5;
        if (r11 >= r0) goto L_0x029b;
    L_0x027e:
        r0 = f272a;
        if (r0 == 0) goto L_0x0296;
    L_0x0282:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom RESUMED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0296:
        r10.performPause();
        r10.mResumed = r3;
    L_0x029b:
        if (r11 >= r8) goto L_0x02b8;
    L_0x029d:
        r0 = f272a;
        if (r0 == 0) goto L_0x02b5;
    L_0x02a1:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom STARTED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02b5:
        r10.performStop();
    L_0x02b8:
        if (r11 >= r6) goto L_0x02d5;
    L_0x02ba:
        r0 = f272a;
        if (r0 == 0) goto L_0x02d2;
    L_0x02be:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom STOPPED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02d2:
        r10.performReallyStop();
    L_0x02d5:
        r0 = 2;
        if (r11 >= r0) goto L_0x0261;
    L_0x02d8:
        r0 = f272a;
        if (r0 == 0) goto L_0x02f0;
    L_0x02dc:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom ACTIVITY_CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02f0:
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0303;
    L_0x02f4:
        r0 = r9.f287o;
        r0 = r0.mo45b();
        if (r0 == 0) goto L_0x0303;
    L_0x02fc:
        r0 = r10.mSavedViewState;
        if (r0 != 0) goto L_0x0303;
    L_0x0300:
        r9.m313c(r10);
    L_0x0303:
        r10.performDestroyView();
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0338;
    L_0x030a:
        r0 = r10.mContainer;
        if (r0 == 0) goto L_0x0338;
    L_0x030e:
        r0 = r9.f286n;
        if (r0 <= 0) goto L_0x03d8;
    L_0x0312:
        r0 = r9.f292t;
        if (r0 != 0) goto L_0x03d8;
    L_0x0316:
        r0 = r9.m305a(r10, r12, r3, r13);
    L_0x031a:
        if (r0 == 0) goto L_0x0331;
    L_0x031c:
        r1 = r10.mView;
        r10.mAnimatingAway = r1;
        r10.mStateAfterAnimating = r11;
        r1 = r10.mView;
        r2 = new c.m.x.a.gv.z;
        r2.<init>(r9, r1, r0, r10);
        r0.setAnimationListener(r2);
        r1 = r10.mView;
        r1.startAnimation(r0);
    L_0x0331:
        r0 = r10.mContainer;
        r1 = r10.mView;
        r0.removeView(r1);
    L_0x0338:
        r10.mContainer = r7;
        r10.mView = r7;
        r10.mInnerView = r7;
        goto L_0x0261;
    L_0x0340:
        r0 = f272a;
        if (r0 == 0) goto L_0x0358;
    L_0x0344:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0358:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x035f;
    L_0x035c:
        r10.performDestroy();
    L_0x035f:
        r10.mCalled = r3;
        r10.onDetach();
        r0 = r10.mCalled;
        if (r0 != 0) goto L_0x0383;
    L_0x0368:
        r0 = new c.m.x.a.gv.aq;
        r1 = new java.lang.StringBuilder;
        r2 = "Fragment ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r2 = " did not call through to super.onDetach()";
        r1 = r1.append(r2);
        r1 = r1.toString();
        r0.<init>(r1);
        throw r0;
    L_0x0383:
        if (r14 != 0) goto L_0x0045;
    L_0x0385:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x03ce;
    L_0x0389:
        r0 = r10.mIndex;
        if (r0 < 0) goto L_0x0045;
    L_0x038d:
        r0 = f272a;
        if (r0 == 0) goto L_0x03a5;
    L_0x0391:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "Freeing fragment index ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x03a5:
        r0 = r9.f278f;
        r1 = r10.mIndex;
        r0.set(r1, r7);
        r0 = r9.f280h;
        if (r0 != 0) goto L_0x03b7;
    L_0x03b0:
        r0 = new java.util.ArrayList;
        r0.<init>();
        r9.f280h = r0;
    L_0x03b7:
        r0 = r9.f280h;
        r1 = r10.mIndex;
        r1 = java.lang.Integer.valueOf(r1);
        r0.add(r1);
        r0 = r9.f287o;
        r1 = r10.mWho;
        r0.m236b(r1);
        r10.initState();
        goto L_0x0045;
    L_0x03ce:
        r10.mHost = r7;
        r10.mParentFragment = r7;
        r10.mFragmentManager = r7;
        r10.mChildFragmentManager = r7;
        goto L_0x0045;
    L_0x03d8:
        r0 = r7;
        goto L_0x031a;
    L_0x03db:
        r0 = r7;
        goto L_0x019d;
        */
        throw new UnsupportedOperationException("Method not decompiled: c.m.x.a.gv.w.a(c.m.x.a.gv.n, int, int, int, boolean):void");
    }

    public final void m330a(C0058n c0058n, boolean z) {
        if (this.f279g == null) {
            this.f279g = new ArrayList();
        }
        if (f272a) {
            Log.v("FragmentManager", "add: " + c0058n);
        }
        if (c0058n.mIndex < 0) {
            if (this.f280h == null || this.f280h.size() <= 0) {
                if (this.f278f == null) {
                    this.f278f = new ArrayList();
                }
                c0058n.setIndex(this.f278f.size(), this.f289q);
                this.f278f.add(c0058n);
            } else {
                c0058n.setIndex(((Integer) this.f280h.remove(this.f280h.size() - 1)).intValue(), this.f289q);
                this.f278f.set(c0058n.mIndex, c0058n);
            }
            if (f272a) {
                Log.v("FragmentManager", "Allocated fragment index " + c0058n);
            }
        }
        if (!c0058n.mDetached) {
            if (this.f279g.contains(c0058n)) {
                throw new IllegalStateException("Fragment already added: " + c0058n);
            }
            this.f279g.add(c0058n);
            c0058n.mAdded = true;
            c0058n.mRemoving = false;
            if (c0058n.mHasMenu && c0058n.mMenuVisible) {
                this.f290r = true;
            }
            if (z) {
                m311b(c0058n);
            }
        }
    }

    public final void m331a(C0065u c0065u, C0062s c0062s, C0058n c0058n) {
        if (this.f287o != null) {
            throw new IllegalStateException("Already attached");
        }
        this.f287o = c0065u;
        this.f288p = c0062s;
        this.f289q = c0058n;
    }

    public final void m332a(Runnable runnable, boolean z) {
        if (!z) {
            m317s();
        }
        synchronized (this) {
            if (this.f292t || this.f287o == null) {
                throw new IllegalStateException("Activity has been destroyed");
            }
            if (this.f275c == null) {
                this.f275c = new ArrayList();
            }
            this.f275c.add(runnable);
            if (this.f275c.size() == 1) {
                this.f287o.m244i().removeCallbacks(this.f297y);
                this.f287o.m244i().post(this.f297y);
            }
        }
    }

    public final void mo61a(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        int size;
        int i;
        int i2 = 0;
        String str2 = str + "    ";
        if (this.f278f != null) {
            size = this.f278f.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.print("Active Fragments in ");
                printWriter.print(Integer.toHexString(System.identityHashCode(this)));
                printWriter.println(":");
                for (i = 0; i < size; i++) {
                    C0058n c0058n;
                    c0058n = (C0058n) this.f278f.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0058n);
                    if (c0058n != null) {
                        c0058n.dump(str2, fileDescriptor, printWriter, strArr);
                    }
                }
            }
        }
        if (this.f279g != null) {
            size = this.f279g.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Added Fragments:");
                for (i = 0; i < size; i++) {
                    c0058n = (C0058n) this.f279g.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0058n.toString());
                }
            }
        }
        if (this.f282j != null) {
            size = this.f282j.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Fragments Created Menus:");
                for (i = 0; i < size; i++) {
                    c0058n = (C0058n) this.f282j.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0058n.toString());
                }
            }
        }
        if (this.f281i != null) {
            size = this.f281i.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Back Stack:");
                for (i = 0; i < size; i++) {
                    C0050e c0050e = (C0050e) this.f281i.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0050e.toString());
                    c0050e.m216a(str2, printWriter);
                }
            }
        }
        synchronized (this) {
            if (this.f283k != null) {
                int size2 = this.f283k.size();
                if (size2 > 0) {
                    printWriter.print(str);
                    printWriter.println("Back Stack Indices:");
                    for (i = 0; i < size2; i++) {
                        c0050e = (C0050e) this.f283k.get(i);
                        printWriter.print(str);
                        printWriter.print("  #");
                        printWriter.print(i);
                        printWriter.print(": ");
                        printWriter.println(c0050e);
                    }
                }
            }
            if (this.f284l != null && this.f284l.size() > 0) {
                printWriter.print(str);
                printWriter.print("mAvailBackStackIndices: ");
                printWriter.println(Arrays.toString(this.f284l.toArray()));
            }
        }
        if (this.f275c != null) {
            i = this.f275c.size();
            if (i > 0) {
                printWriter.print(str);
                printWriter.println("Pending Actions:");
                while (i2 < i) {
                    Runnable runnable = (Runnable) this.f275c.get(i2);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i2);
                    printWriter.print(": ");
                    printWriter.println(runnable);
                    i2++;
                }
            }
        }
        printWriter.print(str);
        printWriter.println("FragmentManager misc state:");
        printWriter.print(str);
        printWriter.print("  mHost=");
        printWriter.println(this.f287o);
        printWriter.print(str);
        printWriter.print("  mContainer=");
        printWriter.println(this.f288p);
        if (this.f289q != null) {
            printWriter.print(str);
            printWriter.print("  mParent=");
            printWriter.println(this.f289q);
        }
        printWriter.print(str);
        printWriter.print("  mCurState=");
        printWriter.print(this.f286n);
        printWriter.print(" mStateSaved=");
        printWriter.print(this.f291s);
        printWriter.print(" mDestroyed=");
        printWriter.println(this.f292t);
        if (this.f290r) {
            printWriter.print(str);
            printWriter.print("  mNeedMenuInvalidate=");
            printWriter.println(this.f290r);
        }
        if (this.f293u != null) {
            printWriter.print(str);
            printWriter.print("  mNoTransactionsBecause=");
            printWriter.println(this.f293u);
        }
        if (this.f280h != null && this.f280h.size() > 0) {
            printWriter.print(str);
            printWriter.print("  mAvailIndices: ");
            printWriter.println(Arrays.toString(this.f280h.toArray()));
        }
    }

    final boolean m334a(int i, int i2) {
        if (this.f281i == null) {
            return false;
        }
        int i3;
        C0050e c0050e;
        if (i >= 0 || (i2 & 1) != 0) {
            int size;
            i3 = -1;
            if (i >= 0) {
                size = this.f281i.size() - 1;
                while (size >= 0) {
                    c0050e = (C0050e) this.f281i.get(size);
                    if (i >= 0 && i == c0050e.f216p) {
                        break;
                    }
                    size--;
                }
                if (size < 0) {
                    return false;
                }
                if ((i2 & 1) != 0) {
                    size--;
                    while (size >= 0) {
                        c0050e = (C0050e) this.f281i.get(size);
                        if (i < 0 || i != c0050e.f216p) {
                            break;
                        }
                        size--;
                    }
                }
                i3 = size;
            }
            if (i3 == this.f281i.size() - 1) {
                return false;
            }
            ArrayList arrayList = new ArrayList();
            for (size = this.f281i.size() - 1; size > i3; size--) {
                arrayList.add(this.f281i.remove(size));
            }
            int size2 = arrayList.size() - 1;
            SparseArray sparseArray = new SparseArray();
            SparseArray sparseArray2 = new SparseArray();
            for (size = 0; size <= size2; size++) {
                ((C0050e) arrayList.get(size)).m214a(sparseArray, sparseArray2);
            }
            C0049b c0049b = null;
            int i4 = 0;
            while (i4 <= size2) {
                if (f272a) {
                    Log.v("FragmentManager", "Popping back stack state: " + arrayList.get(i4));
                }
                i4++;
                c0049b = ((C0050e) arrayList.get(i4)).m212a(i4 == size2, c0049b, sparseArray, sparseArray2);
            }
        } else {
            i3 = this.f281i.size() - 1;
            if (i3 < 0) {
                return false;
            }
            c0050e = (C0050e) this.f281i.remove(i3);
            SparseArray sparseArray3 = new SparseArray();
            SparseArray sparseArray4 = new SparseArray();
            c0050e.m214a(sparseArray3, sparseArray4);
            c0050e.m212a(true, null, sparseArray3, sparseArray4);
        }
        m318t();
        return true;
    }

    public final boolean m335a(Menu menu) {
        if (this.f279g == null) {
            return false;
        }
        boolean z = false;
        for (int i = 0; i < this.f279g.size(); i++) {
            C0058n c0058n = (C0058n) this.f279g.get(i);
            if (c0058n != null && c0058n.performPrepareOptionsMenu(menu)) {
                z = true;
            }
        }
        return z;
    }

    public final boolean m336a(Menu menu, MenuInflater menuInflater) {
        boolean z;
        C0058n c0058n;
        int i = 0;
        ArrayList arrayList = null;
        if (this.f279g != null) {
            int i2 = 0;
            z = false;
            while (i2 < this.f279g.size()) {
                c0058n = (C0058n) this.f279g.get(i2);
                if (c0058n != null && c0058n.performCreateOptionsMenu(menu, menuInflater)) {
                    z = true;
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(c0058n);
                }
                i2++;
                z = z;
            }
        } else {
            z = false;
        }
        if (this.f282j != null) {
            while (i < this.f282j.size()) {
                c0058n = (C0058n) this.f282j.get(i);
                if (arrayList == null || !arrayList.contains(c0058n)) {
                    c0058n.onDestroyOptionsMenu();
                }
                i++;
            }
        }
        this.f282j = arrayList;
        return z;
    }

    public final boolean m337a(MenuItem menuItem) {
        if (this.f279g == null) {
            return false;
        }
        for (int i = 0; i < this.f279g.size(); i++) {
            C0058n c0058n = (C0058n) this.f279g.get(i);
            if (c0058n != null && c0058n.performOptionsItemSelected(menuItem)) {
                return true;
            }
        }
        return false;
    }

    public final C0058n m338b(String str) {
        if (!(this.f278f == null || str == null)) {
            for (int size = this.f278f.size() - 1; size >= 0; size--) {
                C0058n c0058n = (C0058n) this.f278f.get(size);
                if (c0058n != null) {
                    c0058n = c0058n.findFragmentByWho(str);
                    if (c0058n != null) {
                        return c0058n;
                    }
                }
            }
        }
        return null;
    }

    public final void m339b(int i) {
        synchronized (this) {
            this.f283k.set(i, null);
            if (this.f284l == null) {
                this.f284l = new ArrayList();
            }
            if (f272a) {
                Log.v("FragmentManager", "Freeing back stack index " + i);
            }
            this.f284l.add(Integer.valueOf(i));
        }
    }

    public final void m340b(Menu menu) {
        if (this.f279g != null) {
            for (int i = 0; i < this.f279g.size(); i++) {
                C0058n c0058n = (C0058n) this.f279g.get(i);
                if (c0058n != null) {
                    c0058n.performOptionsMenuClosed(menu);
                }
            }
        }
    }

    final void m341b(C0050e c0050e) {
        if (this.f281i == null) {
            this.f281i = new ArrayList();
        }
        this.f281i.add(c0050e);
        m318t();
    }

    public final void m342b(C0058n c0058n, int i, int i2) {
        if (f272a) {
            Log.v("FragmentManager", "hide: " + c0058n);
        }
        if (!c0058n.mHidden) {
            c0058n.mHidden = true;
            if (c0058n.mView != null) {
                Animation a = m305a(c0058n, i, false, i2);
                if (a != null) {
                    C0074w.m310b(c0058n.mView, a);
                    c0058n.mView.startAnimation(a);
                }
                c0058n.mView.setVisibility(8);
            }
            if (c0058n.mAdded && c0058n.mHasMenu && c0058n.mMenuVisible) {
                this.f290r = true;
            }
            c0058n.onHiddenChanged(true);
        }
    }

    public final boolean mo62b() {
        m317s();
        m346c();
        this.f287o.m244i();
        return m334a(-1, 0);
    }

    public final boolean m344b(MenuItem menuItem) {
        if (this.f279g == null) {
            return false;
        }
        for (int i = 0; i < this.f279g.size(); i++) {
            C0058n c0058n = (C0058n) this.f279g.get(i);
            if (c0058n != null && c0058n.performContextItemSelected(menuItem)) {
                return true;
            }
        }
        return false;
    }

    public final void m345c(C0058n c0058n, int i, int i2) {
        if (f272a) {
            Log.v("FragmentManager", "show: " + c0058n);
        }
        if (c0058n.mHidden) {
            c0058n.mHidden = false;
            if (c0058n.mView != null) {
                Animation a = m305a(c0058n, i, true, i2);
                if (a != null) {
                    C0074w.m310b(c0058n.mView, a);
                    c0058n.mView.startAnimation(a);
                }
                c0058n.mView.setVisibility(0);
            }
            if (c0058n.mAdded && c0058n.mHasMenu && c0058n.mMenuVisible) {
                this.f290r = true;
            }
            c0058n.onHiddenChanged(false);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public final boolean m346c() {
        /*
        r6 = this;
        r0 = 1;
        r2 = 0;
        r1 = r6.f277e;
        if (r1 == 0) goto L_0x000e;
    L_0x0006:
        r0 = new java.lang.IllegalStateException;
        r1 = "Recursive entry to executePendingTransactions";
        r0.<init>(r1);
        throw r0;
    L_0x000e:
        r1 = android.os.Looper.myLooper();
        r3 = r6.f287o;
        r3 = r3.m244i();
        r3 = r3.getLooper();
        if (r1 == r3) goto L_0x0026;
    L_0x001e:
        r0 = new java.lang.IllegalStateException;
        r1 = "Must be called from main thread of process";
        r0.<init>(r1);
        throw r0;
    L_0x0026:
        r1 = r2;
    L_0x0027:
        monitor-enter(r6);
        r3 = r6.f275c;	 Catch:{ all -> 0x009b }
        if (r3 == 0) goto L_0x0034;
    L_0x002c:
        r3 = r6.f275c;	 Catch:{ all -> 0x009b }
        r3 = r3.size();	 Catch:{ all -> 0x009b }
        if (r3 != 0) goto L_0x005c;
    L_0x0034:
        monitor-exit(r6);	 Catch:{ all -> 0x009b }
        r0 = r6.f294v;
        if (r0 == 0) goto L_0x00a9;
    L_0x0039:
        r3 = r2;
        r4 = r2;
    L_0x003b:
        r0 = r6.f278f;
        r0 = r0.size();
        if (r3 >= r0) goto L_0x00a2;
    L_0x0043:
        r0 = r6.f278f;
        r0 = r0.get(r3);
        r0 = (p000c.p001m.p002x.p003a.gv.C0058n) r0;
        if (r0 == 0) goto L_0x0058;
    L_0x004d:
        r5 = r0.mLoaderManager;
        if (r5 == 0) goto L_0x0058;
    L_0x0051:
        r0 = r0.mLoaderManager;
        r0 = r0.mo7a();
        r4 = r4 | r0;
    L_0x0058:
        r0 = r3 + 1;
        r3 = r0;
        goto L_0x003b;
    L_0x005c:
        r1 = r6.f275c;	 Catch:{ all -> 0x009b }
        r3 = r1.size();	 Catch:{ all -> 0x009b }
        r1 = r6.f276d;	 Catch:{ all -> 0x009b }
        if (r1 == 0) goto L_0x006b;
    L_0x0066:
        r1 = r6.f276d;	 Catch:{ all -> 0x009b }
        r1 = r1.length;	 Catch:{ all -> 0x009b }
        if (r1 >= r3) goto L_0x006f;
    L_0x006b:
        r1 = new java.lang.Runnable[r3];	 Catch:{ all -> 0x009b }
        r6.f276d = r1;	 Catch:{ all -> 0x009b }
    L_0x006f:
        r1 = r6.f275c;	 Catch:{ all -> 0x009b }
        r4 = r6.f276d;	 Catch:{ all -> 0x009b }
        r1.toArray(r4);	 Catch:{ all -> 0x009b }
        r1 = r6.f275c;	 Catch:{ all -> 0x009b }
        r1.clear();	 Catch:{ all -> 0x009b }
        r1 = r6.f287o;	 Catch:{ all -> 0x009b }
        r1 = r1.m244i();	 Catch:{ all -> 0x009b }
        r4 = r6.f297y;	 Catch:{ all -> 0x009b }
        r1.removeCallbacks(r4);	 Catch:{ all -> 0x009b }
        monitor-exit(r6);	 Catch:{ all -> 0x009b }
        r6.f277e = r0;
        r1 = r2;
    L_0x008a:
        if (r1 >= r3) goto L_0x009e;
    L_0x008c:
        r4 = r6.f276d;
        r4 = r4[r1];
        r4.run();
        r4 = r6.f276d;
        r5 = 0;
        r4[r1] = r5;
        r1 = r1 + 1;
        goto L_0x008a;
    L_0x009b:
        r0 = move-exception;
        monitor-exit(r6);
        throw r0;
    L_0x009e:
        r6.f277e = r2;
        r1 = r0;
        goto L_0x0027;
    L_0x00a2:
        if (r4 != 0) goto L_0x00a9;
    L_0x00a4:
        r6.f294v = r2;
        r6.m316r();
    L_0x00a9:
        return r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: c.m.x.a.gv.w.c():boolean");
    }

    final ArrayList<C0058n> m347d() {
        ArrayList<C0058n> arrayList = null;
        if (this.f278f != null) {
            for (int i = 0; i < this.f278f.size(); i++) {
                C0058n c0058n = (C0058n) this.f278f.get(i);
                if (c0058n != null && c0058n.mRetainInstance) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(c0058n);
                    c0058n.mRetaining = true;
                    c0058n.mTargetIndex = c0058n.mTarget != null ? c0058n.mTarget.mIndex : -1;
                    if (f272a) {
                        Log.v("FragmentManager", "retainNonConfig: keeping retained " + c0058n);
                    }
                }
            }
        }
        return arrayList;
    }

    public final void m348d(C0058n c0058n, int i, int i2) {
        if (f272a) {
            Log.v("FragmentManager", "detach: " + c0058n);
        }
        if (!c0058n.mDetached) {
            c0058n.mDetached = true;
            if (c0058n.mAdded) {
                if (this.f279g != null) {
                    if (f272a) {
                        Log.v("FragmentManager", "remove from detach: " + c0058n);
                    }
                    this.f279g.remove(c0058n);
                }
                if (c0058n.mHasMenu && c0058n.mMenuVisible) {
                    this.f290r = true;
                }
                c0058n.mAdded = false;
                m329a(c0058n, 1, i, i2, false);
            }
        }
    }

    final Parcelable m349e() {
        C0054i[] c0054iArr = null;
        m346c();
        if (f273b) {
            this.f291s = true;
        }
        if (this.f278f == null || this.f278f.size() <= 0) {
            return null;
        }
        int size = this.f278f.size();
        ae[] aeVarArr = new ae[size];
        int i = 0;
        boolean z = false;
        while (i < size) {
            boolean z2;
            C0058n c0058n = (C0058n) this.f278f.get(i);
            if (c0058n != null) {
                if (c0058n.mIndex < 0) {
                    m308a(new IllegalStateException("Failure saving state: active " + c0058n + " has cleared index: " + c0058n.mIndex));
                }
                ae aeVar = new ae(c0058n);
                aeVarArr[i] = aeVar;
                if (c0058n.mState <= 0 || aeVar.f15j != null) {
                    aeVar.f15j = c0058n.mSavedFragmentState;
                } else {
                    Bundle bundle;
                    if (this.f295w == null) {
                        this.f295w = new Bundle();
                    }
                    c0058n.performSaveInstanceState(this.f295w);
                    if (this.f295w.isEmpty()) {
                        bundle = null;
                    } else {
                        bundle = this.f295w;
                        this.f295w = null;
                    }
                    if (c0058n.mView != null) {
                        m313c(c0058n);
                    }
                    if (c0058n.mSavedViewState != null) {
                        if (bundle == null) {
                            bundle = new Bundle();
                        }
                        bundle.putSparseParcelableArray("android:view_state", c0058n.mSavedViewState);
                    }
                    if (!c0058n.mUserVisibleHint) {
                        if (bundle == null) {
                            bundle = new Bundle();
                        }
                        bundle.putBoolean("android:user_visible_hint", c0058n.mUserVisibleHint);
                    }
                    aeVar.f15j = bundle;
                    if (c0058n.mTarget != null) {
                        if (c0058n.mTarget.mIndex < 0) {
                            m308a(new IllegalStateException("Failure saving state: " + c0058n + " has target not in fragment manager: " + c0058n.mTarget));
                        }
                        if (aeVar.f15j == null) {
                            aeVar.f15j = new Bundle();
                        }
                        bundle = aeVar.f15j;
                        String str = "android:target_state";
                        C0058n c0058n2 = c0058n.mTarget;
                        if (c0058n2.mIndex < 0) {
                            m308a(new IllegalStateException("Fragment " + c0058n2 + " is not currently in the FragmentManager"));
                        }
                        bundle.putInt(str, c0058n2.mIndex);
                        if (c0058n.mTargetRequestCode != 0) {
                            aeVar.f15j.putInt("android:target_req_state", c0058n.mTargetRequestCode);
                        }
                    }
                }
                if (f272a) {
                    Log.v("FragmentManager", "Saved state of " + c0058n + ": " + aeVar.f15j);
                }
                z2 = true;
            } else {
                z2 = z;
            }
            i++;
            z = z2;
        }
        if (z) {
            int[] iArr;
            int i2;
            ac acVar;
            if (this.f279g != null) {
                i = this.f279g.size();
                if (i > 0) {
                    iArr = new int[i];
                    for (i2 = 0; i2 < i; i2++) {
                        iArr[i2] = ((C0058n) this.f279g.get(i2)).mIndex;
                        if (iArr[i2] < 0) {
                            m308a(new IllegalStateException("Failure saving state: active " + this.f279g.get(i2) + " has cleared index: " + iArr[i2]));
                        }
                        if (f272a) {
                            Log.v("FragmentManager", "saveAllState: adding fragment #" + i2 + ": " + this.f279g.get(i2));
                        }
                    }
                    if (this.f281i != null) {
                        i = this.f281i.size();
                        if (i > 0) {
                            c0054iArr = new C0054i[i];
                            for (i2 = 0; i2 < i; i2++) {
                                c0054iArr[i2] = new C0054i((C0050e) this.f281i.get(i2));
                                if (f272a) {
                                    Log.v("FragmentManager", "saveAllState: adding back stack #" + i2 + ": " + this.f281i.get(i2));
                                }
                            }
                        }
                    }
                    acVar = new ac();
                    acVar.f3a = aeVarArr;
                    acVar.f4b = iArr;
                    acVar.f5c = c0054iArr;
                    return acVar;
                }
            }
            iArr = null;
            if (this.f281i != null) {
                i = this.f281i.size();
                if (i > 0) {
                    c0054iArr = new C0054i[i];
                    for (i2 = 0; i2 < i; i2++) {
                        c0054iArr[i2] = new C0054i((C0050e) this.f281i.get(i2));
                        if (f272a) {
                            Log.v("FragmentManager", "saveAllState: adding back stack #" + i2 + ": " + this.f281i.get(i2));
                        }
                    }
                }
            }
            acVar = new ac();
            acVar.f3a = aeVarArr;
            acVar.f4b = iArr;
            acVar.f5c = c0054iArr;
            return acVar;
        } else if (!f272a) {
            return null;
        } else {
            Log.v("FragmentManager", "saveAllState: no fragments!");
            return null;
        }
    }

    public final void m350e(C0058n c0058n, int i, int i2) {
        if (f272a) {
            Log.v("FragmentManager", "attach: " + c0058n);
        }
        if (c0058n.mDetached) {
            c0058n.mDetached = false;
            if (!c0058n.mAdded) {
                if (this.f279g == null) {
                    this.f279g = new ArrayList();
                }
                if (this.f279g.contains(c0058n)) {
                    throw new IllegalStateException("Fragment already added: " + c0058n);
                }
                if (f272a) {
                    Log.v("FragmentManager", "add from attach: " + c0058n);
                }
                this.f279g.add(c0058n);
                c0058n.mAdded = true;
                if (c0058n.mHasMenu && c0058n.mMenuVisible) {
                    this.f290r = true;
                }
                m329a(c0058n, this.f286n, i, i2, false);
            }
        }
    }

    public final void m351f() {
        this.f291s = false;
    }

    public final void m352g() {
        this.f291s = false;
        m314d(1);
    }

    public final void m353h() {
        this.f291s = false;
        m314d(2);
    }

    public final void m354i() {
        this.f291s = false;
        m314d(4);
    }

    public final void m355j() {
        this.f291s = false;
        m314d(5);
    }

    public final void m356k() {
        m314d(4);
    }

    public final void m357l() {
        this.f291s = true;
        m314d(3);
    }

    public final void m358m() {
        m314d(2);
    }

    public final void m359n() {
        m314d(1);
    }

    public final void m360o() {
        this.f292t = true;
        m346c();
        m314d(0);
        this.f287o = null;
        this.f288p = null;
        this.f289q = null;
    }

    public final void m361p() {
        if (this.f279g != null) {
            for (int i = 0; i < this.f279g.size(); i++) {
                C0058n c0058n = (C0058n) this.f279g.get(i);
                if (c0058n != null) {
                    c0058n.performLowMemory();
                }
            }
        }
    }

    final bg m362q() {
        return this;
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append("FragmentManager{");
        stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
        stringBuilder.append(" in ");
        if (this.f289q != null) {
            ay.m113a(this.f289q, stringBuilder);
        } else {
            ay.m113a(this.f287o, stringBuilder);
        }
        stringBuilder.append("}}");
        return stringBuilder.toString();
    }
}
