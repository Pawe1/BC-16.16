package com.adobe.air.wand.view;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ViewFlipper;
import com.adobe.air.wand.view.WandView.Listener;
import com.adobe.air.wand.view.WandView.ScreenOrientation;

public class WandViewFlipper extends ViewFlipper implements WandView {
    private static final String ACTIVE_WIFI_ASSIST_MESSAGE = "Enter this PIN in the desktop game and press 'Connect'";
    private static final String DEFAULT_VIEW_FONT_ASSET = "AdobeClean-Light.ttf";
    private static final String INACTIVE_WIFI_ASSIST_MESSAGE = "Connect this device to WiFi to get the pairing PIN";
    private static final String LOG_TAG = "WandViewFlipper";
    private static final String PIN_TITLE = "PIN : ";
    private static final String TITLE_DESCRIPTION_STRING = "Use this device as a Wireless Gamepad";
    private CompanionView mCompanionView = null;
    private View mCompanionViewHolder = null;
    private int mCurrentViewIndex = 0;
    private View mDefaultView = null;
    private Listener mListener = null;
    private TouchSensor mTouchSensor = null;

    class C01622 implements Runnable {
        C01622() {
        }

        public void run() {
            CharSequence access$300;
            boolean z;
            ((ImageView) WandViewFlipper.this.mCompanionViewHolder.findViewById(2131558927)).setImageResource(2131427386);
            WandViewFlipper.this.mCurrentViewIndex = 0;
            String str = "";
            if (WandViewFlipper.this.mListener != null) {
                str = WandViewFlipper.this.mListener.getConnectionToken();
            }
            if (str.equals("")) {
                Object obj = str;
            } else {
                access$300 = WandViewFlipper.getTokenString(str);
            }
            ((TextView) WandViewFlipper.this.mDefaultView.findViewById(2131558931)).setText(access$300);
            TextView textView = (TextView) WandViewFlipper.this.mDefaultView.findViewById(2131558932);
            if (WandViewFlipper.this.mListener.getConnectionToken().equals("")) {
                z = false;
            } else {
                z = true;
            }
            textView.setText(WandViewFlipper.getTokenDesc(z));
            WandViewFlipper.this.setDisplayedChild(WandViewFlipper.this.mCurrentViewIndex);
        }
    }

    class C01633 implements Runnable {
        C01633() {
        }

        public void run() {
            WandViewFlipper.this.setDisplayedChild(WandViewFlipper.this.mCurrentViewIndex);
            try {
                if (WandViewFlipper.this.mListener != null) {
                    WandViewFlipper.this.mListener.onLoadCompanion(((Activity) WandViewFlipper.this.getContext()).getResources().getConfiguration());
                }
            } catch (Exception e) {
            }
        }
    }

    public WandViewFlipper(Context context) {
        super(context);
        initView(context);
    }

    public WandViewFlipper(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        initView(context);
    }

    private void initView(Context context) {
        this.mListener = null;
        try {
            setKeepScreenOn(true);
            LayoutInflater from = LayoutInflater.from(context);
            this.mDefaultView = from.inflate(2130903234, null);
            this.mCompanionViewHolder = from.inflate(2130903233, null);
            this.mDefaultView.getBackground().setDither(true);
            TextView textView = (TextView) this.mDefaultView.findViewById(2131558928);
            Typeface createFromAsset = Typeface.createFromAsset(context.getAssets(), DEFAULT_VIEW_FONT_ASSET);
            textView.setTypeface(createFromAsset);
            ((TextView) this.mDefaultView.findViewById(2131558931)).setTypeface(createFromAsset);
            ((TextView) this.mDefaultView.findViewById(2131558932)).setTypeface(createFromAsset);
            textView = (TextView) this.mDefaultView.findViewById(2131558929);
            textView.setTypeface(createFromAsset);
            textView.setText(TITLE_DESCRIPTION_STRING);
            addView(this.mDefaultView, 0);
            addView(this.mCompanionViewHolder, 1);
            this.mCompanionView = (CompanionView) this.mCompanionViewHolder.findViewById(2131558925);
            this.mTouchSensor = this.mCompanionView.getTouchSensor();
            this.mCurrentViewIndex = 0;
        } catch (Exception e) {
        }
    }

    public void setScreenOrientation(ScreenOrientation screenOrientation) throws Exception {
        int i;
        switch (screenOrientation) {
            case LANDSCAPE:
                i = 0;
                break;
            case PORTRAIT:
                i = 1;
                break;
            case REVERSE_PORTRAIT:
                i = 9;
                break;
            case REVERSE_LANDSCAPE:
                i = 8;
                break;
            default:
                i = -1;
                break;
        }
        Activity activity = (Activity) getContext();
        if (activity == null) {
            throw new IllegalArgumentException("Wand cannot find activity while loading companion.");
        }
        activity.setRequestedOrientation(i);
    }

    public void drawImage(Bitmap bitmap) throws Exception {
        if (this.mCurrentViewIndex == 0) {
            throw new Exception("Companion view is not yet loaded.");
        }
        final ImageView imageView = (ImageView) this.mCompanionViewHolder.findViewById(2131558927);
        Bitmap createScaledBitmap = Bitmap.createScaledBitmap(bitmap, imageView.getWidth(), (bitmap.getHeight() * imageView.getWidth()) / bitmap.getWidth(), true);
        if (createScaledBitmap != bitmap) {
            bitmap.recycle();
        }
        int height = imageView.getHeight();
        int height2 = createScaledBitmap.getHeight();
        if (height2 > height) {
            Bitmap createBitmap = Bitmap.createBitmap(createScaledBitmap, 0, height2 - height, imageView.getWidth(), imageView.getHeight());
            if (createBitmap != createScaledBitmap) {
                createScaledBitmap.recycle();
            }
            createScaledBitmap = createBitmap;
        }
        ((Activity) getContext()).runOnUiThread(new Runnable() {
            public void run() {
                imageView.setImageBitmap(createScaledBitmap);
            }
        });
    }

    private static String getTokenString(String str) {
        return PIN_TITLE + str;
    }

    private static String getTokenDesc(boolean z) {
        if (z) {
            return ACTIVE_WIFI_ASSIST_MESSAGE;
        }
        return INACTIVE_WIFI_ASSIST_MESSAGE;
    }

    public void loadDefaultView() throws Exception {
        ((Activity) getContext()).runOnUiThread(new C01622());
    }

    public void loadCompanionView() throws Exception {
        if (this.mCurrentViewIndex != 1) {
            this.mCurrentViewIndex = 1;
            ((Activity) getContext()).runOnUiThread(new C01633());
        }
    }

    public void registerListener(Listener listener) throws Exception {
        if (this.mListener != null) {
            throw new Exception("View listener is already registered");
        } else if (listener == null) {
            throw new Exception("Invalid view listener");
        } else {
            this.mListener = listener;
        }
    }

    public void unregisterListener() {
        this.mListener = null;
    }

    public void updateConnectionToken(final String str) {
        if (this.mCurrentViewIndex != 1) {
            ((Activity) getContext()).runOnUiThread(new Runnable() {
                public void run() {
                    CharSequence access$300;
                    String str = "";
                    if (str.equals("")) {
                        Object obj = str;
                    } else {
                        access$300 = WandViewFlipper.getTokenString(str);
                    }
                    ((TextView) WandViewFlipper.this.mDefaultView.findViewById(2131558931)).setText(access$300);
                    ((TextView) WandViewFlipper.this.mDefaultView.findViewById(2131558932)).setText(WandViewFlipper.getTokenDesc(!str.equals("")));
                }
            });
        }
    }

    public TouchSensor getTouchSensor() {
        return this.mTouchSensor;
    }
}
