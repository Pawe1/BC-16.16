//class LogEntrySearch
package utils 
{
    import __AS3__.vec.*;
    
    public class LogEntrySearch extends Object
    {
        public function LogEntrySearch(arg1:String="iterative")
        {
            super();
            _mode = arg1;
            return;
        }

        public function search(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String, arg4:Boolean=false, arg5:Boolean=false, arg6:Boolean=false):int
        {
            return searchIterativ(arg1, arg2, arg3);
        }

        public function searchIterativ(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String):int
        {
            var loc1:*=0;
            var loc2:*=0;
            loc1 = 0;
            while (loc1 < arg2.length) 
            {
                if (arg2[loc1][arg3] == arg1) 
                {
                    return loc1;
                }
                if (arg2[loc1][arg3] > arg1) 
                {
                    return loc2;
                }
                loc2 = loc1;
                ++loc1;
            }
            return loc2;
        }

        public function searchNearestIndex(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String):int
        {
            var loc4:*=0;
            var loc5:*=NaN;
            var loc3:*=null;
            var loc2:*;
            if ((loc2 = arg2.length) <= 1) 
            {
                return 0;
            }
            var loc6:*=-1;
            var loc8:*=0;
            var loc1:*=true;
            var loc7:*=-1;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                if ((loc3 = arg2[loc4] as Object).hasOwnProperty(arg3)) 
                {
                    if ((loc5 = Math.abs(loc3[arg3] - arg1)) <= loc8 || loc1) 
                    {
                        loc8 = loc5;
                        loc6 = loc4;
                    }
                }
                else 
                {
                    return -1;
                }
                loc1 = false;
                if (loc5 > loc7 && !(loc7 == -1)) 
                {
                    return loc6;
                }
                loc7 = loc5;
                ++loc4;
            }
            return loc6;
        }

        public static const MODE_ITERATIVE:String="iterative";

        public static const MODE_RECURSIVE:String="recursive";

        protected var _mode:String;
    }
}


