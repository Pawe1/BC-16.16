//package adobe
//  package images
//    class PNGEncoder
package com.adobe.images 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public class PNGEncoder extends Object
    {
        public function PNGEncoder()
        {
            super();
            return;
        }

        public static function encode(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc4:*=0;
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeUnsignedInt(2303741511);
            loc2.writeUnsignedInt(218765834);
            var loc6:*;
            (loc6 = new flash.utils.ByteArray()).writeInt(arg1.width);
            loc6.writeInt(arg1.height);
            loc6.writeUnsignedInt(134610944);
            loc6.writeByte(0);
            writeChunk(loc2, 1229472850, loc6);
            var loc5:*=new flash.utils.ByteArray();
            loc3 = 0;
            while (loc3 < arg1.height) 
            {
                loc5.writeByte(0);
                if (arg1.transparent) 
                {
                    loc4 = 0;
                    while (loc4 < arg1.width) 
                    {
                        loc1 = arg1.getPixel32(loc4, loc3);
                        loc5.writeUnsignedInt((loc1 & 16777215) << 8 | loc1 >>> 24);
                        ++loc4;
                    }
                }
                else 
                {
                    loc4 = 0;
                    while (loc4 < arg1.width) 
                    {
                        loc1 = arg1.getPixel(loc4, loc3);
                        loc5.writeUnsignedInt((loc1 & 16777215) << 8 | 255);
                        ++loc4;
                    }
                }
                ++loc3;
            }
            loc5.compress();
            writeChunk(loc2, 1229209940, loc5);
            writeChunk(loc2, 1229278788, null);
            return loc2;
        }

        internal static function writeChunk(arg1:flash.utils.ByteArray, arg2:uint, arg3:flash.utils.ByteArray):void
        {
            var loc2:*=0;
            var loc7:*=0;
            var loc6:*=0;
            var loc5:*=0;
            if (!crcTableComputed) 
            {
                crcTableComputed = true;
                crcTable = [];
                loc7 = 0;
                while (loc7 < 256) 
                {
                    loc2 = loc7;
                    loc6 = 0;
                    while (loc6 < 8) 
                    {
                        if (loc2 & 1) 
                        {
                            loc2 = 3988292384 ^ loc2 >>> 1;
                        }
                        else 
                        {
                            loc2 = loc2 >>> 1;
                        }
                        ++loc6;
                    }
                    crcTable[loc7] = loc2;
                    ++loc7;
                }
            }
            var loc3:*=0;
            if (arg3 != null) 
            {
                loc3 = arg3.length;
            }
            arg1.writeUnsignedInt(loc3);
            var loc1:*=arg1.position;
            arg1.writeUnsignedInt(arg2);
            if (arg3 != null) 
            {
                arg1.writeBytes(arg3);
            }
            var loc4:*=arg1.position;
            arg1.position = loc1;
            loc2 = 4294967295;
            loc5 = 0;
            while (loc5 < loc4 - loc1) 
            {
                loc2 = crcTable[(loc2 ^ arg1.readUnsignedByte()) & 255] ^ loc2 >>> 8;
                ++loc5;
            }
            loc2 = loc2 ^ 4294967295;
            arg1.position = loc4;
            arg1.writeUnsignedInt(loc2);
            return;
        }

        internal static var crcTable:Array;

        internal static var crcTableComputed:Boolean=false;
    }
}


//  package protocols
//    package oauth2
//      package event
//        class GetAccessTokenEvent
package com.adobe.protocols.oauth2.event 
{
    import flash.events.*;
    
    public class GetAccessTokenEvent extends flash.events.Event implements com.adobe.protocols.oauth2.event.IOAuth2Event
    {
        public function GetAccessTokenEvent(arg1:Boolean=false, arg2:Boolean=false)
        {
            super("getAccessToken", arg1, arg2);
            return;
        }

        public function parseAccessTokenResponse(arg1:Object):void
        {
            _accessToken = arg1.access_token;
            _tokenType = arg1.token_type;
            _expiresIn = arg1.expires_in;
            _refreshToken = arg1.refresh_token;
            _scope = arg1.scope;
            _state = arg1.state;
            _response = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
        }

        public function get errorCode():String
        {
            return _errorCode;
        }

        public function set errorCode(arg1:String):void
        {
            _errorCode = arg1;
            return;
        }

        public function get errorMessage():String
        {
            return _errorMessage;
        }

        public function set errorMessage(arg1:String):void
        {
            _errorMessage = arg1;
            return;
        }

        public function get accessToken():String
        {
            return _accessToken;
        }

        public function get tokenType():String
        {
            return _tokenType;
        }

        public function get expiresIn():int
        {
            return _expiresIn;
        }

        public function get refreshToken():String
        {
            return _refreshToken;
        }

        public function get scope():String
        {
            return _scope;
        }

        public function get state():String
        {
            return _state;
        }

        public function get response():Object
        {
            return _response;
        }

        public static const TYPE:String="getAccessToken";

        internal var _errorCode:String;

        internal var _errorMessage:String;

        internal var _accessToken:String;

        internal var _tokenType:String;

        internal var _expiresIn:int;

        internal var _refreshToken:String;

        internal var _scope:String;

        internal var _state:String;

        internal var _response:Object;
    }
}


//        class IOAuth2Event
package com.adobe.protocols.oauth2.event 
{
    public dynamic interface IOAuth2Event
    {
        function get errorCode():String;

        function set errorCode(arg1:String):void;

        function get errorMessage():String;

        function set errorMessage(arg1:String):void;
    }
}


//        class OAut2ProgressEvent
package com.adobe.protocols.oauth2.event 
{
    import flash.events.*;
    
    public class OAut2ProgressEvent extends flash.events.Event
    {
        public function OAut2ProgressEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const PROGRESS:String="progressEvent";

        public var authorizationCode:String;

        public var accessToken:String;
    }
}


//        class RefreshAccessTokenEvent
package com.adobe.protocols.oauth2.event 
{
    import flash.events.*;
    
    public class RefreshAccessTokenEvent extends flash.events.Event implements com.adobe.protocols.oauth2.event.IOAuth2Event
    {
        public function RefreshAccessTokenEvent(arg1:Boolean=false, arg2:Boolean=false)
        {
            super("refreshAccessToken", arg1, arg2);
            return;
        }

        public function parseAccessTokenResponse(arg1:Object):void
        {
            _accessToken = arg1.access_token;
            _tokenType = arg1.token_type;
            _expiresIn = arg1.expires_in;
            _refreshToken = arg1.refresh_token;
            _scope = arg1.scope;
            _state = arg1.state;
            _response = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
        }

        public function get errorCode():String
        {
            return _errorCode;
        }

        public function set errorCode(arg1:String):void
        {
            _errorCode = arg1;
            return;
        }

        public function get errorMessage():String
        {
            return _errorMessage;
        }

        public function set errorMessage(arg1:String):void
        {
            _errorMessage = arg1;
            return;
        }

        public function get accessToken():String
        {
            return _accessToken;
        }

        public function get tokenType():String
        {
            return _tokenType;
        }

        public function get expiresIn():int
        {
            return _expiresIn;
        }

        public function get refreshToken():String
        {
            return _refreshToken;
        }

        public function get scope():String
        {
            return _scope;
        }

        public function get state():String
        {
            return _state;
        }

        public function get response():Object
        {
            return _response;
        }

        public static const TYPE:String="refreshAccessToken";

        internal var _errorCode:String;

        internal var _errorMessage:String;

        internal var _accessToken:String;

        internal var _tokenType:String;

        internal var _expiresIn:int;

        internal var _refreshToken:String;

        internal var _scope:String;

        internal var _state:String;

        internal var _response:Object;
    }
}


//      package grant
//        class AuthorizationCodeGrant
package com.adobe.protocols.oauth2.grant 
{
    import flash.media.*;
    
    public class AuthorizationCodeGrant extends Object implements com.adobe.protocols.oauth2.grant.IGrantType
    {
        public function AuthorizationCodeGrant(arg1:flash.media.StageWebView, arg2:String, arg3:String, arg4:String, arg5:String=null, arg6:Object=null, arg7:Object=null)
        {
            super();
            _stageWebView = arg1;
            _clientId = arg2;
            _clientSecret = arg3;
            _redirectUri = arg4;
            _scope = arg5;
            _state = arg6;
            _queryParams = arg7;
            return;
        }

        public function get stageWebView():flash.media.StageWebView
        {
            return _stageWebView;
        }

        public function get clientId():String
        {
            return _clientId;
        }

        public function get clientSecret():String
        {
            return _clientSecret;
        }

        public function get redirectUri():String
        {
            return _redirectUri;
        }

        public function get scope():String
        {
            return _scope;
        }

        public function get state():Object
        {
            return _state;
        }

        public function get queryParams():Object
        {
            return _queryParams;
        }

        public function getFullAuthUrl(arg1:String):String
        {
            var loc2:*=arg1 + "?response_type=" + "code" + "&client_id=" + clientId + "&redirect_uri=" + redirectUri;
            if (!(scope == null) && scope.length > 0) 
            {
                loc2 = loc2 + ("&scope=" + scope);
            }
            if (state != null) 
            {
                loc2 = loc2 + ("&state=" + state);
            }
            if (queryParams != null) 
            {
                var loc4:*=0;
                var loc3:*=queryParams;
                for (var loc1:* in loc3) 
                {
                    loc2 = loc2 + ("&" + loc1 + "=" + queryParams[loc1]);
                }
            }
            return loc2;
        }

        internal var _stageWebView:flash.media.StageWebView;

        internal var _clientId:String;

        internal var _clientSecret:String;

        internal var _redirectUri:String;

        internal var _scope:String;

        internal var _state:Object;

        internal var _queryParams:Object;
    }
}


//        class IGrantType
package com.adobe.protocols.oauth2.grant 
{
    public dynamic interface IGrantType
    {
        function get clientId():String;
    }
}


//        class ImplicitGrant
package com.adobe.protocols.oauth2.grant 
{
    import flash.media.*;
    
    public class ImplicitGrant extends Object implements com.adobe.protocols.oauth2.grant.IGrantType
    {
        public function ImplicitGrant(arg1:flash.media.StageWebView, arg2:String, arg3:String, arg4:String=null, arg5:Object=null, arg6:Object=null)
        {
            super();
            _stageWebView = arg1;
            _clientId = arg2;
            _redirectUri = arg3;
            _scope = arg4;
            _state = arg5;
            _queryParams = arg6;
            return;
        }

        public function get stageWebView():flash.media.StageWebView
        {
            return _stageWebView;
        }

        public function get clientId():String
        {
            return _clientId;
        }

        public function get redirectUri():String
        {
            return _redirectUri;
        }

        public function get scope():String
        {
            return _scope;
        }

        public function get state():Object
        {
            return _state;
        }

        public function get queryParams():Object
        {
            return _queryParams;
        }

        public function getFullAuthUrl(arg1:String):String
        {
            var loc2:*=arg1 + "?response_type=" + "token" + "&client_id=" + clientId + "&redirect_uri=" + redirectUri;
            if (!(scope == null) && scope.length > 0) 
            {
                loc2 = loc2 + ("&scope=" + scope);
            }
            if (state != null) 
            {
                loc2 = loc2 + ("&state=" + state);
            }
            if (queryParams != null) 
            {
                var loc4:*=0;
                var loc3:*=queryParams;
                for (var loc1:* in loc3) 
                {
                    loc2 = loc2 + ("&" + loc1 + "=" + queryParams[loc1]);
                }
            }
            return loc2;
        }

        internal var _stageWebView:flash.media.StageWebView;

        internal var _clientId:String;

        internal var _redirectUri:String;

        internal var _scope:String;

        internal var _state:Object;

        internal var _queryParams:Object;
    }
}


//        class ResourceOwnerCredentialsGrant
package com.adobe.protocols.oauth2.grant 
{
    public class ResourceOwnerCredentialsGrant extends Object implements com.adobe.protocols.oauth2.grant.IGrantType
    {
        public function ResourceOwnerCredentialsGrant(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String=null)
        {
            super();
            _clientId = arg1;
            _clientSecret = arg2;
            _username = arg3;
            _password = arg4;
            _scope = arg5;
            return;
        }

        public function get clientId():String
        {
            return _clientId;
        }

        public function get clientSecret():String
        {
            return _clientSecret;
        }

        public function get username():String
        {
            return _username;
        }

        public function get password():String
        {
            return _password;
        }

        public function get scope():String
        {
            return _scope;
        }

        internal var _clientId:String;

        internal var _clientSecret:String;

        internal var _username:String;

        internal var _password:String;

        internal var _scope:String;
    }
}


//      class OAuth2
package com.adobe.protocols.oauth2 
{
    import com.adobe.protocols.oauth2.event.*;
    import com.adobe.protocols.oauth2.grant.*;
    import com.adobe.serialization.json.*;
    import flash.events.*;
    import flash.net.*;
    import org.as3commons.logging.api.*;
    import org.as3commons.logging.setup.*;
    import org.as3commons.logging.setup.target.*;
    
    public class OAuth2 extends flash.events.EventDispatcher
    {
        public function OAuth2(arg1:String, arg2:String, arg3:org.as3commons.logging.setup.LogSetupLevel=null)
        {
            traceTarget = new org.as3commons.logging.setup.target.TraceTarget();
            super();
            this.authEndpoint = arg1;
            this.tokenEndpoint = arg2;
            traceTarget = new org.as3commons.logging.setup.target.TraceTarget();
            traceTarget.format = "{date} {time} [{logLevel}] {name} {message}";
            org.as3commons.logging.api.LOGGER_FACTORY.setup = new org.as3commons.logging.setup.LevelTargetSetup(traceTarget, arg3 != null ? arg3 : org.as3commons.logging.setup.LogSetupLevel.NONE);
            return;
        }

        public function getAccessToken(arg1:com.adobe.protocols.oauth2.grant.IGrantType):void
        {
            if (arg1 is com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant) 
            {
                log.info("Initiating getAccessToken() with authorization code grant type workflow");
                getAccessTokenWithAuthorizationCodeGrant(arg1 as com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant);
            }
            else if (arg1 is com.adobe.protocols.oauth2.grant.ImplicitGrant) 
            {
                log.info("Initiating getAccessToken() with implicit grant type workflow");
                getAccessTokenWithImplicitGrant(arg1 as com.adobe.protocols.oauth2.grant.ImplicitGrant);
            }
            else if (arg1 is com.adobe.protocols.oauth2.grant.ResourceOwnerCredentialsGrant) 
            {
                log.info("Initiating getAccessToken() with resource owner credentials grant type workflow");
                getAccessTokenWithResourceOwnerCredentialsGrant(arg1 as com.adobe.protocols.oauth2.grant.ResourceOwnerCredentialsGrant);
            }
            return;
        }

        public function refreshAccessToken(arg1:String, arg2:String, arg3:String, arg4:String=null):void
        {
            var refreshToken:String;
            var clientId:String;
            var clientSecret:String;
            var scope:String;
            var refreshAccessTokenEvent:com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent;
            var urlRequest:flash.net.URLRequest;
            var urlLoader:flash.net.URLLoader;
            var urlVariables:flash.net.URLVariables;
            var onRefreshAccessTokenResult:*;
            var onRefreshAccessTokenError:*;

            var loc1:*;
            refreshToken = arg1;
            clientId = arg2;
            clientSecret = arg3;
            scope = arg4;
            onRefreshAccessTokenResult = function (arg1:flash.events.Event):void
            {
                var loc1:*=null;
                try 
                {
                    loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                    log.debug("Access token: " + loc1.access_token);
                    refreshAccessTokenEvent.parseAccessTokenResponse(loc1);
                }
                catch (error:com.adobe.serialization.json.JSONParseError)
                {
                    refreshAccessTokenEvent.errorCode = "com.adobe.serialization.json.JSONParseError";
                    refreshAccessTokenEvent.errorMessage = "Error parsing output from refresh access token response";
                }
                dispatchEvent(refreshAccessTokenEvent);
                return;
            }
            onRefreshAccessTokenError = function (arg1:flash.events.Event):void
            {
                var loc1:*=null;
                log.error("Error encountered during refresh access token request: " + arg1);
                try 
                {
                    loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                    refreshAccessTokenEvent.errorCode = loc1.error;
                    refreshAccessTokenEvent.errorMessage = loc1.error_description;
                }
                catch (error:com.adobe.serialization.json.JSONParseError)
                {
                    refreshAccessTokenEvent.errorCode = "Unknown";
                    refreshAccessTokenEvent.errorMessage = "Error encountered during refresh access token request.  Unable to parse error message.";
                }
                dispatchEvent(refreshAccessTokenEvent);
                return;
            }
            refreshAccessTokenEvent = new com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent();
            urlRequest = new flash.net.URLRequest(tokenEndpoint);
            urlLoader = new flash.net.URLLoader();
            urlRequest.method = "POST";
            urlVariables = new flash.net.URLVariables();
            urlVariables.grant_type = "refresh_token";
            urlVariables.client_id = clientId;
            urlVariables.client_secret = clientSecret;
            urlVariables.refresh_token = refreshToken;
            if (scope) 
            {
                urlVariables.scope = scope;
            }
            urlRequest.data = urlVariables;
            urlLoader.addEventListener("complete", onRefreshAccessTokenResult);
            urlLoader.addEventListener("ioError", onRefreshAccessTokenError);
            urlLoader.addEventListener("securityError", onRefreshAccessTokenError);
            try 
            {
                urlLoader.load(urlRequest);
            }
            catch (error:Error)
            {
                log.error("Error loading token endpoint \"" + tokenEndpoint + "\"");
            }
            return;
        }

        public function setLogLevel(arg1:org.as3commons.logging.setup.LogSetupLevel):void
        {
            org.as3commons.logging.api.LOGGER_FACTORY.setup = new org.as3commons.logging.setup.LevelTargetSetup(traceTarget, arg1);
            return;
        }

        internal function getAccessTokenWithAuthorizationCodeGrant(arg1:com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant):void
        {
            var authorizationCodeGrant:com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant;
            var getAccessTokenEvent:com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
            var startTime:Number;
            var urlTolaod:String;
            var onLocationChanging:*;
            var getAccessTokenWithAuthCode:*;
            var onStageWebViewComplete:*;
            var onStageWebViewError:*;

            var loc1:*;
            authorizationCodeGrant = arg1;
            onLocationChanging = function (arg1:flash.events.LocationChangeEvent):void
            {
                var loc2:*=false;
                var loc1:*=false;
                var loc4:*=null;
                var loc3:*=null;
                var loc5:*=null;
                try 
                {
                    log.info("Loading URL: " + arg1.location);
                    loc2 = arg1.location.indexOf(authorizationCodeGrant.redirectUri) == 0;
                    loc1 = arg1.location.indexOf("code") > 0;
                    log.info("isRedirectUri: " + loc2);
                    log.info("isOAuthCode: " + loc1);
                    if (loc2 && loc1) 
                    {
                        log.info("Redirect URI encountered (" + authorizationCodeGrant.redirectUri + ").  Extracting values from path.");
                        arg1.preventDefault();
                        if ((loc3 = (loc4 = extractQueryParams(arg1.location)).code) == null) 
                        {
                            log.error("Error encountered during authorization request");
                            getAccessTokenEvent.errorCode = loc4.error;
                            getAccessTokenEvent.errorMessage = loc4.error_description;
                            dispatchEvent(getAccessTokenEvent);
                        }
                        else 
                        {
                            log.debug("Authorization code: " + loc3);
                            (loc5 = new com.adobe.protocols.oauth2.event.OAut2ProgressEvent("progressEvent")).authorizationCode = loc3;
                            dispatchEvent(loc5);
                            getAccessTokenWithAuthCode(loc3);
                        }
                    }
                }
                catch (e:Error)
                {
                    log.info("any error: " + e.message);
                }
                return;
            }
            getAccessTokenWithAuthCode = function (arg1:String):void
            {
                var code:String;
                var urlRequest:flash.net.URLRequest;
                var urlLoader:flash.net.URLLoader;
                var urlVariables:flash.net.URLVariables;
                var onGetAccessTokenResult:*;
                var onGetAccessTokenError:*;

                var loc1:*;
                code = arg1;
                onGetAccessTokenResult = function (arg1:flash.events.Event):void
                {
                    var loc1:*=null;
                    var loc2:*=null;
                    try 
                    {
                        loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                        log.debug("Access token: " + loc1.access_token);
                        loc2 = new com.adobe.protocols.oauth2.event.OAut2ProgressEvent("progressEvent");
                        loc2.accessToken = loc1.access_token;
                        dispatchEvent(loc2);
                        getAccessTokenEvent.parseAccessTokenResponse(loc1);
                    }
                    catch (error:com.adobe.serialization.json.JSONParseError)
                    {
                        getAccessTokenEvent.errorCode = "com.adobe.serialization.json.JSONParseError";
                        getAccessTokenEvent.errorMessage = "Error parsing output from access token response";
                    }
                    dispatchEvent(getAccessTokenEvent);
                    return;
                }
                onGetAccessTokenError = function (arg1:flash.events.Event):void
                {
                    var loc1:*=null;
                    log.error("Error encountered during access token request: " + arg1);
                    try 
                    {
                        loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                        getAccessTokenEvent.errorCode = loc1.error;
                        getAccessTokenEvent.errorMessage = loc1.error_description;
                    }
                    catch (error:com.adobe.serialization.json.JSONParseError)
                    {
                        getAccessTokenEvent.errorCode = "Unknown";
                        getAccessTokenEvent.errorMessage = "Error encountered during access token request.  Unable to parse error message.";
                    }
                    dispatchEvent(getAccessTokenEvent);
                    return;
                }
                urlRequest = new flash.net.URLRequest(tokenEndpoint);
                if (requestHeader) 
                {
                    urlRequest.requestHeaders.push(requestHeader);
                }
                urlLoader = new flash.net.URLLoader();
                urlRequest.method = "POST";
                urlVariables = new flash.net.URLVariables();
                urlVariables.grant_type = "authorization_code";
                if (useURLDecode) 
                {
                    urlVariables.code = decodeURI(code);
                }
                else 
                {
                    urlVariables.code = code;
                }
                urlVariables.redirect_uri = authorizationCodeGrant.redirectUri;
                urlVariables.client_id = authorizationCodeGrant.clientId;
                urlVariables.client_secret = authorizationCodeGrant.clientSecret;
                urlRequest.data = urlVariables;
                urlLoader.addEventListener("complete", onGetAccessTokenResult);
                urlLoader.addEventListener("ioError", onGetAccessTokenError);
                urlLoader.addEventListener("securityError", onGetAccessTokenError);
                try 
                {
                    urlLoader.load(urlRequest);
                }
                catch (error:Error)
                {
                    log.error("Error loading token endpoint \"" + tokenEndpoint + "\"");
                }
                return;
            }
            onStageWebViewComplete = function (arg1:flash.events.Event):void
            {
                var loc2:*=null;
                var loc1:*=null;
                if (authorizationCodeGrant.redirectUri == "urn:ietf:wg:oauth:2.0:oob" && arg1.currentTarget.title.indexOf("code") > 0) 
                {
                    loc2 = arg1.currentTarget.title.substring(arg1.currentTarget.title.indexOf("code"));
                    loc1 = loc2.split("=")[1];
                    log.debug("Authorization code extracted from page title: " + loc1);
                    getAccessTokenWithAuthCode(loc1);
                }
                else 
                {
                    log.info("Auth URL loading complete after " + (new Date().time - startTime) + "ms");
                }
                return;
            }
            onStageWebViewError = function (arg1:flash.events.ErrorEvent):void
            {
                log.error("Error occurred with StageWebView: " + arg1);
                getAccessTokenEvent.errorCode = "STAGE_WEB_VIEW_ERROR";
                getAccessTokenEvent.errorMessage = "Error occurred with StageWebView";
                dispatchEvent(getAccessTokenEvent);
                return;
            }
            getAccessTokenEvent = new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
            authorizationCodeGrant.stageWebView.addEventListener("locationChanging", onLocationChanging);
            authorizationCodeGrant.stageWebView.addEventListener("locationChange", onLocationChanging);
            authorizationCodeGrant.stageWebView.addEventListener("complete", onStageWebViewComplete);
            authorizationCodeGrant.stageWebView.addEventListener("error", onStageWebViewError);
            startTime = new Date().time;
            urlTolaod = authorizationCodeGrant.getFullAuthUrl(authEndpoint);
            log.info("Loading auth URL: " + urlTolaod);
            try 
            {
                authorizationCodeGrant.stageWebView.loadURL(urlTolaod);
            }
            catch (e:Error)
            {
                log.error("loadURL error: " + e.message);
            }
            return;
        }

        internal function getAccessTokenWithImplicitGrant(arg1:com.adobe.protocols.oauth2.grant.ImplicitGrant):void
        {
            var implicitGrant:com.adobe.protocols.oauth2.grant.ImplicitGrant;
            var getAccessTokenEvent:com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
            var urlTolaod:String;
            var onLocationChanging:*;
            var onLocationChange:*;
            var onStageWebViewError:*;

            var loc1:*;
            implicitGrant = arg1;
            onLocationChanging = function (arg1:flash.events.LocationChangeEvent):void
            {
                log.info("onLocationChanging- Loading auth URL: " + urlTolaod);
                return;
            }
            onLocationChange = function (arg1:flash.events.LocationChangeEvent):void
            {
                var loc1:*=false;
                var loc2:*=false;
                var loc3:*=null;
                var loc4:*=null;
                try 
                {
                    log.info("onLocationChanging - Loading URL: " + arg1.location);
                    loc1 = arg1.location.indexOf(implicitGrant.redirectUri) == 0;
                    loc2 = arg1.location.indexOf("access_token") > 0;
                    log.info("isRedirectUri: " + loc1);
                    log.info("isAccessToken: " + loc2);
                    if (loc1 && loc2) 
                    {
                        log.info("Redirect URI encountered (" + implicitGrant.redirectUri + ").  Extracting values from path.");
                        arg1.preventDefault();
                        if ((loc4 = (loc3 = extractQueryParams(arg1.location)).access_token) == null) 
                        {
                            log.error("Error encountered during access token request");
                            getAccessTokenEvent.errorCode = loc3.error;
                            getAccessTokenEvent.errorMessage = loc3.error_description;
                            dispatchEvent(getAccessTokenEvent);
                        }
                        else 
                        {
                            log.debug("Access token: " + loc4);
                            getAccessTokenEvent.parseAccessTokenResponse(loc3);
                            dispatchEvent(getAccessTokenEvent);
                        }
                    }
                }
                catch (e:Error)
                {
                    log.info("any error: " + e.message);
                }
                return;
            }
            onStageWebViewError = function (arg1:flash.events.ErrorEvent):void
            {
                log.error("Error occurred with StageWebView: " + arg1);
                getAccessTokenEvent.errorCode = "STAGE_WEB_VIEW_ERROR";
                getAccessTokenEvent.errorMessage = "Error occurred with StageWebView";
                dispatchEvent(getAccessTokenEvent);
                return;
            }
            getAccessTokenEvent = new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
            implicitGrant.stageWebView.addEventListener("locationChanging", onLocationChanging);
            implicitGrant.stageWebView.addEventListener("locationChange", onLocationChange);
            implicitGrant.stageWebView.addEventListener("error", onStageWebViewError);
            urlTolaod = implicitGrant.getFullAuthUrl(authEndpoint);
            log.info("Loading auth URL: " + urlTolaod);
            try 
            {
                implicitGrant.stageWebView.loadURL(urlTolaod);
            }
            catch (e:Error)
            {
                log.error("loadURL error: " + e.message);
            }
            return;
        }

        internal function getAccessTokenWithResourceOwnerCredentialsGrant(arg1:com.adobe.protocols.oauth2.grant.ResourceOwnerCredentialsGrant):void
        {
            var resourceOwnerCredentialsGrant:com.adobe.protocols.oauth2.grant.ResourceOwnerCredentialsGrant;
            var getAccessTokenEvent:com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
            var urlRequest:flash.net.URLRequest;
            var urlLoader:flash.net.URLLoader;
            var urlVariables:flash.net.URLVariables;
            var onGetAccessTokenResult:*;
            var onGetAccessTokenError:*;

            var loc1:*;
            resourceOwnerCredentialsGrant = arg1;
            onGetAccessTokenResult = function (arg1:flash.events.Event):void
            {
                var loc1:*=null;
                try 
                {
                    loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                    log.debug("Access token: " + loc1.access_token);
                    getAccessTokenEvent.parseAccessTokenResponse(loc1);
                }
                catch (error:com.adobe.serialization.json.JSONParseError)
                {
                    getAccessTokenEvent.errorCode = "com.adobe.serialization.json.JSONParseError";
                    getAccessTokenEvent.errorMessage = "Error parsing output from access token response";
                }
                dispatchEvent(getAccessTokenEvent);
                return;
            }
            onGetAccessTokenError = function (arg1:flash.events.Event):void
            {
                var loc1:*=null;
                log.error("Error encountered during access token request: " + arg1);
                try 
                {
                    loc1 = com.adobe.serialization.json.JSON.decode(arg1.target.data);
                    getAccessTokenEvent.errorCode = loc1.error;
                    getAccessTokenEvent.errorMessage = loc1.error_description;
                }
                catch (error:com.adobe.serialization.json.JSONParseError)
                {
                    getAccessTokenEvent.errorCode = "Unknown";
                    getAccessTokenEvent.errorMessage = "Error encountered during access token request.  Unable to parse error message.";
                }
                dispatchEvent(getAccessTokenEvent);
                return;
            }
            getAccessTokenEvent = new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
            urlRequest = new flash.net.URLRequest(tokenEndpoint);
            urlLoader = new flash.net.URLLoader();
            urlRequest.method = "POST";
            urlVariables = new flash.net.URLVariables();
            urlVariables.grant_type = "password";
            urlVariables.client_id = resourceOwnerCredentialsGrant.clientId;
            urlVariables.client_secret = resourceOwnerCredentialsGrant.clientSecret;
            urlVariables.username = resourceOwnerCredentialsGrant.username;
            urlVariables.password = resourceOwnerCredentialsGrant.password;
            urlVariables.scope = resourceOwnerCredentialsGrant.scope;
            urlRequest.data = urlVariables;
            urlLoader.addEventListener("complete", onGetAccessTokenResult);
            urlLoader.addEventListener("ioError", onGetAccessTokenError);
            urlLoader.addEventListener("securityError", onGetAccessTokenError);
            try 
            {
                urlLoader.load(urlRequest);
            }
            catch (error:Error)
            {
                log.error("Error loading token endpoint \"" + tokenEndpoint + "\"");
            }
            return;
        }

        internal function extractQueryParams(arg1:String):Object
        {
            var loc3:*=null;
            var loc4:*=arg1.indexOf("?") > 0 ? "?" : "#";
            var loc1:*=arg1.split(loc4)[1];
            var loc5:*=loc1.split("&");
            var loc2:*={};
            var loc8:*=0;
            var loc7:*=loc5;
            for each (var loc6:* in loc7) 
            {
                (loc3 = loc6.split("="))[0] = (loc3[0] as String).replace("#", "");
                loc2[loc3[0]] = loc3[1];
            }
            return loc2;
        }

        internal static const log:org.as3commons.logging.api.ILogger=org.as3commons.logging.api.getLogger(OAuth2);

        internal var grantType:com.adobe.protocols.oauth2.grant.IGrantType;

        internal var authEndpoint:String;

        internal var tokenEndpoint:String;

        internal var traceTarget:org.as3commons.logging.setup.target.TraceTarget;

        public var requestHeader:flash.net.URLRequestHeader;

        public var useURLDecode:Boolean=false;
    }
}


//      class OAuth2Const
package com.adobe.protocols.oauth2 
{
    public class OAuth2Const extends Object
    {
        public function OAuth2Const()
        {
            super();
            return;
        }

        public static const GRANT_TYPE_AUTHORIZATION_CODE:String="authorization_code";

        public static const GRANT_TYPE_RESOURCE_OWNER_CREDENTIALS:String="password";

        public static const GRANT_TYPE_REFRESH_TOKEN:String="refresh_token";

        public static const RESPONSE_TYPE_AUTHORIZATION_CODE:String="code";

        public static const RESPONSE_TYPE_IMPLICIT:String="token";

        public static const RESPONSE_PROPERTY_AUTHORIZATION_CODE:String="code";

        public static const RESPONSE_PROPERTY_ACCESS_TOKEN:String="access_token";

        public static const GOOGLE_INSTALLED_APPLICATION_REDIRECT_URI:String="urn:ietf:wg:oauth:2.0:oob";
    }
}


//  package serialization
//    package json
//      class JSON
package com.adobe.serialization.json 
{
    public class JSON extends Object
    {
        public function JSON()
        {
            super();
            return;
        }

        public static function decode(arg1:String, arg2:Boolean=true):*
        {
            return new com.adobe.serialization.json.JSONDecoder(arg1, arg2).getValue();
        }

        public static function encode(arg1:Object):String
        {
            return new com.adobe.serialization.json.JSONEncoder(arg1).getString();
        }
    }
}


//      class JSONDecoder
package com.adobe.serialization.json 
{
    public class JSONDecoder extends Object
    {
        public function JSONDecoder(arg1:String, arg2:Boolean)
        {
            super();
            this.strict = arg2;
            this.tokenizer = new com.adobe.serialization.json.JSONTokenizer(arg1, arg2);
            this.nextToken();
            this.value = this.parseValue();
            if (arg2 && !(this.nextToken() == null)) 
            {
                this.tokenizer.parseError("Unexpected characters left in input stream");
            }
            return;
        }

        internal function nextToken():com.adobe.serialization.json.JSONToken
        {
            var loc1:*;
            this.token = loc1 = this.tokenizer.getNextToken();
            return loc1;
        }

        internal function parseObject():Object
        {
            var loc2:*=null;
            var loc1:*=new Object();
            this.nextToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
            }
            for (;;) 
            {
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.STRING) 
                {
                    loc2 = String(this.token.value);
                    this.nextToken();
                    if (this.token.type != com.adobe.serialization.json.JSONTokenType.COLON) 
                    {
                        this.tokenizer.parseError("Expecting : but found " + this.token.value);
                    }
                    else 
                    {
                        this.nextToken();
                        loc1[loc2] = this.parseValue();
                        this.nextToken();
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                        {
                            return loc1;
                        }
                        if (this.token.type != com.adobe.serialization.json.JSONTokenType.COMMA) 
                        {
                            this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                        }
                        else 
                        {
                            this.nextToken();
                            if (!this.strict) 
                            {
                                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                                {
                                    return loc1;
                                }
                            }
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
            return null;
        }

        internal function parseArray():Array
        {
            var loc1:*=new Array();
            this.nextToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
            }
            for (;;) 
            {
                loc1.push(this.parseValue());
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
                {
                    this.nextToken();
                    if (!this.strict) 
                    {
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                        {
                            return loc1;
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
            return null;
        }

        public function getValue():*
        {
            return this.value;
        }

        internal function parseValue():Object
        {
            if (this.token == null) 
            {
                this.tokenizer.parseError("Unexpected end of input");
            }
            var loc1:*=this.token.type;
            switch (loc1) 
            {
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACE:
                {
                    return this.parseObject();
                }
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET:
                {
                    return this.parseArray();
                }
                case com.adobe.serialization.json.JSONTokenType.STRING:
                case com.adobe.serialization.json.JSONTokenType.NUMBER:
                case com.adobe.serialization.json.JSONTokenType.TRUE:
                case com.adobe.serialization.json.JSONTokenType.FALSE:
                case com.adobe.serialization.json.JSONTokenType.NULL:
                {
                    return this.token.value;
                }
                case com.adobe.serialization.json.JSONTokenType.NAN:
                {
                    if (!this.strict) 
                    {
                        return this.token.value;
                    }
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
                default:
                {
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
            }
            return null;
        }

        internal var strict:Boolean;

        internal var value:*;

        internal var tokenizer:com.adobe.serialization.json.JSONTokenizer;

        internal var token:com.adobe.serialization.json.JSONToken;
    }
}


//      class JSONEncoder
package com.adobe.serialization.json 
{
    import flash.utils.*;
    
    public class JSONEncoder extends Object
    {
        public function JSONEncoder(arg1:*)
        {
            super();
            this.jsonString = this.convertToString(arg1);
            return;
        }

        internal function escapeString(arg1:String):String
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*="";
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2 = arg1.charAt(loc4);
                var loc7:*=loc2;
                switch (loc7) 
                {
                    case "\"":
                    {
                        loc1 = loc1 + "\\\"";
                        break;
                    }
                    case "\\":
                    {
                        loc1 = loc1 + "\\\\";
                        break;
                    }
                    case "":
                    {
                        loc1 = loc1 + "\\b";
                        break;
                    }
                    case "":
                    {
                        loc1 = loc1 + "\\f";
                        break;
                    }
                    case "\n":
                    {
                        loc1 = loc1 + "\\n";
                        break;
                    }
                    case "\r":
                    {
                        loc1 = loc1 + "\\r";
                        break;
                    }
                    case "\t":
                    {
                        loc1 = loc1 + "\\t";
                        break;
                    }
                    default:
                    {
                        if (loc2 < " ") 
                        {
                            loc5 = loc2.charCodeAt(0).toString(16);
                            loc6 = loc5.length != 2 ? "000" : "00";
                            loc1 = loc1 + ("\\u" + loc6 + loc5);
                        }
                        else 
                        {
                            loc1 = loc1 + loc2;
                        }
                    }
                }
                ++loc4;
            }
            return "\"" + loc1 + "\"";
        }

        internal function arrayToString(arg1:Array):String
        {
            var loc1:*="";
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (loc1.length > 0) 
                {
                    loc1 = loc1 + ",";
                }
                loc1 = loc1 + this.convertToString(arg1[loc2]);
                ++loc2;
            }
            return "[" + loc1 + "]";
        }

        public function getString():String
        {
            return this.jsonString;
        }

        internal function objectToString(arg1:Object):String
        {
            var value:Object;
            var s:String;
            var classInfo:XML;
            var key:String;
            var v:XML;
            var o:Object;

            var loc1:*;
            value = null;
            key = null;
            v = null;
            o = arg1;
            s = "";
            classInfo = flash.utils.describeType(o);
            if (classInfo.@name.toString() != "Object") 
            {
                loc2 = 0;
                var loc5:*=0;
                var loc6:*=classInfo;
                var loc4:*=new XMLList("");
                for each (var loc7:* in loc6) 
                {
                    var loc8:*;
                    with (loc8 = loc7) 
                    {
                        if (name() == "variable" || name() == "accessor" && attribute("access").charAt(0) == "r") 
                        {
                            loc4[loc5] = loc7;
                        }
                    }
                }
                loc3 = loc4;
                for each (v in loc3) 
                {
                    if (v.metadata) 
                    {
                        v.metadata;
                        loc5 = 0;
                        loc6 = v.metadata;
                        loc4 = new XMLList("");
                        for each (loc7 in loc6) 
                        {
                            with (loc8 = loc7) 
                            {
                                if (@name == "Transient") 
                                {
                                    loc4[loc5] = loc7;
                                }
                            }
                        }
                    }
                    if (v.metadata) 
                    {
                        continue;
                    }
                    if (s.length > 0) 
                    {
                        s = s + ",";
                    }
                    s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
                }
            }
            else 
            {
                var loc2:*=0;
                var loc3:*=o;
                for (key in loc3) 
                {
                    value = o[key];
                    if (value is Function) 
                    {
                        continue;
                    }
                    if (s.length > 0) 
                    {
                        s = s + ",";
                    }
                    s = s + (this.escapeString(key) + ":" + this.convertToString(value));
                }
            }
            return "{" + s + "}";
        }

        internal function convertToString(arg1:*):String
        {
            if (arg1 is String) 
            {
                return this.escapeString(arg1 as String);
            }
            if (arg1 is Number) 
            {
                return isFinite(arg1 as Number) ? arg1.toString() : "null";
            }
            if (arg1 is Boolean) 
            {
                return arg1 ? "true" : "false";
            }
            if (arg1 is Array) 
            {
                return this.arrayToString(arg1 as Array);
            }
            if (arg1 is Object && !(arg1 == null)) 
            {
                return this.objectToString(arg1);
            }
            return "null";
        }

        internal var jsonString:String;
    }
}


//      class JSONParseError
package com.adobe.serialization.json 
{
    public class JSONParseError extends Error
    {
        public function JSONParseError(arg1:String="", arg2:int=0, arg3:String="")
        {
            super(arg1);
            name = "JSONParseError";
            this._location = arg2;
            this._text = arg3;
            return;
        }

        public function get location():int
        {
            return this._location;
        }

        public function get text():String
        {
            return this._text;
        }

        internal var _location:int;

        internal var _text:String;
    }
}


//      class JSONToken
package com.adobe.serialization.json 
{
    public class JSONToken extends Object
    {
        public function JSONToken(arg1:int=-1, arg2:Object=null)
        {
            super();
            this._type = arg1;
            this._value = arg2;
            return;
        }

        public function get value():Object
        {
            return this._value;
        }

        public function get type():int
        {
            return this._type;
        }

        public function set type(arg1:int):void
        {
            this._type = arg1;
            return;
        }

        public function set value(arg1:Object):void
        {
            this._value = arg1;
            return;
        }

        internal var _value:Object;

        internal var _type:int;
    }
}


//      class JSONTokenType
package com.adobe.serialization.json 
{
    public class JSONTokenType extends Object
    {
        public function JSONTokenType()
        {
            super();
            return;
        }

        public static const FALSE:int=8;

        public static const RIGHT_BRACKET:int=4;

        public static const NULL:int=9;

        public static const NUMBER:int=11;

        public static const TRUE:int=7;

        public static const RIGHT_BRACE:int=2;

        public static const STRING:int=10;

        public static const LEFT_BRACKET:int=3;

        public static const LEFT_BRACE:int=1;

        public static const UNKNOWN:int=-1;

        public static const COMMA:int=0;

        public static const NAN:int=12;

        public static const COLON:int=6;
    }
}


//      class JSONTokenizer
package com.adobe.serialization.json 
{
    public class JSONTokenizer extends Object
    {
        public function JSONTokenizer(arg1:String, arg2:Boolean)
        {
            this.controlCharsRegExp = new RegExp("[\\x00-\\x1F]");
            super();
            this.jsonString = arg1;
            this.strict = arg2;
            this.loc = 0;
            this.nextChar();
            return;
        }

        internal function skipComments():void
        {
            if (this.ch == "/") 
            {
                this.nextChar();
                var loc1:*=this.ch;
                switch (loc1) 
                {
                    case "/":
                    {
                        do 
                        {
                            this.nextChar();
                        }
                        while (!(this.ch == "\n") && !(this.ch == ""));
                        this.nextChar();
                        break;
                    }
                    case "*":
                    {
                        this.nextChar();
                        for (;;) 
                        {
                            if (this.ch != "*") 
                            {
                                this.nextChar();
                            }
                            else 
                            {
                                this.nextChar();
                                if (this.ch == "/") 
                                {
                                    this.nextChar();
                                    break;
                                }
                            }
                            if (this.ch != "") 
                            {
                                continue;
                            }
                            this.parseError("Multi-line comment not closed");
                        }
                        break;
                    }
                    default:
                    {
                        this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
                    }
                }
            }
            return;
        }

        internal function isDigit(arg1:String):Boolean
        {
            return arg1 >= "0" && arg1 <= "9";
        }

        internal function readNumber():com.adobe.serialization.json.JSONToken
        {
            var loc3:*=null;
            var loc1:*="";
            if (this.ch == "-") 
            {
                loc1 = loc1 + "-";
                this.nextChar();
            }
            if (!this.isDigit(this.ch)) 
            {
                this.parseError("Expecting a digit");
            }
            if (this.ch != "0") 
            {
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            else 
            {
                loc1 = loc1 + this.ch;
                this.nextChar();
                if (this.isDigit(this.ch)) 
                {
                    this.parseError("A digit cannot immediately follow 0");
                }
                else if (!this.strict && this.ch == "x") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                    if (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                    else 
                    {
                        this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                    }
                    while (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                }
            }
            if (this.ch == ".") 
            {
                loc1 = loc1 + ".";
                this.nextChar();
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Expecting a digit");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            if (this.ch == "e" || this.ch == "E") 
            {
                loc1 = loc1 + "e";
                this.nextChar();
                if (this.ch == "+" || this.ch == "-") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Scientific notation number needs exponent value");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            var loc2:*=Number(loc1);
            if (isFinite(loc2) && !isNaN(loc2)) 
            {
                loc3 = new com.adobe.serialization.json.JSONToken();
                loc3.type = com.adobe.serialization.json.JSONTokenType.NUMBER;
                loc3.value = loc2;
                return loc3;
            }
            this.parseError("Number " + loc2 + " is not valid!");
            return null;
        }

        public function unescapeString(arg1:String):String
        {
            var loc5:*=undefined;
            var loc6:*=undefined;
            var loc7:*=undefined;
            var loc8:*=undefined;
            var loc9:*=undefined;
            if (this.strict && this.controlCharsRegExp.test(arg1)) 
            {
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            }
            var loc1:*="";
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=arg1.length;
            do 
            {
                loc2 = arg1.indexOf("\\", loc3);
                if (loc2 >= 0) 
                {
                    loc1 = loc1 + arg1.substr(loc3, loc2 - loc3);
                    loc3 = loc2 + 2;
                    loc5 = loc2 + 1;
                    loc6 = arg1.charAt(loc5);
                    var loc10:*=loc6;
                    switch (loc10) 
                    {
                        case "\"":
                        {
                            loc1 = loc1 + "\"";
                            break;
                        }
                        case "\\":
                        {
                            loc1 = loc1 + "\\";
                            break;
                        }
                        case "n":
                        {
                            loc1 = loc1 + "\n";
                            break;
                        }
                        case "r":
                        {
                            loc1 = loc1 + "\r";
                            break;
                        }
                        case "t":
                        {
                            loc1 = loc1 + "\t";
                            break;
                        }
                        case "u":
                        {
                            loc7 = "";
                            if (loc3 + 4 > loc4) 
                            {
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            }
                            loc8 = loc3;
                            while (loc8 < loc3 + 4) 
                            {
                                loc9 = arg1.charAt(loc8);
                                if (!this.isHexDigit(loc9)) 
                                {
                                    this.parseError("Excepted a hex digit, but found: " + loc9);
                                }
                                loc7 = loc7 + loc9;
                                ++loc8;
                            }
                            loc1 = loc1 + String.fromCharCode(parseInt(loc7, 16));
                            loc3 = loc3 + 4;
                            break;
                        }
                        case "f":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        case "/":
                        {
                            loc1 = loc1 + "/";
                            break;
                        }
                        case "b":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        default:
                        {
                            loc1 = loc1 + ("\\" + loc6);
                        }
                    }
                }
                else 
                {
                    loc1 = loc1 + arg1.substr(loc3);
                    break;
                }
            }
            while (loc3 < loc4);
            return loc1;
        }

        internal function skipWhite():void
        {
            while (this.isWhiteSpace(this.ch)) 
            {
                this.nextChar();
            }
            return;
        }

        internal function isWhiteSpace(arg1:String):Boolean
        {
            if (arg1 == " " || arg1 == "\t" || arg1 == "\n" || arg1 == "\r") 
            {
                return true;
            }
            if (!this.strict && arg1.charCodeAt(0) == 160) 
            {
                return true;
            }
            return false;
        }

        public function parseError(arg1:String):void
        {
            throw new com.adobe.serialization.json.JSONParseError(arg1, this.loc, this.jsonString);
        }

        internal function readString():com.adobe.serialization.json.JSONToken
        {
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc1:*=this.loc;
            do 
            {
                loc1 = this.jsonString.indexOf("\"", loc1);
                if (loc1 >= 0) 
                {
                    loc3 = 0;
                    --loc4;
                    while (this.jsonString.charAt(loc4) == "\\") 
                    {
                        ++loc3;
                        --loc4;
                    }
                    if (loc3 % 2 == 0) 
                    {
                        break;
                    }
                    ++loc1;
                }
                else 
                {
                    this.parseError("Unterminated string literal");
                }
            }
            while (true);
            var loc2:*=new com.adobe.serialization.json.JSONToken();
            loc2.type = com.adobe.serialization.json.JSONTokenType.STRING;
            loc2.value = this.unescapeString(this.jsonString.substr(this.loc, loc1 - this.loc));
            this.loc = loc1 + 1;
            this.nextChar();
            return loc2;
        }

        internal function nextChar():String
        {
            var loc1:*;
            var loc2:*=((loc1 = this).loc + 1);
            loc1.loc = loc2;
            this.ch = loc1 = this.jsonString.charAt((loc1 = this).loc);
            return loc1;
        }

        internal function skipIgnored():void
        {
            var loc1:*=0;
            do 
            {
                loc1 = this.loc;
                this.skipWhite();
                this.skipComments();
            }
            while (loc1 != this.loc);
            return;
        }

        internal function isHexDigit(arg1:String):Boolean
        {
            return this.isDigit(arg1) || arg1 >= "A" && arg1 <= "F" || arg1 >= "a" && arg1 <= "f";
        }

        public function getNextToken():com.adobe.serialization.json.JSONToken
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=new com.adobe.serialization.json.JSONToken();
            this.skipIgnored();
            var loc6:*=this.ch;
            switch (loc6) 
            {
                case "{":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.LEFT_BRACE;
                    loc1.value = "{";
                    this.nextChar();
                    break;
                }
                case "}":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE;
                    loc1.value = "}";
                    this.nextChar();
                    break;
                }
                case "[":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET;
                    loc1.value = "[";
                    this.nextChar();
                    break;
                }
                case "]":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET;
                    loc1.value = "]";
                    this.nextChar();
                    break;
                }
                case ",":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.COMMA;
                    loc1.value = ",";
                    this.nextChar();
                    break;
                }
                case ":":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.COLON;
                    loc1.value = ":";
                    this.nextChar();
                    break;
                }
                case "t":
                {
                    loc2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc2 != "true") 
                    {
                        this.parseError("Expecting \'true\' but found " + loc2);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.TRUE;
                        loc1.value = true;
                        this.nextChar();
                    }
                    break;
                }
                case "f":
                {
                    loc3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc3 != "false") 
                    {
                        this.parseError("Expecting \'false\' but found " + loc3);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.FALSE;
                        loc1.value = false;
                        this.nextChar();
                    }
                    break;
                }
                case "n":
                {
                    loc4 = "n" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc4 != "null") 
                    {
                        this.parseError("Expecting \'null\' but found " + loc4);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.NULL;
                        loc1.value = null;
                        this.nextChar();
                    }
                    break;
                }
                case "N":
                {
                    loc5 = "N" + this.nextChar() + this.nextChar();
                    if (loc5 != "NaN") 
                    {
                        this.parseError("Expecting \'NaN\' but found " + loc5);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.NAN;
                        loc1.value = NaN;
                        this.nextChar();
                    }
                    break;
                }
                case "\"":
                {
                    loc1 = this.readString();
                    break;
                }
                default:
                {
                    if (this.isDigit(this.ch) || this.ch == "-") 
                    {
                        loc1 = this.readNumber();
                    }
                    else 
                    {
                        if (this.ch == "") 
                        {
                            return null;
                        }
                        this.parseError("Unexpected " + this.ch + " encountered");
                    }
                }
            }
            return loc1;
        }

        internal var ch:String;

        internal var loc:int;

        internal var jsonString:String;

        internal var strict:Boolean;

        internal var controlCharsRegExp:RegExp;

        internal var obj:Object;
    }
}


//  package utils
//    class AGALMiniAssembler
package com.adobe.utils 
{
    import flash.display3D.*;
    import flash.utils.*;
    
    public class AGALMiniAssembler extends Object
    {
        public function AGALMiniAssembler(arg1:Boolean=false)
        {
            super();
            this.debugEnabled = arg1;
            if (!initialized) 
            {
                init();
            }
            return;
        }

        public function assemble(arg1:String, arg2:String, arg3:uint=1, arg4:Boolean=false):flash.utils.ByteArray
        {
            var loc6:*=0;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=false;
            var loc16:*=0;
            var loc17:*=0;
            var loc18:*=0;
            var loc19:*=false;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=0;
            var loc25:*=0;
            var loc26:*=null;
            var loc27:*=false;
            var loc28:*=false;
            var loc29:*=0;
            var loc30:*=0;
            var loc31:*=0;
            var loc32:*=0;
            var loc33:*=0;
            var loc34:*=0;
            var loc35:*=null;
            var loc36:*=null;
            var loc37:*=null;
            var loc38:*=null;
            var loc39:*=0;
            var loc40:*=0;
            var loc41:*=NaN;
            var loc42:*=null;
            var loc43:*=null;
            var loc44:*=0;
            var loc45:*=0;
            var loc46:*=null;
            var loc1:*=flash.utils.getTimer();
            this._agalcode = new flash.utils.ByteArray();
            this._error = "";
            var loc2:*=false;
            if (arg1 != FRAGMENT) 
            {
                if (arg1 != VERTEX) 
                {
                    this._error = "ERROR: mode needs to be \"" + FRAGMENT + "\" or \"" + VERTEX + "\" but is \"" + arg1 + "\".";
                }
            }
            else 
            {
                loc2 = true;
            }
            this.agalcode.endian = flash.utils.Endian.LITTLE_ENDIAN;
            this.agalcode.writeByte(160);
            this.agalcode.writeUnsignedInt(arg3);
            this.agalcode.writeByte(161);
            this.agalcode.writeByte(loc2 ? 1 : 0);
            this.initregmap(arg3, arg4);
            var loc3:*=arg2.replace(new RegExp("[\\f\\n\\r\\v]+", "g"), "\n").split("\n");
            var loc4:*=0;
            var loc5:*=0;
            var loc7:*=loc3.length;
            loc6 = 0;
            while (loc6 < loc7 && this._error == "") 
            {
                loc8 = new String(loc3[loc6]);
                loc8 = loc8.replace(REGEXP_OUTER_SPACES, "");
                loc9 = loc8.search("//");
                if (loc9 != -1) 
                {
                    loc8 = loc8.slice(0, loc9);
                }
                loc10 = loc8.search(new RegExp("<.*>", "g"));
                if (loc10 != -1) 
                {
                    loc11 = loc8.slice(loc10).match(new RegExp("([\\w\\.\\-\\+]+)", "gi"));
                    loc8 = loc8.slice(0, loc10);
                }
                loc12 = loc8.match(new RegExp("^\\w{3}", "ig"));
                if (loc12) 
                {
                    loc13 = OPMAP[loc12[0]];
                    if (this.debugEnabled) 
                    {
                        trace(loc13);
                    }
                    if (loc13 != null) 
                    {
                        loc8 = loc8.slice(loc8.search(loc13.name) + loc13.name.length);
                        if (loc13.flags & OP_VERSION2 && arg3 < 2) 
                        {
                            this._error = "error: opcode requires version 2.";
                            break;
                        }
                        if (loc13.flags & OP_VERT_ONLY && loc2) 
                        {
                            this._error = "error: opcode is only allowed in vertex programs.";
                            break;
                        }
                        if (loc13.flags & OP_FRAG_ONLY && !loc2) 
                        {
                            this._error = "error: opcode is only allowed in fragment programs.";
                            break;
                        }
                        if (this.verbose) 
                        {
                            trace("emit opcode=" + loc13);
                        }
                        this.agalcode.writeUnsignedInt(loc13.emitCode);
                        ++loc5;
                        if (loc5 > MAX_OPCODES) 
                        {
                            this._error = "error: too many opcodes. maximum is " + MAX_OPCODES + ".";
                            break;
                        }
                        loc14 = loc8.match(new RegExp("vc\\[([vof][acostdip]?)(\\d*)?(\\.[xyzw](\\+\\d{1,3})?)?\\](\\.[xyzw]{1,4})?|([vof][acostdip]?)(\\d*)?(\\.[xyzw]{1,4})?", "gi"));
                        if (!loc14 || !(loc14.length == loc13.numRegister)) 
                        {
                            this._error = "error: wrong number of operands. found " + loc14.length + " but expected " + loc13.numRegister + ".";
                            break;
                        }
                        loc15 = false;
                        loc16 = 64 + 64 + 32;
                        loc17 = loc14.length;
                        loc18 = 0;
                        while (loc18 < loc17) 
                        {
                            loc19 = false;
                            loc20 = loc14[loc18].match(new RegExp("\\[.*\\]", "ig"));
                            if (loc20 && loc20.length > 0) 
                            {
                                loc14[loc18] = loc14[loc18].replace(loc20[0], "0");
                                if (this.verbose) 
                                {
                                    trace("IS REL");
                                }
                                loc19 = true;
                            }
                            loc21 = loc14[loc18].match(new RegExp("^\\b[A-Za-z]{1,2}", "ig"));
                            if (!loc21) 
                            {
                                this._error = "error: could not parse operand " + loc18 + " (" + loc14[loc18] + ").";
                                loc15 = true;
                                break;
                            }
                            loc22 = REGMAP[loc21[0]];
                            if (this.debugEnabled) 
                            {
                                trace(loc22);
                            }
                            if (loc22 == null) 
                            {
                                this._error = "error: could not find register name for operand " + loc18 + " (" + loc14[loc18] + ").";
                                loc15 = true;
                                break;
                            }
                            if (loc2) 
                            {
                                if (!(loc22.flags & REG_FRAG)) 
                                {
                                    this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") only allowed in vertex programs.";
                                    loc15 = true;
                                    break;
                                }
                                if (loc19) 
                                {
                                    this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") relative adressing not allowed in fragment programs.";
                                    loc15 = true;
                                    break;
                                }
                            }
                            else if (!(loc22.flags & REG_VERT)) 
                            {
                                this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") only allowed in fragment programs.";
                                loc15 = true;
                                break;
                            }
                            loc14[loc18] = loc14[loc18].slice(loc14[loc18].search(loc22.name) + loc22.name.length);
                            loc23 = loc19 ? loc20[0].match(new RegExp("\\d+")) : loc14[loc18].match(new RegExp("\\d+"));
                            loc24 = 0;
                            if (loc23) 
                            {
                                loc24 = uint(loc23[0]);
                            }
                            if (loc22.range < loc24) 
                            {
                                this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") index exceeds limit of " + (loc22.range + 1) + ".";
                                loc15 = true;
                                break;
                            }
                            loc25 = 0;
                            loc26 = loc14[loc18].match(new RegExp("(\\.[xyzw]{1,4})"));
                            loc27 = loc18 == 0 && !(loc13.flags & OP_NO_DEST);
                            loc28 = loc18 == 2 && loc13.flags & OP_SPECIAL_TEX;
                            loc29 = 0;
                            loc30 = 0;
                            loc31 = 0;
                            if (loc27 && loc19) 
                            {
                                this._error = "error: relative can not be destination";
                                loc15 = true;
                                break;
                            }
                            if (loc26) 
                            {
                                loc25 = 0;
                                loc33 = loc26[0].length;
                                loc34 = 1;
                                while (loc34 < loc33) 
                                {
                                    loc32 = loc26[0].charCodeAt(loc34) - "x".charCodeAt(0);
                                    if (loc32 > 2) 
                                    {
                                        loc32 = 3;
                                    }
                                    if (loc27) 
                                    {
                                        loc25 = loc25 | 1 << loc32;
                                    }
                                    else 
                                    {
                                        loc25 = loc25 | loc32 << (loc34 - 1) << 1;
                                    }
                                    ++loc34;
                                }
                                if (!loc27) 
                                {
                                    while (loc34 <= 4) 
                                    {
                                        loc25 = loc25 | loc32 << (loc34 - 1) << 1;
                                        ++loc34;
                                    }
                                }
                            }
                            else 
                            {
                                loc25 = loc27 ? 15 : 228;
                            }
                            if (loc19) 
                            {
                                loc35 = loc20[0].match(new RegExp("[A-Za-z]{1,2}", "ig"));
                                loc36 = REGMAP[loc35[0]];
                                if (loc36 == null) 
                                {
                                    this._error = "error: bad index register";
                                    loc15 = true;
                                    break;
                                }
                                loc29 = loc36.emitCode;
                                loc37 = loc20[0].match(new RegExp("(\\.[xyzw]{1,1})"));
                                if (loc37.length == 0) 
                                {
                                    this._error = "error: bad index register select";
                                    loc15 = true;
                                    break;
                                }
                                loc30 = loc37[0].charCodeAt(1) - "x".charCodeAt(0);
                                if (loc30 > 2) 
                                {
                                    loc30 = 3;
                                }
                                loc38 = loc20[0].match(new RegExp("\\+\\d{1,3}", "ig"));
                                if (loc38.length > 0) 
                                {
                                    loc31 = loc38[0];
                                }
                                if (loc31 < 0 || loc31 > 255) 
                                {
                                    this._error = "error: index offset " + loc31 + " out of bounds. [0..255]";
                                    loc15 = true;
                                    break;
                                }
                                if (this.verbose) 
                                {
                                    trace("RELATIVE: type=" + loc29 + "==" + loc35[0] + " sel=" + loc30 + "==" + loc37[0] + " idx=" + loc24 + " offset=" + loc31);
                                }
                            }
                            if (this.verbose) 
                            {
                                trace("  emit argcode=" + loc22 + "[" + loc24 + "][" + loc25 + "]");
                            }
                            if (loc27) 
                            {
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(loc25);
                                this.agalcode.writeByte(loc22.emitCode);
                                loc16 = loc16 - 32;
                            }
                            else if (loc28) 
                            {
                                if (this.verbose) 
                                {
                                    trace("  emit sampler");
                                }
                                loc39 = 5;
                                loc40 = loc11 != null ? loc11.length : 0;
                                loc41 = 0;
                                loc34 = 0;
                                while (loc34 < loc40) 
                                {
                                    if (this.verbose) 
                                    {
                                        trace("    opt: " + loc11[loc34]);
                                    }
                                    loc42 = SAMPLEMAP[loc11[loc34]];
                                    if (loc42 != null) 
                                    {
                                        if (loc42.flag != SAMPLER_SPECIAL_SHIFT) 
                                        {
                                            loc39 = loc39 & ~(15 << loc42.flag);
                                        }
                                        loc39 = loc39 | uint(loc42.mask) << uint(loc42.flag);
                                    }
                                    else 
                                    {
                                        loc41 = Number(loc11[loc34]);
                                        if (this.verbose) 
                                        {
                                            trace("    bias: " + loc41);
                                        }
                                    }
                                    ++loc34;
                                }
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(int(loc41 * 8));
                                this.agalcode.writeByte(0);
                                this.agalcode.writeUnsignedInt(loc39);
                                if (this.verbose) 
                                {
                                    trace("    bits: " + (loc39 - 5));
                                }
                                loc16 = loc16 - 64;
                            }
                            else 
                            {
                                if (loc18 == 0) 
                                {
                                    this.agalcode.writeUnsignedInt(0);
                                    loc16 = loc16 - 32;
                                }
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(loc31);
                                this.agalcode.writeByte(loc25);
                                this.agalcode.writeByte(loc22.emitCode);
                                this.agalcode.writeByte(loc29);
                                this.agalcode.writeShort(loc19 ? loc30 | 1 << 15 : 0);
                                loc16 = loc16 - 64;
                            }
                            ++loc18;
                        }
                        loc18 = 0;
                        while (loc18 < loc16) 
                        {
                            this.agalcode.writeByte(0);
                            loc18 = loc18 + 8;
                        }
                        if (loc15) 
                        {
                            break;
                        }
                    }
                    else if (loc8.length >= 3) 
                    {
                        trace("warning: bad line " + loc6 + ": " + loc3[loc6]);
                    }
                }
                else if (loc8.length >= 3) 
                {
                    trace("warning: bad line " + loc6 + ": " + loc3[loc6]);
                }
                ++loc6;
            }
            if (this._error != "") 
            {
                this._error = this._error + ("\n  at line " + loc6 + " " + loc3[loc6]);
                this.agalcode.length = 0;
                trace(this._error);
            }
            if (this.debugEnabled) 
            {
                loc43 = "generated bytecode:";
                loc44 = this.agalcode.length;
                loc45 = 0;
                while (loc45 < loc44) 
                {
                    if (!(loc45 % 16)) 
                    {
                        loc43 = loc43 + "\n";
                    }
                    if (!(loc45 % 4)) 
                    {
                        loc43 = loc43 + " ";
                    }
                    loc46 = this.agalcode[loc45].toString(16);
                    if (loc46.length < 2) 
                    {
                        loc46 = "0" + loc46;
                    }
                    loc43 = loc43 + loc46;
                    ++loc45;
                }
                trace(loc43);
            }
            if (this.verbose) 
            {
                trace("AGALMiniAssembler.assemble time: " + (flash.utils.getTimer() - loc1) / 1000 + "s");
            }
            return this.agalcode;
        }

        internal function initregmap(arg1:uint, arg2:Boolean):void
        {
            REGMAP[VA] = new Register(VA, "vertex attribute", 0, arg2 ? 1024 : arg1 == 1 || arg1 == 2 ? 7 : 15, REG_VERT | REG_READ);
            REGMAP[VC] = new Register(VC, "vertex constant", 1, arg2 ? 1024 : arg1 != 1 ? 249 : 127, REG_VERT | REG_READ);
            REGMAP[VT] = new Register(VT, "vertex temporary", 2, arg2 ? 1024 : arg1 != 1 ? 25 : 7, REG_VERT | REG_WRITE | REG_READ);
            REGMAP[VO] = new Register(VO, "vertex output", 3, arg2 ? 1024 : 0, REG_VERT | REG_WRITE);
            REGMAP[VI] = new Register(VI, "varying", 4, arg2 ? 1024 : arg1 != 1 ? 9 : 7, REG_VERT | REG_FRAG | REG_READ | REG_WRITE);
            REGMAP[FC] = new Register(FC, "fragment constant", 1, arg2 ? 1024 : arg1 != 1 ? arg1 != 2 ? 199 : 63 : 27, REG_FRAG | REG_READ);
            REGMAP[FT] = new Register(FT, "fragment temporary", 2, arg2 ? 1024 : arg1 != 1 ? 25 : 7, REG_FRAG | REG_WRITE | REG_READ);
            REGMAP[FS] = new Register(FS, "texture sampler", 5, arg2 ? 1024 : 7, REG_FRAG | REG_READ);
            REGMAP[FO] = new Register(FO, "fragment output", 3, arg2 ? 1024 : arg1 != 1 ? 3 : 0, REG_FRAG | REG_WRITE);
            REGMAP[FD] = new Register(FD, "fragment depth output", 6, arg2 ? 1024 : arg1 != 1 ? 0 : -1, REG_FRAG | REG_WRITE);
            REGMAP["op"] = REGMAP[VO];
            REGMAP["i"] = REGMAP[VI];
            REGMAP["v"] = REGMAP[VI];
            REGMAP["oc"] = REGMAP[FO];
            REGMAP["od"] = REGMAP[FD];
            REGMAP["fi"] = REGMAP[VI];
            return;
        }

        internal static function init():void
        {
            initialized = true;
            OPMAP[MOV] = new OpCode(MOV, 2, 0, 0);
            OPMAP[ADD] = new OpCode(ADD, 3, 1, 0);
            OPMAP[SUB] = new OpCode(SUB, 3, 2, 0);
            OPMAP[MUL] = new OpCode(MUL, 3, 3, 0);
            OPMAP[DIV] = new OpCode(DIV, 3, 4, 0);
            OPMAP[RCP] = new OpCode(RCP, 2, 5, 0);
            OPMAP[MIN] = new OpCode(MIN, 3, 6, 0);
            OPMAP[MAX] = new OpCode(MAX, 3, 7, 0);
            OPMAP[FRC] = new OpCode(FRC, 2, 8, 0);
            OPMAP[SQT] = new OpCode(SQT, 2, 9, 0);
            OPMAP[RSQ] = new OpCode(RSQ, 2, 10, 0);
            OPMAP[POW] = new OpCode(POW, 3, 11, 0);
            OPMAP[LOG] = new OpCode(LOG, 2, 12, 0);
            OPMAP[EXP] = new OpCode(EXP, 2, 13, 0);
            OPMAP[NRM] = new OpCode(NRM, 2, 14, 0);
            OPMAP[SIN] = new OpCode(SIN, 2, 15, 0);
            OPMAP[COS] = new OpCode(COS, 2, 16, 0);
            OPMAP[CRS] = new OpCode(CRS, 3, 17, 0);
            OPMAP[DP3] = new OpCode(DP3, 3, 18, 0);
            OPMAP[DP4] = new OpCode(DP4, 3, 19, 0);
            OPMAP[ABS] = new OpCode(ABS, 2, 20, 0);
            OPMAP[NEG] = new OpCode(NEG, 2, 21, 0);
            OPMAP[SAT] = new OpCode(SAT, 2, 22, 0);
            OPMAP[M33] = new OpCode(M33, 3, 23, OP_SPECIAL_MATRIX);
            OPMAP[M44] = new OpCode(M44, 3, 24, OP_SPECIAL_MATRIX);
            OPMAP[M34] = new OpCode(M34, 3, 25, OP_SPECIAL_MATRIX);
            OPMAP[DDX] = new OpCode(DDX, 2, 26, OP_VERSION2 | OP_FRAG_ONLY);
            OPMAP[DDY] = new OpCode(DDY, 2, 27, OP_VERSION2 | OP_FRAG_ONLY);
            OPMAP[IFE] = new OpCode(IFE, 2, 28, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[INE] = new OpCode(INE, 2, 29, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[IFG] = new OpCode(IFG, 2, 30, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[IFL] = new OpCode(IFL, 2, 31, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[ELS] = new OpCode(ELS, 0, 32, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_DECNEST | OP_SCALAR);
            OPMAP[EIF] = new OpCode(EIF, 0, 33, OP_NO_DEST | OP_VERSION2 | OP_DECNEST | OP_SCALAR);
            OPMAP[KIL] = new OpCode(KIL, 1, 39, OP_NO_DEST | OP_FRAG_ONLY);
            OPMAP[TEX] = new OpCode(TEX, 3, 40, OP_FRAG_ONLY | OP_SPECIAL_TEX);
            OPMAP[SGE] = new OpCode(SGE, 3, 41, 0);
            OPMAP[SLT] = new OpCode(SLT, 3, 42, 0);
            OPMAP[SGN] = new OpCode(SGN, 2, 43, 0);
            OPMAP[SEQ] = new OpCode(SEQ, 3, 44, 0);
            OPMAP[SNE] = new OpCode(SNE, 3, 45, 0);
            SAMPLEMAP[RGBA] = new Sampler(RGBA, SAMPLER_TYPE_SHIFT, 0);
            SAMPLEMAP[DXT1] = new Sampler(DXT1, SAMPLER_TYPE_SHIFT, 1);
            SAMPLEMAP[DXT5] = new Sampler(DXT5, SAMPLER_TYPE_SHIFT, 2);
            SAMPLEMAP[VIDEO] = new Sampler(VIDEO, SAMPLER_TYPE_SHIFT, 3);
            SAMPLEMAP[D2] = new Sampler(D2, SAMPLER_DIM_SHIFT, 0);
            SAMPLEMAP[D3] = new Sampler(D3, SAMPLER_DIM_SHIFT, 2);
            SAMPLEMAP[CUBE] = new Sampler(CUBE, SAMPLER_DIM_SHIFT, 1);
            SAMPLEMAP[MIPNEAREST] = new Sampler(MIPNEAREST, SAMPLER_MIPMAP_SHIFT, 1);
            SAMPLEMAP[MIPLINEAR] = new Sampler(MIPLINEAR, SAMPLER_MIPMAP_SHIFT, 2);
            SAMPLEMAP[MIPNONE] = new Sampler(MIPNONE, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NOMIP] = new Sampler(NOMIP, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NEAREST] = new Sampler(NEAREST, SAMPLER_FILTER_SHIFT, 0);
            SAMPLEMAP[LINEAR] = new Sampler(LINEAR, SAMPLER_FILTER_SHIFT, 1);
            SAMPLEMAP[ANISOTROPIC2X] = new Sampler(ANISOTROPIC2X, SAMPLER_FILTER_SHIFT, 2);
            SAMPLEMAP[ANISOTROPIC4X] = new Sampler(ANISOTROPIC4X, SAMPLER_FILTER_SHIFT, 3);
            SAMPLEMAP[ANISOTROPIC8X] = new Sampler(ANISOTROPIC8X, SAMPLER_FILTER_SHIFT, 4);
            SAMPLEMAP[ANISOTROPIC16X] = new Sampler(ANISOTROPIC16X, SAMPLER_FILTER_SHIFT, 5);
            SAMPLEMAP[CENTROID] = new Sampler(CENTROID, SAMPLER_SPECIAL_SHIFT, 1 << 0);
            SAMPLEMAP[SINGLE] = new Sampler(SINGLE, SAMPLER_SPECIAL_SHIFT, 1 << 1);
            SAMPLEMAP[IGNORESAMPLER] = new Sampler(IGNORESAMPLER, SAMPLER_SPECIAL_SHIFT, 1 << 2);
            SAMPLEMAP[REPEAT] = new Sampler(REPEAT, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[WRAP] = new Sampler(WRAP, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[CLAMP] = new Sampler(CLAMP, SAMPLER_REPEAT_SHIFT, 0);
            SAMPLEMAP[CLAMP_U_REPEAT_V] = new Sampler(CLAMP_U_REPEAT_V, SAMPLER_REPEAT_SHIFT, 2);
            SAMPLEMAP[REPEAT_U_CLAMP_V] = new Sampler(REPEAT_U_CLAMP_V, SAMPLER_REPEAT_SHIFT, 3);
            return;
        }

        
        {
            initialized = false;
        }

        public function get error():String
        {
            return this._error;
        }

        public function get agalcode():flash.utils.ByteArray
        {
            return this._agalcode;
        }

        public function assemble2(arg1:flash.display3D.Context3D, arg2:uint, arg3:String, arg4:String):flash.display3D.Program3D
        {
            var loc1:*=this.assemble(VERTEX, arg3, arg2);
            var loc2:*=this.assemble(FRAGMENT, arg4, arg2);
            var loc3:*=arg1.createProgram();
            loc3.upload(loc1, loc2);
            return loc3;
        }

        internal static const DXT1:String="dxt1";

        internal static const DXT5:String="dxt5";

        internal static const VIDEO:String="video";

        internal static const ANISOTROPIC8X:String="anisotropic8x";

        protected static const REGEXP_OUTER_SPACES:RegExp=new RegExp("^\\s+|\\s+$", "g");

        internal static const OPMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const REGMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const SAMPLEMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const MAX_NESTING:int=4;

        internal static const MAX_OPCODES:int=2048;

        internal static const FRAGMENT:String="fragment";

        internal static const VERTEX:String="vertex";

        internal static const SAMPLER_TYPE_SHIFT:uint=8;

        internal static const SAMPLER_DIM_SHIFT:uint=12;

        internal static const SAMPLER_SPECIAL_SHIFT:uint=16;

        internal static const SAMPLER_REPEAT_SHIFT:uint=20;

        internal static const SAMPLER_MIPMAP_SHIFT:uint=24;

        internal static const SAMPLER_FILTER_SHIFT:uint=28;

        internal static const REG_WRITE:uint=1;

        internal static const REG_READ:uint=2;

        internal static const REG_FRAG:uint=32;

        internal static const REG_VERT:uint=64;

        internal static const OP_SCALAR:uint=1;

        internal static const OP_SPECIAL_TEX:uint=8;

        internal static const OP_SPECIAL_MATRIX:uint=16;

        internal static const OP_FRAG_ONLY:uint=32;

        internal static const OP_VERT_ONLY:uint=64;

        internal static const OP_NO_DEST:uint=128;

        internal static const OP_VERSION2:uint=256;

        internal static const OP_INCNEST:uint=512;

        internal static const OP_DECNEST:uint=1024;

        internal static const MOV:String="mov";

        internal static const ADD:String="add";

        internal static const SUB:String="sub";

        internal static const MUL:String="mul";

        internal static const DIV:String="div";

        internal static const RCP:String="rcp";

        internal static const MIN:String="min";

        internal static const MAX:String="max";

        internal static const FRC:String="frc";

        internal static const SQT:String="sqt";

        internal static const RSQ:String="rsq";

        internal static const POW:String="pow";

        internal static const LOG:String="log";

        internal static const EXP:String="exp";

        internal static const NRM:String="nrm";

        internal static const SIN:String="sin";

        internal static const COS:String="cos";

        internal static const CRS:String="crs";

        internal static const DP3:String="dp3";

        internal static const DP4:String="dp4";

        internal static const ABS:String="abs";

        internal static const NEG:String="neg";

        internal static const SAT:String="sat";

        internal static const M33:String="m33";

        internal static const M44:String="m44";

        internal static const M34:String="m34";

        internal static const DDX:String="ddx";

        internal static const DDY:String="ddy";

        internal static const IFE:String="ife";

        internal static const INE:String="ine";

        internal static const IFG:String="ifg";

        internal static const IFL:String="ifl";

        internal static const ELS:String="els";

        internal static const EIF:String="eif";

        internal static const TED:String="ted";

        internal static const KIL:String="kil";

        internal static const TEX:String="tex";

        internal static const SGE:String="sge";

        internal static const SLT:String="slt";

        internal static const SGN:String="sgn";

        internal static const SEQ:String="seq";

        internal static const SNE:String="sne";

        internal static const VA:String="va";

        internal static const VC:String="vc";

        internal static const VT:String="vt";

        internal static const VO:String="vo";

        internal static const VI:String="vi";

        internal static const FC:String="fc";

        internal static const FT:String="ft";

        internal static const FO:String="fo";

        internal static const FD:String="fd";

        internal static const D2:String="2d";

        internal static const D3:String="3d";

        internal static const CUBE:String="cube";

        internal static const MIPNEAREST:String="mipnearest";

        internal static const MIPLINEAR:String="miplinear";

        internal static const MIPNONE:String="mipnone";

        internal static const NOMIP:String="nomip";

        internal static const NEAREST:String="nearest";

        internal static const LINEAR:String="linear";

        internal static const ANISOTROPIC2X:String="anisotropic2x";

        internal static const ANISOTROPIC4X:String="anisotropic4x";

        internal static const FS:String="fs";

        internal static const ANISOTROPIC16X:String="anisotropic16x";

        internal static const CENTROID:String="centroid";

        internal static const SINGLE:String="single";

        internal static const IGNORESAMPLER:String="ignoresampler";

        internal static const REPEAT:String="repeat";

        internal static const WRAP:String="wrap";

        internal static const CLAMP:String="clamp";

        internal static const REPEAT_U_CLAMP_V:String="repeat_u_clamp_v";

        internal static const CLAMP_U_REPEAT_V:String="clamp_u_repeat_v";

        internal static const RGBA:String="rgba";

        internal var _agalcode:flash.utils.ByteArray=null;

        internal var _error:String="";

        internal var debugEnabled:Boolean=false;

        public var verbose:Boolean=false;

        internal static var initialized:Boolean=false;
    }
}


class OpCode extends Object
{
    public function OpCode(arg1:String, arg2:uint, arg3:uint, arg4:uint)
    {
        super();
        this._name = arg1;
        this._numRegister = arg2;
        this._emitCode = arg3;
        this._flags = arg4;
        return;
    }

    public function get emitCode():uint
    {
        return this._emitCode;
    }

    public function get flags():uint
    {
        return this._flags;
    }

    public function get name():String
    {
        return this._name;
    }

    public function get numRegister():uint
    {
        return this._numRegister;
    }

    public function toString():String
    {
        return "[OpCode name=\"" + this._name + "\", numRegister=" + this._numRegister + ", emitCode=" + this._emitCode + ", flags=" + this._flags + "]";
    }

    internal var _emitCode:uint;

    internal var _flags:uint;

    internal var _name:String;

    internal var _numRegister:uint;
}

class Register extends Object
{
    public function Register(arg1:String, arg2:String, arg3:uint, arg4:uint, arg5:uint)
    {
        super();
        this._name = arg1;
        this._longName = arg2;
        this._emitCode = arg3;
        this._range = arg4;
        this._flags = arg5;
        return;
    }

    public function get emitCode():uint
    {
        return this._emitCode;
    }

    public function get longName():String
    {
        return this._longName;
    }

    public function get name():String
    {
        return this._name;
    }

    public function get flags():uint
    {
        return this._flags;
    }

    public function get range():uint
    {
        return this._range;
    }

    public function toString():String
    {
        return "[Register name=\"" + this._name + "\", longName=\"" + this._longName + "\", emitCode=" + this._emitCode + ", range=" + this._range + ", flags=" + this._flags + "]";
    }

    internal var _emitCode:uint;

    internal var _name:String;

    internal var _longName:String;

    internal var _flags:uint;

    internal var _range:uint;
}

class Sampler extends Object
{
    public function Sampler(arg1:String, arg2:uint, arg3:uint)
    {
        super();
        this._name = arg1;
        this._flag = arg2;
        this._mask = arg3;
        return;
    }

    public function get flag():uint
    {
        return this._flag;
    }

    public function get mask():uint
    {
        return this._mask;
    }

    public function get name():String
    {
        return this._name;
    }

    public function toString():String
    {
        return "[Sampler name=\"" + this._name + "\", flag=\"" + this._flag + "\", mask=" + this.mask + "]";
    }

    internal var _flag:uint;

    internal var _mask:uint;

    internal var _name:String;
}

//    class StringUtil
package com.adobe.utils 
{
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            return;
        }

        public static function stringsAreEqual(arg1:String, arg2:String, arg3:Boolean):Boolean
        {
            if (arg3) 
            {
                return arg1 == arg2;
            }
            return arg1.toUpperCase() == arg2.toUpperCase();
        }

        public static function trim(arg1:String):String
        {
            return StringUtil.ltrim(StringUtil.rtrim(arg1));
        }

        public static function ltrim(arg1:String):String
        {
            var loc2:*=NaN;
            var loc1:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1.charCodeAt(loc2) > 32) 
                {
                    return arg1.substring(loc2);
                }
                ++loc2;
            }
            return "";
        }

        public static function rtrim(arg1:String):String
        {
            var loc2:*=NaN;
            var loc1:*=arg1.length;
            loc2 = loc1;
            while (loc2 > 0) 
            {
                if (arg1.charCodeAt((loc2 - 1)) > 32) 
                {
                    return arg1.substring(0, loc2);
                }
                --loc2;
            }
            return "";
        }

        public static function beginsWith(arg1:String, arg2:String):Boolean
        {
            return arg2 == arg1.substring(0, arg2.length);
        }

        public static function endsWith(arg1:String, arg2:String):Boolean
        {
            return arg2 == arg1.substring(arg1.length - arg2.length);
        }

        public static function remove(arg1:String, arg2:String):String
        {
            return StringUtil.replace(arg1, arg2, "");
        }

        public static function replace(arg1:String, arg2:String, arg3:String):String
        {
            return arg1.split(arg2).join(arg3);
        }

        public static function stringHasValue(arg1:String):Boolean
        {
            return !(arg1 == null) && arg1.length > 0;
        }
    }
}


