package com.milkmangames.extensions.android.goviral;

import android.util.Log;
import com.facebook.applinks.AppLinkData;
import com.facebook.applinks.AppLinkData.CompletionHandler;

final class C0422t implements CompletionHandler {
    final /* synthetic */ C0403a f400a;

    C0422t(C0403a c0403a) {
        this.f400a = c0403a;
    }

    public final void onDeferredAppLinkDataFetched(AppLinkData appLinkData) {
        if (appLinkData == null) {
            Log.d("[GVExtension]", "No deferred app link data!");
            return;
        }
        if (appLinkData.getTargetUri() == null) {
            Log.d("[GVExtension]", "Empty deferred app link target uri!");
        }
        this.f400a.dispatchStatusEventAsync("701", appLinkData.getTargetUri().toString());
    }
}
