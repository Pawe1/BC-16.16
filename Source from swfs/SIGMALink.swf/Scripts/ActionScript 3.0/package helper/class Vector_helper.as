//class Vector_helper
package helper 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public final class Vector_helper extends Object
    {
        public function Vector_helper()
        {
            super();
            return;
        }

        public static function stringify(arg1:__AS3__.vec.Vector.<int>, arg2:*="|"):String
        {
            if (!arg1) 
            {
                return "";
            }
            var loc1:*="";
            var loc3:*=0;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = loc1 + arg1[loc3];
                if (loc3 + 1 < loc2) 
                {
                    loc1 = loc1 + "|";
                }
                ++loc3;
            }
            return loc1;
        }

        public static function unstringify(arg1:String, arg2:*="|"):__AS3__.vec.Vector.<int>
        {
            if (!arg1) 
            {
                return new __AS3__.vec.Vector.<int>();
            }
            var loc4:*=new __AS3__.vec.Vector.<int>();
            var loc1:*=arg1.split(arg2);
            var loc3:*=0;
            var loc2:*=loc1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4.push(loc1[loc3]);
                ++loc3;
            }
            return loc4;
        }

        public static function getIndicesByFilter(arg1:String, arg2:String, arg3:*="|"):__AS3__.vec.Vector.<int>
        {
            if (!arg1) 
            {
                return new __AS3__.vec.Vector.<int>();
            }
            var loc4:*=new __AS3__.vec.Vector.<int>();
            var loc1:*=arg1.split(arg3);
            var loc3:*=0;
            var loc2:*=loc1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (loc1[loc3] == arg2) 
                {
                    loc4.push(loc3);
                }
                ++loc3;
            }
            return loc4;
        }

        public static function isVector(arg1:*):Boolean
        {
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            return loc1.indexOf("__AS3__.vec::Vector.") >= 0;
        }

        public static function sortVector(arg1:*, arg2:String):void
        {
            var loc1:*=[];
            while (arg1.length > 0) 
            {
                loc1.push(arg1.pop());
            }
            loc1.sortOn(arg2, 16 | 2);
            while (loc1.length > 0) 
            {
                arg1.push(loc1.pop());
            }
            return;
        }

        public static const DEFAULT_DELIMITER:String="|";

        internal static const VECTOR_PREFIX:String="__AS3__.vec::Vector.";
    }
}


