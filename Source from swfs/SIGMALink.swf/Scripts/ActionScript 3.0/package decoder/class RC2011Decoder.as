//class RC2011Decoder
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


