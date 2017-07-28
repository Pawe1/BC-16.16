//class GVSocialServiceType
package com.milkmangames.nativeextensions 
{
    public class GVSocialServiceType extends Object
    {
        public function GVSocialServiceType()
        {
            super();
            return;
        }

        public static function decode(arg1:String):String
        {
            var loc1:*=arg1.toUpperCase();
            if (loc1.indexOf("FACEB") > -1) 
            {
                return FACEBOOK;
            }
            if (loc1.indexOf("TWITT") > -1) 
            {
                return TWITTER;
            }
            if (loc1.indexOf("SINA") > -1) 
            {
                return SINAWEIBO;
            }
            return arg1;
        }

        public static const TWITTER:String="TWITTER";

        public static const FACEBOOK:String="FACEBOOK";

        public static const SINAWEIBO:String="SINAWEIBO";

        public static const SMS:String="SMS";
    }
}


