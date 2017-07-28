package com.adobe.air;

import android.app.Activity;
import android.app.Application;
import android.app.Dialog;
import android.app.KeyguardManager;
import android.app.UiModeManager;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Configuration;
import android.content.res.Resources.Theme;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.media.AudioManager;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.util.AttributeSet;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.view.View;
import android.view.WindowManager.LayoutParams;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import com.adobe.air.telephony.AndroidTelephonyManager;
import com.adobe.air.utils.Utils;
import com.adobe.flashplayer.HDMIUtils;
import com.facebook.internal.ServerProtocol;
import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AndroidActivityWrapper {
    private static final String ADOBE_COM = "adobe.com";
    private static final int ASPECT_RATIO_ANY = 3;
    private static final int ASPECT_RATIO_LANDSCAPE = 2;
    private static final int ASPECT_RATIO_PORTRAIT = 1;
    public static final int IMAGE_PICKER_REQUEST_CODE = 2;
    private static final int INVOKE_EVENT_OPEN_URL = 1;
    private static final int INVOKE_EVENT_STANDARD = 0;
    private static final String LOG_TAG = "AndroidActivityWrapper";
    public static final int STILL_PICTURE_REQUEST_CODE = 3;
    public static final int VIDEO_CAPTURE_REQUEST_CODE = 4;
    public static final int WEBVIEW_UPLOAD_FILE_CHOOSER_CODE = 5;
    private static final String WWW_ADOBE_COM = "www.adobe.com";
    private static boolean mIsAndroidTV = false;
    private static AndroidActivityWrapper sActivityWrapper = null;
    private static AndroidTelephonyManager sAndroidTelephonyManager = null;
    private static boolean sApplicationLaunched = false;
    private static boolean sDepthAndStencil = false;
    private static Entrypoints sEntryPoint = null;
    private static String sGamePreviewHost = "";
    private static boolean sHasCaptiveRuntime = false;
    private static AndroidIdleState sIdleStateManager = null;
    private static boolean sIsSwfPreviewMode = false;
    private static boolean sRuntimeLibrariesLoaded = false;
    private int debuggerPort = -1;
    private KeyguardManager keyGuardManager = null;
    private boolean mActivateEventPending = false;
    private List<ActivityResultCallback> mActivityResultListeners = null;
    private ActivityState mActivityState = ActivityState.STARTED;
    private List<StateChangeCallback> mActivityStateListeners = null;
    private ConfigDownloadListener mConfigDownloadListener = null;
    private boolean mContainsVideo = false;
    private DebuggerSettings mDebuggerSettings = new DebuggerSettings();
    private boolean mDisplayWaitingDialog = false;
    private String mExtraArgs = null;
    private boolean mFullScreenSetFromMetaData = false;
    private int mHardKeyboardHidden = 2;
    private int mHardKeyboardType = 0;
    private List<InputEventCallback> mInputEventListeners = null;
    private boolean mInvokeEventPendingFromOnCreate = false;
    private boolean mIsADL = false;
    private boolean mIsDebuggerMode = false;
    private boolean mIsFullScreen = false;
    private String mLibCorePath = null;
    private OrientationManager mOrientationManager = null;
    private boolean mRGB565Override = false;
    private String mRootDir = null;
    private boolean mScreenOn = true;
    private boolean mShowDebuggerDialog = false;
    private String mXmlPath = null;
    private Activity m_activity = null;
    private Application m_application = null;
    private AndroidCameraView m_cameraView = null;
    private FlashEGL m_flashEGL = null;
    private FrameLayout m_layout = null;
    private AIRWindowSurfaceView m_mainView = null;
    private Condition m_newActivityCondition = null;
    private Lock m_newActivityLock = null;
    private RelativeLayout m_overlaysLayout = null;
    private boolean m_planeBreakCascade = false;
    private boolean m_planeCascadeInit = false;
    private int m_planeCascadeStep = 0;
    private List<SurfaceView> m_planes = null;
    private Context m_runtimeContext = null;
    private boolean m_skipKickCascade = true;
    private SurfaceView m_videoView = null;

    interface ActivityResultCallback {
        void onActivityResult(int i, int i2, Intent intent);
    }

    public enum ActivityState {
        STARTED,
        RESTARTED,
        RESUMED,
        PAUSED,
        STOPPED,
        DESTROYED
    }

    private enum DebugMode {
        None,
        ConnectMode,
        ListenMode,
        ConflictMode
    }

    interface InputEventCallback {
        boolean onGenericMotionEvent(MotionEvent motionEvent);

        boolean onKeyEvent(KeyEvent keyEvent);
    }

    public static class PlaneID {
        public static final int PLANE_CAMERA = 5;
        public static final int PLANE_COUNT = 8;
        public static final int PLANE_FLASH = 3;
        public static final int PLANE_OVERLAY = 2;
        public static final int PLANE_STAGE3D = 6;
        public static final int PLANE_STAGETEXT = 1;
        public static final int PLANE_STAGEVIDEO = 7;
        public static final int PLANE_STAGEVIDEOAUTOMATIC = 4;
        public static final int PLANE_STAGEWEBVIEW = 0;
    }

    interface StateChangeCallback {
        void onActivityStateChanged(ActivityState activityState);

        void onConfigurationChanged(Configuration configuration);
    }

    private native void nativeActivateEvent();

    private native void nativeDeactivateEvent();

    private native void nativeLowMemoryEvent();

    private native void nativeOnFocusListener(boolean z);

    private native void nativeSendInvokeEventWithData(String str, String str2, int i);

    private native void nativeSetVisible(boolean z);

    public boolean isScreenOn() {
        return this.mScreenOn;
    }

    public boolean isScreenLocked() {
        return this.keyGuardManager.inKeyguardRestrictedInputMode();
    }

    public boolean isResumed() {
        return this.mActivityState == ActivityState.RESUMED;
    }

    public boolean isStarted() {
        return this.mActivityState == ActivityState.STARTED || this.mActivityState == ActivityState.RESTARTED;
    }

    public static boolean isGingerbread() {
        return VERSION.SDK_INT >= 9;
    }

    public static boolean isHoneycomb() {
        return VERSION.SDK_INT >= 11;
    }

    public static boolean isIceCreamSandwich() {
        return VERSION.SDK_INT >= 14;
    }

    public static boolean isJellybean() {
        return VERSION.SDK_INT >= 16;
    }

    public static AndroidActivityWrapper CreateAndroidActivityWrapper(Activity activity) {
        return CreateAndroidActivityWrapper(activity, Boolean.valueOf(false));
    }

    private static boolean isAndroidTV(Activity activity) {
        try {
            if (((UiModeManager) activity.getSystemService("uimode")).getCurrentModeType() == 4) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static AndroidActivityWrapper CreateAndroidActivityWrapper(Activity activity, Boolean bool) {
        sHasCaptiveRuntime = bool.booleanValue();
        if (bool.booleanValue()) {
            Utils.setRuntimePackageName(activity.getApplicationContext().getPackageName());
        } else {
            Utils.setRuntimePackageName("com.adobe.air");
        }
        if (sActivityWrapper == null) {
            sActivityWrapper = new AndroidActivityWrapper(activity);
        }
        mIsAndroidTV = isAndroidTV(activity);
        return sActivityWrapper;
    }

    private AndroidActivityWrapper(Activity activity) {
        this.m_activity = activity;
        this.m_newActivityLock = new ReentrantLock();
        this.m_newActivityCondition = this.m_newActivityLock.newCondition();
        this.m_application = activity.getApplication();
        LoadRuntimeLibraries();
        this.keyGuardManager = (KeyguardManager) activity.getSystemService("keyguard");
    }

    public static AndroidActivityWrapper GetAndroidActivityWrapper() {
        return sActivityWrapper;
    }

    public static boolean GetHasCaptiveRuntime() {
        return sHasCaptiveRuntime;
    }

    public static boolean GetIsAndroidTV() {
        return mIsAndroidTV;
    }

    public static boolean IsGamePreviewMode() {
        return sIsSwfPreviewMode;
    }

    public static boolean GetDepthAndStencilForGamePreview() {
        return sDepthAndStencil;
    }

    public static boolean ShouldShowGamePreviewWatermark() {
        Boolean valueOf = Boolean.valueOf(sIsSwfPreviewMode);
        if (valueOf.booleanValue() && (sGamePreviewHost.equalsIgnoreCase("www.adobe.com") || sGamePreviewHost.equalsIgnoreCase(ADOBE_COM))) {
            valueOf = Boolean.valueOf(false);
        }
        return valueOf.booleanValue();
    }

    public Activity getActivity() {
        return this.m_activity;
    }

    public void setSpeakerphoneOn(boolean z) {
        ((AudioManager) getActivity().getSystemService("audio")).setSpeakerphoneOn(z);
    }

    public boolean getSpeakerphoneOn() {
        return ((AudioManager) getActivity().getSystemService("audio")).isSpeakerphoneOn();
    }

    public boolean getWebContentsDebuggingEnabled() {
        try {
            Bundle bundle = this.m_activity.getPackageManager().getActivityInfo(this.m_activity.getComponentName(), 128).metaData;
            if (bundle != null) {
                Boolean bool = (Boolean) bundle.get("webContentsDebuggingEnabled");
                if (bool != null) {
                    return bool.booleanValue();
                }
            }
        } catch (NameNotFoundException e) {
        }
        return false;
    }

    public void registerPlane(SurfaceView surfaceView, int i) {
        this.m_planes.set(i, surfaceView);
        planeBreakCascade();
    }

    public void unregisterPlane(int i) {
        this.m_planes.set(i, null);
        planeBreakCascade();
    }

    public void planeCleanCascade() {
        if (!this.m_planeCascadeInit) {
            this.m_planeCascadeInit = true;
            planeBreakCascade();
        }
    }

    public void planeBreakCascade() {
        int i = 0;
        for (int i2 = 0; i2 < 8; i2++) {
            if (this.m_planes.get(i2) != null) {
                i++;
            }
        }
        if (i > 1) {
            this.m_planeBreakCascade = true;
        }
    }

    private boolean planeRemovedSuccessfully(SurfaceView surfaceView) {
        if (!surfaceView.getHolder().getSurface().isValid()) {
            return true;
        }
        if ((Build.MODEL.equals("LT18i") || Build.MODEL.equals("LT15i") || Build.MODEL.equals("Arc")) && isIceCreamSandwich() && this.m_layout.indexOfChild(surfaceView) < 0) {
            return true;
        }
        return false;
    }

    public void planeKickCascade() {
        if (!isHoneycomb() || !this.m_skipKickCascade) {
            if (!isJellybean() || !this.mContainsVideo) {
                planeCleanCascade();
                if (this.m_layout != null) {
                    if (this.m_planeBreakCascade) {
                        int i = 0;
                        while (i < 8) {
                            if (this.m_planes.get(i) != null && this.m_layout.indexOfChild((View) this.m_planes.get(i)) >= 0) {
                                this.m_layout.removeView((View) this.m_planes.get(i));
                            }
                            i++;
                        }
                        this.m_planeBreakCascade = false;
                        i = 0;
                        while (i < 8) {
                            if (this.m_planes.get(i) != null && !planeRemovedSuccessfully((SurfaceView) this.m_planes.get(i))) {
                                this.m_planeBreakCascade = true;
                                break;
                            }
                            i++;
                        }
                        this.m_planeCascadeStep = 0;
                    }
                    if (this.m_planeCascadeStep == 0) {
                        planeStepCascade();
                        this.m_mainView.requestFocus();
                    }
                }
            }
        }
    }

    public void planeStepCascade() {
        this.m_skipKickCascade = false;
        if (this.m_layout != null && !this.m_planeBreakCascade) {
            while (this.m_planeCascadeStep < 8) {
                if (this.m_planes.get(this.m_planeCascadeStep) != null) {
                    if (this.m_layout.indexOfChild((View) this.m_planes.get(this.m_planeCascadeStep)) < 0) {
                        this.m_layout.addView((View) this.m_planes.get(this.m_planeCascadeStep), 0);
                    }
                    this.m_planeCascadeStep++;
                    return;
                }
                this.m_planeCascadeStep++;
            }
        }
    }

    public void ensureZOrder() {
        int i = 7;
        while (i >= 0) {
            if (this.m_planes.get(i) != null && this.m_layout.indexOfChild((View) this.m_planes.get(i)) >= 0) {
                this.m_layout.bringChildToFront((View) this.m_planes.get(i));
            }
            i--;
        }
    }

    public Context getRuntimeContext() {
        return this.m_runtimeContext;
    }

    public Application getApplication() {
        return this.m_application;
    }

    public Context getApplicationContext() {
        return this.m_application;
    }

    public Context getDefaultContext() {
        if (this.m_activity != null) {
            return this.m_activity;
        }
        return this.m_application;
    }

    public int getDefaultIntentFlags() {
        if (this.m_activity != null) {
            return 0;
        }
        return 268435456;
    }

    public RelativeLayout getOverlaysLayout(boolean z) {
        if (z && this.m_overlaysLayout == null) {
            this.m_overlaysLayout = new RelativeLayout(this.m_activity);
            this.m_layout.addView(this.m_overlaysLayout);
        }
        return this.m_overlaysLayout;
    }

    public void didRemoveOverlay() {
        if (this.m_overlaysLayout != null && this.m_overlaysLayout.getChildCount() == 0) {
            this.m_layout.removeView(this.m_overlaysLayout);
            this.m_overlaysLayout = null;
        }
    }

    public View getView() {
        return this.m_mainView;
    }

    public AndroidCameraView getCameraView() {
        return this.m_cameraView;
    }

    public boolean isApplicationLaunched() {
        return sApplicationLaunched;
    }

    public FlashEGL getEgl() {
        if (this.m_flashEGL == null) {
            this.m_flashEGL = FlashEGLFactory.CreateFlashEGL();
        }
        return this.m_flashEGL;
    }

    public boolean isSurfaceValid() {
        return this.m_mainView != null && this.m_mainView.isSurfaceValid();
    }

    public void SendIntentToRuntime(Class<?> cls, String str, String str2) {
        try {
            Intent intent = new Intent(this.m_runtimeContext, cls);
            intent.setAction(str);
            intent.addCategory(str2);
            this.m_activity.startActivity(intent);
        } catch (Exception e) {
        }
    }

    public void SendIntentToRuntime(Class<?> cls, String str, String str2, String str3, String str4) {
        try {
            Intent intent = new Intent(this.m_runtimeContext, cls);
            intent.setAction(str);
            intent.addCategory(str2);
            intent.putExtra(str3, str4);
            this.m_activity.startActivity(intent);
        } catch (Exception e) {
        }
    }

    public void StartDownloadConfigService() {
        Intent intent = new Intent();
        intent.setPackage(Utils.getRuntimePackageName());
        intent.setAction(AIRService.INTENT_DOWNLOAD_CONFIG);
        try {
            getApplicationContext().startService(intent);
        } catch (SecurityException e) {
        }
    }

    public void ShowImmediateUpdateDialog() {
        String str;
        try {
            String str2;
            Bundle bundle = this.m_activity.getPackageManager().getActivityInfo(this.m_activity.getComponentName(), 128).metaData;
            if (bundle != null) {
                str2 = (String) bundle.get("airDownloadURL");
            } else {
                str2 = null;
            }
            str = str2;
        } catch (NameNotFoundException e) {
            str = null;
        }
        if (str != null) {
            SendIntentToRuntime(AIRUpdateDialog.class, "android.intent.action.MAIN", "AIRUpdateDialog", "airDownloadURL", str);
        } else {
            SendIntentToRuntime(AIRUpdateDialog.class, "android.intent.action.MAIN", "AIRUpdateDialog");
        }
    }

    private void initializeAndroidAppVars(ApplicationInfo applicationInfo) {
        ApplicationFileManager.setAndroidPackageName(applicationInfo.packageName);
        ApplicationFileManager.setAndroidAPKPath(applicationInfo.sourceDir);
        ApplicationFileManager.processAndroidDataPath(this.m_application.getCacheDir().getAbsolutePath());
    }

    private void parseArgs(Activity activity, String[] strArr) {
        String str = "";
        String str2 = "";
        String str3 = "";
        String str4 = "false";
        String str5 = "false";
        String str6 = "false";
        String str7 = "";
        try {
            str = strArr[0];
            str2 = strArr[1];
            str3 = strArr[2];
            str4 = strArr[3];
            str5 = strArr[4];
            if (strArr.length >= 6) {
                str6 = strArr[5];
                str7 = strArr[6];
            }
        } catch (ArrayIndexOutOfBoundsException e) {
        }
        this.mExtraArgs = str3;
        this.mIsADL = Boolean.valueOf(str4).booleanValue();
        this.mIsDebuggerMode = Boolean.valueOf(str5).booleanValue();
        sIsSwfPreviewMode = Boolean.valueOf(str6).booleanValue();
        sGamePreviewHost = str7;
        initializeAndroidAppVars(this.m_activity.getApplicationInfo());
        if (this.mIsADL) {
            this.mXmlPath = str;
            this.mRootDir = str2;
            return;
        }
        this.mXmlPath = ApplicationFileManager.getAppXMLRoot();
        this.mRootDir = ApplicationFileManager.getAppRoot();
    }

    public void onCreate(Activity activity, String[] strArr) {
        this.m_activity = activity;
        this.mActivityState = ActivityState.STARTED;
        parseArgs(activity, strArr);
        SignalNewActivityCreated();
        try {
            this.m_runtimeContext = this.m_activity.createPackageContext(Utils.getRuntimePackageName(), 4);
        } catch (Exception e) {
        }
        if (!this.mIsDebuggerMode || this.mIsADL || sApplicationLaunched || DeviceProfiling.checkAndInitiateProfiler(this.m_activity)) {
            afterOnCreate();
        } else {
            checkForDebuggerAndLaunchDialog();
        }
        this.mInvokeEventPendingFromOnCreate = true;
        this.mConfigDownloadListener = ConfigDownloadListener.GetConfigDownloadListener();
    }

    private void afterOnCreate() {
        try {
            if (this.m_planes == null) {
                this.m_planes = new ArrayList(8);
                for (int i = 0; i < 8; i++) {
                    this.m_planes.add(i, null);
                }
            }
            Context applicationContext = getApplicationContext();
            this.m_layout = new FrameLayout(applicationContext);
            this.m_mainView = new AIRWindowSurfaceView(applicationContext, this);
            if (this.m_cameraView == null && this.m_runtimeContext.checkCallingOrSelfPermission("android.permission.CAMERA") == 0) {
                this.m_cameraView = new AndroidCameraView(applicationContext, this);
            }
            if (this.m_cameraView != null) {
                this.m_layout.addView(this.m_cameraView, 8, 16);
            }
            Bundle bundle = this.m_activity.getPackageManager().getActivityInfo(this.m_activity.getComponentName(), 128).metaData;
            if (bundle != null) {
                Boolean bool = (Boolean) bundle.get("containsVideo");
                if (bool != null && bool.booleanValue()) {
                    this.mContainsVideo = bool.booleanValue();
                    this.m_videoView = this.m_mainView.getVideoView();
                    this.m_layout.addView(this.m_videoView, 0);
                }
            }
            this.m_layout.addView(this.m_mainView);
            if (this.m_overlaysLayout != null) {
                this.m_layout.addView(this.m_overlaysLayout);
            }
            this.m_activity.setContentView(this.m_layout);
            if (!((!this.mIsADL && !this.mShowDebuggerDialog) || this.m_activity == null || this.m_activity.getCurrentFocus() == this.m_mainView)) {
                this.m_mainView.requestFocus();
                this.m_mainView.onWindowFocusChanged(true);
            }
            if (!this.mFullScreenSetFromMetaData) {
                setFullScreenFromMetaData();
            }
            this.mFullScreenSetFromMetaData = true;
            if (getIsFullScreen()) {
                this.m_mainView.setFullScreen();
            }
            this.mHardKeyboardHidden = this.m_activity.getResources().getConfiguration().hardKeyboardHidden;
            this.mHardKeyboardType = this.m_activity.getResources().getConfiguration().keyboard;
            this.mOrientationManager = OrientationManager.getOrientationManager();
            this.mOrientationManager.onActivityCreated(this.m_activity, this.m_mainView);
            callActivityStateListeners();
            HDMIUtils.initHelper(applicationContext);
        } catch (Exception e) {
        }
    }

    private void LaunchApplication(Activity activity, AIRWindowSurfaceView aIRWindowSurfaceView, String str, String str2, String str3, boolean z, boolean z2) {
        if (!sApplicationLaunched) {
            String str4;
            String str5;
            String str6;
            String stringExtra;
            int i;
            if (z) {
                try {
                    stringExtra = activity.getIntent().getStringExtra("args");
                    if (stringExtra != null) {
                        String[] split = stringExtra.split(" ");
                        str = split[0];
                        str2 = split[1];
                        if (split.length >= 2) {
                            str3 = split[2] + " ";
                        }
                        for (i = 3; i < split.length; i++) {
                            str3 = str3 + split[i] + " ";
                        }
                    }
                    str4 = str3;
                    str5 = str2;
                    str6 = str;
                } catch (Exception e) {
                    str4 = str3;
                    str5 = str2;
                    str6 = str;
                }
            } else if (sIsSwfPreviewMode) {
                try {
                    stringExtra = activity.getIntent().getDataString();
                    if (stringExtra != null && stringExtra.indexOf("?") > 0) {
                        i = -1;
                        for (String str7 : stringExtra.substring(stringExtra.indexOf("?") + 1).split("&")) {
                            String str72;
                            if (str72.substring(0, str72.indexOf("=")).equalsIgnoreCase("depthAndStencil")) {
                                if (str72.substring(str72.indexOf("=") + 1).equalsIgnoreCase(ServerProtocol.DIALOG_RETURN_SCOPES_TRUE)) {
                                    sDepthAndStencil = true;
                                } else {
                                    sDepthAndStencil = false;
                                }
                            } else if (str72.substring(0, str72.indexOf("=")).equalsIgnoreCase("autoorients")) {
                                if (str72.substring(str72.indexOf("=") + 1).equalsIgnoreCase(ServerProtocol.DIALOG_RETURN_SCOPES_TRUE)) {
                                    setAutoOrients(true);
                                } else {
                                    setAutoOrients(false);
                                }
                            } else if (str72.substring(0, str72.indexOf("=")).equalsIgnoreCase("aspectratio")) {
                                str72 = str72.substring(str72.indexOf("=") + 1);
                                if (str72.equalsIgnoreCase("portrait")) {
                                    i = 1;
                                } else if (str72.equalsIgnoreCase("landscape")) {
                                    i = 2;
                                } else if (str72.equalsIgnoreCase("any")) {
                                    i = 3;
                                }
                            }
                        }
                        if (i != -1) {
                            setAspectRatio(i);
                        }
                    }
                    str4 = str3;
                    str5 = str2;
                    str6 = str;
                } catch (Exception e2) {
                    str4 = str3;
                    str5 = str2;
                    str6 = str;
                }
            } else {
                str4 = str3;
                str5 = str2;
                str6 = str;
            }
            try {
                Context applicationContext = getApplicationContext();
                sEntryPoint = new Entrypoints();
                sEntryPoint.EntryMain(str6, str5, str4, Utils.getRuntimePackageName(), aIRWindowSurfaceView, activity.getApplication(), activity.getApplicationInfo(), applicationContext, this, z, z2);
                sIdleStateManager = AndroidIdleState.GetIdleStateManager(applicationContext);
                sApplicationLaunched = true;
            } catch (Exception e3) {
            }
        }
    }

    private void setMainView(View view) {
        if (sApplicationLaunched && sEntryPoint != null && isResumed()) {
            try {
                sEntryPoint.setMainView(view);
            } catch (Exception e) {
            }
        }
    }

    public void initCallStateListener() {
        if (sAndroidTelephonyManager == null) {
            sAndroidTelephonyManager = AndroidTelephonyManager.CreateAndroidTelephonyManager(getApplicationContext());
            sAndroidTelephonyManager.listen(true);
        }
    }

    public void onPause() {
        this.mActivityState = ActivityState.PAUSED;
        callActivityStateListeners();
        if (this.m_mainView != null) {
            this.m_mainView.forceSoftKeyboardDown();
        }
        if (this.mOrientationManager != null) {
            this.mOrientationManager.onActivityPaused();
        }
        if (sIdleStateManager != null) {
            sIdleStateManager.releaseLock();
        }
        if (isApplicationLaunched()) {
            nativeOnFocusListener(false);
            nativeDeactivateEvent();
        }
        planeBreakCascade();
    }

    public void onResume() {
        this.mActivityState = ActivityState.RESUMED;
        callActivityStateListeners();
        if (this.mOrientationManager != null) {
            this.mOrientationManager.onActivityResumed();
        }
        if (sIdleStateManager != null) {
            sIdleStateManager.acquireLock();
        }
        if (isApplicationLaunched()) {
            nativeActivateEvent();
            nativeOnFocusListener(true);
        } else {
            this.mActivateEventPending = true;
        }
        this.m_skipKickCascade = true;
        planeBreakCascade();
    }

    public void onRestart() {
        this.mActivityState = ActivityState.RESTARTED;
        callActivityStateListeners();
        if (this.m_mainView != null) {
            this.m_mainView.HideSoftKeyboardOnWindowFocusChange();
        }
        SetVisible(true);
    }

    public void onStop() {
        this.mActivityState = ActivityState.STOPPED;
        callActivityStateListeners();
        SetVisible(false);
    }

    public void onDestroy() {
        this.mActivityState = ActivityState.DESTROYED;
        callActivityStateListeners();
        if (this.mOrientationManager != null) {
            this.mOrientationManager.onActivityDestroyed();
        }
        for (int i = 0; i < 8; i++) {
            if (this.m_planes.get(i) != null) {
                this.m_layout.removeView((View) this.m_planes.get(i));
            }
        }
        if (this.m_overlaysLayout != null) {
            this.m_layout.removeView(this.m_overlaysLayout);
        }
        this.m_activity = null;
        this.m_cameraView = null;
        this.m_mainView = null;
        this.m_layout = null;
        setMainView(null);
        HDMIUtils.closeHelper();
    }

    public void SendInvokeEvent() {
        Intent intent = this.m_activity.getIntent();
        String dataString = intent.getDataString();
        int i = 0;
        if (dataString != null) {
            i = 1;
        }
        nativeSendInvokeEventWithData(dataString, intent.getAction(), i);
    }

    public void onNewIntent(Intent intent) {
        this.m_activity.setIntent(intent);
        SendInvokeEvent();
    }

    public void onSurfaceInitialized() {
        setMainView(this.m_mainView);
        SetVisible(true);
        if (this.mDisplayWaitingDialog) {
            showDialogWaitingForConnection(this.debuggerPort);
            this.mDisplayWaitingDialog = false;
        }
        LaunchApplication(this.m_activity, this.m_mainView, this.mXmlPath, this.mRootDir, this.mExtraArgs, this.mIsADL, this.mIsDebuggerMode);
        if (this.mInvokeEventPendingFromOnCreate) {
            if (!this.mIsADL) {
                SendInvokeEvent();
            }
            this.mInvokeEventPendingFromOnCreate = false;
        }
        if (this.mActivateEventPending) {
            nativeActivateEvent();
            this.mActivateEventPending = false;
        }
        planeCleanCascade();
    }

    public void finish() {
        if (this.m_activity != null) {
            this.m_activity.finish();
        }
    }

    public void onSurfaceDestroyed() {
        SetVisible(false);
    }

    public void onScreenStateChanged(boolean z) {
        this.mScreenOn = z;
        SetVisible(z);
        if (z) {
            this.m_skipKickCascade = false;
            planeBreakCascade();
        }
    }

    private void SetVisible(boolean z) {
        if (z) {
            if (isSurfaceValid() && this.mScreenOn && this.mActivityState != ActivityState.STOPPED && this.mActivityState != ActivityState.DESTROYED) {
                nativeSetVisible(true);
            }
        } else if (isApplicationLaunched()) {
            nativeSetVisible(false);
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
        this.mHardKeyboardHidden = configuration.hardKeyboardHidden;
        this.mHardKeyboardType = configuration.keyboard;
        this.mOrientationManager.onConfigurationChanged(configuration);
        callActivityStateListeners(configuration);
    }

    public boolean dispatchKeyEvent(KeyEvent keyEvent, boolean z) {
        return callInputEventListeners(keyEvent);
    }

    public boolean dispatchGenericMotionEvent(MotionEvent motionEvent, boolean z) {
        return callInputEventListeners(motionEvent);
    }

    public void onLowMemory() {
        nativeLowMemoryEvent();
    }

    public int getOrientation() {
        return this.mOrientationManager.getOrientation();
    }

    public int getDeviceOrientation() {
        return this.mOrientationManager.getDeviceOrientation();
    }

    public void setOrientation(int i) {
        this.mOrientationManager.setOrientation(i);
    }

    public void setAspectRatio(int i) {
        this.mOrientationManager.setAspectRatio(i);
    }

    public void setAutoOrients(boolean z) {
        this.mOrientationManager.setAutoOrients(z);
    }

    public boolean getAutoOrients() {
        return this.mOrientationManager.getAutoOrients();
    }

    public int[] getSupportedOrientations() {
        return this.mOrientationManager.getSupportedOrientations();
    }

    public void onActivityResult(int i, int i2, Intent intent) {
        callActivityResultListeners(i, i2, intent);
    }

    public boolean isHardKeyboardHidden() {
        return this.mHardKeyboardHidden == 2;
    }

    public int getHardKeyboardType() {
        return this.mHardKeyboardType;
    }

    public boolean needsCompositingSurface() {
        if (this.m_runtimeContext.checkCallingOrSelfPermission("android.permission.CAMERA") == 0) {
            return true;
        }
        return false;
    }

    public void setUseRGB565(Boolean bool) {
        this.mRGB565Override = bool.booleanValue();
    }

    public boolean useRGB565() {
        if (this.mIsADL) {
            return this.mRGB565Override;
        }
        ResourceFileManager resourceFileManager = new ResourceFileManager(this.m_activity);
        return !resourceFileManager.resExists(resourceFileManager.lookupResId(AndroidConstants.ANDROID_RESOURCE_RGBA8888));
    }

    public void BroadcastIntent(String str, String str2) {
        try {
            getDefaultContext().startActivity(Intent.parseUri(str2, 0).setAction(str).addFlags(getDefaultIntentFlags()));
        } catch (URISyntaxException e) {
        } catch (ActivityNotFoundException e2) {
        }
    }

    public void LaunchMarketPlaceForAIR(String str) {
        if (str == null) {
            str = "market://details?id=" + Utils.getRuntimePackageName();
        }
        try {
            BroadcastIntent("android.intent.action.VIEW", str);
        } catch (Exception e) {
        }
    }

    public String GetLibCorePath() {
        if (this.mLibCorePath == null) {
            this.mLibCorePath = Utils.GetLibCorePath(this.m_application);
        }
        return this.mLibCorePath;
    }

    private void LoadRuntimeLibraries() {
        if (!sRuntimeLibrariesLoaded) {
            try {
                System.load(Utils.GetLibSTLPath(this.m_application));
                System.load(GetLibCorePath());
                sRuntimeLibrariesLoaded = true;
            } catch (UnsatisfiedLinkError e) {
            }
        }
    }

    private void showDialogUnableToListenOnPort(int i) {
        new ListenErrorDialog(this.m_activity, i).createAndShowDialog();
    }

    private void checkForDebuggerAndLaunchDialog() {
        DebugMode debugMode;
        ServerSocket serverSocket;
        boolean z;
        DebuggerSettings debuggerSettings;
        boolean z2;
        Object obj;
        Throwable th;
        ServerSocket serverSocket2 = null;
        if (!this.mIsADL) {
            String str;
            ResourceFileManager resourceFileManager = new ResourceFileManager(this.m_activity);
            DebugMode debugMode2 = DebugMode.None;
            if (resourceFileManager.resExists(resourceFileManager.lookupResId(AndroidConstants.ANDROID_RESOURCE_DEBUG_RAW_INFO))) {
                try {
                    HashMap parseKeyValuePairFile = Utils.parseKeyValuePairFile(resourceFileManager.getFileStreamFromRawRes(resourceFileManager.lookupResId(AndroidConstants.ANDROID_RESOURCE_DEBUG_RAW_INFO)), "=");
                    String str2 = (String) parseKeyValuePairFile.get("incomingDebugPort");
                    if (str2 != null) {
                        try {
                            this.debuggerPort = Integer.parseInt(str2);
                            debugMode2 = DebugMode.ListenMode;
                        } catch (NumberFormatException e) {
                        }
                    }
                    str2 = (String) parseKeyValuePairFile.get("outgoingDebugHost");
                    if (str2 != null) {
                        if (debugMode2 == DebugMode.ListenMode) {
                            debugMode = DebugMode.ConflictMode;
                            throw new Exception("listen and connect are mutually exclusive.");
                        }
                        str = str2;
                        debugMode = DebugMode.ConnectMode;
                        switch (debugMode) {
                            case ListenMode:
                                try {
                                    serverSocket = new ServerSocket(this.debuggerPort, 1, InetAddress.getLocalHost());
                                    try {
                                        serverSocket.close();
                                        if (serverSocket != null) {
                                            try {
                                                serverSocket.close();
                                            } catch (IOException e2) {
                                                z = true;
                                            }
                                        }
                                        z = true;
                                    } catch (IOException e3) {
                                        serverSocket2 = serverSocket;
                                        if (serverSocket2 != null) {
                                            try {
                                                serverSocket2.close();
                                            } catch (IOException e4) {
                                                z = false;
                                            }
                                        }
                                        z = false;
                                        if (z) {
                                            this.mDisplayWaitingDialog = true;
                                            afterOnCreate();
                                        } else {
                                            showDialogUnableToListenOnPort(this.debuggerPort);
                                        }
                                        debuggerSettings = this.mDebuggerSettings;
                                        if (debugMode != DebugMode.ListenMode) {
                                            z2 = false;
                                        } else {
                                            z2 = true;
                                        }
                                        debuggerSettings.setListen(z2);
                                        this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                        return;
                                    } catch (SecurityException e5) {
                                        serverSocket2 = serverSocket;
                                        if (serverSocket2 != null) {
                                            try {
                                                serverSocket2.close();
                                            } catch (IOException e6) {
                                                z = false;
                                            }
                                        }
                                        z = false;
                                        if (z) {
                                            this.mDisplayWaitingDialog = true;
                                            afterOnCreate();
                                        } else {
                                            showDialogUnableToListenOnPort(this.debuggerPort);
                                        }
                                        debuggerSettings = this.mDebuggerSettings;
                                        if (debugMode != DebugMode.ListenMode) {
                                            z2 = true;
                                        } else {
                                            z2 = false;
                                        }
                                        debuggerSettings.setListen(z2);
                                        this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                        return;
                                    } catch (Exception e7) {
                                        Exception exception = e7;
                                        serverSocket2 = serverSocket;
                                        Exception exception2 = exception;
                                        try {
                                            if (obj.getClass().getName().equals("android.os.NetworkOnMainThreadException")) {
                                                z = true;
                                            } else {
                                                z = false;
                                            }
                                            if (serverSocket2 != null) {
                                                try {
                                                    serverSocket2.close();
                                                } catch (IOException e8) {
                                                }
                                            }
                                            if (z) {
                                                showDialogUnableToListenOnPort(this.debuggerPort);
                                            } else {
                                                this.mDisplayWaitingDialog = true;
                                                afterOnCreate();
                                            }
                                            debuggerSettings = this.mDebuggerSettings;
                                            if (debugMode != DebugMode.ListenMode) {
                                                z2 = false;
                                            } else {
                                                z2 = true;
                                            }
                                            debuggerSettings.setListen(z2);
                                            this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                            return;
                                        } catch (Throwable th2) {
                                            th = th2;
                                            if (serverSocket2 != null) {
                                                try {
                                                    serverSocket2.close();
                                                } catch (IOException e9) {
                                                }
                                            }
                                            throw th;
                                        }
                                    } catch (Throwable th3) {
                                        th = th3;
                                        serverSocket2 = serverSocket;
                                        if (serverSocket2 != null) {
                                            serverSocket2.close();
                                        }
                                        throw th;
                                    }
                                } catch (IOException e10) {
                                    if (serverSocket2 != null) {
                                        serverSocket2.close();
                                    }
                                    z = false;
                                    if (z) {
                                        this.mDisplayWaitingDialog = true;
                                        afterOnCreate();
                                    } else {
                                        showDialogUnableToListenOnPort(this.debuggerPort);
                                    }
                                    debuggerSettings = this.mDebuggerSettings;
                                    if (debugMode != DebugMode.ListenMode) {
                                        z2 = true;
                                    } else {
                                        z2 = false;
                                    }
                                    debuggerSettings.setListen(z2);
                                    this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                    return;
                                } catch (SecurityException e11) {
                                    if (serverSocket2 != null) {
                                        serverSocket2.close();
                                    }
                                    z = false;
                                    if (z) {
                                        showDialogUnableToListenOnPort(this.debuggerPort);
                                    } else {
                                        this.mDisplayWaitingDialog = true;
                                        afterOnCreate();
                                    }
                                    debuggerSettings = this.mDebuggerSettings;
                                    if (debugMode != DebugMode.ListenMode) {
                                        z2 = false;
                                    } else {
                                        z2 = true;
                                    }
                                    debuggerSettings.setListen(z2);
                                    this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                    return;
                                } catch (Exception e12) {
                                    obj = e12;
                                    if (obj.getClass().getName().equals("android.os.NetworkOnMainThreadException")) {
                                        z = true;
                                    } else {
                                        z = false;
                                    }
                                    if (serverSocket2 != null) {
                                        serverSocket2.close();
                                    }
                                    if (z) {
                                        this.mDisplayWaitingDialog = true;
                                        afterOnCreate();
                                    } else {
                                        showDialogUnableToListenOnPort(this.debuggerPort);
                                    }
                                    debuggerSettings = this.mDebuggerSettings;
                                    if (debugMode != DebugMode.ListenMode) {
                                        z2 = true;
                                    } else {
                                        z2 = false;
                                    }
                                    debuggerSettings.setListen(z2);
                                    this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                    return;
                                }
                                if (z) {
                                    this.mDisplayWaitingDialog = true;
                                    afterOnCreate();
                                } else {
                                    showDialogUnableToListenOnPort(this.debuggerPort);
                                }
                                debuggerSettings = this.mDebuggerSettings;
                                if (debugMode != DebugMode.ListenMode) {
                                    z2 = true;
                                } else {
                                    z2 = false;
                                }
                                debuggerSettings.setListen(z2);
                                this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                                return;
                            case ConnectMode:
                                if (Utils.nativeConnectDebuggerSocket(str)) {
                                    showDialogforIpAddress(str);
                                    return;
                                }
                                this.mDebuggerSettings.setHost(str);
                                afterOnCreate();
                                return;
                            case None:
                                afterOnCreate();
                                return;
                            case ConflictMode:
                                return;
                            default:
                                return;
                        }
                    }
                } catch (Exception e13) {
                    return;
                }
            }
            debugMode = debugMode2;
            str = null;
            switch (debugMode) {
                case ListenMode:
                    serverSocket = new ServerSocket(this.debuggerPort, 1, InetAddress.getLocalHost());
                    serverSocket.close();
                    if (serverSocket != null) {
                        serverSocket.close();
                    }
                    z = true;
                    if (z) {
                        showDialogUnableToListenOnPort(this.debuggerPort);
                    } else {
                        this.mDisplayWaitingDialog = true;
                        afterOnCreate();
                    }
                    debuggerSettings = this.mDebuggerSettings;
                    if (debugMode != DebugMode.ListenMode) {
                        z2 = false;
                    } else {
                        z2 = true;
                    }
                    debuggerSettings.setListen(z2);
                    this.mDebuggerSettings.setDebugerPort(this.debuggerPort);
                    return;
                case ConnectMode:
                    if (Utils.nativeConnectDebuggerSocket(str)) {
                        this.mDebuggerSettings.setHost(str);
                        afterOnCreate();
                        return;
                    }
                    showDialogforIpAddress(str);
                    return;
                case None:
                    afterOnCreate();
                    return;
                case ConflictMode:
                    return;
                default:
                    return;
            }
        }
    }

    private void showDialogforIpAddress(String str) {
        getApplicationContext();
        new RemoteDebuggerDialog(this.m_activity).createAndShowDialog(str);
    }

    private void closeDialogWaitingForConnection() {
        Context applicationContext = getApplicationContext();
        try {
            Intent intent = new Intent();
            intent.setAction("android.intent.action.MAIN");
            intent.addCategory("RemoteDebuggerListenerDialogClose");
            intent.putExtra("debuggerPort", this.debuggerPort);
            applicationContext.sendBroadcast(intent);
        } catch (Exception e) {
        }
    }

    private void showDialogWaitingForConnection(final int i) {
        getApplicationContext();
        if (sHasCaptiveRuntime) {
            new Thread(new Runnable() {
                public void run() {
                    try {
                        Thread.sleep(30000);
                        new Socket(InetAddress.getLocalHost(), i).close();
                    } catch (Exception e) {
                    }
                }
            }).start();
            return;
        }
        try {
            Intent intent = new Intent(this.m_runtimeContext, RemoteDebuggerListenerDialog.class);
            intent.setAction("android.intent.action.MAIN");
            intent.addCategory("RemoteDebuggerListenerDialog");
            intent.putExtra("debuggerPort", i);
            this.m_activity.startActivity(intent);
        } catch (Exception e) {
        }
    }

    public void gotResultFromDialog(boolean z, String str) {
        boolean nativeConnectDebuggerSocket;
        if (z) {
            if (str.length() != 0) {
                nativeConnectDebuggerSocket = Utils.nativeConnectDebuggerSocket(str);
            } else {
                nativeConnectDebuggerSocket = false;
            }
            if (nativeConnectDebuggerSocket) {
                this.mDebuggerSettings.setHost(str);
                this.mDebuggerSettings.setListen(false);
                this.mShowDebuggerDialog = true;
            } else {
                showDialogforIpAddress(str);
            }
        } else {
            nativeConnectDebuggerSocket = false;
        }
        if (nativeConnectDebuggerSocket || !z) {
            afterOnCreate();
        }
    }

    public void addInputEventListner(InputEventCallback inputEventCallback) {
        if (this.mInputEventListeners == null) {
            this.mInputEventListeners = new ArrayList();
        }
        if (!this.mInputEventListeners.contains(inputEventCallback)) {
            this.mInputEventListeners.add(inputEventCallback);
        }
    }

    public void removeInputEventListner(InputEventCallback inputEventCallback) {
        if (this.mInputEventListeners != null) {
            this.mInputEventListeners.remove(inputEventCallback);
        }
    }

    private boolean callInputEventListeners(KeyEvent keyEvent) {
        if (this.mInputEventListeners == null) {
            return false;
        }
        boolean z;
        try {
            int size = this.mInputEventListeners.size();
            int i = 0;
            boolean z2 = false;
            while (i < size) {
                if (!z2) {
                    try {
                        if (!((InputEventCallback) this.mInputEventListeners.get(i)).onKeyEvent(keyEvent)) {
                            z = false;
                            i++;
                            z2 = z;
                        }
                    } catch (Exception e) {
                        z = z2;
                    }
                }
                z = true;
                i++;
                z2 = z;
            }
            z = z2;
        } catch (Exception e2) {
            z = false;
        }
        return z;
    }

    private boolean callInputEventListeners(MotionEvent motionEvent) {
        if (this.mInputEventListeners == null) {
            return false;
        }
        boolean z;
        try {
            int size = this.mInputEventListeners.size();
            int i = 0;
            boolean z2 = false;
            while (i < size) {
                if (!z2) {
                    try {
                        if (!((InputEventCallback) this.mInputEventListeners.get(i)).onGenericMotionEvent(motionEvent)) {
                            z = false;
                            i++;
                            z2 = z;
                        }
                    } catch (Exception e) {
                        z = z2;
                    }
                }
                z = true;
                i++;
                z2 = z;
            }
            z = z2;
        } catch (Exception e2) {
            z = false;
        }
        return z;
    }

    public void addActivityStateChangeListner(StateChangeCallback stateChangeCallback) {
        if (this.mActivityStateListeners == null) {
            this.mActivityStateListeners = new ArrayList();
        }
        if (!this.mActivityStateListeners.contains(stateChangeCallback)) {
            this.mActivityStateListeners.add(stateChangeCallback);
        }
    }

    public void removeActivityStateChangeListner(StateChangeCallback stateChangeCallback) {
        if (this.mActivityStateListeners != null) {
            this.mActivityStateListeners.remove(stateChangeCallback);
        }
    }

    private void callActivityStateListeners() {
        if (this.mActivityStateListeners != null) {
            try {
                int size = this.mActivityStateListeners.size();
                for (int i = 0; i < size; i++) {
                    ((StateChangeCallback) this.mActivityStateListeners.get(i)).onActivityStateChanged(this.mActivityState);
                }
            } catch (Exception e) {
            }
        }
    }

    private void callActivityStateListeners(Configuration configuration) {
        if (this.mActivityStateListeners != null) {
            try {
                int size = this.mActivityStateListeners.size();
                for (int i = 0; i < size; i++) {
                    ((StateChangeCallback) this.mActivityStateListeners.get(i)).onConfigurationChanged(configuration);
                }
            } catch (Exception e) {
            }
        }
    }

    public void addActivityResultListener(ActivityResultCallback activityResultCallback) {
        if (this.mActivityResultListeners == null) {
            this.mActivityResultListeners = new ArrayList();
        }
        if (!this.mActivityResultListeners.contains(activityResultCallback)) {
            this.mActivityResultListeners.add(activityResultCallback);
        }
    }

    public void removeActivityResultListener(ActivityResultCallback activityResultCallback) {
        if (this.mActivityResultListeners != null) {
            this.mActivityResultListeners.remove(activityResultCallback);
        }
    }

    private void callActivityResultListeners(int i, int i2, Intent intent) {
        if (this.mActivityResultListeners != null) {
            try {
                int size = this.mActivityResultListeners.size();
                for (int i3 = 0; i3 < size; i3++) {
                    ((ActivityResultCallback) this.mActivityResultListeners.get(i3)).onActivityResult(i, i2, intent);
                }
            } catch (Exception e) {
            }
        }
    }

    private void SignalNewActivityCreated() {
        this.m_newActivityLock.lock();
        this.m_newActivityCondition.signalAll();
        this.m_newActivityLock.unlock();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.app.Activity WaitForNewActivity() {
        /*
        r2 = this;
        r0 = r2.m_newActivityLock;
        r0.lock();
        r0 = r2.m_activity;	 Catch:{ InterruptedException -> 0x0016, all -> 0x001d }
        if (r0 != 0) goto L_0x000e;
    L_0x0009:
        r0 = r2.m_newActivityCondition;	 Catch:{ InterruptedException -> 0x0016, all -> 0x001d }
        r0.await();	 Catch:{ InterruptedException -> 0x0016, all -> 0x001d }
    L_0x000e:
        r0 = r2.m_newActivityLock;
        r0.unlock();
    L_0x0013:
        r0 = r2.m_activity;
        return r0;
    L_0x0016:
        r0 = move-exception;
        r0 = r2.m_newActivityLock;
        r0.unlock();
        goto L_0x0013;
    L_0x001d:
        r0 = move-exception;
        r1 = r2.m_newActivityLock;
        r1.unlock();
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.AndroidActivityWrapper.WaitForNewActivity():android.app.Activity");
    }

    private void setFullScreenFromMetaData() {
        try {
            Bundle bundle = this.m_activity.getPackageManager().getActivityInfo(this.m_activity.getComponentName(), 128).metaData;
            if (bundle != null) {
                Boolean bool = (Boolean) bundle.get("fullScreen");
                if (bool != null && bool.booleanValue()) {
                    this.m_mainView.setFullScreen();
                }
            }
        } catch (NameNotFoundException e) {
        }
    }

    protected void setIsFullScreen(boolean z) {
        this.mIsFullScreen = z;
    }

    protected boolean getIsFullScreen() {
        return this.mIsFullScreen;
    }

    public String GetAppCacheDirectory() {
        return this.m_application.getCacheDir().getAbsolutePath();
    }

    public String GetAppDataDirectory() {
        return this.m_application.getApplicationInfo().dataDir;
    }

    public String GetRuntimeDataDirectory() {
        return this.m_runtimeContext.getApplicationInfo().dataDir + "/";
    }

    public void finishActivityFromChild(Activity activity, int i) {
    }

    public void finishFromChild(Activity activity) {
    }

    public void onAttachedToWindow() {
    }

    public void onBackPressed() {
    }

    public void onContentChanged() {
    }

    public boolean onContextItemSelected(MenuItem menuItem, boolean z) {
        return z;
    }

    public void onContextMenuClosed(Menu menu) {
    }

    public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenuInfo contextMenuInfo) {
    }

    public CharSequence onCreateDescription(CharSequence charSequence) {
        return charSequence;
    }

    public boolean onCreateOptionsMenu(Menu menu, boolean z) {
        return z;
    }

    public boolean onCreatePanelMenu(int i, Menu menu, boolean z) {
        return z;
    }

    public View onCreatePanelView(int i, View view) {
        return view;
    }

    public boolean onCreateThumbnail(Bitmap bitmap, Canvas canvas, boolean z) {
        return z;
    }

    public View onCreateView(String str, Context context, AttributeSet attributeSet, View view) {
        return view;
    }

    public void onDetachedFromWindow() {
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent, boolean z) {
        return z;
    }

    public boolean onKeyLongPress(int i, KeyEvent keyEvent, boolean z) {
        return z;
    }

    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent, boolean z) {
        return z;
    }

    public boolean onKeyUp(int i, KeyEvent keyEvent, boolean z) {
        return z;
    }

    public boolean onMenuItemSelected(int i, MenuItem menuItem, boolean z) {
        return z;
    }

    public boolean onMenuOpened(int i, Menu menu, boolean z) {
        return z;
    }

    public boolean onOptionsItemSelected(MenuItem menuItem, boolean z) {
        return z;
    }

    public void onOptionsMenuClosed(Menu menu) {
    }

    public void onPanelClosed(int i, Menu menu) {
    }

    public boolean onPrepareOptionsMenu(Menu menu, boolean z) {
        return z;
    }

    public boolean onPreparePanel(int i, View view, Menu menu, boolean z) {
        return z;
    }

    public Object onRetainNonConfigurationInstance(Object obj) {
        return obj;
    }

    public boolean onSearchRequested(boolean z) {
        return z;
    }

    public boolean onTouchEvent(MotionEvent motionEvent, boolean z) {
        return z;
    }

    public boolean onTrackballEvent(MotionEvent motionEvent, boolean z) {
        return z;
    }

    public void onUserInteraction() {
    }

    public void onWindowAttributesChanged(LayoutParams layoutParams) {
    }

    public void onWindowFocusChanged(boolean z) {
    }

    public void onApplyThemeResource(Theme theme, int i, boolean z) {
    }

    public void onChildTitleChanged(Activity activity, CharSequence charSequence) {
    }

    public Dialog onCreateDialog(int i, Bundle bundle, Dialog dialog) {
        return dialog;
    }

    public Dialog onCreateDialog(int i, Dialog dialog) {
        return dialog;
    }

    public void onPostCreate(Bundle bundle) {
    }

    public void onPostResume() {
    }

    public void onPrepareDialog(int i, Dialog dialog, Bundle bundle) {
    }

    public void onPrepareDialog(int i, Dialog dialog) {
    }

    public void onRestoreInstanceState(Bundle bundle) {
    }

    public void onSaveInstanceState(Bundle bundle) {
    }

    public void onTitleChanged(CharSequence charSequence, int i) {
    }

    public void onUserLeaveHint() {
    }

    public DebuggerSettings GetDebuggerSettings() {
        return this.mDebuggerSettings;
    }

    public void applyDownloadedConfig() {
        if (sEntryPoint != null) {
            sEntryPoint.EntryApplyDownloadedConfig();
        }
    }
}
