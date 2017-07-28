//class TireSize
package core.general 
{
    public class TireSize extends core.general.BaseType
    {
        public function TireSize(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.TireSize
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if ((TYPES[loc1] as TireSize).toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const S_16INCH:core.general.TireSize=new TireSize("1253");

        public static const S_18INCH:core.general.TireSize=new TireSize("1411");

        public static const S_20INCH:core.general.TireSize=new TireSize("1590");

        public static const S_22INCH:core.general.TireSize=new TireSize("1770");

        public static const S_24INCH:core.general.TireSize=new TireSize("1907");

        public static const S_26INCH:core.general.TireSize=new TireSize("2085");

        public static const S_275INCH:core.general.TireSize=new TireSize("2180");

        public static const S_27INCH:core.general.TireSize=new TireSize("2195");

        public static const S_28INCH:core.general.TireSize=new TireSize("2200");

        public static const S_29INCH:core.general.TireSize=new TireSize("2300");

        public static const S_700C:core.general.TireSize=new TireSize("2095");

        public static const TYPES:Array=[S_16INCH, S_18INCH, S_20INCH, S_22INCH, S_24INCH, S_26INCH, S_27INCH, S_275INCH, S_28INCH, S_29INCH, S_700C];
    }
}


