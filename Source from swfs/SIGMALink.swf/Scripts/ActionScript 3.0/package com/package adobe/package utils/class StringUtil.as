//class StringUtil
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


