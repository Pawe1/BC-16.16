//class ExpansionConverter
package utils.converter 
{
    public class ExpansionConverter extends Object
    {
        public function ExpansionConverter(arg1:String="meter", arg2:String="feet")
        {
            super();
            inputFormat = arg1;
            outputFormat = arg2;
            return;
        }

        public function convert(arg1:Object):Number
        {
            var loc2:*=0;
            var loc1:*=0;
            if (arg1 is String) 
            {
                loc1 = parseFloat(arg1.toString());
            }
            if (arg1 is Number) 
            {
                loc1 = arg1 as Number;
            }
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat == "meter" && outputFormat == "feet") 
            {
                loc2 = loc1 * 3.2808399;
            }
            else if (inputFormat == "feet" && outputFormat == "meter") 
            {
                loc2 = loc1 / 3.2808399;
            }
            return loc2;
        }

        internal const METER_TO_FEET:Number=3.2808399;

        public var inputFormat:String="meter";

        public var outputFormat:String="feet";
    }
}


