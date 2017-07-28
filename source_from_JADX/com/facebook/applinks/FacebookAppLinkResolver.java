package com.facebook.applinks;

import android.net.Uri;
import android.os.Bundle;
import com.facebook.AccessToken;
import com.facebook.FacebookRequestError;
import com.facebook.GraphRequest;
import com.facebook.GraphRequest.Callback;
import com.facebook.GraphResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import p000c.p001m.p002x.p003a.gv.bo;
import p000c.p001m.p002x.p003a.gv.bo.C0049a;
import p000c.p001m.p002x.p003a.gv.bs;
import p000c.p001m.p002x.p003a.gv.bt;
import p000c.p001m.p002x.p003a.gv.bt.C0051a;

public class FacebookAppLinkResolver {
    private static final String APP_LINK_ANDROID_TARGET_KEY = "android";
    private static final String APP_LINK_KEY = "app_links";
    private static final String APP_LINK_TARGET_APP_NAME_KEY = "app_name";
    private static final String APP_LINK_TARGET_CLASS_KEY = "class";
    private static final String APP_LINK_TARGET_PACKAGE_KEY = "package";
    private static final String APP_LINK_TARGET_SHOULD_FALLBACK_KEY = "should_fallback";
    private static final String APP_LINK_TARGET_URL_KEY = "url";
    private static final String APP_LINK_WEB_TARGET_KEY = "web";
    private final HashMap<Uri, bo> cachedAppLinks = new HashMap();

    private static C0049a getAndroidTargetFromJson(JSONObject jSONObject) {
        Uri uri = null;
        String tryGetStringFromJson = tryGetStringFromJson(jSONObject, APP_LINK_TARGET_PACKAGE_KEY, null);
        if (tryGetStringFromJson == null) {
            return null;
        }
        String tryGetStringFromJson2 = tryGetStringFromJson(jSONObject, APP_LINK_TARGET_CLASS_KEY, null);
        String tryGetStringFromJson3 = tryGetStringFromJson(jSONObject, "app_name", null);
        String tryGetStringFromJson4 = tryGetStringFromJson(jSONObject, "url", null);
        if (tryGetStringFromJson4 != null) {
            uri = Uri.parse(tryGetStringFromJson4);
        }
        return new C0049a(tryGetStringFromJson, tryGetStringFromJson2, uri, tryGetStringFromJson3);
    }

    private static Uri getWebFallbackUriFromJson(Uri uri, JSONObject jSONObject) {
        Uri uri2 = null;
        try {
            JSONObject jSONObject2 = jSONObject.getJSONObject("web");
            if (!tryGetBooleanFromJson(jSONObject2, APP_LINK_TARGET_SHOULD_FALLBACK_KEY, true)) {
                return null;
            }
            String tryGetStringFromJson = tryGetStringFromJson(jSONObject2, "url", null);
            if (tryGetStringFromJson != null) {
                uri2 = Uri.parse(tryGetStringFromJson);
            }
            return uri2 != null ? uri2 : uri;
        } catch (JSONException e) {
            return uri;
        }
    }

    private static boolean tryGetBooleanFromJson(JSONObject jSONObject, String str, boolean z) {
        try {
            z = jSONObject.getBoolean(str);
        } catch (JSONException e) {
        }
        return z;
    }

    private static String tryGetStringFromJson(JSONObject jSONObject, String str, String str2) {
        try {
            str2 = jSONObject.getString(str);
        } catch (JSONException e) {
        }
        return str2;
    }

    public bt<bo> getAppLinkFromUrlInBackground(final Uri uri) {
        List arrayList = new ArrayList();
        arrayList.add(uri);
        return getAppLinkFromUrlsInBackground(arrayList).m235b(new bs<Map<Uri, bo>, bo>() {
            public bo then(bt<Map<Uri, bo>> btVar) {
                return (bo) ((Map) btVar.m238d()).get(uri);
            }
        });
    }

    public bt<Map<Uri, bo>> getAppLinkFromUrlsInBackground(List<Uri> list) {
        final Object hashMap = new HashMap();
        final HashSet hashSet = new HashSet();
        StringBuilder stringBuilder = new StringBuilder();
        for (Uri uri : list) {
            synchronized (this.cachedAppLinks) {
                bo boVar = (bo) this.cachedAppLinks.get(uri);
            }
            if (boVar != null) {
                hashMap.put(uri, boVar);
            } else {
                if (!hashSet.isEmpty()) {
                    stringBuilder.append(',');
                }
                stringBuilder.append(uri.toString());
                hashSet.add(uri);
            }
        }
        if (hashSet.isEmpty()) {
            return bt.m219a(hashMap);
        }
        final C0051a a = bt.m216a();
        Bundle bundle = new Bundle();
        bundle.putString("ids", stringBuilder.toString());
        bundle.putString(GraphRequest.FIELDS_PARAM, String.format("%s.fields(%s,%s)", new Object[]{APP_LINK_KEY, APP_LINK_ANDROID_TARGET_KEY, "web"}));
        new GraphRequest(AccessToken.getCurrentAccessToken(), "", bundle, null, new Callback() {
            public void onCompleted(GraphResponse graphResponse) {
                FacebookRequestError error = graphResponse.getError();
                if (error != null) {
                    a.m213a(error.getException());
                    return;
                }
                JSONObject jSONObject = graphResponse.getJSONObject();
                if (jSONObject == null) {
                    a.m214a(hashMap);
                    return;
                }
                Iterator it = hashSet.iterator();
                while (it.hasNext()) {
                    Uri uri = (Uri) it.next();
                    if (jSONObject.has(uri.toString())) {
                        try {
                            JSONObject jSONObject2 = jSONObject.getJSONObject(uri.toString()).getJSONObject(FacebookAppLinkResolver.APP_LINK_KEY);
                            JSONArray jSONArray = jSONObject2.getJSONArray(FacebookAppLinkResolver.APP_LINK_ANDROID_TARGET_KEY);
                            int length = jSONArray.length();
                            List arrayList = new ArrayList(length);
                            for (int i = 0; i < length; i++) {
                                C0049a access$000 = FacebookAppLinkResolver.getAndroidTargetFromJson(jSONArray.getJSONObject(i));
                                if (access$000 != null) {
                                    arrayList.add(access$000);
                                }
                            }
                            bo boVar = new bo(uri, arrayList, FacebookAppLinkResolver.getWebFallbackUriFromJson(uri, jSONObject2));
                            hashMap.put(uri, boVar);
                            synchronized (FacebookAppLinkResolver.this.cachedAppLinks) {
                                FacebookAppLinkResolver.this.cachedAppLinks.put(uri, boVar);
                            }
                        } catch (JSONException e) {
                        }
                    }
                }
                a.m214a(hashMap);
            }
        }).executeAsync();
        return a.m212a();
    }
}
