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

public final class C0070t {
    private final C0065u<?> f265a;

    private C0070t(C0065u<?> c0065u) {
        this.f265a = c0065u;
    }

    public static final C0070t m263a(C0065u<?> c0065u) {
        return new C0070t(c0065u);
    }

    public final View m264a(View view, String str, Context context, AttributeSet attributeSet) {
        return this.f265a.f254d.mo57a(view, str, context, attributeSet);
    }

    public final C0071v m265a() {
        return this.f265a.f254d;
    }

    public final List<C0058n> m266a(List<C0058n> list) {
        if (this.f265a.f254d.f278f == null) {
            return null;
        }
        if (list == null) {
            list = new ArrayList(m278c());
        }
        list.addAll(this.f265a.f254d.f278f);
        return list;
    }

    public final void m267a(Configuration configuration) {
        this.f265a.f254d.m325a(configuration);
    }

    public final void m268a(Parcelable parcelable, List<C0058n> list) {
        this.f265a.f254d.m326a(parcelable, (List) list);
    }

    public final void m269a(bb<String, am> bbVar) {
        this.f265a.m227a((bb) bbVar);
    }

    public final void m270a(String str, FileDescriptor fileDescriptor, PrintWriter printWriter) {
        this.f265a.m231a(str, printWriter);
    }

    public final void m271a(boolean z) {
        this.f265a.m233a(z);
    }

    public final boolean m272a(Menu menu) {
        return this.f265a.f254d.m335a(menu);
    }

    public final boolean m273a(Menu menu, MenuInflater menuInflater) {
        return this.f265a.f254d.m336a(menu, menuInflater);
    }

    public final boolean m274a(MenuItem menuItem) {
        return this.f265a.f254d.m337a(menuItem);
    }

    public final am m275b() {
        return this.f265a.m245j();
    }

    public final void m276b(Menu menu) {
        this.f265a.f254d.m340b(menu);
    }

    public final boolean m277b(MenuItem menuItem) {
        return this.f265a.f254d.m344b(menuItem);
    }

    public final int m278c() {
        List list = this.f265a.f254d.f278f;
        return list == null ? 0 : list.size();
    }

    public final void m279d() {
        this.f265a.f254d.m331a(this.f265a, this.f265a, null);
    }

    public final void m280e() {
        this.f265a.f254d.m351f();
    }

    public final Parcelable m281f() {
        return this.f265a.f254d.m349e();
    }

    public final List<C0058n> m282g() {
        return this.f265a.f254d.m347d();
    }

    public final void m283h() {
        this.f265a.f254d.m352g();
    }

    public final void m284i() {
        this.f265a.f254d.m353h();
    }

    public final void m285j() {
        this.f265a.f254d.m354i();
    }

    public final void m286k() {
        this.f265a.f254d.m355j();
    }

    public final void m287l() {
        this.f265a.f254d.m356k();
    }

    public final void m288m() {
        this.f265a.f254d.m357l();
    }

    public final void m289n() {
        this.f265a.f254d.m358m();
    }

    public final void m290o() {
        this.f265a.f254d.m360o();
    }

    public final void m291p() {
        this.f265a.f254d.m361p();
    }

    public final boolean m292q() {
        return this.f265a.f254d.m346c();
    }

    public final void m293r() {
        this.f265a.m246k();
    }

    public final void m294s() {
        this.f265a.m247l();
    }

    public final void m295t() {
        this.f265a.m248m();
    }

    public final bb<String, am> m296u() {
        return this.f265a.m249n();
    }
}
