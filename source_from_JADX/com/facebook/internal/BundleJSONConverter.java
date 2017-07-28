package com.facebook.internal;

import android.os.Bundle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

public class BundleJSONConverter {
    private static final Map<Class<?>, Setter> SETTERS;

    public interface Setter {
        void setOnBundle(Bundle bundle, String str, Object obj);

        void setOnJSON(JSONObject jSONObject, String str, Object obj);
    }

    final class C02271 implements Setter {
        C02271() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            bundle.putBoolean(str, ((Boolean) obj).booleanValue());
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            jSONObject.put(str, obj);
        }
    }

    final class C02282 implements Setter {
        C02282() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            bundle.putInt(str, ((Integer) obj).intValue());
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            jSONObject.put(str, obj);
        }
    }

    final class C02293 implements Setter {
        C02293() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            bundle.putLong(str, ((Long) obj).longValue());
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            jSONObject.put(str, obj);
        }
    }

    final class C02304 implements Setter {
        C02304() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            bundle.putDouble(str, ((Double) obj).doubleValue());
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            jSONObject.put(str, obj);
        }
    }

    final class C02315 implements Setter {
        C02315() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            bundle.putString(str, (String) obj);
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            jSONObject.put(str, obj);
        }
    }

    final class C02326 implements Setter {
        C02326() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            throw new IllegalArgumentException("Unexpected type from JSON");
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            JSONArray jSONArray = new JSONArray();
            for (Object put : (String[]) obj) {
                jSONArray.put(put);
            }
            jSONObject.put(str, jSONArray);
        }
    }

    final class C02337 implements Setter {
        C02337() {
        }

        public final void setOnBundle(Bundle bundle, String str, Object obj) {
            JSONArray jSONArray = (JSONArray) obj;
            ArrayList arrayList = new ArrayList();
            if (jSONArray.length() == 0) {
                bundle.putStringArrayList(str, arrayList);
                return;
            }
            int i = 0;
            while (i < jSONArray.length()) {
                Object obj2 = jSONArray.get(i);
                if (obj2 instanceof String) {
                    arrayList.add((String) obj2);
                    i++;
                } else {
                    throw new IllegalArgumentException("Unexpected type in an array: " + obj2.getClass());
                }
            }
            bundle.putStringArrayList(str, arrayList);
        }

        public final void setOnJSON(JSONObject jSONObject, String str, Object obj) {
            throw new IllegalArgumentException("JSONArray's are not supported in bundles.");
        }
    }

    static {
        Map hashMap = new HashMap();
        SETTERS = hashMap;
        hashMap.put(Boolean.class, new C02271());
        SETTERS.put(Integer.class, new C02282());
        SETTERS.put(Long.class, new C02293());
        SETTERS.put(Double.class, new C02304());
        SETTERS.put(String.class, new C02315());
        SETTERS.put(String[].class, new C02326());
        SETTERS.put(JSONArray.class, new C02337());
    }

    public static Bundle convertToBundle(JSONObject jSONObject) {
        Bundle bundle = new Bundle();
        Iterator keys = jSONObject.keys();
        while (keys.hasNext()) {
            String str = (String) keys.next();
            Object obj = jSONObject.get(str);
            if (!(obj == null || obj == JSONObject.NULL)) {
                if (obj instanceof JSONObject) {
                    bundle.putBundle(str, convertToBundle((JSONObject) obj));
                } else {
                    Setter setter = (Setter) SETTERS.get(obj.getClass());
                    if (setter == null) {
                        throw new IllegalArgumentException("Unsupported type: " + obj.getClass());
                    }
                    setter.setOnBundle(bundle, str, obj);
                }
            }
        }
        return bundle;
    }

    public static JSONObject convertToJSON(Bundle bundle) {
        JSONObject jSONObject = new JSONObject();
        for (String str : bundle.keySet()) {
            Object obj = bundle.get(str);
            if (obj != null) {
                if (obj instanceof List) {
                    JSONArray jSONArray = new JSONArray();
                    for (String put : (List) obj) {
                        jSONArray.put(put);
                    }
                    jSONObject.put(str, jSONArray);
                } else if (obj instanceof Bundle) {
                    jSONObject.put(str, convertToJSON((Bundle) obj));
                } else {
                    Setter setter = (Setter) SETTERS.get(obj.getClass());
                    if (setter == null) {
                        throw new IllegalArgumentException("Unsupported type: " + obj.getClass());
                    }
                    setter.setOnJSON(jSONObject, str, obj);
                }
            }
        }
        return jSONObject;
    }
}
