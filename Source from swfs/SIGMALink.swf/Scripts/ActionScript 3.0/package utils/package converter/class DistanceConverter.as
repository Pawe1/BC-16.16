//class DistanceConverter
package utils.converter 
{
    public class DistanceConverter extends Object implements utils.converter.IConverter
    {
        public function DistanceConverter(arg1:String="kilometer", arg2:String="mile")
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
                if (isNaN(arg1 as Number)) 
                {
                    loc1 = 0;
                }
                else 
                {
                    loc1 = arg1 as Number;
                }
            }
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat == "kilometer" && outputFormat == "mile") 
            {
                loc2 = loc1 / 1.609344;
            }
            else if (inputFormat == "kilometer" && outputFormat == "meter") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "kilometer" && outputFormat == "millimeter") 
            {
                loc2 = loc1 * 1000 * 1000;
            }
            else if (inputFormat == "mile" && outputFormat == "kilometer") 
            {
                loc2 = loc1 * 1.609344;
            }
            else if (inputFormat == "mile" && outputFormat == "meter") 
            {
                loc2 = loc1 * 1.609344 * 1000;
            }
            else if (inputFormat == "mile" && outputFormat == "millimeter") 
            {
                loc2 = loc1 * 1609344;
            }
            else if (inputFormat == "meter" && outputFormat == "kilometer") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "meter" && outputFormat == "kilometer") 
            {
                loc2 = loc1 / (1000 * 1000);
            }
            else if (inputFormat == "meter" && outputFormat == "mile") 
            {
                loc2 = loc1 / (1000 * 1.609344);
            }
            else if (inputFormat == "millimeter" && outputFormat == "meter") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "millimeter" && outputFormat == "kilometer") 
            {
                loc2 = loc1 / (1000 * 1000);
            }
            else if (inputFormat == "millimeter" && outputFormat == "mile") 
            {
                loc2 = loc1 / (1000 * 1000 * 1.609344);
            }
            if (minOutputDistance >= 0 && loc2 < minOutputDistance) 
            {
                loc2 = minOutputDistance;
            }
            if (maxOutputDistance > 0 && loc2 < maxOutputDistance) 
            {
                loc2 = maxOutputDistance;
            }
            return loc2;
        }

        internal const METER_TO_KILOMETER:Number=1000;

        public static const MILES_TO_KILOMETER:Number=1.609344;

        internal var _inputFormat:String="kilometer";

        public var maxOutputDistance:Number=0;

        public var minOutputDistance:Number=-1;

        internal var _outputFormat:String="mile";

        internal var _toInt:Boolean=false;
    }
}


