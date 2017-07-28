package com.adobe.air;

import android.R.id;
import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Configuration;
import android.content.res.Resources.Theme;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Process;
import android.util.AttributeSet;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager.LayoutParams;
import com.facebook.internal.Utility;
import dalvik.system.DexClassLoader;
import java.lang.reflect.Method;
import java.net.URISyntaxException;

public class GamePreviewAppEntry extends Activity {
    private static final String GAME_PREVIEW_APP_XML = "assets/META-INF/AIR/GamePreview-app.xml";
    private static final String GAME_PREVIEW_SRC_DIR = "assets";
    private static final String GAME_PREVIEW_SWF = "assets/GamePreview.swf";
    private static final String LOG_TAG = "AppEntry";
    private static final String RESOURCE_BUTTON_EXIT = "string.button_exit";
    private static final String RESOURCE_BUTTON_INSTALL = "string.button_install";
    private static final String RESOURCE_CLASS = "air.com.adobe.appentry.R";
    private static final String RESOURCE_TEXT_RUNTIME_REQUIRED = "string.text_runtime_required";
    private static final String RESOURCE_TITLE_ADOBE_AIR = "string.title_adobe_air";
    private static String RUNTIME_PACKAGE_ID = "com.adobe.air";
    private static Object sAndroidActivityWrapper = null;
    private static Class<?> sAndroidActivityWrapperClass;
    private static DexClassLoader sDloader;
    private static boolean sRuntimeClassesLoaded = false;

    class C01161 implements OnClickListener {
        C01161() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            GamePreviewAppEntry.this.launchMarketPlaceForAIR();
            System.exit(0);
        }
    }

    class C01172 implements OnClickListener {
        C01172() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            System.exit(0);
        }
    }

    class C01183 implements OnCancelListener {
        C01183() {
        }

        public void onCancel(DialogInterface dialogInterface) {
            System.exit(0);
        }
    }

    class C01194 implements ServiceConnection {
        C01194() {
        }

        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            GamePreviewAppEntry.this.unbindService(this);
            GamePreviewAppEntry.this.loadSharedRuntimeDex();
            GamePreviewAppEntry.this.createActivityWrapper(false);
            if (GamePreviewAppEntry.sRuntimeClassesLoaded) {
                GamePreviewAppEntry.this.InvokeWrapperOnCreate();
            } else {
                GamePreviewAppEntry.KillSelf();
            }
        }

        public void onServiceDisconnected(ComponentName componentName) {
        }
    }

    private void BroadcastIntent(String str, String str2) {
        try {
            startActivity(Intent.parseUri(str2, 0).setAction(str).addFlags(268435456));
        } catch (URISyntaxException e) {
        } catch (ActivityNotFoundException e2) {
        }
    }

    private void launchMarketPlaceForAIR() {
        String str;
        try {
            Bundle bundle = getPackageManager().getActivityInfo(getComponentName(), 128).metaData;
            str = bundle != null ? (String) bundle.get("airDownloadURL") : null;
        } catch (NameNotFoundException e) {
            str = null;
        }
        if (str == null) {
            str = "market://details?id=" + RUNTIME_PACKAGE_ID;
        }
        try {
            BroadcastIntent("android.intent.action.VIEW", str);
        } catch (Exception e2) {
        }
    }

    private boolean isRuntimeInstalled() {
        try {
            getPackageManager().getPackageInfo(RUNTIME_PACKAGE_ID, 256);
            return true;
        } catch (NameNotFoundException e) {
            return false;
        }
    }

    private boolean isRuntimeOnExternalStorage() {
        try {
            if ((getPackageManager().getApplicationInfo(RUNTIME_PACKAGE_ID, Utility.DEFAULT_STREAM_BUFFER_SIZE).flags & 262144) == 262144) {
                return true;
            }
        } catch (NameNotFoundException e) {
        }
        return false;
    }

    private void showDialog(int i, String str, int i2, int i3) {
        Builder builder = new Builder(this);
        builder.setTitle(i);
        builder.setMessage(str);
        builder.setPositiveButton(i2, new C01161());
        builder.setNegativeButton(i3, new C01172());
        builder.setOnCancelListener(new C01183());
        builder.show();
    }

    private void showRuntimeNotInstalledDialog() {
        ResourceIdMap resourceIdMap = new ResourceIdMap(RESOURCE_CLASS);
        showDialog(resourceIdMap.getId(RESOURCE_TITLE_ADOBE_AIR), getString(resourceIdMap.getId(RESOURCE_TEXT_RUNTIME_REQUIRED)) + getString(resourceIdMap.getId("string.text_install_runtime")), resourceIdMap.getId(RESOURCE_BUTTON_INSTALL), resourceIdMap.getId(RESOURCE_BUTTON_EXIT));
    }

    private void showRuntimeOnExternalStorageDialog() {
        ResourceIdMap resourceIdMap = new ResourceIdMap(RESOURCE_CLASS);
        showDialog(resourceIdMap.getId(RESOURCE_TITLE_ADOBE_AIR), getString(resourceIdMap.getId(RESOURCE_TEXT_RUNTIME_REQUIRED)) + getString(resourceIdMap.getId("string.text_runtime_on_external_storage")), resourceIdMap.getId(RESOURCE_BUTTON_INSTALL), resourceIdMap.getId(RESOURCE_BUTTON_EXIT));
    }

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        boolean loadCaptiveRuntimeClasses = loadCaptiveRuntimeClasses();
        if (!loadCaptiveRuntimeClasses) {
            if (sRuntimeClassesLoaded || isRuntimeInstalled()) {
                loadSharedRuntimeDex();
            } else if (isRuntimeOnExternalStorage()) {
                showRuntimeOnExternalStorageDialog();
                return;
            } else {
                showRuntimeNotInstalledDialog();
                return;
            }
        }
        if (sRuntimeClassesLoaded) {
            createActivityWrapper(loadCaptiveRuntimeClasses);
            InvokeWrapperOnCreate();
        } else if (loadCaptiveRuntimeClasses) {
            KillSelf();
        } else {
            launchAIRService();
        }
    }

    private void launchAIRService() {
        try {
            Intent intent = new Intent("com.adobe.air.AIRServiceAction");
            intent.setClassName(RUNTIME_PACKAGE_ID, "com.adobe.air.AIRService");
            bindService(intent, new C01194(), 1);
        } catch (Exception e) {
        }
    }

    private void InvokeWrapperOnCreate() {
        try {
            Method method = sAndroidActivityWrapperClass.getMethod("onCreate", new Class[]{Activity.class, String[].class});
            String str = GAME_PREVIEW_APP_XML;
            String str2 = GAME_PREVIEW_SRC_DIR;
            Boolean bool = new Boolean(false);
            Boolean bool2 = new Boolean(false);
            Boolean bool3 = new Boolean(true);
            String host = getIntent().getData().getHost();
            String[] strArr = new String[]{str, str2, "-nodebug", bool.toString(), bool2.toString(), bool3.toString(), host};
            InvokeMethod(method, this, strArr);
        } catch (Exception e) {
        }
    }

    private Object InvokeMethod(Method method, Object... objArr) {
        if (!sRuntimeClassesLoaded) {
            return null;
        }
        if (objArr == null) {
            return method.invoke(sAndroidActivityWrapper, new Object[0]);
        }
        try {
            return method.invoke(sAndroidActivityWrapper, objArr);
        } catch (Exception e) {
            return null;
        }
    }

    private static void KillSelf() {
        Process.killProcess(Process.myPid());
    }

    public void onStart() {
        super.onStart();
    }

    public void onRestart() {
        super.onRestart();
        try {
            if (sRuntimeClassesLoaded) {
                InvokeMethod(sAndroidActivityWrapperClass.getMethod("onRestart", new Class[0]), new Object[0]);
            }
        } catch (Exception e) {
        }
    }

    public void onPause() {
        super.onPause();
        try {
            if (sRuntimeClassesLoaded) {
                InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPause", new Class[0]), new Object[0]);
            }
        } catch (Exception e) {
        }
    }

    public void onResume() {
        super.onResume();
        try {
            if (sRuntimeClassesLoaded) {
                InvokeMethod(sAndroidActivityWrapperClass.getMethod("onResume", new Class[0]), new Object[0]);
            }
        } catch (Exception e) {
        }
    }

    public void onStop() {
        super.onStop();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onStop", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public void onDestroy() {
        super.onDestroy();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onDestroy", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onConfigurationChanged", new Class[]{Configuration.class}), configuration);
        } catch (Exception e) {
        }
    }

    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("dispatchKeyEvent", new Class[]{KeyEvent.class, Boolean.TYPE}), keyEvent, Boolean.valueOf(false));
        } catch (Exception e) {
        }
        if (super.dispatchKeyEvent(keyEvent)) {
            return true;
        }
        return false;
    }

    public boolean dispatchGenericMotionEvent(MotionEvent motionEvent) {
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("dispatchGenericMotionEvent", new Class[]{MotionEvent.class, Boolean.TYPE}), motionEvent, Boolean.valueOf(false));
        } catch (Exception e) {
        }
        if (super.dispatchGenericMotionEvent(motionEvent)) {
            return true;
        }
        return false;
    }

    public void onLowMemory() {
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onLowMemory", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    protected void onActivityResult(int i, int i2, Intent intent) {
        try {
            if (sRuntimeClassesLoaded) {
                InvokeMethod(sAndroidActivityWrapperClass.getMethod("onActivityResult", new Class[]{Integer.TYPE, Integer.TYPE, Intent.class}), Integer.valueOf(i), Integer.valueOf(i2), intent);
            }
        } catch (Exception e) {
        }
    }

    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onNewIntent", new Class[]{Intent.class}), intent);
        } catch (Exception e) {
        }
    }

    private boolean loadCaptiveRuntimeClasses() {
        try {
            sAndroidActivityWrapperClass = Class.forName("com.adobe.air.AndroidActivityWrapper");
            try {
                if (sAndroidActivityWrapperClass == null) {
                    return true;
                }
                sRuntimeClassesLoaded = true;
                return true;
            } catch (Exception e) {
                return true;
            }
        } catch (Exception e2) {
            return false;
        }
    }

    private void loadSharedRuntimeDex() {
        try {
            if (!sRuntimeClassesLoaded) {
                sDloader = new DexClassLoader(RUNTIME_PACKAGE_ID, getFilesDir().getAbsolutePath(), null, createPackageContext(RUNTIME_PACKAGE_ID, 3).getClassLoader());
                sAndroidActivityWrapperClass = sDloader.loadClass("com.adobe.air.AndroidActivityWrapper");
                if (sAndroidActivityWrapperClass != null) {
                    sRuntimeClassesLoaded = true;
                }
            }
        } catch (Exception e) {
        }
    }

    private void createActivityWrapper(boolean z) {
        if (z) {
            try {
                sAndroidActivityWrapper = sAndroidActivityWrapperClass.getMethod("CreateAndroidActivityWrapper", new Class[]{Activity.class, Boolean.class}).invoke(null, new Object[]{this, Boolean.valueOf(z)});
                return;
            } catch (Exception e) {
                return;
            }
        }
        sAndroidActivityWrapper = sAndroidActivityWrapperClass.getMethod("CreateAndroidActivityWrapper", new Class[]{Activity.class}).invoke(null, new Object[]{this});
    }

    public void finishActivityFromChild(Activity activity, int i) {
        super.finishActivityFromChild(activity, i);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("finishActivityFromChild", new Class[]{Activity.class, Integer.TYPE}), activity, Integer.valueOf(i));
        } catch (Exception e) {
        }
    }

    public void finishFromChild(Activity activity) {
        super.finishFromChild(activity);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("finishFromChild", new Class[]{Activity.class}), activity);
        } catch (Exception e) {
        }
    }

    public void onAttachedToWindow() {
        super.onAttachedToWindow();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onAttachedToWindow", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public void onBackPressed() {
        super.onBackPressed();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onBackPressed", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public void onContentChanged() {
        super.onContentChanged();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onContentChanged", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public boolean onContextItemSelected(MenuItem menuItem) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onContextItemSelected", new Class[]{MenuItem.class, Boolean.TYPE}), menuItem, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onContextItemSelected(menuItem);
        }
    }

    public void onContextMenuClosed(Menu menu) {
        super.onContextMenuClosed(menu);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onContextMenuClosed", new Class[]{Menu.class}), menu);
        } catch (Exception e) {
        }
    }

    public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenuInfo contextMenuInfo) {
        super.onCreateContextMenu(contextMenu, view, contextMenuInfo);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateContextMenu", new Class[]{ContextMenu.class, View.class, ContextMenuInfo.class}), contextMenu, view, contextMenuInfo);
        } catch (Exception e) {
        }
    }

    public CharSequence onCreateDescription() {
        try {
            return (CharSequence) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateDescription", new Class[]{CharSequence.class}), r1);
        } catch (Exception e) {
            return super.onCreateDescription();
        }
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateOptionsMenu", new Class[]{Menu.class, Boolean.TYPE}), menu, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onCreateOptionsMenu(menu);
        }
    }

    public boolean onCreatePanelMenu(int i, Menu menu) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreatePanelMenu", new Class[]{Integer.TYPE, Menu.class, Boolean.TYPE}), Integer.valueOf(i), menu, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onCreatePanelMenu(i, menu);
        }
    }

    public View onCreatePanelView(int i) {
        try {
            return (View) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreatePanelView", new Class[]{Integer.TYPE, View.class}), Integer.valueOf(i), r1);
        } catch (Exception e) {
            return super.onCreatePanelView(i);
        }
    }

    public boolean onCreateThumbnail(Bitmap bitmap, Canvas canvas) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateThumbnail", new Class[]{Bitmap.class, Canvas.class, Boolean.TYPE}), bitmap, canvas, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onCreateThumbnail(bitmap, canvas);
        }
    }

    public View onCreateView(String str, Context context, AttributeSet attributeSet) {
        try {
            return (View) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateView", new Class[]{String.class, Context.class, AttributeSet.class, View.class}), str, context, attributeSet, r1);
        } catch (Exception e) {
            return super.onCreateView(str, context, attributeSet);
        }
    }

    public void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onDetachedFromWindow", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onKeyDown", new Class[]{Integer.TYPE, KeyEvent.class, Boolean.TYPE}), Integer.valueOf(i), keyEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onKeyDown(i, keyEvent);
        }
    }

    public boolean onKeyLongPress(int i, KeyEvent keyEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onKeyLongPress", new Class[]{Integer.TYPE, KeyEvent.class, Boolean.TYPE}), Integer.valueOf(i), keyEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onKeyLongPress(i, keyEvent);
        }
    }

    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onKeyMultiple", new Class[]{Integer.TYPE, Integer.TYPE, KeyEvent.class, Boolean.TYPE}), Integer.valueOf(i), Integer.valueOf(i2), keyEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onKeyMultiple(i, i2, keyEvent);
        }
    }

    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onKeyUp", new Class[]{Integer.TYPE, KeyEvent.class, Boolean.TYPE}), Integer.valueOf(i), keyEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onKeyUp(i, keyEvent);
        }
    }

    public boolean onMenuItemSelected(int i, MenuItem menuItem) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onMenuItemSelected", new Class[]{Integer.TYPE, MenuItem.class, Boolean.TYPE}), Integer.valueOf(i), menuItem, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onMenuItemSelected(i, menuItem);
        }
    }

    public boolean onMenuOpened(int i, Menu menu) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onMenuOpened", new Class[]{Integer.TYPE, Menu.class, Boolean.TYPE}), Integer.valueOf(i), menu, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onMenuOpened(i, menu);
        }
    }

    public boolean onOptionsItemSelected(MenuItem menuItem) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onOptionsItemSelected", new Class[]{MenuItem.class, Boolean.TYPE}), menuItem, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onOptionsItemSelected(menuItem);
        }
    }

    public void onOptionsMenuClosed(Menu menu) {
        super.onOptionsMenuClosed(menu);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onOptionsMenuClosed", new Class[]{Menu.class}), menu);
        } catch (Exception e) {
        }
    }

    public void onPanelClosed(int i, Menu menu) {
        super.onPanelClosed(i, menu);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPanelClosed", new Class[]{Integer.TYPE, Menu.class}), Integer.valueOf(i), menu);
        } catch (Exception e) {
        }
    }

    public boolean onPrepareOptionsMenu(Menu menu) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPrepareOptionsMenu", new Class[]{Menu.class, Boolean.TYPE}), menu, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onPrepareOptionsMenu(menu);
        }
    }

    public boolean onPreparePanel(int i, View view, Menu menu) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPreparePanel", new Class[]{Integer.TYPE, View.class, Menu.class, Boolean.TYPE}), Integer.valueOf(i), view, menu, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onPreparePanel(i, view, menu);
        }
    }

    public Object onRetainNonConfigurationInstance() {
        Object onRetainNonConfigurationInstance = super.onRetainNonConfigurationInstance();
        try {
            onRetainNonConfigurationInstance = InvokeMethod(sAndroidActivityWrapperClass.getMethod("onRetainNonConfigurationInstance", new Class[]{Object.class}), onRetainNonConfigurationInstance);
        } catch (Exception e) {
        }
        return onRetainNonConfigurationInstance;
    }

    public boolean onSearchRequested() {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onSearchRequested", new Class[]{Boolean.TYPE}), Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onSearchRequested();
        }
    }

    public boolean onTouchEvent(MotionEvent motionEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onTouchEvent", new Class[]{MotionEvent.class, Boolean.TYPE}), motionEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onTouchEvent(motionEvent);
        }
    }

    public boolean onTrackballEvent(MotionEvent motionEvent) {
        try {
            return ((Boolean) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onTrackballEvent", new Class[]{MotionEvent.class, Boolean.TYPE}), motionEvent, Boolean.valueOf(r1))).booleanValue();
        } catch (Exception e) {
            return super.onTrackballEvent(motionEvent);
        }
    }

    public void onUserInteraction() {
        super.onUserInteraction();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onUserInteraction", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    public void onWindowAttributesChanged(LayoutParams layoutParams) {
        super.onWindowAttributesChanged(layoutParams);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onWindowAttributesChanged", new Class[]{LayoutParams.class}), layoutParams);
        } catch (Exception e) {
        }
    }

    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onWindowFocusChanged", new Class[]{Boolean.TYPE}), Boolean.valueOf(z));
        } catch (Exception e) {
        }
    }

    protected void onApplyThemeResource(Theme theme, int i, boolean z) {
        super.onApplyThemeResource(theme, i, z);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onApplyThemeResource", new Class[]{Theme.class, Integer.TYPE, Boolean.TYPE}), theme, Integer.valueOf(i), Boolean.valueOf(z));
        } catch (Exception e) {
        }
    }

    protected void onChildTitleChanged(Activity activity, CharSequence charSequence) {
        super.onChildTitleChanged(activity, charSequence);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onChildTitleChanged", new Class[]{Activity.class, CharSequence.class}), activity, charSequence);
        } catch (Exception e) {
        }
    }

    protected Dialog onCreateDialog(int i) {
        try {
            return (Dialog) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateDialog", new Class[]{Integer.TYPE, Dialog.class}), Integer.valueOf(i), r1);
        } catch (Exception e) {
            return super.onCreateDialog(i);
        }
    }

    protected Dialog onCreateDialog(int i, Bundle bundle) {
        try {
            return (Dialog) InvokeMethod(sAndroidActivityWrapperClass.getMethod("onCreateDialog", new Class[]{Integer.TYPE, Bundle.class, Dialog.class}), Integer.valueOf(i), bundle, r1);
        } catch (Exception e) {
            return super.onCreateDialog(i, bundle);
        }
    }

    protected void onPostCreate(Bundle bundle) {
        super.onPostCreate(bundle);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPostCreate", new Class[]{Bundle.class}), bundle);
        } catch (Exception e) {
        }
    }

    protected void onPostResume() {
        super.onPostResume();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPostResume", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }

    protected void onPrepareDialog(int i, Dialog dialog) {
        super.onPrepareDialog(i, dialog);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPrepareDialog", new Class[]{id.class, Dialog.class}), Integer.valueOf(i), dialog);
        } catch (Exception e) {
        }
    }

    protected void onPrepareDialog(int i, Dialog dialog, Bundle bundle) {
        super.onPrepareDialog(i, dialog, bundle);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onPrepareDialog", new Class[]{id.class, Dialog.class, Bundle.class}), Integer.valueOf(i), dialog, bundle);
        } catch (Exception e) {
        }
    }

    protected void onRestoreInstanceState(Bundle bundle) {
        super.onRestoreInstanceState(bundle);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onRestoreInstanceState", new Class[]{Bundle.class}), bundle);
        } catch (Exception e) {
        }
    }

    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onSaveInstanceState", new Class[]{Bundle.class}), bundle);
        } catch (Exception e) {
        }
    }

    protected void onTitleChanged(CharSequence charSequence, int i) {
        super.onTitleChanged(charSequence, i);
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onTitleChanged", new Class[]{CharSequence.class, Integer.TYPE}), charSequence, Integer.valueOf(i));
        } catch (Exception e) {
        }
    }

    protected void onUserLeaveHint() {
        super.onUserLeaveHint();
        try {
            InvokeMethod(sAndroidActivityWrapperClass.getMethod("onUserLeaveHint", new Class[0]), new Object[0]);
        } catch (Exception e) {
        }
    }
}
