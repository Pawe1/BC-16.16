package com.adobe.air.wand.view;

import android.content.Context;
import android.graphics.Rect;
import android.os.Build.VERSION;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import com.adobe.air.TouchEventData;

public class CompanionView extends View {
    private static final String LOG_TAG = "CompanionView";
    static final int POST_TOUCH_MESSAGE_AFTER_DELAY = 0;
    public static final int kTouchActionBegin = 2;
    public static final int kTouchActionEnd = 4;
    public static final int kTouchActionMove = 1;
    public static final int kTouchMetaStateIsEraser = 67108864;
    public static final int kTouchMetaStateIsPen = 33554432;
    public static final int kTouchMetaStateMask = 234881024;
    public static final int kTouchMetaStateSideButton1 = 134217728;
    public final int kMultitouchGesture = 2;
    public final int kMultitouchNone = 0;
    public final int kMultitouchRaw = 1;
    private int mBoundHeight = 0;
    private int mBoundWidth = 0;
    private int mCurrentOrientation = 0;
    private GestureDetector mGestureDetector;
    private GestureListener mGestureListener;
    private boolean mIsFullScreen = false;
    private int mMultitouchMode = 2;
    private ScaleGestureDetector mScaleGestureDetector;
    private int mSkipHeightFromTop = 0;
    private TouchSensor mTouchSensor = null;
    private int mVisibleBoundHeight = 0;
    private int mVisibleBoundWidth = 0;

    public CompanionView(Context context) {
        super(context);
        initView(context);
    }

    public CompanionView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        initView(context);
    }

    private void initView(Context context) {
        this.mTouchSensor = new TouchSensor();
        this.mGestureListener = new GestureListener(context, this);
        this.mGestureDetector = new GestureDetector(context, this.mGestureListener, null, false);
        this.mScaleGestureDetector = new ScaleGestureDetector(context, this.mGestureListener);
        setWillNotDraw(false);
        setClickable(true);
        setEnabled(true);
        setFocusable(true);
        setFocusableInTouchMode(true);
    }

    public View returnThis() {
        return this;
    }

    public void onWindowFocusChanged(boolean z) {
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return false;
    }

    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return false;
    }

    protected void onFocusChanged(boolean z, int i, Rect rect) {
        super.onFocusChanged(z, i, rect);
    }

    public boolean onTouchEvent(MotionEvent motionEvent) {
        int i;
        boolean z;
        int action = motionEvent.getAction() & 255;
        if (this.mGestureListener != null) {
            if (action == 5 || action == 0) {
                for (i = 0; i < motionEvent.getPointerCount(); i++) {
                    this.mGestureListener.setDownTouchPoint(motionEvent.getX(i), motionEvent.getY(i), motionEvent.getPointerId(i));
                }
            }
            if (action == 0) {
                this.mGestureListener.mayStartNewTransformGesture();
            }
            if (action == 5) {
                this.mGestureListener.setCouldBeTwoFingerTap(1);
                this.mGestureListener.setPrimaryPointOfTwoFingerTap(motionEvent.getX(0), motionEvent.getY(0), motionEvent.getPointerId(0));
                this.mGestureListener.setSecondaryPointOfTwoFingerTap(motionEvent.getX(1), motionEvent.getY(1), motionEvent.getPointerId(1));
            } else if (action == 6 && this.mGestureListener.getCouldBeTwoFingerTap() == 1) {
                this.mGestureListener.setCouldBeTwoFingerTap(2);
            } else if (action == 1 && this.mGestureListener.getCouldBeTwoFingerTap() == 2) {
                this.mGestureListener.setCouldBeTwoFingerTap(3);
            } else if (action != 2) {
                this.mGestureListener.setCouldBeTwoFingerTap(0);
            }
        }
        int pointerCount = motionEvent.getPointerCount();
        Object obj = null;
        int i2 = 0;
        while (i2 < pointerCount) {
            int toolType;
            int i3;
            Object obj2;
            Object obj3;
            float size;
            boolean z2;
            int historySize;
            float[] fArr;
            float pressure;
            float x = motionEvent.getX(i2);
            float y = ((float) this.mSkipHeightFromTop) + motionEvent.getY(i2);
            int action2 = motionEvent.getAction();
            int pointerId = motionEvent.getPointerId(i2);
            i = motionEvent.getMetaState();
            if (VERSION.SDK_INT >= 14) {
                i &= -234881025;
                toolType = motionEvent.getToolType(i2);
                if (toolType == 4) {
                    i |= kTouchMetaStateIsEraser;
                } else if (toolType == 2) {
                    i |= kTouchMetaStateIsPen;
                }
                if ((motionEvent.getButtonState() & 2) != 0) {
                    i3 = i | kTouchMetaStateSideButton1;
                    if (obj == null) {
                        i = 3;
                        obj2 = obj;
                        action = 4;
                    } else {
                        if (motionEvent.getPointerCount() != 1) {
                            if (pointerId != motionEvent.getPointerId((65280 & action2) >> 8)) {
                                i = action2;
                                obj2 = obj;
                                action = 1;
                            }
                        }
                        action2 &= 255;
                        switch (action2) {
                            case 0:
                            case 5:
                                obj2 = obj;
                                action = 2;
                                i = action2;
                                break;
                            case 1:
                            case 6:
                                obj3 = obj;
                                break;
                            case 3:
                                obj3 = 1;
                                break;
                            default:
                                obj2 = obj;
                                action = 1;
                                i = action2;
                                break;
                        }
                        action = 4;
                        if (this.mGestureListener == null) {
                            this.mGestureListener.endTwoFingerGesture();
                            this.mGestureListener.setCheckForSwipe(true);
                            obj2 = obj3;
                            i = action2;
                        } else {
                            obj2 = obj3;
                            i = action2;
                        }
                    }
                    if (IsTouchEventHandlingAllowed(action, x, y)) {
                        size = motionEvent.getSize(i2);
                        z2 = pointerId != 0;
                        historySize = motionEvent.getHistorySize();
                        fArr = new float[((historySize + 1) * 3)];
                        toolType = 0;
                        for (action2 = 0; action2 < historySize; action2++) {
                            int i4 = toolType + 1;
                            fArr[toolType] = motionEvent.getHistoricalX(i2, action2);
                            int i5 = i4 + 1;
                            fArr[i4] = motionEvent.getHistoricalY(i2, action2);
                            toolType = i5 + 1;
                            fArr[i5] = motionEvent.getHistoricalPressure(i2, action2);
                        }
                        pressure = motionEvent.getPressure(i2);
                        fArr[toolType] = x;
                        fArr[toolType + 1] = y;
                        fArr[toolType + 2] = pressure;
                        historySize = i3 & -2;
                        if (action != 1) {
                            if (i == 3) {
                                historySize |= 1;
                            }
                            this.mTouchSensor.dispatchEvent(new TouchEventData(action, x, y, pressure, pointerId, size, size, z2, null, historySize));
                        }
                        switch (action) {
                            case 1:
                            case 2:
                                action = 1;
                                break;
                            default:
                                action = 0;
                                break;
                        }
                        if (action != 0) {
                            this.mTouchSensor.dispatchEvent(new TouchEventData(action, x, y, pressure, pointerId, size, size, z2, fArr, historySize));
                        }
                    }
                    i2++;
                    obj = obj2;
                }
            }
            i3 = i;
            if (obj == null) {
                if (motionEvent.getPointerCount() != 1) {
                    if (pointerId != motionEvent.getPointerId((65280 & action2) >> 8)) {
                        i = action2;
                        obj2 = obj;
                        action = 1;
                    }
                }
                action2 &= 255;
                switch (action2) {
                    case 0:
                    case 5:
                        obj2 = obj;
                        action = 2;
                        i = action2;
                        break;
                    case 1:
                    case 6:
                        obj3 = obj;
                        break;
                    case 3:
                        obj3 = 1;
                        break;
                    default:
                        obj2 = obj;
                        action = 1;
                        i = action2;
                        break;
                }
                action = 4;
                if (this.mGestureListener == null) {
                    obj2 = obj3;
                    i = action2;
                } else {
                    this.mGestureListener.endTwoFingerGesture();
                    this.mGestureListener.setCheckForSwipe(true);
                    obj2 = obj3;
                    i = action2;
                }
            } else {
                i = 3;
                obj2 = obj;
                action = 4;
            }
            if (IsTouchEventHandlingAllowed(action, x, y)) {
                size = motionEvent.getSize(i2);
                if (pointerId != 0) {
                }
                historySize = motionEvent.getHistorySize();
                fArr = new float[((historySize + 1) * 3)];
                toolType = 0;
                for (action2 = 0; action2 < historySize; action2++) {
                    int i42 = toolType + 1;
                    fArr[toolType] = motionEvent.getHistoricalX(i2, action2);
                    int i52 = i42 + 1;
                    fArr[i42] = motionEvent.getHistoricalY(i2, action2);
                    toolType = i52 + 1;
                    fArr[i52] = motionEvent.getHistoricalPressure(i2, action2);
                }
                pressure = motionEvent.getPressure(i2);
                fArr[toolType] = x;
                fArr[toolType + 1] = y;
                fArr[toolType + 2] = pressure;
                historySize = i3 & -2;
                if (action != 1) {
                    if (i == 3) {
                        historySize |= 1;
                    }
                    this.mTouchSensor.dispatchEvent(new TouchEventData(action, x, y, pressure, pointerId, size, size, z2, null, historySize));
                }
                switch (action) {
                    case 1:
                    case 2:
                        action = 1;
                        break;
                    default:
                        action = 0;
                        break;
                }
                if (action != 0) {
                    this.mTouchSensor.dispatchEvent(new TouchEventData(action, x, y, pressure, pointerId, size, size, z2, fArr, historySize));
                }
            }
            i2++;
            obj = obj2;
        }
        if (this.mScaleGestureDetector != null) {
            try {
                z = this.mScaleGestureDetector.onTouchEvent(motionEvent);
            } catch (Exception e) {
                z = true;
            }
        } else {
            z = true;
        }
        if (this.mGestureDetector != null) {
            return z && this.mGestureDetector.onTouchEvent(motionEvent);
        } else {
            return z;
        }
    }

    public void onGestureListener(int i, int i2, boolean z, float f, float f2, float f3, float f4, float f5, float f6, float f7) {
        this.mTouchSensor.dispatchEvent(new GestureEventData(i, i2, z, f, f2, f3, f4, f5, f6, f7));
    }

    public TouchSensor getTouchSensor() {
        return this.mTouchSensor;
    }

    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
    }

    public void setMultitouchMode(int i) {
        this.mMultitouchMode = i;
    }

    public int getMultitouchMode() {
        return this.mMultitouchMode;
    }

    public boolean getIsFullScreen() {
        return this.mIsFullScreen;
    }

    public int getBoundWidth() {
        return this.mBoundWidth;
    }

    public int getBoundHeight() {
        return this.mBoundHeight;
    }

    public int getVisibleBoundWidth() {
        return this.mVisibleBoundWidth;
    }

    public int getVisibleBoundHeight() {
        return this.mVisibleBoundHeight;
    }

    public boolean IsLandScape() {
        return this.mCurrentOrientation == 2;
    }

    private boolean IsTouchEventHandlingAllowed(int i, float f, float f2) {
        return true;
    }

    public boolean IsTouchUpHandlingAllowed() {
        return true;
    }
}
