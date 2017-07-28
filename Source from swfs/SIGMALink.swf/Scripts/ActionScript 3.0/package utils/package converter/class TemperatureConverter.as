//class TemperatureConverter
package utils.converter 
{
    public class TemperatureConverter extends Object implements utils.converter.IConverter
    {
        public function TemperatureConverter(arg1:String="celsius", arg2:String="fahrenheit")
        {
            super();
            inputFormat = arg1;
            _outputFormat = arg2;
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
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat == "celsius" && outputFormat == "fahrenheit") 
            {
                loc2 = loc1 * 1.8 + 32;
            }
            else if (inputFormat == "fahrenheit" && outputFormat == "celsius") 
            {
                loc2 = (loc1 - 32) * 0.555555555556;
            }
            return loc2;
        }

        internal var _inputFormat:String="celsius";

        internal var _outputFormat:String="fahrenheit";

        internal var _toInt:Boolean=false;
    }
}


