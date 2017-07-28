//class Rox110Decoder
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


