package com.facebook.internal;

import com.facebook.FacebookRequestError.Category;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import org.json.JSONArray;
import org.json.JSONObject;

public final class FacebookRequestErrorClassification {
    public static final int EC_APP_TOO_MANY_CALLS = 4;
    public static final int EC_INVALID_SESSION = 102;
    public static final int EC_INVALID_TOKEN = 190;
    public static final int EC_RATE = 9;
    public static final int EC_SERVICE_UNAVAILABLE = 2;
    public static final int EC_TOO_MANY_USER_ACTION_CALLS = 341;
    public static final int EC_USER_TOO_MANY_CALLS = 17;
    public static final String KEY_LOGIN_RECOVERABLE = "login_recoverable";
    public static final String KEY_NAME = "name";
    public static final String KEY_OTHER = "other";
    public static final String KEY_RECOVERY_MESSAGE = "recovery_message";
    public static final String KEY_TRANSIENT = "transient";
    private static FacebookRequestErrorClassification defaultInstance;
    private final Map<Integer, Set<Integer>> loginRecoverableErrors;
    private final String loginRecoverableRecoveryMessage;
    private final Map<Integer, Set<Integer>> otherErrors;
    private final String otherRecoveryMessage;
    private final Map<Integer, Set<Integer>> transientErrors;
    private final String transientRecoveryMessage;

    final class C02381 extends HashMap<Integer, Set<Integer>> {
        C02381() {
            put(Integer.valueOf(2), null);
            put(Integer.valueOf(4), null);
            put(Integer.valueOf(9), null);
            put(Integer.valueOf(17), null);
            put(Integer.valueOf(FacebookRequestErrorClassification.EC_TOO_MANY_USER_ACTION_CALLS), null);
        }
    }

    final class C02392 extends HashMap<Integer, Set<Integer>> {
        C02392() {
            put(Integer.valueOf(102), null);
            put(Integer.valueOf(FacebookRequestErrorClassification.EC_INVALID_TOKEN), null);
        }
    }

    FacebookRequestErrorClassification(Map<Integer, Set<Integer>> map, Map<Integer, Set<Integer>> map2, Map<Integer, Set<Integer>> map3, String str, String str2, String str3) {
        this.otherErrors = map;
        this.transientErrors = map2;
        this.loginRecoverableErrors = map3;
        this.otherRecoveryMessage = str;
        this.transientRecoveryMessage = str2;
        this.loginRecoverableRecoveryMessage = str3;
    }

    public static FacebookRequestErrorClassification createFromJSON(JSONArray jSONArray) {
        if (jSONArray == null) {
            return null;
        }
        String str = null;
        String str2 = null;
        String str3 = null;
        Map map = null;
        Map map2 = null;
        Map map3 = null;
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject optJSONObject = jSONArray.optJSONObject(i);
            if (optJSONObject != null) {
                String optString = optJSONObject.optString("name");
                if (optString != null) {
                    if (optString.equalsIgnoreCase(KEY_OTHER)) {
                        str3 = optJSONObject.optString(KEY_RECOVERY_MESSAGE, null);
                        map3 = parseJSONDefinition(optJSONObject);
                    } else if (optString.equalsIgnoreCase(KEY_TRANSIENT)) {
                        str2 = optJSONObject.optString(KEY_RECOVERY_MESSAGE, null);
                        map2 = parseJSONDefinition(optJSONObject);
                    } else if (optString.equalsIgnoreCase(KEY_LOGIN_RECOVERABLE)) {
                        str = optJSONObject.optString(KEY_RECOVERY_MESSAGE, null);
                        map = parseJSONDefinition(optJSONObject);
                    }
                }
            }
        }
        return new FacebookRequestErrorClassification(map3, map2, map, str3, str2, str);
    }

    public static synchronized FacebookRequestErrorClassification getDefaultErrorClassification() {
        FacebookRequestErrorClassification facebookRequestErrorClassification;
        synchronized (FacebookRequestErrorClassification.class) {
            if (defaultInstance == null) {
                defaultInstance = getDefaultErrorClassificationImpl();
            }
            facebookRequestErrorClassification = defaultInstance;
        }
        return facebookRequestErrorClassification;
    }

    private static FacebookRequestErrorClassification getDefaultErrorClassificationImpl() {
        return new FacebookRequestErrorClassification(null, new C02381(), new C02392(), null, null, null);
    }

    private static Map<Integer, Set<Integer>> parseJSONDefinition(JSONObject jSONObject) {
        JSONArray optJSONArray = jSONObject.optJSONArray("items");
        if (optJSONArray.length() == 0) {
            return null;
        }
        Map<Integer, Set<Integer>> hashMap = new HashMap();
        for (int i = 0; i < optJSONArray.length(); i++) {
            JSONObject optJSONObject = optJSONArray.optJSONObject(i);
            if (optJSONObject != null) {
                int optInt = optJSONObject.optInt("code");
                if (optInt != 0) {
                    Object obj;
                    JSONArray optJSONArray2 = optJSONObject.optJSONArray("subcodes");
                    if (optJSONArray2 == null || optJSONArray2.length() <= 0) {
                        obj = null;
                    } else {
                        Set hashSet = new HashSet();
                        for (int i2 = 0; i2 < optJSONArray2.length(); i2++) {
                            int optInt2 = optJSONArray2.optInt(i2);
                            if (optInt2 != 0) {
                                hashSet.add(Integer.valueOf(optInt2));
                            }
                        }
                        obj = hashSet;
                    }
                    hashMap.put(Integer.valueOf(optInt), obj);
                }
            }
        }
        return hashMap;
    }

    public final Category classify(int i, int i2, boolean z) {
        if (z) {
            return Category.TRANSIENT;
        }
        Set set;
        if (this.otherErrors != null && this.otherErrors.containsKey(Integer.valueOf(i))) {
            set = (Set) this.otherErrors.get(Integer.valueOf(i));
            if (set == null || set.contains(Integer.valueOf(i2))) {
                return Category.OTHER;
            }
        }
        if (this.loginRecoverableErrors != null && this.loginRecoverableErrors.containsKey(Integer.valueOf(i))) {
            set = (Set) this.loginRecoverableErrors.get(Integer.valueOf(i));
            if (set == null || set.contains(Integer.valueOf(i2))) {
                return Category.LOGIN_RECOVERABLE;
            }
        }
        if (this.transientErrors != null && this.transientErrors.containsKey(Integer.valueOf(i))) {
            set = (Set) this.transientErrors.get(Integer.valueOf(i));
            if (set == null || set.contains(Integer.valueOf(i2))) {
                return Category.TRANSIENT;
            }
        }
        return Category.OTHER;
    }

    public final Map<Integer, Set<Integer>> getLoginRecoverableErrors() {
        return this.loginRecoverableErrors;
    }

    public final Map<Integer, Set<Integer>> getOtherErrors() {
        return this.otherErrors;
    }

    public final String getRecoveryMessage(Category category) {
        switch (category) {
            case OTHER:
                return this.otherRecoveryMessage;
            case LOGIN_RECOVERABLE:
                return this.loginRecoverableRecoveryMessage;
            case TRANSIENT:
                return this.transientRecoveryMessage;
            default:
                return null;
        }
    }

    public final Map<Integer, Set<Integer>> getTransientErrors() {
        return this.transientErrors;
    }
}
