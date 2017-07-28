package com.adobe.air.gestures;

import android.content.Context;
import android.os.Build.VERSION;
import android.view.GestureDetector.OnDoubleTapListener;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.ScaleGestureDetector.OnScaleGestureListener;
import android.view.ViewConfiguration;
import com.adobe.air.AIRWindowSurfaceView;
import com.adobe.air.SystemCapabilities;

public class AIRGestureListener implements OnGestureListener, OnDoubleTapListener, OnScaleGestureListener {
    private static final String LOG_TAG = "AIRGestureListener";
    private static final int MAX_TOUCH_POINTS = 2;
    private static final float MM_PER_INCH = 25.4f;
    private static final float _FP_GESTURE_PAN_THRESHOLD_MM = 3.0f;
    private static final float _FP_GESTURE_ROTATION_THRESHOLD_DEGREES = 15.0f;
    private static final float _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM = 10.0f;
    private static final float _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM = 5.0f;
    private static final float _FP_GESTURE_ZOOM_PER_AXIS_THRESHOLD_MM = 3.0f;
    private static final float _FP_GESTURE_ZOOM_THRESHOLD_MM = 8.0f;
    private static final int kGestureAll = 8;
    private static final int kGestureBegin = 2;
    private static final int kGestureEnd = 4;
    private static final int kGesturePan = 1;
    private static final int kGestureRotate = 2;
    private static final int kGestureSwipe = 5;
    private static final int kGestureTwoFingerTap = 3;
    private static final int kGestureUpdate = 1;
    private static final int kGestureZoom = 0;
    private static int screenPPI = 0;
    private boolean mCheckForSwipe = true;
    private int mCouldBeTwoFingerTap = 0;
    private boolean mDidOccurTwoFingerGesture = false;
    private TouchPoint[] mDownTouchPoints;
    private boolean mInPanTransformGesture = false;
    private boolean mInRotateTransformGesture = false;
    private boolean mInZoomTransformGesture = false;
    private boolean mInZoomTransformGestureX = false;
    private boolean mInZoomTransformGestureY = false;
    private float mPreviousAbsoluteRotation = 0.0f;
    private float mPreviousPanLocX = 0.0f;
    private float mPreviousPanLocY = 0.0f;
    private float mPreviousRotateLocX = 0.0f;
    private float mPreviousRotateLocY = 0.0f;
    private float mPreviousZoomLocX = 0.0f;
    private float mPreviousZoomLocY = 0.0f;
    private TouchPoint mPrimaryPointOfTwoFingerTap = null;
    private TouchPoint mSecondaryPointOfTwoFingerTap = null;
    private AIRWindowSurfaceView mSurfaceView;
    private long mTwoFingerTapStartTime = 0;

    private class TouchPoint {
        private int pid;
        private float f318x;
        private float f319y;

        TouchPoint() {
            this.f318x = 0.0f;
            this.f319y = 0.0f;
            this.pid = 0;
        }

        TouchPoint(float f, float f2, int i) {
            this.f318x = f;
            this.f319y = f2;
            this.pid = i;
        }

        private void assign(float f, float f2, int i) {
            this.f318x = f;
            this.f319y = f2;
            this.pid = i;
        }
    }

    private native boolean nativeOnGestureListener(int i, int i2, boolean z, float f, float f2, float f3, float f4, float f5, float f6, float f7, float f8);

    public AIRGestureListener(Context context, AIRWindowSurfaceView aIRWindowSurfaceView) {
        int i = 0;
        this.mSurfaceView = aIRWindowSurfaceView;
        this.mDownTouchPoints = new TouchPoint[2];
        while (i < 2) {
            this.mDownTouchPoints[i] = new TouchPoint();
            i++;
        }
        this.mSecondaryPointOfTwoFingerTap = new TouchPoint();
        screenPPI = SystemCapabilities.GetScreenDPI(context);
    }

    public TouchPoint getDownTouchPoint(int i) {
        if (i < 0 || i >= 2) {
            return null;
        }
        return this.mDownTouchPoints[i];
    }

    public void setDownTouchPoint(float f, float f2, int i) {
        if (i >= 0 && i < 2) {
            this.mDownTouchPoints[i].assign(f, f2, i);
        }
    }

    public void setCouldBeTwoFingerTap(int i) {
        this.mCouldBeTwoFingerTap = i;
        if (i == 0) {
            this.mTwoFingerTapStartTime = System.currentTimeMillis();
            this.mDidOccurTwoFingerGesture = false;
        }
    }

    public int getCouldBeTwoFingerTap() {
        return this.mCouldBeTwoFingerTap;
    }

    public void setSecondaryPointOfTwoFingerTap(float f, float f2, int i) {
        this.mSecondaryPointOfTwoFingerTap = new TouchPoint(f, f2, i);
    }

    public void setPrimaryPointOfTwoFingerTap(float f, float f2, int i) {
        this.mPrimaryPointOfTwoFingerTap = new TouchPoint(f, f2, i);
    }

    public void mayStartNewTransformGesture() {
        this.mInRotateTransformGesture = false;
        this.mInZoomTransformGesture = false;
        this.mInZoomTransformGestureX = false;
        this.mInZoomTransformGestureY = false;
        this.mInPanTransformGesture = false;
    }

    public boolean getCheckForSwipe() {
        return this.mCheckForSwipe;
    }

    public void setCheckForSwipe(boolean z) {
        this.mCheckForSwipe = z;
    }

    public boolean endTwoFingerGesture() {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode == 2) {
            long currentTimeMillis = System.currentTimeMillis();
            if (!this.mDidOccurTwoFingerGesture && this.mCouldBeTwoFingerTap == 3 && currentTimeMillis - this.mTwoFingerTapStartTime < ((long) ViewConfiguration.getTapTimeout())) {
                onTwoFingerTap();
            }
            endRotateGesture();
            endPanGesture();
        }
        return true;
    }

    private void endRotateGesture() {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode == 2 && this.mInRotateTransformGesture) {
            nativeOnGestureListener(4, 2, true, this.mPreviousRotateLocX, this.mPreviousRotateLocY, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f);
            this.mInRotateTransformGesture = false;
        }
    }

    private void endZoomGesture() {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode == 2 && this.mInZoomTransformGesture) {
            nativeOnGestureListener(4, 0, true, this.mPreviousZoomLocX, this.mPreviousZoomLocY, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f);
            this.mInZoomTransformGesture = false;
            this.mInZoomTransformGestureX = false;
            this.mInZoomTransformGestureY = false;
        }
    }

    private void endPanGesture() {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode == 2 && this.mInPanTransformGesture) {
            nativeOnGestureListener(4, 1, true, this.mPreviousPanLocX, this.mPreviousPanLocY, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f);
            this.mInPanTransformGesture = false;
        }
    }

    public boolean onDown(MotionEvent motionEvent) {
        return true;
    }

    public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        return true;
    }

    public void onLongPress(MotionEvent motionEvent) {
    }

    public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode != 2) {
            return true;
        }
        float f3 = 0.0f;
        float f4 = 0.0f;
        float f5 = 0.0f;
        float x;
        float y;
        float rotation;
        if (motionEvent2.getPointerCount() == 2) {
            int i = 1;
            x = (motionEvent2.getX(0) + motionEvent2.getX(1)) / 2.0f;
            y = (motionEvent2.getY(0) + motionEvent2.getY(1)) / 2.0f;
            TouchPoint[] touchPointArr = new TouchPoint[2];
            for (multitouchMode = 0; multitouchMode < 2; multitouchMode++) {
                touchPointArr[multitouchMode] = new TouchPoint(motionEvent2.getX(multitouchMode), motionEvent2.getY(multitouchMode), motionEvent2.getPointerId(multitouchMode));
            }
            int access$100 = touchPointArr[0].pid;
            int access$1002 = touchPointArr[1].pid;
            if (access$100 >= 0 && access$100 < 2 && access$1002 >= 0 && access$1002 < 2) {
                if (!this.mInPanTransformGesture) {
                    rotation = getRotation(this.mDownTouchPoints[access$100], this.mDownTouchPoints[access$1002], touchPointArr[0], touchPointArr[1]);
                    if (Math.abs(rotation) > 180.0f) {
                        if (rotation > 0.0f) {
                            rotation = (360.0f - rotation) * -1.0f;
                        } else {
                            rotation += 360.0f;
                        }
                    }
                    if (this.mInRotateTransformGesture || Math.abs(rotation) > _FP_GESTURE_ROTATION_THRESHOLD_DEGREES) {
                        if (!this.mInRotateTransformGesture) {
                            i = 2;
                            this.mInRotateTransformGesture = true;
                            this.mPreviousAbsoluteRotation = 0.0f;
                            this.mDidOccurTwoFingerGesture = true;
                        }
                        f3 = rotation - this.mPreviousAbsoluteRotation;
                        if (Math.abs(f3) > 180.0f) {
                            float f6;
                            if (f3 > 0.0f) {
                                f6 = (360.0f - f3) * -1.0f;
                            } else {
                                f6 = 360.0f + f3;
                            }
                            f3 = f6;
                        }
                        this.mPreviousAbsoluteRotation = rotation;
                        this.mPreviousRotateLocX = x;
                        this.mPreviousRotateLocY = y;
                        nativeOnGestureListener(i, 2, true, x, y, 1.0f, 1.0f, f3, 0.0f, 0.0f, 0.0f);
                        f3 = 0.0f;
                    }
                }
                if (!(this.mInZoomTransformGesture || this.mInRotateTransformGesture)) {
                    if (isPanGesture(this.mDownTouchPoints[access$100], this.mDownTouchPoints[access$1002], touchPointArr[0], touchPointArr[1])) {
                        if (!this.mInPanTransformGesture) {
                            i = 2;
                            this.mInPanTransformGesture = true;
                            this.mDidOccurTwoFingerGesture = true;
                        }
                        f4 = -1.0f * f;
                        f5 = -1.0f * f2;
                        this.mPreviousPanLocX = x;
                        this.mPreviousPanLocY = y;
                        nativeOnGestureListener(i, 1, true, x, y, 1.0f, 1.0f, f3, f4, f5, 0.0f);
                    } else if (this.mInPanTransformGesture) {
                        endPanGesture();
                        setDownTouchPoint(touchPointArr[0].f318x, touchPointArr[0].f319y, touchPointArr[0].pid);
                        setDownTouchPoint(touchPointArr[1].f318x, touchPointArr[1].f319y, touchPointArr[1].pid);
                    }
                }
            }
        } else if (motionEvent2.getPointerCount() == 1) {
            multitouchMode = motionEvent2.getPointerId(0);
            if (multitouchMode >= 0 && multitouchMode < 2 && this.mCheckForSwipe && motionEvent.getPointerCount() == 1) {
                Object obj;
                float f7 = 0.0f;
                float x2 = motionEvent2.getX(0) - this.mDownTouchPoints[multitouchMode].f318x;
                rotation = motionEvent2.getY(0) - this.mDownTouchPoints[multitouchMode].f319y;
                if ((Math.abs(x2) * MM_PER_INCH) / ((float) screenPPI) >= _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM && (Math.abs(rotation) * MM_PER_INCH) / ((float) screenPPI) <= _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM) {
                    f5 = 0.0f;
                    f7 = ((motionEvent2.getX(0) - motionEvent.getX(0)) / ((float) (motionEvent2.getEventTime() - motionEvent.getEventTime()))) * 1000.0f;
                    f4 = x2 > 0.0f ? 1.0f : -1.0f;
                    obj = 1;
                } else if ((Math.abs(rotation) * MM_PER_INCH) / ((float) screenPPI) < _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM || (Math.abs(x2) * MM_PER_INCH) / ((float) screenPPI) > _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM) {
                    obj = null;
                } else {
                    f4 = 0.0f;
                    f7 = ((motionEvent2.getY(0) - motionEvent.getY(0)) / ((float) (motionEvent2.getEventTime() - motionEvent.getEventTime()))) * 1000.0f;
                    f5 = rotation > 0.0f ? 1.0f : -1.0f;
                    multitouchMode = 1;
                }
                if (obj != null) {
                    x = motionEvent.getX(0);
                    y = motionEvent2.getY(0);
                    if (f7 < 0.0f) {
                        f7 *= -1.0f;
                    }
                    nativeOnGestureListener(8, 5, true, x, y, 1.0f, 1.0f, 0.0f, f4, f5, f7);
                    this.mCheckForSwipe = false;
                }
            }
        }
        return true;
    }

    public void onShowPress(MotionEvent motionEvent) {
    }

    public boolean onTwoFingerTap() {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode != 2) {
            return true;
        }
        boolean z = nativeOnGestureListener(8, 3, false, (this.mSecondaryPointOfTwoFingerTap.f318x + this.mPrimaryPointOfTwoFingerTap.f318x) / 2.0f, (this.mSecondaryPointOfTwoFingerTap.f319y + this.mPrimaryPointOfTwoFingerTap.f319y) / 2.0f, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f);
        this.mCouldBeTwoFingerTap = 0;
        return z;
    }

    public boolean onSingleTapConfirmed(MotionEvent motionEvent) {
        return true;
    }

    public boolean onSingleTapUp(MotionEvent motionEvent) {
        return true;
    }

    public boolean onDoubleTap(MotionEvent motionEvent) {
        if (motionEvent.getPointerCount() != 1 || this.mSurfaceView.nativeOnDoubleClickListener(motionEvent.getX(0), motionEvent.getY(0))) {
            return true;
        }
        return false;
    }

    public boolean onDoubleTapEvent(MotionEvent motionEvent) {
        return true;
    }

    public boolean onScaleBegin(ScaleGestureDetector scaleGestureDetector) {
        if (this.mInZoomTransformGesture) {
            endZoomGesture();
        }
        return true;
    }

    public boolean onScale(ScaleGestureDetector scaleGestureDetector) {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode != 2) {
            return true;
        }
        int i = 1;
        float focusX = scaleGestureDetector.getFocusX();
        float focusY = scaleGestureDetector.getFocusY();
        float f = 1.0f;
        float f2 = 1.0f;
        double previousSpan = (double) scaleGestureDetector.getPreviousSpan();
        double abs = Math.abs(((double) scaleGestureDetector.getCurrentSpan()) - previousSpan);
        double d = 0.0d;
        double d2 = 0.0d;
        if (VERSION.SDK_INT >= 11) {
            d = (double) Math.abs(scaleGestureDetector.getCurrentSpanX() - scaleGestureDetector.getPreviousSpanX());
            d2 = (double) Math.abs(scaleGestureDetector.getCurrentSpanY() - scaleGestureDetector.getPreviousSpanY());
        }
        if (previousSpan == 0.0d) {
            return false;
        }
        if (!this.mInZoomTransformGesture && (25.399999618530273d * abs) / ((double) screenPPI) <= 8.0d) {
            return false;
        }
        float f3;
        if (!this.mInZoomTransformGesture) {
            this.mInZoomTransformGesture = true;
            i = 2;
            this.mDidOccurTwoFingerGesture = true;
        }
        if (VERSION.SDK_INT >= 11) {
            if (!(scaleGestureDetector.getPreviousSpanX() == 0.0f || scaleGestureDetector.getCurrentSpanX() == 0.0f || (!this.mInZoomTransformGestureX && (r16 * 25.399999618530273d) / ((double) screenPPI) <= 3.0d))) {
                f = Math.abs(scaleGestureDetector.getCurrentSpanX() / scaleGestureDetector.getPreviousSpanX());
                this.mInZoomTransformGestureX = true;
            }
            if (scaleGestureDetector.getPreviousSpanY() == 0.0f || scaleGestureDetector.getCurrentSpanY() == 0.0f || (!this.mInZoomTransformGestureY && (r14 * 25.399999618530273d) / ((double) screenPPI) <= 3.0d)) {
                f3 = f;
            } else {
                f2 = Math.abs(scaleGestureDetector.getCurrentSpanY() / scaleGestureDetector.getPreviousSpanY());
                this.mInZoomTransformGestureY = true;
                f3 = f;
            }
        } else {
            f2 = scaleGestureDetector.getScaleFactor();
            f3 = f2;
        }
        this.mPreviousZoomLocX = focusX;
        this.mPreviousZoomLocY = focusY;
        nativeOnGestureListener(i, 0, true, focusX, focusY, f3, f2, 0.0f, 0.0f, 0.0f, 0.0f);
        return true;
    }

    public void onScaleEnd(ScaleGestureDetector scaleGestureDetector) {
        int multitouchMode = this.mSurfaceView.getMultitouchMode();
        this.mSurfaceView.getClass();
        if (multitouchMode == 2 && this.mInZoomTransformGesture) {
            float scaleFactor = scaleGestureDetector.getScaleFactor();
            nativeOnGestureListener(4, 0, true, this.mPreviousZoomLocX, this.mPreviousZoomLocY, scaleFactor, scaleFactor, 0.0f, 0.0f, 0.0f, 0.0f);
        }
    }

    private float getRotation(TouchPoint touchPoint, TouchPoint touchPoint2, TouchPoint touchPoint3, TouchPoint touchPoint4) {
        if (touchPoint.pid != touchPoint3.pid || touchPoint2.pid != touchPoint4.pid) {
            return 0.0f;
        }
        return (float) (((Math.atan2((double) (touchPoint4.f319y - touchPoint3.f319y), (double) (touchPoint4.f318x - touchPoint3.f318x)) * 180.0d) / 3.141592653589793d) - ((Math.atan2((double) (touchPoint2.f319y - touchPoint.f319y), (double) (touchPoint2.f318x - touchPoint.f318x)) * 180.0d) / 3.141592653589793d));
    }

    private boolean isPanGesture(TouchPoint touchPoint, TouchPoint touchPoint2, TouchPoint touchPoint3, TouchPoint touchPoint4) {
        float access$200 = touchPoint3.f318x - touchPoint.f318x;
        float access$300 = touchPoint3.f319y - touchPoint.f319y;
        float access$2002 = touchPoint4.f318x - touchPoint2.f318x;
        float access$3002 = touchPoint4.f319y - touchPoint2.f319y;
        float min = Math.min(Math.abs(access$200), Math.abs(access$2002));
        float min2 = Math.min(Math.abs(access$300), Math.abs(access$3002));
        double sqrt = Math.sqrt((double) ((min * min) + (min2 * min2)));
        if (((access$200 < 0.0f || access$2002 < 0.0f) && (access$200 > 0.0f || access$2002 > 0.0f)) || (((access$300 < 0.0f || access$3002 < 0.0f) && (access$300 > 0.0f || access$3002 > 0.0f)) || (!this.mInPanTransformGesture && sqrt <= ((double) ((3.0f * ((float) screenPPI)) / MM_PER_INCH))))) {
            return false;
        }
        return true;
    }

    private double distanceBetweenPoints(TouchPoint touchPoint, TouchPoint touchPoint2) {
        return Math.sqrt(Math.pow((double) (touchPoint2.f318x - touchPoint.f318x), 2.0d) + Math.pow((double) (touchPoint2.f319y - touchPoint.f319y), 2.0d));
    }
}
