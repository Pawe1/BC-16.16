package com.adobe.air;

import android.app.Activity;
import android.app.Application;
import android.content.ActivityNotFoundException;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Matrix;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.provider.MediaStore.Images.Media;
import android.provider.MediaStore.Images.Thumbnails;
import java.io.OutputStream;
import java.util.Date;

public class AndroidMediaManager {
    public static final int ERROR_ACTIVITY_DESTROYED = 2;
    public static final int ERROR_IMAGE_PICKER_NOT_FOUND = 1;
    private static long MediaManagerObjectPointer = 0;
    private static final String PHONE_STORAGE = "phoneStorage";
    private ActivityResultCallback mActivityResultCB = null;
    private boolean mCallbacksRegistered = false;

    class C01091 implements ActivityResultCallback {
        C01091() {
        }

        public void onActivityResult(int i, int i2, Intent intent) {
            if (i == 2 && AndroidMediaManager.MediaManagerObjectPointer != 0 && AndroidMediaManager.this.mCallbacksRegistered) {
                AndroidMediaManager.this.onBrowseImageResult(i2, intent, AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity());
                AndroidMediaManager.this.unregisterCallbacks();
            }
        }
    }

    public native void useImagePickerData(long j, boolean z, boolean z2, String str, String str2, String str3);

    public native void useStreamData(long j, boolean z, boolean z2, String str);

    public AndroidMediaManager() {
        MediaManagerObjectPointer = 0;
    }

    public void registerCallbacks() {
        doCallbackRegistration(true);
    }

    public void unregisterCallbacks() {
        doCallbackRegistration(false);
    }

    private void doCallbackRegistration(boolean z) {
        this.mCallbacksRegistered = z;
        if (z) {
            if (this.mActivityResultCB == null) {
                this.mActivityResultCB = new C01091();
            }
            AndroidActivityWrapper.GetAndroidActivityWrapper().addActivityResultListener(this.mActivityResultCB);
        } else if (this.mActivityResultCB != null) {
            AndroidActivityWrapper.GetAndroidActivityWrapper().removeActivityResultListener(this.mActivityResultCB);
            this.mActivityResultCB = null;
        }
    }

    public static boolean AddImage(Application application, Bitmap bitmap, boolean z) {
        String str = null;
        if (application != null) {
            String SaveImage;
            ContentResolver contentResolver = application.getContentResolver();
            try {
                str = Media.insertImage(contentResolver, bitmap, null, null);
            } catch (Exception e) {
            }
            if (str == null) {
                SaveImage = SaveImage(PHONE_STORAGE, contentResolver, bitmap, z);
            } else {
                SaveImage = str;
            }
            if (SaveImage != null) {
                try {
                    Cursor query = contentResolver.query(Uri.parse(SaveImage), new String[]{"_data"}, null, null, null);
                    if (query != null) {
                        int columnIndexOrThrow = query.getColumnIndexOrThrow("_data");
                        query.moveToFirst();
                        MediaScannerConnection.scanFile(AndroidActivityWrapper.GetAndroidActivityWrapper().getDefaultContext(), new String[]{query.getString(columnIndexOrThrow)}, null, null);
                    }
                } catch (Exception e2) {
                }
                return true;
            }
        }
        return false;
    }

    private static String SaveImage(String str, ContentResolver contentResolver, Bitmap bitmap, boolean z) {
        Uri insert;
        try {
            ContentValues contentValues = new ContentValues();
            if (z) {
                contentValues.put("mime_type", "image/jpeg");
            } else {
                contentValues.put("mime_type", "image/png");
            }
            Date date = new Date();
            contentValues.put("datetaken", Long.valueOf(date.getTime()));
            contentValues.put("date_added", Long.valueOf(date.getTime() / 1000));
            insert = contentResolver.insert(Media.getContentUri(str), contentValues);
            if (insert != null) {
                try {
                    OutputStream openOutputStream = contentResolver.openOutputStream(insert);
                    try {
                        bitmap.compress(CompressFormat.JPEG, 90, openOutputStream);
                        long parseId = ContentUris.parseId(insert);
                        SaveThumbnail(str, contentResolver, SaveThumbnail(str, contentResolver, bitmap, parseId, 320.0f, 240.0f, 1), parseId, 50.0f, 50.0f, 3);
                    } catch (Exception e) {
                        if (insert != null) {
                            contentResolver.delete(insert, null, null);
                            insert = null;
                        }
                    } finally {
                        openOutputStream.close();
                    }
                } catch (Exception e2) {
                }
            }
        } catch (Exception e3) {
            insert = null;
            if (insert != null) {
                contentResolver.delete(insert, null, null);
                insert = null;
            }
            if (insert == null) {
                return null;
            }
            return insert.toString();
        }
        if (insert == null) {
            return insert.toString();
        }
        return null;
    }

    private static final Bitmap SaveThumbnail(String str, ContentResolver contentResolver, Bitmap bitmap, long j, float f, float f2, int i) {
        if (bitmap == null) {
            return null;
        }
        Matrix matrix = new Matrix();
        try {
            Uri insert;
            matrix.setScale(f / ((float) bitmap.getWidth()), f2 / ((float) bitmap.getHeight()));
            Bitmap createBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
            ContentValues contentValues = new ContentValues(4);
            contentValues.put("kind", Integer.valueOf(i));
            contentValues.put("image_id", Integer.valueOf((int) j));
            contentValues.put("height", Integer.valueOf(createBitmap.getHeight()));
            contentValues.put("width", Integer.valueOf(createBitmap.getWidth()));
            try {
                insert = contentResolver.insert(Thumbnails.getContentUri(str), contentValues);
                if (insert != null) {
                    try {
                        OutputStream openOutputStream = contentResolver.openOutputStream(insert);
                        createBitmap.compress(CompressFormat.JPEG, 100, openOutputStream);
                        openOutputStream.close();
                    } catch (Exception e) {
                        if (insert != null) {
                            contentResolver.delete(insert, null, null);
                            insert = null;
                        }
                        if (insert == null) {
                            return null;
                        }
                        return createBitmap;
                    }
                }
            } catch (Exception e2) {
                insert = null;
                if (insert != null) {
                    contentResolver.delete(insert, null, null);
                    insert = null;
                }
                if (insert == null) {
                    return createBitmap;
                }
                return null;
            }
            if (insert == null) {
                return null;
            }
            return createBitmap;
        } catch (Exception e3) {
            return null;
        }
    }

    public int BrowseImage(long j) {
        int i = 0;
        try {
            AndroidActivityWrapper GetAndroidActivityWrapper = AndroidActivityWrapper.GetAndroidActivityWrapper();
            Intent intent = new Intent();
            intent.setType("image/*");
            intent.setAction("android.intent.action.PICK");
            if (GetAndroidActivityWrapper.getActivity() != null) {
                GetAndroidActivityWrapper.getActivity().startActivityForResult(Intent.createChooser(intent, ""), 2);
            } else {
                i = 2;
            }
        } catch (ActivityNotFoundException e) {
            i = 1;
        }
        if (i == 0) {
            registerCallbacks();
            MediaManagerObjectPointer = j;
        }
        return i;
    }

    public void onBrowseImageResult(int i, Intent intent, Activity activity) {
        if (i == 0) {
            useImagePickerData(MediaManagerObjectPointer, false, true, "", "", "");
        } else if (i == -1) {
            try {
                Activity activity2 = activity;
                Cursor managedQuery = activity2.managedQuery(intent.getData(), new String[]{"_data", "mime_type", "_display_name"}, null, null, null);
                if (managedQuery == null) {
                    useImagePickerData(MediaManagerObjectPointer, false, false, "", "", "");
                    return;
                }
                int columnIndexOrThrow = managedQuery.getColumnIndexOrThrow("_data");
                int columnIndexOrThrow2 = managedQuery.getColumnIndexOrThrow("_display_name");
                managedQuery.moveToFirst();
                String string = managedQuery.getString(columnIndexOrThrow);
                String str = "image";
                String string2 = managedQuery.getString(columnIndexOrThrow2);
                if (string == null || string.startsWith("http")) {
                    useStreamData(MediaManagerObjectPointer, true, true, intent.getDataString());
                } else {
                    useImagePickerData(MediaManagerObjectPointer, true, true, string, str, string2);
                }
            } catch (IllegalArgumentException e) {
                useImagePickerData(MediaManagerObjectPointer, false, false, "", "", "");
            } catch (Exception e2) {
                useImagePickerData(MediaManagerObjectPointer, false, false, "", "", "");
            }
        }
    }
}
