package com.adobe.air;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore.Images.Media;
import com.facebook.internal.AnalyticsEvents;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class CameraUI implements ActivityResultCallback {
    public static final int ERROR_ACTIVITY_DESTROYED = 4;
    public static final int ERROR_CAMERA_BUSY = 1;
    public static final int ERROR_CAMERA_ERROR = 2;
    public static final int ERROR_CAMERA_UNAVAILABLE = 3;
    private static final String LOG_TAG = "CameraUI";
    private static final String PHONE_STORAGE = "phoneStorage";
    public static final int REQUESTED_MEDIA_TYPE_IMAGE = 1;
    public static final int REQUESTED_MEDIA_TYPE_INVALID = 0;
    public static final int REQUESTED_MEDIA_TYPE_VIDEO = 2;
    private static String sCameraRollPath = null;
    private static CameraUI sCameraUI = null;
    private boolean mCameraBusy = false;
    private String mImagePath = null;
    private long mLastClientId = 0;

    private native void nativeOnCameraCancel(long j);

    private native void nativeOnCameraError(long j, int i);

    private native void nativeOnCameraResult(long j, String str, String str2, String str3);

    private void onCameraError(int i) {
        if (this.mLastClientId != 0) {
            nativeOnCameraError(this.mLastClientId, i);
            this.mLastClientId = 0;
        }
    }

    private void onCameraCancel() {
        if (this.mLastClientId != 0) {
            nativeOnCameraCancel(this.mLastClientId);
            this.mLastClientId = 0;
        }
    }

    private void onCameraResult(String str, String str2, String str3) {
        if (this.mLastClientId != 0) {
            nativeOnCameraResult(this.mLastClientId, str, str2, str3);
            this.mLastClientId = 0;
        }
    }

    private CameraUI() {
    }

    public static synchronized CameraUI getCameraUI() {
        CameraUI cameraUI;
        synchronized (CameraUI.class) {
            if (sCameraUI == null) {
                sCameraUI = new CameraUI();
                AndroidActivityWrapper.GetAndroidActivityWrapper().addActivityResultListener(sCameraUI);
            }
            cameraUI = sCameraUI;
        }
        return cameraUI;
    }

    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    public void unregisterCallbacks(long j) {
        if (this.mLastClientId == j) {
            this.mLastClientId = 0;
        }
    }

    private String toMediaType(String str) {
        if (str == null) {
            return null;
        }
        if (str.startsWith("image/")) {
            return new String("image");
        }
        if (str.startsWith("video/")) {
            return new String(AnalyticsEvents.PARAMETER_SHARE_DIALOG_CONTENT_VIDEO);
        }
        return null;
    }

    private File getFileFromUri(Uri uri, Activity activity) {
        Cursor cursorFromUri = getCursorFromUri(uri, activity, new String[]{"_data"});
        if (cursorFromUri == null) {
            return null;
        }
        File file;
        try {
            file = new File(cursorFromUri.getString(cursorFromUri.getColumnIndexOrThrow("_data")));
            return file;
        } catch (IllegalArgumentException e) {
            file = e;
            return null;
        } finally {
            cursorFromUri.close();
        }
    }

    private Cursor getCursorFromUri(Uri uri, Activity activity, String[] strArr) {
        int i;
        Throwable th;
        Cursor cursor = null;
        int i2 = 1;
        try {
            Cursor query = activity.getContentResolver().query(uri, strArr, null, null, null);
            try {
                if (query.moveToFirst()) {
                    if (query != null) {
                        i = 1;
                    } else {
                        i = 0;
                    }
                    if (query.moveToFirst()) {
                        i2 = 0;
                    }
                    if ((i & i2) != 0) {
                        query.close();
                    }
                    return query;
                }
                query.close();
                if (query != null) {
                    i = 1;
                } else {
                    i = 0;
                }
                if (query.moveToFirst()) {
                    i2 = 0;
                }
                if ((i & i2) != 0) {
                    query.close();
                }
                return null;
            } catch (Throwable th2) {
                cursor = query;
                th = th2;
                if (cursor == null) {
                    i = 0;
                } else {
                    i = 1;
                }
                if (cursor.moveToFirst()) {
                    i2 = 0;
                }
                if ((i & i2) != 0) {
                    cursor.close();
                }
                throw th;
            }
        } catch (Throwable th22) {
            th = th22;
            if (cursor == null) {
                i = 1;
            } else {
                i = 0;
            }
            if (cursor.moveToFirst()) {
                i2 = 0;
            }
            if ((i & i2) != 0) {
                cursor.close();
            }
            throw th;
        }
    }

    private void processImageSuccessResult() {
        String str = new String("image");
        String name = new File(this.mImagePath).getName();
        MediaScannerConnection.scanFile(AndroidActivityWrapper.GetAndroidActivityWrapper().getDefaultContext(), new String[]{this.mImagePath}, null, null);
        onCameraResult(this.mImagePath, str, name);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void processVideoSuccessResult(android.content.Intent r9) {
        /*
        r8 = this;
        r7 = 2;
        r1 = 0;
        r0 = 3;
        r0 = new java.lang.String[r0];
        r2 = 0;
        r3 = "_data";
        r0[r2] = r3;
        r2 = 1;
        r3 = "mime_type";
        r0[r2] = r3;
        r2 = "_display_name";
        r0[r7] = r2;
        r2 = r9.getData();
        r3 = com.adobe.air.AndroidActivityWrapper.GetAndroidActivityWrapper();
        r3 = r3.getActivity();
        r4 = r8.getCursorFromUri(r2, r3, r0);
        if (r4 == 0) goto L_0x009e;
    L_0x0025:
        r0 = "_data";
        r0 = r4.getColumnIndexOrThrow(r0);	 Catch:{ IllegalArgumentException -> 0x0077, all -> 0x007f }
        r2 = "mime_type";
        r2 = r4.getColumnIndexOrThrow(r2);	 Catch:{ IllegalArgumentException -> 0x0077, all -> 0x007f }
        r3 = "_display_name";
        r5 = r4.getColumnIndexOrThrow(r3);	 Catch:{ IllegalArgumentException -> 0x0077, all -> 0x007f }
        r3 = r4.getString(r0);	 Catch:{ IllegalArgumentException -> 0x0077, all -> 0x007f }
        if (r3 == 0) goto L_0x009c;
    L_0x003d:
        r0 = r4.getString(r2);	 Catch:{ IllegalArgumentException -> 0x0088, all -> 0x007f }
        r0 = r8.toMediaType(r0);	 Catch:{ IllegalArgumentException -> 0x0088, all -> 0x007f }
        if (r0 != 0) goto L_0x004f;
    L_0x0047:
        r2 = new java.lang.String;	 Catch:{ IllegalArgumentException -> 0x008c, all -> 0x007f }
        r6 = "video";
        r2.<init>(r6);	 Catch:{ IllegalArgumentException -> 0x008c, all -> 0x007f }
        r0 = r2;
    L_0x004f:
        r2 = r4.getString(r5);	 Catch:{ IllegalArgumentException -> 0x0091, all -> 0x007f }
        if (r2 != 0) goto L_0x009a;
    L_0x0055:
        r1 = new java.lang.String;	 Catch:{ IllegalArgumentException -> 0x0096, all -> 0x007f }
        r5 = "";
        r1.<init>(r5);	 Catch:{ IllegalArgumentException -> 0x0096, all -> 0x007f }
    L_0x005c:
        r4.close();
        r2 = r1;
        r1 = r0;
    L_0x0061:
        if (r1 == 0) goto L_0x006b;
    L_0x0063:
        r0 = "image";
        r0 = r1.equals(r0);
        if (r0 != 0) goto L_0x0073;
    L_0x006b:
        r0 = "video";
        r0 = r1.equals(r0);
        if (r0 == 0) goto L_0x0084;
    L_0x0073:
        r8.onCameraResult(r3, r1, r2);
    L_0x0076:
        return;
    L_0x0077:
        r0 = move-exception;
        r2 = r1;
        r0 = r1;
    L_0x007a:
        r4.close();
        r3 = r0;
        goto L_0x0061;
    L_0x007f:
        r0 = move-exception;
        r4.close();
        throw r0;
    L_0x0084:
        r8.onCameraError(r7);
        goto L_0x0076;
    L_0x0088:
        r0 = move-exception;
        r2 = r1;
        r0 = r3;
        goto L_0x007a;
    L_0x008c:
        r2 = move-exception;
        r2 = r1;
        r1 = r0;
        r0 = r3;
        goto L_0x007a;
    L_0x0091:
        r2 = move-exception;
        r2 = r1;
        r1 = r0;
        r0 = r3;
        goto L_0x007a;
    L_0x0096:
        r1 = move-exception;
        r1 = r0;
        r0 = r3;
        goto L_0x007a;
    L_0x009a:
        r1 = r2;
        goto L_0x005c;
    L_0x009c:
        r0 = r1;
        goto L_0x005c;
    L_0x009e:
        r2 = r1;
        r3 = r1;
        goto L_0x0061;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.CameraUI.processVideoSuccessResult(android.content.Intent):void");
    }

    public void onActivityResult(int i, int i2, Intent intent) {
        if (i == 3 || i == 4) {
            this.mCameraBusy = false;
            if (this.mLastClientId != 0) {
                switch (i2) {
                    case -1:
                        if (i == 3) {
                            if (this.mImagePath != null) {
                                processImageSuccessResult();
                                this.mImagePath = null;
                                return;
                            }
                            onCameraCancel();
                            return;
                        } else if (i == 4) {
                            processVideoSuccessResult(intent);
                            return;
                        } else {
                            return;
                        }
                    case 0:
                        if (this.mImagePath != null) {
                            this.mImagePath = null;
                        }
                        onCameraCancel();
                        return;
                    default:
                        if (this.mImagePath != null) {
                            this.mImagePath = null;
                        }
                        onCameraError(2);
                        return;
                }
            }
        }
    }

    public void launch(long j, int i) {
        if (j != 0) {
            if (this.mCameraBusy) {
                nativeOnCameraError(j, 1);
                return;
            }
            int stillPictureWork;
            if (this.mLastClientId != 0) {
                onCameraError(1);
            }
            this.mLastClientId = j;
            this.mCameraBusy = true;
            switch (i) {
                case 1:
                    stillPictureWork = stillPictureWork();
                    break;
                case 2:
                    stillPictureWork = videoCaptureWork();
                    break;
                default:
                    stillPictureWork = 3;
                    break;
            }
            if (stillPictureWork != 0) {
                this.mCameraBusy = false;
                onCameraError(stillPictureWork);
            }
        }
    }

    private int videoCaptureWork() {
        try {
            Activity activity = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity();
            if (activity == null) {
                return 4;
            }
            Intent intent = new Intent("android.media.action.VIDEO_CAPTURE");
            intent.putExtra("android.intent.extra.videoQuality", 0);
            activity.startActivityForResult(intent, 4);
            return 0;
        } catch (ActivityNotFoundException e) {
            return 3;
        }
    }

    private String getCameraRollDirectory(Activity activity) {
        if (sCameraRollPath != null) {
            return sCameraRollPath;
        }
        Uri insert;
        Uri insert2;
        try {
            insert = activity.getContentResolver().insert(Media.EXTERNAL_CONTENT_URI, new ContentValues());
        } catch (Exception e) {
            insert = null;
        }
        if (insert == null) {
            try {
                insert2 = activity.getContentResolver().insert(Media.getContentUri(PHONE_STORAGE), new ContentValues());
            } catch (Exception e2) {
                insert2 = insert;
            }
        } else {
            insert2 = insert;
        }
        if (insert2 != null) {
            try {
                sCameraRollPath = getFileFromUri(insert2, activity).getParent();
            } catch (ActivityNotFoundException e3) {
            } catch (NullPointerException e4) {
            } finally {
                activity.getContentResolver().delete(insert2, null, null);
            }
        } else {
            File externalStoragePublicDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
            if (externalStoragePublicDirectory.exists()) {
                sCameraRollPath = externalStoragePublicDirectory.toString();
            }
        }
        return sCameraRollPath;
    }

    private int stillPictureWork() {
        Activity activity = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity();
        if (activity == null) {
            return 4;
        }
        if (getCameraRollDirectory(activity) == null) {
            return 2;
        }
        String str = getCameraRollDirectory(activity) + "/" + new SimpleDateFormat("'IMG'_yyyyMMdd_HHmmss").format(new Date(System.currentTimeMillis())) + ".jpg";
        File file = new File(str);
        if (file.exists()) {
            return 2;
        }
        int i;
        try {
            Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
            intent.putExtra("output", Uri.fromFile(file));
            activity.startActivityForResult(intent, 3);
            i = 0;
        } catch (ActivityNotFoundException e) {
            str = null;
            i = 3;
        } catch (NullPointerException e2) {
            str = null;
            i = 2;
        }
        this.mImagePath = str;
        return i;
    }
}
