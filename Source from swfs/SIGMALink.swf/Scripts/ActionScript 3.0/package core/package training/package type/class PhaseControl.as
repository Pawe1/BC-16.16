//class PhaseControl
package core.training.type 
{
    import core.general.*;
    
    public class PhaseControl extends core.general.BaseType
    {
        public function PhaseControl(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseControl
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

        public static const DISTANCE:core.training.type.PhaseControl=new PhaseControl("distance");

        public static const NO:core.training.type.PhaseControl=new PhaseControl("no");

        public static const PULSE:core.training.type.PhaseControl=new PhaseControl("pulse");

        public static const TIME:core.training.type.PhaseControl=new PhaseControl("time");

        public static const TYPES:Array=[NO, TIME, PULSE, DISTANCE];
    }
}


