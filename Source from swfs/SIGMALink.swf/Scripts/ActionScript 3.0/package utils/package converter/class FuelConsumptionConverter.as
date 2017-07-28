//class FuelConsumptionConverter
package utils.converter 
{
    public class FuelConsumptionConverter extends Object implements utils.converter.IConverter
    {
        public function FuelConsumptionConverter()
        {
            super();
            return;
        }

        public function get inputFormat():String
        {
            return _inputFormat;
        }

        public function set inputFormat(arg1:String):void
        {
            _inputFormat = arg1;
            return;
        }

        public function get outputFormat():String
        {
            return _outputFormat;
        }

        public function set outputFormat(arg1:String):void
        {
            _outputFormat = arg1;
            return;
        }

        public function set toInt(arg1:Boolean):void
        {
            _toInt = arg1;
            return;
        }

        public function get toInt():Boolean
        {
            return _toInt;
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
            if (arg1 == 0) 
            {
                return 0;
            }
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat == "l/100km" && outputFormat == "mpg") 
            {
                loc2 = 62.1504039776 * 3.785 / loc1;
            }
            else if (inputFormat == "l/100km" && outputFormat == "ml/100km") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "l/100km" && outputFormat == "dl/100km") 
            {
                loc2 = loc1 * 10;
            }
            else if (inputFormat == "mpg" && outputFormat == "l/100km") 
            {
                loc2 = 100 / (1.609 * loc1 / 3.785);
            }
            else if (inputFormat == "mpg" && outputFormat == "ml/100km") 
            {
                loc2 = 100 / (1.609 * loc1 / 3.785) * 1000;
            }
            else if (inputFormat == "mpg" && outputFormat == "dl/100km") 
            {
                loc2 = 100 / (1.609 * loc1 / 3.785) * 10;
            }
            else if (inputFormat == "ml/100km" && outputFormat == "l/100km") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "ml/100km" && outputFormat == "mpg") 
            {
                loc2 = 62.1504039776 * 3.785 / (loc1 / 1000);
            }
            else if (inputFormat == "dl/100km" && outputFormat == "mpg") 
            {
                loc2 = 62.1504039776 * 3.785 / (loc1 / 10);
            }
            else if (inputFormat == "dl/100km" && outputFormat == "l/100km") 
            {
                loc2 = loc1 / 10;
            }
            return loc2;
        }

        internal const GALLON_TO_LITER:Number=3.785;

        internal const MPG_TO_LITER_PER_HUNDRED_KM:Number=235.2;

        internal var _inputFormat:String="l/100km";

        internal var _outputFormat:String="l/100km";

        internal var _toInt:Boolean=false;
    }
}


