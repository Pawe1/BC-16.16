//class Rox100Decoder
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


