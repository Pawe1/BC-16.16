package com.adobe.air;

import android.app.Activity;
import android.app.UiModeManager;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Build.VERSION;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Locale;

public class InstallOfferPingUtils {
    private static final String LOG_TAG = "InstallOfferPingUtils";

    private static boolean isAndroidTV(Activity activity) {
        try {
            if (((UiModeManager) activity.getSystemService("uimode")).getCurrentModeType() == 4) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static void PingAndExit(Activity activity, String baseUrl, boolean installClicked, boolean update, final boolean exit) {
        try {
            String urlQueryStr = "";
            if (update) {
                urlQueryStr = urlQueryStr + "installOffer=" + (installClicked ? "ua" : "ur");
            } else {
                urlQueryStr = urlQueryStr + "installOffer=" + (installClicked ? "a" : "r");
            }
            urlQueryStr = (((urlQueryStr + "&appid=" + activity.getPackageName()) + "&runtimeType=s") + "&lang=" + Locale.getDefault().getLanguage()) + "&model=" + Build.MODEL;
            if (isAndroidTV(activity)) {
                urlQueryStr = urlQueryStr + "&os=atv";
            } else {
                urlQueryStr = urlQueryStr + "&os=a";
            }
            String urlStr = baseUrl + URLEncoder.encode((urlQueryStr + "&osVer=" + VERSION.RELEASE) + "&arch=" + System.getProperty("os.arch"), "UTF-8");
            new AsyncTask<String, Integer, Integer>() {
                protected Integer doInBackground(String... urls) {
                    int resCode = 0;
                    try {
                        HttpURLConnection conn = (HttpURLConnection) new URL(urls[0]).openConnection();
                        conn.setConnectTimeout(10000);
                        conn.setRequestMethod("GET");
                        HttpURLConnection.setFollowRedirects(true);
                        resCode = conn.getResponseCode();
                        if (exit) {
                            System.exit(0);
                        }
                    } catch (Exception e) {
                    }
                    return Integer.valueOf(resCode);
                }
            }.execute(new String[]{urlStr});
            activity.finish();
        } catch (Exception e) {
        }
    }
}
