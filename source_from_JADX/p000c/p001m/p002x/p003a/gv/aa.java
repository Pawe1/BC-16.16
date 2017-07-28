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
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import p000c.p001m.p002x.p003a.gv.C0063g.C0062b;

final class aa extends C0013z implements bl {
    static final Interpolator f10A = new DecelerateInterpolator(2.5f);
    static final Interpolator f11B = new DecelerateInterpolator(1.5f);
    static final Interpolator f12C = new AccelerateInterpolator(2.5f);
    static final Interpolator f13D = new AccelerateInterpolator(1.5f);
    static boolean f14a = false;
    static final boolean f15b;
    static Field f16r = null;
    ArrayList<Runnable> f17c;
    Runnable[] f18d;
    boolean f19e;
    ArrayList<C0073r> f20f;
    ArrayList<C0073r> f21g;
    ArrayList<Integer> f22h;
    ArrayList<C0063g> f23i;
    ArrayList<C0073r> f24j;
    ArrayList<C0063g> f25k;
    ArrayList<Integer> f26l;
    ArrayList<OnBackStackChangedListener> f27m;
    int f28n = 0;
    C0080y f29o;
    C0077w f30p;
    C0073r f31q;
    boolean f32s;
    boolean f33t;
    boolean f34u;
    String f35v;
    boolean f36w;
    Bundle f37x = null;
    SparseArray<Parcelable> f38y = null;
    Runnable f39z = new ab(this);

    static class C0011a implements AnimationListener {
        private AnimationListener f6a = null;
        private boolean f7b = false;
        private View f8c = null;

        public C0011a(View view, Animation animation) {
            if (view != null && animation != null) {
                this.f8c = view;
            }
        }

        public C0011a(View view, Animation animation, AnimationListener animationListener) {
            if (view != null && animation != null) {
                this.f6a = animationListener;
                this.f8c = view;
            }
        }

        public void onAnimationEnd(Animation animation) {
            if (this.f8c != null && this.f7b) {
                this.f8c.post(new af(this));
            }
            if (this.f6a != null) {
                this.f6a.onAnimationEnd(animation);
            }
        }

        public void onAnimationRepeat(Animation animation) {
            if (this.f6a != null) {
                this.f6a.onAnimationRepeat(animation);
            }
        }

        public void onAnimationStart(Animation animation) {
            if (this.f8c != null) {
                this.f7b = aa.m14a(this.f8c, animation);
                if (this.f7b) {
                    this.f8c.post(new ae(this));
                }
            }
            if (this.f6a != null) {
                this.f6a.onAnimationStart(animation);
            }
        }
    }

    static class C0012b {
        public static final int[] f9a = new int[]{16842755, 16842960, 16842961};
    }

    static {
        boolean z = false;
        if (VERSION.SDK_INT >= 11) {
            z = true;
        }
        f15b = z;
    }

    aa() {
    }

    private static Animation m8a(float f, float f2) {
        Animation alphaAnimation = new AlphaAnimation(f, f2);
        alphaAnimation.setInterpolator(f11B);
        alphaAnimation.setDuration(220);
        return alphaAnimation;
    }

    private static Animation m9a(float f, float f2, float f3, float f4) {
        Animation animationSet = new AnimationSet(false);
        Animation scaleAnimation = new ScaleAnimation(f, f2, f, f2, 1, 0.5f, 1, 0.5f);
        scaleAnimation.setInterpolator(f10A);
        scaleAnimation.setDuration(220);
        animationSet.addAnimation(scaleAnimation);
        scaleAnimation = new AlphaAnimation(f3, f4);
        scaleAnimation.setInterpolator(f11B);
        scaleAnimation.setDuration(220);
        animationSet.addAnimation(scaleAnimation);
        return animationSet;
    }

    private Animation m10a(C0073r c0073r, int i, boolean z, int i2) {
        Animation onCreateAnimation = c0073r.onCreateAnimation(i, z, c0073r.mNextAnim);
        if (onCreateAnimation != null) {
            return onCreateAnimation;
        }
        if (c0073r.mNextAnim != 0) {
            onCreateAnimation = AnimationUtils.loadAnimation(this.f29o.f301b, c0073r.mNextAnim);
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
                context = this.f29o.f301b;
                return aa.m9a(1.125f, 1.0f, 0.0f, 1.0f);
            case 2:
                context = this.f29o.f301b;
                return aa.m9a(1.0f, 0.975f, 1.0f, 0.0f);
            case 3:
                context = this.f29o.f301b;
                return aa.m9a(0.975f, 1.0f, 0.0f, 1.0f);
            case 4:
                context = this.f29o.f301b;
                return aa.m9a(1.0f, 1.075f, 1.0f, 0.0f);
            case 5:
                context = this.f29o.f301b;
                return aa.m8a(0.0f, 1.0f);
            case 6:
                context = this.f29o.f301b;
                return aa.m8a(1.0f, 0.0f);
            default:
                if (i2 == 0 && this.f29o.mo77e()) {
                    i2 = this.f29o.mo78f();
                }
                return i2 == 0 ? null : null;
        }
    }

    private C0073r m11a(Bundle bundle, String str) {
        int i = bundle.getInt(str, -1);
        if (i == -1) {
            return null;
        }
        if (i >= this.f20f.size()) {
            m13a(new IllegalStateException("Fragment no longer exists for key " + str + ": index " + i));
        }
        C0073r c0073r = (C0073r) this.f20f.get(i);
        if (c0073r != null) {
            return c0073r;
        }
        m13a(new IllegalStateException("Fragment no longer exists for key " + str + ": index " + i));
        return c0073r;
    }

    private void m12a(int i, C0063g c0063g) {
        synchronized (this) {
            if (this.f25k == null) {
                this.f25k = new ArrayList();
            }
            int size = this.f25k.size();
            if (i < size) {
                if (f14a) {
                    Log.v("FragmentManager", "Setting back stack index " + i + " to " + c0063g);
                }
                this.f25k.set(i, c0063g);
            } else {
                while (size < i) {
                    this.f25k.add(null);
                    if (this.f26l == null) {
                        this.f26l = new ArrayList();
                    }
                    if (f14a) {
                        Log.v("FragmentManager", "Adding available back stack index " + size);
                    }
                    this.f26l.add(Integer.valueOf(size));
                    size++;
                }
                if (f14a) {
                    Log.v("FragmentManager", "Adding back stack index " + i + " with " + c0063g);
                }
                this.f25k.add(c0063g);
            }
        }
    }

    private void m13a(RuntimeException runtimeException) {
        Log.e("FragmentManager", runtimeException.getMessage());
        Log.e("FragmentManager", "Activity state:");
        PrintWriter printWriter = new PrintWriter(new be("FragmentManager"));
        if (this.f29o != null) {
            try {
                this.f29o.mo72a("  ", printWriter, new String[0]);
            } catch (Throwable e) {
                Log.e("FragmentManager", "Failed dumping state", e);
            }
        } else {
            try {
                mo27a("  ", null, printWriter, new String[0]);
            } catch (Throwable e2) {
                Log.e("FragmentManager", "Failed dumping state", e2);
            }
        }
        throw runtimeException;
    }

    static boolean m14a(View view, Animation animation) {
        if (VERSION.SDK_INT < 19 || bm.m198a(view) != 0 || !bm.m201c(view)) {
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

    private static void m15b(View view, Animation animation) {
        if (view != null && animation != null && aa.m14a(view, animation)) {
            AnimationListener animationListener;
            try {
                if (f16r == null) {
                    Field declaredField = Animation.class.getDeclaredField("mListener");
                    f16r = declaredField;
                    declaredField.setAccessible(true);
                }
                animationListener = (AnimationListener) f16r.get(animation);
            } catch (Throwable e) {
                Log.e("FragmentManager", "No field with the name mListener is found in Animation class", e);
                animationListener = null;
            } catch (Throwable e2) {
                Log.e("FragmentManager", "Cannot access Animation's mListener field", e2);
                animationListener = null;
            }
            animation.setAnimationListener(new C0011a(view, animation, animationListener));
        }
    }

    public static int m16c(int i) {
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

    private void m17c(C0073r c0073r) {
        m34a(c0073r, this.f28n, 0, 0, false);
    }

    private void m18d(int i) {
        m29a(i, 0, 0, false);
    }

    private void m19d(C0073r c0073r) {
        if (c0073r.mInnerView != null) {
            if (this.f38y == null) {
                this.f38y = new SparseArray();
            } else {
                this.f38y.clear();
            }
            c0073r.mInnerView.saveHierarchyState(this.f38y);
            if (this.f38y.size() > 0) {
                c0073r.mSavedViewState = this.f38y;
                this.f38y = null;
            }
        }
    }

    private C0073r m20e(int i) {
        int size;
        C0073r c0073r;
        if (this.f21g != null) {
            for (size = this.f21g.size() - 1; size >= 0; size--) {
                c0073r = (C0073r) this.f21g.get(size);
                if (c0073r != null && c0073r.mFragmentId == i) {
                    return c0073r;
                }
            }
        }
        if (this.f20f != null) {
            for (size = this.f20f.size() - 1; size >= 0; size--) {
                c0073r = (C0073r) this.f20f.get(size);
                if (c0073r != null && c0073r.mFragmentId == i) {
                    return c0073r;
                }
            }
        }
        return null;
    }

    private void m21r() {
        if (this.f20f != null) {
            for (int i = 0; i < this.f20f.size(); i++) {
                C0073r c0073r = (C0073r) this.f20f.get(i);
                if (c0073r != null) {
                    m32a(c0073r);
                }
            }
        }
    }

    private void m22s() {
        if (this.f33t) {
            throw new IllegalStateException("Can not perform this action after onSaveInstanceState");
        } else if (this.f35v != null) {
            throw new IllegalStateException("Can not perform this action inside of " + this.f35v);
        }
    }

    private void m23t() {
        if (this.f27m != null) {
            for (int i = 0; i < this.f27m.size(); i++) {
                this.f27m.get(i);
            }
        }
    }

    public final int m24a(C0063g c0063g) {
        int size;
        synchronized (this) {
            if (this.f26l == null || this.f26l.size() <= 0) {
                if (this.f25k == null) {
                    this.f25k = new ArrayList();
                }
                size = this.f25k.size();
                if (f14a) {
                    Log.v("FragmentManager", "Setting back stack index " + size + " to " + c0063g);
                }
                this.f25k.add(c0063g);
            } else {
                size = ((Integer) this.f26l.remove(this.f26l.size() - 1)).intValue();
                if (f14a) {
                    Log.v("FragmentManager", "Adding back stack index " + size + " with " + c0063g);
                }
                this.f25k.set(size, c0063g);
            }
        }
        return size;
    }

    public final View mo23a(View view, String str, Context context, AttributeSet attributeSet) {
        if (!"fragment".equals(str)) {
            return null;
        }
        String attributeValue = attributeSet.getAttributeValue(null, "class");
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, C0012b.f9a);
        String string = attributeValue == null ? obtainStyledAttributes.getString(0) : attributeValue;
        int resourceId = obtainStyledAttributes.getResourceId(1, -1);
        String string2 = obtainStyledAttributes.getString(2);
        obtainStyledAttributes.recycle();
        if (!C0073r.isSupportFragmentClass(this.f29o.f301b, string)) {
            return null;
        }
        int id = view != null ? view.getId() : 0;
        if (id == -1 && resourceId == -1 && string2 == null) {
            throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Must specify unique android:id, android:tag, or have a parent with an id for " + string);
        }
        C0073r c0073r;
        C0073r e = resourceId != -1 ? m20e(resourceId) : null;
        if (e == null && string2 != null) {
            e = mo25a(string2);
        }
        if (e == null && id != -1) {
            e = m20e(id);
        }
        if (f14a) {
            Log.v("FragmentManager", "onCreateView: id=0x" + Integer.toHexString(resourceId) + " fname=" + string + " existing=" + e);
        }
        if (e == null) {
            C0073r instantiate = C0073r.instantiate(context, string);
            instantiate.mFromLayout = true;
            instantiate.mFragmentId = resourceId != 0 ? resourceId : id;
            instantiate.mContainerId = id;
            instantiate.mTag = string2;
            instantiate.mInLayout = true;
            instantiate.mFragmentManager = this;
            instantiate.mHost = this.f29o;
            instantiate.onInflate(this.f29o.f301b, attributeSet, instantiate.mSavedFragmentState);
            m35a(instantiate, true);
            c0073r = instantiate;
        } else if (e.mInLayout) {
            throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Duplicate id 0x" + Integer.toHexString(resourceId) + ", tag " + string2 + ", or parent id 0x" + Integer.toHexString(id) + " with another fragment for " + string);
        } else {
            e.mInLayout = true;
            e.mHost = this.f29o;
            if (!e.mRetaining) {
                e.onInflate(this.f29o.f301b, attributeSet, e.mSavedFragmentState);
            }
            c0073r = e;
        }
        if (this.f28n > 0 || !c0073r.mFromLayout) {
            m17c(c0073r);
        } else {
            m34a(c0073r, 1, 0, 0, false);
        }
        if (c0073r.mView == null) {
            throw new IllegalStateException("Fragment " + string + " did not create a view.");
        }
        if (resourceId != 0) {
            c0073r.mView.setId(resourceId);
        }
        if (c0073r.mView.getTag() == null) {
            c0073r.mView.setTag(string2);
        }
        return c0073r.mView;
    }

    public final ak mo24a() {
        return new C0063g(this);
    }

    public final C0073r mo25a(String str) {
        int size;
        C0073r c0073r;
        if (!(this.f21g == null || str == null)) {
            for (size = this.f21g.size() - 1; size >= 0; size--) {
                c0073r = (C0073r) this.f21g.get(size);
                if (c0073r != null && str.equals(c0073r.mTag)) {
                    return c0073r;
                }
            }
        }
        if (!(this.f20f == null || str == null)) {
            for (size = this.f20f.size() - 1; size >= 0; size--) {
                c0073r = (C0073r) this.f20f.get(size);
                if (c0073r != null && str.equals(c0073r.mTag)) {
                    return c0073r;
                }
            }
        }
        return null;
    }

    public final void mo26a(int i) {
        if (i < 0) {
            throw new IllegalArgumentException("Bad id: " + i);
        }
        m37a(new ac(this, i), false);
    }

    final void m29a(int i, int i2, int i3, boolean z) {
        if (this.f29o == null && i != 0) {
            throw new IllegalStateException("No host");
        } else if (z || this.f28n != i) {
            this.f28n = i;
            if (this.f20f != null) {
                int i4 = 0;
                int i5 = 0;
                while (i4 < this.f20f.size()) {
                    int a;
                    C0073r c0073r = (C0073r) this.f20f.get(i4);
                    if (c0073r != null) {
                        m34a(c0073r, i, i2, i3, false);
                        if (c0073r.mLoaderManager != null) {
                            a = i5 | c0073r.mLoaderManager.mo30a();
                            i4++;
                            i5 = a;
                        }
                    }
                    a = i5;
                    i4++;
                    i5 = a;
                }
                if (i5 == 0) {
                    m21r();
                }
                if (this.f32s && this.f29o != null && this.f28n == 5) {
                    this.f29o.mo76d();
                    this.f32s = false;
                }
            }
        }
    }

    public final void m30a(Configuration configuration) {
        if (this.f21g != null) {
            for (int i = 0; i < this.f21g.size(); i++) {
                C0073r c0073r = (C0073r) this.f21g.get(i);
                if (c0073r != null) {
                    c0073r.performConfigurationChanged(configuration);
                }
            }
        }
    }

    final void m31a(Parcelable parcelable, List<C0073r> list) {
        if (parcelable != null) {
            ag agVar = (ag) parcelable;
            if (agVar.f48a != null) {
                int i;
                C0073r c0073r;
                int i2;
                if (list != null) {
                    for (i = 0; i < list.size(); i++) {
                        c0073r = (C0073r) list.get(i);
                        if (f14a) {
                            Log.v("FragmentManager", "restoreAllState: re-attaching retained " + c0073r);
                        }
                        ai aiVar = agVar.f48a[c0073r.mIndex];
                        aiVar.f61k = c0073r;
                        c0073r.mSavedViewState = null;
                        c0073r.mBackStackNesting = 0;
                        c0073r.mInLayout = false;
                        c0073r.mAdded = false;
                        c0073r.mTarget = null;
                        if (aiVar.f60j != null) {
                            aiVar.f60j.setClassLoader(this.f29o.f301b.getClassLoader());
                            c0073r.mSavedViewState = aiVar.f60j.getSparseParcelableArray("android:view_state");
                            c0073r.mSavedFragmentState = aiVar.f60j;
                        }
                    }
                }
                this.f20f = new ArrayList(agVar.f48a.length);
                if (this.f22h != null) {
                    this.f22h.clear();
                }
                for (i2 = 0; i2 < agVar.f48a.length; i2++) {
                    ai aiVar2 = agVar.f48a[i2];
                    if (aiVar2 != null) {
                        C0073r a = aiVar2.m69a(this.f29o, this.f31q);
                        if (f14a) {
                            Log.v("FragmentManager", "restoreAllState: active #" + i2 + ": " + a);
                        }
                        this.f20f.add(a);
                        aiVar2.f61k = null;
                    } else {
                        this.f20f.add(null);
                        if (this.f22h == null) {
                            this.f22h = new ArrayList();
                        }
                        if (f14a) {
                            Log.v("FragmentManager", "restoreAllState: avail #" + i2);
                        }
                        this.f22h.add(Integer.valueOf(i2));
                    }
                }
                if (list != null) {
                    for (int i3 = 0; i3 < list.size(); i3++) {
                        c0073r = (C0073r) list.get(i3);
                        if (c0073r.mTargetIndex >= 0) {
                            if (c0073r.mTargetIndex < this.f20f.size()) {
                                c0073r.mTarget = (C0073r) this.f20f.get(c0073r.mTargetIndex);
                            } else {
                                Log.w("FragmentManager", "Re-attaching retained fragment " + c0073r + " target no longer exists: " + c0073r.mTargetIndex);
                                c0073r.mTarget = null;
                            }
                        }
                    }
                }
                if (agVar.f49b != null) {
                    this.f21g = new ArrayList(agVar.f49b.length);
                    for (i = 0; i < agVar.f49b.length; i++) {
                        c0073r = (C0073r) this.f20f.get(agVar.f49b[i]);
                        if (c0073r == null) {
                            m13a(new IllegalStateException("No instantiated fragment for index #" + agVar.f49b[i]));
                        }
                        c0073r.mAdded = true;
                        if (f14a) {
                            Log.v("FragmentManager", "restoreAllState: added #" + i + ": " + c0073r);
                        }
                        if (this.f21g.contains(c0073r)) {
                            throw new IllegalStateException("Already added!");
                        }
                        this.f21g.add(c0073r);
                    }
                } else {
                    this.f21g = null;
                }
                if (agVar.f50c != null) {
                    this.f23i = new ArrayList(agVar.f50c.length);
                    for (i2 = 0; i2 < agVar.f50c.length; i2++) {
                        C0063g a2 = agVar.f50c[i2].m295a(this);
                        if (f14a) {
                            Log.v("FragmentManager", "restoreAllState: back stack #" + i2 + " (index " + a2.f263p + "): " + a2);
                            a2.m292a("  ", new PrintWriter(new be("FragmentManager")), false);
                        }
                        this.f23i.add(a2);
                        if (a2.f263p >= 0) {
                            m12a(a2.f263p, a2);
                        }
                    }
                    return;
                }
                this.f23i = null;
            }
        }
    }

    public final void m32a(C0073r c0073r) {
        if (!c0073r.mDeferStart) {
            return;
        }
        if (this.f19e) {
            this.f36w = true;
            return;
        }
        c0073r.mDeferStart = false;
        m34a(c0073r, this.f28n, 0, 0, false);
    }

    public final void m33a(C0073r c0073r, int i, int i2) {
        if (f14a) {
            Log.v("FragmentManager", "remove: " + c0073r + " nesting=" + c0073r.mBackStackNesting);
        }
        boolean z = !c0073r.isInBackStack();
        if (!c0073r.mDetached || z) {
            if (this.f21g != null) {
                this.f21g.remove(c0073r);
            }
            if (c0073r.mHasMenu && c0073r.mMenuVisible) {
                this.f32s = true;
            }
            c0073r.mAdded = false;
            c0073r.mRemoving = true;
            m34a(c0073r, z ? 0 : 1, i, i2, false);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    final void m34a(p000c.p001m.p002x.p003a.gv.C0073r r10, int r11, int r12, int r13, boolean r14) {
        /*
        r9 = this;
        r8 = 4;
        r6 = 3;
        r5 = 1;
        r3 = 0;
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
        if (r0 >= r11) goto L_0x0282;
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
        r0.m34a(r1, r2, r3, r4, r5);
    L_0x0040:
        r0 = r10.mState;
        switch(r0) {
            case 0: goto L_0x0076;
            case 1: goto L_0x015e;
            case 2: goto L_0x0227;
            case 3: goto L_0x0227;
            case 4: goto L_0x0244;
            default: goto L_0x0045;
        };
    L_0x0045:
        r0 = r10.mState;
        if (r0 == r11) goto L_0x0031;
    L_0x0049:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveToState: Fragment state for ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r2 = " not updated inline; expected state ";
        r1 = r1.append(r2);
        r1 = r1.append(r11);
        r2 = " found ";
        r1 = r1.append(r2);
        r2 = r10.mState;
        r1 = r1.append(r2);
        r1 = r1.toString();
        android.util.Log.w(r0, r1);
        r10.mState = r11;
        goto L_0x0031;
    L_0x0076:
        r0 = f14a;
        if (r0 == 0) goto L_0x008e;
    L_0x007a:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x008e:
        r0 = r10.mSavedFragmentState;
        if (r0 == 0) goto L_0x00d4;
    L_0x0092:
        r0 = r10.mSavedFragmentState;
        r1 = r9.f29o;
        r1 = r1.f301b;
        r1 = r1.getClassLoader();
        r0.setClassLoader(r1);
        r0 = r10.mSavedFragmentState;
        r1 = "android:view_state";
        r0 = r0.getSparseParcelableArray(r1);
        r10.mSavedViewState = r0;
        r0 = r10.mSavedFragmentState;
        r1 = "android:target_state";
        r0 = r9.m11a(r0, r1);
        r10.mTarget = r0;
        r0 = r10.mTarget;
        if (r0 == 0) goto L_0x00c1;
    L_0x00b7:
        r0 = r10.mSavedFragmentState;
        r1 = "android:target_req_state";
        r0 = r0.getInt(r1, r3);
        r10.mTargetRequestCode = r0;
    L_0x00c1:
        r0 = r10.mSavedFragmentState;
        r1 = "android:user_visible_hint";
        r0 = r0.getBoolean(r1, r5);
        r10.mUserVisibleHint = r0;
        r0 = r10.mUserVisibleHint;
        if (r0 != 0) goto L_0x00d4;
    L_0x00cf:
        r10.mDeferStart = r5;
        if (r11 <= r6) goto L_0x00d4;
    L_0x00d3:
        r11 = r6;
    L_0x00d4:
        r0 = r9.f29o;
        r10.mHost = r0;
        r0 = r9.f31q;
        r10.mParentFragment = r0;
        r0 = r9.f31q;
        if (r0 == 0) goto L_0x010e;
    L_0x00e0:
        r0 = r9.f31q;
        r0 = r0.mChildFragmentManager;
    L_0x00e4:
        r10.mFragmentManager = r0;
        r10.mCalled = r3;
        r0 = r9.f29o;
        r0 = r0.f301b;
        r10.onAttach(r0);
        r0 = r10.mCalled;
        if (r0 != 0) goto L_0x0113;
    L_0x00f3:
        r0 = new c.m.x.a.gv.au;
        r1 = new java.lang.StringBuilder;
        r2 = "Fragment ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r2 = " did not call through to super.onAttach()";
        r1 = r1.append(r2);
        r1 = r1.toString();
        r0.<init>(r1);
        throw r0;
    L_0x010e:
        r0 = r9.f29o;
        r0 = r0.f303d;
        goto L_0x00e4;
    L_0x0113:
        r0 = r10.mParentFragment;
        if (r0 != 0) goto L_0x011c;
    L_0x0117:
        r0 = r9.f29o;
        r0.mo69a(r10);
    L_0x011c:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x0125;
    L_0x0120:
        r0 = r10.mSavedFragmentState;
        r10.performCreate(r0);
    L_0x0125:
        r10.mRetaining = r3;
        r0 = r10.mFromLayout;
        if (r0 == 0) goto L_0x015e;
    L_0x012b:
        r0 = r10.mSavedFragmentState;
        r0 = r10.getLayoutInflater(r0);
        r1 = r10.mSavedFragmentState;
        r0 = r10.performCreateView(r0, r7, r1);
        r10.mView = r0;
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0271;
    L_0x013d:
        r0 = r10.mView;
        r10.mInnerView = r0;
        r0 = android.os.Build.VERSION.SDK_INT;
        r1 = 11;
        if (r0 < r1) goto L_0x0267;
    L_0x0147:
        r0 = r10.mView;
        p000c.p001m.p002x.p003a.gv.bm.m200b(r0);
    L_0x014c:
        r0 = r10.mHidden;
        if (r0 == 0) goto L_0x0157;
    L_0x0150:
        r0 = r10.mView;
        r1 = 8;
        r0.setVisibility(r1);
    L_0x0157:
        r0 = r10.mView;
        r1 = r10.mSavedFragmentState;
        r10.onViewCreated(r0, r1);
    L_0x015e:
        if (r11 <= r5) goto L_0x0227;
    L_0x0160:
        r0 = f14a;
        if (r0 == 0) goto L_0x0178;
    L_0x0164:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto ACTIVITY_CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0178:
        r0 = r10.mFromLayout;
        if (r0 != 0) goto L_0x0217;
    L_0x017c:
        r0 = r10.mContainerId;
        if (r0 == 0) goto L_0x0408;
    L_0x0180:
        r0 = r9.f30p;
        r1 = r10.mContainerId;
        r0 = r0.mo67a(r1);
        r0 = (android.view.ViewGroup) r0;
        if (r0 != 0) goto L_0x01cb;
    L_0x018c:
        r1 = r10.mRestored;
        if (r1 != 0) goto L_0x01cb;
    L_0x0190:
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
        r9.m13a(r1);
    L_0x01cb:
        r10.mContainer = r0;
        r1 = r10.mSavedFragmentState;
        r1 = r10.getLayoutInflater(r1);
        r2 = r10.mSavedFragmentState;
        r1 = r10.performCreateView(r1, r0, r2);
        r10.mView = r1;
        r1 = r10.mView;
        if (r1 == 0) goto L_0x027f;
    L_0x01df:
        r1 = r10.mView;
        r10.mInnerView = r1;
        r1 = android.os.Build.VERSION.SDK_INT;
        r2 = 11;
        if (r1 < r2) goto L_0x0275;
    L_0x01e9:
        r1 = r10.mView;
        p000c.p001m.p002x.p003a.gv.bm.m200b(r1);
    L_0x01ee:
        if (r0 == 0) goto L_0x0205;
    L_0x01f0:
        r1 = r9.m10a(r10, r12, r5, r13);
        if (r1 == 0) goto L_0x0200;
    L_0x01f6:
        r2 = r10.mView;
        p000c.p001m.p002x.p003a.gv.aa.m15b(r2, r1);
        r2 = r10.mView;
        r2.startAnimation(r1);
    L_0x0200:
        r1 = r10.mView;
        r0.addView(r1);
    L_0x0205:
        r0 = r10.mHidden;
        if (r0 == 0) goto L_0x0210;
    L_0x0209:
        r0 = r10.mView;
        r1 = 8;
        r0.setVisibility(r1);
    L_0x0210:
        r0 = r10.mView;
        r1 = r10.mSavedFragmentState;
        r10.onViewCreated(r0, r1);
    L_0x0217:
        r0 = r10.mSavedFragmentState;
        r10.performActivityCreated(r0);
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0225;
    L_0x0220:
        r0 = r10.mSavedFragmentState;
        r10.restoreViewState(r0);
    L_0x0225:
        r10.mSavedFragmentState = r7;
    L_0x0227:
        if (r11 <= r6) goto L_0x0244;
    L_0x0229:
        r0 = f14a;
        if (r0 == 0) goto L_0x0241;
    L_0x022d:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto STARTED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0241:
        r10.performStart();
    L_0x0244:
        if (r11 <= r8) goto L_0x0045;
    L_0x0246:
        r0 = f14a;
        if (r0 == 0) goto L_0x025e;
    L_0x024a:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "moveto RESUMED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x025e:
        r10.performResume();
        r10.mSavedFragmentState = r7;
        r10.mSavedViewState = r7;
        goto L_0x0045;
    L_0x0267:
        r0 = r10.mView;
        r0 = p000c.p001m.p002x.p003a.gv.as.m108a(r0);
        r10.mView = r0;
        goto L_0x014c;
    L_0x0271:
        r10.mInnerView = r7;
        goto L_0x015e;
    L_0x0275:
        r1 = r10.mView;
        r1 = p000c.p001m.p002x.p003a.gv.as.m108a(r1);
        r10.mView = r1;
        goto L_0x01ee;
    L_0x027f:
        r10.mInnerView = r7;
        goto L_0x0217;
    L_0x0282:
        r0 = r10.mState;
        if (r0 <= r11) goto L_0x0045;
    L_0x0286:
        r0 = r10.mState;
        switch(r0) {
            case 1: goto L_0x028d;
            case 2: goto L_0x02ff;
            case 3: goto L_0x02e2;
            case 4: goto L_0x02c5;
            case 5: goto L_0x02a7;
            default: goto L_0x028b;
        };
    L_0x028b:
        goto L_0x0045;
    L_0x028d:
        if (r11 > 0) goto L_0x0045;
    L_0x028f:
        r0 = r9.f34u;
        if (r0 == 0) goto L_0x029e;
    L_0x0293:
        r0 = r10.mAnimatingAway;
        if (r0 == 0) goto L_0x029e;
    L_0x0297:
        r0 = r10.mAnimatingAway;
        r10.mAnimatingAway = r7;
        r0.clearAnimation();
    L_0x029e:
        r0 = r10.mAnimatingAway;
        if (r0 == 0) goto L_0x036a;
    L_0x02a2:
        r10.mStateAfterAnimating = r11;
        r11 = r5;
        goto L_0x0045;
    L_0x02a7:
        r0 = 5;
        if (r11 >= r0) goto L_0x02c5;
    L_0x02aa:
        r0 = f14a;
        if (r0 == 0) goto L_0x02c2;
    L_0x02ae:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom RESUMED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02c2:
        r10.performPause();
    L_0x02c5:
        if (r11 >= r8) goto L_0x02e2;
    L_0x02c7:
        r0 = f14a;
        if (r0 == 0) goto L_0x02df;
    L_0x02cb:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom STARTED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02df:
        r10.performStop();
    L_0x02e2:
        if (r11 >= r6) goto L_0x02ff;
    L_0x02e4:
        r0 = f14a;
        if (r0 == 0) goto L_0x02fc;
    L_0x02e8:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom STOPPED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x02fc:
        r10.performReallyStop();
    L_0x02ff:
        r0 = 2;
        if (r11 >= r0) goto L_0x028d;
    L_0x0302:
        r0 = f14a;
        if (r0 == 0) goto L_0x031a;
    L_0x0306:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom ACTIVITY_CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x031a:
        r0 = r10.mView;
        if (r0 == 0) goto L_0x032d;
    L_0x031e:
        r0 = r9.f29o;
        r0 = r0.mo74b();
        if (r0 == 0) goto L_0x032d;
    L_0x0326:
        r0 = r10.mSavedViewState;
        if (r0 != 0) goto L_0x032d;
    L_0x032a:
        r9.m19d(r10);
    L_0x032d:
        r10.performDestroyView();
        r0 = r10.mView;
        if (r0 == 0) goto L_0x0362;
    L_0x0334:
        r0 = r10.mContainer;
        if (r0 == 0) goto L_0x0362;
    L_0x0338:
        r0 = r9.f28n;
        if (r0 <= 0) goto L_0x0405;
    L_0x033c:
        r0 = r9.f34u;
        if (r0 != 0) goto L_0x0405;
    L_0x0340:
        r0 = r9.m10a(r10, r12, r3, r13);
    L_0x0344:
        if (r0 == 0) goto L_0x035b;
    L_0x0346:
        r1 = r10.mView;
        r10.mAnimatingAway = r1;
        r10.mStateAfterAnimating = r11;
        r1 = r10.mView;
        r2 = new c.m.x.a.gv.ad;
        r2.<init>(r9, r1, r0, r10);
        r0.setAnimationListener(r2);
        r1 = r10.mView;
        r1.startAnimation(r0);
    L_0x035b:
        r0 = r10.mContainer;
        r1 = r10.mView;
        r0.removeView(r1);
    L_0x0362:
        r10.mContainer = r7;
        r10.mView = r7;
        r10.mInnerView = r7;
        goto L_0x028d;
    L_0x036a:
        r0 = f14a;
        if (r0 == 0) goto L_0x0382;
    L_0x036e:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "movefrom CREATED: ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x0382:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x03ad;
    L_0x0386:
        r10.performDestroy();
    L_0x0389:
        r10.mCalled = r3;
        r10.onDetach();
        r0 = r10.mCalled;
        if (r0 != 0) goto L_0x03b0;
    L_0x0392:
        r0 = new c.m.x.a.gv.au;
        r1 = new java.lang.StringBuilder;
        r2 = "Fragment ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r2 = " did not call through to super.onDetach()";
        r1 = r1.append(r2);
        r1 = r1.toString();
        r0.<init>(r1);
        throw r0;
    L_0x03ad:
        r10.mState = r3;
        goto L_0x0389;
    L_0x03b0:
        if (r14 != 0) goto L_0x0045;
    L_0x03b2:
        r0 = r10.mRetaining;
        if (r0 != 0) goto L_0x03fb;
    L_0x03b6:
        r0 = r10.mIndex;
        if (r0 < 0) goto L_0x0045;
    L_0x03ba:
        r0 = f14a;
        if (r0 == 0) goto L_0x03d2;
    L_0x03be:
        r0 = "FragmentManager";
        r1 = new java.lang.StringBuilder;
        r2 = "Freeing fragment index ";
        r1.<init>(r2);
        r1 = r1.append(r10);
        r1 = r1.toString();
        android.util.Log.v(r0, r1);
    L_0x03d2:
        r0 = r9.f20f;
        r1 = r10.mIndex;
        r0.set(r1, r7);
        r0 = r9.f22h;
        if (r0 != 0) goto L_0x03e4;
    L_0x03dd:
        r0 = new java.util.ArrayList;
        r0.<init>();
        r9.f22h = r0;
    L_0x03e4:
        r0 = r9.f22h;
        r1 = r10.mIndex;
        r1 = java.lang.Integer.valueOf(r1);
        r0.add(r1);
        r0 = r9.f29o;
        r1 = r10.mWho;
        r0.m313b(r1);
        r10.initState();
        goto L_0x0045;
    L_0x03fb:
        r10.mHost = r7;
        r10.mParentFragment = r7;
        r10.mFragmentManager = r7;
        r10.mChildFragmentManager = r7;
        goto L_0x0045;
    L_0x0405:
        r0 = r7;
        goto L_0x0344;
    L_0x0408:
        r0 = r7;
        goto L_0x01cb;
        */
        throw new UnsupportedOperationException("Method not decompiled: c.m.x.a.gv.aa.a(c.m.x.a.gv.r, int, int, int, boolean):void");
    }

    public final void m35a(C0073r c0073r, boolean z) {
        if (this.f21g == null) {
            this.f21g = new ArrayList();
        }
        if (f14a) {
            Log.v("FragmentManager", "add: " + c0073r);
        }
        m47b(c0073r);
        if (!c0073r.mDetached) {
            if (this.f21g.contains(c0073r)) {
                throw new IllegalStateException("Fragment already added: " + c0073r);
            }
            this.f21g.add(c0073r);
            c0073r.mAdded = true;
            c0073r.mRemoving = false;
            if (c0073r.mHasMenu && c0073r.mMenuVisible) {
                this.f32s = true;
            }
            if (z) {
                m17c(c0073r);
            }
        }
    }

    public final void m36a(C0080y c0080y, C0077w c0077w, C0073r c0073r) {
        if (this.f29o != null) {
            throw new IllegalStateException("Already attached");
        }
        this.f29o = c0080y;
        this.f30p = c0077w;
        this.f31q = c0073r;
    }

    public final void m37a(Runnable runnable, boolean z) {
        if (!z) {
            m22s();
        }
        synchronized (this) {
            if (this.f34u || this.f29o == null) {
                throw new IllegalStateException("Activity has been destroyed");
            }
            if (this.f17c == null) {
                this.f17c = new ArrayList();
            }
            this.f17c.add(runnable);
            if (this.f17c.size() == 1) {
                this.f29o.m321i().removeCallbacks(this.f39z);
                this.f29o.m321i().post(this.f39z);
            }
        }
    }

    public final void mo27a(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        int size;
        int i;
        C0073r c0073r;
        int i2 = 0;
        String str2 = str + "    ";
        if (this.f20f != null) {
            size = this.f20f.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.print("Active Fragments in ");
                printWriter.print(Integer.toHexString(System.identityHashCode(this)));
                printWriter.println(":");
                for (i = 0; i < size; i++) {
                    c0073r = (C0073r) this.f20f.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0073r);
                    if (c0073r != null) {
                        c0073r.dump(str2, fileDescriptor, printWriter, strArr);
                    }
                }
            }
        }
        if (this.f21g != null) {
            size = this.f21g.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Added Fragments:");
                for (i = 0; i < size; i++) {
                    c0073r = (C0073r) this.f21g.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0073r.toString());
                }
            }
        }
        if (this.f24j != null) {
            size = this.f24j.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Fragments Created Menus:");
                for (i = 0; i < size; i++) {
                    c0073r = (C0073r) this.f24j.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0073r.toString());
                }
            }
        }
        if (this.f23i != null) {
            size = this.f23i.size();
            if (size > 0) {
                printWriter.print(str);
                printWriter.println("Back Stack:");
                for (i = 0; i < size; i++) {
                    C0063g c0063g = (C0063g) this.f23i.get(i);
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i);
                    printWriter.print(": ");
                    printWriter.println(c0063g.toString());
                    c0063g.m291a(str2, printWriter);
                }
            }
        }
        synchronized (this) {
            if (this.f25k != null) {
                int size2 = this.f25k.size();
                if (size2 > 0) {
                    printWriter.print(str);
                    printWriter.println("Back Stack Indices:");
                    for (i = 0; i < size2; i++) {
                        c0063g = (C0063g) this.f25k.get(i);
                        printWriter.print(str);
                        printWriter.print("  #");
                        printWriter.print(i);
                        printWriter.print(": ");
                        printWriter.println(c0063g);
                    }
                }
            }
            if (this.f26l != null && this.f26l.size() > 0) {
                printWriter.print(str);
                printWriter.print("mAvailBackStackIndices: ");
                printWriter.println(Arrays.toString(this.f26l.toArray()));
            }
        }
        if (this.f17c != null) {
            i = this.f17c.size();
            if (i > 0) {
                printWriter.print(str);
                printWriter.println("Pending Actions:");
                while (i2 < i) {
                    Runnable runnable = (Runnable) this.f17c.get(i2);
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
        printWriter.println(this.f29o);
        printWriter.print(str);
        printWriter.print("  mContainer=");
        printWriter.println(this.f30p);
        if (this.f31q != null) {
            printWriter.print(str);
            printWriter.print("  mParent=");
            printWriter.println(this.f31q);
        }
        printWriter.print(str);
        printWriter.print("  mCurState=");
        printWriter.print(this.f28n);
        printWriter.print(" mStateSaved=");
        printWriter.print(this.f33t);
        printWriter.print(" mDestroyed=");
        printWriter.println(this.f34u);
        if (this.f32s) {
            printWriter.print(str);
            printWriter.print("  mNeedMenuInvalidate=");
            printWriter.println(this.f32s);
        }
        if (this.f35v != null) {
            printWriter.print(str);
            printWriter.print("  mNoTransactionsBecause=");
            printWriter.println(this.f35v);
        }
        if (this.f22h != null && this.f22h.size() > 0) {
            printWriter.print(str);
            printWriter.print("  mAvailIndices: ");
            printWriter.println(Arrays.toString(this.f22h.toArray()));
        }
    }

    final boolean m39a(int i, int i2) {
        if (this.f23i == null) {
            return false;
        }
        int i3;
        C0063g c0063g;
        if (i >= 0 || (i2 & 1) != 0) {
            int size;
            i3 = -1;
            if (i >= 0) {
                size = this.f23i.size() - 1;
                while (size >= 0) {
                    c0063g = (C0063g) this.f23i.get(size);
                    if (i >= 0 && i == c0063g.f263p) {
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
                        c0063g = (C0063g) this.f23i.get(size);
                        if (i < 0 || i != c0063g.f263p) {
                            break;
                        }
                        size--;
                    }
                }
                i3 = size;
            }
            if (i3 == this.f23i.size() - 1) {
                return false;
            }
            ArrayList arrayList = new ArrayList();
            for (size = this.f23i.size() - 1; size > i3; size--) {
                arrayList.add(this.f23i.remove(size));
            }
            int size2 = arrayList.size() - 1;
            SparseArray sparseArray = new SparseArray();
            SparseArray sparseArray2 = new SparseArray();
            for (size = 0; size <= size2; size++) {
                ((C0063g) arrayList.get(size)).m289a(sparseArray, sparseArray2);
            }
            C0062b c0062b = null;
            int i4 = 0;
            while (i4 <= size2) {
                if (f14a) {
                    Log.v("FragmentManager", "Popping back stack state: " + arrayList.get(i4));
                }
                i4++;
                c0062b = ((C0063g) arrayList.get(i4)).m287a(i4 == size2, c0062b, sparseArray, sparseArray2);
            }
        } else {
            i3 = this.f23i.size() - 1;
            if (i3 < 0) {
                return false;
            }
            c0063g = (C0063g) this.f23i.remove(i3);
            SparseArray sparseArray3 = new SparseArray();
            SparseArray sparseArray4 = new SparseArray();
            c0063g.m289a(sparseArray3, sparseArray4);
            c0063g.m287a(true, null, sparseArray3, sparseArray4);
        }
        m23t();
        return true;
    }

    public final boolean m40a(Menu menu) {
        if (this.f21g == null) {
            return false;
        }
        boolean z = false;
        for (int i = 0; i < this.f21g.size(); i++) {
            C0073r c0073r = (C0073r) this.f21g.get(i);
            if (c0073r != null && c0073r.performPrepareOptionsMenu(menu)) {
                z = true;
            }
        }
        return z;
    }

    public final boolean m41a(Menu menu, MenuInflater menuInflater) {
        boolean z;
        C0073r c0073r;
        int i = 0;
        ArrayList arrayList = null;
        if (this.f21g != null) {
            int i2 = 0;
            z = false;
            while (i2 < this.f21g.size()) {
                c0073r = (C0073r) this.f21g.get(i2);
                if (c0073r != null && c0073r.performCreateOptionsMenu(menu, menuInflater)) {
                    z = true;
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(c0073r);
                }
                i2++;
                z = z;
            }
        } else {
            z = false;
        }
        if (this.f24j != null) {
            while (i < this.f24j.size()) {
                c0073r = (C0073r) this.f24j.get(i);
                if (arrayList == null || !arrayList.contains(c0073r)) {
                    c0073r.onDestroyOptionsMenu();
                }
                i++;
            }
        }
        this.f24j = arrayList;
        return z;
    }

    public final boolean m42a(MenuItem menuItem) {
        if (this.f21g == null) {
            return false;
        }
        for (int i = 0; i < this.f21g.size(); i++) {
            C0073r c0073r = (C0073r) this.f21g.get(i);
            if (c0073r != null && c0073r.performOptionsItemSelected(menuItem)) {
                return true;
            }
        }
        return false;
    }

    public final C0073r m43b(String str) {
        if (!(this.f20f == null || str == null)) {
            for (int size = this.f20f.size() - 1; size >= 0; size--) {
                C0073r c0073r = (C0073r) this.f20f.get(size);
                if (c0073r != null) {
                    c0073r = c0073r.findFragmentByWho(str);
                    if (c0073r != null) {
                        return c0073r;
                    }
                }
            }
        }
        return null;
    }

    public final void m44b(int i) {
        synchronized (this) {
            this.f25k.set(i, null);
            if (this.f26l == null) {
                this.f26l = new ArrayList();
            }
            if (f14a) {
                Log.v("FragmentManager", "Freeing back stack index " + i);
            }
            this.f26l.add(Integer.valueOf(i));
        }
    }

    public final void m45b(Menu menu) {
        if (this.f21g != null) {
            for (int i = 0; i < this.f21g.size(); i++) {
                C0073r c0073r = (C0073r) this.f21g.get(i);
                if (c0073r != null) {
                    c0073r.performOptionsMenuClosed(menu);
                }
            }
        }
    }

    final void m46b(C0063g c0063g) {
        if (this.f23i == null) {
            this.f23i = new ArrayList();
        }
        this.f23i.add(c0063g);
        m23t();
    }

    final void m47b(C0073r c0073r) {
        if (c0073r.mIndex < 0) {
            if (this.f22h == null || this.f22h.size() <= 0) {
                if (this.f20f == null) {
                    this.f20f = new ArrayList();
                }
                c0073r.setIndex(this.f20f.size(), this.f31q);
                this.f20f.add(c0073r);
            } else {
                c0073r.setIndex(((Integer) this.f22h.remove(this.f22h.size() - 1)).intValue(), this.f31q);
                this.f20f.set(c0073r.mIndex, c0073r);
            }
            if (f14a) {
                Log.v("FragmentManager", "Allocated fragment index " + c0073r);
            }
        }
    }

    public final void m48b(C0073r c0073r, int i, int i2) {
        if (f14a) {
            Log.v("FragmentManager", "hide: " + c0073r);
        }
        if (!c0073r.mHidden) {
            c0073r.mHidden = true;
            if (c0073r.mView != null) {
                Animation a = m10a(c0073r, i, false, i2);
                if (a != null) {
                    aa.m15b(c0073r.mView, a);
                    c0073r.mView.startAnimation(a);
                }
                c0073r.mView.setVisibility(8);
            }
            if (c0073r.mAdded && c0073r.mHasMenu && c0073r.mMenuVisible) {
                this.f32s = true;
            }
            c0073r.onHiddenChanged(true);
        }
    }

    public final boolean mo28b() {
        m22s();
        m52c();
        this.f29o.m321i();
        return m39a(-1, 0);
    }

    public final boolean m50b(MenuItem menuItem) {
        if (this.f21g == null) {
            return false;
        }
        for (int i = 0; i < this.f21g.size(); i++) {
            C0073r c0073r = (C0073r) this.f21g.get(i);
            if (c0073r != null && c0073r.performContextItemSelected(menuItem)) {
                return true;
            }
        }
        return false;
    }

    public final void m51c(C0073r c0073r, int i, int i2) {
        if (f14a) {
            Log.v("FragmentManager", "show: " + c0073r);
        }
        if (c0073r.mHidden) {
            c0073r.mHidden = false;
            if (c0073r.mView != null) {
                Animation a = m10a(c0073r, i, true, i2);
                if (a != null) {
                    aa.m15b(c0073r.mView, a);
                    c0073r.mView.startAnimation(a);
                }
                c0073r.mView.setVisibility(0);
            }
            if (c0073r.mAdded && c0073r.mHasMenu && c0073r.mMenuVisible) {
                this.f32s = true;
            }
            c0073r.onHiddenChanged(false);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public final boolean m52c() {
        /*
        r6 = this;
        r0 = 1;
        r2 = 0;
        r1 = r6.f19e;
        if (r1 == 0) goto L_0x000e;
    L_0x0006:
        r0 = new java.lang.IllegalStateException;
        r1 = "Recursive entry to executePendingTransactions";
        r0.<init>(r1);
        throw r0;
    L_0x000e:
        r1 = android.os.Looper.myLooper();
        r3 = r6.f29o;
        r3 = r3.m321i();
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
        r3 = r6.f17c;	 Catch:{ all -> 0x009b }
        if (r3 == 0) goto L_0x0034;
    L_0x002c:
        r3 = r6.f17c;	 Catch:{ all -> 0x009b }
        r3 = r3.size();	 Catch:{ all -> 0x009b }
        if (r3 != 0) goto L_0x005c;
    L_0x0034:
        monitor-exit(r6);	 Catch:{ all -> 0x009b }
        r0 = r6.f36w;
        if (r0 == 0) goto L_0x00a9;
    L_0x0039:
        r3 = r2;
        r4 = r2;
    L_0x003b:
        r0 = r6.f20f;
        r0 = r0.size();
        if (r3 >= r0) goto L_0x00a2;
    L_0x0043:
        r0 = r6.f20f;
        r0 = r0.get(r3);
        r0 = (p000c.p001m.p002x.p003a.gv.C0073r) r0;
        if (r0 == 0) goto L_0x0058;
    L_0x004d:
        r5 = r0.mLoaderManager;
        if (r5 == 0) goto L_0x0058;
    L_0x0051:
        r0 = r0.mLoaderManager;
        r0 = r0.mo30a();
        r4 = r4 | r0;
    L_0x0058:
        r0 = r3 + 1;
        r3 = r0;
        goto L_0x003b;
    L_0x005c:
        r1 = r6.f17c;	 Catch:{ all -> 0x009b }
        r3 = r1.size();	 Catch:{ all -> 0x009b }
        r1 = r6.f18d;	 Catch:{ all -> 0x009b }
        if (r1 == 0) goto L_0x006b;
    L_0x0066:
        r1 = r6.f18d;	 Catch:{ all -> 0x009b }
        r1 = r1.length;	 Catch:{ all -> 0x009b }
        if (r1 >= r3) goto L_0x006f;
    L_0x006b:
        r1 = new java.lang.Runnable[r3];	 Catch:{ all -> 0x009b }
        r6.f18d = r1;	 Catch:{ all -> 0x009b }
    L_0x006f:
        r1 = r6.f17c;	 Catch:{ all -> 0x009b }
        r4 = r6.f18d;	 Catch:{ all -> 0x009b }
        r1.toArray(r4);	 Catch:{ all -> 0x009b }
        r1 = r6.f17c;	 Catch:{ all -> 0x009b }
        r1.clear();	 Catch:{ all -> 0x009b }
        r1 = r6.f29o;	 Catch:{ all -> 0x009b }
        r1 = r1.m321i();	 Catch:{ all -> 0x009b }
        r4 = r6.f39z;	 Catch:{ all -> 0x009b }
        r1.removeCallbacks(r4);	 Catch:{ all -> 0x009b }
        monitor-exit(r6);	 Catch:{ all -> 0x009b }
        r6.f19e = r0;
        r1 = r2;
    L_0x008a:
        if (r1 >= r3) goto L_0x009e;
    L_0x008c:
        r4 = r6.f18d;
        r4 = r4[r1];
        r4.run();
        r4 = r6.f18d;
        r5 = 0;
        r4[r1] = r5;
        r1 = r1 + 1;
        goto L_0x008a;
    L_0x009b:
        r0 = move-exception;
        monitor-exit(r6);
        throw r0;
    L_0x009e:
        r6.f19e = r2;
        r1 = r0;
        goto L_0x0027;
    L_0x00a2:
        if (r4 != 0) goto L_0x00a9;
    L_0x00a4:
        r6.f36w = r2;
        r6.m21r();
    L_0x00a9:
        return r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: c.m.x.a.gv.aa.c():boolean");
    }

    final ArrayList<C0073r> m53d() {
        ArrayList<C0073r> arrayList = null;
        if (this.f20f != null) {
            for (int i = 0; i < this.f20f.size(); i++) {
                C0073r c0073r = (C0073r) this.f20f.get(i);
                if (c0073r != null && c0073r.mRetainInstance) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(c0073r);
                    c0073r.mRetaining = true;
                    c0073r.mTargetIndex = c0073r.mTarget != null ? c0073r.mTarget.mIndex : -1;
                    if (f14a) {
                        Log.v("FragmentManager", "retainNonConfig: keeping retained " + c0073r);
                    }
                }
            }
        }
        return arrayList;
    }

    public final void m54d(C0073r c0073r, int i, int i2) {
        if (f14a) {
            Log.v("FragmentManager", "detach: " + c0073r);
        }
        if (!c0073r.mDetached) {
            c0073r.mDetached = true;
            if (c0073r.mAdded) {
                if (this.f21g != null) {
                    if (f14a) {
                        Log.v("FragmentManager", "remove from detach: " + c0073r);
                    }
                    this.f21g.remove(c0073r);
                }
                if (c0073r.mHasMenu && c0073r.mMenuVisible) {
                    this.f32s = true;
                }
                c0073r.mAdded = false;
                m34a(c0073r, 1, i, i2, false);
            }
        }
    }

    final Parcelable m55e() {
        C0067k[] c0067kArr = null;
        m52c();
        if (f15b) {
            this.f33t = true;
        }
        if (this.f20f == null || this.f20f.size() <= 0) {
            return null;
        }
        int size = this.f20f.size();
        ai[] aiVarArr = new ai[size];
        int i = 0;
        boolean z = false;
        while (i < size) {
            boolean z2;
            C0073r c0073r = (C0073r) this.f20f.get(i);
            if (c0073r != null) {
                if (c0073r.mIndex < 0) {
                    m13a(new IllegalStateException("Failure saving state: active " + c0073r + " has cleared index: " + c0073r.mIndex));
                }
                ai aiVar = new ai(c0073r);
                aiVarArr[i] = aiVar;
                if (c0073r.mState <= 0 || aiVar.f60j != null) {
                    aiVar.f60j = c0073r.mSavedFragmentState;
                } else {
                    Bundle bundle;
                    if (this.f37x == null) {
                        this.f37x = new Bundle();
                    }
                    c0073r.performSaveInstanceState(this.f37x);
                    if (this.f37x.isEmpty()) {
                        bundle = null;
                    } else {
                        bundle = this.f37x;
                        this.f37x = null;
                    }
                    if (c0073r.mView != null) {
                        m19d(c0073r);
                    }
                    if (c0073r.mSavedViewState != null) {
                        if (bundle == null) {
                            bundle = new Bundle();
                        }
                        bundle.putSparseParcelableArray("android:view_state", c0073r.mSavedViewState);
                    }
                    if (!c0073r.mUserVisibleHint) {
                        if (bundle == null) {
                            bundle = new Bundle();
                        }
                        bundle.putBoolean("android:user_visible_hint", c0073r.mUserVisibleHint);
                    }
                    aiVar.f60j = bundle;
                    if (c0073r.mTarget != null) {
                        if (c0073r.mTarget.mIndex < 0) {
                            m13a(new IllegalStateException("Failure saving state: " + c0073r + " has target not in fragment manager: " + c0073r.mTarget));
                        }
                        if (aiVar.f60j == null) {
                            aiVar.f60j = new Bundle();
                        }
                        bundle = aiVar.f60j;
                        String str = "android:target_state";
                        C0073r c0073r2 = c0073r.mTarget;
                        if (c0073r2.mIndex < 0) {
                            m13a(new IllegalStateException("Fragment " + c0073r2 + " is not currently in the FragmentManager"));
                        }
                        bundle.putInt(str, c0073r2.mIndex);
                        if (c0073r.mTargetRequestCode != 0) {
                            aiVar.f60j.putInt("android:target_req_state", c0073r.mTargetRequestCode);
                        }
                    }
                }
                if (f14a) {
                    Log.v("FragmentManager", "Saved state of " + c0073r + ": " + aiVar.f60j);
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
            ag agVar;
            if (this.f21g != null) {
                i = this.f21g.size();
                if (i > 0) {
                    iArr = new int[i];
                    for (i2 = 0; i2 < i; i2++) {
                        iArr[i2] = ((C0073r) this.f21g.get(i2)).mIndex;
                        if (iArr[i2] < 0) {
                            m13a(new IllegalStateException("Failure saving state: active " + this.f21g.get(i2) + " has cleared index: " + iArr[i2]));
                        }
                        if (f14a) {
                            Log.v("FragmentManager", "saveAllState: adding fragment #" + i2 + ": " + this.f21g.get(i2));
                        }
                    }
                    if (this.f23i != null) {
                        i = this.f23i.size();
                        if (i > 0) {
                            c0067kArr = new C0067k[i];
                            for (i2 = 0; i2 < i; i2++) {
                                c0067kArr[i2] = new C0067k((C0063g) this.f23i.get(i2));
                                if (f14a) {
                                    Log.v("FragmentManager", "saveAllState: adding back stack #" + i2 + ": " + this.f23i.get(i2));
                                }
                            }
                        }
                    }
                    agVar = new ag();
                    agVar.f48a = aiVarArr;
                    agVar.f49b = iArr;
                    agVar.f50c = c0067kArr;
                    return agVar;
                }
            }
            iArr = null;
            if (this.f23i != null) {
                i = this.f23i.size();
                if (i > 0) {
                    c0067kArr = new C0067k[i];
                    for (i2 = 0; i2 < i; i2++) {
                        c0067kArr[i2] = new C0067k((C0063g) this.f23i.get(i2));
                        if (f14a) {
                            Log.v("FragmentManager", "saveAllState: adding back stack #" + i2 + ": " + this.f23i.get(i2));
                        }
                    }
                }
            }
            agVar = new ag();
            agVar.f48a = aiVarArr;
            agVar.f49b = iArr;
            agVar.f50c = c0067kArr;
            return agVar;
        } else if (!f14a) {
            return null;
        } else {
            Log.v("FragmentManager", "saveAllState: no fragments!");
            return null;
        }
    }

    public final void m56e(C0073r c0073r, int i, int i2) {
        if (f14a) {
            Log.v("FragmentManager", "attach: " + c0073r);
        }
        if (c0073r.mDetached) {
            c0073r.mDetached = false;
            if (!c0073r.mAdded) {
                if (this.f21g == null) {
                    this.f21g = new ArrayList();
                }
                if (this.f21g.contains(c0073r)) {
                    throw new IllegalStateException("Fragment already added: " + c0073r);
                }
                if (f14a) {
                    Log.v("FragmentManager", "add from attach: " + c0073r);
                }
                this.f21g.add(c0073r);
                c0073r.mAdded = true;
                if (c0073r.mHasMenu && c0073r.mMenuVisible) {
                    this.f32s = true;
                }
                m34a(c0073r, this.f28n, i, i2, false);
            }
        }
    }

    public final void m57f() {
        this.f33t = false;
    }

    public final void m58g() {
        this.f33t = false;
        m18d(1);
    }

    public final void m59h() {
        this.f33t = false;
        m18d(2);
    }

    public final void m60i() {
        this.f33t = false;
        m18d(4);
    }

    public final void m61j() {
        this.f33t = false;
        m18d(5);
    }

    public final void m62k() {
        m18d(4);
    }

    public final void m63l() {
        this.f33t = true;
        m18d(3);
    }

    public final void m64m() {
        m18d(2);
    }

    public final void m65n() {
        m18d(1);
    }

    public final void m66o() {
        this.f34u = true;
        m52c();
        m18d(0);
        this.f29o = null;
        this.f30p = null;
        this.f31q = null;
    }

    public final void m67p() {
        if (this.f21g != null) {
            for (int i = 0; i < this.f21g.size(); i++) {
                C0073r c0073r = (C0073r) this.f21g.get(i);
                if (c0073r != null) {
                    c0073r.performLowMemory();
                }
            }
        }
    }

    final bl m68q() {
        return this;
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append("FragmentManager{");
        stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
        stringBuilder.append(" in ");
        if (this.f31q != null) {
            bd.m168a(this.f31q, stringBuilder);
        } else {
            bd.m168a(this.f29o, stringBuilder);
        }
        stringBuilder.append("}}");
        return stringBuilder.toString();
    }
}
