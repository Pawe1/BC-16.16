//package type
//  class PhaseCategory
package core.training.type 
{
    import core.general.*;
    import debug.*;
    
    public class PhaseCategory extends core.general.BaseType
    {
        public function PhaseCategory(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseCategory
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
            debug.Debug.warning("Warning: Unknown TrainingPhaseType: \'" + arg1 + "\' !");
            return null;
        }

        public static const INTERVAL:core.training.type.PhaseCategory=new PhaseCategory("interval");

        public static const SIMPLE:core.training.type.PhaseCategory=new PhaseCategory("simple");

        public static const TYPES:Array=[SIMPLE, INTERVAL];
    }
}


//  class PhaseChangeMode
package core.training.type 
{
    import core.general.*;
    
    public class PhaseChangeMode extends core.general.BaseType
    {
        public function PhaseChangeMode(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseChangeMode
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

        public static const AUTOMATIC:core.training.type.PhaseChangeMode=new PhaseChangeMode("automatic");

        public static const MANUAL:core.training.type.PhaseChangeMode=new PhaseChangeMode("manual");

        public static const TYPES:Array=[AUTOMATIC, MANUAL];
    }
}


//  class PhaseControl
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


//  class PhaseLoadRecovery
package core.training.type 
{
    import core.general.*;
    
    public class PhaseLoadRecovery extends core.general.BaseType
    {
        public function PhaseLoadRecovery(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseLoadRecovery
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

        public static const LOAD:core.training.type.PhaseLoadRecovery=new PhaseLoadRecovery("load");

        public static const RECOVERY:core.training.type.PhaseLoadRecovery=new PhaseLoadRecovery("recovery");

        public static const TYPES:Array=[LOAD, RECOVERY];
    }
}


//  class PhaseTarget
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


