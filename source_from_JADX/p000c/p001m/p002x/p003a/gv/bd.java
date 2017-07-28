package p000c.p001m.p002x.p003a.gv;

public final class bd {
    public static void m168a(Object obj, StringBuilder stringBuilder) {
        if (obj == null) {
            stringBuilder.append("null");
            return;
        }
        String simpleName = obj.getClass().getSimpleName();
        if (simpleName == null || simpleName.length() <= 0) {
            simpleName = obj.getClass().getName();
            int lastIndexOf = simpleName.lastIndexOf(46);
            if (lastIndexOf > 0) {
                simpleName = simpleName.substring(lastIndexOf + 1);
            }
        }
        stringBuilder.append(simpleName);
        stringBuilder.append('{');
        stringBuilder.append(Integer.toHexString(System.identityHashCode(obj)));
    }
}
