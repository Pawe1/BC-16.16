//package grant
//  class AuthorizationCodeGrant
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


//  class IGrantType
package com.adobe.protocols.oauth2.grant 
{
    public dynamic interface IGrantType
    {
        function get clientId():String;
    }
}


//  class ImplicitGrant
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


//  class ResourceOwnerCredentialsGrant
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


