package com.adobe.air;

import android.view.InputDevice;
import android.view.InputDevice.MotionRange;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.MotionEvent;
import com.sigmasport.misc.Constant;
import java.util.ArrayList;
import java.util.List;

/* compiled from: AndroidInputManager */
class AndroidInputDevice {
    private InputDevice mDevice = null;
    private List<AndroidInputControl> mInputControls = null;
    private int mNumControls = 0;

    public AndroidInputDevice(InputDevice inputDevice) {
        this.mDevice = inputDevice;
        this.mInputControls = new ArrayList();
        for (MotionRange motionRange : inputDevice.getMotionRanges()) {
            if ((motionRange.getSource() & 16) != 0) {
                this.mInputControls.add(new AndroidInputControl(ControlType.AXIS, motionRange.getAxis(), motionRange.getMin(), motionRange.getMax()));
                this.mNumControls++;
            }
        }
        int i = 0;
        while (i < KeyEvent.getMaxKeyCode()) {
            if (KeyCharacterMap.deviceHasKey(i) && isGameKey(i)) {
                this.mInputControls.add(new AndroidInputControl(ControlType.BUTTON, i, 0.0f, 1.0f));
                this.mNumControls++;
            }
            i++;
        }
    }

    public String getName() {
        return this.mDevice.getName();
    }

    public String getUniqueId() {
        return this.mDevice.getDescriptor();
    }

    public int getNumControls() {
        return this.mNumControls;
    }

    public AndroidInputControl getInputControl(int i) {
        return (AndroidInputControl) this.mInputControls.get(i);
    }

    private static boolean isGameKey(int i) {
        switch (i) {
            case Constant.EEPROM_USER_DATA_ADDR_18 /*19*/:
            case 20:
            case Constant.EEPROM_USER_DATA_ADDR_1A /*21*/:
            case 22:
            case Constant.EEPROM_USER_DATA_ADDR_1C /*23*/:
                return true;
            default:
                return KeyEvent.isGamepadButton(i);
        }
    }

    public boolean onKeyEvent(KeyEvent keyEvent) {
        for (int i = 0; i < this.mInputControls.size(); i++) {
            AndroidInputControl androidInputControl = (AndroidInputControl) this.mInputControls.get(i);
            if (androidInputControl.getType() == ControlType.BUTTON.ordinal() && androidInputControl.getCode() == keyEvent.getKeyCode()) {
                switch (keyEvent.getAction()) {
                    case 0:
                        androidInputControl.setData(1.0f);
                        return true;
                    case 1:
                        androidInputControl.setData(0.0f);
                        return true;
                    default:
                        break;
                }
            }
        }
        return false;
    }

    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        for (int i = 0; i < this.mInputControls.size(); i++) {
            AndroidInputControl androidInputControl = (AndroidInputControl) this.mInputControls.get(i);
            if (androidInputControl.getType() == ControlType.AXIS.ordinal()) {
                androidInputControl.setData(motionEvent.getAxisValue(androidInputControl.getCode()));
            }
        }
        return true;
    }
}
