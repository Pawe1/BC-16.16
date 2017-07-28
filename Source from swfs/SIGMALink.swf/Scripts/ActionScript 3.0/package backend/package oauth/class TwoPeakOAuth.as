//class TwoPeakOAuth
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


