//class AltitudeConverter
package utils.converter 
{
    public class AltitudeConverter extends Object implements utils.converter.IConverter
    {
        public function AltitudeConverter(arg1:String="meter", arg2:String="feet")
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
            else if (inputFormat == "meter" && outputFormat == "feet") 
            {
                loc2 = loc1 * 3.2808399;
            }
            else if (inputFormat == "meter" && outputFormat == "millimeter") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "feet" && outputFormat == "meter") 
            {
                loc2 = loc1 / 3.2808399;
            }
            else if (inputFormat == "feet" && outputFormat == "millimeter") 
            {
                loc2 = loc1 * 304.8;
            }
            else if (inputFormat == "millimeter" && outputFormat == "meter") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "millimeter" && outputFormat == "feet") 
            {
                loc2 = loc1 / 304.8;
            }
            if (toInt) 
            {
                loc2 = loc2;
            }
            return loc2;
        }

        public static const FEET_TO_MILLIMETER:Number=304.8;

        public static const METER_TO_FEET:Number=3.2808399;

        internal var _inputFormat:String="meter";

        internal var _outputFormat:String="feet";

        internal var _toInt:Boolean=false;
    }
}


