package com.facebook.login;

public enum LoginBehavior {
    NATIVE_WITH_FALLBACK(true, true),
    NATIVE_ONLY(true, false),
    WEB_ONLY(false, true);
    
    private final boolean allowsKatanaAuth;
    private final boolean allowsWebViewAuth;

    private LoginBehavior(boolean z, boolean z2) {
        this.allowsKatanaAuth = z;
        this.allowsWebViewAuth = z2;
    }

    final boolean allowsKatanaAuth() {
        return this.allowsKatanaAuth;
    }

    final boolean allowsWebViewAuth() {
        return this.allowsWebViewAuth;
    }
}
