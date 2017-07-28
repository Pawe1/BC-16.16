package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.content.res.Configuration;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public final class C0085x {
    private final C0080y<?> f315a;

    private C0085x(C0080y<?> c0080y) {
        this.f315a = c0080y;
    }

    public static final C0085x m341a(C0080y<?> c0080y) {
        return new C0085x(c0080y);
    }

    public final View m342a(View view, String str, Context context, AttributeSet attributeSet) {
        return this.f315a.f303d.mo23a(view, str, context, attributeSet);
    }

    final C0073r m343a(String str) {
        return this.f315a.f303d.m43b(str);
    }

    public final C0013z m344a() {
        return this.f315a.f303d;
    }

    public final List<C0073r> m345a(List<C0073r> list) {
        if (this.f315a.f303d.f20f == null) {
            return null;
        }
        if (list == null) {
            list = new ArrayList(m357c());
        }
        list.addAll(this.f315a.f303d.f20f);
        return list;
    }

    public final void m346a(Configuration configuration) {
        this.f315a.f303d.m30a(configuration);
    }

    public final void m347a(Parcelable parcelable, List<C0073r> list) {
        this.f315a.f303d.m31a(parcelable, (List) list);
    }

    public final void m348a(bg<String, aq> bgVar) {
        this.f315a.m304a((bg) bgVar);
    }

    public final void m349a(String str, FileDescriptor fileDescriptor, PrintWriter printWriter) {
        this.f315a.m308a(str, printWriter);
    }

    public final void m350a(boolean z) {
        this.f315a.m310a(z);
    }

    public final boolean m351a(Menu menu) {
        return this.f315a.f303d.m40a(menu);
    }

    public final boolean m352a(Menu menu, MenuInflater menuInflater) {
        return this.f315a.f303d.m41a(menu, menuInflater);
    }

    public final boolean m353a(MenuItem menuItem) {
        return this.f315a.f303d.m42a(menuItem);
    }

    public final aq m354b() {
        return this.f315a.m322j();
    }

    public final void m355b(Menu menu) {
        this.f315a.f303d.m45b(menu);
    }

    public final boolean m356b(MenuItem menuItem) {
        return this.f315a.f303d.m50b(menuItem);
    }

    public final int m357c() {
        List list = this.f315a.f303d.f20f;
        return list == null ? 0 : list.size();
    }

    public final void m358d() {
        this.f315a.f303d.m36a(this.f315a, this.f315a, null);
    }

    public final void m359e() {
        this.f315a.f303d.m57f();
    }

    public final Parcelable m360f() {
        return this.f315a.f303d.m55e();
    }

    public final List<C0073r> m361g() {
        return this.f315a.f303d.m53d();
    }

    public final void m362h() {
        this.f315a.f303d.m58g();
    }

    public final void m363i() {
        this.f315a.f303d.m59h();
    }

    public final void m364j() {
        this.f315a.f303d.m60i();
    }

    public final void m365k() {
        this.f315a.f303d.m61j();
    }

    public final void m366l() {
        this.f315a.f303d.m62k();
    }

    public final void m367m() {
        this.f315a.f303d.m63l();
    }

    public final void m368n() {
        this.f315a.f303d.m64m();
    }

    public final void m369o() {
        this.f315a.f303d.m66o();
    }

    public final void m370p() {
        this.f315a.f303d.m67p();
    }

    public final boolean m371q() {
        return this.f315a.f303d.m52c();
    }

    public final void m372r() {
        this.f315a.m324l();
    }

    public final void m373s() {
        this.f315a.m325m();
    }

    public final void m374t() {
        this.f315a.m326n();
    }

    public final bg<String, aq> m375u() {
        return this.f315a.m327o();
    }
}
