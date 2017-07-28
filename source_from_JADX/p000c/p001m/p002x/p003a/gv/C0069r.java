package p000c.p001m.p002x.p003a.gv;

import android.os.Handler;
import android.os.Message;

final class C0069r extends Handler {
    final /* synthetic */ C0068q f264a;

    C0069r(C0068q c0068q) {
        this.f264a = c0068q;
    }

    public final void handleMessage(Message message) {
        switch (message.what) {
            case 1:
                if (this.f264a.mStopped) {
                    this.f264a.doReallyStop(false);
                    return;
                }
                return;
            case 2:
                this.f264a.onResumeFragments();
                this.f264a.mFragments.m292q();
                return;
            default:
                super.handleMessage(message);
                return;
        }
    }
}
