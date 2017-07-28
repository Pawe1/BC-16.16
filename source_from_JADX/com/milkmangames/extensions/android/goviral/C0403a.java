package com.milkmangames.extensions.android.goviral;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.Signature;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Bitmap.Config;
import android.net.Uri;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Parcelable;
import android.provider.Telephony.Sms;
import android.text.Html;
import android.util.Base64;
import android.util.Log;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREByteArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.facebook.AccessToken;
import com.facebook.AccessTokenTracker;
import com.facebook.CallbackManager;
import com.facebook.CallbackManager.Factory;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.applinks.AppLinkData;
import com.facebook.internal.AttributionIdentifiers;
import com.facebook.internal.NativeProtocol;
import com.facebook.login.LoginBehavior;
import com.facebook.login.LoginManager;
import com.facebook.share.internal.ShareConstants;
import com.facebook.share.model.AppInviteContent.Builder;
import com.facebook.share.model.GameRequestContent;
import com.facebook.share.model.GameRequestContent.ActionType;
import com.facebook.share.model.GameRequestContent.Filters;
import com.facebook.share.model.ShareContent;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.model.ShareOpenGraphAction;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.model.ShareOpenGraphObject;
import com.facebook.share.model.SharePhoto;
import com.facebook.share.widget.AppInviteDialog;
import com.facebook.share.widget.GameRequestDialog;
import com.facebook.share.widget.MessageDialog;
import com.facebook.share.widget.ShareDialog;
import com.facebook.share.widget.ShareDialog.Mode;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.json.JSONStringer;
import p000c.p001m.p002x.p003a.gv.ca;
import p000c.p001m.p002x.p003a.gv.cd;

@TargetApi(8)
public final class C0403a extends FREContext implements cd {
    public static final String[] f357a = new String[]{"com.twitdroid", "com.twitter.android", "com.handmark.tweetcaster", "com.thedeck.android"};
    public static FREContext f358c;
    public static boolean f359d = false;
    public Activity f360b = null;
    private ca f361e;
    private String f362f;
    private String f363g;
    private String f364h;
    private String f365i;
    private String f366j;
    private GraphRequest f367k;
    private String f368l;
    private String f369m;
    private String f370n;
    private String f371o;
    private String f372p;
    private AppEventsLogger f373q;
    private CallbackManager f374r;
    private AccessTokenTracker f375s;
    private boolean f376t;
    private boolean f377u;

    private class C0377a implements FREFunction {
        final /* synthetic */ C0403a f326a;

        private C0377a(C0403a c0403a) {
            this.f326a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m399a(this.f326a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsInt());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class aa implements FREFunction {
        final /* synthetic */ C0403a f327a;

        private aa(C0403a c0403a) {
            this.f327a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                FREArray fREArray = (FREArray) fREObjectArr[0];
                FREArray fREArray2 = (FREArray) fREObjectArr[1];
                fREObjectArr[2].getAsString();
                C0403a.m392a(fREArray, fREArray2);
                C0403a c0403a = this.f327a;
                C0403a.m452n();
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ab implements FREFunction {
        final /* synthetic */ C0403a f328a;

        private ab(C0403a c0403a) {
            this.f328a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                FREArray fREArray = (FREArray) fREObjectArr[0];
                FREArray fREArray2 = (FREArray) fREObjectArr[1];
                String asString = fREObjectArr[2].getAsString();
                C0403a.m425c(this.f328a, C0403a.m392a(fREArray, fREArray2), asString);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ac implements FREFunction {
        final /* synthetic */ C0403a f329a;

        private ac(C0403a c0403a) {
            this.f329a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                this.f329a.m413a(fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), false);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ad implements FREFunction {
        final /* synthetic */ C0403a f330a;

        private ad(C0403a c0403a) {
            this.f330a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                this.f330a.m411a(fREObjectArr[0].getAsString(), (FREBitmapData) fREObjectArr[1], fREObjectArr[2].getAsString(), false);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0378b implements FREFunction {
        final /* synthetic */ C0403a f331a;

        private C0378b(C0403a c0403a) {
            this.f331a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f331a;
                return FREObject.newObject(true);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0379c implements FREFunction {
        final /* synthetic */ C0403a f332a;

        private C0379c(C0403a c0403a) {
            this.f332a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m415a(this.f332a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), (FREBitmapData) fREObjectArr[3], fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), fREObjectArr[6].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private abstract class C0380d implements FREFunction {
        protected C0403a f333b;
        final /* synthetic */ C0403a f334c;

        public C0380d(C0403a c0403a) {
            this.f334c = c0403a;
            this.f333b = c0403a;
        }

        protected abstract FREObject mo332a(FREObject[] fREObjectArr);

        public FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            FREObject fREObject = null;
            try {
                fREObject = mo332a(fREObjectArr);
            } catch (Exception e) {
                Log.d("[GVExtension]", "Call failed");
                Log.e("[GVExtension]", e.getMessage());
                e.printStackTrace();
            }
            return fREObject;
        }
    }

    private class C0381e implements FREFunction {
        final /* synthetic */ C0403a f335a;

        private C0381e(C0403a c0403a) {
            this.f335a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                String asString2 = fREObjectArr[1].getAsString();
                FREArray fREArray = (FREArray) fREObjectArr[2];
                FREArray fREArray2 = (FREArray) fREObjectArr[3];
                String asString3 = fREObjectArr[4].getAsString();
                String asString4 = fREObjectArr[5].getAsString();
                fREObjectArr[6].getAsBool();
                this.f335a.m412a(asString, asString2, C0403a.m392a(fREArray, fREArray2), asString3, asString4);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0382f implements FREFunction {
        final /* synthetic */ C0403a f336a;

        private C0382f(C0403a c0403a) {
            this.f336a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                boolean asBool = fREObjectArr[1].getAsBool();
                boolean asBool2 = fREObjectArr[2].getAsBool();
                Bundle a = asBool ? C0403a.m392a((FREArray) fREObjectArr[3], (FREArray) fREObjectArr[4]) : null;
                if (asBool2) {
                    C0403a.m398a(this.f336a, asString, fREObjectArr[5].getAsDouble(), a);
                } else {
                    C0403a.m400a(this.f336a, asString, a);
                }
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0383g implements FREFunction {
        final /* synthetic */ C0403a f337a;

        private C0383g(C0403a c0403a) {
            this.f337a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                FREBitmapData fREBitmapData = (FREBitmapData) fREObjectArr[1];
                String asString2 = fREObjectArr[2].getAsString();
                String asString3 = fREObjectArr[3].getAsString();
                fREObjectArr[4].getAsBool();
                C0403a.m402a(this.f337a, asString, fREBitmapData, asString2, asString3);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0384h implements FREFunction {
        final /* synthetic */ C0403a f338a;

        private C0384h(C0403a c0403a) {
            this.f338a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m437g(this.f338a, fREObjectArr[0].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0385i implements FREFunction {
        final /* synthetic */ C0403a f339a;

        private C0385i(C0403a c0403a) {
            this.f339a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m410a(this.f339a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), fREObjectArr[5].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0386j implements FREFunction {
        final /* synthetic */ C0403a f340a;

        private C0386j(C0403a c0403a) {
            this.f340a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m409a(this.f340a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), (FREBitmapData) fREObjectArr[3], fREObjectArr[6].getAsString(), fREObjectArr[7].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0387k implements FREFunction {
        final /* synthetic */ C0403a f341a;

        private C0387k(C0403a c0403a) {
            this.f341a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f341a;
                return FREObject.newObject(C0403a.m454o());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0388l implements FREFunction {
        final /* synthetic */ C0403a f342a;

        private C0388l(C0403a c0403a) {
            this.f342a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f342a;
                return FREObject.newObject(C0403a.m456p());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0389m implements FREFunction {
        final /* synthetic */ C0403a f343a;

        private C0389m(C0403a c0403a) {
            this.f343a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                fREObjectArr[1].getAsString();
                fREObjectArr[2].getAsBool();
                C0403a.m428d(this.f343a, asString);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0390n implements FREFunction {
        final /* synthetic */ C0403a f344a;

        private C0390n(C0403a c0403a) {
            this.f344a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                Log.d("[GVExtension]", "call inner init");
                C0403a.m453n(this.f344a);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0391o implements FREFunction {
        final /* synthetic */ C0403a f345a;

        private C0391o(C0403a c0403a) {
            this.f345a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f345a;
                return FREObject.newObject(C0403a.m458q());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0392p implements FREFunction {
        final /* synthetic */ C0403a f346a;

        private C0392p(C0403a c0403a) {
            this.f346a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f346a;
                return FREObject.newObject(true);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0393q implements FREFunction {
        final /* synthetic */ C0403a f347a;

        private C0393q(C0403a c0403a) {
            this.f347a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0403a.m426c(this.f347a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0394r implements FREFunction {
        final /* synthetic */ C0403a f348a;

        private C0394r(C0403a c0403a) {
            this.f348a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(this.f348a.m459r());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0395s implements FREFunction {
        final /* synthetic */ C0403a f349a;

        private C0395s(C0403a c0403a) {
            this.f349a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a c0403a = this.f349a;
                C0403a.m450m();
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0396t implements FREFunction {
        final /* synthetic */ C0403a f350a;

        private C0396t(C0403a c0403a) {
            this.f350a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m441h(this.f350a, fREObjectArr[0].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0397u implements FREFunction {
        final /* synthetic */ C0403a f351a;

        private C0397u(C0403a c0403a) {
            this.f351a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(AppEventsLogger.activateApp(this.f351a.getActivity(), this.f351a.f362f));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0398v implements FREFunction {
        final /* synthetic */ C0403a f352a;

        private C0398v(C0403a c0403a) {
            this.f352a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0403a.m432e(this.f352a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0399w implements FREFunction {
        final /* synthetic */ C0403a f353a;

        private C0399w(C0403a c0403a) {
            this.f353a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0403a.m435f(this.f353a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0400x implements FREFunction {
        final /* synthetic */ C0403a f354a;

        private C0400x(C0403a c0403a) {
            this.f354a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m408a(this.f354a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsString(), fREObjectArr[3].getAsBool(), fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), fREObjectArr[6].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0401y implements FREFunction {
        final /* synthetic */ C0403a f355a;

        private C0401y(C0403a c0403a) {
            this.f355a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                String asString2 = fREObjectArr[1].getAsString();
                String asString3 = fREObjectArr[2].getAsString();
                boolean asBool = fREObjectArr[3].getAsBool();
                String asString4 = fREObjectArr[4].getAsString();
                String asString5 = fREObjectArr[5].getAsString();
                FREBitmapData fREBitmapData = (FREBitmapData) fREObjectArr[6];
                fREObjectArr[7].getAsString();
                C0403a.m406a(this.f355a, asString, asString2, asString3, asBool, asString4, asString5, fREBitmapData, fREObjectArr[8].getAsString(), fREObjectArr[9].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0402z implements FREFunction {
        final /* synthetic */ C0403a f356a;

        private C0402z(C0403a c0403a) {
            this.f356a = c0403a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0403a.m407a(this.f356a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsString(), fREObjectArr[3].getAsBool(), fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), (FREByteArray) fREObjectArr[6], fREObjectArr[7].getAsString(), fREObjectArr[8].getAsString(), fREObjectArr[9].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private Intent m388a(String str, Uri uri, String str2) {
        Log.d("[GVExtension]", "SMS intent recipients: " + str2);
        String replace = (str2 == null || str2.equals("")) ? null : str2.replace(",", ";").replace("-", "").replace(" ", "");
        Log.d("[GVExtension]", "SMS sendable : " + replace);
        Intent intent;
        if (VERSION.SDK_INT >= 19) {
            Log.d("[GVExtension]", "use kit");
            intent = new Intent("android.intent.action.SEND");
            intent.setType("text/plain");
            String defaultSmsPackage = Sms.getDefaultSmsPackage(getActivity());
            if (defaultSmsPackage == null) {
                return null;
            }
            intent.putExtra("android.intent.extra.TEXT", str);
            intent.putExtra("sms_body", str);
            if (replace != null) {
                intent.putExtra("address", replace);
            }
            intent.setPackage(defaultSmsPackage);
            return intent;
        }
        Log.d("[GVExtension]", "sms not kit kat+");
        intent = new Intent("android.intent.action.VIEW");
        intent.setType("vnd.android-dir/mms-sms");
        intent.setData(uri == null ? Uri.parse("sms:") : Uri.parse("mms:"));
        if (replace != null) {
            intent.putExtra("address", replace);
        }
        intent.putExtra("sms_body", str);
        intent.putExtra("android.intent.extra.TEXT", str);
        return intent;
    }

    private static Bitmap m389a(FREBitmapData fREBitmapData) {
        int width;
        Buffer bits;
        int i;
        Exception e;
        Bitmap createBitmap;
        int i2;
        int pixel;
        Bitmap bitmap = null;
        int i3 = 1;
        Log.d("[GVExtension]", "Parse bitmap " + fREBitmapData);
        try {
            fREBitmapData.acquire();
            width = fREBitmapData.getWidth();
            try {
                i3 = fREBitmapData.getHeight();
                bits = fREBitmapData.getBits();
                Log.d("[GVExtension]", "Image size:" + width + "," + i3);
                i = width;
                width = i3;
            } catch (Exception e2) {
                e = e2;
                Log.d("[GVExtension]", "Encoding failed!");
                e.printStackTrace();
                i = width;
                bits = null;
                width = i3;
                if (bits != null) {
                    Log.d("[GVExtension]", "inData");
                    Log.d("[GVExtension]", "create");
                    createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                    createBitmap.copyPixelsFromBuffer(bits);
                    bitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                    for (i3 = 0; i3 < width; i3++) {
                        for (i2 = 0; i2 < i; i2++) {
                            pixel = createBitmap.getPixel(i2, i3);
                            bitmap.setPixel(i2, i3, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                        }
                    }
                    try {
                        fREBitmapData.release();
                    } catch (Exception e3) {
                        Log.d("[GVExtension]", "Failed releasing image");
                    }
                } else {
                    Log.d("[GVExtension]", "In data not valid");
                }
                return bitmap;
            }
        } catch (Exception e4) {
            e = e4;
            width = 1;
            Log.d("[GVExtension]", "Encoding failed!");
            e.printStackTrace();
            i = width;
            bits = null;
            width = i3;
            if (bits != null) {
                Log.d("[GVExtension]", "In data not valid");
            } else {
                Log.d("[GVExtension]", "inData");
                Log.d("[GVExtension]", "create");
                createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                createBitmap.copyPixelsFromBuffer(bits);
                bitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                for (i3 = 0; i3 < width; i3++) {
                    for (i2 = 0; i2 < i; i2++) {
                        pixel = createBitmap.getPixel(i2, i3);
                        bitmap.setPixel(i2, i3, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                    }
                }
                fREBitmapData.release();
            }
            return bitmap;
        }
        if (bits != null) {
            Log.d("[GVExtension]", "inData");
            Log.d("[GVExtension]", "create");
            createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
            createBitmap.copyPixelsFromBuffer(bits);
            bitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
            for (i3 = 0; i3 < width; i3++) {
                for (i2 = 0; i2 < i; i2++) {
                    pixel = createBitmap.getPixel(i2, i3);
                    bitmap.setPixel(i2, i3, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                }
            }
            fREBitmapData.release();
        } else {
            Log.d("[GVExtension]", "In data not valid");
        }
        return bitmap;
    }

    private Uri m390a(String str, FREBitmapData fREBitmapData) {
        try {
            OutputStream fileOutputStream;
            fREBitmapData.acquire();
            int width = fREBitmapData.getWidth();
            int height = fREBitmapData.getHeight();
            Buffer bits = fREBitmapData.getBits();
            Log.d("[GVExtension]", "Image size:" + width + "," + height);
            try {
                fileOutputStream = new FileOutputStream(new File(this.f360b.getApplicationContext().getCacheDir() + File.separator + str));
            } catch (Exception e) {
                Log.d("[GVExtension]", "File caching failed");
                fileOutputStream = null;
            }
            if (fileOutputStream != null) {
                Bitmap createBitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                createBitmap.copyPixelsFromBuffer(bits);
                Bitmap createBitmap2 = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                for (int i = 0; i < height; i++) {
                    for (int i2 = 0; i2 < width; i2++) {
                        int pixel = createBitmap.getPixel(i2, i);
                        createBitmap2.setPixel(i2, i, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                    }
                }
                createBitmap2.compress(CompressFormat.JPEG, 90, fileOutputStream);
                try {
                    fileOutputStream.flush();
                    fileOutputStream.close();
                    fREBitmapData.release();
                } catch (Exception e2) {
                    Log.d("[GVExtension]", "Failed releasing image");
                }
                return Uri.parse("content://" + AttachedFileProvider.f324b + "/" + str);
            }
            try {
                fREBitmapData.release();
            } catch (IllegalStateException e3) {
                Log.d("[GVExtension]", "ERROR: Could not release bitmapdata.");
                Log.e("[GVExtension]", "Failed to write temp image stream.");
                return null;
            } catch (FREInvalidObjectException e4) {
                Log.d("[GVExtension]", "ERROR: Could not release bitmapdata.");
                Log.e("[GVExtension]", "Failed to write temp image stream.");
                return null;
            } catch (FREWrongThreadException e5) {
                Log.d("[GVExtension]", "ERROR: Could not release bitmapdata.");
                Log.e("[GVExtension]", "Failed to write temp image stream.");
                return null;
            }
            Log.e("[GVExtension]", "Failed to write temp image stream.");
            return null;
        } catch (Exception e6) {
            Log.e("[GVExtension]", "Encoding failed!");
            return null;
        }
    }

    private Uri m391a(String str, FREByteArray fREByteArray) {
        try {
            fREByteArray.acquire();
            ByteBuffer bytes = fREByteArray.getBytes();
            File file = new File(this.f360b.getApplicationContext().getCacheDir() + File.separator + str);
            try {
                file.createNewFile();
                FileChannel channel = new FileOutputStream(file).getChannel();
                bytes.order(ByteOrder.LITTLE_ENDIAN);
                channel.write(bytes);
                channel.close();
            } catch (Exception e) {
                Log.d("[GVExtension]", "ERROR: File caching failed");
                file = null;
            }
            try {
                fREByteArray.release();
                if (file != null) {
                    return Uri.parse("content://" + AttachedFileProvider.f324b + "/" + str);
                }
                Log.d("[GVExtension]", "no out file.");
                return null;
            } catch (Exception e2) {
                Log.d("[GVExtension]", "Failed closing stream.");
                return null;
            }
        } catch (Exception e3) {
            Log.e("[GVExtension]", "Encoding failed!");
            return null;
        }
    }

    protected static Bundle m392a(FREArray fREArray, FREArray fREArray2) {
        Bundle bundle = new Bundle();
        int i = 0;
        while (true) {
            try {
                if (((long) i) >= fREArray.getLength()) {
                    break;
                }
                bundle.putString(fREArray.getObjectAt((long) i).getAsString(), fREArray2.getObjectAt((long) i).getAsString());
                i++;
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
        }
        return bundle;
    }

    static /* synthetic */ String m394a(Set set) {
        StringBuilder stringBuilder = new StringBuilder();
        Object obj = 1;
        for (String str : set) {
            if (obj != null) {
                obj = null;
            } else {
                stringBuilder.append(",");
            }
            stringBuilder.append(str);
        }
        return stringBuilder.toString();
    }

    private List<Intent> m395a(Intent intent) {
        List<Intent> arrayList = new ArrayList();
        PackageManager packageManager = this.f360b.getPackageManager();
        List<ResolveInfo> queryIntentActivities = packageManager.queryIntentActivities(intent, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST);
        Intent intent2 = new Intent("android.intent.action.SEND");
        intent2.setType("message/rfc822");
        for (ResolveInfo resolveInfo : packageManager.queryIntentActivities(intent2, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST)) {
            String str = resolveInfo.activityInfo.packageName;
            if (str != null) {
                for (ResolveInfo resolveInfo2 : queryIntentActivities) {
                    String str2 = resolveInfo2.activityInfo.packageName;
                    if (str2.equals(str)) {
                        Intent intent3 = (Intent) intent.clone();
                        intent3.setPackage(str2);
                        Object obj = null;
                        for (Intent intent22 : arrayList) {
                            obj = intent22.getPackage().equalsIgnoreCase(intent3.getPackage()) ? 1 : obj;
                        }
                        if (obj == null) {
                            arrayList.add(intent3);
                        }
                    }
                }
            }
        }
        return arrayList;
    }

    static /* synthetic */ void m396a(C0403a c0403a, Bundle bundle, String str) {
        if (AppInviteDialog.canShow()) {
            Builder builder = new Builder();
            if (bundle.containsKey("previewImageURL")) {
                builder.setPreviewImageUrl(bundle.getString("previewImageURL"));
            }
            if (bundle.containsKey("appLinkURL")) {
                builder.setApplinkUrl(bundle.getString("appLinkURL"));
            }
            AppInviteDialog appInviteDialog = new AppInviteDialog(c0403a.getActivity());
            appInviteDialog.registerCallback(c0403a.f374r, new C0426x(c0403a, str), 194241);
            appInviteDialog.show(builder.build());
        }
    }

    static /* synthetic */ void m397a(C0403a c0403a, Bundle bundle, String str, int i) {
        ShareLinkContent.Builder builder = new ShareLinkContent.Builder();
        if (bundle.containsKey("name")) {
            builder.setContentTitle(bundle.getString("name"));
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_TITLE)) {
            builder.setContentTitle(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_TITLE));
        }
        if (bundle.containsKey("message")) {
            builder.setContentDescription(bundle.getString("message"));
        }
        if (bundle.containsKey("description")) {
            builder.setContentDescription(bundle.getString("description"));
        }
        if (bundle.containsKey("image")) {
            builder.setImageUrl(Uri.parse(bundle.getString("image")));
        }
        if (bundle.containsKey("link")) {
            builder.setContentUrl(Uri.parse(bundle.getString("link")));
        }
        if (bundle.containsKey("place")) {
            builder.setPlaceId(bundle.getString("place"));
        }
        if (bundle.containsKey("ref")) {
            builder.setRef(bundle.getString("ref"));
        }
        if (bundle.containsKey(NativeProtocol.AUDIENCE_FRIENDS)) {
            builder.setPeopleIds(C0403a.m419b(bundle.getString(NativeProtocol.AUDIENCE_FRIENDS)));
        }
        ShareContent build = builder.build();
        ShareDialog shareDialog = new ShareDialog(c0403a.getActivity());
        shareDialog.registerCallback(c0403a.f374r, new C0425w(c0403a, str), 194237);
        Mode mode = Mode.AUTOMATIC;
        if (i == 0) {
            mode = Mode.AUTOMATIC;
        } else if (i == 2) {
            mode = Mode.WEB;
        } else if (i == 3) {
            mode = Mode.FEED;
        } else if (i == 4) {
            mode = Mode.AUTOMATIC;
        }
        shareDialog.show(build, mode);
    }

    static /* synthetic */ void m398a(C0403a c0403a, String str, double d, Bundle bundle) {
        AppEventsLogger s = c0403a.m460s();
        if (bundle != null) {
            s.logEvent(str, d, bundle);
        } else {
            s.logEvent(str, d);
        }
    }

    static /* synthetic */ void m399a(C0403a c0403a, String str, int i) {
        Log.d("[GVExtension]", "request auth-read session..");
        if (AccessToken.getCurrentAccessToken() != null) {
            Log.d("[GVExtension]", "auth called with open session; exit");
            return;
        }
        String[] split = str.split(",");
        Collection arrayList = new ArrayList();
        for (Object add : split) {
            arrayList.add(add);
        }
        Log.d("[GVExtension]", "Set array list " + arrayList.size() + " is " + arrayList);
        LoginManager instance = LoginManager.getInstance();
        if (i == 0) {
            instance.setLoginBehavior(LoginBehavior.NATIVE_WITH_FALLBACK);
        } else if (i != 1) {
            if (i == 2) {
                instance.setLoginBehavior(LoginBehavior.WEB_ONLY);
            } else if (i == 3) {
                instance.setLoginBehavior(LoginBehavior.NATIVE_WITH_FALLBACK);
            } else if (i == 4) {
                instance.setLoginBehavior(LoginBehavior.NATIVE_WITH_FALLBACK);
            }
        }
        instance.logInWithReadPermissions(c0403a.getActivity(), arrayList);
    }

    static /* synthetic */ void m400a(C0403a c0403a, String str, Bundle bundle) {
        AppEventsLogger s = c0403a.m460s();
        if (bundle != null) {
            s.logEvent(str, bundle);
        } else {
            s.logEvent(str);
        }
    }

    static /* synthetic */ void m402a(C0403a c0403a, String str, FREBitmapData fREBitmapData, String str2, String str3) {
        Bundle bundle = new Bundle();
        bundle.putByteArray("picture", C0403a.m422b(fREBitmapData));
        bundle.putString("message", str);
        c0403a.m412a(str2, "POST", bundle, "publish_actions", str3);
    }

    static /* synthetic */ void m404a(C0403a c0403a, String str, String str2, Bundle bundle, FREBitmapData fREBitmapData, String str3) {
        str2.contains(":");
        Bitmap a = fREBitmapData != null ? C0403a.m389a(fREBitmapData) : null;
        ShareOpenGraphObject.Builder builder = new ShareOpenGraphObject.Builder();
        for (String str4 : bundle.keySet()) {
            builder.putString(str4, bundle.getString(str4));
        }
        builder.putString("og:type", str2);
        ShareOpenGraphObject build = builder.build();
        ShareOpenGraphAction.Builder builder2 = new ShareOpenGraphAction.Builder();
        builder2.setActionType(str);
        builder2.putObject(str2, build);
        if (a != null) {
            builder2.putPhoto("image", new SharePhoto.Builder().setBitmap(a).setUserGenerated(true).build());
        }
        ShareOpenGraphContent build2 = new ShareOpenGraphContent.Builder().setPreviewPropertyName(str2).setAction(builder2.build()).build();
        ShareDialog shareDialog = new ShareDialog(c0403a.getActivity());
        shareDialog.registerCallback(c0403a.f374r, new C0423u(c0403a, str3), 194238);
        shareDialog.show(build2);
    }

    static /* synthetic */ void m406a(C0403a c0403a, String str, String str2, String str3, boolean z, String str4, String str5, FREBitmapData fREBitmapData, String str6, String str7) {
        String str8;
        String[] split = str2.split(",");
        String[] split2 = str4.split(",");
        String[] split3 = str5.split(",");
        Intent intent = new Intent("android.intent.action.SEND");
        if (split.length > 0) {
            intent.putExtra("android.intent.extra.EMAIL", split);
        }
        intent.putExtra("android.intent.extra.SUBJECT", str);
        if (split2.length > 0) {
            intent.putExtra("android.intent.extra.CC", split2);
        }
        if (split3.length > 0) {
            intent.putExtra("android.intent.extra.BCC", split3);
        }
        if (z) {
            str8 = "text/html";
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str3));
        } else {
            str8 = "text/plain";
            intent.putExtra("android.intent.extra.TEXT", str3);
        }
        Parcelable a = c0403a.m390a(str6 + ".jpeg", fREBitmapData);
        if (a != null) {
            intent.putExtra("android.intent.extra.STREAM", a);
            str8 = "image/jpeg";
        }
        intent.setType(str8);
        c0403a.f371o = str7;
        List a2 = c0403a.m395a(intent);
        if (a2.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a2.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a2.toArray(new Parcelable[0]));
            c0403a.f360b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0403a.f360b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m407a(C0403a c0403a, String str, String str2, String str3, boolean z, String str4, String str5, FREByteArray fREByteArray, String str6, String str7, String str8) {
        String str9;
        String[] split = str2.split(",");
        String[] split2 = str4.split(",");
        String[] split3 = str5.split(",");
        Intent intent = new Intent("android.intent.action.SEND");
        if (split.length > 0) {
            intent.putExtra("android.intent.extra.EMAIL", split);
        }
        intent.putExtra("android.intent.extra.SUBJECT", str);
        if (split2.length > 0) {
            intent.putExtra("android.intent.extra.CC", split2);
        }
        if (split3.length > 0) {
            intent.putExtra("android.intent.extra.BCC", split3);
        }
        if (z) {
            str9 = "text/html";
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str3));
        } else {
            str9 = "text/plain";
            intent.putExtra("android.intent.extra.TEXT", str3);
        }
        Parcelable a = c0403a.m391a(str7, fREByteArray);
        if (a != null) {
            intent.setType(str6);
            intent.putExtra("android.intent.extra.STREAM", a);
        } else {
            intent.setType(str9);
        }
        c0403a.f371o = str8;
        List a2 = c0403a.m395a(intent);
        if (a2.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a2.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a2.toArray(new Parcelable[0]));
            c0403a.f360b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0403a.f360b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m408a(C0403a c0403a, String str, String str2, String str3, boolean z, String str4, String str5, String str6) {
        String[] split = str2.split(",");
        String[] split2 = str4.split(",");
        String[] split3 = str5.split(",");
        Intent intent = new Intent("android.intent.action.SEND");
        if (split.length > 0) {
            intent.putExtra("android.intent.extra.EMAIL", split);
        }
        intent.putExtra("android.intent.extra.SUBJECT", str);
        if (split2.length > 0) {
            intent.putExtra("android.intent.extra.CC", split2);
        }
        if (split3.length > 0) {
            intent.putExtra("android.intent.extra.BCC", split3);
        }
        if (z) {
            intent.setType("text/html");
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str3));
        } else {
            intent.setType("text/plain");
            intent.putExtra("android.intent.extra.TEXT", str3);
        }
        c0403a.f371o = str6;
        List a = c0403a.m395a(intent);
        Log.d("[GVExtension]", "Client intents length:" + a.size());
        if (a.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a.toArray(new Parcelable[0]));
            c0403a.f360b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0403a.f360b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m409a(C0403a c0403a, String str, String str2, boolean z, FREBitmapData fREBitmapData, String str3, String str4) {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.putExtra("android.intent.extra.SUBJECT", str);
        String str5 = "text/html";
        if (z) {
            intent.setType("text/html");
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str2));
        } else {
            intent.setType("text/plain");
            intent.putExtra("android.intent.extra.TEXT", str2);
        }
        Log.d("[GVExtension]", "share generic image with filename in: " + str4);
        if (str4.equals("")) {
            str4 = "image_1.jpeg";
        }
        Parcelable a = c0403a.m390a(str4, fREBitmapData);
        if (a != null) {
            intent.putExtra("android.intent.extra.STREAM", a);
            str5 = "image/jpeg";
        }
        intent.setType(str5);
        c0403a.f369m = str3;
        c0403a.f360b.startActivityForResult(Intent.createChooser(intent, "Share with:"), 194234);
    }

    static /* synthetic */ void m410a(C0403a c0403a, String str, String str2, boolean z, String str3) {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.putExtra("android.intent.extra.SUBJECT", str);
        if (z) {
            intent.setType("text/html");
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str2));
        } else {
            intent.setType("text/plain");
            intent.putExtra("android.intent.extra.TEXT", str2);
        }
        c0403a.f369m = str3;
        c0403a.f360b.startActivityForResult(Intent.createChooser(intent, "Share with:"), 194233);
    }

    private void m411a(String str, FREBitmapData fREBitmapData, String str2, boolean z) {
        Intent c = m423c("text/plain");
        if (c != null) {
            c.putExtra("android.intent.extra.TEXT", str);
            Parcelable a = m390a("twattachment.jpeg", fREBitmapData);
            if (a != null) {
                c.putExtra("android.intent.extra.STREAM", a);
                c.setType("image/jpeg");
            } else {
                Log.d("[GVExtension]", "Twitter intent did not allow image attachment.");
                c.setType("text/plain");
            }
            this.f372p = str2;
            this.f360b.startActivityForResult(c, z ? 2345235 : 194236);
        }
    }

    private void m412a(String str, String str2, Bundle bundle, String str3, String str4) {
        int i = 0;
        if (C0403a.m458q()) {
            int i2;
            HttpMethod httpMethod;
            GraphRequest graphRequest;
            AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
            Collection arrayList = new ArrayList();
            if (str3 == null || str3.equals("")) {
                i2 = 0;
            } else {
                int i3;
                String[] split = str3.split(",");
                int i4 = 0;
                for (i3 = 0; i3 < split.length; i3++) {
                    if (!currentAccessToken.getPermissions().contains(split[i3])) {
                        Log.d("[GVExtension]", "No current write permission for '" + split[i3] + "'");
                        i4 = 1;
                    }
                }
                i3 = split.length;
                while (i < i3) {
                    arrayList.add(split[i]);
                    i++;
                }
                i2 = i4;
            }
            this.f365i = str;
            this.f368l = str4;
            if (!str2.equals("GET")) {
                if (str2.equals("POST")) {
                    httpMethod = HttpMethod.POST;
                } else if (str2.equals("DELETE")) {
                    httpMethod = HttpMethod.DELETE;
                }
                graphRequest = new GraphRequest(currentAccessToken, str, bundle, httpMethod, new C0405c(this, str, str3, str4));
                if (i2 != 0) {
                    Log.d("[GVExtension]", "No reauth required for this graph request.");
                    graphRequest.executeAsync();
                }
                this.f367k = graphRequest;
                LoginManager.getInstance().logInWithPublishPermissions(getActivity(), arrayList);
                return;
            }
            httpMethod = HttpMethod.GET;
            graphRequest = new GraphRequest(currentAccessToken, str, bundle, httpMethod, new C0405c(this, str, str3, str4));
            if (i2 != 0) {
                this.f367k = graphRequest;
                LoginManager.getInstance().logInWithPublishPermissions(getActivity(), arrayList);
                return;
            }
            Log.d("[GVExtension]", "No reauth required for this graph request.");
            graphRequest.executeAsync();
        }
    }

    private void m413a(String str, String str2, boolean z) {
        Intent c = m423c("text/plain");
        if (c != null) {
            c.putExtra("android.intent.extra.TEXT", str);
            this.f372p = str2;
            this.f360b.startActivityForResult(c, z ? 2345235 : 194236);
        }
    }

    static /* synthetic */ boolean m414a(C0403a c0403a, String str) {
        if (!C0403a.m458q()) {
            return false;
        }
        c0403a.f366j = str;
        AccessToken.refreshCurrentAccessTokenAsync();
        return true;
    }

    static /* synthetic */ boolean m415a(C0403a c0403a, String str, String str2, boolean z, FREBitmapData fREBitmapData, String str3, String str4, String str5) {
        Uri uri = null;
        c0403a.f370n = str4;
        if (str.equals("SINAWEIBO")) {
            return false;
        }
        if (!str.equals("TWITTER")) {
            Intent t;
            Parcelable a = (!z || fREBitmapData == null) ? null : c0403a.m390a("image_1.jpeg", fREBitmapData);
            if (str.equals("FACEBOOK")) {
                t = c0403a.m461t();
                if (t == null) {
                    return false;
                }
                if (str3 != null) {
                    str2 = str2 + " " + str3;
                }
                t.putExtra("android.intent.extra.TEXT", str2);
            } else {
                t = null;
            }
            if (str.equals("SMS")) {
                if (z) {
                    uri = a;
                }
                t = c0403a.m388a(str2, uri, str5);
                if (t == null) {
                    return false;
                }
            }
            if (t == null) {
                return false;
            }
            if (a != null) {
                t.putExtra("android.intent.extra.STREAM", a);
                t.setType("image/jpeg");
            }
            c0403a.f360b.startActivityForResult(t, 2345235);
            return true;
        } else if (z) {
            c0403a.m411a(str2, fREBitmapData, str4, true);
            return true;
        } else {
            c0403a.m413a(str2, str4, true);
            return true;
        }
    }

    static /* synthetic */ boolean m417a(String str) {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? false : currentAccessToken.getPermissions().contains(str);
    }

    private static ArrayList<String> m419b(String str) {
        ArrayList<String> arrayList = new ArrayList();
        String[] split = str.split(",");
        for (Object add : split) {
            arrayList.add(add);
        }
        return arrayList;
    }

    static /* synthetic */ void m420b(C0403a c0403a, Bundle bundle, String str) {
        ShareLinkContent.Builder builder = new ShareLinkContent.Builder();
        if (bundle.containsKey("name")) {
            builder.setContentTitle(bundle.getString("name"));
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_TITLE)) {
            builder.setContentTitle(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_TITLE));
        }
        if (bundle.containsKey("message")) {
            builder.setContentDescription(bundle.getString("message"));
        }
        if (bundle.containsKey("description")) {
            builder.setContentDescription(bundle.getString("description"));
        }
        if (bundle.containsKey("image")) {
            builder.setImageUrl(Uri.parse(bundle.getString("image")));
        }
        if (bundle.containsKey("link")) {
            builder.setContentUrl(Uri.parse(bundle.getString("link")));
        }
        if (bundle.containsKey("place")) {
            builder.setPlaceId(bundle.getString("place"));
        }
        if (bundle.containsKey("ref")) {
            builder.setRef(bundle.getString("ref"));
        }
        if (bundle.containsKey(NativeProtocol.AUDIENCE_FRIENDS)) {
            builder.setPeopleIds(C0403a.m419b(bundle.getString(NativeProtocol.AUDIENCE_FRIENDS)));
        }
        ShareLinkContent build = builder.build();
        MessageDialog messageDialog = new MessageDialog(c0403a.getActivity());
        messageDialog.registerCallback(c0403a.f374r, new C0424v(c0403a, str), 194239);
        messageDialog.show(build);
    }

    static /* synthetic */ void m421b(C0403a c0403a, String str) {
        try {
            c0403a.getActivity().startActivity(new Intent("android.intent.action.VIEW", Uri.parse("twitter://user?screen_name=" + str)));
        } catch (Exception e) {
            try {
                c0403a.getActivity().startActivity(new Intent("android.intent.action.VIEW", Uri.parse("http://www.twitter.com/" + str)));
            } catch (Exception e2) {
            }
        }
    }

    private static byte[] m422b(FREBitmapData fREBitmapData) {
        int width;
        int height;
        Buffer buffer;
        int i;
        OutputStream byteArrayOutputStream;
        Bitmap createBitmap;
        Bitmap createBitmap2;
        int i2;
        int pixel;
        byte[] bArr = null;
        try {
            fREBitmapData.acquire();
            width = fREBitmapData.getWidth();
            try {
                height = fREBitmapData.getHeight();
                try {
                    Buffer bits = fREBitmapData.getBits();
                    Log.d("[GVExtension]", "Image size:" + width + "," + height);
                    int i3 = height;
                    buffer = bits;
                    i = width;
                    width = i3;
                } catch (Exception e) {
                    Log.d("[GVExtension]", "Encoding failed!");
                    i = width;
                    width = height;
                    buffer = null;
                    if (buffer != null) {
                        byteArrayOutputStream = new ByteArrayOutputStream();
                        createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                        createBitmap.copyPixelsFromBuffer(buffer);
                        createBitmap2 = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                        for (height = 0; height < width; height++) {
                            for (i2 = 0; i2 < i; i2++) {
                                pixel = createBitmap.getPixel(i2, height);
                                createBitmap2.setPixel(i2, height, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                            }
                        }
                        Log.d("[GVExtension]", "wrote bitmap height-" + createBitmap2.getHeight());
                        createBitmap2.compress(CompressFormat.JPEG, 90, byteArrayOutputStream);
                        Log.d("[GVExtension]", "results in px39:" + createBitmap2.getPixel(39, 39));
                        bArr = byteArrayOutputStream.toByteArray();
                        try {
                            byteArrayOutputStream.flush();
                            byteArrayOutputStream.close();
                            fREBitmapData.release();
                        } catch (Exception e2) {
                            Log.d("[GVExtension]", "Failed releasing image");
                        }
                    }
                    return bArr;
                }
            } catch (Exception e3) {
                height = 0;
                Log.d("[GVExtension]", "Encoding failed!");
                i = width;
                width = height;
                buffer = null;
                if (buffer != null) {
                    byteArrayOutputStream = new ByteArrayOutputStream();
                    createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                    createBitmap.copyPixelsFromBuffer(buffer);
                    createBitmap2 = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                    for (height = 0; height < width; height++) {
                        for (i2 = 0; i2 < i; i2++) {
                            pixel = createBitmap.getPixel(i2, height);
                            createBitmap2.setPixel(i2, height, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                        }
                    }
                    Log.d("[GVExtension]", "wrote bitmap height-" + createBitmap2.getHeight());
                    createBitmap2.compress(CompressFormat.JPEG, 90, byteArrayOutputStream);
                    Log.d("[GVExtension]", "results in px39:" + createBitmap2.getPixel(39, 39));
                    bArr = byteArrayOutputStream.toByteArray();
                    byteArrayOutputStream.flush();
                    byteArrayOutputStream.close();
                    fREBitmapData.release();
                }
                return bArr;
            }
        } catch (Exception e4) {
            height = 0;
            width = 0;
            Log.d("[GVExtension]", "Encoding failed!");
            i = width;
            width = height;
            buffer = null;
            if (buffer != null) {
                byteArrayOutputStream = new ByteArrayOutputStream();
                createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                createBitmap.copyPixelsFromBuffer(buffer);
                createBitmap2 = Bitmap.createBitmap(i, width, Config.ARGB_8888);
                for (height = 0; height < width; height++) {
                    for (i2 = 0; i2 < i; i2++) {
                        pixel = createBitmap.getPixel(i2, height);
                        createBitmap2.setPixel(i2, height, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                    }
                }
                Log.d("[GVExtension]", "wrote bitmap height-" + createBitmap2.getHeight());
                createBitmap2.compress(CompressFormat.JPEG, 90, byteArrayOutputStream);
                Log.d("[GVExtension]", "results in px39:" + createBitmap2.getPixel(39, 39));
                bArr = byteArrayOutputStream.toByteArray();
                byteArrayOutputStream.flush();
                byteArrayOutputStream.close();
                fREBitmapData.release();
            }
            return bArr;
        }
        if (buffer != null) {
            byteArrayOutputStream = new ByteArrayOutputStream();
            createBitmap = Bitmap.createBitmap(i, width, Config.ARGB_8888);
            createBitmap.copyPixelsFromBuffer(buffer);
            createBitmap2 = Bitmap.createBitmap(i, width, Config.ARGB_8888);
            for (height = 0; height < width; height++) {
                for (i2 = 0; i2 < i; i2++) {
                    pixel = createBitmap.getPixel(i2, height);
                    createBitmap2.setPixel(i2, height, ((((pixel & 255) << 16) | (((pixel >> 24) & 255) << 24)) | (((pixel >> 8) & 255) << 8)) | ((pixel >> 16) & 255));
                }
            }
            Log.d("[GVExtension]", "wrote bitmap height-" + createBitmap2.getHeight());
            createBitmap2.compress(CompressFormat.JPEG, 90, byteArrayOutputStream);
            Log.d("[GVExtension]", "results in px39:" + createBitmap2.getPixel(39, 39));
            bArr = byteArrayOutputStream.toByteArray();
            byteArrayOutputStream.flush();
            byteArrayOutputStream.close();
            fREBitmapData.release();
        }
        return bArr;
    }

    private Intent m423c(String str) {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.setType(str);
        List<ResolveInfo> queryIntentActivities = this.f360b.getPackageManager().queryIntentActivities(intent, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST);
        int i = 0;
        while (i < f357a.length) {
            for (ResolveInfo resolveInfo : queryIntentActivities) {
                String str2 = resolveInfo.activityInfo.packageName;
                if (str2 != null && str2.startsWith(f357a[i])) {
                    intent.setPackage(str2);
                    return intent;
                }
            }
            i++;
        }
        return null;
    }

    static /* synthetic */ void m425c(C0403a c0403a, Bundle bundle, String str) {
        String string;
        GameRequestDialog gameRequestDialog = new GameRequestDialog(c0403a.getActivity());
        gameRequestDialog.registerCallback(c0403a.f374r, new C0427y(c0403a, str), 194240);
        GameRequestContent.Builder builder = new GameRequestContent.Builder();
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_TITLE)) {
            builder.setTitle(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_TITLE));
            bundle.remove(ShareConstants.WEB_DIALOG_PARAM_TITLE);
        }
        if (bundle.containsKey("message")) {
            builder.setMessage(bundle.getString("message"));
            bundle.remove("message");
        }
        if (bundle.containsKey("to")) {
            string = bundle.getString("to");
            if (string != null) {
                builder.setRecipients(Arrays.asList(string.split(",")));
            }
            bundle.remove("to");
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_DATA)) {
            builder.setData(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_DATA));
            bundle.remove(ShareConstants.WEB_DIALOG_PARAM_DATA);
        }
        if (bundle.containsKey("object_id")) {
            builder.setObjectId(bundle.getString("object_id"));
            bundle.remove("object_id");
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_ACTION_TYPE)) {
            string = bundle.getString(ShareConstants.WEB_DIALOG_PARAM_ACTION_TYPE);
            if (string.equals("send")) {
                builder.setActionType(ActionType.SEND);
            } else if (string.equals("turn")) {
                builder.setActionType(ActionType.TURN);
            } else if (string.equals("askfor")) {
                builder.setActionType(ActionType.ASKFOR);
            }
            bundle.remove(ShareConstants.WEB_DIALOG_PARAM_ACTION_TYPE);
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_SUGGESTIONS)) {
            builder.setSuggestions(new ArrayList(Arrays.asList(bundle.getString(ShareConstants.WEB_DIALOG_PARAM_SUGGESTIONS).split(","))));
            bundle.remove(ShareConstants.WEB_DIALOG_PARAM_SUGGESTIONS);
        }
        if (bundle.containsKey(ShareConstants.WEB_DIALOG_PARAM_FILTERS)) {
            string = bundle.getString(ShareConstants.WEB_DIALOG_PARAM_FILTERS);
            if (string.equals("app_users")) {
                builder.setFilters(Filters.APP_USERS);
            } else if (string.equals("app_non_users")) {
                builder.setFilters(Filters.APP_NON_USERS);
            }
            bundle.remove(ShareConstants.WEB_DIALOG_PARAM_FILTERS);
        }
        gameRequestDialog.show(builder.build());
    }

    static /* synthetic */ boolean m426c(C0403a c0403a, String str) {
        Log.d("[GVExtension]", "Service check:" + str);
        if (!str.equals("SINAWEIBO")) {
            if (str.equals("FACEBOOK")) {
                return c0403a.m461t() != null;
            } else {
                if (str.equals("TWITTER")) {
                    return c0403a.m459r();
                }
                if (str.equals("SMS")) {
                    return c0403a.m388a("test", null, "") != null;
                }
            }
        }
        return false;
    }

    static /* synthetic */ void m428d(C0403a c0403a, String str) {
        String str2;
        String str3;
        NameNotFoundException e;
        NoSuchAlgorithmException e2;
        Exception e3;
        AlertDialog create;
        Intent intent;
        Bundle bundleExtra;
        Uri parse;
        c0403a.f362f = str;
        c0403a.f366j = null;
        c0403a.f364h = null;
        c0403a.f363g = null;
        if (f359d) {
            Log.d("[GVExtension]", "doDebugDisplay");
            str2 = "";
            try {
                Signature[] signatureArr = c0403a.f360b.getPackageManager().getPackageInfo(c0403a.f360b.getApplicationContext().getPackageName(), 64).signatures;
                int length = signatureArr.length;
                str3 = str2;
                int i = 0;
                while (i < length) {
                    try {
                        Signature signature = signatureArr[i];
                        MessageDigest instance = MessageDigest.getInstance("SHA");
                        instance.update(signature.toByteArray());
                        i++;
                        str3 = Base64.encodeToString(instance.digest(), 0);
                    } catch (NameNotFoundException e4) {
                        e = e4;
                    } catch (NoSuchAlgorithmException e5) {
                        e2 = e5;
                    } catch (Exception e6) {
                        e3 = e6;
                    }
                }
            } catch (NameNotFoundException e7) {
                NameNotFoundException nameNotFoundException = e7;
                str3 = str2;
                e = nameNotFoundException;
                Log.e("name not found", e.toString());
                str3 = str3;
                create = new AlertDialog.Builder(c0403a.f360b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0406d(c0403a, str3));
                create.setButton(-2, "Close", new C0407e(c0403a));
                create.show();
                FacebookSdk.setApplicationId(c0403a.f362f);
                FacebookSdk.sdkInitialize(c0403a.getActivity().getApplicationContext());
                Log.d("[GVExtension]", "Did init fb");
                c0403a.f374r = Factory.create();
                LoginManager.getInstance().registerCallback(c0403a.f374r, new C0404b(c0403a));
                c0403a.f375s = new C0415m(c0403a);
                intent = c0403a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0403a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                        }
                        if (!c0403a.f376t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0403a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0403a.f376t) {
                }
            } catch (NoSuchAlgorithmException e8) {
                NoSuchAlgorithmException noSuchAlgorithmException = e8;
                str3 = str2;
                e2 = noSuchAlgorithmException;
                Log.e("no such an algorithm", e2.toString());
                str3 = str3;
                create = new AlertDialog.Builder(c0403a.f360b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0406d(c0403a, str3));
                create.setButton(-2, "Close", new C0407e(c0403a));
                create.show();
                FacebookSdk.setApplicationId(c0403a.f362f);
                FacebookSdk.sdkInitialize(c0403a.getActivity().getApplicationContext());
                Log.d("[GVExtension]", "Did init fb");
                c0403a.f374r = Factory.create();
                LoginManager.getInstance().registerCallback(c0403a.f374r, new C0404b(c0403a));
                c0403a.f375s = new C0415m(c0403a);
                intent = c0403a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0403a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                        }
                        if (!c0403a.f376t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0403a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0403a.f376t) {
                }
            } catch (Exception e9) {
                Exception exception = e9;
                str3 = str2;
                e3 = exception;
                Log.e("exception", e3.toString());
                str3 = str3;
                create = new AlertDialog.Builder(c0403a.f360b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0406d(c0403a, str3));
                create.setButton(-2, "Close", new C0407e(c0403a));
                create.show();
                FacebookSdk.setApplicationId(c0403a.f362f);
                FacebookSdk.sdkInitialize(c0403a.getActivity().getApplicationContext());
                Log.d("[GVExtension]", "Did init fb");
                c0403a.f374r = Factory.create();
                LoginManager.getInstance().registerCallback(c0403a.f374r, new C0404b(c0403a));
                c0403a.f375s = new C0415m(c0403a);
                intent = c0403a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0403a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                        }
                        if (!c0403a.f376t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0403a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0403a.f376t) {
                }
            }
            str3 = str3;
            create = new AlertDialog.Builder(c0403a.f360b).create();
            create.setTitle("DEBUG");
            create.setMessage("Your fb hashkey is " + str3);
            create.setButton(-1, "Mail it", new C0406d(c0403a, str3));
            create.setButton(-2, "Close", new C0407e(c0403a));
            create.show();
        }
        FacebookSdk.setApplicationId(c0403a.f362f);
        FacebookSdk.sdkInitialize(c0403a.getActivity().getApplicationContext());
        Log.d("[GVExtension]", "Did init fb");
        c0403a.f374r = Factory.create();
        LoginManager.getInstance().registerCallback(c0403a.f374r, new C0404b(c0403a));
        c0403a.f375s = new C0415m(c0403a);
        intent = c0403a.getActivity().getIntent();
        bundleExtra = intent.getBundleExtra("al_applink_data");
        if (bundleExtra != null) {
            str2 = bundleExtra.getString("target_url");
            if (str2 != null) {
                parse = Uri.parse(str2);
                if (parse == null) {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0403a.dispatchStatusEventAsync("701", parse.toString());
                } else {
                    AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
                }
                if (!c0403a.f376t && !c0403a.f377u) {
                    Log.d("[GVExtension]", "init fb with token check");
                    if (AccessToken.getCurrentAccessToken() != null) {
                        Log.d("[GVExtension]", "init fb token found");
                        if (c0403a.f377u) {
                            Log.d("[GVExtension]", "init fb already dispatched");
                            return;
                        }
                        c0403a.dispatchStatusEventAsync("5", "");
                        c0403a.f376t = true;
                        c0403a.f377u = true;
                        return;
                    }
                    Log.d("[GVExtension]", "init fb token not found");
                    return;
                }
            }
        }
        parse = intent.getData();
        if (parse == null) {
            AppLinkData.fetchDeferredAppLinkData(c0403a.f360b, new C0422t(c0403a));
        } else {
            Log.i("Activity", "App Link Target URL: " + parse.toString());
            c0403a.dispatchStatusEventAsync("701", parse.toString());
        }
        if (!c0403a.f376t) {
        }
    }

    static /* synthetic */ String m430e() {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        if (currentAccessToken == null) {
            return "";
        }
        StringBuilder stringBuilder = new StringBuilder();
        Object obj = 1;
        for (String str : currentAccessToken.getDeclinedPermissions()) {
            if (obj != null) {
                obj = null;
            } else {
                stringBuilder.append(",");
            }
            stringBuilder.append(str);
        }
        return stringBuilder.toString();
    }

    static /* synthetic */ boolean m432e(C0403a c0403a, String str) {
        if (C0403a.m458q()) {
            boolean z;
            Collection arrayList = new ArrayList();
            if (str == null || str.equals("")) {
                z = false;
            } else {
                int i;
                String[] split = str.split(",");
                z = false;
                for (i = 0; i < split.length; i++) {
                    if (!AccessToken.getCurrentAccessToken().getPermissions().contains(split[i])) {
                        Log.d("[GVExtension]", "No current publish permission for '" + split[i] + "'");
                        z = true;
                    }
                }
                for (Object add : split) {
                    arrayList.add(add);
                }
            }
            if (z) {
                c0403a.f364h = str;
                LoginManager.getInstance().logInWithPublishPermissions(c0403a.getActivity(), arrayList);
                return true;
            }
        }
        return false;
    }

    static /* synthetic */ boolean m435f(C0403a c0403a, String str) {
        if (C0403a.m458q()) {
            boolean z;
            Collection arrayList = new ArrayList();
            if (str == null || str.equals("")) {
                z = false;
            } else {
                int i;
                String[] split = str.split(",");
                z = false;
                for (i = 0; i < split.length; i++) {
                    if (!AccessToken.getCurrentAccessToken().getPermissions().contains(split[i])) {
                        Log.d("[GVExtension]", "No current read permission for '" + split[i] + "'");
                        z = true;
                    }
                }
                for (Object add : split) {
                    arrayList.add(add);
                }
            }
            if (z) {
                c0403a.f363g = str;
                LoginManager.getInstance().logInWithReadPermissions(c0403a.getActivity(), arrayList);
                return true;
            }
        }
        return false;
    }

    static /* synthetic */ void m437g(C0403a c0403a, String str) {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        String str2 = c0403a.f362f;
        if (str2 == null && currentAccessToken != null) {
            str2 = currentAccessToken.getApplicationId();
        }
        if (str2 != null) {
            String str3 = str2 + "/custom_audience_third_party_id";
            AttributionIdentifiers attributionIdentifiers = AttributionIdentifiers.getAttributionIdentifiers(c0403a.getActivity().getApplicationContext());
            Bundle bundle = new Bundle();
            if (currentAccessToken == null) {
                str2 = attributionIdentifiers.getAttributionId() != null ? attributionIdentifiers.getAttributionId() : attributionIdentifiers.getAndroidAdvertiserId();
                if (attributionIdentifiers.getAttributionId() != null) {
                    bundle.putString("udid", str2);
                }
            }
            if (FacebookSdk.getLimitEventAndDataUsage(c0403a.getActivity().getApplicationContext()) || attributionIdentifiers.isTrackingLimited()) {
                bundle.putString("limit_event_usage", AppEventsConstants.EVENT_PARAM_VALUE_YES);
            }
            new GraphRequest(currentAccessToken, str3, bundle, HttpMethod.GET, new C0428z(c0403a, str)).executeAsync();
        }
    }

    static /* synthetic */ void m440h() {
    }

    static /* synthetic */ void m441h(C0403a c0403a, String str) {
        Intent intent;
        try {
            if (c0403a.getActivity().getPackageManager().getPackageInfo("com.facebook.katana", 0).versionCode >= 3002850) {
                String str2 = "android.intent.action.VIEW";
                intent = new Intent(str2, Uri.parse("fb://facewebmodal/f?href=" + ("https://www.facebook.com/profile.php?id=" + str)));
            } else {
                intent = new Intent("android.intent.action.VIEW", Uri.parse("fb://profile/" + str));
            }
        } catch (Exception e) {
            intent = new Intent("android.intent.action.VIEW", Uri.parse("https://m.facebook.com/profile.php?id=" + str));
        }
        c0403a.getActivity().startActivity(intent);
    }

    static /* synthetic */ void m450m() {
        if (AccessToken.getCurrentAccessToken() != null) {
            LoginManager.getInstance().logOut();
        }
    }

    static /* synthetic */ void m452n() {
    }

    static /* synthetic */ void m453n(C0403a c0403a) {
        Log.d("[GVExtension]", "GoViral initializer-.");
        c0403a.f376t = false;
        c0403a.f377u = false;
        c0403a.f360b = c0403a.getActivity();
        c0403a.f361e = new ca(c0403a);
        c0403a.f361e.m257a(c0403a);
        f358c = c0403a;
        AttachedFileProvider.f324b = c0403a.f360b.getApplicationContext().getPackageName() + ".AttachedFileProvider";
    }

    static /* synthetic */ String m454o() {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? "" : currentAccessToken.getToken();
    }

    static /* synthetic */ double m456p() {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? 0.0d : (double) (currentAccessToken.getExpires().getTime() / 1000);
    }

    private static boolean m458q() {
        return AccessToken.getCurrentAccessToken() != null;
    }

    private boolean m459r() {
        return m423c("text/plain") != null;
    }

    private AppEventsLogger m460s() {
        if (this.f373q == null) {
            this.f373q = AppEventsLogger.newLogger(getActivity());
        }
        return this.f373q;
    }

    private Intent m461t() {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.setType("text/plain");
        for (ResolveInfo resolveInfo : this.f360b.getPackageManager().queryIntentActivities(intent, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST)) {
            if (resolveInfo.activityInfo.packageName.contains("com.facebook.katana")) {
                ActivityInfo activityInfo = resolveInfo.activityInfo;
                intent.setComponent(new ComponentName(activityInfo.applicationInfo.packageName, activityInfo.name));
                return intent;
            }
        }
        return null;
    }

    public final void mo323a() {
        Log.d("[GVExtension]", "started fb");
    }

    public final void mo324a(int i, int i2, Intent intent) {
        Log.d("[GVExtension]", "r=" + i);
        if (FacebookSdk.isFacebookRequestCode(i) || i == 194240 || i == 194237 || i == 194241 || i == 194238 || i == 194239) {
            Log.d("[GVExtension]", "facebook handler caught activityresult");
            this.f374r.onActivityResult(i, i2, intent);
        } else {
            Log.d("[GVExtension]", "Facebook handler ignore unrelated activityresult");
        }
        if (i == 194236) {
            dispatchStatusEventAsync(this.f372p + "[[[GVRiD]]]18", "");
        }
        if (i == 194235) {
            dispatchStatusEventAsync(this.f371o + "[[[GVRiD]]]3", "");
        }
        if (i == 194234 || i == 194233) {
            dispatchStatusEventAsync(this.f369m + "[[[GVRiD]]]30", "");
        }
        if (i == 2345235) {
            dispatchStatusEventAsync(this.f370n + "[[[GVRiD]]]51", "");
        }
    }

    public final void m464a(int i, String str, String str2, String str3) {
        String str4 = i + "[ERR]" + str + "[URL]" + str2;
        Log.d("[GVExtension]", "FB Dialog failed:" + str4);
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]11", str4);
    }

    public final void m465a(int i, String str, String str2, String str3, boolean z, String str4, String str5) {
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]13", "{\"permissions\":\"" + str5 + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + str + "\",\"gvUrl\":\"" + str2 + "\",\"gvUserMessage\":\"" + str4 + "\"}");
    }

    public final void m466a(String str, Bundle bundle, String str2) {
        Log.d("[GVExtension]", "FBDialogFinished.");
        JSONStringer jSONStringer = new JSONStringer();
        String str3 = "{\"gvDialogType\":\"" + str + "\"}";
        if (bundle != null) {
            try {
                jSONStringer.object();
                jSONStringer.key("gvDialogType");
                jSONStringer.value(str);
                for (String str32 : bundle.keySet()) {
                    jSONStringer.key(str32);
                    jSONStringer.value(bundle.get(str32));
                }
                jSONStringer.endObject();
                str32 = jSONStringer.toString();
            } catch (Exception e) {
                Log.d("[GVExtension]", "Failed parsing fb dialog return values.");
                str32 = "{\"gvDialogType\":\"" + str + "\"}";
            }
        }
        dispatchStatusEventAsync(str2 + "[[[GVRiD]]]9", str32);
    }

    public final void m467a(String str, String str2) {
        String str3 = "{\"gvDialogType\":\"" + str + "\"}";
        Log.d("[GVExtension]", "facebook dialog canceled :" + str);
        dispatchStatusEventAsync(str2 + "[[[GVRiD]]]10", str3);
    }

    public final void m468a(String str, String str2, String str3) {
        String str4 = str + "[URL]" + str2;
        Log.d("[GVExtension]", "onrawresponse:" + str4);
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]12", str4);
    }

    public final void mo325b() {
        if (this.f362f != null) {
        }
    }

    public final void mo326c() {
        if (this.f375s != null) {
            this.f375s.stopTracking();
        }
    }

    public final void dispose() {
        this.f360b = null;
    }

    public final Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> hashMap = new HashMap();
        hashMap.put("ffiInitGoViral", new C0390n());
        hashMap.put("ffiCanSendEmail", new C0378b());
        hashMap.put("ffiShowEmailComposer", new C0400x());
        hashMap.put("ffiShowEmailComposerWithBitmap", new C0401y());
        hashMap.put("ffiShowEmailComposerWithByteArray", new C0402z());
        hashMap.put("ffiInitFacebook", new C0389m());
        hashMap.put("ffiAuthenticateWithFacebook", new C0377a());
        hashMap.put("ffiIsFacebookAuthenticated", new C0391o());
        hashMap.put("ffiLogoutFacebook", new C0395s());
        hashMap.put("ffiShowFacebookFeedDialog", new aa());
        hashMap.put("ffiShowFacebookRequestDialog", new ab());
        hashMap.put("ffiFacebookGraphRequest", new C0381e());
        hashMap.put("ffiFacebookPostPhoto", new C0383g());
        hashMap.put("ffiGetAccessToken", new C0387k());
        hashMap.put("ffiShowTweetSheet", new ac());
        hashMap.put("ffiShowTweetSheetWithImage", new ad());
        hashMap.put("ffiIsTweetSheetAvailable", new C0394r());
        hashMap.put("ffiIsGenericShareAvailable", new C0392p());
        hashMap.put("ffiShareGeneric", new C0385i());
        hashMap.put("ffiShareGenericWithImage", new C0386j());
        hashMap.put("ffiPublishInstall", new C0397u());
        hashMap.put("ffiGetFbAccessExpiry", new C0388l());
        hashMap.put("ffiRequestNewReadPermissions", new C0399w());
        hashMap.put("ffiRequestNewPublishPermissions", new C0398v());
        hashMap.put("ffiFacebookLogAppEvent", new C0382f());
        hashMap.put("ffiFacebookRequestAppUserID", new C0384h());
        hashMap.put("ffiPresentFacebookProfileOrPage", new C0396t());
        hashMap.put("ffiIsServiceAvailable", new C0393q());
        hashMap.put("ffiDisplaySocialView", new C0379c());
        hashMap.put("ffiIsAppInviteDialogAvailable", new C0408f(this));
        hashMap.put("ffiIsPermissionGranted", new C0409g(this));
        hashMap.put("ffiGetDeclinedPermissions", new C0410h(this));
        hashMap.put("ffiIsFacebookShareDialogAvailable", new C0411i(this));
        hashMap.put("ffiShowFacebookShareDialog", new C0412j(this));
        hashMap.put("ffiShowFacebookAppInviteDialog", new C0413k(this));
        hashMap.put("ffiIsFacebookGraphDialogAvailable", new C0414l(this));
        hashMap.put("ffiShowFacebookGraphDialog", new C0416n(this));
        hashMap.put("ffiStageFacebookImage", new C0417o(this));
        hashMap.put("ffiIsFacebookMessageDialogAvailable", new C0418p(this));
        hashMap.put("ffiShowFacebookMessageDialog", new C0419q(this));
        hashMap.put("ffiRefreshSessionPermissions", new C0420r(this));
        hashMap.put("ffiPresentTwitterProfile", new C0421s(this));
        return hashMap;
    }
}
