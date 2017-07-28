package com.facebook.internal;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import p000c.p001m.p002x.p003a.gv.C0073r;

public class FragmentWrapper {
    private Fragment nativeFragment;
    private C0073r supportFragment;

    public FragmentWrapper(Fragment fragment) {
        Validate.notNull(fragment, "fragment");
        this.nativeFragment = fragment;
    }

    public FragmentWrapper(C0073r c0073r) {
        Validate.notNull(c0073r, "fragment");
        this.supportFragment = c0073r;
    }

    public final Activity getActivity() {
        return this.supportFragment != null ? this.supportFragment.getActivity() : this.nativeFragment.getActivity();
    }

    public Fragment getNativeFragment() {
        return this.nativeFragment;
    }

    public C0073r getSupportFragment() {
        return this.supportFragment;
    }

    public void startActivityForResult(Intent intent, int i) {
        if (this.supportFragment != null) {
            this.supportFragment.startActivityForResult(intent, i);
        } else {
            this.nativeFragment.startActivityForResult(intent, i);
        }
    }
}
