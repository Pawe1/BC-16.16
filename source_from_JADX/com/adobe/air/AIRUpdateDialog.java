package com.adobe.air;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.DialogInterface.OnKeyListener;
import android.os.Bundle;
import android.view.KeyEvent;
import com.adobe.air.AndroidLocale.STRING_ID;

public class AIRUpdateDialog extends Activity {
    private static String AIR_PING_URL = "https://airdownload2.adobe.com/air?";
    private static AIRUpdateDialog sThis = null;
    private final String LOG_TAG = "AIRUpdateDialog";
    private final String RUNTIME_PACKAGE_ID = "com.adobe.air";
    private AndroidActivityWrapper actWrapper;
    private AlertDialog alertDialog = null;

    class C00931 implements OnClickListener {
        C00931() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            AIRUpdateDialog.this.actWrapper.LaunchMarketPlaceForAIR(AIRUpdateDialog.this.getIntent().getStringExtra("airDownloadURL"));
            InstallOfferPingUtils.PingAndExit(AIRUpdateDialog.sThis, AIRUpdateDialog.AIR_PING_URL, true, true, false);
        }
    }

    class C00942 implements OnKeyListener {
        C00942() {
        }

        public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
            if (i != 4 && i != 84) {
                return false;
            }
            dialogInterface.cancel();
            InstallOfferPingUtils.PingAndExit(AIRUpdateDialog.sThis, AIRUpdateDialog.AIR_PING_URL, false, true, false);
            return true;
        }
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        sThis = this;
        this.actWrapper = AndroidActivityWrapper.CreateAndroidActivityWrapper(this, Boolean.valueOf(false));
        this.alertDialog = new Builder(this).setTitle(AndroidConstants.ADOBE_AIR).setMessage(AndroidLocale.GetLocalizedString(STRING_ID.IDA_RUNTIME_UPDATE_MESSAGE)).create();
        this.alertDialog.setButton(-1, AndroidLocale.GetLocalizedString(STRING_ID.IDA_UPDATE), new C00931());
        this.alertDialog.setOnKeyListener(new C00942());
        this.alertDialog.setCancelable(true);
        this.alertDialog.show();
    }

    public void onPause() {
        if (this.alertDialog != null) {
            this.alertDialog.cancel();
            this.alertDialog = null;
            finish();
        }
        super.onPause();
    }

    public void onStop() {
        if (this.alertDialog != null) {
            this.alertDialog.cancel();
            this.alertDialog = null;
            finish();
        }
        super.onStop();
    }
}
