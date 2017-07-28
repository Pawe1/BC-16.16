//class TrainingPeaksOAuth
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


