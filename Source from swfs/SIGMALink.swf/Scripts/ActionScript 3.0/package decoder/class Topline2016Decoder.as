//class Topline2016Decoder
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


