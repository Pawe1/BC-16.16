package com.adobe.air;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.DialogInterface.OnKeyListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.view.KeyEvent;
import java.net.InetAddress;
import java.net.Socket;

public class RemoteDebuggerListenerDialog extends Activity {
    private final String LOG_TAG = getClass().getName();
    private int count = 0;
    private int debuggerPort = -1;
    private Activity mActivity = null;
    private Runnable mCheckAgain = null;
    private Handler mHandler = new Handler();
    private BroadcastReceiver mReceiver;
    private AlertDialog mWaitDialog = null;

    class C01381 extends BroadcastReceiver {
        C01381() {
        }

        public void onReceive(Context context, Intent intent) {
            if (!isInitialStickyBroadcast()) {
                Bundle extras = RemoteDebuggerListenerDialog.this.getIntent().getExtras();
                if ((extras != null ? extras.getInt("debuggerPort") : 7936) == RemoteDebuggerListenerDialog.this.debuggerPort) {
                    RemoteDebuggerListenerDialog.this.dismissDialog();
                }
            }
        }
    }

    class C01392 implements OnClickListener {
        C01392() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            RemoteDebuggerListenerDialog.this.mHandler.removeCallbacks(RemoteDebuggerListenerDialog.this.mCheckAgain);
            RemoteDebuggerListenerDialog.this.closeListeningDebuggerSocket();
            RemoteDebuggerListenerDialog.this.unregisterReceiver(RemoteDebuggerListenerDialog.this.mReceiver);
            RemoteDebuggerListenerDialog.this.mReceiver = null;
            dialogInterface.cancel();
            RemoteDebuggerListenerDialog.this.finish();
        }
    }

    class C01403 implements OnKeyListener {
        C01403() {
        }

        public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
            if (i == 4) {
                RemoteDebuggerListenerDialog.this.mHandler.removeCallbacks(RemoteDebuggerListenerDialog.this.mCheckAgain);
                RemoteDebuggerListenerDialog.this.closeListeningDebuggerSocket();
                RemoteDebuggerListenerDialog.this.unregisterReceiver(RemoteDebuggerListenerDialog.this.mReceiver);
                RemoteDebuggerListenerDialog.this.mReceiver = null;
                dialogInterface.cancel();
                RemoteDebuggerListenerDialog.this.finish();
            }
            return false;
        }
    }

    class C01445 extends AsyncTask<Integer, Integer, Integer> {
        C01445() {
        }

        protected Integer doInBackground(Integer... numArr) {
            try {
                new Socket(InetAddress.getLocalHost(), numArr[0].intValue()).close();
            } catch (Exception e) {
            }
            return Integer.valueOf(0);
        }
    }

    private enum DialogState {
        StateRuntimeNotReady,
        StateRuntimeWaitingForDebugger,
        StateRuntimeTimedOut
    }

    public void onCreate(Bundle bundle) {
        final String string = getString(2131689577);
        final String string2 = getString(2131689578);
        this.mActivity = this;
        super.onCreate(bundle);
        Bundle extras = getIntent().getExtras();
        this.debuggerPort = extras != null ? extras.getInt("debuggerPort") : 7936;
        this.mWaitDialog = new Builder(this).create();
        CharSequence format = String.format(string, new Object[]{Integer.valueOf(60)});
        this.mReceiver = new C01381();
        IntentFilter intentFilter = new IntentFilter("android.intent.action.MAIN");
        intentFilter.addCategory("RemoteDebuggerListenerDialogClose");
        registerReceiver(this.mReceiver, intentFilter);
        this.mWaitDialog = createDialog(getString(2131689575), format, getString(2131689570), new C01392(), new C01403());
        this.count = 0;
        this.mCheckAgain = new Runnable() {

            class C01411 implements OnClickListener {
                C01411() {
                }

                public void onClick(DialogInterface dialogInterface, int i) {
                    RemoteDebuggerListenerDialog.this.closeListeningDebuggerSocket();
                    dialogInterface.cancel();
                    RemoteDebuggerListenerDialog.this.finish();
                }
            }

            public void run() {
                if (RemoteDebuggerListenerDialog.this.count < 60) {
                    CharSequence format = String.format(string, new Object[]{Integer.valueOf(60 - RemoteDebuggerListenerDialog.this.count)});
                    RemoteDebuggerListenerDialog.this.count = RemoteDebuggerListenerDialog.this.count + 1;
                    RemoteDebuggerListenerDialog.this.mWaitDialog.setMessage(format);
                    RemoteDebuggerListenerDialog.this.mHandler.postDelayed(this, 1000);
                    return;
                }
                RemoteDebuggerListenerDialog.this.mHandler.removeCallbacks(this);
                RemoteDebuggerListenerDialog.this.mWaitDialog.cancel();
                if (RemoteDebuggerListenerDialog.this.mReceiver != null) {
                    RemoteDebuggerListenerDialog.this.unregisterReceiver(RemoteDebuggerListenerDialog.this.mReceiver);
                    RemoteDebuggerListenerDialog.this.mReceiver = null;
                }
                final OnClickListener c01411 = new C01411();
                RemoteDebuggerListenerDialog.this.mWaitDialog = RemoteDebuggerListenerDialog.this.createDialog(AndroidConstants.ADOBE_AIR, string2, RemoteDebuggerListenerDialog.this.getString(2131689571), c01411, new OnKeyListener() {
                    public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
                        if (i == 4) {
                            c01411.onClick(dialogInterface, -1);
                        }
                        return false;
                    }
                });
                RemoteDebuggerListenerDialog.this.mWaitDialog.show();
            }
        };
        this.mHandler.postDelayed(this.mCheckAgain, 1000);
        this.mWaitDialog.show();
    }

    private AlertDialog createDialog(CharSequence charSequence, CharSequence charSequence2, CharSequence charSequence3, OnClickListener onClickListener, OnKeyListener onKeyListener) {
        AlertDialog create = new Builder(this.mActivity).create();
        create.setTitle(charSequence);
        create.setMessage(charSequence2);
        create.setButton(-1, charSequence3, onClickListener);
        create.setOnKeyListener(onKeyListener);
        create.setCancelable(true);
        return create;
    }

    private void closeListeningDebuggerSocket() {
        new C01445().execute(new Integer[]{Integer.valueOf(this.debuggerPort)});
    }

    private void dismissDialog() {
        if (this.mWaitDialog != null) {
            this.mWaitDialog.cancel();
        }
        if (this.mReceiver != null) {
            unregisterReceiver(this.mReceiver);
        }
        this.mReceiver = null;
        this.mHandler.removeCallbacks(this.mCheckAgain);
        this.mActivity.finish();
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i == 4) {
            closeListeningDebuggerSocket();
            dismissDialog();
        }
        return super.onKeyDown(i, keyEvent);
    }

    public void onStop() {
        closeListeningDebuggerSocket();
        dismissDialog();
        super.onStop();
    }
}
