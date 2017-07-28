//class PhaseTarget
package core.training.type 
{
    import core.general.*;
    
    public class PhaseTarget extends core.general.BaseType
    {
        public function PhaseTarget(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseTarget
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

        public static const CADENCE:core.training.type.PhaseTarget=new PhaseTarget("cadence");

        public static const HEARTFREQUENCY:core.training.type.PhaseTarget=new PhaseTarget("heartfrequency");

        public static const OFF:core.training.type.PhaseTarget=new PhaseTarget("off");

        public static const PERCENT_MAX_HEARTFREQUENCY:core.training.type.PhaseTarget=new PhaseTarget("percent_of_max_heartfrequency");

        public static const POWER:core.training.type.PhaseTarget=new PhaseTarget("power");

        public static const TYPES:Array=[OFF, PERCENT_MAX_HEARTFREQUENCY, HEARTFREQUENCY, CADENCE, POWER];
    }
}


