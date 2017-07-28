//class PhaseChangeMode
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


