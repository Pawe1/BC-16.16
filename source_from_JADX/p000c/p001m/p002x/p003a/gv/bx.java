package p000c.p001m.p002x.p003a.gv;

import java.util.concurrent.CancellationException;
import p000c.p001m.p002x.p003a.gv.bt.C0051a;

final class bx implements Runnable {
    final /* synthetic */ br f212a;
    final /* synthetic */ C0051a f213b;
    final /* synthetic */ bs f214c;
    final /* synthetic */ bt f215d;

    bx(br brVar, C0051a c0051a, bs bsVar, bt btVar) {
        this.f212a = brVar;
        this.f213b = c0051a;
        this.f214c = bsVar;
        this.f215d = btVar;
    }

    public final void run() {
        if (this.f212a == null || !this.f212a.m208a()) {
            try {
                bt btVar = (bt) this.f214c.then(this.f215d);
                if (btVar == null) {
                    this.f213b.m214a(null);
                    return;
                } else {
                    btVar.m234a(new by(this));
                    return;
                }
            } catch (CancellationException e) {
                this.f213b.m215b();
                return;
            } catch (Exception e2) {
                this.f213b.m213a(e2);
                return;
            }
        }
        this.f213b.m215b();
    }
}
