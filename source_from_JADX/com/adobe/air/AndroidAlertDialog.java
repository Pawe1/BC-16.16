package com.adobe.air;

import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;

public class AndroidAlertDialog {
    private AlertDialog mAlertDialog = null;
    private Builder mDialogBuilder = null;

    public AndroidAlertDialog(Context context) {
        this.mDialogBuilder = new Builder(context);
    }

    public Builder GetAlertDialogBuilder() {
        return this.mDialogBuilder;
    }

    public void show() {
        this.mAlertDialog = this.mDialogBuilder.create();
        this.mAlertDialog.setCanceledOnTouchOutside(false);
        this.mAlertDialog.show();
    }

    public void dismiss() {
        if (this.mAlertDialog != null) {
            this.mAlertDialog.dismiss();
        }
    }
}
