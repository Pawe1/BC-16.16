package p000c.p001m.p002x.p003a.gv;

import android.net.Uri;
import java.util.Collections;
import java.util.List;

public final class bo {
    private Uri f180a;
    private List<C0049a> f181b;
    private Uri f182c;

    public static class C0049a {
        private final Uri f176a;
        private final String f177b;
        private final String f178c;
        private final String f179d;

        public C0049a(String str, String str2, Uri uri, String str3) {
            this.f177b = str;
            this.f178c = str2;
            this.f176a = uri;
            this.f179d = str3;
        }
    }

    public bo(Uri uri, List<C0049a> list, Uri uri2) {
        List emptyList;
        this.f180a = uri;
        if (list == null) {
            emptyList = Collections.emptyList();
        }
        this.f181b = emptyList;
        this.f182c = uri2;
    }
}
