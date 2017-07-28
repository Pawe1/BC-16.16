package com.adobe.air;

import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import com.facebook.internal.Utility;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

public final class ApplicationFileManager {
    private static final String APP_PREFIX = "app";
    private static final String APP_XML_PATH = "META-INF/AIR/application.xml";
    private static final String ASSET_STRING = "assets";
    public static String sAndroidPackageName;
    public static String sApkPath;
    public static String sAppDataPath;
    public static String sInitialContentName;
    private final int BUFFER_SIZE = Utility.DEFAULT_STREAM_BUFFER_SIZE;
    private final int DEFAULT_SIZE = -1;
    private HashMap<Object, Object> mFileInfoMap = new HashMap();

    public static void setAndroidPackageName(String str) {
        sAndroidPackageName = str;
    }

    public static void setAndroidAPKPath(String str) {
        sApkPath = str;
    }

    private static void setAndroidDataPath(String str) {
        sAppDataPath = str;
    }

    public static String getAndroidApkPath() {
        return sApkPath;
    }

    public static String getAndroidAppDataPath() {
        return sAppDataPath;
    }

    public static String getAppXMLRoot() {
        return getAndroidUnzipContentPath() + File.separatorChar + APP_XML_PATH;
    }

    public static String getAppRoot() {
        return getAndroidUnzipContentPath() + File.separatorChar + ASSET_STRING;
    }

    public static String getAndroidUnzipContentPath() {
        return sAppDataPath;
    }

    private File getApkPathFile() {
        return new File(getAndroidApkPath());
    }

    private static void setInitialContentName(String str) {
        sInitialContentName = str;
    }

    ApplicationFileManager() {
        procZipContents(getApkPathFile());
    }

    public static boolean deleteUnzippedContents(String str) {
        File file = new File(str);
        if (file.isDirectory()) {
            File[] listFiles = file.listFiles();
            for (File absolutePath : listFiles) {
                deleteUnzippedContents(absolutePath.getAbsolutePath());
            }
        }
        return file.delete();
    }

    public void deleteFile(String str) {
        new File(str).delete();
    }

    public void procZipContents(File file) {
        try {
            ZipFile zipFile = new ZipFile(file);
            Enumeration entries = zipFile.entries();
            while (entries.hasMoreElements()) {
                ZipEntry zipEntry = (ZipEntry) entries.nextElement();
                String name = zipEntry.getName();
                if (name.substring(0, ASSET_STRING.length()).equals(ASSET_STRING)) {
                    this.mFileInfoMap.put(name, new FileInfo(zipEntry.getSize(), true, false));
                    File file2 = new File(name);
                    while (file2.getParent() != null && ((FileInfo) this.mFileInfoMap.get(file2.getParent())) == null) {
                        this.mFileInfoMap.put(file2.getParent(), new FileInfo(-1, false, true));
                        file2 = new File(file2.getParent());
                    }
                }
            }
            zipFile.close();
        } catch (Exception e) {
        }
    }

    public boolean fileExists(String str) {
        return this.mFileInfoMap.containsKey(!str.equals("") ? new StringBuilder().append(ASSET_STRING).append(File.separator).append(str).toString() : ASSET_STRING);
    }

    public boolean isDirectory(String str) {
        FileInfo fileInfo = (FileInfo) this.mFileInfoMap.get(!str.equals("") ? ASSET_STRING + File.separator + str : ASSET_STRING);
        return fileInfo != null && fileInfo.mIsDirectory;
    }

    public long getLSize(String str) {
        FileInfo fileInfo = (FileInfo) this.mFileInfoMap.get(ASSET_STRING + File.separator + str);
        if (fileInfo == null || fileInfo.mFileSize == -1) {
            return 0;
        }
        return fileInfo.mFileSize;
    }

    public boolean addToCache(String str) {
        if (sInitialContentName == null || str.indexOf(sInitialContentName) == -1) {
            return false;
        }
        return true;
    }

    public boolean readFileName(String str) {
        Throwable th;
        String str2 = ASSET_STRING + File.separator + str;
        String str3 = getAndroidUnzipContentPath() + File.separatorChar;
        File file = new File(str3 + str2);
        if (!file.exists()) {
            ZipFile zipFile = null;
            ZipFile zipFile2;
            try {
                zipFile2 = new ZipFile(getApkPathFile());
                try {
                    Enumeration entries = zipFile2.entries();
                    while (entries.hasMoreElements()) {
                        ZipEntry zipEntry = (ZipEntry) entries.nextElement();
                        String name = zipEntry.getName();
                        if (name.substring(0, ASSET_STRING.length()).equals(ASSET_STRING)) {
                            if (name.equals(str2)) {
                                InputStream inputStream = zipFile2.getInputStream(zipEntry);
                                new File(file.getParent()).mkdirs();
                                OutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(file), Utility.DEFAULT_STREAM_BUFFER_SIZE);
                                byte[] bArr = new byte[Utility.DEFAULT_STREAM_BUFFER_SIZE];
                                while (true) {
                                    int read = inputStream.read(bArr);
                                    if (read == -1) {
                                        break;
                                    }
                                    bufferedOutputStream.write(bArr, 0, read);
                                }
                                closeInputStream(inputStream);
                                closeOutputStream(bufferedOutputStream);
                            } else if (name.startsWith(str2 + "/")) {
                                new File(str3 + str2).mkdirs();
                                break;
                            }
                        }
                    }
                    if (zipFile2 != null) {
                        try {
                            zipFile2.close();
                        } catch (Exception e) {
                        }
                    }
                } catch (Exception e2) {
                    zipFile = zipFile2;
                } catch (Throwable th2) {
                    th = th2;
                }
            } catch (Exception e3) {
                if (zipFile != null) {
                    try {
                        zipFile.close();
                    } catch (Exception e4) {
                    }
                }
                return true;
            } catch (Throwable th3) {
                Throwable th4 = th3;
                zipFile2 = null;
                th = th4;
                if (zipFile2 != null) {
                    try {
                        zipFile2.close();
                    } catch (Exception e5) {
                    }
                }
                throw th;
            }
        }
        return true;
    }

    public void copyFolder(String str) {
        String str2 = !str.equals("") ? ASSET_STRING + File.separator + str : ASSET_STRING;
        String str3 = getAndroidUnzipContentPath() + File.separatorChar;
        try {
            InputStream zipInputStream = new ZipInputStream(new BufferedInputStream(new FileInputStream(getApkPathFile()), Utility.DEFAULT_STREAM_BUFFER_SIZE));
            while (true) {
                ZipEntry nextEntry = zipInputStream.getNextEntry();
                if (nextEntry != null) {
                    String name = nextEntry.getName();
                    if (name.substring(0, ASSET_STRING.length()).equals(ASSET_STRING) && name.startsWith(str2)) {
                        File file = new File(str3 + name);
                        new File(file.getParent()).mkdirs();
                        OutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(file), Utility.DEFAULT_STREAM_BUFFER_SIZE);
                        byte[] bArr = new byte[Utility.DEFAULT_STREAM_BUFFER_SIZE];
                        while (true) {
                            int read = zipInputStream.read(bArr, 0, Utility.DEFAULT_STREAM_BUFFER_SIZE);
                            if (read == -1) {
                                break;
                            }
                            bufferedOutputStream.write(bArr, 0, read);
                        }
                        closeOutputStream(bufferedOutputStream);
                    }
                } else {
                    closeInputStream(zipInputStream);
                    return;
                }
            }
        } catch (Exception e) {
        }
    }

    public String[] appDirectoryNameList(String str) {
        String str2 = !str.equals("") ? ASSET_STRING + File.separator + str : ASSET_STRING;
        ArrayList arrayList = new ArrayList();
        for (String str3 : this.mFileInfoMap.keySet()) {
            if (!str3.equals(str2) && str3.startsWith(str2) && -1 == str3.indexOf(File.separator, str2.length() + 1)) {
                arrayList.add(str3.substring(str2.length() + 1));
            }
        }
        return (String[]) arrayList.toArray(new String[0]);
    }

    public boolean[] appDirectoryTypeList(String str) {
        String str2 = !str.equals("") ? ASSET_STRING + File.separator + str : ASSET_STRING;
        ArrayList arrayList = new ArrayList();
        for (String str3 : this.mFileInfoMap.keySet()) {
            if (!str3.equals(str2) && str3.startsWith(str2) && -1 == str3.indexOf(File.separator, str2.length() + 1)) {
                arrayList.add(new Boolean(((FileInfo) this.mFileInfoMap.get(str3)).mIsFile));
            }
        }
        boolean[] zArr = new boolean[arrayList.size()];
        for (int i = 0; i < zArr.length; i++) {
            zArr[i] = ((Boolean) arrayList.get(i)).booleanValue();
        }
        return zArr;
    }

    private static void RefreshAppCache(String str, String str2) {
        if (!new File(str + File.separator + str2).exists()) {
            deleteDir(new File(str));
        }
    }

    public static boolean deleteDir(File file) {
        if (file.isDirectory()) {
            for (File deleteDir : file.listFiles()) {
                if (!deleteDir(deleteDir)) {
                    return false;
                }
            }
        }
        if (file.delete()) {
            return true;
        }
        return false;
    }

    public static void processAndroidDataPath(String str) {
        String str2;
        String str3 = APP_PREFIX;
        String str4 = str + File.separator + APP_PREFIX;
        String str5 = null;
        try {
            Bundle bundle = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity().getPackageManager().getActivityInfo(AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity().getComponentName(), 128).metaData;
            if (bundle != null) {
                str2 = (String) bundle.get("uniqueappversionid");
                try {
                    if (AndroidActivityWrapper.IsGamePreviewMode()) {
                        str3 = UUID.randomUUID().toString();
                    } else {
                        str3 = str2;
                    }
                    RefreshAppCache(str4, str3);
                    str2 = (String) bundle.get("initialcontent");
                    str5 = str3;
                } catch (NameNotFoundException e) {
                } catch (NullPointerException e2) {
                }
            } else {
                str2 = null;
                str5 = str3;
            }
            String str6 = str2;
            str2 = str5;
            str5 = str6;
        } catch (NameNotFoundException e3) {
            str2 = str3;
        } catch (NullPointerException e4) {
            str2 = str3;
        }
        setAndroidDataPath(str4 + File.separator + str2);
        new File(str4 + File.separator + str2).mkdirs();
        setInitialContentName(str5);
    }

    private void closeInputStream(InputStream inputStream) throws Exception {
        inputStream.close();
    }

    private void closeOutputStream(OutputStream outputStream) throws Exception {
        outputStream.flush();
        outputStream.close();
    }

    public static void checkAndCreateAppDataDir() {
        File file = new File(sAppDataPath);
        if (!file.exists()) {
            try {
                file.mkdirs();
            } catch (SecurityException e) {
            }
        }
    }
}
