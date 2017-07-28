//class GVFacebookDialogMode
package com.milkmangames.nativeextensions 
{
    public class GVFacebookDialogMode extends Object
    {
        public function GVFacebookDialogMode()
        {
            super();
            return;
        }

        static function enumerate(arg1:String):int
        {
            if (arg1 == AUTOMATIC) 
            {
                return 0;
            }
            if (arg1 == WEB) 
            {
                return 2;
            }
            if (arg1 == FEED) 
            {
                return 3;
            }
            if (arg1 == IOS_NATIVE) 
            {
                return 4;
            }
            return 0;
        }

        public static const AUTOMATIC:String="AUTOMATIC";

        public static const WEB:String="WEB";

        public static const FEED:String="FEED";

        public static const IOS_NATIVE:String="IOS_NATIVE";
    }
}


