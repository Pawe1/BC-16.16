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
import android.os.Environment;
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
import com.adobe.fre.FREObject;
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
import com.facebook.share.model.AppInviteContent;
import com.facebook.share.model.GameRequestContent;
import com.facebook.share.model.GameRequestContent.ActionType;
import com.facebook.share.model.GameRequestContent.Filters;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.model.ShareLinkContent.Builder;
import com.facebook.share.model.ShareOpenGraphAction;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.model.ShareOpenGraphObject;
import com.facebook.share.model.SharePhoto;
import com.facebook.share.widget.AppInviteDialog;
import com.facebook.share.widget.GameRequestDialog;
import com.facebook.share.widget.MessageDialog;
import com.facebook.share.widget.ShareDialog;
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
import p000c.p001m.p002x.p003a.gv.bv;
import p000c.p001m.p002x.p003a.gv.by;

@TargetApi(8)
public final class C0351a extends FREContext implements by {
    public static final String[] f343a = new String[]{"com.twitdroid", "com.twitter.android", "com.handmark.tweetcaster", "com.thedeck.android"};
    public static FREContext f344c;
    public static boolean f345d = false;
    public Activity f346b = null;
    private bv f347e;
    private String f348f;
    private String f349g;
    private String f350h;
    private String f351i;
    private String f352j;
    private GraphRequest f353k;
    private String f354l;
    private String f355m;
    private String f356n;
    private String f357o;
    private String f358p;
    private AppEventsLogger f359q;
    private CallbackManager f360r;
    private AccessTokenTracker f361s;
    private boolean f362t;
    private boolean f363u;

    private class C0325a implements FREFunction {
        final /* synthetic */ C0351a f312a;

        private C0325a(C0351a c0351a) {
            this.f312a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m385a(this.f312a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsInt());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class aa implements FREFunction {
        final /* synthetic */ C0351a f313a;

        private aa(C0351a c0351a) {
            this.f313a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                FREArray fREArray = (FREArray) fREObjectArr[0];
                FREArray fREArray2 = (FREArray) fREObjectArr[1];
                fREObjectArr[2].getAsString();
                C0351a.m379a(fREArray, fREArray2);
                C0351a c0351a = this.f313a;
                C0351a.m439n();
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ab implements FREFunction {
        final /* synthetic */ C0351a f314a;

        private ab(C0351a c0351a) {
            this.f314a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                FREArray fREArray = (FREArray) fREObjectArr[0];
                FREArray fREArray2 = (FREArray) fREObjectArr[1];
                String asString = fREObjectArr[2].getAsString();
                C0351a.m414d(this.f314a, C0351a.m379a(fREArray, fREArray2), asString);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ac implements FREFunction {
        final /* synthetic */ C0351a f315a;

        private ac(C0351a c0351a) {
            this.f315a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                this.f315a.m399a(fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), false);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class ad implements FREFunction {
        final /* synthetic */ C0351a f316a;

        private ad(C0351a c0351a) {
            this.f316a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                this.f316a.m397a(fREObjectArr[0].getAsString(), (FREBitmapData) fREObjectArr[1], fREObjectArr[2].getAsString(), false);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0326b implements FREFunction {
        final /* synthetic */ C0351a f317a;

        private C0326b(C0351a c0351a) {
            this.f317a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f317a;
                return FREObject.newObject(true);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0327c implements FREFunction {
        final /* synthetic */ C0351a f318a;

        private C0327c(C0351a c0351a) {
            this.f318a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m401a(this.f318a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), (FREBitmapData) fREObjectArr[3], fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), fREObjectArr[6].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private abstract class C0328d implements FREFunction {
        protected C0351a f319b;
        final /* synthetic */ C0351a f320c;

        public C0328d(C0351a c0351a) {
            this.f320c = c0351a;
            this.f319b = c0351a;
        }

        protected abstract FREObject mo297a(FREObject[] fREObjectArr);

        public FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            FREObject fREObject = null;
            try {
                fREObject = mo297a(fREObjectArr);
            } catch (Exception e) {
                Log.d("[GVExtension]", "Call failed");
                Log.e("[GVExtension]", e.getMessage());
                e.printStackTrace();
            }
            return fREObject;
        }
    }

    private class C0329e implements FREFunction {
        final /* synthetic */ C0351a f321a;

        private C0329e(C0351a c0351a) {
            this.f321a = c0351a;
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
                this.f321a.m398a(asString, asString2, C0351a.m379a(fREArray, fREArray2), asString3, asString4);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0330f implements FREFunction {
        final /* synthetic */ C0351a f322a;

        private C0330f(C0351a c0351a) {
            this.f322a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                boolean asBool = fREObjectArr[1].getAsBool();
                boolean asBool2 = fREObjectArr[2].getAsBool();
                Bundle a = asBool ? C0351a.m379a((FREArray) fREObjectArr[3], (FREArray) fREObjectArr[4]) : null;
                if (asBool2) {
                    C0351a.m384a(this.f322a, asString, fREObjectArr[5].getAsDouble(), a);
                } else {
                    C0351a.m386a(this.f322a, asString, a);
                }
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0331g implements FREFunction {
        final /* synthetic */ C0351a f323a;

        private C0331g(C0351a c0351a) {
            this.f323a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                FREBitmapData fREBitmapData = (FREBitmapData) fREObjectArr[1];
                String asString2 = fREObjectArr[2].getAsString();
                String asString3 = fREObjectArr[3].getAsString();
                fREObjectArr[4].getAsBool();
                C0351a.m388a(this.f323a, asString, fREBitmapData, asString2, asString3);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0332h implements FREFunction {
        final /* synthetic */ C0351a f324a;

        private C0332h(C0351a c0351a) {
            this.f324a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m424g(this.f324a, fREObjectArr[0].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0333i implements FREFunction {
        final /* synthetic */ C0351a f325a;

        private C0333i(C0351a c0351a) {
            this.f325a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m396a(this.f325a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), fREObjectArr[5].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0334j implements FREFunction {
        final /* synthetic */ C0351a f326a;

        private C0334j(C0351a c0351a) {
            this.f326a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m395a(this.f326a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsBool(), (FREBitmapData) fREObjectArr[3], fREObjectArr[6].getAsString(), fREObjectArr[7].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0335k implements FREFunction {
        final /* synthetic */ C0351a f327a;

        private C0335k(C0351a c0351a) {
            this.f327a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f327a;
                return FREObject.newObject(C0351a.m441o());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0336l implements FREFunction {
        final /* synthetic */ C0351a f328a;

        private C0336l(C0351a c0351a) {
            this.f328a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f328a;
                return FREObject.newObject(C0351a.m443p());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0337m implements FREFunction {
        final /* synthetic */ C0351a f329a;

        private C0337m(C0351a c0351a) {
            this.f329a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                String asString = fREObjectArr[0].getAsString();
                fREObjectArr[1].getAsString();
                fREObjectArr[2].getAsBool();
                C0351a.m415d(this.f329a, asString);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0338n implements FREFunction {
        final /* synthetic */ C0351a f330a;

        private C0338n(C0351a c0351a) {
            this.f330a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                Log.d("[GVExtension]", "call inner init");
                C0351a.m440n(this.f330a);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0339o implements FREFunction {
        final /* synthetic */ C0351a f331a;

        private C0339o(C0351a c0351a) {
            this.f331a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f331a;
                return FREObject.newObject(C0351a.m445q());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0340p implements FREFunction {
        final /* synthetic */ C0351a f332a;

        private C0340p(C0351a c0351a) {
            this.f332a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f332a;
                return FREObject.newObject(true);
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0341q implements FREFunction {
        final /* synthetic */ C0351a f333a;

        private C0341q(C0351a c0351a) {
            this.f333a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0351a.m412c(this.f333a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0342r implements FREFunction {
        final /* synthetic */ C0351a f334a;

        private C0342r(C0351a c0351a) {
            this.f334a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(this.f334a.m446r());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0343s implements FREFunction {
        final /* synthetic */ C0351a f335a;

        private C0343s(C0351a c0351a) {
            this.f335a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a c0351a = this.f335a;
                C0351a.m437m();
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0344t implements FREFunction {
        final /* synthetic */ C0351a f336a;

        private C0344t(C0351a c0351a) {
            this.f336a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m428h(this.f336a, fREObjectArr[0].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0345u implements FREFunction {
        final /* synthetic */ C0351a f337a;

        private C0345u(C0351a c0351a) {
            this.f337a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(AppEventsLogger.activateApp(this.f337a.getActivity(), this.f337a.f348f));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0346v implements FREFunction {
        final /* synthetic */ C0351a f338a;

        private C0346v(C0351a c0351a) {
            this.f338a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0351a.m419e(this.f338a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0347w implements FREFunction {
        final /* synthetic */ C0351a f339a;

        private C0347w(C0351a c0351a) {
            this.f339a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                return FREObject.newObject(C0351a.m422f(this.f339a, fREObjectArr[0].getAsString()));
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
                return null;
            }
        }
    }

    private class C0348x implements FREFunction {
        final /* synthetic */ C0351a f340a;

        private C0348x(C0351a c0351a) {
            this.f340a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m394a(this.f340a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsString(), fREObjectArr[3].getAsBool(), fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), fREObjectArr[6].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0349y implements FREFunction {
        final /* synthetic */ C0351a f341a;

        private C0349y(C0351a c0351a) {
            this.f341a = c0351a;
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
                C0351a.m392a(this.f341a, asString, asString2, asString3, asBool, asString4, asString5, fREBitmapData, fREObjectArr[8].getAsString(), fREObjectArr[9].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private class C0350z implements FREFunction {
        final /* synthetic */ C0351a f342a;

        private C0350z(C0351a c0351a) {
            this.f342a = c0351a;
        }

        public final FREObject call(FREContext fREContext, FREObject[] fREObjectArr) {
            try {
                C0351a.m393a(this.f342a, fREObjectArr[0].getAsString(), fREObjectArr[1].getAsString(), fREObjectArr[2].getAsString(), fREObjectArr[3].getAsBool(), fREObjectArr[4].getAsString(), fREObjectArr[5].getAsString(), (FREByteArray) fREObjectArr[6], fREObjectArr[7].getAsString(), fREObjectArr[8].getAsString(), fREObjectArr[9].getAsString());
            } catch (Exception e) {
                Log.e("[GVExtension]", e.getMessage());
            }
            return null;
        }
    }

    private Intent m375a(String str, Uri uri, String str2) {
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

    private static Bitmap m376a(FREBitmapData fREBitmapData) {
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

    private static Uri m377a(String str, FREBitmapData fREBitmapData) {
        try {
            OutputStream fileOutputStream;
            fREBitmapData.acquire();
            int width = fREBitmapData.getWidth();
            int height = fREBitmapData.getHeight();
            Buffer bits = fREBitmapData.getBits();
            Log.d("[GVExtension]", "Image size:" + width + "," + height);
            try {
                fileOutputStream = new FileOutputStream(new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/" + str));
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
                return Uri.fromFile(new File(Environment.getExternalStorageDirectory(), str));
            }
            Log.e("[GVExtension]", "Failed to write temp image stream.");
            return null;
        } catch (Exception e3) {
            Log.e("[GVExtension]", "Encoding failed!");
            return null;
        }
    }

    private static Uri m378a(String str, FREByteArray fREByteArray) {
        try {
            fREByteArray.acquire();
            ByteBuffer bytes = fREByteArray.getBytes();
            File file = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/" + str);
            try {
                file.createNewFile();
                FileChannel channel = new FileOutputStream(file).getChannel();
                bytes.order(ByteOrder.LITTLE_ENDIAN);
                channel.write(bytes);
                channel.close();
            } catch (Exception e) {
                Log.d("[GVExtension]", "File caching failed");
                e.printStackTrace();
                file = null;
            }
            try {
                fREByteArray.release();
                if (file != null) {
                    return Uri.fromFile(new File(Environment.getExternalStorageDirectory(), str));
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

    protected static Bundle m379a(FREArray fREArray, FREArray fREArray2) {
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

    static /* synthetic */ String m381a(Set set) {
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

    private List<Intent> m382a(Intent intent) {
        List<Intent> arrayList = new ArrayList();
        PackageManager packageManager = this.f346b.getPackageManager();
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

    static /* synthetic */ void m383a(C0351a c0351a, Bundle bundle, String str) {
        Builder builder = new Builder();
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
            builder.setPeopleIds(C0351a.m405b(bundle.getString(NativeProtocol.AUDIENCE_FRIENDS)));
        }
        ShareLinkContent build = builder.build();
        ShareDialog shareDialog = new ShareDialog(c0351a.getActivity());
        shareDialog.registerCallback(c0351a.f360r, new C0373w(c0351a, str), 194237);
        shareDialog.show(build);
    }

    static /* synthetic */ void m384a(C0351a c0351a, String str, double d, Bundle bundle) {
        AppEventsLogger s = c0351a.m447s();
        if (bundle != null) {
            s.logEvent(str, d, bundle);
        } else {
            s.logEvent(str, d);
        }
    }

    static /* synthetic */ void m385a(C0351a c0351a, String str, int i) {
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
        instance.logInWithReadPermissions(c0351a.getActivity(), arrayList);
    }

    static /* synthetic */ void m386a(C0351a c0351a, String str, Bundle bundle) {
        AppEventsLogger s = c0351a.m447s();
        if (bundle != null) {
            s.logEvent(str, bundle);
        } else {
            s.logEvent(str);
        }
    }

    static /* synthetic */ void m388a(C0351a c0351a, String str, FREBitmapData fREBitmapData, String str2, String str3) {
        Bundle bundle = new Bundle();
        bundle.putByteArray("picture", C0351a.m408b(fREBitmapData));
        bundle.putString("message", str);
        c0351a.m398a(str2, "POST", bundle, "publish_actions", str3);
    }

    static /* synthetic */ void m390a(C0351a c0351a, String str, String str2, Bundle bundle, FREBitmapData fREBitmapData, String str3) {
        str2.contains(":");
        Bitmap a = fREBitmapData != null ? C0351a.m376a(fREBitmapData) : null;
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
        ShareDialog shareDialog = new ShareDialog(c0351a.getActivity());
        shareDialog.registerCallback(c0351a.f360r, new C0371u(c0351a, str3), 194238);
        shareDialog.show(build2);
    }

    static /* synthetic */ void m392a(C0351a c0351a, String str, String str2, String str3, boolean z, String str4, String str5, FREBitmapData fREBitmapData, String str6, String str7) {
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
        Parcelable a = C0351a.m377a(str6 + ".jpeg", fREBitmapData);
        if (a != null) {
            intent.putExtra("android.intent.extra.STREAM", a);
            str8 = "image/jpeg";
        }
        intent.setType(str8);
        c0351a.f357o = str7;
        List a2 = c0351a.m382a(intent);
        if (a2.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a2.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a2.toArray(new Parcelable[0]));
            c0351a.f346b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0351a.f346b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m393a(C0351a c0351a, String str, String str2, String str3, boolean z, String str4, String str5, FREByteArray fREByteArray, String str6, String str7, String str8) {
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
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str3));
        } else {
            intent.putExtra("android.intent.extra.TEXT", str3);
        }
        Parcelable a = C0351a.m378a(str7, fREByteArray);
        if (a != null) {
            intent.setType(str6);
            intent.putExtra("android.intent.extra.STREAM", a);
        }
        c0351a.f357o = str8;
        List a2 = c0351a.m382a(intent);
        if (a2.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a2.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a2.toArray(new Parcelable[0]));
            c0351a.f346b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0351a.f346b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m394a(C0351a c0351a, String str, String str2, String str3, boolean z, String str4, String str5, String str6) {
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
        c0351a.f357o = str6;
        List a = c0351a.m382a(intent);
        Log.d("[GVExtension]", "Client intents length:" + a.size());
        if (a.size() > 0) {
            Intent createChooser = Intent.createChooser((Intent) a.remove(0), "Send with:");
            createChooser.putExtra("android.intent.extra.INITIAL_INTENTS", (Parcelable[]) a.toArray(new Parcelable[0]));
            c0351a.f346b.startActivityForResult(createChooser, 194235);
            return;
        }
        c0351a.f346b.startActivityForResult(intent, 194235);
    }

    static /* synthetic */ void m395a(C0351a c0351a, String str, String str2, boolean z, FREBitmapData fREBitmapData, String str3, String str4) {
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
        Parcelable a = C0351a.m377a(str4, fREBitmapData);
        if (a != null) {
            intent.putExtra("android.intent.extra.STREAM", a);
            str5 = "image/jpeg";
        }
        intent.setType(str5);
        c0351a.f355m = str3;
        c0351a.f346b.startActivityForResult(intent, 194234);
    }

    static /* synthetic */ void m396a(C0351a c0351a, String str, String str2, boolean z, String str3) {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.putExtra("android.intent.extra.SUBJECT", str);
        if (z) {
            intent.setType("text/html");
            intent.putExtra("android.intent.extra.TEXT", Html.fromHtml(str2));
        } else {
            intent.setType("text/plain");
            intent.putExtra("android.intent.extra.TEXT", str2);
        }
        c0351a.f355m = str3;
        c0351a.f346b.startActivityForResult(intent, 194233);
    }

    private void m397a(String str, FREBitmapData fREBitmapData, String str2, boolean z) {
        Intent c = m409c("text/plain");
        if (c != null) {
            c.putExtra("android.intent.extra.TEXT", str);
            Parcelable a = C0351a.m377a("twattachment.jpeg", fREBitmapData);
            if (a != null) {
                c.putExtra("android.intent.extra.STREAM", a);
                c.setType("image/jpeg");
            } else {
                Log.d("[GVExtension]", "Twitter intent did not allow image attachment.");
                c.setType("text/plain");
            }
            this.f358p = str2;
            this.f346b.startActivityForResult(c, z ? 2345235 : 194236);
        }
    }

    private void m398a(String str, String str2, Bundle bundle, String str3, String str4) {
        int i = 0;
        if (C0351a.m445q()) {
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
            this.f351i = str;
            this.f354l = str4;
            if (!str2.equals("GET")) {
                if (str2.equals("POST")) {
                    httpMethod = HttpMethod.POST;
                } else if (str2.equals("DELETE")) {
                    httpMethod = HttpMethod.DELETE;
                }
                graphRequest = new GraphRequest(currentAccessToken, str, bundle, httpMethod, new C0353c(this, str, str3, str4));
                if (i2 != 0) {
                    Log.d("[GVExtension]", "No reauth required for this graph request.");
                    graphRequest.executeAsync();
                }
                this.f353k = graphRequest;
                LoginManager.getInstance().logInWithPublishPermissions(getActivity(), arrayList);
                return;
            }
            httpMethod = HttpMethod.GET;
            graphRequest = new GraphRequest(currentAccessToken, str, bundle, httpMethod, new C0353c(this, str, str3, str4));
            if (i2 != 0) {
                this.f353k = graphRequest;
                LoginManager.getInstance().logInWithPublishPermissions(getActivity(), arrayList);
                return;
            }
            Log.d("[GVExtension]", "No reauth required for this graph request.");
            graphRequest.executeAsync();
        }
    }

    private void m399a(String str, String str2, boolean z) {
        Intent c = m409c("text/plain");
        if (c != null) {
            c.putExtra("android.intent.extra.TEXT", str);
            this.f358p = str2;
            this.f346b.startActivityForResult(c, z ? 2345235 : 194236);
        }
    }

    static /* synthetic */ boolean m400a(C0351a c0351a, String str) {
        if (!C0351a.m445q()) {
            return false;
        }
        c0351a.f352j = str;
        AccessToken.refreshCurrentAccessTokenAsync();
        return true;
    }

    static /* synthetic */ boolean m401a(C0351a c0351a, String str, String str2, boolean z, FREBitmapData fREBitmapData, String str3, String str4, String str5) {
        Uri uri = null;
        c0351a.f356n = str4;
        if (str.equals("SINAWEIBO")) {
            return false;
        }
        if (!str.equals("TWITTER")) {
            Intent t;
            Parcelable a = (!z || fREBitmapData == null) ? null : C0351a.m377a("image_1.jpeg", fREBitmapData);
            if (str.equals("FACEBOOK")) {
                t = c0351a.m448t();
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
                t = c0351a.m375a(str2, uri, str5);
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
            c0351a.f346b.startActivityForResult(t, 2345235);
            return true;
        } else if (z) {
            c0351a.m397a(str2, fREBitmapData, str4, true);
            return true;
        } else {
            c0351a.m399a(str2, str4, true);
            return true;
        }
    }

    static /* synthetic */ boolean m403a(String str) {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? false : currentAccessToken.getPermissions().contains(str);
    }

    private static ArrayList<String> m405b(String str) {
        ArrayList<String> arrayList = new ArrayList();
        String[] split = str.split(",");
        for (Object add : split) {
            arrayList.add(add);
        }
        return arrayList;
    }

    static /* synthetic */ void m406b(C0351a c0351a, Bundle bundle, String str) {
        if (AppInviteDialog.canShow()) {
            AppInviteContent.Builder builder = new AppInviteContent.Builder();
            if (bundle.containsKey("previewImageURL")) {
                builder.setPreviewImageUrl(bundle.getString("previewImageURL"));
            }
            if (bundle.containsKey("appLinkURL")) {
                builder.setApplinkUrl(bundle.getString("appLinkURL"));
            }
            AppInviteDialog appInviteDialog = new AppInviteDialog(c0351a.getActivity());
            appInviteDialog.registerCallback(c0351a.f360r, new C0374x(c0351a, str), 194241);
            appInviteDialog.show(builder.build());
        }
    }

    static /* synthetic */ void m407b(C0351a c0351a, String str) {
        try {
            c0351a.getActivity().startActivity(new Intent("android.intent.action.VIEW", Uri.parse("twitter://user?screen_name=" + str)));
        } catch (Exception e) {
            try {
                c0351a.getActivity().startActivity(new Intent("android.intent.action.VIEW", Uri.parse("http://www.twitter.com/" + str)));
            } catch (Exception e2) {
            }
        }
    }

    private static byte[] m408b(FREBitmapData fREBitmapData) {
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

    private Intent m409c(String str) {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.setType(str);
        List<ResolveInfo> queryIntentActivities = this.f346b.getPackageManager().queryIntentActivities(intent, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST);
        int i = 0;
        while (i < f343a.length) {
            for (ResolveInfo resolveInfo : queryIntentActivities) {
                String str2 = resolveInfo.activityInfo.packageName;
                if (str2 != null && str2.startsWith(f343a[i])) {
                    intent.setPackage(str2);
                    return intent;
                }
            }
            i++;
        }
        return null;
    }

    static /* synthetic */ void m411c(C0351a c0351a, Bundle bundle, String str) {
        Builder builder = new Builder();
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
            builder.setPeopleIds(C0351a.m405b(bundle.getString(NativeProtocol.AUDIENCE_FRIENDS)));
        }
        ShareLinkContent build = builder.build();
        MessageDialog messageDialog = new MessageDialog(c0351a.getActivity());
        messageDialog.registerCallback(c0351a.f360r, new C0372v(c0351a, str), 194239);
        messageDialog.show(build);
    }

    static /* synthetic */ boolean m412c(C0351a c0351a, String str) {
        Log.d("[GVExtension]", "Service check:" + str);
        if (!str.equals("SINAWEIBO")) {
            if (str.equals("FACEBOOK")) {
                return c0351a.m448t() != null;
            } else {
                if (str.equals("TWITTER")) {
                    return c0351a.m446r();
                }
                if (str.equals("SMS")) {
                    return c0351a.m375a("test", null, "") != null;
                }
            }
        }
        return false;
    }

    static /* synthetic */ void m414d(C0351a c0351a, Bundle bundle, String str) {
        String string;
        GameRequestDialog gameRequestDialog = new GameRequestDialog(c0351a.getActivity());
        gameRequestDialog.registerCallback(c0351a.f360r, new C0375y(c0351a, str), 194240);
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
            builder.setTo(bundle.getString("to"));
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

    static /* synthetic */ void m415d(C0351a c0351a, String str) {
        String str2;
        NameNotFoundException e;
        NoSuchAlgorithmException e2;
        Exception e3;
        Intent intent;
        Bundle bundleExtra;
        Uri parse;
        c0351a.f348f = str;
        c0351a.f352j = null;
        c0351a.f350h = null;
        c0351a.f349g = null;
        if (f345d) {
            String str3;
            AlertDialog create;
            Log.d("[GVExtension]", "doDebugDisplay");
            str2 = "";
            try {
                Signature[] signatureArr = c0351a.f346b.getPackageManager().getPackageInfo(c0351a.f346b.getApplicationContext().getPackageName(), 64).signatures;
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
                create = new AlertDialog.Builder(c0351a.f346b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0354d(c0351a, str3));
                create.setButton(-2, "Close", new C0355e(c0351a));
                create.show();
                Log.d("[GVExtension]", "Will init fb");
                FacebookSdk.sdkInitialize(c0351a.getActivity().getApplicationContext());
                FacebookSdk.setApplicationId(c0351a.f348f);
                Log.d("[GVExtension]", "Did init fb");
                c0351a.f360r = Factory.create();
                LoginManager.getInstance().registerCallback(c0351a.f360r, new C0352b(c0351a));
                AppEventsLogger.activateApp(c0351a.getActivity());
                c0351a.f361s = new C0363m(c0351a);
                intent = c0351a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0351a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                        }
                        if (!c0351a.f362t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0351a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0351a.f362t) {
                }
            } catch (NoSuchAlgorithmException e8) {
                NoSuchAlgorithmException noSuchAlgorithmException = e8;
                str3 = str2;
                e2 = noSuchAlgorithmException;
                Log.e("no such an algorithm", e2.toString());
                str3 = str3;
                create = new AlertDialog.Builder(c0351a.f346b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0354d(c0351a, str3));
                create.setButton(-2, "Close", new C0355e(c0351a));
                create.show();
                Log.d("[GVExtension]", "Will init fb");
                FacebookSdk.sdkInitialize(c0351a.getActivity().getApplicationContext());
                FacebookSdk.setApplicationId(c0351a.f348f);
                Log.d("[GVExtension]", "Did init fb");
                c0351a.f360r = Factory.create();
                LoginManager.getInstance().registerCallback(c0351a.f360r, new C0352b(c0351a));
                AppEventsLogger.activateApp(c0351a.getActivity());
                c0351a.f361s = new C0363m(c0351a);
                intent = c0351a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0351a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                        }
                        if (!c0351a.f362t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0351a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0351a.f362t) {
                }
            } catch (Exception e9) {
                Exception exception = e9;
                str3 = str2;
                e3 = exception;
                Log.e("exception", e3.toString());
                str3 = str3;
                create = new AlertDialog.Builder(c0351a.f346b).create();
                create.setTitle("DEBUG");
                create.setMessage("Your fb hashkey is " + str3);
                create.setButton(-1, "Mail it", new C0354d(c0351a, str3));
                create.setButton(-2, "Close", new C0355e(c0351a));
                create.show();
                Log.d("[GVExtension]", "Will init fb");
                FacebookSdk.sdkInitialize(c0351a.getActivity().getApplicationContext());
                FacebookSdk.setApplicationId(c0351a.f348f);
                Log.d("[GVExtension]", "Did init fb");
                c0351a.f360r = Factory.create();
                LoginManager.getInstance().registerCallback(c0351a.f360r, new C0352b(c0351a));
                AppEventsLogger.activateApp(c0351a.getActivity());
                c0351a.f361s = new C0363m(c0351a);
                intent = c0351a.getActivity().getIntent();
                bundleExtra = intent.getBundleExtra("al_applink_data");
                if (bundleExtra != null) {
                    str2 = bundleExtra.getString("target_url");
                    if (str2 != null) {
                        parse = Uri.parse(str2);
                        if (parse == null) {
                            Log.i("Activity", "App Link Target URL: " + parse.toString());
                            c0351a.dispatchStatusEventAsync("701", parse.toString());
                        } else {
                            AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                        }
                        if (!c0351a.f362t) {
                        }
                    }
                }
                parse = intent.getData();
                if (parse == null) {
                    AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                } else {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0351a.dispatchStatusEventAsync("701", parse.toString());
                }
                if (!c0351a.f362t) {
                }
            }
            str3 = str3;
            create = new AlertDialog.Builder(c0351a.f346b).create();
            create.setTitle("DEBUG");
            create.setMessage("Your fb hashkey is " + str3);
            create.setButton(-1, "Mail it", new C0354d(c0351a, str3));
            create.setButton(-2, "Close", new C0355e(c0351a));
            create.show();
        }
        Log.d("[GVExtension]", "Will init fb");
        FacebookSdk.sdkInitialize(c0351a.getActivity().getApplicationContext());
        FacebookSdk.setApplicationId(c0351a.f348f);
        Log.d("[GVExtension]", "Did init fb");
        c0351a.f360r = Factory.create();
        LoginManager.getInstance().registerCallback(c0351a.f360r, new C0352b(c0351a));
        AppEventsLogger.activateApp(c0351a.getActivity());
        c0351a.f361s = new C0363m(c0351a);
        intent = c0351a.getActivity().getIntent();
        bundleExtra = intent.getBundleExtra("al_applink_data");
        if (bundleExtra != null) {
            str2 = bundleExtra.getString("target_url");
            if (str2 != null) {
                parse = Uri.parse(str2);
                if (parse == null) {
                    Log.i("Activity", "App Link Target URL: " + parse.toString());
                    c0351a.dispatchStatusEventAsync("701", parse.toString());
                } else {
                    AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
                }
                if (!c0351a.f362t && !c0351a.f363u) {
                    Log.d("[GVExtension]", "init fb with token check");
                    if (AccessToken.getCurrentAccessToken() != null) {
                        Log.d("[GVExtension]", "init fb token found");
                        if (c0351a.f363u) {
                            Log.d("[GVExtension]", "init fb already dispatched");
                            return;
                        }
                        c0351a.dispatchStatusEventAsync("5", "");
                        c0351a.f362t = true;
                        c0351a.f363u = true;
                        return;
                    }
                    Log.d("[GVExtension]", "init fb token not found");
                    return;
                }
            }
        }
        parse = intent.getData();
        if (parse == null) {
            AppLinkData.fetchDeferredAppLinkData(c0351a.f346b, new C0370t(c0351a));
        } else {
            Log.i("Activity", "App Link Target URL: " + parse.toString());
            c0351a.dispatchStatusEventAsync("701", parse.toString());
        }
        if (!c0351a.f362t) {
        }
    }

    static /* synthetic */ String m417e() {
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

    static /* synthetic */ boolean m419e(C0351a c0351a, String str) {
        if (C0351a.m445q()) {
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
                c0351a.f350h = str;
                LoginManager.getInstance().logInWithPublishPermissions(c0351a.getActivity(), arrayList);
                return true;
            }
        }
        return false;
    }

    static /* synthetic */ boolean m422f(C0351a c0351a, String str) {
        if (C0351a.m445q()) {
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
                c0351a.f349g = str;
                LoginManager.getInstance().logInWithReadPermissions(c0351a.getActivity(), arrayList);
                return true;
            }
        }
        return false;
    }

    static /* synthetic */ void m424g(C0351a c0351a, String str) {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        String str2 = c0351a.f348f;
        if (str2 == null && currentAccessToken != null) {
            str2 = currentAccessToken.getApplicationId();
        }
        if (str2 != null) {
            String str3 = str2 + "/custom_audience_third_party_id";
            AttributionIdentifiers attributionIdentifiers = AttributionIdentifiers.getAttributionIdentifiers(c0351a.getActivity().getApplicationContext());
            Bundle bundle = new Bundle();
            if (currentAccessToken == null) {
                str2 = attributionIdentifiers.getAttributionId() != null ? attributionIdentifiers.getAttributionId() : attributionIdentifiers.getAndroidAdvertiserId();
                if (attributionIdentifiers.getAttributionId() != null) {
                    bundle.putString("udid", str2);
                }
            }
            if (FacebookSdk.getLimitEventAndDataUsage(c0351a.getActivity().getApplicationContext()) || attributionIdentifiers.isTrackingLimited()) {
                bundle.putString("limit_event_usage", AppEventsConstants.EVENT_PARAM_VALUE_YES);
            }
            new GraphRequest(currentAccessToken, str3, bundle, HttpMethod.GET, new C0376z(c0351a, str)).executeAsync();
        }
    }

    static /* synthetic */ void m427h() {
    }

    static /* synthetic */ void m428h(C0351a c0351a, String str) {
        Intent intent;
        try {
            if (c0351a.getActivity().getPackageManager().getPackageInfo("com.facebook.katana", 0).versionCode >= 3002850) {
                String str2 = "android.intent.action.VIEW";
                intent = new Intent(str2, Uri.parse("fb://facewebmodal/f?href=" + ("https://www.facebook.com/profile.php?id=" + str)));
            } else {
                intent = new Intent("android.intent.action.VIEW", Uri.parse("fb://profile/" + str));
            }
        } catch (Exception e) {
            intent = new Intent("android.intent.action.VIEW", Uri.parse("https://m.facebook.com/profile.php?id=" + str));
        }
        c0351a.getActivity().startActivity(intent);
    }

    static /* synthetic */ void m437m() {
        if (AccessToken.getCurrentAccessToken() != null) {
            LoginManager.getInstance().logOut();
        }
    }

    static /* synthetic */ void m439n() {
    }

    static /* synthetic */ void m440n(C0351a c0351a) {
        Log.d("[GVExtension]", "GoViral initializer-.");
        c0351a.f362t = false;
        c0351a.f363u = false;
        c0351a.f346b = c0351a.getActivity();
        c0351a.f347e = new bv(c0351a);
        c0351a.f347e.m182a(c0351a);
        f344c = c0351a;
    }

    static /* synthetic */ String m441o() {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? "" : currentAccessToken.getToken();
    }

    static /* synthetic */ double m443p() {
        AccessToken currentAccessToken = AccessToken.getCurrentAccessToken();
        return currentAccessToken == null ? 0.0d : (double) (currentAccessToken.getExpires().getTime() / 1000);
    }

    private static boolean m445q() {
        return AccessToken.getCurrentAccessToken() != null;
    }

    private boolean m446r() {
        return m409c("text/plain") != null;
    }

    private AppEventsLogger m447s() {
        if (this.f359q == null) {
            this.f359q = AppEventsLogger.newLogger(getActivity());
        }
        return this.f359q;
    }

    private Intent m448t() {
        Intent intent = new Intent("android.intent.action.SEND");
        intent.setType("text/plain");
        for (ResolveInfo resolveInfo : this.f346b.getPackageManager().queryIntentActivities(intent, NativeProtocol.MESSAGE_GET_ACCESS_TOKEN_REQUEST)) {
            if (resolveInfo.activityInfo.packageName.contains("com.facebook.katana")) {
                ActivityInfo activityInfo = resolveInfo.activityInfo;
                intent.setComponent(new ComponentName(activityInfo.applicationInfo.packageName, activityInfo.name));
                return intent;
            }
        }
        return null;
    }

    public final void mo285a() {
        Log.d("[GVExtension]", "started fb");
    }

    public final void mo286a(int i, int i2, Intent intent) {
        Log.d("[GVExtension]", "r=" + i);
        if (FacebookSdk.isFacebookRequestCode(i) || i == 194240 || i == 194237 || i == 194241 || i == 194238 || i == 194239) {
            Log.d("[GVExtension]", "facebook handler caught activityresult");
            this.f360r.onActivityResult(i, i2, intent);
        } else {
            Log.d("[GVExtension]", "Facebook handler ignore unrelated activityresult");
        }
        if (i == 194236) {
            dispatchStatusEventAsync(this.f358p + "[[[GVRiD]]]18", "");
        }
        if (i == 194235) {
            dispatchStatusEventAsync(this.f357o + "[[[GVRiD]]]3", "");
        }
        if (i == 194234 || i == 194233) {
            dispatchStatusEventAsync(this.f355m + "[[[GVRiD]]]30", "");
        }
        if (i == 2345235) {
            dispatchStatusEventAsync(this.f356n + "[[[GVRiD]]]51", "");
        }
    }

    public final void m451a(int i, String str, String str2, String str3) {
        String str4 = i + "[ERR]" + str + "[URL]" + str2;
        Log.d("[GVExtension]", "FB Dialog failed:" + str4);
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]11", str4);
    }

    public final void m452a(int i, String str, String str2, String str3, boolean z, String str4, String str5) {
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]13", "{\"permissions\":\"" + str5 + "\",\"gvShouldNotify\":" + z + ",\"gvCategory\":0,\"gvErrCode\":" + i + ",\"gvErr\":\"" + str + "\",\"gvUrl\":\"" + str2 + "\",\"gvUserMessage\":\"" + str4 + "\"}");
    }

    public final void m453a(String str, Bundle bundle, String str2) {
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

    public final void m454a(String str, String str2) {
        String str3 = "{\"gvDialogType\":\"" + str + "\"}";
        Log.d("[GVExtension]", "facebook dialog canceled :" + str);
        dispatchStatusEventAsync(str2 + "[[[GVRiD]]]10", str3);
    }

    public final void m455a(String str, String str2, String str3) {
        String str4 = str + "[URL]" + str2;
        Log.d("[GVExtension]", "onrawresponse:" + str4);
        dispatchStatusEventAsync(str3 + "[[[GVRiD]]]12", str4);
    }

    public final void mo287b() {
        if (this.f348f != null) {
            Log.d("[GVExtension]", "Resume->activate publish");
            AppEventsLogger.activateApp(getActivity(), this.f348f);
        }
    }

    public final void mo288c() {
        if (this.f361s != null) {
            this.f361s.stopTracking();
        }
    }

    public final void dispose() {
        this.f346b = null;
    }

    public final Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> hashMap = new HashMap();
        hashMap.put("ffiInitGoViral", new C0338n());
        hashMap.put("ffiCanSendEmail", new C0326b());
        hashMap.put("ffiShowEmailComposer", new C0348x());
        hashMap.put("ffiShowEmailComposerWithBitmap", new C0349y());
        hashMap.put("ffiShowEmailComposerWithByteArray", new C0350z());
        hashMap.put("ffiInitFacebook", new C0337m());
        hashMap.put("ffiAuthenticateWithFacebook", new C0325a());
        hashMap.put("ffiIsFacebookAuthenticated", new C0339o());
        hashMap.put("ffiLogoutFacebook", new C0343s());
        hashMap.put("ffiShowFacebookFeedDialog", new aa());
        hashMap.put("ffiShowFacebookRequestDialog", new ab());
        hashMap.put("ffiFacebookGraphRequest", new C0329e());
        hashMap.put("ffiFacebookPostPhoto", new C0331g());
        hashMap.put("ffiGetAccessToken", new C0335k());
        hashMap.put("ffiShowTweetSheet", new ac());
        hashMap.put("ffiShowTweetSheetWithImage", new ad());
        hashMap.put("ffiIsTweetSheetAvailable", new C0342r());
        hashMap.put("ffiIsGenericShareAvailable", new C0340p());
        hashMap.put("ffiShareGeneric", new C0333i());
        hashMap.put("ffiShareGenericWithImage", new C0334j());
        hashMap.put("ffiPublishInstall", new C0345u());
        hashMap.put("ffiGetFbAccessExpiry", new C0336l());
        hashMap.put("ffiRequestNewReadPermissions", new C0347w());
        hashMap.put("ffiRequestNewPublishPermissions", new C0346v());
        hashMap.put("ffiFacebookLogAppEvent", new C0330f());
        hashMap.put("ffiFacebookRequestAppUserID", new C0332h());
        hashMap.put("ffiPresentFacebookProfileOrPage", new C0344t());
        hashMap.put("ffiIsServiceAvailable", new C0341q());
        hashMap.put("ffiDisplaySocialView", new C0327c());
        hashMap.put("ffiIsAppInviteDialogAvailable", new C0356f(this));
        hashMap.put("ffiIsPermissionGranted", new C0357g(this));
        hashMap.put("ffiGetDeclinedPermissions", new C0358h(this));
        hashMap.put("ffiIsFacebookShareDialogAvailable", new C0359i(this));
        hashMap.put("ffiShowFacebookShareDialog", new C0360j(this));
        hashMap.put("ffiShowFacebookAppInviteDialog", new C0361k(this));
        hashMap.put("ffiIsFacebookGraphDialogAvailable", new C0362l(this));
        hashMap.put("ffiShowFacebookGraphDialog", new C0364n(this));
        hashMap.put("ffiStageFacebookImage", new C0365o(this));
        hashMap.put("ffiIsFacebookMessageDialogAvailable", new C0366p(this));
        hashMap.put("ffiShowFacebookMessageDialog", new C0367q(this));
        hashMap.put("ffiRefreshSessionPermissions", new C0368r(this));
        hashMap.put("ffiPresentTwitterProfile", new C0369s(this));
        return hashMap;
    }
}
