package com.adobe.air.wand.motionsensor;

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import de.pagecon.ane.nfc.BaseConfig;

public abstract class MotionSensor {
    protected static final String LOG_TAG = "MotionSensor";
    protected Activity mActivity = null;
    protected boolean mRegistered = false;
    protected Sensor mSensor = null;
    protected int mSensorDelay = 1;
    protected SensorEventListener mSensorEventListener = null;
    protected SensorManager mSensorManager = null;

    public interface Listener {
        void onSensorChanged(float[] fArr, long j);
    }

    public MotionSensor(Activity activity, int i) {
        this.mActivity = activity;
        this.mSensorManager = (SensorManager) this.mActivity.getSystemService("sensor");
        this.mSensor = this.mSensorManager.getDefaultSensor(i);
        if (this.mSensor == null) {
        }
    }

    private float[] getScreenOrientedValues(float[] fArr) {
        float[] fArr2 = (float[]) fArr.clone();
        int rotation = this.mActivity.getWindowManager().getDefaultDisplay().getRotation();
        if (rotation != 0) {
            if (rotation == 2) {
                fArr2[0] = -fArr2[0];
                fArr2[1] = -fArr2[1];
            } else if (rotation == 1) {
                r1 = fArr2[0];
                fArr2[0] = -fArr2[1];
                fArr2[1] = r1;
            } else if (rotation == 3) {
                r1 = -fArr2[0];
                fArr2[0] = fArr2[1];
                fArr2[1] = r1;
            }
        }
        return fArr2;
    }

    public void setListener(final Listener listener) {
        SensorEventListener sensorEventListener;
        boolean z = this.mRegistered;
        stop();
        if (listener == null) {
            sensorEventListener = null;
        } else {
            sensorEventListener = new SensorEventListener() {
                public void onSensorChanged(SensorEvent sensorEvent) {
                    listener.onSensorChanged(MotionSensor.this.getScreenOrientedValues(sensorEvent.values), sensorEvent.timestamp);
                }

                public void onAccuracyChanged(Sensor sensor, int i) {
                }
            };
        }
        this.mSensorEventListener = sensorEventListener;
        if (z) {
            start();
        }
    }

    public void start(int i) {
        if (!this.mRegistered && this.mSensor != null) {
            this.mSensorDelay = i * BaseConfig.READ_SETTING_DATA_DELAY_TIMEOUT;
            start();
        }
    }

    public void start() {
        if (!this.mRegistered && this.mSensor != null) {
            this.mRegistered = this.mSensorManager.registerListener(this.mSensorEventListener, this.mSensor, this.mSensorDelay);
            if (!this.mRegistered) {
            }
        }
    }

    public void stop() {
        if (this.mRegistered) {
            this.mSensorManager.unregisterListener(this.mSensorEventListener, this.mSensor);
            this.mRegistered = false;
        }
    }

    public boolean available() {
        return this.mSensor != null;
    }

    public boolean active() {
        return this.mRegistered;
    }

    public void dispose() {
        stop();
        setListener(null);
        this.mSensor = null;
        this.mSensorManager = null;
        this.mActivity = null;
    }
}
