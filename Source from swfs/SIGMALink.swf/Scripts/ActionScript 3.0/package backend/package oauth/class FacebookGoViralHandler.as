//class FacebookGoViralHandler
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


