//class PhaseCategory
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


