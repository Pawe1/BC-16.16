//package oauth
//  class CommonOAuth
package service.oauth 
{
    import com.adobe.protocols.oauth2.*;
    import com.adobe.protocols.oauth2.event.*;
    import com.adobe.protocols.oauth2.grant.*;
    import configCache.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import mx.events.*;
    import org.as3commons.logging.setup.*;
    import utils.*;
    
    public class CommonOAuth extends flash.events.EventDispatcher
    {
        public function CommonOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            popupTitle = "";
            super(arg1);
            return;
        }

        public function set popupTitle(arg1:String):void
        {
            var loc1:*=this.popupTitle;
            if (loc1 !== arg1) 
            {
                this.popupTitle = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "popupTitle", loc1, arg1));
                }
            }
            return;
        }

        public function get refreshToken():String
        {
            _refreshToken = configCache.ConfigCache.getInstance().getValue(className + "refreshToken", null);
            return _refreshToken;
        }

        public function get popupTitle():String
        {
            return this.popupTitle;
        }

        public function get label():String
        {
            return this.label;
        }

        public function set label(arg1:String):void
        {
            var loc1:*=this.label;
            if (loc1 !== arg1) 
            {
                this.label = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "label", loc1, arg1));
                }
            }
            return;
        }

        public function set refreshToken(arg1:String):void
        {
            if (_refreshToken != arg1) 
            {
                _refreshToken = arg1;
                configCache.ConfigCache.getInstance().setValue(className + "refreshToken", arg1);
            }
            return;
        }

        public function get loggedOut():Boolean
        {
            return _loggedOut;
        }

        public function set loggedOut(arg1:Boolean):void
        {
            _loggedOut = arg1;
            if (_loggedOut) 
            {
                debug("user logged out");
                dispatchEvent(new flash.events.Event("loggedOutEvent"));
            }
            else 
            {
                debug("user logged in");
                dispatchEvent(new flash.events.Event("loggedInEvent"));
            }
            return;
        }

        protected function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            var loc1:*=null;
            var loc2:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc2.requestHeader = requestHeader;
            loc2.useURLDecode = useURLDecode;
            if (implicitGrant) 
            {
                loc1 = new com.adobe.protocols.oauth2.grant.ImplicitGrant(arg1, CLIENT_ID, REDIRECT_URI, SCOPE, STATE, PARAMS);
            }
            else 
            {
                loc1 = new com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant(arg1, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, SCOPE, STATE, PARAMS);
            }
            loc2.addEventListener("getAccessToken", onGetAccessToken);
            loc2.addEventListener("progressEvent", onAuthorizeProgress);
            loc2.getAccessToken(loc1);
            return;
        }

        public function get accessToken():String
        {
            _accessToken = configCache.ConfigCache.getInstance().getValue(className + "token", null);
            return _accessToken;
        }

        public function set accessToken(arg1:String):void
        {
            if (_accessToken != arg1) 
            {
                _accessToken = arg1;
                configCache.ConfigCache.getInstance().setValue(className + "token", arg1);
            }
            return;
        }

        public function get requestHeader():flash.net.URLRequestHeader
        {
            return _requestHeader;
        }

        public function set requestHeader(arg1:flash.net.URLRequestHeader):void
        {
            _requestHeader = arg1;
            return;
        }

        protected function refresh_token():void
        {
            var loc1:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc1.requestHeader = requestHeader;
            loc1.addEventListener("refreshAccessToken", onRefreshAccessToken);
            loc1.refreshAccessToken(refreshToken, CLIENT_ID, CLIENT_SECRET, SCOPE);
            return;
        }

        protected function onRefreshAccessToken(arg1:com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent):void
        {
            var loc1:*=null;
            (arg1.currentTarget as com.adobe.protocols.oauth2.OAuth2).removeEventListener("refreshAccessToken", onRefreshAccessToken);
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    debug.Debug.info("----------------------- " + className + ": ACCESS TOKEN REFRESHED !!!! ---------------------------");
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

        protected function doLogout():void
        {
            accessToken = null;
            authorizationCode = null;
            loggedOut = true;
            setAccessTokenExpiresIn_timestamp(0);
            refreshToken = null;
            debug("logout complete");
            return;
        }

        public function destructor():void
        {
            return;
        }

        public function showWebViewer(arg1:Boolean):void
        {
            return;
        }

        public function logout():void
        {
            return;
        }

        public function getAccessTokenExpiresIn_timestamp():Number
        {
            return configCache.ConfigCache.getInstance().getValue(className + "tokenExpirationTimestamp", 0);
        }

        public function setAccessTokenExpiresIn_timestamp(arg1:Number):void
        {
            configCache.ConfigCache.getInstance().setValue(className + "tokenExpirationTimestamp", arg1);
            return;
        }

        public function checkLogin(arg1:flash.display.Stage, arg2:Boolean):void
        {
            debug("check login state");
            _stage = arg1;
            showWebViewOnCheckLogin = arg2;
            checkUserLogin();
            return;
        }

        public function hideWebViewer():void
        {
            debug("hideWebViewer");
            destructor();
            return;
        }

        public function getCompleteHTTPStatus():int
        {
            return 200;
        }

        public function getErrorMessage(arg1:int):String
        {
            return utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
        }

        protected function getStageWebView():flash.media.StageWebView
        {
            return null;
        }

        protected function initWebView():void
        {
            return;
        }

        protected function debug(arg1:String=""):void
        {
            debug.Debug.debug("CLASS: " + className + "\t message: " + arg1 + "\n\t\tSTATUS - authorizationCode: " + authorizationCode + "\taccessToken: " + accessToken + "\trefreshToken: " + refreshToken + "\tloggedOut: " + loggedOut + "\tlastLocation: " + lastLocation);
            return;
        }

        protected function checkUserLogin():void
        {
            var loc1:*=null;
            if (checkAccessToken()) 
            {
                return;
            }
            _loggedOut = true;
            initWebView();
            showWebViewer(false);
            try 
            {
                loc1 = getStageWebView();
                doOAuthCall(loc1);
            }
            catch (e:Error)
            {
            };
            return;
        }

        protected function onGetAccessToken(arg1:com.adobe.protocols.oauth2.event.GetAccessTokenEvent):void
        {
            var loc1:*=null;
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    refreshToken = arg1.refreshToken;
                    loggedOut = false;
                    loc1 = new Date();
                    loc1.setSeconds(loc1.seconds + arg1.expiresIn);
                    setAccessTokenExpiresIn_timestamp(loc1.time);
                }
                debug("onGetAccessToken");
            }
            else 
            {
                debug("onGetAccessToken error: " + arg1.errorMessage);
            }
            if (!loggedOut) 
            {
                hideWebViewer();
            }
            return;
        }

        protected function onAuthorizeProgress(arg1:com.adobe.protocols.oauth2.event.OAut2ProgressEvent):void
        {
            if (arg1.authorizationCode) 
            {
                authorizationCode = arg1.authorizationCode;
            }
            if (arg1.accessToken) 
            {
                accessToken = arg1.accessToken;
            }
            debug("onAuthorizeProgress");
            return;
        }

        protected function checkAccessToken():Boolean
        {
            if (!accessToken) 
            {
                return false;
            }
            var loc1:*=getAccessTokenExpiresIn_timestamp();
            if (loc1 < new Date().time) 
            {
                refresh_token();
            }
            else 
            {
                loggedOut = false;
            }
            return true;
        }

        protected const REFRESH_TOKEN:String="refreshToken";

        protected const TOKEN:String="token";

        protected const TOKEN_EXPIRATION_TIMESTAMP:String="tokenExpirationTimestamp";

        public static const LOGGED_IN:String="loggedInEvent";

        public static const LOGGED_OUT:String="loggedOutEvent";

        public static const LOGGED_OUT_COMPLETE:String="loggedOutComplete";

        public var AUTHORIZE_URL:String="";

        public var CLIENT_ID:String="";

        public var CLIENT_SECRET:String="";

        public var DASHBOARD_URL:String="";

        protected var _stage:flash.display.Stage;

        protected var implicitGrant:Boolean=false;

        protected var lastLocation:String="";

        protected var showWebViewOnCheckLogin:Boolean=true;

        protected var useURLDecode:Boolean=false;

        internal var _isDebug:Boolean=false;

        public var DEAUTHORIZE_URL:String="";

        public var HOME_URL:String="";

        public var INIT_URL:String="";

        public var LOGOUT_COMPLETE_URL:String="";

        public var LOGOUT_URL:String="";

        public var PARAMS:Object=null;

        public var REDIRECT_URI:String="";

        public var REGISTER_URL:String;

        public var SCOPE:String="";

        public var STATE:String="";

        public var TOKEN_URL:String="";

        public var UPLOAD_URL:String="";

        internal var _accessToken:String=null;

        internal var _loggedOut:Boolean=true;

        public var authorizationCode:String;

        public var className:String;

        internal var label:String;

        public var popupCancelFunc:Function;

        internal var popupTitle:String;

        internal var _refreshToken:String=null;

        public var LOGIN_URL:String="";

        internal var _requestHeader:flash.net.URLRequestHeader;

        public var ACCOUNT_RECOVER:String;
    }
}


//  class PostRequest
package service.oauth 
{
    import flash.utils.*;
    
    public class PostRequest extends Object
    {
        public function PostRequest()
        {
            super();
            createPostData();
            return;
        }

        public function createPostData():void
        {
            postData = new flash.utils.ByteArray();
            postData.endian = "bigEndian";
            return;
        }

        public function writePostData(arg1:String, arg2:String):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            writeBoundary();
            writeLineBreak();
            loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"";
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            postData.writeUTFBytes(arg2);
            writeLineBreak();
            return;
        }

        public function writeFileData(arg1:String, arg2:flash.utils.ByteArray, arg3:String):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            writeBoundary();
            writeLineBreak();
            loc3 = (loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"; filename=\"" + arg1 + "\";").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            postData.writeUTFBytes(arg1);
            writeQuotationMark();
            writeLineBreak();
            loc3 = (loc1 = arg3 || "application/octet-stream").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            arg2.position = 0;
            postData.writeBytes(arg2, 0, arg2.length);
            writeLineBreak();
            return;
        }

        public function getPostData():flash.utils.ByteArray
        {
            postData.position = 0;
            return postData;
        }

        public function close():void
        {
            writeBoundary();
            writeDoubleDash();
            return;
        }

        protected function writeLineBreak():void
        {
            postData.writeShort(3338);
            return;
        }

        protected function writeQuotationMark():void
        {
            postData.writeByte(34);
            return;
        }

        protected function writeDoubleDash():void
        {
            postData.writeShort(11565);
            return;
        }

        protected function writeBoundary():void
        {
            var loc1:*=0;
            writeDoubleDash();
            var loc2:*=boundary.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                postData.writeByte(boundary.charCodeAt(loc1));
                ++loc1;
            }
            return;
        }

        public var boundary:String="-----";

        protected var postData:flash.utils.ByteArray;
    }
}


//  class UploadPostHelper
package service.oauth 
{
    import flash.utils.*;
    
    public class UploadPostHelper extends Object
    {
        public function UploadPostHelper()
        {
            super();
            return;
        }

        public static function getBoundary():String
        {
            var loc1:*=0;
            if (_boundary.length == 0) 
            {
                loc1 = 0;
                while (loc1 < 32) 
                {
                    _boundary = _boundary + String.fromCharCode(97 + Math.random() * 25);
                    ++loc1;
                }
            }
            return _boundary;
        }

        public static function getPostData(arg1:String, arg2:flash.utils.ByteArray, arg3:Object=null):flash.utils.ByteArray
        {
            var loc3:*=0;
            var loc1:*=null;
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "bigEndian";
            if (arg3 == null) 
            {
                arg3 = {};
            }
            arg3.Filename = arg1;
            var loc6:*=0;
            var loc5:*=arg3;
            for (var loc2:* in loc5) 
            {
                loc4 = BOUNDARY(loc4);
                loc4 = LINEBREAK(loc4);
                loc1 = "Content-Disposition: form-data; name=\"" + loc2 + "\"";
                loc3 = 0;
                while (loc3 < loc1.length) 
                {
                    loc4.writeByte(loc1.charCodeAt(loc3));
                    ++loc3;
                }
                loc4 = LINEBREAK(loc4);
                (loc4 = LINEBREAK(loc4)).writeUTFBytes(arg3[loc2]);
                loc4 = LINEBREAK(loc4);
            }
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"file\"; filename=\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4.writeUTFBytes(arg1);
            loc4 = QUOTATIONMARK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Type: application/octet-stream";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            (loc4 = LINEBREAK(loc4)).writeBytes(arg2, 0, arg2.length);
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"Upload\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Submit Query";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            return loc4 = DOUBLEDASH(loc4);
        }

        internal static function BOUNDARY(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*=UploadPostHelper.getBoundary().length;
            arg1 = DOUBLEDASH(arg1);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                arg1.writeByte(_boundary.charCodeAt(loc1));
                ++loc1;
            }
            return arg1;
        }

        internal static function LINEBREAK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(3338);
            return arg1;
        }

        internal static function QUOTATIONMARK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeByte(34);
            return arg1;
        }

        internal static function DOUBLEDASH(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(11565);
            return arg1;
        }

        internal static var _boundary:String="";
    }
}


