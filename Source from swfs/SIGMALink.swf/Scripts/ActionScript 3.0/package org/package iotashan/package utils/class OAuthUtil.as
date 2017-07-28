//class OAuthUtil
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


