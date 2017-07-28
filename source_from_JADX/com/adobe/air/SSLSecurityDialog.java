package com.adobe.air;

import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
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

    class C01371 implements OnClickListener {
        C01371() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            SSLSecurityDialog.this.SetUserAction(SSLSecurityDialog.USER_ACTION_TRUST_ALWAYS);
        }
    }

    class C01382 implements OnClickListener {
        C01382() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            SSLSecurityDialog.this.SetUserAction(SSLSecurityDialog.USER_ACTION_TRUST_SESSION);
        }
    }

    class C01393 implements OnClickListener {
        C01393() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            SSLSecurityDialog.this.SetUserAction(SSLSecurityDialog.USER_ACTION_TRUST_NONE);
        }
    }

    class C01404 implements OnKeyListener {
        C01404() {
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
    public void ShowSSLDialog(java.lang.String r12, byte[] r13, android.net.http.SslCertificate r14, boolean r15) {
        /*
        r11 = this;
        r2 = com.adobe.air.AndroidActivityWrapper.GetAndroidActivityWrapper();
        r0 = r2.getActivity();
        if (r0 != 0) goto L_0x011b;
    L_0x000a:
        r0 = r2.WaitForNewActivity();
        r1 = r0;
    L_0x000f:
        r3 = new com.adobe.air.AndroidAlertDialog;
        r3.<init>(r1);
        r4 = r3.GetAlertDialogBuilder();
        r0 = r2.getRuntimeContext();
        r2 = android.view.LayoutInflater.from(r0);
        r5 = r0.getResources();
        r0 = "ssl_certificate_warning";
        r2 = com.adobe.air.utils.Utils.GetLayoutViewFromRuntime(r0, r5, r2);
        if (r2 == 0) goto L_0x0105;
    L_0x002c:
        r6 = r2.getResources();
        r0 = "ServerName";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByName(r0, r6, r2);
        r0 = (android.widget.TextView) r0;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = r0.getText();
        r7 = r7.append(r8);
        r8 = " ";
        r7 = r7.append(r8);
        r7 = r7.append(r12);
        r7 = r7.toString();
        r0.setText(r7);
        if (r13 == 0) goto L_0x0106;
    L_0x0058:
        r0 = new com.adobe.air.Certificate;
        r0.<init>();
        r0.setCertificate(r13);
    L_0x0060:
        r7 = "IDA_CERTIFICATE_DETAILS";
        r7 = com.adobe.air.utils.Utils.GetResourceStringFromRuntime(r7, r5);
        r8 = 8;
        r8 = new java.lang.Object[r8];
        r9 = 0;
        r10 = r0.getIssuedToCommonName();
        r8[r9] = r10;
        r9 = 1;
        r10 = r0.getIssuedToOrganization();
        r8[r9] = r10;
        r9 = 2;
        r10 = r0.getIssuedToOrganizationalUnit();
        r8[r9] = r10;
        r9 = 3;
        r10 = r0.getIssuedByCommonName();
        r8[r9] = r10;
        r9 = 4;
        r10 = r0.getIssuedByOrganization();
        r8[r9] = r10;
        r9 = 5;
        r10 = r0.getIssuedByOrganizationalUnit();
        r8[r9] = r10;
        r9 = 6;
        r10 = r0.getIssuedOn();
        r8[r9] = r10;
        r9 = 7;
        r0 = r0.getExpiresOn();
        r8[r9] = r0;
        r7 = java.lang.String.format(r7, r8);
        r0 = "CertificateDetails";
        r0 = com.adobe.air.utils.Utils.GetWidgetInViewByName(r0, r6, r2);
        r0 = (android.widget.TextView) r0;
        r6 = android.widget.TextView.BufferType.SPANNABLE;
        r0.setText(r7, r6);
        r4.setView(r2);
        if (r15 == 0) goto L_0x00c6;
    L_0x00b8:
        r0 = "IDA_CURL_INTERFACE_ALLSESS";
        r0 = com.adobe.air.utils.Utils.GetResourceStringFromRuntime(r0, r5);
        r2 = new com.adobe.air.SSLSecurityDialog$1;
        r2.<init>();
        r4.setPositiveButton(r0, r2);
    L_0x00c6:
        r0 = "IDA_CURL_INTERFACE_THISSESS";
        r0 = com.adobe.air.utils.Utils.GetResourceStringFromRuntime(r0, r5);
        r2 = new com.adobe.air.SSLSecurityDialog$2;
        r2.<init>();
        r4.setNeutralButton(r0, r2);
        r0 = "IDA_CURL_INTERFACE_NOSESS";
        r0 = com.adobe.air.utils.Utils.GetResourceStringFromRuntime(r0, r5);
        r2 = new com.adobe.air.SSLSecurityDialog$3;
        r2.<init>();
        r4.setNegativeButton(r0, r2);
        r0 = new com.adobe.air.SSLSecurityDialog$4;
        r0.<init>();
        r4.setOnKeyListener(r0);
        r0 = new com.adobe.air.SSLSecurityDialog$5;
        r0.<init>(r3);
        r1.runOnUiThread(r0);
        r0 = r11.m_lock;
        r0.lock();
        r0 = r11.m_useraction;	 Catch:{ InterruptedException -> 0x010d, all -> 0x0114 }
        if (r0 != 0) goto L_0x0100;
    L_0x00fb:
        r0 = r11.m_condition;	 Catch:{ InterruptedException -> 0x010d, all -> 0x0114 }
        r0.await();	 Catch:{ InterruptedException -> 0x010d, all -> 0x0114 }
    L_0x0100:
        r0 = r11.m_lock;
        r0.unlock();
    L_0x0105:
        return;
    L_0x0106:
        r0 = new com.adobe.air.Certificate;
        r0.<init>(r14);
        goto L_0x0060;
    L_0x010d:
        r0 = move-exception;
        r0 = r11.m_lock;
        r0.unlock();
        goto L_0x0105;
    L_0x0114:
        r0 = move-exception;
        r1 = r11.m_lock;
        r1.unlock();
        throw r0;
    L_0x011b:
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
