package com.adobe.air.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.res.Resources;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Environment;
import android.os.Process;
import android.view.LayoutInflater;
import android.view.View;
import com.facebook.share.internal.ShareConstants;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Scanner;

public class Utils {
    private static String sRuntimePackageName;

    public static native boolean nativeConnectDebuggerSocket(String str);

    public static String getRuntimePackageName() {
        return sRuntimePackageName;
    }

    public static void setRuntimePackageName(String str) {
        sRuntimePackageName = str;
    }

    public static boolean hasCaptiveRuntime() {
        return !"com.adobe.air".equals(sRuntimePackageName);
    }

    static void KillProcess() {
        Process.killProcess(Process.myPid());
    }

    public static boolean writeStringToFile(String str, String str2) {
        File file = new File(str2);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                return false;
            }
        }
        byte[] bytes = str.getBytes();
        try {
            OutputStream fileOutputStream = new FileOutputStream(file);
            fileOutputStream.write(bytes, 0, bytes.length);
            fileOutputStream.close();
            return true;
        } catch (IOException e2) {
            return false;
        }
    }

    public static void writeOut(InputStream inputStream, File file) throws IOException {
        OutputStream fileOutputStream = new FileOutputStream(file);
        writeThrough(inputStream, fileOutputStream);
        fileOutputStream.close();
    }

    public static void writeThrough(InputStream inputStream, OutputStream outputStream) throws IOException {
        byte[] bArr = new byte[4096];
        while (true) {
            int read = inputStream.read(bArr);
            if (read == -1) {
                return;
            }
            if (outputStream != null) {
                outputStream.write(bArr, 0, read);
                outputStream.flush();
            }
        }
    }

    public static void copyTo(File file, File file2) throws IOException {
        if (file.isDirectory()) {
            file2.mkdirs();
            for (File file3 : file.listFiles()) {
                copyTo(file3, new File(file2, file3.getName()));
            }
            return;
        }
        InputStream fileInputStream = new FileInputStream(file);
        OutputStream fileOutputStream = new FileOutputStream(file2);
        copyTo(fileInputStream, fileOutputStream);
        fileInputStream.close();
        fileOutputStream.close();
    }

    public static void copyTo(InputStream inputStream, OutputStream outputStream) throws IOException {
        byte[] bArr = new byte[1024];
        while (true) {
            int read = inputStream.read(bArr);
            if (read > 0) {
                outputStream.write(bArr, 0, read);
            } else {
                return;
            }
        }
    }

    public static void writeBufferToFile(StringBuffer stringBuffer, File file) throws IOException {
        FileWriter fileWriter = new FileWriter(file);
        fileWriter.write(stringBuffer.toString());
        fileWriter.close();
    }

    public static HashMap<String, String> parseKeyValuePairFile(File file, String str) throws FileNotFoundException, IllegalStateException {
        return parseKeyValuePairFile(new FileInputStream(file), str);
    }

    public static HashMap<String, String> parseKeyValuePairFile(InputStream inputStream, String str) throws IllegalStateException {
        HashMap<String, String> hashMap = new HashMap();
        Scanner scanner = new Scanner(inputStream);
        while (scanner.hasNextLine()) {
            Scanner scanner2 = new Scanner(scanner.nextLine());
            scanner2.useDelimiter(str);
            if (scanner2.hasNext()) {
                hashMap.put(scanner2.next().trim(), scanner2.next().trim());
            }
            scanner2.close();
        }
        scanner.close();
        return hashMap;
    }

    public static void writeStringToFile(String str, File file) throws IOException {
        FileWriter fileWriter = new FileWriter(file);
        fileWriter.write(str);
        fileWriter.close();
    }

    public static String ReplaceTextContentWithStars(String str) {
        int length = str.length();
        char[] cArr = new char[length];
        for (int i = 0; i < length; i++) {
            cArr[i] = '*';
        }
        return new String(cArr);
    }

    public static String GetResourceStringFromRuntime(String str, Resources resources) {
        return resources.getString(resources.getIdentifier(str, "string", sRuntimePackageName));
    }

    public static View GetWidgetInViewByName(String str, Resources resources, View view) {
        return view.findViewById(resources.getIdentifier(str, ShareConstants.WEB_DIALOG_PARAM_ID, sRuntimePackageName));
    }

    public static View GetLayoutViewFromRuntime(String str, Resources resources, LayoutInflater layoutInflater) {
        int identifier = resources.getIdentifier(str, "layout", sRuntimePackageName);
        if (identifier != 0) {
            return layoutInflater.inflate(identifier, null);
        }
        return null;
    }

    public static String GetExternalStorageDirectory() {
        return Environment.getExternalStorageDirectory().getAbsolutePath();
    }

    public static String GetSharedDataDirectory() {
        return Environment.getDataDirectory().getAbsolutePath();
    }

    public static String GetLibCorePath(Context context) {
        return GetNativeLibraryPath(context, "libCore.so");
    }

    public static String GetLibSTLPath(Context context) {
        return GetNativeLibraryPath(context, "libstlport_shared.so");
    }

    public static String GetNativeLibraryPath(Context context, String str) {
        String str2;
        try {
            ApplicationInfo applicationInfo = context.getPackageManager().getApplicationInfo(sRuntimePackageName, 0);
            Field field = ApplicationInfo.class.getField("nativeLibraryDir");
            str2 = field != null ? ((String) ApplicationInfo.class.getField("sourceDir").get(applicationInfo)).startsWith("/system/app/") ? new String("/system/lib/" + sRuntimePackageName + "/" + str) : ((String) field.get(applicationInfo)).concat("/" + str) : null;
        } catch (Exception e) {
            str2 = null;
        }
        if (str2 == null) {
            return new String("/data/data/" + sRuntimePackageName + "/lib/" + str);
        }
        return str2;
    }

    public static String GetNativeExtensionPath(Context context, String str) {
        String str2;
        try {
            str2 = ApplicationInfo.class.getField("nativeLibraryDir") != null ? ((String) ApplicationInfo.class.getField("sourceDir").get(context.getPackageManager().getApplicationInfo(sRuntimePackageName, 0))).startsWith("/system/app/") ? new String("/system/lib/" + sRuntimePackageName + "/" + str) : new String("/data/data/" + context.getPackageName() + "/lib/" + str) : null;
        } catch (Exception e) {
            str2 = null;
        }
        if (str2 == null) {
            return new String("/data/data/" + sRuntimePackageName + "/lib/" + str);
        }
        return str2;
    }

    public static String GetTelemetrySettings(Context context, String str, String str2) {
        ByteArrayOutputStream byteArrayOutputStream;
        Object obj;
        Object obj2;
        String string;
        Throwable th;
        Throwable th2;
        InputStream inputStream = null;
        InputStream open;
        try {
            open = context.getResources().getAssets().open(str, 1);
            try {
                byteArrayOutputStream = new ByteArrayOutputStream();
            } catch (Exception e) {
                obj = inputStream;
                if (open != null) {
                    try {
                        open.close();
                    } catch (Exception e2) {
                        obj2 = inputStream;
                    }
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
                obj2 = inputStream;
                if (string == null) {
                    try {
                        string = context.createPackageContext(str2, 0).getSharedPreferences("telemetry", 1).getString("content", "");
                    } catch (Exception e3) {
                    }
                }
                return string;
            } catch (Throwable th3) {
                th = th3;
                obj = inputStream;
                inputStream = open;
                th2 = th;
                if (inputStream != null) {
                    try {
                        inputStream.close();
                    } catch (Exception e4) {
                        throw th2;
                    }
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
                throw th2;
            }
            try {
                copyTo(open, (OutputStream) byteArrayOutputStream);
                String byteArrayOutputStream2 = byteArrayOutputStream.toString();
                if (open != null) {
                    try {
                        open.close();
                    } catch (Exception e5) {
                        string = byteArrayOutputStream2;
                    }
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
                string = byteArrayOutputStream2;
            } catch (Exception e6) {
                if (open != null) {
                    open.close();
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
                obj2 = inputStream;
                if (string == null) {
                    string = context.createPackageContext(str2, 0).getSharedPreferences("telemetry", 1).getString("content", "");
                }
                return string;
            } catch (Throwable th4) {
                th = th4;
                inputStream = open;
                th2 = th;
                if (inputStream != null) {
                    inputStream.close();
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
                throw th2;
            }
        } catch (Exception e7) {
            open = inputStream;
            byteArrayOutputStream = inputStream;
            if (open != null) {
                open.close();
            }
            if (byteArrayOutputStream != null) {
                byteArrayOutputStream.close();
            }
            obj2 = inputStream;
            if (string == null) {
                string = context.createPackageContext(str2, 0).getSharedPreferences("telemetry", 1).getString("content", "");
            }
            return string;
        } catch (Throwable th5) {
            th2 = th5;
            byteArrayOutputStream = inputStream;
            if (inputStream != null) {
                inputStream.close();
            }
            if (byteArrayOutputStream != null) {
                byteArrayOutputStream.close();
            }
            throw th2;
        }
        if (string == null) {
            string = context.createPackageContext(str2, 0).getSharedPreferences("telemetry", 1).getString("content", "");
        }
        return string;
    }

    public static boolean isNetworkAvailable(Context context) {
        NetworkInfo activeNetworkInfo = ((ConnectivityManager) context.getSystemService("connectivity")).getActiveNetworkInfo();
        if (activeNetworkInfo == null || !activeNetworkInfo.isConnected()) {
            return false;
        }
        return true;
    }
}
