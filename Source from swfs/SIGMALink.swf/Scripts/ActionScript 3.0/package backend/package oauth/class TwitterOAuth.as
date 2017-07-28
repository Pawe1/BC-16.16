//class TwitterOAuth
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


