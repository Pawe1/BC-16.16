//package general
//  package interfaces
//    class IDatabase
package core.general.interfaces 
{
    public dynamic interface IDatabase
    {
        function generateDBInsert():Array;

        function generateDBSelect():Array;

        function generateDBDelete():Array;
    }
}


//    class IDate
package core.general.interfaces 
{
    public dynamic interface IDate
    {
        function get date():Date;

        function set date(arg1:Date):void;
    }
}


//    class IGeneralDataInformation
package core.general.interfaces 
{
    import __AS3__.vec.*;
    import core.units.*;
    
    public dynamic interface IGeneralDataInformation
    {
        function get dateCode():String;

        function set dateCode(arg1:String):void;

        function get description():String;

        function set description(arg1:String):void;

        function get externalLink():String;

        function set externalLink(arg1:String):void;

        function get linkedRouteId():uint;

        function set linkedRouteId(arg1:uint):void;

        function get name():String;

        function set name(arg1:String):void;

        function get participant():__AS3__.vec.Vector.<core.participant.Person>;

        function set participant(arg1:__AS3__.vec.Vector.<core.participant.Person>):void;

        function get rating():uint;

        function set rating(arg1:uint):void;

        function get serialNumber():String;

        function set serialNumber(arg1:String):void;

        function get startDate():Date;

        function set startDate(arg1:Date):void;

        function get trackProfile():uint;

        function set trackProfile(arg1:uint):void;

        function get trainingType():String;

        function set trainingType(arg1:String):void;

        function get unit():core.units.Unit;

        function set unit(arg1:core.units.Unit):void;

        function get weather():uint;

        function set weather(arg1:uint):void;

        function get wind():uint;

        function set wind(arg1:uint):void;
    }
}


//    class IImportFromDevice
package core.general.interfaces 
{
    public dynamic interface IImportFromDevice
    {
        function get alreadySaved():Boolean;

        function set alreadySaved(arg1:Boolean):void;

        function get importFromDevice():Boolean;

        function set importFromDevice(arg1:Boolean):void;

        function get isNew():Boolean;

        function set isNew(arg1:Boolean):void;

        function get isUpdate():Boolean;

        function set isUpdate(arg1:Boolean):void;
    }
}


//    class ISynchronisable
package core.general.interfaces 
{
    public dynamic interface ISynchronisable
    {
        function get GUID():String;

        function set GUID(arg1:String):void;

        function get isDeleted():Boolean;

        function set isDeleted(arg1:Boolean):void;

        function get modificationDate():Number;

        function set modificationDate(arg1:Number):void;
    }
}


//  class AlarmMode
package core.general 
{
    public class AlarmMode extends Object
    {
        public function AlarmMode()
        {
            super();
            return;
        }

        public static const EVERY_DAY:String="everyDay";

        public static const OFF:String="off";

        public static const ONE_TIME:String="oneTime";

        public static const WORK_DAY:String="workDay";
    }
}


//  class AltitudeReference
package core.general 
{
    public class AltitudeReference extends Object
    {
        public function AltitudeReference()
        {
            super();
            return;
        }

        public static var ACTUAL_ALTITUDE:String="actualAltitude";

        public static var SEA_LEVEL:String="seaLevel";
    }
}


//  class AutoLap
package core.general 
{
    public class AutoLap extends Object
    {
        public function AutoLap()
        {
            super();
            return;
        }

        public static const CALORIES:uint=3;

        public static const DISTANCE:uint=1;

        public static const OFF:uint=0;

        public static const TIME:uint=2;
    }
}


//  class AutoOffTimeUnit
package core.general 
{
    public class AutoOffTimeUnit extends core.general.BaseType
    {
        public function AutoOffTimeUnit(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.AutoOffTimeUnit
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const FIVE_MINUTES:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("5min");

        public static const OFF:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("off");

        public static const ONE_HOURS:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("1h");

        public static const THIRTY_MINUTES:core.general.AutoOffTimeUnit=new AutoOffTimeUnit("30min");

        public static const TYPES:Array=[FIVE_MINUTES, THIRTY_MINUTES, ONE_HOURS, OFF];
    }
}


//  class BaseType
package core.general 
{
    public class BaseType extends Object
    {
        public function BaseType(arg1:String=null)
        {
            super();
            data = arg1;
            return;
        }

        public function toString():String
        {
            return this.data;
        }

        public function equals(arg1:core.general.BaseType):Boolean
        {
            return !(arg1 == null) && data == arg1.data;
        }

        public var data:String;
    }
}


//  class BatteryStatus
package core.general 
{
    public class BatteryStatus extends Object
    {
        public function BatteryStatus()
        {
            super();
            return;
        }

        public static const BATTERY_EMPTY:String="empty";

        public static const BATTERY_FULL:String="full";
    }
}


//  class BikeCommon
package core.general 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class BikeCommon extends Object
    {
        public function BikeCommon()
        {
            super();
            return;
        }

        
        {
            new __AS3__.vec.Vector.<Object>(4)[0] = {"label":utils.LanguageManager.getString("BIKE_1"), "data":"bike1"};
            new __AS3__.vec.Vector.<Object>(4)[1] = {"label":utils.LanguageManager.getString("BIKE_2"), "data":"bike2"};
            new __AS3__.vec.Vector.<Object>(4)[2] = {"label":utils.LanguageManager.getString("BIKE_3"), "data":"bike3"};
            new __AS3__.vec.Vector.<Object>(4)[3] = {"label":utils.LanguageManager.getString("BIKE_NO"), "data":"noBike"};
            dp = new __AS3__.vec.Vector.<Object>(4);
        }

        public static const BIKE1:String="bike1";

        public static const BIKE2:String="bike2";

        public static const BIKE3:String="bike3";

        public static const NO_BIKE:String="noBike";

        public static var dp:__AS3__.vec.Vector.<Object>;
    }
}


//  class BikeType
package core.general 
{
    public class BikeType extends Object
    {
        public function BikeType()
        {
            super();
            return;
        }

        public static const MOUNTAIN_BIKE:String="mountainBike";

        public static const RACE_DROP:String="raceDrop";

        public static const RACE_HOODS:String="raceHoods";
    }
}


//  class Colors
package core.general 
{
    public class Colors extends Object
    {
        public function Colors()
        {
            super();
            return;
        }

        public static function brightness(arg1:Number):Number
        {
            var loc1:*=0;
            var loc2:*=hexToRgb(arg1);
            if (loc2.r > loc1) 
            {
                loc1 = loc2.r;
            }
            if (loc2.g > loc1) 
            {
                loc1 = loc2.g;
            }
            if (loc2.b > loc1) 
            {
                loc1 = loc2.b;
            }
            loc1 = loc1 / 255;
            return loc1;
        }

        public static function calculateColorWithAlpha(arg1:int, arg2:Number):int
        {
            var loc3:*=0;
            var loc1:*=null;
            var loc2:*=0;
            if (arg2 >= 0 && arg2 <= 1) 
            {
                loc1 = (arg2 * 255).toString(16);
                loc3 = (loc2 = "0x" + loc1 + "000000") + arg1;
            }
            else 
            {
                loc3 = arg1;
            }
            return loc3;
        }

        public static function brightenColor(arg1:Number, arg2:Number):Number
        {
            if (isNaN(arg2)) 
            {
                arg2 = 0;
            }
            if (arg2 > 100) 
            {
                arg2 = 100;
            }
            if (arg2 < 0) 
            {
                arg2 = 0;
            }
            var loc1:*=arg2 / 100;
            var loc2:*;
            loc2.r = (loc2 = hexToRgb(arg1)).r + (255 - loc2.r) * loc1;
            loc2.b = loc2.b + (255 - loc2.b) * loc1;
            loc2.g = loc2.g + (255 - loc2.g) * loc1;
            return rgbToHex(Math.round(loc2.r), Math.round(loc2.g), Math.round(loc2.b));
        }

        public static function darkenColor(arg1:Number, arg2:Number):Number
        {
            if (isNaN(arg2)) 
            {
                arg2 = 0;
            }
            if (arg2 > 100) 
            {
                arg2 = 100;
            }
            if (arg2 < 0) 
            {
                arg2 = 0;
            }
            var loc1:*=1 - arg2 / 100;
            var loc2:*;
            loc2.r = (loc2 = hexToRgb(arg1)).r * loc1;
            loc2.b = loc2.b * loc1;
            loc2.g = loc2.g * loc1;
            return rgbToHex(Math.round(loc2.r), Math.round(loc2.g), Math.round(loc2.b));
        }

        public static function rgbToHex(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return arg1 << 16 | arg2 << 8 | arg3;
        }

        public static function hexToRgb(arg1:Number):Object
        {
            return {"r":(arg1 & 16711680) >> 16, "g":(arg1 & 65280) >> 8, "b":arg1 & 255};
        }

        public static const AVERAGE_INCLINE:int=INCLINE;

        public static const AVERAGE_POWER:int=POWER;

        public static const AVERAGE_RISERATE:int=RISERATE;

        public static const AVERAGE_SPEED:int=SPEED;

        public static const AVERAGE_TEMPERATURE:int=TEMPERATURE;

        public static const BALANCE:int=46795;

        public static const BALANCE_DARK:int=32655;

        public static const BEST_20MIN_POWER_COLOR:int=10066329;

        public static const BEST_5K_TIME_COLOR:int=16752653;

        public static const BLACK:int=0;

        public static const BLUE:int=1542837;

        public static const BLUE_DARK:int=1014176;

        public static const BLUE_GPSIES:int=24063;

        public static const BREAK_COLOR:int=24063;

        public static const BRONZE:int=14132588;

        public static const BUTTON_BLUE:uint=3045570;

        public static const CADENCE:int=4539975;

        public static const CALORIES:int=16750910;

        public static const CHART_OUTSIDE:int=10066329;

        public static const CHART_OUTSIDE_DARK:int=7434867;

        public static const CHART_ZONE1:int=48716;

        public static const CHART_ZONE1_DARK:int=3050304;

        public static const CHART_ZONE2:int=16568846;

        public static const CHART_ZONE2_DARK:int=13544728;

        public static const CHART_ZONE3:int=13046322;

        public static const CHART_ZONE3_DARK:int=10031655;

        public static const CHART_ZONE_IN:int=48716;

        public static const CHART_ZONE_IN_DARK:int=3050304;

        public static const CHART_ZONE_OVER:int=6908265;

        public static const CHART_ZONE_OVER_DARK:int=4539975;

        public static const CHART_ZONE_UNDER:int=10066329;

        public static const CHART_ZONE_UNDER_DARK:int=7434867;

        public static const DARKESTGREY:uint=3684408;

        public static const DARKFONT:uint=3028545;

        public static const DARKGREY:uint=6710886;

        public static const DARK_BLUE:int=19931;

        public static const DARK_BLUE_DARK:int=2506104;

        public static const DEEPPINK:int=16711884;

        public static const DEEPPINT_DARK:int=10828408;

        public static const DIMGREY:int=6908265;

        public static const DIMGREY_DARK:int=4539975;

        public static const DISTANCE:int=11388486;

        public static const GOLD:int=16698419;

        public static const GREEN:int=48716;

        public static const GREEN_DARK:int=3050304;

        public static const GREEN_TRACKS:int=39168;

        public static const GREY:int=10066329;

        public static const GREY_DARK:int=7434867;

        public static const HEATRATE:int=10031655;

        public static const INCLINE:int=7747541;

        public static const INTENSITY_ZONE:int=13046322;

        public static const INTENSITY_ZONE_1:int=1542837;

        public static const INTENSITY_ZONE_1_DARK:int=1014176;

        public static const INTENSITY_ZONE_2:int=48716;

        public static const INTENSITY_ZONE_2_DARK:int=3050304;

        public static const INTENSITY_ZONE_3:int=16568846;

        public static const INTENSITY_ZONE_3_DARK:int=13544728;

        public static const INTENSITY_ZONE_4:int=13046322;

        public static const INTENSITY_ZONE_4_DARK:int=10031655;

        public static const INTENSITY_ZONE_OVER:int=6908265;

        public static const INTENSITY_ZONE_OVER_DARK:int=4539975;

        public static const INTENSITY_ZONE_UNDER:int=10066329;

        public static const INTENSITY_ZONE_UNDER_DARK:int=7434867;

        public static const INTERVAL_COLOR:int=13046322;

        public static const LAP_COLOR:int=41728;

        public static const LIGHTGREY:uint=15396337;

        public static const MAGENTA:int=11085908;

        public static const MAGENTA_DARK:int=2377349;

        public static const MIDGREY:uint=9737364;

        public static const OK_GREEN:uint=3781962;

        public static const ORANGE:int=16752653;

        public static const ORANGE_DARK:int=14123548;

        public static const PHASE_COLOR:int=8588321;

        public static const POWER:int=16755200;

        public static const POWER_NP:int=14192640;

        public static const POWER_ZONE_1:int=7747541;

        public static const POWER_ZONE_1_DARK:int=5257595;

        public static const POWER_ZONE_2:int=1542837;

        public static const POWER_ZONE_2_DARK:int=1014176;

        public static const POWER_ZONE_3:int=48716;

        public static const POWER_ZONE_3_DARK:int=3050304;

        public static const POWER_ZONE_4:int=16568846;

        public static const POWER_ZONE_4_DARK:int=13544728;

        public static const POWER_ZONE_5:int=16752653;

        public static const POWER_ZONE_5_DARK:int=14123548;

        public static const POWER_ZONE_6:int=13046322;

        public static const POWER_ZONE_6_DARK:int=10031655;

        public static const POWER_ZONE_7:int=11085908;

        public static const ALTITUDE:int=19931;

        public static const RECOVERY_COLOR:int=0;

        public static const RED:int=13046322;

        public static const RED_DARK:int=10031655;

        public static const RISERATE:int=16711884;

        public static const SILVER:int=11581372;

        public static const SLEEP_BLUE:uint=39321;

        public static const SLEEP_GREEN:uint=10079283;

        public static const SLEEP_RED:uint=16737894;

        public static const SPEED:int=3050304;

        public static const STEPS:int=2201544;

        public static const TEMPERATURE:int=11085908;

        public static const VIOLET:int=7747541;

        public static const VIOLET_DARK:int=5257595;

        public static const WHITE:int=16777215;

        public static const POWER_ZONE_7_DARK:int=2377349;

        public static const YELLOW_DARK:int=13544728;

        public static const YELLOW_GREEN:int=11067173;

        public static const YELLOW_GREEN_DARK:int=8954666;

        public static const YELLOW_ORANGE:int=16755200;

        public static const YELLOW_ORANGE_DARK:int=14192640;

        public static const ZONE:int=48716;

        public static const ZONE1:int=48716;

        public static const ZONE2:int=16568846;

        public static const ZONE3:int=13046322;

        public static const AUTO_LAP_COLOR:uint=1535255;

        public static const AVERAGE_ALTITUDE:int=19931;

        public static const AVERAGE_BALANCE:int=46795;

        public static const AVERAGE_CADENCE:int=CADENCE;

        public static const AVERAGE_HEATRATE:int=HEATRATE;

        public static const YELLOW:int=16568846;
    }
}


//  class DataType
package core.general 
{
    public class DataType extends Object
    {
        public function DataType()
        {
            super();
            return;
        }

        public static const LOG:String="log";

        public static const MEMORY:String="memory";
    }
}


//  class DistancePlusMinusStatus
package core.general 
{
    public class DistancePlusMinusStatus extends Object
    {
        public function DistancePlusMinusStatus()
        {
            super();
            return;
        }

        public static const DISTNACE_MINUS:String="minus";

        public static const DISTNACE_PLUS:String="plus";
    }
}


//  class DockingStations
package core.general 
{
    public class DockingStations extends Object
    {
        public function DockingStations()
        {
            super();
            return;
        }

        public static const DS08:String="DS08";

        public static const DS09:String="DS09";

        public static const DS12:String="DS12";

        public static const DS16:String="DS16";

        public static const DS_BLE:String="DS_BLE";

        public static const DS_BLE_ROX_11:String="DS_BLE_ROX_11";

        public static const DS_NFC:String="DS_NFC";

        public static const DS_RC_2011:String="DS_RC_2011";

        public static const DS_ROX_2011:String="DS_ROX_2011";

        public static const GPS_10:String="GPS_10";

        public static const ROX_10:String="ROX_10";

        public static const ROX_11:String="ROX_11";

        public static const ROX_7:String="ROX_7";

        public static const UFSB:String="UFSB";
    }
}


//  class DouglasPeucker
package core.general 
{
    import __AS3__.vec.*;
    
    public class DouglasPeucker extends Object
    {
        public function DouglasPeucker()
        {
            super();
            return;
        }

        public static function getSquareDistance(arg1:Object, arg2:Object, arg3:String, arg4:String):Number
        {
            var loc1:*=arg1[arg3] - arg2[arg3];
            var loc2:*=arg1[arg4] - arg2[arg4];
            return loc1 * loc1 + loc2 * loc2;
        }

        public static function getSquareSegmentDistance(arg1:Object, arg2:Object, arg3:Object, arg4:String, arg5:String):Number
        {
            var loc2:*=NaN;
            var loc4:*=arg2[arg4];
            var loc5:*=arg2[arg5];
            var loc1:*=arg3[arg4] - loc4;
            var loc3:*=arg3[arg5] - loc5;
            if (!(loc1 === 0) || !(loc3 === 0)) 
            {
                if ((loc2 = ((arg1[arg4] - loc4) * loc1 + (arg1[arg5] - loc5) * loc3) / (loc1 * loc1 + loc3 * loc3)) > 1) 
                {
                    loc4 = arg3[arg4];
                    loc5 = arg3[arg5];
                }
                else if (loc2 > 0) 
                {
                    loc4 = loc4 + loc1 * loc2;
                    loc5 = loc5 + loc3 * loc2;
                }
            }
            loc1 = arg1[arg4] - loc4;
            loc3 = arg1[arg5] - loc5;
            return loc1 * loc1 + loc3 * loc3;
        }

        public static function simplifyRadialDistance(arg1:__AS3__.vec.Vector.<Object>, arg2:Number, arg3:String, arg4:String):__AS3__.vec.Vector.<Object>
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=arg1.length;
            var loc5:*=arg1[0];
            var loc2:*=null;
            loc2 = __AS3__.vec.Vector.<Object>([loc5]);
            loc3 = 1;
            while (loc3 < loc1) 
            {
                loc4 = arg1[loc3];
                if (getSquareDistance(loc4, loc5, arg3, arg4) > arg2) 
                {
                    loc2.push(loc4);
                    loc5 = loc4;
                }
                ++loc3;
            }
            if (loc5 !== loc4) 
            {
                loc2.push(loc4);
            }
            return loc2;
        }

        public static function simplifyDouglasPeucker(arg1:__AS3__.vec.Vector.<Object>, arg2:Number, arg3:String, arg4:String):__AS3__.vec.Vector.<Object>
        {
            var loc3:*=0;
            var loc7:*=NaN;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc6:*=arg1.length;
            var loc10:*=null;
            loc10 = new __AS3__.vec.Vector.<int>(loc6);
            var loc11:*=0;
            var loc1:*;
            --loc1;
            var loc9:*=null;
            loc9 = new __AS3__.vec.Vector.<int>();
            var loc2:*=null;
            loc2 = new __AS3__.vec.Vector.<int>();
            var loc8:*=null;
            loc8 = new __AS3__.vec.Vector.<Object>();
            var loc12:*;
            loc10[loc1] = loc12 = 1;
            loc10[loc11] = loc12;
            while (loc1) 
            {
                loc7 = 0;
                loc3 = loc11 + 1;
                while (loc3 < loc1) 
                {
                    if ((loc5 = getSquareSegmentDistance(arg1[loc3], arg1[loc11], arg1[loc1], arg3, arg4)) > loc7) 
                    {
                        loc4 = loc3;
                        loc7 = loc5;
                    }
                    ++loc3;
                }
                if (loc7 > arg2) 
                {
                    loc10[loc4] = 1;
                    loc9.push(loc11);
                    loc2.push(loc4);
                    loc9.push(loc4);
                    loc2.push(loc1);
                }
                loc11 = loc9.pop();
                loc1 = loc2.pop();
            }
            loc3 = 0;
            while (loc3 < loc6) 
            {
                if (loc10[loc3]) 
                {
                    loc8.push(arg1[loc3]);
                }
                ++loc3;
            }
            return loc8;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<Object>, arg2:String="distanceAbsolute", arg3:String="altitude", arg4:Number=1, arg5:Boolean=false):__AS3__.vec.Vector.<Object>
        {
            var loc1:*=arg4 * arg4;
            if (!arg5) 
            {
                arg1 = simplifyRadialDistance(arg1, loc1, arg2, arg3);
            }
            arg1 = simplifyDouglasPeucker(arg1, loc1, arg2, arg3);
            return arg1;
        }
    }
}


//  class ErrorLoggingTyp
package core.general 
{
    public class ErrorLoggingTyp extends Object
    {
        public function ErrorLoggingTyp()
        {
            super();
            return;
        }

        public static const DESC_ABSTRACTDECODER_ABSTRACT_FUNC:String="AbstractDecoder > decodeUnitInformation: Abstract function, please override!";

        public static const DESC_ACTIVATIONHANDLER_NO_ACTIVATION_KEY:String="ActivationHandler > isActivationNumberValid: Activation key is not available";

        public static const DESC_ACTIVATIONHANDLER_NO_UNIQUE_KEY:String="ActivationHandler > generateTransmitKey: Unique key is not available";

        public static const DESC_ACTIVATIONHANDLER_UNKNOWN_REGISTER_RESULT:String="ActivationHandler > dataReceived: unknown status of register result";

        public static const DESC_ACTIVATIONHANDLER_USE_GET_INSTANCE:String="ActivationHandler > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_CONFIG_ERROR_INSERT_CONFIG:String="Config > insertConfigError: config not saved";

        public static const DESC_CONFIG_SELECT_CONFIG_ERROR:String="Config > selectConfigError: config data not selected";

        public static const DESC_CONFIG_USE_GET_INSTANCE:String="Config > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_CONFIG_WITHOUT_DATA:String="Config > selectConfigComplete: required config data not found";

        public static const DESC_CSV_INVALID_FIELD:String="CSVSpreadSheetFactory > addRow: Field is not a String";

        public static const DESC_DATABASEHANDLER_COMMIT_ERROR:String="DatabaseHandler > commitStatementsError: statement not committed";

        public static const DESC_DATABASEHANDLER_CONNECTION_ERROR:String="DatabaseHandler > openConnectionError: database not connected";

        public static const DESC_DATABASEHANDLER_DATABASE_IO_ERROR:String="DatabaseHandler:";

        public static const DESC_DATABASEHANDLER_DATABASE_SECURITY_ERROR:String="DatabaseHandler:";

        public static const DESC_DATABASEHANDLER_USE_GET_INSTANCE:String="DatabaseHandler > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_DECODE_BMP_ERROR:String="SaveFileWorker > decodeBMPBytes: ";

        public static const DESC_ENCODE_SQLRESULT_DATA_ERROR:String="SaveFileWorker > encodeSQLResultData: ";

        public static const DESC_ERROR_AGPS_DATA_URL_STREAM_ERROR:String="FirmwareUpdateHandler > The download of the A-GPS update file failed.";

        public static const DESC_ERROR_BC2316_WRONG_CRC:String="BC 23.16 > Log: incorrect checksum";

        public static const DESC_ERROR_BLE_SERVICE_READ_FAILED:String="BLEHandler > onLoaded: usb service, read failed!";

        public static const DESC_ERROR_BLE_UNIT_INFO_DYN_CHECKSUM:String="BLEHandler > decodeUnitInformation: incorrect dynamic checksum";

        public static const DESC_ERROR_BLE_UNIT_INFO_STATIC_CHECKSUM:String="BLEHandler > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_BLE_WRONG_CRC_UNIT_INFO:String="BLEDSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_CURRENT_DATABASE_CORRUPT:String="DatabaseBackup > ";

        public static const DESC_ERROR_DATABASE_CANNOT_DELETE:String="StartApplicationHandler > updateDatabaseAgain: ";

        public static const DESC_ERROR_DATABASE_NOT_EXIST:String="DataCenter2 > backup file exist but current data base file doesn\'t exist";

        public static const DESC_ERROR_DATABASE_UPDATE:String="DatabaseUpdate > update error";

        public static const DESC_ERROR_DB_RECOVERY_NOT_POSSIBLE:String="DatabaseRecovery > invalid database";

        public static const DESC_ERROR_DECODE_RC_LOG:String="RC2011Decoder > decodeLog: log not decoded";

        public static const DESC_ERROR_DELETE_MARKER:String="UnitHandler > deleteMarkerError: ";

        public static const DESC_ERROR_DELETE_TRACK_ON_UNIT_TIME_OUT:String="Delete Track timeout ";

        public static const DESC_ERROR_DELETE_TRAINING:String="TrainingHandler > deleteTraining: ";

        public static const DESC_ERROR_DELETE_TRAININGPHASE:String="TrainingHandler > deleteTrainingPhase: ";

        public static const DESC_ERROR_FILE_IMPORT:String="FileImportHandler > fileOpenError: ";

        public static const DESC_ERROR_FILE_MULTI_SELECT:String="FileImportHandler > multipleFileSelectError: ";

        public static const DESC_ERROR_FIRMWARE_UPDATE_DEVICE_INVALID_RESPONSE:String="invalid response";

        public static const DESC_ERROR_FIRMWARE_UPDATE_DEVICE_NO_RESPONSE:String="FirmwareUpdateHandler > Device not responding.";

        public static const DESC_ERROR_FIRMWARE_UPDATE_URL_STREAM_ERROR:String="FirmwareUpdateHandler > The download of the firmware update file failed.";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_EEPROM:String="GPS10Decoder > load EEPROM: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_LOG:String="GPS10Decoder > decodeLog: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_LOGHEADER:String="GPS10Decoder > decodeLogHeader: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_PAGE_HEADER_COUNT:String="GPS10Decoder > decodePageHeaderCount: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_PAUSE:String="GPS10Decoder > decodePause: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_SETTINGS:String="GPS10Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_TOTALS:String="GPS10Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_UNIT_INFO:String="GPS10DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_GPS10HANDLER_WRONG_UNIT:String="GPS10Handler > load data from unit: wrong unit";

        public static const DESC_ERROR_INSERT_ACTIVATION:String="ActivationHandler > updateActivationError: new activation data not saved";

        public static const DESC_ERROR_INSERT_ROUTE:String="UnitHandler > createNewRouteError: ";

        public static const DESC_ERROR_INSERT_SPORT:String="SportHandler > saveSport: ";

        public static const DESC_ERROR_INSERT_TRAINING:String="TrainingHandler > saveTraining: ";

        public static const DESC_ERROR_LOAD_DATA_FROM_UNIT_TIME_OUT:String="Load data timeout ";

        public static const DESC_ERROR_LOAD_SETTINGS_TIME_OUT:String="Load Settings timeout ";

        public static const DESC_ERROR_LOAD_TOTALS_TIME_OUT:String="Load Totals timeout ";

        public static const DESC_ERROR_LOAD_TRAININGS_TIME_OUT:String="Load Trainings timeout ";

        public static const DESC_ERROR_OLD_DATABASE_CORRUPT:String="DatabaseBackup > ";

        public static const DESC_ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM1:String="RC2011Decoder > decodeBatteryInformation: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM3:String="RC2011Decoder > decodeBatteryInformation: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_LOG_CHECKSUM6:String="RC2011Decoder > decodeLog: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_FAST_LAP_CHECKSUM6:String="RC2011Decoder > decodeLogFastLap: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_MARKER_CHECKSUM6:String="RC2011Decoder > decodeLogMarker: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_PAUSE_CHECKSUM6:String="RC2011Decoder > decodeLogPause: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM1:String="RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM4:String="RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum4";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_INFO_CHECKSUM6:String="RC2011Decoder > decodePageHeaderInformation: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_SETTINGS_CHECKSUM1:String="RC2011Decoder > decodeSettings: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_SETTINGS_CHECKSUM3:String="RC2011Decoder > decodeSettings: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_SN_INFO_CHECKSUM2:String="RC2011Decoder > decodeSerialNumberInformation: incorrect checksum2";

        public static const DESC_ERROR_RC2011DECODER_SN_INFO_CHECKSUM5:String="RC2011Decoder > decodeSerialNumberInformation: incorrect checksum5";

        public static const DESC_ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM1:String="RC2011Decoder > decodeTotalValues: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM3:String="RC2011Decoder > decodeTotalValues: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM1:String="RC2011Decoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM2:String="RC2011Decoder > decodeUnitInformation: incorrect checksum2";

        public static const DESC_ERROR_ROX100DECODER_SINGLETON_VIOLATION:String="Rox100Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_LOG_STATUS:String="ROX100Decoder > decodeLogStatus: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_NUMBER_OF_TRACKS:String="ROX100Decoder > decodeNumberOfTracks: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_PLANED_TRACK_HEADER:String="ROX100Decoder > decodePlanedTrackFile: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SETTINGS:String="ROX100Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SET_SETTINGS:String="ROX100Decoder > onLoaded (send settings complete): wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SET_TOTALS:String="ROX100Decoder > onLoaded (send totals complete): wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TOTALS:String="ROX100Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TRACK_DATA:String="ROX100Decoder > decodeTrackFile: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TRACK_HEADER:String="ROX100Decoder > decodeTrackFileHeader: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_UNIT_INFO:String="ROX100DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_ROX110DECODER_WRONG_CRC_SET_PROGRAM:String="ROX110Decoder > onLoaded (send program complete): wrong crc";

        public static const DESC_ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM1:String="ROX2010Decoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM2:String="ROX2010Decoder > decodeUnitInformation: incorrect checksum2";

        public static const DESC_ERROR_ROX2012DECODER_BATTERY_INFORMATION_CHECKSUM:String="RC2012Decoder > decodeBatteryInformation: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_CYCLING_CHECKSUM:String="ROX2012Decoder > decodeLogCycling: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_CYCLING_LAP_CHECKSUM:String="ROX2012Decoder > decodeLogCyclingLap: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_HIKING_CHECKSUM:String="ROX2012Decoder > decodeLogRunning: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_PAUSE_CHECKSUM:String="ROX2012Decoder > decodeLogPause: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_PAGEHEADER_INFO_CHECKSUM6:String="ROX2012Decoder > decodePageHeaderInformation: incorrect checksum6";

        public static const DESC_ERROR_ROX2012DECODER_SETTINGS_CHECKSUM:String="ROX2012Decoder > decodeSettings: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_TOTALS_CHECKSUM:String="ROX2012Decoder > decodeTotals: incorrect checksum";

        public static const DESC_ERROR_ROX2012_SERIAL_NUMBER_DECODING_CHECKSUM:String="Topline2012Decoder > decode serialnumber: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_LOG_STATUS:String="ROX70Decoder > decodeLogStatus: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_NUMBER_OF_TRACKS:String="ROX70Decoder > decodeNumberOfTracks: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_PLANED_TRACK_HEADER:String="ROX70Decoder > decodePlanedTrackFile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SETTINGS:String="ROX70Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_PROFILE:String="ROX70Decoder > onLoaded (send sport profile complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_SETTINGS:String="ROX70Decoder > onLoaded (send settings complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_TOTALS:String="ROX70Decoder > onLoaded (send totals complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SPORT_PROFILE:String="ROX70Decoder > decodeSportProfile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TOTALS:String="ROX70Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TRACK_DATA:String="ROX70Decoder > decodeTrackFile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TRACK_HEADER:String="ROX70Decoder > decodeTrackFileHeader: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_UNIT_INFO:String="ROX70DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_ROXDECODER_UNIT_INFORMATION_CHECKSUM1:String="ROXDecoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_ROXDECODER_UNIT_INFORMATION_ROX2011_DETECTED:String="ROXDecoder > decodeUnitInformation: ROX 8.1 / 9.1 on DS 2008 is not supported";

        public static const DESC_ERROR_SAVE_MARKER:String="UnitHandler > saveMarkerError: ";

        public static const DESC_ERROR_SELECT_ACTIVATION:String="ActivationHandler > selectActivationError: activations not selected";

        public static const DESC_ERROR_SELECT_SPORT:String="SportHandler > loadSportsFromDB: ";

        public static const DESC_ERROR_SELECT_STATISTIC_YEARS:String="StatisticHandler > selectYearsWithData";

        public static const DESC_ERROR_SELECT_TRAINING:String="TrainingHandler > loadTrainingsFromDB: ";

        public static const DESC_ERROR_SELECT_TRAININGPHASES:String="TrainingHandler > loadTrainingPhasesFromDB: ";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_LESS_DATA:String="Gps10Handler > Send-Response Check failed... > Less Data";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_NO_DATA:String="Gps10Handler > Send-Response Check failed... > No Data";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_OUT_OF_RANGE:String="Gps10Handler > Send-Response Check failed... > Out of Range";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_UNKNOWN_ERROR:String="Gps10Handler > Send-Response Check failed... > Unknown Error";

        public static const DESC_ERROR_SEND_TOTALS_TIME_OUT:String="Send Totlas timeout ";

        public static const DESC_ERROR_SEND_TRACK_TO_UNIT_TIME_OUT:String="Send Track timeout ";

        public static const DESC_ERROR_SEND_TRAININGS_TIME_OUT:String="Send Trainings timeout ";

        public static const DESC_ERROR_SETTING_DATA_TOPLINE2009_NOT_VALIDE:String="ToplineDecoder > decodeSettings: data is not valid";

        public static const DESC_ERROR_SETTING_DATA_TOPLINE2012_NOT_VALIDE:String="Topline2012Decoder > decodeSettings: data is not valid";

        public static const DESC_ERROR_TRIP_DATA_TOPLINE2009_NOT_VALIDE:String="ToplineDecoder > decodeMemory: data is not valid";

        public static const DESC_ERROR_UNIT_IN_SLEEP_MODE:String="ToplineDecoder > decodeUnitInformation: Unit in sleep mode";

        public static const DESC_ERROR_UNIT_NOT_IN_SILENCE_MODE:String="RC2011Decoder > decodeUnitInformation: Unit not in silence mode";

        public static const DESC_ERROR_UNKNOWN_OS_CAPABILITIES:String="USB > Initialisation of USBService failed";

        public static const DESC_ERROR_USB:String="USB > receivedDataUncomplete: ";

        public static const DESC_ERROR_USB_SERVICE_FILE_NOT_FOUND:String="USB > Executable USBService file not found";

        public static const DESC_ERROR_USB_SERVICE_READ_FAILED:String="RC2011Handler > onLoaded: usb service, read failed!";

        public static const DESC_ERROR_USB_SERVICE_SCAN_USB_PORT:String="USB > scanUSBPortsError: ";

        public static const DESC_ERROR_USB_SERVICE_STANDARD_ERROR_DATA_HANDLER:String="USB > standardErrorDataHandler: ";

        public static const DESC_ERROR_USB_SERVICE_TOO_MANY_DATA_RECEIVED:String="USB > standardOutputDataHandler: ";

        public static const DESC_ERROR_USB_SERVICE_UNIT_HANDLER_IS_NULL:String="USB > standardOutputDataHandler: current unit handler is null, ";

        public static const DESC_ERROR_WRITE_DATA_ON_UNIT:String="RC2011Handler > onSent: write data error, checksum incorrect";

        public static const DESC_EXPORTDATA_ERROR_WRITE_EXPORT_FILE_01:String="ExportData > saveFileSelected: file couldn\'t write";

        public static const DESC_EXPORTDATA_ERROR_WRITE_EXPORT_FILE_02:String="ExportData > onFileIOError: file couldn\'t write";

        public static const DESC_FILTERHANDLER_ERROR_WRITE_FILTER_FILE:String="FilterHandler > saveFilterIOError: file couldn\'t write";

        public static const DESC_FILTERHANDLER_SFF_NOT_READ:String="FilterHandler > loadFilterListIOError: .sff file couldn\'t read";

        public static const DESC_HANDLECOMMANDMESSAGE_ERROR:String="SaveFileWorker > handleCommandMessage: ";

        public static const DESC_HANDLER_FACTORY_DOCKING_STATION_IN_NOT_SUPPORTED:String="Not the same Unit";

        public static const DESC_HANDLER_FACTORY_NOT_THE_SAME_UNIT:String="Not the same Unit";

        public static const DESC_HANDLER_FACTORY_UNIT_IS_NOT_SUPPORTED:String="Unit is not supported";

        public static const DESC_INFO_ACTIVATION:String="ActivationHandler: ";

        public static const DESC_INFO_CHECK_CONNECTION_TIME_OUT:String="Unit Handler > checkConnectionTimeout ";

        public static const DESC_INFO_CONFIG_UPDATE:String="Config > save: ";

        public static const DESC_INFO_ERROR_USB_SERVICE_READ_FAILED:String="RC2011Handler > read data error... repeat command";

        public static const DESC_INFO_ERROR_WRITE_DATA_ON_UNIT:String="RC2011Handler > write data error... repeat command";

        public static const DESC_INFO_REGET_LOG_DATA_COMMAND:String="ROX100Decoder: reget last session - ";

        public static const DESC_INFO_ROX_ON_WRONG_MENU:String="ROX on wrong menu";

        public static const DESC_LOGROX_NO_ENTRIES_TO_GENERATE_CSV:String="LogROX9 > generateCSV: no log entries found";

        public static const DESC_LOGVIEW_NO_ENTRIES_FOUND:String="LogView > logEntriesLoadComplete: no entries found";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_CSV:String="Log > generateCSV: Abstract function, please override!";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_PWX:String="Log > generatePWX: Abstract function, please override!";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_XLSX:String="Log > generateXLSX: Abstract function, please override!";

        public static const DESC_LOG_PARTICIPANT_INVALID_DECLARATION:String="Log > set participant: p_participant must be an array of Person";

        public static const DESC_LOG_ROX_UNKNOWN_SMF_VERSION:String="LogROX9 > fromSLF: unknown .slf version";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_CSV:String="Memory > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_PWX:String="Memory > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_XLSX:String="Memory > generateXLSX: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_CSV:String="MemoryBikeComputer > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_PWX:String="MemoryBikeComputer > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_XLSX:String="MemoryBikeComputer > generateXLSX: Abstract function, please override!";

        public static const DESC_MEMORY_PARTICIPANT_INVALID_DECLARATION:String="Memory > set participant: p_participant must be an array of Person";

        public static const DESC_MEMORY_ROX_UNKNOWN_SMF_VERSION:String="MemoryROX > fromSMF: unknown .smf version";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_CSV:String="MemoryRunningComputer > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_PWX:String="MemoryRunningComputer > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_XLSX:String="MemoryRunningComputer > generateXLSX: Abstract function, please override!";

        public static const DESC_OLDUNITHANDLER_UNIT_NOT_SUPPORTED:String="OldUnitHandler > getNewSerialNumber: Unit is not supported - unknown serialnumber";

        public static const DESC_PERSON_ILLEGAL_TYPE_OF_GENDER:String="Person > set gender: Illegal type of gender";

        public static const DESC_RC2011DECODER_USE_GET_INSTANCE:String="RC2011Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_ROXDECODER_USE_GET_INSTANCE:String="ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_SPORTPROFILE_NOT_SAVED:String="Sportprofiles > Error while saving sportprofile";

        public static const DESC_TOPLINE2012DECODER_USE_GET_INSTANCE:String="Topline2012Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_TOPLINEDECODER_USE_GET_INSTANCE:String="ToplineDecoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_DELETE_UNIT:String="UnitCollectionManager > insertUnitInDBError: unit not deleted";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_INSERT_UNIT:String="UnitCollectionManager > insertUnitInDBError: unit not saved";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_SELECT_UNIT:String="UnitCollectionManager > loadUnitFromDBError: units not selected";

        public static const DESC_UNITHANDLER_ERROR_DELETE_LOG:String="UnitHandler > deleteLogFromDBError: log not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_LOG_PERSON:String="UnitHandler > deletePersonError: log person not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_MEMORY:String="UnitHandler > deleteMemoryFromDBError: memory not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_PERSON_FROM_ALL:String="UnitHandler > deletePersonFromAllTablesError: Can not delete person from all tables";

        public static const DESC_UNITHANDLER_ERROR_DELETE_SETTINGS:String="UnitHandler > deleteSettingsFromDBError: settings not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_TOTALS:String="UnitHandler > deleteTotalsFromDBError: totals not deleted";

        public static const DESC_UNITHANDLER_ERROR_GET_LOG_DATA:String="UnitHandler > getLogData: required log data not found";

        public static const DESC_UNITHANDLER_ERROR_GET_MEMORY_DATA:String="UnitHandler > getMemoryData: required memory data not found";

        public static const DESC_UNITHANDLER_ERROR_INSERT_ENTRY:String="UnitHandler > insertEntryError: log entries not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_LOG:String="UnitHandler > insertLogError: log not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_MEMORY:String="UnitHandler > insertMemoryError: memory not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_MEMORY_PERSON:String="UnitHandler > insertPersonToMemoryError: memory person not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_PERSON:String="UnitHandler > insertPersonError: person not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_SETTINGS:String="UnitHandler > insertSettingsError: settings not saved";

        public static const DESC_UNITHANDLER_ERROR_SELECT_ALL_PERSONS:String="UnitHandler > selectAllPersonsError: Can not select all persons";

        public static const DESC_UNITHANDLER_ERROR_SELECT_CURRENT_SETTINGS:String="UnitHandler > selectCurrentSettingsError: current settings not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_COMPLETE:String="UnitHandler > selectLogError: log not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_ENTRIES:String="UnitHandler > loadLogEntriesError: log entries not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_PERSON:String="UnitHandler > selectLogPersonError: log person not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_MEMORY:String="UnitHandler > selectMemoryError: memory not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_MEMORY_PERSON:String="UnitHandler > selectMemoryPersonError: memory person not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_SETTINGS_DATA:String="UnitHandler > getSettingsData: required settings data not found";

        public static const DESC_UNITHANDLER_FILE_NOT_EXIST:String="UnitHandler > createEmptySettings: file does not exist";

        public static const DESC_UNIT_ABSTRACT_FUNC_FROM_DB:String="Unit > fromDB: Abstract function, please override!";

        public static const DESC_UNIT_ABSTRACT_FUNC_FROM_SUF:String="Unit > fromSUF: Abstract function, please override!";

        public static const DESC_WARNING_CANNOT_CREATE_SETTING_DATA:String="CurrentUnitHandler > onLoaded: Can not create setting data";

        public static const DESC_WARNING_CANNOT_CREATE_UNIT:String="CurrentUnitHandler > onLoaded: Can not create unit";

        public static const DESC_WARNING_DECODING_CHECKSUM6_CORRUPT:String="ROXDecoder > Decoding > Wrong checksum6";

        public static const DESC_WARNING_DECODING_CHECKSUM7_CORRUPT:String="ROXDecoder > Decoding > Wrong checksum7";

        public static const DESC_WARNING_MULTIPLE_WRONG_HR_VALUES:String="RC2011Decoder > smoothHR: wrong heartrate values";

        public static const DESC_WARNING_MULTIPLE_WRONG_SPEE_VALUES:String="RC2011Decoder > smoothSpeed: wrong speed values";

        public static const DESC_WARNING_NOT_SUPPORTED_MODEL:String="Gps10Decoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_NOT_SUPPORTET_2012_MODEL:String="Topline2012Decoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_NOT_SUPPORTET_MODEL:String="ToplineDecoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_UNIT_DO_NOT_MATCH:String="Topline2016Handler > onLoaded: Unit do not match";

        public static const DESC_WARNING_UNSUPPORTED_OR_NO_COMMUNICATION_MODE:String="Topline2016Handler > unsupported or no communication mode";

        public static const DESC_WARNING_USB_SERVICE_TOO_MANY_DS_FOUND:String="USB > Too many docking stations found...";

        public static const DESC_WARNING_WRONG_ALTITUDE_VALUE:String="ROXDecoder > Decoding > Wrong altitude value";

        public static const DESC_WARNING_WRONG_CADENCE_VALUE:String="ROX2010Decoder > Decoding > Wrong cadence value";

        public static const DESC_WARNING_WRONG_HEARTRATE_VALUE:String="ROXDecoder > Decoding > Wrong heartrate value";

        public static const DESC_WARNING_WRONG_SPEED_VALUE:String="ROXDecoder > Decoding > Wrong speed value";

        public static const DESC_WRITE_FILE_ERROR:String="SaveFileWorker > writeToFile: ";

        public static const DESC_XLSX_INVALID_FIELD:String="XLSXSpreadSheetFactory > addRow: Field is not a String";

        public static const ERROR_ABSTRACTDECODER_ABSTRACT_FUNC:int=10063;

        public static const ERROR_ACTIVATIONHANDLER_NO_ACTIVATION_KEY:int=100001;

        public static const ERROR_ACTIVATIONHANDLER_SINGLETON_VIOLATION:int=10070;

        public static const ERROR_ACTIVATIONHANDLER_UNIQUE_KEY_IS_NULL:int=100000;

        public static const ERROR_ACTIVATIONHANDLER_UNKOWN_REGISTER_RESULT:int=100002;

        public static const ERROR_AGPS_DATA_URL_STREAM_ERROR:int=1058;

        public static const ERROR_BC2316_WRONG_CRC:int=537;

        public static const ERROR_BLE_SERVICE_READ_FAILED:int=118;

        public static const ERROR_BLE_UNIT_INFO_DYN_CHECKSUM:int=10133;

        public static const ERROR_BLE_UNIT_INFO_STATIC_CHECKSUM:int=10134;

        public static const ERROR_BLE_WRONG_CRC_UNIT_INFO:int=523;

        public static const ERROR_COMMIT_STATEMENTS:int=1000001;

        public static const ERROR_CONFIG_SINGLETON_VIOLATION:int=10071;

        public static const ERROR_CSV_INVALID_FIELD:int=10003;

        public static const ERROR_CURRENT_DATABASE_CORRUPT:int=1000035;

        public static const ERROR_DATABASEHANDLER_SINGLETON_VIOLATION:int=10072;

        public static const ERROR_DATABASE_CANNOT_DELETE:int=1000044;

        public static const ERROR_DATABASE_CONNECTION:int=1000000;

        public static const ERROR_DATABASE_IO:int=1000030;

        public static const ERROR_DATABASE_NOT_EXIST:int=1000036;

        public static const ERROR_DATABASE_SECURITY_ERROR:int=1000031;

        public static const ERROR_DATABASE_UPDATE:int=1000059;

        public static const ERROR_DB_RECOVERY_NOT_POSSIBLE:int=1000047;

        public static const ERROR_DECODE_BMP_ERROR:int=1000051;

        public static const ERROR_DECODE_RC_LOG:int=10121;

        public static const ERROR_DELETE_LOG:int=1000023;

        public static const ERROR_DELETE_LOG_PERSON:int=1000024;

        public static const ERROR_DELETE_MARKER:int=1000040;

        public static const ERROR_DELETE_MEMORY:int=1000019;

        public static const ERROR_DELETE_PERSON_FROM_ALL:int=10098;

        public static const ERROR_DELETE_SETTINGS:int=1000012;

        public static const ERROR_DELETE_TOTLAS:int=1000045;

        public static const ERROR_DELETE_TRACK_ON_UNIT_TIME_OUT:int=129;

        public static const ERROR_DELETE_TRAINING:int=1000057;

        public static const ERROR_DELETE_TRAININGPHASE:int=1000057;

        public static const ERROR_DELETE_UNIT:int=1000028;

        public static const ERROR_DOCKING_STATION_IN_NOT_SUPPORTED:int=10093;

        public static const ERROR_EMPTY_CONFIG:int=1000003;

        public static const ERROR_EMPTY_SETTINGS_FILE_NOT_EXIST:int=1035;

        public static const ERROR_ENCODE_SQLRESULT_DATA_ERROR:int=1000052;

        public static const ERROR_FILE_IMPORT:int=1059;

        public static const ERROR_FILE_MULTI_SELECT:int=1060;

        public static const ERROR_FIRMWARE_UPDATE_DEVICE_INVALID_RESPONSE:int=1061;

        public static const ERROR_FIRMWARE_UPDATE_DEVICE_NO_RESPONSE:int=1058;

        public static const ERROR_FIRMWARE_UPDATE_URL_STREAM_ERROR:int=1057;

        public static const ERROR_GET_LOG_DATA:int=1000013;

        public static const ERROR_GET_MEMORY_DATA:int=1000016;

        public static const ERROR_GPS10DECODER_LOG_INFO_CHECKSUM:int=10156;

        public static const ERROR_GPS10DECODER_PAGEHEADER_INFO_CHECKSUM:int=10155;

        public static const ERROR_GPS10DECODER_WRONG_CRC_EEPROM:int=549;

        public static const ERROR_GPS10DECODER_WRONG_CRC_PAGE_HEADER_COUNT:int=550;

        public static const ERROR_GPS10DECODER_WRONG_CRC_SETTINGS:int=547;

        public static const ERROR_GPS10DECODER_WRONG_CRC_TOTALS:int=548;

        public static const ERROR_GPS10DECODER_WRONG_CRC_UNIT_INFO:int=533;

        public static const ERROR_GPS10HANDLER_WRONG_UNIT:int=548;

        public static const ERROR_HANDLECOMMANDMESSAGE_ERROR:int=1000053;

        public static const ERROR_INSERT_ACTIVATION:int=1000033;

        public static const ERROR_INSERT_CONFIG:int=1000025;

        public static const ERROR_INSERT_ENTRY:int=1000005;

        public static const ERROR_INSERT_LOG:int=1000004;

        public static const ERROR_INSERT_MEMORY:int=1000020;

        public static const ERROR_INSERT_MEMORY_PERSON:int=1000021;

        public static const ERROR_INSERT_PERSON:int=1000006;

        public static const ERROR_INSERT_ROUTE:int=1000046;

        public static const ERROR_INSERT_SETTINGS:int=1000011;

        public static const ERROR_INSERT_SPORT:int=1000048;

        public static const ERROR_INSERT_TRAINING:int=1000054;

        public static const ERROR_INSERT_UNIT:int=1000027;

        public static const ERROR_INVALID_DATABASE:int=3;

        public static const ERROR_LOAD_DATA_FROM_UNIT_TIME_OUT:int=130;

        public static const ERROR_LOAD_SETTINGS_TIME_OUT:int=125;

        public static const ERROR_LOAD_TOTALS_TIME_OUT:int=126;

        public static const ERROR_LOAD_TRACK_FROM_DEVICE:int=10135;

        public static const ERROR_LOAD_TRAININGS_TIME_OUT:int=131;

        public static const ERROR_LOGGING_INFO:int=1;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_CSV:int=10054;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_PWX:int=10056;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_XLSX:int=10055;

        public static const ERROR_LOG_PARTICIPANT_INVALID_DECLARATION:int=10005;

        public static const ERROR_LOG_TO_VIEW_UNCOMPLETE:int=1051;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_CSV:int=10057;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_PWX:int=10059;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_XLSX:int=10058;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_CSV:int=10064;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_PWX:int=10066;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_XLSX:int=10065;

        public static const ERROR_MEMORY_PARTICIPANT_INVALID_DECLARATION:int=10006;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_CSV:int=10094;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_PWX:int=10096;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_XLSX:int=10095;

        public static const ERROR_NFC_SERVICE_STANDARD_ERROR_DATA_HANDLER:int=216;

        public static const ERROR_NOT_THE_SAME_UNIT:int=10092;

        public static const ERROR_NO_LOG_ENTRIES_TO_GENERATE_CSV:int=10067;

        public static const ERROR_OLD_DATABASE_CORRUPT:int=1000034;

        public static const ERROR_OLD_DC_VERSION:int=2;

        public static const ERROR_PERSON_ILLEGAL_TYPE_OF_GENDER:int=10007;

        public static const ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM1:int=10109;

        public static const ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM3:int=10108;

        public static const ERROR_RC2011DECODER_LOG_CHECKSUM6:int=10113;

        public static const ERROR_RC2011DECODER_LOG_FAST_LAP_CHECKSUM6:int=10116;

        public static const ERROR_RC2011DECODER_LOG_MARKER_CHECKSUM6:int=10114;

        public static const ERROR_RC2011DECODER_LOG_PAUSE_CHECKSUM6:int=10115;

        public static const ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM1:int=10112;

        public static const ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM4:int=10111;

        public static const ERROR_RC2011DECODER_PAGEHEADER_INFO_CHECKSUM6:int=10110;

        public static const ERROR_RC2011DECODER_SETTINGS_CHECKSUM1:int=10105;

        public static const ERROR_RC2011DECODER_SETTINGS_CHECKSUM3:int=10104;

        public static const ERROR_RC2011DECODER_SINGLETON_VIOLATION:int=10099;

        public static const ERROR_RC2011DECODER_SN_INFO_CHECKSUM2:int=10102;

        public static const ERROR_RC2011DECODER_SN_INFO_CHECKSUM5:int=10103;

        public static const ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM1:int=10107;

        public static const ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM3:int=10106;

        public static const ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM1:int=10101;

        public static const ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM2:int=10100;

        public static const ERROR_ROX100DECODER_SINGLETON_VIOLATION:int=10124;

        public static const ERROR_ROX100DECODER_WRONG_CRC_LOG_STATUS:int=516;

        public static const ERROR_ROX100DECODER_WRONG_CRC_NUMBER_OF_TRACKS:int=518;

        public static const ERROR_ROX100DECODER_WRONG_CRC_PLANED_TRACK_HEADER:int=520;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SETTINGS:int=512;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SET_SETTINGS:int=513;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SET_TOTALS:int=515;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TOTALS:int=514;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TRACK_DATA:int=519;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TRACK_HEADER:int=517;

        public static const ERROR_ROX100DECODER_WRONG_CRC_UNIT_INFO:int=511;

        public static const ERROR_ROX110DECODER_WRONG_CRC_SET_PROGRAM:int=536;

        public static const ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM1:int=10118;

        public static const ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM2:int=10119;

        public static const ERROR_ROX2012DECODER_BATTERY_INFORMATION_CHECKSUM:int=10126;

        public static const ERROR_ROX2012DECODER_LOG_CYCLING_CHECKSUM:int=10130;

        public static const ERROR_ROX2012DECODER_LOG_CYCLING_LAP_CHECKSUM:int=10131;

        public static const ERROR_ROX2012DECODER_LOG_HIKING_CHECKSUM:int=10132;

        public static const ERROR_ROX2012DECODER_LOG_PAUSE_CHECKSUM:int=10129;

        public static const ERROR_ROX2012DECODER_PAGEHEADER_INFO_CHECKSUM6:int=10125;

        public static const ERROR_ROX2012DECODER_SETTINGS_CHECKSUM:int=10127;

        public static const ERROR_ROX2012DECODER_TOTALS_CHECKSUM:int=10128;

        public static const ERROR_ROX2012_SERIAL_NUMBER_DECODING_CHECKSUM:int=522;

        public static const ERROR_ROX70DECODER_WRONG_CRC_LOG_STATUS:int=524;

        public static const ERROR_ROX70DECODER_WRONG_CRC_NUMBER_OF_TRACKS:int=525;

        public static const ERROR_ROX70DECODER_WRONG_CRC_PLANED_TRACK_HEADER:int=526;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SETTINGS:int=527;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_PROFILE:int=535;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_SETTINGS:int=528;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_TOTALS:int=529;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SPORT_PROFILE:int=534;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TOTALS:int=530;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TRACK_DATA:int=531;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TRACK_HEADER:int=532;

        public static const ERROR_ROX70DECODER_WRONG_CRC_UNIT_INFO:int=533;

        public static const ERROR_ROXDECODER_SINGLETON_VIOLATION:int=10074;

        public static const ERROR_ROXDECODER_UNIT_INFORMATION_CHECKSUM1:int=10120;

        public static const ERROR_ROXDECODER_UNIT_INFORMATION_ROX2011_DETECTED:int=10122;

        public static const ERROR_SAVE_MARKER:int=1000041;

        public static const ERROR_SAVE_SPORTPROFILES_DATA:int=1000094;

        public static const ERROR_SELECT_ACTIVATION:int=1000032;

        public static const ERROR_SELECT_ALL_PERSONS:int=10097;

        public static const ERROR_SELECT_CONFIG:int=1000002;

        public static const ERROR_SELECT_CURRENT_SETTINGS:int=1000007;

        public static const ERROR_SELECT_LOG:int=1000014;

        public static const ERROR_SELECT_LOG_ENTRIES:int=1000022;

        public static const ERROR_SELECT_LOG_PERSON:int=1000017;

        public static const ERROR_SELECT_MEMORY:int=1000015;

        public static const ERROR_SELECT_MEMORY_PERSON:int=1000018;

        public static const ERROR_SELECT_SETTINGS_DATA:int=1000009;

        public static const ERROR_SELECT_SPORT:int=1000049;

        public static const ERROR_SELECT_SPORTPROFILES_DATA:int=1000010;

        public static const ERROR_SELECT_STATISTIC_YEARS:int=1000058;

        public static const ERROR_SELECT_TRAINING:int=1000055;

        public static const ERROR_SELECT_TRAININGPHASES:int=1000056;

        public static const ERROR_SELECT_UNIT:int=1000026;

        public static const ERROR_SEND_CHECK_RESPONSE_LESS_DATA:int=900002;

        public static const ERROR_SEND_CHECK_RESPONSE_NO_DATA:int=900001;

        public static const ERROR_SEND_CHECK_RESPONSE_OUT_OF_RANGE:int=900003;

        public static const ERROR_SEND_CHECK_RESPONSE_UNKNOWN_ERROR:int=900004;

        public static const ERROR_SEND_TOTALS_TIME_OUT:int=127;

        public static const ERROR_SEND_TRACK_TO_UNIT_TIME_OUT:int=128;

        public static const ERROR_SEND_TRAININGS_TIME_OUT:int=132;

        public static const ERROR_SETTING_DATA_TOPLINE2009_NOT_VALIDE:int=101;

        public static const ERROR_SETTING_DATA_TOPLINE2012_NOT_VALIDE:int=124;

        public static const ERROR_TOPLINE2012DECODER_SINGLETON_VIOLATION:int=10123;

        public static const ERROR_TOPLINEDECODER_SINGLETON_VIOLATION:int=10075;

        public static const ERROR_TRIP_DATA_TOPLINE2009_NOT_VALIDE:int=107;

        public static const ERROR_UNCAUGHT_EXCEPTION:int=-1;

        public static const ERROR_UNIT_ABSTRACT_FUNC_FROM_DB:int=10061;

        public static const ERROR_UNIT_ABSTRACT_FUNC_FROM_SUF:int=10060;

        public static const ERROR_UNIT_IN_SLEEP_MODE:int=100;

        public static const ERROR_UNIT_IS_NOT_SUPPORTED:int=10091;

        public static const ERROR_UNIT_NOT_IN_SILENCE_MODE:int=109;

        public static const ERROR_UNIT_NOT_SUPPORTED:int=10078;

        public static const ERROR_UNKNOWN_OS_CAPABILITIES:int=111;

        public static const ERROR_UNKNOWN_SLF_VERSION:int=10090;

        public static const ERROR_UNKNOWN_SMF_VERSION:int=10069;

        public static const ERROR_USB:int=110;

        public static const ERROR_USB_SERVICE_FILE_NOT_FOUND:int=112;

        public static const ERROR_USB_SERVICE_READ_FAILED:int=118;

        public static const ERROR_USB_SERVICE_SCAN_USB_PORT:int=114;

        public static const ERROR_USB_SERVICE_STANDARD_ERROR_DATA_HANDLER:int=116;

        public static const ERROR_USB_SERVICE_TOO_MANY_DATA_RECEIVED:int=115;

        public static const ERROR_USB_SERVICE_UNIT_HANDLER_IS_NULL:int=117;

        public static const ERROR_WRITE_DATA_ON_UNIT:int=108;

        public static const ERROR_WRITE_FILE_ERROR:int=1000050;

        public static const ERROR_XLSX_INVALID_FIELD:int=10004;

        public static const INFO_ACTIVATION:int=1000038;

        public static const INFO_CHECK_CONNECTION_TIME_OUT:int=120;

        public static const INFO_CONFIG_UPDATE:int=1000037;

        public static const INFO_ERROR_USB_SERVICE_READ_FAILED:int=122;

        public static const INFO_ERROR_WRITE_DATA_ON_UNIT:int=121;

        public static const INFO_REGET_LOG_DATA_COMMAND:int=521;

        public static const INFO_ROX_ON_WRONG_MENU:int=123;

        public static const IO_ERROR_EXPORT_DATA_WRITE_FILE_01:int=1043;

        public static const IO_ERROR_EXPORT_DATA_WRITE_FILE_02:int=1044;

        public static const IO_ERROR_READ_FILTER_FILE:int=1021;

        public static const IO_ERROR_WRITE_FILTER_FILE:int=1022;

        public static const WARNING_CANNOT_CREATE_SETTING_DATA:int=10002;

        public static const WARNING_CANNOT_CREATE_UNIT:int=10001;

        public static const WARNING_DECODING_CHECKSUM6_CORRUPT:int=505;

        public static const WARNING_DECODING_CHECKSUM7_CORRUPT:int=506;

        public static const WARNING_MULTIPLE_WRONG_HR_VALUES:int=509;

        public static const WARNING_MULTIPLE_WRONG_SPEE_VALUES:int=508;

        public static const WARNING_NOT_SUPPORTET_MODEL:int=51133;

        public static const WARNING_NOT_SUPPORTET_TOPLINE2009_MODEL:int=501;

        public static const WARNING_NOT_SUPPORTET_TOPLINE2012_MODEL:int=510;

        public static const WARNING_UNIT_DO_NOT_MATCH:int=10010;

        public static const WARNING_UNSUPPORTED_OR_NO_COMMUNICATION_MODE:int=10011;

        public static const WARNING_USB_SERVICE_TOO_MANY_DS_FOUND:int=113;

        public static const WARNING_WRONG_ALTITUDE_VALUE:int=502;

        public static const WARNING_WRONG_CADENCE_VALUE:int=507;

        public static const WARNING_WRONG_HEARTRATE_VALUE:int=504;

        public static const WARNING_WRONG_SPEED_VALUE:int=503;
    }
}


//  class Favorites
package core.general 
{
    public class Favorites extends Object
    {
        public function Favorites()
        {
            super();
            return;
        }

        public static const DONT_DISPLAY_INDEX:int=40;

        public static const DONT_DISPLAY_INDEXES:Array=[8, 9, 17];

        public static const FAVORITES:Array=["Cycling Distance", "Cycling Rise Time", "Cycling Average", "Cycling Maximum", "Cycling Distance+", "Cycling Distance-", "Cycling Avg Cadence", "Cycling Max Cadence", "Ghost Race", "Cycling Don\'t Display", "Heartrate Zone Bar", "Heartrate Average", "Heartrate Maximum", "Heartrate Time Zone 1", "Heartrate Time Zone 2", "Heartrate Time Zone 3", "Heartrate Calories", "Heartrate Don\'t Display", "Temperature Actual", "Temperature Minimum", "Temperature Maximum", "Temperature Don\'t Display", "Uphill Climb", "Uphill Max Altitude", "Uphill Distance", "Uphill Trip Time", "Uphill Avg Incline", "Uphill Rise Rate", "Uphill M Rise Rate", "Uphill Max Incline", "Uphill Average", "Uphill Don\'t Display", "Downhill Descend", "Downhill Distance", "Downhill Trip Time", "Downhill Avg Incline", "Downhill Rise Rate", "Downhill M. Rise Rate", "Downhill Max Incline", "Downhill Average", "Downhill Don\'t Display", "Time Clock", "Time Date", "Time Stopwatch", "Time Countdown", "Time Alarm Clock", "Time Don\'t Display"];

        public static const FAVORITES_GUI:Array=["Cycling Distance", "Cycling Rise Time", "Cycling Average", "Cycling Maximum", "Cycling Distance+", "Cycling Distance-", "Cycling Avg Cadence", "Cycling Max Cadence", "Heartrate Zone Bar", "Heartrate Average", "Heartrate Maximum", "Heartrate Time Zone 1", "Heartrate Time Zone 2", "Heartrate Time Zone 3", "Heartrate Calories", "Temperature Actual", "Temperature Minimum", "Temperature Maximum", "Uphill Climb", "Uphill Max Altitude", "Uphill Distance", "Uphill Trip Time", "Uphill Avg Incline", "Uphill Rise Rate", "Uphill M Rise Rate", "Uphill Max Incline", "Uphill Average", "Downhill Descend", "Downhill Distance", "Downhill Trip Time", "Downhill Avg Incline", "Downhill Rise Rate", "Downhill M. Rise Rate", "Downhill Max Incline", "Downhill Average", "Time Clock", "Time Date", "Time Stopwatch", "Time Countdown", "Time Alarm Clock", "Don\'t Display"];

        public static const FIRST_DONT_DISPLAY_INDEX:int=9;
    }
}


//  class FavoritesROX2010
package core.general 
{
    public class FavoritesROX2010 extends Object
    {
        public function FavoritesROX2010()
        {
            super();
            return;
        }

        public static const DONT_DISPLAY_INDEX:int=53;

        public static const DONT_DISPLAY_INDEXES:Array=[9];

        public static const FAVORITES:Array=["Cycling Distance", "Cycling Rise Time", "Cycling Average", "Cycling Maximum", "Cycling Distance +/-", "", "Cycling Avg Cadence", "Cycling Max Cadence", "Cycling Ghost Race", "Cycling Don\'t Display", "Heartrate Zone Bar", "Heartrate Average", "Heartrate Maximum", "Heartrate Time Zone 1", "Heartrate Time Zone 2", "Heartrate Time Zone 3", "Heartrate Calories", "Heartrate Don\'t Display", "Temperature Actual", "Temperature Minimum", "Temperature Maximum", "Temperature Don\'t Display", "Uphill Climb", "Uphill Max Altitude", "Uphill Distance", "Uphill Trip Time", "Uphill Avg Incline", "Uphill Rise Rate", "Uphill M. Rise Rate", "Uphill Max Incline", "Uphill Average", "Uphill Don\'t Display", "Downhill Descend", "Downhill Distance", "Downhill Trip Time", "Downhill Avg Incline", "Downhill Rise Rate", "Downhill M. Rise Rate", "Downhill Max Incline", "Downhill Average", "Downhill Don\'t Display", "Time Clock", "Time Date", "Time Stopwatch", "Time Countdown", "Time Alarm Clock", "Time Don\'t Display", "Cycling Expansion", "Cycling Avg Expansion", "Cycling Power", "Cycling Avg Power", "Cycling Max Power", "Uphill Avg Expansion"];

        public static const FAVORITES_GUI:Array=["Cycling Distance", "Cycling Rise Time", "Cycling Average", "Cycling Maximum", "Cycling Distance +/-", "", "Cycling Avg Cadence", "Cycling Max Cadence", "Cycling Ghost Race", "", "Heartrate Zone Bar", "Heartrate Average", "Heartrate Maximum", "Heartrate Time Zone 1", "Heartrate Time Zone 2", "Heartrate Time Zone 3", "Heartrate Calories", "", "Temperature Actual", "Temperature Minimum", "Temperature Maximum", "", "Uphill Climb", "Uphill Max Altitude", "Uphill Distance", "Uphill Trip Time", "Uphill Avg Incline", "Uphill Rise Rate", "Uphill M. Rise Rate", "Uphill Max Incline", "Uphill Average", "", "Downhill Descend", "Downhill Distance", "Downhill Trip Time", "Downhill Avg Incline", "Downhill Rise Rate", "Downhill M. Rise Rate", "Downhill Max Incline", "Downhill Average", "", "Time Clock", "Time Date", "Time Stopwatch", "Time Countdown", "Time Alarm Clock", "", "Cycling Expansion", "Cycling Avg Expansion", "Cycling Power", "Cycling Avg Power", "Cycling Max Power", "Uphill Avg Expansion", "Don\'t Display"];

        public static const FIRST_DONT_DISPLAY_INDEX:int=9;
    }
}


//  class FilterMode
package core.general 
{
    public class FilterMode extends Object
    {
        public function FilterMode()
        {
            super();
            return;
        }

        public static const ACTIVITIES:String="filterActivities";

        public static const ACTIVITY_COMPARE_POPUP:String="filterActivitiesForCompare";

        public static const TRACKS:String="filterTracks";
    }
}


//  class Gender
package core.general 
{
    public class Gender extends Object
    {
        public function Gender()
        {
            super();
            return;
        }

        public static const FEMALE:String="female";

        public static const GENDER:Array=["male", "female", "group"];

        public static const GROUP:String="group";

        public static const MALE:String="male";
    }
}


//  class HRMaxOption
package core.general 
{
    public class HRMaxOption extends Object
    {
        public function HRMaxOption()
        {
            super();
            return;
        }

        public static const MANUAL:String="manual";

        public static const CALCULATED:String="calculated";

        public static const OPTIONS:Array=["manual", "calculated"];
    }
}


//  class LanguageSoftware
package core.general 
{
    import flash.system.*;
    
    public class LanguageSoftware extends Object
    {
        public function LanguageSoftware()
        {
            super();
            return;
        }

        public static function fromSystemLanguage():String
        {
            var loc3:*=0;
            var loc1:*="en_US";
            var loc2:*=SYSTEM_LANGUAGE_CODE.length;
            var loc4:*=flash.system.Capabilities.language;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (SYSTEM_LANGUAGE_CODE[loc3][0] == loc4) 
                {
                    loc1 = SYSTEM_LANGUAGE_CODE[loc3][1];
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        
        {
            SYSTEM_LANGUAGE_CODE = [["cs", "cs_CZ"], ["de", "de_DE"], ["en", "en_US"], ["es", "es_ES"], ["fr", "fr_FR"], ["it", "it_IT"], ["nl", "nl_NL"], ["pl", "pl_PL"]];
        }

        public static const CS_CZ:String="cs_CZ";

        public static const DE_DE:String="de_DE";

        public static const EN_US:String="en_US";

        public static const ES_ES:String="es_ES";

        public static const FR_FR:String="fr_FR";

        public static const IT_IT:String="it_IT";

        public static const JA_JP:String="ja_JP";

        public static const NL_NL:String="nl_NL";

        public static const PL_PL:String="pl_PL";

        public static const ZH_CN:String="zh_CN";

        internal static var SYSTEM_LANGUAGE_CODE:Array;
    }
}


//  class LanguageUnit
package core.general 
{
    public class LanguageUnit extends Object
    {
        public function LanguageUnit()
        {
            super();
            return;
        }

        public static const CZECH:String="cs";

        public static const DUTCH:String="nl";

        public static const ENGLISH:String="en";

        public static const FRENCH:String="fr";

        public static const GERMAN:String="de";

        public static const ITALIAN:String="it";

        public static const LANGUAGES:Array=["de", "en", "fr", "it", "es", "se", "nl", "pl", "cs"];

        public static const POLISH:String="pl";

        public static const SPANISH:String="es";

        public static const SWEDISH:String="se";
    }
}


//  class LogType
package core.general 
{
    public final class LogType extends core.general.BaseType
    {
        public function LogType(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.LogType
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const ACTIVITY_TRACKER:core.general.LogType=new LogType("ActivityTracker");

        public static const CYCLING:core.general.LogType=new LogType("Cycling");

        public static const PULSE:core.general.LogType=new LogType("Pulse");

        public static const RUNNING:core.general.LogType=new LogType("Running");

        public static const TYPES:Array=[CYCLING, PULSE, RUNNING, ACTIVITY_TRACKER];
    }
}


//  class MarkerType
package core.general 
{
    public class MarkerType extends Object
    {
        public function MarkerType()
        {
            super();
            return;
        }

        public static const AUTO_LAP:String="al";

        public static const BEST_20MIN_POWER:String="best29MinPower";

        public static const BEST_5K_TIME:String="best5KTime";

        public static const INTERVAL:String="Interval";

        public static const INTERVAL_PHASE:String="IntervalPhase";

        public static const LAP:String="l";

        public static const PAUSE:String="p";

        public static const RECOVERY:String="Recovery";

        public static const SIMPLE_PHASE:String="SimplePhase";
    }
}


//  class Measurement
package core.general 
{
    public class Measurement extends Object
    {
        public function Measurement()
        {
            super();
            return;
        }

        public static const KMH:String="kmh";

        public static const MEASUREMENTS:Array=["kmh", "mph", "min/km", "min/mi"];

        public static const MIN_KM:String="min/km";

        public static const MIN_MI:String="min/mi";

        public static const MPH:String="mph";
    }
}


//  class MeasuringUnit
package core.general 
{
    public class MeasuringUnit extends Object
    {
        public function MeasuringUnit()
        {
            super();
            return;
        }

        public static const DISTANCE:String="distanceAbsolute";

        public static const TRAININGTIME:String="trainingTimeAbsolute";
    }
}


//  class POICategories
package core.general 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class POICategories extends Object
    {
        public function POICategories()
        {
            super();
            return;
        }

        public static function categoryId(arg1:String):int
        {
            var loc2:*=0;
            var loc1:*=DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1 == DATA_PROVIDER[loc2].value) 
                {
                    return DATA_PROVIDER[loc2].id;
                }
                ++loc2;
            }
            return 0;
        }

        public static function categoryType(arg1:int):String
        {
            var loc2:*=0;
            var loc1:*=DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1 == DATA_PROVIDER[loc2].id) 
                {
                    return DATA_PROVIDER[loc2].value;
                }
                ++loc2;
            }
            return "";
        }

        
        {
            new __AS3__.vec.Vector.<Object>(11)[0] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_NOTHING"), "value":"", "id":0};
            new __AS3__.vec.Vector.<Object>(11)[1] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_CYCLING"), "value":"cycling", "id":1};
            new __AS3__.vec.Vector.<Object>(11)[2] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_RESTAURANT"), "value":"sustenance ", "id":2};
            new __AS3__.vec.Vector.<Object>(11)[3] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_HOTEL"), "value":"accommodation", "id":3};
            new __AS3__.vec.Vector.<Object>(11)[4] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_CINEMA"), "value":"entertainment", "id":4};
            new __AS3__.vec.Vector.<Object>(11)[5] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_BANK"), "value":"money", "id":5};
            new __AS3__.vec.Vector.<Object>(11)[6] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_GAS_STATION"), "value":"automobile", "id":6};
            new __AS3__.vec.Vector.<Object>(11)[7] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_HOSPITALS"), "value":"health", "id":7};
            new __AS3__.vec.Vector.<Object>(11)[8] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_TOURIST_INFO"), "value":"tourism", "id":8};
            new __AS3__.vec.Vector.<Object>(11)[9] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_SHOPPING"), "value":"shopping", "id":9};
            new __AS3__.vec.Vector.<Object>(11)[10] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_WIKIPEDIA"), "value":"wikipedia", "id":10};
            DATA_PROVIDER = new __AS3__.vec.Vector.<Object>(11);
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class PowerZoneDefaults
package core.general 
{
    public class PowerZoneDefaults extends Object
    {
        public function PowerZoneDefaults()
        {
            super();
            return;
        }

        public static const POWER_ZONE_1_START:int=0;

        public static const POWER_ZONE_1_START_PERCENT:int=0;

        public static const POWER_ZONE_2_START:int=141;

        public static const POWER_ZONE_2_START_PERCENT:int=56;

        public static const POWER_ZONE_3_START:int=191;

        public static const POWER_ZONE_3_START_PERCENT:int=76;

        public static const POWER_ZONE_4_START:int=231;

        public static const POWER_ZONE_4_START_PERCENT:int=91;

        public static const POWER_ZONE_5_START:int=261;

        public static const POWER_ZONE_5_START_PERCENT:int=106;

        public static const POWER_ZONE_6_START:int=301;

        public static const POWER_ZONE_6_START_PERCENT:int=121;

        public static const POWER_ZONE_7_END:int=2000;

        public static const POWER_ZONE_7_START:int=367;

        public static const POWER_ZONE_7_START_PERCENT:int=151;

        public static const POWER_ZONE_MAXIMUM:int=2000;

        public static const POWER_ZONE_MINIMUM:int=0;

        public static const THRESHOLD_POWER:int=253;
    }
}


//  class Revision
package core.general 
{
    public final class Revision extends Object
    {
        public function Revision()
        {
            super();
            return;
        }

        public static const CURRENT_REVISION:int=400;

        public static const DC100:int=100;

        public static const DC200:int=200;

        public static const DC210:int=210;

        public static const DC300:int=300;

        public static const DC310:int=310;

        public static const DC320:int=320;

        public static const DC330:int=330;

        public static const DC400:int=400;
    }
}


//  class SensorPosition
package core.general 
{
    public class SensorPosition extends Object
    {
        public function SensorPosition()
        {
            super();
            return;
        }

        public static const TX_SENSOR_POSITION_CHEST:String="chest";

        public static const TX_SENSOR_POSITION_HIP:String="hip";
    }
}


//  class SpeedReference
package core.general 
{
    public class SpeedReference extends Object
    {
        public function SpeedReference()
        {
            super();
            return;
        }

        public static const GPS:String="gps";

        public static const SENSOR:String="sensor";
    }
}


//  class TireSize
package core.general 
{
    public class TireSize extends core.general.BaseType
    {
        public function TireSize(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.TireSize
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if ((TYPES[loc1] as TireSize).toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const S_16INCH:core.general.TireSize=new TireSize("1253");

        public static const S_18INCH:core.general.TireSize=new TireSize("1411");

        public static const S_20INCH:core.general.TireSize=new TireSize("1590");

        public static const S_22INCH:core.general.TireSize=new TireSize("1770");

        public static const S_24INCH:core.general.TireSize=new TireSize("1907");

        public static const S_26INCH:core.general.TireSize=new TireSize("2085");

        public static const S_275INCH:core.general.TireSize=new TireSize("2180");

        public static const S_27INCH:core.general.TireSize=new TireSize("2195");

        public static const S_28INCH:core.general.TireSize=new TireSize("2200");

        public static const S_29INCH:core.general.TireSize=new TireSize("2300");

        public static const S_700C:core.general.TireSize=new TireSize("2095");

        public static const TYPES:Array=[S_16INCH, S_18INCH, S_20INCH, S_22INCH, S_24INCH, S_26INCH, S_27INCH, S_275INCH, S_28INCH, S_29INCH, S_700C];
    }
}


//  class TrackDirection
package core.general 
{
    public class TrackDirection extends Object
    {
        public function TrackDirection()
        {
            super();
            return;
        }

        public static const DRIVING_DIRECTION:String="drivingDirection";

        public static const NORTH:String="north";
    }
}


//  class TrainingCategory
package core.general 
{
    public final class TrainingCategory extends core.general.BaseType
    {
        public function TrainingCategory(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.TrainingCategory
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const FREE:core.general.TrainingCategory=new TrainingCategory("Free");

        public static const INTERVAL:core.general.TrainingCategory=new TrainingCategory("Interval");

        public static const NONE:core.general.TrainingCategory=new TrainingCategory("none");

        public static const PROGRAM:core.general.TrainingCategory=new TrainingCategory("Program");

        public static const SMARTPHONE:core.general.TrainingCategory=new TrainingCategory("Samrphone");

        public static const TYPES:Array=[FREE, INTERVAL, PROGRAM, SMARTPHONE, NONE];
    }
}


//  class TrainingZone
package core.general 
{
    public class TrainingZone extends Object
    {
        public function TrainingZone()
        {
            super();
            return;
        }

        public static const FAT_ZONE:String="fatZone";

        public static const FIT_ZONE:String="fitZone";

        public static const OFF:String="off";

        public static const OWN_ZONE:String="ownZone";

        public static const OWN_ZONE_1:String="ownZone1";

        public static const OWN_ZONE_2:String="ownZone2";

        public static const OWN_ZONE_3:String="ownZone3";

        public static const TRAINING_ZONE:Array=["fitZone", "fatZone", "ownZone", "ownZone1", "ownZone2", "ownZone3", "off"];
    }
}


//  class UnitType
package core.general 
{
    import debug.*;
    import utils.*;
    
    public class UnitType extends core.general.BaseType
    {
        public function UnitType(arg1:String=null)
        {
            super(arg1);
            typeString = arg1;
            return;
        }

        public static function hashtag(arg1:core.general.UnitType):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            while (BC509 === loc2) 
            {
                loc1 = "#SIGMA #BC509";
            }
        }

        public function getLabel():String
        {
            return utils.LanguageManager.getString("UNIT_" + typeString.toUpperCase());
        }

        public static function fromString(arg1:String):core.general.UnitType
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            if (arg1 != "") 
            {
                debug.Debug.warning("Warning: Unknown UnitType: \'" + arg1 + "\'");
            }
            else 
            {
                debug.Debug.warning("Warning: No UnitType defined");
            }
            return null;
        }

        public static function formatUnit(arg1:core.general.UnitType):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            while (BC509 === loc2) 
            {
                loc1 = utils.LanguageManager.getString("UNIT_BC509");
            }
        }

        public static const BC1009STS:core.general.UnitType=new UnitType("bc1009sts");

        public static const BC1212:core.general.UnitType=new UnitType("bc1212");

        public static const BC1212STS:core.general.UnitType=new UnitType("bc1212sts");

        public static const BC1412:core.general.UnitType=new UnitType("bc1412");

        public static const BC1416:core.general.UnitType=new UnitType("bc1416");

        public static const BC1416STS:core.general.UnitType=new UnitType("bc1416sts");

        public static const BC1609:core.general.UnitType=new UnitType("bc1609");

        public static const BC1609STS:core.general.UnitType=new UnitType("bc1609sts");

        public static const BC1612:core.general.UnitType=new UnitType("bc1612");

        public static const BC1612STS:core.general.UnitType=new UnitType("bc1612sts");

        public static const BC1616:core.general.UnitType=new UnitType("bc1616");

        public static const BC1616STS:core.general.UnitType=new UnitType("bc1616sts");

        public static const BC1909HR:core.general.UnitType=new UnitType("bc1909hr");

        public static const BC2209MHR:core.general.UnitType=new UnitType("bc2209mhr");

        public static const BC2316STS:core.general.UnitType=new UnitType("bc2316sts");

        public static const BC416:core.general.UnitType=new UnitType("bc416");

        public static const BC416ATS:core.general.UnitType=new UnitType("bc416ats");

        public static const BC509:core.general.UnitType=new UnitType("bc509");

        public static const BC512:core.general.UnitType=new UnitType("bc512");

        public static const BC516:core.general.UnitType=new UnitType("bc516");

        public static const BC716:core.general.UnitType=new UnitType("bc716");

        public static const BC716ATS:core.general.UnitType=new UnitType("bc716ats");

        public static const BC812:core.general.UnitType=new UnitType("bc812");

        public static const BC812W:core.general.UnitType=new UnitType("bc812w");

        public static const BC916:core.general.UnitType=new UnitType("bc916");

        public static const BC916ATS:core.general.UnitType=new UnitType("bc916ats");

        public static const GPS10:core.general.UnitType=new UnitType("gps10");

        public static const PC2814:core.general.UnitType=new UnitType("pc2814");

        public static const RC1209:core.general.UnitType=new UnitType("rc1209");

        public static const RC1411:core.general.UnitType=new UnitType("rc1411");

        public static const ROX100:core.general.UnitType=new UnitType("rox100");

        public static const ROX110:core.general.UnitType=new UnitType("rox110");

        public static const ROX50:core.general.UnitType=new UnitType("rox50");

        public static const ROX60:core.general.UnitType=new UnitType("rox60");

        public static const ROX8:core.general.UnitType=new UnitType("rox8");

        public static const ROX80:core.general.UnitType=new UnitType("rox80");

        public static const ROX81:core.general.UnitType=new UnitType("rox81");

        public static const ROX9:core.general.UnitType=new UnitType("rox9");

        public static const ROX90:core.general.UnitType=new UnitType("rox90");

        public static const ROX70:core.general.UnitType=new UnitType("rox70");

        public static const SigmaMove:core.general.UnitType=new UnitType("SIGMA MOVE");

        public static const TYPES:Array=[BC509, BC1009, BC1009STS, BC1609, BC1609STS, BC1909HR, BC2209MHR, BC512, BC812, BC1212, BC1412, BC1612, BC1612STS, BC812W, BC1212STS, BC416, BC416ATS, BC516, BC716, BC716ATS, BC916, BC916ATS, BC1616, BC1616STS, BC1416, BC1416STS, BC2316STS, ROX80, ROX8, ROX90, ROX9, ROX81, ROX91, ROX50, ROX60, ROX70, ROX100, ROX110, RC1209, RC1411, PC2814, GPS10, SigmaMove, Activo];

        public static const Activo:core.general.UnitType=new UnitType("ACTIVO");

        public static const BC1009:core.general.UnitType=new UnitType("bc1009");

        public static const ROX91:core.general.UnitType=new UnitType("rox91");

        public static var _dataProvider:Array;

        internal var typeString:String;
    }
}


//  class WeightUnit
package core.general 
{
    public class WeightUnit extends Object
    {
        public function WeightUnit()
        {
            super();
            return;
        }

        public static const G:String="g";

        public static const KG:String="kg";

        public static const LB:String="lb";

        public static const WEIGHTUNITS:Array=["kg", "lb", "g"];
    }
}


//  class WheelSizeSelectionMode
package core.general 
{
    public class WheelSizeSelectionMode extends core.general.BaseType
    {
        public function WheelSizeSelectionMode(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.general.WheelSizeSelectionMode
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const MANUAL:core.general.WheelSizeSelectionMode=new WheelSizeSelectionMode("manual selection");

        public static const TIRE:core.general.WheelSizeSelectionMode=new WheelSizeSelectionMode("tire");

        public static const TYPES:Array=[MANUAL, TIRE];
    }
}


