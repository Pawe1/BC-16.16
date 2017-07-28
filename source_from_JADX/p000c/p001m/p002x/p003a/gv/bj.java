package p000c.p001m.p002x.p003a.gv;

import android.net.Uri;
import java.util.Collections;
import java.util.List;

public final class bj {
    private Uri f137a;
    private List<C0041a> f138b;
    private Uri f139c;

    public static class C0041a {
        private final Uri f133a;
        private final String f134b;
        private final String f135c;
        private final String f136d;

        public C0041a(String str, String str2, Uri uri, String str3) {
            this.f134b = str;
            this.f135c = str2;
            this.f133a = uri;
            this.f136d = str3;
        }
    }

    public bj(Uri uri, List<C0041a> list, Uri uri2) {
        List emptyList;
        this.f137a = uri;
        if (list == null) {
            emptyList = Collections.emptyList();
        }
        this.f138b = emptyList;
        this.f139c = uri2;
    }
}
