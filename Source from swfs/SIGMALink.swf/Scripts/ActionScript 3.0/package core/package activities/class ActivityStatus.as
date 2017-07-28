//class ActivityStatus
package core.activities 
{
    public class ActivityStatus extends Object
    {
        public function ActivityStatus()
        {
            super();
            return;
        }

        public static function hasStatus(arg1:core.activities.Activity, arg2:String):Boolean
        {
            return !(arg1.activityStatus.indexOf(arg2) == -1);
        }

        public static function addStatus(arg1:core.activities.Activity, arg2:String):void
        {
            var loc1:*=null;
            if (arg1.activityStatus != "none") 
            {
                loc1 = arg1.activityStatus.split(",");
                loc1.push(arg2);
                arg1.activityStatus = loc1.join(",");
            }
            else 
            {
                arg1.activityStatus = arg2;
            }
            return;
        }

        public static function removeStatus(arg1:core.activities.Activity, arg2:String):void
        {
            var loc4:*=0;
            var loc2:*=null;
            loc2 = arg1.activityStatus.split(",");
            var loc1:*=[];
            var loc3:*=loc2.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                if (loc2[loc4] != arg2) 
                {
                    loc1.push(arg2);
                }
                ++loc4;
            }
            arg1.activityStatus = loc1.join(",");
            return;
        }

        public static const HEADER_DATA_VALID:String="headerDataValid";

        public static const NONE:String="none";

        internal static const STATUS_DELIMITER:String=",";
    }
}


