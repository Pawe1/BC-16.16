//package formatter
//  class AltitudeFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class AltitudeFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function AltitudeFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public function get inputType():String
        {
            return this._inputType;
        }

        public function set inputType(arg1:String):void
        {
            this._inputType = arg1;
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                if (this.outputFeed) 
                {
                    arg1 = Math.round(arg1 as Number);
                }
                loc3 = new RegExp("M+");
                loc4 = new RegExp("C+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = int(arg1).toString();
                }
                else 
                {
                    loc10 = new frontend.formatter.NumberFormatter();
                    loc10.fractionalDigits = loc5[0].toString().length;
                    loc6 = loc10.format(arg1);
                }
                loc7 = loc6.split(",");
                loc8 = this.formatString;
                loc8 = loc8.replace(loc3, loc7[0]);
                if (loc7.length == 2) 
                {
                    loc8 = loc8.replace(loc4, loc7[1]);
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc9 = super.format(loc8);
                return loc9;
            }
            return null;
        }

        public static const INPUT_FEET:String="ft";

        public static const INPUT_METER:String="m";

        internal var _formatString:String="M";

        internal var _inputType:String="m";

        public var outputFeed:Boolean=false;
    }
}


//  class CadenceFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class CadenceFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function CadenceFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc2:*=null;
            var loc1:*=parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc3:*=this.rounding;
            switch (loc3) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            this.useGrouping = true;
            this.groupingSeparator = String.fromCharCode(8201);
            this.groupingPattern = "3";
            this.fractionalDigits = 0;
            loc2 = super.format(loc1);
            return loc2;
        }

        public var rounding:String;
    }
}


//  class CaloriesFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class CaloriesFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function CaloriesFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            if (arg1 == null) 
            {
                return "0";
            }
            var loc1:*=parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc3:*=this.rounding;
            switch (loc3) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            this.useGrouping = true;
            this.groupingSeparator = String.fromCharCode(8201);
            this.groupingPattern = "3";
            this.fractionalDigits = 0;
            var loc2:*=super.format(loc1);
            return loc2;
        }

        public var rounding:String;
    }
}


//  class CustomDateTimeFormatter
package frontend.formatter 
{
    import backend.utils.*;
    import core.*;
    import flash.globalization.*;
    import utils.format.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class CustomDateTimeFormatter extends Object implements utils.interfaces.ICustomDateTimeFormatter
    {
        public function CustomDateTimeFormatter()
        {
            super();
            this._dateFormatter = new utils.formatter.DateFormatterMx();
            return;
        }

        public function get dateStyle():String
        {
            return this._dateStyle;
        }

        public function set dateStyle(arg1:String):void
        {
            this._dateStyle = arg1;
            return;
        }

        public function get timeStyle():String
        {
            return this._timeStyle;
        }

        public function set timeStyle(arg1:String):void
        {
            this._timeStyle = arg1;
            return;
        }

        public function setStyle(arg1:String, arg2:*):void
        {
            return;
        }

        public function format(arg1:Object):String
        {
            var loc1:*=null;
            if (this.dateStyle == flash.globalization.DateTimeStyle.SHORT) 
            {
                if (core.MeasurementConfig.dateFormat != utils.format.DateFormat.EUROPEAN) 
                {
                    loc1 = utils.formatter.DateFormatterMx.US_FORMAT;
                }
                else 
                {
                    loc1 = utils.formatter.DateFormatterMx.EU_FORMAT;
                }
            }
            if (this.timeStyle == flash.globalization.DateTimeStyle.SHORT) 
            {
                if (loc1 != "") 
                {
                    loc1 = loc1 + " - ";
                }
                loc1 = loc1 + backend.utils.DataUtils.clockFormat;
            }
            this._dateFormatter.formatString = loc1;
            return this._dateFormatter.format(arg1);
        }

        internal var _dateStyle:String="none";

        internal var _timeStyle:String="none";

        internal var _dateFormatter:utils.formatter.DateFormatterMx;
    }
}


//  class DistanceFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class DistanceFormatter extends Object implements utils.interfaces.ICustomFormatter
    {
        public function DistanceFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public function format(arg1:Object):String
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                loc1 = new RegExp("M+");
                loc2 = new RegExp("K+");
                loc3 = loc1.exec(this.formatString);
                loc5 = 0;
                if (loc3 == null) 
                {
                    loc4 = (arg1 as Number).toFixed(0);
                }
                else 
                {
                    loc5 = loc3[0].toString().length;
                    loc4 = new RegExp("[-]*\\d+\\.*\\d{0," + loc5 + "}|[-]*\\d+").exec(arg1 + "")[0] + "";
                }
                loc6 = loc4.split(".");
                loc7 = this.formatString;
                loc7 = loc7.replace(loc2, loc6[0]);
                loc8 = "";
                if (loc6[1] != null) 
                {
                    loc8 = loc6[1];
                }
                while (loc5 > loc8.length) 
                {
                    loc8 = loc8 + "0";
                }
                loc7 = loc7.replace(loc1, loc8);
                return loc7;
            }
            return null;
        }

        internal var _formatString:String="K,MM";
    }
}


//  class ExpansionFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class ExpansionFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function ExpansionFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                loc3 = new RegExp("M+");
                loc4 = new RegExp("C+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = int(arg1).toString();
                }
                else 
                {
                    fractionalDigits = loc5[0].toString().length;
                    loc6 = super.format(arg1);
                }
                loc6 = loc6.replace(",", ".");
                loc7 = loc6.split(".");
                loc8 = this.formatString;
                loc8 = loc8.replace(loc3, loc7[0]);
                if (loc7.length != 2) 
                {
                    loc8 = loc8.replace(loc4, 0);
                }
                else 
                {
                    loc8 = loc8.replace(loc4, loc7[1]);
                }
                return loc8;
            }
            return null;
        }

        public static const INPUT_FEET:String="ft";

        public static const INPUT_METER:String="m";

        internal var _formatString:String="M,C";
    }
}


//  class FuelEconomyFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class FuelEconomyFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function FuelEconomyFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                loc3 = new RegExp("B+");
                loc4 = new RegExp("A+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = (arg1 as Number).toFixed(0);
                }
                else 
                {
                    loc6 = (arg1 as Number).toFixed(loc5[0].toString().length);
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc7 = loc6.split(".");
                loc8 = super.format(loc7[0]);
                if (loc8) 
                {
                    loc7[0] = loc8;
                }
                loc9 = this.formatString;
                loc9 = loc9.replace(loc3, loc7[0]);
                if (loc7.length == 2) 
                {
                    loc9 = loc9.replace(loc4, loc7[1]);
                }
                return loc9;
            }
            return null;
        }

        internal var _formatString:String="B,AA";
    }
}


//  class GhostDistanceDecoderFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class GhostDistanceDecoderFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function GhostDistanceDecoderFormatter()
        {
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=NaN;
            if (arg1 == null) 
            {
                return "0";
            }
            loc1 = parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            loc1 = Math.round(loc1);
            this.useGrouping = false;
            this.fractionalDigits = 2;
            var loc2:*=super.format(loc1);
            return loc2;
        }
    }
}


//  class HeartrateFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class HeartrateFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function HeartrateFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc2:*=null;
            var loc1:*=parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc3:*=this.rounding;
            switch (loc3) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            this.useGrouping = true;
            this.groupingSeparator = SEPERATOR;
            this.groupingPattern = "3";
            this.fractionalDigits = 0;
            loc2 = super.format(loc1);
            return loc2;
        }

        public static const SEPERATOR:String=String.fromCharCode(8201);

        public var rounding:String;
    }
}


//  class InclineFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class InclineFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function InclineFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=parseInt(super.format(arg1));
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc2:*=this.rounding;
            switch (loc2) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            return loc1.toString();
        }

        public var rounding:String;
    }
}


//  class IntensityFactorFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class IntensityFactorFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function IntensityFactorFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "0";
                this.fractionalDigits = 3;
                loc1 = super.format(arg1);
                return loc1;
            }
            return null;
        }

        public var rounding:String;
    }
}


//  class LinkBackendInitializer
package frontend.formatter 
{
    import backend.utils.container.*;
    import core.user.interfaces.*;
    import handler.*;
    import init.*;
    import init.interfaces.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class LinkBackendInitializer extends init.BackendInitializer
    {
        public function LinkBackendInitializer()
        {
            super();
            return;
        }

        public override function createAltitudeFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.AltitudeFormatter();
        }

        public override function createCadenceFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.CadenceFormatter();
        }

        public override function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.CaloriesFormatter();
        }

        public override function createDateFormatterMx():utils.interfaces.ICustomFormatter
        {
            return new utils.formatter.DateFormatterMx();
        }

        public override function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            return new frontend.formatter.CustomDateTimeFormatter();
        }

        public override function createDistanceFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.DistanceFormatter();
        }

        public override function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.GhostDistanceDecoderFormatter();
        }

        public override function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.HeartrateFormatter();
        }

        public override function createInclineFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.InclineFormatter();
        }

        public override function createPowerFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.PowerFormatter();
        }

        public override function createSpeedFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.SpeedFormatter();
        }

        public override function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            var loc1:*=new frontend.formatter.TimeFormatter();
            loc1.formatString = "MM:SS";
            return loc1;
        }

        public override function createTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            return new frontend.formatter.TimeFormatter();
        }

        public override function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter
        {
            var loc1:*=new frontend.formatter.TimeFormatter();
            loc1.formatString = "HH:MM";
            return loc1;
        }

        public override function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            return new backend.utils.container.CustomListCollection(arg1);
        }

        public override function getSportHandler():init.interfaces.ISportHandler
        {
            return handler.SportHandler.getInstance();
        }

        public override function getUserhandler():core.user.interfaces.IUserHandler
        {
            return handler.UserHandler.getInstance();
        }

        public static function getInstance():frontend.formatter.LinkBackendInitializer
        {
            if (!_instance) 
            {
                _instance = new LinkBackendInitializer();
                init.BackendInitializer.setInstance(_instance);
            }
            return _instance;
        }

        internal static var _instance:frontend.formatter.LinkBackendInitializer;
    }
}


//  class NumberBaseRoundType
package frontend.formatter 
{
    public class NumberBaseRoundType extends Object
    {
        public function NumberBaseRoundType()
        {
            super();
            return;
        }

        public static const DOWN:String="down";

        public static const NEAREST:String="nearest";

        public static const UP:String="up";
    }
}


//  class NumberFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class NumberFormatter extends Object implements utils.interfaces.ICustomFormatterBase
    {
        public function NumberFormatter()
        {
            super();
            return;
        }

        public function format(arg1:Object):String
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            if (arg1 == null) 
            {
                return null;
            }
            var loc1:*=Number(arg1);
            if (this.fractionalDigits > -1) 
            {
                loc2 = loc1.toFixed(this.fractionalDigits);
            }
            else 
            {
                loc2 = loc1.toString();
            }
            if (this.useGrouping) 
            {
                if (this.fractionalDigits > 0) 
                {
                    loc3 = (loc2.length - this.fractionalDigits - 1) % parseInt(this.groupingPattern);
                }
                else 
                {
                    loc3 = loc2.length % parseInt(this.groupingPattern);
                }
                loc4 = loc2.slice(0, loc3);
                loc5 = loc2.slice(loc3).replace(new RegExp("(\\d{3})(?=\\d)", "g"), "$1" + this.groupingSeparator);
                if (loc4 && loc5) 
                {
                    loc2 = loc4 + this.groupingSeparator + loc5;
                }
                else if (loc4) 
                {
                    loc2 = loc4;
                }
                else 
                {
                    loc2 = loc5;
                }
            }
            if (this.decimalSeparator != ".") 
            {
                loc2 = loc2.replace(".", this.decimalSeparator);
            }
            return loc2;
        }

        public var decimalSeparator:String;

        public var fractionalDigits:int=-1;

        public var groupingPattern:String;

        public var groupingSeparator:String;

        public var useGrouping:Boolean=false;
    }
}


//  class PowerFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class PowerFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function PowerFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc1 = super.format(arg1);
                return loc1;
            }
            return null;
        }

        public var rounding:String;
    }
}


//  class PowerPerKGFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class PowerPerKGFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function PowerPerKGFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                useGrouping = true;
                groupingSeparator = String.fromCharCode(8201);
                groupingPattern = "3";
                fractionalDigits = 1;
                loc1 = super.format(arg1);
                return loc1;
            }
            return null;
        }

        public var rounding:String;
    }
}


//  class SeaLevelFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class SeaLevelFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function SeaLevelFormatter()
        {
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 1;
                loc1 = super.format(arg1);
                if (decimalSeparator != ".") 
                {
                    loc1 = loc1.replace(".", decimalSeparator);
                }
                return loc1;
            }
            return null;
        }
    }
}


//  class SpeedFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class SpeedFormatter extends Object implements utils.interfaces.ICustomFormatter
    {
        public function SpeedFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return null;
        }

        public function set formatString(arg1:String):void
        {
            return;
        }

        public function format(arg1:Object):String
        {
            var loc1:*="";
            if (arg1 != null) 
            {
                loc1 = (arg1 as Number).toFixed(this.precision);
                loc1 = loc1.replace(".", this.decimalSeparator);
            }
            return loc1;
        }

        public var decimalSeparator:String=",";

        public var precision:int=2;
    }
}


//  class TemperatureFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class TemperatureFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function TemperatureFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                loc3 = new RegExp("B+");
                loc4 = new RegExp("A+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = (arg1 as Number).toFixed(0);
                }
                else 
                {
                    loc6 = (arg1 as Number).toFixed(loc5[0].toString().length);
                }
                loc7 = loc6.split(".");
                loc8 = this.formatString;
                loc8 = loc8.replace(loc3, loc7[0]);
                if (loc7.length == 2) 
                {
                    loc8 = loc8.replace(loc4, loc7[1]);
                }
                return loc8;
            }
            return null;
        }

        public static const INPUT_CELSIUS:String="°C";

        public static const INPUT_FAHRENHEIT:String="°F";

        internal var _formatString:String="B,A";
    }
}


//  class TimeFormatter
package frontend.formatter 
{
    import utils.format.*;
    import utils.interfaces.*;
    
    public class TimeFormatter extends Object implements utils.interfaces.ICustomTimeFormatter
    {
        public function TimeFormatter(arg1:String=null)
        {
            super();
            if (arg1 != null) 
            {
                this.formatString = arg1;
            }
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public function get inputType():String
        {
            return this._inputType;
        }

        public function set inputType(arg1:String):void
        {
            this._inputType = arg1;
            return;
        }

        public function format(arg1:Object):String
        {
            if (arg1 == null) 
            {
                return null;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=parseInt(arg1.toString());
            if (!isNaN(loc7)) 
            {
                if (this._inputType == INPUT_MILLISECONDS) 
                {
                    loc1 = loc7 % 10;
                    loc7 = loc7 - loc1;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS) 
                {
                    loc2 = loc7 % 10;
                    loc7 = loc7 - loc2;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS) 
                {
                    loc3 = loc7 % 10;
                    loc7 = loc7 - loc3;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS) 
                {
                    loc4 = loc7 % 60;
                    loc7 = loc7 - loc4;
                    loc7 = loc7 / 60;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS || this._inputType == INPUT_MINUTES) 
                {
                    loc5 = loc7 % 60;
                    loc7 = loc7 - loc5;
                    loc7 = loc7 / 60;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS || this._inputType == INPUT_MINUTES || this._inputType == INPUT_HOURS) 
                {
                    loc6 = loc7;
                }
                return this.generateString(loc1, loc2, loc3, loc4, loc5, loc6);
            }
            return null;
        }

        internal function generateString(arg1:int, arg2:int, arg3:int, arg4:int, arg5:int, arg6:int):String
        {
            var loc1:*=arg1.toString();
            var loc2:*=arg2.toString();
            var loc3:*=arg3.toString();
            var loc4:*=arg4.toString();
            var loc5:*=arg5.toString();
            var loc6:*=arg6.toString();
            var loc7:*=new RegExp("m");
            var loc8:*=new RegExp("h");
            var loc9:*=new RegExp("t");
            var loc10:*=new RegExp("S+");
            var loc11:*=new RegExp("M+");
            var loc12:*=new RegExp("H+");
            var loc13:*=loc7.exec(this.formatString);
            var loc14:*=loc8.exec(this.formatString);
            var loc15:*=loc9.exec(this.formatString);
            var loc16:*=loc10.exec(this.formatString);
            var loc17:*=loc11.exec(this.formatString);
            var loc18:*=loc12.exec(this.formatString);
            if (!(loc17 == null) && loc17[0] == "MM" && arg5 < 10) 
            {
                loc5 = "0" + loc5;
            }
            if (!(loc16 == null) && loc16[0] == "SS" && arg4 < 10) 
            {
                loc4 = "0" + loc4;
            }
            if (!(loc18 == null) && loc18[0] == "HH" && arg6 < 10) 
            {
                loc6 = "0" + loc6;
            }
            var loc19:*=this.formatString;
            loc19 = loc19.replace(loc7, loc1);
            loc19 = loc19.replace(loc8, loc2);
            loc19 = loc19.replace(loc9, loc3);
            loc19 = loc19.replace(loc10, loc4);
            loc19 = loc19.replace(loc11, loc5);
            loc19 = loc19.replace(loc12, loc6);
            return loc19;
        }

        public static const INPUT_HOURS:String=utils.format.TimeFormatterConstants.INPUT_HOURS;

        public static const INPUT_HUNDREDTHSSECONDS:String=utils.format.TimeFormatterConstants.INPUT_HUNDREDTHSSECONDS;

        public static const INPUT_MILLISECONDS:String=utils.format.TimeFormatterConstants.INPUT_MILLISECONDS;

        public static const INPUT_MINUTES:String=utils.format.TimeFormatterConstants.INPUT_MINUTES;

        public static const INPUT_SECONDS:String=utils.format.TimeFormatterConstants.INPUT_SECONDS;

        public static const INPUT_TENSECONDS:String=utils.format.TimeFormatterConstants.INPUT_TENSECONDS;

        internal var _formatString:String="HH:MM:SS";

        internal var _inputType:String="hundredthsSecond";
    }
}


//  class WheelSizeFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class WheelSizeFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function WheelSizeFormatter()
        {
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc1 = super.format(arg1);
                return loc1;
            }
            return null;
        }
    }
}


