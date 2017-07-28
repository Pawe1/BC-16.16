package com.facebook;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import p000c.p001m.p002x.p003a.gv.ax;

public class CustomTabActivity extends Activity {
    public static final String CUSTOM_TAB_REDIRECT_ACTION = (CustomTabActivity.class.getSimpleName() + ".action_customTabRedirect");
    private static final int CUSTOM_TAB_REDIRECT_REQUEST_CODE = 2;
    public static final String DESTROY_ACTION = (CustomTabActivity.class.getSimpleName() + ".action_destroy");
    private BroadcastReceiver closeReceiver;

    class C01761 extends BroadcastReceiver {
        C01761() {
        }

        public void onReceive(Context context, Intent intent) {
            CustomTabActivity.this.finish();
        }
    }

    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i2 == 0) {
            Intent intent2 = new Intent(CUSTOM_TAB_REDIRECT_ACTION);
            intent2.putExtra(CustomTabMainActivity.EXTRA_URL, getIntent().getDataString());
            ax.m123a((Context) this).m127a(intent2);
            this.closeReceiver = new C01761();
            ax.m123a((Context) this).m126a(this.closeReceiver, new IntentFilter(DESTROY_ACTION));
        }
    }

    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Intent intent = new Intent(this, CustomTabMainActivity.class);
        intent.setAction(CUSTOM_TAB_REDIRECT_ACTION);
        intent.putExtra(CustomTabMainActivity.EXTRA_URL, getIntent().getDataString());
        intent.addFlags(603979776);
        startActivityForResult(intent, 2);
    }

    protected void onDestroy() {
        ax.m123a((Context) this).m125a(this.closeReceiver);
        super.onDestroy();
    }
}
