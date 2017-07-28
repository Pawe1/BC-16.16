//package utils
//  package converter
//    class AltitudeConverter
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


//    class DistanceConverter
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


//    class ExpansionConverter
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


//    class FuelConsumptionConverter
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


//    class FuelEconomyConverter
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


//    class IConverter
package utils.converter 
{
    public dynamic interface IConverter
    {
        function get inputFormat():String;

        function set inputFormat(arg1:String):void;

        function get outputFormat():String;

        function set outputFormat(arg1:String):void;

        function set toInt(arg1:Boolean):void;

        function get toInt():Boolean;

        function convert(arg1:Object):Number;
    }
}


//    class PowerPerWeightConverter
package utils.converter 
{
    public class PowerPerWeightConverter extends Object implements utils.converter.IConverter
    {
        public function PowerPerWeightConverter(arg1:String="kg", arg2:String="lb")
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
            else if (inputFormat == "kg" && outputFormat == "lb") 
            {
                loc2 = loc1 / 2.20462262;
            }
            else 
            {
                loc2 = loc1;
            }
            return loc2;
        }

        public static const KG_TO_LB:Number=2.20462262;

        public static const LB_TO_G:Number=453.59237;

        internal var _inputFormat:String="kg";

        internal var _outputFormat:String="lb";

        internal var _toInt:Boolean=false;
    }
}


//    class SizeConverter
package utils.converter 
{
    public class SizeConverter extends Object implements utils.converter.IConverter
    {
        public function SizeConverter(arg1:String="centimeter", arg2:String="inch")
        {
            super();
            inputFormat = arg1;
            outputFormat = arg2;
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
            else if (inputFormat == "centimeter" && outputFormat == "inch") 
            {
                loc2 = loc1 * 0.393700787;
            }
            else if (inputFormat == "inch" && outputFormat == "centimeter") 
            {
                loc2 = loc1 / 0.393700787;
            }
            return loc2;
        }

        public static const CM_TO_INCH:Number=0.393700787;

        internal var _inputFormat:String="centimeter";

        internal var _outputFormat:String="inch";

        internal var _toInt:Boolean=false;
    }
}


//    class SpeedConverter
package utils.converter 
{
    public class SpeedConverter extends Object implements utils.converter.IConverter
    {
        public function SpeedConverter(arg1:String="kmh", arg2:String="mph")
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
                arg1 = (arg1 as String).replace(",", ".");
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
            else if (inputFormat != "ms") 
            {
                if (inputFormat != "kmh") 
                {
                    if (inputFormat != "mph") 
                    {
                        if (inputFormat != "fps") 
                        {
                            if (inputFormat != "s/km") 
                            {
                                if (inputFormat == "s/mile") 
                                {
                                    if (outputFormat != "kmh") 
                                    {
                                        if (outputFormat != "ms") 
                                        {
                                            if (outputFormat != "mph") 
                                            {
                                                if (outputFormat != "fps") 
                                                {
                                                    if (outputFormat == "s/km") 
                                                    {
                                                        loc2 = Math.round(1000 / (1609 / loc1));
                                                    }
                                                }
                                                else 
                                                {
                                                    loc2 = 1609 / loc1 * 3.2808399;
                                                }
                                            }
                                            else 
                                            {
                                                loc2 = 1609 / loc1 * 2.23693629;
                                            }
                                        }
                                        else 
                                        {
                                            loc2 = 1609 / loc1;
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = 1609 / loc1 * 3.6;
                                    }
                                }
                            }
                            else if (outputFormat != "kmh") 
                            {
                                if (outputFormat != "ms") 
                                {
                                    if (outputFormat != "mph") 
                                    {
                                        if (outputFormat != "fps") 
                                        {
                                            if (outputFormat == "s/mile") 
                                            {
                                                loc2 = Math.round(1609 / (1000 / loc1));
                                            }
                                        }
                                        else 
                                        {
                                            loc2 = 1000 / loc1 / 3.2808399;
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = 1000 / loc1 / 2.23693629;
                                    }
                                }
                                else 
                                {
                                    loc2 = 1000 / loc1;
                                }
                            }
                            else 
                            {
                                loc2 = 1000 / loc1 * 3.6;
                            }
                        }
                        else if (outputFormat != "kmh") 
                        {
                            if (outputFormat != "ms") 
                            {
                                if (outputFormat != "mph") 
                                {
                                    if (outputFormat != "s/km") 
                                    {
                                        if (outputFormat == "s/mile") 
                                        {
                                            loc2 = Math.round(1609 / (loc1 / 3.2808399));
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = Math.round(1000 / (loc1 / 3.2808399));
                                    }
                                }
                                else 
                                {
                                    loc2 = loc1 / 3.2808399 * 2.23693629;
                                }
                            }
                            else 
                            {
                                loc2 = loc1 / 3.2808399;
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 3.2808399 * 3.6;
                        }
                    }
                    else if (outputFormat != "kmh") 
                    {
                        if (outputFormat != "ms") 
                        {
                            if (outputFormat != "fps") 
                            {
                                if (outputFormat != "s/km") 
                                {
                                    if (outputFormat == "s/mile") 
                                    {
                                        loc2 = Math.round(1609 / (loc1 / 2.23693629));
                                    }
                                }
                                else 
                                {
                                    loc2 = Math.round(1000 / (loc1 / 2.23693629));
                                }
                            }
                            else 
                            {
                                loc2 = loc1 / 2.23693629 * 3.2808399;
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 2.23693629;
                        }
                    }
                    else 
                    {
                        loc2 = loc1 / 1.609344;
                    }
                }
                else if (outputFormat != "ms") 
                {
                    if (outputFormat != "mph") 
                    {
                        if (outputFormat != "fps") 
                        {
                            if (outputFormat != "s/km") 
                            {
                                if (outputFormat == "s/mile") 
                                {
                                    loc2 = Math.round(1609 / (loc1 / 3.6));
                                }
                            }
                            else 
                            {
                                loc2 = Math.round(1000 / (loc1 / 3.6));
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 3.6 * 3.2808399;
                        }
                    }
                    else 
                    {
                        loc2 = loc1 * 1.609344;
                    }
                }
                else 
                {
                    loc2 = loc1 / 3.6;
                }
            }
            else if (outputFormat != "kmh") 
            {
                if (outputFormat != "mph") 
                {
                    if (outputFormat != "fps") 
                    {
                        if (outputFormat != "s/km") 
                        {
                            if (outputFormat == "s/mile") 
                            {
                                loc2 = Math.round(1609 / loc1);
                            }
                        }
                        else 
                        {
                            loc2 = Math.round(1000 / loc1);
                        }
                    }
                    else 
                    {
                        loc2 = loc1 * 3.2808399;
                    }
                }
                else 
                {
                    loc2 = loc1 * 2.23693629;
                }
            }
            else 
            {
                loc2 = loc1 * 3.6;
            }
            if (!isFinite(loc2)) 
            {
                loc2 = 0;
            }
            return loc2;
        }

        internal const KMH_TO_MPH:Number=1.609344;

        internal const MS_TO_FPS:Number=3.2808399;

        internal const MS_TO_KMH:Number=3.6;

        internal const MS_TO_MPH:Number=2.23693629;

        internal var _inputFormat:String="kmh";

        internal var _outputFormat:String="mph";

        internal var _toInt:Boolean=false;
    }
}


//    class SpeedTimeConverter
package utils.converter 
{
    import utils.*;
    
    public class SpeedTimeConverter extends Object implements utils.converter.IConverter
    {
        public function SpeedTimeConverter()
        {
            super();
            return;
        }

        public function get inputFormat():String
        {
            return null;
        }

        public function set inputFormat(arg1:String):void
        {
            return;
        }

        public function get outputFormat():String
        {
            return null;
        }

        public function set outputFormat(arg1:String):void
        {
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
            return utils.Calculations.calculateSpeedTime(arg1 as Number) * 100;
        }

        internal var _toInt:Boolean=false;
    }
}


//    class TemperatureConverter
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


//    class WeightConverter
package utils.converter 
{
    public class WeightConverter extends Object implements utils.converter.IConverter
    {
        public function WeightConverter(arg1:String="kg", arg2:String="lb")
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
            else if (inputFormat == "kg" && outputFormat == "lb") 
            {
                loc2 = loc1 * 2.20462262;
            }
            else if (inputFormat == "kg" && outputFormat == "g") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "lb" && outputFormat == "kg") 
            {
                loc2 = loc1 / 2.20462262;
            }
            else if (inputFormat == "lb" && outputFormat == "g") 
            {
                loc2 = loc1 * 453.59237;
            }
            else if (inputFormat == "g" && outputFormat == "kg") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "g" && outputFormat == "lb") 
            {
                loc2 = loc1 / 453.59237;
            }
            return loc2;
        }

        public function convertROX2012(arg1:Number):Number
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
            else if (inputFormat == "kg" && outputFormat == "lb") 
            {
                loc2 = loc1 * 2258 / 1024;
            }
            else if (inputFormat == "kg" && outputFormat == "g") 
            {
                loc2 = loc1 * 1000;
            }
            else if (inputFormat == "lb" && outputFormat == "kg") 
            {
                loc2 = loc1 * 929 / 2048;
            }
            else if (inputFormat == "lb" && outputFormat == "g") 
            {
                loc2 = loc1 * 929 / 2048 * 1000;
            }
            else if (inputFormat == "g" && outputFormat == "kg") 
            {
                loc2 = loc1 / 1000;
            }
            else if (inputFormat == "g" && outputFormat == "lb") 
            {
                loc2 = loc1 * 2258 / 1024 / 1000;
            }
            return loc2;
        }

        public static const KG_TO_LB:Number=2.20462262;

        public static const LB_TO_G:Number=453.59237;

        internal var _inputFormat:String="kg";

        internal var _outputFormat:String="lb";

        internal var _toInt:Boolean=false;
    }
}


//  package dataprovider
//    class CommonAlarmModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAlarmModeDataProvider extends Object
    {
        public function CommonAlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_OFF"), "data":"off"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_DAILY"), "data":"everyDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_WORK_DAYS"), "data":"workDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_ONCE"), "data":"oneTime"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonAltitudeReferenceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAltitudeReferenceDataProvider extends Object
    {
        public function CommonAltitudeReferenceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ACTUAL_ALTITUDE"), "data":core.general.AltitudeReference.ACTUAL_ALTITUDE}, {"label":utils.LanguageManager.getString("SETTINGS_AIR_PRESSURE"), "data":core.general.AltitudeReference.SEA_LEVEL}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonAltitudeUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAltitudeUnitDataProvider extends Object
    {
        public function CommonAltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonAutoLapDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAutoLapDataProvider extends Object
    {
        public function CommonAutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_OFF"), "data":0}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_DISTANCE"), "data":1}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_TIME"), "data":2}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_CALORIES"), "data":3}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonAutoOffTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAutoOffTimeDataProvider extends Object
    {
        public function CommonAutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_OFF"), "data":core.general.AutoOffTimeUnit.OFF}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_5MIN"), "data":core.general.AutoOffTimeUnit.FIVE_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_30MIN"), "data":core.general.AutoOffTimeUnit.THIRTY_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_1HOUR"), "data":core.general.AutoOffTimeUnit.ONE_HOURS}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonBacklightTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBacklightTimeDataProvider extends Object
    {
        public function CommonBacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":0}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":3}]);
            DATA_PROVIDER_ROX70_ROX110 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":3}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":0}]);
            return;
        }

        public static var DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_ROX70_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonBikeTypeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBikeTypeDataProvider extends Object
    {
        public function CommonBikeTypeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_DROP"), "data":"raceDrop"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_HOODS"), "data":"raceHoods"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_MOUNTAIN_BIKE"), "data":"mountainBike"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonClockFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonClockFormatDataProvider extends Object
    {
        public function CommonClockFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("CLOCK_FORMAT_24"), "data":"24"}, {"label":utils.LanguageManager.getString("CLOCK_FORMAT_12"), "data":"12"}]);
            V_AM_PM_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_AM"), "data":"AM"}, {"label":utils.LanguageManager.getString("UNIT_PM"), "data":"PM"}]);
            return;
        }

        public static var V_AM_PM_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonDateFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDateFormatDataProvider extends Object
    {
        public function CommonDateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_EU"), "data":"eu"}, {"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_US"), "data":"us"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonDistanceUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDistanceUnitDataProvider extends Object
    {
        public function CommonDistanceUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonETAModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonETAModeDataProvider extends Object
    {
        public function CommonETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_TIME"), "data":false}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_CLOCK"), "data":true}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonFavoritesPC2812DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFavoritesPC2812DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesPC2812DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_TRIP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "data":1, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "data":2, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "data":3, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PROFILE"), "data":4, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES_PC2812"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES_PC2812"), "data":5, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "data":6, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "data":7, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":8, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "data":9, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_OFF"), "data":0, "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER_TRIP:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonFavoritesRox100DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFavoritesRox100DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRox100DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_TRIP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":0, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TARGET_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":16, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":17, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_GRAPH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":18, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":21, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":22, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":23, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":28, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":29, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":30, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_TARGETZ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":31, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_7_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":32, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":33, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":34, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":35, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":43, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":44, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":45, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":46, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":47, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":48, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":51, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":52, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":53, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":54, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":55, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":56, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":57, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":58, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_SIGNAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":59, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":60, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":61, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":62, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":63, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_MINI_TRACK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":64, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":75, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":76, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":77, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":78, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":79, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":80, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":81, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":82, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_TRACK_ALTI = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":0, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_FULL_SCREEN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":75, "image":"FavoriteNotDisplayIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":16, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":17, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":18, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":21, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":22, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":23, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":28, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":29, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":30, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":31, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":32, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":33, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":34, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":35, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":43, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":44, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":45, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":46, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":47, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":48, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":51, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":52, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":53, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":54, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":55, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":56, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":57, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":58, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":59, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":60, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":61, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":62, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":63, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":64, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_LAP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":0, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":1, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":2, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME_SINCE_START"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":3, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":4, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE_SINCE_START"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":5, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":6, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":7, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":8, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":9, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":10, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":11, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":12, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":13, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":14, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":15, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":16, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":17, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":18, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":19, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":20, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_PAGE_COUNT = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_OFF"), "data":0}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_1"), "data":1}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_2"), "data":2}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_3"), "data":3}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_4"), "data":4}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_5"), "data":5}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_6"), "data":6}]);
            V_DATA_PROVIDER_CUSTOM = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TARGET_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":16, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":17, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_GRAPH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":18, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":21, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":22, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":23, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":28, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":29, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":30, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_TARGETZ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":31, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_7_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":32, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":33, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":34, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":35, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":43, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":44, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":45, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":46, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":47, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":48, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":51, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":52, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":53, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":54, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":55, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":56, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":57, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":58, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_SIGNAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":59, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":60, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":61, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":62, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":63, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_MINI_TRACK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":64, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":75, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":76, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":77, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":78, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":79, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":80, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":81, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":82, "image":"FavoriteLapIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER_CUSTOM:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_LAP:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PAGE_COUNT:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TRACK_ALTI:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TRIP:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonFavoritesRox2010DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonFavoritesRox2010DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRox2010DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_GHOST_RACE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[8], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[47], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[48], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[49], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[50], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[51], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[15], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[16], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[18], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[19], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[20], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[27], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[28], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[29], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[30], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[52], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[35], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[36], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[37], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[38], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[39], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[41], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[42], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[43], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[44], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[45], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[53], "image":"FavoriteNotDisplayIcon"}]);
            V_DATA_PROVIDER_ROX8_1 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[47], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[48], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[49], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[50], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[51], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[15], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[16], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[18], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[19], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[20], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[27], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[28], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[29], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[30], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[52], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[35], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[36], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[37], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[38], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[39], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[41], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[42], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[43], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[44], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[45], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[53], "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX8_1:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonFavoritesRoxDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonFavoritesRoxDataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRoxDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[5], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[8], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[9], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[15], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[16], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[17], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[18], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[19], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[20], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[21], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[27], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[28], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[29], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[30], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[31], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[35], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[36], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[37], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[38], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[39], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[40], "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonFuelConsumptionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFuelConsumptionDataProvider extends Object
    {
        public function CommonFuelConsumptionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_LITER"), "data":"l/100km"}, {"label":utils.LanguageManager.getString("UNIT_GALLON"), "data":"mpg"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonGPSFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonGPSFormatDataProvider extends Object
    {
        public function CommonGPSFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":"hddd°mm,mmm", "data":"hddd°mm,mmm"}, {"label":"hddd°mm\'ss,s", "data":"hddd°mm\'ss,s"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonGenderDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonGenderDataProvider extends Object
    {
        public function CommonGenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_MALE"), "data":"male"}, {"label":utils.LanguageManager.getString("SETTINGS_FEMALE"), "data":"female"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonHeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonHeightUnitDataProvider extends Object
    {
        public function CommonHeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CM"), "data":"centimeter"}, {"label":utils.LanguageManager.getString("SETTINGS_INCH"), "data":"inch"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonLanguageDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonLanguageDataProvider extends Object
    {
        public function CommonLanguageDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BETA_TEST = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}]);
            V_DATA_PROVIDER_GPS10 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}]);
            V_DATA_PROVIDER_PC2814 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_RC2011 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}]);
            V_DATA_PROVIDER_ROX2008 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX2010 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX70_ROX110 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}, {"label":utils.LanguageManager.getString("LANGUAGE_CZECH"), "data":"cs"}]);
            V_DATA_PROVIDER_SOFTWARESETTINGS_EN = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl_PL"}, {"label":utils.LanguageManager.getString("LANGUAGE_CZECH"), "data":"cs_CZ"}]);
            V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}]);
            V_DATA_PROVIDER_TOPLINE2009 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_SWEDISH"), "data":"se"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}]);
            V_DATA_PROVIDER_TOPLINE2012 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BETA_TEST:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_GPS10:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PC2814:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC2011:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX2008:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX2010:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX70_ROX110:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARESETTINGS_EN:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TOPLINE2009:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TOPLINE2012:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonMeasurementDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonMeasurementDataProvider extends Object
    {
        public function CommonMeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}]);
            V_DATA_PROVIDER_RC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_KM"), "data":"min/km"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_MI"), "data":"min/mi"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonRouteOptionsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonRouteOptionsDataProvider extends Object
    {
        public function CommonRouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_SUITABLE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HIKING"), "param":"trekking", "sportId":"6", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_WALKING"), "param":"walking", "sportId":"5", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RUNNING"), "param":"jogging", "sportId":"4", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_BICYCLETOUR"), "param":"biking", "sportId":"3", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_MOUNTAINBIKE"), "param":"mountainbiking", "sportId":"2", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RACINGBICYCLE"), "param":"racingbike", "sportId":"1", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_INLINESKATING"), "param":"skating", "sportId":"12", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_CROSSSKATING"), "param":"crossskating", "sportId":"12", "selectable":false}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HANDBIKE"), "param":"handcycle", "sportId":"15", "selectable":true}]);
            V_CHARACTERISTIC_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_FLAT"), "param":"flat"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_HILLY"), "param":"hilly"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_MOUNTAINOUS"), "param":"mountainous"}]);
            V_TYPE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ALL"), "data":0}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ROUND_TRIP"), "data":1}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ONE_WAY_TRIP"), "data":2}]);
            return;
        }

        public static function resolveSportId(arg1:String):uint
        {
            var loc3:*=0;
            var loc2:*=V_SUITABLE_DATA_PROVIDER.length;
            var loc1:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc3].param == arg1) 
                {
                    loc1 = V_SUITABLE_DATA_PROVIDER[loc3].sportId;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public static function resolveSportParams():Array
        {
            return getParams(V_SUITABLE_DATA_PROVIDER);
        }

        public static function resolveSportParam(arg1:int):String
        {
            var loc2:*=0;
            var loc1:*=V_SUITABLE_DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc2].sportId == arg1) 
                {
                    return V_SUITABLE_DATA_PROVIDER[loc2].param;
                }
                ++loc2;
            }
            return "biking";
        }

        public static function resolveCategoryParams():Array
        {
            return getParams(V_CHARACTERISTIC_DATA_PROVIDER);
        }

        internal static function getParams(arg1:__AS3__.vec.Vector.<Object>):Array
        {
            var loc3:*=0;
            var loc2:*=undefined;
            loc2 = arg1;
            var loc1:*=loc2.length;
            var loc4:*=[];
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4[loc4.length] = "\'" + loc2[loc3].param + "\'";
                ++loc3;
            }
            return loc4;
        }

        public static var V_CHARACTERISTIC_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_SUITABLE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_TYPE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonSamplingRateDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonSamplingRateDataProvider extends Object
    {
        public function CommonSamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_PC2814 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_RC1411 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_BC2316 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            V_DATA_PROVIDER_ROX110 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC2316:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PC2814:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC1411:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTemperatureUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTemperatureUnitDataProvider extends Object
    {
        public function CommonTemperatureUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTimeZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonTimeZoneDataProvider extends Object
    {
        public function CommonTimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"data":0, "label":"Almaty (GMT+06:00)"}, {"data":1, "label":"Athens (GMT+02:00)"}, {"data":2, "label":"Auckland (GMT+12:00)"}, {"data":3, "label":"Azores (GMT-01:00)"}, {"data":4, "label":"Baghdad (GMT+03:00)"}, {"data":5, "label":"Baku (GMT+04:00)"}, {"data":6, "label":"Bangkok (GMT+07:00)"}, {"data":7, "label":"Beijing (GMT+08:00)"}, {"data":8, "label":"Berlin (GMT+01:00)"}, {"data":9, "label":"Bern (GMT+01:00)"}, {"data":10, "label":"Brasilia (GMT-03:00)"}, {"data":11, "label":"Brussels (GMT+01:00)"}, {"data":12, "label":"Budapest (GMT+01:00)"}, {"data":13, "label":"BuenosAires (GMT-03:00)"}, {"data":14, "label":"Cairo (GMT+02:00)"}, {"data":15, "label":"Canberra (GMT+10:00)"}, {"data":16, "label":"CapeVerdeIs. (GMT-01:00)"}, {"data":17, "label":"Caracas (GMT-04:00)"}, {"data":18, "label":"Chennai (GMT+05:30)"}, {"data":19, "label":"Copenhageu (GMT+01:00)"}, {"data":20, "label":"Darwin (GMT+09:30)"}, {"data":21, "label":"Dublin (GMT+00:00)"}, {"data":22, "label":"Edinburgh (GMT+00:00)"}, {"data":23, "label":"Fiji (GMT+12:00)"}, {"data":24, "label":"Georgetown (GMT-03:00)"}, {"data":25, "label":"Greenland (GMT-03:00)"}, {"data":26, "label":"Guam (GMT+10:00)"}, {"data":27, "label":"Hanoi (GMT+07:00)"}, {"data":28, "label":"HongKong (GMT+08:00)"}, {"data":29, "label":"Islamabad (GMT+05:00)"}, {"data":30, "label":"Istanbul (GMT+02:00)"}, {"data":31, "label":"Jakarta (GMT+07:00)"}, {"data":32, "label":"Jerusalem (GMT+02:00)"}, {"data":33, "label":"Kabul (GMT+04:30)"}, {"data":34, "label":"Karachi (GMT+05:00)"}, {"data":35, "label":"Kuwaut (GMT+03:00)"}, {"data":36, "label":"Lima (GMT-05:00)"}, {"data":37, "label":"Lisbon (GMT+00:00)"}, {"data":38, "label":"London (GMT+00:00)"}, {"data":39, "label":"Madrid (GMT+01:00)"}, {"data":40, "label":"Magadan (GMT+11:00)"}, {"data":41, "label":"Melbourne (GMT+10:00)"}, {"data":42, "label":"Mexico (GMT-06:00)"}, {"data":43, "label":"Mid-Atlantic (GMT-02:00)"}, {"data":44, "label":"Monrovia (GMT+00:00)"}, {"data":45, "label":"Moscow (GMT+03:00)"}, {"data":46, "label":"Mumbai (GMT+05:30)"}, {"data":47, "label":"Muscat (GMT+04:00)"}, {"data":48, "label":"Newfoundland (GMT-03:30)"}, {"data":49, "label":"Paris (GMT+01:00)"}, {"data":50, "label":"Prague (GMT+01:00)"}, {"data":51, "label":"Quito (GMT-05:00)"}, {"data":52, "label":"Rome (GMT+01:00)"}, {"data":53, "label":"Samoa (GMT-11:00)"}, {"data":54, "label":"Santiago (GMT-04:00)"}, {"data":55, "label":"Seoul (GMT+09:00)"}, {"data":56, "label":"Singapore (GMT+08:00)"}, {"data":57, "label":"SolomonIs. (GMT+11:00)"}, {"data":58, "label":"Sydney (GMT+10:00)"}, {"data":59, "label":"Taipei (GMT+08:00)"}, {"data":60, "label":"Tashkent (GMT+05:00)"}, {"data":61, "label":"Tehran (GMT+03:30)"}, {"data":62, "label":"Tokyo (GMT+09:00)"}, {"data":63, "label":"US-Alaska (GMT-09:00)"}, {"data":64, "label":"US-Arizona (GMT-07:00)"}, {"data":65, "label":"US-Atlantic (GMT-04:00)"}, {"data":66, "label":"US-Central (GMT-06:00)"}, {"data":67, "label":"US-Eastern (GMT-05:00)"}, {"data":68, "label":"US-Hawaii (GMT-10:00)"}, {"data":69, "label":"US-Mountain (GMT-07:00)"}, {"data":70, "label":"US-Pacific (GMT-08:00)"}, {"data":71, "label":"Vienna (GMT+01:00)"}, {"data":72, "label":"Vladivostok (GMT+10:00)"}, {"data":73, "label":"Wellington (GMT+12:00)"}, {"data":74, "label":"Yangon (GMT+06:30)"}, {"data":75, "label":"Yerevan (GMT+04:00)"}, {"data":76, "label":"-14:00"}, {"data":77, "label":"-13:30"}, {"data":78, "label":"-13:00"}, {"data":79, "label":"-12:30"}, {"data":80, "label":"-12:00"}, {"data":81, "label":"-11:30"}, {"data":82, "label":"-11:00"}, {"data":83, "label":"-10:30"}, {"data":84, "label":"-10:00"}, {"data":85, "label":"-09:30"}, {"data":86, "label":"-09:00"}, {"data":87, "label":"-08:30"}, {"data":88, "label":"-08:00"}, {"data":89, "label":"-07:30"}, {"data":90, "label":"-07:00"}, {"data":91, "label":"-06:30"}, {"data":92, "label":"-06:00"}, {"data":93, "label":"-05:30"}, {"data":94, "label":"-05:00"}, {"data":95, "label":"-04:30"}, {"data":96, "label":"-04:00"}, {"data":97, "label":"-03:30"}, {"data":98, "label":"-03:00"}, {"data":99, "label":"-02:30"}, {"data":100, "label":"-02:00"}, {"data":101, "label":"-01:30"}, {"data":102, "label":"-01:00"}, {"data":103, "label":"00:30"}, {"data":104, "label":"00:00"}, {"data":105, "label":"00:30"}, {"data":106, "label":"01:00"}, {"data":107, "label":"01:30"}, {"data":108, "label":"02:00"}, {"data":109, "label":"02:30"}, {"data":110, "label":"03:00"}, {"data":111, "label":"03:30"}, {"data":112, "label":"04:00"}, {"data":113, "label":"04:30"}, {"data":114, "label":"05:00"}, {"data":115, "label":"05:30"}, {"data":116, "label":"06:00"}, {"data":117, "label":"06:30"}, {"data":118, "label":"07:00"}, {"data":119, "label":"07:30"}, {"data":120, "label":"08:00"}, {"data":121, "label":"08:30"}, {"data":122, "label":"09:00"}, {"data":123, "label":"09:30"}, {"data":124, "label":"10:00"}, {"data":125, "label":"10:30"}, {"data":126, "label":"11:00"}, {"data":127, "label":"11:30"}, {"data":128, "label":"12:00"}, {"data":129, "label":"12:30"}, {"data":130, "label":"13:00"}, {"data":131, "label":"13:30"}, {"data":132, "label":"14:00"}]);
            DATA_PROVIDER_GPS_10 = __AS3__.vec.Vector.<Object>([{"data":0, "label":"GMT -12:00"}, {"data":1, "label":"GMT -11:00"}, {"data":2, "label":"GMT -10:00"}, {"data":3, "label":"GMT -09:30"}, {"data":4, "label":"GMT -09:00"}, {"data":5, "label":"GMT -08:00"}, {"data":6, "label":"GMT -07:00"}, {"data":7, "label":"GMT -06:00"}, {"data":8, "label":"GMT -05:00"}, {"data":9, "label":"GMT -04:30"}, {"data":10, "label":"GMT -04:00"}, {"data":11, "label":"GMT -03:30"}, {"data":12, "label":"GMT -03:00"}, {"data":13, "label":"GMT -02:00"}, {"data":14, "label":"GMT -01:00"}, {"data":15, "label":"GMT +00:00"}, {"data":16, "label":"GMT +01:00"}, {"data":17, "label":"GMT +02:00"}, {"data":18, "label":"GMT +03:00"}, {"data":19, "label":"GMT +03:30"}, {"data":20, "label":"GMT +04:00"}, {"data":21, "label":"GMT +04:30"}, {"data":22, "label":"GMT +05:00"}, {"data":23, "label":"GMT +05:30"}, {"data":24, "label":"GMT +05:45"}, {"data":25, "label":"GMT +06:00"}, {"data":26, "label":"GMT +06:30"}, {"data":27, "label":"GMT +07:00"}, {"data":28, "label":"GMT +08:00"}, {"data":29, "label":"GMT +08:45"}, {"data":30, "label":"GMT +09:00"}, {"data":31, "label":"GMT +09:30"}, {"data":32, "label":"GMT +10:00"}, {"data":33, "label":"GMT +10:30"}, {"data":34, "label":"GMT +11:00"}, {"data":35, "label":"GMT +11:30"}, {"data":36, "label":"GMT +12:00"}, {"data":37, "label":"GMT +12:45"}, {"data":38, "label":"GMT +13:00"}, {"data":39, "label":"GMT +14:00"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_GPS_10:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTireModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonTireModeDataProvider extends Object
    {
        public function CommonTireModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TIRE_SIZE_16INCH"), "data":core.general.TireSize.S_16INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_18INCH"), "data":core.general.TireSize.S_18INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_20INCH"), "data":core.general.TireSize.S_20INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_22INCH"), "data":core.general.TireSize.S_22INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_24INCH"), "data":core.general.TireSize.S_24INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_26INCH"), "data":core.general.TireSize.S_26INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_27INCH"), "data":core.general.TireSize.S_27INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_275INCH"), "data":core.general.TireSize.S_275INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_28INCH"), "data":core.general.TireSize.S_28INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_29INCH"), "data":core.general.TireSize.S_29INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_700C"), "data":core.general.TireSize.S_700C}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTrackDirectionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrackDirectionDataProvider extends Object
    {
        public function CommonTrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TRACK_NORTH_DIRECTION"), "data":"north"}, {"label":utils.LanguageManager.getString("TRACK_DRIVING_DIRECTION"), "data":"drivingDirection"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTrackDistanceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.*;
    import utils.*;
    
    public class CommonTrackDistanceDataProvider extends Object
    {
        public function CommonTrackDistanceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            if (core.MeasurementConfig.distanceFormat != "kilometer") 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"131 " + utils.LanguageManager.getString("UNIT_FT"), "data":1}, {"label":"262 " + utils.LanguageManager.getString("UNIT_FT"), "data":2}, {"label":"393 " + utils.LanguageManager.getString("UNIT_FT"), "data":3}]);
            }
            else 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"40 " + utils.LanguageManager.getString("UNIT_M"), "data":1}, {"label":"80 " + utils.LanguageManager.getString("UNIT_M"), "data":2}, {"label":"120 " + utils.LanguageManager.getString("UNIT_M"), "data":3}]);
            }
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonTrainingZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrainingZoneDataProvider extends Object
    {
        public function CommonTrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_FIT_FAT = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}]);
            V_DATA_PROVIDER_HEARTRATE_LIMITS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_RCMOVE = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FIT"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FAT"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_1"), "data":"ownZone1"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_2"), "data":"ownZone2"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_3"), "data":"ownZone3"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            return;
        }

        public static var V_DATA_PROVIDER_FIT_FAT:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_HEARTRATE_LIMITS:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RCMOVE:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonUnitsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    
    public class CommonUnitsDataProvider extends Object
    {
        public function CommonUnitsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_ALL_DEVICES = new __AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>();
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC512.getLabel(), core.general.UnitType.BC512));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812.getLabel(), core.general.UnitType.BC812));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212.getLabel(), core.general.UnitType.BC1212));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1412.getLabel(), core.general.UnitType.BC1412));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612.getLabel(), core.general.UnitType.BC1612));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612STS.getLabel(), core.general.UnitType.BC1612STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812W.getLabel(), core.general.UnitType.BC812W));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212STS.getLabel(), core.general.UnitType.BC1212STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416.getLabel(), core.general.UnitType.BC416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416ATS.getLabel(), core.general.UnitType.BC416ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC516.getLabel(), core.general.UnitType.BC516));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716.getLabel(), core.general.UnitType.BC716));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716ATS.getLabel(), core.general.UnitType.BC716ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916.getLabel(), core.general.UnitType.BC916));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916ATS.getLabel(), core.general.UnitType.BC916ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416.getLabel(), core.general.UnitType.BC1416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416STS.getLabel(), core.general.UnitType.BC1416STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616.getLabel(), core.general.UnitType.BC1616));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616STS.getLabel(), core.general.UnitType.BC1616STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC2316STS.getLabel(), core.general.UnitType.BC2316STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX50.getLabel(), core.general.UnitType.ROX50));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX60.getLabel(), core.general.UnitType.ROX60));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX70.getLabel(), core.general.UnitType.ROX70));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX100.getLabel(), core.general.UnitType.ROX100));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX110.getLabel(), core.general.UnitType.ROX110));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.GPS10.getLabel(), core.general.UnitType.GPS10));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.RC1411.getLabel(), core.general.UnitType.RC1411));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.PC2814.getLabel(), core.general.UnitType.PC2814));
            return;
        }

        public static function isSupported(arg1:core.general.UnitType):Boolean
        {
            var loc2:*=0;
            var loc1:*=V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_DATA_PROVIDER_ALL_DEVICES[loc2].data == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public static var V_DATA_PROVIDER_ALL_DEVICES:__AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>;
    }
}


//    class CommonWeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonWeightUnitDataProvider extends Object
    {
        public function CommonWeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_KG"), "data":"kg"}, {"label":utils.LanguageManager.getString("UNIT_LB"), "data":"lb"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class CommonWheelSizeSelectionModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonWheelSizeSelectionModeDataProvider extends Object
    {
        public function CommonWheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("WHEELSIZE_MANUAL"), "data":core.general.WheelSizeSelectionMode.MANUAL.toString()}, {"label":utils.LanguageManager.getString("WHEELSIZE_TIRE"), "data":core.general.WheelSizeSelectionMode.TIRE.toString()}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//    class GraphicsnameConstants
package utils.dataprovider 
{
    public class GraphicsnameConstants extends Object
    {
        public function GraphicsnameConstants()
        {
            super();
            return;
        }

        public static const FavoriteBatteryStatusIcon:String="FavoriteBatteryStatusIcon";

        public static const FavoriteCyclingIcon:String="FavoriteCyclingIcon";

        public static const FavoriteDownhillIcon:String="FavoriteDownhillIcon";

        public static const FavoriteGPSIcon:String="FavoriteGPSIcon";

        public static const FavoriteHeartrateIcon:String="FavoriteHeartrateIcon";

        public static const FavoriteLapIcon:String="FavoriteLapIcon";

        public static const FavoriteNavigationIcon:String="FavoriteNavigationIcon";

        public static const FavoriteNotDisplayIcon:String="FavoriteNotDisplayIcon";

        public static const FavoriteTemperatureIcon:String="FavoriteTemperatureIcon";

        public static const FavoriteTimeIcon:String="FavoriteTimeIcon";

        public static const FavoriteUphillIcon:String="FavoriteUphillIcon";
    }
}


//    class RouteTypeCommon
package utils.dataprovider 
{
    public class RouteTypeCommon extends Object
    {
        public function RouteTypeCommon()
        {
            super();
            return;
        }

        public static const ALL_TRIPS:String="alltrips";

        public static const ONE_WAY_TRIP:String="onewaytrip";

        public static const ROUND_TRIP:String="roundtrip";
    }
}


//    class UnitItemRendererData
package utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import utils.*;
    
    public class UnitItemRendererData extends utils.ItemRendererDataObjectBase
    {
        public function UnitItemRendererData(arg1:String="", arg2:Object=null)
        {
            super(arg1, arg2);
            var loc1:*=arg2 as core.general.UnitType;
            usb = !(core.units.UnitFactory.usbSupported().indexOf(loc1) == -1);
            ble = !(core.units.UnitFactory.bleSupported().indexOf(loc1) == -1);
            nfc = !(core.units.UnitFactory.nfcSupported().indexOf(loc1) == -1);
            return;
        }

        public var ble:Boolean=false;

        public var nfc:Boolean=false;

        public var usb:Boolean=false;
    }
}


//  package date
//    class CalendarUtil
package utils.date 
{
    import flash.utils.*;
    
    public class CalendarUtil extends Object
    {
        public function CalendarUtil()
        {
            super();
            return;
        }

        public static function calculateCalendarWeek(arg1:Date):uint
        {
            var loc8:*=0;
            var loc4:*=0;
            var loc9:*=null;
            var loc11:*=0;
            var loc14:*=false;
            var loc17:*=null;
            var loc10:*=0;
            var loc1:*=false;
            var loc7:*=0;
            var loc13:*;
            var loc6:*=(loc13 = new Date(arg1.fullYear, arg1.month, arg1.date)).time + "_" + weekCalculationStandard;
            if (kwCalculated[loc6] != undefined) 
            {
                ++reuseCalculatedCalendarWeekCount;
                return kwCalculated[loc6];
            }
            ++calculateCalendarWeekCount;
            loc13.hours = 12;
            var loc2:*=daysFromBeginningDate(loc13);
            var loc12:*=new Date(loc13.fullYear, 0, 1, 12);
            var loc15:*=daysFromBeginningDate(loc12);
            var loc16:*=new Date(loc13.fullYear, 0, 4, 12);
            var loc3:*=daysFromBeginningDate(loc16);
            var loc5:*=1;
            var loc18:*=weekCalculationStandard;
            while ("i" === loc18) 
            {
                loc5 = isoWeekNumber(loc13);
            }
        }

        public static function calculateMaxCalendarWeek(arg1:Date):int
        {
            var loc2:*=new Date(arg1.fullYear, 11, 31);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 == 1) 
            {
                loc2.date = loc2.date - 7;
                loc1 = calculateCalendarWeek(loc2);
            }
            return loc1;
        }

        public static function calculateCalendarWeekObject(arg1:Date):utils.date.Week
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc1:*=0;
            var loc3:*=calculateCalendarWeek(arg1);
            if (arg1.month == 11 || arg1.month == 0) 
            {
                loc4 = calculateFirstWeekOfMonth(0, arg1.fullYear + 1);
                loc1 = calculateMaxCalendarWeek(new Date((arg1.fullYear - 1), 11, 31, 12));
                if (weekCalculationStandard != "i") 
                {
                    if (weekCalculationStandard == "a") 
                    {
                        loc2 = new utils.date.Week(loc3, arg1.fullYear);
                    }
                }
                else if (loc3 == loc4 && arg1.month == 11) 
                {
                    loc2 = new utils.date.Week(loc3, arg1.fullYear + 1);
                }
                else if (loc3 == loc1 && arg1.month == 0) 
                {
                    loc2 = new utils.date.Week(loc3, (arg1.fullYear - 1));
                }
                else 
                {
                    loc2 = new utils.date.Week(loc3, arg1.fullYear);
                }
            }
            else 
            {
                loc2 = new utils.date.Week(loc3, arg1.fullYear);
            }
            return loc2;
        }

        public static function calculateMaxCalendarWeekObject(arg1:Date):utils.date.Week
        {
            var loc2:*=calculateMaxCalendarWeek(arg1);
            var loc1:*=new utils.date.Week(loc2, arg1.fullYear);
            return loc1;
        }

        public static function calculateWeekYear(arg1:Date):utils.date.Week
        {
            var loc3:*=new Date(arg1.fullYear, arg1.month, arg1.date - 3);
            while (loc3.day != 4) 
            {
                --loc3.date;
            }
            var loc1:*=calculateCalendarWeek(arg1);
            var loc2:*=new utils.date.Week(loc1, loc3.fullYear);
            return loc2;
        }

        public static function thursday(arg1:Date):Date
        {
            var loc1:*=new Date();
            loc1.setTime(arg1.getTime() + (3 - (arg1.getDay() + 6) % 7) * 86400000);
            return loc1;
        }

        public static function scrubTimeValue(arg1:Object):Object
        {
            var loc1:*=null;
            if (arg1 is Date) 
            {
                return new Date(arg1.getFullYear(), arg1.getMonth(), arg1.getDate());
            }
            if (arg1 is Object) 
            {
                loc1 = {};
                if (arg1.rangeStart) 
                {
                    loc1.rangeStart = new Date(arg1.rangeStart.getFullYear(), arg1.rangeStart.getMonth(), arg1.rangeStart.getDate());
                }
                if (arg1.rangeEnd) 
                {
                    loc1.rangeEnd = new Date(arg1.rangeEnd.getFullYear(), arg1.rangeEnd.getMonth(), arg1.rangeEnd.getDate());
                }
                return loc1;
            }
            return null;
        }

        public static function scrubTimeValues(arg1:Array):Array
        {
            var loc1:*=0;
            var loc2:*=[];
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                loc2[loc1] = scrubTimeValue(arg1[loc1]);
                ++loc1;
            }
            return loc2;
        }

        public static function getNumberOfDaysInMonth(arg1:int, arg2:int):int
        {
            var loc1:*=0;
            if (arg2 != 1) 
            {
                if (arg2 == 3 || arg2 == 5 || arg2 == 8 || arg2 == 10) 
                {
                    loc1 = 30;
                }
                else 
                {
                    loc1 = 31;
                }
            }
            else if (arg1 % 4 == 0 && !(arg1 % 100 == 0) || arg1 % 400 == 0) 
            {
                loc1 = 29;
            }
            else 
            {
                loc1 = 28;
            }
            return loc1;
        }

        public static function maxMonthDaysTest(arg1:Date):uint
        {
            var loc2:*=31;
            var loc1:*=new Date(arg1.fullYear, arg1.month, loc2);
            while (loc1.date != loc2) 
            {
                --loc2;
                loc1 = new Date(arg1.fullYear, arg1.month, loc2);
            }
            return loc2;
        }

        public static function calculateCalendarWeekMondayDate(arg1:uint, arg2:uint):Date
        {
            var loc2:*=firstMonday(arg2);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 > arg1) 
            {
                loc2.date = loc2.date - 7;
                loc1 = calculateCalendarWeek(loc2);
            }
            loc2.time = loc2.time + 604800000 * (arg1 - loc1);
            return loc2;
        }

        public static function calculateCalendarWeekSundayDate(arg1:uint, arg2:uint):Date
        {
            var loc2:*=firstSunday(arg2);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 > arg1) 
            {
                if (loc2.fullYear == arg2) 
                {
                    loc2.date = loc2.date - 7;
                    loc1 = calculateCalendarWeek(loc2);
                    if (loc2.fullYear < arg2) 
                    {
                        return loc2;
                    }
                }
            }
            loc2.time = loc2.time + 604800000 * (arg1 - loc1);
            return loc2;
        }

        public static function calculateFirstWeekOfMonth(arg1:int, arg2:int):int
        {
            var loc1:*=null;
            if (arg1 == 0) 
            {
                return 1;
            }
            loc1 = new Date(arg2, arg1, 1, 12);
            return calculateCalendarWeek(loc1);
        }

        public static function calculateDayOfYear(arg1:Date):uint
        {
            var loc2:*=new Date(arg1.fullYear, 0, 1);
            var loc1:*=(arg1.time - loc2.time) / 86400000;
            ++loc1;
            return loc1;
        }

        public static function calculateDateFromDayOfYear(arg1:uint, arg2:uint):Date
        {
            var loc1:*=new Date(arg2, 0, 1);
            --arg1;
            loc1.time = loc1.time + arg1 * 86400000;
            return loc1;
        }

        internal static function isoWeekNumber(arg1:Date):int
        {
            var loc3:*=0;
            var loc8:*=null;
            arg1.hours = 12;
            var loc2:*=daysFromBeginningDate(arg1);
            var loc10:*=new Date(arg1.fullYear, 0, 1, 12);
            var loc4:*=daysFromBeginningDate(loc10);
            var loc11:*=new Date(arg1.fullYear, 11, 31, 12);
            var loc6:*=daysFromBeginningDate(loc11);
            var loc5:*=loc10.day <= 1 ? 1 - loc10.day : 8 - loc10.day;
            var loc12:*;
            (loc12 = new Date()).time = loc10.time + 86400000 * loc5;
            var loc9:*;
            var loc1:*=(loc9 = daysFromBeginningDate(loc12)) > 4;
            var loc7:*=loc11.day < 4;
            if (loc2 >= loc9) 
            {
                if (loc7 && loc2 > loc6 - loc11.day) 
                {
                    return 1;
                }
                loc3 = Math.floor((loc2 - loc9) / 7);
                return loc1 ? loc3 + 2 : loc3 + 1;
            }
            if (loc1) 
            {
                return 1;
            }
            loc8 = new Date((arg1.fullYear - 1), 11, 31, 12);
            return isoWeekNumber(loc8);
        }

        internal static function leapGregorian(arg1:int):Boolean
        {
            return arg1 % 4 == 0 && !(arg1 % 100 == 0 && !(arg1 % 400 == 0));
        }

        internal static function daysFromBeginningDate(arg1:Date):int
        {
            return daysFromBeginning(arg1.fullYear, arg1.month, arg1.date);
        }

        internal static function daysFromBeginning(arg1:int, arg2:int, arg3:int):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var loc1:*=0;
            loc3 = 0;
            while (loc3 < arg2) 
            {
                loc4 = loc2[loc3];
                if (1 == loc3 && leapGregorian(arg1)) 
                {
                    ++loc4;
                }
                loc1 = loc1 + loc4;
                ++loc3;
            }
            return loc1 = loc1 + arg3;
        }

        internal static function firstMonday(arg1:uint):Date
        {
            var loc1:*=new Date(arg1, 0, 1);
            if (loc1.day > 1) 
            {
                loc1.date = loc1.date + (7 - (loc1.day - 1));
            }
            else if (loc1.day < 1) 
            {
                loc1.date = loc1.date + 1;
            }
            return loc1;
        }

        internal static function firstSunday(arg1:uint):Date
        {
            var loc1:*=new Date(arg1, 0, 1);
            if (loc1.day > 0) 
            {
                loc1.date = loc1.date + (7 - loc1.day);
            }
            return loc1;
        }

        
        {
            kwCalculated = new flash.utils.Dictionary();
        }

        public static const NUMBERING_FIRST_DAY_IS_MONDAY:String="j";

        public static const NUMBERING_FIRST_DAY_IS_SUNDAY:String="a";

        public static const NUMBERING_SIMPLE:String="s";

        public static const NUMBERING_STANDARD_ISO_8601:String="i";

        public static var weekCalculationStandard:String="i";

        internal static var calculateCalendarWeekCount:int=0;

        internal static var kwCalculated:flash.utils.Dictionary;

        internal static var reuseCalculatedCalendarWeekCount:int=0;
    }
}


//    class DateUtilCommon
package utils.date 
{
    import init.*;
    import utils.interfaces.*;
    
    public class DateUtilCommon extends Object
    {
        public function DateUtilCommon()
        {
            super();
            return;
        }

        public static function clearTime(arg1:Date):Date
        {
            arg1.hours = 0;
            arg1.minutes = 0;
            arg1.seconds = 0;
            arg1.milliseconds = 0;
            return arg1;
        }

        public static function copyDate(arg1:Date):Date
        {
            return new Date(arg1.getTime());
        }

        public static function setTime(arg1:Date, arg2:Number):Date
        {
            arg1.hours = Math.floor(arg2 / 3600000 % 24);
            arg1.minutes = Math.floor(arg2 / 60000 % 60);
            arg1.seconds = Math.floor(arg2 / 1000 % 60);
            arg1.milliseconds = Math.floor(arg2 % 1000);
            return arg1;
        }

        public static function addTime(arg1:Date, arg2:Number):Date
        {
            arg1.milliseconds = arg1.milliseconds + arg2;
            return arg1;
        }

        public static function dateToMySqlFormat(arg1:Date=null, arg2:Boolean=false):String
        {
            formattedDate.formatString = arg2 ? "YYYY-MM-DD" : "YYYY-MM-DD JJ:NN:SS";
            if (arg1 == null) 
            {
                arg1 = new Date();
            }
            return formattedDate.format(arg1);
        }

        public static function dateFromMySqlFormat(arg1:String):Date
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*;
            if ((loc4 = arg1.split(" ")).length != 2) 
            {
                loc1 = new Date(Date.parse(arg1));
            }
            else 
            {
                loc2 = loc4[0].toString().split("-");
                loc3 = loc4[1].toString().split(":");
                if (loc2.length == 3 && loc3.length == 3) 
                {
                    loc1 = new Date();
                    loc1.setFullYear(loc2[0], (loc2[1] - 1), loc2[2]);
                    loc1.setHours(loc3[0], loc3[1], loc3[2], 0);
                }
            }
            return loc1;
        }

        
        {
            formattedDate = init.BackendInitializer.getInstance().createDateFormatterMx();
        }

        public static const CENTURY_IN_MILLISECONDS:Number=3.1104e+012;

        public static const DAY_IN_MILLISECONDS:Number=86400000;

        public static const HOUR_IN_MILLISECONDS:Number=3600000;

        public static const MILLENIUM_IN_MILLISECONDS:Number=3.1104e+015;

        public static const MINUTE_IN_MILLISECONDS:Number=60000;

        public static const MONTH_IN_MILLISECONDS:Number=2592000000;

        public static const WEEK_IN_MILLISECONDS:Number=604800000;

        public static const YEAR_IN_MILLISECONDS:Number=31104000000;

        public static var formattedDate:utils.interfaces.ICustomFormatter;
    }
}


//    class Week
package utils.date 
{
    public class Week extends Object
    {
        public function Week(arg1:uint=0, arg2:uint=0)
        {
            super();
            week = arg1;
            year = arg2;
            return;
        }

        public var week:uint;

        public var year:uint;
    }
}


//  package events
//    class SettingsEvent
package utils.events 
{
    import core.settings.*;
    import flash.events.*;
    
    public class SettingsEvent extends flash.events.Event
    {
        public function SettingsEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:core.settings.Settings=null)
        {
            super(arg1, arg2, arg3);
            settings = arg4;
            return;
        }

        public function get settings():core.settings.Settings
        {
            return _settings;
        }

        public function set settings(arg1:core.settings.Settings):void
        {
            _settings = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new utils.events.SettingsEvent(type, bubbles, cancelable, settings);
        }

        public static const CREATION_COMPLETE:String="creationComplete";

        public var _settings:core.settings.Settings;
    }
}


//  package file
//    class CRC32Generator
package utils.file 
{
    import flash.utils.*;
    
    public class CRC32Generator extends Object
    {
        public function CRC32Generator()
        {
            super();
            return;
        }

        public function generateCRC32(arg1:flash.utils.ByteArray):int
        {
            var loc3:*=0;
            if (!_tableComputed) 
            {
                makeCRCTable();
            }
            var loc1:*=-1;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = _crcTable[(loc1 ^ arg1[loc3]) & 255] ^ loc1 >>> 8;
                ++loc3;
            }
            loc1 = ~loc1;
            return loc1 & 4294967295;
        }

        internal static function makeCRCTable():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            _crcTable = new Array(256);
            loc2 = 0;
            while (loc2 < 256) 
            {
                loc1 = loc2;
                loc3 = 0;
                while (loc3 < 8) 
                {
                    if ((loc1 & 1) == 0) 
                    {
                        loc1 = loc1 >>> 1;
                    }
                    else 
                    {
                        loc1 = 3988292384 ^ loc1 >>> 1;
                    }
                    ++loc3;
                }
                _crcTable[loc2] = loc1;
                ++loc2;
            }
            _tableComputed = true;
            return;
        }

        internal static var _crcTable:Array;

        internal static var _tableComputed:Boolean=false;
    }
}


//    class FileExtension
package utils.file 
{
    public class FileExtension extends Object
    {
        public function FileExtension()
        {
            super();
            return;
        }

        public static function createFileName(arg1:String):String
        {
            var loc1:*=createRandomNumber(1, 100);
            var loc3:*;
            var loc2:*=(loc3 = new Date()).date.toString() + loc3.month.toString() + loc3.fullYear.toString() + loc3.hours.toString() + loc3.minutes.toString() + loc3.seconds.toString() + loc3.milliseconds.toString() + loc1;
            return loc2 + "." + arg1;
        }

        public static function createRandomNumber(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.floor(Math.random() * (arg2 - arg1 + 1)) + arg1;
            return loc1;
        }

        public static const CSV_FILE:String="csv";

        public static const FILTER_FILE:String="sff";

        public static const FIT_FILE:String="fit";

        public static const GPX_FILE:String="gpx";

        public static const KML_FILE:String="kml";

        public static const KMZ_FILE:String="kmz";

        public static const LOG_FILE:String="slf";

        public static const MEMORY_FILE:String="smf";

        public static const POINT_NAVIGATION:String="spn";

        public static const SETTING_FILE:String="ssf";

        public static const SPORTPROFILE:String="ssp";

        public static const TCX_FILE:String="tcx";

        public static const TRACK_FILE:String="stf";

        public static const TRAININGPROGRAM_FILE:String="spf";

        public static const XLSX_FILE:String="xlsx";
    }
}


//    class GZIPBytesEncoder
package utils.file 
{
    import flash.errors.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class GZIPBytesEncoder extends Object
    {
        public function GZIPBytesEncoder()
        {
            super();
            return;
        }

        public function compressToByteArray(arg1:flash.utils.ByteArray, arg2:Date=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("src can\'t be null.");
            }
            var loc10:*=arg1.position;
            var loc12:*;
            (loc12 = new flash.utils.ByteArray()).writeBytes(arg1);
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "littleEndian";
            var loc8:*=31;
            loc4.writeByte(loc8);
            var loc7:*=139;
            loc4.writeByte(loc7);
            var loc3:*=8;
            loc4.writeByte(loc3);
            var loc2:*=parseInt("00000000", 2);
            loc4.writeByte(loc2);
            var loc5:*=arg2 != null ? arg2.time : 0;
            loc4.writeUnsignedInt(loc5);
            var loc13:*=parseInt("00000100", 2);
            loc4.writeByte(loc13);
            if (flash.system.Capabilities.os.indexOf("Windows") >= 0) 
            {
                loc1 = 11;
            }
            else if (flash.system.Capabilities.os.indexOf("Mac OS") >= 0) 
            {
                loc1 = 7;
            }
            else 
            {
                loc1 = 3;
            }
            loc4.writeByte(loc1);
            var loc6:*;
            var loc11:*=(loc6 = new utils.file.CRC32Generator()).generateCRC32(loc12);
            var loc9:*=loc12.length % Math.pow(2, 32);
            loc12.deflate();
            loc4.writeBytes(loc12, 0, loc12.length);
            loc4.writeUnsignedInt(loc11);
            loc4.writeUnsignedInt(loc9);
            return loc4;
        }

        public function uncompressToByteArray(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc2:*=null;
            loc2 = parseGZIPData(arg1);
            var loc1:*=loc2.getCompressedData();
            try 
            {
                loc1.inflate();
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified source is not a GZIP file format file or data.");
            }
            return loc1;
        }

        public function parseGZIPData(arg1:flash.utils.ByteArray, arg2:String=""):utils.file.GZIPFile
        {
            var loc7:*=null;
            var loc2:*=null;
            var loc15:*=null;
            var loc22:*=null;
            var loc10:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("The srcBytes ByteArray can\'t be null.");
            }
            arg1.endian = "littleEndian";
            var loc21:*;
            if ((loc21 = arg1.readUnsignedByte()) != 31) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc19:*;
            if ((loc19 = arg1.readUnsignedByte()) != 139) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc18:*;
            if ((loc18 = arg1.readUnsignedByte()) != 8) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc4:*;
            var loc11:*=((loc4 = arg1.readByte()) >> 7 & 1) == 1;
            var loc16:*=(loc4 >> 6 & 1) == 1;
            var loc13:*=(loc4 >> 5 & 1) == 1;
            var loc20:*=(loc4 >> 4 & 1) == 1;
            var loc1:*=(loc4 >> 3 & 1) == 1;
            var loc6:*=false;
            loc6 = (loc4 >> 2 & 1) != 1 ? loc6 : true;
            loc6 = (loc4 >> 1 & 1) != 1 ? loc6 : true;
            if (loc6 = (loc4 & 1) != 1 ? loc6 : true) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc5:*=arg1.readUnsignedInt();
            var loc23:*=arg1.readUnsignedByte();
            var loc14:*=arg1.readUnsignedByte();
            if (loc13) 
            {
                loc7 = arg1.readUTF();
            }
            var loc12:*=null;
            if (loc20) 
            {
                loc2 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc2.writeByte(arg1.readByte());
                }
                loc2.position = 0;
                loc12 = loc2.readUTFBytes(loc2.length);
            }
            if (loc1) 
            {
                loc22 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc22.writeByte(arg1.readByte());
                }
                loc22.position = 0;
                loc15 = loc22.readUTFBytes(loc22.length);
            }
            if (loc16) 
            {
                loc10 = arg1.readUnsignedShort();
            }
            var loc17:*=arg1.length - arg1.position - 8;
            var loc3:*=new flash.utils.ByteArray();
            arg1.readBytes(loc3, 0, loc17);
            var loc9:*=arg1.readUnsignedInt();
            var loc8:*=arg1.readUnsignedInt();
            return new utils.file.GZIPFile(loc3, loc8, new Date(loc5), arg2, loc12, loc15);
        }
    }
}


//    class GZIPEncoder
package utils.file 
{
    import flash.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class GZIPEncoder extends Object
    {
        public function GZIPEncoder()
        {
            super();
            return;
        }

        public function compressToFile(arg1:Object, arg2:flash.filesystem.File):void
        {
            var loc7:*=null;
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=null;
            if (arg1 == null || arg2 == null) 
            {
                throw new ArgumentError("src and output can\'t be null.");
            }
            var loc8:*=new flash.filesystem.File(arg2.nativePath);
            if (arg1 is flash.filesystem.File) 
            {
                if (!(loc3 = arg1 as flash.filesystem.File).exists || loc3.isDirectory) 
                {
                    throw new ArgumentError("If src is a File instance, it must specify the location of an existing file (not a directory).");
                }
                (loc2 = new flash.filesystem.FileStream()).open(loc3, "read");
                loc7 = new flash.utils.ByteArray();
                loc2.readBytes(loc7, 0, loc2.bytesAvailable);
                loc2.close();
                if (loc8.isDirectory) 
                {
                    loc8 = loc8.resolvePath(loc3.name + ".gz");
                }
                loc1 = loc3.modificationDate;
            }
            else if (arg1 is flash.utils.ByteArray) 
            {
                loc7 = arg1 as flash.utils.ByteArray;
                if (loc8.isDirectory) 
                {
                    loc8 = loc8.resolvePath("output.gz");
                }
                loc1 = new Date();
            }
            else 
            {
                throw new ArgumentError("src must be a File instance or a ByteArray instance");
            }
            var loc5:*;
            var loc6:*=(loc5 = new utils.file.GZIPBytesEncoder()).compressToByteArray(loc7, loc1);
            var loc4:*;
            (loc4 = new flash.filesystem.FileStream()).open(loc8, "write");
            loc4.writeBytes(loc6, 0, loc6.length);
            loc4.close();
            return;
        }

        public function uncompressToFile(arg1:flash.filesystem.File, arg2:flash.filesystem.File):void
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                throw new ArgumentError("output cannot be null");
            }
            var loc4:*=parseGZIPFile(arg1);
            var loc2:*;
            if ((loc2 = new flash.filesystem.File(arg2.nativePath)).isDirectory) 
            {
                if (loc4.headerFileName == null) 
                {
                    if (loc4.gzipFileName.lastIndexOf(".gz") != loc4.gzipFileName.length - 3) 
                    {
                        if (loc4.gzipFileName.lastIndexOf(".gzip") != loc4.gzipFileName.length - 5) 
                        {
                            loc1 = loc4.gzipFileName;
                        }
                        else 
                        {
                            loc1 = loc4.gzipFileName.substr(0, loc4.gzipFileName.length - 5);
                        }
                    }
                    else 
                    {
                        loc1 = loc4.gzipFileName.substr(0, loc4.gzipFileName.length - 3);
                    }
                }
                else 
                {
                    loc1 = loc4.headerFileName;
                }
                loc2 = loc2.resolvePath(loc1);
            }
            var loc3:*=loc4.getCompressedData();
            try 
            {
                loc3.uncompress("deflate");
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified file is not a GZIP file format file.");
            }
            var loc5:*;
            (loc5 = new flash.filesystem.FileStream()).open(loc2, "write");
            loc5.writeBytes(loc3, 0, loc3.length);
            loc5.close();
            return;
        }

        public function uncompressToByteArray(arg1:Object):flash.utils.ByteArray
        {
            var loc3:*=null;
            var loc2:*=null;
            if (arg1 is flash.filesystem.File) 
            {
                loc2 = arg1 as flash.filesystem.File;
                loc3 = parseGZIPFile(loc2);
            }
            else if (arg1 is flash.utils.ByteArray) 
            {
                loc3 = parseGZIPData(arg1 as flash.utils.ByteArray);
            }
            else 
            {
                throw new ArgumentError("The src argument must be a File or ByteArray instance");
            }
            var loc1:*=loc3.getCompressedData();
            try 
            {
                loc1.uncompress("deflate");
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified source is not a GZIP file format file or data.");
            }
            return loc1;
        }

        public function parseGZIPFile(arg1:flash.filesystem.File):utils.file.GZIPFile
        {
            checkSrcFile(arg1);
            var loc2:*=new flash.filesystem.File(arg1.nativePath);
            var loc1:*=new flash.filesystem.FileStream();
            loc1.open(loc2, "read");
            var loc3:*=new flash.utils.ByteArray();
            loc1.readBytes(loc3, 0, loc1.bytesAvailable);
            loc1.close();
            return parseGZIPData(loc3, loc2.name);
        }

        public function parseGZIPData(arg1:flash.utils.ByteArray, arg2:String=""):utils.file.GZIPFile
        {
            var loc1:*=new utils.file.GZIPBytesEncoder();
            return loc1.parseGZIPData(arg1, arg2);
        }

        internal function checkSrcFile(arg1:flash.filesystem.File):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("src can\'t be null");
            }
            if (arg1.isDirectory) 
            {
                throw new ArgumentError("src must refer to the location of a file, not a directory");
            }
            if (!arg1.exists) 
            {
                throw new ArgumentError("src refers to a file that doesn\'t exist");
            }
            return;
        }
    }
}


//    class GZIPFile
package utils.file 
{
    import flash.utils.*;
    
    public class GZIPFile extends Object
    {
        public function GZIPFile(arg1:flash.utils.ByteArray, arg2:int, arg3:Date, arg4:String="", arg5:String=null, arg6:String=null)
        {
            super();
            _compressedData = arg1;
            _originalFileSize = arg2;
            _fileModificationTime = arg3;
            _gzipFileName = arg4;
            _headerFileName = arg5;
            _headerComment = arg6;
            return;
        }

        public function get fileModificationTime():Date
        {
            return _fileModificationTime;
        }

        public function get gzipFileName():String
        {
            return _gzipFileName;
        }

        public function get headerComment():String
        {
            return _headerComment;
        }

        public function get headerFileName():String
        {
            return _headerFileName;
        }

        public function get originalFileSize():int
        {
            return _originalFileSize;
        }

        public function getCompressedData():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            _compressedData.position = 0;
            _compressedData.readBytes(loc1, 0, _compressedData.length);
            return loc1;
        }

        internal var _fileModificationTime:Date;

        internal var _gzipFileName:String;

        internal var _headerComment:String;

        internal var _headerFileName:String;

        internal var _originalFileSize:int;

        internal var _compressedData:flash.utils.ByteArray;
    }
}


//  package format
//    class AltitudeFormat
package utils.format 
{
    public class AltitudeFormat extends Object
    {
        public function AltitudeFormat()
        {
            super();
            return;
        }

        public static const FEET:String="feet";

        public static const METER:String="meter";

        public static const MILLIMETER:String="millimeter";
    }
}


//    class BodySizeFormat
package utils.format 
{
    public class BodySizeFormat extends Object
    {
        public function BodySizeFormat()
        {
            super();
            return;
        }

        public static const CENTIMETER:String="centimeter";

        public static const INCH:String="inch";
    }
}


//    class CDATAFormat
package utils.format 
{
    public class CDATAFormat extends Object
    {
        public function CDATAFormat()
        {
            super();
            return;
        }

        public static function getCDataAsXMLNode(arg1:String, arg2:String):XML
        {
            return new XML("<" + (arg1 + " ") + ">" + new XML("<![CDATA[" + arg2 + "]]>") + "</" + (arg1 + " ") + ">");
        }
    }
}


//    class ClockFormat
package utils.format 
{
    import core.general.interfaces.*;
    import init.*;
    import utils.interfaces.*;
    
    public class ClockFormat extends Object
    {
        public function ClockFormat()
        {
            super();
            return;
        }

        public static function GET_CLOCKFORMAT(arg1:String):String
        {
            var loc1:*=CLOCK_FORMATS.indexOf(arg1);
            return CLOCK_FORMATS[loc1];
        }

        public static function formatClock(arg1:Object, arg2:String=null, arg3:String=null):String
        {
            var loc1:*=null;
            if (arg1 is core.general.interfaces.IGeneralDataInformation) 
            {
                loc1 = (arg1 as core.general.interfaces.IGeneralDataInformation).startDate;
            }
            else if (arg1 is core.general.interfaces.IDate) 
            {
                loc1 = (arg1 as core.general.interfaces.IDate).date;
            }
            else if (arg1 is Date) 
            {
                loc1 = arg1 as Date;
            }
            var loc2:*=init.BackendInitializer.getInstance().createDateFormatterMx();
            return loc2.format(loc1);
        }

        public static const AM:String="AM";

        public static const CLOCK_12H:String="12";

        public static const CLOCK_24H:String="24";

        public static const CLOCK_FORMATS:Array=["24", "12"];

        public static const PM:String="PM";
    }
}


//    class DateFormat
package utils.format 
{
    public class DateFormat extends Object
    {
        public function DateFormat()
        {
            super();
            return;
        }

        public static function GET_DATEFORMAT(arg1:String):String
        {
            var loc1:*=DATEFORMATS.indexOf(arg1);
            return DATEFORMAT_FORMATS[loc1];
        }

        public static function GET_DATEFORMAT_SPARK(arg1:String):String
        {
            var loc1:*=DATEFORMATS.indexOf(arg1);
            return DATEFORMAT_FORMATS_SPARK[loc1];
        }

        public static const AMERICAN:String="us";

        public static const AMERICAN_FORMAT:String="MM/DD/YYYY";

        public static const AMERICAN_FORMAT_SHORT:String="MM/dd";

        public static const AMERICAN_FORMAT_SPARK:String="MM/dd/yyyy";

        public static const DATEFORMATS:Array=["eu", "us"];

        public static const DATEFORMAT_FORMATS:Array=["DD.MM.YYYY", "MM/DD/YYYY"];

        public static const DATEFORMAT_FORMATS_SPARK:Array=["dd.MM.yyyy", "MM/dd/yyyy"];

        public static const DD_MM_YY:String="dd.MM.yy";

        public static const EUROPEAN:String="eu";

        public static const EUROPEAN_FORMAT:String="DD.MM.YYYY";

        public static const EUROPEAN_FORMAT_SHORT:String="dd.MM";

        public static const EUROPEAN_FORMAT_SPARK:String="dd.MM.yyyy";

        public static const MM_DD_YY:String="MM/dd/yy";
    }
}


//    class DistanceFormat
package utils.format 
{
    public class DistanceFormat extends Object
    {
        public function DistanceFormat()
        {
            super();
            return;
        }

        public static const KILOMETER:String="kilometer";

        public static const METER:String="meter";

        public static const MILE:String="mile";

        public static const MILLIMETER:String="millimeter";
    }
}


//    class ExpansionFormat
package utils.format 
{
    public class ExpansionFormat extends Object
    {
        public function ExpansionFormat()
        {
            super();
            return;
        }

        public static const FEET:String="feet";

        public static const METER:String="meter";
    }
}


//    class FuelConsumptionFormat
package utils.format 
{
    public class FuelConsumptionFormat extends Object
    {
        public function FuelConsumptionFormat()
        {
            super();
            return;
        }

        public static const LITER_PER_HUNDRED_KILOMETER:String="l/100km";

        public static const MILES_PER_GALLON:String="mpg";

        public static const MILLILITER_PER_HUNDRED_KILOMETER:String="ml/100km";

        public static const DECILITER_PER_HUNDRED_KILOMETER:String="dl/100km";
    }
}


//    class FuelEconomyFormat
package utils.format 
{
    public class FuelEconomyFormat extends Object
    {
        public function FuelEconomyFormat()
        {
            super();
            return;
        }

        public static const GALLON:String="gallon";

        public static const LITER:String="liter";

        public static const MILLILITER:String="milliliter";
    }
}


//    class GPSFormat
package utils.format 
{
    public class GPSFormat extends Object
    {
        public function GPSFormat()
        {
            super();
            return;
        }

        public static const DECIMAL_DEGREE_MINUTE:String="hddd°mm,mmm";

        public static const DECIMAL_DEGREE_MINUTES_SECONDS:String="hddd°mm\'ss,s";
    }
}


//    class SpeedFormat
package utils.format 
{
    public class SpeedFormat extends Object
    {
        public function SpeedFormat()
        {
            super();
            return;
        }

        public static const DISTANCE_PER_TIME:String="distance/time";

        public static const FEET_PER_SECOND:String="fps";

        public static const KILOMETER_PER_HOUR:String="kmh";

        public static const METER_PER_SECOND:String="ms";

        public static const MILES_PER_HOUR:String="mph";

        public static const SECONDS_PER_KILOMETER:String="s/km";

        public static const SECONDS_PER_MILE:String="s/mile";

        public static const TIME_PER_DISTANCE:String="time/distance";
    }
}


//    class TemperatureFormat
package utils.format 
{
    public class TemperatureFormat extends Object
    {
        public function TemperatureFormat()
        {
            super();
            return;
        }

        public static const CELSIUS:String="celsius";

        public static const FAHRENHEIT:String="fahrenheit";
    }
}


//    class TimeFormatterConstants
package utils.format 
{
    public class TimeFormatterConstants extends Object
    {
        public function TimeFormatterConstants()
        {
            super();
            return;
        }

        public static const INPUT_HOURS:String="hours";

        public static const INPUT_HUNDREDTHSSECONDS:String="hundredthsSecond";

        public static const INPUT_MILLISECONDS:String="milliSeconds";

        public static const INPUT_MINUTES:String="minutes";

        public static const INPUT_SECONDS:String="seconds";

        public static const INPUT_TENSECONDS:String="tenSeconds";
    }
}


//  package formatter
//    class DateFormatterMx
package utils.formatter 
{
    import utils.interfaces.*;
    
    public class DateFormatterMx extends Object implements utils.interfaces.ICustomFormatter
    {
        public function DateFormatterMx()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return _formatString;
        }

        public function set formatString(arg1:String):void
        {
            _formatString = arg1;
            return;
        }

        public function format(arg1:Object):String
        {
            var loc4:*=null;
            var loc1:*=null;
            if (arg1 is Number) 
            {
                (loc4 = new Date()).setTime(arg1 as Number);
                arg1 = loc4;
            }
            if (arg1 is Date) 
            {
                loc1 = arg1 as Date;
                var loc5:*=loc1.month + 1;
                var loc7:*=loc1.date;
                var loc6:*=loc1.hours;
                var loc8:*=loc1.minutes;
                var loc3:*=loc1.seconds;
                var loc2:*=formatString;
                if (loc2.indexOf("YYYY") == -1) 
                {
                    if (loc2.indexOf("YY") != -1) 
                    {
                        loc2 = loc2.replace("YYYY", loc1.fullYear.toString().substr(2, 2));
                    }
                }
                else 
                {
                    loc2 = loc2.replace("YYYY", loc1.fullYear);
                }
                loc2 = loc2.replace("MM", loc5 < 10 ? "0" + loc5 : loc5);
                loc2 = loc2.replace("DD", loc7 < 10 ? "0" + loc7 : loc7);
                if (formatString.indexOf("12") == -1) 
                {
                    loc2 = loc2.replace("JJ", loc6 < 10 ? "0" + loc6 : loc6);
                    loc2 = loc2.replace("NN", loc8 < 10 ? "0" + loc8 : loc8);
                    loc2 = loc2.replace("SS", loc3 < 10 ? "0" + loc3 : loc3);
                }
                else 
                {
                    if (loc6 != 0) 
                    {
                        if (loc6 >= 1 && loc6 <= 11) 
                        {
                            loc2 = loc2.replace("12", "AM");
                        }
                        else if (loc6 != 12) 
                        {
                            if (loc6 >= 13 && loc6 <= 23) 
                            {
                                loc6 = loc6 - 12;
                                loc2 = loc2.replace("12", "PM");
                            }
                        }
                        else 
                        {
                            loc6 = 12;
                            loc2 = loc2.replace("12", "PM");
                        }
                    }
                    else 
                    {
                        loc6 = 12;
                        loc2 = loc2.replace("12", "AM");
                    }
                    loc2 = loc2.replace("JJ", loc6);
                    loc2 = loc2.replace("NN", loc8 < 10 ? "0" + loc8 : loc8);
                    loc2 = loc2.replace("SS", loc3 < 10 ? "0" + loc3 : loc3);
                }
                return loc2;
            }
            return null;
        }

        public static const CLOCK_12:String="JJ:NN 12";

        public static const CLOCK_24:String="JJ:NN";

        public static const EU_FORMAT:String="DD.MM.YYYY";

        public static const US_FORMAT:String="MM/DD/YYYY";

        internal var _formatString:String="MM/DD/YYYY";
    }
}


//  package interfaces
//    class ICustomDateTimeFormatter
package utils.interfaces 
{
    public dynamic interface ICustomDateTimeFormatter extends utils.interfaces.ICustomFormatterBase
    {
        function get dateStyle():String;

        function set dateStyle(arg1:String):void;

        function get timeStyle():String;

        function set timeStyle(arg1:String):void;

        function setStyle(arg1:String, arg2:*):void;
    }
}


//    class ICustomFormatter
package utils.interfaces 
{
    public dynamic interface ICustomFormatter extends utils.interfaces.ICustomFormatterBase
    {
        function get formatString():String;

        function set formatString(arg1:String):void;
    }
}


//    class ICustomFormatterBase
package utils.interfaces 
{
    public dynamic interface ICustomFormatterBase
    {
        function format(arg1:Object):String;
    }
}


//    class ICustomTimeFormatter
package utils.interfaces 
{
    public dynamic interface ICustomTimeFormatter extends utils.interfaces.ICustomFormatter
    {
        function set inputType(arg1:String):void;
    }
}


//  package sort
//    class SortUtil
package utils.sort 
{
    public class SortUtil extends Object
    {
        public function SortUtil()
        {
            super();
            return;
        }

        public static function sortOnString(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3].toLowerCase();
            var loc4:*=arg2[arg3].toLowerCase();
            var loc2:*=loc1 < loc4 ? 0 : 1;
            var loc3:*=loc1 < loc4 ? 1 : 0;
            return doNumberSort(loc2, loc3, arg4);
        }

        public static function sortOnDate(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=(arg1[arg3] as Date).time;
            var loc2:*=(arg2[arg3] as Date).time;
            return doNumberSort(loc1, loc2, arg4);
        }

        public static function sortOnNumber(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3];
            var loc2:*=arg2[arg3];
            return doNumberSort(loc1, loc2, arg4);
        }

        public static function sortOnBool(arg1:Object, arg2:Object, arg3:String, arg4:Boolean):Number
        {
            var loc1:*=arg1[arg3];
            var loc3:*=arg2[arg3];
            var loc4:*=loc1 ? 1 : 0;
            var loc2:*=loc3 ? 1 : 0;
            return doNumberSort(loc4, loc2, arg4);
        }

        public static function sortOnTwoNumberFields(arg1:Object, arg2:Object, arg3:String, arg4:String, arg5:Boolean=false):Number
        {
            var loc1:*;
            return (loc1 = sortOnNumber(arg1, arg2, arg3, arg5)) != 0 ? loc1 : sortOnNumber(arg1, arg2, arg4, arg5);
        }

        public static function doNumberSort(arg1:Number, arg2:Number, arg3:Boolean):Number
        {
            if (arg3) 
            {
                if (arg1 < arg2) 
                {
                    return 1;
                }
                if (arg1 > arg2) 
                {
                    return -1;
                }
            }
            else 
            {
                if (arg1 < arg2) 
                {
                    return -1;
                }
                if (arg1 > arg2) 
                {
                    return 1;
                }
            }
            return 0;
        }
    }
}


//  package validator
//    class TextInputRestrictions
package utils.validator 
{
    public class TextInputRestrictions extends Object
    {
        public function TextInputRestrictions()
        {
            super();
            return;
        }

        public static function getValidSQLString(arg1:String):String
        {
            if (arg1 == null) 
            {
                return "";
            }
            if (arg1.indexOf("\"") != -1) 
            {
                arg1 = arg1.replace("\"", "");
                return getValidSQLString(arg1);
            }
            return arg1;
        }

        public static function replaceSpaces(arg1:String, arg2:String="_"):String
        {
            return arg1.replace(new RegExp(" ", "g"), arg2);
        }

        public static function getValidSingleLineText(arg1:String):String
        {
            var loc1:*=arg1.replace("\n", " ");
            loc1 = loc1.replace("\t", " ");
            return loc1;
        }

        public static function getValidFileNameString(arg1:String):String
        {
            var loc1:*=arg1.match(new RegExp("[^!¡?¿\"¨#$%&\'´()*.,;:=\\^\\\\\\/{}\\[\\]|\\<\\>~¢©®ª£¤¥¦§«»¬¯°º±¹²³µ¶·×Ø÷]+", "g"));
            return loc1.join("");
        }

        public static function getValidPrintDescription(arg1:String, arg2:int):String
        {
            if (arg1.length > arg2 && arg2 > 0) 
            {
                arg1 = arg1.substr(0, arg2);
                arg1 = arg1 + "...";
            }
            return arg1;
        }

        public static const SQL_VALID:String="^\"";
    }
}


//  class BackendUtil
package utils 
{
    import flash.utils.*;
    
    public class BackendUtil extends Object
    {
        public function BackendUtil()
        {
            super();
            return;
        }

        public static function copy(arg1:Object):Object
        {
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeObject(arg1);
            loc2.position = 0;
            var loc1:*=loc2.readObject();
            return loc1;
        }

        public static function generateStatementText(arg1:String, arg2:Array):String
        {
            arg1 = arg1 + (" (" + arg2.join(",") + ") VALUES (");
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg2[loc2] = "?";
                ++loc2;
            }
            arg1 = arg1 + (arg2.join(",") + ")");
            return arg1;
        }
    }
}


//  class Base64Decoder
package utils 
{
    import flash.utils.*;
    
    public class Base64Decoder extends Object
    {
        public function Base64Decoder()
        {
            work = [0, 0, 0, 0];
            super();
            data = new flash.utils.ByteArray();
            return;
        }

        public function decode(arg1:String):void
        {
            var loc2:*=0;
            var loc1:*=NaN;
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc1 = arg1.charCodeAt(loc2);
                if (loc1 != 61) 
                {
                    if (inverse[loc1] != 64) 
                    {
                        count = (count + 1);
                        work[count] = inverse[loc1];
                        if (count == 4) 
                        {
                            count = 0;
                            data.writeByte(work[0] << 2 | (work[1] & 255) >> 4);
                            ++filled;
                            if (work[2] == -1) 
                            {
                                break;
                            }
                            data.writeByte(work[1] << 4 | (work[2] & 255) >> 2);
                            ++filled;
                            if (work[3] == -1) 
                            {
                                break;
                            }
                            data.writeByte(work[2] << 6 | work[3]);
                            ++filled;
                        }
                    }
                }
                else 
                {
                    count = (count + 1);
                    work[count] = -1;
                    if (count == 4) 
                    {
                        count = 0;
                        data.writeByte(work[0] << 2 | (work[1] & 255) >> 4);
                        ++filled;
                        if (work[2] == -1) 
                        {
                            break;
                        }
                        data.writeByte(work[1] << 4 | (work[2] & 255) >> 2);
                        ++filled;
                        if (work[3] == -1) 
                        {
                            break;
                        }
                        data.writeByte(work[2] << 6 | work[3]);
                        ++filled;
                    }
                }
                ++loc2;
            }
            return;
        }

        public function drain():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=data.position;
            data.position = 0;
            loc1.writeBytes(data, 0, data.length);
            data.position = loc2;
            loc1.position = 0;
            filled = 0;
            return loc1;
        }

        public function flush():flash.utils.ByteArray
        {
            if (!(count > 0)) 
            {
            };
            return drain();
        }

        public function reset():void
        {
            data = new flash.utils.ByteArray();
            count = 0;
            filled = 0;
            return;
        }

        public function toByteArray():flash.utils.ByteArray
        {
            var loc1:*=flush();
            reset();
            return loc1;
        }

        internal static const ESCAPE_CHAR_CODE:Number=61;

        internal static const inverse:Array=[64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 62, 64, 64, 64, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 64, 64, 64, 64, 64, 64, 64, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 64, 64, 64, 64, 64, 64, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64];

        internal var count:int=0;

        internal var data:flash.utils.ByteArray;

        internal var filled:int=0;

        internal var work:Array;
    }
}


//  class Calculations
package utils 
{
    import __AS3__.vec.*;
    import core.*;
    import core.activities.*;
    import core.route.*;
    import core.route.interfaces.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import utils.converter.*;
    
    public class Calculations extends Object
    {
        public function Calculations()
        {
            super();
            return;
        }

        public static function calculateCalories(arg1:Object, arg2:Object, arg3:String=null):Number
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc2:*=null;
            var loc7:*=0;
            var loc5:*=NaN;
            var loc8:*=null;
            var loc4:*=null;
            var loc6:*=0;
            if (arg2.heartrate == 0) 
            {
                return 0;
            }
            if (canCalculateCalories(arg1, arg2)) 
            {
                loc3 = arg2.heartrate;
                loc1 = arg1.hrMax;
                loc2 = arg1.gender;
                loc7 = arg1.age;
                loc5 = arg1.hasOwnProperty("bodyWeight") ? arg1.bodyWeight : arg1.weight;
                loc8 = arg1.hasOwnProperty("bodyWeightUnit") ? arg1.bodyWeightUnit : arg1.weightUnit;
                loc4 = new utils.converter.WeightConverter();
                if (arg3 != null) 
                {
                    loc4.inputFormat = arg3;
                    loc4.outputFormat = "g";
                    loc5 = loc4.convert(loc5);
                }
                loc4.inputFormat = "g";
                loc4.outputFormat = "kg";
                loc5 = loc4.convert(loc5);
                if (loc2 != "male") 
                {
                    loc6 = (-1.68 + 0.043 * loc3 - 0.105 * loc5 + 0.095 * loc7 + 0.00134 * loc3 * loc5 - 0.0011 * loc3) / 60;
                }
                else 
                {
                    loc6 = (-1.68 + 0.043 * loc3 - 0.105 * loc5 + 0.095 * loc7 + 10.84 + 0.00134 * loc3 * loc5 - 0.106 * loc3 - 0.0011 * loc3 * loc7 - 0.101 * loc5 - 0.107 * loc7 + 0.00119 * loc3 * loc5 + 0.0011 * loc3 * loc7) / 60;
                }
                if (loc6 < 0) 
                {
                    loc6 = 0;
                }
                loc6 = loc6 * arg2.trainingTime / 100;
                if (arg1.hasOwnProperty("caloriesDifferenceFactor") && loc6 > 0) 
                {
                    loc6 = loc6 - loc6 * arg1.caloriesDifferenceFactor;
                }
            }
            return loc6;
        }

        public static function calculateCaloriesDifferenceFactor(arg1:core.activities.Activity, arg2:Number, arg3:Number):void
        {
            if (arg1.caloriesDefined && arg1.caloriesDifferenceFactorDefined) 
            {
                if (arg1.caloriesDifferenceFactor == 0 && !(arg3 == 0)) 
                {
                    arg1.caloriesDifferenceFactor = (arg3 - arg2) / arg3;
                }
            }
            return;
        }

        public static function calculateCaloriesBasedOnSpeed(arg1:core.activities.Activity):void
        {
            var loc1:*=null;
            var loc6:*=NaN;
            var loc2:*=NaN;
            var loc5:*=0;
            var loc3:*=arg1.entries.length;
            var loc4:*=arg1.calories / loc3;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                loc1 = arg1.entries[loc5];
                loc1.calories = loc4;
                ++loc5;
            }
            return;
        }

        public static function calculateWeight(arg1:Number, arg2:Number):Number
        {
            return (210 - arg1 / 2 + 4 - arg2) / 0.11023;
        }

        public static function speedTimeMaximum():int
        {
            return core.MeasurementConfig.distanceFormat != "kilometer" ? 1980 : 1200;
        }

        public static function speedTimeFactor():Number
        {
            return core.MeasurementConfig.distanceFormat != "kilometer" ? 1.609344 : 1;
        }

        public static function calculateSpeedTime(arg1:Number):Number
        {
            var loc1:*=0;
            if (arg1 > 0) 
            {
                loc1 = Math.floor(1000 / arg1 * speedTimeFactor());
            }
            else 
            {
                loc1 = speedTimeMaximum();
            }
            if (loc1 > speedTimeMaximum()) 
            {
                loc1 = speedTimeMaximum();
            }
            return loc1;
        }

        public static function calculateSpeed(arg1:Number):Number
        {
            var loc1:*=0;
            if (arg1 > 0 && arg1 < speedTimeMaximum()) 
            {
                loc1 = 1000 * speedTimeFactor() / arg1;
            }
            else 
            {
                loc1 = 0;
            }
            return loc1;
        }

        public static function RDP(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:Number):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc7:*=NaN;
            var loc10:*=NaN;
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc11:*=undefined;
            var loc1:*=undefined;
            var loc2:*=undefined;
            var loc9:*=arg1[0];
            var loc8:*=arg1[(arg1.length - 1)];
            if (arg1.length < 3) 
            {
                return arg1;
            }
            var loc5:*=-1;
            var loc6:*=0;
            loc7 = 1;
            while (loc7 < (arg1.length - 1)) 
            {
                if ((loc10 = findPerpendicularDistance(arg1[loc7], loc9, loc8)) > loc6) 
                {
                    loc6 = loc10;
                    loc5 = loc7;
                }
                ++loc7;
            }
            if (loc6 > arg2) 
            {
                loc3 = arg1.slice(0, loc5 + 1);
                loc4 = arg1.slice(loc5);
                loc11 = RDP(loc3, arg2);
                loc1 = RDP(loc4, arg2);
                return loc2 = loc11.slice(0, (loc11.length - 1)).concat(loc1);
            }
            return new __AS3__.vec.Vector.<core.route.RoutePoint>(loc9, loc8);
            return null;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:Number):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc5:*=0;
            var loc11:*=0;
            var loc2:*=NaN;
            var loc9:*=null;
            var loc12:*=null;
            var loc4:*=null;
            var loc3:*=null;
            var loc8:*=new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc7:*;
            if ((loc7 = arg1.length) < 1) 
            {
                return null;
            }
            var loc10:*=0;
            var loc1:*=new __AS3__.vec.Vector.<Array>();
            var loc14:*=new Array(loc7);
            loc5 = 0;
            while (loc5 < loc7) 
            {
                loc14[loc5] = 0;
                ++loc5;
            }
            loc14[0] = 1;
            loc14[(loc7 - 1)] = 1;
            var loc6:*=0;
            if (loc7 > 2) 
            {
                loc12 = [0, (loc7 - 1)];
                loc1.push(loc12);
                while (loc1.length > 0) 
                {
                    loc9 = loc1.pop();
                    loc2 = 0;
                    loc11 = loc9[0] + 1;
                    while (loc11 < loc9[1]) 
                    {
                        if ((loc6 = distance(arg1[loc11], arg1[loc9[0]], arg1[loc9[1]])) > loc2) 
                        {
                            loc2 = loc6;
                            loc10 = loc11;
                        }
                        ++loc11;
                    }
                    if (!(loc2 > arg2)) 
                    {
                        continue;
                    }
                    loc14[loc10] = loc2;
                    loc4 = [loc9[0], loc10];
                    loc1.push(loc4);
                    loc3 = [loc10, loc9[1]];
                    loc1.push(loc3);
                }
            }
            loc5 = 0;
            loc11 = 0;
            var loc16:*=0;
            var loc15:*=arg1;
            for each (var loc13:* in loc15) 
            {
                if (loc14[loc11] != 0) 
                {
                    loc8.push(loc13);
                    ++loc5;
                }
                ++loc11;
            }
            return loc8;
        }

        public static function simplifyActivityEntries(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg2:Number):__AS3__.vec.Vector.<core.activities.ActivityEntry>
        {
            var loc5:*=0;
            var loc11:*=0;
            var loc2:*=NaN;
            var loc9:*=null;
            var loc12:*=null;
            var loc4:*=null;
            var loc3:*=null;
            var loc8:*=new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            var loc7:*;
            if ((loc7 = arg1.length) < 1) 
            {
                return null;
            }
            var loc10:*=0;
            var loc1:*=new __AS3__.vec.Vector.<Array>();
            var loc14:*=new Array(loc7);
            loc5 = 0;
            while (loc5 < loc7) 
            {
                loc14[loc5] = 0;
                ++loc5;
            }
            loc14[0] = 1;
            loc14[(loc7 - 1)] = 1;
            var loc6:*=0;
            if (loc7 > 2) 
            {
                loc12 = [0, (loc7 - 1)];
                loc1.push(loc12);
                while (loc1.length > 0) 
                {
                    loc9 = loc1.pop();
                    loc2 = 0;
                    loc11 = loc9[0] + 1;
                    while (loc11 < loc9[1]) 
                    {
                        if ((loc6 = distanceActivityEntry(arg1[loc11], arg1[loc9[0]], arg1[loc9[1]])) > loc2) 
                        {
                            loc2 = loc6;
                            loc10 = loc11;
                        }
                        ++loc11;
                    }
                    if (!(loc2 > arg2)) 
                    {
                        continue;
                    }
                    loc14[loc10] = loc2;
                    loc4 = [loc9[0], loc10];
                    loc1.push(loc4);
                    loc3 = [loc10, loc9[1]];
                    loc1.push(loc3);
                }
            }
            loc5 = 0;
            loc11 = 0;
            var loc16:*=0;
            var loc15:*=arg1;
            for each (var loc13:* in loc15) 
            {
                if (loc14[loc11] != 0) 
                {
                    loc8.push(loc13);
                    ++loc5;
                }
                ++loc11;
            }
            return loc8;
        }

        public static function distanceBetweenRoutePoints(arg1:Object, arg2:Object):Number
        {
            var loc1:*=distanceBetweenGeoPositions(arg1.latitude, arg1.longitude, arg2.latitude, arg2.longitude);
            return loc1;
        }

        public static function distanceBetweenGeoPositions(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc5:*=degreesToRadians(arg3 - arg1);
            var loc4:*=degreesToRadians(arg4 - arg2);
            var loc1:*=Math.sin(loc5 / 2) * Math.sin(loc5 / 2) + Math.sin(loc4 / 2) * Math.sin(loc4 / 2) * Math.cos(degreesToRadians(arg1)) * Math.cos(degreesToRadians(arg3));
            var loc2:*=2 * Math.atan2(Math.sqrt(loc1), Math.sqrt(1 - loc1));
            var loc3:*;
            return loc3 = 6371 * loc2 * 1000;
        }

        public static function indexOfNearestRoutePoint(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:core.route.RoutePoint):int
        {
            var loc5:*=0;
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc6:*=-1;
            var loc4:*=arg1.length;
            loc5 = 0;
            while (loc5 < loc4) 
            {
                loc1 = arg1[loc5];
                loc2 = Calculations.distanceBetweenRoutePoints(arg2, loc1);
                if (isNaN(loc3) || loc2 < loc3) 
                {
                    loc3 = loc2;
                    loc6 = loc5;
                }
                ++loc5;
            }
            return loc6;
        }

        public static function degreesToRadians(arg1:Number):Number
        {
            return arg1 * 3.14159265359 / 180;
        }

        public static function calculateAge(arg1:Object):Number
        {
            var loc1:*=null;
            var loc4:*=NaN;
            var loc6:*=NaN;
            var loc5:*=NaN;
            var loc2:*=0;
            var loc3:*=new Date();
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                loc1 = (arg1 as core.settings.interfaces.IBirthDate).birthDate;
                loc4 = 0;
                loc6 = 0;
                loc4 = (loc5 = loc3.getTime() - loc1.getTime()) / 86400000;
                loc2 = Math.floor(loc4 / 365.24);
                if ((loc6 = Math.floor((loc4 - loc2 * 365.24) / 30.4375)) == 12) 
                {
                    loc6 = 11;
                }
            }
            else if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc2 = loc3.fullYear - (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            return loc2;
        }

        public static function calculateFitStartValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 70 / 100;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.7);
        }

        public static function calculateFitEndValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 7999 / 10000;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.8);
        }

        public static function calculateFatStartValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 55 / 100;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.55);
        }

        public static function calculateFatEndValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 6999 / 10000;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.7);
        }

        public static function calculateThreeZonesValues(arg1:core.settings.Settings):void
        {
            if (arg1 is core.settings.interfaces.IThreeZones && arg1 is core.settings.interfaces.IHRmax) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone1 = Math.round(55 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).startZone2 = Math.round(70 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).startZone3 = Math.round(80 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).endZone3 = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            return;
        }

        public static function calculateHRMax(arg1:core.settings.Settings):void
        {
            var loc3:*=NaN;
            var loc2:*=(arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            var loc1:*=(arg1 as core.settings.interfaces.IGender).gender;
            if (arg1 is core.settings.interfaces.IBirthDate || arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc3 = Calculations.calculateAge(arg1);
            }
            else if (arg1 is core.settings.interfaces.IAge) 
            {
                loc3 = (arg1 as core.settings.interfaces.IAge).age;
            }
            var loc4:*=loc1;
            while ("male" === loc4) 
            {
                (arg1 as core.settings.interfaces.IHRmax).hrMax = Math.round(210 - loc3 / 2 - 0.05 * loc2 / 1000 * 2.2046 + 4);
            }
        }

        internal static function canCalculateCalories(arg1:Object, arg2:Object):Boolean
        {
            return arg1.hasOwnProperty("hrMax") && arg1.hasOwnProperty("gender") && arg1.hasOwnProperty("age") && (arg1.hasOwnProperty("bodyWeight") || arg1.hasOwnProperty("weight")) && (arg1.hasOwnProperty("bodyWeightUnit") || arg1.hasOwnProperty("weightUnit")) && arg1.hasOwnProperty("samplingRate") && arg2.hasOwnProperty("heartrate");
        }

        internal static function findPerpendicularDistance(arg1:core.route.RoutePoint, arg2:core.route.RoutePoint, arg3:core.route.RoutePoint):Number
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc2:*=NaN;
            if (arg2.longitude != arg3.longitude) 
            {
                loc3 = (arg3.latitude - arg2.latitude) / (arg3.longitude - arg2.longitude);
                loc2 = arg2.latitude - loc3 * arg2.longitude;
                loc1 = Math.abs(loc3 * arg1.longitude - arg1.latitude + loc2) / Math.sqrt(Math.pow(loc3, 2) + 1);
            }
            else 
            {
                loc1 = Math.abs(arg1.longitude - arg2.longitude);
            }
            return loc1;
        }

        internal static function distance(arg1:core.route.interfaces.ILatLon, arg2:core.route.interfaces.ILatLon, arg3:core.route.interfaces.ILatLon):Number
        {
            if (arg2.equalsRoutePoint(arg3)) 
            {
                return distanceBetweenRoutePoints(arg3, arg1);
            }
            var loc8:*=arg1.latitude;
            var loc2:*=arg1.longitude;
            var loc7:*=arg2.latitude;
            var loc5:*=arg2.longitude;
            var loc6:*=arg3.latitude;
            var loc4:*=arg3.longitude;
            var loc3:*=loc6 - loc7;
            var loc1:*=loc4 - loc5;
            var loc11:*=((loc8 - loc7) * loc3 + (loc2 - loc5) * loc1) / (loc3 * loc3 + loc1 * loc1);
            var loc10:*=new core.route.RoutePoint();
            var loc9:*=new core.route.RoutePoint();
            if (loc11 <= 0) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc7;
                loc9.longitude = loc5;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            if (loc11 >= 1) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc6;
                loc9.longitude = loc4;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            loc10.latitude = loc8 - loc7;
            loc10.longitude = loc2 - loc5;
            loc9.latitude = loc11 * (loc6 - loc7);
            loc9.longitude = loc11 * (loc4 - loc5);
            return distanceBetweenRoutePoints(loc10, loc9);
        }

        internal static function distanceActivityEntry(arg1:core.activities.ActivityEntry, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):Number
        {
            if (arg2.equalsRoutePoint(arg3)) 
            {
                return distanceBetweenRoutePoints(arg3, arg1);
            }
            var loc8:*=arg1.latitude;
            var loc2:*=arg1.longitude;
            var loc7:*=arg2.latitude;
            var loc5:*=arg2.longitude;
            var loc6:*=arg3.latitude;
            var loc4:*=arg3.longitude;
            var loc3:*=loc6 - loc7;
            var loc1:*=loc4 - loc5;
            var loc11:*=((loc8 - loc7) * loc3 + (loc2 - loc5) * loc1) / (loc3 * loc3 + loc1 * loc1);
            var loc10:*=new core.route.RoutePoint();
            var loc9:*=new core.route.RoutePoint();
            if (loc11 <= 0) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc7;
                loc9.longitude = loc5;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            if (loc11 >= 1) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc6;
                loc9.longitude = loc4;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            loc10.latitude = loc8 - loc7;
            loc10.longitude = loc2 - loc5;
            loc9.latitude = loc11 * (loc6 - loc7);
            loc9.longitude = loc11 * (loc4 - loc5);
            return distanceBetweenRoutePoints(loc10, loc9);
        }
    }
}


//  class ChecksumUtil
package utils 
{
    public class ChecksumUtil extends Object
    {
        public function ChecksumUtil()
        {
            super();
            return;
        }

        public static function calculateCrcValue(arg1:Array, arg2:uint=0):uint
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.length;
            while (loc3 < loc1) 
            {
                loc2 = loc2 + arg1[loc3];
                ++loc3;
            }
            return (loc2 = loc2 + arg2) & 255;
        }

        public static function addCommandChecksumm(arg1:Array, arg2:uint=0):Array
        {
            arg1.push(calculateCrcValue(arg1, arg2));
            return arg1;
        }
    }
}


//  class GUID
package utils 
{
    import flash.system.*;
    
    public class GUID extends Object
    {
        public function GUID()
        {
            super();
            return;
        }

        public static function create():String
        {
            var loc1:*=new Date();
            var loc4:*=loc1.getTime();
            var loc3:*=Math.random() * 1.79769313486e+308;
            var loc6:*=flash.system.Capabilities.serverString;
            counter = (counter + 1);
            var loc5:*;
            var loc2:*=(loc5 = calculate(loc4 + loc6 + loc3 + counter).toUpperCase()).substring(0, 8) + "-" + loc5.substring(8, 12) + "-" + loc5.substring(12, 16) + "-" + loc5.substring(16, 20) + "-" + loc5.substring(20, 32);
            return loc2;
        }

        internal static function calculate(arg1:String):String
        {
            return hex_sha1(arg1);
        }

        internal static function hex_sha1(arg1:String):String
        {
            return binb2hex(core_sha1(str2binb(arg1), arg1.length * 8));
        }

        internal static function core_sha1(arg1:Array, arg2:Number):Array
        {
            var loc7:*=NaN;
            var loc11:*=NaN;
            var loc6:*=NaN;
            var loc10:*=NaN;
            var loc13:*=NaN;
            var loc15:*=arg2 >> 5;
            var loc16:*=arg1[loc15] | 128 << 24 - arg2 % 32;
            arg1[loc15] = loc16;
            arg1[(arg2 + 64 >> 9 << 4) + 15] = arg2;
            var loc14:*=new Array(80);
            var loc1:*=1732584193;
            var loc2:*=-271733879;
            var loc3:*=-1732584194;
            var loc4:*=271733878;
            var loc5:*=-1009589776;
            loc7 = 0;
            while (loc7 < arg1.length) 
            {
                loc11 = loc1;
                var loc12:*=loc2;
                loc6 = loc3;
                var loc8:*=loc4;
                var loc9:*=loc5;
                loc10 = 0;
                while (loc10 < 80) 
                {
                    if (loc10 < 16) 
                    {
                        loc14[loc10] = arg1[loc7 + loc10];
                    }
                    else 
                    {
                        loc14[loc10] = rol(loc14[loc10 - 3] ^ loc14[loc10 - 8] ^ loc14[loc10 - 14] ^ loc14[loc10 - 16], 1);
                    }
                    loc13 = safe_add(safe_add(rol(loc1, 5), sha1_ft(loc10, loc2, loc3, loc4)), safe_add(safe_add(loc5, loc14[loc10]), sha1_kt(loc10)));
                    loc5 = loc4;
                    loc4 = loc3;
                    loc3 = rol(loc2, 30);
                    loc2 = loc1;
                    loc1 = loc13;
                    ++loc10;
                }
                loc1 = safe_add(loc1, loc11);
                loc2 = safe_add(loc2, loc12);
                loc3 = safe_add(loc3, loc6);
                loc4 = safe_add(loc4, loc8);
                loc5 = safe_add(loc5, loc9);
                loc7 = loc7 + 16;
            }
            return new Array(loc1, loc2, loc3, loc4, loc5);
        }

        internal static function sha1_ft(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            if (arg1 < 20) 
            {
                return arg2 & arg3 | ~arg2 & arg4;
            }
            if (arg1 < 40) 
            {
                return arg2 ^ arg3 ^ arg4;
            }
            if (arg1 < 60) 
            {
                return arg2 & arg3 | arg2 & arg4 | arg3 & arg4;
            }
            return arg2 ^ arg3 ^ arg4;
        }

        internal static function sha1_kt(arg1:Number):Number
        {
            return arg1 < 20 ? 1518500249 : arg1 < 40 ? 1859775393 : arg1 < 60 ? -1894007588 : -899497514;
        }

        internal static function safe_add(arg1:Number, arg2:Number):Number
        {
            var loc2:*=(arg1 & 65535) + (arg2 & 65535);
            var loc1:*=(arg1 >> 16) + (arg2 >> 16) + (loc2 >> 16);
            return loc1 << 16 | loc2 & 65535;
        }

        internal static function rol(arg1:Number, arg2:Number):Number
        {
            return arg1 << arg2 | arg1 >>> 32 - arg2;
        }

        internal static function str2binb(arg1:String):Array
        {
            var loc2:*=NaN;
            var loc1:*=[];
            var loc3:*=255;
            loc2 = 0;
            while (loc2 < arg1.length * 8) 
            {
                var loc4:*=loc2 >> 5;
                var loc5:*=loc1[loc4] | (arg1.charCodeAt(loc2 / 8) & loc3) << 24 - loc2 % 32;
                loc1[loc4] = loc5;
                loc2 = loc2 + 8;
            }
            return loc1;
        }

        internal static function binb2hex(arg1:Array):String
        {
            var loc3:*=NaN;
            var loc1:*=new String("");
            var loc2:*=new String("0123456789abcdef");
            loc3 = 0;
            while (loc3 < arg1.length * 4) 
            {
                loc1 = loc1 + (loc2.charAt(arg1[loc3 >> 2] >> (3 - loc3 % 4) * 8 + 4 & 15) + loc2.charAt(arg1[loc3 >> 2] >> (3 - loc3 % 4) * 8 & 15));
                ++loc3;
            }
            return loc1;
        }

        internal static var counter:Number=0;
    }
}


//  class ISO8601Util
package utils 
{
    public class ISO8601Util extends Object
    {
        public function ISO8601Util()
        {
            super();
            return;
        }

        public function formatExtendedDateTime(arg1:Date):String
        {
            return formatExtendedDate(arg1) + "T" + formatExtendedTime(arg1) + "Z";
        }

        public function formatBasicDateTime(arg1:Date):String
        {
            return formatBasicDate(arg1) + "T" + formatBasicTime(arg1) + "Z";
        }

        public function parseDateTimeString(arg1:String):Date
        {
            arg1 = arg1.replace(new RegExp("-|:|T|Z", "g"), "");
            var loc1:*=parseBasicDate(arg1.substr(0, 8));
            loc1 = parseBasicTime(arg1.substr(8, 6), loc1);
            return loc1;
        }

        public function parseBasicDate(arg1:String, arg2:Date=null):Date
        {
            if (arg2 == null) 
            {
                arg2 = new Date();
            }
            arg2.setUTCFullYear(convertYear(arg1), convertMonth(arg1), convertDate(arg1));
            return arg2;
        }

        public function parseBasicTime(arg1:String, arg2:Date=null):Date
        {
            if (arg2 == null) 
            {
                arg2 = new Date();
            }
            arg2.setUTCHours(convertHours(arg1), convertMinutes(arg1), convertSeconds(arg1));
            return arg2;
        }

        public function formatExtendedDate(arg1:Date):String
        {
            return formatYear(arg1.getUTCFullYear()) + "-" + formatMonth(arg1.getUTCMonth()) + "-" + formatDate(arg1.getUTCDate());
        }

        public function formatBasicDate(arg1:Date):String
        {
            return formatYear(arg1.getUTCFullYear()) + formatMonth(arg1.getUTCMonth()) + formatDate(arg1.getUTCDate());
        }

        public function formatExtendedTime(arg1:Date):String
        {
            return formatTimeChunk(arg1.getUTCHours()) + ":" + formatTimeChunk(arg1.getUTCMinutes()) + ":" + formatTimeChunk(arg1.getUTCSeconds());
        }

        public function formatBasicTime(arg1:Date):String
        {
            return formatTimeChunk(arg1.getUTCHours()) + formatTimeChunk(arg1.getUTCMinutes()) + formatTimeChunk(arg1.getUTCSeconds());
        }

        internal function convertYear(arg1:String):int
        {
            arg1 = arg1.substr(0, 4);
            return parseInt(arg1);
        }

        internal function convertMonth(arg1:String):int
        {
            arg1 = arg1.substr(4, 2);
            var loc1:*=(parseInt(arg1) - 1);
            return loc1;
        }

        internal function convertDate(arg1:String):int
        {
            arg1 = arg1.substr(6, 2);
            return parseInt(arg1);
        }

        internal function convertHours(arg1:String):int
        {
            arg1 = arg1.substr(0, 2);
            return parseInt(arg1);
        }

        internal function convertMinutes(arg1:String):int
        {
            arg1 = arg1.substr(2, 2);
            return parseInt(arg1);
        }

        internal function convertSeconds(arg1:String):int
        {
            arg1 = arg1.substr(4, 2);
            return parseInt(arg1);
        }

        internal function formatYear(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + "0" + "0" + loc1;
            }
            else if (arg1 < 100) 
            {
                loc1 = "0" + "0" + loc1;
            }
            else if (arg1 < 1000) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatMonth(arg1:int):String
        {
            ++arg1;
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatDate(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatTimeChunk(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal const COLON:String=":";

        internal const DASH:String="-";

        internal const T:String="T";

        internal const ZERO:String="0";

        internal const ZULU:String="Z";
    }
}


//  class ItemRendererDataObjectBase
package utils 
{
    public class ItemRendererDataObjectBase extends Object
    {
        public function ItemRendererDataObjectBase(arg1:String="", arg2:Object=null)
        {
            super();
            label = arg1;
            data = arg2;
            return;
        }

        public var data:Object;

        public var label:String;
    }
}


//  class LanguageManager
package utils 
{
    public class LanguageManager extends Object
    {
        public function LanguageManager()
        {
            super();
            return;
        }

        public static function getString(arg1:String, arg2:Array=null, arg3:String=null):String
        {
            return getStringFunction("language", arg1, arg2, arg3) as String;
        }

        public static const DEFAULT_LANGUAGE_PACK:String="language";

        public static var getStringFunction:Function;
    }
}


//  class LogEntrySearch
package utils 
{
    import __AS3__.vec.*;
    
    public class LogEntrySearch extends Object
    {
        public function LogEntrySearch(arg1:String="iterative")
        {
            super();
            _mode = arg1;
            return;
        }

        public function search(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String, arg4:Boolean=false, arg5:Boolean=false, arg6:Boolean=false):int
        {
            return searchIterativ(arg1, arg2, arg3);
        }

        public function searchIterativ(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String):int
        {
            var loc1:*=0;
            var loc2:*=0;
            loc1 = 0;
            while (loc1 < arg2.length) 
            {
                if (arg2[loc1][arg3] == arg1) 
                {
                    return loc1;
                }
                if (arg2[loc1][arg3] > arg1) 
                {
                    return loc2;
                }
                loc2 = loc1;
                ++loc1;
            }
            return loc2;
        }

        public function searchNearestIndex(arg1:Number, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg3:String):int
        {
            var loc4:*=0;
            var loc5:*=NaN;
            var loc3:*=null;
            var loc2:*;
            if ((loc2 = arg2.length) <= 1) 
            {
                return 0;
            }
            var loc6:*=-1;
            var loc8:*=0;
            var loc1:*=true;
            var loc7:*=-1;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                if ((loc3 = arg2[loc4] as Object).hasOwnProperty(arg3)) 
                {
                    if ((loc5 = Math.abs(loc3[arg3] - arg1)) <= loc8 || loc1) 
                    {
                        loc8 = loc5;
                        loc6 = loc4;
                    }
                }
                else 
                {
                    return -1;
                }
                loc1 = false;
                if (loc5 > loc7 && !(loc7 == -1)) 
                {
                    return loc6;
                }
                loc7 = loc5;
                ++loc4;
            }
            return loc6;
        }

        public static const MODE_ITERATIVE:String="iterative";

        public static const MODE_RECURSIVE:String="recursive";

        protected var _mode:String;
    }
}


//  class PolylineUtil
package utils 
{
    import __AS3__.vec.*;
    import core.gps.*;
    import core.route.*;
    
    public class PolylineUtil extends Object
    {
        public function PolylineUtil()
        {
            super();
            return;
        }

        internal function encodePoly(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>):void
        {
            this.longlat = arg1;
            return;
        }

        public function getStartEntryBearing():Number
        {
            if (startEntryBearingLatLongStart && startEntryBearingLatLongEnd) 
            {
                startEntryBearing = new core.gps.LatLonHelper(startEntryBearingLatLongStart, startEntryBearingLatLongEnd).angle();
            }
            return startEntryBearing;
        }

        public function decodePoly(arg1:String):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc11:*=0;
            var loc6:*=null;
            this.encoded = arg1;
            this.longlat = new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc8:*=0;
            var loc3:*=this.encoded.length;
            var loc10:*=0;
            var loc4:*=0;
            var loc7:*=0;
            var loc9:*=0;
        }

        internal const START_ENTRY_BEARING_POINT_END:uint=5;

        internal const START_ENTRY_BEARING_POINT_START:uint=1;

        public static const PRECISION_5:uint=10000;

        public static const PRECISION_6:uint=100000;

        public var encoded:String;

        public var longlat:__AS3__.vec.Vector.<core.route.RoutePoint>;

        internal var _precision:uint=100000;

        internal var startEntryBearing:Number;

        internal var startEntryBearingLatLongEnd:core.route.RoutePoint;

        internal var startEntryBearingLatLongStart:core.route.RoutePoint;
    }
}


//  class Util
package utils 
{
    public class Util extends Object
    {
        public function Util()
        {
            super();
            return;
        }

        public static function toArray(arg1:*):Array
        {
            var loc1:*=[];
            var loc4:*=0;
            var loc3:*=arg1;
            for each (var loc2:* in loc3) 
            {
                loc1.push(loc2);
            }
            return loc1;
        }
    }
}


