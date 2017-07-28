package com.facebook.share.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import com.facebook.C0253R;
import com.facebook.internal.AnalyticsEvents;
import com.facebook.internal.CallbackManagerImpl.RequestCodeOffset;

public final class SendButton extends ShareButtonBase {

    class C03211 implements OnClickListener {
        C03211() {
        }

        public void onClick(View view) {
            SendButton.this.callExternalOnClickListener(view);
            (SendButton.this.getFragment() != null ? new MessageDialog(SendButton.this.getFragment(), SendButton.this.getRequestCode()) : new MessageDialog(SendButton.this.getActivity(), SendButton.this.getRequestCode())).show(SendButton.this.getShareContent());
        }
    }

    public SendButton(Context context) {
        super(context, null, 0, AnalyticsEvents.EVENT_SEND_BUTTON_CREATE, AnalyticsEvents.EVENT_SEND_BUTTON_DID_TAP);
    }

    public SendButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet, 0, AnalyticsEvents.EVENT_SEND_BUTTON_CREATE, AnalyticsEvents.EVENT_SEND_BUTTON_DID_TAP);
    }

    public SendButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i, AnalyticsEvents.EVENT_SEND_BUTTON_CREATE, AnalyticsEvents.EVENT_SEND_BUTTON_DID_TAP);
    }

    protected final int getDefaultRequestCode() {
        return RequestCodeOffset.Message.toRequestCode();
    }

    protected final int getDefaultStyleResource() {
        return C0253R.style.com_facebook_button_send;
    }

    protected final OnClickListener getShareOnClickListener() {
        return new C03211();
    }
}
