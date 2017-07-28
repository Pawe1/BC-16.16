//package format
//  class AltitudeFormat
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


//  class BodySizeFormat
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


//  class CDATAFormat
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


//  class ClockFormat
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


//  class DateFormat
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


//  class DistanceFormat
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


//  class ExpansionFormat
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


//  class FuelConsumptionFormat
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


//  class FuelEconomyFormat
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


//  class GPSFormat
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


//  class SpeedFormat
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


//  class TemperatureFormat
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


//  class TimeFormatterConstants
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


