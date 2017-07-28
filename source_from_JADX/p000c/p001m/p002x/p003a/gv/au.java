package p000c.p001m.p002x.p003a.gv;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

final class au extends Handler {
    final /* synthetic */ at f83a;

    au(at atVar, Looper looper) {
        this.f83a = atVar;
        super(looper);
    }

    public final void handleMessage(Message message) {
        switch (message.what) {
            case 1:
                at.m71a(this.f83a);
                return;
            default:
                super.handleMessage(message);
                return;
        }
    }
}
