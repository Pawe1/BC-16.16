//package decoder
//  package core
//    class DecodeError
package decoder.core 
{
    import core.activities.*;
    
    public class DecodeError extends Error
    {
        public function DecodeError(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            _id = arg2 as String;
            if (_id == null) 
            {
                _id = "";
            }
            _message = arg1 as String;
            if (_message == null) 
            {
                _message = "";
            }
            return;
        }

        public function toString():String
        {
            return "[#" + _id + "] " + _message;
        }

        public var activity:core.activities.Activity;

        internal var _id:String="";

        internal var _message:String="";
    }
}


//  class BCDEncoder
package decoder 
{
    public class BCDEncoder extends Object
    {
        public function BCDEncoder()
        {
            super();
            return;
        }

        public static function encode(arg1:Object, arg2:Array=null):Array
        {
            var loc3:*=0;
            var loc5:*=0;
            var loc4:*=0;
            if (!(arg1 is String)) 
            {
                return arg2;
            }
            var loc1:*=[];
            var loc2:*=arg1 as String;
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                loc5 = parseInt(loc2.charAt(loc3)) as uint;
                loc1.push(isNaN(loc5) ? 0 : loc5);
                ++loc3;
            }
            if (arg2 == null) 
            {
                return loc1;
            }
            loc1 = loc1.reverse();
            loc4 = 0;
            while (loc4 < arg2.length) 
            {
                arg2[loc4] = loc4 < loc1.length ? loc1[loc4] : 0;
                ++loc4;
            }
            return arg2.reverse();
        }
    }
}


//  class Gps10Decoder
package decoder 
{
    import com.hurlant.util.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.gps.*;
    import core.marker.*;
    import core.settings.*;
    import core.sleepScreen.*;
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import decoder.core.*;
    import flash.events.*;
    import handler.*;
    import utils.*;
    import utils.converter.*;
    
    public class Gps10Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.units.interfaces.ICodingTotals
    {
        public function Gps10Decoder(arg1:flash.events.IEventDispatcher=null)
        {
            speedConverter = new utils.converter.SpeedConverter("kmh", "ms");
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            speedConverter.inputFormat = "kmh";
            speedConverter.outputFormat = "ms";
            return;
        }

        public function encodeSleepScreen(arg1:core.units.Unit):Array
        {
            var loc6:*=0;
            var loc2:*=NaN;
            var loc1:*=(arg1 as core.units.interfaces.ISleepScreen).sleepScreen;
            var loc3:*=new Array(172);
            loc6 = 0;
            while (loc6 < loc3.length) 
            {
                loc3[loc6] = 0;
                ++loc6;
            }
            loc2 = loc1.id;
            if (loc2 == 0) 
            {
                loc3[171] = 1;
                return loc3;
            }
            loc2 = 1;
            loc3[0] = loc2 & 255;
            loc3[1] = loc2 >> 8 & 255;
            loc3[2] = loc2 >> 16 & 255;
            loc3[3] = loc2 >> 24 & 255;
            var loc7:*=core.sleepScreen.SleepScreenSign.getBytes(loc1.xml, 16, 59);
            loc6 = 0;
            while (loc6 < loc7.length) 
            {
                loc3[loc6 + 4] = loc7[loc6];
                ++loc6;
            }
            var loc4:*=loc1.xml.dots.@clockX;
            loc3[168] = loc4;
            var loc5:*=loc1.xml.dots.@clockY;
            loc3[169] = loc5;
            if (loc1.xml.dots.@myNamePos == "buttom") 
            {
                loc3[170] = 1;
            }
            loc3[171] = utils.ChecksumUtil.calculateCrcValue(loc3.slice(0, 170), 1);
            return loc3;
        }

        public function decodeInitialInformation(arg1:Array, arg2:Array):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=parseInt((arg2[0] as int).toString(16), 10);
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc1:*=arg1 as Array;
            if (!isValidChecksum(loc1, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 547, "GPS10Decoder > decodeSettings: wrong crc"));
                return null;
            }
            var loc4:*;
            (loc4 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsGps10).unit = arg2;
            loc4.date = new Date();
            loc1.pop();
            loc4.timeZone = loc1[0] & 63;
            loc4.summerTime = loc1[0] >> 6 & 1;
            loc4.clockMode = (loc1[0] >> 7 & 1) != 0 ? "12" : "24";
            loc4.language = decodeLanguage(loc1[1] & 7);
            loc4.autoPause = loc1[1] >> 3 & 1;
            loc4.speedUnit = (loc1[1] >> 4 & 1) != 0 ? "mph" : "kmh";
            loc4.altitudeReference = (loc1[1] >> 5 & 1) != 0 ? core.general.AltitudeReference.SEA_LEVEL : core.general.AltitudeReference.ACTUAL_ALTITUDE;
            loc4.contrast = (loc1[1] >> 6 & 3) + 1;
            loc4.dateFormat = (loc1[2] & 1) != 0 ? "us" : "eu";
            loc4.temperatureUnit = (loc1[2] >> 1 & 1) != 0 ? "fahrenheit" : "celsius";
            loc4.altitudeUnit = (loc1[2] >> 2 & 1) != 0 ? "feet" : "meter";
            loc4.nfcActive = (loc1[2] >> 3 & 1) != 1 ? false : true;
            loc4.systemTone = (loc1[2] >> 4 & 1) != 1 ? false : true;
            loc4.actualAltitude = ((loc1[4] << 8 | loc1[3]) - 10000) * 100;
            loc4.seaLevel = ((loc1[6] << 8 | loc1[5]) & 2047) / 10 + 900;
            loc4.homeAltitude1 = ((loc1[8] << 8 | loc1[7]) - 10000) * 100;
            loc4.homeAltitude2 = ((loc1[10] << 8 | loc1[9]) - 10000) * 100;
            var loc2:*=11;
            var loc3:*="";
            while (loc2 <= 19) 
            {
                if (loc1[loc2] == 0) 
                {
                    break;
                }
                loc3 = loc3 + com.hurlant.util.Hex.toString(loc1[loc2].toString(16));
                ++loc2;
            }
            loc4.myName = loc3;
            loc4.autoLapDistance = loc1[21] << 8 | loc1[20];
            return loc4;
        }

        public function decodeLanguage(arg1:int):String
        {
            var loc1:*="";
        }

        public function encodeLanguage(arg1:core.settings.SettingsGps10):uint
        {
            var loc1:*=0;
            var loc2:*=arg1.language;
            while ("en" === loc2) 
            {
                loc1 = 0;
            }
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc1:*=NaN;
            var loc2:*=fillArray(32);
            var loc6:*=arg1.currentSettings as core.settings.SettingsGps10;
            loc2[0] = loc6.timeZone & 63;
            var loc7:*=0;
            var loc8:*=loc2[loc7] | (loc6.summerTime ? 1 : 0) << 6;
            loc2[loc7] = loc8;
            loc8 = 0;
            loc7 = loc2[loc8] | (loc6.clockMode != "24" ? 1 : 0) << 7;
            loc2[loc8] = loc7;
            loc2[1] = encodeLanguage(loc6);
            loc7 = 1;
            loc8 = loc2[loc7] | (loc6.autoPause ? 1 : 0) << 3;
            loc2[loc7] = loc8;
            loc8 = 1;
            loc7 = loc2[loc8] | (loc6.speedUnit != "kmh" ? 1 : 0) << 4;
            loc2[loc8] = loc7;
            loc7 = 1;
            loc8 = loc2[loc7] | (loc6.altitudeReference != core.general.AltitudeReference.ACTUAL_ALTITUDE ? 1 : 0) << 5;
            loc2[loc7] = loc8;
            loc8 = 1;
            loc7 = loc2[loc8] | (loc6.contrast - 1) << 6;
            loc2[loc8] = loc7;
            loc2[2] = loc6.dateFormat != "eu" ? 1 : 0;
            loc7 = 2;
            loc8 = loc2[loc7] | (loc6.temperatureUnit != "celsius" ? 1 : 0) << 1;
            loc2[loc7] = loc8;
            loc8 = 2;
            loc7 = loc2[loc8] | (loc6.altitudeUnit != "meter" ? 1 : 0) << 2;
            loc2[loc8] = loc7;
            loc7 = 2;
            loc8 = loc2[loc7] | (loc6.nfcActive ? 1 : 0) << 3;
            loc2[loc7] = loc8;
            loc8 = 2;
            loc7 = loc2[loc8] | (loc6.systemTone ? 1 : 0) << 4;
            loc2[loc8] = loc7;
            loc7 = 2;
            loc8 = loc2[loc7] | 160;
            loc2[loc7] = loc8;
            loc1 = loc6.actualAltitude / 100 + 10000;
            loc2[4] = loc1 >> 8 & 255;
            loc2[3] = loc1 & 255;
            loc1 = (loc6.seaLevel - 900) * 10;
            loc2[6] = loc1 >> 8 & 255;
            loc2[5] = loc1 & 255;
            loc1 = loc6.homeAltitude1 / 100 + 10000;
            loc2[8] = loc1 >> 8 & 255;
            loc2[7] = loc1 & 255;
            loc1 = loc6.homeAltitude2 / 100 + 10000;
            loc2[10] = loc1 >> 8 & 255;
            loc2[9] = loc1 & 255;
            var loc3:*=0;
            var loc4:*=loc6.myName;
            var loc5:*=0;
            while (loc3 < 9) 
            {
                loc5 = loc4.charCodeAt(loc3);
                if (isNaN(loc5)) 
                {
                    loc2[loc3 + 11] = 0;
                }
                else 
                {
                    loc2[loc3 + 11] = loc5;
                }
                ++loc3;
            }
            loc1 = loc6.autoLapDistance;
            loc2[20] = 0;
            loc2[21] = 0;
            loc2[22] = 30;
            loc2[23] = 32;
            loc2[24] = 9;
            loc2[31] = utils.ChecksumUtil.calculateCrcValue(loc2.slice(0, 31), 1);
            return loc2;
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc4:*=0;
            var loc2:*=NaN;
            var loc3:*=fillArray(20);
            var loc1:*=arg1 as core.totals.TotalsGps10;
            loc2 = Math.round(loc1.totalDistance1);
            loc3[0] = loc2 & 255;
            loc3[1] = loc2 >> 8 & 255;
            loc3[2] = loc2 >> 16 & 255;
            loc3[3] = loc2 >> 24 & 255;
            loc2 = (loc1.totalDistance1 - loc2) * 1000;
            loc3[4] = loc2 & 255;
            loc3[5] = loc2 >> 8 & 255;
            loc2 = loc1.totalTrainingTime1 / 100;
            loc3[6] = loc2 & 255;
            loc3[7] = loc2 >> 8 & 255;
            loc3[8] = loc2 >> 16 & 255;
            loc3[9] = loc2 >> 24 & 255;
            loc3[10] = loc1.totalCal1 & 255;
            loc3[11] = loc1.totalCal1 >> 8 & 255;
            loc3[12] = loc1.totalCal1 >> 16 & 255;
            loc2 = loc1.totalClimbMeter1 / 100;
            loc3[13] = loc2 & 255;
            loc3[14] = loc2 >> 8 & 255;
            loc3[15] = loc2 >> 16 & 255;
            loc1.resetDate = new Date();
            loc3[16] = loc1.resetDate.getFullYear() - 2000;
            loc3[17] = loc1.resetDate.getMonth() + 1;
            loc3[18] = loc1.resetDate.getDate();
            loc3[19] = utils.ChecksumUtil.calculateCrcValue(loc3.slice(0, 19), 1);
            return loc3;
        }

        public function decodePageHeaderCount(arg1:Array):uint
        {
            var loc1:*=arg1 as Array;
            if (!isValidChecksum(loc1, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 550, "GPS10Decoder > decodeTotals: wrong crc"));
                return 0;
            }
            return loc1[1] << 8 | loc1[0];
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc2:*=arg1 as Array;
            if (!isValidChecksum(loc2, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 548, "GPS10Decoder > decodeTotals: wrong crc"));
                return null;
            }
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type) as core.totals.TotalsGps10;
            loc1.unit = arg2;
            loc2.pop();
            loc1.totalDistance1 = (loc2[3] & 15) << 24 | loc2[2] << 16 | loc2[1] << 8 | loc2[0];
            loc1.totalDistance1 = loc1.totalDistance1 + ((loc2[5] & 3) << 8 | loc2[4]) / 1000;
            loc1.totalTrainingTime1 = ((loc2[9] & 3) << 24 | loc2[8] << 16 | loc2[7] << 8 | loc2[6]) * 100;
            loc1.totalCal1 = (loc2[12] & 1) << 16 | loc2[11] << 8 | loc2[10];
            loc1.totalClimbMeter1 = ((loc2[15] & 15) << 16 | loc2[14] << 8 | loc2[13]) * 100;
            var loc4:*=(loc2[16] & 63) + 2000;
            var loc3:*=(loc2[17] - 1);
            var loc5:*=loc2[18] & 31;
            loc1.resetDate = new Date(loc4, loc3, loc5);
            return loc1;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):Boolean
        {
            var loc15:*=0;
            var loc2:*=null;
            var loc8:*=null;
            var loc14:*=0;
            var loc1:*=0;
            var loc6:*=0;
            var loc11:*=0;
            var loc3:*=null;
            var loc9:*=NaN;
            var loc5:*=0;
            var loc13:*=0;
            var loc4:*=0;
            var loc12:*=0;
            var loc10:*=0;
            var loc7:*=0;
            try 
            {
                loc15 = 0;
                _currentLogEntry = null;
                loc14 = 0;
                loc1 = 0;
                while (arg2.length > 0) 
                {
                };
                arg1.averageInclineUphill = loc5 / loc13;
                arg1.averageInclineDownhill = loc4 / loc12;
                arg1.averageTemperature = loc10 / loc7;
                loc6 = 0;
                loc11 = arg1.entries.length;
                loc9 = arg1.calories / loc11;
                if (loc11 > 0) 
                {
                    arg1.minimumAltitude = arg1.entries[0].altitude;
                }
                loc6 = 0;
                while (loc6 < loc11) 
                {
                    (loc3 = arg1.entries[loc6]).calories = loc9;
                    arg1.minimumAltitude = Math.min(arg1.minimumAltitude, loc3.altitude);
                    if (loc6 == 0) 
                    {
                        arg1.minimumIncline = loc3.incline;
                        arg1.maximumIncline = loc3.incline;
                        arg1.minimumTemperature = loc3.temperature;
                        arg1.maximumTemperature = loc3.temperature;
                    }
                    arg1.minimumIncline = Math.min(arg1.minimumIncline, loc3.incline);
                    arg1.maximumIncline = Math.max(arg1.maximumIncline, loc3.incline);
                    arg1.minimumTemperature = Math.min(arg1.minimumTemperature, loc3.temperature);
                    arg1.maximumTemperature = Math.max(arg1.maximumTemperature, loc3.temperature);
                    ++loc6;
                }
                handler.ActivityCalculator.createAutoLapsByDistance(arg1, 5000, true);
            }
            catch (e:decoder.core.DecodeError)
            {
                debug.Debug.error(e.toString());
                var loc17:*=false;
                return loc17;
            }
            return true;
        }

        internal function decodeLogEntryLog(arg1:core.activities.Activity, arg2:Array):core.activities.ActivityEntry
        {
            var loc7:*=0;
            var loc4:*=NaN;
            var loc9:*=0;
            if (!isValidChecksum(arg2, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10156, "GPS10Decoder > decodeLog: wrong crc"));
                throw new decoder.core.DecodeError("GPS10Decoder > decodeLog: wrong crc", 10156);
            }
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg1);
            loc1.number = arg1.entries.length;
            var loc6:*=arg2[0] >> 1 & 1;
            var loc2:*=arg2[0] >> 2 & 1;
            var loc8:*=arg2[0] >> 3 & 1;
            var loc5:*=arg2[0] >> 4 & 1;
            var loc3:*=(arg2[0] >> 5 & 1) != 1 ? 1 : -1;
            loc1.altitudeDifferencesUphill = ((arg2[2] & 1) << 8 | arg2[1]) * 1000;
            loc1.incline = (arg2[2] >> 1) * loc3;
            loc1.distance = (arg2[4] & 15) << 8 | arg2[3];
            loc1.temperature = arg2[5] - 10;
            loc1.speed = speedConverter.convert((arg2[7] << 8 | arg2[6]) / 100);
            loc1.speedTime = utils.Calculations.calculateSpeedTime(loc1.speed);
            loc1.altitude = ((arg2[9] << 8 | arg2[8]) - 1000) * 1000;
            loc7 = arg2[10];
            loc4 = ((arg2[13] & 15) << 16 | arg2[12] << 8 | arg2[11]) / 10000;
            loc9 = (arg2[13] >> 4 & 1) != 1 ? 2 : 0;
            loc1.latitude = new core.gps.DdMmmmmm(loc7, loc4, loc9).toLatLon();
            loc7 = arg2[14];
            loc4 = ((arg2[17] & 15) << 16 | arg2[16] << 8 | arg2[15]) / 10000;
            loc9 = (arg2[13] >> 5 & 1) != 1 ? 3 : 1;
            loc1.longitude = new core.gps.DdMmmmmm(loc7, loc4, loc9).toLatLon();
            loc1.trainingTime = arg1.samplingRate * 100;
            if (_lastEntryWasPause) 
            {
                loc1.distance = loc1.distance - (_currentLogEntry ? _currentLogEntry.distance : 0);
                loc1.trainingTime = loc1.trainingTime - (_currentLogEntry ? _currentLogEntry.trainingTime : 0);
            }
            if (_currentLogEntry) 
            {
                loc1.distanceAbsolute = (_currentLogEntry ? _currentLogEntry.distanceAbsolute : 0) + loc1.distance;
                loc1.trainingTimeAbsolute = (_currentLogEntry ? _currentLogEntry.trainingTimeAbsolute : 0) + loc1.trainingTime;
            }
            else 
            {
                loc1.distanceAbsolute = loc1.distance;
                loc1.trainingTimeAbsolute = loc1.trainingTime;
            }
            return loc1;
        }

        internal function decodeLogEntryPause(arg1:core.activities.Activity, arg2:Array):Array
        {
            var loc3:*=0;
            var loc10:*=NaN;
            var loc4:*=0;
            var loc2:*=0;
            var loc12:*=0;
            var loc19:*=0;
            var loc13:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc16:*=null;
            var loc18:*=null;
            if (!isValidChecksum(arg2, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10156, "GPS10Decoder > decodeLog: wrong crc"));
                throw new decoder.core.DecodeError("GPS10Decoder > decodePause: wrong crc", 10156);
            }
            var loc15:*;
            (loc15 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "p")).type = "p";
            var loc14:*=arg2[0] >> 1 & 1;
            var loc8:*=arg2[0] >> 2 & 1;
            var loc17:*=arg2[0] >> 3 & 1;
            var loc11:*=arg2[0] >> 4 & 1;
            var loc1:*=(arg2[0] >> 5 & 1) != 1 ? 1 : -1;
            loc15.altitudeUphill = ((arg2[2] & 1) << 8 | arg2[1]) * 1000;
            loc15.averageInclineUphill = (arg2[2] >> 1) * loc1;
            loc15.distance = (arg2[4] & 15) << 8 | arg2[3];
            loc15.averageSpeed = speedConverter.convert((arg2[7] << 8 | arg2[6]) / 100);
            loc15.averageAltitude = ((arg2[9] << 8 | arg2[8]) - 1000) * 1000;
            loc3 = arg2[10];
            loc10 = ((arg2[13] & 15) << 16 | arg2[12] << 8 | arg2[11]) / 10000;
            loc4 = (arg2[13] >> 4 & 1) != 1 ? 2 : 0;
            loc15.latitude = new core.gps.DdMmmmmm(loc3, loc10, loc4).toLatLon();
            loc3 = arg2[14];
            loc10 = ((arg2[17] & 15) << 16 | arg2[16] << 8 | arg2[15]) / 10000;
            loc4 = (arg2[13] >> 5 & 1) != 1 ? 3 : 1;
            loc15.longitude = new core.gps.DdMmmmmm(loc3, loc10, loc4).toLatLon();
            var loc5:*=arg2[18];
            loc2 = arg2[19];
            loc12 = (arg2[20] - 1);
            loc19 = arg2[21];
            loc13 = arg2[22];
            loc6 = arg2[23];
            loc7 = arg2[24];
            loc16 = new Date(loc2, loc12, loc19, loc13, loc6, loc7);
            loc2 = arg2[25];
            loc12 = (arg2[26] - 1);
            loc19 = arg2[27];
            loc13 = arg2[28];
            loc6 = arg2[29];
            loc7 = arg2[30];
            loc18 = new Date(loc2, loc12, loc19, loc13, loc6, loc7);
            loc15.duration = (loc18.time - loc16.time) / 10;
            var loc9:*;
            (loc9 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            loc9.altitudeDifferencesUphill = loc15.altitudeUphill;
            loc9.incline = loc15.averageInclineUphill;
            loc9.distance = loc15.distance;
            loc9.temperature = arg2[5] - 10;
            loc9.speed = loc15.averageSpeed;
            loc9.speedTime = utils.Calculations.calculateSpeedTime(loc9.speed);
            loc9.altitude = loc15.averageAltitude;
            loc9.latitude = loc15.latitude;
            loc9.longitude = loc15.longitude;
            loc9.trainingTime = loc5 * 100;
            if (_currentLogEntry == null) 
            {
                loc15.timeAbsolute = loc9.trainingTime;
                loc9.trainingTimeAbsolute = loc9.trainingTime;
                loc15.distanceAbsolute = loc9.distance;
                loc9.distanceAbsolute = loc9.distance;
            }
            else 
            {
                loc15.timeAbsolute = loc9.trainingTime + _currentLogEntry.trainingTimeAbsolute;
                loc9.trainingTimeAbsolute = loc9.trainingTime + _currentLogEntry.trainingTimeAbsolute;
                loc15.distanceAbsolute = loc9.distance + _currentLogEntry.distanceAbsolute;
                loc9.distanceAbsolute = loc9.distance + _currentLogEntry.distanceAbsolute;
            }
            return new Array(loc15, loc9);
        }

        public function encodePointNavigation(arg1:core.gps.PointNavigation):Array
        {
            var loc1:*=fillArray(27);
            var loc2:*=0;
            var loc3:*=0;
            while (loc2 < 9) 
            {
                loc3 = arg1.text1.charCodeAt(loc2);
                if (isNaN(loc3)) 
                {
                    loc1[loc2] = 0;
                }
                else 
                {
                    loc1[loc2] = loc3;
                }
                ++loc2;
            }
            loc2 = 0;
            while (loc2 < 9) 
            {
                loc3 = arg1.text2.charCodeAt(loc2);
                if (isNaN(loc3)) 
                {
                    loc1[loc2 + 9] = 0;
                }
                else 
                {
                    loc1[loc2 + 9] = loc3;
                }
                ++loc2;
            }
            var loc4:*=arg1.getLonDdMmmmmm();
            loc1[18] = loc4.degree;
            loc1[19] = loc4.minutes & 255;
            loc1[20] = loc4.minutes >> 8 & 255;
            loc1[21] = loc4.minutes >> 16 & 15;
            var loc5:*=21;
            var loc6:*=loc1[loc5] | (loc4.direction != 3 ? 16 : 0);
            loc1[loc5] = loc6;
            loc4 = arg1.getLatDdMmmmmm();
            loc1[22] = loc4.direction != 2 ? 1 : 0;
            loc6 = 22;
            loc5 = loc1[loc6] | (loc4.degree & 127) << 1;
            loc1[loc6] = loc5;
            loc1[23] = loc4.minutes & 255;
            loc1[24] = loc4.minutes >> 8 & 255;
            loc1[25] = loc4.minutes >> 16 & 15;
            loc1[26] = utils.ChecksumUtil.calculateCrcValue(loc1.slice(0, 26), 1);
            return loc1;
        }

        public function decodeLogHeader(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc9:*=0;
            var loc5:*=0;
            var loc14:*=NaN;
            var loc10:*=0;
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            var loc1:*=arg1 as Array;
            if (!isValidChecksum(loc1, 1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10155, "GPS10Decoder > decodeLogHeader: wrong crc"));
                return loc2;
            }
            var loc6:*=[];
            loc6 = loc1.slice(1, 16);
            var loc7:*="";
            loc9 = 0;
            while (loc9 < loc6.length) 
            {
                if (loc6[loc9] < 15) 
                {
                    loc7 = loc7 + "0";
                }
                loc7 = loc7 + loc6[loc9].toString(16);
                if (loc9 == 3 || loc9 == 5 || loc9 == 7 || loc9 == 9) 
                {
                    loc7 = loc7 + "-";
                }
                ++loc9;
            }
            loc2.GUID = loc7;
            var loc3:*=arg1[8] << 8 | arg1[7];
            var loc15:*=(arg1[9] - 1);
            var loc19:*=arg1[10];
            var loc16:*=arg1[11];
            var loc12:*=arg1[12];
            var loc13:*=arg1[13];
            loc2.startDate = new Date(loc3, loc15, loc19, loc16, loc12, loc13);
            loc2.trainingTime = ((loc1[18] & 7) << 16 | loc1[17] << 8 | loc1[16]) * 100;
            var loc11:*=(loc1[19] & 1) != 0 ? "fahrenheit" : "celsius";
            var loc4:*=(loc1[19] >> 1 & 1) != 0 ? "feet" : "meter";
            loc2.speedUnit = (loc1[19] >> 2 & 1) != 0 ? "mph" : "kmh";
            var loc17:*=(loc1[19] >> 3 & 1) != 0 ? "12" : "24";
            var loc8:*=(loc1[21] << 8 | loc1[20]) / 100;
            loc2.maximumSpeed = speedConverter.convert(loc8);
            loc2.maxSpeedEntry = loc1[23] << 8 | loc1[22];
            loc2.maximumAltitude = ((loc1[27] << 8 | loc1[26]) - 1000) * 1000;
            loc2.maxAltitudeEntry = loc1[29] << 8 | loc1[28];
            loc2.minimumAltitude = 0;
            loc2.distance = loc1[32] << 16 | loc1[31] << 8 | loc1[30];
            var loc18:*=(loc1[25] << 8 | loc1[24]) / 100;
            loc2.averageSpeed = speedConverter.convert(loc18);
            loc2.startAdress = (loc1[36] & 3) << 24 | loc1[35] << 16 | loc1[34] << 8 | loc1[33];
            loc2.stopAdress = (loc1[40] & 3) << 24 | loc1[39] << 16 | loc1[38] << 8 | loc1[37];
            loc2.calories = (loc1[43] & 1) << 16 | loc1[42] << 8 | loc1[41];
            loc2.altitudeDifferencesUphill = ((loc1[46] & 15) << 16 | loc1[45] << 8 | loc1[44]) * 100;
            loc5 = loc1[47];
            loc14 = ((loc1[50] & 15) << 16 | loc1[49] << 8 | loc1[48]) / 10000;
            loc10 = (loc1[50] >> 4 & 1) != 1 ? 3 : 1;
            loc2.longitudeStart = new core.gps.DdMmmmmm(loc5, loc14, loc10).toLatLon();
            loc5 = loc1[51];
            loc14 = ((loc1[54] & 15) << 16 | loc1[53] << 8 | loc1[52]) / 10000;
            loc10 = (loc1[54] >> 4 & 1) != 1 ? 2 : 0;
            loc2.latitudeStart = new core.gps.DdMmmmmm(loc5, loc14, loc10).toLatLon();
            loc5 = loc1[55];
            loc14 = ((loc1[58] & 15) << 16 | loc1[57] << 8 | loc1[56]) / 10000;
            loc10 = (loc1[58] >> 4 & 1) != 1 ? 3 : 1;
            loc2.longitudeEnd = new core.gps.DdMmmmmm(loc5, loc14, loc10).toLatLon();
            loc5 = loc1[59];
            loc14 = ((loc1[62] & 15) << 16 | loc1[61] << 8 | loc1[60]) / 10000;
            loc10 = (loc1[62] >> 4 & 1) != 1 ? 2 : 0;
            loc2.latitudeEnd = new core.gps.DdMmmmmm(loc5, loc14, loc10).toLatLon();
            return loc2;
        }

        public static function isValidChecksum(arg1:Array, arg2:uint=1):Boolean
        {
            var loc2:*=arg1[(arg1.length - 1)];
            var loc1:*=utils.ChecksumUtil.calculateCrcValue(arg1.slice(0, (arg1.length - 1)), arg2);
            return loc2 == loc1;
        }

        public static function getInstance():decoder.Gps10Decoder
        {
            if (_instance == null) 
            {
                _instance = new Gps10Decoder();
            }
            return _instance as Gps10Decoder;
        }

        public static function fillArray(arg1:uint):Array
        {
            var loc1:*=new Array(arg1);
            var loc2:*=0;
            while (loc2 < arg1) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            return loc1;
        }

        public static const LOG_BYTE_INDICATOR_LOG:uint=0;

        public static const LOG_BYTE_INDICATOR_PAUSE:uint=1;

        public static const LOG_ENTRY_SIZE_LOG:uint=25;

        public static const LOG_ENTRY_SIZE_PAUSE:uint=32;

        public static const LOG_HEADER_LENGTH:uint=32;

        internal var _currentLogEntry:core.activities.ActivityEntry;

        internal var _currentMarker:core.marker.Marker;

        internal var _lastEntryWasPause:Boolean=false;

        internal var speedConverter:utils.converter.SpeedConverter;

        internal static var _instance:decoder.Gps10Decoder;
    }
}


//  class PC2814Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.training.*;
    import core.training.type.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import utils.*;
    
    public class PC2814Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog
    {
        public function PC2814Decoder()
        {
            super();
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeIntervalSettings(arg1:Array, arg2:core.settings.SettingsPC2814=null):core.settings.SettingsPC2814
        {
            if (arg2 == null) 
            {
                arg2 = new core.settings.SettingsPC2814();
            }
            arg2.intervalWarmUpTime = ((arg1[1] & 15) << 8 | arg1[0]) * 100;
            arg2.intervalTime = (arg1[2] << 4 | arg1[1] >> 4) * 100;
            arg2.intervalWarmUpTargetZoneLowerLimit = arg1[3];
            arg2.intervalWarmUpTargetZoneUpperLimit = arg1[4];
            arg2.intervalTargetZoneLowerLimit = arg1[5];
            arg2.intervalTargetZoneUpperLimit = arg1[6];
            arg2.intervalRecoveryTime = ((arg1[8] & 15) << 8 | arg1[7]) * 100;
            arg2.intervalCoolDownTime = (arg1[9] << 4 | arg1[8] >> 4) * 100;
            arg2.intervalRecoveryHR = arg1[10];
            arg2.intervalCoolDownTargetZoneLowerLimit = arg1[11];
            arg2.intervalCoolDownTargetZoneUpperLimit = arg1[12];
            var loc2:*;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc25:*=0;
            var loc24:*=core.settings.SettingsFactory.createSettingsFromUnitType(core.general.UnitType.PC2814) as core.settings.SettingsPC2814;
            var loc33:*=13;
            var loc19:*=36;
            var loc22:*=58;
            loc24.myName = "";
            var loc13:*=10;
            loc25 = 1;
            while (loc25 <= 10) 
            {
                if (arg1[loc25] != 255) 
                {
                    loc24.myName = loc24.myName + String.fromCharCode(arg1[loc25]);
                }
                ++loc25;
            }
            loc24 = decodeIntervalSettings((arg1 as Array).slice(13, 28), loc24);
            var loc29:*;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc10:*=arg1.currentSettings as core.settings.SettingsPC2814;
            var loc1:*=new Array(95);
            var loc13:*=13;
            var loc12:*=36;
            var loc2:*=58;
            loc1[0] = 1;
            var loc4:*=0;
            var loc8:*=loc10.myName.split("");
            loc4 = 0;
            while (loc4 < 10) 
            {
                if (loc8[loc4] == null) 
                {
                    loc8[loc4] = " ";
                }
                loc1[loc4 + 1] = (loc8[loc4] as String).charCodeAt(0);
                ++loc4;
            }
            var loc9:*=0;
            loc4 = 0;
            while (loc4 <= 10) 
            {
                loc9 = loc9 + loc1[loc4];
                ++loc4;
            }
            loc9 = loc9 & 255;
            loc1[11] = loc9;
            loc1[12] = 0;
            var loc7:*=loc10.intervalWarmUpTime / 100;
            loc1[loc13 + 0] = loc7 & 255;
            loc1[loc13 + 1] = loc7 >> 8;
            var loc14:*=loc10.intervalTime / 100;
            var loc15:*=loc13 + 1;
            var loc16:*=loc1[loc15] | (loc14 & 15) << 4;
            loc1[loc15] = loc16;
            loc1[loc13 + 2] = loc14 >> 4;
            loc1[loc13 + 3] = loc10.intervalWarmUpTargetZoneLowerLimit;
            loc1[loc13 + 4] = loc10.intervalWarmUpTargetZoneUpperLimit;
            loc1[loc13 + 5] = loc10.intervalTargetZoneLowerLimit;
            loc1[loc13 + 6] = loc10.intervalTargetZoneUpperLimit;
            var loc5:*=loc10.intervalRecoveryTime / 100;
            loc1[loc13 + 7] = loc5 & 255;
            loc1[loc13 + 8] = loc5 >> 8;
            var loc11:*=loc10.intervalCoolDownTime / 100;
            loc16 = loc13 + 8;
            loc15 = loc1[loc16] | (loc11 & 15) << 4;
            loc1[loc16] = loc15;
            loc1[loc13 + 9] = loc11 >> 4;
            loc1[loc13 + 10] = loc10.intervalRecoveryHR;
            loc1[loc13 + 11] = loc10.intervalCoolDownTargetZoneLowerLimit;
            loc1[loc13 + 12] = loc10.intervalCoolDownTargetZoneUpperLimit;
            if (loc10.intervalRecoveryMode != core.training.type.PhaseControl.PULSE) 
            {
                loc1[loc13 + 13] = 0;
            }
            else 
            {
                loc1[loc13 + 13] = 1;
            }
            loc9 = 0;
            loc4 = 0;
            while (loc4 <= 13) 
            {
                loc9 = loc9 + loc1[loc13 + loc4];
                ++loc4;
            }
            loc9 = loc9 & 255;
            loc1[loc13 + 14] = loc9;
            loc1[loc13 + 15] = 17;
            loc1[loc13 + 16] = 32;
            loc1[loc13 + 17] = 17;
            loc1[loc13 + 18] = 20;
            loc1[loc13 + 19] = 0;
            loc1[loc13 + 20] = 0;
            loc1[loc13 + 21] = 0;
            loc1[loc13 + 22] = 0;
            loc15 = loc10.freeTrainingTargetZone;
            while ("fitZone" === loc15) 
            {
                loc1[loc12 + 0] = 0;
            }
        }

        public function decodeTrainingProgram(arg1:Array, arg2:core.units.Unit, arg3:Boolean=false):core.training.Training
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1.slice(0, 12);
            var loc7:*;
            if (!(loc7 = decodeTrainingProgramHeader(loc3, arg2))) 
            {
                return null;
            }
            var loc6:*=0;
            var loc5:*=13;
            if (arg3) 
            {
                loc5 = 12;
            }
            var loc4:*=0;
            while (loc7.phaseCount > loc6) 
            {
            };
            if (loc7.programDataLength == 0) 
            {
                loc7.programDataLength = loc5;
            }
            return loc7;
        }

        public function encodeTrainingProgram(arg1:core.training.Training):Array
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc3:*=[];
            if (arg1.phasesList.length != arg1.phaseCount) 
            {
                arg1.phaseCount = arg1.phasesList.length;
            }
            var loc1:*=encodeTrainingProgramHeader(arg1);
            (loc3 = loc3.concat(loc1)).push(255);
            loc4 = 0;
            while (loc4 < arg1.phaseCount) 
            {
                if (arg1.phasesList[loc4].type != core.training.type.PhaseCategory.SIMPLE) 
                {
                    if (arg1.phasesList[loc4].type == core.training.type.PhaseCategory.INTERVAL) 
                    {
                        loc2 = encodeTrainingProgramIntervalPhase(arg1.phasesList[loc4] as core.training.TrainingPhase);
                    }
                }
                else 
                {
                    loc2 = encodeTrainingProgramSimplePhase(arg1.phasesList[loc4] as core.training.TrainingPhase);
                }
                loc3 = loc3.concat(loc2);
                ++loc4;
            }
            return loc3;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc1:*=0;
            var loc11:*=0;
            var loc19:*=NaN;
            var loc20:*=0;
            var loc12:*=null;
            var loc13:*=null;
            var loc2:*=null;
            var loc21:*=null;
            var loc9:*=null;
            var loc7:*=0;
            var loc3:*=0;
            var loc6:*=(arg2.length - 1);
            var loc15:*=1;
            var loc18:*=1;
            var loc5:*=1;
            var loc16:*=1;
            var loc17:*=1;
            var loc4:*=1;
            var loc10:*=false;
            while (loc7 < loc6) 
            {
                loc1 = arg2[loc7] & 15;
            }
            handler.ActivityCalculator.calculateMinMaxAvgValues(arg1);
            var loc8:*;
            if ((loc8 = arg1.entries[(arg1.entries.length - 1)]).trainingTimeAbsolute != arg1.trainingTime) 
            {
                loc19 = loc8.trainingTimeAbsolute - arg1.trainingTime;
                loc8.trainingTimeAbsolute = loc8.trainingTimeAbsolute - loc19;
                loc8.trainingTime = loc8.trainingTime - loc19;
            }
            var loc14:*;
            loc20 = loc14 = arg1.markerList.length;
            while (loc20 > 0) 
            {
                if (arg1.markerList[(loc20 - 1)].type == "p") 
                {
                    removeMarkerFromMarkerVector(arg1.markerList[(loc20 - 1)], arg1.markerList);
                    break;
                }
                --loc20;
            }
            return;
        }

        public function decodeListOfAdressOfPageHeader(arg1:Array):uint
        {
            var loc2:*=0;
            var loc1:*=arg1[1] << 8 | arg1[0];
            var loc3:*=arg1[3] == 17 && arg1[4] == 32 && arg1[5] == 17 && arg1[6] == 20;
            var loc4:*=0;
            loc2 = 0;
            while (loc2 < 2) 
            {
                loc4 = loc4 + arg1[loc2];
                ++loc2;
            }
            if (!((loc4 = loc4 & 255) == arg1[2]) || !loc3) 
            {
                return null;
            }
            return loc1;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            return;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc4:*=0;
            var loc15:*;
            (loc15 = core.activities.ActivityFactory.createActivityFromUnitType(core.general.UnitType.PC2814, "log")).unit = arg2;
            var loc1:*=arg1[0] & 3;
        }

        public function decodeLogStatus(arg1:Array, arg2:core.units.Unit):core.units.Unit
        {
            (arg2 as core.units.interfaces.ILogTime5Sec).logTime5Sec = (arg1[2] << 8 | arg1[1]) * 60;
            (arg2 as core.units.interfaces.ILogTime10Sec).logTime10Sec = (arg1[4] << 8 | arg1[3]) * 60;
            (arg2 as core.units.interfaces.ILogTime20Sec).logTime20Sec = (arg1[6] << 8 | arg1[5]) * 60;
            (arg2 as core.units.interfaces.ILogTime30Sec).logTime30Sec = (arg1[8] << 8 | arg1[7]) * 60;
            (arg2 as core.units.interfaces.ILogStatus).maxPackages = 156840;
            (arg2 as core.units.interfaces.ILogStatus).freePackages = (arg2 as core.units.interfaces.ILogTime5Sec).logTime5Sec;
            var loc1:*=arg1[18] == 17 && arg1[19] == 32 && arg1[20] == 17 && arg1[21] == 20;
            if (!loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10134, "BLEHandler > decodeUnitInformation: incorrect checksum1"));
                return null;
            }
            return arg2;
        }

        internal function decodeSimplePhase(arg1:Array):core.training.TrainingPhase
        {
            var loc7:*=0;
            var loc1:*=new core.training.TrainingPhase();
            loc1.type = core.training.type.PhaseCategory.SIMPLE;
            var loc3:*;
            if ((loc3 = arg1[0] >> 1 & 1) != 1) 
            {
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.AUTOMATIC;
            }
            else 
            {
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.MANUAL;
            }
            var loc8:*;
            if ((loc8 = arg1[0] >> 2 & 1) != 0) 
            {
                loc1.loadPhaseControl = core.training.type.PhaseControl.TIME;
            }
            else 
            {
                loc1.loadPhaseControl = core.training.type.PhaseControl.PULSE;
            }
            var loc4:*;
            if ((loc4 = arg1[0] >> 3 & 1) != 0) 
            {
                loc1.loadTargetType = core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY;
            }
            else 
            {
                loc1.loadTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
            }
            var loc5:*=arg1[1] << 4 | arg1[0] >> 4;
            loc1.loadDuration = loc5 * 100;
            if (loc1.loadPhaseControl != core.training.type.PhaseControl.TIME) 
            {
                loc1.loadTargetMax = arg1[4];
            }
            else 
            {
                loc1.loadTargetMin = arg1[2];
                loc1.loadTargetMax = arg1[3];
            }
            var loc6:*;
            if ((loc6 = arg1[5] & 1) != 0) 
            {
                loc1.loadRecovery = core.training.type.PhaseLoadRecovery.RECOVERY;
            }
            else 
            {
                loc1.loadRecovery = core.training.type.PhaseLoadRecovery.LOAD;
            }
            loc1.titel = String.fromCharCode(arg1[6], arg1[7], arg1[8], arg1[9], arg1[10], arg1[11], arg1[12], arg1[13], arg1[14], arg1[15]);
            var loc9:*=arg1[16];
            var loc2:*=0;
            loc7 = 0;
            while (loc7 <= 15) 
            {
                loc2 = loc2 + arg1[loc7];
                ++loc7;
            }
            loc2 = loc2 & 255;
            if (loc2 != loc9) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc1;
        }

        internal function decodeIntervalPhase(arg1:Array):core.training.TrainingPhase
        {
            var loc7:*=0;
            var loc1:*=new core.training.TrainingPhase();
            loc1.type = core.training.type.PhaseCategory.INTERVAL;
            var loc3:*;
            if ((loc3 = arg1[0] >> 1 & 1) != 1) 
            {
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.AUTOMATIC;
            }
            else 
            {
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.MANUAL;
            }
            var loc9:*;
            if ((loc9 = arg1[0] >> 2 & 1) != 0) 
            {
                loc1.loadPhaseControl = core.training.type.PhaseControl.TIME;
            }
            else 
            {
                loc1.loadPhaseControl = core.training.type.PhaseControl.PULSE;
            }
            var loc10:*;
            if ((loc10 = arg1[0] >> 3 & 1) != 0) 
            {
                loc1.recoveryPhaseControl = core.training.type.PhaseControl.TIME;
            }
            else 
            {
                loc1.recoveryPhaseControl = core.training.type.PhaseControl.PULSE;
            }
            var loc6:*=arg1[1] << 4 | arg1[0] >> 4;
            loc1.loadDuration = loc6 * 100;
            var loc4:*=(arg1[3] & 240) << 8 | arg1[2];
            loc1.recoveryDuration = loc4 * 100;
            var loc5:*=arg1[3] >> 4 & 1;
            var loc8:*=arg1[3] >> 5 & 1;
            if (loc1.loadPhaseControl != core.training.type.PhaseControl.TIME) 
            {
                loc1.loadTargetMax = arg1[8];
            }
            else 
            {
                loc1.loadTargetMin = arg1[4];
                loc1.loadTargetMax = arg1[6];
            }
            if (loc1.recoveryPhaseControl != core.training.type.PhaseControl.TIME) 
            {
                loc1.recoveryTargetMax = arg1[9];
            }
            else 
            {
                loc1.recoveryTargetMin = arg1[5];
                loc1.recoveryTargetMax = arg1[7];
            }
            loc1.iterations = arg1[10];
            loc1.titel = String.fromCharCode(arg1[11], arg1[12], arg1[13], arg1[14], arg1[15], arg1[16], arg1[17], arg1[18], arg1[19], arg1[20]);
            var loc11:*=arg1[21];
            var loc2:*=0;
            loc7 = 0;
            while (loc7 <= 20) 
            {
                loc2 = loc2 + arg1[loc7];
                ++loc7;
            }
            loc2 = loc2 & 255;
            if (loc2 != loc11) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc1;
        }

        internal function decodeTrainingProgramHeader(arg1:Array, arg2:core.units.Unit):core.training.Training
        {
            var loc2:*=0;
            var loc3:*;
            (loc3 = new core.training.Training(arg2, false)).programDataLength = arg1[0];
            loc3.name = String.fromCharCode(arg1[1], arg1[2], arg1[3], arg1[4], arg1[5], arg1[6], arg1[7], arg1[8], arg1[9]);
            if (loc3.name == "         ") 
            {
                loc3.name = "";
            }
            loc3.phaseCount = arg1[10];
            var loc4:*=arg1[11];
            var loc1:*=0;
            loc2 = 0;
            while (loc2 <= 10) 
            {
                loc1 = loc1 + arg1[loc2];
                ++loc2;
            }
            loc1 = loc1 & 255;
            if (loc1 != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc3;
        }

        internal function encodeTrainingProgramHeader(arg1:core.training.Training):Array
        {
            var loc6:*=null;
            var loc4:*=new Array(12);
            var loc5:*=0;
            var loc1:*=12;
            loc5 = 0;
            while (loc5 < arg1.phaseCount) 
            {
                if (arg1.phasesList[loc5].type != core.training.type.PhaseCategory.SIMPLE) 
                {
                    if (arg1.phasesList[loc5].type == core.training.type.PhaseCategory.INTERVAL) 
                    {
                        loc1 = loc1 + 22;
                    }
                }
                else 
                {
                    loc1 = loc1 + 17;
                }
                ++loc5;
            }
            loc4[0] = loc1;
            var loc3:*;
            if ((loc3 = arg1.name) == "") 
            {
                loc3 = "         ";
            }
            loc6 = loc3.split("");
            loc5 = 0;
            while (loc5 < 9) 
            {
                if (loc6[loc5] == null) 
                {
                    loc6[loc5] = " ";
                }
                loc4[loc5 + 1] = (loc6[loc5] as String).charCodeAt(0);
                ++loc5;
            }
            loc4[10] = arg1.phaseCount;
            var loc2:*=0;
            loc5 = 0;
            while (loc5 <= 10) 
            {
                loc2 = loc2 + loc4[loc5];
                ++loc5;
            }
            loc2 = loc2 & 255;
            loc4[11] = loc2;
            return loc4;
        }

        internal function encodeTrainingProgramSimplePhase(arg1:core.training.TrainingPhase):Array
        {
            var loc2:*=new Array(17);
            loc2[0] = 0;
            if (arg1.phaseChangeMode == core.training.type.PhaseChangeMode.MANUAL) 
            {
                var loc6:*=0;
                var loc7:*=loc2[loc6] | 2;
                loc2[loc6] = loc7;
            }
            if (arg1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
            {
                loc7 = 0;
                loc6 = loc2[loc7] | 4;
                loc2[loc7] = loc6;
            }
            if (arg1.loadTargetType == core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY) 
            {
                loc6 = 0;
                loc7 = loc2[loc6] | 8;
                loc2[loc6] = loc7;
            }
            var loc3:*=arg1.loadDuration / 100;
            loc7 = 0;
            loc6 = loc2[loc7] | (loc3 & 15) << 4;
            loc2[loc7] = loc6;
            loc2[1] = loc3 >> 4;
            loc2[2] = arg1.loadTargetMin;
            loc2[3] = arg1.loadTargetMax;
            loc2[4] = arg1.loadTargetMax;
            if (arg1.loadRecovery != core.training.type.PhaseLoadRecovery.RECOVERY) 
            {
                loc2[5] = 0;
            }
            else 
            {
                loc2[5] = 1;
            }
            var loc4:*=0;
            var loc5:*=arg1.titel.split("");
            loc4 = 0;
            while (loc4 < 10) 
            {
                if (loc5[loc4] == null || loc5[loc4] == "") 
                {
                    loc5[loc4] = " ";
                }
                loc2[loc4 + 6] = (loc5[loc4] as String).charCodeAt(0);
                ++loc4;
            }
            var loc1:*=0;
            loc4 = 0;
            while (loc4 <= 15) 
            {
                loc1 = loc1 + loc2[loc4];
                ++loc4;
            }
            loc1 = loc1 & 255;
            loc2[16] = loc1;
            return loc2;
        }

        internal function encodeTrainingProgramIntervalPhase(arg1:core.training.TrainingPhase):Array
        {
            var loc3:*;
            (loc3 = new Array(22))[0] = 1;
            if (arg1.phaseChangeMode == core.training.type.PhaseChangeMode.MANUAL) 
            {
                var loc7:*=0;
                var loc8:*=loc3[loc7] | 2;
                loc3[loc7] = loc8;
            }
            if (arg1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
            {
                loc8 = 0;
                loc7 = loc3[loc8] | 4;
                loc3[loc8] = loc7;
            }
            if (arg1.recoveryPhaseControl == core.training.type.PhaseControl.TIME) 
            {
                loc7 = 0;
                loc8 = loc3[loc7] | 8;
                loc3[loc7] = loc8;
            }
            var loc4:*=arg1.loadDuration / 100;
            loc8 = 0;
            loc7 = loc3[loc8] | (loc4 & 15) << 4;
            loc3[loc8] = loc7;
            loc3[1] = loc4 >> 4;
            var loc2:*=arg1.recoveryDuration / 100;
            loc3[2] = loc2 & 255;
            loc3[3] = loc2 >> 8;
            if (arg1.loadTargetType == core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY) 
            {
                loc7 = 3;
                loc8 = loc3[loc7] | 16;
                loc3[loc7] = loc8;
            }
            if (arg1.recoveryTargetType == core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY) 
            {
                loc8 = 3;
                loc7 = loc3[loc8] | 32;
                loc3[loc8] = loc7;
            }
            loc3[4] = arg1.loadTargetMin;
            loc3[5] = arg1.recoveryTargetMin;
            loc3[6] = arg1.loadTargetMax;
            loc3[7] = arg1.recoveryTargetMax;
            loc3[8] = arg1.loadTargetMax;
            loc3[9] = arg1.recoveryTargetMax;
            loc3[10] = arg1.iterations;
            var loc5:*=0;
            var loc6:*=arg1.titel.split("");
            loc5 = 0;
            while (loc5 < 10) 
            {
                if (loc6[loc5] == null || loc6[loc5] == "") 
                {
                    loc6[loc5] = " ";
                }
                loc3[loc5 + 11] = (loc6[loc5] as String).charCodeAt(0);
                ++loc5;
            }
            var loc1:*=0;
            loc5 = 0;
            while (loc5 <= 20) 
            {
                loc1 = loc1 + loc3[loc5];
                ++loc5;
            }
            loc1 = loc1 & 255;
            loc3[21] = loc1;
            return loc3;
        }

        internal function removeMarkerFromMarkerVector(arg1:core.marker.Marker, arg2:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            if (arg2.indexOf(arg1) > -1) 
            {
                arg2.splice(arg2.indexOf(arg1), 1);
                removeMarkerFromMarkerVector(arg1, arg2);
            }
            return;
        }

        internal function decodeLoggingData(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry, arg4:Boolean):core.activities.ActivityEntry
        {
            var loc1:*;
            (loc1 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).heartrate = (arg2[1] & 15) << 4 | arg2[0] >> 4;
            if (arg3 != null) 
            {
                loc1.trainingTime = arg1.samplingRate * 100;
                if (arg4) 
                {
                    loc1.trainingTime = loc1.trainingTime - arg3.trainingTime;
                }
                loc1.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc1.trainingTime;
            }
            else 
            {
                loc1.trainingTime = 0;
                loc1.trainingTimeAbsolute = 0;
            }
            loc1.calories = utils.Calculations.calculateCalories(arg1, loc1);
            var loc3:*=(loc3 = (loc3 = (loc3 = arg2[0] & 15) + (arg2[0] >> 4)) + (arg2[1] & 15)) & 15;
            var loc2:*;
            if ((loc2 = arg2[1] >> 4) != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10130, "ROX2012Decoder > decodeLogCycling: incorrect checksum"));
            }
            return loc1;
        }

        internal function decodeEntryFromPause(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry, arg4:Boolean):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc1:*;
            (loc1 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).heartrate = arg2[2];
            var loc3:*=(arg2[1] & 127) << 5 | arg2[0] >> 3;
            loc1.trainingTime = loc3;
            if (arg4) 
            {
                loc1.trainingTime = loc1.trainingTime - arg3.trainingTime;
            }
            if (arg3 == null) 
            {
                loc1.trainingTimeAbsolute = loc1.trainingTime;
            }
            else 
            {
                loc1.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc1.trainingTime;
            }
            var loc5:*=arg2[15];
            var loc2:*=0;
            loc4 = 0;
            while (loc4 <= 14) 
            {
                loc2 = loc2 + arg2[loc4];
                ++loc4;
            }
            if ((loc2 = loc2 & 255) != loc5) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc1;
        }

        internal function decodePauseData(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry, arg4:uint):core.marker.Marker
        {
            var loc2:*=0;
            var loc12:*;
            (loc12 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "p")).type = "p";
            loc12.number = (arg4 - 1);
            loc12.timeAbsolute = arg3.trainingTimeAbsolute;
            var loc4:*=(arg2[4] & 15) << 8 | arg2[3];
            var loc13:*=arg2[4] >> 4;
            var loc18:*=arg2[5];
            var loc14:*=(arg2[7] & 15) << 8 | arg2[6];
            var loc1:*=arg2[8] >> 4;
            var loc6:*=arg2[9];
            var loc3:*=arg2[9];
            var loc15:*=arg2[10];
            var loc16:*=arg2[11];
            var loc11:*=arg2[12];
            var loc8:*=arg2[13];
            var loc9:*=arg2[14];
            var loc5:*=new Date(loc4, loc13, loc18, loc3, loc15, loc16);
            var loc17:*=new Date(loc14, loc1, loc6, loc11, loc8, loc9);
            var loc10:*=new Date(loc14 - loc4, loc1 - loc13, loc6 - loc18, loc11 - loc3, loc8 - loc15, loc9 - loc16);
            arg1.pauseTime = loc10.seconds + 60 * loc10.minutes + 3600 * loc10.hours;
            loc12.duration = loc10.seconds + 60 * loc10.minutes + 3600 * loc10.hours;
            var loc19:*=arg2[15];
            var loc7:*=0;
            loc2 = 0;
            while (loc2 <= 14) 
            {
                loc7 = loc7 + arg2[loc2];
                ++loc2;
            }
            if ((loc7 = loc7 & 255) != loc19) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc12;
        }

        internal function decodeLapData(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker, arg4:uint):core.marker.Marker
        {
            var loc3:*=0;
            var loc2:*;
            (loc2 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "l")).type = "l";
            loc2.number = (arg4 - 1);
            var loc5:*=(arg2[3] & 31) << 21 | arg2[2] << 13 | arg2[1] << 5 | arg2[0] >> 3;
            loc2.time = loc5;
            if (arg3 != null) 
            {
                loc2.timeAbsolute = arg3.timeAbsolute + loc2.time;
            }
            else 
            {
                loc2.timeAbsolute = loc2.time;
            }
            var loc4:*=arg2[5] << 11 | arg2[4] << 3 | arg2[3] >> 5;
            loc2.calories = loc4;
            loc2.averageHeartrate = arg2[6];
            loc2.maximumHeartrate = arg2[7];
            loc2.minimumHeartrate = arg2[8];
            var loc6:*=arg2[9];
            var loc1:*=0;
            loc3 = 0;
            while (loc3 <= 8) 
            {
                loc1 = loc1 + arg2[loc3];
                ++loc3;
            }
            if ((loc1 = loc1 & 255) != loc6) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc2;
        }

        internal function decodeFastLapData(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker, arg4:core.activities.ActivityEntry, arg5:uint):core.marker.Marker
        {
            var loc3:*=0;
            var loc2:*;
            (loc2 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "l")).type = "l";
            loc2.number = (arg5 - 1);
            loc2.fastLap = true;
            var loc4:*=(arg2[3] & 31) << 21 | arg2[2] << 13 | arg2[1] << 5 | arg2[0] >> 3;
            loc2.time = loc4;
            if (arg3 != null) 
            {
                loc2.timeAbsolute = arg3.timeAbsolute + loc2.time;
            }
            else 
            {
                loc2.timeAbsolute = loc2.time;
            }
            if (arg4 != null) 
            {
                loc2.averageHeartrate = arg4.heartrate;
                loc2.maximumHeartrate = arg4.heartrate;
                loc2.minimumHeartrate = arg4.heartrate;
            }
            var loc5:*=arg2[9];
            var loc1:*=0;
            loc3 = 0;
            while (loc3 <= 8) 
            {
                loc1 = loc1 + arg2[loc3];
                ++loc3;
            }
            if ((loc1 = loc1 & 255) != loc5) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc2;
        }

        internal function decodePhaseChangeData(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker, arg4:uint):core.marker.Marker
        {
            var loc4:*=0;
            var loc5:*="IntervalPhase";
            if (arg2[20] == 0) 
            {
                loc5 = "SimplePhase";
            }
            var loc2:*;
            (loc2 = core.marker.MarkerFactory.createMarkerFromLog(arg1, loc5)).type = loc5;
            loc2.number = (arg4 - 1);
            var loc3:*=(arg2[3] & 31) << 21 | arg2[2] << 13 | arg2[1] << 5 | arg2[0] >> 3;
            loc2.time = loc3;
            if (arg3 != null) 
            {
                loc2.timeAbsolute = arg3.timeAbsolute + loc2.time;
            }
            else 
            {
                loc2.timeAbsolute = loc2.time;
            }
            loc2.timeUnderTargetZone = (arg2[6] & 127) << 19 | arg2[5] << 11 | arg2[4] << 3 | arg2[3] >> 5;
            loc2.timeInTargetZone = (arg2[10] & 1) << 25 | arg2[9] << 17 | arg2[8] << 9 | arg2[7] << 1 | arg2[6] >> 7;
            loc2.timeOverTargetZone = (arg2[13] & 7) << 23 | arg2[12] << 15 | arg2[11] << 7 | arg2[10] >> 1;
            loc2.averageHeartrate = arg2[14];
            loc2.maximumHeartrate = arg2[15];
            loc2.minimumHeartrate = arg2[16];
            loc2.calories = arg2[19] << 16 | arg2[18] << 8 | arg2[17];
            if (loc5 == "IntervalPhase") 
            {
                loc2.intervalCount = arg2[20];
            }
            var loc6:*=arg2[21];
            var loc1:*=0;
            loc4 = 0;
            while (loc4 <= 20) 
            {
                loc1 = loc1 + arg2[loc4];
                ++loc4;
            }
            if ((loc1 = loc1 & 255) != loc6) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc2;
        }

        internal function addPlanedPhaseInformation(arg1:core.activities.Activity, arg2:core.marker.Marker, arg3:uint):core.marker.Marker
        {
            var loc1:*=null;
            if (arg3 - 2 < arg1.tempTraining.phasesList.length) 
            {
                loc1 = arg1.tempTraining.phasesList[arg3 - 2] as core.training.TrainingPhase;
                if (arg2.type == "SimplePhase" && loc1.type == core.training.type.PhaseCategory.SIMPLE) 
                {
                    arg2.plannedAutoChange = loc1.phaseChangeMode;
                    arg2.plannedLoadRecovery = loc1.loadRecovery;
                    arg2.plannedPhaseControl = loc1.loadPhaseControl;
                    arg2.plannedLowerLimit = loc1.loadTargetMin;
                    arg2.plannedUpperLimit = loc1.loadTargetMax;
                    arg2.plannedTime = loc1.loadDuration;
                    arg2.title = loc1.titel;
                }
                else if (arg2.type == "IntervalPhase" && loc1.type == core.training.type.PhaseCategory.INTERVAL) 
                {
                    arg2.plannedAutoChange = loc1.phaseChangeMode;
                    arg2.plannedLoadRecovery = loc1.loadRecovery;
                    arg2.plannedPhaseControl = loc1.loadPhaseControl;
                    arg2.plannedRecoveryPhaseControl = loc1.recoveryPhaseControl;
                    arg2.plannedLowerLimit = loc1.loadTargetMin;
                    arg2.plannedRecoveryLowerLimit = loc1.recoveryTargetMin;
                    arg2.plannedUpperLimit = loc1.loadTargetMax;
                    arg2.plannedRecoveryUpperLimit = loc1.recoveryTargetMax;
                    arg2.plannedTime = loc1.loadDuration;
                    arg2.plannedRecoveryTime = loc1.recoveryDuration;
                    arg2.intervalCount = loc1.iterations;
                    arg2.title = loc1.titel;
                }
                else if (arg2.type == "Interval" && loc1.type == core.training.type.PhaseCategory.INTERVAL) 
                {
                    arg2.plannedPhaseControl = loc1.loadPhaseControl;
                    arg2.plannedLowerLimit = loc1.loadTargetMin;
                    arg2.plannedUpperLimit = loc1.loadTargetMax;
                    arg2.plannedTime = loc1.loadDuration;
                }
                else if (arg2.type == "Recovery" && loc1.type == core.training.type.PhaseCategory.INTERVAL) 
                {
                    arg2.plannedRecoveryPhaseControl = loc1.recoveryPhaseControl;
                    arg2.plannedRecoveryLowerLimit = loc1.recoveryTargetMin;
                    arg2.plannedRecoveryUpperLimit = loc1.recoveryTargetMax;
                    arg2.plannedRecoveryTime = loc1.recoveryDuration;
                }
            }
            return arg2;
        }

        internal function decodeIntervalRecoveryData(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker, arg4:uint):core.marker.Marker
        {
            var loc4:*=0;
            var loc5:*="Interval";
            if (!(arg3 == null) && arg3.type == "Interval") 
            {
                loc5 = "Recovery";
            }
            var loc2:*;
            (loc2 = core.marker.MarkerFactory.createMarkerFromLog(arg1, loc5)).type = loc5;
            loc2.number = (arg4 - 1);
            var loc3:*=(arg2[3] & 31) << 21 | arg2[2] << 13 | arg2[1] << 5 | arg2[0] >> 3;
            loc2.time = loc3;
            if (arg3 != null) 
            {
                loc2.timeAbsolute = arg3.timeAbsolute + loc2.time;
            }
            else 
            {
                loc2.timeAbsolute = loc2.time;
            }
            loc2.timeUnderTargetZone = (arg2[6] & 127) << 19 | arg2[5] << 11 | arg2[4] << 3 | arg2[3] >> 5;
            loc2.timeInTargetZone = (arg2[10] & 1) << 25 | arg2[9] << 17 | arg2[8] << 9 | arg2[7] << 1 | arg2[6] >> 7;
            loc2.timeOverTargetZone = (arg2[13] & 7) << 23 | arg2[12] << 15 | arg2[11] << 7 | arg2[10] >> 1;
            loc2.averageHeartrate = arg2[14];
            loc2.maximumHeartrate = arg2[15];
            loc2.minimumHeartrate = arg2[16];
            loc2.calories = arg2[19] << 16 | arg2[18] << 8 | arg2[17];
            var loc6:*=arg2[20];
            var loc1:*=0;
            loc4 = 0;
            while (loc4 <= 19) 
            {
                loc1 = loc1 + arg2[loc4];
                ++loc4;
            }
            if ((loc1 = loc1 & 255) != loc6) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10133, "BLEHandler > decodeUnitInformation: incorrect dynamic checksum"));
                return null;
            }
            return loc2;
        }

        public static function getInstance():decoder.PC2814Decoder
        {
            if (_instance == null) 
            {
                _instance = new PC2814Decoder();
            }
            return _instance;
        }

        public static const MY_NAME:Array=["*", "+", "-", "=", ".", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "♥"];

        public static const OPEN_TRAINING_FOUND:String="openTrainingFound";

        internal static const NO_NAME_STRING:String="         ";

        internal static var _instance:decoder.PC2814Decoder;
    }
}


//  class RC2011Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.marker.*;
    import core.settings.*;
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import init.*;
    import init.interfaces.*;
    import utils.*;
    import utils.converter.*;
    
    public class RC2011Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.units.interfaces.ICodingTotals, core.activities.interfaces.ICodingLog, core.units.interfaces.ICodingUnitInformation
    {
        public function RC2011Decoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10099, "RC2011Decoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc8:*=null;
            var loc6:*=arg1 as Array;
            var loc5:*=0;
            var loc14:*;
            if ((loc14 = loc6[2] & 63) == 1) 
            {
                loc8 = new core.units.UnitRC1411();
            }
            if (loc8 == null) 
            {
                return null;
            }
            var loc12:*;
            var loc2:*=((loc12 = loc6[0]) & 240) >> 4;
            var loc3:*=loc12 & 15;
            var loc1:*=loc2.toString() + loc3.toString();
            var loc13:*;
            var loc11:*=((loc13 = loc6[1]) & 240) >> 4;
            var loc7:*=loc13 & 15;
            var loc4:*=loc11.toString() + loc7.toString();
            loc8.softwareRevision = loc4;
            var loc16:*=parseInt(loc6[3]);
            var loc10:*=0;
            loc5 = 0;
            while (loc5 < 3) 
            {
                loc10 = loc10 + loc6[loc5];
                ++loc5;
            }
            if ((loc10 = loc10 & 255) != loc16) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10100, "RC2011Decoder > decodeUnitInformation: incorrect checksum2"));
                loc8 = null;
                return null;
            }
            var loc15:*="14112011";
            var loc9:*="";
            loc5 = 7;
            while (loc5 > 3) 
            {
                loc9 = loc9 + loc6[loc5].toString(16);
                --loc5;
            }
            if (loc9 != loc15) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10101, "RC2011Decoder > decodeUnitInformation: incorrect checksum1"));
                loc8 = null;
                return null;
            }
            return loc8;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc22:*=0;
            var loc34:*;
            (loc34 = new core.settings.SettingsRC1411()).unitType = arg2.type;
            var loc3:*;
            var loc7:*=(loc3 = arg1 as Array)[0] & 15;
            var loc8:*="";
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc2:*=0;
            var loc1:*=new core.totals.TotalsRC1411();
            loc1.unit = arg2;
            loc1.unitType = arg2.type;
            var loc8:*=(loc8 = (loc8 = (loc8 = (loc8 = arg1[3] << 24) | arg1[2] << 16) | arg1[1] << 8) | arg1[0]) / 10000;
            loc1.totalCal1 = loc8;
            var loc10:*=(loc10 = (loc10 = (loc10 = arg1[7] << 24) | arg1[6] << 16) | arg1[5] << 8) | arg1[4];
            var loc9:*;
            (loc9 = new utils.converter.DistanceConverter()).inputFormat = "meter";
            loc9.outputFormat = "meter";
            loc1.totalDistance1 = loc9.convert(loc10) * 0.1;
            var loc5:*=(loc5 = (arg1[11] & 255) << 8) | arg1[10];
            var loc3:*=arg1[9];
            var loc6:*=arg1[8];
            loc1.totalTrainingTime1 = (loc5 * 3600 + loc3 * 60 + loc6) * 100;
            var loc4:*=(loc4 = arg1[13] << 8) | arg1[12];
            var loc11:*=0;
            loc2 = 0;
            while (loc2 < 12) 
            {
                loc11 = loc11 + arg1[loc2];
                ++loc2;
            }
            if ((loc11 = loc11 & 65535) != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10106, "RC2011Decoder > decodeTotalValues: incorrect checksum3"));
            }
            var loc12:*="14112011";
            var loc7:*="";
            loc2 = 17;
            while (loc2 > 13) 
            {
                loc7 = loc7 + arg1[loc2].toString(16);
                --loc2;
            }
            if (loc7 != loc12) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10107, "RC2011Decoder > decodeTotalValues: incorrect checksum1"));
            }
            return loc1;
        }

        public function decodeBatteryInformation(arg1:Object, arg2:core.units.Unit):core.units.Unit
        {
            var loc1:*=arg1 as Array;
            var loc7:*=(loc7 = (loc7 = loc1[2] << 16) | loc1[1] << 8) | loc1[0];
            var loc2:*=(loc2 = (loc2 = loc1[5] << 16) | loc1[4] << 8) | loc1[3];
            var loc8:*=(loc8 = loc1[7] << 8) | loc1[6];
            var loc6:*=loc1[8] & 1;
            (arg2 as core.units.interfaces.IUnitBatteryStatus).unitBatteryStatus = loc6 != 0 ? true : false;
            var loc9:*=(loc1[8] & 2) >> 1;
            (arg2 as core.units.interfaces.IR3TXBatteryStatus).r3txBatteryStatus = loc9 != 0 ? true : false;
            var loc4:*=loc1[9];
            var loc10:*=0;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < 9) 
            {
                loc10 = loc10 + loc1[loc3];
                ++loc3;
            }
            if ((loc10 = loc10 & 255) != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10108, "RC2011Decoder > decodeBatteryInformation: incorrect checksum3"));
            }
            var loc11:*="14112011";
            var loc5:*="";
            loc3 = 13;
            while (loc3 > 9) 
            {
                loc5 = loc5 + loc1[loc3].toString(16);
                --loc3;
            }
            if (loc5 != loc11) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10109, "RC2011Decoder > decodeBatteryInformation: incorrect checksum1"));
            }
            return arg2;
        }

        public function decodeFreeLoggingTime(arg1:Object, arg2:core.units.Unit):core.units.Unit
        {
            var loc4:*;
            var loc5:*=(loc4 = arg1 as Array)[1] * 3600 + loc4[0] * 60;
            (arg2 as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc5;
            var loc1:*=loc4[3] * 3600 + loc4[2] * 60;
            (arg2 as core.units.interfaces.ILogTime10Sec).logTime10Sec = loc1;
            var loc3:*=loc4[5] * 3600 + loc4[4] * 60;
            (arg2 as core.units.interfaces.ILogTime20Sec).logTime20Sec = loc3;
            var loc2:*=loc4[7] * 3600 + loc4[6] * 60;
            (arg2 as core.units.interfaces.ILogTime30Sec).logTime30Sec = loc2;
            (arg2 as core.units.interfaces.ILogStatus).maxPackages = 10872;
            (arg2 as core.units.interfaces.ILogStatus).freePackages = (arg2 as core.units.interfaces.ILogTime5Sec).logTime5Sec / 5;
            return arg2;
        }

        public function decodeListOfAdressOfPageHeader(arg1:Object, arg2:core.units.Unit):Object
        {
            var loc4:*={};
            var loc2:*=arg1 as Array;
            var loc3:*=0;
            var loc8:*=(loc8 = loc2[0]) | loc2[1] << 8;
            loc4.startAddrLastPage = loc8;
            var loc9:*=(loc9 = loc2[2]) | loc2[3] << 8;
            loc4.stopAddrLastPage = loc9;
            var loc6:*=(loc6 = loc2[4]) | loc2[5] << 8;
            loc4.numberOfPages = loc6;
            loc4.pageHeaderList = new Array(loc6);
            var loc7:*=loc2.slice(6, 14);
            decodeFreeLoggingTime(loc7, arg2);
            var loc1:*=loc2[14];
            var loc11:*=0;
            loc3 = 0;
            while (loc3 < 14) 
            {
                loc11 = loc11 + (loc2[loc3] & 255);
                ++loc3;
            }
            if ((loc11 = loc11 & 255) != loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10111, "RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum4"));
            }
            var loc10:*="14112011";
            var loc5:*="";
            loc3 = 18;
            while (loc3 > 14) 
            {
                loc5 = loc5 + loc2[loc3].toString(16);
                --loc3;
            }
            if (loc5 != loc10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10112, "RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum1"));
            }
            return loc4;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc21:*=0;
            var loc19:*;
            var loc22:*;
            if (!(loc22 = (loc19 = (arg1[11] & 128) >> 7) != 0 ? true : false)) 
            {
                dispatchEvent(new flash.events.Event("openTrainingFound"));
                return null;
            }
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            loc2.pageHeaderData = arg1;
            var loc7:*=arg1[0];
            var loc32:*=arg1[1];
            var loc33:*=2000 + arg1[2];
            var loc23:*=arg1[3];
            var loc30:*=arg1[4];
            var loc5:*=arg1[5];
            loc2.startDate = new Date(loc33, (loc32 - 1), loc7, loc5, loc30, loc23);
            loc2.dateCode = loc2.startDate.toString();
            var loc26:*=(loc26 = (loc26 = arg1[6]) + arg1[7] * 60) + arg1[8] * 3600;
            if (loc2.trainingTimeDefined) 
            {
                loc2.trainingTime = loc26 * 100;
            }
            var loc34:*=(loc34 = arg1[9]) | arg1[10] << 8;
            if (loc2.correctionFactorDefined) 
            {
                loc2.correctionFactor = loc34;
            }
            var loc29:*=arg1[11] & 3;
            if (!(arg2 is core.units.UnitRC1411)) 
            {
            };
            var loc8:*=(arg1[11] & 4) >> 2;
            if (loc2.calibrationDefined) 
            {
                loc2.calibration = loc8 != 0 ? true : false;
            }
            var loc25:*;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc9:*=0;
            var loc21:*=null;
            var loc11:*=null;
            var loc7:*=NaN;
            var loc10:*=NaN;
            var loc22:*=NaN;
            var loc8:*=NaN;
            var loc6:*=NaN;
            var loc5:*=NaN;
            var loc16:*=0;
            var loc23:*=null;
            var loc17:*=0;
            var loc12:*=NaN;
            var loc15:*=NaN;
            var loc24:*=null;
            var loc18:*=NaN;
            var loc3:*=6;
            var loc2:*=19;
            var loc1:*=26;
            var loc20:*=3;
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.statistic = true;
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            try 
            {
                loc9 = 0;
                loc21 = null;
                loc11 = null;
                loc7 = 0;
                loc10 = 0;
                loc22 = 0;
                loc8 = 0;
                loc6 = 0;
                loc5 = 0;
                loc16 = 0;
                for (;;) 
                {
                    loc23 = [];
                }
            }
            catch (e:Error)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10121, "RC2011Decoder > decodeLog: log not decoded, log entries: " + arg2.length + ", logId: " + arg1.activityId));
            }
            if (loc21 is core.activities.ActivityEntry) 
            {
                if (loc21.isPause) 
                {
                    if ((loc12 = loc7 - loc10) > 0) 
                    {
                        loc21.trainingTime = loc21.trainingTime + loc12;
                        loc21.trainingTimeAbsolute = loc7;
                    }
                    if ((loc15 = loc22 - loc8) > 0) 
                    {
                        loc21.distance = loc21.distance + loc15;
                        loc21.distanceAbsolute = loc22;
                    }
                    arg1.pauseTime = arg1.pauseTime - loc21.pauseTime;
                    loc21.pauseTime = 0;
                }
            }
            var loc13:*=core.activities.ActivityFactory.createLogEntryFromLog(arg1);
            if (arg1.entries.length > 0) 
            {
                if ((loc24 = arg1.entries[0]) != null) 
                {
                    if (loc24.heartrateDefined) 
                    {
                        loc13.heartrate = loc24.heartrate;
                    }
                    if (loc24.speedDefined) 
                    {
                        loc13.speed = loc24.speed;
                        loc13.speedTime = loc24.speedTime;
                    }
                }
            }
            arg1.entries.unshift(loc13);
            smoothEntries_v04(arg1);
            calculateFastLapDistances(arg1);
            var loc14:*=arg1.calories;
            handler.ActivityCalculator.calculateMinMaxAvgValues(arg1);
            var loc19:*=arg1.recalculatedValues.calories;
            var loc4:*=arg1.entries.length;
            loc18 = 0;
            while (loc18 < loc4) 
            {
                arg1.entries[loc18].calories = arg1.entries[loc18].calories - arg1.entries[loc18].calories * arg1.caloriesDifferenceFactor;
                ++loc18;
            }
            handler.ActivityCalculator.calculateMarkerValuesByEntries(arg1);
            return;
        }

        public function calculateFastLapDistances(arg1:core.activities.Activity):void
        {
            var loc5:*=null;
            var loc3:*=null;
            var loc6:*=null;
            var loc2:*=arg1.markerList;
            var loc4:*=0;
            var loc1:*=[];
            loc4 = 0;
            while (loc4 < loc2.length) 
            {
                loc3 = loc2[loc4];
                if (loc4 + 1 < loc2.length) 
                {
                    loc6 = loc2[loc4 + 1];
                }
                if (loc3.fastLap) 
                {
                    loc5.addItem(loc3);
                }
                else if (!(loc6 == null) && loc6.fastLapDefined) 
                {
                    (loc5 = init.BackendInitializer.getInstance().createVectorList()).addItem(loc3);
                    loc1[loc1.length] = loc5;
                }
                ++loc4;
            }
            loc4 = 0;
            while (loc4 < loc1.length) 
            {
                setFastLapSeriesDistance(loc1[loc4] as init.interfaces.IVectorList, arg1);
                ++loc4;
            }
            loc4 = 0;
            while (loc4 < loc2.length) 
            {
                loc3 = loc2[loc4];
                loc3.distance = loc3.distance * 10000 / 10000;
                loc3.distanceAbsolute = loc3.distanceAbsolute * 10000 / 10000;
                ++loc4;
            }
            return;
        }

        public function encodeSerialNumberInformation():Array
        {
            var loc1:*=new Array(12);
            loc1[0] = 86;
            loc1[1] = 52;
            loc1[2] = 18;
            loc1[3] = 35;
            loc1[4] = 3;
            loc1[5] = 17;
            loc1[6] = 0;
            var loc2:*=0;
            loc1[7] = 0;
            loc2 = 0;
            while (loc2 < 7) 
            {
                var loc3:*=7;
                var loc4:*=loc1[loc3] + loc1[loc2];
                loc1[loc3] = loc4;
                loc4 = 7;
                loc3 = loc1[loc4] & 255;
                loc1[loc4] = loc3;
                ++loc2;
            }
            loc1[8] = 18;
            loc1[9] = 33;
            loc1[10] = 18;
            loc1[11] = 21;
            return loc1;
        }

        public function encodePageHeaderAddrList(arg1:core.units.Unit):Array
        {
            var loc1:*=new Array(19);
            var loc2:*=0;
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            loc1[6] = 6;
            loc1[7] = 15;
            (arg1 as core.units.interfaces.ILogTime5Sec).logTime5Sec = 54360;
            loc1[8] = 12;
            loc1[9] = 30;
            (arg1 as core.units.interfaces.ILogTime10Sec).logTime10Sec = 108720;
            loc1[10] = 25;
            loc1[11] = 60;
            (arg1 as core.units.interfaces.ILogTime20Sec).logTime20Sec = 217500;
            loc1[12] = 37;
            loc1[13] = 90;
            (arg1 as core.units.interfaces.ILogTime30Sec).logTime30Sec = 326220;
            loc2 = 0;
            while (loc2 < 14) 
            {
                var loc3:*=14;
                var loc4:*=loc1[loc3] + loc1[loc2];
                loc1[loc3] = loc4;
                loc4 = 14;
                loc3 = loc1[loc4] & 255;
                loc1[loc4] = loc3;
                ++loc2;
            }
            loc1[15] = 17;
            loc1[16] = 32;
            loc1[17] = 17;
            loc1[18] = 20;
            return loc1;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc3:*=new Array(30);
            var loc4:*=0;
            var loc13:*=arg1.currentSettings as core.settings.SettingsRC1411;
            loc4 = 0;
            while (loc4 < loc3.length) 
            {
                loc3[loc4] = 0;
                ++loc4;
            }
            var loc21:*=loc13.lowBatDetectLevel;
            while ("2.2V" === loc21) 
            {
                var loc20:*=0;
                loc21 = loc3[loc20] | 1;
                loc3[loc20] = loc21;
            }
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc5:*=new Array(18);
            var loc8:*=0;
            var loc2:*=arg1 as core.totals.TotalsRC1411;
            var loc3:*=loc2.totalCal1 * 10000;
            loc5[0] = loc3 & 255;
            loc5[1] = (loc3 & 65280) >> 8;
            loc5[2] = (loc3 & 16711680) >> 16;
            loc5[3] = (loc3 & 4278190080) >> 24;
            var loc6:*;
            (loc6 = new utils.converter.DistanceConverter()).inputFormat = "meter";
            loc6.outputFormat = "meter";
            var loc4:*=loc6.convert(loc2.totalDistance1) * 10;
            loc5[4] = loc4 & 255;
            loc5[5] = (loc4 & 65280) >> 8;
            loc5[6] = (loc4 & 16711680) >> 16;
            loc5[7] = (loc4 & 4278190080) >> 24;
            loc2.totalTrainingTime1 = loc2.totalTrainingTime1 / 100;
            var loc9:*=Math.abs(loc2.totalTrainingTime1 / 3600);
            var loc1:*=Math.abs((loc2.totalTrainingTime1 - loc9 * 3600) / 60);
            var loc7:*=loc2.totalTrainingTime1 - loc9 * 3600 - loc1 * 60;
            loc5[8] = loc7;
            loc5[9] = loc1;
            loc5[10] = loc9 & 255;
            loc5[11] = (loc9 & 65280) >> 8;
            var loc10:*=0;
            loc8 = 0;
            while (loc8 < 12) 
            {
                loc10 = loc10 + (loc5[loc8] & 65535);
                ++loc8;
            }
            loc5[12] = loc10 & 255;
            loc5[13] = (loc10 & 65280) >> 8;
            loc5[14] = 17;
            loc5[15] = 32;
            loc5[16] = 17;
            loc5[17] = 20;
            return loc5;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            return;
        }

        internal function decodeLogEntry(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:core.marker.Marker=null):core.activities.ActivityEntry
        {
            var loc4:*=0;
            if (_debug) 
            {
                ++_testCounter;
            }
            var loc6:*;
            (loc6 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            loc6.isPause = false;
            var loc9:*=(arg2[0] & 4) >> 2;
            var loc3:*=(loc3 = (loc3 = arg2[0] >> 4) | arg2[1] << 4) / 10;
            if (arg1.distanceDefined && loc6.distanceDefined && loc6.distanceAbsoluteDefined) 
            {
                loc6.distance = loc3;
                if (arg3 == null) 
                {
                    loc6.distanceAbsolute = loc3;
                }
                else 
                {
                    loc6.distanceAbsolute = arg3.distanceAbsolute + loc3;
                }
            }
            var loc7:*=arg1.samplingRate * 100;
            loc6.trainingTime = loc7;
            if (arg3 == null) 
            {
                loc6.trainingTimeAbsolute = loc7;
            }
            else 
            {
                loc6.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc7;
            }
            var loc5:*=arg2[2];
            if (loc6.heartrateDefined) 
            {
                loc6.heartrate = loc5;
                if (loc5 < arg1.minimumHeartrate) 
                {
                    arg1.minimumHeartrate = loc5;
                }
                if (loc5 > arg1.maximumHeartrate) 
                {
                    arg1.maximumHeartrate = loc5;
                }
                if (arg1.upperLimitDefined && arg1.lowerLimitDefined && arg1.samplingRateDefined) 
                {
                    if (loc5 < arg1.lowerLimit) 
                    {
                        arg1.timeUnderZone = arg1.timeUnderZone + arg1.samplingRate * 100;
                    }
                    else if (loc5 >= arg1.lowerLimit && loc5 <= arg1.upperLimit) 
                    {
                        arg1.timeInZone = arg1.timeInZone + arg1.samplingRate * 100;
                    }
                    else if (loc5 > arg1.upperLimit) 
                    {
                        arg1.timeOverZone = arg1.timeOverZone + arg1.samplingRate * 100;
                    }
                }
            }
            var loc1:*=(loc1 = (loc1 = arg2[3]) | arg2[4] << 8) / 100;
            var loc8:*;
            (loc8 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc8.outputFormat = "ms";
            if (loc6.speedDefined) 
            {
                loc6.speed = loc8.convert(loc1);
                if (loc6.speed > 0) 
                {
                    loc6.speedTime = Math.floor(1000 / loc6.speed);
                }
                else 
                {
                    loc6.speedTime = 1200;
                }
                if (loc6.speedTime > 1200) 
                {
                    loc6.speedTime = 1200;
                }
                if (loc6.speed < arg1.minimumSpeed) 
                {
                    arg1.minimumSpeed = loc6.speed;
                }
                if (loc6.speed > arg1.maximumSpeed) 
                {
                    arg1.maximumSpeed = loc6.speed;
                }
            }
            var loc2:*=arg2[5];
            var loc10:*=0;
            loc4 = 0;
            while (loc4 < 5) 
            {
                loc10 = (loc10 = loc10 + arg2[loc4]) & 31;
                ++loc4;
            }
            if (loc10 != loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10113, "RC2011Decoder > decodeLog: incorrect checksum6 (logEntry)"));
            }
            arg1.entries.push(loc6);
            arg3 = loc6;
            return arg3;
        }

        internal function decodeLogPause(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:core.marker.Marker=null):core.activities.ActivityEntry
        {
            var loc14:*=0;
            if (_debug) 
            {
                ++_testCounter;
            }
            var loc16:*;
            (loc16 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            loc16.isPause = true;
            var loc12:*=arg2[0] >> 2;
            loc16.trainingTime = loc12 * 100;
            if (arg3 == null) 
            {
                loc16.trainingTimeAbsolute = loc12;
            }
            else 
            {
                loc16.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc12;
            }
            var loc4:*=arg2[1];
            if (loc16.heartrateDefined) 
            {
                loc16.heartrate = loc4;
            }
            var loc24:*=(loc24 = (loc24 = arg2[2]) | arg2[3] << 8) / 10;
            if (loc16.distanceDefined && loc16.distanceAbsoluteDefined) 
            {
                loc16.distance = loc24;
                if (arg3 == null) 
                {
                    loc16.distanceAbsolute = loc24;
                }
                else 
                {
                    loc16.distanceAbsolute = arg3.distanceAbsolute + loc24;
                }
            }
            var loc17:*=(loc17 = (loc17 = arg2[4]) | arg2[5] << 8) / 100;
            var loc8:*;
            (loc8 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc8.outputFormat = "ms";
            if (loc16.speedDefined) 
            {
                loc16.speed = loc8.convert(loc17);
                if (loc16.speed > 0) 
                {
                    loc16.speedTime = Math.floor(1000 / loc16.speed);
                }
                else 
                {
                    loc16.speedTime = 1200;
                }
                if (loc16.speedTime > 1200) 
                {
                    loc16.speedTime = 1200;
                }
            }
            var loc5:*=arg2[6];
            var loc15:*=arg2[7];
            var loc19:*=2000 + arg2[8];
            var loc18:*=arg2[9];
            var loc1:*=arg2[10];
            var loc11:*=arg2[11];
            var loc6:*=new Date(loc19, (loc15 - 1), loc5, loc11, loc1, loc18);
            var loc20:*=arg2[12];
            var loc13:*=arg2[13];
            var loc7:*=2000 + arg2[14];
            var loc21:*=arg2[15];
            var loc9:*=arg2[16];
            var loc10:*=arg2[17];
            var loc22:*;
            var loc2:*=((loc22 = new Date(loc7, (loc13 - 1), loc20, loc10, loc9, loc21)).getTime() - loc6.getTime()) * 0.1;
            arg1.pauseTime = arg1.pauseTime + loc2;
            loc16.pauseTime = loc2;
            var loc3:*=arg2[18];
            var loc23:*=0;
            loc14 = 0;
            while (loc14 < 18) 
            {
                loc23 = loc23 + (arg2[loc14] & 31);
                ++loc14;
            }
            if ((loc23 = loc23 & 31) != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10115, "RC2011Decoder > decodeLogPause: incorrect checksum6 (logPause)"));
            }
            arg1.entries.push(loc16);
            arg3 = loc16;
            return arg3;
        }

        internal function decodeLogLap(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:core.marker.Marker=null):core.marker.Marker
        {
            var loc3:*=NaN;
            var loc4:*=0;
            if (_debug) 
            {
                ++_testCounter;
            }
            var loc16:*;
            (loc16 = core.marker.MarkerFactory.createMarkerFromLog(arg1)).logReference = arg1;
            loc16.type = "l";
            loc16.number = arg1.markerList.length;
            loc16.title = "";
            loc16.description = "";
            if (loc16.fastLapDefined) 
            {
                loc16.fastLap = false;
            }
            var loc17:*=(arg2[0] & 4) >> 2;
            if (loc16.tXSensorPositionDefined) 
            {
                loc16.tXSensorPosition = loc17 != 1 ? "chest" : "hip";
            }
            var loc7:*;
            if ((loc7 = arg2[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value - decodeLogLap - minHR"));
            }
            if (loc16.minimumHeartrateDefined) 
            {
                loc16.minimumHeartrate = loc7;
            }
            var loc11:*;
            if ((loc11 = arg2[2]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value - decodeLogLap - avgHR"));
            }
            if (loc16.averageHeartrateDefined) 
            {
                loc16.averageHeartrate = loc11;
            }
            var loc1:*;
            if ((loc1 = arg2[3]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value - decodeLogLap - maxHR"));
            }
            if (loc16.maximumHeartrateDefined) 
            {
                loc16.maximumHeartrate = loc1;
            }
            var loc5:*=(loc5 = (loc5 = (loc5 = (loc5 = arg2[4]) | arg2[5] << 8) | arg2[6] << 16) | arg2[7] << 24) / 10000;
            if (loc16.caloriesDefined) 
            {
                loc16.calories = loc5;
            }
            var loc14:*=arg2[8];
            var loc8:*=arg2[9];
            var loc12:*=arg2[10];
            var loc10:*;
            var loc13:*=(loc10 = arg2[11]) * 360000 + loc12 * 6000 + loc8 * 100 + loc14 * 10;
            loc16.time = loc13;
            if (arg4 == null) 
            {
                loc16.timeAbsolute = loc13;
            }
            else 
            {
                loc16.timeAbsolute = arg4.timeAbsolute + loc13;
            }
            var loc18:*=(loc18 = (loc18 = (loc18 = arg2[12]) | arg2[13] << 8) | arg2[14] << 16) | arg2[15] << 24;
            if (loc16.distanceDefined && loc16.distanceAbsoluteDefined) 
            {
                loc3 = loc18 / 10000;
                loc16.distance = loc3 * 1000;
                if (arg4 == null) 
                {
                    loc16.distanceAbsolute = loc16.distance;
                }
                else 
                {
                    loc16.distanceAbsolute = arg4.distanceAbsolute + loc16.distance;
                }
            }
            var loc15:*;
            (loc15 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc15.outputFormat = "ms";
            var loc19:*;
            if ((loc19 = (loc19 = (loc19 = arg2[16]) | arg2[17] << 8) | arg2[18] << 16) == 2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc19 = loc19 / 100;
            if (loc16.minimumSpeedDefined) 
            {
                loc16.minimumSpeed = loc15.convert(loc19);
            }
            var loc9:*;
            if ((loc9 = (loc9 = (loc9 = arg2[19]) | arg2[20] << 8) | arg2[21] << 16) == 2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc9 = loc9 / 100;
            if (loc16.averageSpeedDefined) 
            {
                loc16.averageSpeed = loc15.convert(loc9);
            }
            var loc6:*;
            if ((loc6 = (loc6 = (loc6 = arg2[22]) | arg2[23] << 8) | arg2[24] << 16) == 2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc6 = loc6 / 100;
            if (loc16.maximumSpeedDefined) 
            {
                loc16.maximumSpeed = loc15.convert(loc6);
            }
            var loc2:*=arg2[25] & 31;
            var loc20:*=0;
            loc4 = 0;
            while (loc4 < 25) 
            {
                loc20 = loc20 + (arg2[loc4] & 31);
                ++loc4;
            }
            if ((loc20 = loc20 & 31) != loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10114, "RC2011Decoder > decodeLogMarker: incorrect checksum6 (logLap)"));
            }
            arg1.markerList.push(loc16);
            return arg4 = loc16;
        }

        internal function decodeLogFastLap(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:core.marker.Marker=null):core.marker.Marker
        {
            if (_debug) 
            {
                ++_testCounter;
            }
            var loc4:*;
            (loc4 = core.marker.MarkerFactory.createMarkerFromLog(arg1)).logReference = arg1;
            loc4.type = "l";
            loc4.number = arg1.markerList.length;
            loc4.title = "";
            loc4.description = "";
            if (loc4.fastLapDefined) 
            {
                loc4.fastLap = true;
            }
            var loc5:*=(arg2[0] & 4) >> 2;
            if (loc4.tXSensorPositionDefined) 
            {
                loc4.tXSensorPosition = loc5 != 1 ? "chest" : "hip";
            }
            var loc3:*=arg2[1].toString();
            var loc1:*=arg2[1] * 10;
            if (isNaN(loc1)) 
            {
                loc1 = 0;
            }
            loc4.time = loc1;
            if (arg4 == null) 
            {
                loc4.timeAbsolute = loc1;
            }
            else 
            {
                loc4.timeAbsolute = arg4.timeAbsolute + loc1;
            }
            if (loc4.distanceDefined && loc4.distanceAbsoluteDefined) 
            {
                loc4.distance = 0;
                loc4.distanceAbsolute = 0;
            }
            var loc2:*=arg2[2] & 31;
            var loc6:*;
            if ((loc6 = (loc6 = (arg2[0] & 31) + (arg2[1] & 31)) & 31) != loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10116, "RC2011Decoder > decodeLogFastLap: incorrect checksum6 (logFastLap)"));
            }
            arg1.markerList.push(loc4);
            return arg4 = loc4;
        }

        internal function setFastLapSeriesDistance(arg1:init.interfaces.IVectorList, arg2:core.activities.Activity):void
        {
            var loc1:*=null;
            var loc9:*=null;
            var loc14:*=null;
            var loc13:*=null;
            var loc8:*=null;
            var loc4:*=null;
            var loc12:*=null;
            var loc3:*=0;
            var loc11:*=arg1.getItemAt(0) as core.marker.Marker;
            var loc10:*=arg1.getItemAt((arg1.length - 1)) as core.marker.Marker;
            var loc7:*=init.BackendInitializer.getInstance().createVectorList();
            loc3 = 0;
            while (loc3 < arg2.entries.length) 
            {
                loc1 = arg2.entries[loc3];
                if (loc1.trainingTimeAbsolute > loc11.timeAbsolute && loc1.trainingTimeAbsolute < loc10.timeAbsolute) 
                {
                    loc7.addItem(loc1);
                }
                ++loc3;
            }
            var loc2:*=init.BackendInitializer.getInstance().createVectorList();
            var loc6:*=0;
            if (loc7.length != 0) 
            {
                loc3 = 0;
                while (loc3 < loc7.length) 
                {
                    loc9 = loc7.getItemAt(loc3);
                    loc6 = 0;
                    while (loc6 < arg1.length) 
                    {
                        loc13 = arg1.getItemAt(loc6);
                        if (loc9.trainingTimeAbsolute > loc13.timeAbsolute) 
                        {
                            if (!loc2.contains(loc13)) 
                            {
                                loc2.addItem(loc13);
                            }
                        }
                        else 
                        {
                            loc2.addItem(loc9);
                            if (loc3 == (loc7.length - 1)) 
                            {
                                if (!loc2.contains(loc13)) 
                                {
                                    loc2.addItem(loc13);
                                }
                            }
                            loc6 = arg1.length;
                        }
                        ++loc6;
                    }
                    ++loc3;
                }
            }
            else 
            {
                loc6 = 0;
                while (loc6 < arg1.length) 
                {
                    loc2.addItem(arg1.getItemAt(loc6));
                    ++loc6;
                }
            }
            var loc5:*=0;
            var loc15:*=0;
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                if (loc3 > 0) 
                {
                    loc8 = loc2.getItemAt((loc3 - 1));
                }
                if ((loc4 = loc2.getItemAt(loc3)) is core.marker.Marker && (loc4 as core.marker.Marker).fastLapDefined) 
                {
                    if ((loc4 as core.marker.Marker).fastLap == false) 
                    {
                        loc12 = loc4;
                    }
                }
                if (loc8 != null) 
                {
                    if (loc4 is core.marker.Marker && (loc4 as core.marker.Marker).fastLapDefined) 
                    {
                        if (loc8 is core.activities.ActivityEntry) 
                        {
                            loc5 = (loc8 as core.activities.ActivityEntry).distanceAbsolute;
                            loc15 = (loc8 as core.activities.ActivityEntry).trainingTimeAbsolute;
                        }
                        else if (loc8 is core.marker.Marker) 
                        {
                            loc5 = (loc8 as core.marker.Marker).distanceAbsolute;
                            loc15 = (loc8 as core.marker.Marker).timeAbsolute;
                        }
                        else 
                        {
                            loc5 = 0;
                            loc15 = 0;
                        }
                        if ((loc4 as core.marker.Marker).fastLapDefined && !(loc5 == 0) && !(loc15 == 0)) 
                        {
                            (loc4 as core.marker.Marker).distanceAbsolute = loc5 * (loc4 as core.marker.Marker).timeAbsolute / loc15;
                            (loc4 as core.marker.Marker).distance = (loc4 as core.marker.Marker).distanceAbsolute - loc5;
                        }
                        if ((loc12 as core.marker.Marker).minimumHeartrateDefined && (loc12 as core.marker.Marker).maximumHeartrateDefined && (loc12 as core.marker.Marker).averageHeartrateDefined) 
                        {
                            if ((loc4 as core.marker.Marker).fastLapDefined) 
                            {
                                (loc4 as core.marker.Marker).minimumHeartrate = (loc12 as core.marker.Marker).minimumHeartrate;
                                (loc4 as core.marker.Marker).maximumHeartrate = (loc12 as core.marker.Marker).maximumHeartrate;
                                (loc4 as core.marker.Marker).averageHeartrate = (loc12 as core.marker.Marker).averageHeartrate;
                            }
                        }
                        if ((loc12 as core.marker.Marker).minimumSpeedDefined && (loc12 as core.marker.Marker).maximumSpeed && (loc12 as core.marker.Marker).averageSpeedDefined) 
                        {
                            if ((loc4 as core.marker.Marker).fastLapDefined) 
                            {
                                (loc4 as core.marker.Marker).minimumSpeed = (loc12 as core.marker.Marker).minimumSpeed;
                                (loc4 as core.marker.Marker).maximumSpeed = (loc12 as core.marker.Marker).maximumSpeed;
                                (loc4 as core.marker.Marker).averageSpeed = (loc12 as core.marker.Marker).averageSpeed;
                            }
                        }
                    }
                }
                ++loc3;
            }
            return;
        }

        internal function smoothEntries_v04(arg1:core.activities.Activity):void
        {
            var loc18:*=null;
            var loc5:*=null;
            var loc10:*=null;
            var loc24:*=null;
            var loc6:*=null;
            var loc16:*=null;
            var loc19:*=NaN;
            var loc8:*;
            (loc8 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc8.outputFormat = "ms";
            var loc7:*=loc8.convert(0.02);
            var loc9:*=-1;
            var loc25:*=-1;
            var loc12:*=0;
            var loc15:*=0;
            var loc21:*=20;
            var loc11:*=-1;
            var loc1:*=-1;
            var loc13:*=0;
            var loc20:*=0;
            var loc23:*=arg1.samplingRate * 80;
            loc20 = 0;
            while (loc20 < arg1.entries.length) 
            {
                loc18 = arg1.entries[loc20];
                if (loc20 >= 1 && arg1.entries.length > 1) 
                {
                    loc24 = arg1.entries[(loc20 - 1)];
                }
                if (loc20 >= 2 && arg1.entries.length > 2) 
                {
                    loc6 = arg1.entries[loc20 - 2];
                }
                if (arg1.entries.length > loc20 + 1) 
                {
                    loc16 = arg1.entries[loc20 + 1];
                }
                if (loc18.isPause == true && loc18.trainingTime == 0) 
                {
                    loc24.isPause = true;
                    loc24.isWaypoint = loc18.isWaypoint;
                    loc24.pauseTime = loc18.pauseTime;
                    handler.ActivityCalculator.removeEntryFromEntriesVector(arg1.entries[loc20], arg1.entries);
                    --loc20;
                }
                else 
                {
                    if (loc18.heartrateDefined) 
                    {
                        if (loc18.isPause) 
                        {
                            if (loc18.trainingTime < 2 || loc18.heartrate == loc21) 
                            {
                                if (loc24 == null) 
                                {
                                    if (loc16 != null) 
                                    {
                                        if (loc16.heartrate > loc21) 
                                        {
                                            loc18.heartrate = loc16.heartrate;
                                        }
                                        else 
                                        {
                                            loc18.heartrate = 0;
                                        }
                                    }
                                }
                                else if (loc24.heartrate > loc21) 
                                {
                                    loc18.heartrate = loc24.heartrate;
                                }
                                else if (loc6 != null) 
                                {
                                    if (loc6.heartrate > loc21) 
                                    {
                                        loc18.heartrate = loc6.heartrate;
                                    }
                                }
                            }
                            if (loc18.heartrate == loc21) 
                            {
                                loc18.heartrate = loc13;
                            }
                            loc1 = loc20;
                            if (loc11 >= 0 && loc11 < loc1) 
                            {
                                smoothHeartrate(arg1, loc11, loc1);
                            }
                            loc11 = loc20;
                            loc1 = loc20;
                        }
                        else 
                        {
                            if (loc24 != null) 
                            {
                                if (loc24.isPause) 
                                {
                                    if (loc18.trainingTime < 5 || loc18.heartrate == loc21) 
                                    {
                                        if (loc16 != null) 
                                        {
                                            if (loc16.heartrate > loc21) 
                                            {
                                                loc18.heartrate = loc16.heartrate;
                                            }
                                        }
                                    }
                                }
                            }
                            if (loc18.heartrate == loc21) 
                            {
                                if (arg1.entries.length > 1) 
                                {
                                    if (loc20 != 0) 
                                    {
                                        if (loc20 == (arg1.entries.length - 1)) 
                                        {
                                            smoothHeartrate(arg1, arg1.entries.length - 2, (arg1.entries.length - 1));
                                        }
                                    }
                                    else 
                                    {
                                        smoothHeartrate(arg1, 0, 1);
                                        loc11 = loc20;
                                        loc1 = loc20;
                                    }
                                }
                            }
                            else if (loc11 != (loc20 - 1)) 
                            {
                                loc1 = loc20;
                                if (loc11 >= 0 && loc11 < loc1) 
                                {
                                    smoothHeartrate(arg1, loc11, loc1);
                                }
                                loc11 = loc20;
                                loc1 = loc20;
                            }
                            else 
                            {
                                loc11 = loc20;
                                loc13 = loc18.heartrate;
                            }
                        }
                    }
                    if (loc18.speedDefined) 
                    {
                        if (loc18.isPause) 
                        {
                            if (loc18.trainingTime < 2 || loc18.speed == loc7) 
                            {
                                if (loc24 == null) 
                                {
                                    if (loc16 != null) 
                                    {
                                        if (loc16.speed == loc7) 
                                        {
                                            loc18.speed = 0;
                                            loc18.speedTime = 0;
                                        }
                                        else 
                                        {
                                            loc18.speed = loc16.speed;
                                            loc18.speedTime = loc16.speedTime;
                                        }
                                    }
                                }
                                else if (loc24.speed == loc7) 
                                {
                                    if (loc6 != null) 
                                    {
                                        if (loc6.speed != loc7) 
                                        {
                                            loc18.speed = loc6.speed;
                                            loc18.speedTime = loc6.speedTime;
                                        }
                                    }
                                }
                                else 
                                {
                                    loc18.speed = loc24.speed;
                                    loc18.speedTime = loc24.speedTime;
                                }
                            }
                            if (loc18.speed == loc7) 
                            {
                                loc18.speed = loc12;
                            }
                            loc25 = loc20;
                            if (loc9 >= 0 && loc9 < loc25) 
                            {
                                smoothSpeed(arg1, loc9, loc25);
                            }
                            loc9 = loc20;
                            loc25 = loc20;
                        }
                        else 
                        {
                            if (loc24 != null) 
                            {
                                if (loc24.isPause) 
                                {
                                    if (loc18.trainingTime < 5 || loc18.speed == loc7) 
                                    {
                                        if (loc16 != null) 
                                        {
                                            if (loc16.speed != loc7) 
                                            {
                                                loc18.speed = loc16.speed;
                                                loc18.speedTime = loc16.speedTime;
                                            }
                                        }
                                    }
                                }
                            }
                            if (loc18.speed == loc7) 
                            {
                                if (arg1.entries.length > 1) 
                                {
                                    if (loc20 != 0) 
                                    {
                                        if (loc20 == (arg1.entries.length - 1)) 
                                        {
                                            smoothSpeed(arg1, arg1.entries.length - 2, (arg1.entries.length - 1));
                                        }
                                    }
                                    else 
                                    {
                                        smoothSpeed(arg1, 0, 1);
                                        loc9 = loc20;
                                        loc25 = loc20;
                                    }
                                }
                            }
                            else if (loc9 != (loc20 - 1)) 
                            {
                                loc25 = loc20;
                                if (loc9 >= 0 && loc9 < loc25) 
                                {
                                    smoothSpeed(arg1, loc9, loc25);
                                }
                                loc9 = loc20;
                                loc25 = loc20;
                            }
                            else 
                            {
                                loc9 = loc20;
                                loc12 = loc18.speed;
                                loc15 = loc18.speedTime;
                            }
                        }
                    }
                }
                ++loc20;
            }
            var loc3:*=-1;
            var loc4:*=-1;
            loc24 = null;
            loc20 = 0;
            while (loc20 < arg1.entries.length) 
            {
                loc18 = arg1.entries[loc20];
                if (loc20 >= 1 && arg1.entries.length > 1) 
                {
                    loc24 = arg1.entries[(loc20 - 1)];
                }
                if (loc18.distanceDefined) 
                {
                    if (loc18.isPause) 
                    {
                        loc4 = loc20;
                        if (loc3 >= 0 && loc3 < loc4) 
                        {
                            smoothDistance(arg1, loc3, loc4);
                        }
                        loc3 = loc20;
                        loc4 = loc20;
                    }
                    else if (loc24 != null) 
                    {
                        loc19 = loc18.distance - loc24.distance;
                        if (!(loc18.distance == 0) && loc18.speed > 0 && loc19 < loc23) 
                        {
                            if (loc3 != (loc20 - 1)) 
                            {
                                loc4 = loc20;
                                if (loc3 >= 0 && loc3 < loc4) 
                                {
                                    smoothDistance(arg1, loc3, loc4);
                                }
                                loc3 = loc20;
                                loc4 = loc20;
                            }
                            else 
                            {
                                loc3 = loc20;
                            }
                        }
                    }
                }
                ++loc20;
            }
            var loc14:*=1e-005;
            var loc17:*=arg1.calories;
            var loc22:*=0;
            var loc2:*={};
            loc2.weight = utils.Calculations.calculateWeight(arg1.age, arg1.hrMax);
            loc2.weightUnit = "kg";
            loc2.hrMax = arg1.hrMax;
            loc2.gender = arg1.gender;
            loc2.age = arg1.age;
            loc2.samplingRate = arg1.samplingRate;
            loc20 = 0;
            while (loc20 < arg1.entries.length) 
            {
                loc18 = arg1.entries[loc20];
                if (loc20 > 0) 
                {
                    loc24 = arg1.entries[(loc20 - 1)];
                }
                loc18.number = loc20;
                if (loc20 > 0) 
                {
                    loc24 = arg1.entries[(loc20 - 1)];
                    loc18.distanceAbsolute = loc24.distanceAbsolute + loc18.distance;
                    if (loc18.distanceAbsolute <= loc24.distanceAbsolute) 
                    {
                        loc18.distanceAbsolute = loc24.distanceAbsolute + loc14;
                    }
                }
                else 
                {
                    loc18.distanceAbsolute = loc18.distance;
                }
                loc18.calories = utils.Calculations.calculateCalories(loc2, loc18, "kg");
                loc22 = loc22 + loc18.calories;
                ++loc20;
            }
            utils.Calculations.calculateCaloriesDifferenceFactor(arg1, arg1.calories, loc22);
            return;
        }

        internal function smoothDistance(arg1:core.activities.Activity, arg2:int, arg3:int):void
        {
            var loc2:*=0;
            if (arg3 <= arg2 || arg3 == -1 || arg2 == -1) 
            {
                return;
            }
            var loc3:*=0;
            var loc1:*=0;
            loc2 = arg2 + 1;
            while (loc2 < arg3) 
            {
                loc3 = loc3 + arg1.entries[loc2].distance;
                ++loc1;
                ++loc2;
            }
            loc3 = loc3 / loc1;
            loc2 = arg2 + 1;
            while (loc2 < arg3) 
            {
                arg1.entries[loc2].distance = loc3;
                ++loc2;
            }
            return;
        }

        internal function smoothSpeed(arg1:core.activities.Activity, arg2:int, arg3:int):void
        {
            var loc2:*=null;
            var loc3:*=0;
            if (arg3 <= arg2 || arg3 == -1 || arg2 == -1) 
            {
                return;
            }
            var loc7:*=arg1.entries[arg2];
            var loc10:*=arg1.entries[arg3];
            var loc5:*=(arg3 - arg2 - 1);
            var loc4:*=60 / arg1.samplingRate;
            if (loc5 > loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 508, "RC2011Decoder > smoothSpeed: wrong speed values: " + loc5));
            }
            var loc6:*=loc7.speed;
            var loc1:*;
            var loc9:*=((loc1 = loc10.speed) - loc6) / (loc5 + 1);
            var loc8:*=0;
            loc3 = arg2 + 1;
            while (loc3 < arg3) 
            {
                loc2 = arg1.entries[loc3];
                if (loc5 > loc4) 
                {
                    loc2.speed = 0;
                    loc2.speedTime = 0;
                }
                else 
                {
                    ++loc8;
                    (loc2 = arg1.entries[loc3]).speed = loc7.speed + loc8 * loc9;
                    loc2.speedTime = Math.floor(1000 / loc2.speed);
                }
                ++loc3;
            }
            return;
        }

        internal function smoothHeartrate(arg1:core.activities.Activity, arg2:int, arg3:int):void
        {
            var loc7:*=null;
            var loc3:*=0;
            if (arg3 <= arg2 || arg3 == -1 || arg2 == -1) 
            {
                return;
            }
            var loc8:*=arg1.entries[arg2];
            var loc10:*=arg1.entries[arg3];
            var loc6:*=(arg3 - arg2 - 1);
            var loc4:*=60 / arg1.samplingRate;
            if (loc6 > loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 509, "RC2011Decoder > smoothHR: wrong heartrate values: " + loc6));
            }
            var loc1:*=loc8.heartrate;
            var loc2:*;
            var loc5:*=((loc2 = loc10.heartrate) - loc1) / (loc6 + 1);
            loc5 = Math.round(loc5);
            var loc9:*=0;
            loc3 = arg2 + 1;
            while (loc3 < arg3) 
            {
                loc7 = arg1.entries[loc3];
                if (loc6 > loc4) 
                {
                    loc7.heartrate = 0;
                }
                else 
                {
                    ++loc9;
                    loc7.heartrate = loc8.heartrate + loc9 * loc5;
                }
                ++loc3;
            }
            return;
        }

        public static function getInstance():decoder.RC2011Decoder
        {
            if (_instance == null) 
            {
                _instance = new RC2011Decoder();
            }
            return _instance;
        }

        public static const OPEN_TRAINING_FOUND:String="openTrainingFound";

        internal var _debug:Boolean=false;

        internal var _testCounter:int=0;

        internal static var _instance:decoder.RC2011Decoder;
    }
}


//  class Rox100Decoder
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
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import init.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class Rox100Decoder extends flash.events.EventDispatcher
    {
        public function Rox100Decoder()
        {
            altitudeConverter = new utils.converter.AltitudeConverter();
            altitudeFormater = init.BackendInitializer.getInstance().createAltitudeFormatter();
            distanceConverter = new utils.converter.DistanceConverter();
            distanceForamtter = init.BackendInitializer.getInstance().createDistanceFormatter();
            super();
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
            if (arg1 is core.settings.SettingsROX100) 
            {
                _myUnitSettings = arg1 as core.settings.SettingsROX100;
            }
            return;
        }

        public function set totals(arg1:core.totals.Totals):void
        {
            if (arg1 is core.totals.TotalsROX100) 
            {
                _myUnitTotals = arg1 as core.totals.TotalsROX100;
            }
            return;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            if (arg1 is core.units.UnitROX100) 
            {
                _myUnit = arg1 as core.units.UnitROX100;
            }
            return;
        }

        internal function decodeLap(arg1:Array, arg2:core.activities.Activity):core.marker.Marker
        {
            var loc1:*=core.marker.MarkerFactory.createMarkerFromLog(arg2);
            loc1.type = "l";
            var loc2:*=0;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[0]) | arg1[1] << 8) | arg1[2] << 16) | arg1[3] << 24) * 10;
            loc1.time = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[4]) | arg1[5] << 8) | arg1[6] << 16) | arg1[7] << 24) * 10;
            loc1.timeAbsolute = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[8]) | arg1[9] << 8) | arg1[10] << 16) | arg1[11] << 24;
            loc1.distance = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[12]) | arg1[13] << 8) | arg1[14] << 16) | arg1[15] << 24;
            loc1.distanceAbsolute = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[16]) | arg1[17] << 8) | arg1[18] << 16) | arg1[19] << 24) / 100;
            loc1.averageSpeed = _speedConverter.convert(loc2);
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[20]) | arg1[21] << 8) | arg1[22] << 16) | arg1[23] << 24) / 100;
            loc1.maximumSpeed = _speedConverter.convert(loc2);
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[24]) | arg1[25] << 8) | arg1[26] << 16) | arg1[27] << 24) / 1000000;
            loc1.longitude = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[28]) | arg1[29] << 8) | arg1[30] << 16) | arg1[31] << 24) / 1000000;
            loc1.latitude = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[32]) | arg1[33] << 8) | arg1[34] << 16) | arg1[35] << 24;
            loc1.calories = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[36]) | arg1[37] << 8) | arg1[38] << 16) | arg1[39] << 24) * 1000;
            loc1.altitudeUphill = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[40]) | arg1[41] << 8) | arg1[42] << 16) | arg1[43] << 24;
            loc1.altitudeDownhill = Math.abs(loc2) * 1000;
            loc2 = (loc2 = arg1[44]) | arg1[45] << 8;
            loc1.averageCadence = loc2;
            loc2 = (loc2 = arg1[46]) | arg1[47] << 8;
            loc1.maximumCadence = loc2;
            loc2 = (loc2 = arg1[48]) | arg1[49] << 8;
            loc1.averagePower = loc2;
            loc2 = (loc2 = arg1[50]) | arg1[51] << 8;
            loc1.maximumPower = loc2;
            if ((loc2 = (loc2 = arg1[52]) | arg1[53] << 8) > 50000) 
            {
                loc2 = loc2 - 65536;
            }
            loc1.averageAltitude = loc2 * 1000;
            loc2 = (loc2 = arg1[54]) | arg1[55] << 8;
            loc1.maximumAltitude = loc2 * 1000;
            loc2 = (loc2 = arg1[56]) | arg1[57] << 8;
            loc1.averageInclineUphill = loc2;
            loc2 = (loc2 = arg1[58]) | arg1[59] << 8;
            loc1.maximumInclineUphill = loc2;
            if ((loc2 = arg1[60]) != 0) 
            {
                loc2 = loc2 - 255;
            }
            loc1.averageInclineDownhill = loc2;
            if ((loc2 = arg1[62]) != 0) 
            {
                loc2 = loc2 - 255;
            }
            loc1.maximumInclineDownhill = loc2;
            loc2 = (loc2 = arg1[64]) | arg1[65] << 8;
            loc1.number = (loc2 - 1);
            loc2 = arg1[66];
            loc1.averageHeartrate = loc2;
            loc2 = arg1[67];
            loc1.maximumHeartrate = loc2;
            return loc1;
        }

        public function encodeTotals():Array
        {
            var loc1:*=new Array(120);
            var loc2:*=0;
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            var loc3:*=_myUnitTotals.totalDistance1;
            loc1[0] = loc3 & 255;
            loc1[1] = loc3 >> 8 & 255;
            loc1[2] = loc3 >> 16 & 255;
            loc1[3] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTrainingTime1 * 10 / 100;
            loc1[4] = loc3 & 255;
            loc1[5] = loc3 >> 8 & 255;
            loc1[6] = loc3 >> 16 & 255;
            loc1[7] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalCal1;
            loc1[8] = loc3 & 255;
            loc1[9] = loc3 >> 8 & 255;
            loc1[10] = loc3 >> 16 & 255;
            loc1[11] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalClimbMeter1 / 1000;
            loc1[12] = loc3 & 255;
            loc1[13] = loc3 >> 8 & 255;
            loc1[14] = loc3 >> 16 & 255;
            loc1[15] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.maxAltitude1 / 1000;
            loc1[16] = loc3 & 255;
            loc1[17] = loc3 >> 8 & 255;
            loc1[18] = loc3 >> 16 & 255;
            loc1[19] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistUp1;
            loc1[20] = loc3 & 255;
            loc1[21] = loc3 >> 8 & 255;
            loc1[22] = loc3 >> 16 & 255;
            loc1[23] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeUp1 / 100;
            loc1[24] = loc3 & 255;
            loc1[25] = loc3 >> 8 & 255;
            loc1[26] = loc3 >> 16 & 255;
            loc1[27] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalDescent1 / 1000 * -1;
            loc1[28] = loc3 & 255;
            loc1[29] = loc3 >> 8 & 255;
            loc1[30] = loc3 >> 16 & 255;
            loc1[31] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistDown1;
            loc1[32] = loc3 & 255;
            loc1[33] = loc3 >> 8 & 255;
            loc1[34] = loc3 >> 16 & 255;
            loc1[35] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeDown1 / 100;
            loc1[36] = loc3 & 255;
            loc1[37] = loc3 >> 8 & 255;
            loc1[38] = loc3 >> 16 & 255;
            loc1[39] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalDistance2;
            loc1[40] = loc3 & 255;
            loc1[41] = loc3 >> 8 & 255;
            loc1[42] = loc3 >> 16 & 255;
            loc1[43] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTrainingTime2 * 10 / 100;
            loc1[44] = loc3 & 255;
            loc1[45] = loc3 >> 8 & 255;
            loc1[46] = loc3 >> 16 & 255;
            loc1[47] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalCal2;
            loc1[48] = loc3 & 255;
            loc1[49] = loc3 >> 8 & 255;
            loc1[50] = loc3 >> 16 & 255;
            loc1[51] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalClimbMeter2 / 1000;
            loc1[52] = loc3 & 255;
            loc1[53] = loc3 >> 8 & 255;
            loc1[54] = loc3 >> 16 & 255;
            loc1[55] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.maxAltitude2 / 1000;
            loc1[56] = loc3 & 255;
            loc1[57] = loc3 >> 8 & 255;
            loc1[58] = loc3 >> 16 & 255;
            loc1[59] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistUp2;
            loc1[60] = loc3 & 255;
            loc1[61] = loc3 >> 8 & 255;
            loc1[62] = loc3 >> 16 & 255;
            loc1[63] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeUp2 / 100;
            loc1[64] = loc3 & 255;
            loc1[65] = loc3 >> 8 & 255;
            loc1[66] = loc3 >> 16 & 255;
            loc1[67] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalDescent2 / 1000 * -1;
            loc1[68] = loc3 & 255;
            loc1[69] = loc3 >> 8 & 255;
            loc1[70] = loc3 >> 16 & 255;
            loc1[71] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistDown2;
            loc1[72] = loc3 & 255;
            loc1[73] = loc3 >> 8 & 255;
            loc1[74] = loc3 >> 16 & 255;
            loc1[75] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeDown2 / 100;
            loc1[76] = loc3 & 255;
            loc1[77] = loc3 >> 8 & 255;
            loc1[78] = loc3 >> 16 & 255;
            loc1[79] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalDistance3;
            loc1[80] = loc3 & 255;
            loc1[81] = loc3 >> 8 & 255;
            loc1[82] = loc3 >> 16 & 255;
            loc1[83] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTrainingTime3 * 10 / 100;
            loc1[84] = loc3 & 255;
            loc1[85] = loc3 >> 8 & 255;
            loc1[86] = loc3 >> 16 & 255;
            loc1[87] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalCal3;
            loc1[88] = loc3 & 255;
            loc1[89] = loc3 >> 8 & 255;
            loc1[90] = loc3 >> 16 & 255;
            loc1[91] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalClimbMeter3 / 1000;
            loc1[92] = loc3 & 255;
            loc1[93] = loc3 >> 8 & 255;
            loc1[94] = loc3 >> 16 & 255;
            loc1[95] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.maxAltitude3 / 1000;
            loc1[96] = loc3 & 255;
            loc1[97] = loc3 >> 8 & 255;
            loc1[98] = loc3 >> 16 & 255;
            loc1[99] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistUp3;
            loc1[100] = loc3 & 255;
            loc1[101] = loc3 >> 8 & 255;
            loc1[102] = loc3 >> 16 & 255;
            loc1[103] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeUp3 / 100;
            loc1[104] = loc3 & 255;
            loc1[105] = loc3 >> 8 & 255;
            loc1[106] = loc3 >> 16 & 255;
            loc1[107] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalDescent3 / 1000 * -1;
            loc1[108] = loc3 & 255;
            loc1[109] = loc3 >> 8 & 255;
            loc1[110] = loc3 >> 16 & 255;
            loc1[111] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTripDistDown3;
            loc1[112] = loc3 & 255;
            loc1[113] = loc3 >> 8 & 255;
            loc1[114] = loc3 >> 16 & 255;
            loc1[115] = loc3 >> 24 & 255;
            loc3 = _myUnitTotals.totalTimeDown3 / 100;
            loc1[116] = loc3 & 255;
            loc1[117] = loc3 >> 8 & 255;
            loc1[118] = loc3 >> 16 & 255;
            loc1[119] = loc3 >> 24 & 255;
            return loc1;
        }

        internal function decodeLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            var loc2:*=0;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[0]) | arg1[1] << 8) | arg1[2] << 16) | arg1[3] << 24) / 1000000;
            loc1.latitude = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[4]) | arg1[5] << 8) | arg1[6] << 16) | arg1[7] << 24) / 1000000;
            loc1.longitude = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[8]) | arg1[9] << 8) | arg1[10] << 16) | arg1[11] << 24) / 100;
            loc1.speed = _speedConverter.convert(loc2);
            if (loc1.speed > 0) 
            {
                loc1.speedTime = Math.floor(1000 / loc1.speed);
            }
            else 
            {
                loc1.speedTime = 1200;
            }
            loc2 = (loc2 = (loc2 = (loc2 = (loc2 = arg1[12]) | arg1[13] << 8) | arg1[14] << 16) | arg1[15] << 24) / 100;
            loc1.distance = loc2;
            loc2 = (loc2 = (loc2 = (loc2 = arg1[16]) | arg1[17] << 8) | arg1[18] << 16) | arg1[19] << 24;
            loc1.trainingTime = loc2 * 10;
            loc2 = (loc2 = arg1[20]) | arg1[21] << 8;
            loc1.power = loc2;
            if (loc1.power == 2000) 
            {
                if (arg2.entries.length != 0) 
                {
                    loc1.power = arg2.entries[(arg2.entries.length - 1)].power;
                }
                else 
                {
                    loc1.power = 0;
                }
            }
            if (loc1.power != 0) 
            {
                loc1.powerPerKG = loc1.power / (arg2.bodyWeight / 1000);
            }
            loc1.workInKJ = loc1.power / 1000 * loc1.trainingTime / 100;
            loc2 = (loc2 = arg1[22]) | arg1[23] << 8;
            if (arg1[23] >> 7 == 1) 
            {
                loc2 = loc2 - 65536;
            }
            loc2 = loc2 / 10;
            loc1.temperature = loc2;
            loc2 = (loc2 = arg1[24]) | arg1[25] << 8;
            if (arg1[25] >> 7 == 1) 
            {
                loc2 = loc2 - 65536;
            }
            loc1.altitude = loc2 * 1000;
            loc2 = arg1[26];
            loc1.heartrate = loc2;
            loc1.percentHRMax = loc1.heartrate * 100 / arg2.hrMax;
            loc2 = arg1[27];
            loc1.cadence = loc2;
            loc2 = arg1[28];
            if ((loc2 = arg1[29]) >> 7 == 1) 
            {
                loc2 = loc2 - 255;
            }
            loc1.incline = loc2;
            loc1.riseRate = loc1.speed * 3.6 / 0.06 * loc1.incline / 100 * 1000;
            loc1.calories = utils.Calculations.calculateCalories(arg2, loc1);
            var loc3:*=loc2 = arg1[30];
            while (0 === loc3) 
            {
                loc1.speedReference = "sensor";
            }
        }

        internal function smoothEntries(arg1:core.activities.Activity, arg2:Boolean=true):void
        {
            var loc6:*=null;
            var loc4:*=null;
            var loc7:*=NaN;
            var loc3:*;
            if ((loc3 = arg1.entries.length) == 0) 
            {
                return;
            }
            var loc1:*=0;
            var loc5:*=0;
            var loc8:*=0;
            var loc2:*=0;
            loc8 = 0;
            while (loc8 < loc3) 
            {
                if ((loc4 = arg1.entries[loc8]).isPause && loc8 + 1 < loc3) 
                {
                    handler.ActivityCalculator.removeEntryFromEntriesVector(arg1.entries[loc8 + 1], arg1.entries);
                    loc3 = arg1.entries.length;
                }
                loc4.number = loc2;
                ++loc2;
                if (loc6 != null) 
                {
                    if (arg1.exerciseTimeDefined) 
                    {
                        loc5 = loc5 + loc4.trainingTime;
                        if (arg1.trainingTime != arg1.exerciseTime) 
                        {
                            if (loc4.speedDefined && loc4.speed > 0) 
                            {
                                loc1 = loc1 + loc4.trainingTime;
                            }
                        }
                        else 
                        {
                            loc1 = loc1 + loc4.trainingTime;
                        }
                    }
                    else 
                    {
                        loc1 = loc1 + loc4.trainingTime;
                    }
                    loc4.trainingTimeAbsolute = loc4.trainingTime + loc6.trainingTimeAbsolute;
                    loc4.distanceAbsolute = loc4.distance + loc6.distanceAbsolute;
                    if ((loc7 = loc4.altitude - loc6.altitude) > 0) 
                    {
                        loc4.altitudeDifferencesUphill = loc7;
                    }
                    else if (loc7 < 0) 
                    {
                        loc4.altitudeDifferencesDownhill = loc7 * -1;
                    }
                    if (arg2) 
                    {
                        if (loc4.incline > 0) 
                        {
                            loc4.distanceUphill = loc4.distance;
                            loc4.trainingTimeUphill = loc4.trainingTime;
                        }
                        else if (loc4.incline < 0) 
                        {
                            loc4.distanceDownhill = loc4.distance;
                            loc4.trainingTimeDownhill = loc4.trainingTime;
                        }
                    }
                    else if (loc7 > 0) 
                    {
                        loc4.distanceUphill = loc4.distance;
                        loc4.trainingTimeUphill = loc4.trainingTime;
                    }
                    else if (loc7 < 0) 
                    {
                        loc4.distanceDownhill = loc4.distance;
                        loc4.trainingTimeDownhill = loc4.trainingTime;
                    }
                    loc6 = loc4;
                }
                else 
                {
                    loc4.trainingTimeAbsolute = loc4.trainingTime;
                    loc4.distanceAbsolute = loc4.distance;
                    loc6 = loc4;
                }
                if (!loc4.isPause) 
                {
                };
                ++loc8;
            }
            if (loc4) 
            {
                arg1.trainingTime = loc1;
                arg1.exerciseTime = loc5;
                arg1.distance = loc4.distanceAbsolute;
            }
            return;
        }

        public function encodeSettings1403271():Array
        {
            var loc6:*;
            (loc6 = new utils.converter.WeightConverter()).inputFormat = "g";
            var loc4:*;
            (loc4 = new utils.converter.SizeConverter()).inputFormat = "centimeter";
            var loc3:*=new Array(236);
            var loc9:*=0;
            loc9 = 0;
            while (loc9 < loc3.length) 
            {
                loc3[loc9] = 0;
                ++loc9;
            }
            loc3[0] = _myUnitSettings.speedUnit != "kmh" ? 1 : 0;
            loc3[1] = _myUnitSettings.distanceUnit != "kilometer" ? 1 : 0;
            loc3[2] = _myUnitSettings.altitudeUnit != "meter" ? 1 : 0;
            loc3[3] = _myUnitSettings.temperatureUnit != "celsius" ? 1 : 0;
            loc3[4] = _myUnitSettings.weightUnit != "kg" ? 1 : 0;
            loc6.outputFormat = _myUnitSettings.weightUnit;
            loc3[5] = _myUnitSettings.dateFormat != "eu" ? 1 : 0;
            loc3[6] = _myUnitSettings.clockMode != "24" ? 1 : 0;
            var loc12:*=_myUnitSettings.language;
            while ("en" === loc12) 
            {
                loc3[7] = 0;
            }
        }

        public function encodeSettings():Array
        {
            var loc6:*;
            (loc6 = new utils.converter.WeightConverter()).inputFormat = "g";
            var loc4:*;
            (loc4 = new utils.converter.SizeConverter()).inputFormat = "centimeter";
            var loc3:*=new Array(236);
            var loc9:*=0;
            loc9 = 0;
            while (loc9 < loc3.length) 
            {
                loc3[loc9] = 0;
                ++loc9;
            }
            loc3[0] = _myUnitSettings.speedUnit != "kmh" ? 1 : 0;
            loc3[1] = _myUnitSettings.distanceUnit != "kilometer" ? 1 : 0;
            loc3[2] = _myUnitSettings.altitudeUnit != "meter" ? 1 : 0;
            loc3[3] = _myUnitSettings.temperatureUnit != "celsius" ? 1 : 0;
            loc3[4] = _myUnitSettings.weightUnit != "kg" ? 1 : 0;
            loc6.outputFormat = _myUnitSettings.weightUnit;
            loc3[5] = _myUnitSettings.dateFormat != "eu" ? 1 : 0;
            loc3[6] = _myUnitSettings.clockMode != "24" ? 1 : 0;
            var loc12:*=_myUnitSettings.language;
            while ("en" === loc12) 
            {
                loc3[7] = 0;
            }
        }

        public function decodeSettings(arg1:Object):core.settings.Settings
        {
            var loc2:*=NaN;
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc14:*=NaN;
            var loc11:*=NaN;
            var loc15:*=NaN;
            var loc17:*;
            (loc17 = new utils.converter.WeightConverter()).outputFormat = "g";
            var loc5:*;
            (loc5 = new utils.converter.SizeConverter()).outputFormat = "centimeter";
            var loc4:*=arg1 as Array;
            _myUnitSettings = new core.settings.SettingsROX100();
            _myUnitSettings.unitType = _myUnit.type;
            _myUnitSettings.unit = _myUnit;
            _myUnitSettings.date = new Date();
            _myUnitSettings.speedUnit = loc4[3] != 0 ? "mph" : "kmh";
            _myUnitSettings.distanceUnit = loc4[4] != 0 ? "mile" : "kilometer";
            _myUnitSettings.altitudeUnit = loc4[5] != 0 ? "feet" : "meter";
            _myUnitSettings.temperatureUnit = loc4[6] != 0 ? "fahrenheit" : "celsius";
            _myUnitSettings.weightUnit = loc4[7] != 0 ? "lb" : "kg";
            loc17.inputFormat = _myUnitSettings.weightUnit;
            _myUnitSettings.dateFormat = loc4[8] != 0 ? "us" : "eu";
            _myUnitSettings.clockMode = loc4[9] != 0 ? "12" : "24";
            var loc18:*=loc4[10];
            while (0 === loc18) 
            {
                _myUnitSettings.language = "en";
            }
        }

        public function decodeSettings1403271(arg1:Object):core.settings.Settings
        {
            var loc2:*=NaN;
            var loc1:*=NaN;
            var loc5:*=NaN;
            var loc14:*=NaN;
            var loc17:*=NaN;
            var loc16:*=NaN;
            var loc11:*=NaN;
            var loc4:*=NaN;
            var loc22:*=NaN;
            var loc18:*=NaN;
            var loc15:*=NaN;
            var loc19:*=NaN;
            var loc21:*;
            (loc21 = new utils.converter.WeightConverter()).outputFormat = "g";
            var loc7:*;
            (loc7 = new utils.converter.SizeConverter()).outputFormat = "centimeter";
            var loc6:*=arg1 as Array;
            var loc3:*=3;
            _myUnitSettings = new core.settings.SettingsROX100();
            _myUnitSettings.unitType = _myUnit.type;
            _myUnitSettings.unit = _myUnit;
            _myUnitSettings.date = new Date();
            _myUnitSettings.speedUnit = loc6[loc3 + 0] != 0 ? "mph" : "kmh";
            _myUnitSettings.distanceUnit = loc6[loc3 + 1] != 0 ? "mile" : "kilometer";
            _myUnitSettings.altitudeUnit = loc6[loc3 + 2] != 0 ? "feet" : "meter";
            _myUnitSettings.temperatureUnit = loc6[loc3 + 3] != 0 ? "fahrenheit" : "celsius";
            _myUnitSettings.weightUnit = loc6[loc3 + 4] != 0 ? "lb" : "kg";
            loc21.inputFormat = _myUnitSettings.weightUnit;
            _myUnitSettings.dateFormat = loc6[loc3 + 5] != 0 ? "us" : "eu";
            _myUnitSettings.clockMode = loc6[loc3 + 6] != 0 ? "12" : "24";
            var loc23:*=loc6[loc3 + 7];
            while (0 === loc23) 
            {
                _myUnitSettings.language = "en";
            }
        }

        public function decodeLogStatus(arg1:Object):core.units.Unit
        {
            var loc4:*=arg1 as Array;
            var loc5:*=1.37;
            var loc9:*=loc4[3] / 100;
            (_myUnit as core.units.interfaces.ILogStatus).maxPackages = loc5 * 1024;
            (_myUnit as core.units.interfaces.ILogStatus).freePackages = loc9 * 1024;
            var loc1:*=(loc4[6] << 8 | loc4[5]) * 3600 + loc4[7] * 60 + loc4[8];
            var loc6:*=(loc4[10] << 8 | loc4[9]) * 3600 + loc4[11] * 60 + loc4[12];
            var loc7:*=(loc4[14] << 8 | loc4[13]) * 3600 + loc4[15] * 60 + loc4[16];
            var loc3:*=(loc4[18] << 8 | loc4[17]) * 3600 + loc4[19] * 60 + loc4[20];
            var loc2:*=(loc4[22] << 8 | loc4[21]) * 3600 + loc4[23] * 60 + loc4[24];
            var loc8:*=(loc4[26] << 8 | loc4[25]) * 3600 + loc4[27] * 60 + loc4[28];
            (_myUnit as core.units.interfaces.ILogTime1Sec).logTime1Sec = loc1;
            (_myUnit as core.units.interfaces.ILogTime2Sec).logTime2Sec = loc6;
            (_myUnit as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc7;
            (_myUnit as core.units.interfaces.ILogTime10Sec).logTime10Sec = loc3;
            (_myUnit as core.units.interfaces.ILogTime20Sec).logTime20Sec = loc2;
            (_myUnit as core.units.interfaces.ILogTime30Sec).logTime30Sec = loc8;
            if (!decoder.Rox100Decoder.isValidCheckSum(loc4)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 516, "ROX100Decoder > decodeLogStatus: wrong crc"));
            }
            return _myUnit;
        }

        public function decodeLogHeader(arg1:Object, arg2:uint):core.activities.Activity
        {
            var loc5:*=NaN;
            var loc1:*=arg1 as Array;
            var loc3:*=new utils.converter.SpeedConverter("kmh", "ms");
            var loc4:*=new utils.converter.WeightConverter(loc1[113] > 128 ? "lb" : "kg", "g");
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createActivityFromUnitType(_myUnit.type, "log")).unit = _myUnit;
            loc2.serialNumber = _myUnit.serialNumber;
            loc2.statistic = true;
            loc2.pageHeaderData = loc1;
            loc2.startDate = new Date(2000 + loc1[0], (loc1[1] - 1), loc1[2], loc1[3], loc1[4], loc1[5]);
            loc2.dateCode = loc2.startDate.toString();
            loc5 = (loc5 = loc1[6]) | loc1[7] << 8;
            loc2.lapCount = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[8]) | loc1[9] << 8) | loc1[10] << 16) | loc1[11] << 24;
            loc2.exerciseTime = loc5 * 10;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[12]) | loc1[13] << 8) | loc1[14] << 16) | loc1[15] << 24;
            loc2.trainingTime = loc5 * 10;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[16]) | loc1[17] << 8) | loc1[18] << 16) | loc1[19] << 24;
            loc2.distance = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[20]) | loc1[21] << 8) | loc1[22] << 16) | loc1[23] << 24;
            loc2.calories = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[24]) | loc1[25] << 8) | loc1[26] << 16) | loc1[27] << 24) / 10;
            loc2.maximumSpeed = loc3.convert(loc5);
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[28]) | loc1[29] << 8) | loc1[30] << 16) | loc1[31] << 24) / 10;
            loc2.averageSpeed = loc3.convert(loc5);
            loc5 = (loc5 = (loc5 = (loc5 = loc1[32]) | loc1[33] << 8) | loc1[34] << 16) | loc1[35] << 24;
            loc2.wheelSize = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[36]) | loc1[37] << 8) | loc1[38] << 16) | loc1[39] << 24) / 1000000;
            loc2.latitudeStart = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[40]) | loc1[41] << 8) | loc1[42] << 16) | loc1[43] << 24) / 1000000;
            loc2.longitudeStart = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[44]) | loc1[45] << 8) | loc1[46] << 16) | loc1[47] << 24) / 1000000;
            loc2.latitudeEnd = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = (loc5 = loc1[48]) | loc1[49] << 8) | loc1[50] << 16) | loc1[51] << 24) / 1000000;
            loc2.longitudeEnd = loc5;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[52]) | loc1[53] << 8) | loc1[54] << 16) | loc1[55] << 24;
            loc2.altitudeDifferencesUphill = loc5 * 1000;
            loc5 = (loc5 = (loc5 = (loc5 = loc1[56]) | loc1[57] << 8) | loc1[58] << 16) | loc1[59] << 24;
            loc2.distanceDownhill = loc5;
            loc5 = (loc5 = (loc5 = loc1[60]) | loc1[61] << 8) | loc1[62] << 16;
            loc2.maxSpeedEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[63]) | loc1[64] << 8) | loc1[65] << 16;
            loc2.maxHeartrateEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[66]) | loc1[67] << 8) | loc1[68] << 16;
            loc2.maxInclineUphillEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[69]) | loc1[70] << 8) | loc1[71] << 16;
            loc2.maxInclineDownhillEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[72]) | loc1[73] << 8) | loc1[74] << 16;
            loc2.maxAltitudeEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[75]) | loc1[76] << 8) | loc1[77] << 16;
            loc2.maxCadenceEntry = loc5;
            loc5 = (loc5 = (loc5 = loc1[78]) | loc1[79] << 8) | loc1[80] << 16;
            loc2.maxPowerEntry = loc5;
            loc2.maximumHeartrate = loc1[81];
            loc2.lowerLimit = loc1[82];
            loc2.upperLimit = loc1[122];
            loc2.averageHeartrate = loc1[83];
            loc2.intensityZone1Start = loc1[84];
            loc2.intensityZone2Start = loc1[88];
            loc2.intensityZone3Start = loc1[89];
            loc2.intensityZone4Start = loc1[90];
            loc2.intensityZone4End = loc1[91];
            loc5 = (loc5 = loc1[96]) | loc1[97] << 8;
            loc2.maximumInclineUphill = loc5;
            loc5 = (loc5 = (loc5 = loc1[98]) | loc1[99] << 8) - 65536;
            loc2.maximumInclineDownhill = loc5;
            loc5 = (loc5 = loc1[100]) | loc1[101] << 8;
            loc2.maximumAltitude = loc5;
            loc5 = (loc5 = loc1[102]) | loc1[103] << 8;
            loc2.averageCadence = loc5;
            loc5 = (loc5 = loc1[104]) | loc1[105] << 8;
            loc2.maximumCadence = loc5;
            loc5 = (loc5 = loc1[106]) | loc1[107] << 8;
            loc2.averagePower = loc5;
            loc5 = (loc5 = loc1[108]) | loc1[109] << 8;
            loc2.maximumPower = loc5;
            loc5 = (loc5 = loc1[110]) | loc1[111] << 8;
            loc2.age = loc5;
            var loc7:*=0;
            var loc6:*=0;
            loc7 = loc5 = (loc5 = loc1[112]) | (loc1[113] & 127) << 8;
            loc2.bodyWeight = loc4.convert(loc7);
            loc2.bodyWeightUnit = "g";
            loc5 = (loc5 = loc1[114]) | loc1[115] << 8;
            loc2.entryCount = loc5;
            loc5 = (loc5 = loc1[116]) | loc1[117] << 8;
            loc2.pauseCount = loc5;
            loc5 = (loc5 = loc1[118]) | loc1[119] << 8;
            loc2.startIndex = loc5;
            loc5 = (loc5 = loc1[120]) | loc1[121] << 8;
            loc2.endIndex = loc5;
            loc2.gender = loc1[123] != 0 ? "male" : "female";
            var loc8:*=loc1[124];
            while (0 === loc8) 
            {
                loc2.bike = "bike1";
            }
        }

        public function decodeLog(arg1:core.activities.Activity):void
        {
            var loc9:*=null;
            var loc4:*=null;
            var loc8:*=null;
            var loc10:*=null;
            var loc6:*=null;
            var loc2:*=null;
            var loc14:*=null;
            var loc1:*=null;
            var loc12:*=null;
            _speedConverter = new utils.converter.SpeedConverter("kmh", "ms");
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc11:*=arg1.startDate.getTime() / 1000;
            while (arg1.recordValuesLoaded.length > 0) 
            {
                loc9 = arg1.recordValuesLoaded.splice(0, 32);
                loc4 = decodeLogEntry(loc9, arg1);
                arg1.entries.push(loc4);
            }
            while (arg1.loggingPauseValuesLoaded.length > 0) 
            {
                loc8 = arg1.loggingPauseValuesLoaded.splice(0, 48);
                loc6 = decodePause(loc8, arg1);
                if (loc8[11] == 0) 
                {
                    loc10 = loc6;
                    continue;
                }
                if (loc10 == null) 
                {
                    continue;
                }
                arg1.pauseTime = arg1.pauseTime + loc6.pauseTime;
                loc2 = arg1.entries[(loc10.pauseIndex - 1)];
                loc2.isPause = true;
                loc2.pauseTime = loc6.pauseTime;
                loc10 = null;
            }
            var loc13:*=core.activities.ActivityFactory.createLogEntryFromLog(arg1);
            if (arg1.entries.length > 0) 
            {
                loc14 = arg1.entries[0];
                loc13.heartrate = loc14.heartrate;
                loc13.percentHRMax = loc14.percentHRMax;
                loc13.speed = loc14.speed;
                loc13.speedReference = loc14.speedReference;
                loc13.speedTime = loc14.speedTime;
                loc13.altitude = loc14.altitude;
                loc13.temperature = loc14.temperature;
                loc13.incline = loc14.incline;
                loc13.cadence = loc14.cadence;
                loc13.power = loc14.power;
                loc13.powerPerKG = loc14.powerPerKG;
                loc13.intensityZone = loc14.intensityZone;
                loc13.targetZone = loc14.targetZone;
                loc13.latitude = loc14.latitude;
                loc13.longitude = loc14.longitude;
            }
            arg1.entries.unshift(loc13);
            smoothEntries(arg1);
            var loc3:*=arg1.calories;
            handler.ActivityCalculator.calculateMinMaxAvgValues(arg1);
            var loc7:*=arg1.recalculatedValues.calories;
            utils.Calculations.calculateCaloriesDifferenceFactor(arg1, loc3, loc7);
            var loc5:*=0;
            loc5 = 0;
            while (loc5 < arg1.entries.length) 
            {
                arg1.entries[loc5].calories = arg1.entries[loc5].calories - arg1.entries[loc5].calories * arg1.caloriesDifferenceFactor;
                ++loc5;
            }
            handler.ActivityCalculator.calculateMarkerValuesByEntries(arg1);
            while (arg1.lapValuesLoaded.length > 0) 
            {
                loc1 = arg1.lapValuesLoaded.splice(0, 68);
                (loc12 = decodeLap(loc1, arg1)).logReference = arg1;
                arg1.markerList.push(loc12);
            }
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
            while (arg1.routePointsLoaded.length > 0) 
            {
                loc1 = arg1.routePointsLoaded.splice(0, 12);
                loc3 = decodeTrackPoint(loc1);
                ++loc2;
                arg1.routePoints.push(loc3);
            }
            core.route.Route.setImportedRouteStartPoints(arg1);
            return;
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
            loc3[66] = loc10 & 255;
            loc3[67] = loc10 >> 8 & 255;
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

        public function encodeWayPoint(arg1:core.route.RoutePoi):Array
        {
            var loc4:*=NaN;
            var loc3:*=0;
            var loc1:*=new Array(16);
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc1[loc3] = 0;
                ++loc3;
            }
            var loc2:*=arg1.name.length;
            loc3 = 0;
            while (loc3 <= 11) 
            {
                if (loc3 < loc2) 
                {
                    loc1[loc3] = arg1.name.charCodeAt(loc3);
                }
                ++loc3;
            }
            loc1[12] = arg1.wayTTPId_curId;
            loc1[13] = (arg1.waypointPointNumber - 100) / 123 + arg1.wayTTPId_curId;
            loc4 = (arg1.waypointPointNumber - 100) % 123;
            loc1[14] = loc4 & 255;
            loc1[15] = loc4 >> 8 & 255;
            return loc1;
        }

        public function decodeTotals(arg1:Object):core.totals.Totals
        {
            var loc1:*=arg1 as Array;
            _myUnitTotals = new core.totals.TotalsROX100();
            _myUnitTotals.unitType = _myUnit.type;
            _myUnitTotals.unit = _myUnit;
            var loc2:*=0;
            loc2 = loc1[3];
            loc2 = loc2 | loc1[4] << 8;
            loc2 = loc2 | loc1[5] << 16;
            loc2 = loc2 | loc1[6] << 24;
            _myUnitTotals.totalDistance1 = loc2;
            loc2 = loc1[7];
            loc2 = loc2 | loc1[8] << 8;
            loc2 = loc2 | loc1[9] << 16;
            loc2 = loc2 | loc1[10] << 24;
            _myUnitTotals.totalTrainingTime1 = loc2 / 10 * 100;
            loc2 = loc1[11];
            loc2 = loc2 | loc1[12] << 8;
            loc2 = loc2 | loc1[13] << 16;
            loc2 = loc2 | loc1[14] << 24;
            _myUnitTotals.totalCal1 = loc2;
            loc2 = loc1[15];
            loc2 = loc2 | loc1[16] << 8;
            loc2 = loc2 | loc1[17] << 16;
            loc2 = loc2 | loc1[18] << 24;
            _myUnitTotals.totalClimbMeter1 = loc2 * 1000;
            loc2 = loc1[19];
            loc2 = loc2 | loc1[20] << 8;
            loc2 = loc2 | loc1[21] << 16;
            loc2 = loc2 | loc1[22] << 24;
            _myUnitTotals.maxAltitude1 = loc2 * 1000;
            loc2 = loc1[23];
            loc2 = loc2 | loc1[24] << 8;
            loc2 = loc2 | loc1[25] << 16;
            loc2 = loc2 | loc1[26] << 24;
            _myUnitTotals.totalTripDistUp1 = loc2;
            loc2 = loc1[27];
            loc2 = loc2 | loc1[28] << 8;
            loc2 = loc2 | loc1[29] << 16;
            loc2 = loc2 | loc1[30] << 24;
            _myUnitTotals.totalTimeUp1 = loc2 * 100;
            loc2 = loc1[31];
            loc2 = loc2 | loc1[32] << 8;
            loc2 = loc2 | loc1[33] << 16;
            loc2 = loc2 | loc1[34] << 24;
            if (loc2 < 0) 
            {
                loc2 = loc2 * -1;
            }
            _myUnitTotals.totalDescent1 = loc2 * 1000;
            loc2 = loc1[35];
            loc2 = loc2 | loc1[36] << 8;
            loc2 = loc2 | loc1[37] << 16;
            loc2 = loc2 | loc1[38] << 24;
            _myUnitTotals.totalTripDistDown1 = loc2;
            loc2 = loc1[39];
            loc2 = loc2 | loc1[40] << 8;
            loc2 = loc2 | loc1[41] << 16;
            loc2 = loc2 | loc1[42] << 24;
            _myUnitTotals.totalTimeDown1 = loc2 * 100;
            loc2 = loc1[43];
            loc2 = loc2 | loc1[44] << 8;
            loc2 = loc2 | loc1[45] << 16;
            loc2 = loc2 | loc1[46] << 24;
            _myUnitTotals.totalDistance2 = loc2;
            loc2 = loc1[47];
            loc2 = loc2 | loc1[48] << 8;
            loc2 = loc2 | loc1[49] << 16;
            loc2 = loc2 | loc1[50] << 24;
            _myUnitTotals.totalTrainingTime2 = loc2 / 10 * 100;
            loc2 = loc1[51];
            loc2 = loc2 | loc1[52] << 8;
            loc2 = loc2 | loc1[53] << 16;
            loc2 = loc2 | loc1[54] << 24;
            _myUnitTotals.totalCal2 = loc2;
            loc2 = loc1[55];
            loc2 = loc2 | loc1[56] << 8;
            loc2 = loc2 | loc1[57] << 16;
            loc2 = loc2 | loc1[58] << 24;
            _myUnitTotals.totalClimbMeter2 = loc2 * 1000;
            loc2 = loc1[59];
            loc2 = loc2 | loc1[60] << 8;
            loc2 = loc2 | loc1[61] << 16;
            loc2 = loc2 | loc1[62] << 24;
            _myUnitTotals.maxAltitude2 = loc2 * 1000;
            loc2 = loc1[63];
            loc2 = loc2 | loc1[64] << 8;
            loc2 = loc2 | loc1[65] << 16;
            loc2 = loc2 | loc1[66] << 24;
            _myUnitTotals.totalTripDistUp2 = loc2;
            loc2 = loc1[67];
            loc2 = loc2 | loc1[68] << 8;
            loc2 = loc2 | loc1[69] << 16;
            loc2 = loc2 | loc1[70] << 24;
            _myUnitTotals.totalTimeUp2 = loc2 * 100;
            loc2 = loc1[71];
            loc2 = loc2 | loc1[72] << 8;
            loc2 = loc2 | loc1[73] << 16;
            loc2 = loc2 | loc1[74] << 24;
            if (loc2 < 0) 
            {
                loc2 = loc2 * -1;
            }
            _myUnitTotals.totalDescent2 = loc2 * 1000;
            loc2 = loc1[75];
            loc2 = loc2 | loc1[76] << 8;
            loc2 = loc2 | loc1[77] << 16;
            loc2 = loc2 | loc1[78] << 24;
            _myUnitTotals.totalTripDistDown2 = loc2;
            loc2 = loc1[79];
            loc2 = loc2 | loc1[80] << 8;
            loc2 = loc2 | loc1[81] << 16;
            loc2 = loc2 | loc1[82] << 24;
            _myUnitTotals.totalTimeDown2 = loc2 * 100;
            loc2 = loc1[83];
            loc2 = loc2 | loc1[84] << 8;
            loc2 = loc2 | loc1[85] << 16;
            loc2 = loc2 | loc1[86] << 24;
            _myUnitTotals.totalDistance3 = loc2;
            loc2 = loc1[87];
            loc2 = loc2 | loc1[88] << 8;
            loc2 = loc2 | loc1[89] << 16;
            loc2 = loc2 | loc1[90] << 24;
            _myUnitTotals.totalTrainingTime3 = loc2 / 10 * 100;
            loc2 = loc1[91];
            loc2 = loc2 | loc1[92] << 8;
            loc2 = loc2 | loc1[93] << 16;
            loc2 = loc2 | loc1[94] << 24;
            _myUnitTotals.totalCal3 = loc2;
            loc2 = loc1[95];
            loc2 = loc2 | loc1[96] << 8;
            loc2 = loc2 | loc1[97] << 16;
            loc2 = loc2 | loc1[98] << 24;
            _myUnitTotals.totalClimbMeter3 = loc2 * 1000;
            loc2 = loc1[99];
            loc2 = loc2 | loc1[100] << 8;
            loc2 = loc2 | loc1[101] << 16;
            loc2 = loc2 | loc1[102] << 24;
            _myUnitTotals.maxAltitude3 = loc2 * 1000;
            loc2 = loc1[103];
            loc2 = loc2 | loc1[104] << 8;
            loc2 = loc2 | loc1[105] << 16;
            loc2 = loc2 | loc1[106] << 24;
            _myUnitTotals.totalTripDistUp3 = loc2;
            loc2 = loc1[107];
            loc2 = loc2 | loc1[108] << 8;
            loc2 = loc2 | loc1[109] << 16;
            loc2 = loc2 | loc1[110] << 24;
            _myUnitTotals.totalTimeUp3 = loc2 * 100;
            loc2 = loc1[111];
            loc2 = loc2 | loc1[112] << 8;
            loc2 = loc2 | loc1[113] << 16;
            loc2 = loc2 | loc1[114] << 24;
            if (loc2 < 0) 
            {
                loc2 = loc2 * -1;
            }
            _myUnitTotals.totalDescent3 = loc2 * 1000;
            loc2 = loc1[115];
            loc2 = loc2 | loc1[116] << 8;
            loc2 = loc2 | loc1[117] << 16;
            loc2 = loc2 | loc1[118] << 24;
            _myUnitTotals.totalTripDistDown3 = loc2;
            loc2 = loc1[119];
            loc2 = loc2 | loc1[120] << 8;
            loc2 = loc2 | loc1[121] << 16;
            loc2 = loc2 | loc1[122] << 24;
            _myUnitTotals.totalTimeDown3 = loc2 * 100;
            if (!decoder.Rox100Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 514, "ROX100Decoder > decodeTotals: wrong crc"));
            }
            return _myUnitTotals;
        }

        internal function decodePause(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc8:*;
            (loc8 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = true;
            var loc6:*=0;
            loc6 = (loc6 = (loc6 = (loc6 = (loc6 = arg1[0]) | arg1[1] << 8) | arg1[2] << 16) | arg1[3] << 24) / 1000000;
            loc8.latitude = loc6;
            loc6 = (loc6 = (loc6 = (loc6 = (loc6 = arg1[4]) | arg1[5] << 8) | arg1[6] << 16) | arg1[7] << 24) / 1000000;
            loc8.longitude = loc6;
            var loc12:*=2000 + arg1[8];
            var loc4:*=arg1[9];
            var loc5:*=arg1[10];
            var loc15:*=arg1[14];
            var loc2:*=arg1[15];
            var loc10:*=arg1[16];
            var loc7:*=new Date(loc12, (loc4 - 1), loc5, loc15, loc2, loc10);
            var loc9:*=2000 + arg1[11];
            var loc1:*=arg1[12];
            var loc13:*=arg1[13];
            var loc14:*=arg1[17];
            var loc11:*=arg1[18];
            var loc16:*=arg1[19];
            var loc17:*;
            var loc3:*=((loc17 = new Date(loc9, (loc1 - 1), loc13, loc14, loc11, loc16)).getTime() - loc7.getTime()) * 0.1;
            loc8.pauseTime = loc3;
            loc6 = (loc6 = (loc6 = (loc6 = (loc6 = arg1[20]) | arg1[21] << 8) | arg1[22] << 16) | arg1[23] << 24) / 100;
            loc8.distance = loc6;
            loc6 = (loc6 = (loc6 = (loc6 = (loc6 = arg1[24]) | arg1[25] << 8) | arg1[26] << 16) | arg1[27] << 24) / 100;
            loc8.speed = _speedConverter.convert(loc6);
            if (loc8.speed > 0) 
            {
                loc8.speedTime = Math.floor(1000 / loc8.speed);
            }
            else 
            {
                loc8.speedTime = 1200;
            }
            loc6 = (loc6 = (loc6 = (loc6 = arg1[28]) | arg1[29] << 8) | arg1[30] << 16) | arg1[31] << 24;
            loc8.pauseIndex = loc6;
            loc6 = (loc6 = (loc6 = (loc6 = (loc6 = arg1[32]) | arg1[33] << 8) | arg1[34] << 16) | arg1[35] << 24) * 10;
            loc8.trainingTime = loc6;
            if ((loc6 = (loc6 = arg1[36]) | arg1[37] << 8) > 50000) 
            {
                loc6 = loc6 - 65536;
            }
            loc8.altitude = loc6 * 1000;
            loc6 = (loc6 = arg1[38]) | arg1[39] << 8;
            loc8.power = loc6;
            loc6 = (loc6 = arg1[40]) | arg1[41] << 8;
            if (arg1[41] >> 7 == 1) 
            {
                loc6 = loc6 - 65536;
            }
            loc6 = loc6 / 10;
            loc8.temperature = loc6;
            var loc18:*=loc6 = arg1[42];
            while (0 === loc18) 
            {
                loc8.speedReference = "sensor";
            }
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
            if (arg1.waypointIndex == 0) 
            {
            };
            return loc1;
        }

        public static function calculateCheckSum(arg1:Array, arg2:int, arg3:int, arg4:int):int
        {
            var loc2:*=0;
            loc2 = loc2 ^ arg4;
            loc2 = loc2 ^ arg3;
            loc2 = loc2 ^ arg2;
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

        public static function getInstance():decoder.Rox100Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox100Decoder();
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

        public static const PAUSE_VALUES_SIZE:int=48;

        public static const RECORD_VALUES_SIZE:int=32;

        public static const TRACK_HEADER_SIZE:int=280;

        public static const WAY_POINT_SIZE:int=16;

        public static const ENCODED_DATA_SPLITTER:String=".";

        public static const LAP_VALUES_SIZE:int=68;

        public static const TRACK_POINTS_SIZE:int=12;

        internal var _myUnitTotals:core.totals.TotalsROX100;

        internal var _myUnit:core.units.UnitROX100;

        internal var distanceForamtter:utils.interfaces.ICustomFormatter;

        internal var _myUnitSettings:core.settings.SettingsROX100;

        internal var distanceConverter:utils.converter.DistanceConverter;

        internal static var _instance:decoder.Rox100Decoder;

        internal var altitudeFormater:utils.interfaces.ICustomFormatter;

        internal var altitudeConverter:utils.converter.AltitudeConverter;

        internal var _speedConverter:utils.converter.SpeedConverter;
    }
}


//  class Rox110Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.hurlant.util.*;
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.marker.*;
    import core.notification.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
    import core.totals.*;
    import core.training.*;
    import core.training.type.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.utils.*;
    import utils.converter.*;
    
    public class Rox110Decoder extends decoder.Rox70Decoder
    {
        public function Rox110Decoder()
        {
            super();
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

        public override function set settings(arg1:core.settings.Settings):void
        {
            if (arg1 is core.settings.SettingsROX110) 
            {
                _myUnitSettings = arg1 as core.settings.SettingsROX110;
            }
            return;
        }

        public override function get totals():core.totals.Totals
        {
            return _myUnitTotals;
        }

        public override function set totals(arg1:core.totals.Totals):void
        {
            if (arg1 is core.totals.TotalsROX110) 
            {
                _myUnitTotals = arg1 as core.totals.TotalsROX110;
            }
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            if (arg1 is core.units.UnitROX110) 
            {
                _myUnit = arg1 as core.units.UnitROX110;
            }
            return;
        }

        public function encodeNotification():Array
        {
            var loc8:*=0;
            var loc13:*=NaN;
            var loc15:*=_myUnit.notificationEvent;
            var loc6:*=[];
            var loc7:*=0;
            ++loc7;
            if (loc15.category != "msg") 
            {
                if (loc15.category != "email") 
                {
                    if (loc15.category != "call") 
                    {
                        loc6[loc7] = 4;
                    }
                    else 
                    {
                        loc6[loc7] = 1;
                    }
                }
                else 
                {
                    loc6[loc7] = 6;
                }
            }
            else 
            {
                loc6[loc7] = 4;
            }
            ++loc7;
            loc6[loc7] = 0;
            ++loc7;
            loc6[loc7] = 0;
            ++loc7;
            loc6[loc7] = 0;
            var loc10:*=loc15.title;
            loc8 = 0;
            while (loc8 < 32) 
            {
                if (loc8 < loc10.length) 
                {
                    loc13 = loc10.charCodeAt(loc8);
                    loc6[loc7] = isNaN(loc13) ? 0 : loc13;
                }
                else 
                {
                    loc6[loc7] = 0;
                }
                ++loc7;
                ++loc8;
            }
            var loc14:*=loc15.tickerText.toString();
            loc8 = 0;
            while (loc8 < 32) 
            {
                if (loc8 < loc14.length) 
                {
                    loc13 = loc14.charCodeAt(loc8);
                    loc6[loc7] = isNaN(loc13) ? 0 : loc13;
                }
                else 
                {
                    loc6[loc7] = 0;
                }
                ++loc7;
                ++loc8;
            }
            var loc9:*=loc15.text;
            loc8 = 0;
            while (loc8 < 32) 
            {
                if (loc8 < loc9.length) 
                {
                    loc13 = loc9.charCodeAt(loc8);
                    loc6[loc7] = isNaN(loc13) ? 0 : loc13;
                }
                else 
                {
                    loc6[loc7] = 0;
                }
                ++loc7;
                ++loc8;
            }
            var loc11:*;
            var loc16:*=(loc11 = new Date()).fullYear.toString();
            var loc1:*=loc11.month + 1 < 10 ? "0" + (loc11.month + 1) : (loc11.month + 1).toString();
            var loc2:*=loc11.date < 10 ? "0" + loc11.date : loc11.date.toString();
            var loc3:*=loc11.hours < 10 ? "0" + loc11.hours : loc11.hours.toString();
            var loc12:*=loc11.minutes < 10 ? "0" + loc11.minutes : loc11.minutes.toString();
            var loc4:*=loc11.seconds < 10 ? "0" + loc11.seconds : loc11.seconds.toString();
            var loc5:*=loc16 + loc1 + loc2 + "T" + loc3 + loc12 + loc4;
            loc8 = 0;
            while (loc8 < 32) 
            {
                if (loc8 < loc5.length) 
                {
                    loc13 = loc5.charCodeAt(loc8);
                    loc6[loc7] = isNaN(loc13) ? 0 : loc13;
                }
                else 
                {
                    loc6[loc7] = 0;
                }
                ++loc7;
                ++loc8;
            }
            ++loc7;
            loc6[loc7] = loc9.length & 255;
            ++loc7;
            loc6[loc7] = loc9.length >> 8 & 255;
            ++loc7;
            loc6[loc7] = loc9.length >> 16 & 255;
            ++loc7;
            loc6[loc7] = loc9.length >> 24 & 255;
            ++loc7;
            loc6[loc7] = 0;
            ++loc7;
            loc6[loc7] = 0;
            ++loc7;
            loc6[loc7] = 0;
            ++loc7;
            loc6[loc7] = 0;
            return loc6;
        }

        protected override function decodeLap(arg1:Array, arg2:core.activities.Activity):core.marker.Marker
        {
            var loc1:*=super.decodeLap(arg1, arg2);
            loc1.averagePower = arg1[57] << 8 | arg1[56];
            loc1.maximumPower = arg1[59] << 8 | arg1[58];
            loc1.normalizedPower = arg1[61] << 8 | arg1[60];
            loc1.averageCadence = arg1[63] << 8 | arg1[62];
            loc1.maximumCadence = arg1[65] << 8 | arg1[64];
            loc1.averageBalance = arg1[66];
            loc1.minimumHeartrate = arg1[67];
            loc1.averageHeartrate = arg1[68];
            loc1.maximumHeartrate = arg1[69];
            loc1.pedalingTime = (arg1[75] << 24 || arg1[74] << 16 || arg1[73] << 8 || arg1[72]) * 10;
            loc1.leftTorqueEffectivity = arg1[76];
            loc1.rightTorqueEffectivity = arg1[77];
            loc1.leftPedalingSmoothness = arg1[78];
            loc1.rightPedalingSmoothness = arg1[79];
            return loc1;
        }

        public static function getInstance():decoder.Rox110Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox110Decoder();
            }
            return _instance;
        }

        public override function decodeLogStatus(arg1:Object):core.units.Unit
        {
            var loc1:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 524, "ROX70Decoder > decodeLogStatus: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            var loc2:*=1367;
            var loc3:*=loc1[3] << 24 | loc1[2] << 16 | loc1[1] << 8 | loc1[0];
            (_myUnit as core.units.interfaces.ILogStatus).maxPackages = loc2 * 1024;
            (_myUnit as core.units.interfaces.ILogStatus).freePackages = loc3 * 1024;
            (_myUnit as core.units.interfaces.ILogTime1Sec).logTime1Sec = loc1[7] << 24 | loc1[6] << 16 | loc1[5] << 8 | loc1[4];
            (_myUnit as core.units.interfaces.ILogTime2Sec).logTime2Sec = loc1[11] << 24 | loc1[10] << 16 | loc1[9] << 8 | loc1[8];
            (_myUnit as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc1[15] << 24 | loc1[14] << 16 | loc1[13] << 8 | loc1[12];
            (_myUnit as core.units.interfaces.ILogTime10Sec).logTime10Sec = loc1[19] << 24 | loc1[18] << 16 | loc1[17] << 8 | loc1[16];
            (_myUnit as core.units.interfaces.ILogTime20Sec).logTime20Sec = loc1[23] << 24 | loc1[22] << 16 | loc1[21] << 8 | loc1[20];
            return _myUnit;
        }

        public override function decodeLogHeader(arg1:Object):core.activities.Activity
        {
            var loc2:*=core.activities.ActivityFactory.createActivityFromUnitType(_myUnit.type, "log");
            loc2.unit = _myUnit;
            loc2.serialNumber = _myUnit.serialNumber;
            loc2 = decodeCommonLogHeader(loc2, arg1);
            var loc1:*=arg1 as Array;
            loc2.hrMax = loc1[204];
            loc2.averageHeartrate = loc1[205];
            loc2.minimumHeartrate = loc1[206];
            loc2.maximumHeartrate = loc1[207];
            loc2.averageCadence = loc1[209] << 8 | loc1[208];
            loc2.maximumCadence = loc1[211] << 8 | loc1[210];
            loc2.best20minPower = loc1[213] << 8 | loc1[212];
            loc2.averagePower = loc1[215] << 8 | loc1[214];
            loc2.maximumPower = loc1[217] << 8 | loc1[216];
            loc2.powerNP = loc1[219] << 8 | loc1[218];
            loc2.powerTSS = (loc1[221] << 8 | loc1[220]) / 10;
            loc2.workInKJ = loc1[223] << 8 | loc1[222];
            loc2.averagePowerWattPerKG = (loc1[225] << 8 | loc1[224]) / 10;
            loc2.powerFTP = loc1[227] << 8 | loc1[226];
            loc2.minHeartrateEntry = loc1[231] << 24 | loc1[230] << 16 | loc1[229] << 8 | loc1[228];
            loc2.maxHeartrateEntry = loc1[235] << 24 | loc1[234] << 16 | loc1[233] << 8 | loc1[232];
            loc2.maxCadenceEntry = loc1[239] << 24 | loc1[238] << 16 | loc1[237] << 8 | loc1[236];
            loc2.pedalingTime = (loc1[243] << 24 | loc1[242] << 16 | loc1[241] << 8 | loc1[240]) * 10;
            loc2.pedalingIndex = loc2.pedalingTime * 100 / loc2.trainingTime;
            loc2.maxPowerEntry = loc1[247] << 24 | loc1[246] << 16 | loc1[245] << 8 | loc1[244];
            loc2.best20minPowerEntry = loc1[251] << 24 | loc1[250] << 16 | loc1[249] << 8 | loc1[248];
            loc2.timeUnderIntensityZone = (loc1[291] << 24 | loc1[290] << 16 | loc1[289] << 8 | loc1[288]) * 10;
            loc2.timeInIntensityZone1 = (loc1[295] << 24 | loc1[294] << 16 | loc1[293] << 8 | loc1[292]) * 10;
            loc2.timeInIntensityZone2 = (loc1[299] << 24 | loc1[298] << 16 | loc1[297] << 8 | loc1[296]) * 10;
            loc2.timeInIntensityZone3 = (loc1[303] << 24 | loc1[302] << 16 | loc1[301] << 8 | loc1[300]) * 10;
            loc2.timeInIntensityZone4 = (loc1[307] << 24 | loc1[306] << 16 | loc1[305] << 8 | loc1[304]) * 10;
            loc2.timeOverIntensityZone = (loc1[311] << 24 | loc1[310] << 16 | loc1[309] << 8 | loc1[308]) * 10;
            loc2.timeInPowerZone1 = (loc1[315] << 24 | loc1[314] << 16 | loc1[313] << 8 | loc1[312]) * 10;
            loc2.timeInPowerZone2 = (loc1[319] << 24 | loc1[318] << 16 | loc1[317] << 8 | loc1[316]) * 10;
            loc2.timeInPowerZone3 = (loc1[323] << 24 | loc1[322] << 16 | loc1[321] << 8 | loc1[320]) * 10;
            loc2.timeInPowerZone4 = (loc1[327] << 24 | loc1[326] << 16 | loc1[325] << 8 | loc1[324]) * 10;
            loc2.timeInPowerZone5 = (loc1[331] << 24 | loc1[330] << 16 | loc1[329] << 8 | loc1[328]) * 10;
            loc2.timeInPowerZone6 = (loc1[335] << 24 | loc1[334] << 16 | loc1[333] << 8 | loc1[332]) * 10;
            loc2.timeInPowerZone7 = (loc1[339] << 24 | loc1[338] << 16 | loc1[337] << 8 | loc1[336]) * 10;
            loc2.powerZone1Start = loc1[341] << 8 | loc1[340];
            loc2.powerZone2Start = loc1[343] << 8 | loc1[342];
            loc2.powerZone3Start = loc1[345] << 8 | loc1[344];
            loc2.powerZone4Start = loc1[347] << 8 | loc1[346];
            loc2.powerZone5Start = loc1[349] << 8 | loc1[348];
            loc2.powerZone6Start = loc1[351] << 8 | loc1[350];
            loc2.powerZone7Start = loc1[353] << 8 | loc1[352];
            loc2.powerZone7End = loc1[355] << 8 | loc1[354];
            loc2.intensityZone1Start = loc1[356];
            loc2.intensityZone2Start = loc1[357];
            loc2.intensityZone3Start = loc1[358];
            loc2.intensityZone4Start = loc1[359];
            loc2.intensityZone4End = loc1[360];
            loc2.averageBalanceRight = loc1[361] & 127;
            loc2.averageBalanceLeft = 100 - loc2.averageBalanceRight;
            loc2.bodyWeight = loc1[363] << 8 | loc1[362];
            loc2.bodyHeight = loc1[365] << 8 | loc1[364];
            loc2.wheelSize = loc1[367] << 8 | loc1[366];
            loc2.bikeWeight = loc1[369] << 8 | loc1[368];
            loc2.age = loc1[370];
            loc2.shoulderWidth = loc1[371];
            loc2.powerIF = (loc1[375] << 24 | loc1[374] << 16 | loc1[373] << 8 | loc1[372]) / 1000;
            loc2.torqueEffectLeft = loc1[376];
            loc2.torqueEffectRight = loc1[377];
            loc2.pedalSmoothLeft = loc1[378];
            loc2.pedalSmoothRight = loc1[379];
            loc2.phaseValuesToLoad = loc1[23] << 8 | loc1[22];
            loc2.workoutIndex = loc1[75] << 24 | loc1[74] << 16 | loc1[73] << 8 | loc1[72];
            loc2.workoutId = loc1[80];
            return loc2;
        }

        public function decodeLogProgram(arg1:core.activities.Activity, arg2:Array):core.activities.Activity
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg2)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 527, "ROX70Decoder > decodeSettings: wrong crc"));
            }
            arg2.splice(0, 3);
            arg2.pop();
            arg1.trainingReference = new core.training.TrainingReference();
            var loc3:*=0;
            var loc5:*=0;
            arg1.trainingReference.name = "";
            loc3 = 0;
            while (loc3 <= 16) 
            {
                arg1.trainingReference.name = arg1.trainingReference.name + com.hurlant.util.Hex.toString(arg2[loc3].toString(16));
                ++loc3;
            }
            var loc4:*=new flash.utils.ByteArray();
            var loc1:*="";
            loc3 = 0;
            while (loc3 < 16) 
            {
                loc4.writeByte(arg2[17 + loc3]);
                if (loc3 == 3 || loc3 == 5 || loc3 == 7 || loc3 == 9 || loc3 == 15) 
                {
                    loc1 = loc1 + com.hurlant.util.Hex.fromArray(loc4);
                    loc4.clear();
                    if (loc3 != 15) 
                    {
                        loc1 = loc1 + "-";
                    }
                }
                ++loc3;
            }
            arg1.trainingReference.trainingGUID = loc1.toUpperCase();
            var loc2:*;
            (loc2 = new flash.utils.ByteArray()).writeByte(arg2[33]);
            loc2.writeByte(arg2[34]);
            loc2.writeByte(arg2[35]);
            loc2.writeByte(arg2[36]);
            loc2.writeByte(arg2[37]);
            loc2.writeByte(arg2[38]);
            arg1.trainingReference.modificationDate = parseInt(com.hurlant.util.Hex.fromArray(loc2), 16);
            arg1.trainingReference.totalPhases = arg2[39];
            arg1.trainingReference.programId = arg2[40];
            if (arg1.trainingReference.totalPhases > 0) 
            {
                arg1.trainingReference.plannedPhases = new __AS3__.vec.Vector.<core.marker.Marker>();
                decodeLogPlanedTrainingPhase(arg1, arg2, 44);
            }
            return arg1;
        }

        public function decodePhase(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc8:*=null;
            var loc5:*=null;
            var loc7:*=NaN;
            var loc6:*=false;
            var loc4:*=arg2[65];
            var loc2:*=arg1.trainingReference.plannedPhases[(loc4 - 1)];
            var loc1:*=core.marker.Marker.copy(loc2, arg1);
            if (arg1.trainingReference.logPhases.length > 0) 
            {
                loc8 = arg1.trainingReference.logPhases[(arg1.trainingReference.logPhases.length - 1)];
            }
            loc1.logReference = arg1;
            var loc3:*=arg2[3] << 24 | arg2[2] << 16 | arg2[1] << 8 | arg2[0];
            loc1.time = (arg2[7] << 24 | arg2[6] << 16 | arg2[5] << 8 | arg2[4]) * 10;
            if (loc8) 
            {
                loc1.timeAbsolute = loc1.time + loc8.timeAbsolute;
            }
            else 
            {
                loc1.timeAbsolute = loc1.time;
            }
            loc1.distance = (arg2[11] << 24 | arg2[10] << 16 | arg2[9] << 8 | arg2[8]) / 100;
            if (loc8) 
            {
                loc1.distanceAbsolute = loc1.distance + loc8.distanceAbsolute;
            }
            else 
            {
                loc1.distanceAbsolute = loc1.distance;
            }
            var loc9:*=arg2[12];
            while (0 === loc9) 
            {
                loc1.type = "SimplePhase";
            }
        }

        internal function getNextMarkerNumber(arg1:core.activities.Activity, arg2:core.marker.Marker):int
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc2:*=0;
            var loc1:*=arg1.trainingReference.logPhases.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4 = arg1.trainingReference.logPhases[loc3];
                if ((arg2.type == "SimplePhase" || arg2.type == "IntervalPhase") && (loc4.type == "SimplePhase" || loc4.type == "IntervalPhase")) 
                {
                    loc2 = loc4.number + 1;
                }
                if (arg2.type == "Interval" && loc4.type == "Interval") 
                {
                    loc2 = loc4.number + 1;
                }
                if (arg2.type == "Recovery" && loc4.type == "Recovery") 
                {
                    loc2 = loc4.number + 1;
                }
                ++loc3;
            }
            return loc2;
        }

        internal function getIntervalPhaseMarker(arg1:core.activities.Activity, arg2:int, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc4:*=null;
            var loc3:*=0;
            var loc2:*=null;
            var loc1:*=arg1.trainingReference.logPhases.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                if ((loc2 = arg1.trainingReference.logPhases[loc3]).type == "IntervalPhase" && loc2.number == arg2) 
                {
                    loc4 = loc2;
                    break;
                }
                ++loc3;
            }
            if (!loc4) 
            {
                arg3.type = "IntervalPhase";
                arg3.number = arg2;
                loc4 = arg3;
            }
            return loc4;
        }

        internal function decodeLogPlanedTrainingPhase(arg1:core.activities.Activity, arg2:Array, arg3:*):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc7:*=null;
            var loc2:*=false;
            var loc1:*=0;
            var loc9:*=0;
            var loc8:*=NaN;
            var loc5:*=0;
            var loc6:*=0;
            while (arg1.trainingReference.plannedPhases.length < arg1.trainingReference.totalPhases) 
            {
                loc3 = 1;
                if (arg2[arg3] != 0) 
                {
                    if (arg2[arg3] == 1) 
                    {
                        (loc7 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "IntervalPhase")).type = "IntervalPhase";
                    }
                }
                else 
                {
                    (loc7 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "SimplePhase")).type = "SimplePhase";
                }
                arg3 = arg3 + loc3;
                loc3 = 17;
                loc7.title = "";
                loc4 = 0;
                while (loc4 <= 16) 
                {
                    loc7.title = loc7.title + com.hurlant.util.Hex.toString(arg2[arg3 + loc4].toString(16));
                    ++loc4;
                }
                arg3 = arg3 + loc3;
                loc3 = 1;
                loc7.intervalCount = arg2[arg3];
                loc7.intervalCountDefined = true;
                arg3 = arg3 + loc3;
                loc3 = 1;
                loc7.plannedAutoChange = (arg2[arg3] & 1) != 0 ? core.training.type.PhaseChangeMode.MANUAL : core.training.type.PhaseChangeMode.AUTOMATIC;
                loc7.plannedAutoChangeDefined = true;
                loc2 = (arg2[arg3] & 2) == 0;
                arg3 = arg3 + loc3;
                loc7.plannedLoadRecovery = loc2 ? core.training.type.PhaseLoadRecovery.LOAD : core.training.type.PhaseLoadRecovery.RECOVERY;
                loc7.plannedLoadRecoveryDefined = true;
                loc3 = 4;
                loc1 = arg2[arg3] & 15;
                loc9 = arg2[arg3] >> 4 & 15;
                loc8 = arg2[arg3] >> 8;
                arg3 = arg3 + loc3;
                loc3 = 2;
                loc5 = arg2[arg3 + 1] << 8 | arg2[arg3];
                arg3 = arg3 + loc3;
                loc3 = 2;
                loc6 = arg2[arg3 + 1] << 8 | arg2[arg3];
                arg3 = arg3 + loc3;
                if (loc1 != 1) 
                {
                    if (loc1 != 2) 
                    {
                        if (loc1 == 3) 
                        {
                            loc7.plannedPhaseControl = core.training.type.PhaseControl.DISTANCE;
                            loc7.plannedPhaseControlDefined = true;
                            loc7.plannedDistance = loc8;
                            loc7.plannedDistanceDefined = true;
                        }
                    }
                    else 
                    {
                        loc7.plannedPhaseControl = core.training.type.PhaseControl.TIME;
                        loc7.plannedPhaseControlDefined = true;
                        loc7.plannedTime = loc8;
                        loc7.plannedTimeDefined = true;
                    }
                }
                else 
                {
                    loc7.plannedPhaseControl = core.training.type.PhaseControl.PULSE;
                    loc7.plannedPhaseControlDefined = true;
                }
                if (loc9 == 2) 
                {
                    loc7.plannedUpperLimit = loc5;
                    loc7.plannedUpperLimitDefined = true;
                    loc7.plannedLowerLimit = loc6;
                    loc7.plannedLowerLimitDefined = true;
                }
                loc3 = 4;
                loc1 = arg2[arg3] & 15;
                loc9 = arg2[arg3] >> 4 & 15;
                loc8 = arg2[arg3] >> 8;
                arg3 = arg3 + loc3;
                loc3 = 2;
                loc5 = arg2[arg3 + 1] << 8 | arg2[arg3];
                arg3 = arg3 + loc3;
                loc3 = 2;
                loc6 = arg2[arg3 + 1] << 8 | arg2[arg3];
                arg3 = arg3 + loc3;
                if (loc1 != 1) 
                {
                    if (loc1 != 2) 
                    {
                        if (loc1 == 3) 
                        {
                            loc7.plannedRecoveryPhaseControl = core.training.type.PhaseControl.DISTANCE;
                            loc7.plannedRecoveryPhaseControlDefined = true;
                            loc7.plannedRecoveryDistance = loc8;
                            loc7.plannedRecoveryDistanceDefined = true;
                        }
                    }
                    else 
                    {
                        loc7.plannedRecoveryPhaseControl = core.training.type.PhaseControl.TIME;
                        loc7.plannedRecoveryPhaseControlDefined = true;
                        loc7.plannedRecoveryTime = loc8;
                        loc7.plannedRecoveryTimeDefined = true;
                    }
                }
                else 
                {
                    loc7.plannedRecoveryPhaseControl = core.training.type.PhaseControl.PULSE;
                    loc7.plannedRecoveryPhaseControlDefined = true;
                }
                if (loc9 == 2) 
                {
                    loc7.plannedRecoveryUpperLimit = loc5;
                    loc7.plannedRecoveryUpperLimitDefined = true;
                    loc7.plannedRecoveryLowerLimit = loc6;
                    loc7.plannedRecoveryLowerLimitDefined = true;
                }
                arg1.trainingReference.plannedPhases.push(loc7);
            }
            return;
        }

        public function decodeProgram(arg1:Object):core.training.Training
        {
            var loc10:*=null;
            var loc3:*=NaN;
            var loc6:*=NaN;
            var loc4:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc4)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 527, "ROX70Decoder > decodeSettings: wrong crc"));
            }
            loc4.splice(0, 3);
            loc4.pop();
            var loc5:*;
            (loc5 = new core.training.Training(unit, false)).date = new Date();
            var loc7:*=0;
            var loc9:*=0;
            loc7 = 0;
            while (loc7 <= 16) 
            {
                loc5.name = loc5.name + com.hurlant.util.Hex.toString(loc4[loc7].toString(16));
                ++loc7;
            }
            var loc8:*=new flash.utils.ByteArray();
            var loc1:*="";
            loc7 = 0;
            while (loc7 < 16) 
            {
                loc8.writeByte(loc4[17 + loc7]);
                if (loc7 == 3 || loc7 == 5 || loc7 == 7 || loc7 == 9 || loc7 == 15) 
                {
                    loc1 = loc1 + com.hurlant.util.Hex.fromArray(loc8);
                    loc8.clear();
                    if (loc7 != 15) 
                    {
                        loc1 = loc1 + "-";
                    }
                }
                ++loc7;
            }
            loc5.GUID = loc1.toUpperCase();
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeByte(loc4[33]);
            loc2.writeByte(loc4[34]);
            loc2.writeByte(loc4[35]);
            loc2.writeByte(loc4[36]);
            loc2.writeByte(loc4[37]);
            loc2.writeByte(loc4[38]);
            loc5.modificationDate = parseInt(com.hurlant.util.Hex.fromArray(loc2), 16);
            loc5.phaseCount = loc4[39];
            loc5.programIdOnDevice = loc4[40];
            var loc11:*=44;
            loc7 = 0;
            while (loc7 < loc5.phaseCount) 
            {
                (loc10 = new core.training.TrainingPhase()).training = loc5;
                loc10.type = loc4[loc11] != 0 ? core.training.type.PhaseCategory.INTERVAL : core.training.type.PhaseCategory.SIMPLE;
                ++loc11;
                loc9 = 0;
                while (loc9 <= 16) 
                {
                    loc10.titel = loc10.titel + com.hurlant.util.Hex.toString(loc4[loc11 + loc9].toString(16));
                    ++loc9;
                }
                loc11 = loc11 + 17;
                loc10.iterations = loc4[loc11];
                ++loc11;
                loc10.phaseChangeMode = (loc4[loc11] & 1) != 1 ? core.training.type.PhaseChangeMode.AUTOMATIC : core.training.type.PhaseChangeMode.MANUAL;
                loc10.loadRecovery = (loc4[loc11] >> 1 & 1) != 1 ? core.training.type.PhaseLoadRecovery.LOAD : core.training.type.PhaseLoadRecovery.RECOVERY;
                ++loc11;
            }
            loc5.recalcEstimatedValue();
            return loc5;
        }

        public function encodeProgram(arg1:core.training.Training):Array
        {
            var loc1:*=null;
            var loc4:*=NaN;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc5:*=[];
            loc9 = 0;
            while (loc9 < 404) 
            {
                loc5[loc9] = 0;
                ++loc9;
            }
            loc9 = 0;
            while (loc9 <= 16) 
            {
                if (loc9 < arg1.name.length) 
                {
                    loc11 = arg1.name.charCodeAt(loc9);
                    loc5[loc9] = isNaN(loc11) ? 0 : loc11;
                }
                ++loc9;
            }
            var loc8:*=new RegExp("-", "g");
            var loc2:*=arg1.GUID.replace(loc8, "");
            var loc12:*=loc2.split("");
            loc9 = 0;
            while (loc9 < 16) 
            {
                if (loc12[loc9 * 2] != null) 
                {
                    loc5[17 + loc9] = parseInt(loc12[loc9 * 2], 16) << 4;
                }
                if (loc12[loc9 * 2 + 1] != null) 
                {
                    var loc15:*=17 + loc9;
                    var loc16:*=loc5[loc15] | parseInt(loc12[loc9 * 2 + 1], 16);
                    loc5[loc15] = loc16;
                }
                ++loc9;
            }
            var loc3:*;
            var loc13:*=(loc3 = arg1.modificationDate.toString(16)).split("");
            while (loc13.length < 12) 
            {
                loc13.unshift("0");
            }
            loc9 = 0;
            while (loc9 < 6) 
            {
                if (loc13[loc9 * 2] != null) 
                {
                    loc5[33 + loc9] = parseInt(loc13[loc9 * 2], 16) << 4;
                }
                if (loc13[loc9 * 2 + 1] != null) 
                {
                    loc16 = 33 + loc9;
                    loc15 = loc5[loc16] | parseInt(loc13[loc9 * 2 + 1], 16);
                    loc5[loc16] = loc15;
                }
                ++loc9;
            }
            arg1.phaseCount = loc15 = arg1.phasesList.length;
            loc5[39] = loc15;
            loc5[40] = 0;
            var loc14:*=44;
            loc9 = 0;
        }

        public override function decodeSportProfile(arg1:Object):core.sportprofiles.Sportprofile
        {
            var loc4:*=null;
            var loc6:*=null;
            var loc5:*=0;
            var loc1:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc1)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 534, "ROX70Decoder > decodeSportProfile: wrong crc"));
            }
            loc1.splice(0, 3);
            loc1.pop();
            var loc3:*=new core.sportprofiles.SportProfileROX110();
            loc3 = decodeCommonSportProfile(loc3, loc1) as core.sportprofiles.SportProfileROX110;
            var loc7:*=84;
            var loc2:*=8;
            (loc4 = new core.sportprofiles.FavFunctionList()).templateId = loc1[loc7];
            loc4.active = loc1[loc7] > 0;
            loc5 = 1;
            while (loc5 <= 6) 
            {
                loc6 = new core.sportprofiles.FavFunctionlistItem(loc1[loc7 + loc5], loc5);
                loc4.changeFavFunction(loc6);
                ++loc5;
            }
            loc3.changeLapFavSet(1, loc4.toJson());
            loc7 = loc7 + loc2;
            (loc4 = new core.sportprofiles.FavFunctionList()).templateId = loc1[loc7];
            loc4.active = loc1[loc7] > 0;
            loc5 = 1;
            while (loc5 <= 6) 
            {
                loc6 = new core.sportprofiles.FavFunctionlistItem(loc1[loc7 + loc5], loc5);
                loc4.changeFavFunction(loc6);
                ++loc5;
            }
            loc3.changeAutoLapFavSet(1, loc4.toJson());
            if (loc3 is core.settings.interfaces.IGPSStatus) 
            {
                (loc3 as core.settings.interfaces.IGPSStatus).gpsStatus = (loc1[70] & 1) != 0 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                (loc3 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero = (loc1[70] & 8) >> 3 != 1 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAvgCadInclZero) 
            {
                (loc3 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero = (loc1[70] & 16) >> 4 != 1 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAlarmDistance) 
            {
                (loc3 as core.settings.interfaces.IAlarmDistance).alarmDistance = (loc1[71] & 1) != 0 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAlarmTime) 
            {
                (loc3 as core.settings.interfaces.IAlarmTime).alarmTime = (loc1[71] & 2) != 0 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAlarmCalories) 
            {
                (loc3 as core.settings.interfaces.IAlarmCalories).alarmCalories = (loc1[71] & 4) != 0 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IAutoWheelsize) 
            {
                (loc3 as core.settings.interfaces.IAutoWheelsize).autoWheelsize = (loc1[71] & 8) != 0 ? false : true;
            }
            if (loc3 is core.settings.interfaces.IWheelSize1) 
            {
                (loc3 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc1[101] << 8 | loc1[100];
            }
            if (loc3 is core.settings.interfaces.IBikeWeight1) 
            {
                (loc3 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = (loc1[105] << 8 | loc1[104]) * 10;
            }
            if (loc3 is core.settings.interfaces.IPowerFTP) 
            {
                (loc3 as core.settings.interfaces.IPowerFTP).powerFTP = loc1[109] << 8 | loc1[108];
            }
        }

        public override function encodeSportProfile(arg1:core.sportprofiles.Sportprofile):Array
        {
            var loc8:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc4:*=0;
            var loc3:*=null;
            var loc1:*=encodeCommonSportprofile(arg1);
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                if (!(arg1 as core.settings.interfaces.IGPSStatus).gpsStatus) 
                {
                    loc1[70] = loc1[70] | 1;
                }
            }
            if (arg1 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                if ((arg1 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero) 
                {
                    loc1[70] = loc1[70] | 8;
                }
            }
            if (arg1 is core.settings.interfaces.IAvgCadInclZero) 
            {
                if ((arg1 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero) 
                {
                    loc1[70] = loc1[70] | 16;
                }
            }
            if (arg1 is core.settings.interfaces.IAlarmDistance) 
            {
                if (!(arg1 as core.settings.interfaces.IAlarmDistance).alarmDistance) 
                {
                    loc1[71] = loc1[71] | 1;
                }
            }
            if (arg1 is core.settings.interfaces.IAlarmTime) 
            {
                if (!(arg1 as core.settings.interfaces.IAlarmTime).alarmTime) 
                {
                    loc1[71] = loc1[71] | 2;
                }
            }
            if (arg1 is core.settings.interfaces.IAlarmCalories) 
            {
                if (!(arg1 as core.settings.interfaces.IAlarmCalories).alarmCalories) 
                {
                    loc1[71] = loc1[71] | 4;
                }
            }
            if (arg1 is core.settings.interfaces.IAutoWheelsize) 
            {
                if (!(arg1 as core.settings.interfaces.IAutoWheelsize).autoWheelsize) 
                {
                    loc1[71] = loc1[71] | 8;
                }
            }
            else 
            {
                loc1[71] = loc1[71] | 8;
            }
            var loc9:*=84;
            var loc2:*=8;
            if (arg1 is core.settings.interfaces.ILapFavSets) 
            {
                loc5 = new core.sportprofiles.FavFunctionList();
                loc5 = (arg1 as core.settings.interfaces.ILapFavSets).getLapFavSetObject(1);
                loc1[loc9 + 0] = loc5.active ? loc5.templateId : 0;
                loc7 = 0;
                while (loc7 < 6) 
                {
                    loc6 = loc5.getFavFunctionlistItem(loc7);
                    loc1[loc9 + loc7 + 1] = loc6 != null ? loc5.getFavFunctionlistItem(loc7).favFuncId : 0;
                    ++loc7;
                }
                loc1[loc9 + 7] = 0;
                loc9 = loc9 + loc2;
            }
            if (arg1 is core.settings.interfaces.IAutoLapFavSets) 
            {
                loc9 = 92;
                loc5 = new core.sportprofiles.FavFunctionList();
                loc5 = (arg1 as core.settings.interfaces.IAutoLapFavSets).getAutoLapFavSetObject(1);
                loc1[loc9 + 0] = loc5.active ? loc5.templateId : 0;
                loc7 = 0;
                while (loc7 < 6) 
                {
                    loc6 = loc5.getFavFunctionlistItem(loc7);
                    loc1[loc9 + loc7 + 1] = loc6 != null ? loc5.getFavFunctionlistItem(loc7).favFuncId : 0;
                    ++loc7;
                }
                loc1[loc9 + 7] = 0;
                loc9 = loc9 + loc2;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                loc8 = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
                loc1[100] = loc8 & 255;
                loc1[101] = loc8 >> 8 & 255;
            }
            loc1[102] = 0;
            loc1[103] = 0;
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                loc8 = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1 / 10;
                loc1[104] = loc8 & 255;
                loc1[105] = loc8 >> 8 & 255;
                loc8 = (loc3 = new utils.converter.WeightConverter("g", "lb")).convert(loc8);
                loc1[106] = loc8 & 255;
                loc1[107] = loc8 >> 8 & 255;
            }
            if (arg1 is core.settings.interfaces.IPowerFTP) 
            {
                loc8 = (arg1 as core.settings.interfaces.IPowerFTP).powerFTP;
                loc1[108] = loc8 & 255;
                loc1[109] = loc8 >> 8 & 255;
            }
        }

        public override function decodeTotals(arg1:Object):core.totals.Totals
        {
            _myUnitTotals = new core.totals.TotalsROX110();
            return decodeCommonTotals(arg1, _myUnitTotals);
        }

        public override function decodeSettings(arg1:Object):core.settings.Settings
        {
            _myUnitSettings = new core.settings.SettingsROX110();
            return decodeCommonSettings(arg1, _myUnitSettings);
        }

        public override function encodeSettings():Array
        {
            return encodeCommonSettings(_myUnitSettings);
        }

        protected override function decodeLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc1:*=super.decodeLogEntry(arg1, arg2);
            loc1.power = arg1[49] << 8 | arg1[48];
            loc1.powerPerKG = loc1.power / arg2.bodyWeight;
            loc1.normalizedPower = arg1[51] << 8 | arg1[50];
            loc1.heartrate = arg1[52];
            loc1.cadence = arg1[53];
            loc1.rightBalance = arg1[54] & 127;
            loc1.leftBalance = 100 - loc1.rightBalance;
            loc1.timeBelowIntensityZones = arg1[55] * 10;
            loc1.timeInIntensityZone1 = arg1[56] * 10;
            loc1.timeInIntensityZone2 = arg1[57] * 10;
            loc1.timeInIntensityZone3 = arg1[58] * 10;
            loc1.timeInIntensityZone4 = arg1[59] * 10;
            loc1.timeAboveIntensityZones = arg1[60] * 10;
            loc1.timeInPowerZone1 = arg1[61] * 10;
            loc1.timeInPowerZone2 = arg1[62] * 10;
            loc1.timeInPowerZone3 = arg1[63] * 10;
            loc1.timeInPowerZone4 = arg1[64] * 10;
            loc1.timeInPowerZone5 = arg1[65] * 10;
            loc1.timeInPowerZone6 = arg1[66] * 10;
            loc1.timeInPowerZone7 = arg1[67] * 10;
            loc1.pedalingTime = arg1[68] * 10;
            return loc1;
        }

        public static const LAP_VALUES_SIZE:int=80;

        public static const PHASE_VALUES_SIZE:int=68;

        public static const RECORD_VALUES_SIZE:int=72;

        public static const TRACK_HEADER_SIZE:int=280;

        public static const TRACK_POINTS_SIZE:int=12;

        public static const WAY_POINT_HEADER_SIZE:int=72;

        public static const WAY_POINT_SIZE:int=72;

        internal static const POI_DESC_LENGTH:int=58;

        internal static const POI_DESC_START_INDEX:int=10;

        public static const ENCODED_DATA_SPLITTER:String=".";

        internal var _myUnit:core.units.UnitROX110;

        internal var _myUnitSettings:core.settings.SettingsROX110;

        internal var _myUnitTotals:core.totals.TotalsROX110;

        internal static var _instance:decoder.Rox110Decoder;
    }
}


//  class Rox2010Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import init.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class Rox2010Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog
    {
        public function Rox2010Decoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc6:*=null;
            var loc7:*=NaN;
            _7infotripArray = arg1 as Array;
            var loc3:*=87;
            var loc5:*;
            var loc4:*=(loc5 = decodeTripList())[0];
            var loc8:*=loc5[1];
            var loc1:*=new __AS3__.vec.Vector.<core.activities.Activity>();
            var loc2:*=loc4;
            if (loc8 > 0) 
            {
                loc6 = decodeTrip(loc2 * loc3, arg2 as core.units.UnitROX2010);
                loc1[0] = loc6;
            }
            loc7 = 1;
            while (loc7 < loc8) 
            {
                if (loc2 != 0) 
                {
                    --loc2;
                }
                else 
                {
                    loc2 = 6;
                }
                loc6 = decodeTrip(loc2 * loc3, arg2 as core.units.UnitROX2010);
                loc1[loc7] = loc6;
                ++loc7;
            }
            return loc1;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc164:*=false;
            var loc9:*=0;
            var loc10:*=0;
            var loc34:*=0;
            var loc40:*=0;
            var loc100:*=null;
            var loc129:*=0;
            var loc131:*=0;
            var loc98:*=0;
            var loc99:*=0;
            var loc77:*=null;
            var loc151:*=0;
            var loc154:*=0;
            var loc175:*=0;
            var loc173:*=0;
            var loc171:*=null;
            var loc78:*=0;
            var loc35:*=0;
            var loc56:*=0;
            var loc19:*=null;
            var loc75:*=0;
            var loc58:*=null;
            var loc42:*=0;
            var loc76:*=0;
            var loc153:*=false;
            var loc38:*=arg2 as core.units.UnitROX2010;
            var loc47:*;
            (loc47 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsROX2010).unitType = arg2.type;
            loc47.unit = arg2;
            var loc111:*;
            var loc36:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc83:*=0;
            var loc95:*=0;
            var loc105:*=0;
            var loc103:*=0;
            var loc2:*=null;
            var loc80:*=0;
            var loc82:*=0;
            var loc78:*=0;
            var loc132:*=0;
            var loc157:*=null;
            var loc21:*=0;
            var loc179:*=false;
            var loc34:*;
            (loc34 = new core.totals.TotalsROX2010()).unitType = arg2.type;
            loc34.unit = arg2;
            var loc20:*=arg1[38] & 15;
            var loc50:*=(arg1[37] & 240) >> 4;
            var loc51:*=arg1[37] & 15;
            var loc74:*=(arg1[36] & 240) >> 4;
            var loc75:*=arg1[36] & 15;
            var loc91:*=(arg1[35] & 240) >> 4;
            var loc93:*=arg1[35] & 15;
            var loc3:*=(arg1[34] & 240) >> 4;
            var loc4:*=arg1[34] & 15;
            var loc15:*=(arg1[33] & 240) >> 4;
            var loc17:*=arg1[33] & 15;
            var loc11:*=(loc11 = (loc11 = (loc11 = (loc11 = (loc11 = loc20.toString()) + (loc50.toString() + loc51.toString())) + (loc74.toString() + loc75.toString())) + (loc91.toString() + loc93.toString())) + (loc3.toString() + loc4.toString())) + (loc15.toString() + loc17.toString());
            var loc25:*;
            (loc25 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc25.outputFormat = "meter";
            loc34.totalDistance1 = loc25.convert(new Number(loc11) / 1000000);
            var loc19:*=(arg1[43] & 240) >> 4;
            var loc18:*=arg1[43] & 15;
            var loc5:*=(arg1[42] & 240) >> 4;
            var loc6:*=arg1[42] & 15;
            var loc96:*=(arg1[41] & 240) >> 4;
            var loc94:*=arg1[41] & 15;
            var loc76:*=(arg1[40] & 240) >> 4;
            var loc77:*=arg1[40] & 15;
            var loc54:*=(arg1[39] & 240) >> 4;
            var loc52:*=arg1[39] & 15;
            var loc37:*=(arg1[38] & 240) >> 4;
            var loc176:*=(loc176 = (loc176 = (loc176 = (loc176 = (loc176 = loc19.toString() + loc18.toString()) + (loc5.toString() + loc6.toString())) + (loc96.toString() + loc94.toString())) + (loc76.toString() + loc77.toString())) + (loc54.toString() + loc52.toString())) + loc37.toString();
            loc34.totalDistance2 = loc25.convert(new Number(loc176) / 1000000);
            var loc160:*=(arg1[53] & 240) >> 4;
            var loc159:*=arg1[53] & 15;
            var loc197:*=(arg1[52] & 240) >> 4;
            var loc199:*=arg1[52] & 15;
            var loc182:*=(arg1[51] & 240) >> 4;
            var loc180:*=arg1[51] & 15;
            var loc131:*=(arg1[50] & 240) >> 4;
            var loc133:*=arg1[50] & 15;
            var loc7:*=parseInt(loc160.toString() + loc159.toString() + loc197.toString() + loc199.toString());
            var loc181:*=parseInt(loc182.toString() + loc180.toString());
            var loc14:*=parseInt(loc131.toString() + loc133.toString());
            loc34.totalTrainingTime1 = (loc7 * 3600 + loc181 * 60 + loc14) * 100;
            var loc198:*=(arg1[57] & 240) >> 4;
            var loc196:*=arg1[57] & 15;
            var loc123:*=(arg1[56] & 240) >> 4;
            var loc122:*=arg1[56] & 15;
            var loc135:*=(arg1[55] & 240) >> 4;
            var loc134:*=arg1[55] & 15;
            var loc143:*=(arg1[54] & 240) >> 4;
            var loc142:*=arg1[54] & 15;
            var loc191:*=parseInt(loc198.toString() + loc196.toString() + loc123.toString() + loc122.toString());
            var loc12:*=parseInt(loc135.toString() + loc134.toString());
            var loc60:*=parseInt(loc143.toString() + loc142.toString());
            loc34.totalTrainingTime2 = (loc191 * 3600 + loc12 * 60 + loc60) * 100;
            var loc183:*;
            (loc183 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc183.outputFormat = "millimeter";
            if ((arg1[76] & 240) >> 4 != 15) 
            {
                loc83 = (arg1[76] & 240) >> 4;
                loc95 = arg1[76] & 15;
                loc105 = (arg1[75] & 240) >> 4;
                loc103 = arg1[75] & 15;
                loc2 = loc83.toString() + loc95.toString() + loc105.toString() + loc103.toString();
            }
            else 
            {
                loc83 = arg1[76] & 15;
                loc105 = (arg1[75] & 240) >> 4;
                loc103 = arg1[75] & 15;
                loc2 = "-" + loc83.toString() + loc105.toString() + loc103.toString();
            }
            loc34.maxAltitude1 = loc183.convert(parseInt(loc2));
            if ((arg1[78] & 240) >> 4 != 15) 
            {
                loc80 = (arg1[78] & 240) >> 4;
                loc82 = arg1[78] & 15;
                loc78 = (arg1[77] & 240) >> 4;
                loc132 = arg1[77] & 15;
                loc157 = loc80.toString() + loc82.toString() + loc78.toString() + loc132.toString();
            }
            else 
            {
                loc80 = arg1[78] & 15;
                loc78 = (arg1[77] & 240) >> 4;
                loc132 = arg1[77] & 15;
                loc157 = "-" + loc80.toString() + loc78.toString() + loc132.toString();
            }
            loc34.maxAltitude2 = loc183.convert(parseInt(loc157));
            var loc84:*=arg1[82] & 15;
            var loc138:*=(arg1[81] & 240) >> 4;
            var loc139:*=arg1[81] & 15;
            var loc186:*=(arg1[80] & 240) >> 4;
            var loc187:*=arg1[80] & 15;
            var loc200:*=(arg1[79] & 240) >> 4;
            var loc202:*=arg1[79] & 15;
            var loc124:*=(loc124 = (loc124 = (loc124 = loc84.toString()) + (loc138.toString() + loc139.toString())) + (loc186.toString() + loc187.toString())) + (loc200.toString() + loc202.toString());
            loc34.totalClimbMeter1 = loc183.convert(parseInt(loc124) / 10);
            var loc170:*=(arg1[85] & 240) >> 4;
            var loc171:*=arg1[85] & 15;
            var loc163:*=(arg1[84] & 240) >> 4;
            var loc162:*=arg1[84] & 15;
            var loc201:*=(arg1[83] & 240) >> 4;
            var loc203:*=arg1[83] & 15;
            var loc149:*=(arg1[82] & 240) >> 4;
            var loc28:*=(loc28 = (loc28 = (loc28 = loc170.toString() + loc171) + (loc163.toString() + loc162.toString())) + (loc201.toString() + loc203.toString())) + loc149.toString();
            loc34.totalClimbMeter2 = loc183.convert(parseInt(loc28) / 10);
            var loc42:*=arg1[89] & 15;
            var loc67:*=(arg1[88] & 240) >> 4;
            var loc66:*=arg1[88] & 15;
            var loc43:*=(arg1[87] & 240) >> 4;
            var loc46:*=arg1[87] & 15;
            var loc110:*=(arg1[86] & 240) >> 4;
            var loc109:*=arg1[86] & 15;
            var loc193:*=(loc193 = (loc193 = (loc193 = loc42.toString()) + (loc67.toString() + loc66.toString())) + (loc43.toString() + loc46.toString())) + (loc110.toString() + loc109.toString());
            loc34.totalDescent1 = loc183.convert(parseInt(loc193) / 10);
            var loc48:*=(arg1[92] & 240) >> 4;
            var loc49:*=arg1[92] & 15;
            var loc86:*=(arg1[91] & 240) >> 4;
            var loc71:*=arg1[91] & 15;
            var loc107:*=(arg1[90] & 240) >> 4;
            var loc108:*=arg1[90] & 15;
            var loc98:*=(arg1[89] & 240) >> 4;
            var loc148:*=(loc148 = (loc148 = (loc148 = loc48.toString() + loc49.toString()) + (loc86.toString() + loc71.toString())) + (loc107.toString() + loc108.toString())) + loc98.toString();
            loc34.totalDescent2 = loc183.convert(parseInt(loc148) / 10);
            var loc87:*=(arg1[96] & 240) >> 4;
            var loc68:*=arg1[96] & 15;
            var loc65:*=(arg1[95] & 240) >> 4;
            var loc64:*=arg1[95] & 15;
            var loc45:*=(arg1[94] & 240) >> 4;
            var loc44:*=arg1[94] & 15;
            var loc155:*=(arg1[93] & 240) >> 4;
            var loc154:*=arg1[93] & 15;
            var loc166:*=(loc166 = (loc166 = parseInt(loc87.toString() + loc68.toString() + loc65.toString() + loc64.toString()) * 3600) + parseInt(loc45.toString() + loc44.toString()) * 60) + parseInt(loc155.toString() + loc154.toString());
            loc34.totalTimeUp1 = loc166 * 100;
            var loc114:*=(arg1[100] & 240) >> 4;
            var loc115:*=arg1[100] & 15;
            var loc153:*=(arg1[99] & 240) >> 4;
            var loc152:*=arg1[99] & 15;
            var loc144:*=(arg1[98] & 240) >> 4;
            var loc145:*=arg1[98] & 15;
            var loc61:*=(arg1[97] & 240) >> 4;
            var loc62:*=arg1[97] & 15;
            var loc146:*=(loc146 = (loc146 = parseInt(loc114.toString() + loc115.toString() + loc153.toString() + loc152.toString()) * 3600) + parseInt(loc144.toString() + loc145.toString()) * 60) + parseInt(loc61.toString() + loc62.toString());
            loc34.totalTimeUp2 = loc146 * 100;
            var loc174:*=(arg1[104] & 240) >> 4;
            var loc175:*=arg1[104] & 15;
            var loc127:*=(arg1[103] & 240) >> 4;
            var loc128:*=arg1[103] & 15;
            var loc111:*=(arg1[102] & 240) >> 4;
            var loc112:*=arg1[102] & 15;
            var loc151:*=(arg1[101] & 240) >> 4;
            var loc147:*=arg1[101] & 15;
            var loc119:*=(loc119 = (loc119 = parseInt(loc174.toString() + loc175.toString() + loc127.toString() + loc128.toString()) * 3600) + parseInt(loc111.toString() + loc112.toString()) * 60) + parseInt(loc151.toString() + loc147.toString());
            loc34.totalTimeDown1 = loc119 * 100;
            var loc167:*=(arg1[108] & 240) >> 4;
            var loc164:*=arg1[108] & 15;
            var loc178:*=(arg1[107] & 240) >> 4;
            var loc177:*=arg1[107] & 15;
            var loc194:*=(arg1[106] & 240) >> 4;
            var loc195:*=arg1[106] & 15;
            var loc117:*=(arg1[105] & 240) >> 4;
            var loc116:*=arg1[105] & 15;
            var loc188:*=(loc188 = (loc188 = parseInt(loc167.toString() + loc164.toString() + loc178.toString() + loc177.toString()) * 3600) + parseInt(loc194.toString() + loc195.toString()) * 60) + parseInt(loc117.toString() + loc116.toString());
            loc34.totalTimeDown2 = loc188 * 100;
            var loc8:*=arg1[114] & 15;
            var loc56:*=(arg1[113] & 240) >> 4;
            var loc58:*=arg1[113] & 15;
            var loc40:*=(arg1[112] & 240) >> 4;
            var loc41:*=arg1[112] & 15;
            var loc99:*=(arg1[111] & 240) >> 4;
            var loc101:*=arg1[111] & 15;
            var loc88:*=(arg1[110] & 240) >> 4;
            var loc79:*=arg1[110] & 15;
            var loc140:*=(arg1[109] & 240) >> 4;
            var loc141:*=arg1[109] & 15;
            var loc27:*=(loc27 = (loc27 = (loc27 = (loc27 = (loc27 = loc8.toString()) + (loc56.toString() + loc58.toString())) + (loc40.toString() + loc41.toString())) + (loc99.toString() + loc101.toString())) + (loc88.toString() + loc79.toString())) + (loc140.toString() + loc141.toString());
            loc34.totalTripDistUp1 = loc25.convert(new Number(loc27) / 1000000);
            var loc57:*=(arg1[119] & 240) >> 4;
            var loc59:*=arg1[119] & 15;
            var loc85:*=(arg1[118] & 240) >> 4;
            var loc81:*=arg1[118] & 15;
            var loc104:*=(arg1[117] & 240) >> 4;
            var loc106:*=arg1[117] & 15;
            var loc126:*=(arg1[116] & 240) >> 4;
            var loc125:*=arg1[116] & 15;
            var loc136:*=(arg1[115] & 240) >> 4;
            var loc137:*=arg1[115] & 15;
            var loc113:*=(arg1[114] & 240) >> 4;
            var loc120:*=(loc120 = (loc120 = (loc120 = (loc120 = (loc120 = loc57.toString() + loc59.toString()) + (loc85.toString() + loc81.toString())) + (loc104.toString() + loc106.toString())) + (loc126.toString() + loc125.toString())) + (loc136.toString() + loc137.toString())) + loc113.toString();
            loc34.totalTripDistUp2 = loc25.convert(new Number(loc120) / 1000000);
            var loc192:*=arg1[125] & 15;
            var loc16:*=(arg1[124] & 240) >> 4;
            var loc13:*=arg1[124] & 15;
            var loc69:*=(arg1[123] & 240) >> 4;
            var loc70:*=arg1[123] & 15;
            var loc89:*=(arg1[122] & 240) >> 4;
            var loc90:*=arg1[122] & 15;
            var loc35:*=(arg1[121] & 240) >> 4;
            var loc36:*=arg1[121] & 15;
            var loc63:*=(arg1[120] & 240) >> 4;
            var loc47:*=arg1[120] & 15;
            var loc121:*=(loc121 = (loc121 = (loc121 = (loc121 = (loc121 = loc192.toString()) + (loc16.toString() + loc13.toString())) + (loc69.toString() + loc70.toString())) + (loc89.toString() + loc90.toString())) + (loc35.toString() + loc36.toString())) + (loc63.toString() + loc47.toString());
            loc34.totalTripDistDown1 = loc25.convert(new Number(loc121) / 1000000);
            var loc55:*=(arg1[130] & 240) >> 4;
            var loc53:*=arg1[130] & 15;
            var loc38:*=(arg1[129] & 240) >> 4;
            var loc39:*=arg1[129] & 15;
            var loc92:*=(arg1[128] & 240) >> 4;
            var loc97:*=arg1[128] & 15;
            var loc72:*=(arg1[127] & 240) >> 4;
            var loc73:*=arg1[127] & 15;
            var loc130:*=(arg1[126] & 240) >> 4;
            var loc129:*=arg1[126] & 15;
            var loc29:*=(arg1[125] & 240) >> 4;
            var loc33:*=(loc33 = (loc33 = (loc33 = (loc33 = (loc33 = loc55.toString() + loc53.toString()) + (loc38.toString() + loc39.toString())) + (loc92.toString() + loc97.toString())) + (loc72.toString() + loc73.toString())) + (loc130.toString() + loc129.toString())) + loc29.toString();
            loc34.totalTripDistDown2 = loc25.convert(new Number(loc33) / 1000000);
            var loc31:*=(arg1[133] & 240) >> 4;
            var loc30:*=arg1[133] & 15;
            var loc26:*=(arg1[132] & 240) >> 4;
            var loc24:*=arg1[132] & 15;
            var loc173:*=(arg1[131] & 240) >> 4;
            var loc172:*=arg1[131] & 15;
            var loc100:*=(loc100 = (loc100 = loc31.toString() + loc30.toString()) + (loc26.toString() + loc24.toString())) + (loc173.toString() + loc172.toString());
            loc34.totalCal1 = parseInt(loc100);
            var loc161:*=(arg1[136] & 240) >> 4;
            var loc165:*=arg1[136] & 15;
            var loc169:*=(arg1[135] & 240) >> 4;
            var loc168:*=arg1[135] & 15;
            var loc184:*=(arg1[134] & 240) >> 4;
            var loc185:*=arg1[134] & 15;
            var loc150:*=(loc150 = (loc150 = loc161.toString() + loc165.toString()) + (loc169.toString() + loc168.toString())) + (loc184.toString() + loc185.toString());
            loc34.totalCal2 = parseInt(loc150);
            var loc102:*=arg1[165].toString(16) + arg1[164].toString(16);
            var loc156:*=0;
            loc21 = 0;
            while (loc21 < 164) 
            {
                loc156 = (loc156 = loc156 + arg1[loc21 + 2]) & 65535;
                ++loc21;
            }
            var loc158:*=loc156.toString(16);
            var loc189:*=(arg1[169] & 240) >> 4;
            var loc190:*=arg1[169] & 15;
            var loc23:*=(arg1[168] & 240) >> 4;
            var loc22:*=arg1[168] & 15;
            var loc9:*=(arg1[167] & 240) >> 4;
            var loc10:*=arg1[167] & 15;
            var loc1:*=(arg1[166] & 240) >> 4;
            var loc32:*=arg1[166] & 15;
            var loc118:*=(loc118 = (loc118 = (loc118 = loc189.toString() + loc190.toString()) + (loc23.toString() + loc22.toString())) + (loc9.toString() + loc10.toString())) + (loc1.toString() + loc32.toString());
            if (!loc179) 
            {
            };
            return loc34;
        }

        public function encodeUnitInformation(arg1:core.units.Unit):Array
        {
            var loc5:*=0;
            var loc6:*;
            if ((loc6 = arg1 as core.units.UnitROX2010).serialNumber == null || loc6.dateCode == null || loc6.maskingCode == null || loc6.initialWakeUpInfo == null || loc6.softwareRevision == null) 
            {
                return null;
            }
            var loc1:*=false;
            var loc3:*=[];
            var loc2:*=parseInt(loc6.serialNumber);
            var loc9:*=0;
            if (loc6 is core.units.UnitROX81) 
            {
                loc9 = loc2 - 10000000 + 1048576;
            }
            else 
            {
                loc9 = loc2 - 90000000 + 9437184;
            }
            loc3[0] = loc9 & 255;
            loc3[1] = (loc9 & 65280) >> 8;
            loc3[2] = (loc9 & 16711680) >> 16;
            var loc4:*=loc6.dateCode;
            loc3[3] = loc4.date / 10 << 4;
            var loc14:*=3;
            var loc15:*=loc3[loc14] | loc4.date % 10;
            loc3[loc14] = loc15;
            loc3[4] = (loc4.month + 1) / 10 << 4;
            loc15 = 4;
            loc14 = loc3[loc15] | (loc4.month + 1) % 10;
            loc3[loc15] = loc14;
            loc3[5] = loc4.fullYear % 100 / 10 << 4;
            loc14 = 5;
            loc15 = loc3[loc14] | loc4.fullYear % 100 % 10;
            loc3[loc14] = loc15;
            var loc12:*=parseInt("0x" + loc6.maskingCode);
            loc3[6] = loc12 & 255;
            loc3[7] = (loc12 & 65280) >> 8;
            loc3[8] = (loc12 & 16711680) >> 16;
            loc3[9] = (loc12 & 251658240) >> 24;
            var loc8:*=parseInt("0x" + loc6.initialWakeUpInfo);
            loc15 = 9;
            loc14 = loc3[loc15] | loc8 << 4;
            loc3[loc15] = loc14;
            var loc10:*=parseFloat(loc6.softwareRevision);
            var loc11:*=parseFloat(loc6.softwareRevision) * 10 % 10;
            var loc7:*=loc10 << 4;
            loc7 = loc7 | loc11;
            loc3[10] = loc7;
            var loc13:*=0;
            loc5 = 0;
            while (loc5 < 11) 
            {
                loc13 = loc13 + loc3[loc5];
                ++loc5;
            }
            loc13 = loc13 & 255;
            loc3[11] = loc13;
            loc3[12] = 212;
            loc3[13] = 116;
            loc3[14] = 148;
            loc3[15] = 53;
            if (!loc1) 
            {
            };
            return loc3;
        }

        public function encodeGhostRace(arg1:core.activities.Activity):Array
        {
            var loc34:*=NaN;
            var loc6:*=NaN;
            var loc16:*=NaN;
            var loc22:*=0;
            var loc36:*=NaN;
            var loc26:*=0;
            var loc31:*=NaN;
            var loc1:*=null;
            var loc35:*=NaN;
            var loc20:*=NaN;
            var loc13:*=NaN;
            var loc10:*=NaN;
            var loc24:*=0;
            var loc33:*=0;
            var loc17:*=0;
            var loc3:*=NaN;
            var loc12:*=0;
            var loc19:*=0;
            var loc32:*=0;
            var loc23:*=0;
            var loc4:*=[];
            if (arg1 != null) 
            {
                loc34 = 0;
                loc6 = 0;
                loc16 = 0;
                loc22 = 0;
                loc36 = 0;
                if ((loc26 = arg1.wheelSize) == 0) 
                {
                    loc26 = 2155;
                }
                loc31 = 0;
                loc23 = 0;
                while (loc23 < arg1.entries.length) 
                {
                    loc1 = arg1.entries[loc23];
                    loc36 = loc1.distance / (loc26 / 1000);
                    loc31 = loc1.trainingTime / 100;
                    loc35 = loc36 / loc31;
                    if (isNaN(loc35)) 
                    {
                        loc35 = 0;
                    }
                    loc20 = 0;
                    loc13 = 1;
                    loc10 = 0;
                    loc24 = loc13;
                    while (loc24 <= loc31) 
                    {
                        loc10 = loc13 * loc35 - loc20;
                        loc4[loc4.length] = loc10;
                        loc20 = loc20 + loc10;
                        loc34 = loc34 + loc10;
                        ++loc13;
                        ++loc24;
                    }
                    if (loc20 < loc36 || loc36 == 0) 
                    {
                        loc6 = loc6 + (loc36 - loc20);
                        loc16 = loc16 + loc31 % 1;
                    }
                    if (loc16 >= 1) 
                    {
                        loc4[loc4.length] = loc6;
                        loc34 = loc34 + loc6;
                        loc6 = 0;
                        --loc16;
                    }
                    ++loc23;
                }
                if (loc6 > 0) 
                {
                    var loc37:*=(loc4.length - 1);
                    var loc38:*=loc4[loc37] + loc6;
                    loc4[loc37] = loc38;
                    loc34 = loc34 + loc6;
                }
            }
            var loc7:*=(loc4.length - 1);
            loc23 = loc4.length;
            while (loc23 < 18182) 
            {
                loc4[loc23] = 0;
                ++loc23;
            }
            loc23 = 0;
            while (loc23 < loc7 + 1) 
            {
                loc33 = 0;
                loc17 = 0;
                while (loc17 < 8) 
                {
                    loc3 = 1 << loc17;
                    if (loc4[loc23] & loc3) 
                    {
                        ++loc33;
                    }
                    ++loc17;
                }
                loc12 = 0;
                loc19 = loc23 / 8 + 18182;
                if (loc33 % 2 != 1) 
                {
                    if (loc4[loc19] == undefined) 
                    {
                        loc4[loc19] = 0;
                    }
                }
                else 
                {
                    loc38 = loc19;
                    loc37 = loc4[loc38] | 1 << loc23 % 8;
                    loc4[loc38] = loc37;
                    if (loc12 != loc19) 
                    {
                        loc12 = loc19;
                    }
                }
                ++loc23;
            }
            loc23 = loc4.length;
            while (loc23 < 20455) 
            {
                loc4[loc23] = 0;
                ++loc23;
            }
            var loc15:*=loc4.length;
            loc4[loc4.length] = loc7 & 255;
            loc4[loc4.length] = loc7 >> 8;
            var loc2:*=loc26.toString();
            while (loc2.length < 4) 
            {
                loc2 = "0" + loc2;
            }
            var loc9:*=loc2.split("");
            loc4[loc4.length] = parseInt((loc9[2] + loc9[3]).toString(), 16);
            loc4[loc4.length] = parseInt((loc9[0] + loc9[1]).toString(), 16);
            var loc14:*=arg1.ghostName.split("");
            var loc8:*="";
            loc23 = 0;
            while (loc23 < 10) 
            {
                if (loc23 < loc14.length) 
                {
                    loc8 = loc14[loc23];
                }
                else 
                {
                    loc8 = " ";
                }
                loc32 = MY_NAME.indexOf(loc8);
                loc4[loc4.length] = loc32;
                ++loc23;
            }
            var loc30:*;
            var loc28:*=(loc30 = arg1.trainingTime / 100) / 3600;
            var loc25:*=(loc30 - loc28 * 3600) / 60;
            var loc29:*=loc30 - loc28 * 3600 - loc25 * 60;
            loc4[loc4.length] = parseInt(loc29.toString(), 16);
            loc4[loc4.length] = parseInt(loc25.toString(), 16);
            loc4[loc4.length] = parseInt(loc28.toString(), 16);
            var loc5:*;
            var loc27:*=(loc5 = init.BackendInitializer.getInstance().createGhostDistanceDecoderFormatter()).format(arg1.distance / 1000);
            while (loc27.length < 7) 
            {
                loc27 = "0" + loc27;
            }
            var loc18:*=loc27.split("");
            loc4[loc4.length] = parseInt((loc18[5] + loc18[6]).toString(), 16);
            loc4[loc4.length] = parseInt((loc18[2] + loc18[3]).toString(), 16);
            loc4[loc4.length] = parseInt((loc18[0] + loc18[1]).toString(), 16);
            var loc21:*=loc4.length;
            var loc11:*=0;
            loc23 = 20455;
            while (loc23 < 20475) 
            {
                loc11 = loc11 + (loc4[loc23] & 255);
                ++loc23;
            }
            loc11 = loc11 & 255;
            loc4[loc4.length] = loc11;
            loc4[loc4.length] = 212;
            loc4[loc4.length] = 116;
            loc4[loc4.length] = 148;
            loc4[loc4.length] = 53;
            return loc4;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc74:*=0;
            var loc44:*=0;
            var loc24:*=0;
            var loc36:*=0;
            var loc81:*=0;
            var loc82:*=null;
            var loc148:*=0;
            var loc35:*=0;
            var loc111:*=new Array(170);
            var loc40:*=arg1.currentSettings as core.settings.SettingsROX2010;
            var loc89:*=(arg1 as core.units.UnitROX2010).currentTotals as core.totals.TotalsROX2010;
            var loc31:*=arg1 as core.units.UnitROX2010;
            loc74 = 0;
            while (loc74 < loc111.length) 
            {
                loc111[loc74] = 0;
                ++loc74;
            }
            loc111[0] = 5;
            loc111[1] = 8;
            var loc154:*=1;
            var loc155:*=loc111[loc154] | 48;
            loc111[loc154] = loc155;
            loc111[2] = 100;
            loc111[3] = 80;
            loc111[4] = 100;
            var loc102:*=0;
            loc155 = (loc40 as core.settings.interfaces.IBikeType1).bikeType1;
            while ("raceDrop" === loc155) 
            {
                loc102 = 1;
            }
        }

        public function decodeNumberOfPages(arg1:Array):int
        {
            var loc3:*=arg1[1] << 8;
            var loc2:*=arg1[0];
            var loc1:*=loc3 | loc2;
            return loc1;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            var loc1:*=0;
            var loc19:*=0;
            var loc2:*=0;
            var loc31:*=0;
            var loc3:*=0;
            var loc26:*;
            var loc8:*;
            var loc14:*=((loc8 = (loc26 = arg1 as Array).slice(65360, 65370))[0] & 240) >> 4;
            var loc13:*=loc8[0] & 15;
            var loc12:*=(loc8[1] & 240) >> 4;
            var loc15:*=loc8[1] & 15;
            var loc27:*=loc12.toString(16) + loc15.toString(16) + loc14.toString(16) + loc13.toString(16);
            loc2 = parseInt(loc27, 16);
            var loc7:*=(loc8[3] & 240) >> 4;
            var loc33:*=loc8[3] & 15;
            var loc34:*=(loc8[2] & 240) >> 4;
            var loc21:*=loc8[2] & 15;
            var loc4:*=loc7.toString(16) + loc33.toString(16) + loc34.toString(16) + loc21.toString(16);
            loc31 = parseInt(loc4, 16);
            var loc24:*=(loc8[5] & 240) >> 4;
            var loc5:*=loc8[5] & 15;
            var loc6:*=(loc8[4] & 240) >> 4;
            var loc9:*=loc8[4] & 15;
            var loc32:*=loc24.toString(16) + loc5.toString(16) + loc6.toString(16) + loc9.toString(16);
            loc3 = parseInt(loc32, 16);
            var loc16:*=(loc8[6] & 240) >> 4;
            var loc20:*=loc8[6] & 15;
            var loc28:*=loc16.toString(16) + loc20.toString(16);
            loc1 = parseInt(loc28, 16);
            var loc22:*=(loc8[10] & 240) >> 4;
            var loc10:*=loc8[10] & 15;
            var loc25:*=(loc8[9] & 240) >> 4;
            var loc29:*=loc8[9] & 15;
            var loc23:*=(loc8[8] & 240) >> 4;
            var loc11:*=loc8[8] & 15;
            var loc18:*=(loc8[7] & 240) >> 4;
            var loc30:*=loc8[7] & 15;
            var loc17:*=loc22.toString() + loc10.toString() + loc25.toString() + loc29.toString() + loc23.toString() + loc11.toString() + loc18.toString() + loc30.toString();
            loc19 = parseInt(loc17, 10);
            return;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc11:*=0;
            var loc23:*=null;
            var loc9:*=null;
            var loc91:*=null;
            var loc20:*=null;
            var loc75:*=NaN;
            var loc73:*=0;
            var loc66:*;
            (loc66 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            loc66.serialNumber = (arg2 as core.units.UnitROX2010).serialNumber;
            loc66.pageHeaderData = arg1;
            loc66.pageHeaderData = arg1;
            var loc36:*=(arg1[1] & 48) >> 4;
            var loc19:*=arg1[1] & 15;
            var loc21:*=(arg1[0] & 240) >> 4;
            var loc18:*=arg1[0] & 15;
            var loc44:*=loc36.toString() + loc19.toString() + loc21.toString() + loc18.toString();
            loc11 = parseInt(loc44, 10);
            loc66.wheelSize = loc11;
            var loc50:*;
            if ((loc50 = (arg1[1] & 64) >> 6) != 1) 
            {
                loc9 = "kmh";
            }
            else 
            {
                loc9 = "mph";
            }
            loc66.speedUnit = loc9;
            var loc45:*;
            if ((loc45 = (arg1[1] & 128) >> 7) != 1) 
            {
                loc23 = "bike1";
            }
            else 
            {
                loc23 = "bike2";
            }
            loc66.bike = loc23;
            var loc33:*;
            var loc24:*=(loc33 = arg1[2]).toString();
            var loc41:*=parseInt(loc24, 10);
            loc66.hrMax = loc41;
            var loc34:*;
            var loc38:*=(loc34 = arg1[3]).toString();
            var loc3:*=parseInt(loc38, 10);
            loc66.zone1Start = loc3;
            var loc1:*=arg1[4];
            var loc7:*=loc1.toString();
            var loc61:*=parseInt(loc7, 10);
            loc66.zone2Start = loc61;
            var loc74:*;
            var loc25:*=(loc74 = arg1[5]).toString();
            var loc46:*=parseInt(loc25, 10);
            loc66.zone3Start = loc46;
            var loc22:*;
            var loc57:*=(loc22 = arg1[6]).toString();
            var loc49:*=parseInt(loc57, 10);
            loc66.zone3End = loc49;
            var loc56:*=(arg1[7] & 240) >> 4;
            var loc48:*=arg1[7] & 15;
            var loc55:*=(arg1[8] & 240) >> 4;
            var loc77:*=arg1[8] & 15;
            var loc65:*;
            var loc92:*=(loc65 = arg1[9] & 15).toString() + loc55.toString() + loc77.toString() + loc56.toString() + loc48.toString();
            loc66.calories = parseInt(loc92);
            var loc10:*;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc6:*=null;
            var loc8:*=null;
            var loc10:*=NaN;
            var loc3:*=0;
            var loc5:*=0;
            var loc4:*=1;
            var loc9:*=0;
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc1:*=new utils.converter.SpeedConverter();
            loc1.inputFormat = "kmh";
            loc1.outputFormat = "ms";
            loc5 = 0;
            for (;;) 
            {
                if (loc5 % 10 != 0) 
                {
                    loc6 = arg2.slice(loc3, loc3 + 10);
                    if (isPause(loc6)) 
                    {
                        loc8 = this.decodeRelLogPauseEntry(loc6, arg1);
                    }
                    else 
                    {
                        loc8 = this.decodeRelLogEntry(loc6, arg1);
                    }
                    loc8 = makeAbsolutEntry(loc8, arg1.entries[(loc5 - 1)]);
                    loc3 = loc3 + 10;
                }
                else 
                {
                    loc6 = arg2.slice(loc3, loc3 + 11);
                    if (isPause(loc6)) 
                    {
                        loc8 = this.decodeAbsLogPauseEntry(loc6, arg1);
                    }
                    else 
                    {
                        loc8 = this.decodeAbsLogEntry(loc6, arg1);
                    }
                    loc3 = loc3 + 11;
                }
                loc10 = loc8.speed / (2200 / arg1.wheelSize);
                loc10 = Math.round(loc10 * 100) / 100;
                loc8.speed = loc1.convert(loc10);
                if (loc8.speed > 0) 
                {
                    loc8.speedTime = Math.floor(1000 / loc8.speed);
                }
                else 
                {
                    loc8.speedTime = 1200;
                }
                if (loc8.speedTime > 1200) 
                {
                    loc8.speedTime = 1200;
                }
                arg1.entries.push(loc8);
                if (loc3 >= arg2.length) 
                {
                    break;
                }
                ++loc5;
            }
            var loc11:*;
        }

        internal function decodeTrip(arg1:int, arg2:core.units.UnitROX2010):core.activities.Activity
        {
            var loc167:*=null;
            var loc76:*=NaN;
            var loc150:*=null;
            var loc143:*=NaN;
            var loc44:*=null;
            var loc125:*=null;
            var loc78:*=null;
            var loc54:*=0;
            var loc168:*;
            (loc168 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc168.serialNumber = arg2.serialNumber;
            var loc176:*=(_7infotripArray[arg1] & 240) >> 4;
            var loc158:*=_7infotripArray[arg1] & 15;
            var loc159:*=(_7infotripArray[arg1 + 1] & 240) >> 4;
            var loc199:*=_7infotripArray[arg1 + 1] & 15;
            var loc157:*=(_7infotripArray[arg1 + 2] & 240) >> 4;
            var loc177:*=_7infotripArray[arg1 + 2] & 15;
            var loc79:*=(_7infotripArray[arg1 + 3] & 240) >> 4;
            var loc89:*=_7infotripArray[arg1 + 3] & 15;
            var loc88:*=(_7infotripArray[arg1 + 4] & 112) >> 4;
            var loc35:*=_7infotripArray[arg1 + 4] & 15;
            loc168.startDate = new Date("20" + loc157.toString() + loc177.toString(), (parseInt(loc159.toString() + loc199.toString()) - 1), loc176.toString() + loc158.toString(), loc88.toString() + loc35.toString(), loc79.toString() + loc89.toString());
            loc168.dateCode = loc168.startDate.toString();
            if ((_7infotripArray[arg1 + 4] & 128) >> 7 != 1) 
            {
                loc168.bike = "bike1";
            }
            else 
            {
                loc168.bike = "bike2";
            }
            var loc106:*;
            if ((loc106 = (_7infotripArray[arg1 + 72] & 128) >> 7) != 1) 
            {
                loc168.speedUnit = "kmh";
            }
            else 
            {
                loc168.speedUnit = "mph";
            }
            var loc50:*=new utils.converter.DistanceConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc50.inputFormat = "mile";
                }
            }
            else 
            {
                loc50.inputFormat = "kilometer";
            }
            loc50.outputFormat = "kilometer";
            var loc173:*=(_7infotripArray[arg1 + 5] & 240) >> 4;
            var loc121:*=_7infotripArray[arg1 + 5] & 15;
            var loc126:*=(_7infotripArray[arg1 + 6] & 240) >> 4;
            var loc99:*=_7infotripArray[arg1 + 6] & 15;
            var loc127:*=(_7infotripArray[arg1 + 7] & 240) >> 4;
            var loc17:*=_7infotripArray[arg1 + 7] & 15;
            var loc156:*=loc127.toString() + loc17.toString() + loc126.toString() + loc99.toString() + "." + loc173.toString() + loc121.toString();
            loc168.distance = loc50.convert(new Number(loc156)) * 1000;
            var loc130:*=(_7infotripArray[arg1 + 8] & 240) >> 4;
            var loc113:*=_7infotripArray[arg1 + 8] & 15;
            var loc112:*=(_7infotripArray[arg1 + 9] & 240) >> 4;
            var loc63:*=_7infotripArray[arg1 + 9] & 15;
            var loc115:*=(_7infotripArray[arg1 + 10] & 240) >> 4;
            var loc47:*=_7infotripArray[arg1 + 10] & 15;
            var loc114:*=(_7infotripArray[arg1 + 11] & 240) >> 4;
            var loc27:*=_7infotripArray[arg1 + 11] & 15;
            var loc104:*=parseInt(loc114.toString() + loc27.toString() + loc115.toString() + loc47.toString());
            var loc219:*=parseInt(loc112.toString() + loc63.toString());
            var loc51:*=parseInt(loc130.toString() + loc113.toString());
            loc168.trainingTime = (loc104 * 3600 + loc219 * 60 + loc51) * 100;
            var loc152:*=new utils.converter.SpeedConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc152.inputFormat = "mph";
                }
            }
            else 
            {
                loc152.inputFormat = "kmh";
            }
            loc152.outputFormat = "ms";
            var loc64:*=(_7infotripArray[arg1 + 12] & 240) >> 4;
            var loc212:*=_7infotripArray[arg1 + 12] & 15;
            var loc49:*=(_7infotripArray[arg1 + 13] & 240) >> 4;
            var loc136:*=_7infotripArray[arg1 + 13] & 15;
            var loc30:*;
            var loc185:*=(loc30 = _7infotripArray[arg1 + 14] & 15).toString() + loc49.toString() + loc136.toString() + "." + loc64.toString() + loc212.toString();
            loc168.averageSpeed = loc152.convert(new Number(loc185));
            var loc36:*=(_7infotripArray[arg1 + 16] & 240) >> 4;
            var loc72:*=_7infotripArray[arg1 + 16] & 15;
            var loc74:*=(_7infotripArray[arg1 + 15] & 240) >> 4;
            var loc19:*=_7infotripArray[arg1 + 15] & 15;
            var loc69:*=(_7infotripArray[arg1 + 14] & 240) >> 4;
            var loc11:*=loc36.toString() + loc72.toString() + loc74.toString() + "." + loc19.toString() + loc69.toString();
            loc168.maximumSpeed = loc152.convert(new Number(loc11));
            var loc52:*=(_7infotripArray[arg1 + 17] & 240) >> 4;
            var loc24:*=_7infotripArray[arg1 + 17] & 15;
            var loc23:*=(_7infotripArray[arg1 + 18] & 240) >> 4;
            var loc218:*=_7infotripArray[arg1 + 18] & 15;
            var loc21:*=_7infotripArray[arg1 + 19] & 15;
            var loc37:*=(_7infotripArray[19] & 240) >> 4;
            if (loc21 != 15) 
            {
                loc150 = loc21 + loc23.toString() + loc218.toString() + "." + loc52.toString() + loc24.toString();
                loc143 = loc50.convert(new Number(loc150)) * 1000;
                if (loc37 != 1) 
                {
                    loc168.distancePlus = loc143;
                }
                else 
                {
                    loc168.distanceMinus = loc143;
                }
            }
            else 
            {
                loc167 = "-" + loc23.toString() + loc218.toString() + "." + loc52.toString() + loc24.toString();
                loc76 = loc50.convert(new Number(loc167)) * 1000;
                if (loc37 != 1) 
                {
                    loc168.distancePlus = loc173;
                }
                else 
                {
                    loc168.distanceMinus = loc173;
                }
            }
            var loc172:*=(_7infotripArray[arg1 + 22] & 240) >> 4;
            var loc70:*=_7infotripArray[arg1 + 22] & 15;
            var loc86:*=loc172.toString(16) + loc70.toString(16);
            loc168.averageCadence = parseInt(loc86, 16);
            var loc55:*=(_7infotripArray[arg1 + 23] & 240) >> 4;
            var loc107:*=_7infotripArray[arg1 + 23] & 15;
            var loc31:*=loc55.toString(16) + loc107.toString(16);
            loc168.maximumCadence = parseInt(loc31, 16);
            var loc108:*=(_7infotripArray[arg1 + 24] & 240) >> 4;
            var loc58:*=_7infotripArray[arg1 + 24] & 15;
            var loc77:*=loc108.toString(16) + loc58.toString(16);
            loc168.averageHeartrate = parseInt(loc77, 16);
            var loc7:*=(_7infotripArray[arg1 + 25] & 240) >> 4;
            var loc84:*=_7infotripArray[arg1 + 25] & 15;
            var loc97:*=loc7.toString(16) + loc84.toString(16);
            loc168.maximumHeartrate = parseInt(loc97, 16);
            var loc20:*=(_7infotripArray[arg1 + 26] & 240) >> 4;
            var loc189:*=_7infotripArray[arg1 + 26] & 15;
            var loc187:*=(_7infotripArray[arg1 + 27] & 240) >> 4;
            var loc100:*=_7infotripArray[arg1 + 27] & 15;
            var loc179:*=(_7infotripArray[arg1 + 28] & 240) >> 4;
            var loc82:*=_7infotripArray[arg1 + 28] & 15;
            var loc45:*=parseInt(loc179.toString() + loc82.toString());
            var loc32:*=parseInt(loc187.toString() + loc100.toString());
            var loc6:*=parseInt(loc20.toString() + loc189.toString());
            loc168.timeInZone1 = (loc45 * 3600 + loc32 * 60 + loc6) * 100;
            var loc75:*=(_7infotripArray[arg1 + 29] & 240) >> 4;
            var loc39:*=_7infotripArray[arg1 + 29] & 15;
            var loc41:*=(_7infotripArray[arg1 + 30] & 240) >> 4;
            var loc87:*=_7infotripArray[arg1 + 30] & 15;
            var loc43:*=(_7infotripArray[arg1 + 31] & 240) >> 4;
            var loc33:*=_7infotripArray[arg1 + 31] & 15;
            var loc198:*=parseInt(loc43.toString() + loc33.toString());
            var loc153:*=parseInt(loc41.toString() + loc87.toString());
            var loc135:*=parseInt(loc75.toString() + loc39.toString());
            loc168.timeInZone2 = (loc198 * 3600 + loc153 * 60 + loc135) * 100;
            var loc128:*=(_7infotripArray[arg1 + 32] & 240) >> 4;
            var loc122:*=_7infotripArray[arg1 + 32] & 15;
            var loc120:*=(_7infotripArray[arg1 + 33] & 240) >> 4;
            var loc62:*=_7infotripArray[arg1 + 33] & 15;
            var loc123:*=(_7infotripArray[arg1 + 34] & 240) >> 4;
            var loc8:*=_7infotripArray[arg1 + 34] & 15;
            var loc216:*=parseInt(loc123.toString() + loc8.toString());
            var loc102:*=parseInt(loc120.toString() + loc62.toString());
            var loc14:*=parseInt(loc128.toString() + loc122.toString());
            loc168.timeInZone3 = (loc216 * 3600 + loc102 * 60 + loc14) * 100;
            var loc169:*=(_7infotripArray[arg1 + 37] & 240) >> 4;
            var loc182:*=_7infotripArray[arg1 + 37] & 15;
            var loc183:*=(_7infotripArray[arg1 + 36] & 240) >> 4;
            var loc217:*=_7infotripArray[arg1 + 36] & 15;
            var loc178:*=(_7infotripArray[arg1 + 35] & 240) >> 4;
            var loc213:*=_7infotripArray[arg1 + 35] & 15;
            var loc59:*=loc169.toString() + loc182.toString() + loc183.toString() + loc217.toString() + loc178.toString() + loc213.toString();
            loc168.calories = parseInt(loc59, 10);
            var loc66:*=(_7infotripArray[arg1 + 39] & 240) >> 4;
            var loc28:*=_7infotripArray[arg1 + 39] & 15;
            var loc25:*=(_7infotripArray[arg1 + 38] & 240) >> 4;
            var loc163:*=_7infotripArray[arg1 + 38] & 15;
            var loc138:*;
            (loc138 = new utils.converter.TemperatureConverter()).inputFormat = core.MeasurementConfig.temperatureFormat;
            loc138.outputFormat = "celsius";
            if (loc66 != 15) 
            {
                loc168.minimumTemperature = loc138.convert(parseFloat(loc66.toString() + loc28.toString() + loc25.toString() + "." + loc163.toString()));
            }
            else 
            {
                loc44 = "-" + loc28.toString() + loc25.toString() + "." + loc163.toString();
                loc168.minimumTemperature = loc138.convert(new Number(loc44));
            }
            var loc61:*=(_7infotripArray[arg1 + 41] & 240) >> 4;
            var loc188:*=_7infotripArray[arg1 + 41] & 15;
            var loc192:*=(_7infotripArray[arg1 + 40] & 240) >> 4;
            var loc190:*=_7infotripArray[arg1 + 40] & 15;
            if (loc61 != 15) 
            {
                loc168.maximumTemperature = loc138.convert(parseFloat(loc61.toString() + loc188.toString() + loc192.toString() + "." + loc190.toString()));
            }
            else 
            {
                loc125 = "-" + loc188.toString() + loc192.toString() + "." + loc190.toString();
                loc168.maximumTemperature = loc138.convert(new Number(loc125));
            }
            var loc155:*=(_7infotripArray[arg1 + 43] & 240) >> 4;
            var loc200:*=_7infotripArray[arg1 + 43] & 15;
            var loc201:*=(_7infotripArray[arg1 + 42] & 240) >> 4;
            var loc191:*=_7infotripArray[arg1 + 42] & 15;
            var loc210:*;
            (loc210 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc210.outputFormat = "millimeter";
            if (loc155 != 15) 
            {
                loc168.maximumAltitude = loc210.convert(parseInt(loc155.toString() + loc200.toString() + loc201.toString() + loc191.toString(), 10));
            }
            else 
            {
                loc78 = "-" + loc200.toString() + loc201.toString() + loc191.toString();
                loc168.maximumAltitude = loc210.convert(new Number(loc78));
            }
            var loc34:*=(_7infotripArray[arg1 + 44] & 240) >> 4;
            var loc95:*=_7infotripArray[arg1 + 44] & 15;
            var loc85:*=(_7infotripArray[arg1 + 45] & 240) >> 4;
            var loc18:*=_7infotripArray[arg1 + 45] & 15;
            var loc83:*=(_7infotripArray[arg1 + 46] & 240) >> 4;
            var loc2:*=_7infotripArray[arg1 + 46] & 15;
            var loc154:*=loc83.toString() + loc2.toString() + loc85.toString() + loc18.toString() + "." + loc34.toString() + loc95.toString();
            loc168.distanceUphill = loc50.convert(new Number(loc154)) * 1000;
            var loc194:*=_7infotripArray[arg1 + 50] & 15;
            var loc13:*=(_7infotripArray[arg1 + 49] & 240) >> 4;
            var loc193:*=_7infotripArray[arg1 + 49] & 15;
            var loc196:*=(_7infotripArray[arg1 + 48] & 240) >> 4;
            var loc57:*=_7infotripArray[arg1 + 48] & 15;
            var loc195:*=(_7infotripArray[arg1 + 47] & 240) >> 4;
            var loc73:*=_7infotripArray[arg1 + 47] & 15;
            var loc129:*=parseInt(loc194.toString() + loc13.toString() + loc193.toString());
            var loc56:*=parseInt(loc196.toString() + loc57.toString());
            var loc180:*=parseInt(loc195.toString() + loc73.toString());
            loc168.trainingTimeUphill = (loc129 * 3600 + loc56 * 60 + loc180) * 100;
            var loc165:*=(_7infotripArray[arg1 + 52] & 240) >> 4;
            var loc164:*=_7infotripArray[arg1 + 52] & 15;
            var loc162:*=(_7infotripArray[arg1 + 51] & 240) >> 4;
            var loc1:*=_7infotripArray[arg1 + 51] & 15;
            var loc161:*=(_7infotripArray[arg1 + 50] & 240) >> 4;
            var loc94:*=loc165.toString() + loc164.toString() + loc162.toString() + "." + loc1.toString() + loc161.toString();
            loc168.averageSpeedUphill = loc152.convert(new Number(loc94));
            var loc109:*=(_7infotripArray[arg1 + 53] & 240) >> 4;
            var loc110:*=_7infotripArray[arg1 + 53] & 15;
            var loc146:*=loc109.toString() + loc110.toString();
            loc168.averageInclineUphill = parseInt(loc146, 10);
            var loc202:*=(_7infotripArray[arg1 + 54] & 240) >> 4;
            var loc186:*=_7infotripArray[arg1 + 54] & 15;
            var loc184:*=loc202.toString() + loc186.toString();
            loc168.maximumInclineUphill = parseInt(loc184, 10);
            var loc60:*=(_7infotripArray[arg1 + 56] & 240) >> 4;
            var loc101:*=_7infotripArray[arg1 + 56] & 15;
            var loc103:*=(_7infotripArray[arg1 + 55] & 240) >> 4;
            var loc208:*=_7infotripArray[arg1 + 55] & 15;
            var loc98:*;
            var loc171:*=(loc98 = _7infotripArray[arg1 + 57] & 15).toString() + loc60.toString() + loc101.toString() + loc103.toString() + loc208.toString();
            loc168.altitudeDifferencesUphill = loc210.convert(parseInt(loc171, 10));
            var loc166:*=(_7infotripArray[arg1 + 59] & 240) >> 4;
            var loc10:*=_7infotripArray[arg1 + 59] & 15;
            var loc16:*=(_7infotripArray[arg1 + 58] & 240) >> 4;
            var loc96:*=_7infotripArray[arg1 + 58] & 15;
            var loc12:*=(_7infotripArray[arg1 + 57] & 240) >> 4;
            var loc124:*=loc166.toString() + loc10.toString() + loc16.toString() + loc96.toString() + loc12.toString();
            loc168.altitudeDifferencesDownhill = loc210.convert(parseInt(loc124, 10));
            var loc207:*=(_7infotripArray[arg1 + 62] & 240) >> 4;
            var loc133:*=_7infotripArray[arg1 + 62] & 15;
            var loc132:*=(_7infotripArray[arg1 + 61] & 240) >> 4;
            var loc197:*=_7infotripArray[arg1 + 61] & 15;
            var loc131:*=(_7infotripArray[arg1 + 60] & 240) >> 4;
            var loc174:*=_7infotripArray[arg1 + 60] & 15;
            var loc105:*=loc207.toString() + loc133.toString() + loc132.toString() + loc197.toString() + "." + loc131.toString() + loc174.toString();
            loc168.distanceDownhill = loc50.convert(new Number(loc105)) * 1000;
            var loc3:*=(_7infotripArray[arg1 + 63] & 240) >> 4;
            var loc141:*=_7infotripArray[arg1 + 63] & 15;
            var loc144:*=(_7infotripArray[arg1 + 64] & 240) >> 4;
            var loc26:*=_7infotripArray[arg1 + 64] & 15;
            var loc145:*=(_7infotripArray[arg1 + 65] & 240) >> 4;
            var loc46:*=_7infotripArray[arg1 + 65] & 15;
            var loc140:*=_7infotripArray[arg1 + 66] & 15;
            var loc206:*=parseInt(loc140.toString() + loc145.toString() + loc46.toString());
            var loc117:*=parseInt(loc144.toString() + loc26.toString());
            var loc137:*=parseInt(loc3.toString() + loc141.toString());
            loc168.trainingTimeDownhill = (loc206 * 3600 + loc117 * 60 + loc137) * 100;
            var loc149:*=(_7infotripArray[arg1 + 68] & 240) >> 4;
            var loc40:*=_7infotripArray[arg1 + 68] & 15;
            var loc42:*=(_7infotripArray[arg1 + 67] & 240) >> 4;
            var loc53:*=_7infotripArray[arg1 + 67] & 15;
            var loc38:*=(_7infotripArray[arg1 + 66] & 240) >> 4;
            var loc90:*=loc149.toString() + loc40.toString() + loc42.toString() + "." + loc53.toString() + loc38.toString();
            loc168.averageSpeedDownhill = loc152.convert(new Number(loc90));
            var loc181:*=(_7infotripArray[arg1 + 69] & 240) >> 4;
            var loc142:*=_7infotripArray[arg1 + 69] & 15;
            var loc148:*=loc181.toString() + loc142.toString();
            loc168.averageInclineDownhill = parseInt(loc148, 10);
            var loc65:*=(_7infotripArray[arg1 + 70] & 240) >> 4;
            var loc209:*=_7infotripArray[arg1 + 70] & 15;
            var loc160:*=loc65.toString() + loc209.toString();
            loc168.maximumInclineDownhill = parseInt(loc160, 10);
            var loc170:*=(_7infotripArray[arg1 + 72] & 112) >> 4;
            var loc67:*=_7infotripArray[arg1 + 72] & 15;
            var loc68:*=(_7infotripArray[arg1 + 71] & 240) >> 4;
            var loc139:*=_7infotripArray[arg1 + 71] & 15;
            var loc118:*=loc170.toString() + loc67.toString() + loc68.toString() + loc139.toString();
            loc168.wheelSize = parseInt(loc118);
            var loc205:*=(_7infotripArray[arg1 + 73] & 240) >> 4;
            var loc134:*=_7infotripArray[arg1 + 73] & 15;
            var loc91:*=loc205.toString(16) + loc134.toString(16);
            loc168.hrMax = parseInt(loc91, 16);
            var loc175:*=(_7infotripArray[arg1 + 74] & 240) >> 4;
            var loc48:*=_7infotripArray[arg1 + 74] & 15;
            var loc71:*=loc175.toString(16) + loc48.toString(16);
            loc168.zone1Start = parseInt(loc71, 16);
            var loc211:*=(_7infotripArray[arg1 + 75] & 240) >> 4;
            var loc22:*=_7infotripArray[arg1 + 75] & 15;
            var loc92:*=loc211.toString(16) + loc22.toString(16);
            loc168.zone2Start = parseInt(loc92, 16);
            var loc203:*=(_7infotripArray[arg1 + 76] & 240) >> 4;
            var loc214:*=_7infotripArray[arg1 + 76] & 15;
            var loc29:*=loc203.toString(16) + loc214.toString(16);
            loc168.zone3Start = parseInt(loc29, 16);
            var loc151:*=(_7infotripArray[arg1 + 77] & 240) >> 4;
            var loc93:*=_7infotripArray[arg1 + 77] & 15;
            var loc80:*=loc151.toString(16) + loc93.toString(16);
            loc168.zone3End = parseInt(loc80, 16);
            var loc15:*=_7infotripArray[arg1 + 79].toString(16);
            var loc4:*=_7infotripArray[arg1 + 78].toString(16);
            var loc147:*=parseFloat(loc15 + "." + loc4);
            var loc204:*=new utils.converter.ExpansionConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc204.inputFormat = "feet";
                }
            }
            else 
            {
                loc204.inputFormat = "meter";
            }
            loc204.outputFormat = "meter";
            loc168.averageExpansion = loc204.convert(loc147);
            var loc116:*=parseInt(_7infotripArray[arg1 + 81].toString(16), 10);
            var loc119:*=parseInt(_7infotripArray[arg1 + 80].toString(16), 10);
            loc168.averagePower = loc116 * 100 + loc119;
            var loc5:*=parseInt(_7infotripArray[arg1 + 83].toString(16), 10);
            var loc9:*=parseInt(_7infotripArray[arg1 + 82].toString(16), 10);
            loc168.maximumPower = loc5 * 100 + loc9;
            var loc81:*=_7infotripArray[arg1 + 85].toString(16) + "." + _7infotripArray[arg1 + 84].toString(16);
            loc168.averageExpansionUphill = parseFloat(loc81);
            var loc111:*=_7infotripArray[arg1 + 86];
            var loc215:*=0;
            loc54 = 0;
            while (loc54 < 86) 
            {
                loc215 = loc215 + _7infotripArray[arg1 + loc54];
                ++loc54;
            }
            loc215 = loc215 & 255;
            if (loc111 == loc215) 
            {
            };
            return loc168;
        }

        internal function decodeTripList():Array
        {
            var loc2:*=_7infotripArray[609] & 15;
            var loc1:*=(_7infotripArray[609] & 240) >> 4;
            if (_7infotripArray[610] == _7infotripArray[609]) 
            {
            };
            if (!(!(_7infotripArray[611] == 212) || !(_7infotripArray[612] == 116) || !(_7infotripArray[613] == 148) || !(_7infotripArray[614] == 53))) 
            {
            };
            var loc3:*=new Array(2);
            loc3[0] = loc2;
            loc3[1] = loc1;
            return loc3;
        }

        internal function setFavIndex(arg1:String):int
        {
            if (core.general.FavoritesROX2010.FAVORITES_GUI.indexOf(arg1) == 53) 
            {
                return 9;
            }
            return core.general.FavoritesROX2010.FAVORITES.indexOf(arg1);
        }

        internal function calculateValuesFromBasisValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.Activity
        {
            if (arg1.zone1Start <= arg2.heartrate && arg1.zone2Start > arg2.heartrate) 
            {
                arg2.targetZone = 1;
                arg1.timeInZone1 = arg1.timeInZone1 + arg2.trainingTime;
            }
            else if (arg1.zone2Start <= arg2.heartrate && arg1.zone3Start > arg2.heartrate) 
            {
                arg2.targetZone = 2;
                arg1.timeInZone2 = arg1.timeInZone2 + arg2.trainingTime;
            }
            else if (arg1.zone3Start <= arg2.heartrate && arg1.zone3End > arg2.heartrate) 
            {
                arg2.targetZone = 3;
                arg1.timeInZone3 = arg1.timeInZone3 + arg2.trainingTime;
            }
            else 
            {
                arg2.targetZone = 0;
                arg1.timeOutOfZone = arg1.timeOutOfZone + arg2.trainingTime;
            }
            if (arg3 != null) 
            {
                arg2.distance = calculateDistance(arg1.wheelSize, arg2.relativeRotations);
                if (arg1.entries.length > 0) 
                {
                    arg2.distanceAbsolute = arg3.distanceAbsolute + arg2.distance;
                    arg2.trainingTimeAbsolute = arg3.trainingTimeAbsolute + arg2.trainingTime;
                }
                if (arg3.altitude < arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesUphill = arg2.altitude - arg3.altitude;
                    arg2.distanceUphill = arg2.distance;
                    arg2.trainingTimeUphill = arg2.trainingTime;
                    arg1.distanceUphill = arg1.distanceUphill + arg2.distanceUphill;
                    arg1.trainingTimeUphill = arg1.trainingTimeUphill + arg2.trainingTimeUphill;
                    arg1.altitudeDifferencesUphill = arg1.altitudeDifferencesUphill + arg2.altitudeDifferencesUphill;
                }
                else if (arg3.altitude > arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesDownhill = arg3.altitude - arg2.altitude;
                    arg2.distanceDownhill = arg2.distance;
                    arg2.trainingTimeDownhill = arg2.trainingTime;
                    arg1.distanceDownhill = arg1.distanceDownhill + arg2.distanceDownhill;
                    arg1.trainingTimeDownhill = arg1.trainingTimeDownhill + arg2.trainingTimeDownhill;
                    arg1.altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill + arg2.altitudeDifferencesDownhill;
                }
                else 
                {
                    arg2.altitudeDifferencesDownhill = 0;
                    arg2.distanceDownhill = 0;
                    arg2.trainingTimeDownhill = 0;
                    arg2.altitudeDifferencesUphill = 0;
                    arg2.distanceUphill = 0;
                    arg2.trainingTimeUphill = 0;
                }
            }
            arg1.pauseTime = arg1.pauseTime + arg2.pauseTime;
            arg1.trainingTime = arg1.trainingTime + arg2.trainingTime;
            arg1.distance = arg1.distance + arg2.distance;
            return arg1;
        }

        internal function calcMinMaxValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry, arg3:int):core.activities.Activity
        {
            if (arg1.minimumSpeed > arg2.speed || isNaN(arg1.minimumSpeed) || arg3 == 0) 
            {
                arg1.minimumSpeed = arg2.speed;
            }
            if (arg1.maximumSpeed < arg2.speed || isNaN(arg1.maximumSpeed) || arg3 == 0) 
            {
                arg1.maximumSpeed = arg2.speed;
            }
            if (arg1.minimumAltitude > arg2.altitude || isNaN(arg1.minimumAltitude) || arg3 == 0) 
            {
                arg1.minimumAltitude = arg2.altitude;
            }
            if (arg1.maximumAltitude < arg2.altitude || isNaN(arg1.maximumAltitude) || arg3 == 0) 
            {
                arg1.maximumAltitude = arg2.altitude;
            }
            if (arg1.minimumHeartrate > arg2.heartrate || isNaN(arg1.minimumHeartrate) || arg3 == 0) 
            {
                arg1.minimumHeartrate = arg2.heartrate;
            }
            if (arg1.maximumHeartrate < arg2.heartrate || isNaN(arg1.maximumHeartrate) || arg3 == 0) 
            {
                arg1.maximumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumTemperature > arg2.temperature || isNaN(arg1.minimumTemperature) || arg3 == 0) 
            {
                arg1.minimumTemperature = arg2.temperature;
            }
            if (arg1.maximumTemperature < arg2.temperature || isNaN(arg1.maximumTemperature) || arg3 == 0) 
            {
                arg1.maximumTemperature = arg2.temperature;
            }
            if (arg1.minimumCadence > arg2.cadence || isNaN(arg1.minimumCadence) || arg3 == 0) 
            {
                arg1.minimumCadence = arg2.cadence;
            }
            if (arg1.maximumCadence < arg2.cadence || isNaN(arg1.maximumCadence) || arg3 == 0) 
            {
                arg1.maximumCadence = arg2.cadence;
            }
            if (arg1.minimumPower > arg2.power || isNaN(arg1.minimumPower) || arg3 == 0) 
            {
                arg1.minimumPower = arg2.power;
            }
            if (arg1.maximumPower < arg2.power || isNaN(arg1.maximumPower) || arg3 == 0) 
            {
                arg1.maximumPower = arg2.power;
            }
            if (arg1.minimumIncline > arg2.incline || isNaN(arg1.minimumIncline) || arg3 == 0) 
            {
                arg1.minimumIncline = arg2.incline;
            }
            if (arg1.maximumIncline < arg2.incline || isNaN(arg1.maximumIncline) || arg3 == 0) 
            {
                arg1.maximumIncline = arg2.incline;
            }
            if (arg1.minimumRiseRate > arg2.riseRate || isNaN(arg1.minimumRiseRate) || arg3 == 0) 
            {
                arg1.minimumRiseRate = arg2.riseRate;
            }
            if (arg1.maximumRiseRate < arg2.riseRate || isNaN(arg1.maximumRiseRate) || arg3 == 0) 
            {
                arg1.maximumRiseRate = arg2.riseRate;
            }
            return arg1;
        }

        internal function calcAverages(arg1:core.activities.Activity, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):core.activities.Activity
        {
            var loc1:*=arg8;
            arg1.averageAltitude = arg3 / loc1;
            arg1.averageHeartrate = arg4 / loc1;
            arg1.averageSpeed = arg2 / loc1;
            arg1.averageTemperature = arg5 / loc1;
            arg1.averageCadence = arg6 / loc1;
            arg1.averagePower = arg7 / loc1;
            return arg1;
        }

        internal function makeAbsolutEntry(arg1:core.activities.ActivityEntry, arg2:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            arg1.temperature = arg2.temperature;
            if (!(arg1.temperature > 40)) 
            {
            };
            return arg1;
        }

        internal function calculateRotations(arg1:Number, arg2:Number):int
        {
            var loc1:*=0;
            if (arg1 < arg2) 
            {
                loc1 = arg1 - arg2 + 1024;
            }
            else 
            {
                loc1 = arg1 - arg2;
            }
            return loc1;
        }

        internal function calculateDistance(arg1:int, arg2:int):Number
        {
            return Math.round(arg1 * arg2) / 1000;
        }

        internal function isPause(arg1:Array):Boolean
        {
            if ((arg1[0] & 1) == 0) 
            {
                return false;
            }
            return true;
        }

        internal function decodeAbsLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc7:*=0;
            var loc11:*=0;
            var loc3:*=0;
            var loc9:*;
            (loc9 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc9.isWaypoint = true;
            }
            else 
            {
                loc9.isWaypoint = false;
            }
            var loc13:*;
            var loc14:*=(loc13 = (arg1[0] & 252) >> 2) - 10;
            loc9.temperature = loc14;
            var loc4:*;
            if ((loc4 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc9.heartrate = loc4;
            var loc10:*;
            if ((loc10 = arg1[2]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc9.cadence = loc10;
            var loc5:*=arg1[3] - 99;
            loc9.incline = loc5;
            if ((loc7 = (loc7 = (loc7 = (arg1[5] & 15) << 8) | arg1[4]) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc9.altitude = loc7 * 1000;
            var loc12:*=(loc12 = arg1[5] >> 5) | arg1[6] << 3;
            loc9.power = loc12;
            var loc8:*=0;
            loc8 = (loc8 = (arg1[8] & 3) << 8) | arg1[7];
            loc9.rotations = loc8;
            if ((loc11 = (loc11 = (arg1[9] & 15) << 6) | (arg1[8] & 252) >> 2) < 1 && loc11 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc9.speed = loc11 * 0.2;
            loc9.trainingTime = arg2.samplingRate * 100;
            var loc1:*=arg1[10];
            var loc2:*=0;
            loc3 = 0;
            while (loc3 < 10) 
            {
                loc2 = (loc2 = loc2 + arg1[loc3]) & 255;
                ++loc3;
            }
            if (loc2 == loc1) 
            {
            };
            return loc9;
        }

        internal function decodeAbsLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc7:*;
            (loc7 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = true;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc7.isWaypoint = true;
            }
            else 
            {
                loc7.isWaypoint = false;
            }
            var loc12:*;
            var loc14:*=(loc12 = (arg1[0] & 252) >> 2) - 10;
            loc7.temperature = loc14;
            var loc5:*;
            if ((loc5 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc7.heartrate = loc5;
            var loc8:*;
            if ((loc8 = arg1[2]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc7.cadence = loc8;
            var loc10:*;
            if ((loc10 = (loc10 = (loc10 = arg1[3]) | (arg1[4] & 31) << 8) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc7.altitude = loc10 * 1000;
            var loc11:*=(loc11 = (arg1[4] & 224) >> 5) | arg1[5] << 3;
            loc7.power = loc11;
            var loc2:*;
            if ((loc2 = arg1[6] & 63) != 63) 
            {
                loc7.trainingTime = loc2;
            }
            var loc13:*=(loc13 = arg1[7]) | (arg1[8] & 3) << 8;
            loc7.rotations = loc13;
            var loc9:*=(loc9 = (arg1[8] & 252) >> 2) | arg1[9] << 6;
            loc7.pauseTime = loc9 * 100;
            var loc1:*=arg1[10];
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 10) 
            {
                loc3 = (loc3 = loc3 + arg1[loc4]) & 31;
                ++loc4;
            }
            if (loc3 != loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc7;
        }

        internal function decodeRelLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = false;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc7:*=0;
            loc7 = (loc7 = (arg1[1] & 15) << 6) | (arg1[0] & 252) >> 2;
            loc1.rotations = loc7;
            var loc9:*;
            if ((loc9 = (loc9 = (arg1[1] & 240) >> 4) | (arg1[2] & 63) << 4) < 1 && loc9 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc1.speed = loc9 * 0.2;
            var loc5:*=arg1[3] - 99;
            loc1.incline = loc5;
            var loc8:*;
            if ((loc8 = arg1[4]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc1.cadence = loc8;
            var loc10:*=0;
            if ((loc10 = arg1[5]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc10;
            var loc11:*;
            if ((loc11 = (loc11 = (loc11 = (arg1[7] & 15) << 8) | arg1[6]) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc11 * 1000;
            var loc12:*=(loc12 = arg1[7] >> 5) | arg1[8] << 3;
            loc1.power = loc12;
            loc1.trainingTime = arg2.samplingRate * 100;
            var loc2:*=arg1[9];
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 9) 
            {
                loc3 = (loc3 = loc3 + arg1[loc4]) & 31;
                ++loc4;
            }
            if (loc3 == loc2) 
            {
            };
            return loc1;
        }

        internal function decodeRelLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc5:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = true;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc2:*;
            if ((loc2 = (arg1[0] & 252) >> 2) != 63) 
            {
                loc1.trainingTime = loc2;
            }
            var loc9:*=(loc9 = arg1[1]) | (arg1[2] & 63) << 8;
            loc1.pauseTime = loc9 * 100;
            var loc12:*=(loc12 = (arg1[2] & 192) >> 6) | arg1[3] << 2;
            loc1.rotations = loc12;
            var loc7:*;
            if ((loc7 = arg1[4]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc1.cadence = loc7;
            var loc8:*;
            if ((loc8 = arg1[5]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc8;
            var loc10:*;
            if ((loc10 = (loc10 = (loc10 = arg1[6]) | (arg1[7] & 31) << 8) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc10 * 1000;
            var loc11:*=(loc11 = (arg1[7] & 224) >> 5) | arg1[8] << 3;
            loc1.power = loc11;
            var loc3:*=arg1[9];
            var loc4:*=0;
            loc5 = 0;
            while (loc5 < 9) 
            {
                loc4 = (loc4 = loc4 + arg1[loc5]) & 31;
                ++loc5;
            }
            if (loc4 != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc1;
        }

        internal function smoothEntries_v1(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc6:*=null;
            var loc18:*=null;
            var loc21:*=null;
            var loc5:*=null;
            var loc1:*=null;
            var loc10:*=NaN;
            var loc17:*=0;
            var loc14:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc12:*=NaN;
            var loc16:*=arg1.entries;
            var loc20:*=0;
            var loc4:*=0;
            var loc19:*=0;
            var loc2:*=0;
            var loc13:*=0;
            var loc11:*=0;
            var loc3:*=0;
            var loc9:*=0;
            var loc15:*=0;
            loc10 = 0;
            while (loc10 < loc16.length) 
            {
                loc6 = loc16[loc10];
                if (loc10 > 0) 
                {
                    loc18 = loc16[(loc10 - 1)];
                    loc6.relativeRotations = calculateRotations(loc6.rotations, loc18.rotations);
                }
                if (loc10 < (loc16.length - 1)) 
                {
                    (loc5 = loc16[loc10 + 1]).relativeRotations = calculateRotations(loc5.rotations, loc6.rotations);
                }
                if (loc10 < loc16.length - 2) 
                {
                    loc1 = loc16[loc10 + 2];
                    loc1.relativeRotations = calculateRotations(loc1.rotations, loc5.rotations);
                }
                if (loc10 > 1) 
                {
                    loc21 = loc16[loc10 - 2];
                }
                if (loc6.speed < 0.5 && loc6.speed > 0) 
                {
                    if (loc18 == null) 
                    {
                        loc6.speed = 0;
                        loc6.riseRate = 0;
                    }
                    else 
                    {
                        loc6.speed = loc18.speed;
                    }
                }
                if (loc6.altitude == 5000) 
                {
                    if (loc18 == null) 
                    {
                        loc6.altitude = 0;
                        loc6.incline = 0;
                        loc6.riseRate = 0;
                    }
                    else 
                    {
                        loc6.altitude = loc18.altitude;
                        loc6.incline = loc18.incline;
                        loc6.riseRate = loc18.riseRate;
                    }
                }
                if (loc6.heartrate <= 20) 
                {
                    if (loc18 == null) 
                    {
                        loc6.heartrate = 0;
                    }
                    else 
                    {
                        loc6.heartrate = loc18.heartrate;
                    }
                }
                if (loc6.cadence == 10) 
                {
                    if (loc18 == null) 
                    {
                        loc6.cadence = 0;
                    }
                    else 
                    {
                        loc6.cadence = loc18.cadence;
                    }
                }
                if (loc10 == 0) 
                {
                    loc6.trainingTime = 0;
                }
                if (loc6.isPause && !(loc18 == null) && loc18.isPause) 
                {
                    loc18.pauseTime = loc18.pauseTime + loc6.pauseTime;
                    loc18.relativeRotations = loc18.relativeRotations + loc6.relativeRotations;
                    loc18.trainingTime = loc18.trainingTime + loc6.trainingTime;
                    loc18.speed = (loc18.speed + loc6.speed) / 2;
                    loc18.incline = (loc18.incline + loc6.incline) / 2;
                    loc18.riseRate = loc18.speed * 3.6 / 0.06 * loc18.incline / 100 * 1000;
                    loc18.altitude = (loc18.altitude + loc6.altitude) / 2;
                    loc18.temperature = (loc18.temperature + loc6.temperature) / 2;
                    loc18.heartrate = (loc18.heartrate + loc6.heartrate) / 2;
                    loc18.cadence = (loc18.cadence + loc6.cadence) / 2;
                    loc18.power = (loc18.power + loc6.power) / 2;
                    if (loc18.isWaypoint || loc6.isWaypoint) 
                    {
                        loc18.isWaypoint = true;
                    }
                    handler.ActivityCalculator.removeEntryFromEntriesVector(loc16[loc10], loc16);
                    --loc10;
                }
                else 
                {
                    if (!(loc18 == null) && !(loc21 == null) && loc18.isPause) 
                    {
                        loc17 = loc21.relativeRotations * 0.7 / arg1.samplingRate * 100 * loc18.trainingTime;
                        if (loc18.trainingTime > 0 && loc17 == 0) 
                        {
                            loc17 = 1;
                        }
                        if ((loc14 = loc6.relativeRotations - loc17) < 0) 
                        {
                            loc14 = 0;
                            loc18.relativeRotations = loc6.relativeRotations;
                        }
                        else 
                        {
                            loc18.relativeRotations = loc17;
                        }
                        loc6.relativeRotations = loc14;
                        if (!loc6.isPause) 
                        {
                            loc21.trainingTime = loc21.trainingTime + loc18.trainingTime;
                            loc21.trainingTimeAbsolute = loc21.trainingTimeAbsolute + loc18.trainingTime;
                            loc21.relativeRotations = loc21.relativeRotations + loc18.relativeRotations;
                            loc18.trainingTime = 0;
                            loc18.trainingTimeAbsolute = loc21.trainingTimeAbsolute;
                            loc18.trainingTimeDownhill = 0;
                            loc18.trainingTimeUphill = 0;
                            loc18.relativeRotations = 0;
                            loc18.altitudeDifferencesDownhill = 0;
                            loc18.altitudeDifferencesUphill = 0;
                            loc18.distance = 0;
                            loc18.distanceDownhill = 0;
                            loc18.distanceUphill = 0;
                            loc18.temperature = loc21.temperature;
                            loc18.incline = 0;
                            loc18.riseRate = 0;
                            loc18.speed = 0;
                            loc18.cadence = 0;
                            loc18.power = 0;
                        }
                    }
                    if (arg1.samplingRate != 4.5) 
                    {
                        if (arg1.samplingRate == 10.125) 
                        {
                            if (loc6.heartrate == 0 && loc5 && loc18) 
                            {
                                if (loc5.heartrate != 0) 
                                {
                                    if (loc18 != null) 
                                    {
                                        loc6.heartrate = loc18.heartrate;
                                        ++loc9;
                                    }
                                }
                            }
                        }
                    }
                    else if (loc6.heartrate == 0 && loc18 && loc5 && loc1) 
                    {
                        if (loc5.heartrate != 0) 
                        {
                            if (loc18 != null) 
                            {
                                loc6.heartrate = loc18.heartrate;
                                ++loc9;
                            }
                        }
                        else if (loc1.heartrate != 0) 
                        {
                            if (loc18 != null) 
                            {
                                loc6.heartrate = loc18.heartrate;
                                loc5.heartrate = loc18.heartrate;
                                loc9 = loc9 + 2;
                            }
                        }
                    }
                }
                loc6.riseRate = loc6.speed * 3.6 / 0.06 * loc6.incline / 100 * 1000;
                loc6.calories = utils.Calculations.calculateCalories(arg1, loc6);
                loc15 = loc15 + loc6.calories;
                ++loc10;
            }
            utils.Calculations.calculateCaloriesDifferenceFactor(arg1, arg1.calories, loc15);
            arg1.pauseTime = 0;
            arg1.trainingTime = 0;
            arg1.distance = 0;
            loc12 = 0;
            while (loc12 < loc16.length) 
            {
                loc7 = loc16[loc12];
                if (loc12 > 0) 
                {
                    loc8 = loc16[(loc12 - 1)];
                }
                if (!loc7.isPause) 
                {
                    loc20 = loc20 + loc7.speed;
                    loc4 = loc4 + loc7.altitude;
                    loc19 = loc19 + loc7.heartrate;
                    loc2 = loc2 + loc7.temperature;
                    loc13 = loc13 + loc7.cadence;
                    loc11 = loc11 + loc7.power;
                    ++loc3;
                }
                arg1 = calculateValuesFromBasisValues(arg1, loc7, loc8);
                arg1 = calcMinMaxValues(arg1, loc7, loc12);
                loc16[loc12].calories = loc16[loc12].calories - loc16[loc12].calories * arg1.caloriesDifferenceFactor;
                ++loc12;
            }
            arg1.entries = loc16;
            arg1 = calcAverages(arg1, loc20, loc4, loc19, loc2, loc13, loc11, loc3);
            return arg1;
        }

        public static function getInstance():decoder.Rox2010Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox2010Decoder();
            }
            return _instance;
        }

        public static const MY_NAME:Array=["*", "+", "-", "=", ".", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "♥"];

        internal var _7infotripArray:Array;

        internal static var _instance:decoder.Rox2010Decoder;
    }
}


//  class Rox2012Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import utils.*;
    import utils.converter.*;
    
    public class Rox2012Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog, core.units.interfaces.ICodingTotals
    {
        public function Rox2012Decoder()
        {
            speedConverter = new utils.converter.SpeedConverter();
            super();
            speedConverter.inputFormat = "kmh";
            speedConverter.outputFormat = "ms";
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public static function getInstance():decoder.Rox2012Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox2012Decoder();
            }
            return _instance;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            return;
        }

        public function decodeBatteryInformation(arg1:core.units.UnitROX2012, arg2:Array):core.units.Unit
        {
            var loc2:*=(arg2[2] & 3) << 16 | arg2[1] << 8 | arg2[0];
            var loc3:*;
            if ((loc3 = (arg2[2] & 128) >> 7) != 0) 
            {
                arg1.unitBatteryStatus = true;
            }
            else 
            {
                arg1.unitBatteryStatus = false;
            }
            var loc1:*=(arg2[6] & 3) << 24 | arg2[5] << 16 | arg2[4] << 8 | arg2[3];
            var loc4:*=arg2[6] >> 4;
            var loc6:*=0;
            var loc5:*=0;
            loc5 = 0;
            while (loc5 < 6) 
            {
                loc6 = loc6 + arg2[loc5];
                ++loc5;
            }
            if ((loc6 = (loc6 = loc6 + ((arg2[6] & 15) >> 4)) & 15) != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10126, "RC2012Decoder > decodeBatteryInformation: incorrect checksum"));
            }
            return arg1;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            return null;
        }

        public function decodePageHeaderInformationCycling(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc7:*=0;
            var loc10:*=0;
            var loc5:*;
            (loc5 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log", core.general.LogType.CYCLING)).unit = arg2;
            decodePageHeaderCommon(arg1, loc5);
            if (loc5.stopAdress - 166 == 0) 
            {
                return null;
            }
            loc5.pageHeaderData = arg1;
            var loc3:*=(arg1[12] & 63) << 16 | arg1[11] << 8 | arg1[10];
            loc5.trainingTime = loc3 * 100;
            loc5.trainingTimeDefined = true;
            var loc1:*=arg1[14] > 127 ? "mph" : "kmh";
            loc5.speedUnit = loc1;
            loc5.speedUnitDefined = true;
            loc5.bodyWeightUnit = loc1 != "mph" ? "kg" : "lb";
            loc5.bodyWeightUnitDefined = true;
            var loc6:*=((arg1[14] & 127) << 8) + arg1[13];
            loc5.maximumSpeed = speedConverter.convert(loc6 / 100);
            loc5.maximumSpeedDefined = true;
            if (core.general.UnitType.ROX60.equals(arg2.type)) 
            {
                loc7 = arg1[18] >> 4 << 16 | arg1[16] << 8 | arg1[15];
                loc5.altitudeDifferencesUphill = loc7 * 100;
                loc5.altitudeDifferencesUphillDefined = true;
            }
            var loc2:*=arg1[18] << 8 | arg1[17];
            loc5.maxSpeedEntry = loc2;
            var loc4:*=arg1[24] << 16 | arg1[23] << 8 | arg1[22];
            loc5.distance = loc4;
            loc5.distanceDefined = true;
            var loc11:*=arg1[29] >> 7 << 16 | arg1[28] << 8 | arg1[27];
            loc5.calories = loc11;
            loc5.caloriesDefined = true;
            var loc9:*=arg1[31];
            loc5.bike = loc9 > 127 ? "bike2" : "bike1";
            var loc8:*=(arg1[33] & 15) << 8 | arg1[32];
            loc5.wheelSize = loc8;
            loc5.wheelSizeDefined = true;
            if (core.general.UnitType.ROX60.equals(arg2.type)) 
            {
                loc10 = (arg1[39] & 15) << 16 | arg1[38] << 8 | arg1[37];
                loc5.altitudeDifferencesDownhill = loc10 * 100;
                loc5.altitudeDifferencesDownhillDefined = true;
            }
            loc5.dateCode = loc3.toString(10) + loc5.startDate.toString();
            return loc5;
        }

        public function decodePageHeaderInformationPulse(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*;
            (loc4 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log", core.general.LogType.PULSE)).unit = arg2;
            decodePageHeaderCommon(arg1, loc4);
            if (loc4.stopAdress - 166 == 0) 
            {
                return null;
            }
            loc4.pageHeaderData = arg1;
            var loc1:*=arg1[14] > 127 ? "mph" : "kmh";
            loc4.bodyWeightUnit = loc1 != "mph" ? "kg" : "lb";
            loc4.bodyWeightUnitDefined = true;
            var loc3:*=(arg1[21] & 63) << 16 | arg1[20] << 8 | arg1[19];
            loc4.trainingTime = loc3 * 100;
            loc4.trainingTimeDefined = true;
            var loc5:*=(arg1[44] & 1) << 16 | arg1[41] << 8 | arg1[40];
            loc4.calories = loc5;
            loc4.caloriesDefined = true;
            if (core.general.UnitType.ROX60.equals(loc4.unitType)) 
            {
                loc6 = (arg1[44] & 15) << 16 | arg1[43] << 8 | arg1[42];
                loc4.altitudeDifferencesUphill = loc6 * 100;
                loc4.altitudeDifferencesUphillDefined = true;
                loc2 = (arg1[47] & 15) << 16 | arg1[46] << 8 | arg1[45];
                loc4.altitudeDifferencesDownhill = loc2 * 100;
                loc4.altitudeDifferencesDownhillDefined = true;
            }
            loc4.dateCode = loc3.toString(10) + loc4.startDate.toString();
            return loc4;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc17:*=NaN;
            var loc34:*=NaN;
            var loc37:*=null;
            var loc32:*=NaN;
            var loc4:*=0;
            var loc26:*=0;
            var loc1:*=arg1 as Array;
            var loc14:*;
            if ((loc14 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type)) is core.settings.interfaces.ISeaLevel) 
            {
                loc17 = ((loc1[1] & 7) << 8 | loc1[0]) / 10 + 900;
                (loc14 as core.settings.interfaces.ISeaLevel).seaLevel = loc17;
            }
            var loc28:*=(loc1[1] & 120) >> 3;
            var loc10:*=loc1[2] & 63;
            var loc30:*=loc1[2] & 64;
            (loc14 as core.settings.interfaces.ISpeedUnit).speedUnit = loc30 > 0 ? "mph" : "kmh";
            (loc14 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit = loc30 > 0 ? "lb" : "kg";
            var loc12:*=(loc1[5] & 3) << 16 | loc1[4] << 8 | loc1[3];
            (loc14 as core.settings.interfaces.IService).serviceInterval = loc12;
            var loc27:*=(loc1[5] & 252) >> 2;
            (loc14 as core.settings.interfaces.IClock).clock = new Date(null, null, null, loc28, loc10, loc27, null);
            var loc20:*=(loc1[7] & 15) << 8 | loc1[6];
            (loc14 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc20;
            var loc21:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc16:*=NaN;
            var loc7:*=NaN;
            var loc18:*=NaN;
            var loc8:*=0;
            var loc9:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
            var loc3:*=(arg1[3] & 15) << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0];
            var loc15:*=((arg1[7] & 252) << 2 | (arg1[3] & 240) >> 4) / 1000;
            var loc1:*=new utils.converter.DistanceConverter("meter", "meter");
            (loc9 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc1.convert(loc3 + loc15);
            var loc12:*=(arg1[7] & 3) << 24 | arg1[6] << 16 | arg1[5] << 8 | arg1[4];
            (loc9 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = loc12 * 100;
            var loc13:*=(arg1[11] & 15) << 24 | arg1[10] << 16 | arg1[9] << 8 | arg1[8];
            var loc4:*=((arg1[15] & 252) << 2 | (arg1[11] & 15) >> 4) / 1000;
            (loc9 as core.totals.interfaces.ITotalDistance2).totalDistance2 = loc1.convert(loc13 + loc4);
            var loc14:*=(arg1[15] & 3) << 24 | arg1[14] << 16 | arg1[13] << 8 | arg1[12];
            (loc9 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = loc14 * 100;
            var loc6:*=(arg1[25] & 4) >> 2 << 16 | arg1[17] << 8 | arg1[16];
            (loc9 as core.totals.interfaces.ITotalCal1).totalCal1 = loc6;
            var loc5:*=(arg1[25] & 8) >> 3 << 16 | arg1[19] << 8 | arg1[18];
            (loc9 as core.totals.interfaces.ITotalCal2).totalCal2 = loc5;
            var loc17:*=(arg1[25] & 16) >> 4 << 16 | arg1[21] << 8 | arg1[20];
            (loc9 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories = loc17;
            var loc10:*=(arg1[25] & 3) << 24 | arg1[24] << 16 | arg1[23] << 8 | arg1[22];
            (loc9 as core.totals.interfaces.ITotalHikingTime).totalHikingTime = loc10 * 100;
            if (loc9 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc16 = (loc16 = ((arg1[28] & 15) << 16 | arg1[27] << 8 | arg1[26]) * 0.1) + 0.01 * ((arg1[28] & 240) >> 4);
                (loc9 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc16);
            }
            if (loc9 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                loc7 = (loc7 = ((arg1[31] & 15) << 16 | arg1[30] << 8 | arg1[29]) * 0.1) + 0.01 * ((arg1[31] & 240) >> 4);
                (loc9 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc7);
            }
            if (loc9 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                loc18 = (loc18 = ((arg1[34] & 15) << 16 | arg1[33] << 8 | arg1[32]) * 0.1) + 0.01 * ((arg1[34] & 240) >> 4);
                (loc9 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc18);
            }
            var loc2:*=arg1[39] == 164 && arg1[38] == 163 && arg1[37] == 162 && arg1[36] == 161;
            var loc11:*=0;
            loc8 = 0;
            while (loc8 < 35) 
            {
                loc11 = loc11 + arg1[loc8];
                ++loc8;
            }
            if (!((loc11 = loc11 & 255) == arg1[35]) || !loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10128, "ROX2012Decoder > decodeTotals: incorrect checksum"));
                return null;
            }
            return loc9;
        }

        public function encodeSettingInfos(arg1:core.settings.Settings):Array
        {
            var loc6:*=0;
            var loc15:*=0;
            var loc18:*=NaN;
            var loc3:*=0;
            var loc8:*=0;
            var loc23:*=null;
            var loc19:*=NaN;
            var loc11:*=0;
            var loc17:*=0;
            var loc2:*=new Array(34);
            loc6 = 0;
            while (loc6 < loc2.length) 
            {
                loc2[loc6] = 0;
                ++loc6;
            }
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                loc15 = ((arg1 as core.settings.interfaces.ISeaLevel).seaLevel - 900) * 10;
                loc2[0] = loc15 & 255;
                loc2[1] = loc15 >> 8 & 7;
            }
            loc2[2] = loc2[2] & 191 | ((arg1 as core.settings.interfaces.ISpeedUnit).speedUnit != "mph" ? 0 : 64);
            var loc12:*=(arg1 as core.settings.interfaces.IService).serviceInterval;
            loc2[3] = loc12 & 255;
            loc2[4] = loc12 >> 8 & 255;
            loc2[5] = loc12 >> 16 & 3;
            var loc10:*=(arg1 as core.settings.interfaces.IClock).clock;
            loc2[1] = loc2[1] & 7 | loc10.hours << 3 & 248;
            loc2[2] = loc2[2] & 192 | loc10.minutes & 63;
            loc2[5] = loc2[5] & 3 | loc10.seconds << 2;
            var loc21:*=(arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            loc2[6] = loc21 & 255;
            loc2[7] = loc21 >> 8 & 15;
            var loc20:*=(arg1 as core.settings.interfaces.IWheelSize2).wheelSize2;
            loc2[8] = loc20 & 255;
            loc2[9] = loc20 >> 8 & 15;
            var loc1:*=(arg1 as core.settings.interfaces.IService).serviceStatusOn;
            loc2[9] = loc2[9] & 239 | (loc1 ? 16 : 0);
            var loc5:*=(arg1 as core.settings.interfaces.ITrainingZone).trainingZone != "fitZone" ? (arg1 as core.settings.interfaces.ITrainingZone).trainingZone != "fatZone" ? 2 : 1 : 0;
            loc2[9] = loc2[9] & 159 | loc5 << 5;
            var loc7:*=(arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm;
            loc2[9] = loc2[9] & 127 | (loc7 ? 0 : 128);
            loc2[10] = loc2[10] & 192 | (arg1 as core.settings.interfaces.IDate).date.date;
            loc2[11] = (arg1 as core.settings.interfaces.IDate).date.fullYear & 255;
            loc2[12] = loc2[12] & 240 | (arg1 as core.settings.interfaces.IDate).date.fullYear >> 8 & 15;
            loc2[12] = loc2[12] & 15 | (arg1 as core.settings.interfaces.IDate).date.month + 1 << 4;
            loc2[13] = (arg1 as core.settings.interfaces.IAge).age;
            var loc22:*=new utils.converter.WeightConverter("g", "kg").convert((arg1 as core.settings.interfaces.IBodyWeight).bodyWeight) * 100;
            loc2[15] = loc22 / 100;
            loc2[14] = loc22 - loc2[15] * 100;
            loc2[16] = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            loc2[17] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            loc2[18] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            loc2[19] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            loc2[20] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            loc2[21] = (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            loc2[22] = (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit;
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                if ((loc18 = new utils.converter.AltitudeConverter("millimeter", "meter").convert((arg1 as core.settings.interfaces.IActualAltitude).actualAltitude)) < 0) 
                {
                    loc2[24] = loc2[24] & 127 | 128;
                    loc18 = loc18 * -1;
                }
                loc3 = loc18;
                loc2[23] = loc3 & 255;
                loc2[24] = loc2[24] & 128 | loc3 >> 8 & 127;
                loc8 = loc18 * 10 - loc3 * 10;
                loc2[25] = loc8;
            }
            var loc9:*=0;
            var loc14:*;
            if ((loc14 = (arg1 as core.settings.interfaces.ILanguage).language) != "de") 
            {
                if (loc14 != "en") 
                {
                    if (loc14 != "fr") 
                    {
                        if (loc14 != "it") 
                        {
                            if (loc14 != "es") 
                            {
                                if (loc14 != "pl") 
                                {
                                    if (loc14 == "nl") 
                                    {
                                        loc9 = 6;
                                    }
                                }
                                else 
                                {
                                    loc9 = 5;
                                }
                            }
                            else 
                            {
                                loc9 = 4;
                            }
                        }
                        else 
                        {
                            loc9 = 3;
                        }
                    }
                    else 
                    {
                        loc9 = 2;
                    }
                }
                else 
                {
                    loc9 = 1;
                }
            }
            else 
            {
                loc9 = 0;
            }
            loc2[25] = loc2[25] & 143 | loc9 << 4 & 112;
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                loc23 = (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference;
                loc2[25] = loc2[25] & 127 | (loc23 != core.general.AltitudeReference.SEA_LEVEL ? 0 : 128);
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                if ((loc19 = new utils.converter.AltitudeConverter("millimeter", "meter").convert((arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1)) < 0) 
                {
                    loc2[27] = loc2[27] & 127 | 128;
                    loc19 = loc19 * -1;
                }
                loc11 = loc19;
                loc2[26] = loc11 & 255;
                loc2[27] = loc2[27] & 128 | loc11 >> 8 & 127;
                loc17 = loc19 * 10 - loc11 * 10;
                loc2[28] = loc8;
            }
            var loc4:*;
            if ((loc4 = (arg1 as core.settings.interfaces.IGender).gender) != "female") 
            {
                loc2[28] = loc2[28] & 239;
            }
            else 
            {
                loc2[28] = loc2[28] | 16;
            }
            var loc16:*=(arg1 as core.settings.interfaces.IContrast).contrast;
            loc2[28] = loc2[28] & 159 | loc16 << 5 & 96;
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                if ("MM/DD/YYYY" != (arg1 as core.settings.interfaces.IDateFormat).dateFormat) 
                {
                    loc2[28] = loc2[28] & 127;
                }
                else 
                {
                    loc2[28] = loc2[28] & 127 | 128;
                }
            }
            loc2[33] = 164;
            loc2[32] = 163;
            loc2[31] = 162;
            loc2[30] = 161;
            var loc13:*=0;
            loc6 = 0;
            while (loc6 < 29) 
            {
                loc13 = loc13 + loc2[loc6];
                ++loc6;
            }
            loc13 = loc13 & 255;
            loc2[29] = loc13;
            return loc2;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            return null;
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc17:*=NaN;
            var loc15:*=0;
            var loc6:*=NaN;
            var loc9:*=0;
            var loc22:*=NaN;
            var loc12:*=0;
            var loc2:*=new Array(40);
            var loc7:*=0;
            loc7 = 0;
            while (loc7 < loc2.length) 
            {
                loc2[loc7] = 0;
                ++loc7;
            }
            var loc3:*;
            var loc21:*;
            var loc8:*=loc21 = (loc3 = new utils.converter.DistanceConverter("meter", "meter")).convert((arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1);
            loc2[0] = loc8 & 255;
            loc2[1] = loc8 >> 8 & 255;
            loc2[2] = loc8 >> 16 & 255;
            loc2[3] = loc8 >> 24 & 15;
            var loc1:*=(loc21 - loc8) * 100;
            loc2[3] = loc2[3] & 15 | loc1 << 4;
            loc2[7] = loc1 >> 2 & 252;
            var loc14:*=(arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 / 100;
            loc2[4] = loc14 & 255;
            loc2[5] = loc14 >> 8 & 255;
            loc2[6] = loc14 >> 16 & 255;
            loc2[7] = loc2[7] & 252 | loc14 >> 24 & 3;
            var loc20:*;
            var loc11:*=loc20 = loc3.convert((arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2);
            loc2[8] = loc11 & 255;
            loc2[9] = loc11 >> 8 & 255;
            loc2[10] = loc11 >> 16 & 255;
            loc2[11] = loc11 >> 24 & 15;
            var loc18:*=(loc20 - loc11) * 100;
            loc2[11] = loc2[11] & 15 | loc18 << 4;
            loc2[15] = loc18 >> 2 & 252;
            var loc16:*=(arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 / 100;
            loc2[12] = loc16 & 255;
            loc2[13] = loc16 >> 8 & 255;
            loc2[14] = loc16 >> 16 & 255;
            loc2[15] = loc2[15] & 252 | loc16 >> 24 & 3;
            var loc5:*=(arg1 as core.totals.interfaces.ITotalCal1).totalCal1;
            loc2[16] = loc5 & 255;
            loc2[17] = loc5 >> 8 & 255;
            loc2[25] = loc5 >> 16 << 2 & 4;
            var loc4:*=(arg1 as core.totals.interfaces.ITotalCal2).totalCal2;
            loc2[18] = loc4 & 255;
            loc2[19] = loc4 >> 8 & 255;
            loc2[25] = loc2[25] & 247 | loc4 >> 16 << 3 & 8;
            var loc19:*=(arg1 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories;
            loc2[20] = loc19 & 255;
            loc2[21] = loc19 >> 8 & 255;
            loc2[25] = loc2[25] & 239 | loc19 >> 16 << 4 & 16;
            var loc10:*=(arg1 as core.totals.interfaces.ITotalHikingTime).totalHikingTime / 100;
            loc2[22] = loc10 & 255;
            loc2[23] = loc10 >> 8 & 255;
            loc2[24] = loc10 >> 16 & 255;
            loc2[25] = loc2[25] & 252 | loc10 >> 24 & 3;
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc17 = new utils.converter.AltitudeConverter("millimeter", "meter").convert((arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1) * 10;
                loc2[26] = loc17 & 255;
                loc2[27] = loc17 >> 8 & 255;
                loc2[28] = loc17 >> 16 & 15;
                loc15 = loc17 * 0.1;
                loc2[28] = loc2[28] & 15 | (loc17 * 0.1 - loc15) * 10 << 4 & 240;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                loc6 = new utils.converter.AltitudeConverter("millimeter", "meter").convert((arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2) * 10;
                loc2[29] = loc6 & 255;
                loc2[30] = loc6 >> 8 & 255;
                loc2[31] = loc6 >> 16 & 15;
                loc9 = loc6 * 0.1;
                loc2[31] = loc2[31] & 15 | (loc6 * 0.1 - loc9) * 10 << 4 & 240;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                loc22 = new utils.converter.AltitudeConverter("millimeter", "meter").convert((arg1 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude) * 10;
                loc2[32] = loc22 & 255;
                loc2[33] = loc22 >> 8 & 255;
                loc2[34] = loc22 >> 16 & 15;
                loc12 = loc22 * 0.1;
                loc2[34] = loc2[34] & 15 | (loc22 * 0.1 - loc12) * 10 << 4 & 240;
            }
            loc2[39] = 164;
            loc2[38] = 163;
            loc2[37] = 162;
            loc2[36] = 161;
            var loc13:*=0;
            loc7 = 0;
            while (loc7 < 35) 
            {
                loc13 = loc13 + loc2[loc7];
                ++loc7;
            }
            loc2[35] = loc13 & 255;
            return loc2;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc8:*=0;
            var loc24:*=null;
            var loc25:*=null;
            var loc26:*=null;
            var loc16:*=0;
            var loc20:*=null;
            var loc15:*=null;
            var loc2:*=null;
            var loc21:*=null;
            var loc6:*=null;
            var loc14:*=null;
            var loc3:*=0;
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc19:*=0;
            var loc22:*=0;
            var loc12:*=0;
            var loc5:*=false;
            var loc1:*=0;
            while (loc3 < (arg2.length - 1)) 
            {
            };
            var loc10:*=core.activities.ActivityFactory.createLogEntryFromLog(arg1);
            if (arg1.entries.length > 0) 
            {
                if ((loc26 = arg1.entries[0]) != null) 
                {
                    if (loc26.altitudeDefined) 
                    {
                        loc10.altitude = loc26.altitude;
                    }
                    if (loc26.heartrateDefined) 
                    {
                        loc10.heartrate = loc26.heartrate;
                    }
                    if (loc26.speedDefined) 
                    {
                        loc10.speed = loc26.speed;
                    }
                    if (loc26.temperatureDefined) 
                    {
                        loc10.temperature = loc26.temperature;
                    }
                    if (loc26.rotationsDefined) 
                    {
                        loc10.rotations = loc26.rotations;
                    }
                    if (loc26.cadenceDefined) 
                    {
                        loc10.cadence = loc26.cadence;
                    }
                }
            }
            arg1.entries.unshift(loc10);
            var loc13:*=arg1.calories;
            var loc11:*=arg1.altitudeDifferencesUphill;
            var loc4:*=arg1.altitudeDifferencesDownhill;
            handler.ActivityCalculator.calculateMinMaxAvgValues(arg1);
            arg1.altitudeDifferencesUphill = loc11;
            arg1.altitudeDifferencesDownhill = loc4;
            var loc18:*=0;
            var loc17:*=0;
            var loc9:*=0;
            var loc7:*=arg1.entries.length;
            var loc23:*=arg1.altitudeDifferencesUphillDefined;
            loc16 = 0;
            while (loc16 < loc7) 
            {
                if ((loc20 = arg1.entries[loc16]).calories == 0 && loc16 > 0) 
                {
                    loc20.calories = utils.Calculations.calculateCalories(arg1, loc20);
                }
                loc18 = loc18 + loc20.calories;
                if (loc23) 
                {
                    loc9 = loc9 + loc20.altitudeDifferencesUphill;
                }
                ++loc16;
            }
            utils.Calculations.calculateCaloriesDifferenceFactor(arg1, loc13, loc18);
            loc17 = arg1.altitudeDifferencesUphill / loc9;
            loc16 = 0;
            while (loc16 < loc7) 
            {
                loc2 = arg1.entries[loc16];
                if (loc16 > 0) 
                {
                    loc15 = arg1.entries[(loc16 - 1)];
                }
                if (loc23) 
                {
                    loc2.altitudeDifferencesUphill = loc2.altitudeDifferencesUphill * loc17;
                }
                arg1.entries[loc16].calories = arg1.entries[loc16].calories - arg1.entries[loc16].calories * arg1.caloriesDifferenceFactor;
                ++loc16;
            }
            return;
        }

        internal function decodePageHeaderCommon(arg1:Array, arg2:core.activities.Activity):void
        {
            var loc10:*=0;
            arg2.pageHeaderData = arg1;
            arg2.samplingRate = 10;
            arg2.samplingRateDefined = true;
            var loc20:*=arg1[0];
            arg2.hrMax = loc20;
            arg2.hrMaxDefined = true;
            var loc8:*=arg1[1];
            arg2.intensityZone1Start = Math.round(loc20 * loc8 / 100);
            arg2.intensityZone1StartDefined = true;
            var loc6:*=arg1[2];
            arg2.intensityZone2Start = Math.round(loc20 * loc6 / 100);
            arg2.intensityZone2StartDefined = true;
            var loc12:*=arg1[3];
            arg2.intensityZone3Start = Math.round(loc20 * loc12 / 100);
            arg2.intensityZone3StartDefined = true;
            var loc11:*=arg1[4];
            arg2.intensityZone4Start = Math.round(loc20 * loc11 / 100);
            arg2.intensityZone4StartDefined = true;
            arg2.intensityZone4End = loc20;
            arg2.intensityZone4EndDefined = true;
            var loc1:*=arg1[5];
            arg2.lowerLimit = loc1;
            arg2.lowerLimitDefined = true;
            var loc18:*=arg1[6];
            arg2.upperLimit = loc18;
            arg2.upperLimitDefined = true;
            var loc21:*=arg1[7];
            arg2.age = loc21;
            arg2.ageDefined = true;
            var loc9:*=new utils.converter.WeightConverter("kg", "g").convert(parseFloat(arg1[9] + "." + arg1[8]));
            arg2.bodyWeight = loc9;
            arg2.bodyWeightDefined = true;
            var loc5:*=arg1[26] << 8 | arg1[25];
            arg2.stopAdress = loc5;
            var loc13:*=arg1[29] & 31;
            var loc15:*=arg1[30] & 63;
            var loc7:*;
        }

        internal function getByteSizeCyclingLog(arg1:core.activities.Activity):uint
        {
            if (isROX5(arg1)) 
            {
                return 7;
            }
            return 9;
        }

        internal function getByteSizeCyclingPause(arg1:core.activities.Activity):uint
        {
            if (isROX5(arg1)) 
            {
                return 19;
            }
            return 21;
        }

        internal function getByteSizeCyclingLap(arg1:core.activities.Activity):uint
        {
            if (isROX5(arg1)) 
            {
                return 17;
            }
            return 23;
        }

        internal function getByteSizeRunning(arg1:core.activities.Activity):uint
        {
            if (isROX5(arg1)) 
            {
                return 4;
            }
            return 5;
        }

        internal function getByteSizeRunningPause(arg1:core.activities.Activity):uint
        {
            if (isROX5(arg1)) 
            {
                return 14;
            }
            return 16;
        }

        internal function isROX5(arg1:core.activities.Activity):Boolean
        {
            return arg1.unitType.toString() == core.general.UnitType.ROX50.toString();
        }

        internal function isROX6(arg1:core.activities.Activity):Boolean
        {
            return arg1.unitType.toString() == core.general.UnitType.ROX60.toString();
        }

        internal function decodeLogCycling(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc7:*=NaN;
            var loc9:*=NaN;
            var loc3:*=0;
            var loc6:*;
            (loc6 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            loc6.trainingTime = arg1.samplingRate * 100;
            if (arg4) 
            {
                loc6.trainingTime = loc6.trainingTime - arg3.trainingTimeAbsolute % (arg1.samplingRate * 100);
            }
            if (arg3 == null) 
            {
                loc6.trainingTimeAbsolute = loc6.trainingTime;
            }
            else 
            {
                loc6.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc6.trainingTime;
            }
            var loc10:*=(arg2[2] & 3) << 8 | arg2[1];
            loc6.rotations = loc10;
            loc6.distance = loc10 * arg1.wheelSize / 1000;
            if (arg4) 
            {
                loc6.distance = loc6.distance - arg3.tempUncorrectedDistance;
            }
            if (!(arg3 == null) && arg3.distanceDefined && arg3.distanceAbsoluteDefined) 
            {
                loc6.distanceAbsolute = (arg3.distanceAbsolute * 1000 + loc6.distance * 1000) / 1000;
            }
            else 
            {
                loc6.distanceAbsolute = loc6.distance;
            }
            var loc1:*=arg2[2] >> 2;
            loc6.temperature = loc1 - 10;
            var loc2:*=speedConverter.convert(((arg2[4] & 127) << 8 | arg2[3]) / 100);
            loc6.speed = loc2;
            if (loc6.speed > 0) 
            {
                loc6.speedTime = Math.floor(1000 / loc6.speed);
            }
            else 
            {
                loc6.speedTime = 1200;
            }
            var loc4:*=arg2[5];
            loc6.heartrate = loc4;
            var loc11:*=arg2[6];
            loc6.cadence = loc11;
            if (loc6.altitudeDefined) 
            {
                loc7 = (arg2[8] & 127) << 8 | arg2[7];
                if (arg2[8] > 127) 
                {
                    loc7 = loc7 * -1;
                }
                loc6.altitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc7);
            }
            if (!(arg3 == null) && loc6.altitudeDefined) 
            {
                if ((loc9 = loc6.altitude - arg3.altitude) > 0) 
                {
                    if (loc6.altitudeDifferencesUphillDefined) 
                    {
                        loc6.altitudeDifferencesUphill = loc9;
                    }
                    if (loc6.distanceDefined && loc6.distanceUphillDefined) 
                    {
                        loc6.distanceUphill = loc6.distance;
                    }
                    if (loc6.trainingTimeUphillDefined) 
                    {
                        loc6.trainingTimeUphill = loc6.trainingTime;
                    }
                }
                else if (loc9 < 0) 
                {
                    if (loc6.altitudeDifferencesDownhillDefined) 
                    {
                        loc6.altitudeDifferencesDownhill = Math.abs(loc9);
                    }
                    if (loc6.distanceDefined && loc6.distanceDownhillDefined) 
                    {
                        loc6.distanceDownhill = loc6.distance;
                    }
                    if (loc6.trainingTimeDownhillDefined) 
                    {
                        loc6.trainingTimeDownhill = loc6.trainingTime;
                    }
                }
            }
            var loc5:*=arg2[0] & 15;
            var loc8:*=arg2[0] >> 4;
            loc3 = 1;
            while (loc3 < arg2.length) 
            {
                loc5 = loc5 + arg2[loc3];
                ++loc3;
            }
            if ((loc5 = loc5 & 15) != loc8) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10130, "ROX2012Decoder > decodeLogCycling: incorrect checksum"));
            }
            return loc6;
        }

        internal function decodeLogCyclingLapROX50(arg1:uint, arg2:core.activities.Activity, arg3:Array, arg4:core.activities.ActivityEntry=null, arg5:core.marker.Marker=null):core.marker.Marker
        {
            var loc4:*=0;
            var loc12:*;
            (loc12 = core.marker.MarkerFactory.createMarkerFromLog(arg2)).logReference = arg2;
            loc12.type = "l";
            loc12.number = (arg1 - 1);
            loc12.title = "";
            var loc5:*=arg3[7] << 16 | arg3[6] << 8 | arg3[5];
            loc12.distance = loc5 * arg2.wheelSize / 1000;
            if (!(arg5 == null) && arg5.distanceDefined && arg5.distanceAbsoluteDefined) 
            {
                loc12.distanceAbsolute = arg5.distanceAbsolute + loc12.distance;
            }
            else 
            {
                loc12.distanceAbsolute = loc12.distance;
            }
            var loc3:*=(arg3[4] >> 7 << 16 | arg3[2] << 8 | arg3[1]) / 1000;
            loc12.calories = loc3;
            var loc6:*=speedConverter.convert(((arg3[4] & 127) << 8 | arg3[3]) / 100);
            loc12.averageSpeed = loc6;
            var loc1:*=arg3[8];
            loc12.averageHeartrate = loc1;
            var loc2:*=arg3[9];
            loc12.maximumHeartrate = loc2;
            var loc10:*=arg3[10];
            loc12.averageCadence = loc10;
            var loc7:*=speedConverter.convert(((arg3[12] & 127) << 8 | arg3[11]) / 100);
            loc12.maximumSpeed = loc7;
            var loc9:*=((arg3[15] & 63) << 16 | arg3[14] << 8 | arg3[13]) * 100;
            loc12.time = loc9;
            if (arg5 == null) 
            {
                loc12.timeAbsolute = loc9;
            }
            else 
            {
                loc12.timeAbsolute = arg5.timeAbsolute + loc9;
            }
            var loc11:*=arg3[16];
            var loc8:*=arg3[0] & 15;
            loc4 = 1;
            while (loc4 < 16) 
            {
                loc8 = loc8 + arg3[loc4];
                ++loc4;
            }
            if ((loc8 = loc8 & 255) != loc11) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10131, "ROX2012Decoder > decodeLogCyclingLap: incorrect checksum"));
            }
            return loc12;
        }

        internal function decodeLogCyclingLapROX60(arg1:uint, arg2:core.activities.Activity, arg3:Array, arg4:core.activities.ActivityEntry=null, arg5:core.marker.Marker=null):core.marker.Marker
        {
            var loc5:*=0;
            var loc13:*;
            (loc13 = core.marker.MarkerFactory.createMarkerFromLog(arg2)).logReference = arg2;
            loc13.type = "l";
            loc13.number = (arg1 - 1);
            loc13.title = "";
            var loc10:*=((arg3[3] & 63) << 16 | arg3[2] << 8 | arg3[1]) * 100;
            loc13.time = loc10;
            if (arg5 == null) 
            {
                loc13.timeAbsolute = loc10;
            }
            else 
            {
                loc13.timeAbsolute = arg5.timeAbsolute + loc10;
            }
            var loc6:*=speedConverter.convert(((arg3[5] & 127) << 8 | arg3[4]) / 100);
            loc13.averageSpeed = loc6;
            var loc7:*=arg3[8] << 16 | arg3[7] << 8 | arg3[6];
            loc13.distance = loc7 * arg2.wheelSize / 1000;
            if (arg5 == null) 
            {
                loc13.distanceAbsolute = loc13.distance;
            }
            else 
            {
                loc13.distanceAbsolute = arg5.distanceAbsolute + loc13.distance;
            }
            var loc2:*=arg3[9];
            loc13.averageHeartrate = loc2;
            var loc3:*=arg3[10];
            loc13.maximumHeartrate = loc3;
            var loc11:*=arg3[11];
            loc13.averageCadence = loc11;
            var loc4:*=arg3[15] >> 7 << 16 | arg3[13] << 8 | arg3[12];
            loc13.calories = loc4;
            var loc8:*=speedConverter.convert(((arg3[15] & 127) << 8 | arg3[14]) / 100);
            loc13.maximumSpeed = loc8;
            var loc1:*=arg3[18] << 16 | arg3[17] << 8 | arg3[16];
            loc13.altitudeUphill = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc1 * 0.1);
            var loc14:*=arg3[21] << 16 | arg3[20] << 8 | arg3[19];
            loc13.altitudeDownhill = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc14 * 0.1);
            var loc12:*=arg3[22];
            var loc9:*=arg3[0] & 15;
            loc5 = 1;
            while (loc5 < 22) 
            {
                loc9 = loc9 + arg3[loc5];
                ++loc5;
            }
            if ((loc9 = loc9 & 255) != loc12) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10131, "ROX2012Decoder > decodeLogCyclingLap: incorrect checksum"));
            }
            return loc13;
        }

        internal function decodeLogCyclingPause(arg1:uint, arg2:core.activities.Activity, arg3:Array, arg4:core.activities.ActivityEntry=null, arg5:core.marker.Marker=null, arg6:Boolean=false):core.marker.Marker
        {
            var loc12:*=0;
            var loc18:*;
            (loc18 = core.marker.MarkerFactory.createMarkerFromLog(arg2)).type = "p";
            loc18.number = (arg1 - 1);
            loc18.logReference = arg2;
            var loc21:*=arg3[0] >> 3;
            if (arg6) 
            {
                arg5.timeAbsolute = arg5.timeAbsolute - arg4.trainingTime;
            }
            if (arg4 == null) 
            {
                loc18.timeAbsolute = loc21 * 100;
            }
            else 
            {
                loc18.timeAbsolute = loc21 * 100 + arg4.trainingTimeAbsolute;
            }
            if (arg5 == null) 
            {
                loc18.time = loc18.timeAbsolute;
            }
            else 
            {
                loc18.time = loc18.timeAbsolute - arg5.timeAbsolute;
            }
            var loc22:*=(arg3[2] & 3) << 8 | arg3[1];
            loc18.distance = loc22 * arg2.wheelSize / 1000;
            if (arg4 == null) 
            {
                loc18.distanceAbsolute = loc18.distance;
            }
            else 
            {
                loc18.distanceAbsolute = loc18.distance + arg4.distanceAbsolute;
            }
            if (arg6) 
            {
                loc18.distanceAbsolute = loc18.distanceAbsolute - arg4.tempUncorrectedDistance;
            }
            if (arg5 == null) 
            {
                loc18.distance = loc18.distanceAbsolute;
            }
            else 
            {
                loc18.distance = loc18.distanceAbsolute - arg5.distanceAbsolute;
            }
            var loc14:*=arg3[2] >> 2;
            var loc1:*=isROX5(arg2) ? 0 : 2;
            var loc3:*=(arg3[9 + loc1] & 15) << 8 | arg3[8 + loc1];
            var loc8:*=arg3[9 + loc1] >> 4;
            var loc11:*=arg3[7 + loc1] & 63;
            var loc9:*=(arg3[12 + loc1] & 15) << 8 | arg3[11 + loc1];
            var loc2:*=arg3[12 + loc1] >> 4;
            var loc5:*=arg3[10 + loc1] & 63;
            var loc13:*=arg3[13 + loc1] & 31;
            var loc10:*=(arg3[14 + loc1] & 224) >> 2 | arg3[13 + loc1] >> 5;
            var loc17:*=arg3[14 + loc1] & 31;
            var loc19:*=arg3[15 + loc1] & 63;
            var loc6:*=arg3[16 + loc1] & 63;
            var loc16:*=arg3[17 + loc1] & 63;
            var loc4:*=new Date(loc3, loc8, loc11, loc13, loc10, loc19);
            var loc20:*=new Date(loc9, loc2, loc5, loc17, loc6, loc16);
            var loc7:*=new Date(loc9 - loc3, loc2 - loc8, loc5 - loc11, loc17 - loc13, loc6 - loc10, loc16 - loc19);
            arg2.pauseTime = loc7.seconds + 60 * loc7.minutes + 3600 * loc7.hours;
            arg2.pauseTime = arg2.pauseTime * 100;
            loc18.duration = loc7.seconds + 60 * loc7.minutes + 3600 * loc7.hours;
            loc18.duration = loc18.duration * 100;
            var loc15:*=0;
            loc12 = 0;
            while (loc12 < 18 + loc1) 
            {
                loc15 = loc15 + arg3[loc12];
                ++loc12;
            }
            if ((loc15 = loc15 & 255) != arg3[18 + loc1]) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10129, "ROX2012Decoder > decodeLogPause: incorrect checksum"));
            }
            return loc18;
        }

        internal function decodeLogCyclingEntryFromPause(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc8:*=NaN;
            var loc4:*=0;
            var loc7:*;
            (loc7 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            var loc9:*;
            if ((loc9 = arg2[0] >> 3) == 0) 
            {
                return null;
            }
            loc7.trainingTime = loc9 * 100;
            if (arg4) 
            {
                loc7.trainingTime = loc7.trainingTime - arg3.trainingTime;
            }
            if (arg3 == null) 
            {
                loc7.trainingTimeAbsolute = loc7.trainingTime;
            }
            else 
            {
                loc7.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc7.trainingTime;
            }
            var loc10:*=(arg2[2] & 3) << 8 | arg2[1];
            loc7.rotations = loc10;
            loc7.distance = loc10 * arg1.wheelSize / 1000;
            loc7.tempUncorrectedDistance = loc7.distance;
            if (arg4) 
            {
                loc7.distance = loc7.distance - arg3.tempUncorrectedDistance;
            }
            if (!(arg3 == null) && arg3.distanceDefined && arg3.distanceAbsoluteDefined) 
            {
                loc7.distanceAbsolute = (arg3.distanceAbsolute * 1000 + loc7.distance * 1000) / 1000;
            }
            else 
            {
                loc7.distanceAbsolute = loc7.distance;
            }
            var loc1:*=arg2[2] >> 2;
            loc7.temperature = loc1 - 10;
            var loc2:*=speedConverter.convert(((arg2[4] & 127) << 8 | arg2[3]) / 100);
            loc7.speed = loc2;
            var loc5:*=arg2[5];
            loc7.heartrate = loc5;
            var loc11:*=arg2[6];
            loc7.cadence = loc11;
            if (loc7.altitudeDefined) 
            {
                loc8 = (arg2[8] & 127) << 8 | arg2[7];
                if (arg2[8] > 127) 
                {
                    loc8 = loc8 * -1;
                }
                loc7.altitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc8);
            }
            var loc3:*=isROX5(arg1) ? 0 : 2;
            var loc6:*=0;
            loc4 = 0;
            while (loc4 < 18 + loc3) 
            {
                loc6 = loc6 + arg2[loc4];
                ++loc4;
            }
            if ((loc6 = loc6 & 255) != arg2[18 + loc3]) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10129, "ROX2012Decoder > decodeLogPause: incorrect checksum"));
            }
            return loc7;
        }

        internal function decodeLogRunningPause(arg1:uint, arg2:core.activities.Activity, arg3:Array, arg4:core.activities.ActivityEntry=null, arg5:core.marker.Marker=null):core.marker.Marker
        {
            var loc12:*=0;
            var loc14:*=0;
            var loc20:*;
            (loc20 = core.marker.MarkerFactory.createMarkerFromLog(arg2)).type = "p";
            loc20.number = (arg1 - 1);
            loc20.logReference = arg2;
            var loc23:*=arg3[0] >> 3;
            loc20.time = loc23 * 100;
            if (arg4 == null) 
            {
                loc20.timeAbsolute = loc20.time;
            }
            else 
            {
                loc20.timeAbsolute = loc20.time + arg4.trainingTimeAbsolute;
            }
            if (arg5 == null) 
            {
                loc20.time = loc20.timeAbsolute;
            }
            else 
            {
                loc20.time = loc20.timeAbsolute - arg5.timeAbsolute;
            }
            if (isROX6(arg2)) 
            {
                loc12 = (arg3[2] & 127) << 8 | arg3[1];
                if (arg3[2] > 127) 
                {
                    loc12 = loc12 * -1;
                }
                loc20.averageAltitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc12);
            }
            var loc2:*=isROX5(arg2) ? 0 : 2;
            var loc1:*=arg3[1 + loc2];
            loc20.averageHeartrate = loc1;
            var loc4:*=(arg3[4 + loc2] & 15) << 8 | arg3[3 + loc2];
            var loc9:*=arg3[4 + loc2] >> 4;
            var loc13:*=arg3[2 + loc2] & 63;
            var loc10:*=(arg3[7 + loc2] & 15) << 8 | arg3[6 + loc2];
            var loc3:*=arg3[7 + loc2] >> 4;
            var loc6:*=arg3[5 + loc2] & 63;
            var loc15:*=arg3[8 + loc2] & 31;
            var loc11:*=(arg3[9 + loc2] & 224) >> 2 | arg3[8 + loc2] >> 5;
            var loc19:*=arg3[9 + loc2] & 31;
            var loc21:*=arg3[10 + loc2] & 63;
            var loc7:*=arg3[11 + loc2] & 63;
            var loc18:*=arg3[12 + loc2] & 63;
            var loc5:*=new Date(loc4, loc9, loc13, loc15, loc11, loc21);
            var loc22:*=new Date(loc10, loc3, loc6, loc19, loc7, loc18);
            var loc8:*=new Date(loc10 - loc4, loc3 - loc9, loc6 - loc13, loc19 - loc15, loc7 - loc11, loc18 - loc21);
            arg2.pauseTime = loc8.seconds + 60 * loc8.minutes + 3600 * loc8.hours;
            loc20.duration = loc8.seconds + 60 * loc8.minutes + 3600 * loc8.hours;
            loc20.duration = loc20.duration * 100;
            var loc16:*=(arg3[12 + loc2] & 192) >> 2 | (arg3[11 + loc2] & 192) >> 4 | arg3[10 + loc2] >> 6;
            var loc17:*=0;
            loc14 = 0;
            while (loc14 < (arg3.length - 1)) 
            {
                loc17 = loc17 + arg3[loc14];
                ++loc14;
            }
            if ((loc17 = loc17 & 255) != arg3[(arg3.length - 1)]) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10129, "ROX2012Decoder > decodeLogPause: incorrect checksum"));
            }
            return loc20;
        }

        internal function decodeLogRunning(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null):core.activities.ActivityEntry
        {
            var loc7:*=NaN;
            var loc6:*=NaN;
            var loc2:*=NaN;
            var loc1:*;
            (loc1 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            loc1.trainingTime = arg1.samplingRate * 100;
            if (arg3 == null) 
            {
                loc1.trainingTimeAbsolute = loc1.trainingTime;
            }
            else 
            {
                loc1.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc1.trainingTime;
            }
            if (isROX6(arg1)) 
            {
                loc7 = (arg2[2] & 127) << 8 | arg2[1];
                if (arg2[2] > 127) 
                {
                    loc7 = loc7 * -1;
                }
                loc1.altitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc7);
            }
            if (!(arg3 == null) && loc1.altitudeDefined) 
            {
                if ((loc6 = loc1.altitude - arg3.altitude) > 0) 
                {
                    if (loc1.altitudeDifferencesUphillDefined) 
                    {
                        loc1.altitudeDifferencesUphill = loc6;
                    }
                    if (loc1.distanceDefined && loc1.distanceUphillDefined) 
                    {
                        loc1.distanceUphill = loc1.distance;
                    }
                    if (loc1.trainingTimeUphillDefined) 
                    {
                        loc1.trainingTimeUphill = loc1.trainingTime;
                    }
                }
                else if (loc6 < 0) 
                {
                    if (loc1.altitudeDifferencesDownhillDefined) 
                    {
                        loc1.altitudeDifferencesDownhill = Math.abs(loc6);
                    }
                    if (loc1.distanceDefined && loc1.distanceDownhillDefined) 
                    {
                        loc1.distanceDownhill = loc1.distance;
                    }
                    if (loc1.trainingTimeDownhillDefined) 
                    {
                        loc1.trainingTimeDownhill = loc1.trainingTime;
                    }
                }
            }
            var loc4:*=isROX5(arg1) ? 0 : 2;
            var loc8:*=arg2[1 + loc4];
            loc1.heartrate = loc8;
            if (isROX5(arg1)) 
            {
                loc2 = arg2[2] >> 2;
            }
            else 
            {
                loc2 = arg2[4] & 63;
            }
            loc1.temperature = loc2 - 10;
            var loc3:*=0;
            var loc9:*=0;
            var loc5:*=0;
            if (isROX5(arg1)) 
            {
                loc9 = arg2[0] & 15;
                loc5 = 1;
                while (loc5 < 3) 
                {
                    loc9 = loc9 + arg2[loc5];
                    ++loc5;
                }
                loc9 = loc9 & 255;
                loc3 = arg2[3];
            }
            else 
            {
                loc9 = arg2[0] & 15;
                loc5 = 1;
                while (loc5 < 5) 
                {
                    loc9 = loc9 + arg2[loc5];
                    ++loc5;
                }
                loc9 = loc9 & 15;
                loc3 = arg2[0] >> 4;
            }
            if (loc9 != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10132, "ROX2012Decoder > decodeLogRunning: incorrect checksum"));
            }
            return loc1;
        }

        internal function decodeLogRunningEntryFromPause(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc12:*=0;
            var loc14:*=0;
            var loc18:*;
            (loc18 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            var loc23:*;
            if ((loc23 = arg2[0] >> 3) == 0) 
            {
                return null;
            }
            loc18.trainingTime = loc23 * 100;
            if (arg4) 
            {
                loc18.trainingTime = loc18.trainingTime - arg3.trainingTime;
            }
            if (arg3 == null) 
            {
                loc18.trainingTimeAbsolute = loc18.trainingTime;
            }
            else 
            {
                loc18.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc18.trainingTime;
            }
            if (isROX6(arg1)) 
            {
                loc12 = (arg2[2] & 127) << 8 | arg2[1];
                if (arg2[2] > 127) 
                {
                    loc12 = loc12 * -1;
                }
                loc18.altitude = new utils.converter.AltitudeConverter("meter", "millimeter").convert(loc12);
            }
            var loc2:*=isROX5(arg1) ? 0 : 2;
            var loc1:*=arg2[1 + loc2];
            loc18.heartrate = loc1;
            var loc4:*=(arg2[4 + loc2] & 15) << 8 | arg2[3 + loc2];
            var loc9:*=arg2[4 + loc2] >> 4;
            var loc13:*=arg2[2 + loc2] & 63;
            var loc10:*=(arg2[7 + loc2] & 15) << 8 | arg2[6 + loc2];
            var loc3:*=arg2[7 + loc2] >> 4;
            var loc6:*=arg2[5 + loc2] & 63;
            var loc15:*=arg2[8 + loc2] & 31;
            var loc11:*=(arg2[9 + loc2] & 224) >> 2 | arg2[8 + loc2] >> 5;
            var loc20:*=arg2[9 + loc2] & 31;
            var loc21:*=arg2[10 + loc2] & 63;
            var loc7:*=arg2[11 + loc2] & 63;
            var loc19:*=arg2[12 + loc2] & 63;
            var loc5:*=new Date(loc4, loc9, loc13, loc15, loc11, loc21);
            var loc22:*=new Date(loc10, loc3, loc6, loc20, loc7, loc19);
            var loc8:*=new Date(loc10 - loc4, loc3 - loc9, loc6 - loc13, loc20 - loc15, loc7 - loc11, loc19 - loc21);
            arg1.pauseTime = loc8.seconds + 60 * loc8.minutes + 3600 * loc8.hours;
            loc18.pauseTime = loc8.seconds + 60 * loc8.minutes + 3600 * loc8.hours;
            loc18.pauseTime = loc18.pauseTime * 100;
            var loc16:*=(arg2[12 + loc2] & 192) >> 2 | (arg2[11 + loc2] & 192) >> 4 | arg2[10 + loc2] >> 6;
            var loc17:*=0;
            loc14 = 0;
            while (loc14 < (arg2.length - 1)) 
            {
                loc17 = loc17 + arg2[loc14];
                ++loc14;
            }
            if ((loc17 = loc17 & 255) != arg2[(arg2.length - 1)]) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10129, "ROX2012Decoder > decodeLogPause: incorrect checksum"));
            }
            return loc18;
        }

        internal function calculateDistance(arg1:int, arg2:int):Number
        {
            return Math.round(arg1 * arg2) / 1000;
        }

        public static const GET_SETTING_INFO_TOTALS_BYTES_TO_RECEIVE:uint=40;

        public static const GET_SETTING_INFO_NORMAL_BYTES_TO_RECEIVE:uint=34;

        internal var speedConverter:utils.converter.SpeedConverter;

        internal static var _instance:decoder.Rox2012Decoder;
    }
}


//  class Rox70Decoder
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


//  class RoxDecoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import utils.converter.*;
    
    public class RoxDecoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog, core.units.interfaces.ICodingUnitInformation
    {
        public function RoxDecoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public static function getInstance():decoder.RoxDecoder
        {
            if (_instance == null) 
            {
                _instance = new RoxDecoder();
            }
            return _instance;
        }

        public function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc33:*=NaN;
            var loc38:*=null;
            var loc7:*=false;
            var loc8:*=arg1 as Array;
            var loc9:*=0;
            loc33 = 0;
            while (loc33 < 11) 
            {
                loc9 = loc9 + loc8[loc33];
                ++loc33;
            }
            loc9 = loc9 & 255;
            var loc27:*=parseInt(loc8[11]);
            var loc15:*=0;
            loc15 = (loc15 = (loc15 = loc8[2] << 16) | loc8[1] << 8) | loc8[0];
            var loc30:*=0;
            var loc11:*;
            if ((loc11 = (loc8[2] & 128) >> 7) != 0) 
            {
                if (loc11 == 1) 
                {
                    loc38 = new core.units.UnitROX9();
                    loc30 = loc15 - 9437184 + 90000000;
                }
            }
            else 
            {
                loc38 = new core.units.UnitROX8();
                loc30 = loc15 - 1048576 + 10000000;
            }
            loc38.serialNumber = loc30.toString();
            var loc41:*;
            (loc41 = new core.settings.SettingsROX()).unitType = loc38.type;
            loc41.unit = loc38;
            loc38.currentSettings = loc41;
            var loc3:*=(loc8[5] & 240) >> 4;
            var loc24:*=loc8[5] & 15;
            var loc28:*=(loc8[4] & 240) >> 4;
            var loc31:*=loc8[4] & 15;
            var loc5:*=(loc8[3] & 240) >> 4;
            var loc2:*=loc8[3] & 15;
            var loc20:*=loc5.toString(10) + loc2.toString(10);
            var loc39:*=loc28.toString(10) + loc31.toString(10);
            var loc4:*=loc3.toString(10) + loc24.toString(10);
            var loc32:*=new Date(parseInt("20" + loc4), (parseInt(loc39) - 1), parseInt(loc20));
            loc38.dateCode = loc32;
            var loc12:*;
            var loc16:*=(loc12 = parseInt(loc8[9])) & 15;
            var loc37:*=(loc8[8] & 240) >> 4;
            var loc36:*=loc8[8] & 15;
            var loc10:*=(loc8[7] & 240) >> 4;
            var loc13:*=loc8[7] & 15;
            var loc35:*=(loc8[6] & 240) >> 4;
            var loc34:*=loc8[6] & 15;
            var loc29:*=(loc29 = (loc29 = (loc29 = loc16.toString(16)) + (loc37.toString(16) + loc36.toString(16))) + (loc10.toString(16) + loc13.toString(16))) + (loc35.toString(16) + loc34.toString(16));
            loc38.maskingCode = loc29;
            var loc19:*;
            var loc17:*;
            var loc1:*=(loc17 = ((loc19 = parseInt(loc8[9])) & 240) >> 4).toString(16);
            loc38.initialWakeUpInfo = loc1;
            var loc40:*;
            var loc18:*=((loc40 = loc8[10]) & 240) >> 4;
            var loc14:*=loc40 & 15;
            var loc6:*=loc18.toString() + "." + loc14.toString();
            loc38.softwareRevision = loc6;
            var loc21:*=loc8[15].toString(16).toUpperCase();
            var loc23:*=loc8[14].toString(16).toUpperCase();
            var loc22:*=loc8[13].toString(16).toUpperCase();
            var loc25:*=loc8[12].toString(16).toUpperCase();
            var loc26:*;
            if ((loc26 = loc21 + loc23 + loc22 + loc25) != "359474D4") 
            {
                if (loc26 != "46A585E5") 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10120, "ROXDecoder > decodeUnitInformation: incorrect checksum1"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10122, "ROXDecoder > decodeUnitInformation: ROX 8.1 / 9.1 on DS 2008 is not supported"));
                }
                return null;
            }
            if (!loc7) 
            {
            };
            return loc38;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.UnitROX):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc5:*=null;
            var loc6:*=NaN;
            _7infotripArray = arg1 as Array;
            var loc4:*;
            var loc3:*=(loc4 = decodeTripList())[0];
            var loc7:*=loc4[1];
            var loc1:*=new __AS3__.vec.Vector.<core.activities.Activity>();
            var loc2:*=loc3;
            if (loc7 > 0) 
            {
                loc5 = decodeTrip(loc2 * 79, arg2);
                loc1[0] = loc5;
            }
            loc6 = 1;
            while (loc6 < loc7) 
            {
                if (loc2 != 0) 
                {
                    --loc2;
                }
                else 
                {
                    loc2 = 6;
                }
                loc5 = decodeTrip(loc2 * 79, arg2);
                loc1[loc6] = loc5;
                ++loc6;
            }
            return loc1;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc145:*=false;
            var loc8:*=0;
            var loc9:*=0;
            var loc28:*=0;
            var loc32:*=0;
            var loc87:*=null;
            var loc109:*=0;
            var loc111:*=0;
            var loc85:*=0;
            var loc86:*=0;
            var loc64:*=null;
            var loc131:*=0;
            var loc135:*=0;
            var loc154:*=0;
            var loc152:*=0;
            var loc151:*=null;
            var loc65:*=0;
            var loc29:*=0;
            var loc46:*=0;
            var loc62:*=0;
            var loc49:*=null;
            var loc63:*=0;
            var loc133:*=false;
            var loc37:*=new core.settings.SettingsROX();
            var loc31:*=arg2 as core.units.UnitROX;
            loc37.unitType = arg2.type;
            loc37.unit = arg2;
            var loc98:*;
            var loc39:*;
            if ((loc39 = (loc98 = arg1 as Array)[0] & 1) != 1) 
            {
                loc37.speedUnit = "kmh";
            }
            else 
            {
                loc37.speedUnit = "mph";
            }
            var loc18:*;
        }

        public function decodeTotals(arg1:Object, arg2:core.units.Unit):core.totals.Totals
        {
            var loc88:*=0;
            var loc100:*=0;
            var loc109:*=0;
            var loc107:*=0;
            var loc2:*=null;
            var loc85:*=0;
            var loc87:*=0;
            var loc83:*=0;
            var loc136:*=0;
            var loc160:*=null;
            var loc181:*=false;
            var loc37:*;
            (loc37 = new core.totals.TotalsROX()).unitType = arg2.type;
            loc37.unit = arg2;
            var loc10:*;
            var loc22:*=(loc10 = arg1 as Array)[10] & 15;
            var loc55:*=(loc10[9] & 240) >> 4;
            var loc56:*=loc10[9] & 15;
            var loc79:*=(loc10[8] & 240) >> 4;
            var loc80:*=loc10[8] & 15;
            var loc96:*=(loc10[7] & 240) >> 4;
            var loc98:*=loc10[7] & 15;
            var loc3:*=(loc10[6] & 240) >> 4;
            var loc4:*=loc10[6] & 15;
            var loc16:*=(loc10[5] & 240) >> 4;
            var loc18:*=loc10[5] & 15;
            var loc12:*=(loc12 = (loc12 = (loc12 = (loc12 = (loc12 = loc22.toString()) + (loc55.toString() + loc56.toString())) + (loc79.toString() + loc80.toString())) + (loc96.toString() + loc98.toString())) + (loc3.toString() + loc4.toString())) + (loc16.toString() + loc18.toString());
            var loc26:*;
            (loc26 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc26.outputFormat = "meter";
            loc37.totalDistance1 = loc26.convert(new Number(loc12) / 1000000);
            var loc20:*=(loc10[15] & 240) >> 4;
            var loc19:*=loc10[15] & 15;
            var loc5:*=(loc10[14] & 240) >> 4;
            var loc6:*=loc10[14] & 15;
            var loc101:*=(loc10[13] & 240) >> 4;
            var loc99:*=loc10[13] & 15;
            var loc81:*=(loc10[12] & 240) >> 4;
            var loc82:*=loc10[12] & 15;
            var loc59:*=(loc10[11] & 240) >> 4;
            var loc57:*=loc10[11] & 15;
            var loc41:*=(loc10[10] & 240) >> 4;
            var loc178:*=(loc178 = (loc178 = (loc178 = (loc178 = (loc178 = loc20.toString() + loc19.toString()) + (loc5.toString() + loc6.toString())) + (loc101.toString() + loc99.toString())) + (loc81.toString() + loc82.toString())) + (loc59.toString() + loc57.toString())) + loc41.toString();
            loc37.totalDistance2 = loc26.convert(new Number(loc178) / 1000000);
            var loc162:*=(loc10[25] & 240) >> 4;
            var loc161:*=loc10[25] & 15;
            var loc199:*=(loc10[24] & 240) >> 4;
            var loc201:*=loc10[24] & 15;
            var loc184:*=(loc10[23] & 240) >> 4;
            var loc182:*=loc10[23] & 15;
            var loc135:*=(loc10[22] & 240) >> 4;
            var loc137:*=loc10[22] & 15;
            var loc7:*=parseInt(loc162.toString() + loc161.toString() + loc199.toString() + loc201.toString());
            var loc183:*=parseInt(loc184.toString() + loc182.toString());
            var loc15:*=parseInt(loc135.toString() + loc137.toString());
            loc37.totalTrainingTime1 = (loc7 * 3600 + loc183 * 60 + loc15) * 100;
            var loc200:*=(loc10[29] & 240) >> 4;
            var loc198:*=loc10[29] & 15;
            var loc127:*=(loc10[28] & 240) >> 4;
            var loc126:*=loc10[28] & 15;
            var loc139:*=(loc10[27] & 240) >> 4;
            var loc138:*=loc10[27] & 15;
            var loc147:*=(loc10[26] & 240) >> 4;
            var loc146:*=loc10[26] & 15;
            var loc193:*=parseInt(loc200.toString() + loc198.toString() + loc127.toString() + loc126.toString());
            var loc13:*=parseInt(loc139.toString() + loc138.toString());
            var loc65:*=parseInt(loc147.toString() + loc146.toString());
            loc37.totalTrainingTime2 = (loc193 * 3600 + loc13 * 60 + loc65) * 100;
            var loc185:*;
            (loc185 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc185.outputFormat = "millimeter";
            if ((loc10[48] & 240) >> 4 != 15) 
            {
                loc88 = (loc10[48] & 240) >> 4;
                loc100 = loc10[48] & 15;
                loc109 = (loc10[47] & 240) >> 4;
                loc107 = loc10[47] & 15;
                loc2 = loc88.toString() + loc100.toString() + loc109.toString() + loc107.toString();
            }
            else 
            {
                loc88 = loc10[48] & 15;
                loc109 = (loc10[47] & 240) >> 4;
                loc107 = loc10[47] & 15;
                loc2 = "-" + loc88.toString() + loc109.toString() + loc107.toString();
            }
            loc37.maxAltitude1 = loc185.convert(parseInt(loc2));
            if ((loc10[50] & 240) >> 4 != 15) 
            {
                loc85 = (loc10[50] & 240) >> 4;
                loc87 = loc10[50] & 15;
                loc83 = (loc10[49] & 240) >> 4;
                loc136 = loc10[49] & 15;
                loc160 = loc85.toString() + loc87.toString() + loc83.toString() + loc136.toString();
            }
            else 
            {
                loc85 = loc10[50] & 15;
                loc83 = (loc10[49] & 240) >> 4;
                loc136 = loc10[49] & 15;
                loc160 = "-" + loc85.toString() + loc83.toString() + loc136.toString();
            }
            loc37.maxAltitude2 = loc185.convert(parseInt(loc160));
            var loc89:*=loc10[54] & 15;
            var loc142:*=(loc10[53] & 240) >> 4;
            var loc143:*=loc10[53] & 15;
            var loc188:*=(loc10[52] & 240) >> 4;
            var loc189:*=loc10[52] & 15;
            var loc202:*=(loc10[51] & 240) >> 4;
            var loc204:*=loc10[51] & 15;
            var loc128:*=(loc128 = (loc128 = (loc128 = loc89.toString()) + (loc142.toString() + loc143.toString())) + (loc188.toString() + loc189.toString())) + (loc202.toString() + loc204.toString());
            loc37.totalClimbMeter1 = loc185.convert(parseInt(loc128) / 10);
            var loc172:*=(loc10[57] & 240) >> 4;
            var loc173:*=loc10[57] & 15;
            var loc165:*=(loc10[56] & 240) >> 4;
            var loc164:*=loc10[56] & 15;
            var loc203:*=(loc10[55] & 240) >> 4;
            var loc205:*=loc10[55] & 15;
            var loc153:*=(loc10[54] & 240) >> 4;
            var loc29:*=(loc29 = (loc29 = (loc29 = loc172.toString() + loc173) + (loc165.toString() + loc164.toString())) + (loc203.toString() + loc205.toString())) + loc153.toString();
            loc37.totalClimbMeter2 = loc185.convert(parseInt(loc29) / 10);
            var loc47:*=loc10[61] & 15;
            var loc72:*=(loc10[60] & 240) >> 4;
            var loc71:*=loc10[60] & 15;
            var loc48:*=(loc10[59] & 240) >> 4;
            var loc51:*=loc10[59] & 15;
            var loc114:*=(loc10[58] & 240) >> 4;
            var loc113:*=loc10[58] & 15;
            var loc195:*=(loc195 = (loc195 = (loc195 = loc47.toString()) + (loc72.toString() + loc71.toString())) + (loc48.toString() + loc51.toString())) + (loc114.toString() + loc113.toString());
            loc37.totalDescent1 = loc185.convert(parseInt(loc195) / 10);
            var loc53:*=(loc10[64] & 240) >> 4;
            var loc54:*=loc10[64] & 15;
            var loc91:*=(loc10[63] & 240) >> 4;
            var loc76:*=loc10[63] & 15;
            var loc111:*=(loc10[62] & 240) >> 4;
            var loc112:*=loc10[62] & 15;
            var loc103:*=(loc10[61] & 240) >> 4;
            var loc152:*=(loc152 = (loc152 = (loc152 = loc53.toString() + loc54.toString()) + (loc91.toString() + loc76.toString())) + (loc111.toString() + loc112.toString())) + loc103.toString();
            loc37.totalDescent2 = loc185.convert(parseInt(loc152) / 10);
            var loc92:*=(loc10[68] & 240) >> 4;
            var loc73:*=loc10[68] & 15;
            var loc70:*=(loc10[67] & 240) >> 4;
            var loc69:*=loc10[67] & 15;
            var loc50:*=(loc10[66] & 240) >> 4;
            var loc49:*=loc10[66] & 15;
            var loc159:*=(loc10[65] & 240) >> 4;
            var loc158:*=loc10[65] & 15;
            var loc168:*=(loc168 = (loc168 = parseInt(loc92.toString() + loc73.toString() + loc70.toString() + loc69.toString()) * 3600) + parseInt(loc50.toString() + loc49.toString()) * 60) + parseInt(loc159.toString() + loc158.toString());
            loc37.totalTimeUp1 = loc168 * 100;
            var loc118:*=(loc10[72] & 240) >> 4;
            var loc119:*=loc10[72] & 15;
            var loc157:*=(loc10[71] & 240) >> 4;
            var loc156:*=loc10[71] & 15;
            var loc148:*=(loc10[70] & 240) >> 4;
            var loc149:*=loc10[70] & 15;
            var loc66:*=(loc10[69] & 240) >> 4;
            var loc67:*=loc10[69] & 15;
            var loc150:*=(loc150 = (loc150 = parseInt(loc118.toString() + loc119.toString() + loc157.toString() + loc156.toString()) * 3600) + parseInt(loc148.toString() + loc149.toString()) * 60) + parseInt(loc66.toString() + loc67.toString());
            loc37.totalTimeUp2 = loc150 * 100;
            var loc176:*=(loc10[76] & 240) >> 4;
            var loc177:*=loc10[76] & 15;
            var loc131:*=(loc10[75] & 240) >> 4;
            var loc132:*=loc10[75] & 15;
            var loc115:*=(loc10[74] & 240) >> 4;
            var loc116:*=loc10[74] & 15;
            var loc155:*=(loc10[73] & 240) >> 4;
            var loc151:*=loc10[73] & 15;
            var loc123:*=(loc123 = (loc123 = parseInt(loc176.toString() + loc177.toString() + loc131.toString() + loc132.toString()) * 3600) + parseInt(loc115.toString() + loc116.toString()) * 60) + parseInt(loc155.toString() + loc151.toString());
            loc37.totalTimeDown1 = loc123 * 100;
            var loc169:*=(loc10[80] & 240) >> 4;
            var loc166:*=loc10[80] & 15;
            var loc180:*=(loc10[79] & 240) >> 4;
            var loc179:*=loc10[79] & 15;
            var loc196:*=(loc10[78] & 240) >> 4;
            var loc197:*=loc10[78] & 15;
            var loc121:*=(loc10[77] & 240) >> 4;
            var loc120:*=loc10[77] & 15;
            var loc190:*=(loc190 = (loc190 = parseInt(loc169.toString() + loc166.toString() + loc180.toString() + loc179.toString()) * 3600) + parseInt(loc196.toString() + loc197.toString()) * 60) + parseInt(loc121.toString() + loc120.toString());
            loc37.totalTimeDown2 = loc190 * 100;
            var loc8:*=loc10[86] & 15;
            var loc61:*=(loc10[85] & 240) >> 4;
            var loc63:*=loc10[85] & 15;
            var loc45:*=(loc10[84] & 240) >> 4;
            var loc46:*=loc10[84] & 15;
            var loc104:*=(loc10[83] & 240) >> 4;
            var loc106:*=loc10[83] & 15;
            var loc93:*=(loc10[82] & 240) >> 4;
            var loc84:*=loc10[82] & 15;
            var loc144:*=(loc10[81] & 240) >> 4;
            var loc145:*=loc10[81] & 15;
            var loc28:*=(loc28 = (loc28 = (loc28 = (loc28 = (loc28 = loc8.toString()) + (loc61.toString() + loc63.toString())) + (loc45.toString() + loc46.toString())) + (loc104.toString() + loc106.toString())) + (loc93.toString() + loc84.toString())) + (loc144.toString() + loc145.toString());
            loc37.totalTripDistUp1 = loc26.convert(new Number(loc28) / 1000000);
            var loc62:*=(loc10[91] & 240) >> 4;
            var loc64:*=loc10[91] & 15;
            var loc90:*=(loc10[90] & 240) >> 4;
            var loc86:*=loc10[90] & 15;
            var loc108:*=(loc10[89] & 240) >> 4;
            var loc110:*=loc10[89] & 15;
            var loc130:*=(loc10[88] & 240) >> 4;
            var loc129:*=loc10[88] & 15;
            var loc140:*=(loc10[87] & 240) >> 4;
            var loc141:*=loc10[87] & 15;
            var loc117:*=(loc10[86] & 240) >> 4;
            var loc124:*=(loc124 = (loc124 = (loc124 = (loc124 = (loc124 = loc62.toString() + loc64.toString()) + (loc90.toString() + loc86.toString())) + (loc108.toString() + loc110.toString())) + (loc130.toString() + loc129.toString())) + (loc140.toString() + loc141.toString())) + loc117.toString();
            loc37.totalTripDistUp2 = loc26.convert(new Number(loc124) / 1000000);
            var loc194:*=loc10[97] & 15;
            var loc17:*=(loc10[96] & 240) >> 4;
            var loc14:*=loc10[96] & 15;
            var loc74:*=(loc10[95] & 240) >> 4;
            var loc75:*=loc10[95] & 15;
            var loc94:*=(loc10[94] & 240) >> 4;
            var loc95:*=loc10[94] & 15;
            var loc38:*=(loc10[93] & 240) >> 4;
            var loc39:*=loc10[93] & 15;
            var loc68:*=(loc10[92] & 240) >> 4;
            var loc52:*=loc10[92] & 15;
            var loc125:*=(loc125 = (loc125 = (loc125 = (loc125 = (loc125 = loc194.toString()) + (loc17.toString() + loc14.toString())) + (loc74.toString() + loc75.toString())) + (loc94.toString() + loc95.toString())) + (loc38.toString() + loc39.toString())) + (loc68.toString() + loc52.toString());
            loc37.totalTripDistDown1 = loc26.convert(new Number(loc125) / 1000000);
            var loc60:*=(loc10[102] & 240) >> 4;
            var loc58:*=loc10[102] & 15;
            var loc42:*=(loc10[101] & 240) >> 4;
            var loc43:*=loc10[101] & 15;
            var loc97:*=(loc10[100] & 240) >> 4;
            var loc102:*=loc10[100] & 15;
            var loc77:*=(loc10[99] & 240) >> 4;
            var loc78:*=loc10[99] & 15;
            var loc134:*=(loc10[98] & 240) >> 4;
            var loc133:*=loc10[98] & 15;
            var loc30:*=(loc10[97] & 240) >> 4;
            var loc36:*=(loc36 = (loc36 = (loc36 = (loc36 = (loc36 = loc60.toString() + loc58.toString()) + (loc42.toString() + loc43.toString())) + (loc97.toString() + loc102.toString())) + (loc77.toString() + loc78.toString())) + (loc134.toString() + loc133.toString())) + loc30.toString();
            loc37.totalTripDistDown2 = loc26.convert(new Number(loc36) / 1000000);
            var loc34:*=(loc10[105] & 240) >> 4;
            var loc33:*=loc10[105] & 15;
            var loc27:*=(loc10[104] & 240) >> 4;
            var loc25:*=loc10[104] & 15;
            var loc175:*=(loc10[103] & 240) >> 4;
            var loc174:*=loc10[103] & 15;
            var loc105:*=(loc105 = (loc105 = loc34.toString() + loc33.toString()) + (loc27.toString() + loc25.toString())) + (loc175.toString() + loc174.toString());
            loc37.totalCal1 = parseInt(loc105);
            var loc163:*=(loc10[108] & 240) >> 4;
            var loc167:*=loc10[108] & 15;
            var loc171:*=(loc10[107] & 240) >> 4;
            var loc170:*=loc10[107] & 15;
            var loc186:*=(loc10[106] & 240) >> 4;
            var loc187:*=loc10[106] & 15;
            var loc154:*=(loc154 = (loc154 = loc163.toString() + loc167.toString()) + (loc171.toString() + loc170.toString())) + (loc186.toString() + loc187.toString());
            loc37.totalCal2 = parseInt(loc154);
            var loc32:*=(loc10[137] & 240) >> 4;
            var loc31:*=loc10[137] & 15;
            var loc40:*=(loc10[136] & 240) >> 4;
            var loc44:*=loc10[136] & 15;
            var loc21:*=loc32.toString() + loc31.toString() + loc40.toString() + loc44.toString();
            var loc191:*=(loc10[141] & 240) >> 4;
            var loc192:*=loc10[141] & 15;
            var loc24:*=(loc10[140] & 240) >> 4;
            var loc23:*=loc10[140] & 15;
            var loc9:*=(loc10[139] & 240) >> 4;
            var loc11:*=loc10[139] & 15;
            var loc1:*=(loc10[138] & 240) >> 4;
            var loc35:*=loc10[138] & 15;
            var loc122:*=(loc122 = (loc122 = (loc122 = loc191.toString() + loc192.toString()) + (loc24.toString() + loc23.toString())) + (loc9.toString() + loc11.toString())) + (loc1.toString() + loc35.toString());
            if (!loc181) 
            {
            };
            return loc37;
        }

        public function encodeUnitInformation(arg1:core.units.UnitROX):Array
        {
            var loc5:*=0;
            if (arg1.serialNumber == null || arg1.dateCode == null || arg1.maskingCode == null || arg1.initialWakeUpInfo == null || arg1.softwareRevision == null) 
            {
                return null;
            }
            var loc1:*=false;
            var loc3:*=[];
            var loc2:*=parseInt(arg1.serialNumber);
            var loc8:*=0;
            if (arg1 is core.units.UnitROX8) 
            {
                loc8 = loc2 - 10000000 + 1048576;
            }
            else 
            {
                loc8 = loc2 - 90000000 + 9437184;
            }
            loc3[0] = loc8 & 255;
            loc3[1] = (loc8 & 65280) >> 8;
            loc3[2] = (loc8 & 16711680) >> 16;
            var loc4:*=arg1.dateCode;
            loc3[3] = loc4.date / 10 << 4;
            var loc13:*=3;
            var loc14:*=loc3[loc13] | loc4.date % 10;
            loc3[loc13] = loc14;
            loc3[4] = (loc4.month + 1) / 10 << 4;
            loc14 = 4;
            loc13 = loc3[loc14] | (loc4.month + 1) % 10;
            loc3[loc14] = loc13;
            loc3[5] = loc4.fullYear % 100 / 10 << 4;
            loc13 = 5;
            loc14 = loc3[loc13] | loc4.fullYear % 100 % 10;
            loc3[loc13] = loc14;
            var loc11:*=parseInt("0x" + arg1.maskingCode);
            loc3[6] = loc11 & 255;
            loc3[7] = (loc11 & 65280) >> 8;
            loc3[8] = (loc11 & 16711680) >> 16;
            loc3[9] = (loc11 & 251658240) >> 24;
            var loc7:*=parseInt("0x" + arg1.initialWakeUpInfo);
            loc14 = 9;
            loc13 = loc3[loc14] | loc7 << 4;
            loc3[loc14] = loc13;
            var loc9:*=parseFloat(arg1.softwareRevision);
            var loc10:*=parseFloat(arg1.softwareRevision) * 10 % 10;
            var loc6:*=loc9 << 4;
            loc6 = loc6 | loc10;
            loc3[10] = loc6;
            var loc12:*=0;
            loc5 = 0;
            while (loc5 < 11) 
            {
                loc12 = loc12 + loc3[loc5];
                ++loc5;
            }
            loc12 = loc12 & 255;
            loc3[11] = loc12;
            loc3[12] = 212;
            loc3[13] = 116;
            loc3[14] = 148;
            loc3[15] = 53;
            if (!loc1) 
            {
            };
            return loc3;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc63:*=0;
            var loc37:*=0;
            var loc21:*=0;
            var loc30:*=0;
            var loc71:*=0;
            var loc72:*=null;
            var loc128:*=0;
            var loc96:*=new Array(142);
            var loc34:*=arg1.currentSettings as core.settings.SettingsROX;
            var loc78:*=(arg1 as core.units.UnitROX).currentTotals as core.totals.TotalsROX;
            var loc28:*=arg1 as core.units.UnitROX;
            loc63 = 0;
            while (loc63 < 142) 
            {
                loc96[loc63] = 0;
                ++loc63;
            }
            if (loc34.speedUnit != "mph") 
            {
                loc37 = 0;
            }
            else 
            {
                loc37 = 1;
            }
            var loc133:*=0;
            var loc134:*=loc96[loc133] | loc37;
            loc96[loc133] = loc134;
            loc134 = loc34.language;
            while ("de" === loc134) 
            {
                loc21 = 0;
            }
        }

        public function decodeNumberOfPages(arg1:Array):uint
        {
            var loc3:*=arg1[1] << 8;
            var loc2:*=arg1[0];
            var loc1:*=loc3 | loc2;
            return loc1;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            var loc1:*=0;
            var loc19:*=0;
            var loc2:*=0;
            var loc31:*=0;
            var loc3:*=0;
            var loc26:*;
            var loc8:*;
            var loc14:*=((loc8 = (loc26 = arg1 as Array).slice(65360, 65370))[0] & 240) >> 4;
            var loc13:*=loc8[0] & 15;
            var loc12:*=(loc8[1] & 240) >> 4;
            var loc15:*=loc8[1] & 15;
            var loc27:*=loc12.toString(16) + loc15.toString(16) + loc14.toString(16) + loc13.toString(16);
            loc2 = parseInt(loc27, 16);
            var loc7:*=(loc8[3] & 240) >> 4;
            var loc33:*=loc8[3] & 15;
            var loc34:*=(loc8[2] & 240) >> 4;
            var loc21:*=loc8[2] & 15;
            var loc4:*=loc7.toString(16) + loc33.toString(16) + loc34.toString(16) + loc21.toString(16);
            loc31 = parseInt(loc4, 16);
            var loc24:*=(loc8[5] & 240) >> 4;
            var loc5:*=loc8[5] & 15;
            var loc6:*=(loc8[4] & 240) >> 4;
            var loc9:*=loc8[4] & 15;
            var loc32:*=loc24.toString(16) + loc5.toString(16) + loc6.toString(16) + loc9.toString(16);
            loc3 = parseInt(loc32, 16);
            var loc16:*=(loc8[6] & 240) >> 4;
            var loc20:*=loc8[6] & 15;
            var loc28:*=loc16.toString(16) + loc20.toString(16);
            loc1 = parseInt(loc28, 16);
            var loc22:*=(loc8[10] & 240) >> 4;
            var loc10:*=loc8[10] & 15;
            var loc25:*=(loc8[9] & 240) >> 4;
            var loc29:*=loc8[9] & 15;
            var loc23:*=(loc8[8] & 240) >> 4;
            var loc11:*=loc8[8] & 15;
            var loc18:*=(loc8[7] & 240) >> 4;
            var loc30:*=loc8[7] & 15;
            var loc17:*=loc22.toString() + loc10.toString() + loc25.toString() + loc29.toString() + loc23.toString() + loc11.toString() + loc18.toString() + loc30.toString();
            loc19 = parseInt(loc17, 10);
            return;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc10:*=0;
            var loc24:*=null;
            var loc9:*=null;
            var loc66:*=NaN;
            var loc59:*;
            (loc59 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            loc59.serialNumber = arg2.serialNumber;
            loc59.pageHeaderData = arg1;
            var loc35:*=(arg1[1] & 48) >> 4;
            var loc20:*=arg1[1] & 15;
            var loc22:*=(arg1[0] & 240) >> 4;
            var loc19:*=arg1[0] & 15;
            var loc43:*=loc35.toString() + loc20.toString() + loc22.toString() + loc19.toString();
            loc10 = parseInt(loc43, 10);
            loc59.wheelSize = loc10;
            var loc49:*;
            if ((loc49 = (arg1[1] & 64) >> 6) != 1) 
            {
                loc9 = "kmh";
            }
            else 
            {
                loc9 = "mph";
            }
            loc59.speedUnit = loc9;
            var loc44:*;
            if ((loc44 = (arg1[1] & 128) >> 7) != 1) 
            {
                loc24 = "bike1";
            }
            else 
            {
                loc24 = "bike2";
            }
            loc59.bike = loc24;
            var loc31:*;
            var loc25:*=(loc31 = arg1[2]).toString();
            var loc41:*=parseInt(loc25, 10);
            loc59.hrMax = loc41;
            var loc32:*;
            var loc37:*=(loc32 = arg1[3]).toString();
            var loc3:*=parseInt(loc37, 10);
            loc59.zone1Start = loc3;
            var loc1:*=arg1[4];
            var loc6:*=loc1.toString();
            var loc57:*=parseInt(loc6, 10);
            loc59.zone2Start = loc57;
            var loc65:*;
            var loc26:*=(loc65 = arg1[5]).toString();
            var loc45:*=parseInt(loc26, 10);
            loc59.zone3Start = loc45;
            var loc23:*;
            var loc54:*=(loc23 = arg1[6]).toString();
            var loc48:*=parseInt(loc54, 10);
            loc59.zone3End = loc48;
            var loc53:*=(arg1[7] & 240) >> 4;
            var loc47:*=arg1[7] & 15;
            var loc52:*=(arg1[8] & 240) >> 4;
            var loc68:*=arg1[8] & 15;
            var loc58:*;
            var loc77:*=(loc58 = arg1[9] & 15).toString() + loc52.toString() + loc68.toString() + loc53.toString() + loc47.toString();
            loc59.calories = parseInt(loc77);
            var loc73:*=(arg1[12] & 48) >> 4;
            var loc30:*=arg1[12] & 15;
            var loc29:*=(arg1[11] & 240) >> 4;
            var loc34:*=arg1[11] & 15;
            var loc28:*=(arg1[10] & 240) >> 4;
            var loc11:*=arg1[10] & 15;
            var loc46:*=parseInt(loc73.toString() + loc30.toString());
            var loc36:*=parseInt(loc29.toString() + loc34.toString());
            var loc27:*=parseInt(loc28.toString() + loc11.toString());
            var loc42:*=(arg1[18] & 240) >> 4;
            var loc75:*=arg1[18] & 15;
            var loc71:*=(arg1[17] & 240) >> 4;
            var loc4:*=arg1[17] & 15;
            var loc72:*=(arg1[16] & 240) >> 4;
            var loc61:*=arg1[16] & 15;
            var loc40:*=parseInt("20" + loc42.toString(16) + loc75.toString(16));
            var loc38:*=parseInt(loc71.toString(16) + loc4.toString(16));
            var loc50:*=parseInt(loc72.toString(16) + loc61.toString(16));
            var loc8:*=new Date(loc40, (loc38 - 1), loc50, loc46, loc36, loc27);
            loc59.startDate = loc8;
            loc59.dateCode = loc59.startDate.toString();
            var loc62:*;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc9:*=null;
            var loc1:*=null;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc8:*=0;
            var loc7:*=1;
            var loc2:*=0;
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc3:*;
            (loc3 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc3.outputFormat = "ms";
            loc8 = 0;
            for (;;) 
            {
                if (loc8 % 10 != 0) 
                {
                    loc9 = arg2.slice(loc4, loc4 + 6);
                    if (isPause(loc9)) 
                    {
                        loc1 = this.decodeRelLogPauseEntry(loc9, arg1);
                    }
                    else 
                    {
                        loc1 = this.decodeRelLogEntry(loc9, arg1);
                    }
                    loc1 = makeAbsolutEntry(loc1, arg1.entries[(loc8 - 1)]);
                    loc4 = loc4 + 6;
                }
                else 
                {
                    loc9 = arg2.slice(loc4, loc4 + 7);
                    if (isPause(loc9)) 
                    {
                        loc1 = this.decodeAbsLogPauseEntry(loc9, arg1);
                    }
                    else 
                    {
                        loc1 = this.decodeAbsLogEntry(loc9, arg1);
                    }
                    loc4 = loc4 + 7;
                }
                loc5 = loc1.speed / (2200 / arg1.wheelSize);
                loc5 = Math.round(loc5 * 100) / 100;
                loc1.speed = loc3.convert(loc5);
                if (loc1.speed > 0) 
                {
                    loc1.speedTime = Math.floor(1000 / loc1.speed);
                }
                else 
                {
                    loc1.speedTime = 1200;
                }
                if (loc1.speedTime > 1200) 
                {
                    loc1.speedTime = 1200;
                }
                arg1.entries.push(loc1);
                if (loc4 >= arg2.length) 
                {
                    break;
                }
                ++loc8;
            }
            var loc6:*;
        }

        internal function decodeTrip(arg1:int, arg2:core.units.UnitROX):core.activities.Activity
        {
            var loc160:*=null;
            var loc142:*=null;
            var loc41:*=null;
            var loc119:*=null;
            var loc74:*=null;
            var loc161:*;
            (loc161 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc161.serialNumber = arg2.serialNumber;
            var loc169:*=(_7infotripArray[arg1] & 240) >> 4;
            var loc151:*=_7infotripArray[arg1] & 15;
            var loc152:*=(_7infotripArray[arg1 + 1] & 240) >> 4;
            var loc193:*=_7infotripArray[arg1 + 1] & 15;
            var loc150:*=(_7infotripArray[arg1 + 2] & 240) >> 4;
            var loc170:*=_7infotripArray[arg1 + 2] & 15;
            var loc75:*=(_7infotripArray[arg1 + 3] & 240) >> 4;
            var loc84:*=_7infotripArray[arg1 + 3] & 15;
            var loc83:*=(_7infotripArray[arg1 + 4] & 112) >> 4;
            var loc33:*=_7infotripArray[arg1 + 4] & 15;
            loc161.startDate = new Date("20" + loc150.toString() + loc170.toString(), (parseInt(loc152.toString() + loc193.toString()) - 1), loc169.toString() + loc151.toString(), loc83.toString() + loc33.toString(), loc75.toString() + loc84.toString());
            loc161.dateCode = loc161.startDate.toString();
            if ((_7infotripArray[arg1 + 4] & 128) >> 7 != 1) 
            {
                loc161.bike = "bike1";
            }
            else 
            {
                loc161.bike = "bike2";
            }
            if ((_7infotripArray[arg1 + 72] & 128) >> 7 != 1) 
            {
                loc161.speedUnit = "kmh";
            }
            else 
            {
                loc161.speedUnit = "mph";
            }
            var loc47:*=new utils.converter.DistanceConverter();
            if (loc161.speedUnit != "kmh") 
            {
                if (loc161.speedUnit == "mph") 
                {
                    loc47.inputFormat = "mile";
                }
            }
            else 
            {
                loc47.inputFormat = "kilometer";
            }
            loc47.outputFormat = "kilometer";
            var loc166:*=(_7infotripArray[arg1 + 5] & 240) >> 4;
            var loc115:*=_7infotripArray[arg1 + 5] & 15;
            var loc120:*=(_7infotripArray[arg1 + 6] & 240) >> 4;
            var loc97:*=_7infotripArray[arg1 + 6] & 15;
            var loc121:*=(_7infotripArray[arg1 + 7] & 240) >> 4;
            var loc15:*=_7infotripArray[arg1 + 7] & 15;
            var loc149:*=loc121.toString() + loc15.toString() + loc120.toString() + loc97.toString() + "." + loc166.toString() + loc115.toString();
            loc161.distance = loc47.convert(new Number(loc149)) * 1000;
            var loc124:*=(_7infotripArray[arg1 + 8] & 240) >> 4;
            var loc109:*=_7infotripArray[arg1 + 8] & 15;
            var loc108:*=(_7infotripArray[arg1 + 9] & 240) >> 4;
            var loc59:*=_7infotripArray[arg1 + 9] & 15;
            var loc111:*=(_7infotripArray[arg1 + 10] & 240) >> 4;
            var loc44:*=_7infotripArray[arg1 + 10] & 15;
            var loc110:*=(_7infotripArray[arg1 + 11] & 240) >> 4;
            var loc25:*=_7infotripArray[arg1 + 11] & 15;
            var loc102:*=parseInt(loc110.toString() + loc25.toString() + loc111.toString() + loc44.toString());
            var loc212:*=parseInt(loc108.toString() + loc59.toString());
            var loc48:*=parseInt(loc124.toString() + loc109.toString());
            loc161.trainingTime = (loc102 * 3600 + loc212 * 60 + loc48) * 100;
            var loc144:*=new utils.converter.SpeedConverter();
            if (loc161.speedUnit != "kmh") 
            {
                if (loc161.speedUnit == "mph") 
                {
                    loc144.inputFormat = "mph";
                }
            }
            else 
            {
                loc144.inputFormat = "kmh";
            }
            loc144.outputFormat = "ms";
            var loc61:*=(_7infotripArray[arg1 + 12] & 240) >> 4;
            var loc206:*=_7infotripArray[arg1 + 12] & 15;
            var loc46:*=(_7infotripArray[arg1 + 13] & 240) >> 4;
            var loc130:*=_7infotripArray[arg1 + 13] & 15;
            var loc28:*;
            var loc178:*=(loc28 = _7infotripArray[arg1 + 14] & 15).toString() + loc46.toString() + loc130.toString() + "." + loc61.toString() + loc206.toString();
            loc161.averageSpeed = loc144.convert(new Number(loc178));
            var loc34:*=(_7infotripArray[arg1 + 16] & 240) >> 4;
            var loc69:*=_7infotripArray[arg1 + 16] & 15;
            var loc71:*=(_7infotripArray[arg1 + 15] & 240) >> 4;
            var loc17:*=_7infotripArray[arg1 + 15] & 15;
            var loc66:*=(_7infotripArray[arg1 + 14] & 240) >> 4;
            var loc10:*=loc34.toString() + loc69.toString() + loc71.toString() + "." + loc17.toString() + loc66.toString();
            loc161.maximumSpeed = loc144.convert(new Number(loc10));
            var loc49:*=(_7infotripArray[arg1 + 17] & 240) >> 4;
            var loc22:*=_7infotripArray[arg1 + 17] & 15;
            var loc21:*=(_7infotripArray[arg1 + 18] & 240) >> 4;
            var loc211:*=_7infotripArray[arg1 + 18] & 15;
            var loc19:*;
            if ((loc19 = _7infotripArray[arg1 + 19] & 15) != 15) 
            {
                loc142 = loc19 + loc21.toString() + loc211.toString() + "." + loc49.toString() + loc22.toString();
                loc161.distancePlus = loc47.convert(new Number(loc142)) * 1000;
            }
            else 
            {
                loc160 = "-" + loc21.toString() + loc211.toString() + "." + loc49.toString() + loc22.toString();
                loc161.distancePlus = loc47.convert(new Number(loc160)) * 1000;
            }
            var loc60:*=(_7infotripArray[arg1 + 21] & 240) >> 4;
            var loc96:*=_7infotripArray[arg1 + 21] & 15;
            var loc93:*=(_7infotripArray[arg1 + 20] & 240) >> 4;
            var loc196:*=_7infotripArray[arg1 + 20] & 15;
            var loc94:*=(_7infotripArray[arg1 + 19] & 240) >> 4;
            var loc145:*="";
            if (loc60 != 15) 
            {
                loc145 = loc60.toString() + loc96.toString() + loc93.toString() + "." + loc196.toString() + loc94.toString();
            }
            else 
            {
                loc145 = "-" + loc96.toString() + loc93.toString() + "." + loc196.toString() + loc94.toString();
            }
            loc161.distanceMinus = loc47.convert(new Number(loc145)) * 1000;
            var loc165:*=(_7infotripArray[arg1 + 22] & 240) >> 4;
            var loc67:*=_7infotripArray[arg1 + 22] & 15;
            var loc81:*=loc165.toString(16) + loc67.toString(16);
            loc161.averageCadence = parseInt(loc81, 16);
            var loc51:*=(_7infotripArray[arg1 + 23] & 240) >> 4;
            var loc104:*=_7infotripArray[arg1 + 23] & 15;
            var loc29:*=loc51.toString(16) + loc104.toString(16);
            loc161.maximumCadence = parseInt(loc29, 16);
            var loc105:*=(_7infotripArray[arg1 + 24] & 240) >> 4;
            var loc54:*=_7infotripArray[arg1 + 24] & 15;
            var loc73:*=loc105.toString(16) + loc54.toString(16);
            loc161.averageHeartrate = parseInt(loc73, 16);
            var loc7:*=(_7infotripArray[arg1 + 25] & 240) >> 4;
            var loc79:*=_7infotripArray[arg1 + 25] & 15;
            var loc92:*=loc7.toString(16) + loc79.toString(16);
            loc161.maximumHeartrate = parseInt(loc92, 16);
            var loc18:*=(_7infotripArray[arg1 + 26] & 240) >> 4;
            var loc182:*=_7infotripArray[arg1 + 26] & 15;
            var loc180:*=(_7infotripArray[arg1 + 27] & 240) >> 4;
            var loc98:*=_7infotripArray[arg1 + 27] & 15;
            var loc172:*=(_7infotripArray[arg1 + 28] & 240) >> 4;
            var loc77:*=_7infotripArray[arg1 + 28] & 15;
            var loc42:*=parseInt(loc172.toString() + loc77.toString());
            var loc30:*=parseInt(loc180.toString() + loc98.toString());
            var loc6:*=parseInt(loc18.toString() + loc182.toString());
            loc161.timeInZone1 = (loc42 * 3600 + loc30 * 60 + loc6) * 100;
            var loc72:*=(_7infotripArray[arg1 + 29] & 240) >> 4;
            var loc36:*=_7infotripArray[arg1 + 29] & 15;
            var loc38:*=(_7infotripArray[arg1 + 30] & 240) >> 4;
            var loc82:*=_7infotripArray[arg1 + 30] & 15;
            var loc40:*=(_7infotripArray[arg1 + 31] & 240) >> 4;
            var loc31:*=_7infotripArray[arg1 + 31] & 15;
            var loc192:*=parseInt(loc40.toString() + loc31.toString());
            var loc146:*=parseInt(loc38.toString() + loc82.toString());
            var loc129:*=parseInt(loc72.toString() + loc36.toString());
            loc161.timeInZone2 = (loc192 * 3600 + loc146 * 60 + loc129) * 100;
            var loc122:*=(_7infotripArray[arg1 + 32] & 240) >> 4;
            var loc116:*=_7infotripArray[arg1 + 32] & 15;
            var loc114:*=(_7infotripArray[arg1 + 33] & 240) >> 4;
            var loc58:*=_7infotripArray[arg1 + 33] & 15;
            var loc117:*=(_7infotripArray[arg1 + 34] & 240) >> 4;
            var loc8:*=_7infotripArray[arg1 + 34] & 15;
            var loc209:*=parseInt(loc117.toString() + loc8.toString());
            var loc100:*=parseInt(loc114.toString() + loc58.toString());
            var loc13:*=parseInt(loc122.toString() + loc116.toString());
            loc161.timeInZone3 = (loc209 * 3600 + loc100 * 60 + loc13) * 100;
            var loc162:*=(_7infotripArray[arg1 + 37] & 240) >> 4;
            var loc175:*=_7infotripArray[arg1 + 37] & 15;
            var loc176:*=(_7infotripArray[arg1 + 36] & 240) >> 4;
            var loc210:*=_7infotripArray[arg1 + 36] & 15;
            var loc171:*=(_7infotripArray[arg1 + 35] & 240) >> 4;
            var loc207:*=_7infotripArray[arg1 + 35] & 15;
            var loc55:*=loc162.toString() + loc175.toString() + loc176.toString() + loc210.toString() + loc171.toString() + loc207.toString();
            loc161.calories = parseInt(loc55, 10);
            var loc63:*=(_7infotripArray[arg1 + 39] & 240) >> 4;
            var loc26:*=_7infotripArray[arg1 + 39] & 15;
            var loc23:*=(_7infotripArray[arg1 + 38] & 240) >> 4;
            var loc156:*=_7infotripArray[arg1 + 38] & 15;
            var loc132:*;
            (loc132 = new utils.converter.TemperatureConverter()).outputFormat = "celsius";
            if (loc63 != 15) 
            {
                loc161.minimumTemperature = loc132.convert(parseFloat(loc63.toString() + loc26.toString() + loc23.toString() + "." + loc156.toString()));
            }
            else 
            {
                loc41 = "-" + loc26.toString() + loc23.toString() + "." + loc156.toString();
                loc161.minimumTemperature = loc132.convert(new Number(loc41));
            }
            var loc57:*=(_7infotripArray[arg1 + 41] & 240) >> 4;
            var loc181:*=_7infotripArray[arg1 + 41] & 15;
            var loc185:*=(_7infotripArray[arg1 + 40] & 240) >> 4;
            var loc183:*=_7infotripArray[arg1 + 40] & 15;
            if (loc57 != 15) 
            {
                loc161.maximumTemperature = loc132.convert(parseFloat(loc57.toString() + loc181.toString() + loc185.toString() + "." + loc183.toString()));
            }
            else 
            {
                loc119 = "-" + loc181.toString() + loc185.toString() + "." + loc183.toString();
                loc161.maximumTemperature = loc132.convert(new Number(loc119));
            }
            var loc148:*=(_7infotripArray[arg1 + 43] & 240) >> 4;
            var loc194:*=_7infotripArray[arg1 + 43] & 15;
            var loc195:*=(_7infotripArray[arg1 + 42] & 240) >> 4;
            var loc184:*=_7infotripArray[arg1 + 42] & 15;
            var loc204:*;
            (loc204 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc204.outputFormat = "millimeter";
            if (loc148 != 15) 
            {
                loc161.maximumAltitude = loc204.convert(parseInt(loc148.toString() + loc194.toString() + loc195.toString() + loc184.toString(), 10));
            }
            else 
            {
                loc74 = "-" + loc194.toString() + loc195.toString() + loc184.toString();
                loc161.maximumAltitude = loc204.convert(new Number(loc74));
            }
            var loc32:*=(_7infotripArray[arg1 + 44] & 240) >> 4;
            var loc90:*=_7infotripArray[arg1 + 44] & 15;
            var loc80:*=(_7infotripArray[arg1 + 45] & 240) >> 4;
            var loc16:*=_7infotripArray[arg1 + 45] & 15;
            var loc78:*=(_7infotripArray[arg1 + 46] & 240) >> 4;
            var loc3:*=_7infotripArray[arg1 + 46] & 15;
            var loc147:*=loc78.toString() + loc3.toString() + loc80.toString() + loc16.toString() + "." + loc32.toString() + loc90.toString();
            loc161.distanceUphill = loc47.convert(new Number(loc147)) * 1000;
            var loc187:*=_7infotripArray[arg1 + 50] & 15;
            var loc12:*=(_7infotripArray[arg1 + 49] & 240) >> 4;
            var loc186:*=_7infotripArray[arg1 + 49] & 15;
            var loc190:*=(_7infotripArray[arg1 + 48] & 240) >> 4;
            var loc53:*=_7infotripArray[arg1 + 48] & 15;
            var loc189:*=(_7infotripArray[arg1 + 47] & 240) >> 4;
            var loc70:*=_7infotripArray[arg1 + 47] & 15;
            var loc123:*=parseInt(loc187.toString() + loc12.toString() + loc186.toString());
            var loc52:*=parseInt(loc190.toString() + loc53.toString());
            var loc173:*=parseInt(loc189.toString() + loc70.toString());
            loc161.trainingTimeUphill = (loc123 * 3600 + loc52 * 60 + loc173) * 100;
            var loc158:*=(_7infotripArray[arg1 + 52] & 240) >> 4;
            var loc157:*=_7infotripArray[arg1 + 52] & 15;
            var loc155:*=(_7infotripArray[arg1 + 51] & 240) >> 4;
            var loc1:*=_7infotripArray[arg1 + 51] & 15;
            var loc154:*=(_7infotripArray[arg1 + 50] & 240) >> 4;
            var loc89:*=loc158.toString() + loc157.toString() + loc155.toString() + "." + loc1.toString() + loc154.toString();
            loc161.averageSpeedUphill = loc144.convert(new Number(loc89));
            var loc106:*=(_7infotripArray[arg1 + 53] & 240) >> 4;
            var loc107:*=_7infotripArray[arg1 + 53] & 15;
            var loc139:*=loc106.toString() + loc107.toString();
            loc161.averageInclineUphill = parseInt(loc139, 10);
            var loc197:*=(_7infotripArray[arg1 + 54] & 240) >> 4;
            var loc179:*=_7infotripArray[arg1 + 54] & 15;
            var loc177:*=loc197.toString() + loc179.toString();
            loc161.maximumInclineUphill = parseInt(loc177, 10);
            var loc56:*=(_7infotripArray[arg1 + 56] & 240) >> 4;
            var loc99:*=_7infotripArray[arg1 + 56] & 15;
            var loc101:*=(_7infotripArray[arg1 + 55] & 240) >> 4;
            var loc202:*=_7infotripArray[arg1 + 55] & 15;
            var loc95:*;
            var loc164:*=(loc95 = _7infotripArray[arg1 + 57] & 15).toString() + loc56.toString() + loc99.toString() + loc101.toString() + loc202.toString();
            loc161.altitudeDifferencesUphill = loc204.convert(parseInt(loc164, 10));
            var loc159:*=(_7infotripArray[arg1 + 59] & 240) >> 4;
            var loc9:*=_7infotripArray[arg1 + 59] & 15;
            var loc14:*=(_7infotripArray[arg1 + 58] & 240) >> 4;
            var loc91:*=_7infotripArray[arg1 + 58] & 15;
            var loc11:*=(_7infotripArray[arg1 + 57] & 240) >> 4;
            var loc118:*=loc159.toString() + loc9.toString() + loc14.toString() + loc91.toString() + loc11.toString();
            loc161.altitudeDifferencesDownhill = loc204.convert(parseInt(loc118, 10));
            var loc201:*=(_7infotripArray[arg1 + 62] & 240) >> 4;
            var loc127:*=_7infotripArray[arg1 + 62] & 15;
            var loc126:*=(_7infotripArray[arg1 + 61] & 240) >> 4;
            var loc191:*=_7infotripArray[arg1 + 61] & 15;
            var loc125:*=(_7infotripArray[arg1 + 60] & 240) >> 4;
            var loc167:*=_7infotripArray[arg1 + 60] & 15;
            var loc103:*=loc201.toString() + loc127.toString() + loc126.toString() + loc191.toString() + "." + loc125.toString() + loc167.toString();
            loc161.distanceDownhill = loc47.convert(new Number(loc103)) * 1000;
            var loc4:*=(_7infotripArray[arg1 + 63] & 240) >> 4;
            var loc135:*=_7infotripArray[arg1 + 63] & 15;
            var loc137:*=(_7infotripArray[arg1 + 64] & 240) >> 4;
            var loc24:*=_7infotripArray[arg1 + 64] & 15;
            var loc138:*=(_7infotripArray[arg1 + 65] & 240) >> 4;
            var loc43:*=_7infotripArray[arg1 + 65] & 15;
            var loc134:*=_7infotripArray[arg1 + 66] & 15;
            var loc200:*=parseInt(loc134.toString() + loc138.toString() + loc43.toString());
            var loc112:*=parseInt(loc137.toString() + loc24.toString());
            var loc131:*=parseInt(loc4.toString() + loc135.toString());
            loc161.trainingTimeDownhill = (loc200 * 3600 + loc112 * 60 + loc131) * 100;
            var loc141:*=(_7infotripArray[arg1 + 68] & 240) >> 4;
            var loc37:*=_7infotripArray[arg1 + 68] & 15;
            var loc39:*=(_7infotripArray[arg1 + 67] & 240) >> 4;
            var loc50:*=_7infotripArray[arg1 + 67] & 15;
            var loc35:*=(_7infotripArray[arg1 + 66] & 240) >> 4;
            var loc85:*=loc141.toString() + loc37.toString() + loc39.toString() + "." + loc50.toString() + loc35.toString();
            loc161.averageSpeedDownhill = loc144.convert(new Number(loc85));
            var loc174:*=(_7infotripArray[arg1 + 69] & 240) >> 4;
            var loc136:*=_7infotripArray[arg1 + 69] & 15;
            var loc140:*=loc174.toString() + loc136.toString();
            loc161.averageInclineDownhill = parseInt(loc140, 10);
            var loc62:*=(_7infotripArray[arg1 + 70] & 240) >> 4;
            var loc203:*=_7infotripArray[arg1 + 70] & 15;
            var loc153:*=loc62.toString() + loc203.toString();
            loc161.maximumInclineDownhill = parseInt(loc153, 10);
            var loc163:*=(_7infotripArray[arg1 + 72] & 112) >> 4;
            var loc64:*=_7infotripArray[arg1 + 72] & 15;
            var loc65:*=(_7infotripArray[arg1 + 71] & 240) >> 4;
            var loc133:*=_7infotripArray[arg1 + 71] & 15;
            var loc113:*=loc163.toString() + loc64.toString() + loc65.toString() + loc133.toString();
            loc161.wheelSize = parseInt(loc113);
            var loc199:*=(_7infotripArray[arg1 + 73] & 240) >> 4;
            var loc128:*=_7infotripArray[arg1 + 73] & 15;
            var loc86:*=loc199.toString(16) + loc128.toString(16);
            loc161.hrMax = parseInt(loc86, 16);
            var loc168:*=(_7infotripArray[arg1 + 74] & 240) >> 4;
            var loc45:*=_7infotripArray[arg1 + 74] & 15;
            var loc68:*=loc168.toString(16) + loc45.toString(16);
            loc161.zone1Start = parseInt(loc68, 16);
            var loc205:*=(_7infotripArray[arg1 + 75] & 240) >> 4;
            var loc20:*=_7infotripArray[arg1 + 75] & 15;
            var loc87:*=loc205.toString(16) + loc20.toString(16);
            loc161.zone2Start = parseInt(loc87, 16);
            var loc198:*=(_7infotripArray[arg1 + 76] & 240) >> 4;
            var loc208:*=_7infotripArray[arg1 + 76] & 15;
            var loc27:*=loc198.toString(16) + loc208.toString(16);
            loc161.zone3Start = parseInt(loc27, 16);
            var loc143:*=(_7infotripArray[arg1 + 77] & 240) >> 4;
            var loc88:*=_7infotripArray[arg1 + 77] & 15;
            var loc76:*=loc143.toString(16) + loc88.toString(16);
            loc161.zone3End = parseInt(loc76, 16);
            var loc2:*=(_7infotripArray[arg1 + 78] & 240) >> 4;
            var loc188:*=_7infotripArray[arg1 + 78] & 15;
            var loc5:*=loc2.toString(16) + loc188.toString(16);
            return loc161;
        }

        internal function decodeTripList():Array
        {
            var loc2:*=_7infotripArray[553] & 15;
            var loc1:*=(_7infotripArray[553] & 240) >> 4;
            var loc3:*=new Array(2);
            loc3[0] = loc2;
            loc3[1] = loc1;
            return loc3;
        }

        internal function createChecksum3(arg1:Array):Number
        {
            var loc1:*=NaN;
            var loc2:*=null;
            var loc3:*=0;
            loc1 = 0;
            while (loc1 < 136) 
            {
                loc2 = arg1.slice(loc1, loc1 + 1);
                loc3 = loc3 + parseInt(loc2[0]);
                ++loc1;
            }
            return loc3;
        }

        internal function setFavIndex(arg1:String):uint
        {
            if (core.general.Favorites.FAVORITES_GUI.indexOf(arg1) == 40) 
            {
                return 9;
            }
            return core.general.Favorites.FAVORITES.indexOf(arg1);
        }

        internal function calculateValuesFromBasisValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.Activity
        {
            if (arg1.zone1Start <= arg2.heartrate && arg1.zone2Start > arg2.heartrate) 
            {
                arg2.targetZone = 1;
                arg1.timeInZone1 = arg1.timeInZone1 + arg2.trainingTime;
            }
            else if (arg1.zone2Start <= arg2.heartrate && arg1.zone3Start > arg2.heartrate) 
            {
                arg2.targetZone = 2;
                arg1.timeInZone2 = arg1.timeInZone2 + arg2.trainingTime;
            }
            else if (arg1.zone3Start <= arg2.heartrate && arg1.zone3End > arg2.heartrate) 
            {
                arg2.targetZone = 3;
                arg1.timeInZone3 = arg1.timeInZone3 + arg2.trainingTime;
            }
            else 
            {
                arg2.targetZone = 0;
                arg1.timeOutOfZone = arg1.timeOutOfZone + arg2.trainingTime;
            }
            if (arg3 != null) 
            {
                arg2.distance = calculateDistance(arg1.wheelSize, arg2.relativeRotations);
                if (arg1.entries.length > 0) 
                {
                    arg2.distanceAbsolute = arg3.distanceAbsolute + arg2.distance;
                    arg2.trainingTimeAbsolute = arg3.trainingTimeAbsolute + arg2.trainingTime;
                }
                if (arg3.altitude < arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesUphill = arg2.altitude - arg3.altitude;
                    arg2.distanceUphill = arg2.distance;
                    arg2.trainingTimeUphill = arg2.trainingTime;
                    arg1.distanceUphill = arg1.distanceUphill + arg2.distanceUphill;
                    arg1.trainingTimeUphill = arg1.trainingTimeUphill + arg2.trainingTimeUphill;
                    arg1.altitudeDifferencesUphill = arg1.altitudeDifferencesUphill + arg2.altitudeDifferencesUphill;
                }
                else if (arg3.altitude > arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesDownhill = arg3.altitude - arg2.altitude;
                    arg2.distanceDownhill = arg2.distance;
                    arg2.trainingTimeDownhill = arg2.trainingTime;
                    arg1.distanceDownhill = arg1.distanceDownhill + arg2.distanceDownhill;
                    arg1.trainingTimeDownhill = arg1.trainingTimeDownhill + arg2.trainingTimeDownhill;
                    arg1.altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill + arg2.altitudeDifferencesDownhill;
                }
                else 
                {
                    arg2.altitudeDifferencesDownhill = 0;
                    arg2.distanceDownhill = 0;
                    arg2.trainingTimeDownhill = 0;
                    arg2.altitudeDifferencesUphill = 0;
                    arg2.distanceUphill = 0;
                    arg2.trainingTimeUphill = 0;
                }
            }
            arg1.pauseTime = arg1.pauseTime + arg2.pauseTime;
            arg1.trainingTime = arg1.trainingTime + arg2.trainingTime;
            arg1.distance = arg1.distance + arg2.distance;
            return arg1;
        }

        internal function calcMinMaxValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry):core.activities.Activity
        {
            if (arg1.minimumSpeed > arg2.speed || isNaN(arg1.minimumSpeed)) 
            {
                arg1.minimumSpeed = arg2.speed;
            }
            if (arg1.maximumSpeed < arg2.speed || isNaN(arg1.maximumSpeed)) 
            {
                arg1.maximumSpeed = arg2.speed;
            }
            if (arg1.minimumAltitude > arg2.altitude || isNaN(arg1.minimumAltitude)) 
            {
                arg1.minimumAltitude = arg2.altitude;
            }
            if (arg1.maximumAltitude < arg2.altitude || isNaN(arg1.maximumAltitude)) 
            {
                arg1.maximumAltitude = arg2.altitude;
            }
            if (arg1.maximumHeartrate < arg2.heartrate || isNaN(arg1.maximumHeartrate)) 
            {
                arg1.maximumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumHeartrate > arg2.heartrate || isNaN(arg1.minimumHeartrate)) 
            {
                arg1.minimumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumTemperature > arg2.temperature || isNaN(arg1.minimumTemperature)) 
            {
                arg1.minimumTemperature = arg2.temperature;
            }
            if (arg1.maximumTemperature < arg2.temperature || isNaN(arg1.maximumTemperature)) 
            {
                arg1.maximumTemperature = arg2.temperature;
            }
            if (arg1.minimumIncline > arg2.incline || isNaN(arg1.minimumIncline)) 
            {
                arg1.minimumIncline = arg2.incline;
            }
            if (arg1.maximumIncline < arg2.incline || isNaN(arg1.maximumIncline)) 
            {
                arg1.maximumIncline = arg2.incline;
            }
            if (arg1.minimumRiseRate > arg2.riseRate || isNaN(arg1.minimumRiseRate)) 
            {
                arg1.minimumRiseRate = arg2.riseRate;
            }
            if (arg1.maximumRiseRate < arg2.riseRate || isNaN(arg1.maximumRiseRate)) 
            {
                arg1.maximumRiseRate = arg2.riseRate;
            }
            return arg1;
        }

        internal function calcAverages(arg1:core.activities.Activity, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):core.activities.Activity
        {
            var loc1:*=arg6;
            arg1.averageAltitude = arg3 / loc1;
            arg1.averageHeartrate = arg4 / loc1;
            arg1.averageSpeed = arg2 / loc1;
            arg1.averageTemperature = arg5 / loc1;
            return arg1;
        }

        internal function makeAbsolutEntry(arg1:core.activities.ActivityEntry, arg2:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            arg1.temperature = arg2.temperature;
            if (!(arg1.temperature > 40)) 
            {
            };
            return arg1;
        }

        internal function calculateRotations(arg1:Number, arg2:Number):uint
        {
            var loc1:*=0;
            if (arg1 < arg2) 
            {
                loc1 = arg1 - arg2 + 1024;
            }
            else 
            {
                loc1 = arg1 - arg2;
            }
            return loc1;
        }

        internal function calculateIncline(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number):Number
        {
            var loc2:*=0;
            var loc1:*=0;
            arg1 = arg1 / 1000;
            arg2 = arg2 / 1000;
            loc2 = 100 * (arg1 - arg2) / Math.sqrt(Math.pow(arg4 * arg3 / 1000, 2) - Math.pow(arg1 - arg2, 2));
            loc2 = (loc2 = Math.round(loc2 * 100)) / 100;
            if (isNaN(loc2)) 
            {
                loc2 = 0;
            }
            return loc2;
        }

        internal function calculateInclineRel(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=0;
            arg1 = arg1 / 1000;
            arg2 = arg2 / 1000;
            loc1 = 100 * (arg1 - arg2) / Math.sqrt(Math.pow(arg4 * arg3 / 1000, 2) - Math.pow(arg1 - arg2, 2));
            loc1 = (loc1 = Math.round(loc1 * 100)) / 100;
            if (isNaN(loc1)) 
            {
                loc1 = 0;
            }
            return Math.round(loc1);
        }

        internal function calculateDistance(arg1:int, arg2:int):Number
        {
            return Math.round(arg1 * arg2) / 1000;
        }

        internal function isPause(arg1:Array):Boolean
        {
            if ((arg1[0] & 1) == 0) 
            {
                return false;
            }
            return true;
        }

        internal function decodeAbsLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc8:*=0;
            var loc11:*=0;
            var loc5:*=0;
            var loc10:*;
            (loc10 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc13:*;
            var loc14:*=(loc13 = (arg1[0] & 252) >> 2) - 10;
            loc10.temperature = loc14;
            var loc7:*;
            if ((loc7 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc10.isWaypoint = true;
            }
            else 
            {
                loc10.isWaypoint = false;
            }
            var loc6:*;
            if ((loc6 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc10.heartrate = loc6;
            var loc1:*=(loc8 = (loc8 = (loc8 = (arg1[3] & 63) << 8) | arg1[2]) - 999) * 1000;
            if (loc1 == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc10.altitude = loc1;
            var loc9:*=0;
            var loc3:*=loc9 = (loc9 = (loc9 = (loc9 = (loc9 = arg1[5] & 1) << 8) | arg1[4]) << 1) | (arg1[3] & 128) >> 7;
            loc10.rotations = loc3;
            var loc12:*=0;
            if ((loc12 = (loc11 = (loc11 = (arg1[6] & 7) << 7) | arg1[5] >> 1) * 0.2) < 1 && loc12 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc10.speed = loc12;
            loc10.trainingTime = arg2.samplingRate * 100;
            var loc2:*=arg1[6] >> 3;
            var loc4:*=0;
            loc5 = 0;
            while (loc5 < 6) 
            {
                loc4 = (loc4 = loc4 + (arg1[loc5] & 15)) + ((arg1[loc5] & 240) >> 4);
                ++loc5;
            }
            if ((loc4 = (loc4 = loc4 + (arg1[6] & 7)) & 31) != loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc10;
        }

        internal function decodeAbsLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc7:*;
            (loc7 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = true;
            var loc11:*;
            var loc13:*=(loc11 = (arg1[0] & 252) >> 2) - 10;
            loc7.temperature = loc13;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc7.isWaypoint = true;
            }
            else 
            {
                loc7.isWaypoint = false;
            }
            var loc5:*;
            if ((loc5 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc7.heartrate = loc5;
            var loc10:*=0;
            if ((loc10 = ((loc10 = (loc10 = (arg1[3] & 63) << 8) | arg1[2]) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc7.altitude = loc10;
            var loc2:*=0;
            var loc8:*;
            if ((loc8 = loc2 = (loc2 = (arg1[4] & 31) << 1) | (arg1[3] & 128) >> 7) != 63) 
            {
                loc7.trainingTime = loc8;
            }
            var loc9:*=0;
            var loc12:*=loc9 = (loc9 = (loc9 = (arg1[6] & 7) << 11) | arg1[5] << 3) | (arg1[4] & 224) >> 5;
            loc7.pauseTime = loc12 * 100;
            var loc1:*=arg1[6] >> 3;
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 6) 
            {
                loc3 = (loc3 = loc3 + (arg1[loc4] & 15)) + ((arg1[loc4] & 240) >> 4);
                ++loc4;
            }
            if ((loc3 = (loc3 = loc3 + (arg1[6] & 7)) & 31) != loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc7;
        }

        internal function decodeRelLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc8:*=0;
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc9:*;
            if ((loc9 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc2.isWaypoint = true;
            }
            else 
            {
                loc2.isWaypoint = false;
            }
            var loc10:*=0;
            loc10 = (loc10 = (arg1[1] & 15) << 6) | (arg1[0] & 252) >> 2;
            loc2.rotations = loc10;
            var loc1:*=0;
            var loc5:*=0;
            loc1 = (arg1[2] & 63) << 4;
            loc1 = loc1 | (arg1[1] & 240) >> 4;
            if ((loc5 = loc1 * 0.2) < 1 && loc5 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc2.speed = loc5;
            var loc7:*;
            if ((loc7 = ((loc7 = (loc7 = (loc7 = (loc7 = (arg1[4] & 7) << 8) | arg1[3]) << 2) | (arg1[2] & 192) >> 6) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc2.altitude = loc7;
            var loc3:*=0;
            if ((loc3 = (loc3 = (arg1[5] & 7) << 5) | (arg1[4] & 248) >> 3) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc2.heartrate = loc3;
            loc2.trainingTime = arg2.samplingRate * 100;
            var loc4:*=arg1[5] >> 3;
            var loc6:*=0;
            loc8 = 0;
            while (loc8 < 5) 
            {
                loc6 = (loc6 = loc6 + (arg1[loc8] & 15)) + ((arg1[loc8] & 240) >> 4);
                ++loc8;
            }
            if ((loc6 = (loc6 = loc6 + (arg1[5] & 7)) & 31) != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc2;
        }

        internal function decodeRelLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc9:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = true;
            var loc10:*;
            if ((loc10 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc4:*;
            var loc2:*=(loc4 = (arg1[0] & 252) >> 2).toString();
            if (parseInt(loc2) != 63) 
            {
                loc1.trainingTime = parseInt(loc2);
            }
            var loc6:*=0;
            loc6 = (loc6 = (arg1[2] & 63) << 8) | arg1[1];
            loc1.pauseTime = loc6 * 100;
            var loc8:*;
            if ((loc8 = ((loc8 = (loc8 = (loc8 = (loc8 = (arg1[4] & 7) << 8) | arg1[3]) << 2) | (arg1[2] & 192) >> 6) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc8;
            var loc3:*=0;
            if ((loc3 = (loc3 = (arg1[5] & 7) << 5) | (arg1[4] & 248) >> 3) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc3;
            var loc5:*=arg1[5] >> 3;
            var loc7:*=0;
            loc9 = 0;
            while (loc9 < 5) 
            {
                loc7 = (loc7 = loc7 + (arg1[loc9] & 15)) + ((arg1[loc9] & 240) >> 4);
                ++loc9;
            }
            if ((loc7 = (loc7 = loc7 + (arg1[5] & 7)) & 31) != loc5) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc1;
        }

        internal function smoothEntries_v1(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc20:*=null;
            var loc28:*=null;
            var loc13:*=null;
            var loc18:*=null;
            var loc15:*=null;
            var loc22:*=NaN;
            var loc26:*=0;
            var loc6:*=0;
            var loc2:*=null;
            var loc21:*=null;
            var loc23:*=NaN;
            var loc24:*=arg1.entries;
            var loc34:*=0;
            var loc17:*=0;
            var loc30:*=0;
            var loc16:*=0;
            var loc1:*=0;
            var loc14:*=0;
            var loc12:*=0;
            var loc11:*=0;
            var loc10:*=0;
            var loc9:*=0;
            var loc19:*=0;
            var loc33:*=0;
            var loc32:*=0;
            var loc31:*=0;
            var loc29:*=0;
            var loc25:*=0;
            var loc27:*=0;
            var loc35:*=0;
            var loc36:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc3:*=0;
            loc22 = 0;
            while (loc22 < loc24.length) 
            {
                loc20 = loc24[loc22];
                if (loc22 > 0) 
                {
                    loc28 = loc24[(loc22 - 1)];
                    if (loc20.isPause) 
                    {
                        loc20.rotations = loc28.rotations;
                    }
                    loc20.relativeRotations = calculateRotations(loc20.rotations, loc28.rotations);
                }
                if (loc22 < (loc24.length - 1)) 
                {
                    if ((loc18 = loc24[loc22 + 1]).isPause) 
                    {
                        loc18.rotations = loc20.rotations;
                    }
                    loc18.relativeRotations = calculateRotations(loc18.rotations, loc20.rotations);
                }
                if (loc22 < loc24.length - 2) 
                {
                    if ((loc15 = loc24[loc22 + 2]).isPause) 
                    {
                        loc15.rotations = loc18.rotations;
                    }
                    loc15.relativeRotations = calculateRotations(loc15.rotations, loc18.rotations);
                }
                if (loc22 > 1) 
                {
                    loc13 = loc24[loc22 - 2];
                }
                if (loc20.speed < 0.5 && loc20.speed > 0) 
                {
                    if (loc28 == null) 
                    {
                        loc20.speed = 0;
                        loc20.riseRate = 0;
                    }
                    else 
                    {
                        loc20.speed = loc28.speed;
                        loc20.riseRate = loc28.riseRate;
                    }
                }
                if (loc20.altitude == 5000000) 
                {
                    if (loc28 == null) 
                    {
                        loc20.altitude = 0;
                        loc20.incline = 0;
                        loc20.riseRate = 0;
                    }
                    else 
                    {
                        loc20.altitude = loc28.altitude;
                        loc20.incline = loc28.incline;
                        loc20.riseRate = loc28.riseRate;
                    }
                }
                if (loc20.heartrate <= 20) 
                {
                    if (loc28 == null) 
                    {
                        loc20.heartrate = 0;
                    }
                    else 
                    {
                        loc20.heartrate = loc28.heartrate;
                    }
                }
                if (loc22 == 0) 
                {
                    loc20.trainingTime = 0;
                }
                if (loc20.isPause && !(loc28 == null) && loc28.isPause) 
                {
                    loc28.pauseTime = loc28.pauseTime + loc20.pauseTime;
                    loc28.relativeRotations = loc28.relativeRotations + loc20.relativeRotations;
                    loc28.trainingTime = loc28.trainingTime + loc20.trainingTime;
                    loc28.speed = (loc28.speed + loc20.speed) / 2;
                    loc28.altitude = (loc28.altitude + loc20.altitude) / 2;
                    loc28.temperature = (loc28.temperature + loc20.temperature) / 2;
                    loc28.heartrate = (loc28.heartrate + loc20.heartrate) / 2;
                    if (loc28.isWaypoint || loc20.isWaypoint) 
                    {
                        loc28.isWaypoint = true;
                    }
                    handler.ActivityCalculator.removeEntryFromEntriesVector(loc20, loc24);
                    --loc22;
                }
                else 
                {
                    if (!(loc28 == null) && !(loc13 == null) && loc28.isPause) 
                    {
                        loc26 = loc13.relativeRotations * 0.7 / arg1.samplingRate * 100 * loc28.trainingTime;
                        if (loc28.trainingTime > 0 && loc26 == 0) 
                        {
                            loc26 = 1;
                        }
                        if ((loc6 = loc20.relativeRotations - loc26) < 0) 
                        {
                            loc6 = 0;
                            loc28.relativeRotations = loc20.relativeRotations;
                        }
                        else 
                        {
                            loc28.relativeRotations = loc26;
                        }
                        loc20.relativeRotations = loc6;
                        if (!loc20.isPause) 
                        {
                            loc13.trainingTime = loc13.trainingTime + loc28.trainingTime;
                            loc13.trainingTimeAbsolute = loc13.trainingTimeAbsolute + loc28.trainingTime;
                            loc13.relativeRotations = loc13.relativeRotations + loc28.relativeRotations;
                            loc28.trainingTime = 0;
                            loc28.trainingTimeAbsolute = loc13.trainingTimeAbsolute;
                            loc28.trainingTimeDownhill = 0;
                            loc28.trainingTimeUphill = 0;
                            loc28.relativeRotations = 0;
                            loc28.altitudeDifferencesDownhill = 0;
                            loc28.altitudeDifferencesUphill = 0;
                            loc28.distance = 0;
                            loc28.distanceDownhill = 0;
                            loc28.distanceUphill = 0;
                            loc28.temperature = loc13.temperature;
                            loc28.incline = 0;
                            loc28.riseRate = 0;
                            loc28.speed = 0;
                        }
                    }
                    if (arg1.samplingRate != 4.5) 
                    {
                        if (arg1.samplingRate != 10.125) 
                        {
                            if (arg1.samplingRate != 20.25) 
                            {
                                if (arg1.samplingRate == 30.375) 
                                {
                                    if (loc28) 
                                    {
                                        loc20.incline = calculateIncline(loc20.altitude, loc28.altitude, arg1.wheelSize, loc20.relativeRotations, loc28.relativeRotations);
                                        loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                                    }
                                }
                            }
                            else if (loc28) 
                            {
                                loc20.incline = calculateIncline(loc20.altitude, loc28.altitude, arg1.wheelSize, loc20.relativeRotations, loc28.relativeRotations);
                                loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                            }
                        }
                        else 
                        {
                            if (loc20.heartrate == 0 && loc18 && loc28) 
                            {
                                if (loc18.heartrate != 0) 
                                {
                                    if (loc28 != null) 
                                    {
                                        loc20.heartrate = loc28.heartrate;
                                        ++loc3;
                                    }
                                }
                            }
                            if (loc22 == 0 && loc18) 
                            {
                                loc14 = loc20.altitude;
                                loc12 = loc18.altitude;
                                loc33 = loc19 = (loc14 + loc12) / 2;
                                loc29 = loc20.relativeRotations;
                                loc25 = loc18.relativeRotations;
                                loc8 = loc7 = (loc29 + loc25) / 2;
                            }
                            else if (loc22 == (loc24.length - 1) && loc28) 
                            {
                                loc14 = loc28.altitude;
                                loc12 = loc20.altitude;
                                loc32 = (loc14 + loc12) / 2;
                                loc29 = loc28.relativeRotations;
                                loc25 = loc20.relativeRotations;
                                loc4 = (loc29 + loc25) / 2;
                                loc28.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc25);
                                loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100 * 1000;
                                loc20.incline = this.calculateInclineRel(loc32, loc33, arg1.wheelSize, loc27);
                                loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                            }
                            else if (loc28 && loc18) 
                            {
                                loc14 = loc28.altitude;
                                loc12 = loc20.altitude;
                                loc11 = loc18.altitude;
                                loc29 = loc28.relativeRotations;
                                loc25 = loc20.relativeRotations;
                                loc27 = loc18.relativeRotations;
                                loc32 = (loc14 + loc12 + loc11) / 3;
                                loc4 = (loc29 + loc25 + loc27) / 3;
                                if (loc28.isPause) 
                                {
                                    loc19 = loc33 = loc32 = (loc20.altitude + loc18.altitude) / 2;
                                    loc7 = loc8 = loc4 = (loc20.relativeRotations + loc18.relativeRotations) / 2;
                                }
                                else 
                                {
                                    if (loc20.isPause) 
                                    {
                                        loc12 = loc11 = loc28.altitude;
                                        loc25 = loc27 = loc28.relativeRotations;
                                    }
                                    else if (loc18.isPause) 
                                    {
                                        loc11 = loc20.altitude;
                                        loc27 = loc20.relativeRotations;
                                    }
                                    loc32 = (loc14 + loc12 + loc11) / 3;
                                    loc4 = (loc29 + loc25 + loc27) / 3;
                                    loc28.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc25);
                                    loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100;
                                    loc19 = loc33;
                                    loc33 = loc32;
                                    loc7 = loc8;
                                    loc8 = loc4;
                                }
                            }
                        }
                    }
                    else 
                    {
                        if (loc20.heartrate == 0 && loc28 && loc18 && loc15) 
                        {
                            if (loc18.heartrate != 0) 
                            {
                                if (loc28 != null) 
                                {
                                    loc20.heartrate = loc28.heartrate;
                                    ++loc3;
                                }
                            }
                            else if (loc15.heartrate != 0) 
                            {
                                if (loc28 != null) 
                                {
                                    loc20.heartrate = loc28.heartrate;
                                    loc18.heartrate = loc28.heartrate;
                                    loc3 = loc3 + 2;
                                }
                            }
                        }
                        if (loc22 == 0 && loc18 && loc15) 
                        {
                            loc14 = loc20.altitude;
                            loc12 = loc18.altitude;
                            loc11 = loc15.altitude;
                            loc33 = loc19 = (loc14 + loc12 + loc11) / 3;
                            loc29 = loc20.relativeRotations;
                            loc25 = loc18.relativeRotations;
                            loc27 = loc15.relativeRotations;
                            loc8 = loc7 = (loc29 + loc25 + loc27) / 3;
                        }
                        else if (loc22 == 1 && loc28 && loc18 && loc15) 
                        {
                            loc14 = loc28.altitude;
                            loc12 = loc20.altitude;
                            loc11 = loc18.altitude;
                            loc10 = loc15.altitude;
                            loc32 = (loc14 + loc12 + loc11 + loc10) / 4;
                            loc29 = loc28.relativeRotations;
                            loc25 = loc20.relativeRotations;
                            loc27 = loc18.relativeRotations;
                            loc35 = loc15.relativeRotations;
                            loc4 = (loc29 + loc25 + loc27 + loc35) / 4;
                        }
                        else if (loc22 == (loc24.length - 1) && loc13 && loc28) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc31 = (loc14 + loc12 + loc11) / 3;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc5 = (loc29 + loc25 + loc27) / 3;
                            loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                            loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                            loc28.incline = this.calculateInclineRel(loc32, loc33, arg1.wheelSize, loc4);
                            loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100 * 1000;
                            loc20.incline = this.calculateInclineRel(loc31, loc32, arg1.wheelSize, loc5);
                            loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                        }
                        else if (loc22 == loc24.length - 2 && loc13 && loc28 && loc18) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc10 = loc18.altitude;
                            loc31 = (loc14 + loc12 + loc11 + loc10) / 4;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc35 = loc18.relativeRotations;
                            loc5 = (loc29 + loc25 + loc27 + loc35) / 4;
                            loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                            loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                            loc7 = loc8;
                            loc8 = loc4;
                            loc4 = loc5;
                            loc19 = loc33;
                            loc33 = loc32;
                            loc32 = loc31;
                        }
                        else if (loc13 && loc28 && loc18 && loc15) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc10 = loc18.altitude;
                            loc9 = loc15.altitude;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc35 = loc18.relativeRotations;
                            loc36 = loc15.relativeRotations;
                            loc31 = (loc14 + loc12 + loc11 + loc10 + loc9) / 5;
                            loc5 = (loc29 + loc25 + loc27 + loc35 + loc36) / 5;
                            if (loc13.isPause) 
                            {
                                loc19 = loc33 = loc32 = loc31 = (loc28.altitude + loc20.altitude + loc18.altitude + loc15.altitude) / 4;
                                loc7 = loc8 = loc4 = loc5 = (loc28.relativeRotations + loc20.relativeRotations + loc18.relativeRotations + loc15.relativeRotations) / 4;
                            }
                            else 
                            {
                                if (loc28.isPause) 
                                {
                                    loc12 = loc11 = loc10 = loc9 = loc13.altitude;
                                    loc25 = loc27 = loc35 = loc36 = loc13.relativeRotations;
                                }
                                else if (loc20.isPause) 
                                {
                                    loc11 = loc10 = loc9 = loc28.altitude;
                                    loc27 = loc35 = loc36 = loc28.relativeRotations;
                                }
                                else if (loc18.isPause) 
                                {
                                    loc10 = loc9 = loc20.altitude;
                                    loc35 = loc36 = loc20.relativeRotations;
                                }
                                else if (loc15.isPause) 
                                {
                                    loc9 = loc18.altitude;
                                    loc36 = loc18.relativeRotations;
                                }
                                loc31 = (loc14 + loc12 + loc11 + loc10 + loc9) / 5;
                                loc5 = (loc29 + loc25 + loc27 + loc35 + loc36) / 5;
                                loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                                loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                                loc7 = loc8;
                                loc8 = loc4;
                                loc4 = loc5;
                                loc19 = loc33;
                                loc33 = loc32;
                                loc32 = loc31;
                            }
                        }
                    }
                }
                ++loc22;
            }
            arg1.pauseTime = 0;
            arg1.trainingTime = 0;
            arg1.distance = 0;
            loc23 = 0;
            while (loc23 < loc24.length) 
            {
                loc2 = loc24[loc23];
                if (loc23 > 0) 
                {
                    loc21 = loc24[(loc23 - 1)];
                }
                if (!loc2.isPause) 
                {
                    loc34 = loc34 + loc2.speed;
                    loc17 = loc17 + loc2.altitude;
                    loc30 = loc30 + loc2.heartrate;
                    loc16 = loc16 + loc2.temperature;
                    ++loc1;
                }
                loc2.calories = arg1.calories / loc24.length;
                arg1 = calculateValuesFromBasisValues(arg1, loc2, loc21);
                arg1 = calcMinMaxValues(arg1, loc2);
                ++loc23;
            }
            arg1 = calcAverages(arg1, loc34, loc17, loc30, loc16, loc1);
            return arg1;
        }

        public static const MY_NAME:Array=["*", "+", "-", "=", ".", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "♥"];

        internal var _7infotripArray:Array;

        internal static var _instance:decoder.RoxDecoder;
    }
}


//  class Topline2009Decoder
package decoder 
{
    import __AS3__.vec.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import utils.converter.*;
    
    public class Topline2009Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings
    {
        public function Topline2009Decoder()
        {
            super();
            return;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc31:*;
            (loc31 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsTopline2009).unit = arg2;
            var loc15:*=false;
            var loc28:*;
            if (!(loc15 = (loc28 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc32:*=arg1[1];
            var loc4:*="";
            var loc11:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc3:*;
            (loc3 = core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type) as core.totals.TotalsBikeComputer).unit = arg2;
            var loc4:*=false;
            var loc12:*;
            if (!(loc4 = (loc12 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc15:*;
            (loc15 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc15.outputFormat = "meter";
            var loc13:*;
            (loc13 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc13.outputFormat = "millimeter";
            var loc5:*=parseInt(arg1[46].toString() + arg1[47].toString() + arg1[48].toString() + arg1[49].toString() + arg1[50].toString());
            if (loc3 is core.totals.interfaces.ITotalDistance1) 
            {
                (loc3 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc15.convert(loc5);
            }
            var loc10:*=parseInt(arg1[51].toString() + arg1[52].toString() + arg1[53].toString() + arg1[54].toString() + arg1[55].toString());
            if (loc3 is core.totals.interfaces.ITotalDistance2) 
            {
                (loc3 as core.totals.interfaces.ITotalDistance2).totalDistance2 = loc15.convert(loc10);
            }
            var loc14:*=parseInt(arg1[56].toString() + arg1[57].toString() + arg1[58].toString() + arg1[59].toString()) * 3600;
            var loc8:*=parseInt(arg1[60].toString() + arg1[61].toString()) * 60;
            if (loc3 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (loc3 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = (loc14 + loc8) * 100;
            }
            var loc2:*=parseInt(arg1[62].toString() + arg1[63].toString() + arg1[64].toString() + arg1[65].toString()) * 3600;
            var loc9:*=parseInt(arg1[66].toString() + arg1[67].toString()) * 60;
            if (loc3 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (loc3 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = (loc2 + loc9) * 100;
            }
            var loc7:*=parseInt(arg1[68].toString() + arg1[69].toString() + arg1[70].toString() + arg1[71].toString() + arg1[72].toString());
            if (loc3 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (loc3 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = loc13.convert(loc7);
            }
            var loc6:*=parseInt(arg1[73].toString() + arg1[74].toString() + arg1[75].toString() + arg1[76].toString() + arg1[77].toString());
            if (loc3 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (loc3 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = loc13.convert(loc6);
            }
            var loc1:*=parseInt(arg1[86].toString() + arg1[87].toString() + arg1[88].toString() + arg1[89].toString());
            loc1 = loc1 * 3600;
            loc1 = loc1 + parseInt(arg1[90].toString() + arg1[91].toString()) * 60;
            var loc11:*=parseInt(arg1[92].toString() + arg1[93].toString() + arg1[94].toString() + arg1[95].toString() + arg1[96].toString());
            if (loc3 is core.totals.interfaces.ITotalHikingTime) 
            {
                (loc3 as core.totals.interfaces.ITotalHikingTime).totalHikingTime = loc1 * 100;
            }
            if (loc3 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                (loc3 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude = loc13.convert(loc11);
            }
            return loc3;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc89:*=null;
            var loc70:*=null;
            var loc86:*=NaN;
            var loc35:*=null;
            var loc109:*=null;
            var loc94:*=[];
            var loc28:*=arg1.currentSettings as core.settings.SettingsTopline2009;
            var loc75:*=(arg1 as core.units.UnitTopline2009).currentTotals as core.totals.TotalsBikeComputer;
            var loc83:*=0;
            loc94.push(loc83);
            var loc80:*=parseInt(1.toString(), 16);
        }

        public function decodeMemory(arg1:Object, arg2:core.units.UnitTopline2009):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc17:*=NaN;
            var loc1:*=core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory");
            loc1.unit = arg2;
            loc1.serialNumber = arg2.serialNumber;
            var loc22:*;
            var loc15:*;
            if (!(loc15 = (loc22 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc11:*;
            (loc11 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc11.outputFormat = "meter";
            var loc5:*=new Number(arg1[1].toString() + arg1[2].toString() + arg1[3].toString() + arg1[4].toString() + "." + arg1[5].toString() + arg1[6].toString());
            if (loc1.distanceDefined) 
            {
                loc1.distance = loc11.convert(loc5);
            }
            var loc13:*=parseInt(arg1[7].toString() + arg1[8].toString() + arg1[9].toString());
            var loc7:*=parseInt(arg1[10].toString() + arg1[11].toString());
            var loc10:*=parseInt(arg1[12].toString() + arg1[13].toString());
            var loc12:*=loc13 * 3600 + loc7 * 60 + loc10;
            if (loc1.trainingTimeDefined) 
            {
                loc1.trainingTime = loc12 * 100;
            }
            loc1.dateCode = loc5 + "_" + loc12;
            var loc2:*;
            (loc2 = new utils.converter.SpeedConverter()).inputFormat = core.MeasurementConfig.speedFormat;
            loc2.outputFormat = "ms";
            var loc19:*=new Number(arg1[14].toString() + arg1[15].toString() + arg1[16].toString() + "." + arg1[17].toString() + arg1[18].toString());
            if (loc1.averageSpeedDefined) 
            {
                loc1.averageSpeed = loc2.convert(loc19);
            }
            if (core.general.UnitType.BC509 == loc1.unitType) 
            {
                if (loc1.trainingTime != 0) 
                {
                    loc17 = loc1.distance / loc1.trainingTime;
                    loc1.averageSpeed = loc17;
                }
            }
            var loc18:*=new Number(arg1[19].toString() + arg1[20].toString() + arg1[21].toString() + "." + arg1[22].toString() + arg1[23].toString());
            if (loc1.maximumSpeedDefined) 
            {
                loc1.maximumSpeed = loc2.convert(loc18);
            }
            var loc14:*=parseInt(arg1[24].toString() + arg1[25].toString() + arg1[26].toString());
            if (loc1.averageCadenceDefined) 
            {
                loc1.averageCadence = loc14;
            }
            var loc4:*=parseInt(arg1[27].toString() + arg1[28].toString() + arg1[29].toString());
            if (loc1.averageHeartrateDefined) 
            {
                loc1.averageHeartrate = loc4;
            }
            var loc8:*=parseInt(arg1[30].toString() + arg1[31].toString() + arg1[32].toString());
            if (loc1.maximumHeartrateDefined) 
            {
                loc1.maximumHeartrate = loc8;
            }
            var loc20:*=parseInt(arg1[33].toString() + arg1[34].toString() + arg1[35].toString() + arg1[36].toString());
            if (loc1.caloriesDefined) 
            {
                loc1.calories = loc20;
            }
            var loc9:*;
            (loc9 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc9.outputFormat = "millimeter";
            var loc3:*=parseInt(arg1[37].toString() + arg1[38].toString() + arg1[39].toString() + arg1[40].toString() + arg1[41].toString());
            var loc6:*;
            var loc23:*=(loc6 = arg1[42]) == 0;
            if (loc1.altitudeDifferencesDownhillDefined && loc23) 
            {
                loc1.altitudeDifferencesDownhill = loc9.convert(loc3);
            }
            else if (loc1.altitudeDifferencesUphillDefined) 
            {
                loc1.altitudeDifferencesUphill = loc9.convert(loc3);
            }
            var loc16:*=parseInt(arg1[43].toString() + arg1[44].toString() + arg1[45].toString() + arg1[46].toString() + arg1[47].toString());
            if (loc1.maximumAltitudeDefined) 
            {
                loc1.maximumAltitude = loc9.convert(loc16);
            }
            loc1.startDate = new Date();
            var loc21:*;
            (loc21 = new __AS3__.vec.Vector.<core.activities.Activity>()).push(loc1);
            return loc21;
        }

        internal function push(arg1:Array, arg2:Array):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                arg2.push(arg1[loc1]);
                ++loc1;
            }
            return;
        }

        public static function getInstance():decoder.Topline2009Decoder
        {
            if (_instance == null) 
            {
                _instance = new Topline2009Decoder();
            }
            return _instance as Topline2009Decoder;
        }

        public static const DATA_INVALID:String="data_not_valid";

        internal static var _instance:decoder.Topline2009Decoder;
    }
}


//  class Topline2012Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import utils.converter.*;
    import utils.date.*;
    
    public class Topline2012Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.units.interfaces.ICodingTotals
    {
        public function Topline2012Decoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10123, "Topline2012Decoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc26:*;
            (loc26 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsTopline2012).unit = arg2;
            var loc12:*=false;
            var loc24:*;
            if (!(loc12 = (loc24 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            var loc3:*="";
            var loc9:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc10:*=0;
            var loc7:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc9:*=null;
            var loc6:*=0;
            var loc8:*=0;
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
            loc1.unit = arg2;
            var loc2:*=false;
            var loc3:*;
            if (!(loc2 = (loc3 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc10 = arg1[1] << 24 | arg1[2] << 16 | arg1[3] << 8 | arg1[4];
                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc10;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc7 = arg1[5] << 24 | arg1[6] << 16 | arg1[7] << 8 | arg1[8];
                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = loc7;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc4 = arg1[9] << 24 | arg1[10] << 16 | arg1[11] << 8 | arg1[12];
                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = loc4 * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc5 = arg1[13] << 24 | arg1[14] << 16 | arg1[15] << 8 | arg1[16];
                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = loc5 * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc9 = new utils.converter.AltitudeConverter("meter", "millimeter");
                loc6 = arg1[17] << 16 | arg1[18] << 8 | arg1[19];
                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = loc9.convert(loc6 / 10);
            }
            if (loc1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc8 = arg1[20] << 16 | arg1[21] << 8 | arg1[22];
                (loc1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 = loc8 / 100;
            }
            return loc1;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc4:*=null;
            var loc13:*=[];
            var loc14:*=arg1.currentSettings as core.settings.SettingsTopline2012;
            var loc5:*=1;
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc4:*=[];
            var loc6:*=0;
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc6 = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1;
            }
            loc4.push(loc6 >> 24 & 255);
            loc4.push(loc6 >> 16 & 255);
            loc4.push(loc6 >> 8 & 255);
            loc4.push(loc6 & 255);
            var loc5:*=0;
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc5 = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2;
            }
            loc4.push(loc5 >> 24 & 255);
            loc4.push(loc5 >> 16 & 255);
            loc4.push(loc5 >> 8 & 255);
            loc4.push(loc5 & 255);
            var loc1:*=0;
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc1 = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 / 100;
            }
            loc4.push(loc1 >> 24 & 255);
            loc4.push(loc1 >> 16 & 255);
            loc4.push(loc1 >> 8 & 255);
            loc4.push(loc1 & 255);
            var loc2:*=0;
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc2 = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 / 100;
            }
            loc4.push(loc2 >> 24 & 255);
            loc4.push(loc2 >> 16 & 255);
            loc4.push(loc2 >> 8 & 255);
            loc4.push(loc2 & 255);
            var loc8:*=new utils.converter.AltitudeConverter("millimeter", "meter");
            var loc3:*=0;
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc3 = Math.floor(loc8.convert((arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1) * 10);
            }
            loc4.push(loc3 >> 16 & 255);
            loc4.push(loc3 >> 8 & 255);
            loc4.push(loc3 & 255);
            var loc7:*=0;
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc7 = (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 * 100;
            }
            loc4.push(loc7 >> 16 & 255);
            loc4.push(loc7 >> 8 & 255);
            loc4.push(loc7 & 255);
            return loc4;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc9:*=NaN;
            var loc3:*;
            (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc3.serialNumber = arg2.serialNumber;
            var loc14:*;
            var loc4:*;
            if (!(loc4 = (loc14 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 107, "ToplineDecoder > decodeMemory: data is not valid"));
                return null;
            }
            var loc8:*=arg1[1] << 16 | arg1[2] << 8 | arg1[3];
            if (loc3.distanceDefined) 
            {
                loc3.distance = loc8;
            }
            var loc18:*=arg1[4] << 16 | arg1[5] << 8 | arg1[6];
            if (loc3.trainingTimeDefined) 
            {
                loc3.trainingTime = loc18 * 100;
            }
            loc3.dateCode = loc8 + "_" + loc18;
            var loc5:*;
            (loc5 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc5.outputFormat = "ms";
            var loc11:*=arg1[7] << 8 | arg1[8];
            if (loc3.averageSpeedDefined) 
            {
                loc3.averageSpeed = loc5.convert(loc11 / 100);
            }
            if (core.general.UnitType.BC512 == loc3.unitType) 
            {
                if (loc3.trainingTime != 0) 
                {
                    loc9 = loc3.distance / (loc3.trainingTime / 100);
                    loc3.averageSpeed = loc9;
                }
            }
            var loc10:*=arg1[9] << 8 | arg1[10];
            if (loc3.maximumSpeedDefined) 
            {
                loc3.maximumSpeed = loc5.convert(loc10 / 100);
            }
            var loc1:*=arg1[11];
            if (loc3.averageCadenceDefined) 
            {
                loc3.averageCadence = loc1;
            }
            var loc16:*=arg1[12] >> 7 != 0 ? -1 : 1;
            var loc6:*=(arg1[12] & -129) << 8 | arg1[13];
            if (loc3.maximumAltitudeDefined) 
            {
                loc3.maximumAltitude = loc6 * loc16 * 1000;
            }
            var loc7:*=arg1[14] << 16 | arg1[15] << 8 | arg1[16];
            if (loc3.tripSectionDistanceDefined) 
            {
                loc3.tripSectionDistance = loc7;
            }
            var loc2:*=arg1[17] << 16 | arg1[18] << 8 | arg1[19];
            if (loc3.tripSectionTimeDefined) 
            {
                loc3.tripSectionTime = loc2 * 100;
            }
            var loc15:*=(loc15 = arg1[20] << 16 | arg1[21] << 8 | arg1[22]) / 10;
            if (loc3.altitudeDifferencesUphillDefined) 
            {
                loc3.altitudeDifferencesUphill = loc15 * 1000;
            }
            var loc12:*;
            if ((loc12 = arg1[23]) != 0) 
            {
                if (loc12 == 1) 
                {
                    loc3.bike = "bike2";
                }
            }
            else 
            {
                loc3.bike = "bike1";
            }
            var loc13:*=arg1[24] << 16 | arg1[25] << 8 | arg1[26];
            if (loc3.fuelEconomyDefined) 
            {
                loc3.fuelEconomy = loc13 / 100;
            }
            loc3.startDate = new Date();
            var loc17:*;
            (loc17 = new __AS3__.vec.Vector.<core.activities.Activity>()).push(loc3);
            return loc17;
        }

        public static function getInstance():decoder.Topline2012Decoder
        {
            if (_instance == null) 
            {
                _instance = new Topline2012Decoder();
            }
            return _instance as Topline2012Decoder;
        }

        internal static var _instance:decoder.Topline2012Decoder;
    }
}


//  class Topline2016Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.hurlant.util.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.sleepScreen.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import decoder.core.*;
    import flash.events.*;
    import service.*;
    import service.event.*;
    import utils.*;
    import utils.converter.*;
    
    public class Topline2016Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.units.interfaces.ICodingTotals
    {
        public function Topline2016Decoder()
        {
            speedConverter = new utils.converter.SpeedConverter();
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            speedConverter.inputFormat = "kmh";
            speedConverter.outputFormat = "ms";
            return;
        }

        public function encodeGhostRaceHeaderDemo(arg1:core.activities.Activity, arg2:uint):Array
        {
            var loc1:*=new Array(25);
            loc1[0] = arg2 & 255;
            loc1[1] = arg2 >> 8;
            var loc4:*;
            if ((loc4 = 3999) == 0) 
            {
                loc4 = 3999;
            }
            loc1[2] = loc4 & 255;
            loc1[3] = loc4 >> 8;
            loc1[4] = 48;
            loc1[5] = 48;
            loc1[6] = 48;
            loc1[7] = 48;
            loc1[8] = 48;
            loc1[9] = 48;
            loc1[10] = 48;
            loc1[11] = 48;
            loc1[12] = 48;
            loc1[13] = 48;
            loc1[14] = 40;
            loc1[15] = 2;
            loc1[16] = 0;
            loc1[17] = 126;
            loc1[18] = 32;
            loc1[19] = 0;
            var loc2:*=0;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < 20) 
            {
                loc2 = loc2 + (loc1[loc3] & 255);
                ++loc3;
            }
            ++loc2;
            loc2 = loc2 & 255;
            loc1[20] = loc2;
            loc1[21] = 212;
            loc1[22] = 116;
            loc1[23] = 148;
            loc1[24] = 53;
            return loc1;
        }

        public function encodeGhostRaceHeader(arg1:core.activities.Activity, arg2:uint):Array
        {
            var loc10:*=0;
            var loc1:*=new Array(25);
            loc1[0] = arg2 & 255;
            loc1[1] = arg2 >> 8;
            var loc5:*;
            if ((loc5 = arg1.wheelSize) == 0) 
            {
                loc5 = 2095;
            }
            loc1[2] = loc5 & 255;
            loc1[3] = loc5 >> 8;
            var loc12:*=arg1.ghostName.split("");
            var loc9:*="";
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < 10) 
            {
                if (loc3 < loc12.length) 
                {
                    loc10 = (loc9 = loc12[loc3]).charCodeAt(0);
                    loc1[loc3 + 4] = loc10;
                }
                else 
                {
                    loc1[loc3 + 4] = 0;
                }
                ++loc3;
            }
            var loc8:*;
            var loc6:*=(loc8 = arg1.trainingTime / 100) / 3600;
            var loc4:*=(loc8 - loc6 * 3600) / 60;
            var loc7:*=loc8 - loc6 * 3600 - loc4 * 60;
            loc1[14] = loc7;
            loc1[15] = loc4;
            loc1[16] = loc6;
            var loc2:*=arg1.distance;
            loc1[17] = loc2 & 255;
            loc1[18] = loc2 >> 8 & 255;
            loc1[19] = loc2 >> 16 & 255;
            var loc11:*=0;
            loc3 = 0;
            while (loc3 < 20) 
            {
                loc11 = loc11 + (loc1[loc3] & 255);
                ++loc3;
            }
            ++loc11;
            loc11 = loc11 & 255;
            loc1[20] = loc11;
            loc1[21] = 212;
            loc1[22] = 116;
            loc1[23] = 148;
            loc1[24] = 53;
            return loc1;
        }

        public static function getInstance():decoder.Topline2016Decoder
        {
            if (_instance == null) 
            {
                _instance = new Topline2016Decoder();
            }
            return _instance as Topline2016Decoder;
        }

        public function decodePageHeaderCount(arg1:Array):uint
        {
            return arg1[5] << 8 | arg1[4];
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):Boolean
        {
            var loc32:*=null;
            var loc3:*=0;
            var loc1:*=0;
            var loc8:*=false;
            var loc14:*=0;
            var loc4:*=null;
            var loc35:*=null;
            var loc11:*=null;
            var loc5:*=NaN;
            var loc10:*=0;
            var loc26:*=NaN;
            var loc7:*=0;
            var loc16:*=NaN;
            var loc28:*=0;
            var loc17:*=NaN;
            var loc13:*=NaN;
            var loc25:*=0;
            var loc12:*=0;
            var loc2:*=null;
            var loc29:*=NaN;
            var loc33:*=NaN;
            var loc9:*=NaN;
            var loc15:*=NaN;
            var loc36:*=NaN;
            var loc27:*=NaN;
            var loc18:*=NaN;
            var loc6:*=NaN;
            var loc34:*=NaN;
            var loc30:*=NaN;
            var loc31:*=NaN;
            var loc23:*=NaN;
            var loc21:*=NaN;
            var loc20:*=NaN;
            var loc19:*=NaN;
            var loc22:*=NaN;
            var loc24:*=NaN;
            try 
            {
                loc32 = null;
                loc3 = 0;
                loc1 = 0;
                arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
                loc8 = false;
                loc5 = 0;
                loc10 = 0;
                loc26 = 0;
                loc7 = 0;
                loc16 = 0;
                loc28 = 0;
                loc17 = 0;
                loc13 = 0;
                lapCounter = 0;
                pauseCounter = 0;
                while (loc3 < (arg2.length - 1)) 
                {
                };
                loc12 = arg1.entries.length;
                if (arg1.entries[0].power > 0) 
                {
                    loc5 = loc5 + arg1.entries[0].power;
                    ++loc10;
                }
                if (arg1.entries[0].cadence > 0) 
                {
                    loc26 = loc26 + arg1.entries[0].cadence;
                    ++loc7;
                }
                if (arg1.entries[0].heartrate > 0) 
                {
                    loc16 = loc16 + arg1.entries[0].heartrate;
                    ++loc28;
                }
                loc29 = arg1.calories / loc12;
                loc33 = loc5 / loc10;
                loc9 = loc26 / loc7;
                loc15 = loc16 / loc28;
                loc36 = arg1.averagePower / loc33;
                loc27 = arg1.averageCadence / loc9;
                loc18 = arg1.averageHeartrate / loc15;
                if (isNaN(loc36)) 
                {
                    loc36 = 0;
                }
                if (isNaN(loc27)) 
                {
                    loc27 = 0;
                }
                if (isNaN(loc18)) 
                {
                    loc18 = 0;
                }
                loc6 = 0;
                loc34 = 0;
                loc30 = 0;
                loc31 = 0;
                loc23 = 0;
                loc21 = 0;
                loc20 = 0;
                loc19 = 0;
                loc22 = 0;
                loc24 = 0;
                if (loc12 > 32767) 
                {
                    arg1.trainingTime = loc2.trainingTimeAbsolute;
                }
                loc25 = 0;
                while (loc25 < loc12) 
                {
                    (loc2 = arg1.entries[loc25]).calories = loc29;
                    loc2.power = loc2.power * loc36;
                    loc2.cadence = loc2.cadence * loc27;
                    loc2.heartrate = loc2.heartrate * loc18;
                    loc6 = loc6 + loc2.timeBelowTargetZone;
                    loc34 = loc34 + loc2.timeInTargetZone;
                    loc30 = loc30 + loc2.timeAboveTargetZone;
                    loc31 = loc31 + loc2.timeBelowIntensityZones;
                    loc23 = loc23 + loc2.timeInIntensityZone1;
                    loc21 = loc21 + loc2.timeInIntensityZone2;
                    loc20 = loc20 + loc2.timeInIntensityZone3;
                    loc19 = loc19 + loc2.timeInIntensityZone4;
                    loc22 = loc22 + loc2.timeAboveIntensityZones;
                    if (loc12 <= 32767) 
                    {
                        maxValueCorrection(arg1, loc25);
                    }
                    if (loc25 == 0) 
                    {
                        arg1.minimumAltitude = loc2.altitude;
                        arg1.minimumHeartrate = loc2.heartrate;
                        arg1.maximumPower = loc2.power;
                        arg1.maximumCadence = loc2.cadence;
                        arg1.maximumSpeed = loc2.speed;
                        arg1.maximumInclineUphill = loc2.incline;
                        arg1.maximumInclineDownhill = loc2.incline;
                    }
                    arg1.minimumAltitude = Math.min(arg1.minimumAltitude, loc2.altitude);
                    arg1.minimumHeartrate = Math.min(arg1.minimumHeartrate, loc2.heartrate);
                    arg1.maximumPower = Math.max(arg1.maximumPower, loc2.power);
                    arg1.maximumCadence = Math.max(arg1.maximumCadence, loc2.cadence);
                    arg1.maximumSpeed = Math.max(arg1.maximumSpeed, loc2.speed);
                    arg1.maximumInclineUphill = Math.max(arg1.maximumInclineUphill, loc2.incline);
                    arg1.maximumInclineDownhill = Math.min(arg1.maximumInclineDownhill, loc2.incline);
                    if (loc2.power >= arg1.powerZone1Start && loc2.power < arg1.powerZone2Start) 
                    {
                        arg1.timeInPowerZone1 = arg1.timeInPowerZone1 + loc2.trainingTime;
                        loc2.powerZone = 1;
                    }
                    if (loc2.power >= arg1.powerZone2Start && loc2.power < arg1.powerZone3Start) 
                    {
                        arg1.timeInPowerZone2 = arg1.timeInPowerZone2 + loc2.trainingTime;
                        loc2.powerZone = 2;
                    }
                    if (loc2.power >= arg1.powerZone3Start && loc2.power < arg1.powerZone4Start) 
                    {
                        arg1.timeInPowerZone3 = arg1.timeInPowerZone3 + loc2.trainingTime;
                        loc2.powerZone = 3;
                    }
                    if (loc2.power >= arg1.powerZone4Start && loc2.power < arg1.powerZone5Start) 
                    {
                        arg1.timeInPowerZone4 = arg1.timeInPowerZone4 + loc2.trainingTime;
                        loc2.powerZone = 4;
                    }
                    if (loc2.power >= arg1.powerZone5Start && loc2.power < arg1.powerZone6Start) 
                    {
                        arg1.timeInPowerZone5 = arg1.timeInPowerZone5 + loc2.trainingTime;
                        loc2.powerZone = 5;
                    }
                    if (loc2.power >= arg1.powerZone6Start && loc2.power < arg1.powerZone7Start) 
                    {
                        arg1.timeInPowerZone6 = arg1.timeInPowerZone6 + loc2.trainingTime;
                        loc2.powerZone = 6;
                    }
                    if (loc2.power >= arg1.powerZone7Start && loc2.power < arg1.powerZone7End) 
                    {
                        arg1.timeInPowerZone7 = arg1.timeInPowerZone7 + loc2.trainingTime;
                        loc2.powerZone = 7;
                    }
                    loc17 = loc17 + loc2.distanceUphill;
                    loc13 = loc13 + loc2.distanceDownhill;
                    ++loc25;
                }
                arg1.distanceUphill = loc17;
                arg1.distanceDownhill = loc13;
                arg1.timeUnderZone = loc6;
                arg1.timeInZone = loc34;
                arg1.timeOverZone = loc30;
                arg1.timeUnderIntensityZone = loc31;
                arg1.timeInIntensityZone1 = loc23;
                arg1.timeInIntensityZone2 = loc21;
                arg1.timeInIntensityZone3 = loc20;
                arg1.timeInIntensityZone4 = loc19;
                arg1.timeOverIntensityZone = loc22;
                var loc38:*;
                return loc38 = true;
            }
            catch (e:decoder.core.DecodeError)
            {
                debug.Debug.error(e.toString());
                var loc39:*=false;
                return loc39;
            }
            return;
        }

        internal function maxValueCorrection(arg1:core.activities.Activity, arg2:uint):void
        {
            if (arg1.maxSpeedEntry == arg2) 
            {
                (arg1.entries[arg2] as core.activities.ActivityEntry).speed = arg1.maximumSpeed;
            }
            if (arg1.maxHeartrateEntry == arg2) 
            {
                (arg1.entries[arg2] as core.activities.ActivityEntry).heartrate = arg1.maximumHeartrate;
            }
            if (arg1.maxAltitudeEntry == arg2) 
            {
                (arg1.entries[arg2] as core.activities.ActivityEntry).altitude = arg1.maximumAltitude;
            }
            if (arg1.maxInclineUphillEntry == arg2) 
            {
                (arg1.entries[arg2] as core.activities.ActivityEntry).incline = arg1.maximumInclineUphill;
            }
            if (arg1.maxInclineDownhillEntry == arg2) 
            {
                (arg1.entries[arg2] as core.activities.ActivityEntry).incline = arg1.maximumInclineDownhill;
            }
            return;
        }

        public function decodeLogHeader(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc8:*=0;
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            var loc5:*=[];
            loc5 = arg1.slice(0, 16);
            var loc6:*="";
            loc8 = 0;
            while (loc8 < loc5.length) 
            {
                if (loc5[loc8] < 15) 
                {
                    loc6 = loc6 + "0";
                }
                loc6 = loc6 + loc5[loc8].toString(16);
                if (loc8 == 3 || loc8 == 5 || loc8 == 7 || loc8 == 9) 
                {
                    loc6 = loc6 + "-";
                }
                ++loc8;
            }
            loc2.GUID = loc6;
            loc2.startDate = new Date(arg1[8] << 8 | arg1[7], (arg1[9] - 1), arg1[10], arg1[11], arg1[12], arg1[13]);
            loc2.maximumHeartrate = arg1[16];
            loc2.maxHeartrateEntry = (arg1[18] & 127) << 8 | arg1[17];
            var loc9:*=(arg1[18] >> 7 & 1) != 0 ? "fahrenheit" : "celsius";
            var loc1:*=arg1[81];
            loc2.intensityZone1Start = loc1 * arg1[19] / 100;
            loc2.intensityZone2Start = loc1 * arg1[20] / 100;
            loc2.intensityZone3Start = loc1 * arg1[21] / 100;
            loc2.intensityZone4Start = loc1 * arg1[22] / 100;
            loc2.intensityZone4End = loc1 * arg1[80] / 100;
            loc2.lowerLimit = arg1[23];
            loc2.upperLimit = arg1[24];
        }

        public function decodeActivity(arg1:Array, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc6:*=0;
            var loc4:*=0;
            var loc7:*=0;
            var loc5:*=0;
            var loc8:*=0;
            var loc1:*=0;
            var loc3:*;
            (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc3.serialNumber = arg2.serialNumber;
            var loc2:*;
            if (!(loc2 = arg1[0] == 0)) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "ToplineDecoder > decodeMemory: data is not valid"));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 107, "ToplineDecoder > decodeMemory: data is not valid"));
                return null;
            }
            if (core.general.UnitType.BC1616.equals(arg2.type) || core.general.UnitType.BC1616STS.equals(arg2.type) || core.general.UnitType.BC1416.equals(arg2.type) || core.general.UnitType.BC1416STS.equals(arg2.type) || core.general.UnitType.BC2316STS.equals(arg2.type)) 
            {
                loc6 = 2000 + parseInt(arg1[1]);
                loc4 = (arg1[2] - 1);
                loc7 = arg1[3];
                loc5 = arg1[4];
                loc8 = arg1[5];
                loc1 = arg1[35];
                loc3.startDate = new Date(loc6, loc4, loc7, loc5, loc8, loc1);
            }
            else 
            {
                loc3.startDate = new Date();
            }
            loc3.bike = arg1[6] != 0 ? "bike2" : "bike1";
            loc3.distance = arg1[7] << 16 | arg1[8] << 8 | arg1[9];
            loc3.trainingTime = (arg1[10] << 16 | arg1[11] << 8 | arg1[12]) * 100;
            if (loc3.averageSpeedDefined) 
            {
                loc3.averageSpeed = kmphToMpsSpeedConverter.convert((arg1[13] << 8 | arg1[14]) * 0.01);
            }
            if (loc3.maximumSpeedDefined) 
            {
                loc3.maximumSpeed = kmphToMpsSpeedConverter.convert((arg1[15] << 8 | arg1[16]) * 0.01);
            }
            if (loc3.fuelEconomyDefined) 
            {
                loc3.fuelEconomy = (arg1[17] << 16 | arg1[18] << 8 | arg1[19]) / 100;
            }
            if (loc3.averageCadenceDefined) 
            {
                loc3.averageCadence = arg1[20];
            }
            if (loc3.caloriesDefined) 
            {
                loc3.calories = arg1[21] << 16 | arg1[22] << 8 | arg1[23];
            }
            if (loc3.altitudeDifferencesUphillDefined) 
            {
                loc3.altitudeDifferencesUphill = (arg1[24] << 16 | arg1[25] << 8 | arg1[26]) * 100;
            }
            if (loc3.maximumAltitudeDefined) 
            {
                loc3.maximumAltitude = arg1[27] << 8 | arg1[28];
            }
            if (loc3.tripSectionDistanceDefined) 
            {
                loc3.tripSectionDistance = arg1[29] << 16 | arg1[30] << 8 | arg1[31];
            }
            if (loc3.tripSectionTimeDefined) 
            {
                loc3.tripSectionTime = (arg1[32] << 16 | arg1[33] << 8 | arg1[34]) * 100;
            }
            loc3 = generateGUID(loc3);
            new __AS3__.vec.Vector.<core.activities.Activity>(1)[0] = loc3;
            return new __AS3__.vec.Vector.<core.activities.Activity>(1);
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
            loc1.unit = arg2;
            var loc2:*;
            if (!(loc2 = arg1[0] == 0)) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "Topline2012Decoder > decodeSettings: data is not valid"));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance1) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = arg1[1] << 24 | arg1[2] << 16 | arg1[3] << 8 | arg1[4];
            }
            if (loc1 is core.totals.interfaces.ITotalDistance2) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = arg1[5] << 24 | arg1[6] << 16 | arg1[7] << 8 | arg1[8];
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = (arg1[9] << 24 | arg1[10] << 16 | arg1[11] << 8 | arg1[12]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = (arg1[13] << 24 | arg1[14] << 16 | arg1[15] << 8 | arg1[16]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalCal1) 
            {
                (loc1 as core.totals.interfaces.ITotalCal1).totalCal1 = arg1[17] << 16 | arg1[18] << 8 | arg1[19];
            }
            if (loc1 is core.totals.interfaces.ITotalCal2) 
            {
                (loc1 as core.totals.interfaces.ITotalCal2).totalCal2 = arg1[20] << 16 | arg1[21] << 8 | arg1[22];
            }
            return loc1;
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc4:*=0;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=new Array(22);
            loc4 = 0;
            while (loc4 < loc3.length) 
            {
                loc3[loc4] = 0;
                ++loc4;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc3[0] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 24 & 255;
                loc3[1] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 16 & 255;
                loc3[2] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 8 & 255;
                loc3[3] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc3[4] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 24 & 255;
                loc3[5] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 16 & 255;
                loc3[6] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 8 & 255;
                loc3[7] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc1 = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 * 0.01;
                loc3[8] = loc1 >> 24 & 255;
                loc3[9] = loc1 >> 16 & 255;
                loc3[10] = loc1 >> 8 & 255;
                loc3[11] = loc1 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc2 = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 * 0.01;
                loc3[12] = loc2 >> 24 & 255;
                loc3[13] = loc2 >> 16 & 255;
                loc3[14] = loc2 >> 8 & 255;
                loc3[15] = loc2 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalCal1) 
            {
                loc3[16] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 >> 16 & 255;
                loc3[17] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 >> 8 & 255;
                loc3[18] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalCal2) 
            {
                loc3[19] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 >> 16 & 255;
                loc3[20] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 >> 8 & 255;
                loc3[21] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 & 255;
            }
            return loc3;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc8:*=null;
            var loc9:*=NaN;
            var loc7:*;
            (loc7 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.Settings).unit = arg2;
            var loc3:*;
            if (!(loc3 = arg1[0] == 0)) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "Topline2012Decoder > decodeSettings: data is not valid"));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
        }

        public function encodeSleepScreen(arg1:core.units.Unit):Array
        {
            var loc7:*=0;
            var loc1:*=(arg1 as core.units.interfaces.ISleepScreen).sleepScreen;
            var loc2:*=new Array(126);
            loc7 = 0;
            while (loc7 < loc2.length) 
            {
                loc2[loc7] = 0;
                ++loc7;
            }
            loc2[3] = loc1.id;
            var loc8:*=core.sleepScreen.SleepScreenSign.getBytes(loc1.xml, 16, 59);
            loc7 = 0;
            while (loc7 < loc8.length) 
            {
                loc2[loc7 + 4] = loc8[loc7];
                ++loc7;
            }
            var loc3:*=loc1.xml.dots.@clockX;
            var loc5:*=loc1.xml.dots.@clockY;
            loc2[122] = loc3;
            loc2[123] = loc5;
            if (loc1.xml.dots.@myNamePos == "buttom") 
            {
                loc2[124] = 1;
            }
            if (loc1.xml.dots.@myNameInvert == "true") 
            {
                var loc9:*=124;
                var loc10:*=loc2[loc9] | 2;
                loc2[loc9] = loc10;
            }
            var loc6:*=0;
            var loc4:*=0;
            while (loc6 <= 124) 
            {
                loc4 = loc4 + loc2[loc6];
                ++loc6;
            }
            loc4 = ++loc4 & 255;
            loc2[125] = loc4;
            return loc2;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=NaN;
            var loc1:*=new Array(33);
            var loc2:*=arg1.currentSettings;
            loc4 = 0;
            while (loc4 < loc1.length) 
            {
                loc1[loc4] = 0;
                ++loc4;
            }
        }

        public function encodeAdvancedSettings(arg1:core.units.Unit):Array
        {
            var loc9:*=0;
            var loc4:*=0;
            var loc6:*=NaN;
            var loc3:*=NaN;
            var loc11:*=null;
            var loc7:*=NaN;
            var loc10:*=NaN;
            var loc1:*=NaN;
            var loc2:*=new Array(27);
            var loc8:*=arg1.currentSettings;
            loc9 = 0;
            while (loc9 < loc2.length) 
            {
                loc2[loc9] = 0;
                ++loc9;
            }
            if (loc8 is core.settings.interfaces.IMyName) 
            {
                loc4 = 0;
                var loc5:*=(loc8 as core.settings.interfaces.IMyName).myName;
                loc6 = 0;
                while (loc4 < 9) 
                {
                    if (loc4 < loc5.length) 
                    {
                        loc6 = loc5.charCodeAt(loc4);
                        if (isNaN(loc6)) 
                        {
                            loc2[loc4] = 0;
                        }
                        else 
                        {
                            loc2[loc4] = loc6;
                        }
                    }
                    else 
                    {
                        loc2[loc4] = 0;
                    }
                    ++loc4;
                }
            }
            if (loc8 is core.settings.interfaces.IPowerSaveMode) 
            {
                loc2[9] = (loc8 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive ? 1 : 0;
            }
            if (loc8 is core.settings.interfaces.ICadenceSensor) 
            {
                loc2[10] = (loc8 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive ? 1 : 0;
            }
            if (loc8 is core.settings.interfaces.IETADistance) 
            {
                loc3 = (loc8 as core.settings.interfaces.IETADistance).etaDistance / 10;
                loc2[11] = loc3 >> 16 & 255;
                loc2[12] = loc3 >> 8 & 255;
                loc2[13] = loc3 & 255;
            }
            if (loc8 is core.settings.interfaces.IETAArivalFlag) 
            {
                loc2[14] = (loc8 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag ? 1 : 0;
            }
            if (loc8 is core.settings.interfaces.IFuelConsumption) 
            {
                (loc11 = new utils.converter.FuelConsumptionConverter()).inputFormat = "l/100km";
                loc11.outputFormat = (loc8 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
                loc7 = loc11.convert((loc8 as core.settings.interfaces.IFuelConsumption).fuelConsumption) * 10;
                loc2[15] = loc7 >> 8;
                loc2[16] = loc7 & 255;
            }
            if (loc8 is core.settings.interfaces.IBacklight) 
            {
                loc2[17] = (loc8 as core.settings.interfaces.IBacklight).backlightActive ? 1 : 0;
            }
            if (loc8 is core.settings.interfaces.IBacklightTimeOn) 
            {
                loc2[18] = (loc8 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.hours;
                loc2[19] = (loc8 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.minutes;
            }
            if (loc8 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc2[20] = (loc8 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.hours;
                loc2[21] = (loc8 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.minutes;
            }
            if (loc8 is core.settings.interfaces.IHomeAltitude1) 
            {
                loc10 = (loc10 = (loc10 = (loc8 as core.settings.interfaces.IHomeAltitude1).homeAltitude1) / 100) + 10000;
                loc2[22] = loc10 >> 8 & 255;
                loc2[23] = loc10 & 255;
            }
            if (loc8 is core.settings.interfaces.IHomeAltitude2) 
            {
                loc1 = (loc8 as core.settings.interfaces.IHomeAltitude2).homeAltitude2;
                loc1 = loc1 / 100;
                loc1 = loc1 + 10000;
                loc2[24] = loc1 >> 8 & 255;
                loc2[25] = loc1 & 255;
            }
            if (loc8 is core.settings.interfaces.INfc) 
            {
                loc2[26] = (loc8 as core.settings.interfaces.INfc).nfcActive ? 1 : 0;
            }
            return loc2;
        }

        public function decodeSettingsNFC(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc8:*=NaN;
            var loc10:*;
            (loc10 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.Settings).unit = arg2;
            var loc2:*=(arg1[9] & 63) + 2000;
            var loc7:*=arg1[10] & 15;
            var loc11:*=arg1[11] & 31;
            var loc1:*=arg1[0] & 31;
            var loc3:*=arg1[3] >> 2 & 63;
            var loc6:*=arg1[4] & 63;
            if (loc10 as core.settings.interfaces.IClock) 
            {
                (loc10 as core.settings.interfaces.IClock).clock = new Date();
                (loc10 as core.settings.interfaces.IClock).clock.setHours(loc1, loc3, loc6);
                (loc10 as core.settings.interfaces.IClock).clock.setFullYear(loc2, (loc7 - 1), loc11);
            }
            if (loc10 is core.settings.interfaces.IDate) 
            {
                loc10.date = new Date(loc2, (loc7 - 1), loc11, loc1, loc3, loc6, 0);
            }
            var loc4:*="";
        }

        public function encodeSettingsNFC(arg1:core.units.Unit):Array
        {
            var loc9:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=17;
            var loc2:*=new Array(loc5);
            var loc8:*=arg1.currentSettings;
            var loc7:*=0;
            while (loc7 < loc5) 
            {
                loc2[loc7] = 0;
                ++loc7;
            }
            var loc1:*=new Date();
            loc2[9] = loc1.fullYear - 2000;
            loc2[10] = loc1.month + 1;
            loc2[11] = loc1.date;
            loc2[0] = loc1.hours;
            loc2[3] = loc1.minutes << 2;
            loc2[4] = loc1.seconds;
            loc2[1] = 238;
            loc2[2] = 2;
        }

        public function encodeAdvancedSettingsBC2316NFC(arg1:core.units.Unit):Array
        {
            var loc1:*=0;
            var loc16:*=0;
            var loc3:*=0;
            var loc8:*=NaN;
            var loc9:*=0;
            var loc4:*=0;
            var loc11:*=0;
            var loc2:*=0;
            var loc17:*=0;
            var loc6:*=0;
            var loc5:*=37;
            var loc12:*=new Array(loc5);
            var loc15:*=arg1.currentSettings;
            var loc7:*=0;
            while (loc7 < loc5) 
            {
                loc12[loc7] = 0;
                ++loc7;
            }
            if (loc15 is core.settings.interfaces.IBirthDate) 
            {
                loc12[0] = (loc15 as core.settings.interfaces.IBirthDate).birthDate.fullYear & 255;
                loc12[1] = (loc15 as core.settings.interfaces.IBirthDate).birthDate.fullYear >> 8 & 15;
                var loc18:*=1;
                var loc19:*=loc12[loc18] | (loc15 as core.settings.interfaces.IBirthDate).birthDate.month + 1 << 4;
                loc12[loc18] = loc19;
                loc12[2] = (loc15 as core.settings.interfaces.IBirthDate).birthDate.date;
            }
        }

        public function encodeAdvancedSettingsNFC(arg1:core.units.Unit):Array
        {
            var loc2:*=0;
            var loc7:*=NaN;
            var loc10:*=null;
            var loc8:*=NaN;
            var loc1:*=new Array(24);
            var loc6:*=arg1.currentSettings;
            var loc4:*=0;
            while (loc4 < 24) 
            {
                loc1[loc4] = 0;
                ++loc4;
            }
            if (loc6 is core.settings.interfaces.IHomeAltitude1) 
            {
                loc1[0] = (loc6 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 / 100 + 10000 & 255;
                loc1[1] = (loc6 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 / 100 + 10000 >> 8;
            }
            if (loc6 is core.settings.interfaces.IHomeAltitude2) 
            {
                loc1[2] = (loc6 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 / 100 + 10000 & 255;
                loc1[3] = (loc6 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 / 100 + 10000 >> 8;
            }
            if (loc6 is core.settings.interfaces.IETADistance) 
            {
                loc1[4] = (loc6 as core.settings.interfaces.IETADistance).etaDistance & 255;
                loc1[5] = (loc6 as core.settings.interfaces.IETADistance).etaDistance >> 8 & 255;
                loc1[6] = (loc6 as core.settings.interfaces.IETADistance).etaDistance >> 16 & 255;
            }
            if (loc6 is core.settings.interfaces.IMyName) 
            {
                loc2 = 7;
                var loc5:*=(loc6 as core.settings.interfaces.IMyName).myName;
                loc7 = 0;
                while (loc2 <= 15) 
                {
                    loc7 = loc5.charCodeAt(loc2 - 7);
                    if (isNaN(loc7)) 
                    {
                        loc1[loc2] = 0;
                    }
                    else 
                    {
                        loc1[loc2] = loc7;
                    }
                    ++loc2;
                }
            }
            if (loc6 is core.settings.interfaces.IBacklightTimeOn) 
            {
                loc1[16] = (loc6 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.hours & 255;
                loc1[17] = (loc6 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.minutes & 255;
            }
            var loc11:*=16;
            var loc12:*=loc1[loc11] | 128;
            loc1[loc11] = loc12;
            if (loc6 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc1[18] = (loc6 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.hours & 255;
                loc1[19] = (loc6 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.minutes & 255;
            }
            if (loc6 is core.settings.interfaces.IBacklight) 
            {
                if ((loc6 as core.settings.interfaces.IBacklight).backlightActive) 
                {
                    loc12 = 17;
                    loc11 = loc1[loc12] | 128;
                    loc1[loc12] = loc11;
                }
            }
            if (loc6 is core.settings.interfaces.ICadenceSensor) 
            {
                if ((loc6 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive) 
                {
                    loc11 = 17;
                    loc12 = loc1[loc11] | 64;
                    loc1[loc11] = loc12;
                }
            }
            if (loc6 is core.settings.interfaces.IFuelConsumption) 
            {
                (loc10 = new utils.converter.FuelConsumptionConverter()).inputFormat = "l/100km";
                loc10.outputFormat = (loc6 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
                loc8 = loc10.convert((loc6 as core.settings.interfaces.IFuelConsumption).fuelConsumption) * 10;
                loc1[20] = loc8 & 255;
                loc1[21] = loc8 >> 8 & 15;
            }
            if (loc6 is core.settings.interfaces.IPowerSaveMode) 
            {
                if ((loc6 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive) 
                {
                    loc12 = 21;
                    loc11 = loc1[loc12] | 16;
                    loc1[loc12] = loc11;
                }
            }
            if (loc6 is core.settings.interfaces.IETAArivalFlag) 
            {
                if ((loc6 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag) 
                {
                    loc11 = 21;
                    loc12 = loc1[loc11] | 32;
                    loc1[loc11] = loc12;
                }
            }
            var loc9:*=0;
            var loc3:*=0;
            while (loc9 <= 21) 
            {
                loc3 = loc3 + loc1[loc9];
                ++loc9;
            }
            loc3 = ++loc3 & 255;
            loc1[22] = loc3;
            return loc1;
        }

        public function decodeActivityNFC(arg1:Array, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc3:*;
            (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc3.serialNumber = arg2.serialNumber;
            if (loc3.distanceDefined) 
            {
                loc3.distance = arg1[2] << 16 | arg1[1] << 8 | arg1[0];
            }
            loc3.trainingTime = ((arg1[5] & 7) << 16 | arg1[4] << 8 | arg1[3]) * 100;
            var loc5:*=(arg1[6] & 63) + 2000;
            var loc4:*=arg1[14] >> 4;
            var loc7:*=arg1[5] >> 3;
            var loc6:*=arg1[21] >> 3;
            var loc2:*=arg1[7] & 63;
            var loc1:*=arg1[27] & 63;
            loc3.startDate = new Date(loc5, (loc4 - 1), loc7, loc6, loc2, loc1);
            if (loc3.averageSpeedDefined) 
            {
                loc3.averageSpeed = (arg1[9] << 8 | arg1[8]) / 360;
            }
            if (loc3.maximumSpeedDefined) 
            {
                loc3.maximumSpeed = (arg1[11] << 8 | arg1[10]) / 360;
            }
            loc3.bike = arg1[11] >> 7 != 0 ? "bike2" : "bike1";
            if (loc3.fuelEconomyDefined) 
            {
                loc3.fuelEconomy = ((arg1[14] & 15) << 16 | arg1[13] << 8 | arg1[12]) / 100;
            }
            if (loc3.averageCadenceDefined) 
            {
                loc3.averageCadence = arg1[15];
            }
            if (loc3.altitudeDifferencesUphillDefined) 
            {
                loc3.altitudeDifferencesUphill = ((arg1[18] & 15) << 16 | arg1[17] << 8 | arg1[16]) * 100;
            }
            if (loc3.tripSectionTimeDefined) 
            {
                loc3.tripSectionTime = ((arg1[21] & 7) << 16 | arg1[20] << 8 | arg1[19]) * 100;
            }
            if (loc3.tripSectionDistanceDefined) 
            {
                loc3.tripSectionDistance = arg1[24] << 16 | arg1[23] << 8 | arg1[22];
            }
            if (loc3.maximumAltitudeDefined) 
            {
                loc3.maximumAltitude = ((arg1[26] << 8 | arg1[25]) - 10000) * 100;
            }
            loc3 = generateGUID(loc3);
            new __AS3__.vec.Vector.<core.activities.Activity>(1)[0] = loc3;
            return new __AS3__.vec.Vector.<core.activities.Activity>(1);
        }

        public function decodeTotalsNFC(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
            loc1.unit = arg2;
            if (loc1 is core.totals.interfaces.ITotalDistance1) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = (arg1[3] & 15) << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0];
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = ((arg1[9] & 3) << 24 | arg1[8] << 16 | arg1[7] << 8 | arg1[6]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance2) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = (arg1[13] & 15) << 24 | arg1[12] << 16 | arg1[11] << 8 | arg1[10];
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = ((arg1[19] & 3) << 24 | arg1[18] << 16 | arg1[17] << 8 | arg1[16]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalCal1) 
            {
                (loc1 as core.totals.interfaces.ITotalCal1).totalCal1 = (arg1[22] & 1) << 16 | arg1[21] << 8 | arg1[20];
            }
            if (loc1 is core.totals.interfaces.ITotalCal2) 
            {
                (loc1 as core.totals.interfaces.ITotalCal2).totalCal2 = (arg1[25] & 1) << 16 | arg1[24] << 8 | arg1[23];
            }
            return loc1;
        }

        public function encodeTotalsNFC(arg1:core.totals.Totals):Array
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc4:*=27;
            var loc3:*=new Array(loc4);
            var loc6:*=0;
            while (loc6 < loc4) 
            {
                loc3[loc6] = 0;
                ++loc6;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc3[0] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 & 255;
                loc3[1] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 8 & 255;
                loc3[2] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 16 & 255;
                loc3[3] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc1 = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 / 100;
                loc3[6] = loc1 & 255;
                loc3[7] = loc1 >> 8 & 255;
                loc3[8] = loc1 >> 16 & 255;
                loc3[9] = loc1 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc3[10] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 & 255;
                loc3[11] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 8 & 255;
                loc3[12] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 16 & 255;
                loc3[13] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc2 = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 / 100;
                loc3[16] = loc2 & 255;
                loc3[17] = loc2 >> 8 & 255;
                loc3[18] = loc2 >> 16 & 255;
                loc3[19] = loc2 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalCal1) 
            {
                loc3[20] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 & 255;
                loc3[21] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 >> 8 & 255;
                loc3[22] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalCal2) 
            {
                loc3[23] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 & 255;
                loc3[24] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 >> 8 & 255;
                loc3[25] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 >> 16 & 255;
            }
            var loc7:*=0;
            var loc5:*=0;
            while (loc7 < (loc4 - 1)) 
            {
                loc5 = loc5 + loc3[loc7];
                ++loc7;
            }
            loc5 = ++loc5 & 255;
            loc3[26] = loc5;
            return loc3;
        }

        public function decodeTotalsAdvanced(arg1:Array, arg2:core.totals.Totals):core.totals.Totals
        {
            var loc1:*=arg2;
            var loc2:*;
            if (!(loc2 = arg1[0] == 0)) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "Topline2012Decoder > decodeSettings: data is not valid"));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = (arg1[1] << 16 | arg1[2] << 8 | arg1[3]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = (arg1[4] << 16 | arg1[5] << 8 | arg1[6]) * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                (loc1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 = (arg1[7] << 16 | arg1[8] << 8 | arg1[9]) / 100;
            }
            if (loc1 is core.totals.interfaces.ITotalFuelConsumption2) 
            {
                (loc1 as core.totals.interfaces.ITotalFuelConsumption2).totalFuelConsumption2 = (arg1[10] << 16 | arg1[11] << 8 | arg1[12]) / 100;
            }
            return loc1;
        }

        public function decodeTotalsAdvancedNFC(arg1:Array, arg2:core.totals.Totals):core.totals.Totals
        {
            var loc1:*=arg2;
            if (loc1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = ((arg1[2] & 15) << 16 | arg1[1] << 8 | arg1[0]) * 10;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = ((arg1[5] & 15) << 16 | arg1[4] << 8 | arg1[3]) * 10;
            }
            if (loc1 is core.totals.interfaces.ITotalDescent1) 
            {
                (loc1 as core.totals.interfaces.ITotalDescent1).totalDescent1 = ((arg1[8] & 15) << 16 | arg1[7] << 8 | arg1[6]) * 10;
            }
            if (loc1 is core.totals.interfaces.ITotalDescent2) 
            {
                (loc1 as core.totals.interfaces.ITotalDescent2).totalDescent2 = ((arg1[11] & 15) << 16 | arg1[10] << 8 | arg1[9]) * 10;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1 = (arg1[15] & 15) << 24 | arg1[14] << 16 | arg1[13] << 8 | arg1[12];
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2 = (arg1[21] & 15) << 24 | arg1[20] << 16 | arg1[19] << 8 | arg1[18];
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1 = (arg1[27] & 15) << 24 | arg1[26] << 16 | arg1[25] << 8 | arg1[24];
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2 = (arg1[33] & 15) << 24 | arg1[32] << 16 | arg1[31] << 8 | arg1[30];
            }
            return loc1;
        }

        public function encodeTotalsAdvancedNFC(arg1:core.totals.Totals):Array
        {
            var loc8:*=0;
            var loc7:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc1:*=0;
            var loc2:*=0;
            var loc4:*=37;
            var loc3:*=new Array(loc4);
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc3[loc5] = 0;
                ++loc5;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc8 = (arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 / 100;
                loc3[0] = loc8 & 255;
                loc3[1] = loc8 >> 8 & 255;
                loc3[2] = loc8 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                loc7 = (arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 / 100;
                loc3[3] = loc7 & 255;
                loc3[4] = loc7 >> 8 & 255;
                loc3[5] = loc7 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent1) 
            {
                loc9 = (arg1 as core.totals.interfaces.ITotalDescent1).totalDescent1 / 100;
                loc3[6] = loc9 & 255;
                loc3[7] = loc9 >> 8 & 255;
                loc3[8] = loc9 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent2) 
            {
                loc10 = (arg1 as core.totals.interfaces.ITotalDescent2).totalDescent2 / 100;
                loc3[9] = loc10 & 255;
                loc3[10] = loc10 >> 8 & 255;
                loc3[11] = loc10 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                loc11 = (arg1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1;
                loc3[12] = loc11 & 255;
                loc3[13] = loc11 >> 8 & 255;
                loc3[14] = loc11 >> 16 & 255;
                loc3[15] = loc11 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                loc12 = (arg1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2;
                loc3[18] = loc12 & 255;
                loc3[19] = loc12 >> 8 & 255;
                loc3[20] = loc12 >> 16 & 255;
                loc3[21] = loc12 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                loc1 = (arg1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1;
                loc3[24] = loc1 & 255;
                loc3[25] = loc1 >> 8 & 255;
                loc3[26] = loc1 >> 16 & 255;
                loc3[27] = loc1 >> 24 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                loc2 = (arg1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2;
                loc3[30] = loc2 & 255;
                loc3[31] = loc2 >> 8 & 255;
                loc3[32] = loc2 >> 16 & 255;
                loc3[33] = loc2 >> 24 & 255;
            }
            var loc6:*=0;
            var loc13:*=0;
            while (loc6 < (loc4 - 1)) 
            {
                loc13 = loc13 + loc3[loc6];
                ++loc6;
            }
            loc13 = ++loc13 & 255;
            loc3[36] = loc13;
            return loc3;
        }

        public function encodeTotalsAdvanced(arg1:core.totals.Totals):Array
        {
            var loc9:*=0;
            var loc8:*=0;
            var loc6:*=0;
            var loc3:*=0;
            var loc2:*=13;
            var loc1:*=new Array(loc2);
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                loc1[loc5] = 0;
                ++loc5;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc9 = (arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 / 100;
                loc1[2] = loc9 & 255;
                loc1[1] = loc9 >> 8 & 255;
                loc1[0] = loc9 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                loc8 = (arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 / 100;
                loc1[5] = loc8 & 255;
                loc1[4] = loc8 >> 8 & 255;
                loc1[3] = loc8 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc6 = (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 * 100;
                loc1[8] = loc6 & 255;
                loc1[7] = loc6 >> 8 & 255;
                loc1[6] = loc6 >> 16 & 255;
            }
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption2) 
            {
                loc3 = (arg1 as core.totals.interfaces.ITotalFuelConsumption2).totalFuelConsumption2 * 100;
                loc1[11] = loc3 & 255;
                loc1[10] = loc3 >> 8 & 255;
                loc1[9] = loc3 >> 16 & 255;
            }
            var loc7:*=0;
            var loc4:*=0;
            while (loc7 < (loc2 - 1)) 
            {
                loc4 = loc4 + loc1[loc7];
                ++loc7;
            }
            loc4 = ++loc4 & 255;
            loc1[13] = loc4;
            return loc1;
        }

        public function decodeInitialInformationNFC(arg1:Array, arg2:Array):core.units.Unit
        {
            var loc2:*=null;
            if (arg2 == null || arg2.length == 0 || !calculateChecksumm(arg2)) 
            {
                return null;
            }
            var loc1:*=parseInt((arg2[0] as int).toString(16), 10);
        }

        public function decodeAdvancedSettingsNFCBC2316(arg1:Array, arg2:core.settings.Settings):core.settings.Settings
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc8:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc12:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc11:*;
            if ((loc11 = arg2) is core.settings.interfaces.IBirthDate) 
            {
                loc1 = (arg1[1] & 15) << 8 | arg1[0];
                loc2 = arg1[1] >> 4 & 15;
                loc8 = arg1[2] & 31;
                (loc11 as core.settings.interfaces.IBirthDate).birthDate = new Date(loc1, (loc2 - 1), loc8);
            }
            if (!(loc11 is core.settings.interfaces.ITrainingZone)) 
            {
            };
            if (loc11 is core.settings.interfaces.IZoneAlarm) 
            {
                (loc11 as core.settings.interfaces.IZoneAlarm).zoneAlarm = arg1[2] >> 7 != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.IBodyWeight) 
            {
                (loc11 as core.settings.interfaces.IBodyWeight).bodyWeight = arg1[4] * 1000 + arg1[3] * 10;
            }
            if (loc11 is core.settings.interfaces.IHRmax) 
            {
                (loc11 as core.settings.interfaces.IHRmax).hrMax = arg1[5];
            }
            if (loc11 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (loc11 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = arg1[6];
                (loc11 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = arg1[7];
                (loc11 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = arg1[8];
                (loc11 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = arg1[9];
                (loc11 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = 100;
            }
            if (loc11 is core.settings.interfaces.IHeartrateLimits) 
            {
                (loc11 as core.settings.interfaces.IHeartrateLimits).lowerLimit = arg1[10];
                (loc11 as core.settings.interfaces.IHeartrateLimits).upperLimit = arg1[11];
            }
            if (loc11 is core.settings.interfaces.IHomeAltitude1) 
            {
                (loc11 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = ((arg1[13] << 8 | arg1[12]) - 10000) * 100;
            }
            if (loc11 is core.settings.interfaces.IHomeAltitude2) 
            {
                (loc11 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = ((arg1[15] << 8 | arg1[14]) - 10000) * 100;
            }
            if (arg2 is core.settings.interfaces.IMyName) 
            {
                loc3 = 16;
                var loc10:*="";
                while (loc3 <= 24) 
                {
                    if (arg1[loc3] == 0) 
                    {
                        break;
                    }
                    loc10 = loc10 + com.hurlant.util.Hex.toString(arg1[loc3].toString(16));
                    ++loc3;
                }
                (arg2 as core.settings.interfaces.IMyName).myName = loc10;
            }
            if (loc11 is core.settings.interfaces.IHRMaxOption) 
            {
                (loc11 as core.settings.interfaces.IHRMaxOption).hrMaxOption = (arg1[25] & 1) != 1 ? "calculated" : "manual";
            }
            if (loc11 is core.settings.interfaces.IGender) 
            {
                (loc11 as core.settings.interfaces.IGender).gender = (arg1[25] >> 1 & 1) != 1 ? "male" : "female";
            }
            if (loc11 is core.settings.interfaces.IHeartrateSensor) 
            {
                (loc11 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive = (arg1[25] >> 2 & 1) != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.ICadenceSensor) 
            {
                (loc11 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = (arg1[25] >> 3 & 1) != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.IPowerSaveMode) 
            {
                (loc11 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = (arg1[25] >> 4 & 1) != 1 ? false : true;
            }
            if (!(loc11 is core.settings.interfaces.ISamplingRate)) 
            {
            };
            if (loc11 is core.settings.interfaces.IBikeWeight1) 
            {
                (loc11 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = arg1[27] * 1000 + arg1[26] * 10;
            }
            if (loc11 is core.settings.interfaces.IBikeWeight2) 
            {
                (loc11 as core.settings.interfaces.IBikeWeight2).bikeWeight2 = arg1[29] * 1000 + arg1[28] * 10;
            }
            if (!(loc11 is core.settings.interfaces.IBikeType1)) 
            {
            };
            if (!(loc11 is core.settings.interfaces.IBikeType1)) 
            {
            };
            if (loc11 is core.settings.interfaces.IBodyHeight) 
            {
                (loc11 as core.settings.interfaces.IBodyHeight).bodyHeight = (arg1[32] << 8 | arg1[31]) / 10;
            }
            if (loc11 is core.settings.interfaces.IShoulderWidth) 
            {
                (loc11 as core.settings.interfaces.IShoulderWidth).shoulderWidth = (arg1[34] << 8 | arg1[33]) / 10;
            }
            var loc5:*=0;
            var loc9:*=0;
            while (loc5 <= 34) 
            {
                loc9 = loc9 + arg1[loc5];
                ++loc5;
            }
            if ((loc9 = ++loc9 & 255) != arg1[35]) 
            {
                debug.Debug.warning("wrong checksum");
            }
            return loc11;
        }

        public function decodeAdvancedSettingsNFC(arg1:Object, arg2:core.settings.Settings):core.settings.Settings
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc5:*=0;
            var loc7:*=null;
            var loc8:*=0;
            var loc6:*=0;
            var loc1:*=null;
            var loc12:*=null;
            var loc11:*;
            if ((loc11 = arg2) is core.settings.interfaces.IHomeAltitude1) 
            {
                (loc11 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = ((arg1[1] << 8 | arg1[0]) - 10000) * 100;
            }
            if (loc11 is core.settings.interfaces.IHomeAltitude2) 
            {
                (loc11 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = ((arg1[3] << 8 | arg1[2]) - 10000) * 100;
            }
            if (loc11 is core.settings.interfaces.IETADistance) 
            {
                (loc11 as core.settings.interfaces.IETADistance).etaDistance = arg1[6] << 16 | arg1[5] << 8 | arg1[4];
            }
            if (arg2 is core.settings.interfaces.IMyName) 
            {
                loc3 = 7;
                var loc10:*="";
                while (loc3 <= 15) 
                {
                    if (arg1[loc3] == 0) 
                    {
                        break;
                    }
                    loc10 = loc10 + com.hurlant.util.Hex.toString(arg1[loc3].toString(16));
                    ++loc3;
                }
                (arg2 as core.settings.interfaces.IMyName).myName = loc10;
            }
            if (loc11 is core.settings.interfaces.IBacklight) 
            {
                (loc11 as core.settings.interfaces.IBacklight).backlightActive = (arg1[17] >> 7 & 1) != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.IBacklightTimeOn) 
            {
                loc2 = arg1[16] & 31;
                loc5 = arg1[17] & 63;
                loc7 = new Date(null, null, null, loc2, loc5);
                (loc11 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc7;
            }
            if (loc11 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc8 = arg1[18] & 31;
                loc6 = arg1[19] & 63;
                loc1 = new Date(null, null, null, loc8, loc6);
                (loc11 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc1;
            }
            if (loc11 is core.settings.interfaces.ICadenceSensor) 
            {
                (loc11 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = (arg1[17] >> 6 & 1) != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.IFuelConsumption) 
            {
                (loc12 = new utils.converter.FuelConsumptionConverter()).inputFormat = (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
                loc12.outputFormat = "l/100km";
                (loc11 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc12.convert(((arg1[21] & 15) << 8 | arg1[20]) / 10);
            }
            if (loc11 is core.settings.interfaces.IPowerSaveMode) 
            {
                (loc11 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = (arg1[21] >> 4 & 1) != 1 ? false : true;
            }
            if (loc11 is core.settings.interfaces.IETAArivalFlag) 
            {
                (loc11 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = (arg1[21] >> 5 & 1) != 1 ? false : true;
            }
            var loc4:*=0;
            var loc9:*=0;
            while (loc4 <= 21) 
            {
                loc9 = loc9 + arg1[loc4];
                ++loc4;
            }
            if ((loc9 = ++loc9 & 255) != arg1[22]) 
            {
                debug.Debug.warning("wrong checksum");
            }
            return loc11;
        }

        public function decodeAdvancedSettings(arg1:Array, arg2:core.settings.Settings):core.settings.Settings
        {
            var loc4:*=0;
            var loc6:*=null;
            var loc3:*=null;
            var loc1:*=null;
            var loc2:*;
            if (!(loc2 = arg1[0] == 0)) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "Topline2012Decoder > decodeSettings: data is not valid"));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            if (arg2 is core.settings.interfaces.IMyName) 
            {
                loc4 = 1;
                var loc5:*="";
                while (loc4 < 10) 
                {
                    if (arg1[loc4] == 0) 
                    {
                        break;
                    }
                    loc5 = loc5 + com.hurlant.util.Hex.toString(arg1[loc4].toString(16));
                    ++loc4;
                }
                (arg2 as core.settings.interfaces.IMyName).myName = loc5;
            }
            if (arg2 is core.settings.interfaces.IPowerSaveMode) 
            {
                (arg2 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = arg1[10];
            }
            if (arg2 is core.settings.interfaces.ICadenceSensor) 
            {
                (arg2 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = arg1[11];
            }
            if (arg2 is core.settings.interfaces.IETADistance) 
            {
                (arg2 as core.settings.interfaces.IETADistance).etaDistance = (arg1[12] << 16 | arg1[13] << 8 | arg1[14]) * 10;
            }
            if (arg2 is core.settings.interfaces.IETAArivalFlag) 
            {
                (arg2 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = arg1[15];
            }
            if (arg2 is core.settings.interfaces.IFuelConsumption) 
            {
                (loc6 = new utils.converter.FuelConsumptionConverter()).inputFormat = (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
                loc6.outputFormat = "l/100km";
                (arg2 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc6.convert((arg1[16] << 8 | arg1[17]) / 10);
            }
            if (arg2 is core.settings.interfaces.IBacklight) 
            {
                (arg2 as core.settings.interfaces.IBacklight).backlightActive = arg1[18];
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOn) 
            {
                (loc3 = new Date()).minutes = arg1[20];
                loc3.hours = arg1[19];
                (arg2 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc3;
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc1 = new Date();
                loc1.minutes = arg1[22];
                loc1.hours = arg1[21];
                (arg2 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc1;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude1) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = ((arg1[23] << 8 | arg1[24]) - 10000) * 100;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude2) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = ((arg1[25] << 8 | arg1[26]) - 10000) * 100;
            }
            if (arg2 is core.settings.interfaces.INfc) 
            {
                (arg2 as core.settings.interfaces.INfc).nfcActive = arg1[27] != 1 ? false : true;
            }
            return arg2;
        }

        internal function generateGUIDLog(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc3:*=[];
            var loc7:*=arg1.unit.type.toString();
            while (core.general.UnitType.BC1416.toString() === loc7) 
            {
                loc3.push(28);
            }
        }

        internal function decodeLogEntryGeneral(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createLogEntryFromLog(arg1)).number = arg1.entries.length;
            var loc5:*=(arg2[1] & 63) << 4 | (arg2[0] & 240) >> 4;
            loc2.distanceUphill = loc5 * arg1.wheelSize / 1000;
            var loc4:*=(arg2[1] & 192) >> 6 | arg2[2] << 2;
            loc2.distanceDownhill = loc4 * arg1.wheelSize / 1000;
            loc2.rotations = (arg2[4] & 3) << 8 | arg2[3];
            loc2.distance = loc2.rotations * arg1.wheelSize / 1000;
            loc2.trainingTime = arg1.samplingRate * 100;
            if (arg4) 
            {
                loc2.distance = loc2.distance - arg3.distance;
                loc2.distanceDownhill = loc2.distanceDownhill - arg3.distanceDownhill;
                loc2.distanceUphill = loc2.distanceUphill - arg3.distanceUphill;
                loc2.trainingTime = loc2.trainingTime - arg3.trainingTime;
            }
            if (arg3) 
            {
                loc2.distanceAbsolute = arg3.distanceAbsolute + loc2.distance;
            }
            else 
            {
                loc2.distanceAbsolute = loc2.distance;
            }
            if (arg3) 
            {
                loc2.trainingTimeAbsolute = arg3.trainingTimeAbsolute + loc2.trainingTime;
            }
            else 
            {
                loc2.trainingTimeAbsolute = loc2.trainingTime;
            }
            loc2.temperature = ((arg2[4] & 252) >> 2) - 10;
            loc2.altitudeDifferencesUphill = ((arg2[6] & 1) << 8 | arg2[5]) * 1000;
            var loc1:*=arg2[6] >> 1;
            loc2.altitudeDifferencesDownhill = ((arg2[8] & 1) << 8 | arg2[7]) * 1000;
            var loc3:*;
            if (!((loc3 = (arg2[8] >> 1) * -1) == 0) && !(loc1 == 0)) 
            {
                if (arg3) 
                {
                    if (arg3.incline > 0) 
                    {
                        loc2.incline = loc3;
                    }
                    else 
                    {
                        loc2.incline = loc1;
                    }
                }
            }
            else if (loc1 == 0) 
            {
                if (loc3 != 0) 
                {
                    loc2.incline = loc3;
                }
            }
            else 
            {
                loc2.incline = loc1;
            }
            return loc2;
        }

        internal function decodeLogEntryTypeAll(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc1:*;
            (loc1 = decodeLogEntryGeneral(arg1, arg2, arg3, arg4)).heartrate = arg2[9];
            loc1.cadence = arg2[10];
            loc1.speed = speedConverter.convert(((arg2[12] & 7) << 8 | arg2[11]) / 10);
            loc1.speedTime = utils.Calculations.calculateSpeedTime(loc1.speed);
            loc1.timeInTargetZone = (arg2[12] >> 3) * 100;
            loc1.altitude = (((arg2[14] & 31) << 8 | arg2[13]) - 1000) * 1000;
            loc1.timeAboveTargetZone = ((arg2[15] & 3) << 3 | arg2[14] >> 5) * 100;
            loc1.timeBelowTargetZone = loc1.trainingTime - loc1.timeAboveTargetZone - loc1.timeInTargetZone;
            loc1.timeInIntensityZone1 = ((arg2[15] & 124) >> 2) * 100;
            loc1.timeInIntensityZone2 = ((arg2[16] & 15) << 1 | arg2[15] >> 7) * 100;
            loc1.timeInIntensityZone3 = ((arg2[17] & 1) << 4 | (arg2[16] & 240) >> 4) * 100;
            loc1.timeInIntensityZone4 = ((arg2[17] & 62) >> 1) * 100;
            loc1.timeAboveIntensityZones = ((arg2[17] & 192) >> 6 | (arg2[18] & 3) << 2) * 100;
            loc1.timeBelowIntensityZones = loc1.trainingTime - loc1.timeInIntensityZone1 - loc1.timeInIntensityZone2 - loc1.timeInIntensityZone3 - loc1.timeInIntensityZone4 - loc1.timeAboveIntensityZones;
            loc1.power = (arg2[18] & 248) >> 3 | (arg2[19] & 63) << 5;
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function decodeLogEntryTypeNoHr(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc1:*;
            (loc1 = decodeLogEntryGeneral(arg1, arg2, arg3, arg4)).cadence = arg2[9];
            loc1.speed = speedConverter.convert(((arg2[11] & 7) << 8 | arg2[10]) / 10);
            loc1.speedTime = utils.Calculations.calculateSpeedTime(loc1.speed);
            loc1.altitude = ((arg2[12] << 5 | (arg2[11] & 248) >> 3) - 1000) * 1000;
            loc1.power = (arg2[14] & 7) << 8 | arg2[13];
            calculateChecksumm5Bit(arg2);
            return loc1;
        }

        internal function decodeLogEntryTypeNoCad(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc1:*;
            (loc1 = decodeLogEntryGeneral(arg1, arg2, arg3, arg4)).heartrate = arg2[9];
            loc1.speed = speedConverter.convert(((arg2[11] & 7) << 8 | arg2[10]) / 10);
            loc1.speedTime = utils.Calculations.calculateSpeedTime(loc1.speed);
            loc1.timeInTargetZone = (arg2[11] >> 3) * 100;
            loc1.altitude = (((arg2[13] & 31) << 8 | arg2[12]) - 1000) * 1000;
            loc1.timeAboveTargetZone = ((arg2[14] & 3) << 3 | arg2[13] >> 5) * 100;
            loc1.timeBelowTargetZone = loc1.trainingTime - loc1.timeAboveTargetZone - loc1.timeInTargetZone;
            loc1.timeInIntensityZone1 = ((arg2[14] & 124) >> 2) * 100;
            loc1.timeInIntensityZone2 = ((arg2[15] & 15) << 1 | arg2[14] >> 7) * 100;
            loc1.timeInIntensityZone3 = ((arg2[16] & 1) << 4 | (arg2[15] & 240) >> 4) * 100;
            loc1.timeInIntensityZone4 = ((arg2[16] & 62) >> 1) * 100;
            loc1.timeAboveIntensityZones = (arg2[16] & 192) >> 6 | ((arg2[17] & 3) << 2) * 100;
            loc1.timeBelowIntensityZones = loc1.trainingTime - loc1.timeInIntensityZone1 - loc1.timeInIntensityZone2 - loc1.timeInIntensityZone3 - loc1.timeInIntensityZone4 - loc1.timeAboveIntensityZones;
            calculateChecksumm5Bit(arg2);
            return loc1;
        }

        internal function decodeLogEntryTypeNoHrCad(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):core.activities.ActivityEntry
        {
            var loc1:*;
            (loc1 = decodeLogEntryGeneral(arg1, arg2, arg3, arg4)).speed = speedConverter.convert(((arg2[10] & 7) << 8 | arg2[9]) / 10);
            loc1.speedTime = utils.Calculations.calculateSpeedTime(loc1.speed);
            loc1.altitude = ((arg2[11] << 5 | (arg2[10] & 248) >> 3) - 1000) * 1000;
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function decodeLogPauseGeneral(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):Array
        {
            var loc16:*;
            (loc16 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "p")).type = "p";
            loc16.number = pauseCounter;
            ++pauseCounter;
            loc16.logReference = arg1;
            var loc13:*=decodeLogEntryGeneral(arg1, arg2, arg3, arg4);
            arg1.maxHeartrateEntry = (arg1.maxHeartrateEntry + 1);
            arg1.maxAltitudeEntry = (arg1.maxAltitudeEntry + 1);
            arg1.maxInclineDownhillEntry = (arg1.maxInclineDownhillEntry + 1);
            arg1.maxInclineUphillEntry = (arg1.maxInclineUphillEntry + 1);
            arg1.maxSpeedEntry = (arg1.maxSpeedEntry + 1);
            loc13.number = arg1.entries.length;
            var loc18:*=(arg2[1] & 63) << 4 | (arg2[0] & 240) >> 4;
            loc13.distanceUphill = loc18 * arg1.wheelSize / 1000;
            var loc6:*=(arg2[1] & 192) >> 6 | arg2[2] << 2;
            loc13.distanceDownhill = loc6 * arg1.wheelSize / 1000;
            loc13.rotations = (arg2[4] & 3) << 8 | arg2[3];
            loc13.distance = loc13.rotations * arg1.wheelSize / 1000;
            loc13.temperature = ((arg2[4] & 252) >> 2) - 10;
            loc13.speed = speedConverter.convert(((arg2[6] & 7) << 8 | arg2[5]) / 10);
            loc13.speedTime = utils.Calculations.calculateSpeedTime(loc13.speed);
            loc13.trainingTime = (arg2[6] >> 3) * 100;
            loc13.altitudeDifferencesUphill = ((arg2[8] & 1) << 8 | arg2[7]) * 1000;
            var loc1:*=arg2[8] >> 1;
            loc13.altitudeDifferencesDownhill = ((arg2[10] & 1) << 8 | arg2[9]) * 1000;
            var loc4:*=arg2[10] >> 1;
            loc13.incline = Math.max(loc1, loc4);
            loc13.altitude = (((arg2[12] & 31) << 8 | arg2[11]) - 1000) * 1000;
            var loc19:*=((arg2[13] & 7) << 3 | arg2[12] >> 5) + 2000;
            var loc14:*=arg2[13] >> 3;
            var loc8:*=arg2[14] & 15;
            var loc2:*=arg2[14] >> 4;
            var loc9:*=(arg2[15] & 63) + 2000;
            var loc11:*=(arg2[16] & 7) << 2 | arg2[15] >> 6;
            var loc7:*=arg2[16] >> 3;
            var loc10:*=arg2[17] & 63;
            var loc15:*=arg2[17] >> 6 | (arg2[18] & 7) << 2;
            var loc17:*=arg2[18] >> 4 | (arg2[19] & 3) << 4;
            var loc12:*=arg2[19] >> 2;
            var loc3:*=arg2[20] & 31;
            var loc20:*=new Date(loc19, (loc8 - 1), loc14, loc7, loc10, loc15);
            var loc5:*=new Date(loc9, (loc2 - 1), loc11, loc3, loc17, loc12);
            loc16.duration = (loc5.time - loc20.time) / 10;
            if (arg3 == null) 
            {
                loc16.timeAbsolute = loc13.trainingTime;
                loc13.trainingTimeAbsolute = loc13.trainingTime;
            }
            else 
            {
                loc16.timeAbsolute = loc13.trainingTime + arg3.trainingTimeAbsolute;
                loc13.trainingTimeAbsolute = loc13.trainingTime + arg3.trainingTimeAbsolute;
            }
            if (arg3 == null) 
            {
                loc16.distanceAbsolute = loc13.distance;
                loc13.distanceAbsolute = loc13.distance;
            }
            else 
            {
                loc16.distanceAbsolute = loc13.distance + arg3.distanceAbsolute;
                loc13.distanceAbsolute = loc13.distance + arg3.distanceAbsolute;
            }
            return [loc13, loc16];
        }

        internal function decodeLogPauseAll(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):Array
        {
            var loc3:*;
            var loc1:*=(loc3 = decodeLogPauseGeneral(arg1, arg2, arg3, arg4))[0];
            var loc2:*=loc3[1];
            loc1.timeInTargetZone = (arg2[20] >> 5 | (arg2[21] & 3) << 3) * 100;
            loc1.timeAboveTargetZone = ((arg2[21] & 124) >> 2) * 100;
            loc1.timeBelowTargetZone = loc1.trainingTime - loc1.timeAboveTargetZone - loc1.timeInTargetZone;
            loc1.timeInIntensityZone1 = (arg2[21] >> 7 | (arg2[22] & 15) << 1) * 100;
            loc1.timeInIntensityZone2 = ((arg2[22] & 240) >> 4 | (arg2[23] & 1) << 4) * 100;
            loc1.timeInIntensityZone3 = ((arg2[23] & 62) >> 1) * 100;
            loc1.timeInIntensityZone4 = ((arg2[23] & 192) >> 6 | (arg2[24] & 7) << 2) * 100;
            loc1.timeAboveIntensityZones = ((arg2[24] & 248) >> 3) * 100;
            loc1.timeBelowIntensityZones = loc1.trainingTime - loc1.timeInIntensityZone1 - loc1.timeInIntensityZone2 - loc1.timeInIntensityZone3 - loc1.timeInIntensityZone4 - loc1.timeAboveIntensityZones;
            loc1.heartrate = arg2[25];
            loc1.cadence = arg2[26];
            loc1.power = (arg2[28] & 7) << 8 | arg2[27];
            calculateChecksumm5Bit(arg2);
            return [loc1, loc2];
        }

        internal function decodeLogPauseNoHr(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):Array
        {
            var loc3:*;
            var loc1:*=(loc3 = decodeLogPauseGeneral(arg1, arg2, arg3, arg4))[0];
            var loc2:*=loc3[1];
            loc1.power = (arg2[20] & 224) >> 5 | arg2[21] << 3;
            loc1.cadence = arg2[22];
            calculateChecksumm(arg2);
            return [loc1, loc2];
        }

        internal function decodeLogPauseNoCad(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):Array
        {
            var loc3:*;
            var loc1:*=(loc3 = decodeLogPauseGeneral(arg1, arg2, arg3, arg4))[0];
            var loc2:*=loc3[1];
            loc1.timeInTargetZone = (arg2[20] >> 5 | (arg2[21] & 3) << 3) * 100;
            loc1.timeAboveTargetZone = ((arg2[21] & 124) >> 2) * 100;
            loc1.timeBelowTargetZone = loc1.trainingTime - loc1.timeAboveTargetZone - loc1.timeInTargetZone;
            loc1.timeInIntensityZone1 = (arg2[21] >> 7 | (arg2[22] & 15) << 1) * 100;
            loc1.timeInIntensityZone2 = ((arg2[22] & 240) >> 4 | (arg2[23] & 1) << 4) * 100;
            loc1.timeInIntensityZone3 = ((arg2[23] & 62) >> 1) * 100;
            loc1.timeInIntensityZone4 = ((arg2[23] & 192) >> 6 | (arg2[24] & 7) << 2) * 100;
            loc1.timeAboveIntensityZones = ((arg2[24] & 248) >> 3) * 100;
            loc1.timeBelowIntensityZones = loc1.trainingTime - loc1.timeInIntensityZone1 - loc1.timeInIntensityZone2 - loc1.timeInIntensityZone3 - loc1.timeInIntensityZone4 - loc1.timeAboveIntensityZones;
            loc1.heartrate = arg2[25];
            calculateChecksumm(arg2);
            return [loc1, loc2];
        }

        internal function decodeLogPauseNoHrCad(arg1:core.activities.Activity, arg2:Array, arg3:core.activities.ActivityEntry=null, arg4:Boolean=false):Array
        {
            var loc3:*;
            var loc1:*=(loc3 = decodeLogPauseGeneral(arg1, arg2, arg3, arg4))[0];
            var loc2:*=loc3[1];
            calculateChecksumm(arg2);
            return [loc1, loc2];
        }

        internal function decodeLogLapGeneral(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc1:*;
            (loc1 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "l")).type = "l";
            loc1.number = lapCounter;
            ++lapCounter;
            loc1.logReference = arg1;
            loc1.time = (arg2[0] >> 4 << 12 | arg2[2] << 8 | arg2[1]) * 100;
            if (arg3 == null) 
            {
                loc1.timeAbsolute = loc1.time;
            }
            else 
            {
                loc1.timeAbsolute = arg3.timeAbsolute + loc1.time;
            }
            loc1.distance = (arg2[5] << 16 | arg2[4] << 8 | arg2[3]) * arg1.wheelSize / 1000;
            if (arg3 == null) 
            {
                loc1.distanceAbsolute = loc1.distance;
            }
            else 
            {
                loc1.distanceAbsolute = arg3.distanceAbsolute + loc1.distance;
            }
            loc1.averageSpeed = (arg2[7] << 8 | arg2[6]) / 100 / 3.6;
            loc1.maximumSpeed = (arg2[9] << 8 | arg2[8]) / 100 / 3.6;
            loc1.altitudeUphill = ((arg2[12] & 15) << 16 | arg2[11] << 8 | arg2[10]) * 100;
            loc1.altitudeDownhill = ((arg2[12] & 240) << 12 | arg2[14] << 8 | arg2[13]) * 100;
            loc1.distanceUphill = (arg2[17] << 16 | arg2[16] << 8 | arg2[15]) * arg1.wheelSize / 1000;
            loc1.distanceDownhill = (arg2[20] << 16 | arg2[19] << 8 | arg2[18]) * arg1.wheelSize / 1000;
            loc1.maximumAltitude = (((arg2[21] & 31) << 8 | arg2[22]) - 1000) * 1000;
            loc1.averageInclineUphill = arg2[23] & 127;
            loc1.averageInclineDownhill = arg2[24] & 127;
            loc1.maximumInclineUphill = arg2[25] & 127;
            loc1.maximumInclineDownhill = arg2[26] & 127;
            loc1.calories = (arg2[26] & 128) << 16 | arg2[28] << 8 | arg2[27];
            return loc1;
        }

        internal function decodeLogLapAll(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc1:*;
            (loc1 = decodeLogLapGeneral(arg1, arg2, arg3)).averageHeartrate = arg2[29];
            loc1.maximumHeartrate = arg2[30];
            loc1.averageCadence = arg2[31];
            loc1.maximumCadence = arg2[32];
            loc1.averagePower = (arg2[34] & 7) << 8 | arg2[33];
            loc1.maximumPower = (arg2[35] & 63) << 5 | arg2[34] >> 3;
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function decodeLogLapNoHr(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc1:*;
            (loc1 = decodeLogLapGeneral(arg1, arg2, arg3)).averageCadence = arg2[29];
            loc1.maximumCadence = arg2[30];
            loc1.averagePower = (arg2[32] & 7) << 8 | arg2[31];
            loc1.maximumPower = (arg2[33] & 63) << 5 | arg2[32] >> 3;
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function decodeLogLapNoCad(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc1:*;
            (loc1 = decodeLogLapGeneral(arg1, arg2, arg3)).averageHeartrate = arg2[29];
            loc1.maximumHeartrate = arg2[30];
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function decodeLogLapNoHrCad(arg1:core.activities.Activity, arg2:Array, arg3:core.marker.Marker):core.marker.Marker
        {
            var loc1:*=decodeLogLapGeneral(arg1, arg2, arg3);
            calculateChecksumm(arg2);
            return loc1;
        }

        internal function calculateChecksumm(arg1:Array):Boolean
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.length - 2;
            while (loc3 <= loc1) 
            {
                loc2 = loc2 + arg1[loc3];
                ++loc3;
            }
            ++loc2;
            loc2 = loc2 & 255;
            if (loc2 != arg1[loc1 + 1]) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", utils.LanguageManager.getString("INFO_POPUP.WRONG_CHECKSUM")));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 537, "BC 23.16 > Log: incorrect checksum"));
                throw new decoder.core.DecodeError(utils.LanguageManager.getString("INFO_POPUP.WRONG_CHECKSUM"));
                return false;
            }
            return true;
        }

        internal function calculateChecksumm5Bit(arg1:Array):Boolean
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.length - 2;
            while (loc3 <= loc1) 
            {
                loc2 = loc2 + arg1[loc3];
                ++loc3;
            }
            loc2 = loc2 + (arg1[loc1 + 1] & 7);
            ++loc2;
            loc2 = loc2 & 31;
            if (loc2 != (arg1[loc1 + 1] & 248) >> 3) 
            {
                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", utils.LanguageManager.getString("INFO_POPUP.NO_LOG_ON_DEVICE")));
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 537, "BC 23.16 > Log: incorrect checksum"));
                throw new decoder.core.DecodeError(utils.LanguageManager.getString("INFO_POPUP.WRONG_CHECKSUM"));
                return false;
            }
            return true;
        }

        internal function generateGUID(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc3:*=[];
            var loc7:*=arg1.unit.type.toString();
            while (core.general.UnitType.BC1416.toString() === loc7) 
            {
                loc3.push(28);
            }
        }

        public function encodeGhostRaceDataDemo(arg1:core.activities.Activity):Array
        {
            var loc6:*=0;
            var loc5:*=0;
            var loc1:*=0;
            var loc2:*=NaN;
            var loc8:*=0;
            var loc4:*=0;
            var loc3:*=[];
            loc6 = 0;
            while (loc6 < 160) 
            {
                loc3.push(13);
                ++loc6;
            }
            var loc7:*=loc3.length;
            loc6 = 0;
            while (loc6 < loc7) 
            {
                loc5 = 0;
                loc1 = 0;
                while (loc1 < 8) 
                {
                    loc2 = 1 << loc1;
                    if (loc3[loc6] & loc2) 
                    {
                        ++loc5;
                    }
                    ++loc1;
                }
                loc8 = 0;
                loc4 = loc6 / 8 + loc7;
                if (loc5 % 2 != 1) 
                {
                    if (loc3[loc4] == undefined) 
                    {
                        loc3[loc4] = 0;
                    }
                }
                else 
                {
                    var loc9:*=loc4;
                    var loc10:*=loc3[loc9] | 1 << loc6 % 8;
                    loc3[loc9] = loc10;
                    if (loc8 != loc4) 
                    {
                        loc8 = loc4;
                    }
                }
                ++loc6;
            }
            loc3.push(loc7);
            return loc3;
        }

        public function encodeGhostRaceData(arg1:core.activities.Activity):Array
        {
            var loc17:*=NaN;
            var loc11:*=NaN;
            var loc2:*=NaN;
            var loc8:*=0;
            var loc21:*=NaN;
            var loc13:*=0;
            var loc14:*=NaN;
            var loc1:*=null;
            var loc19:*=NaN;
            var loc7:*=NaN;
            var loc20:*=NaN;
            var loc15:*=NaN;
            var loc10:*=0;
            var loc16:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc18:*=0;
            var loc6:*=0;
            var loc9:*=0;
            var loc5:*=[];
            if (arg1 != null) 
            {
                loc17 = 0;
                loc11 = 0;
                loc2 = 0;
                loc8 = 0;
                loc21 = 0;
                if ((loc13 = arg1.wheelSize) == 0) 
                {
                    loc13 = 2095;
                }
                loc14 = 0;
                loc9 = 0;
                while (loc9 < arg1.entries.length) 
                {
                    loc1 = arg1.entries[loc9];
                    loc21 = loc1.distance / (loc13 / 1000);
                    loc14 = loc1.trainingTime / 100;
                    loc19 = loc21 / loc14;
                    if (isNaN(loc19)) 
                    {
                        loc19 = 0;
                    }
                    loc7 = 0;
                    loc20 = 1;
                    loc15 = 0;
                    loc10 = loc20;
                    while (loc10 <= loc14) 
                    {
                        loc15 = loc20 * loc19 - loc7;
                        loc5[loc5.length] = loc15;
                        loc7 = loc7 + loc15;
                        loc17 = loc17 + loc15;
                        ++loc20;
                        ++loc10;
                    }
                    if (loc7 < loc21 || loc21 == 0) 
                    {
                        loc11 = loc11 + (loc21 - loc7);
                        loc2 = loc2 + loc14 % 1;
                    }
                    if (loc2 >= 1) 
                    {
                        loc5[loc5.length] = loc11;
                        loc17 = loc17 + loc11;
                        loc11 = 0;
                        --loc2;
                    }
                    ++loc9;
                }
                if (loc11 > 0) 
                {
                    var loc22:*=(loc5.length - 1);
                    var loc23:*=loc5[loc22] + Math.round(loc11);
                    loc5[loc22] = loc23;
                    loc17 = loc17 + Math.round(loc11);
                }
            }
            var loc12:*=loc5.length;
            loc9 = 0;
            while (loc9 < loc12) 
            {
                loc16 = 0;
                loc3 = 0;
                while (loc3 < 8) 
                {
                    loc4 = 1 << loc3;
                    if (loc5[loc9] & loc4) 
                    {
                        ++loc16;
                    }
                    ++loc3;
                }
                loc18 = 0;
                loc6 = loc9 / 8 + loc12;
                if (loc16 % 2 != 1) 
                {
                    if (loc5[loc6] == undefined) 
                    {
                        loc5[loc6] = 0;
                    }
                }
                else 
                {
                    loc23 = loc6;
                    loc22 = loc5[loc23] | 1 << loc9 % 8;
                    loc5[loc23] = loc22;
                    if (loc18 != loc6) 
                    {
                        loc18 = loc6;
                    }
                }
                ++loc9;
            }
            loc5.push(loc12);
            return loc5;
        }

        public static const LOG_ENTRY_TYPE_LAPALL:uint=8;

        public static const LOG_ENTRY_TYPE_LAPCAD:uint=10;

        public static const LOG_ENTRY_TYPE_LAPHR:uint=9;

        public static const LOG_ENTRY_TYPE_LAPHRCAD:uint=11;

        public static const LOG_ENTRY_TYPE_NOCAD:uint=2;

        public static const LOG_ENTRY_TYPE_NOHR:uint=1;

        public static const LOG_ENTRY_TYPE_ALL:uint=0;

        public static const LOG_ENTRY_TYPE_PAUSEALL:uint=4;

        public static const LOG_ENTRY_TYPE_PAUSENOCAD:uint=6;

        public static const LOG_ENTRY_TYPE_PAUSENOHR:uint=5;

        public static const LOG_ENTRY_TYPE_PAUSENOHRCAD:uint=7;

        protected static const kmphToMpsSpeedConverter:utils.converter.SpeedConverter=new utils.converter.SpeedConverter("kmh", "ms");

        internal static const ENTRY_CORRECTION_MAX:uint=32767;

        public static const LOG_ENTRY_TYPE_NOHRCAD:uint=3;

        internal var lapCounter:uint=0;

        internal var pauseCounter:uint=0;

        internal var speedConverter:utils.converter.SpeedConverter;

        internal static var _instance:decoder.Topline2016Decoder;
    }
}


