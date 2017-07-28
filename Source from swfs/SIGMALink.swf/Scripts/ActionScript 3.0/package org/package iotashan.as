//package iotashan
//  package oauth
//    class IOAuthSignatureMethod
package org.iotashan.oauth 
{
    public dynamic interface IOAuthSignatureMethod
    {
        function get name():String;

        function signRequest(arg1:org.iotashan.oauth.OAuthRequest):String;
    }
}


//    class OAuthConsumer
package org.iotashan.oauth 
{
    public class OAuthConsumer extends Object
    {
        public function OAuthConsumer(arg1:String="", arg2:String="")
        {
            super();
            _key = arg1;
            _secret = arg2;
            return;
        }

        public function get key():String
        {
            return _key;
        }

        public function set key(arg1:String):void
        {
            if (arg1 != _key) 
            {
                _key = arg1;
            }
            return;
        }

        public function get secret():String
        {
            return _secret;
        }

        public function set secret(arg1:String):void
        {
            if (arg1 != _secret) 
            {
                _secret = arg1;
            }
            return;
        }

        public function get isEmpty():Boolean
        {
            if (key.length == 0 && secret.length == 0) 
            {
                return true;
            }
            return false;
        }

        internal var _key:String;

        internal var _secret:String;
    }
}


//    class OAuthRequest
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


//    class OAuthSignatureMethod_HMAC_SHA1
package org.iotashan.oauth 
{
    import com.hurlant.crypto.*;
    import com.hurlant.crypto.hash.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    import org.iotashan.utils.*;
    
    public class OAuthSignatureMethod_HMAC_SHA1 extends Object implements org.iotashan.oauth.IOAuthSignatureMethod
    {
        public function OAuthSignatureMethod_HMAC_SHA1()
        {
            super();
            return;
        }

        public function get name():String
        {
            return "HMAC-SHA1";
        }

        public function signRequest(arg1:org.iotashan.oauth.OAuthRequest):String
        {
            var loc4:*=arg1.getSignableString();
            var loc5:*=org.iotashan.utils.URLEncoding.encode(arg1.consumer.secret) + "&";
            if (arg1.token) 
            {
                loc5 = loc5 + org.iotashan.utils.URLEncoding.encode(arg1.token.secret);
            }
            var loc3:*=com.hurlant.crypto.Crypto.getHMAC("sha1");
            var loc7:*=com.hurlant.util.Hex.toArray(com.hurlant.util.Hex.fromString(loc5));
            var loc6:*=com.hurlant.util.Hex.toArray(com.hurlant.util.Hex.fromString(loc4));
            var loc1:*=loc3.compute(loc7, loc6);
            var loc2:*=com.hurlant.util.Base64.encodeByteArray(loc1);
            return loc2;
        }
    }
}


//    class OAuthToken
package org.iotashan.oauth 
{
    public class OAuthToken extends Object
    {
        public function OAuthToken(arg1:String="", arg2:String="")
        {
            super();
            _key = arg1;
            _secret = arg2;
            return;
        }

        public function get key():String
        {
            return _key;
        }

        public function set key(arg1:String):void
        {
            if (arg1 != _key) 
            {
                _key = arg1;
            }
            return;
        }

        public function get secret():String
        {
            return _secret;
        }

        public function set secret(arg1:String):void
        {
            if (arg1 != _secret) 
            {
                _secret = arg1;
            }
            return;
        }

        public function get isEmpty():Boolean
        {
            if (key.length == 0 && secret.length == 0) 
            {
                return true;
            }
            return false;
        }

        internal var _key:String;

        internal var _secret:String;
    }
}


//  package utils
//    class OAuthUtil
package org.iotashan.utils 
{
    import org.iotashan.oauth.*;
    
    public class OAuthUtil extends Object
    {
        public function OAuthUtil()
        {
            super();
            return;
        }

        public static function getTokenFromResponse(arg1:String):org.iotashan.oauth.OAuthToken
        {
            var loc3:*=null;
            var loc1:*=new org.iotashan.oauth.OAuthToken();
            var loc4:*=arg1.split("&");
            var loc6:*=0;
            var loc5:*=loc4;
            for each (var loc2:* in loc5) 
            {
                if ((loc3 = loc2.split("=")).length != 2) 
                {
                    continue;
                }
                if (loc3[0] == "oauth_token") 
                {
                    loc1.key = loc3[1];
                    continue;
                }
                if (loc3[0] != "oauth_token_secret") 
                {
                    continue;
                }
                loc1.secret = loc3[1];
            }
            if (!(loc1.key == null) && !(loc1.secret == null)) 
            {
                return loc1;
            }
            return null;
        }
    }
}


//    class UIDUtil
package org.iotashan.utils 
{
    import flash.utils.*;
    import mx.core.*;
    import mx.utils.*;
    
    use namespace mx_internal;
    
    public class UIDUtil extends Object
    {
        public function UIDUtil()
        {
            super();
            return;
        }

        public static function createUID():String
        {
            var loc2:*=0;
            var loc3:*=0;
            UIDBuffer.position = 0;
            loc2 = 0;
            while (loc2 < 8) 
            {
                UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                ++loc2;
            }
            loc2 = 0;
            while (loc2 < 3) 
            {
                UIDBuffer.writeByte(45);
                loc3 = 0;
                while (loc3 < 4) 
                {
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                    ++loc3;
                }
                ++loc2;
            }
            UIDBuffer.writeByte(45);
            var loc4:*;
            var loc1:*=(loc4 = new Date().getTime()).toString(16).toUpperCase();
            loc2 = 8;
            while (loc2 > loc1.length) 
            {
                UIDBuffer.writeByte(48);
                --loc2;
            }
            UIDBuffer.writeUTFBytes(loc1);
            loc2 = 0;
            while (loc2 < 4) 
            {
                UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                ++loc2;
            }
            return UIDBuffer.toString();
        }

        public static function fromByteArray(arg1:flash.utils.ByteArray):String
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=0;
            if (!(arg1 == null) && arg1.length >= 16 && arg1.bytesAvailable >= 16) 
            {
                UIDBuffer.position = 0;
                loc2 = 0;
                loc3 = 0;
                while (loc3 < 16) 
                {
                    if (loc3 == 4 || loc3 == 6 || loc3 == 8 || loc3 == 10) 
                    {
                        UIDBuffer.writeByte(45);
                    }
                    loc1 = arg1.readByte();
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[(loc1 & 240) >>> 4]);
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[loc1 & 15]);
                    ++loc3;
                }
                return UIDBuffer.toString();
            }
            return null;
        }

        public static function isUID(arg1:String):Boolean
        {
            var loc2:*=0;
            var loc1:*=NaN;
            if (!(arg1 == null) && arg1.length == 36) 
            {
                loc2 = 0;
                while (loc2 < 36) 
                {
                    loc1 = arg1.charCodeAt(loc2);
                    if (loc2 == 8 || loc2 == 13 || loc2 == 18 || loc2 == 23) 
                    {
                        if (loc1 != 45) 
                        {
                            return false;
                        }
                    }
                    else if (loc1 < 48 || loc1 > 70 || loc1 > 57 && loc1 < 65) 
                    {
                        return false;
                    }
                    ++loc2;
                }
                return true;
            }
            return false;
        }

        public static function toByteArray(arg1:String):flash.utils.ByteArray
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=null;
            var loc4:*=0;
            var loc5:*=0;
            if (isUID(arg1)) 
            {
                loc1 = new flash.utils.ByteArray();
                loc3 = 0;
                while (loc3 < arg1.length) 
                {
                    loc2 = arg1.charAt(loc3);
                    if (loc2 != "-") 
                    {
                        loc4 = getDigit(loc2);
                        ++loc3;
                        loc5 = getDigit(arg1.charAt(loc3));
                        loc1.writeByte((loc4 << 4 | loc5) & 255);
                    }
                    ++loc3;
                }
                loc1.position = 0;
                return loc1;
            }
            return null;
        }

        public static function getUID(arg1:Object):String
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=null;
            if (arg1 == null) 
            {
                return loc1;
            }
            if (arg1 is mx.core.IUID) 
            {
                loc1 = mx.core.IUID(arg1).uid;
                if (loc1 == null || loc1.length == 0) 
                {
                    loc1 = createUID();
                    mx.core.IUID(arg1).uid = loc1;
                }
            }
            else if (arg1 is mx.core.IPropertyChangeNotifier && !(arg1 is mx.core.IUIComponent)) 
            {
                loc1 = mx.core.IPropertyChangeNotifier(arg1).uid;
                if (loc1 == null || loc1.length == 0) 
                {
                    loc1 = createUID();
                    mx.core.IPropertyChangeNotifier(arg1).uid = loc1;
                }
            }
            else 
            {
                if (arg1 is String) 
                {
                    return arg1 as String;
                }
                try 
                {
                    if (arg1 is XMLList && arg1.length == 1) 
                    {
                        arg1 = arg1[0];
                    }
                    if (arg1 is XML) 
                    {
                        loc2 = XML(arg1);
                        if ((loc3 = loc2.nodeKind()) == "text" || loc3 == "attribute") 
                        {
                            var loc6:*;
                            return loc6 = loc2.toString();
                        }
                        if (!((loc4 = loc2.notification()) is Function)) 
                        {
                            loc4 = mx.utils.XMLNotifier.mx_internal::initializeXMLForNotification();
                            loc2.setNotification(loc4);
                        }
                        if (loc4["uid"] == undefined) 
                        {
                            var loc7:*;
                            loc4["uid"] = loc7 = createUID();
                            loc1 = loc7;
                        }
                        loc1 = loc4["uid"];
                    }
                    else 
                    {
                        if ("mx_internal_uid" in arg1) 
                        {
                            return loc7 = arg1.mx_internal_uid;
                        }
                        if ("uid" in arg1) 
                        {
                            var loc8:*;
                            return loc8 = arg1.uid;
                        }
                        loc1 = uidDictionary[arg1];
                        if (!loc1) 
                        {
                            loc1 = createUID();
                            try 
                            {
                                arg1.mx_internal_uid = loc1;
                            }
                            catch (e:Error)
                            {
                                uidDictionary[arg1] = loc1;
                            }
                        }
                    }
                }
                catch (e:Error)
                {
                    loc1 = arg1.toString();
                }
            }
            return loc1;
        }

        internal static function getDigit(arg1:String):uint
        {
            var loc1:*=arg1;
            while ("A" === loc1) 
            {
                return 10;
                return 11;
                return 12;
                return 13;
                return 14;
                return 15;
                return new uint(arg1);
            }
        }

        
        {
            uidDictionary = new flash.utils.Dictionary(true);
        }

        internal static const ALPHA_CHAR_CODES:Array=[48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];

        internal static const DASH:int=45;

        internal static const UIDBuffer:flash.utils.ByteArray=new flash.utils.ByteArray();

        internal static var uidDictionary:flash.utils.Dictionary;
    }
}


//    class URLEncoding
package org.iotashan.utils 
{
    public class URLEncoding extends Object
    {
        public function URLEncoding()
        {
            super();
            return;
        }

        public static function utf8Encode(arg1:String):String
        {
            var loc1:*=0;
            var loc3:*=NaN;
            arg1 = arg1.replace(new RegExp("\\r\\n", "g"), "\n");
            arg1 = arg1.replace(new RegExp("\\r", "g"), "\n");
            var loc2:*="";
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                if ((loc3 = arg1.charCodeAt(loc1)) < 128) 
                {
                    loc2 = loc2 + String.fromCharCode(loc3);
                }
                else if (loc3 > 127 && loc3 < 2048) 
                {
                    loc2 = loc2 + String.fromCharCode(loc3 >> 6 | 192);
                    loc2 = loc2 + String.fromCharCode(loc3 & 63 | 128);
                }
                else 
                {
                    loc2 = loc2 + String.fromCharCode(loc3 >> 12 | 224);
                    loc2 = loc2 + String.fromCharCode(loc3 >> 6 & 63 | 128);
                    loc2 = loc2 + String.fromCharCode(loc3 & 63 | 128);
                }
                ++loc1;
            }
            return loc2;
        }

        public static function urlEncode(arg1:String):String
        {
            var loc2:*=0;
            var loc3:*=NaN;
            var loc1:*="";
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                if ((loc3 = arg1.charCodeAt(loc2)) >= 48 && loc3 <= 57 || loc3 >= 65 && loc3 <= 90 || loc3 >= 97 && loc3 <= 122 || loc3 == 45 || loc3 == 95 || loc3 == 46 || loc3 == 126) 
                {
                    loc1 = loc1 + String.fromCharCode(loc3);
                }
                else 
                {
                    loc1 = loc1 + ("%" + loc3.toString(16).toUpperCase());
                }
                ++loc2;
            }
            return loc1;
        }

        public static function encode(arg1:String):String
        {
            return urlEncode(utf8Encode(arg1));
        }

        public static function decode(arg1:String):*
        {
            var loc5:*=NaN;
            var loc3:*=null;
            var loc2:*=null;
            var loc1:*=arg1;
            var loc4:*=new RegExp("(%[^%]{2})");
            var loc6:*=new RegExp("\\+", "gm");
            loc1 = loc1.replace(loc6, " ");
            while (!((loc2 = loc4.exec(loc1)) == null) && loc2.length > 1 && !(loc2[1] == "")) 
            {
                loc5 = parseInt(loc2[1].substr(1), 16);
                loc3 = String.fromCharCode(loc5);
                loc1 = loc1.replace(loc2[1], loc3);
            }
            return loc1;
        }
    }
}


