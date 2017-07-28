//class PC2814Decoder
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


