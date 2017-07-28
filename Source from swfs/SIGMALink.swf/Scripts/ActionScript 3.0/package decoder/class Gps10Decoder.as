//class Gps10Decoder
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


