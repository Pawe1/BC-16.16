package com.adobe.air.utils;

import android.util.Log;

public class AIRLogger {
    static boolean g_enableReleaseLogging = false;
    private static String mflag = (Utils.GetExternalStorageDirectory() + "/.AIR/enable_logging");

    public static void Enable(boolean z) {
        g_enableReleaseLogging = z;
        Log.v("Release Logging: ", "enabled = " + g_enableReleaseLogging);
    }

    public static boolean isEnabled() {
        return g_enableReleaseLogging;
    }

    public static int m364d(String str, String str2, Throwable th) {
        return g_enableReleaseLogging ? Log.d(str, str2, th) : 0;
    }

    public static int m363d(String str, String str2) {
        return g_enableReleaseLogging ? Log.d(str, str2) : 0;
    }

    public static int m365e(String str, String str2) {
        return g_enableReleaseLogging ? Log.e(str, str2) : 0;
    }

    public static int m366e(String str, String str2, Throwable th) {
        return g_enableReleaseLogging ? Log.e(str, str2, th) : 0;
    }

    public static int m368i(String str, String str2, Throwable th) {
        return g_enableReleaseLogging ? Log.i(str, str2, th) : 0;
    }

    public static int m367i(String str, String str2) {
        return g_enableReleaseLogging ? Log.i(str, str2) : 0;
    }

    public static int m370v(String str, String str2, Throwable th) {
        return g_enableReleaseLogging ? Log.v(str, str2, th) : 0;
    }

    public static int m369v(String str, String str2) {
        return g_enableReleaseLogging ? Log.v(str, str2) : 0;
    }

    public static int m371w(String str, String str2) {
        return g_enableReleaseLogging ? Log.w(str, str2) : 0;
    }

    public static int m373w(String str, Throwable th) {
        return g_enableReleaseLogging ? Log.w(str, th) : 0;
    }

    public static int m372w(String str, String str2, Throwable th) {
        return g_enableReleaseLogging ? Log.w(str, str2, th) : 0;
    }

    public static int println(int i, String str, String str2) {
        return g_enableReleaseLogging ? Log.println(i, str, str2) : 0;
    }

    public static boolean isLoggable(String str, int i) {
        return g_enableReleaseLogging ? Log.isLoggable(str, i) : false;
    }
}
