package com.milkmangames.extensions.android.goviral;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.Cursor;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import java.io.File;
import java.io.FileNotFoundException;

public class AttachedFileProvider extends ContentProvider {
    public static String f324b = "com.milkmangames.AttachedFileProvider";
    public final String f325a = "AttachedFileProvider";

    public int delete(Uri uri, String str, String[] strArr) {
        return 0;
    }

    public String getType(Uri uri) {
        return null;
    }

    public Uri insert(Uri uri, ContentValues contentValues) {
        return null;
    }

    public boolean onCreate() {
        return true;
    }

    public ParcelFileDescriptor openFile(Uri uri, String str) {
        UriMatcher uriMatcher = new UriMatcher(-1);
        uriMatcher.addURI(f324b, "*", 1);
        switch (uriMatcher.match(uri)) {
            case 1:
                return ParcelFileDescriptor.open(new File(getContext().getCacheDir() + File.separator + uri.getLastPathSegment()), 268435456);
            default:
                Log.v("[GVExtension]", "Unsupported uri: '" + uri + "'.");
                throw new FileNotFoundException("Unsupported uri: " + uri.toString());
        }
    }

    public Cursor query(Uri uri, String[] strArr, String str, String[] strArr2, String str2) {
        return null;
    }

    public int update(Uri uri, ContentValues contentValues, String str, String[] strArr) {
        return 0;
    }
}
