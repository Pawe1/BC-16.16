package p000c.p001m.p002x.p003a.gv;

import java.util.concurrent.CancellationException;
import p000c.p001m.p002x.p003a.gv.bo.C0043a;

final class bs implements Runnable {
    final /* synthetic */ bm f169a;
    final /* synthetic */ C0043a f170b;
    final /* synthetic */ bn f171c;
    final /* synthetic */ bo f172d;

    bs(bm bmVar, C0043a c0043a, bn bnVar, bo boVar) {
        this.f169a = bmVar;
        this.f170b = c0043a;
        this.f171c = bnVar;
        this.f172d = boVar;
    }

    public final void run() {
        if (this.f169a == null || !this.f169a.m150a()) {
            try {
                bo boVar = (bo) this.f171c.then(this.f172d);
                if (boVar == null) {
                    this.f170b.m156a(null);
                    return;
                } else {
                    boVar.m176a(new bt(this));
                    return;
                }
            } catch (CancellationException e) {
                this.f170b.m157b();
                return;
            } catch (Exception e2) {
                this.f170b.m155a(e2);
                return;
            }
        }
        this.f170b.m157b();
    }
}
