package p000c.p001m.p002x.p003a.gv;

import android.os.Build.VERSION;
import android.transition.Transition;
import android.transition.TransitionManager;
import android.transition.TransitionSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.View;
import android.view.ViewGroup;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import p000c.p001m.p002x.p003a.gv.al.C0014a;
import p000c.p001m.p002x.p003a.gv.al.C0015b;

final class C0063g extends ak implements Runnable {
    static final boolean f248a = (VERSION.SDK_INT >= 21);
    final aa f249b;
    C0061a f250c;
    C0061a f251d;
    int f252e;
    int f253f;
    int f254g;
    int f255h;
    int f256i;
    int f257j;
    int f258k;
    boolean f259l;
    boolean f260m = true;
    String f261n;
    boolean f262o;
    int f263p = -1;
    int f264q;
    CharSequence f265r;
    int f266s;
    CharSequence f267t;
    ArrayList<String> f268u;
    ArrayList<String> f269v;

    static final class C0061a {
        C0061a f234a;
        C0061a f235b;
        int f236c;
        C0073r f237d;
        int f238e;
        int f239f;
        int f240g;
        int f241h;
        ArrayList<C0073r> f242i;

        C0061a() {
        }
    }

    public class C0062b {
        public ba<String, String> f243a = new ba();
        public ArrayList<View> f244b = new ArrayList();
        public C0014a f245c = new C0014a();
        public View f246d;
        final /* synthetic */ C0063g f247e;

        public C0062b(C0063g c0063g) {
            this.f247e = c0063g;
        }
    }

    public C0063g(aa aaVar) {
        this.f249b = aaVar;
    }

    private int m265a(boolean z) {
        if (this.f262o) {
            throw new IllegalStateException("commit already called");
        }
        if (aa.f14a) {
            Log.v("FragmentManager", "Commit: " + this);
            m291a("  ", new PrintWriter(new be("FragmentManager")));
        }
        this.f262o = true;
        if (this.f259l) {
            this.f263p = this.f249b.m24a(this);
        } else {
            this.f263p = -1;
        }
        this.f249b.m37a((Runnable) this, z);
        return this.f263p;
    }

    private ba<String, View> m266a(C0062b c0062b, C0073r c0073r, boolean z) {
        ba baVar = new ba();
        if (this.f268u != null) {
            al.m84a((Map) baVar, c0073r.getView());
            if (z) {
                baVar.m142a(this.f269v);
            } else {
                baVar = C0063g.m268a(this.f268u, this.f269v, baVar);
            }
        }
        at atVar;
        ArrayList arrayList;
        if (z) {
            if (c0073r.mEnterTransitionCallback != null) {
                atVar = c0073r.mEnterTransitionCallback;
                arrayList = this.f269v;
                at.m113d();
            }
            m273a(c0062b, baVar, false);
        } else {
            if (c0073r.mExitTransitionCallback != null) {
                atVar = c0073r.mExitTransitionCallback;
                arrayList = this.f269v;
                at.m113d();
            }
            C0063g.m282b(c0062b, baVar, false);
        }
        return baVar;
    }

    static /* synthetic */ ba m267a(C0063g c0063g, C0062b c0062b, boolean z, C0073r c0073r) {
        ba baVar = new ba();
        View view = c0073r.getView();
        if (!(view == null || c0063g.f268u == null)) {
            al.m84a((Map) baVar, view);
            if (z) {
                baVar = C0063g.m268a(c0063g.f268u, c0063g.f269v, baVar);
            } else {
                baVar.m142a(c0063g.f269v);
            }
        }
        at atVar;
        ArrayList arrayList;
        if (z) {
            if (c0073r.mExitTransitionCallback != null) {
                atVar = c0073r.mExitTransitionCallback;
                arrayList = c0063g.f269v;
                at.m113d();
            }
            c0063g.m273a(c0062b, baVar, true);
        } else {
            if (c0073r.mEnterTransitionCallback != null) {
                atVar = c0073r.mEnterTransitionCallback;
                arrayList = c0063g.f269v;
                at.m113d();
            }
            C0063g.m282b(c0062b, baVar, true);
        }
        return baVar;
    }

    private static ba<String, View> m268a(ArrayList<String> arrayList, ArrayList<String> arrayList2, ba<String, View> baVar) {
        if (baVar.isEmpty()) {
            return baVar;
        }
        ba<String, View> baVar2 = new ba();
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            View view = (View) baVar.get(arrayList.get(i));
            if (view != null) {
                baVar2.put(arrayList2.get(i), view);
            }
        }
        return baVar2;
    }

    private C0062b m269a(SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2, boolean z) {
        int i = 0;
        int size = sparseArray2.size();
        for (int i2 = 0; i2 < size; i2++) {
            C0073r c0073r = (C0073r) sparseArray2.valueAt(i2);
            if (c0073r.mState <= 0) {
                this.f249b.m47b(c0073r);
                this.f249b.m34a(c0073r, 1, 0, 0, false);
            }
        }
        C0062b c0062b = new C0062b(this);
        c0062b.f246d = new View(this.f249b.f29o.f301b);
        int i3 = 0;
        for (int i4 = 0; i4 < sparseArray.size(); i4++) {
            if (m278a(sparseArray.keyAt(i4), c0062b, z, sparseArray, sparseArray2)) {
                i3 = 1;
            }
        }
        while (i < sparseArray2.size()) {
            int keyAt = sparseArray2.keyAt(i);
            if (sparseArray.get(keyAt) == null && m278a(keyAt, c0062b, z, sparseArray, sparseArray2)) {
                i3 = 1;
            }
            i++;
        }
        return i3 == 0 ? null : c0062b;
    }

    private static void m270a(SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2, C0073r c0073r) {
        if (c0073r != null) {
            int i = c0073r.mContainerId;
            if (i != 0 && !c0073r.isHidden()) {
                if (c0073r.isAdded() && c0073r.getView() != null && sparseArray.get(i) == null) {
                    sparseArray.put(i, c0073r);
                }
                if (sparseArray2.get(i) == c0073r) {
                    sparseArray2.remove(i);
                }
            }
        }
    }

    private static void m271a(ba<String, String> baVar, String str, String str2) {
        if (str != null && str2 != null) {
            for (int i = 0; i < baVar.size(); i++) {
                if (str.equals(baVar.m139c(i))) {
                    baVar.m135a(i, (Object) str2);
                    return;
                }
            }
            baVar.put(str, str2);
        }
    }

    private void m272a(C0062b c0062b, int i, Object obj) {
        if (this.f249b.f21g != null) {
            for (int i2 = 0; i2 < this.f249b.f21g.size(); i2++) {
                C0073r c0073r = (C0073r) this.f249b.f21g.get(i2);
                if (!(c0073r.mView == null || c0073r.mContainer == null || c0073r.mContainerId != i)) {
                    if (!c0073r.mHidden) {
                        al.m81a(obj, c0073r.mView, false);
                        c0062b.f244b.remove(c0073r.mView);
                    } else if (!c0062b.f244b.contains(c0073r.mView)) {
                        al.m81a(obj, c0073r.mView, true);
                        c0062b.f244b.add(c0073r.mView);
                    }
                }
            }
        }
    }

    private void m273a(C0062b c0062b, ba<String, View> baVar, boolean z) {
        int size = this.f269v == null ? 0 : this.f269v.size();
        for (int i = 0; i < size; i++) {
            String str = (String) this.f268u.get(i);
            View view = (View) baVar.get((String) this.f269v.get(i));
            if (view != null) {
                String transitionName = view.getTransitionName();
                if (z) {
                    C0063g.m271a(c0062b.f243a, str, transitionName);
                } else {
                    C0063g.m271a(c0062b.f243a, transitionName, str);
                }
            }
        }
    }

    private static void m274a(C0062b c0062b, ArrayList<String> arrayList, ArrayList<String> arrayList2) {
        if (arrayList != null) {
            for (int i = 0; i < arrayList.size(); i++) {
                C0063g.m271a(c0062b.f243a, (String) arrayList.get(i), (String) arrayList2.get(i));
            }
        }
    }

    static /* synthetic */ void m275a(C0063g c0063g, ba baVar, C0062b c0062b) {
        if (c0063g.f269v != null && !baVar.isEmpty()) {
            View view = (View) baVar.get(c0063g.f269v.get(0));
            if (view != null) {
                c0062b.f245c.f62a = view;
            }
        }
    }

    static /* synthetic */ void m277a(C0073r c0073r, C0073r c0073r2, boolean z, ba baVar) {
        if ((z ? c0073r2.mEnterTransitionCallback : c0073r.mEnterTransitionCallback) != null) {
            ArrayList arrayList = new ArrayList(baVar.keySet());
            arrayList = new ArrayList(baVar.values());
            at.m111b();
        }
    }

    private boolean m278a(int i, C0062b c0062b, boolean z, SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2) {
        View view = (ViewGroup) this.f249b.f30p.mo67a(i);
        if (view == null) {
            return false;
        }
        Object obj;
        Object obj2;
        Transition transition;
        Object obj3;
        Map map;
        Object obj4;
        C0073r c0073r = (C0073r) sparseArray2.get(i);
        C0073r c0073r2 = (C0073r) sparseArray.get(i);
        if (c0073r == null) {
            obj = null;
        } else {
            obj = al.m77a(z ? c0073r.getReenterTransition() : c0073r.getEnterTransition());
        }
        if (c0073r == null || c0073r2 == null) {
            obj2 = null;
        } else {
            Object sharedElementReturnTransition = z ? c0073r2.getSharedElementReturnTransition() : c0073r.getSharedElementEnterTransition();
            if (sharedElementReturnTransition == null) {
                obj2 = null;
            } else {
                transition = (Transition) sharedElementReturnTransition;
                if (transition == null) {
                    obj2 = null;
                } else {
                    obj2 = new TransitionSet();
                    obj2.addTransition(transition);
                }
            }
        }
        if (c0073r2 == null) {
            obj3 = null;
        } else {
            obj3 = al.m77a(z ? c0073r2.getReturnTransition() : c0073r2.getExitTransition());
        }
        ArrayList arrayList = new ArrayList();
        if (obj2 != null) {
            ba a = m266a(c0062b, c0073r2, z);
            if (a.isEmpty()) {
                map = null;
                obj4 = null;
            } else {
                if ((z ? c0073r2.mEnterTransitionCallback : c0073r.mEnterTransitionCallback) != null) {
                    ArrayList arrayList2 = new ArrayList(a.keySet());
                    arrayList2 = new ArrayList(a.values());
                    at.m110a();
                }
                view.getViewTreeObserver().addOnPreDrawListener(new C0065i(this, view, obj2, arrayList, c0062b, z, c0073r, c0073r2));
                Object obj5 = a;
                obj4 = obj2;
            }
        } else {
            map = null;
            obj4 = obj2;
        }
        if (obj == null && obj4 == null && obj3 == null) {
            return false;
        }
        boolean allowReturnTransitionOverlap;
        Object obj6;
        ArrayList arrayList3 = new ArrayList();
        obj2 = obj3 != null ? al.m78a(obj3, c0073r2.getView(), arrayList3, map, c0062b.f246d) : obj3;
        if (!(this.f269v == null || map == null)) {
            View view2 = (View) map.get(this.f269v.get(0));
            if (view2 != null) {
                if (obj2 != null) {
                    al.m79a(obj2, view2);
                }
                if (obj4 != null) {
                    al.m79a(obj4, view2);
                }
            }
        }
        C0015b c0064h = new C0064h(this, c0073r);
        ArrayList arrayList4 = new ArrayList();
        Map baVar = new ba();
        if (c0073r != null) {
            allowReturnTransitionOverlap = z ? c0073r.getAllowReturnTransitionOverlap() : c0073r.getAllowEnterTransitionOverlap();
        } else {
            allowReturnTransitionOverlap = true;
        }
        transition = (Transition) obj;
        Transition transition2 = (Transition) obj2;
        Transition transition3 = (Transition) obj4;
        if (transition == null || transition2 == null) {
            allowReturnTransitionOverlap = true;
        }
        if (allowReturnTransitionOverlap) {
            TransitionSet transitionSet = new TransitionSet();
            if (transition != null) {
                transitionSet.addTransition(transition);
            }
            if (transition2 != null) {
                transitionSet.addTransition(transition2);
            }
            if (transition3 != null) {
                transitionSet.addTransition(transition3);
            }
            obj6 = transitionSet;
        } else {
            if (transition2 != null && transition != null) {
                transition = new TransitionSet().addTransition(transition2).addTransition(transition).setOrdering(1);
            } else if (transition2 != null) {
                transition = transition2;
            } else if (transition == null) {
                transition = null;
            }
            if (transition3 != null) {
                obj6 = new TransitionSet();
                if (transition != null) {
                    obj6.addTransition(transition);
                }
                obj6.addTransition(transition3);
            } else {
                transition2 = transition;
            }
        }
        if (obj6 != null) {
            View view3 = c0062b.f246d;
            C0014a c0014a = c0062b.f245c;
            Map map2 = c0062b.f243a;
            if (!(obj == null && obj4 == null)) {
                Transition transition4 = (Transition) obj;
                if (transition4 != null) {
                    transition4.addTarget(view3);
                }
                if (obj4 != null) {
                    al.m80a(obj4, view3, map, arrayList);
                }
                view.getViewTreeObserver().addOnPreDrawListener(new an(view, transition4, view3, c0064h, map2, baVar, arrayList4));
                if (transition4 != null) {
                    transition4.setEpicenterCallback(new ao(c0014a));
                }
            }
            view.getViewTreeObserver().addOnPreDrawListener(new C0066j(this, view, c0062b, i, obj6));
            al.m81a(obj6, c0062b.f246d, true);
            m272a(c0062b, i, obj6);
            TransitionManager.beginDelayedTransition(view, (Transition) obj6);
            View view4 = c0062b.f246d;
            ArrayList arrayList5 = c0062b.f244b;
            Transition transition5 = (Transition) obj;
            Transition transition6 = (Transition) obj2;
            Transition transition7 = (Transition) obj4;
            Transition transition8 = (Transition) obj6;
            if (transition8 != null) {
                view.getViewTreeObserver().addOnPreDrawListener(new ap(view, transition5, arrayList4, transition6, arrayList3, transition7, arrayList, baVar, arrayList5, transition8, view4));
            }
        }
        return obj6 != null;
    }

    private void m279b(int i, C0073r c0073r, String str) {
        c0073r.mFragmentManager = this.f249b;
        if (str != null) {
            if (c0073r.mTag == null || str.equals(c0073r.mTag)) {
                c0073r.mTag = str;
            } else {
                throw new IllegalStateException("Can't change tag of fragment " + c0073r + ": was " + c0073r.mTag + " now " + str);
            }
        }
        if (i != 0) {
            if (c0073r.mFragmentId == 0 || c0073r.mFragmentId == i) {
                c0073r.mFragmentId = i;
                c0073r.mContainerId = i;
            } else {
                throw new IllegalStateException("Can't change container ID of fragment " + c0073r + ": was " + c0073r.mFragmentId + " now " + i);
            }
        }
        C0061a c0061a = new C0061a();
        c0061a.f236c = 1;
        c0061a.f237d = c0073r;
        m290a(c0061a);
    }

    private void m280b(SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2) {
        if (this.f249b.f30p.mo68a()) {
            for (C0061a c0061a = this.f250c; c0061a != null; c0061a = c0061a.f234a) {
                switch (c0061a.f236c) {
                    case 1:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 2:
                        C0073r c0073r = c0061a.f237d;
                        if (this.f249b.f21g != null) {
                            C0073r c0073r2 = c0073r;
                            for (int i = 0; i < this.f249b.f21g.size(); i++) {
                                C0073r c0073r3 = (C0073r) this.f249b.f21g.get(i);
                                if (c0073r2 == null || c0073r3.mContainerId == c0073r2.mContainerId) {
                                    if (c0073r3 == c0073r2) {
                                        c0073r2 = null;
                                        sparseArray2.remove(c0073r3.mContainerId);
                                    } else {
                                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0073r3);
                                    }
                                }
                            }
                        }
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 3:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 4:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 5:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 6:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 7:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    default:
                        break;
                }
            }
        }
    }

    private static void m281b(SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2, C0073r c0073r) {
        if (c0073r != null) {
            int i = c0073r.mContainerId;
            if (i != 0) {
                if (!c0073r.isAdded()) {
                    sparseArray2.put(i, c0073r);
                }
                if (sparseArray.get(i) == c0073r) {
                    sparseArray.remove(i);
                }
            }
        }
    }

    private static void m282b(C0062b c0062b, ba<String, View> baVar, boolean z) {
        int size = baVar.size();
        for (int i = 0; i < size; i++) {
            String str = (String) baVar.m138b(i);
            String transitionName = ((View) baVar.m139c(i)).getTransitionName();
            if (z) {
                C0063g.m271a(c0062b.f243a, str, transitionName);
            } else {
                C0063g.m271a(c0062b.f243a, transitionName, str);
            }
        }
    }

    public final int mo52a() {
        return m265a(false);
    }

    public final ak mo53a(int i, C0073r c0073r, String str) {
        m279b(i, c0073r, str);
        return this;
    }

    public final ak mo54a(C0073r c0073r) {
        C0061a c0061a = new C0061a();
        c0061a.f236c = 3;
        c0061a.f237d = c0073r;
        m290a(c0061a);
        return this;
    }

    public final ak mo55a(C0073r c0073r, String str) {
        m279b(0, c0073r, str);
        return this;
    }

    public final C0062b m287a(boolean z, C0062b c0062b, SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2) {
        if (aa.f14a) {
            Log.v("FragmentManager", "popFromBackStack: " + this);
            m291a("  ", new PrintWriter(new be("FragmentManager")));
        }
        if (f248a) {
            if (c0062b == null) {
                if (!(sparseArray.size() == 0 && sparseArray2.size() == 0)) {
                    c0062b = m269a((SparseArray) sparseArray, (SparseArray) sparseArray2, true);
                }
            } else if (!z) {
                C0063g.m274a(c0062b, this.f269v, this.f268u);
            }
        }
        m288a(-1);
        int i = c0062b != null ? 0 : this.f258k;
        int i2 = c0062b != null ? 0 : this.f257j;
        C0061a c0061a = this.f251d;
        while (c0061a != null) {
            int i3 = c0062b != null ? 0 : c0061a.f240g;
            int i4 = c0062b != null ? 0 : c0061a.f241h;
            C0073r c0073r;
            C0073r c0073r2;
            switch (c0061a.f236c) {
                case 1:
                    c0073r = c0061a.f237d;
                    c0073r.mNextAnim = i4;
                    this.f249b.m33a(c0073r, aa.m16c(i2), i);
                    break;
                case 2:
                    c0073r = c0061a.f237d;
                    if (c0073r != null) {
                        c0073r.mNextAnim = i4;
                        this.f249b.m33a(c0073r, aa.m16c(i2), i);
                    }
                    if (c0061a.f242i == null) {
                        break;
                    }
                    for (int i5 = 0; i5 < c0061a.f242i.size(); i5++) {
                        c0073r2 = (C0073r) c0061a.f242i.get(i5);
                        c0073r2.mNextAnim = i3;
                        this.f249b.m35a(c0073r2, false);
                    }
                    break;
                case 3:
                    c0073r2 = c0061a.f237d;
                    c0073r2.mNextAnim = i3;
                    this.f249b.m35a(c0073r2, false);
                    break;
                case 4:
                    c0073r2 = c0061a.f237d;
                    c0073r2.mNextAnim = i3;
                    this.f249b.m51c(c0073r2, aa.m16c(i2), i);
                    break;
                case 5:
                    c0073r = c0061a.f237d;
                    c0073r.mNextAnim = i4;
                    this.f249b.m48b(c0073r, aa.m16c(i2), i);
                    break;
                case 6:
                    c0073r2 = c0061a.f237d;
                    c0073r2.mNextAnim = i3;
                    this.f249b.m56e(c0073r2, aa.m16c(i2), i);
                    break;
                case 7:
                    c0073r2 = c0061a.f237d;
                    c0073r2.mNextAnim = i3;
                    this.f249b.m54d(c0073r2, aa.m16c(i2), i);
                    break;
                default:
                    throw new IllegalArgumentException("Unknown cmd: " + c0061a.f236c);
            }
            c0061a = c0061a.f235b;
        }
        if (z) {
            this.f249b.m29a(this.f249b.f28n, aa.m16c(i2), i, true);
            c0062b = null;
        }
        if (this.f263p >= 0) {
            this.f249b.m44b(this.f263p);
            this.f263p = -1;
        }
        return c0062b;
    }

    final void m288a(int i) {
        if (this.f259l) {
            if (aa.f14a) {
                Log.v("FragmentManager", "Bump nesting in " + this + " by " + i);
            }
            for (C0061a c0061a = this.f250c; c0061a != null; c0061a = c0061a.f234a) {
                C0073r c0073r;
                if (c0061a.f237d != null) {
                    c0073r = c0061a.f237d;
                    c0073r.mBackStackNesting += i;
                    if (aa.f14a) {
                        Log.v("FragmentManager", "Bump nesting of " + c0061a.f237d + " to " + c0061a.f237d.mBackStackNesting);
                    }
                }
                if (c0061a.f242i != null) {
                    for (int size = c0061a.f242i.size() - 1; size >= 0; size--) {
                        c0073r = (C0073r) c0061a.f242i.get(size);
                        c0073r.mBackStackNesting += i;
                        if (aa.f14a) {
                            Log.v("FragmentManager", "Bump nesting of " + c0073r + " to " + c0073r.mBackStackNesting);
                        }
                    }
                }
            }
        }
    }

    public final void m289a(SparseArray<C0073r> sparseArray, SparseArray<C0073r> sparseArray2) {
        if (this.f249b.f30p.mo68a()) {
            for (C0061a c0061a = this.f251d; c0061a != null; c0061a = c0061a.f235b) {
                switch (c0061a.f236c) {
                    case 1:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 2:
                        if (c0061a.f242i != null) {
                            for (int size = c0061a.f242i.size() - 1; size >= 0; size--) {
                                C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, (C0073r) c0061a.f242i.get(size));
                            }
                        }
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 3:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 4:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 5:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 6:
                        C0063g.m281b((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    case 7:
                        C0063g.m270a((SparseArray) sparseArray, (SparseArray) sparseArray2, c0061a.f237d);
                        break;
                    default:
                        break;
                }
            }
        }
    }

    final void m290a(C0061a c0061a) {
        if (this.f250c == null) {
            this.f251d = c0061a;
            this.f250c = c0061a;
        } else {
            c0061a.f235b = this.f251d;
            this.f251d.f234a = c0061a;
            this.f251d = c0061a;
        }
        c0061a.f238e = this.f253f;
        c0061a.f239f = this.f254g;
        c0061a.f240g = this.f255h;
        c0061a.f241h = this.f256i;
        this.f252e++;
    }

    public final void m291a(String str, PrintWriter printWriter) {
        m292a(str, printWriter, true);
    }

    public final void m292a(String str, PrintWriter printWriter, boolean z) {
        if (z) {
            printWriter.print(str);
            printWriter.print("mName=");
            printWriter.print(this.f261n);
            printWriter.print(" mIndex=");
            printWriter.print(this.f263p);
            printWriter.print(" mCommitted=");
            printWriter.println(this.f262o);
            if (this.f257j != 0) {
                printWriter.print(str);
                printWriter.print("mTransition=#");
                printWriter.print(Integer.toHexString(this.f257j));
                printWriter.print(" mTransitionStyle=#");
                printWriter.println(Integer.toHexString(this.f258k));
            }
            if (!(this.f253f == 0 && this.f254g == 0)) {
                printWriter.print(str);
                printWriter.print("mEnterAnim=#");
                printWriter.print(Integer.toHexString(this.f253f));
                printWriter.print(" mExitAnim=#");
                printWriter.println(Integer.toHexString(this.f254g));
            }
            if (!(this.f255h == 0 && this.f256i == 0)) {
                printWriter.print(str);
                printWriter.print("mPopEnterAnim=#");
                printWriter.print(Integer.toHexString(this.f255h));
                printWriter.print(" mPopExitAnim=#");
                printWriter.println(Integer.toHexString(this.f256i));
            }
            if (!(this.f264q == 0 && this.f265r == null)) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbTitleRes=#");
                printWriter.print(Integer.toHexString(this.f264q));
                printWriter.print(" mBreadCrumbTitleText=");
                printWriter.println(this.f265r);
            }
            if (!(this.f266s == 0 && this.f267t == null)) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbShortTitleRes=#");
                printWriter.print(Integer.toHexString(this.f266s));
                printWriter.print(" mBreadCrumbShortTitleText=");
                printWriter.println(this.f267t);
            }
        }
        if (this.f250c != null) {
            printWriter.print(str);
            printWriter.println("Operations:");
            String str2 = str + "    ";
            int i = 0;
            C0061a c0061a = this.f250c;
            while (c0061a != null) {
                String str3;
                switch (c0061a.f236c) {
                    case 0:
                        str3 = "NULL";
                        break;
                    case 1:
                        str3 = "ADD";
                        break;
                    case 2:
                        str3 = "REPLACE";
                        break;
                    case 3:
                        str3 = "REMOVE";
                        break;
                    case 4:
                        str3 = "HIDE";
                        break;
                    case 5:
                        str3 = "SHOW";
                        break;
                    case 6:
                        str3 = "DETACH";
                        break;
                    case 7:
                        str3 = "ATTACH";
                        break;
                    default:
                        str3 = "cmd=" + c0061a.f236c;
                        break;
                }
                printWriter.print(str);
                printWriter.print("  Op #");
                printWriter.print(i);
                printWriter.print(": ");
                printWriter.print(str3);
                printWriter.print(" ");
                printWriter.println(c0061a.f237d);
                if (z) {
                    if (!(c0061a.f238e == 0 && c0061a.f239f == 0)) {
                        printWriter.print(str);
                        printWriter.print("enterAnim=#");
                        printWriter.print(Integer.toHexString(c0061a.f238e));
                        printWriter.print(" exitAnim=#");
                        printWriter.println(Integer.toHexString(c0061a.f239f));
                    }
                    if (!(c0061a.f240g == 0 && c0061a.f241h == 0)) {
                        printWriter.print(str);
                        printWriter.print("popEnterAnim=#");
                        printWriter.print(Integer.toHexString(c0061a.f240g));
                        printWriter.print(" popExitAnim=#");
                        printWriter.println(Integer.toHexString(c0061a.f241h));
                    }
                }
                if (c0061a.f242i != null && c0061a.f242i.size() > 0) {
                    for (int i2 = 0; i2 < c0061a.f242i.size(); i2++) {
                        printWriter.print(str2);
                        if (c0061a.f242i.size() == 1) {
                            printWriter.print("Removed: ");
                        } else {
                            if (i2 == 0) {
                                printWriter.println("Removed:");
                            }
                            printWriter.print(str2);
                            printWriter.print("  #");
                            printWriter.print(i2);
                            printWriter.print(": ");
                        }
                        printWriter.println(c0061a.f242i.get(i2));
                    }
                }
                c0061a = c0061a.f234a;
                i++;
            }
        }
    }

    public final int mo56b() {
        return m265a(true);
    }

    public final void run() {
        if (aa.f14a) {
            Log.v("FragmentManager", "Run: " + this);
        }
        if (!this.f259l || this.f263p >= 0) {
            C0062b a;
            m288a(1);
            if (f248a) {
                SparseArray sparseArray = new SparseArray();
                SparseArray sparseArray2 = new SparseArray();
                m280b(sparseArray, sparseArray2);
                a = m269a(sparseArray, sparseArray2, false);
            } else {
                a = null;
            }
            int i = a != null ? 0 : this.f258k;
            int i2 = a != null ? 0 : this.f257j;
            C0061a c0061a = this.f250c;
            while (c0061a != null) {
                int i3 = a != null ? 0 : c0061a.f238e;
                int i4 = a != null ? 0 : c0061a.f239f;
                C0073r c0073r;
                switch (c0061a.f236c) {
                    case 1:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i3;
                        this.f249b.m35a(c0073r, false);
                        break;
                    case 2:
                        C0073r c0073r2 = c0061a.f237d;
                        int i5 = c0073r2.mContainerId;
                        if (this.f249b.f21g != null) {
                            int size = this.f249b.f21g.size() - 1;
                            while (size >= 0) {
                                c0073r = (C0073r) this.f249b.f21g.get(size);
                                if (aa.f14a) {
                                    Log.v("FragmentManager", "OP_REPLACE: adding=" + c0073r2 + " old=" + c0073r);
                                }
                                if (c0073r.mContainerId == i5) {
                                    if (c0073r == c0073r2) {
                                        c0073r = null;
                                        c0061a.f237d = null;
                                        size--;
                                        c0073r2 = c0073r;
                                    } else {
                                        if (c0061a.f242i == null) {
                                            c0061a.f242i = new ArrayList();
                                        }
                                        c0061a.f242i.add(c0073r);
                                        c0073r.mNextAnim = i4;
                                        if (this.f259l) {
                                            c0073r.mBackStackNesting++;
                                            if (aa.f14a) {
                                                Log.v("FragmentManager", "Bump nesting of " + c0073r + " to " + c0073r.mBackStackNesting);
                                            }
                                        }
                                        this.f249b.m33a(c0073r, i2, i);
                                    }
                                }
                                c0073r = c0073r2;
                                size--;
                                c0073r2 = c0073r;
                            }
                        }
                        if (c0073r2 == null) {
                            break;
                        }
                        c0073r2.mNextAnim = i3;
                        this.f249b.m35a(c0073r2, false);
                        break;
                    case 3:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i4;
                        this.f249b.m33a(c0073r, i2, i);
                        break;
                    case 4:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i4;
                        this.f249b.m48b(c0073r, i2, i);
                        break;
                    case 5:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i3;
                        this.f249b.m51c(c0073r, i2, i);
                        break;
                    case 6:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i4;
                        this.f249b.m54d(c0073r, i2, i);
                        break;
                    case 7:
                        c0073r = c0061a.f237d;
                        c0073r.mNextAnim = i3;
                        this.f249b.m56e(c0073r, i2, i);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown cmd: " + c0061a.f236c);
                }
                c0061a = c0061a.f234a;
            }
            this.f249b.m29a(this.f249b.f28n, i2, i, true);
            if (this.f259l) {
                this.f249b.m46b(this);
                return;
            }
            return;
        }
        throw new IllegalStateException("addToBackStack() called after commit()");
    }

    public final String toString() {
        StringBuilder stringBuilder = new StringBuilder(128);
        stringBuilder.append("BackStackEntry{");
        stringBuilder.append(Integer.toHexString(System.identityHashCode(this)));
        if (this.f263p >= 0) {
            stringBuilder.append(" #");
            stringBuilder.append(this.f263p);
        }
        if (this.f261n != null) {
            stringBuilder.append(" ");
            stringBuilder.append(this.f261n);
        }
        stringBuilder.append("}");
        return stringBuilder.toString();
    }
}
