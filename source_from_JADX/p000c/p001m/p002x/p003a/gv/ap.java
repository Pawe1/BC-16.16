package p000c.p001m.p002x.p003a.gv;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.View;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;

public abstract class ap {
    private static int f61b = 1048576;
    private Matrix f62a;

    public static View m56a(Context context, Parcelable parcelable) {
        View view;
        if (parcelable instanceof Bundle) {
            Bundle bundle = (Bundle) parcelable;
            Bitmap bitmap = (Bitmap) bundle.getParcelable("sharedElement:snapshot:bitmap");
            if (bitmap == null) {
                return null;
            }
            View imageView = new ImageView(context);
            imageView.setImageBitmap(bitmap);
            imageView.setScaleType(ScaleType.valueOf(bundle.getString("sharedElement:snapshot:imageScaleType")));
            if (imageView.getScaleType() == ScaleType.MATRIX) {
                float[] floatArray = bundle.getFloatArray("sharedElement:snapshot:imageMatrix");
                Matrix matrix = new Matrix();
                matrix.setValues(floatArray);
                imageView.setImageMatrix(matrix);
            }
            view = imageView;
        } else if (parcelable instanceof Bitmap) {
            Bitmap bitmap2 = (Bitmap) parcelable;
            view = new ImageView(context);
            view.setImageBitmap(bitmap2);
        } else {
            view = null;
        }
        return view;
    }

    public static void m57a() {
    }

    public static void m58b() {
    }

    public static void m59c() {
    }

    public static void m60d() {
    }

    public final Parcelable m61a(View view, Matrix matrix, RectF rectF) {
        int intrinsicWidth;
        if (view instanceof ImageView) {
            ImageView imageView = (ImageView) view;
            Drawable drawable = imageView.getDrawable();
            Drawable background = imageView.getBackground();
            if (drawable != null && background == null) {
                Parcelable parcelable;
                intrinsicWidth = drawable.getIntrinsicWidth();
                int intrinsicHeight = drawable.getIntrinsicHeight();
                if (intrinsicWidth <= 0 || intrinsicHeight <= 0) {
                    parcelable = null;
                } else {
                    float min = Math.min(1.0f, ((float) f61b) / ((float) (intrinsicWidth * intrinsicHeight)));
                    if ((drawable instanceof BitmapDrawable) && min == 1.0f) {
                        Object bitmap = ((BitmapDrawable) drawable).getBitmap();
                    } else {
                        int i = (int) (((float) intrinsicWidth) * min);
                        intrinsicHeight = (int) (((float) intrinsicHeight) * min);
                        parcelable = Bitmap.createBitmap(i, intrinsicHeight, Config.ARGB_8888);
                        Canvas canvas = new Canvas(parcelable);
                        Rect bounds = drawable.getBounds();
                        int i2 = bounds.left;
                        int i3 = bounds.top;
                        int i4 = bounds.right;
                        int i5 = bounds.bottom;
                        drawable.setBounds(0, 0, i, intrinsicHeight);
                        drawable.draw(canvas);
                        drawable.setBounds(i2, i3, i4, i5);
                    }
                }
                if (parcelable != null) {
                    Bundle bundle = new Bundle();
                    bundle.putParcelable("sharedElement:snapshot:bitmap", parcelable);
                    bundle.putString("sharedElement:snapshot:imageScaleType", imageView.getScaleType().toString());
                    if (imageView.getScaleType() == ScaleType.MATRIX) {
                        float[] fArr = new float[9];
                        imageView.getImageMatrix().getValues(fArr);
                        bundle.putFloatArray("sharedElement:snapshot:imageMatrix", fArr);
                    }
                    return bundle;
                }
            }
        }
        int round = Math.round(rectF.width());
        intrinsicWidth = Math.round(rectF.height());
        if (round <= 0 || intrinsicWidth <= 0) {
            return null;
        }
        float min2 = Math.min(1.0f, ((float) f61b) / ((float) (round * intrinsicWidth)));
        round = (int) (((float) round) * min2);
        intrinsicWidth = (int) (((float) intrinsicWidth) * min2);
        if (this.f62a == null) {
            this.f62a = new Matrix();
        }
        this.f62a.set(matrix);
        this.f62a.postTranslate(-rectF.left, -rectF.top);
        this.f62a.postScale(min2, min2);
        Parcelable createBitmap = Bitmap.createBitmap(round, intrinsicWidth, Config.ARGB_8888);
        Canvas canvas2 = new Canvas(createBitmap);
        canvas2.concat(this.f62a);
        view.draw(canvas2);
        return createBitmap;
    }
}
