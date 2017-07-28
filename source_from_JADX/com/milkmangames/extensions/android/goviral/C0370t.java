package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.applinks.AppLinkData;
import com.facebook.applinks.AppLinkData.CompletionHandler;

final class C0370t implements CompletionHandler {
    final /* synthetic */ C0351a f386a;

    C0370t(C0351a c0351a) {
        this.f386a = c0351a;
    }

    public final void onDeferredAppLinkDataFetched(AppLinkData appLinkData) {
        if (appLinkData == null) {
            Log.d("[GVExtension]", "No deferred app link data!");
            return;
        }
        if (appLinkData.getTargetUri() == null) {
            Log.d("[GVExtension]", "Empty deferred app link target uri!");
        }
        this.f386a.dispatchStatusEventAsync("701", appLinkData.getTargetUri().toString());
    }
}
