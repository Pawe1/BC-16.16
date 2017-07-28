package com.adobe.air;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.shapes.RectShape;
import android.graphics.drawable.shapes.Shape;
import android.os.Build.VERSION;
import android.support.v7.appcompat.C0004R;
import android.text.InputFilter;
import android.text.InputFilter.LengthFilter;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextUtils;
import android.text.method.KeyListener;
import android.text.method.PasswordTransformationMethod;
import android.text.method.SingleLineTransformationMethod;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.ActionMode.Callback;
import android.view.ContextMenu;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.TextView.BufferType;
import android.widget.TextView.OnEditorActionListener;
import com.adobe.air.AndroidActivityWrapper.ActivityState;
import com.facebook.internal.Utility;

public class AndroidStageText implements StateChangeCallback {
    private static final int ALIGN_Center = 2;
    private static final int ALIGN_End = 5;
    private static final int ALIGN_Justify = 3;
    private static final int ALIGN_Left = 0;
    private static final int ALIGN_Right = 1;
    private static final int ALIGN_Start = 4;
    private static final int AUTO_CAP_All = 3;
    private static final int AUTO_CAP_None = 0;
    private static final int AUTO_CAP_Sentence = 2;
    private static final int AUTO_CAP_Word = 1;
    private static final int FOCUS_DOWN = 3;
    private static final int FOCUS_NONE = 1;
    private static final int FOCUS_UP = 2;
    private static final int KEYBOARDTYPE_Contact = 4;
    private static final int KEYBOARDTYPE_Default = 0;
    private static final int KEYBOARDTYPE_Email = 5;
    private static final int KEYBOARDTYPE_Number = 3;
    private static final int KEYBOARDTYPE_Punctuation = 1;
    private static final int KEYBOARDTYPE_Url = 2;
    private static final String LOG_TAG = "AndroidStageText";
    private static final int RETURN_KEY_Default = 0;
    private static final int RETURN_KEY_Done = 1;
    private static final int RETURN_KEY_Go = 2;
    private static final int RETURN_KEY_Next = 3;
    private static final int RETURN_KEY_Search = 4;
    private boolean enterKeyDispatched = false;
    private AIRWindowSurfaceView mAIRSurface;
    private int mAlign = 4;
    private int mAutoCapitalize = 0;
    private boolean mAutoCorrect = false;
    private BackgroundBorderDrawable mBBDrawable;
    private int mBackgroundColor = -1;
    private boolean mBold = false;
    private int mBorderColor = -16777216;
    private Rect mBounds = new Rect();
    private ViewGroup mClip = null;
    private Rect mClipBounds = null;
    private Context mContext;
    private boolean mDisableInteraction = false;
    private boolean mDisplayAsPassword = false;
    private boolean mEditable = true;
    private String mFont;
    private int mFontSize;
    private Rect mGlobalBounds = new Rect();
    private boolean mInContentMenu = false;
    private long mInternalReference;
    private boolean mItalic = false;
    private int mKeyboardType = 0;
    private RelativeLayout mLayout;
    private String mLocale = null;
    private int mMaxChars = 0;
    private boolean mMenuInvoked = false;
    private boolean mMultiline = false;
    private boolean mNotifyLayoutComplete = false;
    private boolean mPreventDefault = false;
    private String mRestrict = null;
    private int mReturnKeyLabel = 0;
    private KeyListener mSavedKeyListener = null;
    private double mScaleFactor = 1.0d;
    private boolean mSelectionChanged = false;
    private int mTextColor = -16777216;
    private AndroidStageTextEditText mTextView;
    private AndroidStageTextImpl mView;
    private Rect mViewBounds = null;

    class C01031 implements OnEditorActionListener {
        C01031() {
        }

        public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
            boolean access$1500;
            switch (i) {
                case 2:
                case 3:
                    AndroidStageText.this.enterKeyDispatched = true;
                    access$1500 = AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, 0, 66);
                    AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, 1, 66);
                    return access$1500;
                case 5:
                    access$1500 = AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, 0, 87);
                    AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, 1, 87);
                    return access$1500;
                case 6:
                    AndroidStageText.this.mAIRSurface.DispatchSoftKeyboardEventOnBackKey();
                    return false;
                default:
                    return false;
            }
        }
    }

    public class AndroidStageTextEditText extends EditText {
        private int mLastFocusDirection = 0;
        private View m_focusedChildView = null;
        private boolean m_hasFocus = false;
        private boolean m_inRequestChildFocus = false;

        private class DelayedTransparentRegionUpdate implements Runnable {
            private AIRWindowSurfaceView m_AIRSurface;
            private int m_freqMsecs;
            private int m_nUpdates;
            private AndroidStageTextImpl m_stageText;

            public DelayedTransparentRegionUpdate(int i, int i2, AndroidStageTextImpl androidStageTextImpl, AIRWindowSurfaceView aIRWindowSurfaceView) {
                this.m_nUpdates = i;
                this.m_freqMsecs = i2;
                this.m_stageText = androidStageTextImpl;
                this.m_AIRSurface = aIRWindowSurfaceView;
            }

            public void run() {
                if (!(this.m_stageText == null || this.m_AIRSurface == null)) {
                    this.m_stageText.requestTransparentRegion(this.m_AIRSurface);
                }
                int i = this.m_nUpdates - 1;
                this.m_nUpdates = i;
                if (i > 0) {
                    this.m_stageText.postDelayed(this, (long) this.m_freqMsecs);
                }
            }
        }

        public AndroidStageTextEditText(Context context) {
            super(context);
            setBackgroundDrawable(null);
            setCompoundDrawablePadding(0);
            setPadding(0, 0, 0, 0);
        }

        public AndroidStageTextEditText(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
        }

        public AndroidStageTextEditText(Context context, AttributeSet attributeSet, int i) {
            super(context, attributeSet, i);
        }

        protected void onDraw(Canvas canvas) {
            if (AndroidStageText.this.mClipBounds != null) {
                canvas.save();
                int i = -AndroidStageText.this.mViewBounds.left;
                int i2 = -AndroidStageText.this.mViewBounds.top;
                canvas.clipRect(new Rect(AndroidStageText.this.mClipBounds.left + i, AndroidStageText.this.mClipBounds.top + i2, i + AndroidStageText.this.mClipBounds.right, i2 + AndroidStageText.this.mClipBounds.bottom));
                super.onDraw(canvas);
                canvas.restore();
                return;
            }
            super.onDraw(canvas);
        }

        public boolean dispatchTouchEvent(MotionEvent motionEvent) {
            if (!this.m_hasFocus) {
                requestFocus();
            }
            return super.dispatchTouchEvent(motionEvent);
        }

        protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
            AndroidStageText androidStageText = AndroidStageText.this;
            super.onLayout(z, i, i2, i3, i4);
            if (androidStageText.mNotifyLayoutComplete) {
                androidStageText.mNotifyLayoutComplete = false;
                androidStageText.dispatchCompleteEvent(androidStageText.mInternalReference);
            }
            AndroidStageText.this.mView.postDelayed(new DelayedTransparentRegionUpdate(10, 75, AndroidStageText.this.mView, AndroidStageText.this.mAIRSurface), 75);
        }

        private void dispatchFocusEvent(boolean z, int i) {
            if (this.m_hasFocus != z) {
                this.m_hasFocus = z;
                AndroidStageText androidStageText = AndroidStageText.this;
                if (androidStageText.mInternalReference != 0) {
                    if (androidStageText.mAIRSurface != null) {
                        androidStageText.mAIRSurface.updateFocusedStageText(androidStageText, this.m_hasFocus);
                    }
                    if (z) {
                        androidStageText.dispatchFocusIn(androidStageText.mInternalReference, i);
                    }
                }
            }
        }

        protected void onFocusChanged(boolean z, int i, Rect rect) {
            super.onFocusChanged(z, i, rect);
            if (i == 0) {
                i = this.mLastFocusDirection;
            }
            this.mLastFocusDirection = 0;
            dispatchFocusEvent(z, i);
        }

        protected void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            super.onTextChanged(charSequence, i, i2, i3);
            AndroidStageText androidStageText = AndroidStageText.this;
            if (androidStageText.mInternalReference != 0) {
                androidStageText.dispatchChangeEvent(androidStageText.mInternalReference);
            }
        }

        public boolean onTouchEvent(MotionEvent motionEvent) {
            boolean z;
            int i = 0;
            while (i < motionEvent.getPointerCount()) {
                int action = motionEvent.getAction();
                motionEvent.getPointerId(i);
                if (motionEvent.getPointerCount() == 1 || motionEvent.getPointerId(i) == motionEvent.getPointerId((65280 & action) >> 8)) {
                    action &= 255;
                    if (!(action == 6 || action == 1)) {
                        z = false;
                        break;
                    }
                }
                i++;
            }
            z = true;
            if (z) {
                if (VERSION.SDK_INT >= 11 || !AndroidStageText.this.mMenuInvoked) {
                    AndroidStageText.this.invokeSoftKeyboard(AndroidStageText.this.mInternalReference);
                }
                AndroidStageText.this.mMenuInvoked = false;
            }
            return super.onTouchEvent(motionEvent);
        }

        public void onCreateContextMenu(ContextMenu contextMenu) {
            AndroidStageText.this.mMenuInvoked = true;
            AndroidStageText.this.mSelectionChanged = false;
            super.onCreateContextMenu(contextMenu);
        }

        public boolean onTextContextMenuItem(int i) {
            AndroidStageText.this.mInContentMenu = true;
            boolean onTextContextMenuItem = super.onTextContextMenuItem(i);
            AndroidStageText.this.mInContentMenu = false;
            AndroidStageText.this.mMenuInvoked = false;
            return onTextContextMenuItem;
        }

        public void onSelectionChanged(int i, int i2) {
            super.onSelectionChanged(i, i2);
            AndroidStageText.this.mSelectionChanged = true;
            if (AndroidStageText.this.mAIRSurface != null && AndroidStageText.this.mInContentMenu) {
                AndroidStageText.this.mAIRSurface.showSoftKeyboard(true, AndroidStageText.this.mTextView);
                AndroidStageText.this.invokeSoftKeyboard(AndroidStageText.this.mInternalReference);
            }
        }

        public boolean onKeyDown(int i, KeyEvent keyEvent) {
            boolean z = false;
            switch (i) {
                case 4:
                case C0004R.styleable.Theme_textColorSearchUrl /*66*/:
                case C0004R.styleable.Theme_colorPrimaryDark /*82*/:
                    if (!AndroidStageText.this.enterKeyDispatched) {
                        z = AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, keyEvent.getAction(), i);
                        break;
                    }
                    break;
            }
            if (z) {
                return z;
            }
            return super.onKeyDown(i, keyEvent);
        }

        public boolean onKeyUp(int i, KeyEvent keyEvent) {
            switch (i) {
                case 4:
                case C0004R.styleable.Theme_textColorSearchUrl /*66*/:
                case C0004R.styleable.Theme_colorPrimaryDark /*82*/:
                    if (!AndroidStageText.this.enterKeyDispatched) {
                        AndroidStageText.this.handleKeyEvent(AndroidStageText.this.mInternalReference, keyEvent.getAction(), i);
                        break;
                    }
                    break;
            }
            boolean onKeyUp = super.onKeyUp(i, keyEvent);
            AndroidStageText.this.enterKeyDispatched = false;
            return onKeyUp;
        }

        public boolean onKeyPreIme(int i, KeyEvent keyEvent) {
            if (AndroidStageText.this.mAIRSurface != null && i == 4 && keyEvent.getAction() == 0) {
                AndroidStageText.this.mAIRSurface.DispatchSoftKeyboardEventOnBackKey();
            }
            return super.onKeyPreIme(i, keyEvent);
        }

        public ActionMode startActionMode(Callback callback) {
            if (AndroidStageText.this.mAIRSurface != null && AndroidStageText.this.mSelectionChanged) {
                AndroidStageText.this.mAIRSurface.showSoftKeyboard(true, AndroidStageText.this.mTextView);
                AndroidStageText.this.invokeSoftKeyboard(AndroidStageText.this.mInternalReference);
                AndroidStageText.this.mSelectionChanged = false;
            }
            return super.startActionMode(callback);
        }
    }

    public class AndroidStageTextImpl extends ScrollView {
        public AndroidStageTextImpl(Context context) {
            super(context);
        }

        public AndroidStageTextImpl(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
        }

        public AndroidStageTextImpl(Context context, AttributeSet attributeSet, int i) {
            super(context, attributeSet, i);
        }

        protected void onSizeChanged(int i, int i2, int i3, int i4) {
            super.onSizeChanged(i, i2, i3, i4);
        }

        protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
            AndroidStageText androidStageText = AndroidStageText.this;
            super.onLayout(z, i, i2, i3, i4);
            if (androidStageText.mNotifyLayoutComplete) {
                androidStageText.mNotifyLayoutComplete = false;
                androidStageText.dispatchCompleteEvent(androidStageText.mInternalReference);
            }
        }

        protected void onDraw(Canvas canvas) {
            if (AndroidStageText.this.mClipBounds != null) {
                canvas.save();
                int i = -AndroidStageText.this.mViewBounds.left;
                int i2 = -AndroidStageText.this.mViewBounds.top;
                canvas.clipRect(new Rect(AndroidStageText.this.mClipBounds.left + i, AndroidStageText.this.mClipBounds.top + i2, i + AndroidStageText.this.mClipBounds.right, i2 + AndroidStageText.this.mClipBounds.bottom));
                super.onDraw(canvas);
                canvas.restore();
                return;
            }
            super.onDraw(canvas);
        }
    }

    public class BackgroundBorderDrawable extends ShapeDrawable {
        public int mBkgColor = -1;
        public Paint mBkgPaint;
        public int mBorderColor = -16777216;
        public boolean mHaveBkg = false;
        public boolean mHaveBorder = false;

        public BackgroundBorderDrawable() {
            init();
        }

        public BackgroundBorderDrawable(Shape shape) {
            super(shape);
            init();
        }

        protected void onDraw(Shape shape, Canvas canvas, Paint paint) {
            if (this.mHaveBkg) {
                canvas.drawRect(getBounds(), this.mBkgPaint);
            }
            if (this.mHaveBorder) {
                super.onDraw(shape, canvas, paint);
            }
        }

        private void init() {
            this.mBkgPaint = new Paint(getPaint());
            this.mBkgPaint.setStyle(Style.FILL);
            this.mBkgPaint.setColor(this.mBkgColor);
            getPaint().setStyle(Style.STROKE);
            getPaint().setStrokeWidth(3.0f);
            getPaint().setColor(this.mBorderColor);
        }

        public void setBkgColor(int i) {
            this.mBkgColor = i;
            this.mBkgPaint.setColor(i);
        }

        public void setBorderColor(int i) {
            this.mBorderColor = i;
            getPaint().setColor(i);
        }
    }

    private class RestrictFilter implements InputFilter {
        private static final int kMapSize = 8192;
        private String mPattern = null;
        private byte[] m_map = null;

        public RestrictFilter(String str) {
            this.mPattern = str;
            if (str != null && !"".equals(str)) {
                this.m_map = new byte[8192];
                SetAll(false);
                if (str.charAt(0) == '^') {
                    SetAll(true);
                }
                char c = '\u0000';
                boolean z = true;
                boolean z2 = false;
                boolean z3 = false;
                for (int i = 0; i < str.length(); i++) {
                    boolean z4;
                    char charAt = str.charAt(i);
                    if (!z3) {
                        switch (charAt) {
                            case C0004R.styleable.Theme_actionDropDownStyle /*45*/:
                                z4 = false;
                                z2 = true;
                                break;
                            case C0004R.styleable.Theme_alertDialogCenterButtons /*92*/:
                                z4 = false;
                                z3 = true;
                                break;
                            case C0004R.styleable.Theme_textColorAlertDialogListItem /*94*/:
                                if (z) {
                                    z = false;
                                } else {
                                    z = true;
                                }
                                z4 = false;
                                break;
                            default:
                                z4 = true;
                                break;
                        }
                    }
                    z4 = true;
                    z3 = false;
                    if (z4) {
                        if (z2) {
                            while (c <= charAt) {
                                SetCode(c, z);
                                c = (char) (c + 1);
                            }
                            c = '\u0000';
                            z2 = false;
                        } else {
                            SetCode(charAt, z);
                            c = charAt;
                        }
                    }
                }
            }
        }

        public CharSequence filter(CharSequence charSequence, int i, int i2, Spanned spanned, int i3, int i4) {
            if (this.mPattern == null) {
                return null;
            }
            if (this.m_map == null) {
                return "";
            }
            int i5;
            CharSequence stringBuffer = new StringBuffer(i2 - i);
            if (i2 - i > 1) {
                i5 = 0;
                while (i + i5 < i2 && i3 + i5 < i4 && charSequence.charAt(i + i5) == spanned.charAt(i3 + i5)) {
                    stringBuffer.append(charSequence.charAt(i + i5));
                    i5++;
                }
                i5 += i;
            } else {
                i5 = i;
            }
            int i6 = i5;
            i5 = 1;
            for (int i7 = i6; i7 < i2; i7++) {
                char charAt = charSequence.charAt(i7);
                if (IsCharAvailable(charAt)) {
                    stringBuffer.append(charAt);
                } else {
                    i5 = 0;
                }
            }
            if (i5 != 0) {
                return null;
            }
            if (!(charSequence instanceof Spanned)) {
                return stringBuffer;
            }
            Spannable spannableString = new SpannableString(stringBuffer);
            TextUtils.copySpansFrom((Spanned) charSequence, i, stringBuffer.length(), null, spannableString, 0);
            return spannableString;
        }

        boolean IsEmpty() {
            return this.mPattern != null;
        }

        boolean IsCharAvailable(char c) {
            boolean z = true;
            if (this.mPattern == null) {
            }
            if (this.m_map == null) {
                return false;
            }
            if ((this.m_map[c >> 3] & (1 << (c & 7))) == 0) {
                z = false;
            }
            return z;
        }

        void SetCode(char c, boolean z) {
            if (z) {
                byte[] bArr = this.m_map;
                int i = c >> 3;
                bArr[i] = (byte) (bArr[i] | (1 << (c & 7)));
                return;
            }
            bArr = this.m_map;
            i = c >> 3;
            bArr[i] = (byte) (bArr[i] & ((1 << (c & 7)) ^ -1));
        }

        void SetAll(boolean z) {
            int i;
            int i2 = 0;
            if (z) {
                i = 255;
            } else {
                i = 0;
            }
            byte b = (byte) i;
            while (i2 < 8192) {
                this.m_map[i2] = b;
                i2++;
            }
        }
    }

    private native void dispatchChangeEvent(long j);

    private native void dispatchCompleteEvent(long j);

    private native void dispatchFocusIn(long j, int i);

    private native void dispatchFocusOut(long j, int i);

    private native boolean handleKeyEvent(long j, int i, int i2);

    private native void invokeSoftKeyboard(long j);

    public AndroidStageText(boolean z) {
        this.mMultiline = z;
        this.mDisplayAsPassword = false;
        this.mInternalReference = 0;
        this.mContext = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity();
        this.mView = new AndroidStageTextImpl(this.mContext);
        this.mView.setFillViewport(true);
        if (VERSION.SDK_INT >= 11) {
            this.mView.setLayerType(1, null);
        }
        this.mTextView = new AndroidStageTextEditText(this.mContext);
        this.mTextView.setImeOptions(301989888);
        this.mSavedKeyListener = this.mTextView.getKeyListener();
        setFontSize(12);
        setInputType();
        this.mView.addView(this.mTextView, new LayoutParams(-1, -2));
        if (z) {
            this.mTextView.setTransformationMethod(null);
            this.mTextView.setHorizontallyScrolling(false);
        } else {
            this.mTextView.setSingleLine(true);
        }
        this.mTextView.setGravity(3);
    }

    public void onActivityStateChanged(ActivityState activityState) {
    }

    public void onConfigurationChanged(Configuration configuration) {
    }

    public void setInternalReference(long j) {
        this.mInternalReference = j;
    }

    public void destroyInternals() {
        removeFromStage();
        this.mInternalReference = 0;
        this.mView = null;
        this.mClipBounds = null;
        this.mTextView = null;
    }

    public void addToStage(AIRWindowSurfaceView aIRWindowSurfaceView) {
        if (this.mLayout != null) {
            removeFromStage();
        }
        this.mAIRSurface = aIRWindowSurfaceView;
        AndroidActivityWrapper activityWrapper = aIRWindowSurfaceView.getActivityWrapper();
        activityWrapper.addActivityStateChangeListner(this);
        this.mLayout = activityWrapper.getOverlaysLayout(true);
        this.mLayout.addView(this.mView, new RelativeLayout.LayoutParams(this.mGlobalBounds.width(), this.mGlobalBounds.height()));
        this.mTextView.setOnEditorActionListener(new C01031());
    }

    public void removeFromStage() {
        if (this.mLayout != null) {
            this.mLayout.removeView(this.mView);
            this.mLayout = null;
        }
        if (this.mAIRSurface != null) {
            AndroidActivityWrapper activityWrapper = this.mAIRSurface.getActivityWrapper();
            activityWrapper.didRemoveOverlay();
            activityWrapper.removeActivityStateChangeListner(this);
            this.mAIRSurface.updateFocusedStageText(this, false);
        }
        this.mAIRSurface = null;
    }

    public void setVisibility(boolean z) {
        int i = z ? 0 : 4;
        if (this.mView.getVisibility() != i) {
            this.mView.setVisibility(i);
            if (z) {
                this.mTextView.invalidate();
            }
        }
    }

    public long updateViewBoundsWithKeyboard(int i) {
        int min;
        this.mGlobalBounds = this.mBounds;
        if (this.mAIRSurface != null) {
            Rect rect = new Rect(0, 0, this.mAIRSurface.getVisibleBoundWidth(), this.mAIRSurface.getVisibleBoundHeight());
            if (!rect.contains(this.mBounds)) {
                int min2 = Math.min(Math.max(0, this.mBounds.top), i);
                min = Math.min(Math.max(0, this.mBounds.bottom), i);
                if (min2 == min) {
                    return 0;
                }
                min -= rect.bottom;
                if (min <= 0) {
                    return 0;
                }
                if (min > min2) {
                    this.mGlobalBounds = new Rect(this.mBounds);
                    this.mGlobalBounds.bottom = rect.bottom + min2;
                    min = min2;
                }
                refreshGlobalBounds(false);
                return (long) min;
            }
        }
        min = 0;
        refreshGlobalBounds(false);
        return (long) min;
    }

    public void resetGlobalBounds() {
        this.mGlobalBounds = this.mBounds;
        refreshGlobalBounds(false);
    }

    private void refreshGlobalBounds(final boolean z) {
        if (this.mView != null) {
            this.mView.post(new Runnable() {
                public void run() {
                    if (AndroidStageText.this.mView != null) {
                        LayoutParams layoutParams = new RelativeLayout.LayoutParams(AndroidStageText.this.mGlobalBounds.width(), AndroidStageText.this.mGlobalBounds.height());
                        layoutParams.leftMargin = AndroidStageText.this.mGlobalBounds.left;
                        layoutParams.topMargin = AndroidStageText.this.mGlobalBounds.top;
                        AndroidStageText.this.mView.setLayoutParams(layoutParams);
                        AndroidStageText.this.mView.requestLayout();
                        if (z) {
                            AndroidStageText.this.mNotifyLayoutComplete = true;
                        }
                    }
                }
            });
        }
    }

    public void adjustViewBounds(double d, double d2, double d3, double d4, double d5) {
        this.mViewBounds = new Rect((int) d, (int) d2, (int) (d + d3), (int) (d2 + d4));
        if (d5 != this.mScaleFactor) {
            this.mScaleFactor = d5;
            setFontSize(this.mFontSize);
        }
        this.mBounds = this.mViewBounds;
        if (this.mClip != null) {
            this.mBounds.intersect(this.mClipBounds);
        }
        this.mGlobalBounds = this.mBounds;
        refreshGlobalBounds(true);
    }

    public void setClipBounds(double d, double d2, double d3, double d4) {
        this.mClipBounds = new Rect((int) d, (int) d2, (int) (d + d3), (int) (d2 + d4));
        this.mBounds = this.mViewBounds;
        this.mTextView.invalidate();
        refreshGlobalBounds(true);
    }

    public void removeClip() {
        AIRWindowSurfaceView aIRWindowSurfaceView = this.mAIRSurface;
        this.mBounds = this.mViewBounds;
        this.mClipBounds = null;
        this.mTextView.invalidate();
        refreshGlobalBounds(true);
    }

    public void setText(String str) {
        InputFilter[] filters = this.mTextView.getFilters();
        this.mTextView.setFilters(new InputFilter[0]);
        AndroidStageTextEditText androidStageTextEditText = this.mTextView;
        BufferType bufferType = (!this.mEditable || this.mDisableInteraction) ? BufferType.NORMAL : BufferType.EDITABLE;
        androidStageTextEditText.setText(str, bufferType);
        this.mTextView.setFilters(filters);
    }

    public String getText() {
        return this.mTextView.getText().toString();
    }

    public void setKeyboardType(int i) {
        this.mKeyboardType = i;
        setInputType();
    }

    public int getKeyboardType() {
        return this.mKeyboardType;
    }

    public void setDisplayAsPassword(boolean z) {
        this.mDisplayAsPassword = z;
        if (z) {
            this.mTextView.setTransformationMethod(PasswordTransformationMethod.getInstance());
        } else if (this.mMultiline) {
            this.mTextView.setTransformationMethod(null);
        } else {
            this.mTextView.setTransformationMethod(SingleLineTransformationMethod.getInstance());
        }
        setInputType();
    }

    private void setInputType() {
        int i;
        if (!this.mDisplayAsPassword) {
            switch (this.mKeyboardType) {
                case 1:
                case 4:
                    i = 1;
                    break;
                case 2:
                    i = 17;
                    break;
                case 3:
                    i = 2;
                    break;
                case 5:
                    i = 33;
                    break;
                default:
                    i = 1;
                    break;
            }
        }
        i = this.mKeyboardType == 3 ? 18 : 129;
        if ((i & 15) == 1) {
            if (this.mAutoCorrect) {
                i |= 32768;
            } else {
                i |= 524288;
            }
            if (this.mAutoCapitalize != 0) {
                switch (this.mAutoCapitalize) {
                    case 1:
                        i |= Utility.DEFAULT_STREAM_BUFFER_SIZE;
                        break;
                    case 2:
                        i |= 16384;
                        break;
                    case 3:
                        i |= 4096;
                        break;
                }
            }
        }
        if (this.mMultiline) {
            i |= 131072;
        }
        this.mTextView.setRawInputType(i);
        this.mTextView.invalidate();
    }

    public void setEditable(boolean z) {
        if (z != this.mEditable) {
            this.mEditable = z;
            if (!this.mDisableInteraction) {
                InputFilter[] filters = this.mTextView.getFilters();
                this.mTextView.setFilters(new InputFilter[0]);
                this.mTextView.setText(this.mTextView.getText(), this.mEditable ? BufferType.EDITABLE : BufferType.NORMAL);
                this.mTextView.setFilters(filters);
                this.mTextView.setKeyListener(this.mEditable ? this.mSavedKeyListener : null);
                if (this.mEditable) {
                    setInputType();
                }
            }
        }
    }

    public void setDisableInteraction(boolean z) {
        this.mDisableInteraction = z;
        InputFilter[] filters = this.mTextView.getFilters();
        this.mTextView.setFilters(new InputFilter[0]);
        if (z) {
            this.mTextView.setText(this.mTextView.getText(), BufferType.NORMAL);
            this.mTextView.setFilters(filters);
            this.mTextView.setKeyListener(null);
            return;
        }
        KeyListener keyListener;
        this.mTextView.setText(this.mTextView.getText(), this.mEditable ? BufferType.EDITABLE : BufferType.NORMAL);
        this.mTextView.setFilters(filters);
        AndroidStageTextEditText androidStageTextEditText = this.mTextView;
        if (this.mEditable) {
            keyListener = this.mSavedKeyListener;
        } else {
            keyListener = null;
        }
        androidStageTextEditText.setKeyListener(keyListener);
        if (this.mEditable) {
            setInputType();
        }
    }

    public void setTextColor(int i, int i2, int i3, int i4) {
        this.mTextColor = Color.argb(i4, i, i2, i3);
        this.mTextView.setTextColor(this.mTextColor);
        this.mTextView.invalidate();
    }

    public int getTextColor() {
        return this.mTextColor;
    }

    private RectShape getShapeForBounds(Rect rect) {
        RectShape rectShape = new RectShape();
        rectShape.resize((float) rect.width(), (float) rect.height());
        return rectShape;
    }

    public void setBackgroundColor(int i, int i2, int i3, int i4) {
        this.mBBDrawable.setBkgColor(Color.argb(i4, i, i2, i3));
        this.mTextView.invalidate();
    }

    public int getBackgroundColor() {
        return this.mBBDrawable.mBkgColor;
    }

    public void setBackground(boolean z) {
        if (this.mBBDrawable.mHaveBkg != z) {
            this.mBBDrawable.mHaveBkg = z;
            this.mTextView.invalidate();
        }
    }

    public void setBorderColor(int i, int i2, int i3, int i4) {
        this.mBBDrawable.setBorderColor(Color.argb(i4, i, i2, i3));
        this.mTextView.invalidate();
    }

    public int getBorderColor() {
        return this.mBBDrawable.mBorderColor;
    }

    public void setBorder(boolean z) {
        if (this.mBBDrawable.mHaveBorder != z) {
            this.mBBDrawable.mHaveBorder = z;
            this.mTextView.invalidate();
        }
    }

    public void setAutoCapitalize(int i) {
        if (this.mAutoCapitalize != i) {
            this.mAutoCapitalize = i;
            setInputType();
        }
    }

    public int getAutoCapitalize() {
        return this.mAutoCapitalize;
    }

    public void setAutoCorrect(boolean z) {
        if (this.mAutoCorrect != z) {
            this.mAutoCorrect = z;
            setInputType();
        }
    }

    public int getReturnKeyLabel() {
        return this.mReturnKeyLabel;
    }

    public void setReturnKeyLabel(int i) {
        int i2 = 0;
        this.mReturnKeyLabel = i;
        switch (i) {
            case 1:
                i2 = 6;
                break;
            case 2:
                i2 = 2;
                break;
            case 3:
                i2 = 5;
                break;
            case 4:
                i2 = 3;
                break;
        }
        this.mTextView.setImeOptions(i2 | 301989888);
    }

    private void applyFilters() {
        int i;
        int i2 = 1;
        if (this.mMaxChars != 0) {
            i = 1;
        } else {
            i = 0;
        }
        if (this.mRestrict != null) {
            i++;
        }
        InputFilter[] inputFilterArr = new InputFilter[i];
        if (this.mMaxChars != 0) {
            inputFilterArr[0] = new LengthFilter(this.mMaxChars);
        } else {
            i2 = 0;
        }
        if (this.mRestrict != null) {
            inputFilterArr[i2] = new RestrictFilter(this.mRestrict);
            i2++;
        }
        this.mTextView.setFilters(inputFilterArr);
    }

    public String getRestrict() {
        return this.mRestrict;
    }

    public void clearRestrict() {
        this.mRestrict = null;
        applyFilters();
    }

    public void setRestrict(String str) {
        this.mRestrict = str;
        applyFilters();
    }

    public int getMaxChars() {
        return this.mMaxChars;
    }

    public void setMaxChars(int i) {
        if (i != this.mMaxChars) {
            this.mMaxChars = i;
            applyFilters();
        }
    }

    public String getLocale() {
        return this.mLocale;
    }

    public void setLocale(String str) {
        this.mLocale = str;
    }

    public boolean getPreventDefault() {
        return this.mPreventDefault;
    }

    public void setPreventDefault(boolean z) {
        this.mPreventDefault = z;
    }

    public int getAlign() {
        return this.mAlign;
    }

    public void setAlign(int i) {
        this.mAlign = i;
        switch (i) {
            case 0:
            case 4:
                this.mTextView.setGravity(3);
                break;
            case 1:
            case 5:
                this.mTextView.setGravity(5);
                break;
            case 2:
                this.mTextView.setGravity(1);
                break;
        }
        this.mTextView.invalidate();
    }

    public void setFontSize(int i) {
        this.mFontSize = i;
        this.mTextView.setTextSize(0, (float) ((int) ((((double) i) * this.mScaleFactor) + 0.5d)));
        this.mTextView.invalidate();
    }

    public int getFontSize() {
        return this.mFontSize;
    }

    public void setBold(boolean z) {
        this.mBold = z;
        updateTypeface();
    }

    public void setItalic(boolean z) {
        this.mItalic = z;
        updateTypeface();
    }

    public void setFontFamily(String str) {
        this.mFont = str;
        updateTypeface();
    }

    public void updateTypeface() {
        int i = 0;
        if (this.mBold) {
            i = 1;
        }
        if (this.mItalic) {
            i |= 2;
        }
        Typeface create = Typeface.create(this.mFont, i);
        if (create == null) {
            switch (i) {
                case 0:
                    this.mTextView.setTypeface(Typeface.DEFAULT);
                    break;
                case 1:
                    this.mTextView.setTypeface(Typeface.DEFAULT_BOLD);
                    break;
                default:
                    break;
            }
        }
        this.mTextView.setTypeface(create, i);
        this.mTextView.invalidate();
    }

    public void assignFocus() {
        this.mTextView.requestFocus();
        if (!this.mPreventDefault) {
            this.mAIRSurface.showSoftKeyboard(true, this.mTextView);
        }
        invokeSoftKeyboard(this.mInternalReference);
    }

    public void clearFocus() {
        if (this.mTextView.hasFocus()) {
            this.mTextView.clearFocus();
            this.mAIRSurface.requestFocus();
        }
        if (this.mMenuInvoked && this.mDisableInteraction) {
            this.mAIRSurface.showSoftKeyboard(false, this.mTextView);
        }
    }

    public void selectRange(int i, int i2) {
        int length = this.mTextView.length();
        if (i < 0) {
            i = 0;
        } else if (i > length) {
            i = length;
        }
        if (i2 < 0) {
            i2 = 0;
        } else if (i2 > length) {
            i2 = length;
        }
        this.mTextView.setSelection(i, i2);
        this.mTextView.invalidate();
    }

    public int getSelectionAnchorIndex() {
        return this.mTextView.getSelectionStart();
    }

    public int getSelectionActiveIndex() {
        return this.mTextView.getSelectionEnd();
    }

    public Bitmap captureSnapshot(int i, int i2) {
        if (i < 0 || i2 < 0) {
            return null;
        }
        if (i == 0 && i2 == 0) {
            return null;
        }
        Bitmap createBitmap = Bitmap.createBitmap(i, i2, Config.ARGB_8888);
        Canvas canvas = new Canvas(createBitmap);
        canvas.translate((float) (-this.mView.getScrollX()), (float) (-this.mView.getScrollY()));
        if (this.mScaleFactor != 0.0d) {
            canvas.scale((float) (1.0d / this.mScaleFactor), (float) (1.0d / this.mScaleFactor));
        }
        boolean isHorizontalScrollBarEnabled = this.mView.isHorizontalScrollBarEnabled();
        boolean isVerticalScrollBarEnabled = this.mView.isVerticalScrollBarEnabled();
        this.mView.setHorizontalScrollBarEnabled(false);
        this.mView.setVerticalScrollBarEnabled(false);
        try {
            this.mView.draw(canvas);
        } catch (Exception e) {
            createBitmap = null;
        }
        this.mView.setHorizontalScrollBarEnabled(isHorizontalScrollBarEnabled);
        this.mView.setVerticalScrollBarEnabled(isVerticalScrollBarEnabled);
        return createBitmap;
    }
}
