//class StringUtil
package starling.utils 
{
    import starling.errors.*;
    
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function format(arg1:String, ... rest):String
        {
            var loc1:*=0;
            while (loc1 < rest.length) 
            {
                arg1 = arg1.replace(new RegExp("\\{" + loc1 + "\\}", "g"), rest[loc1]);
                ++loc1;
            }
            return arg1;
        }

        public static function clean(arg1:String):String
        {
            return ("_" + arg1).substr(1);
        }

        public static function trimStart(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            return arg1.substring(loc1, loc2);
        }

        public static function trimEnd(arg1:String):String
        {
            var loc1:*=(arg1.length - 1);
            while (loc1 >= 0) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                --loc1;
            }
            return arg1.substring(0, loc1 + 1);
        }

        public static function trim(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            loc2 = (arg1.length - 1);
            while (loc2 >= loc1) 
            {
                if (arg1.charCodeAt(loc2) > 32) 
                {
                    break;
                }
                --loc2;
            }
            return arg1.substring(loc1, loc2 + 1);
        }
    }
}


