//class SigmaOAuth
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


