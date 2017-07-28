package com.adobe.air;

import android.content.Context;
import android.content.res.Configuration;
import android.hardware.input.InputManager;
import android.hardware.input.InputManager.InputDeviceListener;
import android.util.SparseArray;
import android.view.InputDevice;
import android.view.KeyEvent;
import android.view.MotionEvent;
import com.adobe.air.AndroidActivityWrapper.ActivityState;

public class AndroidInputManager implements InputDeviceListener, StateChangeCallback, InputEventCallback {
    private static AndroidInputManager sAndroidInputManager = null;
    private Context mContext = null;
    private SparseArray<AndroidInputDevice> mInputDevices = null;
    private InputManager mInputManager = null;
    private long mInternalReference = 0;
    private boolean mListening = false;

    private native void OnDeviceAdded(long j, AndroidInputDevice androidInputDevice, String str);

    private native void OnDeviceRemoved(long j, String str);

    public static boolean isSupported() {
        try {
            if (Class.forName("android.hardware.input.InputManager") != null) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static AndroidInputManager GetAndroidInputManager(Context context) {
        if (isSupported() && sAndroidInputManager == null) {
            sAndroidInputManager = new AndroidInputManager(context);
        }
        return sAndroidInputManager;
    }

    private AndroidInputManager(Context context) {
        this.mContext = context;
        if (this.mContext != null) {
            this.mInputManager = (InputManager) this.mContext.getSystemService("input");
        }
        AndroidActivityWrapper GetAndroidActivityWrapper = AndroidActivityWrapper.GetAndroidActivityWrapper();
        if (GetAndroidActivityWrapper != null) {
            GetAndroidActivityWrapper.addActivityStateChangeListner(this);
            GetAndroidActivityWrapper.addInputEventListner(this);
        }
        this.mInputDevices = new SparseArray();
    }

    public AndroidInputDevice getInputDevice(int i) {
        return (AndroidInputDevice) this.mInputDevices.get(i);
    }

    public void setInternalReference(long j) {
        this.mInternalReference = j;
    }

    public void listenForInputDevice(boolean z) {
        if (this.mInputManager != null) {
            if (z) {
                try {
                    if (!this.mListening) {
                        this.mInputManager.registerInputDeviceListener(this, null);
                        addRemoveExistingInputDevices();
                        this.mListening = true;
                        return;
                    }
                } catch (Exception e) {
                    return;
                }
            }
            if (!z && this.mListening) {
                this.mInputManager.unregisterInputDeviceListener(this);
                this.mListening = false;
            }
        }
    }

    private void addRemoveExistingInputDevices() {
        int i = 0;
        int size = this.mInputDevices.size();
        int i2 = 0;
        while (i2 < size) {
            int[] inputDeviceIds = this.mInputManager.getInputDeviceIds();
            int i3 = 0;
            while (i3 < inputDeviceIds.length && this.mInputDevices.keyAt(i2) != inputDeviceIds[i3]) {
                i3++;
            }
            if (i3 == inputDeviceIds.length) {
                OnDeviceRemoved(this.mInternalReference, ((AndroidInputDevice) this.mInputDevices.valueAt(i2)).getUniqueId());
                this.mInputDevices.delete(this.mInputDevices.keyAt(i2));
            }
            i2++;
        }
        int[] inputDeviceIds2 = this.mInputManager.getInputDeviceIds();
        while (i < inputDeviceIds2.length) {
            onInputDeviceAdded(inputDeviceIds2[i]);
            i++;
        }
    }

    public void onInputDeviceAdded(int i) {
        if (((AndroidInputDevice) this.mInputDevices.get(i)) == null) {
            InputDevice inputDevice = this.mInputManager.getInputDevice(i);
            if (!inputDevice.isVirtual() && (inputDevice.getSources() & 16) != 0 && (inputDevice.getSources() & 1) != 0) {
                AndroidInputDevice androidInputDevice = new AndroidInputDevice(inputDevice);
                this.mInputDevices.put(i, androidInputDevice);
                OnDeviceAdded(this.mInternalReference, androidInputDevice, androidInputDevice.getUniqueId());
            }
        }
    }

    public void onInputDeviceRemoved(int i) {
        AndroidInputDevice androidInputDevice = (AndroidInputDevice) this.mInputDevices.get(i);
        if (androidInputDevice != null) {
            OnDeviceRemoved(this.mInternalReference, androidInputDevice.getUniqueId());
            this.mInputDevices.delete(i);
        }
    }

    public void onInputDeviceChanged(int i) {
        onInputDeviceRemoved(i);
        onInputDeviceAdded(i);
    }

    public boolean onKeyEvent(KeyEvent keyEvent) {
        AndroidInputDevice androidInputDevice = (AndroidInputDevice) this.mInputDevices.get(keyEvent.getDeviceId());
        if (androidInputDevice != null) {
            return androidInputDevice.onKeyEvent(keyEvent);
        }
        return false;
    }

    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        if ((motionEvent.getSource() & 16) != 0 && motionEvent.getAction() == 2) {
            AndroidInputDevice androidInputDevice = (AndroidInputDevice) this.mInputDevices.get(motionEvent.getDeviceId());
            if (androidInputDevice != null) {
                return androidInputDevice.onGenericMotionEvent(motionEvent);
            }
        }
        return false;
    }

    public void onActivityStateChanged(ActivityState activityState) {
        if (activityState == ActivityState.RESUMED) {
            listenForInputDevice(true);
        } else if (activityState == ActivityState.PAUSED) {
            listenForInputDevice(false);
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
    }
}
