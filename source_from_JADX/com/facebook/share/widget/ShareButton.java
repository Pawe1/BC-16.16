package com.facebook.share.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import com.facebook.C0253R;
import com.facebook.internal.AnalyticsEvents;
import com.facebook.internal.CallbackManagerImpl.RequestCodeOffset;

public final class ShareButton extends ShareButtonBase {

    class C03221 implements OnClickListener {
        C03221() {
        }

        public void onClick(View view) {
            ShareButton.this.callExternalOnClickListener(view);
            (ShareButton.this.getFragment() != null ? new ShareDialog(ShareButton.this.getFragment(), ShareButton.this.getRequestCode()) : new ShareDialog(ShareButton.this.getActivity(), ShareButton.this.getRequestCode())).show(ShareButton.this.getShareContent());
        }
    }

    public ShareButton(Context context) {
        super(context, null, 0, AnalyticsEvents.EVENT_SHARE_BUTTON_CREATE, AnalyticsEvents.EVENT_SHARE_BUTTON_DID_TAP);
    }

    public ShareButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet, 0, AnalyticsEvents.EVENT_SHARE_BUTTON_CREATE, AnalyticsEvents.EVENT_SHARE_BUTTON_DID_TAP);
    }

    public ShareButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i, AnalyticsEvents.EVENT_SHARE_BUTTON_CREATE, AnalyticsEvents.EVENT_SHARE_BUTTON_DID_TAP);
    }

    protected final int getDefaultRequestCode() {
        return RequestCodeOffset.Share.toRequestCode();
    }

    protected final int getDefaultStyleResource() {
        return C0253R.style.com_facebook_button_share;
    }

    protected final OnClickListener getShareOnClickListener() {
        return new C03221();
    }
}
