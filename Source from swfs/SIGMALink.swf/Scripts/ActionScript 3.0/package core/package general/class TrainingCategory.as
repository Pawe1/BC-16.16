//class TrainingCategory
package core.general 
{
    public final class TrainingCategory extends core.general.BaseType
    {
        public function TrainingCategory(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.TrainingCategory
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

        public static const FREE:core.general.TrainingCategory=new TrainingCategory("Free");

        public static const INTERVAL:core.general.TrainingCategory=new TrainingCategory("Interval");

        public static const NONE:core.general.TrainingCategory=new TrainingCategory("none");

        public static const PROGRAM:core.general.TrainingCategory=new TrainingCategory("Program");

        public static const SMARTPHONE:core.general.TrainingCategory=new TrainingCategory("Samrphone");

        public static const TYPES:Array=[FREE, INTERVAL, PROGRAM, SMARTPHONE, NONE];
    }
}


