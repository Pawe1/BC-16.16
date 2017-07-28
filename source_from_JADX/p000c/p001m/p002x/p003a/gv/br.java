package p000c.p001m.p002x.p003a.gv;

import java.util.concurrent.CancellationException;
import p000c.p001m.p002x.p003a.gv.bo.C0043a;

final class br implements Runnable {
    final /* synthetic */ bm f165a;
    final /* synthetic */ C0043a f166b;
    final /* synthetic */ bn f167c;
    final /* synthetic */ bo f168d;

    br(bm bmVar, C0043a c0043a, bn bnVar, bo boVar) {
        this.f165a = bmVar;
        this.f166b = c0043a;
        this.f167c = bnVar;
        this.f168d = boVar;
    }

    public final void run() {
        if (this.f165a == null || !this.f165a.m150a()) {
            try {
                this.f166b.m156a(this.f167c.then(this.f168d));
                return;
            } catch (CancellationException e) {
                this.f166b.m157b();
                return;
            } catch (Exception e2) {
                this.f166b.m155a(e2);
                return;
            }
        }
        this.f166b.m157b();
    }
}
