//class WheelSizeSelectionMode
package core.general 
{
    public class WheelSizeSelectionMode extends core.general.BaseType
    {
        public function WheelSizeSelectionMode(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.WheelSizeSelectionMode
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

        public static const MANUAL:core.general.WheelSizeSelectionMode=new WheelSizeSelectionMode("manual selection");

        public static const TIRE:core.general.WheelSizeSelectionMode=new WheelSizeSelectionMode("tire");

        public static const TYPES:Array=[MANUAL, TIRE];
    }
}


