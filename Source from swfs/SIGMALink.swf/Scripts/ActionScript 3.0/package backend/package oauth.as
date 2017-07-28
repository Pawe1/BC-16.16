//package oauth
//  class FacebookGoViralHandler
package backend.oauth 
{
    import com.milkmangames.nativeextensions.*;
    import com.milkmangames.nativeextensions.events.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import frontend.components.popup.oauth.*;
    
    public class FacebookGoViralHandler extends frontend.components.popup.oauth.CustomOAuth
    {
        public function FacebookGoViralHandler()
        {
            this.facebookObject = new Object();
            this.postObject = new Object();
            super();
            className = "FacebookGoViralHandler";
            CLIENT_ID = APP_ID;
            CLIENT_SECRET = "288c9b39d76fa7724360329c4eddf2ce";
            UPLOAD_URL = "https://graph.facebook.com/v2.8/";
            if (!com.milkmangames.nativeextensions.GoViral.isSupported()) 
            {
                return;
            }
            com.milkmangames.nativeextensions.GoViral.create();
            if (!com.milkmangames.nativeextensions.GoViral.goViral.isFacebookSupported()) 
            {
                return;
            }
            debug.Debug.debug("Facebook supported... initializing Facebook!");
            com.milkmangames.nativeextensions.GoViral.goViral.initFacebook(APP_ID, "");
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_IN, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_OUT, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_CANCELED, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED, this.onFacebookEvent);
            debug.Debug.debug("Facebook initialized...");
            return;
        }

        public override function get accessToken():String
        {
            var loc1:*=com.milkmangames.nativeextensions.GoViral.goViral.getFbAccessToken();
            return loc1;
        }

        public function postData(arg1:String, arg2:Object=null):void
        {
            com.milkmangames.nativeextensions.GoViral.goViral.facebookGraphRequest(arg1, com.milkmangames.nativeextensions.GVHttpMethod.POST, arg2, APP_PERMISSIONS_PUBLISH).addRequestListener(this.onPostDataResponse);
            return;
        }

        internal function onPostDataResponse(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            if (arg1.type != com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE) 
            {
                debug.Debug.debug("Failed:" + arg1.errorMessage);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
            }
            else 
            {
                debug.Debug.debug("Posted:" + arg1.jsonData);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_SUCCESS));
            }
            return;
        }

        public static function getInstance():backend.oauth.FacebookGoViralHandler
        {
            if (!_instance) 
            {
                _instance = new FacebookGoViralHandler();
            }
            return _instance;
        }

        protected override function initWebView():void
        {
            debug.Debug.debug("not implemented - initWebView");
            return;
        }

        public override function destructor():void
        {
            debug.Debug.debug("not implemented - destructor");
            return;
        }

        public override function showWebViewer(arg1:Boolean):void
        {
            debug.Debug.debug("not implemented - showWebViewer");
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            debug.Debug.debug("not implemented - doOAuthCall");
            return;
        }

        protected override function getStageWebView():flash.media.StageWebView
        {
            debug.Debug.debug("not implemented - getStageWebView");
            return null;
        }

        public static function trackAction(arg1:String):void
        {
            return;
        }

        public function getLoginStatus():Boolean
        {
            return com.milkmangames.nativeextensions.GoViral.goViral.isFacebookAuthenticated();
        }

        public function isNativeFacebookAvailable():Boolean
        {
            return com.milkmangames.nativeextensions.GoViral.goViral.isFacebookSupported() && com.milkmangames.nativeextensions.GoViral.goViral.isFacebookMessageDialogAvailable();
        }

        public override function checkLogin(arg1:flash.display.Stage, arg2:Boolean):void
        {
            var p_stage:flash.display.Stage;
            var p_showPopupIfRequired:Boolean;

            var loc1:*;
            p_stage = arg1;
            p_showPopupIfRequired = arg2;
            if (com.milkmangames.nativeextensions.GoViral.isSupported()) 
            {
                if (this.getLoginStatus() != false) 
                {
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookReadPermissions(APP_PERMISSIONS_READ);
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookPublishPermissions(APP_PERMISSIONS_PUBLISH);
                }
                else if (p_showPopupIfRequired) 
                {
                    try 
                    {
                        com.milkmangames.nativeextensions.GoViral.goViral.authenticateWithFacebook(APP_BASE_PERMISSIONS);
                    }
                    catch (e:Error)
                    {
                        debug.Debug.error("Error: " + e.message);
                    }
                }
            }
            return;
        }

        public override function logout():void
        {
            com.milkmangames.nativeextensions.GoViral.goViral.logoutFacebook();
            return;
        }

        public function onFacebookEvent(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            var loc1:*=arg1.type;
            switch (loc1) 
            {
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_IN:
                {
                    loggedOut = false;
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookReadPermissions(APP_PERMISSIONS_READ);
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookPublishPermissions(APP_PERMISSIONS_PUBLISH);
                    debug.Debug.debug("Logged in to facebook:" + com.milkmangames.nativeextensions.GoViral.VERSION);
                    debug.Debug.debug("DeclinedFacebookPermissions:" + com.milkmangames.nativeextensions.GoViral.goViral.getDeclinedFacebookPermissions().toString());
                    debug.Debug.debug("isFacebookPermissionGranted - " + APP_PERMISSIONS_READ + ":" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted(APP_PERMISSIONS_READ));
                    debug.Debug.debug("isFacebookPermissionGranted - " + APP_PERMISSIONS_PUBLISH + ":" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted(APP_PERMISSIONS_PUBLISH));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_OUT:
                {
                    loggedOut = true;
                    debug.Debug.debug("Logged out of facebook.");
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_CANCELED:
                {
                    debug.Debug.debug("Canceled facebook login.");
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED:
                {
                    debug.Debug.debug("Login failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage);
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_FAILED:
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_FAILED:
                {
                    debug.Debug.debug("perms failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage + "," + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_UPDATED:
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_UPDATED:
                {
                    debug.Debug.debug("Perms updated:" + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESHED:
                {
                    debug.Debug.debug("Perms refreshed, now:" + arg1.permissions + ",uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESH_FAILED:
                {
                    debug.Debug.debug("Refresh permission failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage + "," + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
            }
            return;
        }

        public function postWalk(arg1:Object, arg2:String):void
        {
            this.postId = "";
            this.postObject = arg1;
            this.postType = arg2;
            debug.Debug.debug("postWalk: " + arg1.toString());
            com.milkmangames.nativeextensions.GoViral.goViral.facebookGraphRequest("/me/objects/fitness.course", com.milkmangames.nativeextensions.GVHttpMethod.POST, arg1, APP_PERMISSIONS_PUBLISH).addRequestListener(this.onPostWalkResponse);
            return;
        }

        public function postVideo(arg1:Object):void
        {
            var p_postObject:Object;

            var loc1:*;
            p_postObject = arg1;
            this.postObject = p_postObject;
            debug.Debug.debug("postVideo: " + p_postObject.toString());
            if (!com.milkmangames.nativeextensions.GoViral.goViral.isFacebookMessageDialogAvailable()) 
            {
                return;
            }
            com.milkmangames.nativeextensions.GoViral.goViral.displaySocialComposerView(com.milkmangames.nativeextensions.GVSocialServiceType.FACEBOOK, this.postObject.title, null, p_postObject.videoUrl).addDialogListener(function (arg1:com.milkmangames.nativeextensions.events.GVShareEvent):void
            {
                var loc1:*=arg1.type;
                switch (loc1) 
                {
                    case com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_FINISHED:
                    {
                        dispatchEvent(new flash.events.Event(FBH_POST_DATA_SUCCESS));
                        break;
                    }
                    case com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_CANCELED:
                    {
                        dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
                        break;
                    }
                }
                return;
            })
            return;
        }

        internal function onPostWalkResponse(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            if (arg1.type != com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE) 
            {
                debug.Debug.debug("Failed:" + arg1.errorMessage);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
            }
            else 
            {
                debug.Debug.debug("Posted:" + arg1.jsonData);
                if (arg1.data.hasOwnProperty("id")) 
                {
                    if (arg1.data.id > 0) 
                    {
                        this.postId = arg1.data.id;
                        debug.Debug.debug("id: " + arg1.data.id);
                        this.PostCourseExplicitlyShared(arg1.data.id);
                    }
                }
            }
            return;
        }

        protected function PostCourseExplicitlyShared(arg1:String):void
        {
            var loc1:*=new Object();
            loc1["course"] = arg1;
            this.postData(this.postType, loc1);
            return;
        }

        public static const FBTE_VIEWACTION_PREFIX:String="OPEN_VIEW_";

        public static const FBTE_MENU_TOPVALUES:String="MENU_TOPVALUES";

        public static const APP_BASE_PERMISSIONS:String="user_actions.fitness, public_profile";

        public static const APP_ID:String="1614345838874691";

        public static const APP_PERMISSIONS_READ:String="user_actions.fitness";

        public static const APP_PERMISSIONS_PUBLISH:String="publish_actions";

        public static const FBH_POST_DATA:String="FBH_POST_DATA";

        public static const FBH_POST_DATA_ERROR:String="FBH_POST_DATA_ERROR";

        public static const FBH_POST_DATA_SUCCESS:String="FBH_POST_DATA_SUCCESS";

        public static const FBTE_MENU_ABOUT:String="MENU_ABOUT";

        public static const FBTE_MENU_ACTIVITIES:String="MENU_ACTIVITIES";

        public static const FBTE_MENU_SETTINGS:String="MENU_SETTINGS";

        public static const FBTE_MENU_SETTINGS_ACTIVO:String="MENU_SETTINGS_ACTIVO";

        public static const FBTE_MENU_SETTINGS_PAIRING:String="MENU_SETTINGS_PAIRING";

        public static const FBTE_MENU_SETTINGS_PROFILE:String="MENU_SETTINGS_PROFILE";

        public static const FBTE_MENU_SETTINGS_TIMER:String="MENU_SETTINGS_TIMER";

        public static const FBTE_MENU_SIGMACLOUD:String="MENU_SIGMACLOUD";

        public static const FBTE_MENU_SETTINGS_GENERAL:String="MENU_SETTINGS_GENERAL";

        public static const FBTE_MENU_VIDEOS:String="MENU_VIDEOS";

        public var postId:String="";

        internal var facebookObject:Object;

        internal static var _instance:backend.oauth.FacebookGoViralHandler;

        internal var postObject:Object;

        internal var postType:String;
    }
}


//  class SigmaOAuth
package backend.oauth 
{
    import configCache.*;
    import core.*;
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import handler.*;
    import helper.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.*;
    
    public class SigmaOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function SigmaOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "SigmaOAuth";
            CLIENT_ID = service.cloud.CloudConfig.CLIENT_ID_ANDROID;
            CLIENT_SECRET = service.cloud.CloudConfig.CLIENT_SECRET_ANDROID;
            if (helper.Capabilities_helper.DEVICE == helper.Capabilities_helper.DEVICE_IOS) 
            {
                CLIENT_ID = service.cloud.CloudConfig.CLIENT_ID_IOS;
                CLIENT_SECRET = service.cloud.CloudConfig.CLIENT_SECRET_IOS;
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = null;
            STATE = null;
            LOGIN_URL = service.cloud.CloudConfig.BASE_URL + "/login";
            LOGOUT_URL = service.cloud.CloudConfig.BASE_URL + "/logout.do";
            LOGOUT_COMPLETE_URL = service.cloud.CloudConfig.BASE_URL + "/login?logout";
            AUTHORIZE_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/authorize";
            TOKEN_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/token";
            DEAUTHORIZE_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/deauthorize";
            addEventListener(LOGGED_IN, handler.CloudHandler.getInstance().onLoggedIn);
            addEventListener(LOGGED_OUT, handler.CloudHandler.getInstance().onLoggedOut);
            return;
        }

        public override function get accessToken():String
        {
            return configCache.ConfigCache.getInstance().configCacheObject.accessToken();
        }

        public override function set accessToken(arg1:String):void
        {
            configCache.ConfigCache.getInstance().configCacheObject.setProperty(configCache.ConfigCacheObject.CLOUD_ACCESS_TOKEN, arg1);
            configCache.ConfigCache.getInstance().saveCache();
            return;
        }

        public override function getCompleteHTTPStatus():int
        {
            return 201;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 400:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_DUPLICATE_ERROR");
                    break;
                }
                default:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
                }
            }
            return loc1;
        }

        protected override function checkAccessToken():Boolean
        {
            return false;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation != HOME_URL) 
                {
                    if (lastLocation == ACCOUNT_RECOVER) 
                    {
                        hideWebViewer();
                        flash.net.navigateToURL(new flash.net.URLRequest(ACCOUNT_RECOVER), "_blank");
                        if (loggedOut) 
                        {
                            dispatchEvent(new flash.events.Event(LOGGED_OUT));
                        }
                        else 
                        {
                            loggedOut = true;
                        }
                    }
                }
                else 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(HOME_URL), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
                {
                    if (showWebViewOnCheckLogin) 
                    {
                        showWebViewer(true);
                    }
                    else 
                    {
                        hideWebViewer();
                    }
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public static function getInstance():backend.oauth.SigmaOAuth
        {
            if (_instance == null) 
            {
                _instance = new SigmaOAuth();
            }
            _instance.REGISTER_URL = service.cloud.CloudConfig.BASE_URL + "/portal/#/login?register&lang=" + core.MeasurementConfig.language;
            _instance.ACCOUNT_RECOVER = service.cloud.CloudConfig.BASE_URL + "/portal/#/login?forgot&lang=" + core.MeasurementConfig.language;
            _instance.HOME_URL = service.cloud.CloudConfig.BASE_URL + "/portal/";
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.PARAMS = new Object();
            _instance.PARAMS.language = core.MeasurementConfig.language;
            return _instance;
        }

        internal static var _instance:backend.oauth.SigmaOAuth;
    }
}


//  class StravaOAuth
package backend.oauth 
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import com.adobe.utils.*;
    import configCache.*;
    import core.strava.*;
    import debug.*;
    import extensions.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.popup.*;
    import frontend.components.popup.oauth.*;
    import service.oauth.*;
    import starling.events.*;
    import utils.*;
    
    public class StravaOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function StravaOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "StravaOAuth";
            CLIENT_ID = "137";
            CLIENT_SECRET = "d08449db7b3e37ffda59344c44c7d674746514fd";
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = "write";
            STATE = "mystate";
            LOGIN_URL = "https://www.strava.com/login";
            LOGOUT_URL = "https://www.strava.com/logout";
            LOGOUT_COMPLETE_URL = "https://www.strava.com/";
            AUTHORIZE_URL = "https://www.strava.com/oauth/authorize";
            TOKEN_URL = "https://www.strava.com/oauth/token";
            DEAUTHORIZE_URL = "https://www.strava.com/oauth/deauthorize";
            UPLOAD_URL = "https://www.strava.com/api/v3/uploads";
            REGISTER_URL = "https://www.strava.com/register";
            HOME_URL = "https://www.strava.com/";
            ACCOUNT_RECOVER = "https://www.strava.com/account/recover";
            DASHBOARD_URL = "https://www.strava.com/dashboard";
            addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onStravaLoggedInStatusChanged);
            addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onStravaLoggedInStatusChanged);
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public override function getCompleteHTTPStatus():int
        {
            return 201;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 400:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_DUPLICATE_ERROR");
                    break;
                }
                default:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
                }
            }
            return loc1;
        }

        public static function getInstance():backend.oauth.StravaOAuth
        {
            if (_instance == null) 
            {
                _instance = new StravaOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.STRAVA.TITLE");
            return _instance;
        }

        internal function onStravaLoggedInStatusChanged(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.type;
            switch (loc1) 
            {
                case service.oauth.CommonOAuth.LOGGED_IN:
                {
                    this.loadAthlete();
                    break;
                }
                case service.oauth.CommonOAuth.LOGGED_OUT:
                {
                    configCache.ConfigCache.getInstance().setValue(backend.oauth.StravaOAuth.CONFIG_CACHE_IS_PREMIUM, false);
                    configCache.ConfigCache.getInstance().saveCache();
                    break;
                }
            }
            return;
        }

        protected override function checkAccessToken():Boolean
        {
            return false;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation.indexOf(REGISTER_URL) == -1) 
            {
                if (lastLocation != HOME_URL) 
                {
                    if (lastLocation != ACCOUNT_RECOVER) 
                    {
                        if (lastLocation == DASHBOARD_URL) 
                        {
                            checkUserLogin();
                            hideWebViewer();
                        }
                    }
                    else 
                    {
                        hideWebViewer();
                        flash.net.navigateToURL(new flash.net.URLRequest(ACCOUNT_RECOVER), "_blank");
                        if (loggedOut) 
                        {
                            dispatchEvent(new flash.events.Event(LOGGED_OUT));
                        }
                        else 
                        {
                            loggedOut = true;
                        }
                    }
                }
                else 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(HOME_URL), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        public function loadSegments(arg1:Boolean=true):void
        {
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            this.segmentsList = new Vector.<core.strava.StravaSegment>();
            this.segmentsLoaded = 0;
            var loc1:*=new flash.net.URLRequest(URL_RETREIVE_STARRED_SEGMENTS);
            loc1.method = flash.net.URLRequestMethod.GET;
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
            loc2.latlng = "[0,0]";
            loc2.activity_type = "1";
            loc2.limit = MAX_STRAVA_SEGMENTS + 1;
            loc1.data = loc2;
            var loc3:*=new extensions.ExtendedUrlLoader();
            loc3.extendedData = arg1;
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onLoadStravaStarredComplete);
            loc3.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            loc3.load(loc1);
            return;
        }

        internal function onLoadStravaStarredComplete(arg1:flash.events.Event):void
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=com.adobe.serialization.json.JSON.decode(arg1.target.data);
            var loc2:*=loc1.targets;
            var loc4:*=loc2.length;
            flash.utils.clearTimeout(this._timeOutTimer);
            if (loc4 > MAX_STRAVA_SEGMENTS) 
            {
                this._loadDetais = (arg1.currentTarget as extensions.ExtendedUrlLoader).extendedData as Boolean;
                loc4 = MAX_STRAVA_SEGMENTS;
            }
            loc3 = 0;
            while (loc3 < loc4) 
            {
                this._loadDetais = (arg1.currentTarget as extensions.ExtendedUrlLoader).extendedData as Boolean;
                loc5 = new core.strava.StravaSegment();
                loc5.fromObject(loc2[loc3].segment);
                loc5.compareTo = configCache.ConfigCache.getInstance().getValue(core.strava.StravaDataProvider.COMPARE_CONFIG_CACHE_OBJECT, core.strava.StravaDataProvider.COMPARE_TO_KOM);
                this.segmentsList.push(loc5);
                ++loc3;
            }
            if (loc6 == null) 
            {
                this.triggerStravaSegementsHeaderLoaded();
            }
            return;
        }

        internal function triggerStravaSegementsHeaderLoaded(arg1:flash.events.Event=null):void
        {
            dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED, null, this.segmentsList.length));
            if (this._loadDetais == true) 
            {
                this.loadStravaSegmentDetails();
            }
            return;
        }

        internal function loadStravaSegmentDetails():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=this.segmentsList.length;
            this.segmentsLoaded = 0;
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            while (loc5 < loc6) 
            {
                loc1 = this.segmentsList[loc5] as core.strava.StravaSegment;
                loc3 = new flash.net.URLVariables();
                loc3.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
                loc2 = new flash.net.URLRequest(URL_RETREIVE_SEGMENT + com.adobe.utils.StringUtil.trim(loc1.id.toString()));
                loc2.method = flash.net.URLRequestMethod.GET;
                loc2.data = loc3;
                loc3 = new flash.net.URLVariables();
                loc3.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
                loc3.per_page = 1;
                loc3.following = true;
                loc2 = new flash.net.URLRequest(URL_RETREIVE_SEGMENT_LEADERBORD.replace("{:id}", com.adobe.utils.StringUtil.trim(loc1.id.toString())));
                loc2.method = flash.net.URLRequestMethod.GET;
                loc2.data = loc3;
                loc4 = new extensions.ExtendedUrlLoader();
                loc4.extendedData = [loc1, core.strava.StravaSegment.FIELD_RIVAL_TIME];
                loc4.addEventListener(flash.events.Event.COMPLETE, this.onLoadStravaSegmentDetailLoaderComplete);
                loc4.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
                loc4.load(loc2);
                ++loc5;
            }
            return;
        }

        internal function onError(arg1:flash.events.ErrorEvent):void
        {
            debug.Debug.error("onError: " + (arg1 as flash.events.ErrorEvent).text);
            return;
        }

        internal function onLoadStravaSegmentComplete(arg1:core.strava.StravaSegment):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*;
            var loc2:*=((loc1 = this).segmentsLoaded + 1);
            loc1.segmentsLoaded = loc2;
            dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE, arg1));
            if (this.segmentsLoaded >= this.segmentsList.length) 
            {
                dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_COMPLETE));
                flash.utils.clearTimeout(this._timeOutTimer);
            }
            return;
        }

        internal function onLoadStravaSegmentDetailLoaderComplete(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*=arg1.currentTarget as extensions.ExtendedUrlLoader;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onLoadStravaSegmentDetailLoaderComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            var loc2:*=com.adobe.serialization.json.JSON.decode(loc1.data) as Object;
            var loc3:*=(loc1.extendedData as Array)[0] as core.strava.StravaSegment;
            var loc4:*=(loc1.extendedData as Array)[1] as String;
            var loc5:*=(loc1.extendedData as Array)[2] as Array;
            var loc6:*=loc4;
            switch (loc6) 
            {
                case core.strava.StravaSegment.FIELD_RIVAL_TIME:
                {
                    loc3.rival_time = loc2.entries && loc2.entries.length > 0 && loc2.entries[0].elapsed_time ? loc2.entries[0].elapsed_time : 0;
                    break;
                }
            }
            if (loc3.rival_initialized) 
            {
                this.onLoadStravaSegmentComplete(loc3);
            }
            return;
        }

        public function onTimeout(arg1:flash.events.Event=null):void
        {
            return;
        }

        public function loadAthlete():void
        {
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*=new flash.net.URLRequest(URL_RETREIVE_ATHLETE);
            loc1.method = flash.net.URLRequestMethod.GET;
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
            loc1.data = loc2;
            var loc3:*=new extensions.ExtendedUrlLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onLoadAthleteComplete);
            loc3.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            loc3.load(loc1);
            return;
        }

        internal function onLoadAthleteComplete(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            var loc1:*=com.adobe.serialization.json.JSON.decode(arg1.target.data);
            var loc2:*=new core.strava.StravaAthlete();
            loc2.fromObject(loc1);
            configCache.ConfigCache.getInstance().setValue(backend.oauth.StravaOAuth.CONFIG_CACHE_IS_PREMIUM, loc2.isPremium());
            configCache.ConfigCache.getInstance().saveCache();
            dispatchEvent(new flash.events.Event(EVENT_IS_PREMIUM_ATHLETE_STATUS_CHANGED));
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (!(lastLocation.indexOf("access_denied") == -1) && lastLocation.indexOf("facebook") == -1 && lastLocation.indexOf("google") == -1) 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            else if (loggedOut) 
            {
                if (showWebViewOnCheckLogin) 
                {
                    showWebViewer(true);
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else 
            {
                hideWebViewer();
            }
            return;
        }

        public static const EVENT_IS_PREMIUM_ATHLETE_STATUS_CHANGED:String="stravaPremiumAthleteStatusChanged";

        public static const SEGMENT_ALLEFORTS:String="https://www.strava.com/api/v3/segments/";

        public static const SEGMENT_STARRED:String="https://www.strava.com/api/v3/segments/starred";

        public static const TIMEOUT:uint=30000;

        public static const URL_RETREIVE_ATHLETE:String="https://www.strava.com/api/v3/athlete";

        public static const URL_RETREIVE_SEGMENT:String="https://www.strava.com/api/v3/segments/";

        public static const URL_RETREIVE_SEGMENT_LEADERBORD:String="https://www.strava.com/api/v3/segments/{:id}/leaderboard/";

        public static const URL_RETREIVE_STARRED_SEGMENTS:String="https://www.strava.com/api/v3/segment_targets";

        public static const URL_STRAVA_PREMIUM_INFO:String="http://promo.strava.com/sigma-sport/";

        internal static const MAX_STRAVA_SEGMENTS:uint=100;

        public static const CONFIG_CACHE_IS_PREMIUM:String="stravaIsPremium";

        public var segmentsList:__AS3__.vec.Vector.<core.strava.StravaSegment>;

        internal var _loadDetais:Boolean=false;

        internal var _timeOutTimer:uint;

        internal var segmentsLoaded:uint=0;

        internal static var _instance:backend.oauth.StravaOAuth;
    }
}


//  class TrainingPeaksOAuth
package backend.oauth 
{
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import helper.*;
    import starling.events.*;
    import utils.*;
    
    public class TrainingPeaksOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TrainingPeaksOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "TrainingPeaksOAuth";
            if (helper.Capabilities_helper.isAndroid()) 
            {
                CLIENT_ID = "sigmalinkandroid";
                CLIENT_SECRET = "ZpHCO28de7YLWUGxx3frVrr6MExdjnZb6Fs4EJuU8";
            }
            else 
            {
                CLIENT_ID = "sigmalinkios";
                CLIENT_SECRET = "Mc5dKk7MIfSPuKl9X8fDceorCYtPAaWCEpYzigfMSQ";
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = "file:write";
            STATE = null;
            LOGIN_URL = OAUTH_URL + "Account/LogOn";
            LOGOUT_URL = OAUTH_URL + "Account/LogOff";
            LOGOUT_COMPLETE_URL = OAUTH_URL;
            AUTHORIZE_URL = OAUTH_URL + "OAuth/Authorize";
            TOKEN_URL = OAUTH_URL + "oauth/token";
            UPLOAD_URL = API_URL + "v1/file";
            REGISTER_URL = _REGISTER_URL;
            ACCOUNT_RECOVER = _ACCOUNT_RECOVER;
            implicitGrant = false;
            useURLDecode = true;
            return;
        }

        public override function get requestHeader():flash.net.URLRequestHeader
        {
            return new flash.net.URLRequestHeader("Authorization", "Bearer " + accessToken);
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation == ACCOUNT_RECOVER) 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(ACCOUNT_RECOVER), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
                {
                    if (showWebViewOnCheckLogin) 
                    {
                        showWebViewer(true);
                    }
                    else 
                    {
                        hideWebViewer();
                    }
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public override function getCompleteHTTPStatus():int
        {
            return 200;
        }

        public override function getErrorMessage(arg1:int):String
        {
            return utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
        }

        public static function getInstance():backend.oauth.TrainingPeaksOAuth
        {
            if (_instance == null) 
            {
                _instance = new TrainingPeaksOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE");
            return _instance;
        }

        public static const API_URL:String="https://api.trainingpeaks.com/";

        public static const OAUTH_URL:String="https://oauth.trainingpeaks.com/";

        public static const UPLOAD_APPLICATION_NAME:String="SIGMA LINK";

        public static const _ACCOUNT_RECOVER:String="https://home.trainingpeaks.com/forgotpassword";

        public static const _REGISTER_URL:String="https://home.trainingpeaks.com/signup";

        public var setWorkoutPublic:Boolean=false;

        internal static var _instance:backend.oauth.TrainingPeaksOAuth;
    }
}


//  class TwitterOAuth
package backend.oauth 
{
    import configCache.*;
    import debug.*;
    import feathers.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.popup.oauth.*;
    import org.iotashan.oauth.*;
    import org.iotashan.utils.*;
    import starling.events.*;
    import utils.*;
    
    public class TwitterOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TwitterOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            this.signature = new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1();
            this.thisProfile = {};
            super(arg1);
            className = "TwitterOAuth";
            CLIENT_ID = "76YeNCeZj8FzPXinjYjliJX1V";
            CLIENT_SECRET = "eBClnBnYABEPSn6COKSbxSf3nj0fY37jQE6YaIQqBuCBqmaH5H";
            REDIRECT_URI = "http://www.sigma-dc-control.com";
            HOME_URL = "https://mobile.twitter.com/home";
            REGISTER_URL = "https://mobile.twitter.com/signup";
            return;
        }

        internal function onInitComplete(arg1:flash.events.Event):void
        {
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.Event.COMPLETE, this.onInitComplete);
            this.requestToken = org.iotashan.utils.OAuthUtil.getTokenFromResponse(arg1.currentTarget.data);
            var loc1:*=!this.accessKey;
            var loc2:*=new flash.net.URLRequest(twitterAutTokenURL + this.requestToken.key + "&force_login=" + loc1);
            webView = new frontend.components.popup.oauth.CustomWebView();
            webView.addEventListener(starling.events.Event.COMPLETE, this.onWebViewComplete);
            webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
            webView.loadURL(loc2.url);
            if (pleaseWaitAdded) 
            {
                oauthPopUP.setWebView(webView);
            }
            return;
        }

        public function get accessKey():String
        {
            this._accessKey = configCache.ConfigCache.getInstance().getValue(className + "Key", null);
            return this._accessKey;
        }

        public function set accessKey(arg1:String):void
        {
            this._accessKey = arg1;
            configCache.ConfigCache.getInstance().setValue(className + "Key", arg1);
            return;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != HOME_URL) 
            {
                if (lastLocation.indexOf(REGISTER_URL) == -1) 
                {
                    if (lastLocation.indexOf("denied") != -1) 
                    {
                        hideWebViewer();
                        if (loggedOut) 
                        {
                            dispatchEvent(new flash.events.Event(LOGGED_OUT));
                        }
                        else 
                        {
                            loggedOut = true;
                        }
                    }
                }
                else 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(HOME_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        public function get accessSecret():String
        {
            this._accessSecret = configCache.ConfigCache.getInstance().getValue(className + "Secret", null);
            return this._accessSecret;
        }

        public function set accessSecret(arg1:String):void
        {
            this._accessSecret = arg1;
            configCache.ConfigCache.getInstance().setValue(className + "Secret", arg1);
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (lastLocation.search(REDIRECT_URI) == -1) 
            {
                if (loggedOut) 
                {
                    if (showWebViewOnCheckLogin) 
                    {
                        showWebViewer(true);
                    }
                    else 
                    {
                        hideWebViewer();
                    }
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else if (lastLocation.search("oauth_verifier") >= 0) 
            {
                loc1 = lastLocation.substr(lastLocation.search("oauth_verifier") + 15);
                this.onPin(loc1);
            }
            else 
            {
                this.logout();
            }
            return;
        }

        public override function logout():void
        {
            this.accessKey = null;
            this.accessSecret = null;
            loggedOut = true;
            hideWebViewer();
            return;
        }

        internal function onPin(arg1:String):void
        {
            var loc1:*=new Object();
            loc1.oauth_verifier = arg1;
            this.accessRequest = new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_GET, twitterTokenURL, loc1, this.oAuthConsumer, this.requestToken);
            var loc2:*=new flash.net.URLRequest(this.accessRequest.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
            var loc3:*=new flash.net.URLLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onAccessRequestComplete);
            loc3.load(loc2);
            return;
        }

        internal function onAccessRequestComplete(arg1:flash.events.Event):void
        {
            var loc1:*=org.iotashan.utils.OAuthUtil.getTokenFromResponse(arg1.currentTarget.data);
            this.accessKey = loc1.key;
            this.accessSecret = loc1.secret;
            loggedOut = false;
            hideWebViewer();
            return;
        }

        internal function verifyAccessToken():void
        {
            debug.Debug.debug("verify access token");
            var loc1:*=new org.iotashan.oauth.OAuthConsumer(CLIENT_ID, CLIENT_SECRET);
            var loc2:*=new org.iotashan.oauth.OAuthToken(this.accessKey, this.accessSecret);
            var loc3:*=new org.iotashan.oauth.OAuthRequest(flash.net.URLRequestMethod.GET, VERIFY_CREDENTIALS, null, loc1, loc2);
            var loc4:*=new flash.net.URLRequest(loc3.buildRequest(this.signature, org.iotashan.oauth.OAuthRequest.RESULT_TYPE_URL_STRING));
            loc4.method = flash.net.URLRequestMethod.GET;
            var loc5:*=new flash.net.URLLoader();
            loc5.addEventListener(flash.events.Event.COMPLETE, this.verifyAccessTokenHandler);
            loc5.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onTwitterIOError);
            loc5.addEventListener(flash.events.HTTPStatusEvent.HTTP_STATUS, this.onTwitterHttpStatus);
            loc5.load(loc4);
            return;
        }

        protected function verifyAccessTokenHandler(arg1:flash.events.Event):void
        {
            debug.Debug.debug("Valid Access Data Exists");
            loggedOut = false;
            return;
        }

        internal function onTwitterIOError(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("Tweet IOError!");
            return;
        }

        internal function onTwitterHttpStatus(arg1:flash.events.HTTPStatusEvent):void
        {
            debug.Debug.debug("Tweet HttpStatus!");
            return;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 130:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_OVER_CAPACITY");
                    break;
                }
                case 187:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_DUPLICATE_ERROR");
                    break;
                }
                default:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
                }
            }
            return loc1;
        }

        public static function getInstance():backend.oauth.TwitterOAuth
        {
            if (_instance == null) 
            {
                _instance = new TwitterOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWITTER.TITLE");
            return _instance;
        }

        protected override function debug(arg1:String=""):void
        {
            debug.Debug.debug("CLASS: " + className + "\t message: " + arg1 + "\n\t\tSTATUS - accessKey: " + this.accessKey + "\taccessSecret: " + this.accessSecret + "\tloggedOut: " + loggedOut + "\tlastLocation: " + lastLocation);
            return;
        }

        protected override function checkUserLogin():void
        {
            if (this.accessKey && this.accessSecret) 
            {
                this.verifyAccessToken();
            }
            else 
            {
                loggedOut = true;
                initWebView();
                showWebViewer(false);
                this.doOAuthCall(getStageWebView());
            }
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            if (waitForCall) 
            {
                oauthPopUP.addPleaseWait();
                waitForCall = false;
                pleaseWaitAdded = true;
                reloadTimeout = flash.utils.setTimeout(this.doOAuthCall, 500, arg1);
                return;
            }
            this.oAuthConsumer = new org.iotashan.oauth.OAuthConsumer(CLIENT_ID, CLIENT_SECRET);
            var loc1:*=new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_GET, twitterRequestURL, null, this.oAuthConsumer);
            var loc2:*=new flash.net.URLRequest(loc1.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
            var loc3:*=new flash.net.URLLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onInitComplete);
            loc3.load(loc2);
            return;
        }

        public static const TWITTER_POST_URL:String=TWITTER_API_BASE_URL + "/1.1/statuses/update.json";

        public static const TWITTER_UPLOAD_URL:String="https://upload.twitter.com/1.1/media/upload.json";

        public static const VERIFY_CREDENTIALS:String=TWITTER_API_BASE_URL + "/1.1/account/verify_credentials.json";

        public static const twitterAutTokenURL:String=TWITTER_API_BASE_URL + "/oauth/authorize?oauth_token=";

        public static const twitterAuthURL:String=TWITTER_API_BASE_URL + "/oauth/authorize";

        public static const twitterRequestURL:String=TWITTER_API_BASE_URL + "/oauth/request_token";

        public static const twitterTokenURL:String=TWITTER_API_BASE_URL + "/oauth/access_token";

        public static const TWITTER_API_BASE_URL:String="https://api.twitter.com";

        protected var _accessKey:String;

        protected var _accessSecret:String;

        protected var signature:org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;

        internal var accessRequest:org.iotashan.oauth.OAuthRequest;

        internal var cameraRoll:flash.media.CameraRoll;

        internal var dataSource:flash.utils.IDataInput;

        internal var imageLoader:flash.display.Loader;

        internal var mpLoaderInfo:flash.display.LoaderInfo;

        internal var oAuthConsumer:org.iotashan.oauth.OAuthConsumer;

        internal var requestToken:org.iotashan.oauth.OAuthToken;

        internal var thisProfile:Object;

        internal var webViewStartLocation:int;

        internal static var _instance:backend.oauth.TwitterOAuth;
    }
}


//  class TwoPeakOAuth
package backend.oauth 
{
    import com.adobe.protocols.oauth2.*;
    import com.adobe.protocols.oauth2.event.*;
    import debug.*;
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import helper.*;
    import org.as3commons.logging.setup.*;
    import starling.events.*;
    import utils.*;
    
    public class TwoPeakOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TwoPeakOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "TwoPeakOAuth";
            if (helper.Capabilities_helper.isAndroid()) 
            {
                CLIENT_ID = "sigma_link_android";
                CLIENT_SECRET = "3PyB3xnaxa9PJFoCbzF3UcdKQgeYyl";
            }
            else 
            {
                CLIENT_ID = "sigma_link_ios";
                CLIENT_SECRET = "AjZ7KkYOAtDpVRIQS2K9sTZYp9PF7P";
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = null;
            STATE = "mystate";
            LOGIN_URL = TWO_PEAK_URL + "person/login.php";
            LOGOUT_URL = TWO_PEAK_URL + "person/logout.php";
            LOGOUT_COMPLETE_URL = TWO_PEAK_URL;
            AUTHORIZE_URL = HTTPS_TWO_PEAK_URL + "oauth/authorize.php";
            TOKEN_URL = HTTPS_TWO_PEAK_URL + "oauth/token.php";
            DEAUTHORIZE_URL = TWO_PEAK_URL + "oauth/deauthorize";
            UPLOAD_URL = TWO_PEAK_URL + "api/v2/uploads";
            REGISTER_URL = TWO_PEAK_URL + "user/register.php";
            ACCOUNT_RECOVER = TWO_PEAK_URL + "person/password.php";
            SUPPORT_URL = "https://www.2peak.com/support/";
            return;
        }

        public override function get requestHeader():flash.net.URLRequestHeader
        {
            return new flash.net.URLRequestHeader("Authorization", "Bearer " + accessToken);
        }

        protected override function refresh_token():void
        {
            var loc1:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc1.addEventListener(com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent.TYPE, this.onRefreshAccessToken);
            loc1.refreshAccessToken(refreshToken, CLIENT_ID, CLIENT_SECRET);
            return;
        }

        protected override function onRefreshAccessToken(arg1:com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent):void
        {
            var loc1:*=null;
            (arg1.currentTarget as com.adobe.protocols.oauth2.OAuth2).removeEventListener(com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent.TYPE, this.onRefreshAccessToken);
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    debug.Debug.debug("----------------------- " + className + ": ACCESS TOKEN REFRESHED !!!! ---------------------------");
                    loggedOut = false;
                    loc1 = new Date();
                    loc1.setSeconds(loc1.seconds + arg1.expiresIn);
                    setAccessTokenExpiresIn_timestamp(loc1.time);
                    return;
                }
            }
            else 
            {
                debug.Debug.error("----------------------- " + className + ": REFRESH ACCESS TOKEN ERROR !!!! ---------------------------");
                loggedOut = true;
                accessToken = null;
                checkUserLogin();
            }
            return;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation != ACCOUNT_RECOVER) 
                {
                    if (lastLocation == SUPPORT_URL) 
                    {
                        hideWebViewer();
                        flash.net.navigateToURL(new flash.net.URLRequest(SUPPORT_URL), "_blank");
                        if (loggedOut) 
                        {
                            dispatchEvent(new flash.events.Event(LOGGED_OUT));
                        }
                        else 
                        {
                            loggedOut = true;
                        }
                    }
                }
                else 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(ACCOUNT_RECOVER), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
                {
                    if (showWebViewOnCheckLogin) 
                    {
                        showWebViewer(true);
                    }
                    else 
                    {
                        hideWebViewer();
                    }
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public override function getCompleteHTTPStatus():int
        {
            return 200;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 400:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_DUPLICATE_ERROR");
                    break;
                }
                default:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
                }
            }
            return loc1;
        }

        public static function getInstance():backend.oauth.TwoPeakOAuth
        {
            if (_instance == null) 
            {
                _instance = new TwoPeakOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWOPEAK.TITLE");
            return _instance;
        }

        public static const HTTPS_TWO_PEAK_URL:String="https://2peak.com/";

        public static const TWO_PEAK_URL:String="http://2peak.com/";

        internal static var SUPPORT_URL:String;

        internal static var _instance:backend.oauth.TwoPeakOAuth;
    }
}


