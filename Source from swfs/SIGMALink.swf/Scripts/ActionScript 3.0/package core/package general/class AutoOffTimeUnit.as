//class AutoOffTimeUnit
package core.general 
{
    public class AutoOffTimeUnit extends core.general.BaseType
    {
        public function AutoOffTimeUnit(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.AutoOffTimeUnit
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

        public static const FIVE_MINUTES:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("5min");

        public static const OFF:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("off");

        public static const ONE_HOURS:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("1h");

        public static const THIRTY_MINUTES:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("30min");

        public static const TYPES:Array=[FIVE_MINUTES, THIRTY_MINUTES, ONE_HOURS, OFF];
    }
}


