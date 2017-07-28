package com.adobe.air;

import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.adobe.air.AndroidLocale.STRING_ID;

public final class RemoteDebuggerDialog {
    private final Activity mActivity;

    class C01272 implements OnClickListener {
        C01272() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            RemoteDebuggerDialog.this.gotResultFromDialog(false, null);
        }
    }

    class C01283 implements OnCancelListener {
        C01283() {
        }

        public void onCancel(DialogInterface dialogInterface) {
            RemoteDebuggerDialog.this.gotResultFromDialog(false, null);
        }
    }

    RemoteDebuggerDialog(Activity activity) {
        this.mActivity = activity;
    }

    public void createAndShowDialog(String str) {
        View linearLayout = new LinearLayout(this.mActivity);
        linearLayout.setLayoutParams(new LayoutParams(-1, -1));
        linearLayout.setOrientation(1);
        View textView = new TextView(this.mActivity);
        String str2 = "";
        if (str.length() > 0) {
            str2 = AndroidLocale.GetLocalizedString(STRING_ID.IDA_DEBUGGER_ERROR_MESSAGE).replaceFirst("%1", str) + "\n";
        }
        textView.setText(str2 + AndroidLocale.GetLocalizedString(STRING_ID.IDA_DEBUGGER_ENTERIP_MESSAGE));
        textView.setLayoutParams(new LayoutParams(-1, -1));
        textView.setPadding(20, 20, 20, 20);
        final View editText = new EditText(this.mActivity);
        editText.setLayoutParams(new LayoutParams(-1, -1));
        editText.setHeight(30);
        editText.setWidth(25);
        linearLayout.addView(textView);
        linearLayout.addView(editText);
        Builder builder = new Builder(this.mActivity);
        builder.setView(linearLayout);
        builder.setTitle(AndroidConstants.ADOBE_AIR);
        builder.setPositiveButton(AndroidLocale.GetLocalizedString(STRING_ID.IDA_OK), new OnClickListener() {
            public void onClick(DialogInterface dialogInterface, int i) {
                RemoteDebuggerDialog.this.gotResultFromDialog(true, editText.getText().toString());
            }
        });
        builder.setNegativeButton(AndroidLocale.GetLocalizedString(STRING_ID.IDA_CANCEL), new C01272());
        builder.setOnCancelListener(new C01283());
        builder.show();
    }

    public void gotResultFromDialog(boolean z, String str) {
        AndroidActivityWrapper.GetAndroidActivityWrapper().gotResultFromDialog(z, str);
    }
}
