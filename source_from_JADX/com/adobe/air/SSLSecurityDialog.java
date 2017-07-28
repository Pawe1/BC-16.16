package com.adobe.air;

import android.content.DialogInterface;
import android.content.DialogInterface.OnKeyListener;
import android.net.http.SslCertificate;
import android.view.KeyEvent;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class SSLSecurityDialog {
    public static final String TAG = SSLSecurityDialog.class.toString();
    private static final String USER_ACTION_TRUST_ALWAYS = "always";
    private static final String USER_ACTION_TRUST_NONE = "none";
    private static final String USER_ACTION_TRUST_SESSION = "session";
    private Condition m_condition = this.m_lock.newCondition();
    private Lock m_lock = new ReentrantLock();
    private String m_useraction = null;

    class C01484 implements OnKeyListener {
        C01484() {
        }

        public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
            if (keyEvent.getKeyCode() == 4) {
                SSLSecurityDialog.this.SetUserAction(SSLSecurityDialog.USER_ACTION_TRUST_NONE);
            }
            return false;
        }
    }

    public String show(String str, byte[] bArr) {
        ShowSSLDialog(str, bArr, null, false);
        if (this.m_useraction != null) {
        }
        return this.m_useraction;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void ShowSSLDialog(java.lang.String r11, byte[] r12, android.net.http.SslCertificate r13, boolean r14) {
        /*
        r10 = this;
        r1 = com.adobe.air.AndroidActivityWrapper.GetAndroidActivityWrapper();
        r0 = r1.getActivity();
        if (r0 != 0) goto L_0x0127;
    L_0x000a:
        r0 = r1.WaitForNewActivity();
        r1 = r0;
    L_0x000f:
        r2 = new com.adobe.air.AndroidAlertDialog;
        r2.<init>(r1);
        r3 = r2.GetAlertDialogBuilder();
        r0 = r1.getLayoutInflater();
        r4 = r1.getResources();
        r5 = "ssl_certificate_warning";
        r5 = com.adobe.air.utils.Utils.GetLayoutView(r5, r4, r0);
        if (r5 == 0) goto L_0x010b;
    L_0x0028:
        r6 = r5.getResources();
        r0 = "ServerName";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByNameFromPackage(r0, r6, r5);
        r0 = (android.widget.TextView) r0;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = r0.getText();
        r7 = r7.append(r8);
        r8 = " ";
        r7 = r7.append(r8);
        r7 = r7.append(r11);
        r7 = r7.toString();
        r0.setText(r7);
        if (r12 == 0) goto L_0x010c;
    L_0x0054:
        r0 = new com.adobe.air.Certificate;
        r0.<init>();
        r0.setCertificate(r12);
    L_0x005c:
        r7 = "IDA_CERTIFICATE_DETAILS";
        r4 = com.adobe.air.utils.Utils.GetResourceString(r7, r4);
        r7 = 8;
        r7 = new java.lang.Object[r7];
        r8 = 0;
        r9 = r0.getIssuedToCommonName();
        r7[r8] = r9;
        r8 = 1;
        r9 = r0.getIssuedToOrganization();
        r7[r8] = r9;
        r8 = 2;
        r9 = r0.getIssuedToOrganizationalUnit();
        r7[r8] = r9;
        r8 = 3;
        r9 = r0.getIssuedByCommonName();
        r7[r8] = r9;
        r8 = 4;
        r9 = r0.getIssuedByOrganization();
        r7[r8] = r9;
        r8 = 5;
        r9 = r0.getIssuedByOrganizationalUnit();
        r7[r8] = r9;
        r8 = 6;
        r9 = r0.getIssuedOn();
        r7[r8] = r9;
        r8 = 7;
        r0 = r0.getExpiresOn();
        r7[r8] = r0;
        r4 = java.lang.String.format(r4, r7);
        r0 = "CertificateDetails";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByNameFromPackage(r0, r6, r5);
        r0 = (android.widget.TextView) r0;
        r7 = android.widget.TextView.BufferType.SPANNABLE;
        r0.setText(r4, r7);
        r0 = "NeutralButton";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByNameFromPackage(r0, r6, r5);
        r0 = (android.widget.Button) r0;
        r4 = new com.adobe.air.SSLSecurityDialog$1;
        r4.<init>(r2);
        r0.setOnClickListener(r4);
        r0 = "PositiveButton";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByNameFromPackage(r0, r6, r5);
        r0 = (android.widget.Button) r0;
        if (r14 == 0) goto L_0x0113;
    L_0x00c9:
        r4 = new com.adobe.air.SSLSecurityDialog$2;
        r4.<init>(r2);
        r0.setOnClickListener(r4);
        r4 = 0;
        r0.setVisibility(r4);
    L_0x00d5:
        r0 = "NegativeButton";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByNameFromPackage(r0, r6, r5);
        r0 = (android.widget.Button) r0;
        r4 = new com.adobe.air.SSLSecurityDialog$3;
        r4.<init>(r2);
        r0.setOnClickListener(r4);
        r3.setView(r5);
        r0 = new com.adobe.air.SSLSecurityDialog$4;
        r0.<init>();
        r3.setOnKeyListener(r0);
        r0 = new com.adobe.air.SSLSecurityDialog$5;
        r0.<init>(r2);
        r1.runOnUiThread(r0);
        r0 = r10.m_lock;
        r0.lock();
        r0 = r10.m_useraction;	 Catch:{ InterruptedException -> 0x0119, all -> 0x0120 }
        if (r0 != 0) goto L_0x0106;
    L_0x0101:
        r0 = r10.m_condition;	 Catch:{ InterruptedException -> 0x0119, all -> 0x0120 }
        r0.await();	 Catch:{ InterruptedException -> 0x0119, all -> 0x0120 }
    L_0x0106:
        r0 = r10.m_lock;
        r0.unlock();
    L_0x010b:
        return;
    L_0x010c:
        r0 = new com.adobe.air.Certificate;
        r0.<init>(r13);
        goto L_0x005c;
    L_0x0113:
        r4 = 8;
        r0.setVisibility(r4);
        goto L_0x00d5;
    L_0x0119:
        r0 = move-exception;
        r0 = r10.m_lock;
        r0.unlock();
        goto L_0x010b;
    L_0x0120:
        r0 = move-exception;
        r1 = r10.m_lock;
        r1.unlock();
        throw r0;
    L_0x0127:
        r1 = r0;
        goto L_0x000f;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.SSLSecurityDialog.ShowSSLDialog(java.lang.String, byte[], android.net.http.SslCertificate, boolean):void");
    }

    private void SetUserAction(String str) {
        this.m_lock.lock();
        this.m_useraction = str;
        this.m_condition.signal();
        this.m_lock.unlock();
    }

    public String show(String str, SslCertificate sslCertificate) {
        ShowSSLDialog(str, null, sslCertificate, false);
        if (this.m_useraction != null) {
        }
        return this.m_useraction;
    }

    public String getUserAction() {
        return this.m_useraction;
    }
}
