//class Rox70Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.hurlant.util.*;
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.route.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.sport.*;
    import core.sportprofiles.*;
    import core.strava.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import init.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    import utils.sort.*;
    
    public class Rox70Decoder extends flash.events.EventDispatcher
    {
        public function Rox70Decoder()
        {
            altitudeConverter = new utils.converter.AltitudeConverter();
            altitudeFormater = init.BackendInitializer.getInstance().createAltitudeFormatter();
            distanceConverter = new utils.converter.DistanceConverter();
            distanceForamtter = init.BackendInitializer.getInstance().createDistanceFormatter();
            super();
            if (this is decoder.Rox110Decoder) 
            {
                return;
            }
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10124, "Rox100Decoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            distanceConverter.inputFormat = "meter";
            distanceConverter.outputFormat = core.MeasurementConfig.distanceFormat;
            altitudeConverter.inputFormat = "millimeter";
            altitudeConverter.outputFormat = core.MeasurementConfig.altitudeFormat;
            return;
        }

        public function set settings(arg1:core.settings.Settings):void
        {
            if (arg1 is core.settings.SettingsROX70) 
            {
                _myUnitSettings = arg1 as core.settings.SettingsROX70;
            }
            return;
        }

        public function get totals():core.totals.Totals
        {
            return _myUnitTotals;
        }

        public function set totals(arg1:core.totals.Totals):void
        {
            if (arg1 is core.totals.TotalsROX70) 
            {
                _myUnitTotals = arg1 as core.totals.TotalsROX70;
            }
            return;
        }

        public function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            if (arg1 is core.units.UnitROX70) 
            {
                _myUnit = arg1 as core.units.UnitROX70;
            }
            return;
        }

        protected function decodeLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc2:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            var loc6:*=0;
            loc2.latitude = (arg1[3] << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0]) / 1000000;
            loc2.longitude = (arg1[7] << 24 | arg1[6] << 16 | arg1[5] << 8 | arg1[4]) / 1000000;
            loc2.altitudeDifferencesUphill = (arg1[11] << 24 | arg1[10] << 16 | arg1[9] << 8 | arg1[8]) * 1000;
            loc2.altitudeDifferencesDownhill = (arg1[15] << 24 | arg1[14] << 16 | arg1[13] << 8 | arg1[12]) * -1000;
            loc2.trainingTime = arg1[17] * 10;
            loc2.trainingTimeUphill = arg1[18] * 10;
            loc2.trainingTimeDownhill = arg1[19] * 10;
            loc6 = arg1[21] << 8 | arg1[20];
            if (arg1[21] >> 7 == 1) 
            {
                loc6 = loc6 - 65536;
            }
            loc2.altitude = loc6 * 1000;
            loc2.speed = _speedConverter.convert((arg1[23] << 8 | arg1[22]) / 100);
            loc2.speedTime = utils.Calculations.calculateSpeedTime(loc2.speed);
            loc2.distance = (arg1[27] << 24 | arg1[26] << 16 | arg1[25] << 8 | arg1[24]) / 100;
            loc2.distanceUphill = (arg1[31] << 24 | arg1[30] << 16 | arg1[29] << 8 | arg1[28]) / 100;
            loc2.distanceDownhill = (arg1[35] << 24 | arg1[34] << 16 | arg1[33] << 8 | arg1[32]) / 100;
            var loc1:*=arg1[37] << 8 | arg1[36];
            var loc3:*=arg1[39] >> 7 != 1 ? 0 : (arg1[39] << 8 | arg1[38]) - 65536;
            loc2.incline = loc1 == 0 ? loc3 : loc1;
            var loc5:*=(arg1[41] << 8 | arg1[40]) * 1000;
            var loc4:*=arg1[43] >> 7 != 1 ? 0 : ((arg1[43] << 8 | arg1[42]) - 65536) * -1000;
            loc2.riseRate = loc5 == 0 ? -loc4 : loc5;
            loc6 = arg1[45] >> 7 != 1 ? arg1[45] << 8 | arg1[44] : (arg1[45] << 8 | arg1[44]) - 65536;
            loc2.temperature = loc6 / 10;
            return loc2;
        }

        public function decodeLogStatus(arg1:Object):core.units.Unit
        {
            var loc1:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 524, "ROX70Decoder > decodeLogStatus: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            var loc2:*=1355;
            var loc4:*=loc1[3] << 24 | loc1[2] << 16 | loc1[1] << 8 | loc1[0];
            (_myUnit as core.units.interfaces.ILogStatus).maxPackages = loc2 * 1024;
            (_myUnit as core.units.interfaces.ILogStatus).freePackages = loc4 * 1024;
            var loc3:*=loc1[15] << 24 | loc1[14] << 16 | loc1[13] << 8 | loc1[12];
            (_myUnit as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc3;
            return _myUnit;
        }

        protected function decodeLap(arg1:Array, arg2:core.activities.Activity):core.marker.Marker
        {
            var loc1:*=core.marker.MarkerFactory.createMarkerFromLog(arg2);
            loc1.latitude = (arg1[3] << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0]) / 1000000;
            loc1.longitude = (arg1[7] << 24 | arg1[6] << 16 | arg1[5] << 8 | arg1[4]) / 1000000;
            loc1.type = arg1[8] != 0 ? "al" : "l";
            var loc2:*=0;
            loc2 = (loc2 = arg1[16]) | arg1[17] << 8;
            loc1.number = (loc2 - 1);
            loc2 = (loc2 = arg1[18]) | arg1[19] << 8;
            loc1.minimumSpeed = _speedConverter.convert(loc2 / 100);
            loc2 = (loc2 = arg1[20]) | arg1[21] << 8;
            loc1.averageSpeed = _speedConverter.convert(loc2 / 100);
            loc2 = (loc2 = arg1[22]) | arg1[23] << 8;
            loc1.maximumSpeed = _speedConverter.convert(loc2 / 100);
            loc2 = (loc2 = (loc2 = (loc2 = arg1[24]) | arg1[25] << 8) | arg1[26] << 16) | arg1[27] << 24;
            loc1.time = loc2 * 10;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[28]) | arg1[29] << 8) | arg1[30] << 16) | arg1[31] << 24;
            loc1.distance = loc2 / 100;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[32]) | arg1[33] << 8) | arg1[34] << 16) | arg1[35] << 24;
            loc1.altitudeUphill = loc2 * 1000;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[36]) | arg1[37] << 8) | arg1[38] << 16) | arg1[39] << 24;
            loc1.altitudeDownhill = loc2 * 1000;
            if (loc1.altitudeDownhill < 0) 
            {
                loc1.altitudeDownhill = loc1.altitudeDownhill * -1;
            }
            loc2 = (loc2 = arg1[40]) | arg1[41] << 8;
            loc1.maximumAltitude = loc2 * 1000;
            loc2 = (loc2 = arg1[42]) | arg1[43] << 8;
            loc1.averageAltitude = loc2 * 1000;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[44]) | arg1[45] << 8) | arg1[46] << 16) | arg1[47] << 24;
            loc1.calories = loc2;
            loc2 = (loc2 = arg1[48]) | arg1[49] << 8;
            loc1.averageInclineUphill = loc2;
            loc1.averageInclineDownhill = arg1[51] >> 7 != 1 ? 0 : (arg1[51] << 8 | arg1[50]) - 65536;
            loc2 = (loc2 = arg1[52]) | arg1[53] << 8;
            loc1.maximumInclineUphill = loc2;
            loc2 = (loc2 = arg1[54]) | arg1[55] << 8;
            loc1.maximumInclineDownhill = arg1[55] >> 7 != 1 ? 0 : (arg1[55] << 8 | arg1[54]) - 65536;
            return loc1;
        }

        internal function decodePause(arg1:Array, arg2:Array, arg3:core.activities.Activity):core.marker.Marker
        {
            var loc8:*=NaN;
            var loc2:*=NaN;
            var loc4:*=null;
            var loc5:*;
            (loc5 = core.marker.MarkerFactory.createMarkerFromLog(arg3, "p")).type = "p";
            var loc3:*;
            if ((loc3 = arg3.entries.length) < arg3.maxSpeedEntry) 
            {
                arg3.maxSpeedEntry = arg3.maxSpeedEntry - 2;
            }
            if (loc3 < arg3.maxAltitudeEntry) 
            {
                arg3.maxAltitudeEntry = arg3.maxAltitudeEntry - 2;
            }
            if (loc3 < arg3.maxInclineUphillEntry) 
            {
                arg3.maxInclineUphillEntry = arg3.maxInclineUphillEntry - 2;
            }
            if (loc3 < arg3.maxInclineDownhillEntry) 
            {
                arg3.maxInclineDownhillEntry = arg3.maxInclineDownhillEntry - 2;
            }
            if (arg3.unitType == core.general.UnitType.ROX110) 
            {
                if (loc3 < arg3.maxRiseRateUphillEntry) 
                {
                    arg3.maxRiseRateUphillEntry = arg3.maxRiseRateUphillEntry - 2;
                }
                if (loc3 < arg3.maxRiseRateDownhillEntry) 
                {
                    arg3.maxRiseRateDownhillEntry = arg3.maxRiseRateDownhillEntry - 2;
                }
                if (loc3 < arg3.maxPowerEntry) 
                {
                    arg3.maxPowerEntry = arg3.maxPowerEntry - 2;
                }
                if (loc3 < arg3.maxHeartrateEntry) 
                {
                    arg3.maxHeartrateEntry = arg3.maxHeartrateEntry - 2;
                }
                if (loc3 < arg3.maxCadenceEntry) 
                {
                    arg3.maxCadenceEntry = arg3.maxCadenceEntry - 2;
                }
            }
            loc5.latitude = arg1[0];
            loc5.latitude = loc5.latitude | arg1[1] << 8;
            loc5.latitude = loc5.latitude | arg1[2] << 16;
            loc5.latitude = loc5.latitude | arg1[3] << 24;
            loc5.latitude = loc5.latitude / 1000000;
            loc5.longitude = arg1[4];
            loc5.longitude = loc5.longitude | arg1[5] << 8;
            loc5.longitude = loc5.longitude | arg1[6] << 16;
            loc5.longitude = loc5.longitude | arg1[7] << 24;
            loc5.longitude = loc5.longitude / 1000000;
            var loc7:*=(loc7 = arg1[8]) | arg1[9] << 8;
            var loc6:*=(loc6 = arg1[12]) | arg1[13] << 8;
            var loc9:*=new Date(loc7, arg1[10], arg1[11], loc6, arg1[14], arg1[15]);
            var loc1:*=0;
            if (arg2) 
            {
                loc8 = (loc8 = arg2[8]) | arg2[9] << 8;
                loc2 = (loc2 = arg2[12]) | arg2[13] << 8;
                loc1 = ((loc4 = new Date(loc8, arg2[10], arg2[11], loc2, arg2[14], arg2[15])).time - loc9.time) / 10;
            }
            loc5.duration = loc1;
            return loc5;
        }

        internal function decodeTrackPoint(arg1:Array):core.route.RoutePoint
        {
            var loc1:*=new core.route.RoutePoint();
            loc1.routingType = "imported";
            var loc2:*=0;
            loc2 = arg1[0];
            loc2 = loc2 | arg1[1] << 8;
            loc2 = loc2 | arg1[2] << 16;
            loc2 = loc2 | arg1[3] << 24;
            loc2 = loc2 / 1000000;
            loc1.latitude = parseFloat(loc2.toFixed(9));
            loc2 = arg1[4];
            loc2 = loc2 | arg1[5] << 8;
            loc2 = loc2 | arg1[6] << 16;
            loc2 = loc2 | arg1[7] << 24;
            loc2 = loc2 / 1000000;
            loc1.longitude = parseFloat(loc2.toFixed(9));
            loc2 = arg1[8];
            loc2 = loc2 | arg1[9] << 8;
            if (loc2 > 50000) 
            {
                loc2 = loc2 - 65536;
            }
            loc1.altitude = loc2 * 1000;
            loc2 = arg1[10];
            loc2 = loc2 | arg1[11] << 8;
            loc1.waypointIndex = loc2;
            return loc1;
        }

        internal function encodeTrackPoint(arg1:core.route.RoutePoint):Array
        {
            var loc3:*=NaN;
            var loc2:*=0;
            var loc1:*=new Array(12);
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            loc3 = arg1.latitude * 1000000;
            loc1[0] = loc3 & 255;
            loc1[1] = loc3 >> 8 & 255;
            loc1[2] = loc3 >> 16 & 255;
            loc1[3] = loc3 >> 24 & 255;
            loc3 = arg1.longitude * 1000000;
            loc1[4] = loc3 & 255;
            loc1[5] = loc3 >> 8 & 255;
            loc1[6] = loc3 >> 16 & 255;
            loc1[7] = loc3 >> 24 & 255;
            if ((loc3 = arg1.altitude / 1000) < 0) 
            {
                loc3 = loc3 + 65536;
            }
            loc1[8] = loc3 & 255;
            loc1[9] = loc3 >> 8 & 255;
            loc3 = arg1.waypointIndex;
            loc1[10] = loc3 & 255;
            loc1[11] = loc3 >> 8 & 255;
            if (loc3 == 0) 
            {
            };
            return loc1;
        }

        public static function calculateCheckSum(arg1:Array, arg2:int, arg3:int, arg4:int, arg5:int=0):int
        {
            var loc2:*=0;
            loc2 = loc2 ^ arg4;
            loc2 = loc2 ^ arg3;
            loc2 = loc2 ^ arg2;
            loc2 = loc2 ^ arg5;
            var loc4:*=0;
            var loc1:*=(arg1.length - 1);
            var loc3:*=0;
            loc3 = loc4;
            while (loc3 <= loc1) 
            {
                loc2 = loc2 ^ arg1[loc3];
                ++loc3;
            }
            return loc2;
        }

        public static function getInstance():decoder.Rox70Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox70Decoder();
            }
            return _instance;
        }

        public static function isValidCheckSum(arg1:Array):Boolean
        {
            var loc2:*=arg1[(arg1.length - 1)];
            var loc5:*=(loc5 = (loc5 = 0) ^ arg1[1]) ^ arg1[2];
            var loc4:*=3;
            var loc1:*=arg1.length - 2;
            var loc3:*=0;
            loc3 = loc4;
            while (loc3 <= loc1) 
            {
                loc5 = loc5 ^ arg1[loc3];
                ++loc3;
            }
            return loc5 == loc2;
        }

        public function decodeLogHeader(arg1:Object):core.activities.Activity
        {
            var loc1:*=core.activities.ActivityFactory.createActivityFromUnitType(_myUnit.type, "log");
            loc1.unit = _myUnit;
            loc1.serialNumber = _myUnit.serialNumber;
            return decodeCommonLogHeader(loc1, arg1);
        }

        protected function getName(arg1:Array, arg2:int, arg3:int=16):String
        {
            var loc2:*=0;
            var loc1:*=null;
            loc2 = arg2;
            while (loc2 < arg3) 
            {
                loc1 = loc1 + com.hurlant.util.Hex.toString(arg1[loc2].toString(16));
                ++loc2;
            }
            return loc1;
        }

        protected function getGUID(arg1:Array, arg2:int, arg3:int=16):String
        {
            var loc1:*=0;
            var loc2:*="";
            loc1 = arg2;
            while (loc1 < arg2 + arg3) 
            {
                loc2 = loc2 + addZeroToHex(arg1[loc1]);
                if (loc1 == 3 || loc1 == 5 || loc1 == 7 || loc1 == 9) 
                {
                    loc2 = loc2 + "-";
                }
                ++loc1;
            }
            return loc2;
        }

        protected function setGUID(arg1:Array, arg2:int, arg3:int, arg4:String):void
        {
            var loc2:*=0;
            var loc1:*=0;
            loc2 = 0;
            while (loc2 < arg3) 
            {
                if (arg4.charAt(loc2) != "-") 
                {
                    loc1 = arg4.charCodeAt(loc2);
                    arg1[arg2 + loc2] = loc1;
                }
                ++loc2;
            }
            return;
        }

        protected function decodeCommonLogHeader(arg1:core.activities.Activity, arg2:Object):core.activities.Activity
        {
            var loc1:*=arg2 as Array;
            var loc4:*=new utils.converter.SpeedConverter("kmh", "ms");
            var loc5:*=new utils.converter.WeightConverter(loc1[113] > 128 ? "lb" : "kg", "g");
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 524, "ROX70Decoder > decodeLogStatus: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            arg1.autoLapsDefined = true;
            arg1.statistic = true;
            arg1.GUID = getGUID(loc1, 0);
            arg1.sportId = loc1[17];
            arg1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg1.sportId);
            arg1.lapValuesToLoad = loc1[19] << 8 | loc1[18];
            arg1.autoLapValuesToLoad = loc1[21] << 8 | loc1[20];
            var loc2:*=loc1[27] << 24 | loc1[26] << 16 | loc1[25] << 8 | loc1[24];
            arg1.lapValuesIndex = loc2;
            arg1.recordValuesToLoad = loc1[31] << 24 | loc1[30] << 16 | loc1[29] << 8 | loc1[28];
            arg1.entryCount = arg1.recordValuesToLoad;
            arg1.startIndex = loc1[33] << 8 | loc1[32];
            arg1.startDate = new Date(loc1[41] << 8 | loc1[40], (loc1[42] - 1), loc1[43], loc1[45] << 8 | loc1[44], loc1[46], loc1[47]);
            arg1.dateCode = arg1.startDate.toString();
            var loc3:*=new Date(loc1[49] << 8 | loc1[48], (loc1[50] - 1), loc1[51], loc1[53] << 8 | loc1[52], loc1[54], loc1[55]);
            arg1.trainingTime = (loc1[59] << 24 | loc1[58] << 16 | loc1[57] << 8 | loc1[56]) * 10;
            arg1.exerciseTime = (loc1[63] << 24 | loc1[62] << 16 | loc1[61] << 8 | loc1[60]) * 10;
            arg1.distance = (loc1[67] << 24 | loc1[66] << 16 | loc1[65] << 8 | loc1[64]) / 100;
            arg1.autoLapValuesIndex = loc1[71] << 24 | loc1[70] << 16 | loc1[69] << 8 | loc1[68];
            var loc6:*=loc1[81];
            arg1.averageCadenceCalc = (loc1[81] & 64) >> 6;
            arg1.averagePowerCalc = (loc1[81] & 128) >> 7;
            arg1.best5KTime = (loc1[83] << 8 | loc1[82]) * 10;
            arg1.trainingTimeUphill = (loc1[87] << 24 | loc1[86] << 16 | loc1[85] << 8 | loc1[84]) * 10;
            arg1.trainingTimeDownhill = (loc1[91] << 24 | loc1[90] << 16 | loc1[89] << 8 | loc1[88]) * 10;
            arg1.distanceUphill = (loc1[95] << 24 | loc1[94] << 16 | loc1[93] << 8 | loc1[92]) / 100;
            arg1.distanceDownhill = (loc1[99] << 24 | loc1[98] << 16 | loc1[97] << 8 | loc1[96]) / 100;
            loc4.inputFormat = "kmh";
            loc4.outputFormat = "ms";
            arg1.averageSpeed = loc4.convert((loc1[101] << 8 | loc1[100]) / 100);
            arg1.maximumSpeed = loc4.convert((loc1[103] << 8 | loc1[102]) / 100);
            arg1.averageSpeedUphill = loc4.convert((loc1[105] << 8 | loc1[104]) / 100);
            arg1.averageSpeedDownhill = loc4.convert((loc1[109] << 8 | loc1[108]) / 100);
            arg1.altitudeDifferencesUphill = (loc1[115] << 24 | loc1[114] << 16 | loc1[113] << 8 | loc1[112]) * 1000;
            arg1.altitudeDifferencesDownhill = (loc1[119] << 24 | loc1[118] << 16 | loc1[117] << 8 | loc1[116]) * -1000;
            arg1.averageAltitude = ((loc1[121] << 8 | loc1[120]) - (loc1[121] >> 7 != 1 ? 0 : 65536)) * 1000;
            var loc7:*=loc1[123] << 8 | loc1[122];
            if (loc1[123] >> 7 == 1) 
            {
                loc7 = loc7 - 65536;
            }
            arg1.maximumAltitude = loc7 * 1000;
            arg1.calories = loc1[127] << 24 | loc1[126] << 16 | loc1[125] << 8 | loc1[124];
            arg1.averageTemperature = loc1[129] >> 7 != 1 ? (loc1[129] << 8 | loc1[128]) / 10 : ((loc1[129] << 8 | loc1[128]) - 65536) / 10;
            arg1.minimumTemperature = loc1[131] >> 7 != 1 ? (loc1[131] << 8 | loc1[130]) / 10 : ((loc1[131] << 8 | loc1[130]) - 65536) / 10;
            arg1.maximumTemperature = loc1[133] >> 7 != 1 ? (loc1[133] << 8 | loc1[132]) / 10 : ((loc1[133] << 8 | loc1[132]) - 65536) / 10;
            arg1.averageInclineDownhill = loc1[135] >> 7 != 1 ? 0 : loc1[135] << 8 | loc1[134] - 65536;
            arg1.maximumInclineDownhill = loc1[137] >> 7 != 1 ? 0 : loc1[137] << 8 | loc1[136] - 65536;
            arg1.averageInclineUphill = loc1[139] << 8 | loc1[138];
            arg1.maximumInclineUphill = loc1[141] << 8 | loc1[140];
            arg1.maximumIncline = arg1.maximumInclineUphill;
            arg1.averageRiseRate = loc1[143] << 8 | loc1[142];
            arg1.minimumRiseRate = loc1[145] >> 7 != 1 ? 0 : (loc1[145] << 8 | loc1[144] - 65536) * 1000;
            arg1.maximumRiseRate = (loc1[147] << 8 | loc1[146]) * 1000;
            arg1.averageRiseRateUphill = (loc1[149] << 8 | loc1[148]) * 1000;
            arg1.averageRiseRateDownhill = loc1[151] >> 7 != 1 ? 0 : (loc1[151] << 8 | loc1[150] - 65536) * 1000;
            arg1.minimumRiseRateUphill = (loc1[153] << 8 | loc1[152]) * 1000;
            arg1.minimumRiseRateDownhill = loc1[155] >> 7 != 1 ? 0 : (loc1[155] << 8 | loc1[154] - 65536) * 1000;
            arg1.maximumRiseRateUphill = (loc1[157] << 8 | loc1[156]) * 1000;
            arg1.maximumRiseRateDownhill = loc1[159] >> 7 != 1 ? 0 : (loc1[159] << 8 | loc1[158] - 65536) * 1000;
            arg1.maxSpeedEntry = loc1[163] << 24 | loc1[162] << 16 | loc1[161] << 8 | loc1[160];
            arg1.maxAltitudeEntry = loc1[167] << 24 | loc1[166] << 16 | loc1[165] << 8 | loc1[164];
            arg1.best5KEntry = loc1[171] << 24 | loc1[170] << 16 | loc1[169] << 8 | loc1[168];
            arg1.maxInclineDownhillEntry = loc1[175] << 24 | loc1[174] << 16 | loc1[173] << 8 | loc1[172];
            arg1.maxInclineUphillEntry = loc1[179] << 24 | loc1[178] << 16 | loc1[177] << 8 | loc1[176];
            arg1.minRiseRateEntry = loc1[183] << 24 | loc1[182] << 16 | loc1[181] << 8 | loc1[180];
            arg1.maxRiseRateEntry = loc1[187] << 24 | loc1[186] << 16 | loc1[185] << 8 | loc1[184];
            arg1.minRiseRateUphillEntry = loc1[191] << 24 | loc1[190] << 16 | loc1[189] << 8 | loc1[188];
            arg1.minRiseRateDownhillEntry = loc1[195] << 24 | loc1[194] << 16 | loc1[193] << 8 | loc1[192];
            arg1.maxRiseRateUphillEntry = loc1[199] << 24 | loc1[198] << 16 | loc1[197] << 8 | loc1[196];
            arg1.maxRiseRateDownhillEntry = loc1[203] << 24 | loc1[202] << 16 | loc1[201] << 8 | loc1[200];
            return arg1;
        }

        public function decodeLog(arg1:core.activities.Activity):void
        {
            var loc30:*=null;
            var loc54:*=null;
            var loc17:*=null;
            var loc43:*=null;
            var loc70:*=null;
            var loc1:*=0;
            var loc60:*=null;
            var loc38:*=null;
            var loc55:*=0;
            var loc5:*=null;
            var loc31:*=NaN;
            var loc7:*=NaN;
            var loc65:*=NaN;
            var loc67:*=NaN;
            var loc57:*=NaN;
            var loc44:*=NaN;
            var loc2:*=NaN;
            var loc29:*=NaN;
            var loc14:*=NaN;
            var loc58:*=NaN;
            var loc49:*=NaN;
            var loc20:*=NaN;
            var loc61:*=NaN;
            var loc51:*=NaN;
            var loc8:*=NaN;
            var loc6:*=NaN;
            var loc33:*=NaN;
            var loc48:*=NaN;
            var loc4:*=NaN;
            var loc3:*=NaN;
            var loc18:*=NaN;
            var loc11:*=NaN;
            var loc42:*=NaN;
            var loc34:*=NaN;
            var loc62:*=NaN;
            var loc32:*=NaN;
            var loc26:*=NaN;
            var loc23:*=NaN;
            var loc22:*=NaN;
            var loc21:*=NaN;
            var loc24:*=NaN;
            var loc66:*=null;
            _speedConverter = new utils.converter.SpeedConverter("kmh", "ms");
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc46:*=arg1.startDate.getTime() / 1000;
            var loc13:*=0;
            var loc63:*=0;
            var loc41:*=0;
            var loc47:*=0;
            var loc52:*=0;
            var loc27:*=0;
            var loc56:*=0;
            var loc12:*=0;
            var loc19:*=0;
            var loc59:*=0;
            var loc37:*=0;
            var loc25:*=0;
            var loc35:*=0;
            var loc40:*=0;
            var loc10:*=0;
            var loc36:*=0;
            var loc9:*=0;
            var loc16:*=0;
            var loc53:*=0;
            var loc45:*=0;
            var loc28:*=0;
            var loc69:*=0;
            var loc64:*=0;
            var loc68:*=0;
            if (arg1.unitType != core.general.UnitType.ROX110) 
            {
                if (arg1.unitType == core.general.UnitType.ROX70) 
                {
                    loc68 = 48;
                }
            }
            else 
            {
                loc68 = 72;
            }
            while (arg1.recordValuesLoaded.length > 0) 
            {
                loc30 = arg1.recordValuesLoaded.splice(0, loc68);
                loc1 = 16;
                if ((loc30[loc1] & 3) == 0) 
                {
                    if ((loc54 = decodeLogEntry(loc30, arg1)) != null) 
                    {
                        if (loc17 == null) 
                        {
                            loc54.distanceAbsolute = loc54.distance;
                            loc54.trainingTimeAbsolute = loc54.trainingTime;
                        }
                        else 
                        {
                            loc54.distanceAbsolute = loc17.distanceAbsolute + loc54.distance;
                            loc54.trainingTimeAbsolute = loc17.trainingTimeAbsolute + loc54.trainingTime;
                        }
                        ++loc63;
                        if (loc63 == arg1.maxSpeedEntry) 
                        {
                            loc54.speed = arg1.maximumSpeed;
                        }
                        if (loc63 == arg1.maxAltitudeEntry) 
                        {
                            loc54.altitude = arg1.maximumAltitude;
                        }
                        if (loc63 == arg1.maxInclineUphillEntry) 
                        {
                            loc54.incline = arg1.maximumInclineUphill;
                        }
                        if (loc63 == arg1.maxInclineDownhillEntry) 
                        {
                            loc54.incline = arg1.maximumInclineDownhill;
                        }
                        if (arg1.unitType == core.general.UnitType.ROX110) 
                        {
                            if (loc63 == arg1.maxRiseRateUphillEntry) 
                            {
                                loc54.riseRate = arg1.maximumRiseRateUphill;
                            }
                            if (loc63 == arg1.maxRiseRateDownhillEntry) 
                            {
                                loc54.riseRate = arg1.maximumRiseRateDownhill;
                            }
                            if (loc63 == arg1.maxPowerEntry) 
                            {
                                loc54.power = arg1.maximumPower;
                            }
                            if (loc63 == arg1.maxHeartrateEntry) 
                            {
                                loc54.heartrate = arg1.maximumHeartrate;
                            }
                            if (loc63 == arg1.maxCadenceEntry) 
                            {
                                loc54.cadence = arg1.maximumCadence;
                            }
                        }
                        arg1.entries.push(loc54);
                        loc17 = loc54;
                        if (loc54.power > 0 || arg1.averagePowerCalc == 1) 
                        {
                            loc41 = loc41 + loc54.power;
                            ++loc47;
                        }
                        if (loc54.powerPerKG > 0 || arg1.averagePowerCalc == 1) 
                        {
                            loc37 = loc37 + loc54.powerPerKG;
                            ++loc25;
                        }
                        if (loc54.normalizedPower > 0 || arg1.averagePowerCalc == 1) 
                        {
                            loc52 = loc52 + loc54.normalizedPower;
                            ++loc27;
                        }
                        if (loc54.cadence > 0 || arg1.averageCadenceCalc == 1) 
                        {
                            loc56 = loc56 + loc54.cadence;
                            ++loc12;
                        }
                        if (loc54.heartrate > 0) 
                        {
                            loc19 = loc19 + loc54.heartrate;
                            ++loc59;
                        }
                        if (loc54.rightBalance > 0) 
                        {
                            loc35 = loc35 + loc54.rightBalance;
                            ++loc40;
                        }
                        if (loc54.incline > 0) 
                        {
                            loc10 = loc10 + loc54.incline;
                            ++loc36;
                        }
                        else if (loc54.incline < 0) 
                        {
                            loc9 = loc9 + loc54.incline;
                            ++loc16;
                        }
                        if (loc54.riseRate > 0) 
                        {
                            loc53 = loc53 + loc54.riseRate;
                            ++loc45;
                        }
                        else if (loc54.riseRate < 0) 
                        {
                            loc28 = loc28 + loc54.riseRate;
                            ++loc69;
                        }
                    }
                    continue;
                }
                if ((loc30[loc1] & 3) == 1) 
                {
                    if (arg1.recordValuesLoaded.length >= loc68 && (arg1.recordValuesLoaded[loc1] & 3) == 2) 
                    {
                        loc60 = arg1.recordValuesLoaded.splice(0, loc68);
                    }
                    else 
                    {
                        continue;
                    }
                    (loc43 = decodePause(loc30, loc60, arg1)).number = loc13;
                    if (loc17) 
                    {
                        loc43.distanceAbsolute = loc17.distanceAbsolute;
                        loc43.timeAbsolute = loc17.trainingTimeAbsolute;
                    }
                    if (loc70) 
                    {
                        loc43.distance = loc43.distanceAbsolute - loc70.distanceAbsolute;
                        loc43.time = loc43.timeAbsolute - loc70.timeAbsolute;
                    }
                    else 
                    {
                        loc43.distance = loc43.distanceAbsolute;
                        loc43.time = loc43.timeAbsolute;
                    }
                    arg1.markerList.push(loc43);
                    loc70 = loc43;
                    ++loc13;
                    if (arg1.entries.length < arg1.maxRiseRateUphillEntry) 
                    {
                        arg1.maxRiseRateUphillEntry = arg1.maxRiseRateUphillEntry - 2;
                    }
                    if (arg1.entries.length < arg1.maxRiseRateDownhillEntry) 
                    {
                        arg1.maxRiseRateDownhillEntry = arg1.maxRiseRateDownhillEntry - 2;
                    }
                    if (arg1.entries.length < arg1.maxPowerEntry) 
                    {
                        arg1.maxPowerEntry = arg1.maxPowerEntry - 2;
                    }
                    if (arg1.entries.length < arg1.maxHeartrateEntry) 
                    {
                        arg1.maxHeartrateEntry = arg1.maxHeartrateEntry - 2;
                    }
                    if (arg1.entries.length < arg1.maxCadenceEntry) 
                    {
                        arg1.maxCadenceEntry = arg1.maxCadenceEntry - 2;
                    }
                    if (arg1.entries.length < arg1.best5KEntry) 
                    {
                        loc64 = loc64 + 2;
                    }
                    if (arg1.unitType == core.general.UnitType.ROX110) 
                    {
                        if (arg1.entries.length < arg1.best20minPowerEntry) 
                        {
                            arg1.best20minPowerEntry = arg1.best20minPowerEntry - 2;
                        }
                    }
                    continue;
                }
                trace("wrong Indicator");
            }
            arg1.best5KEntry = arg1.best5KEntry - loc64;
            var loc50:*=core.activities.ActivityFactory.createLogEntryFromLog(arg1);
            if (arg1.entries.length > 0) 
            {
                if (!((loc38 = arg1.entries[0]).trainingTime == 0) || !(loc38.distance == 0)) 
                {
                    loc50.trainingTime = 0;
                    loc50.distance = 0;
                    loc50.speed = loc38.speed;
                    if (loc50.speed > 0) 
                    {
                        loc50.speedTime = Math.floor(1000 / loc50.speed);
                    }
                    else 
                    {
                        loc50.speedTime = 1200;
                    }
                    loc50.altitude = loc38.altitude;
                    loc50.temperature = loc38.temperature;
                    loc50.incline = loc38.incline;
                    loc50.latitude = loc38.latitude;
                    loc50.longitude = loc38.longitude;
                    loc50.riseRate = loc38.riseRate;
                    loc50.heartrate = loc38.heartrate;
                    loc50.cadence = loc38.cadence;
                    loc50.power = loc38.power;
                }
            }
            arg1.entries.unshift(loc50);
            utils.Calculations.calculateCaloriesBasedOnSpeed(arg1);
            var loc15:*;
            if ((loc15 = arg1.entries.length) > 0) 
            {
                if (arg1.entries[0].power > 0 || arg1.averagePowerCalc == 1) 
                {
                    loc41 = loc41 + arg1.entries[0].power;
                    ++loc47;
                }
                if (arg1.entries[0].power > 0 || arg1.averagePowerCalc == 1) 
                {
                    loc37 = loc37 + arg1.entries[0].powerPerKG;
                    ++loc25;
                }
                if (arg1.entries[0].normalizedPower > 0 || arg1.averagePowerCalc == 1) 
                {
                    loc52 = loc52 + arg1.entries[0].normalizedPower;
                    ++loc27;
                }
                if (arg1.entries[0].cadence > 0 || arg1.averageCadenceCalc == 1) 
                {
                    loc56 = loc56 + arg1.entries[0].cadence;
                    ++loc12;
                }
                if (arg1.entries[0].heartrate > 0) 
                {
                    loc19 = loc19 + arg1.entries[0].heartrate;
                    ++loc59;
                }
                if (arg1.entries[0].rightBalance > 0) 
                {
                    loc35 = loc35 + arg1.entries[0].rightBalance;
                    ++loc40;
                }
                if (arg1.entries[0].incline > 0) 
                {
                    loc10 = loc10 + arg1.entries[0].incline;
                    ++loc36;
                }
                else if (arg1.entries[0].incline < 0) 
                {
                    loc9 = loc9 + arg1.entries[0].incline;
                    ++loc16;
                }
                if (arg1.entries[0].riseRate > 0) 
                {
                    loc53 = loc53 + arg1.entries[0].riseRate;
                    ++loc45;
                }
                else if (arg1.entries[0].riseRate < 0) 
                {
                    loc28 = loc28 + arg1.entries[0].riseRate;
                    ++loc69;
                }
                loc31 = arg1.calories / loc15;
                loc7 = arg1.workInKJ / loc15;
                loc65 = loc41 / loc47;
                loc67 = arg1.averagePower / loc65;
                loc57 = loc37 / loc25;
                loc44 = arg1.averagePowerWattPerKG / loc57;
                loc2 = loc52 / loc27;
                loc29 = arg1.powerNP / loc2;
                if (isNaN(loc29) || !isFinite(loc29)) 
                {
                    loc29 = 0;
                }
                loc14 = loc56 / loc12;
                loc58 = arg1.averageCadence / loc14;
                if (isNaN(loc58) || !isFinite(loc58)) 
                {
                    loc58 = 0;
                }
                loc49 = loc19 / loc59;
                loc20 = arg1.averageHeartrate / loc49;
                if (isNaN(loc20) || !isFinite(loc20)) 
                {
                    loc20 = 0;
                }
                loc61 = loc35 / loc40;
                loc51 = arg1.averageBalanceRight / loc61;
                if (isNaN(loc51) || !isFinite(loc51)) 
                {
                    loc51 = 0;
                }
                loc8 = loc10 / loc36;
                loc6 = arg1.averageInclineUphill / loc8;
                if (isNaN(loc6) || !isFinite(loc6)) 
                {
                    loc6 = 0;
                }
                loc33 = loc9 / loc16;
                loc48 = arg1.averageInclineDownhill / loc33;
                if (isNaN(loc48) || !isFinite(loc48)) 
                {
                    loc48 = 0;
                }
                loc4 = loc53 / loc45;
                loc3 = arg1.averageRiseRateUphill / loc4;
                if (isNaN(loc3) || !isFinite(loc3)) 
                {
                    loc3 = 0;
                }
                loc18 = loc28 / loc69;
                loc11 = arg1.averageRiseRateDownhill / loc18;
                if (isNaN(loc11) || !isFinite(loc11)) 
                {
                    loc11 = 0;
                }
                loc42 = 0;
                loc34 = 0;
                loc62 = 0;
                loc32 = 0;
                loc26 = 0;
                loc23 = 0;
                loc22 = 0;
                loc21 = 0;
                loc24 = 0;
                loc55 = 0;
                while (loc55 < loc15) 
                {
                    (loc5 = arg1.entries[loc55]).calories = loc31;
                    loc5.workInKJ = loc7;
                    if (!isNaN(loc67)) 
                    {
                        loc5.power = loc5.power * loc67;
                    }
                    if (!isNaN(loc44)) 
                    {
                        loc5.powerPerKG = loc5.powerPerKG * loc44;
                    }
                    if (!isNaN(loc29)) 
                    {
                        loc5.normalizedPower = loc5.normalizedPower * loc29;
                    }
                    if (!isNaN(loc58)) 
                    {
                        loc5.cadence = loc5.cadence * loc58;
                    }
                    if (!isNaN(loc20)) 
                    {
                        loc5.heartrate = loc5.heartrate * loc20;
                    }
                    if (!isNaN(loc51)) 
                    {
                        loc5.rightBalance = loc5.rightBalance * loc51;
                    }
                    if (loc5.incline > 0 && !isNaN(loc6)) 
                    {
                        loc5.incline = loc5.incline * loc6;
                    }
                    else if (loc5.incline < 0 && !isNaN(loc48)) 
                    {
                        loc5.incline = loc5.incline * loc48;
                    }
                    if (loc5.riseRate > 0 && !isNaN(loc3)) 
                    {
                        loc5.riseRate = loc5.riseRate * loc3;
                    }
                    else if (loc5.riseRate < 0 && !isNaN(loc11)) 
                    {
                        loc5.riseRate = loc5.riseRate * loc11;
                    }
                    loc42 = loc42 + loc5.timeBelowTargetZone;
                    loc34 = loc34 + loc5.timeInTargetZone;
                    loc62 = loc62 + loc5.timeAboveTargetZone;
                    loc32 = loc32 + loc5.timeBelowIntensityZones;
                    loc26 = loc26 + loc5.timeInIntensityZone1;
                    loc23 = loc23 + loc5.timeInIntensityZone2;
                    loc22 = loc22 + loc5.timeInIntensityZone3;
                    loc21 = loc21 + loc5.timeInIntensityZone4;
                    loc24 = loc24 + loc5.timeAboveIntensityZones;
                    if (loc55 == 0) 
                    {
                        arg1.minimumAltitude = loc5.altitude;
                        arg1.minimumPower = loc5.power;
                        arg1.minimumCadence = loc5.cadence;
                        if (loc54 != null) 
                        {
                            arg1.minimumSpeed = loc54.speed;
                            arg1.minimumHeartrate = loc54.heartrate;
                            arg1.minimumIncline = loc54.incline;
                            arg1.minimumInclineDownhill = loc54.incline;
                            arg1.minimumInclineUphill = loc54.incline;
                            arg1.minimumRiseRate = loc54.riseRate;
                            arg1.minimumRiseRateUphill = loc54.riseRate;
                            arg1.minimumRiseRateDownhill = loc54.riseRate;
                        }
                    }
                    arg1.minimumAltitude = Math.min(arg1.minimumAltitude, loc5.altitude);
                    arg1.minimumPower = Math.min(arg1.minimumPower, loc5.power);
                    arg1.minimumCadence = Math.min(arg1.minimumCadence, loc5.cadence);
                    arg1.minimumSpeed = Math.min(arg1.minimumSpeed, loc5.speed);
                    arg1.minimumHeartrate = Math.min(arg1.minimumHeartrate, loc5.heartrate);
                    arg1.minimumIncline = Math.min(arg1.minimumIncline, loc5.incline);
                    if (loc5.incline < 0) 
                    {
                        arg1.minimumInclineDownhill = Math.min(arg1.minimumInclineDownhill, loc5.incline);
                    }
                    else if (loc5.incline > 0) 
                    {
                        arg1.minimumInclineUphill = Math.min(arg1.minimumInclineUphill, loc5.incline);
                    }
                    arg1.minimumRiseRate = Math.min(arg1.minimumRiseRate, loc5.riseRate);
                    if (loc5.riseRate < 0) 
                    {
                        arg1.minimumRiseRateDownhill = Math.min(arg1.minimumRiseRateDownhill, loc5.riseRate);
                    }
                    else if (loc5.riseRate > 0) 
                    {
                        arg1.minimumRiseRateUphill = Math.min(arg1.minimumRiseRateUphill, loc5.riseRate);
                    }
                    if (loc55 == arg1.maxSpeedEntry) 
                    {
                        loc5.speed = arg1.maximumSpeed;
                    }
                    if (loc55 == arg1.maxAltitudeEntry) 
                    {
                        loc5.altitude = arg1.maximumAltitude;
                    }
                    if (loc55 == arg1.maxInclineUphillEntry) 
                    {
                        loc5.incline = arg1.maximumInclineUphill;
                    }
                    if (loc55 == arg1.maxInclineDownhillEntry) 
                    {
                        loc5.incline = arg1.maximumInclineDownhill;
                    }
                    if (arg1.unitType == core.general.UnitType.ROX110) 
                    {
                        if (loc55 == arg1.maxRiseRateUphillEntry) 
                        {
                            loc5.riseRate = arg1.maximumRiseRateUphill;
                        }
                        if (loc55 == arg1.maxRiseRateDownhillEntry) 
                        {
                            loc5.riseRate = arg1.maximumRiseRateDownhill;
                        }
                        if (loc55 == arg1.maxPowerEntry) 
                        {
                            loc5.power = arg1.maximumPower;
                        }
                        if (loc55 == arg1.maxHeartrateEntry) 
                        {
                            loc5.heartrate = arg1.maximumHeartrate;
                        }
                        if (loc55 == arg1.maxCadenceEntry) 
                        {
                            loc5.cadence = arg1.maximumCadence;
                        }
                    }
                    ++loc55;
                }
                arg1.timeUnderIntensityZone = loc32;
                arg1.timeInIntensityZone1 = loc26;
                arg1.timeInIntensityZone2 = loc23;
                arg1.timeInIntensityZone3 = loc22;
                arg1.timeInIntensityZone4 = loc21;
                arg1.timeOverIntensityZone = loc24;
            }
            var loc39:*=0;
            if (arg1.unitType != core.general.UnitType.ROX110) 
            {
                if (arg1.unitType == core.general.UnitType.ROX70) 
                {
                    loc39 = 56;
                }
            }
            else 
            {
                loc39 = 80;
            }
            while (arg1.lapValuesLoaded.length > 0) 
            {
                loc66 = decodeLap(arg1.lapValuesLoaded.splice(0, loc39), arg1);
                arg1.markerList.push(loc66);
            }
            arg1.markerList = arg1.markerList.sort(sortMarkerOnNumber);
            handler.ActivityCalculator.calculateMarkerAbsoluteValues(arg1, "l");
            while (arg1.autoLapValuesLoaded.length > 0) 
            {
                loc66 = decodeLap(arg1.autoLapValuesLoaded.splice(0, loc39), arg1);
                arg1.markerList.push(loc66);
            }
            arg1.markerList = arg1.markerList.sort(sortMarkerOnNumber);
            handler.ActivityCalculator.calculateMarkerAbsoluteValues(arg1, "al");
            return;
        }

        public function decodeTrackHeader(arg1:Object):core.route.Route
        {
            var loc3:*=arg1 as Array;
            var loc4:*;
            (loc4 = new core.route.Route()).loadedFrom = "loadedFromDevice";
            loc4.ownTrack = false;
            loc4.creationTimestamp = new Date();
            var loc7:*=0;
            var loc5:*=0;
            loc5 = 0;
            while (loc5 <= 64) 
            {
                loc4.name = loc4.name + com.hurlant.util.Hex.toString(loc3[loc5].toString(16));
                ++loc5;
            }
            loc7 = (loc7 = loc3[66]) | loc3[67] << 8;
            loc4.downloadId = loc7.toString();
            loc7 = (loc7 = (loc7 = (loc7 = (loc7 = loc3[68]) | loc3[69] << 8) | loc3[70] << 16) | loc3[71] << 24) / 100;
            loc4.distance = loc7;
            loc7 = (loc7 = loc3[72]) | loc3[73] << 8;
            loc4.altitudeDifferencesUphill = loc7 * 1000;
            loc4.rating = loc3[74];
            loc5 = 0;
            while (loc5 <= 170) 
            {
                loc4.description = loc4.description + com.hurlant.util.Hex.toString(loc3[loc5 + 75].toString(16));
                ++loc5;
            }
            loc7 = (loc7 = loc3[246]) | loc3[247] << 8;
            loc4.routePointsToLoad = loc7;
            loc7 = (loc7 = (loc7 = (loc7 = (loc7 = arg1[248]) | arg1[249] << 8) | arg1[250] << 16) | arg1[251] << 24) / 1000000;
            loc4.latitudeStart = parseFloat(loc7.toFixed(9));
            loc7 = (loc7 = (loc7 = (loc7 = (loc7 = arg1[252]) | arg1[253] << 8) | arg1[254] << 16) | arg1[255] << 24) / 1000000;
            loc4.longitudeStart = parseFloat(loc7.toFixed(9));
            var loc6:*=new flash.utils.ByteArray();
            var loc1:*="";
            loc5 = 0;
            while (loc5 < 16) 
            {
                loc6.writeByte(loc3[256 + loc5]);
                if (loc5 == 3 || loc5 == 5 || loc5 == 7 || loc5 == 9 || loc5 == 15) 
                {
                    loc1 = loc1 + com.hurlant.util.Hex.fromArray(loc6);
                    loc6.clear();
                    if (loc5 != 15) 
                    {
                        loc1 = loc1 + "-";
                    }
                }
                ++loc5;
            }
            loc4.GUID = loc1.toUpperCase();
            loc7 = 2.81474976711e+014;
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeByte(loc3[272]);
            loc2.writeByte(loc3[273]);
            loc2.writeByte(loc3[274]);
            loc2.writeByte(loc3[275]);
            loc2.writeByte(loc3[276]);
            loc2.writeByte(loc3[277]);
            loc4.modificationDate = parseInt(com.hurlant.util.Hex.fromArray(loc2), 16);
            loc7 = (loc7 = loc3[278]) | loc3[279] << 8;
            loc4.altitudeDifferencesDownhill = loc7 * 1000;
            return loc4;
        }

        public function decodeTrack(arg1:core.route.Route):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=0;
            arg1.routePoisToLoad = 0;
            while (arg1.routePointsLoaded.length > 0) 
            {
                loc1 = arg1.routePointsLoaded.splice(0, 12);
                loc3 = decodeTrackPoint(loc1);
                ++loc2;
                if (loc3.waypointIndex != 0) 
                {
                    arg1.routePoisToLoad = (arg1.routePoisToLoad + 1);
                }
                arg1.routePoints.push(loc3);
            }
            core.route.Route.setImportedRouteStartPoints(arg1);
            return;
        }

        public function decodeWaypoints(arg1:core.route.Route):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=0;
            while (arg1.waypointsLoaded.length > 0) 
            {
                loc1 = arg1.waypointsLoaded.splice(0, 72);
                (loc3 = decodeWaypoint(loc1)).routeId = arg1.routeId;
                arg1.pois.push(loc3);
            }
            return;
        }

        public function encodeStraveSegmentHeader(arg1:core.strava.StravaSegment):Array
        {
            var loc1:*=[];
            setBytes(loc1, arg1.id, 0, 16);
            var loc3:*=0;
            var loc2:*=arg1.name.length;
            loc3 = 0;
            while (loc3 <= 30) 
            {
                if (loc3 < loc2) 
                {
                    loc1[loc3 + 16] = arg1.name.charCodeAt(loc3);
                }
                ++loc3;
            }
            setBytes(loc1, arg1.compareTo, 47, 1);
            setBytes(loc1, arg1.latlng_reduced.length, 48, 2);
            loc1[50] = 0;
            loc1[51] = 0;
            setBytes(loc1, arg1.start_latitude * 1000000, 52, 4);
            setBytes(loc1, arg1.start_longitude * 1000000, 56, 4);
            setBytes(loc1, arg1.end_latitude * 1000000, 60, 4);
            setBytes(loc1, arg1.end_longitude * 1000000, 64, 4);
            setBytes(loc1, arg1.distance, 68, 4);
            setBytes(loc1, arg1.elevation_high - arg1.elevation_low, 72, 4);
            if (arg1.kom > 0) 
            {
                setBytes(loc1, arg1.kom * 10, 76, 4);
                setBytes(loc1, arg1.kom * 10, 80, 4);
            }
            else if (arg1.qom > 0) 
            {
                setBytes(loc1, arg1.qom * 10, 76, 4);
                setBytes(loc1, arg1.qom * 10, 80, 4);
            }
            setBytes(loc1, arg1.athlete_segment_stats * 10, 84, 4);
            setBytes(loc1, arg1.rival_time * 10, 88, 4);
            setBytes(loc1, arg1.goal_time, 92, 4);
            setBytes(loc1, arg1.startEntryBearing, 96, 2);
            setBytes(loc1, 0, 98, 2);
            return loc1;
        }

        public function encodeStravaSegment(arg1:core.strava.StravaSegment):Array
        {
            var loc2:*=null;
            var loc6:*=[];
            var loc4:*=0;
            if (arg1.latlng_reduced == null) 
            {
                if (arg1.latlng && arg1.latlng.length < 2000) 
                {
                    arg1.latlng_reduced = arg1.latlng;
                }
                else 
                {
                    return loc6;
                }
            }
            var loc5:*=0;
            if (arg1.kom > 0) 
            {
                loc5 = arg1.distance / arg1.kom * 3.6 * 100;
            }
            else if (arg1.qom > 0) 
            {
                loc5 = arg1.distance / arg1.qom * 3.6 * 100;
            }
            var loc7:*=0;
            if (arg1.athlete_segment_stats > 0) 
            {
                loc7 = arg1.distance / arg1.athlete_segment_stats * 3.6 * 100;
            }
            var loc1:*=0;
            if (arg1.rival_time > 0) 
            {
                loc1 = arg1.distance / arg1.rival_time * 3.6 * 100;
            }
            var loc3:*=0;
            if (arg1.goal_time > 0) 
            {
                loc3 = arg1.distance / arg1.goal_time * 3.6 * 100;
            }
            loc4 = 0;
            while (loc4 < arg1.latlng_reduced.length) 
            {
                loc2 = [];
                setBytes(loc2, arg1.latlng_reduced[loc4].latitude * 1000000, 0, 4);
                setBytes(loc2, arg1.latlng_reduced[loc4].longitude * 1000000, 4, 4);
                setBytes(loc2, loc5, 8, 2);
                setBytes(loc2, loc7, 10, 2);
                setBytes(loc2, loc1, 12, 2);
                setBytes(loc2, loc3, 14, 2);
                setBytes(loc2, loc5, 16, 2);
                loc2[18] = 0;
                loc2[19] = 0;
                loc6 = loc6.concat(loc2);
                ++loc4;
            }
            return loc6;
        }

        public function encodeTrackHeader(arg1:core.route.Route):Array
        {
            var loc7:*=0;
            var loc10:*=NaN;
            var loc3:*=new Array(280);
            loc7 = 0;
            while (loc7 < loc3.length) 
            {
                loc3[loc7] = 0;
                ++loc7;
            }
            loc7 = 0;
            var loc6:*=arg1.name.length;
            loc7 = 0;
            while (loc7 <= 64) 
            {
                if (loc7 < loc6) 
                {
                    loc3[loc7] = arg1.name.charCodeAt(loc7);
                }
                ++loc7;
            }
            loc10 = arg1.routeId;
            loc3[65] = loc10 & 255;
            loc3[66] = loc10 >> 8 & 255;
            loc3[67] = loc10 >> 16 & 255;
            loc10 = arg1.distance * 100;
            loc3[68] = loc10 & 255;
            loc3[69] = loc10 >> 8 & 255;
            loc3[70] = loc10 >> 16 & 255;
            loc3[71] = loc10 >> 24 & 255;
            loc10 = arg1.altitudeDifferencesUphill / 1000;
            loc3[72] = loc10 & 255;
            loc3[73] = loc10 >> 8 & 255;
            loc10 = arg1.rating;
            loc3[74] = loc10;
            var loc11:*=arg1.description.length;
            var loc4:*=" ";
            loc7 = 0;
            while (loc7 <= 170) 
            {
                if (loc7 < loc11) 
                {
                    loc3[75 + loc7] = arg1.description.charCodeAt(loc7);
                }
                ++loc7;
            }
            loc10 = arg1.routePointsReduced.length;
            loc3[246] = loc10 & 255;
            loc3[247] = loc10 >> 8 & 255;
            loc10 = arg1.latitudeStart * 1000000;
            loc3[248] = loc10 & 255;
            loc3[249] = loc10 >> 8 & 255;
            loc3[250] = loc10 >> 16 & 255;
            loc3[251] = loc10 >> 24 & 255;
            loc10 = arg1.longitudeStart * 1000000;
            loc3[252] = loc10 & 255;
            loc3[253] = loc10 >> 8 & 255;
            loc3[254] = loc10 >> 16 & 255;
            loc3[255] = loc10 >> 24 & 255;
            var loc5:*=new RegExp("-", "g");
            var loc1:*=arg1.GUID.replace(loc5, "");
            var loc8:*=loc1.split("");
            loc7 = 0;
            while (loc7 < 16) 
            {
                if (loc8[loc7 * 2] != null) 
                {
                    loc3[256 + loc7] = parseInt(loc8[loc7 * 2], 16) << 4;
                }
                if (loc8[loc7 * 2 + 1] != null) 
                {
                    var loc12:*=256 + loc7;
                    var loc13:*=loc3[loc12] | parseInt(loc8[loc7 * 2 + 1], 16);
                    loc3[loc12] = loc13;
                }
                ++loc7;
            }
            var loc2:*=arg1.modificationDate.toString(16);
            var loc9:*=loc2.split("");
            while (loc9.length < 12) 
            {
                loc9.unshift("0");
            }
            loc7 = 0;
            while (loc7 < 6) 
            {
                if (loc9[loc7 * 2] != null) 
                {
                    loc3[272 + loc7] = parseInt(loc9[loc7 * 2], 16) << 4;
                }
                if (loc9[loc7 * 2 + 1] != null) 
                {
                    loc13 = 272 + loc7;
                    loc12 = loc3[loc13] | parseInt(loc9[loc7 * 2 + 1], 16);
                    loc3[loc13] = loc12;
                }
                ++loc7;
            }
            loc10 = arg1.altitudeDifferencesDownhill / 1000;
            loc3[278] = loc10 & 255;
            loc3[279] = loc10 >> 8 & 255;
            return loc3;
        }

        public function encodeTrack(arg1:core.route.Route):Array
        {
            var loc1:*=[];
            var loc3:*=0;
            var loc2:*=arg1.routePointsReduced.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = loc1.concat(encodeTrackPoint(arg1.routePointsReduced[loc3]));
                ++loc3;
            }
            return loc1;
        }

        public function encodeWayPointHeader(arg1:int):Array
        {
            var loc2:*=0;
            var loc1:*=new Array(72);
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            loc1[0] = arg1 & 255;
            loc1[1] = arg1 >> 8 & 255;
            return loc1;
        }

        public function encodeWayPoint(arg1:core.route.RoutePoi, arg2:core.route.Route):Array
        {
            var loc4:*=NaN;
            var loc3:*=0;
            var loc2:*=new Array(72);
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                loc2[loc3] = 0;
                ++loc3;
            }
            loc4 = arg1.latitude * 1000000;
            loc2[0] = loc4 & 255;
            loc2[1] = loc4 >> 8 & 255;
            loc2[2] = loc4 >> 16 & 255;
            loc2[3] = loc4 >> 24 & 255;
            loc4 = arg1.longitude * 1000000;
            loc2[4] = loc4 & 255;
            loc2[5] = loc4 >> 8 & 255;
            loc2[6] = loc4 >> 16 & 255;
            loc2[7] = loc4 >> 24 & 255;
            loc2[8] = 0;
            loc2[9] = core.general.POICategories.categoryId(arg1.type);
            var loc1:*=arg1.name;
            loc3 = 0;
            while (loc3 < 58) 
            {
                if (loc3 < loc1.length) 
                {
                    loc2[loc3 + 10] = loc1.charCodeAt(loc3);
                }
                ++loc3;
            }
            loc2[68] = parseInt(arg2.downloadId) & 255;
            loc2[69] = parseInt(arg2.downloadId) >> 8 & 255;
            loc2[70] = arg1.wayTTPId_curId & 255;
            loc2[71] = arg1.wayTTPId_curId >> 8 & 255;
            return loc2;
        }

        public function decodeWaypoint(arg1:Object):core.route.RoutePoi
        {
            var loc1:*=new core.route.RoutePoi();
            var loc2:*=0;
            var loc3:*=0;
            loc1.latitude = (arg1[3] << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0]) / 1000000;
            loc1.longitude = (arg1[7] << 24 | arg1[6] << 16 | arg1[5] << 8 | arg1[4]) / 1000000;
            loc3 = arg1[9];
            loc1.type = core.general.POICategories.categoryType(loc3);
            loc2 = 0;
            while (loc2 < 58) 
            {
                loc1.name = loc1.name + com.hurlant.util.Hex.toString(arg1[loc2 + 10].toString(16));
                ++loc2;
            }
            loc3 = (loc3 = arg1[70]) | arg1[71] << 8;
            loc1.wayTTPId_curId = loc3;
            return loc1;
        }

        public function decodeTotals(arg1:Object):core.totals.Totals
        {
            _myUnitTotals = new core.totals.TotalsROX70();
            return decodeCommonTotals(arg1, _myUnitTotals);
        }

        protected function decodeCommonTotals(arg1:Object, arg2:core.totals.Totals):core.totals.Totals
        {
            var loc1:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 514, "ROX100Decoder > decodeTotals: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            arg2.unitType = unit.type;
            arg2.unit = unit;
            (arg2 as core.totals.interfaces.ITotalActivityCount1).totalActivityCount1 = loc1[3] << 24 | loc1[2] << 16 | loc1[1] << 8 | loc1[0];
            (arg2 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = (loc1[7] << 24 | loc1[6] << 16 | loc1[5] << 8 | loc1[4]) * 10;
            (arg2 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc1[11] << 24 | loc1[10] << 16 | loc1[9] << 8 | loc1[8];
            (arg2 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = (loc1[15] << 24 | loc1[14] << 16 | loc1[13] << 8 | loc1[12]) * 1000;
            (arg2 as core.totals.interfaces.ITotalDescent1).totalDescent1 = (loc1[19] << 24 | loc1[18] << 16 | loc1[17] << 8 | loc1[16]) * -1000;
            (arg2 as core.totals.interfaces.ITotalCal1).totalCal1 = loc1[23] << 24 | loc1[22] << 16 | loc1[21] << 8 | loc1[20];
            return arg2;
        }

        public function encodeTotals():Array
        {
            var loc4:*=[];
            var loc1:*=(totals as core.totals.interfaces.ITotalActivityCount1).totalActivityCount1;
            loc4[0] = loc1 & 255;
            loc4[1] = loc1 >> 8 & 255;
            loc4[2] = loc1 >> 16 & 255;
            loc4[3] = loc1 >> 24 & 255;
            var loc3:*=(totals as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 / 10;
            loc4[4] = loc3 & 255;
            loc4[5] = loc3 >> 8 & 255;
            loc4[6] = loc3 >> 16 & 255;
            loc4[7] = loc3 >> 24 & 255;
            var loc7:*=(totals as core.totals.interfaces.ITotalDistance1).totalDistance1;
            loc4[8] = loc7 & 255;
            loc4[9] = loc7 >> 8 & 255;
            loc4[10] = loc7 >> 16 & 255;
            loc4[11] = loc7 >> 24 & 255;
            var loc5:*=(totals as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 / 1000;
            loc4[12] = loc5 & 255;
            loc4[13] = loc5 >> 8 & 255;
            loc4[14] = loc5 >> 16 & 255;
            loc4[15] = loc5 >> 24 & 255;
            var loc6:*=(totals as core.totals.interfaces.ITotalDescent1).totalDescent1 / -1000;
            loc4[16] = loc6 & 255;
            loc4[17] = loc6 >> 8 & 255;
            loc4[18] = loc6 >> 16 & 255;
            loc4[19] = loc6 >> 24 & 255;
            var loc2:*=(totals as core.totals.interfaces.ITotalCal1).totalCal1;
            loc4[20] = loc2 & 255;
            loc4[21] = loc2 >> 8 & 255;
            loc4[22] = loc2 >> 16 & 255;
            loc4[23] = loc2 >> 24 & 255;
            return loc4;
        }

        public function decodeSportProfile(arg1:Object):core.sportprofiles.Sportprofile
        {
            var loc2:*=new core.sportprofiles.SportProfileROX70();
            var loc1:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 534, "ROX70Decoder > decodeSportProfile: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            loc2 = decodeCommonSportProfile(loc2, loc1) as core.sportprofiles.SportProfileROX70;
            return loc2;
        }

        protected function decodeCommonSportProfile(arg1:core.sportprofiles.Sportprofile, arg2:Array):core.sportprofiles.Sportprofile
        {
            var loc6:*=null;
            var loc8:*=null;
            var loc1:*=0;
            var loc4:*=null;
            arg1.profileName = "";
            var loc5:*=0;
            loc5 = 0;
            while (loc5 <= 15) 
            {
                arg1.profileName = arg1.profileName + com.hurlant.util.Hex.toString(arg2[loc5].toString(16));
                ++loc5;
            }
            arg1.sportId = arg2[17];
            var loc9:*=22;
            var loc2:*=8;
            var loc7:*=0;
            loc5 = 1;
            while (loc5 <= 6) 
            {
                (loc6 = new core.sportprofiles.FavFunctionList()).templateId = arg2[loc9 + 0];
                loc6.active = arg2[loc9 + 0] > 0;
                loc7 = 1;
                while (loc7 <= 6) 
                {
                    loc8 = new core.sportprofiles.FavFunctionlistItem(arg2[loc9 + loc7], loc7);
                    loc6.changeFavFunction(loc8);
                    ++loc7;
                }
                arg1.changeFavFunctionList(loc5, loc6);
                loc9 = loc9 + loc2;
                ++loc5;
            }
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                (arg1 as core.settings.interfaces.IAutoPause).autoPause = !((arg2[70] & 2) >> 1);
            }
            var loc3:*=(arg2[70] & 4) >> 2;
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                (arg1 as core.settings.interfaces.IAutoLap).autoLapBasedOn = (arg2[70] & 224) >> 5;
                if (loc3 != 0) 
                {
                    (arg1 as core.settings.interfaces.IAutoLap).autoLap = 0;
                }
                else 
                {
                    (arg1 as core.settings.interfaces.IAutoLap).autoLap = 1 + (arg1 as core.settings.interfaces.IAutoLap).autoLapBasedOn;
                }
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                if (core.MeasurementConfig.distanceFormat != "kilometer") 
                {
                    loc1 = arg2[79] << 24 | arg2[78] << 16 | arg2[77] << 8 | arg2[76];
                    loc4 = new utils.converter.AltitudeConverter("feet", "millimeter");
                    (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = Math.round(loc4.convert(loc1));
                }
                else 
                {
                    (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = (arg2[75] << 24 | arg2[74] << 16 | arg2[73] << 8 | arg2[72]) * 1000;
                }
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime = (arg2[81] << 8 | arg2[80]) * 100;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories = arg2[83] << 8 | arg2[82];
            }
            arg1.data = arg2;
            return arg1;
        }

        public function encodeSportProfile(arg1:core.sportprofiles.Sportprofile):Array
        {
            return encodeCommonSportprofile(arg1);
        }

        protected function encodeCommonSportprofile(arg1:core.sportprofiles.Sportprofile):Array
        {
            var loc11:*=null;
            var loc5:*=null;
            var loc12:*=0;
            var loc7:*=null;
            var loc2:*=0;
            var loc10:*=0;
            var loc3:*=0;
            var loc1:*=[];
            var loc4:*=0;
            var loc8:*=0;
            loc4 = 0;
            while (loc4 <= 16) 
            {
                loc8 = arg1.profileName.charCodeAt(loc4);
                loc1[loc4] = isNaN(loc8) ? 0 : loc8;
                ++loc4;
            }
            loc1[16] = 0;
            loc1[17] = arg1.sportId;
            arg1.sport = core.sport.SportLoader.getInstance().getSportById(arg1.sportId);
            loc1[18] = arg1.sport.shortName.charCodeAt(0);
            loc1[19] = arg1.sport.shortName.charCodeAt(1);
            loc1[20] = arg1.sport.shortName.charCodeAt(2);
            loc1[21] = 0;
            var loc13:*=22;
            var loc9:*=8;
            var loc6:*=0;
            loc4 = 1;
            while (loc4 <= 6) 
            {
                loc11 = new core.sportprofiles.FavFunctionList();
                loc11 = arg1.getFavSetObject(loc4);
                loc1[loc13 + 0] = loc11.active ? loc11.templateId : 0;
                loc6 = 0;
                while (loc6 < 6) 
                {
                    loc5 = loc11.getFavFunctionlistItem(loc6);
                    loc1[loc13 + loc6 + 1] = loc5 != null ? loc11.getFavFunctionlistItem(loc6).favFuncId : 0;
                    ++loc6;
                }
                loc1[loc13 + 7] = 255;
                loc13 = loc13 + loc9;
                ++loc4;
            }
            loc1[70] = 0;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                if (!(arg1 as core.settings.interfaces.IAutoPause).autoPause) 
                {
                    loc1[70] = loc1[70] | 2;
                }
            }
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                if ((arg1 as core.settings.interfaces.IAutoLap).autoLap == 0) 
                {
                    loc1[70] = loc1[70] | 4;
                }
                loc1[70] = loc1[70] | ((arg1 as core.settings.interfaces.IAutoLap).autoLap > 0 ? ((arg1 as core.settings.interfaces.IAutoLap).autoLap - 1) : 0) << 5;
            }
            loc1[71] = 0;
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                loc12 = (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance / 1000;
                loc1[72] = loc12 & 255;
                loc1[73] = loc12 >> 8 & 255;
                loc1[74] = loc12 >> 16 & 255;
                loc1[75] = loc12 >> 24 & 255;
                loc2 = (loc7 = new utils.converter.AltitudeConverter("millimeter", "feet")).convert((arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance);
                loc1[76] = loc2 & 255;
                loc1[77] = loc2 >> 8 & 255;
                loc1[78] = loc2 >> 16 & 255;
                loc1[79] = loc2 >> 24 & 255;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                loc10 = (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime / 100;
                loc1[80] = loc10 & 255;
                loc1[81] = loc10 >> 8 & 255;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                loc3 = (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories;
                loc1[82] = loc3 & 255;
                loc1[83] = loc3 >> 8 & 255;
            }
            return loc1;
        }

        protected function decodeCommonSettings(arg1:Object, arg2:core.settings.Settings):core.settings.Settings
        {
            var loc5:*=0;
            arg2.unitType = unit.type;
            arg2.unit = unit;
            arg2.date = new Date();
            var loc2:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc2)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 527, "ROX70Decoder > decodeSettings: wrong crc"));
            }
            loc2.splice(0, 3);
            loc2.pop();
            (arg2 as core.settings.interfaces.IMyName).myName = "";
            var loc3:*=0;
            loc3 = 0;
            while (loc3 <= 15) 
            {
                (arg2 as core.settings.interfaces.IMyName).myName = (arg2 as core.settings.interfaces.IMyName).myName + com.hurlant.util.Hex.toString(loc2[loc3].toString(16));
                ++loc3;
            }
            if (arg2 is core.settings.interfaces.IHRmax) 
            {
                (arg2 as core.settings.interfaces.IHRmax).hrMax = loc2[17];
            }
            (arg2 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = loc2[19] >> 7 != 1 ? (loc2[19] << 8 | loc2[18]) * 1000 : (loc2[19] << 8 | loc2[18] - 65536) * 1000;
            (arg2 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = loc2[23] >> 7 != 1 ? (loc2[23] << 8 | loc2[22]) * 1000 : (loc2[23] << 8 | loc2[22] - 65536) * 1000;
            (arg2 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 = loc2[27] >> 7 != 1 ? (loc2[27] << 8 | loc2[26]) * 1000 : (loc2[27] << 8 | loc2[26] - 65536) * 1000;
            if (arg2 is core.settings.interfaces.IYearOfBirth) 
            {
                (arg2 as core.settings.interfaces.IYearOfBirth).yearOfBirth = loc2[31] << 8 | loc2[30];
            }
            if (arg2 is core.settings.interfaces.IBodyWeight) 
            {
                (arg2 as core.settings.interfaces.IBodyWeight).bodyWeight = (loc2[33] << 8 | loc2[32]) * 1000;
            }
            if (arg2 is core.settings.interfaces.IBodyHeight) 
            {
                (arg2 as core.settings.interfaces.IBodyHeight).bodyHeight = loc2[37] << 8 | loc2[36];
            }
            if (arg2 is core.settings.interfaces.IShoulderWidth) 
            {
                (arg2 as core.settings.interfaces.IShoulderWidth).shoulderWidth = loc2[40];
            }
            (arg2 as core.settings.interfaces.IGender).gender = (loc2[42] & 1) != 0 ? "male" : "female";
            (arg2 as core.settings.interfaces.ISpeedUnit).speedUnit = (loc2[42] >> 1 & 1) != 0 ? "mph" : "kmh";
            (arg2 as core.settings.interfaces.IDistanceUnit).distanceUnit = (loc2[42] >> 2 & 1) != 0 ? "mile" : "kilometer";
            (arg2 as core.settings.interfaces.IAltitudeUnit).altitudeUnit = (loc2[42] >> 3 & 1) != 0 ? "feet" : "meter";
            (arg2 as core.settings.interfaces.ITemperatureUnit).temperatureUnit = (loc2[42] >> 4 & 1) != 0 ? "fahrenheit" : "celsius";
            if (arg2 is core.settings.interfaces.IWeightUnit) 
            {
                (arg2 as core.settings.interfaces.IWeightUnit).weightUnit = (loc2[42] >> 5 & 1) != 0 ? "lb" : "kg";
            }
            (arg2 as core.settings.interfaces.IClockMode).clockMode = (loc2[42] >> 6 & 1) != 0 ? "12" : "24";
            (arg2 as core.settings.interfaces.IDateFormat).dateFormat = (loc2[42] >> 7 & 1) != 0 ? "us" : "eu";
            (arg2 as core.settings.interfaces.IContrast).contrast = (loc2[43] & 15) + 1;
            (arg2 as core.settings.interfaces.ISummerTime).summerTime = (loc2[43] >> 5 & 1) != 0 ? false : true;
            (arg2 as core.settings.interfaces.ISystemTone).systemTone = (loc2[43] >> 6 & 1) != 0 ? false : true;
            (arg2 as core.settings.interfaces.IButtonTone).buttonTone = (loc2[43] >> 7 & 1) != 0 ? false : true;
            var loc4:*;
        }

        public function decodeSettings(arg1:Object):core.settings.Settings
        {
            _myUnitSettings = new core.settings.SettingsROX70();
            return decodeCommonSettings(arg1, _myUnitSettings);
        }

        public function encodeSettings():Array
        {
            return encodeCommonSettings(_myUnitSettings);
        }

        protected function encodeCommonSettings(arg1:core.settings.Settings):Array
        {
            var loc5:*=0;
            var loc17:*=0;
            var loc15:*=null;
            var loc6:*=0;
            var loc8:*=0;
            var loc7:*=0;
            var loc14:*=0;
            var loc2:*=[];
            var loc9:*=0;
            var loc13:*=0;
            loc9 = 0;
            while (loc9 <= 16) 
            {
                loc13 = (arg1 as core.settings.interfaces.IMyName).myName.charCodeAt(loc9);
                loc2[loc9] = isNaN(loc13) ? 0 : loc13;
                ++loc9;
            }
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                loc2[17] = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            else 
            {
                loc2[17] = 0;
            }
            var loc12:*=new utils.converter.AltitudeConverter("millimeter", "feet");
            var loc4:*=(arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 / 1000;
            loc2[18] = loc4 & 255;
            loc2[19] = loc4 >> 8 & 255;
            var loc11:*=loc12.convert((arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1);
            loc2[20] = loc11 & 255;
            loc2[21] = loc11 >> 8 & 255;
            var loc3:*=(arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 / 1000;
            loc2[22] = loc3 & 255;
            loc2[23] = loc3 >> 8 & 255;
            var loc16:*=loc12.convert((arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2);
            loc2[24] = loc16 & 255;
            loc2[25] = loc16 >> 8 & 255;
            var loc1:*=(arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 / 1000;
            loc2[26] = loc1 & 255;
            loc2[27] = loc1 >> 8 & 255;
            var loc10:*=loc12.convert((arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3);
            loc2[28] = loc10 & 255;
            loc2[29] = loc10 >> 8 & 255;
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc5 = (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
                loc2[30] = loc5 & 255;
                loc2[31] = loc5 >> 8;
            }
            else 
            {
                loc2[30] = 0;
                loc2[31] = 0;
            }
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                loc17 = (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight / 1000;
                loc2[32] = loc17 & 255;
                loc2[33] = loc17 >> 8;
                loc6 = (loc15 = new utils.converter.WeightConverter("g", "lb")).convert((arg1 as core.settings.interfaces.IBodyWeight).bodyWeight);
                loc2[34] = loc6 & 255;
                loc2[35] = loc6 >> 8;
            }
            else 
            {
                loc2[32] = 0;
                loc2[33] = 0;
                loc2[34] = 0;
                loc2[35] = 0;
            }
            var loc18:*=new utils.converter.SizeConverter("centimeter", "inch");
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                loc8 = (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight;
                loc2[36] = loc8 & 255;
                loc2[37] = loc8 >> 8;
                loc7 = loc18.convert((arg1 as core.settings.interfaces.IBodyHeight).bodyHeight);
                loc2[38] = loc7 & 255;
                loc2[39] = loc7 >> 8;
            }
            else 
            {
                loc2[36] = 0;
                loc2[37] = 0;
                loc2[38] = 0;
                loc2[39] = 0;
            }
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                loc2[40] = (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth;
                loc14 = loc18.convert((arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth);
                loc2[41] = loc14;
            }
            else 
            {
                loc2[40] = 0;
                loc2[41] = 0;
            }
            loc2[42] = 0;
            if ((arg1 as core.settings.interfaces.IGender).gender == "male") 
            {
                loc2[42] = 1;
            }
            if ((arg1 as core.settings.interfaces.ISpeedUnit).speedUnit == "mph") 
            {
                loc2[42] = loc2[42] | 2;
            }
            if ((arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit == "mile") 
            {
                loc2[42] = loc2[42] | 4;
            }
            if ((arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit == "feet") 
            {
                loc2[42] = loc2[42] | 8;
            }
            if ((arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit == "fahrenheit") 
            {
                loc2[42] = loc2[42] | 16;
            }
            if (arg1 is core.settings.interfaces.IWeightUnit) 
            {
                if ((arg1 as core.settings.interfaces.IWeightUnit).weightUnit == "lb") 
                {
                    loc2[42] = loc2[42] | 32;
                }
            }
            if ((arg1 as core.settings.interfaces.IClockMode).clockMode == "12") 
            {
                loc2[42] = loc2[42] | 64;
            }
            if ((arg1 as core.settings.interfaces.IDateFormat).dateFormat == "us") 
            {
                loc2[42] = loc2[42] | 128;
            }
            loc2[43] = 0;
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                loc2[43] = ((arg1 as core.settings.interfaces.IContrast).contrast - 1);
            }
            if (!(arg1 as core.settings.interfaces.ISummerTime).summerTime) 
            {
                loc2[43] = loc2[43] | 32;
            }
            if (!(arg1 as core.settings.interfaces.ISystemTone).systemTone) 
            {
                loc2[43] = loc2[43] | 64;
            }
            if (!(arg1 as core.settings.interfaces.IButtonTone).buttonTone) 
            {
                loc2[43] = loc2[43] | 128;
            }
            var loc19:*=(arg1 as core.settings.interfaces.ILanguage).language;
            while ("en" === loc19) 
            {
                loc2[44] = 0;
            }
        }

        internal function addZeroToHex(arg1:uint):String
        {
            return arg1 < 16 ? "0" + arg1.toString(16) : arg1.toString(16);
        }

        internal function sortMarkerOnNumber(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "number", false);
        }

        internal function setBytes(arg1:Array, arg2:*, arg3:uint, arg4:uint):void
        {
            if (arg1 == null || arg2 == null) 
            {
                return;
            }
            var loc1:*=0;
            while (loc1 < arg4) 
            {
                arg1[arg3 + loc1] = (loc1 != 0 ? arg2 >> 8 * loc1 : arg2) & 255;
                ++loc1;
            }
            return;
        }

        public static const TRACK_HEADER_SIZE:int=280;

        public static const TRACK_POINTS_SIZE:int=12;

        public static const ENCODED_DATA_SPLITTER:String=".";

        public static const WAY_POINT_SIZE:int=72;

        internal static const POI_DESC_LENGTH:int=58;

        internal static const POI_DESC_START_INDEX:int=10;

        public static const LAP_VALUES_SIZE:int=56;

        public static const RECORD_VALUES_SIZE:int=48;

        public static const WAY_POINT_HEADER_SIZE:int=72;

        protected var _speedConverter:utils.converter.SpeedConverter;

        protected var altitudeFormater:utils.interfaces.ICustomFormatter;

        protected var distanceConverter:utils.converter.DistanceConverter;

        protected var distanceForamtter:utils.interfaces.ICustomFormatter;

        internal var _myUnit:core.units.UnitROX70;

        internal var _myUnitSettings:core.settings.SettingsROX70;

        internal var _myUnitTotals:core.totals.Totals;

        protected var altitudeConverter:utils.converter.AltitudeConverter;

        internal static var _instance:decoder.Rox70Decoder;
    }
}


