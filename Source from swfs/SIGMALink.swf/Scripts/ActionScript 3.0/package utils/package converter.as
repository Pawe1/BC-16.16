//package converter
//  class AltitudeConverter
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


//  class DistanceConverter
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


//  class ExpansionConverter
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


//  class FuelConsumptionConverter
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


//  class FuelEconomyConverter
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


//  class IConverter
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


//  class PowerPerWeightConverter
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


//  class SizeConverter
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


//  class SpeedConverter
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


//  class SpeedTimeConverter
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


//  class TemperatureConverter
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


//  class WeightConverter
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


