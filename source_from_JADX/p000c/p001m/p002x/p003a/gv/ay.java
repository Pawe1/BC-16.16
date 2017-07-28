package p000c.p001m.p002x.p003a.gv;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

final class ay extends Handler {
    final /* synthetic */ ax f128a;

    ay(ax axVar, Looper looper) {
        this.f128a = axVar;
        super(looper);
    }

    public final void handleMessage(Message message) {
        switch (message.what) {
            case 1:
                ax.m124a(this.f128a);
                return;
            default:
                super.handleMessage(message);
                return;
        }
    }
}
