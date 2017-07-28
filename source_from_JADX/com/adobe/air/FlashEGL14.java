package com.adobe.air;

import android.app.Activity;
import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES10;
import android.os.Build;
import android.os.Build.VERSION;
import android.view.SurfaceView;
import com.adobe.flashruntime.air.VideoViewAIR;
import java.util.Scanner;

public class FlashEGL14 implements FlashEGL {
    private static int EGL_BUFFER_DESTROYED = 12437;
    private static int EGL_BUFFER_PRESERVED = 12436;
    private static int EGL_CONTEXT_CLIENT_VERSION = 12440;
    private static int EGL_COVERAGE_BUFFERS_NV = 12512;
    private static int EGL_COVERAGE_SAMPLES_NV = 12513;
    private static int EGL_OPENGL_ES2_BIT = 4;
    private static int EGL_SWAP_BEHAVIOR = 12435;
    private static final int MAX_CONFIGS = 100;
    private static String TAG = "FlashEGL14";
    private static int[] cfgAttrs = new int[]{12339, -1, 12325, -1, 12326, -1, 12352, EGL_OPENGL_ES2_BIT, 12344};
    private static int[] fbPBufferSurfaceAttrs = new int[]{12375, 64, 12374, 64, 12344};
    private static int[] fbWindowSurfaceDefAttrs = new int[]{12344};
    private static int[] fbWindowSurfaceOffAttrs = new int[]{EGL_SWAP_BEHAVIOR, EGL_BUFFER_DESTROYED, 12344};
    private static int[] fbWindowSurfaceOnAttrs = new int[]{EGL_SWAP_BEHAVIOR, EGL_BUFFER_PRESERVED, 12344};
    private int kAlphaBits = 5;
    private int kBlueBits = 4;
    private int kColorBits = 6;
    private int kConfigId = 1;
    private int kCsaaSamp = 10;
    private int kDepthBits = 7;
    private int kGreenBits = 3;
    private int kMsaaSamp = 9;
    private int kNumElements = 12;
    private int kRedBits = 2;
    private int kStencilBits = 8;
    private int kSurfaceTypes = 0;
    private int kSwapPreserve = 11;
    private int kSwapPreserveDefault = 0;
    private int kSwapPreserveOff = 2;
    private int kSwapPreserveOn = 1;
    private EGL14 mEgl = null;
    private EGLConfig mEglConfig = null;
    private int mEglConfigCount = 0;
    private EGLConfig[] mEglConfigList = null;
    volatile EGLContext mEglContext = EGL14.EGL_NO_CONTEXT;
    private EGLDisplay mEglDisplay = EGL14.EGL_NO_DISPLAY;
    private EGLSurface mEglPbufferSurface = EGL14.EGL_NO_SURFACE;
    private EGLSurface mEglSurface = EGL14.EGL_NO_SURFACE;
    private int[] mEglVersion = null;
    private EGLSurface mEglWindowSurface = EGL14.EGL_NO_SURFACE;
    private boolean mIsARGBSurface = false;
    private boolean mIsBufferPreserve = false;
    private boolean mIsES3Device = false;
    private boolean mIsGPUOOM = false;
    private int mPbufferConfigCount = 0;
    private int mPixmapConfigCount = 0;
    private int mWindowConfigCount = 0;

    public void FlashEGL14() {
        this.mEgl = null;
        this.mEglDisplay = EGL14.EGL_NO_DISPLAY;
        this.mEglConfig = null;
        this.mEglContext = EGL14.EGL_NO_CONTEXT;
        this.mEglSurface = EGL14.EGL_NO_SURFACE;
        this.mEglWindowSurface = EGL14.EGL_NO_SURFACE;
        this.mEglPbufferSurface = EGL14.EGL_NO_SURFACE;
        this.mIsARGBSurface = false;
    }

    private int XX(int i, int i2) {
        return (this.kNumElements * i) + i2;
    }

    public boolean HasGLContext() {
        return this.mEglContext != EGL14.EGL_NO_CONTEXT;
    }

    public int GetSurfaceWidth() {
        int[] iArr = new int[1];
        EGL14 egl14 = this.mEgl;
        EGL14.eglQuerySurface(this.mEglDisplay, this.mEglSurface, 12375, iArr, 0);
        return iArr[0];
    }

    public int GetSurfaceHeight() {
        int[] iArr = new int[1];
        EGL14 egl14 = this.mEgl;
        EGL14.eglQuerySurface(this.mEglDisplay, this.mEglSurface, 12374, iArr, 0);
        return iArr[0];
    }

    public boolean IsEmulator() {
        return Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic");
    }

    public boolean ChooseConfig(EGLDisplay eGLDisplay, int[] iArr, EGLConfig[] eGLConfigArr, int i, int[] iArr2) {
        if (IsEmulator()) {
            int[] iArr3 = new int[1];
            EGL14 egl14 = this.mEgl;
            EGL14.eglGetConfigs(eGLDisplay, null, 0, 0, iArr3, 0);
            int i2 = iArr3[0];
            EGLConfig[] eGLConfigArr2 = new EGLConfig[i2];
            egl14 = this.mEgl;
            EGL14.eglGetConfigs(eGLDisplay, eGLConfigArr2, 0, i2, iArr3, 0);
            int length = iArr.length;
            if (iArr.length % 2 != 0) {
                length = iArr.length - 1;
            }
            int i3 = 0;
            for (int i4 = 0; i4 < i2; i4++) {
                int i5 = 0;
                while (i5 < length) {
                    if (iArr[i5 + 1] != -1) {
                        int[] iArr4 = new int[1];
                        EGL14 egl142 = this.mEgl;
                        EGL14.eglGetConfigAttrib(eGLDisplay, eGLConfigArr2[i4], iArr[i5], iArr4, 0);
                        if ((iArr4[0] & iArr[i5 + 1]) != iArr[i5 + 1]) {
                            break;
                        }
                    }
                    i5 += 2;
                }
                if (i5 == length) {
                    if (eGLConfigArr != null && i3 < i) {
                        eGLConfigArr[i3] = eGLConfigArr2[i4];
                    }
                    i3++;
                }
            }
            iArr2[0] = i3;
            return true;
        }
        egl14 = this.mEgl;
        return EGL14.eglChooseConfig(eGLDisplay, iArr, 0, eGLConfigArr, 0, i, iArr2, 0);
    }

    public int[] GetNumConfigs() {
        int[] iArr = new int[4];
        int[] iArr2 = new int[1];
        EGLConfig[] eGLConfigArr = new EGLConfig[100];
        ChooseConfig(this.mEglDisplay, cfgAttrs, eGLConfigArr, 100, iArr2);
        int i = iArr2[0];
        iArr[0] = i;
        this.mEglConfigCount = i;
        cfgAttrs[1] = 4;
        ChooseConfig(this.mEglDisplay, cfgAttrs, eGLConfigArr, 100, iArr2);
        i = iArr2[0];
        iArr[1] = i;
        this.mWindowConfigCount = i;
        cfgAttrs[1] = 2;
        ChooseConfig(this.mEglDisplay, cfgAttrs, eGLConfigArr, 100, iArr2);
        i = iArr2[0];
        iArr[2] = i;
        this.mPixmapConfigCount = i;
        cfgAttrs[1] = 1;
        ChooseConfig(this.mEglDisplay, cfgAttrs, eGLConfigArr, 100, iArr2);
        int i2 = iArr2[0];
        iArr[3] = i2;
        this.mPbufferConfigCount = i2;
        cfgAttrs[1] = -1;
        return iArr;
    }

    public int[] GetConfigs(boolean z, boolean z2) {
        int[] iArr = new int[(this.mEglConfigCount * this.kNumElements)];
        int[] iArr2 = new int[1];
        int[] iArr3 = new int[1];
        this.mEglConfigList = new EGLConfig[this.mEglConfigCount];
        checkEglError("Before eglChooseConfig");
        ChooseConfig(this.mEglDisplay, cfgAttrs, this.mEglConfigList, this.mEglConfigCount, iArr2);
        checkEglError("After eglChooseConfig");
        int i = iArr2[0];
        this.mEglConfigCount = i;
        int i2 = 0;
        while (i2 < i) {
            EGL14 egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12339, iArr3, 0);
            iArr[XX(i2, this.kSurfaceTypes)] = iArr3[0];
            iArr[XX(i2, this.kConfigId)] = i2;
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12324, iArr3, 0);
            iArr[XX(i2, this.kRedBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12323, iArr3, 0);
            iArr[XX(i2, this.kGreenBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12322, iArr3, 0);
            iArr[XX(i2, this.kBlueBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12321, iArr3, 0);
            iArr[XX(i2, this.kAlphaBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12320, iArr3, 0);
            iArr[XX(i2, this.kColorBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12325, iArr3, 0);
            iArr[XX(i2, this.kDepthBits)] = iArr3[0];
            egl14 = this.mEgl;
            EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12326, iArr3, 0);
            iArr[XX(i2, this.kStencilBits)] = iArr3[0];
            iArr[XX(i2, this.kCsaaSamp)] = 0;
            iArr[XX(i2, this.kMsaaSamp)] = 0;
            if (z) {
                egl14 = this.mEgl;
                EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], EGL_COVERAGE_SAMPLES_NV, iArr3, 0);
                if (iArr3[0] != 1) {
                    iArr[XX(i2, this.kCsaaSamp)] = iArr3[0];
                }
            } else {
                egl14 = this.mEgl;
                EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfigList[i2], 12337, iArr3, 0);
                if (iArr3[0] != 1) {
                    iArr[XX(i2, this.kMsaaSamp)] = iArr3[0];
                }
            }
            if (z2) {
                int i3;
                int XX = XX(i2, this.kSwapPreserve);
                if ((this.mEglVersion[0] > 1 || this.mEglVersion[1] > 3) && (iArr[XX(i2, this.kSurfaceTypes)] & EGL_BUFFER_PRESERVED) != 0) {
                    i3 = 1;
                } else {
                    i3 = 0;
                }
                iArr[XX] = i3;
            } else {
                iArr[XX(i2, this.kSwapPreserve)] = 0;
            }
            i2++;
        }
        return iArr;
    }

    public void SetConfig(int i) {
        this.mEglConfig = this.mEglConfigList[i];
        int[] iArr = new int[1];
        EGL14 egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12324, iArr, 0);
        int i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12323, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12322, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12321, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12325, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12326, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12337, iArr, 0);
        i2 = iArr[0];
        egl14 = this.mEgl;
        EGL14.eglGetConfigAttrib(this.mEglDisplay, this.mEglConfig, 12338, iArr, 0);
        int i3 = iArr[0];
    }

    public int CreateDummySurfaceAndContext() {
        if (this.mEglDisplay == EGL14.EGL_NO_DISPLAY) {
            return 12296;
        }
        EGL14 egl14;
        if (this.mEglContext != EGL14.EGL_NO_CONTEXT) {
            if (this.mEglWindowSurface != EGL14.EGL_NO_SURFACE) {
                egl14 = this.mEgl;
                EGL14.eglMakeCurrent(this.mEglDisplay, this.mEglWindowSurface, this.mEglWindowSurface, this.mEglContext);
                return 12288;
            } else if (this.mEglPbufferSurface != EGL14.EGL_NO_SURFACE) {
                egl14 = this.mEgl;
                EGL14.eglMakeCurrent(this.mEglDisplay, this.mEglPbufferSurface, this.mEglPbufferSurface, this.mEglContext);
                return 12288;
            } else {
                egl14 = this.mEgl;
                EGL14.eglMakeCurrent(this.mEglDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
                egl14 = this.mEgl;
                EGL14.eglDestroyContext(this.mEglDisplay, this.mEglContext);
                this.mEglContext = EGL14.EGL_NO_CONTEXT;
            }
        }
        int[] iArr = new int[1];
        EGLConfig[] eGLConfigArr = new EGLConfig[]{1};
        ChooseConfig(this.mEglDisplay, cfgAttrs, eGLConfigArr, 1, iArr);
        cfgAttrs[1] = -1;
        if (iArr[0] == 0) {
            return 12294;
        }
        boolean z;
        int[] iArr2 = new int[]{EGL_CONTEXT_CLIENT_VERSION, 2, 12344};
        if (VERSION.SDK_INT >= 18) {
            egl14 = this.mEgl;
            this.mEglContext = EGL14.eglCreateContext(this.mEglDisplay, eGLConfigArr[0], EGL14.EGL_NO_CONTEXT, iArr2, 0);
            if (this.mEglContext == EGL14.EGL_NO_CONTEXT) {
                return 12294;
            }
            checkEglError("After creating dummy context for checking gl version");
            egl14 = this.mEgl;
            EGLSurface eglCreatePbufferSurface = EGL14.eglCreatePbufferSurface(this.mEglDisplay, eGLConfigArr[0], fbPBufferSurfaceAttrs, 0);
            checkEglError("After eglCreatePbufferSurface for checking gl version");
            if (eglCreatePbufferSurface == EGL14.EGL_NO_SURFACE) {
                return 12294;
            }
            int nextInt;
            egl14 = this.mEgl;
            EGL14.eglMakeCurrent(this.mEglDisplay, eglCreatePbufferSurface, eglCreatePbufferSurface, this.mEglContext);
            checkEglError("After eglMakeCurrent for checking gl version");
            String glGetString = GLES10.glGetString(7938);
            if (glGetString != null) {
                Scanner scanner = new Scanner(glGetString);
                scanner.useDelimiter("[^\\w']+");
                while (scanner.hasNext()) {
                    if (scanner.hasNextInt()) {
                        nextInt = scanner.nextInt();
                        break;
                    } else if (scanner.hasNext()) {
                        scanner.next();
                    }
                }
            }
            nextInt = 0;
            if (nextInt >= 3) {
                z = true;
            } else {
                z = false;
            }
            EGL14 egl142 = this.mEgl;
            EGL14.eglMakeCurrent(this.mEglDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
            egl142 = this.mEgl;
            EGL14.eglDestroySurface(this.mEglDisplay, eglCreatePbufferSurface);
            EGL14 egl143 = this.mEgl;
            EGL14.eglDestroyContext(this.mEglDisplay, this.mEglContext);
            this.mEglContext = EGL14.EGL_NO_CONTEXT;
        } else {
            z = false;
        }
        if (z) {
            iArr2[1] = 3;
            checkEglError("Before eglCreateContext es3");
            egl14 = this.mEgl;
            this.mEglContext = EGL14.eglCreateContext(this.mEglDisplay, eGLConfigArr[0], EGL14.EGL_NO_CONTEXT, iArr2, 0);
            checkEglError("After eglCreateContext es3");
            if (this.mEglContext != EGL14.EGL_NO_CONTEXT) {
                this.mIsES3Device = true;
            }
        }
        if (this.mEglContext == EGL14.EGL_NO_CONTEXT) {
            iArr2[1] = 2;
            checkEglError("Before eglCreateContext es2");
            egl14 = this.mEgl;
            this.mEglContext = EGL14.eglCreateContext(this.mEglDisplay, eGLConfigArr[0], EGL14.EGL_NO_CONTEXT, iArr2, 0);
            checkEglError("After eglCreateContext es2");
            if (this.mEglContext == EGL14.EGL_NO_CONTEXT) {
                return 12294;
            }
        }
        checkEglError("Before eglCreatePbufferSurface");
        egl14 = this.mEgl;
        this.mEglPbufferSurface = EGL14.eglCreatePbufferSurface(this.mEglDisplay, eGLConfigArr[0], fbPBufferSurfaceAttrs, 0);
        checkEglError("After eglCreatePbufferSurface");
        if (this.mEglPbufferSurface == EGL14.EGL_NO_SURFACE) {
            return 12294;
        }
        checkEglError("Before eglMakeCurrent");
        egl14 = this.mEgl;
        EGL14.eglMakeCurrent(this.mEglDisplay, this.mEglPbufferSurface, this.mEglPbufferSurface, this.mEglContext);
        checkEglError("After eglMakeCurrent");
        return 12288;
    }

    public int InitEGL() {
        if (this.mEglContext != EGL14.EGL_NO_CONTEXT) {
            return 12288;
        }
        this.mEgl = new EGL14();
        checkEglError("Before eglGetDisplay");
        EGL14 egl14 = this.mEgl;
        this.mEglDisplay = EGL14.eglGetDisplay(0);
        int checkEglError = checkEglError("After eglGetDisplay");
        if (12288 != checkEglError) {
            return checkEglError;
        }
        this.mEglVersion = new int[2];
        checkEglError("Before eglInitialize");
        egl14 = this.mEgl;
        EGL14.eglInitialize(this.mEglDisplay, this.mEglVersion, 0, this.mEglVersion, 1);
        checkEglError = checkEglError("After eglInitialize");
        if (12288 != checkEglError) {
            return checkEglError;
        }
        return 12288;
    }

    public boolean DestroyGLContext() {
        if (this.mEglContext == EGL14.EGL_NO_CONTEXT || this.mEglDisplay == EGL14.EGL_NO_DISPLAY) {
            return false;
        }
        checkEglError("DestroyGLContext: Before eglMakeCurrent for noSurface");
        EGL14 egl14 = this.mEgl;
        EGL14.eglMakeCurrent(this.mEglDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
        checkEglError("DestroyGLContext: After eglMakeCurrent");
        if (this.mEglPbufferSurface != EGL14.EGL_NO_SURFACE) {
            egl14 = this.mEgl;
            EGL14.eglDestroySurface(this.mEglDisplay, this.mEglPbufferSurface);
            this.mEglPbufferSurface = EGL14.EGL_NO_SURFACE;
        }
        checkEglError("Before eglDestroyContext");
        egl14 = this.mEgl;
        boolean eglDestroyContext = EGL14.eglDestroyContext(this.mEglDisplay, this.mEglContext);
        checkEglError("After eglDestroyContext");
        this.mEglContext = EGL14.EGL_NO_CONTEXT;
        return eglDestroyContext;
    }

    public int CreateGLContext(boolean z) {
        if (this.mEglConfig == null) {
            return 12293;
        }
        if (this.mEglContext != EGL14.EGL_NO_CONTEXT && !z) {
            return 12288;
        }
        int i = this.mIsES3Device ? 3 : 2;
        int[] iArr = new int[]{EGL_CONTEXT_CLIENT_VERSION, i, 12344};
        if (z) {
            EGLContext eGLContext = this.mEglContext;
            checkEglError("Before eglCreateContext");
            EGL14 egl14 = this.mEgl;
            this.mEglContext = EGL14.eglCreateContext(this.mEglDisplay, this.mEglConfig, eGLContext, iArr, 0);
            checkEglError("After eglCreateContext");
            EGL14 egl142 = this.mEgl;
            EGL14.eglDestroyContext(this.mEglDisplay, eGLContext);
            checkEglError("After eglDestroyContext");
        } else {
            checkEglError("Before eglCreateContext");
            EGL14 egl143 = this.mEgl;
            this.mEglContext = EGL14.eglCreateContext(this.mEglDisplay, this.mEglConfig, EGL14.EGL_NO_CONTEXT, iArr, 0);
            checkEglError("After eglCreateContext");
        }
        if (this.mEglContext == EGL14.EGL_NO_CONTEXT) {
            return 12294;
        }
        if (EGL14.EGL_NO_SURFACE == this.mEglPbufferSurface) {
            checkEglError("Before eglCreatePbufferSurface");
            egl143 = this.mEgl;
            this.mEglPbufferSurface = EGL14.eglCreatePbufferSurface(this.mEglDisplay, this.mEglConfig, fbPBufferSurfaceAttrs, 0);
            checkEglError("After eglCreatePbufferSurface");
        }
        return 12288;
    }

    public void TerminateEGL() {
        if (!(this.mEgl == null || this.mEglDisplay == EGL14.EGL_NO_DISPLAY)) {
            EGL14 egl14 = this.mEgl;
            EGL14.eglTerminate(this.mEglDisplay);
        }
        this.mEglDisplay = EGL14.EGL_NO_DISPLAY;
    }

    public void ReleaseGPUResources() {
        if (this.mEglContext != EGL14.EGL_NO_CONTEXT) {
            checkEglError("Before eglMakeCurrent");
            EGL14 egl14 = this.mEgl;
            EGL14.eglMakeCurrent(this.mEglDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
            checkEglError("After eglMakeCurrent");
            synchronized (this.mEgl) {
                checkEglError("Before eglDestroySurface");
                if (this.mEglWindowSurface != EGL14.EGL_NO_SURFACE) {
                    egl14 = this.mEgl;
                    EGL14.eglDestroySurface(this.mEglDisplay, this.mEglWindowSurface);
                    this.mEglWindowSurface = EGL14.EGL_NO_SURFACE;
                }
                checkEglError("After eglDestroySurface (window)");
            }
            if (this.mEglPbufferSurface != EGL14.EGL_NO_SURFACE) {
                checkEglError("Before eglDestroySurface (pbuffer)");
                egl14 = this.mEgl;
                EGL14.eglDestroySurface(this.mEglDisplay, this.mEglPbufferSurface);
                checkEglError("After eglDestroySurface (pbuffer)");
                this.mEglPbufferSurface = EGL14.EGL_NO_SURFACE;
            }
            checkEglError("Before eglDestroyContext");
            egl14 = this.mEgl;
            EGL14.eglDestroyContext(this.mEglDisplay, this.mEglContext);
            checkEglError("After eglDestroyContext");
            this.mEglContext = EGL14.EGL_NO_CONTEXT;
            this.mEglSurface = EGL14.EGL_NO_SURFACE;
        }
    }

    public void SwapEGLBuffers() {
        if (12288 == MakeGLCurrent()) {
            checkEglError("Before eglSwapBuffers");
            EGL14 egl14 = this.mEgl;
            EGL14.eglSwapBuffers(this.mEglDisplay, this.mEglSurface);
            checkEglError("After eglSwapBuffers");
        }
    }

    public int MakeGLCurrent() {
        if (this.mEglContext == EGL14.EGL_NO_CONTEXT) {
            return 12294;
        }
        if (this.mEglSurface == EGL14.EGL_NO_SURFACE) {
            return 12301;
        }
        if (this.mEglDisplay == EGL14.EGL_NO_DISPLAY) {
            return 12296;
        }
        checkEglError("Before eglMakeCurrent");
        EGL14 egl14 = this.mEgl;
        EGL14.eglMakeCurrent(this.mEglDisplay, this.mEglSurface, this.mEglSurface, this.mEglContext);
        return checkEglError("After eglMakeCurrent");
    }

    public int CreateWindowSurface(SurfaceView surfaceView, int i) {
        boolean z = true;
        if (this.mIsGPUOOM) {
            return 12291;
        }
        boolean z2 = surfaceView instanceof AIRWindowSurfaceView;
        if (!(surfaceView instanceof VideoViewAIR) && !(surfaceView instanceof AIRStage3DSurfaceView) && !z2) {
            return 12301;
        }
        if (this.mEglWindowSurface != EGL14.EGL_NO_SURFACE) {
            this.mEglSurface = this.mEglWindowSurface;
            return MakeGLCurrent();
        }
        EGL14 egl14;
        boolean z3;
        boolean z4;
        if (i == this.kSwapPreserveOn) {
            checkEglError("Before eglCreateWindowSurface");
            egl14 = this.mEgl;
            this.mEglWindowSurface = EGL14.eglCreateWindowSurface(this.mEglDisplay, this.mEglConfig, surfaceView.getHolder(), fbWindowSurfaceOnAttrs, 0);
            if (this.mEglWindowSurface == EGL14.EGL_NO_SURFACE) {
                checkEglError("After eglCreateWindowSurface");
                z3 = false;
            }
            z3 = true;
        } else {
            if (i == this.kSwapPreserveOff) {
                checkEglError("Before eglCreateWindowSurface");
                egl14 = this.mEgl;
                this.mEglWindowSurface = EGL14.eglCreateWindowSurface(this.mEglDisplay, this.mEglConfig, surfaceView.getHolder(), fbWindowSurfaceOffAttrs, 0);
                if (this.mEglWindowSurface == EGL14.EGL_NO_SURFACE) {
                    checkEglError("After eglCreateWindowSurface");
                    z3 = false;
                }
            }
            z3 = true;
        }
        if (this.mEglWindowSurface == EGL14.EGL_NO_SURFACE) {
            checkEglError("Before eglCreateWindowSurface");
            egl14 = this.mEgl;
            this.mEglWindowSurface = EGL14.eglCreateWindowSurface(this.mEglDisplay, this.mEglConfig, surfaceView.getHolder(), fbWindowSurfaceDefAttrs, 0);
            int checkEglError = checkEglError("After eglCreateWindowSurface");
            if (checkEglError != 12288) {
                return checkEglError;
            }
            z4 = true;
        } else {
            z4 = z3;
        }
        if (this.mEglWindowSurface == EGL14.EGL_NO_SURFACE) {
            return 12301;
        }
        this.mEglSurface = this.mEglWindowSurface;
        if (z2) {
            ((AIRWindowSurfaceView) surfaceView).setFlashEGL(this);
            Activity activity = ((AIRWindowSurfaceView) surfaceView).getActivityWrapper().getActivity();
            if (activity != null) {
                activity.getWindow().setSoftInputMode(34);
            }
        }
        int[] iArr = new int[]{0};
        this.mIsBufferPreserve = false;
        if (z4) {
            EGL14 egl142 = this.mEgl;
            if (EGL14.eglQuerySurface(this.mEglDisplay, this.mEglSurface, EGL_SWAP_BEHAVIOR, iArr, 0)) {
                if (iArr[0] != EGL_BUFFER_PRESERVED) {
                    z = false;
                }
                this.mIsBufferPreserve = z;
            }
        }
        return MakeGLCurrent();
    }

    public boolean DestroyWindowSurface() {
        if (this.mEglWindowSurface == EGL14.EGL_NO_SURFACE) {
            return false;
        }
        checkEglError("Before eglMakeCurrent");
        EGL14 egl14 = this.mEgl;
        EGL14.eglMakeCurrent(this.mEglDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
        if (12288 != checkEglError("After eglMakeCurrent")) {
            return false;
        }
        checkEglError("Before eglDestroySurface (window)");
        egl14 = this.mEgl;
        EGL14.eglDestroySurface(this.mEglDisplay, this.mEglWindowSurface);
        if (12288 != checkEglError("After eglDestroySurface (window)")) {
            return false;
        }
        if (this.mEglSurface == this.mEglWindowSurface) {
            this.mEglSurface = EGL14.EGL_NO_SURFACE;
        }
        this.mEglWindowSurface = EGL14.EGL_NO_SURFACE;
        if (!(this.mEglPbufferSurface == EGL14.EGL_NO_SURFACE || this.mEglContext == EGL14.EGL_NO_CONTEXT)) {
            this.mEglSurface = this.mEglPbufferSurface;
            egl14 = this.mEgl;
            EGL14.eglMakeCurrent(this.mEglDisplay, this.mEglSurface, this.mEglSurface, this.mEglContext);
            if (12288 != checkEglError("After eglMakeCurrent")) {
                return false;
            }
        }
        return true;
    }

    public boolean IsARGBSurface() {
        return this.mIsARGBSurface;
    }

    public boolean IsBufferPreserve() {
        return this.mIsBufferPreserve;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private int checkEglError(java.lang.String r7) {
        /*
        r6 = this;
        r5 = 12288; // 0x3000 float:1.7219E-41 double:6.071E-320;
        r0 = r6.mEgl;
        r0 = android.opengl.EGL14.eglGetError();
        if (r0 == r5) goto L_0x0072;
    L_0x000a:
        r1 = r6.mIsGPUOOM;
        if (r1 != 0) goto L_0x0072;
    L_0x000e:
        r1 = 12291; // 0x3003 float:1.7223E-41 double:6.0726E-320;
        if (r0 != r1) goto L_0x0072;
    L_0x0012:
        r1 = r6.mEglWindowSurface;
        r2 = android.opengl.EGL14.EGL_NO_SURFACE;
        if (r1 == r2) goto L_0x004a;
    L_0x0018:
        r1 = r6.mEgl;
        r1 = r6.mEglDisplay;
        r2 = r6.mEglWindowSurface;
        android.opengl.EGL14.eglDestroySurface(r1, r2);
        r1 = r6.mEgl;
        r1 = android.opengl.EGL14.eglGetError();
        r2 = android.opengl.EGL14.EGL_NO_SURFACE;
        r6.mEglWindowSurface = r2;
        r2 = android.opengl.EGL14.EGL_NO_SURFACE;
        r6.mEglSurface = r2;
        if (r1 == r5) goto L_0x0031;
    L_0x0031:
        r1 = android.opengl.EGL14.EGL_NO_SURFACE;
        r6.mEglWindowSurface = r1;
        r1 = r6.mEgl;
        r1 = r6.mEglDisplay;
        r2 = android.opengl.EGL14.EGL_NO_SURFACE;
        r3 = android.opengl.EGL14.EGL_NO_SURFACE;
        r4 = android.opengl.EGL14.EGL_NO_CONTEXT;
        android.opengl.EGL14.eglMakeCurrent(r1, r2, r3, r4);
        r1 = r6.mEgl;
        r1 = android.opengl.EGL14.eglGetError();
        if (r1 == r5) goto L_0x004a;
    L_0x004a:
        r1 = r6.mEglPbufferSurface;
        r2 = android.opengl.EGL14.EGL_NO_SURFACE;
        if (r1 == r2) goto L_0x006f;
    L_0x0050:
        r1 = r6.mEglContext;
        r2 = android.opengl.EGL14.EGL_NO_CONTEXT;
        if (r1 == r2) goto L_0x006f;
    L_0x0056:
        r1 = r6.mEglPbufferSurface;
        r6.mEglSurface = r1;
        r1 = r6.mEgl;
        r1 = r6.mEglDisplay;
        r2 = r6.mEglSurface;
        r3 = r6.mEglSurface;
        r4 = r6.mEglContext;
        android.opengl.EGL14.eglMakeCurrent(r1, r2, r3, r4);
        r1 = r6.mEgl;
        r1 = android.opengl.EGL14.eglGetError();
        if (r1 == r5) goto L_0x006f;
    L_0x006f:
        r1 = 1;
        r6.mIsGPUOOM = r1;
    L_0x0072:
        return r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.adobe.air.FlashEGL14.checkEglError(java.lang.String):int");
    }
}
