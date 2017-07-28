package com.adobe.air;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.SurfaceHolder;

/* compiled from: AIRWindowThreadedSurfaceView */
class DrawThread extends Thread {
    private Handler mHandler = null;
    private Looper mLooper = null;
    private boolean mRun = false;
    private AIRWindowThreadedSurfaceView mView = null;

    /* compiled from: AIRWindowThreadedSurfaceView */
    class C01131 extends Handler {
        C01131() {
        }

        public void handleMessage(Message message) {
            if (message.what == DrawRequest.messageID) {
                DrawThread.this.draw((DrawRequest) message.obj);
                DrawThread.this.mView.drawSemaphore.release();
            }
        }
    }

    public DrawThread(AIRWindowThreadedSurfaceView aIRWindowThreadedSurfaceView, SurfaceHolder surfaceHolder, Context context) {
        this.mView = aIRWindowThreadedSurfaceView;
    }

    public void run() {
        Looper.prepare();
        this.mHandler = new C01131();
        this.mLooper = Looper.myLooper();
        Looper.loop();
    }

    public void requestDraw(int i, int i2, int i3, int i4, Bitmap bitmap) {
        Message message = new Message();
        message.what = DrawRequest.messageID;
        message.obj = new DrawRequest(i, i2, i3, i4, bitmap);
        this.mHandler.sendMessage(message);
    }

    public void requestDraw(int i, int i2, int i3, int i4, Bitmap bitmap, int i5, int i6, int i7, int i8, boolean z, int i9) {
        Message message = new Message();
        message.what = DrawRequest.messageID;
        message.obj = new DrawRequest(i, i2, i3, i4, bitmap, i5, i6, i7, i8, z, i9);
        this.mHandler.sendMessage(message);
    }

    public void setRunning(boolean z) {
        this.mRun = z;
        if (!this.mRun) {
            this.mLooper.quit();
        }
    }

    private void draw(DrawRequest drawRequest) {
        if (drawRequest.scale) {
            this.mView.drawScaled(drawRequest.f304x, drawRequest.f305y, drawRequest.wd, drawRequest.ht, drawRequest.bm, drawRequest.dstX, drawRequest.dstY, drawRequest.dstWd, drawRequest.dstHt, drawRequest.fullsc, drawRequest.bgColor);
        } else {
            this.mView.draw(drawRequest.f304x, drawRequest.f305y, drawRequest.wd, drawRequest.ht, drawRequest.bm);
        }
    }
}
