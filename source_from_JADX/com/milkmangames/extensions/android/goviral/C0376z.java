package com.milkmangames.extensions.android.goviral;

import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;
import org.json.JSONException;
import org.json.JSONObject;

final class C0376z implements Callback {
    final /* synthetic */ String f397a;
    final /* synthetic */ C0351a f398b;

    C0376z(C0351a c0351a, String str) {
        this.f398b = c0351a;
        this.f397a = str;
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
        this.f398b.dispatchStatusEventAsync(this.f397a + "[[[GVRiD]]]420", str);
    }
}
