//class Rox2012Decoder
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


