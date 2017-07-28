package p000c.p001m.p002x.p003a.gv;

import java.util.concurrent.CancellationException;
import p000c.p001m.p002x.p003a.gv.bt.C0051a;

final class bw implements Runnable {
    final /* synthetic */ br f208a;
    final /* synthetic */ C0051a f209b;
    final /* synthetic */ bs f210c;
    final /* synthetic */ bt f211d;

    bw(br brVar, C0051a c0051a, bs bsVar, bt btVar) {
        this.f208a = brVar;
        this.f209b = c0051a;
        this.f210c = bsVar;
        this.f211d = btVar;
    }

    public final void run() {
        if (this.f208a == null || !this.f208a.m208a()) {
            try {
                this.f209b.m214a(this.f210c.then(this.f211d));
                return;
            } catch (CancellationException e) {
                this.f209b.m215b();
                return;
            } catch (Exception e2) {
                this.f209b.m213a(e2);
                return;
            }
        }
        this.f209b.m215b();
    }
}
