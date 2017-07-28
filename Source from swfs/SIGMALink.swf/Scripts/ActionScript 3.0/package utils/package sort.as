//package sort
//  class SortUtil
package utils.sort 
{
    public class SortUtil extends Object
    {
        public function SortUtil()
        {
            super();
            return;
        }

        public static function sortOnString(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3].toLowerCase();
            var loc4:*=arg2[arg3].toLowerCase();
            var loc2:*=loc1 < loc4 ? 0 : 1;
            var loc3:*=loc1 < loc4 ? 1 : 0;
            return doNumberSort(loc2, loc3, arg4);
        }

        public static function sortOnDate(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=(arg1[arg3] as Date).time;
            var loc2:*=(arg2[arg3] as Date).time;
            return doNumberSort(loc1, loc2, arg4);
        }

        public static function sortOnNumber(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3];
            var loc2:*=arg2[arg3];
            return doNumberSort(loc1, loc2, arg4);
        }

        public static function sortOnBool(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3];
            var loc3:*=arg2[arg3];
            var loc4:*=loc1 ? 1 : 0;
            var loc2:*=loc3 ? 1 : 0;
            return doNumberSort(loc4, loc2, arg4);
        }

        public static function sortOnTwoNumberFields(arg1:Object, arg2:Object, arg3:String, arg4:String, arg5:Boolean=false):Number
        {
            var loc1:*;
            return (loc1 = sortOnNumber(arg1, arg2, arg3, arg5)) != 0 ? loc1 : sortOnNumber(arg1, arg2, arg4, arg5);
        }

        public static function doNumberSort(arg1:Number, arg2:Number, arg3:Boolean):Number
        {
            if (arg3) 
            {
                if (arg1 < arg2) 
                {
                    return 1;
                }
                if (arg1 > arg2) 
                {
                    return -1;
                }
            }
            else 
            {
                if (arg1 < arg2) 
                {
                    return -1;
                }
                if (arg1 > arg2) 
                {
                    return 1;
                }
            }
            return 0;
        }
    }
}


