package com.adobe.flashruntime.shared;

import android.content.Context;
import android.os.Build.VERSION;
import android.util.Log;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceView;
import android.view.ViewGroup.LayoutParams;

public class VideoView extends SurfaceView {
    private static final String TAG = "VideoSurfaceView";
    private boolean mAmCreated = false;
    private long mCPPInstance;
    private Context mContext;
    private boolean mPlanePositionSet = false;
    private Surface mSurface = null;
    private int mXmax = 16;
    private int mXmin = 0;
    private int mYmax = 16;
    private int mYmin = 0;

    class C01671 implements Callback {
        C01671() {
        }

        public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
            Log.v(VideoView.TAG, "surfaceChanged format=" + i + ", width=" + i2 + ", height=" + i3);
            if (!VideoView.this.useOverlay() || !VideoView.this.mPlanePositionSet) {
                return;
            }
            if (i2 != VideoView.this.mXmax - VideoView.this.mXmin || i3 != VideoView.this.mYmax - VideoView.this.mYmin) {
                VideoView.this.setPlanePosition(VideoView.this.mXmin, VideoView.this.mYmin, VideoView.this.mXmax, VideoView.this.mYmax);
            }
        }

        public void surfaceCreated(SurfaceHolder surfaceHolder) {
            Log.v(VideoView.TAG, "surfaceCreated");
            VideoView.this.mSurface = surfaceHolder.getSurface();
            VideoView.this.mAmCreated = true;
            VideoView.this.notifyNativeReadyForVideo();
        }

        public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
            Log.v(VideoView.TAG, "surfaceDestroyed");
            VideoView.this.mSurface.release();
            VideoView.this.mAmCreated = false;
            VideoView.this.notifyNativeReadyForVideo();
        }
    }

    class C01682 implements Runnable {
        C01682() {
        }

        public void run() {
            VideoView.this.layout(VideoView.this.mXmin, VideoView.this.mYmin, VideoView.this.mXmax, VideoView.this.mYmax);
        }
    }

    private native void nativeSetJavaViewReady(long j, boolean z);

    public VideoView(Context context) {
        super(context);
        this.mContext = context;
        setLayoutParams(new LayoutParams(-2, -2));
        if (useOverlay()) {
            getHolder().setFormat(842094169);
        }
        getHolder().addCallback(new C01671());
    }

    public void VideoPlaybackRestarted() {
    }

    void setNativeInstance(long j) {
    }

    public void setFPInstance(long j) {
        Log.d(TAG, "Changing FP Instance from " + this.mCPPInstance + " to " + j);
        this.mCPPInstance = j;
        notifyNativeReadyForVideo();
    }

    public long getFPInstance() {
        return this.mCPPInstance;
    }

    public void setPlanePosition(int i, int i2, int i3, int i4) {
        this.mXmin = i;
        this.mYmin = i2;
        this.mXmax = i3;
        this.mYmax = i4;
        this.mPlanePositionSet = true;
        getHandler().post(new C01682());
    }

    protected boolean useOverlay() {
        if (VERSION.SDK_INT >= 14) {
            return true;
        }
        return false;
    }

    public Surface getSurface() {
        if (this.mAmCreated && useOverlay()) {
            return this.mSurface;
        }
        return null;
    }

    public void notifyNativeReadyForVideo() {
        if (this.mCPPInstance != 0) {
            nativeSetJavaViewReady(this.mCPPInstance, this.mAmCreated);
        }
    }
}
