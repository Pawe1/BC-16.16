//class OAuthSignatureMethod_HMAC_SHA1
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


