package com.adobe.air;

import java.util.ArrayList;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class FileChooserStub {
    public static final String TAG = FileChooserStub.class.toString();
    private AIRExpandableFileChooser fileChooser;
    private Condition m_condition = this.m_lock.newCondition();
    private ArrayList<String> m_filenames = null;
    private ArrayList<String> m_filterList = new ArrayList();
    private Lock m_lock = new ReentrantLock();
    private String m_userAction = null;

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void show(java.lang.String r8, boolean r9, boolean r10) {
        /*
        r7 = this;
        r1 = com.adobe.air.AndroidActivityWrapper.GetAndroidActivityWrapper();
        r0 = r1.getActivity();
        if (r0 != 0) goto L_0x0056;
    L_0x000a:
        r0 = r1.WaitForNewActivity();
        r6 = r0;
    L_0x000f:
        r0 = new com.adobe.air.FileChooserStub$1;
        r1 = r7;
        r2 = r9;
        r3 = r10;
        r4 = r8;
        r5 = r7;
        r0.<init>(r2, r3, r4, r5);
        r6.runOnUiThread(r0);
        r0 = r7.m_lock;
        r0.lock();
        r0 = r7.m_userAction;	 Catch:{ InterruptedException -> 0x0047, all -> 0x004e }
        if (r0 != 0) goto L_0x002a;
    L_0x0025:
        r0 = r7.m_condition;	 Catch:{ InterruptedException -> 0x0047, all -> 0x004e }
        r0.await();	 Catch:{ InterruptedException -> 0x0047, all -> 0x004e }
    L_0x002a:
        r0 = r7.m_lock;
        r0.unlock();
    L_0x002f:
        r0 = r7.fileChooser;
        r0 = r0.GetFileNames();
        r7.m_filenames = r0;
        r0 = r7.m_filenames;
        if (r0 == 0) goto L_0x0055;
    L_0x003b:
        r0 = 0;
    L_0x003c:
        r1 = r7.m_filenames;
        r1 = r1.size();
        if (r0 >= r1) goto L_0x0055;
    L_0x0044:
        r0 = r0 + 1;
        goto L_0x003c;
    L_0x0047:
        r0 = move-exception;
        r0 = r7.m_lock;
        r0.unlock();
        goto L_0x002f;
    L_0x004e:
        r0 = move-exception;
        r1 = r7.m_lock;
        r1.unlock();
        throw r0;
    L_0x0055:
        return;
    L_0x0056:
        r6 = r0;
        goto L_0x000f;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.FileChooserStub.show(java.lang.String, boolean, boolean):void");
    }

    public void addFilter(String str) {
        this.m_filterList.add(str);
    }

    public void SetUserAction(String str) {
        this.m_lock.lock();
        this.m_userAction = str;
        this.m_condition.signal();
        this.m_lock.unlock();
    }

    public int getNumFilenames() {
        return this.m_filenames.size();
    }

    public String getFilename(int i) {
        if (i >= this.m_filenames.size()) {
            return null;
        }
        return (String) this.m_filenames.get(i);
    }

    public boolean userCancelled() {
        if (this.m_userAction == null || this.m_userAction.equals("cancel")) {
            return true;
        }
        return false;
    }
}
