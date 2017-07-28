package com.adobe.air;

import android.content.res.Configuration;
import android.graphics.ImageFormat;
import android.hardware.Camera;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.PreviewCallback;
import android.hardware.Camera.Size;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import com.adobe.air.AndroidActivityWrapper.ActivityState;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

public class AndroidCamera {
    private static final int CAMERA_POSITION_UNKNOWN = -1;
    private static final String LOG_TAG = "AndroidCamera";
    private static boolean sAreMultipleCamerasSupportedInitialized = false;
    private static boolean sAreMultipleCamerasSupportedOnDevice = false;
    private static Class<?> sCameraInfoClass = null;
    private static Method sMIDGetCameraInfo = null;
    private static Method sMIDGetNumberOfCameras = null;
    private static Method sMIDOpen = null;
    private static Method sMIDOpenWithCameraID = null;
    private StateChangeCallback mActivityStateCB = null;
    private byte[] mBuffer1 = null;
    private byte[] mBuffer2 = null;
    private byte[] mCallbackBuffer = null;
    private boolean mCallbacksRegistered = false;
    private Camera mCamera = null;
    private int mCameraId = 0;
    private boolean mCapturing = false;
    private long mClientId = 0;
    private boolean mInitialized = false;
    private boolean mPreviewSurfaceValid = true;

    class C00971 implements PreviewCallback {
        C00971() {
        }

        public void onPreviewFrame(byte[] bArr, Camera camera) {
            try {
                if (AndroidCamera.this.mClientId != 0 && AndroidCamera.this.mCallbacksRegistered) {
                    AndroidCamera.this.nativeOnFrameCaptured(AndroidCamera.this.mClientId, bArr);
                }
                if (AndroidCamera.this.mCallbackBuffer == AndroidCamera.this.mBuffer1) {
                    AndroidCamera.this.mCallbackBuffer = AndroidCamera.this.mBuffer2;
                } else {
                    AndroidCamera.this.mCallbackBuffer = AndroidCamera.this.mBuffer1;
                }
                AndroidCamera.this.mCamera.addCallbackBuffer(AndroidCamera.this.mCallbackBuffer);
            } catch (Exception e) {
            }
        }
    }

    class C00982 implements StateChangeCallback {
        C00982() {
        }

        public void onActivityStateChanged(ActivityState activityState) {
            if (AndroidCamera.this.mClientId != 0 && AndroidCamera.this.mCallbacksRegistered) {
                if (activityState == ActivityState.RESUMED && AndroidCamera.this.mPreviewSurfaceValid) {
                    AndroidCamera.this.nativeOnCanOpenCamera(AndroidCamera.this.mClientId);
                } else if (activityState == ActivityState.PAUSED) {
                    AndroidCamera.this.nativeOnShouldCloseCamera(AndroidCamera.this.mClientId);
                }
            }
        }

        public void onConfigurationChanged(Configuration configuration) {
        }
    }

    class PreviewSurfaceCallback implements Callback {
        PreviewSurfaceCallback() {
        }

        public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        }

        public void surfaceCreated(SurfaceHolder surfaceHolder) {
            AndroidCamera.this.mPreviewSurfaceValid = true;
            if (AndroidCamera.this.mClientId != 0 && AndroidCamera.this.mCallbacksRegistered) {
                AndroidCamera.this.nativeOnCanOpenCamera(AndroidCamera.this.mClientId);
            }
        }

        public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
            AndroidCamera.this.mPreviewSurfaceValid = false;
            if (AndroidCamera.this.mClientId != 0 && AndroidCamera.this.mCallbacksRegistered) {
                AndroidCamera.this.nativeOnShouldCloseCamera(AndroidCamera.this.mClientId);
            }
        }
    }

    private native void nativeOnCanOpenCamera(long j);

    private native void nativeOnFrameCaptured(long j, byte[] bArr);

    private native void nativeOnShouldCloseCamera(long j);

    public AndroidCamera(long j) {
        this.mClientId = j;
        areMultipleCamerasSupportedOnDevice();
    }

    public static boolean areMultipleCamerasSupportedOnDevice() {
        if (sAreMultipleCamerasSupportedInitialized) {
            return sAreMultipleCamerasSupportedOnDevice;
        }
        sAreMultipleCamerasSupportedInitialized = true;
        try {
            sMIDOpenWithCameraID = Camera.class.getMethod("open", new Class[]{Integer.TYPE});
            sMIDGetNumberOfCameras = Camera.class.getDeclaredMethod("getNumberOfCameras", (Class[]) null);
            try {
                sCameraInfoClass = Class.forName("android.hardware.Camera$CameraInfo");
                sMIDGetCameraInfo = Camera.class.getMethod("getCameraInfo", new Class[]{Integer.TYPE, sCameraInfoClass});
                if (!(sMIDOpenWithCameraID == null || sMIDGetNumberOfCameras == null || sMIDGetCameraInfo == null)) {
                    sAreMultipleCamerasSupportedOnDevice = true;
                }
                return sAreMultipleCamerasSupportedOnDevice;
            } catch (Exception e) {
                return false;
            }
        } catch (NoSuchMethodException e2) {
            return false;
        }
    }

    public boolean open(int i) {
        SurfaceHolder surfaceHolder;
        if (this.mCamera != null) {
            return true;
        }
        boolean z;
        try {
            SurfaceHolder holder = AndroidActivityWrapper.GetAndroidActivityWrapper().getCameraView().getHolder();
            if (holder != null) {
                try {
                    if (holder.getSurface() != null) {
                        if (sAreMultipleCamerasSupportedOnDevice) {
                            this.mCamera = (Camera) sMIDOpenWithCameraID.invoke(null, new Object[]{Integer.valueOf(i)});
                            this.mCameraId = i;
                        } else {
                            this.mCamera = Camera.open();
                            this.mCameraId = 0;
                        }
                        this.mCamera.setPreviewDisplay(holder);
                    }
                } catch (Exception e) {
                    surfaceHolder = holder;
                    if (this.mCamera != null) {
                        this.mCamera.release();
                        this.mCamera = null;
                    }
                    if (this.mCamera != null) {
                        z = false;
                    } else {
                        surfaceHolder.addCallback(new PreviewSurfaceCallback());
                        z = true;
                    }
                    return z;
                }
            }
            surfaceHolder = holder;
        } catch (Exception e2) {
            surfaceHolder = null;
            if (this.mCamera != null) {
                this.mCamera.release();
                this.mCamera = null;
            }
            if (this.mCamera != null) {
                surfaceHolder.addCallback(new PreviewSurfaceCallback());
                z = true;
            } else {
                z = false;
            }
            return z;
        }
        if (this.mCamera != null) {
            surfaceHolder.addCallback(new PreviewSurfaceCallback());
            z = true;
        } else {
            z = false;
        }
        return z;
    }

    public Camera getCamera() {
        return this.mCamera;
    }

    public int[] getSupportedFps() {
        try {
            List<Integer> supportedPreviewFrameRates = this.mCamera.getParameters().getSupportedPreviewFrameRates();
            int[] iArr = new int[supportedPreviewFrameRates.size()];
            int i = 0;
            for (Integer intValue : supportedPreviewFrameRates) {
                int i2 = i + 1;
                iArr[i] = intValue.intValue();
                i = i2;
            }
            return iArr;
        } catch (Exception e) {
            return new int[0];
        }
    }

    public int getCameraPosition() {
        Field field = null;
        int i = -1;
        if (sAreMultipleCamerasSupportedOnDevice) {
            Object newInstance;
            if (sCameraInfoClass != null) {
                try {
                    newInstance = sCameraInfoClass.newInstance();
                } catch (Exception e) {
                }
            } else {
                newInstance = null;
            }
            try {
                sMIDGetCameraInfo.invoke(this.mCamera, new Object[]{Integer.valueOf(this.mCameraId), newInstance});
                if (newInstance != null) {
                    try {
                        field = newInstance.getClass().getField("facing");
                    } catch (Exception e2) {
                    }
                }
                try {
                    i = field.getInt(newInstance);
                } catch (Exception e3) {
                }
            } catch (Exception e4) {
            }
        }
        return i;
    }

    public static int getNumberOfCameras() {
        if (areMultipleCamerasSupportedOnDevice()) {
            try {
                return ((Integer) sMIDGetNumberOfCameras.invoke(null, (Object[]) null)).intValue();
            } catch (Exception e) {
            }
        }
        return 1;
    }

    public int[] getSupportedFormats() {
        try {
            List<Integer> supportedPreviewFormats = this.mCamera.getParameters().getSupportedPreviewFormats();
            int[] iArr = new int[supportedPreviewFormats.size()];
            int i = 0;
            for (Integer intValue : supportedPreviewFormats) {
                int i2 = i + 1;
                iArr[i] = intValue.intValue();
                i = i2;
            }
            return iArr;
        } catch (Exception e) {
            return new int[0];
        }
    }

    public int[] getSupportedVideoSizes() {
        try {
            List<Size> supportedPreviewSizes = this.mCamera.getParameters().getSupportedPreviewSizes();
            int[] iArr = new int[(supportedPreviewSizes.size() * 2)];
            int i = 0;
            for (Size size : supportedPreviewSizes) {
                int i2 = i + 1;
                iArr[i] = size.width;
                i = i2 + 1;
                iArr[i2] = size.height;
            }
            return iArr;
        } catch (Exception e) {
            return new int[0];
        }
    }

    public int getCaptureWidth() {
        try {
            return this.mCamera.getParameters().getPreviewSize().width;
        } catch (Exception e) {
            return 0;
        }
    }

    public int getCaptureHeight() {
        try {
            return this.mCamera.getParameters().getPreviewSize().height;
        } catch (Exception e) {
            return 0;
        }
    }

    public int getCaptureFormat() {
        try {
            return this.mCamera.getParameters().getPreviewFormat();
        } catch (Exception e) {
            return 0;
        }
    }

    public boolean setContinuousFocusMode() {
        boolean z = true;
        if (this.mCamera == null) {
            return false;
        }
        try {
            Parameters parameters = this.mCamera.getParameters();
            List supportedFocusModes = parameters.getSupportedFocusModes();
            if (supportedFocusModes.contains("continuous-video")) {
                parameters.setFocusMode("continuous-video");
                this.mCamera.setParameters(parameters);
            } else if (supportedFocusModes.contains("edof")) {
                parameters.setFocusMode("edof");
                this.mCamera.setParameters(parameters);
            } else {
                z = false;
            }
        } catch (Exception e) {
            z = false;
        }
        return z;
    }

    public boolean autoFocus() {
        if (this.mCamera == null || !this.mCapturing) {
            return false;
        }
        try {
            String focusMode = this.mCamera.getParameters().getFocusMode();
            if (focusMode == "fixed" || focusMode == "infinity" || focusMode == "continuous-video") {
                return false;
            }
            this.mCamera.autoFocus(null);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean startCapture(int i, int i2, int i3, int i4) {
        if (this.mCamera == null) {
            return false;
        }
        try {
            Parameters parameters = this.mCamera.getParameters();
            parameters.setPreviewSize(i, i2);
            parameters.setPreviewFrameRate(i3);
            parameters.setPreviewFormat(i4);
            this.mCamera.setParameters(parameters);
            this.mCamera.setPreviewCallbackWithBuffer(new C00971());
            this.mCamera.startPreview();
            parameters = this.mCamera.getParameters();
            int bitsPerPixel = ImageFormat.getBitsPerPixel(parameters.getPreviewFormat()) * (parameters.getPreviewSize().width * parameters.getPreviewSize().height);
            this.mBuffer1 = new byte[bitsPerPixel];
            this.mBuffer2 = new byte[bitsPerPixel];
            this.mCallbackBuffer = this.mBuffer1;
            this.mCamera.addCallbackBuffer(this.mCallbackBuffer);
            try {
                this.mCapturing = true;
                return true;
            } catch (Exception e) {
                return true;
            }
        } catch (Exception e2) {
            return false;
        }
    }

    public void stopCapture() {
        if (this.mCamera != null) {
            this.mCamera.setPreviewCallback(null);
            this.mCamera.stopPreview();
            this.mCallbackBuffer = null;
            this.mBuffer1 = null;
            this.mBuffer2 = null;
        }
        this.mCapturing = false;
    }

    public void close() {
        if (this.mCamera != null) {
            stopCapture();
            this.mCamera.release();
            this.mCamera = null;
        }
    }

    public void registerCallbacks(boolean z) {
        this.mCallbacksRegistered = z;
        if (z) {
            if (this.mActivityStateCB == null) {
                this.mActivityStateCB = new C00982();
            }
            AndroidActivityWrapper.GetAndroidActivityWrapper().addActivityStateChangeListner(this.mActivityStateCB);
            return;
        }
        if (this.mActivityStateCB != null) {
            AndroidActivityWrapper.GetAndroidActivityWrapper().removeActivityStateChangeListner(this.mActivityStateCB);
        }
        this.mActivityStateCB = null;
    }
}
