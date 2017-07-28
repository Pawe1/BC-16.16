package de.pagecon.bleane.extension;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import de.pagecon.bleane.nativ.NativeManager;

public class HelperActivity extends Activity {
    public static final int REQUEST_ENABLE_BLE = 1;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        startActivityForResult(new Intent("android.bluetooth.adapter.action.REQUEST_ENABLE"), 1);
        NativeManager.instance.notifyInfo("called startActivityForResult");
    }

    protected void onStart() {
        super.onStart();
        setVisible(true);
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        NativeManager.instance.notifyInfo("onActivityResult called");
        finish();
    }
}
