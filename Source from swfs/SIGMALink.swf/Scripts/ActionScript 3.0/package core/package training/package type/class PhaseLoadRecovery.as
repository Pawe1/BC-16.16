//class PhaseLoadRecovery
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


