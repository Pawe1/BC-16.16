package com.adobe.air.wand;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build.VERSION;
import android.os.SystemClock;
import android.os.Vibrator;
import android.util.Base64;
import android.view.Display;
import com.adobe.air.TouchEventData;
import com.adobe.air.wand.message.Message;
import com.adobe.air.wand.message.MessageDataArray;
import com.adobe.air.wand.message.MessageDataObject;
import com.adobe.air.wand.message.MessageManager;
import com.adobe.air.wand.message.Notification;
import com.adobe.air.wand.message.Request;
import com.adobe.air.wand.message.Response;
import com.adobe.air.wand.message.Response.Status;
import com.adobe.air.wand.motionsensor.Accelerometer;
import com.adobe.air.wand.motionsensor.Gyroscope;
import com.adobe.air.wand.motionsensor.Magnetometer;
import com.adobe.air.wand.view.GestureEventData;
import com.adobe.air.wand.view.TouchSensor;
import com.adobe.air.wand.view.WandView.ScreenOrientation;
import java.util.ArrayList;
import java.util.Date;

public class TaskManager {
    protected static final String GESTURE_PHASE_ALL = "ALL";
    protected static final String GESTURE_PHASE_BEGIN = "BEGIN";
    protected static final String GESTURE_PHASE_END = "END";
    protected static final String GESTURE_PHASE_UPDATE = "UPDATE";
    protected static final String GESTURE_TYPE_PAN = "GESTURE_PAN";
    protected static final String GESTURE_TYPE_ROTATE = "GESTURE_ROTATE";
    protected static final String GESTURE_TYPE_SWIPE = "GESTURE_SWIPE";
    protected static final String GESTURE_TYPE_TWO_FINGER_TAP = "GESTURE_TWO_FINGER_TAP";
    protected static final String GESTURE_TYPE_ZOOM = "GESTURE_ZOOM";
    private static final String LOG_TAG = "TaskManager";
    protected static final int MOTION_SENSOR_MINIMUM_INTERVAL = 16;
    protected static final String NAME_NOTIFICATION_ACCELEROMETER = "accelerometer";
    protected static final String NAME_NOTIFICATION_ACCELEROMETER_DATA = "acc";
    protected static final String NAME_NOTIFICATION_DURATION = "duration";
    protected static final String NAME_NOTIFICATION_GYROSCOPE = "gyroscope";
    protected static final String NAME_NOTIFICATION_GYROSCOPE_DATA = "gyro";
    protected static final String NAME_NOTIFICATION_INTERVAL = "interval";
    protected static final String NAME_NOTIFICATION_IS_PRIMARY_TOUCH_POINT = "isPrimaryTouchPoint";
    protected static final String NAME_NOTIFICATION_IS_TRANSFORM = "isTransform";
    protected static final String NAME_NOTIFICATION_LOCAL_X = "localX";
    protected static final String NAME_NOTIFICATION_LOCAL_Y = "localY";
    protected static final String NAME_NOTIFICATION_MAGNETOMETER = "magnetometer";
    protected static final String NAME_NOTIFICATION_MAGNETOMETER_DATA = "mag";
    protected static final String NAME_NOTIFICATION_MESSAGE = "message";
    protected static final String NAME_NOTIFICATION_OFFSET_X = "offsetX";
    protected static final String NAME_NOTIFICATION_OFFSET_Y = "offsetY";
    protected static final String NAME_NOTIFICATION_PHASE = "phase";
    protected static final String NAME_NOTIFICATION_PRESSURE = "pressure";
    protected static final String NAME_NOTIFICATION_ROTATION = "rotation";
    protected static final String NAME_NOTIFICATION_SCALE_X = "scaleX";
    protected static final String NAME_NOTIFICATION_SCALE_Y = "scaleY";
    protected static final String NAME_NOTIFICATION_SCREEN_DIMENSIONS = "screenDimensions";
    protected static final String NAME_NOTIFICATION_SIZE_X = "sizeX";
    protected static final String NAME_NOTIFICATION_SIZE_Y = "sizeY";
    protected static final String NAME_NOTIFICATION_START = "start";
    protected static final String NAME_NOTIFICATION_TIMESTAMP = "timestamp";
    protected static final String NAME_NOTIFICATION_TOUCH_POINT_ID = "touchPointID";
    protected static final String NAME_NOTIFICATION_TYPE = "type";
    protected static final String NAME_NOTIFICATION_VIBRATOR = "vibrator";
    protected static final String SCREEN_DIMENSIONS_HEIGHT = "height";
    protected static final String SCREEN_DIMENSIONS_WIDTH = "width";
    protected static final String TOUCH_TYPE_BEGIN = "TOUCH_BEGIN";
    protected static final String TOUCH_TYPE_END = "TOUCH_END";
    protected static final String TOUCH_TYPE_MOVE = "TOUCH_MOVE";
    private final Accelerometer mAccelerometer;
    private final Display mDisplay;
    private final Gyroscope mGyroscope;
    private Listener mListener = null;
    private final Magnetometer mMagnetometer;
    private final MessageManager mMessageManager;
    private final TouchSensor mTouchSensor;
    private final Vibrator mVibrator;

    class C01461 implements com.adobe.air.wand.view.TouchSensor.Listener {
        C01461() {
        }

        public void onTouchEvent(TouchEventData touchEventData) {
            TaskManager.this.sendTouchEventData(touchEventData);
        }

        public void onGestureEvent(GestureEventData gestureEventData) {
            TaskManager.this.sendGestureEventData(gestureEventData);
        }
    }

    class C01472 implements com.adobe.air.wand.motionsensor.MotionSensor.Listener {
        C01472() {
        }

        public void onSensorChanged(float[] fArr, long j) {
            TaskManager.this.sendMotionSensorData(fArr, j, TaskManager.NAME_NOTIFICATION_ACCELEROMETER_DATA, MessageTitle.ACCELEROMETER_EVENT);
        }
    }

    class C01483 implements com.adobe.air.wand.motionsensor.MotionSensor.Listener {
        C01483() {
        }

        public void onSensorChanged(float[] fArr, long j) {
            TaskManager.this.sendMotionSensorData(fArr, j, TaskManager.NAME_NOTIFICATION_MAGNETOMETER_DATA, MessageTitle.MAGNETOMETER_EVENT);
        }
    }

    class C01494 implements com.adobe.air.wand.motionsensor.MotionSensor.Listener {
        C01494() {
        }

        public void onSensorChanged(float[] fArr, long j) {
            TaskManager.this.sendMotionSensorData(fArr, j, TaskManager.NAME_NOTIFICATION_GYROSCOPE_DATA, MessageTitle.GYROSCOPE_EVENT);
        }
    }

    public interface Listener {
        void drawImage(Bitmap bitmap) throws Exception;

        String getRequestedProtocolVerison() throws Exception;

        void sendConnectionMessage(String str) throws Exception;

        void setScreenOrientation(ScreenOrientation screenOrientation) throws Exception;
    }

    public enum MessageTitle {
        ACCELEROMETER_EVENT("ACCELEROMETER_EVENT"),
        MAGNETOMETER_EVENT("MAGNETOMETER_EVENT"),
        GYROSCOPE_EVENT("GYROSCOPE_EVENT"),
        TOUCH_EVENT("TOUCH_EVENT"),
        GESTURE_EVENT("GESTURE_EVENT"),
        VIBRATE("VIBRATE"),
        DRAW_IMAGE("DRAW_IMAGE"),
        HARDWARE_SPECIFICATIONS("HARDWARE_SPECIFICATIONS"),
        ERROR_LOG("ERROR_LOG");
        
        private final String mTitle;

        private MessageTitle(String str) {
            this.mTitle = str;
        }

        public String toString() {
            return this.mTitle;
        }
    }

    public TaskManager(MessageManager messageManager, Display display, TouchSensor touchSensor, Accelerometer accelerometer, Magnetometer magnetometer, Gyroscope gyroscope, Vibrator vibrator) throws Exception {
        if (messageManager == null) {
            throw new Exception("Invalid MessageManager");
        }
        this.mMessageManager = messageManager;
        if (accelerometer == null) {
            throw new Exception("Invalid Accelerometer");
        }
        this.mAccelerometer = accelerometer;
        if (magnetometer == null) {
            throw new Exception("Invalid Magnetometer");
        }
        this.mMagnetometer = magnetometer;
        if (gyroscope == null) {
            throw new Exception("Invalid Gyroscope");
        }
        this.mGyroscope = gyroscope;
        this.mVibrator = vibrator;
        if (display == null) {
            throw new Exception("Invalid Display");
        }
        this.mDisplay = display;
        if (touchSensor == null) {
            throw new Exception("Invalid TouchSensor");
        }
        this.mTouchSensor = touchSensor;
        this.mTouchSensor.setListener(new C01461());
        this.mAccelerometer.setListener(new C01472());
        this.mMagnetometer.setListener(new C01483());
        this.mGyroscope.setListener(new C01494());
    }

    private String[] getGesturePhases(int i) {
        ArrayList arrayList = new ArrayList();
        if ((i & 2) != 0) {
            arrayList.add(GESTURE_PHASE_BEGIN);
        }
        if ((i & 1) != 0) {
            arrayList.add(GESTURE_PHASE_UPDATE);
        }
        if ((i & 4) != 0) {
            arrayList.add(GESTURE_PHASE_END);
        }
        if ((i & 8) != 0) {
            arrayList.add(GESTURE_PHASE_ALL);
        }
        return (String[]) arrayList.toArray(new String[0]);
    }

    private void sendGestureEventData(GestureEventData gestureEventData) {
        String[] gesturePhases = getGesturePhases(gestureEventData.mPhase);
        for (String put : gesturePhases) {
            try {
                MessageDataObject createDataObject = this.mMessageManager.createDataObject();
                createDataObject.put(NAME_NOTIFICATION_PHASE, put);
                switch (gestureEventData.mType) {
                    case 0:
                        createDataObject.put(NAME_NOTIFICATION_TYPE, GESTURE_TYPE_ZOOM);
                        break;
                    case 1:
                        createDataObject.put(NAME_NOTIFICATION_TYPE, GESTURE_TYPE_PAN);
                        break;
                    case 2:
                        createDataObject.put(NAME_NOTIFICATION_TYPE, GESTURE_TYPE_ROTATE);
                        break;
                    case 3:
                        createDataObject.put(NAME_NOTIFICATION_TYPE, GESTURE_TYPE_TWO_FINGER_TAP);
                        break;
                    case 4:
                        createDataObject.put(NAME_NOTIFICATION_TYPE, GESTURE_TYPE_SWIPE);
                        break;
                }
                createDataObject.put(NAME_NOTIFICATION_IS_TRANSFORM, gestureEventData.mIsTransform);
                createDataObject.put(NAME_NOTIFICATION_LOCAL_X, (double) gestureEventData.mXCoord);
                createDataObject.put(NAME_NOTIFICATION_LOCAL_Y, (double) gestureEventData.mYCoord);
                createDataObject.put(NAME_NOTIFICATION_SCALE_X, (double) gestureEventData.mScaleX);
                createDataObject.put(NAME_NOTIFICATION_SCALE_Y, (double) gestureEventData.mScaleY);
                createDataObject.put(NAME_NOTIFICATION_ROTATION, (double) gestureEventData.mRotation);
                createDataObject.put(NAME_NOTIFICATION_OFFSET_X, (double) gestureEventData.mOffsetX);
                createDataObject.put(NAME_NOTIFICATION_OFFSET_Y, (double) gestureEventData.mOffsetY);
                createDataObject.put(NAME_NOTIFICATION_TIMESTAMP, new Date().getTime());
                String createSerializedNotification = this.mMessageManager.createSerializedNotification(MessageTitle.GESTURE_EVENT.toString(), createDataObject);
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedNotification);
                }
            } catch (Exception e) {
            }
        }
    }

    private String[] getTouchTypes(int i) {
        ArrayList arrayList = new ArrayList();
        if ((i & 2) != 0) {
            arrayList.add(TOUCH_TYPE_BEGIN);
        }
        if ((i & 1) != 0) {
            arrayList.add(TOUCH_TYPE_MOVE);
        }
        if ((i & 4) != 0) {
            arrayList.add(TOUCH_TYPE_END);
        }
        return (String[]) arrayList.toArray(new String[0]);
    }

    private void sendTouchEventData(TouchEventData touchEventData) {
        String[] touchTypes = getTouchTypes(touchEventData.mTouchEventType);
        for (String put : touchTypes) {
            try {
                MessageDataObject createDataObject = this.mMessageManager.createDataObject();
                createDataObject.put(NAME_NOTIFICATION_TYPE, put);
                createDataObject.put(NAME_NOTIFICATION_IS_PRIMARY_TOUCH_POINT, touchEventData.mIsPrimaryPoint);
                createDataObject.put(NAME_NOTIFICATION_LOCAL_X, (double) touchEventData.mXCoord);
                createDataObject.put(NAME_NOTIFICATION_LOCAL_Y, (double) touchEventData.mYCoord);
                createDataObject.put(NAME_NOTIFICATION_PRESSURE, (double) touchEventData.mPressure);
                createDataObject.put(NAME_NOTIFICATION_SIZE_X, (double) touchEventData.mContactX);
                createDataObject.put(NAME_NOTIFICATION_SIZE_Y, (double) touchEventData.mContactY);
                createDataObject.put(NAME_NOTIFICATION_TOUCH_POINT_ID, touchEventData.mPointerID);
                createDataObject.put(NAME_NOTIFICATION_TIMESTAMP, new Date().getTime());
                String createSerializedNotification = this.mMessageManager.createSerializedNotification(MessageTitle.TOUCH_EVENT.toString(), createDataObject);
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedNotification);
                }
            } catch (Exception e) {
            }
        }
    }

    private void sendMotionSensorData(float[] fArr, long j, String str, MessageTitle messageTitle) {
        try {
            MessageDataObject createDataObject = this.mMessageManager.createDataObject();
            long currentTimeMillis = System.currentTimeMillis() - SystemClock.uptimeMillis();
            MessageDataArray createDataArray = this.mMessageManager.createDataArray();
            int i = 0;
            while (i < fArr.length) {
                createDataArray.put(i, (double) fArr[i]);
                i++;
            }
            createDataArray.put(i, currentTimeMillis + (j / 1000000));
            createDataObject.put(str, createDataArray);
            String createSerializedNotification = this.mMessageManager.createSerializedNotification(messageTitle.toString(), createDataObject);
            if (this.mListener != null) {
                this.mListener.sendConnectionMessage(createSerializedNotification);
            }
        } catch (Exception e) {
        }
    }

    public void registerListener(Listener listener) throws Exception {
        if (listener == null) {
            throw new Exception("Invalid listener");
        } else if (this.mListener != null) {
            throw new Exception("A listener is already registered");
        } else {
            this.mListener = listener;
        }
    }

    public void unregisterListener() {
        this.mListener = null;
    }

    private void sendLogNotification(String str) {
        if (str != null && !str.equals("")) {
            MessageDataObject createDataObject = this.mMessageManager.createDataObject();
            try {
                createDataObject.put("message", str);
                String createSerializedNotification = this.mMessageManager.createSerializedNotification(MessageTitle.ERROR_LOG.toString(), createDataObject);
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedNotification);
                }
            } catch (Exception e) {
            }
        }
    }

    public void handleRemoteMessage(String str) {
        try {
            Message deserializeWandMessage = this.mMessageManager.deserializeWandMessage(str);
            switch (deserializeWandMessage.getHeader().getType()) {
                case REQUEST:
                    handleRemoteRequest((Request) deserializeWandMessage);
                    return;
                case RESPONSE:
                    handleRemoteResponse((Response) deserializeWandMessage);
                    return;
                case NOTIFICATION:
                    handleRemoteNotification((Notification) deserializeWandMessage);
                    return;
                default:
                    return;
            }
        } catch (Exception e) {
            if (str == null) {
                str = "null";
            }
            sendLogNotification("Invalid message : \"" + str + "\"");
        }
        if (str == null) {
            str = "null";
        }
        sendLogNotification("Invalid message : \"" + str + "\"");
    }

    private void handleRemoteRequest(Request request) {
        String title = request.getHeader().getTitle();
        if (title.equals(MessageTitle.DRAW_IMAGE.toString())) {
            handleDrawImageRequest(request);
        } else if (title.equals(MessageTitle.HARDWARE_SPECIFICATIONS.toString())) {
            handleHardwareSpecsRequest(request);
        } else {
            sendLogNotification("Unsupported REQUEST title : " + title);
        }
    }

    private void handleRemoteResponse(Response response) {
        sendLogNotification("Unsupported RESPONSE title : " + response.getHeader().getTitle());
    }

    private boolean isOrAboveV1_1_0() throws Exception {
        return this.mListener != null && Version.isGreaterThanEqualTo(this.mListener.getRequestedProtocolVerison(), "1.1.0");
    }

    private void handleRemoteNotification(Notification notification) throws Exception {
        String title = notification.getHeader().getTitle();
        if (title.equals(MessageTitle.VIBRATE.toString())) {
            handleRemoteVibrateNotification(notification);
        } else if (title.equals(MessageTitle.ACCELEROMETER_EVENT.toString())) {
            handleRemoteAccelerometerEventNotification(notification);
        } else if (isOrAboveV1_1_0() && title.equals(MessageTitle.MAGNETOMETER_EVENT.toString())) {
            handleRemoteMagnetometerEventNotification(notification);
        } else if (isOrAboveV1_1_0() && title.equals(MessageTitle.GYROSCOPE_EVENT.toString())) {
            handleRemoteGyroscopeEventNotification(notification);
        } else if (title.equals(MessageTitle.TOUCH_EVENT.toString())) {
            handleRemoteTouchNotification(notification);
        } else if (title.equals(MessageTitle.GESTURE_EVENT.toString())) {
            handleRemoteGestureNotification(notification);
        } else {
            sendLogNotification("Unsupported NOTIFICATION title : " + title);
        }
    }

    void terminateRunningTasks() {
        if (this.mAccelerometer.active()) {
            this.mAccelerometer.stop();
        }
        if (this.mMagnetometer.active()) {
            this.mMagnetometer.stop();
        }
        if (this.mGyroscope.active()) {
            this.mGyroscope.stop();
        }
        if (this.mTouchSensor.activeTouchListening()) {
            this.mTouchSensor.stopTouchEventListening();
        }
        if (this.mTouchSensor.activeGestureListening()) {
            this.mTouchSensor.stopGestureEventListening();
        }
        if (this.mVibrator != null) {
            this.mVibrator.cancel();
        }
    }

    private void handleRemoteAccelerometerEventNotification(Notification notification) {
        try {
            if (this.mAccelerometer.available()) {
                MessageDataObject messageDataObject = (MessageDataObject) notification.getData().getNotification();
                if (messageDataObject.getBoolean(NAME_NOTIFICATION_START)) {
                    if (this.mAccelerometer.active()) {
                        sendLogNotification("Already started accelerometer event updates");
                        return;
                    }
                    int i = messageDataObject.getInt(NAME_NOTIFICATION_INTERVAL);
                    if (i < 16) {
                        i = 16;
                    }
                    this.mAccelerometer.start(i);
                    return;
                } else if (this.mAccelerometer.active()) {
                    this.mAccelerometer.stop();
                    return;
                } else {
                    sendLogNotification("Already stopped accelerometer event updates");
                    return;
                }
            }
            sendLogNotification("The device does not have an accelerometer");
        } catch (Exception e) {
            sendLogNotification("Invalid ACCELEROMETER_EVENT notification");
        }
    }

    private void handleRemoteMagnetometerEventNotification(Notification notification) {
        try {
            if (this.mMagnetometer.available()) {
                MessageDataObject messageDataObject = (MessageDataObject) notification.getData().getNotification();
                if (messageDataObject.getBoolean(NAME_NOTIFICATION_START)) {
                    if (this.mMagnetometer.active()) {
                        sendLogNotification("Already started magnetometer event updates");
                        return;
                    }
                    int i = messageDataObject.getInt(NAME_NOTIFICATION_INTERVAL);
                    if (i < 16) {
                        i = 16;
                    }
                    this.mMagnetometer.start(i);
                    return;
                } else if (this.mMagnetometer.active()) {
                    this.mMagnetometer.stop();
                    return;
                } else {
                    sendLogNotification("Already stopped magnetometer event updates");
                    return;
                }
            }
            sendLogNotification("The device does not have an magnetometer");
        } catch (Exception e) {
            sendLogNotification("Invalid MAGNETOMETER_EVENT notification");
        }
    }

    private void handleRemoteGyroscopeEventNotification(Notification notification) {
        try {
            if (this.mGyroscope.available()) {
                MessageDataObject messageDataObject = (MessageDataObject) notification.getData().getNotification();
                if (messageDataObject.getBoolean(NAME_NOTIFICATION_START)) {
                    if (this.mGyroscope.active()) {
                        sendLogNotification("Already started gyroscope event updates");
                        return;
                    }
                    int i = messageDataObject.getInt(NAME_NOTIFICATION_INTERVAL);
                    if (i < 16) {
                        i = 16;
                    }
                    this.mGyroscope.start(i);
                    return;
                } else if (this.mGyroscope.active()) {
                    this.mGyroscope.stop();
                    return;
                } else {
                    sendLogNotification("Already stopped gyroscope event updates");
                    return;
                }
            }
            sendLogNotification("The device does not have a gyroscope");
        } catch (Exception e) {
            sendLogNotification("Invalid GYROSCOPE_EVENT notification");
        }
    }

    private void handleRemoteTouchNotification(Notification notification) {
        try {
            if (((MessageDataObject) notification.getData().getNotification()).getBoolean(NAME_NOTIFICATION_START)) {
                if (this.mTouchSensor.activeTouchListening()) {
                    sendLogNotification("Already started touch event updates");
                } else {
                    this.mTouchSensor.startTouchEventListening();
                }
            } else if (this.mTouchSensor.activeTouchListening()) {
                this.mTouchSensor.stopTouchEventListening();
            } else {
                sendLogNotification("Already stopped touch event updates");
            }
        } catch (Exception e) {
            sendLogNotification("Invalid TOUCH_EVENT notification");
        }
    }

    private void handleRemoteGestureNotification(Notification notification) {
        try {
            if (((MessageDataObject) notification.getData().getNotification()).getBoolean(NAME_NOTIFICATION_START)) {
                if (this.mTouchSensor.activeGestureListening()) {
                    sendLogNotification("Already started gesture event updates");
                } else {
                    this.mTouchSensor.startGestureEventListening();
                }
            } else if (this.mTouchSensor.activeGestureListening()) {
                this.mTouchSensor.stopGestureEventListening();
            } else {
                sendLogNotification("Already stopped gesture event updates");
            }
        } catch (Exception e) {
            sendLogNotification("Invalid GESTURE_EVENT notification");
        }
    }

    private boolean hasVibrator() {
        if (this.mVibrator == null || VERSION.SDK_INT < 14) {
            return this.mVibrator != null;
        } else {
            return this.mVibrator.hasVibrator();
        }
    }

    private void handleHardwareSpecsRequest(Request request) {
        String createSerializedResponse;
        try {
            MessageDataObject createDataObject = this.mMessageManager.createDataObject();
            boolean available = this.mAccelerometer.available();
            boolean available2 = this.mMagnetometer.available();
            boolean available3 = this.mGyroscope.available();
            Display display = this.mDisplay;
            MessageDataObject createDataObject2 = this.mMessageManager.createDataObject();
            int width = display.getWidth();
            int height = display.getHeight();
            createDataObject2.put(SCREEN_DIMENSIONS_WIDTH, width);
            createDataObject2.put(SCREEN_DIMENSIONS_HEIGHT, height);
            createDataObject.put(NAME_NOTIFICATION_SCREEN_DIMENSIONS, createDataObject2);
            createDataObject.put(NAME_NOTIFICATION_ACCELEROMETER, available);
            createDataObject.put(NAME_NOTIFICATION_VIBRATOR, hasVibrator());
            if (isOrAboveV1_1_0()) {
                createDataObject.put(NAME_NOTIFICATION_MAGNETOMETER, available2);
                createDataObject.put(NAME_NOTIFICATION_GYROSCOPE, available3);
            }
            createSerializedResponse = this.mMessageManager.createSerializedResponse(request, Status.SUCCESS, createDataObject);
            if (this.mListener != null) {
                this.mListener.sendConnectionMessage(createSerializedResponse);
            }
        } catch (Exception e) {
            try {
                createSerializedResponse = this.mMessageManager.createSerializedErrorResponse(request, e.getMessage());
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedResponse);
                }
            } catch (Exception e2) {
                sendLogNotification("Invalid HARDWARE_SPECIFICATIONS request");
            }
        }
    }

    private void handleRemoteVibrateNotification(Notification notification) {
        try {
            long j = ((MessageDataObject) notification.getData().getNotification()).getLong(NAME_NOTIFICATION_DURATION);
            if (j <= 0) {
                sendLogNotification("Invalid vibrate duration.");
            } else if (hasVibrator()) {
                this.mVibrator.vibrate(j);
            } else {
                sendLogNotification("Device does not support vibration");
            }
        } catch (Exception e) {
            sendLogNotification("Invalid VIBRATE notification");
        }
    }

    private void handleDrawImageRequest(Request request) {
        String createSerializedSuccessResponse;
        try {
            byte[] decode = Base64.decode(request.getData().getArguments().getString(0), 0);
            if (decode.length >= 4 && decode[0] == (byte) -1 && decode[1] == (byte) -40 && decode[2] == (byte) -1) {
                Bitmap decodeByteArray = BitmapFactory.decodeByteArray(decode, 0, decode.length);
                if (decodeByteArray == null) {
                    throw new Exception("Unable to decode the image");
                }
                if (this.mListener != null) {
                    this.mListener.drawImage(decodeByteArray);
                }
                createSerializedSuccessResponse = this.mMessageManager.createSerializedSuccessResponse(request);
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedSuccessResponse);
                    return;
                }
                return;
            }
            throw new Exception("Unsupported image format");
        } catch (Exception e) {
            try {
                createSerializedSuccessResponse = this.mMessageManager.createSerializedErrorResponse(request, e.getMessage());
                if (this.mListener != null) {
                    this.mListener.sendConnectionMessage(createSerializedSuccessResponse);
                }
            } catch (Exception e2) {
                sendLogNotification("Invalid DRAW_IMAGE request");
            }
        }
    }
}
