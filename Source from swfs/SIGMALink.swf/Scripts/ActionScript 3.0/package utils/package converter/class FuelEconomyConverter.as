//class FuelEconomyConverter
package utils.converter 
{
    public class FuelEconomyConverter extends Object implements utils.converter.IConverter
    {
        public function FuelEconomyConverter()
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
            else if (inputFormat == "liter" && outputFormat == "gallon") 
            {
                loc2 = loc1 / 3.785411;
            }
            else if (inputFormat == "liter" && outputFormat == "milliliter") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "gallon" && outputFormat == "liter") 
            {
                loc2 = loc1 * 3.785411;
            }
            else if (inputFormat == "gallon" && outputFormat == "milliliter") 
            {
                loc2 = loc1 * 3.785411 * 1000;
            }
            else if (inputFormat == "milliliter" && outputFormat == "liter") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "milliliter" && outputFormat == "gallon") 
            {
                loc2 = loc1 / 1000 / 3.785411;
            }
            return loc2;
        }

        internal const GALLON_TO_LITER:Number=3.785411;

        internal const MPG_TO_LITER_PER_HUNDRED_KM:Number=235.2;

        internal var _inputFormat:String="milliliter";

        internal var _outputFormat:String="liter";

        internal var _toInt:Boolean=false;
    }
}


