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
import p000c.p001m.p002x.p003a.gv.ah.C0009a;
import p000c.p001m.p002x.p003a.gv.ah.C0010b;

final class C0050e extends ag implements Runnable {
    static final boolean f201a = (VERSION.SDK_INT >= 21);
    final C0074w f202b;
    C0048a f203c;
    C0048a f204d;
    int f205e;
    int f206f;
    int f207g;
    int f208h;
    int f209i;
    int f210j;
    int f211k;
    boolean f212l;
    boolean f213m = true;
    String f214n;
    boolean f215o;
    int f216p = -1;
    int f217q;
    CharSequence f218r;
    int f219s;
    CharSequence f220t;
    ArrayList<String> f221u;
    ArrayList<String> f222v;

    static final class C0048a {
        C0048a f187a;
        C0048a f188b;
        int f189c;
        C0058n f190d;
        int f191e;
        int f192f;
        int f193g;
        int f194h;
        ArrayList<C0058n> f195i;

        C0048a() {
        }
    }

    public class C0049b {
        public av<String, String> f196a = new av();
        public ArrayList<View> f197b = new ArrayList();
        public C0009a f198c = new C0009a();
        public View f199d;
        final /* synthetic */ C0050e f200e;

        public C0049b(C0050e c0050e) {
            this.f200e = c0050e;
        }
    }

    public C0050e(C0074w c0074w) {
        this.f202b = c0074w;
    }

    private int m190a(boolean z) {
        if (this.f215o) {
            throw new IllegalStateException("commit already called");
        }
        if (C0074w.f272a) {
            Log.v("FragmentManager", "Commit: " + this);
            m216a("  ", new PrintWriter(new az("FragmentManager")));
        }
        this.f215o = true;
        if (this.f212l) {
            this.f216p = this.f202b.m319a(this);
        } else {
            this.f216p = -1;
        }
        this.f202b.m332a((Runnable) this, z);
        return this.f216p;
    }

    private av<String, View> m191a(C0049b c0049b, C0058n c0058n, boolean z) {
        av avVar = new av();
        if (this.f221u != null) {
            ah.m31a((Map) avVar, c0058n.getView());
            if (z) {
                avVar.m87a(this.f222v);
            } else {
                avVar = C0050e.m193a(this.f221u, this.f222v, avVar);
            }
        }
        ap apVar;
        ArrayList arrayList;
        if (z) {
            if (c0058n.mEnterTransitionCallback != null) {
                apVar = c0058n.mEnterTransitionCallback;
                arrayList = this.f222v;
                ap.m60d();
            }
            m198a(c0049b, avVar, false);
        } else {
            if (c0058n.mExitTransitionCallback != null) {
                apVar = c0058n.mExitTransitionCallback;
                arrayList = this.f222v;
                ap.m60d();
            }
            C0050e.m207b(c0049b, avVar, false);
        }
        return avVar;
    }

    static /* synthetic */ av m192a(C0050e c0050e, C0049b c0049b, boolean z, C0058n c0058n) {
        av avVar = new av();
        View view = c0058n.getView();
        if (!(view == null || c0050e.f221u == null)) {
            ah.m31a((Map) avVar, view);
            if (z) {
                avVar = C0050e.m193a(c0050e.f221u, c0050e.f222v, avVar);
            } else {
                avVar.m87a(c0050e.f222v);
            }
        }
        ap apVar;
        ArrayList arrayList;
        if (z) {
            if (c0058n.mExitTransitionCallback != null) {
                apVar = c0058n.mExitTransitionCallback;
                arrayList = c0050e.f222v;
                ap.m60d();
            }
            c0050e.m198a(c0049b, avVar, true);
        } else {
            if (c0058n.mEnterTransitionCallback != null) {
                apVar = c0058n.mEnterTransitionCallback;
                arrayList = c0050e.f222v;
                ap.m60d();
            }
            C0050e.m207b(c0049b, avVar, true);
        }
        return avVar;
    }

    private static av<String, View> m193a(ArrayList<String> arrayList, ArrayList<String> arrayList2, av<String, View> avVar) {
        if (avVar.isEmpty()) {
            return avVar;
        }
        av<String, View> avVar2 = new av();
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            View view = (View) avVar.get(arrayList.get(i));
            if (view != null) {
                avVar2.put(arrayList2.get(i), view);
            }
        }
        return avVar2;
    }

    private C0049b m194a(SparseArray<C0058n> sparseArray, SparseArray<C0058n> sparseArray2, boolean z) {
        int i = 0;
        C0049b c0049b = new C0049b(this);
        c0049b.f199d = new View(this.f202b.f287o.f252b);
        int i2 = 0;
        int i3 = 0;
        while (i2 < sparseArray.size()) {
            int i4 = m203a(sparseArray.keyAt(i2), c0049b, z, sparseArray, sparseArray2) ? 1 : i3;
            i2++;
            i3 = i4;
        }
        while (i < sparseArray2.size()) {
            i4 = sparseArray2.keyAt(i);
            if (sparseArray.get(i4) == null && m203a(i4, c0049b, z, sparseArray, sparseArray2)) {
                i3 = 1;
            }
            i++;
        }
        return i3 == 0 ? null : c0049b;
    }

    private static void m195a(SparseArray<C0058n> sparseArray, C0058n c0058n) {
        if (c0058n != null) {
            int i = c0058n.mContainerId;
            if (i != 0 && !c0058n.isHidden() && c0058n.isAdded() && c0058n.getView() != null && sparseArray.get(i) == null) {
                sparseArray.put(i, c0058n);
            }
        }
    }

    private static void m196a(av<String, String> avVar, String str, String str2) {
        if (str != null && str2 != null) {
            for (int i = 0; i < avVar.size(); i++) {
                if (str.equals(avVar.m84c(i))) {
                    avVar.m80a(i, (Object) str2);
                    return;
                }
            }
            avVar.put(str, str2);
        }
    }

    private void m197a(C0049b c0049b, int i, Object obj) {
        if (this.f202b.f279g != null) {
            for (int i2 = 0; i2 < this.f202b.f279g.size(); i2++) {
                C0058n c0058n = (C0058n) this.f202b.f279g.get(i2);
                if (!(c0058n.mView == null || c0058n.mContainer == null || c0058n.mContainerId != i)) {
                    if (!c0058n.mHidden) {
                        ah.m28a(obj, c0058n.mView, false);
                        c0049b.f197b.remove(c0058n.mView);
                    } else if (!c0049b.f197b.contains(c0058n.mView)) {
                        ah.m28a(obj, c0058n.mView, true);
                        c0049b.f197b.add(c0058n.mView);
                    }
                }
            }
        }
    }

    private void m198a(C0049b c0049b, av<String, View> avVar, boolean z) {
        int size = this.f222v == null ? 0 : this.f222v.size();
        for (int i = 0; i < size; i++) {
            String str = (String) this.f221u.get(i);
            View view = (View) avVar.get((String) this.f222v.get(i));
            if (view != null) {
                String transitionName = view.getTransitionName();
                if (z) {
                    C0050e.m196a(c0049b.f196a, str, transitionName);
                } else {
                    C0050e.m196a(c0049b.f196a, transitionName, str);
                }
            }
        }
    }

    private static void m199a(C0049b c0049b, ArrayList<String> arrayList, ArrayList<String> arrayList2) {
        if (arrayList != null) {
            for (int i = 0; i < arrayList.size(); i++) {
                C0050e.m196a(c0049b.f196a, (String) arrayList.get(i), (String) arrayList2.get(i));
            }
        }
    }

    static /* synthetic */ void m200a(C0050e c0050e, av avVar, C0049b c0049b) {
        if (c0050e.f222v != null && !avVar.isEmpty()) {
            View view = (View) avVar.get(c0050e.f222v.get(0));
            if (view != null) {
                c0049b.f198c.f17a = view;
            }
        }
    }

    static /* synthetic */ void m202a(C0058n c0058n, C0058n c0058n2, boolean z, av avVar) {
        if ((z ? c0058n2.mEnterTransitionCallback : c0058n.mEnterTransitionCallback) != null) {
            ArrayList arrayList = new ArrayList(avVar.keySet());
            arrayList = new ArrayList(avVar.values());
            ap.m58b();
        }
    }

    private boolean m203a(int i, C0049b c0049b, boolean z, SparseArray<C0058n> sparseArray, SparseArray<C0058n> sparseArray2) {
        View view = (ViewGroup) this.f202b.f288p.mo38a(i);
        if (view == null) {
            return false;
        }
        Object obj;
        Object obj2;
        Transition transition;
        Object obj3;
        Map map;
        Object obj4;
        C0058n c0058n = (C0058n) sparseArray2.get(i);
        C0058n c0058n2 = (C0058n) sparseArray.get(i);
        if (c0058n == null) {
            obj = null;
        } else {
            obj = ah.m24a(z ? c0058n.getReenterTransition() : c0058n.getEnterTransition());
        }
        if (c0058n == null || c0058n2 == null) {
            obj2 = null;
        } else {
            Object sharedElementReturnTransition = z ? c0058n2.getSharedElementReturnTransition() : c0058n.getSharedElementEnterTransition();
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
        if (c0058n2 == null) {
            obj3 = null;
        } else {
            obj3 = ah.m24a(z ? c0058n2.getReturnTransition() : c0058n2.getExitTransition());
        }
        ArrayList arrayList = new ArrayList();
        if (obj2 != null) {
            av a = m191a(c0049b, c0058n2, z);
            if (a.isEmpty()) {
                map = null;
                obj4 = null;
            } else {
                if ((z ? c0058n2.mEnterTransitionCallback : c0058n.mEnterTransitionCallback) != null) {
                    ArrayList arrayList2 = new ArrayList(a.keySet());
                    arrayList2 = new ArrayList(a.values());
                    ap.m57a();
                }
                view.getViewTreeObserver().addOnPreDrawListener(new C0052g(this, view, obj2, arrayList, c0049b, z, c0058n, c0058n2));
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
        obj2 = obj3 != null ? ah.m25a(obj3, c0058n2.getView(), arrayList3, map, c0049b.f199d) : obj3;
        if (!(this.f222v == null || map == null)) {
            View view2 = (View) map.get(this.f222v.get(0));
            if (view2 != null) {
                if (obj2 != null) {
                    ah.m26a(obj2, view2);
                }
                if (obj4 != null) {
                    ah.m26a(obj4, view2);
                }
            }
        }
        C0010b c0051f = new C0051f(this, c0058n);
        ArrayList arrayList4 = new ArrayList();
        Map avVar = new av();
        if (c0058n != null) {
            allowReturnTransitionOverlap = z ? c0058n.getAllowReturnTransitionOverlap() : c0058n.getAllowEnterTransitionOverlap();
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
            View view3 = c0049b.f199d;
            C0009a c0009a = c0049b.f198c;
            Map map2 = c0049b.f196a;
            if (!(obj == null && obj4 == null)) {
                Transition transition4 = (Transition) obj;
                if (transition4 != null) {
                    transition4.addTarget(view3);
                }
                if (obj4 != null) {
                    ah.m27a(obj4, view3, map, arrayList);
                }
                view.getViewTreeObserver().addOnPreDrawListener(new aj(view, transition4, view3, c0051f, map2, avVar, arrayList4));
                if (transition4 != null) {
                    transition4.setEpicenterCallback(new ak(c0009a));
                }
            }
            view.getViewTreeObserver().addOnPreDrawListener(new C0053h(this, view, c0049b, i, obj6));
            ah.m28a(obj6, c0049b.f199d, true);
            m197a(c0049b, i, obj6);
            TransitionManager.beginDelayedTransition(view, (Transition) obj6);
            View view4 = c0049b.f199d;
            ArrayList arrayList5 = c0049b.f197b;
            Transition transition5 = (Transition) obj;
            Transition transition6 = (Transition) obj2;
            Transition transition7 = (Transition) obj4;
            Transition transition8 = (Transition) obj6;
            if (transition8 != null) {
                view.getViewTreeObserver().addOnPreDrawListener(new al(view, transition5, arrayList4, transition6, arrayList3, transition7, arrayList, avVar, arrayList5, transition8, view4));
            }
        }
        return obj6 != null;
    }

    private void m204b(int i, C0058n c0058n, String str) {
        c0058n.mFragmentManager = this.f202b;
        if (str != null) {
            if (c0058n.mTag == null || str.equals(c0058n.mTag)) {
                c0058n.mTag = str;
            } else {
                throw new IllegalStateException("Can't change tag of fragment " + c0058n + ": was " + c0058n.mTag + " now " + str);
            }
        }
        if (i != 0) {
            if (c0058n.mFragmentId == 0 || c0058n.mFragmentId == i) {
                c0058n.mFragmentId = i;
                c0058n.mContainerId = i;
            } else {
                throw new IllegalStateException("Can't change container ID of fragment " + c0058n + ": was " + c0058n.mFragmentId + " now " + i);
            }
        }
        C0048a c0048a = new C0048a();
        c0048a.f189c = 1;
        c0048a.f190d = c0058n;
        m215a(c0048a);
    }

    private void m205b(SparseArray<C0058n> sparseArray, SparseArray<C0058n> sparseArray2) {
        if (this.f202b.f288p.mo39a()) {
            for (C0048a c0048a = this.f203c; c0048a != null; c0048a = c0048a.f187a) {
                switch (c0048a.f189c) {
                    case 1:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    case 2:
                        C0058n c0058n;
                        C0058n c0058n2 = c0048a.f190d;
                        if (this.f202b.f279g != null) {
                            c0058n = c0058n2;
                            for (int i = 0; i < this.f202b.f279g.size(); i++) {
                                C0058n c0058n3 = (C0058n) this.f202b.f279g.get(i);
                                if (c0058n == null || c0058n3.mContainerId == c0058n.mContainerId) {
                                    if (c0058n3 == c0058n) {
                                        c0058n = null;
                                    } else {
                                        C0050e.m195a((SparseArray) sparseArray, c0058n3);
                                    }
                                }
                            }
                        } else {
                            c0058n = c0058n2;
                        }
                        C0050e.m206b((SparseArray) sparseArray2, c0058n);
                        break;
                    case 3:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 4:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 5:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    case 6:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 7:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    default:
                        break;
                }
            }
        }
    }

    private static void m206b(SparseArray<C0058n> sparseArray, C0058n c0058n) {
        if (c0058n != null) {
            int i = c0058n.mContainerId;
            if (i != 0) {
                sparseArray.put(i, c0058n);
            }
        }
    }

    private static void m207b(C0049b c0049b, av<String, View> avVar, boolean z) {
        int size = avVar.size();
        for (int i = 0; i < size; i++) {
            String str = (String) avVar.m83b(i);
            String transitionName = ((View) avVar.m84c(i)).getTransitionName();
            if (z) {
                C0050e.m196a(c0049b.f196a, str, transitionName);
            } else {
                C0050e.m196a(c0049b.f196a, transitionName, str);
            }
        }
    }

    public final int mo23a() {
        return m190a(false);
    }

    public final ag mo24a(int i, C0058n c0058n, String str) {
        m204b(i, c0058n, str);
        return this;
    }

    public final ag mo25a(C0058n c0058n) {
        C0048a c0048a = new C0048a();
        c0048a.f189c = 3;
        c0048a.f190d = c0058n;
        m215a(c0048a);
        return this;
    }

    public final ag mo26a(C0058n c0058n, String str) {
        m204b(0, c0058n, str);
        return this;
    }

    public final C0049b m212a(boolean z, C0049b c0049b, SparseArray<C0058n> sparseArray, SparseArray<C0058n> sparseArray2) {
        if (C0074w.f272a) {
            Log.v("FragmentManager", "popFromBackStack: " + this);
            m216a("  ", new PrintWriter(new az("FragmentManager")));
        }
        if (f201a) {
            if (c0049b == null) {
                if (!(sparseArray.size() == 0 && sparseArray2.size() == 0)) {
                    c0049b = m194a((SparseArray) sparseArray, (SparseArray) sparseArray2, true);
                }
            } else if (!z) {
                C0050e.m199a(c0049b, this.f222v, this.f221u);
            }
        }
        m213a(-1);
        int i = c0049b != null ? 0 : this.f211k;
        int i2 = c0049b != null ? 0 : this.f210j;
        C0048a c0048a = this.f204d;
        while (c0048a != null) {
            int i3 = c0049b != null ? 0 : c0048a.f193g;
            int i4 = c0049b != null ? 0 : c0048a.f194h;
            C0058n c0058n;
            C0058n c0058n2;
            switch (c0048a.f189c) {
                case 1:
                    c0058n = c0048a.f190d;
                    c0058n.mNextAnim = i4;
                    this.f202b.m328a(c0058n, C0074w.m312c(i2), i);
                    break;
                case 2:
                    c0058n = c0048a.f190d;
                    if (c0058n != null) {
                        c0058n.mNextAnim = i4;
                        this.f202b.m328a(c0058n, C0074w.m312c(i2), i);
                    }
                    if (c0048a.f195i == null) {
                        break;
                    }
                    for (int i5 = 0; i5 < c0048a.f195i.size(); i5++) {
                        c0058n2 = (C0058n) c0048a.f195i.get(i5);
                        c0058n2.mNextAnim = i3;
                        this.f202b.m330a(c0058n2, false);
                    }
                    break;
                case 3:
                    c0058n2 = c0048a.f190d;
                    c0058n2.mNextAnim = i3;
                    this.f202b.m330a(c0058n2, false);
                    break;
                case 4:
                    c0058n2 = c0048a.f190d;
                    c0058n2.mNextAnim = i3;
                    this.f202b.m345c(c0058n2, C0074w.m312c(i2), i);
                    break;
                case 5:
                    c0058n = c0048a.f190d;
                    c0058n.mNextAnim = i4;
                    this.f202b.m342b(c0058n, C0074w.m312c(i2), i);
                    break;
                case 6:
                    c0058n2 = c0048a.f190d;
                    c0058n2.mNextAnim = i3;
                    this.f202b.m350e(c0058n2, C0074w.m312c(i2), i);
                    break;
                case 7:
                    c0058n2 = c0048a.f190d;
                    c0058n2.mNextAnim = i3;
                    this.f202b.m348d(c0058n2, C0074w.m312c(i2), i);
                    break;
                default:
                    throw new IllegalArgumentException("Unknown cmd: " + c0048a.f189c);
            }
            c0048a = c0048a.f188b;
        }
        if (z) {
            this.f202b.m324a(this.f202b.f286n, C0074w.m312c(i2), i, true);
            c0049b = null;
        }
        if (this.f216p >= 0) {
            this.f202b.m339b(this.f216p);
            this.f216p = -1;
        }
        return c0049b;
    }

    final void m213a(int i) {
        if (this.f212l) {
            if (C0074w.f272a) {
                Log.v("FragmentManager", "Bump nesting in " + this + " by " + i);
            }
            for (C0048a c0048a = this.f203c; c0048a != null; c0048a = c0048a.f187a) {
                C0058n c0058n;
                if (c0048a.f190d != null) {
                    c0058n = c0048a.f190d;
                    c0058n.mBackStackNesting += i;
                    if (C0074w.f272a) {
                        Log.v("FragmentManager", "Bump nesting of " + c0048a.f190d + " to " + c0048a.f190d.mBackStackNesting);
                    }
                }
                if (c0048a.f195i != null) {
                    for (int size = c0048a.f195i.size() - 1; size >= 0; size--) {
                        c0058n = (C0058n) c0048a.f195i.get(size);
                        c0058n.mBackStackNesting += i;
                        if (C0074w.f272a) {
                            Log.v("FragmentManager", "Bump nesting of " + c0058n + " to " + c0058n.mBackStackNesting);
                        }
                    }
                }
            }
        }
    }

    public final void m214a(SparseArray<C0058n> sparseArray, SparseArray<C0058n> sparseArray2) {
        if (this.f202b.f288p.mo39a()) {
            for (C0048a c0048a = this.f203c; c0048a != null; c0048a = c0048a.f187a) {
                switch (c0048a.f189c) {
                    case 1:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 2:
                        if (c0048a.f195i != null) {
                            for (int size = c0048a.f195i.size() - 1; size >= 0; size--) {
                                C0050e.m206b((SparseArray) sparseArray2, (C0058n) c0048a.f195i.get(size));
                            }
                        }
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 3:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    case 4:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    case 5:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    case 6:
                        C0050e.m206b((SparseArray) sparseArray2, c0048a.f190d);
                        break;
                    case 7:
                        C0050e.m195a((SparseArray) sparseArray, c0048a.f190d);
                        break;
                    default:
                        break;
                }
            }
        }
    }

    final void m215a(C0048a c0048a) {
        if (this.f203c == null) {
            this.f204d = c0048a;
            this.f203c = c0048a;
        } else {
            c0048a.f188b = this.f204d;
            this.f204d.f187a = c0048a;
            this.f204d = c0048a;
        }
        c0048a.f191e = this.f206f;
        c0048a.f192f = this.f207g;
        c0048a.f193g = this.f208h;
        c0048a.f194h = this.f209i;
        this.f205e++;
    }

    public final void m216a(String str, PrintWriter printWriter) {
        m217a(str, printWriter, true);
    }

    public final void m217a(String str, PrintWriter printWriter, boolean z) {
        if (z) {
            printWriter.print(str);
            printWriter.print("mName=");
            printWriter.print(this.f214n);
            printWriter.print(" mIndex=");
            printWriter.print(this.f216p);
            printWriter.print(" mCommitted=");
            printWriter.println(this.f215o);
            if (this.f210j != 0) {
                printWriter.print(str);
                printWriter.print("mTransition=#");
                printWriter.print(Integer.toHexString(this.f210j));
                printWriter.print(" mTransitionStyle=#");
                printWriter.println(Integer.toHexString(this.f211k));
            }
            if (!(this.f206f == 0 && this.f207g == 0)) {
                printWriter.print(str);
                printWriter.print("mEnterAnim=#");
                printWriter.print(Integer.toHexString(this.f206f));
                printWriter.print(" mExitAnim=#");
                printWriter.println(Integer.toHexString(this.f207g));
            }
            if (!(this.f208h == 0 && this.f209i == 0)) {
                printWriter.print(str);
                printWriter.print("mPopEnterAnim=#");
                printWriter.print(Integer.toHexString(this.f208h));
                printWriter.print(" mPopExitAnim=#");
                printWriter.println(Integer.toHexString(this.f209i));
            }
            if (!(this.f217q == 0 && this.f218r == null)) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbTitleRes=#");
                printWriter.print(Integer.toHexString(this.f217q));
                printWriter.print(" mBreadCrumbTitleText=");
                printWriter.println(this.f218r);
            }
            if (!(this.f219s == 0 && this.f220t == null)) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbShortTitleRes=#");
                printWriter.print(Integer.toHexString(this.f219s));
                printWriter.print(" mBreadCrumbShortTitleText=");
                printWriter.println(this.f220t);
            }
        }
        if (this.f203c != null) {
            printWriter.print(str);
            printWriter.println("Operations:");
            String str2 = str + "    ";
            int i = 0;
            C0048a c0048a = this.f203c;
            while (c0048a != null) {
                String str3;
                switch (c0048a.f189c) {
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
                        str3 = "cmd=" + c0048a.f189c;
                        break;
                }
                printWriter.print(str);
                printWriter.print("  Op #");
                printWriter.print(i);
                printWriter.print(": ");
                printWriter.print(str3);
                printWriter.print(" ");
                printWriter.println(c0048a.f190d);
                if (z) {
                    if (!(c0048a.f191e == 0 && c0048a.f192f == 0)) {
                        printWriter.print(str);
                        printWriter.print("enterAnim=#");
                        printWriter.print(Integer.toHexString(c0048a.f191e));
                        printWriter.print(" exitAnim=#");
                        printWriter.println(Integer.toHexString(c0048a.f192f));
                    }
                    if (!(c0048a.f193g == 0 && c0048a.f194h == 0)) {
                        printWriter.print(str);
                        printWriter.print("popEnterAnim=#");
                        printWriter.print(Integer.toHexString(c0048a.f193g));
                        printWriter.print(" popExitAnim=#");
                        printWriter.println(Integer.toHexString(c0048a.f194h));
                    }
                }
                if (c0048a.f195i != null && c0048a.f195i.size() > 0) {
                    for (int i2 = 0; i2 < c0048a.f195i.size(); i2++) {
                        printWriter.print(str2);
                        if (c0048a.f195i.size() == 1) {
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
                        printWriter.println(c0048a.f195i.get(i2));
                    }
                }
                c0048a = c0048a.f187a;
                i++;
            }
        }
    }

    public final int mo27b() {
        return m190a(true);
    }

    public final void run() {
        if (C0074w.f272a) {
            Log.v("FragmentManager", "Run: " + this);
        }
        if (!this.f212l || this.f216p >= 0) {
            C0049b a;
            m213a(1);
            if (f201a) {
                SparseArray sparseArray = new SparseArray();
                SparseArray sparseArray2 = new SparseArray();
                m205b(sparseArray, sparseArray2);
                a = m194a(sparseArray, sparseArray2, false);
            } else {
                a = null;
            }
            int i = a != null ? 0 : this.f211k;
            int i2 = a != null ? 0 : this.f210j;
            C0048a c0048a = this.f203c;
            while (c0048a != null) {
                int i3 = a != null ? 0 : c0048a.f191e;
                int i4 = a != null ? 0 : c0048a.f192f;
                C0058n c0058n;
                switch (c0048a.f189c) {
                    case 1:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i3;
                        this.f202b.m330a(c0058n, false);
                        break;
                    case 2:
                        C0058n c0058n2;
                        C0058n c0058n3 = c0048a.f190d;
                        int i5 = c0058n3.mContainerId;
                        if (this.f202b.f279g != null) {
                            c0058n2 = c0058n3;
                            for (int i6 = 0; i6 < this.f202b.f279g.size(); i6++) {
                                c0058n = (C0058n) this.f202b.f279g.get(i6);
                                if (C0074w.f272a) {
                                    Log.v("FragmentManager", "OP_REPLACE: adding=" + c0058n2 + " old=" + c0058n);
                                }
                                if (c0058n.mContainerId == i5) {
                                    if (c0058n == c0058n2) {
                                        c0058n2 = null;
                                        c0048a.f190d = null;
                                    } else {
                                        if (c0048a.f195i == null) {
                                            c0048a.f195i = new ArrayList();
                                        }
                                        c0048a.f195i.add(c0058n);
                                        c0058n.mNextAnim = i4;
                                        if (this.f212l) {
                                            c0058n.mBackStackNesting++;
                                            if (C0074w.f272a) {
                                                Log.v("FragmentManager", "Bump nesting of " + c0058n + " to " + c0058n.mBackStackNesting);
                                            }
                                        }
                                        this.f202b.m328a(c0058n, i2, i);
                                    }
                                }
                            }
                        } else {
                            c0058n2 = c0058n3;
                        }
                        if (c0058n2 == null) {
                            break;
                        }
                        c0058n2.mNextAnim = i3;
                        this.f202b.m330a(c0058n2, false);
                        break;
                    case 3:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i4;
                        this.f202b.m328a(c0058n, i2, i);
                        break;
                    case 4:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i4;
                        this.f202b.m342b(c0058n, i2, i);
                        break;
                    case 5:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i3;
                        this.f202b.m345c(c0058n, i2, i);
                        break;
                    case 6:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i4;
                        this.f202b.m348d(c0058n, i2, i);
                        break;
                    case 7:
                        c0058n = c0048a.f190d;
                        c0058n.mNextAnim = i3;
                        this.f202b.m350e(c0058n, i2, i);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown cmd: " + c0048a.f189c);
                }
                c0048a = c0048a.f187a;
            }
            this.f202b.m324a(this.f202b.f286n, i2, i, true);
            if (this.f212l) {
                this.f202b.m341b(this);
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
        if (this.f216p >= 0) {
            stringBuilder.append(" #");
            stringBuilder.append(this.f216p);
        }
        if (this.f214n != null) {
            stringBuilder.append(" ");
            stringBuilder.append(this.f214n);
        }
        stringBuilder.append("}");
        return stringBuilder.toString();
    }
}
