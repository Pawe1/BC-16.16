package p000c.p001m.p002x.p003a.gv;

import android.os.Handler;
import android.os.Message;

final class C0084v extends Handler {
    final /* synthetic */ C0083u f314a;

    C0084v(C0083u c0083u) {
        this.f314a = c0083u;
    }

    public final void handleMessage(Message message) {
        switch (message.what) {
            case 1:
                if (this.f314a.mStopped) {
                    this.f314a.doReallyStop(false);
                    return;
                }
                return;
            case 2:
                this.f314a.onResumeFragments();
                this.f314a.mFragments.m371q();
                return;
            default:
                super.handleMessage(message);
                return;
        }
    }
}
