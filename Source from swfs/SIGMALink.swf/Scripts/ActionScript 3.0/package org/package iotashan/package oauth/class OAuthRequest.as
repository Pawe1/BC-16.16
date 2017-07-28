//class OAuthRequest
package org.iotashan.oauth 
{
    import flash.net.*;
    import org.iotashan.utils.*;
    
    public class OAuthRequest extends Object
    {
        public function OAuthRequest(arg1:String, arg2:String, arg3:Object=null, arg4:org.iotashan.oauth.OAuthConsumer=null, arg5:org.iotashan.oauth.OAuthToken=null)
        {
            super();
            _httpMethod = arg1;
            _requestURL = arg2;
            if (!arg3) 
            {
                arg3 = {};
            }
            _requestParams = arg3;
            _consumer = arg4;
            _token = arg5;
            return;
        }

        public function get consumer():org.iotashan.oauth.OAuthConsumer
        {
            return _consumer;
        }

        public function set consumer(arg1:org.iotashan.oauth.OAuthConsumer):void
        {
            _consumer = arg1;
            return;
        }

        public function get httpMethod():String
        {
            return _httpMethod;
        }

        public function set httpMethod(arg1:String):void
        {
            if (arg1 != _httpMethod) 
            {
                _httpMethod = arg1;
            }
            return;
        }

        public function get requestParams():Object
        {
            return _requestParams;
        }

        public function set requestParams(arg1:Object):void
        {
            if (arg1 != _requestParams) 
            {
                _requestParams = arg1;
            }
            return;
        }

        public function get requestURL():String
        {
            return _requestURL;
        }

        public function set requestURL(arg1:String):void
        {
            if (arg1 != _requestURL) 
            {
                _requestURL = arg1;
            }
            return;
        }

        public function get token():org.iotashan.oauth.OAuthToken
        {
            return _token;
        }

        public function set token(arg1:org.iotashan.oauth.OAuthToken):void
        {
            _token = arg1;
            return;
        }

        public function buildRequest(arg1:org.iotashan.oauth.IOAuthSignatureMethod, arg2:String="url", arg3:String=""):*
        {
            var loc1:*=false;
            var loc4:*=null;
            var loc6:*=null;
            var loc2:*=null;
            var loc7:*=null;
            var loc8:*=new Date();
            var loc9:*=org.iotashan.utils.UIDUtil.getUID(loc8);
            _requestParams["oauth_nonce"] = loc9;
            _requestParams["oauth_timestamp"] = loc8.time.substring(0, 10);
            _requestParams["oauth_consumer_key"] = _consumer.key;
            _requestParams["oauth_signature_method"] = arg1.name;
            if (_token) 
            {
                _requestParams["oauth_token"] = _token.key;
            }
            else if (_requestParams.hasOwnProperty("oauth_token")) 
            {
                loc1 = delete _requestParams.oauth_token;
            }
            var loc3:*=arg1.signRequest(this);
            _requestParams["oauth_signature"] = loc3;
            var loc11:*=arg2;
            while ("url" === loc11) 
            {
                return loc4 = _requestURL + "?" + getParameters();
            }
        }

        internal function getSignableParameters():String
        {
            var loc2:*=[];
            var loc4:*=0;
            var loc3:*=_requestParams;
            for (var loc1:* in loc3) 
            {
                if (loc1 == "oauth_signature") 
                {
                    continue;
                }
                loc2.push(loc1 + "=" + org.iotashan.utils.URLEncoding.encode(_requestParams[loc1].toString()));
            }
            loc2.sort();
            return loc2.join("&");
        }

        internal function getParameters():String
        {
            var loc2:*=[];
            var loc4:*=0;
            var loc3:*=_requestParams;
            for (var loc1:* in loc3) 
            {
                loc2.push(loc1 + "=" + org.iotashan.utils.URLEncoding.encode(_requestParams[loc1].toString()));
            }
            loc2.sort();
            return loc2.join("&");
        }

        public function getSignableString():String
        {
            var loc1:*=org.iotashan.utils.URLEncoding.encode(_httpMethod.toUpperCase());
            loc1 = loc1 + "&";
            loc1 = loc1 + org.iotashan.utils.URLEncoding.encode(_requestURL);
            loc1 = loc1 + "&";
            loc1 = loc1 + org.iotashan.utils.URLEncoding.encode(getSignableParameters());
            return loc1;
        }

        public static const HTTP_MEHTOD_GET:String="GET";

        public static const HTTP_MEHTOD_HEAD:String="HEAD";

        public static const HTTP_MEHTOD_POST:String="POST";

        public static const RESULT_TYPE_HEADER:String="header";

        public static const RESULT_TYPE_POST:String="post";

        public static const RESULT_TYPE_URL_STRING:String="url";

        internal var _consumer:org.iotashan.oauth.OAuthConsumer;

        internal var _httpMethod:String;

        internal var _requestParams:Object;

        internal var _requestURL:String;

        internal var _token:org.iotashan.oauth.OAuthToken;
    }
}


