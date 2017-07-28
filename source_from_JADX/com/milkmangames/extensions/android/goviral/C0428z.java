package com.milkmangames.extensions.android.goviral;

import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;
import org.json.JSONException;
import org.json.JSONObject;

final class C0428z implements Callback {
    final /* synthetic */ String f411a;
    final /* synthetic */ C0403a f412b;

    C0428z(C0403a c0403a, String str) {
        this.f412b = c0403a;
        this.f411a = str;
    }

    public final void onCompleted(GraphResponse graphResponse) {
        String str = "";
        JSONObject jSONObject = graphResponse.getJSONObject();
        if (jSONObject != null && jSONObject.has("custom_audience_third_party_id")) {
            try {
                str = jSONObject.getString("custom_audience_third_party_id");
            } catch (JSONException e) {
                str = "";
            }
        }
        this.f412b.dispatchStatusEventAsync(this.f411a + "[[[GVRiD]]]420", str);
    }
}
