//package oauth2
//  package event
//    class GetAccessTokenEvent
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


//    class IOAuth2Event
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


//    class OAut2ProgressEvent
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


//    class RefreshAccessTokenEvent
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


//  package grant
//    class AuthorizationCodeGrant
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


//    class IGrantType
package com.adobe.protocols.oauth2.grant 
{
    public dynamic interface IGrantType
    {
        function get clientId():String;
    }
}


//    class ImplicitGrant
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


//    class ResourceOwnerCredentialsGrant
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


//  class OAuth2
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


//  class OAuth2Const
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


