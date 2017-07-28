//class LogType
package core.general 
{
    public final class LogType extends core.general.BaseType
    {
        public function LogType(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.LogType
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const ACTIVITY_TRACKER:core.general.LogType=new LogType("ActivityTracker");

        public static const CYCLING:core.general.LogType=new LogType("Cycling");

        public static const PULSE:core.general.LogType=new LogType("Pulse");

        public static const RUNNING:core.general.LogType=new LogType("Running");

        public static const TYPES:Array=[CYCLING, PULSE, RUNNING, ACTIVITY_TRACKER];
    }
}


