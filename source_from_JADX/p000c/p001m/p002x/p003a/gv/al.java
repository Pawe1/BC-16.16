package p000c.p001m.p002x.p003a.gv;

import android.graphics.Rect;
import android.transition.Transition;
import android.transition.TransitionSet;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

final class al {

    public static class C0014a {
        public View f62a;
    }

    public interface C0015b {
        View mo57a();
    }

    public static Object m77a(Object obj) {
        return obj != null ? ((Transition) obj).clone() : obj;
    }

    public static Object m78a(Object obj, View view, ArrayList<View> arrayList, Map<String, View> map, View view2) {
        if (obj == null) {
            return obj;
        }
        al.m90b((ArrayList) arrayList, view);
        if (map != null) {
            arrayList.removeAll(map.values());
        }
        if (arrayList.isEmpty()) {
            return null;
        }
        arrayList.add(view2);
        al.m89b((Transition) obj, (ArrayList) arrayList);
        return obj;
    }

    public static void m79a(Object obj, View view) {
        ((Transition) obj).setEpicenterCallback(new am(al.m88b(view)));
    }

    public static void m80a(Object obj, View view, Map<String, View> map, ArrayList<View> arrayList) {
        obj = (TransitionSet) obj;
        arrayList.clear();
        arrayList.addAll(map.values());
        List targets = obj.getTargets();
        targets.clear();
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            View view2 = (View) arrayList.get(i);
            int size2 = targets.size();
            if (!al.m87a(targets, view2, size2)) {
                targets.add(view2);
                for (int i2 = size2; i2 < targets.size(); i2++) {
                    view2 = (View) targets.get(i2);
                    if (view2 instanceof ViewGroup) {
                        ViewGroup viewGroup = (ViewGroup) view2;
                        int childCount = viewGroup.getChildCount();
                        for (int i3 = 0; i3 < childCount; i3++) {
                            View childAt = viewGroup.getChildAt(i3);
                            if (!al.m87a(targets, childAt, size2)) {
                                targets.add(childAt);
                            }
                        }
                    }
                }
            }
        }
        arrayList.add(view);
        al.m89b(obj, (ArrayList) arrayList);
    }

    public static void m81a(Object obj, View view, boolean z) {
        ((Transition) obj).excludeTarget(view, z);
    }

    public static void m82a(Object obj, ArrayList<View> arrayList) {
        Transition transition = (Transition) obj;
        int transitionCount;
        if (transition instanceof TransitionSet) {
            TransitionSet transitionSet = (TransitionSet) transition;
            transitionCount = transitionSet.getTransitionCount();
            for (int i = 0; i < transitionCount; i++) {
                al.m82a(transitionSet.getTransitionAt(i), (ArrayList) arrayList);
            }
        } else if (!al.m85a(transition)) {
            List targets = transition.getTargets();
            if (targets != null && targets.size() == arrayList.size() && targets.containsAll(arrayList)) {
                for (transitionCount = arrayList.size() - 1; transitionCount >= 0; transitionCount--) {
                    transition.removeTarget((View) arrayList.get(transitionCount));
                }
            }
        }
    }

    public static void m84a(Map<String, View> map, View view) {
        if (view.getVisibility() == 0) {
            String transitionName = view.getTransitionName();
            if (transitionName != null) {
                map.put(transitionName, view);
            }
            if (view instanceof ViewGroup) {
                ViewGroup viewGroup = (ViewGroup) view;
                int childCount = viewGroup.getChildCount();
                for (int i = 0; i < childCount; i++) {
                    al.m84a((Map) map, viewGroup.getChildAt(i));
                }
            }
        }
    }

    private static boolean m85a(Transition transition) {
        return (al.m86a(transition.getTargetIds()) && al.m86a(transition.getTargetNames()) && al.m86a(transition.getTargetTypes())) ? false : true;
    }

    private static boolean m86a(List list) {
        return list == null || list.isEmpty();
    }

    private static boolean m87a(List<View> list, View view, int i) {
        for (int i2 = 0; i2 < i; i2++) {
            if (list.get(i2) == view) {
                return true;
            }
        }
        return false;
    }

    private static Rect m88b(View view) {
        Rect rect = new Rect();
        int[] iArr = new int[2];
        view.getLocationOnScreen(iArr);
        rect.set(iArr[0], iArr[1], iArr[0] + view.getWidth(), iArr[1] + view.getHeight());
        return rect;
    }

    public static void m89b(Object obj, ArrayList<View> arrayList) {
        int i = 0;
        Transition transition = (Transition) obj;
        int transitionCount;
        if (transition instanceof TransitionSet) {
            TransitionSet transitionSet = (TransitionSet) transition;
            transitionCount = transitionSet.getTransitionCount();
            while (i < transitionCount) {
                al.m89b(transitionSet.getTransitionAt(i), (ArrayList) arrayList);
                i++;
            }
        } else if (!al.m85a(transition) && al.m86a(transition.getTargets())) {
            int size = arrayList.size();
            for (transitionCount = 0; transitionCount < size; transitionCount++) {
                transition.addTarget((View) arrayList.get(transitionCount));
            }
        }
    }

    private static void m90b(ArrayList<View> arrayList, View view) {
        if (view.getVisibility() != 0) {
            return;
        }
        if (view instanceof ViewGroup) {
            ViewGroup viewGroup = (ViewGroup) view;
            if (viewGroup.isTransitionGroup()) {
                arrayList.add(viewGroup);
                return;
            }
            int childCount = viewGroup.getChildCount();
            for (int i = 0; i < childCount; i++) {
                al.m90b((ArrayList) arrayList, viewGroup.getChildAt(i));
            }
            return;
        }
        arrayList.add(view);
    }
}
