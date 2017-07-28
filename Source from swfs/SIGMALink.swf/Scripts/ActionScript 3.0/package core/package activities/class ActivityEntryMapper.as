//class ActivityEntryMapper
package core.activities 
{
    import __AS3__.vec.*;
    import database.*;
    import utils.*;
    import utils.date.*;
    
    public class ActivityEntryMapper extends Object
    {
        public function ActivityEntryMapper()
        {
            super();
            return;
        }

        public static function generateCSVHeader(arg1:core.activities.ActivityEntry):__AS3__.vec.Vector.<String>
        {
            var loc1:*=new __AS3__.vec.Vector.<String>();
            loc1.push("Number");
            if (arg1.altitudeDefined) 
            {
                loc1.push("Altitude [m]");
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push("AltitudeDifferencesDownhill [m]");
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push("AltitudeDifferencesUphill [m]");
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push("Cadence [rpm]");
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push("Calories [kcal]");
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push("DistanceAbsolute [m]");
            }
            if (arg1.distanceDefined) 
            {
                loc1.push("Distance [m]");
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push("DistanceDownhill [m]");
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push("DistanceUphill [m]");
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push("Heartrate [bpm]");
            }
            if (arg1.inclineDefined) 
            {
                loc1.push("Incline [%]");
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push("IntensityZone");
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push("Latitude");
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push("Longitude");
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push(" % of  HRMax");
            }
            if (arg1.powerDefined) 
            {
                loc1.push("Power [Watt]");
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push("Power to Weight Ratio [Watt/kg]");
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push("RelativeRotations");
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push("RiseRate [m/min]");
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push("Rotations");
            }
            if (arg1.speedDefined) 
            {
                loc1.push("Speed [m/s]");
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push("SpeedReference");
            }
            if (arg1.speedTimeDefined) 
            {
                loc1.push("SpeedTime");
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push("TargetZone");
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push("Temperature [°C]");
            }
            loc1.push("TrainingTime [s]");
            loc1.push("TrainingTimeAbsolute [s]");
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push("TrainingTimeDownhill [s]");
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push("TrainingTimeUphill [s]");
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push("Work [kJ]");
            }
            if (arg1.zoneDefined) 
            {
                loc1.push("Zone");
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push("Power zone");
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push("Time below intensity zones");
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push("Time in intensity zone 1");
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push("Time in intensity zone 2");
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push("Time in intensity zone 3");
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push("Time in intensity zone 4");
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push("Time above intensity zones");
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push("Time in Power zone 1");
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push("Time in Power zone 2");
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push("Time in Power zone 3");
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push("Time in Power zone 4");
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push("Time in Power zone 5");
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push("Time in Power zone 6");
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push("Time in Power zone 7");
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push("Time beow target zone");
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push("Time in target zone");
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push("Time above target zone");
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push("Pedaling time");
            }
            return loc1;
        }

        public static function fromXML(arg1:XML, arg2:core.activities.ActivityEntry, arg3:int, arg4:core.activities.ActivityEntry):void
        {
            var loc1:*=arg3;
            while (100 === loc1) 
            {
            };
        }

        public static function fromDB(arg1:Object, arg2:core.activities.ActivityEntry):void
        {
            arg2.activityEntryId = arg1["activityEntryId"];
            arg2.activityId = arg1["activityId"];
            var loc1:*;
            arg2.altitudeDefined = loc1 = !(arg1["altitude"] == null);
            if (loc1 == true) 
            {
                arg2.altitude = arg1["altitude"];
            }
            arg2.altitudeDifferencesDownhillDefined = loc1 = !(arg1["altitudeDifferencesDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeDifferencesDownhill = arg1["altitudeDifferencesDownhill"];
            }
            arg2.altitudeDifferencesUphillDefined = loc1 = !(arg1["altitudeDifferencesUphill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeDifferencesUphill = arg1["altitudeDifferencesUphill"];
            }
            arg2.cadenceDefined = loc1 = !(arg1["cadence"] == null);
            if (loc1 == true) 
            {
                arg2.cadence = arg1["cadence"];
            }
            arg2.caloriesDefined = loc1 = !(arg1["calories"] == null);
            if (loc1 == true) 
            {
                arg2.calories = arg1["calories"];
            }
            arg2.distanceDefined = loc1 = !(arg1["distance"] == null);
            if (loc1 == true) 
            {
                arg2.distance = arg1["distance"];
            }
            arg2.distanceAbsoluteDefined = loc1 = !(arg1["distanceAbsolute"] == null);
            if (loc1 == true) 
            {
                arg2.distanceAbsolute = arg1["distanceAbsolute"];
            }
            arg2.distanceDownhillDefined = loc1 = !(arg1["distanceDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.distanceDownhill = arg1["distanceDownhill"];
            }
            arg2.distanceUphillDefined = loc1 = !(arg1["distanceUphill"] == null);
            if (loc1 == true) 
            {
                arg2.distanceUphill = arg1["distanceUphill"];
            }
            arg2.heartrateDefined = loc1 = !(arg1["heartrate"] == null);
            if (loc1 == true) 
            {
                arg2.heartrate = arg1["heartrate"];
            }
            arg2.inclineDefined = loc1 = !(arg1["incline"] == null);
            if (loc1 == true) 
            {
                arg2.incline = arg1["incline"];
            }
            arg2.intensityZoneDefined = loc1 = !(arg1["intensityZone"] == null);
            if (loc1 == true) 
            {
                arg2.intensityZone = arg1["intensityZone"];
            }
            arg2.latitudeDefined = loc1 = !(arg1["latitude"] == null);
            if (loc1 == true) 
            {
                arg2.latitude = arg1["latitude"];
            }
            arg2.longitudeDefined = loc1 = !(arg1["longitude"] == null);
            if (loc1 == true) 
            {
                arg2.longitude = arg1["longitude"];
            }
            arg2.percentHRMaxDefined = loc1 = !(arg1["percentHRMax"] == null);
            if (loc1 == true) 
            {
                arg2.percentHRMax = arg1["percentHRMax"];
            }
            arg2.powerDefined = loc1 = !(arg1["power"] == null);
            if (loc1 == true) 
            {
                arg2.power = arg1["power"];
            }
            arg2.powerPerKGDefined = loc1 = !(arg1["powerPerKG"] == null);
            if (loc1 == true) 
            {
                arg2.powerPerKG = arg1["powerPerKG"];
            }
            arg2.relativeRotationsDefined = loc1 = !(arg1["relativeRotations"] == null);
            if (loc1 == true) 
            {
                arg2.relativeRotations = arg1["relativeRotations"];
            }
            arg2.riseRateDefined = loc1 = !(arg1["riseRate"] == null);
            if (loc1 == true) 
            {
                arg2.riseRate = arg1["riseRate"];
            }
            arg2.rotationsDefined = loc1 = !(arg1["rotations"] == null);
            if (loc1 == true) 
            {
                arg2.rotations = arg1["rotations"];
            }
            arg2.speedDefined = loc1 = !(arg1["speed"] == null);
            if (loc1 == true) 
            {
                arg2.speed = arg1["speed"];
                arg2.speedTimeDefined = true;
                arg2.speedTime = utils.Calculations.calculateSpeedTime(arg2.speed);
            }
            arg2.speedReferenceDefined = loc1 = !(arg1["speedReference"] == null);
            if (loc1 == true) 
            {
                arg2.speedReference = arg1["speedReference"];
            }
            arg2.targetZoneDefined = loc1 = !(arg1["targetZone"] == null);
            if (loc1 == true) 
            {
                arg2.targetZone = arg1["targetZone"];
            }
            arg2.temperatureDefined = loc1 = !(arg1["temperature"] == null);
            if (loc1 == true) 
            {
                arg2.temperature = arg1["temperature"];
            }
            arg2.trainingTime = arg1["trainingTime"];
            arg2.trainingTimeAbsolute = arg1["trainingTimeAbsolute"];
            arg2.trainingTimeDownhillDefined = loc1 = !(arg1["trainingTimeDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.trainingTimeDownhill = arg1["trainingTimeDownhill"];
            }
            arg2.trainingTimeUphillDefined = loc1 = !(arg1["trainingTimeUphill"] == null);
            if (loc1 == true) 
            {
                arg2.trainingTimeUphill = arg1["trainingTimeUphill"];
            }
            arg2.workInKJDefined = loc1 = !(arg1["workInKJ"] == null);
            if (loc1 == true) 
            {
                arg2.workInKJ = arg1["workInKJ"];
            }
            arg2.zoneDefined = loc1 = !(arg1["zone"] == null);
            if (loc1 == true) 
            {
                arg2.zone = arg1["zone"];
            }
            arg2.normalizedPowerDefined = loc1 = !(arg1["normalizedPower"] == null);
            if (loc1 == true) 
            {
                arg2.normalizedPower = arg1["normalizedPower"];
            }
            arg2.rightBalanceDefined = loc1 = !(arg1["rightBalance"] == null);
            if (loc1 == true) 
            {
                arg2.rightBalance = arg1["rightBalance"];
            }
            arg2.leftBalanceDefined = loc1 = !(arg1["leftBalance"] == null);
            if (loc1 == true) 
            {
                arg2.leftBalance = arg1["leftBalance"];
            }
            arg2.powerZoneDefined = loc1 = !(arg1["powerZone"] == null);
            if (loc1 == true) 
            {
                arg2.powerZone = arg1["powerZone"];
            }
            arg2.isActiveDefined = loc1 = !(arg1["motionPoints"] == null);
            if (loc1 == true) 
            {
                arg2.isActive = arg1["motionPoints"] != 1 ? false : true;
            }
            arg2.stepsDefined = loc1 = !(arg1["stepsLow"] == null);
            if (loc1 == true) 
            {
                arg2.steps = arg1["stepsLow"];
            }
            arg2.stepTypeDefined = loc1 = !(arg1["stepsMedium"] == null);
            if (loc1 == true) 
            {
                arg2.stepType = arg1["stepsMedium"];
            }
            arg2.sleepPhaseDefined = loc1 = !(arg1["stepsHigh"] == null);
            if (loc1 == true) 
            {
                arg2.sleepPhase = arg1["stepsHigh"];
            }
            arg2.activeHourDefined = loc1 = !(arg1["activTimeLow"] == null);
            if (loc1 == true) 
            {
                arg2.activeHour = arg1["activTimeLow"];
            }
            arg2.timeStartDefined = loc1 = !(arg1["timeStart"] == null);
            if (loc1 == true) 
            {
                arg2.timeStart = utils.date.DateUtilCommon.dateFromMySqlFormat(arg1["timeStart"]);
            }
            arg2.phaseNumberDefined = loc1 = !(arg1["phaseNumber"] == null);
            if (loc1 == true) 
            {
                arg2.phaseNumber = arg1["phaseNumber"];
            }
            arg2.timeBelowIntensityZonesDefined = loc1 = !(arg1["timeBelowIntensityZones"] == null);
            if (loc1 == true) 
            {
                arg2.timeBelowIntensityZones = arg1["timeBelowIntensityZones"];
            }
            arg2.timeInIntensityZone1Defined = loc1 = !(arg1["timeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone1 = arg1["timeInIntensityZone1"];
            }
            arg2.timeInIntensityZone2Defined = loc1 = !(arg1["timeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone2 = arg1["timeInIntensityZone2"];
            }
            arg2.timeInIntensityZone3Defined = loc1 = !(arg1["timeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone3 = arg1["timeInIntensityZone3"];
            }
            arg2.timeInIntensityZone4Defined = loc1 = !(arg1["timeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone4 = arg1["timeInIntensityZone4"];
            }
            arg2.timeAboveIntensityZonesDefined = loc1 = !(arg1["timeAboveIntensityZones"] == null);
            if (loc1 == true) 
            {
                arg2.timeAboveIntensityZones = arg1["timeAboveIntensityZones"];
            }
            arg2.timeBelowTargetZoneDefined = loc1 = !(arg1["timeBelowTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeBelowTargetZone = arg1["timeBelowTargetZone"];
            }
            arg2.timeInPowerZone1Defined = loc1 = !(arg1["timeInPowerZone1"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone1 = arg1["timeInPowerZone1"];
            }
            arg2.timeInPowerZone2Defined = loc1 = !(arg1["timeInPowerZone2"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone2 = arg1["timeInPowerZone2"];
            }
            arg2.timeInPowerZone3Defined = loc1 = !(arg1["timeInPowerZone3"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone3 = arg1["timeInPowerZone3"];
            }
            arg2.timeInPowerZone4Defined = loc1 = !(arg1["timeInPowerZone4"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone4 = arg1["timeInPowerZone4"];
            }
            arg2.timeInPowerZone5Defined = loc1 = !(arg1["timeInPowerZone5"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone5 = arg1["timeInPowerZone5"];
            }
            arg2.timeInPowerZone6Defined = loc1 = !(arg1["timeInPowerZone6"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone6 = arg1["timeInPowerZone6"];
            }
            arg2.timeInPowerZone7Defined = loc1 = !(arg1["timeInPowerZone7"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone7 = arg1["timeInPowerZone7"];
            }
            arg2.timeInTargetZoneDefined = loc1 = !(arg1["timeInTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeInTargetZone = arg1["timeInTargetZone"];
            }
            arg2.timeAboveTargetZoneDefined = loc1 = !(arg1["timeAboveTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeAboveTargetZone = arg1["timeAboveTargetZone"];
            }
            arg2.pedalingTimeDefined = loc1 = !(arg1["pedalingTime"] == null);
            if (loc1 == true) 
            {
                arg2.pedalingTime = arg1["pedalingTime"];
            }
            return;
        }

        public static function generateCSV(arg1:core.activities.ActivityEntry, arg2:int):__AS3__.vec.Vector.<String>
        {
            var loc1:*=new __AS3__.vec.Vector.<String>();
            loc1.push(arg2);
            if (arg1.altitudeDefined) 
            {
                loc1.push(arg1.altitude);
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push(arg1.altitudeDifferencesDownhill);
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push(arg1.altitudeDifferencesUphill);
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push(arg1.cadence);
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push(arg1.calories);
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push(arg1.distanceAbsolute);
            }
            if (arg1.distanceDefined) 
            {
                loc1.push(arg1.distance);
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push(arg1.distanceDownhill);
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push(arg1.distanceUphill);
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push(arg1.heartrate);
            }
            if (arg1.inclineDefined) 
            {
                loc1.push(arg1.incline);
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push(arg1.intensityZone);
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push(arg1.latitude);
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push(arg1.longitude);
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push(arg1.percentHRMax);
            }
            if (arg1.powerDefined) 
            {
                loc1.push(arg1.power);
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push(arg1.powerPerKG);
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push(arg1.relativeRotations);
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push(arg1.riseRate);
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push(arg1.rotations);
            }
            if (arg1.speedDefined) 
            {
                loc1.push(arg1.speed);
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push(arg1.speedReference);
            }
            if (arg1.speedTimeDefined) 
            {
                loc1.push(arg1.speedTime);
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push(arg1.targetZone);
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push(arg1.temperature);
            }
            loc1.push(arg1.trainingTime);
            loc1.push(arg1.trainingTimeAbsolute);
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push(arg1.trainingTimeDownhill);
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push(arg1.trainingTimeUphill);
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push(arg1.workInKJ);
            }
            if (arg1.zoneDefined) 
            {
                loc1.push(arg1.zone);
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push(arg1.powerZone);
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push(arg1.timeBelowIntensityZones);
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push(arg1.timeInIntensityZone1);
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push(arg1.timeInIntensityZone2);
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push(arg1.timeInIntensityZone3);
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push(arg1.timeInIntensityZone4);
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push(arg1.timeAboveIntensityZones);
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push(arg1.timeInPowerZone1);
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push(arg1.timeInPowerZone2);
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push(arg1.timeInPowerZone3);
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push(arg1.timeInPowerZone4);
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push(arg1.timeInPowerZone5);
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push(arg1.timeInPowerZone6);
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push(arg1.timeInPowerZone7);
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push(arg1.timeBelowTargetZone);
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push(arg1.timeInTargetZone);
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push(arg1.timeAboveTargetZone);
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push(arg1.pedalingTime);
            }
            return loc1;
        }

        internal static function fromXML400(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*=undefined;
            if (arg2 != null) 
            {
                arg3.number = arg2.number + 1;
            }
            else 
            {
                arg3.number = 0;
            }
            loc1 = arg1.@altitude;
            var loc2:*;
            arg3.altitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitude = loc1;
            }
            loc1 = arg1.@altitudeDifferencesDownhill;
            arg3.altitudeDifferencesDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesDownhill = loc1;
            }
            loc1 = arg1.@altitudeDifferencesUphill;
            arg3.altitudeDifferencesUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesUphill = loc1;
            }
            loc1 = arg1.@cadence;
            arg3.cadenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.cadence = loc1;
            }
            loc1 = arg1.@calories;
            arg3.caloriesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.calories = loc1;
            }
            loc1 = arg1.@distance;
            arg3.distanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distance = loc1;
            }
            loc1 = arg1.@distanceAbsolute;
            arg3.distanceAbsoluteDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceAbsolute = loc1;
            }
            loc1 = arg1.@distanceDownhill;
            arg3.distanceDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceDownhill = loc1;
            }
            loc1 = arg1.@distanceUphill;
            arg3.distanceUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceUphill = loc1;
            }
            loc1 = arg1.@heartrate;
            arg3.heartrateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.heartrate = loc1;
            }
            loc1 = arg1.@incline;
            arg3.inclineDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.incline = loc1;
            }
            loc1 = arg1.@intensityZone;
            arg3.intensityZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.intensityZone = loc1;
            }
            loc1 = arg1.@latitude;
            arg3.latitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.latitude = loc1;
            }
            loc1 = arg1.@longitude;
            arg3.longitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.longitude = loc1;
            }
            loc1 = arg1.@percentHRMax;
            arg3.percentHRMaxDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.percentHRMax = loc1;
            }
            loc1 = arg1.@power;
            arg3.powerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.power = loc1;
            }
            loc1 = arg1.@powerPerKG;
            arg3.powerPerKGDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerPerKG = loc1;
            }
            loc1 = arg1.@relativeRotations;
            arg3.relativeRotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.relativeRotations = loc1;
            }
            loc1 = arg1.@riseRate;
            arg3.riseRateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.riseRate = loc1;
            }
            loc1 = arg1.@rotations;
            arg3.rotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rotations = loc1;
            }
            loc1 = arg1.@speed;
            arg3.speedDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speed = loc1;
            }
            loc1 = arg1.@speedReference;
            arg3.speedReferenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedReference = loc1;
            }
            loc1 = arg1.@speedTime;
            arg3.speedTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedTime = loc1;
            }
            loc1 = arg1.@targetZone;
            arg3.targetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.targetZone = loc1;
            }
            loc1 = arg1.@zone;
            arg3.zoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.zone = loc1;
            }
            loc1 = arg1.@normalizedPower;
            arg3.normalizedPowerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.normalizedPower = loc1;
            }
            loc1 = arg1.@balance;
            arg3.rightBalanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rightBalance = loc1;
            }
            arg3.leftBalanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.leftBalance = loc1;
            }
            loc1 = arg1.@temperature;
            arg3.temperatureDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.temperature = loc1;
            }
            arg3.trainingTime = arg1.@trainingTime;
            arg3.trainingTimeAbsolute = arg1.@trainingTimeAbsolute;
            loc1 = arg1.@trainingTimeDownhill;
            arg3.trainingTimeDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeDownhill = loc1;
            }
            loc1 = arg1.@trainingTimeUphill;
            arg3.trainingTimeUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeUphill = loc1;
            }
            loc1 = arg1.@workInKJ;
            arg3.workInKJDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.workInKJ = loc1;
            }
            loc1 = arg1.@powerZone;
            arg3.powerZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerZone = loc1;
            }
            loc1 = arg1.@isActive;
            arg3.isActiveDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.isActive = loc1 != 1 ? false : true;
            }
            loc1 = arg1.@steps;
            arg3.stepsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.steps = loc1;
            }
            loc1 = arg1.@stepType;
            arg3.stepTypeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.stepType = loc1;
            }
            loc1 = arg1.@sleepPhase;
            arg3.sleepPhaseDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.sleepPhase = loc1;
            }
            loc1 = arg1.@activeHour;
            arg3.activeHourDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.activeHour = loc1;
            }
            loc1 = arg1.@timeStart;
            arg3.timeStartDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeStart = utils.date.DateUtilCommon.dateFromMySqlFormat(loc1);
            }
            loc1 = arg1.@phaseNumber;
            arg3.phaseNumberDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.phaseNumber = loc1;
            }
            loc1 = arg1.@timeBelowIntensityZones;
            arg3.timeBelowIntensityZonesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeBelowIntensityZones = loc1;
            }
            loc1 = arg1.@timeInIntensityZone1;
            arg3.timeInIntensityZone1Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone1 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone2;
            arg3.timeInIntensityZone2Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone2 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone3;
            arg3.timeInIntensityZone3Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone3 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone4;
            arg3.timeInIntensityZone4Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone4 = loc1;
            }
            loc1 = arg1.@timeAboveIntensityZones;
            arg3.timeAboveIntensityZonesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeAboveIntensityZones = loc1;
            }
            loc1 = arg1.@timeInPowerZone1;
            arg3.timeInPowerZone1Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone1 = loc1;
            }
            loc1 = arg1.@timeInPowerZone2;
            arg3.timeInPowerZone2Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone2 = loc1;
            }
            loc1 = arg1.@timeInPowerZone3;
            arg3.timeInPowerZone3Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone3 = loc1;
            }
            loc1 = arg1.@timeInPowerZone4;
            arg3.timeInPowerZone4Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone4 = loc1;
            }
            loc1 = arg1.@timeInPowerZone5;
            arg3.timeInPowerZone5Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone5 = loc1;
            }
            loc1 = arg1.@timeInPowerZone6;
            arg3.timeInPowerZone6Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone6 = loc1;
            }
            loc1 = arg1.@timeInPowerZone7;
            arg3.timeInPowerZone7Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone7 = loc1;
            }
            loc1 = arg1.@timeBelowTargetZone;
            arg3.timeBelowTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeBelowTargetZone = loc1;
            }
            loc1 = arg1.@timeInTargetZone;
            arg3.timeInTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInTargetZone = loc1;
            }
            loc1 = arg1.@timeAboveTargetZone;
            arg3.timeAboveTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeAboveTargetZone = loc1;
            }
            loc1 = arg1.@pedalingTime;
            arg3.pedalingTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.pedalingTime = loc1;
            }
            return arg3;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("ActivityEntry");
                DB_TABLE_400.addColumns([["activityEntryId", "INTEGER", false, true, true], ["activityId", "INTEGER", false], ["altitude", "NUMERIC", true], ["altitudeDifferencesDownhill", "INTEGER", true], ["altitudeDifferencesUphill", "INTEGER", true], ["cadence", "INTEGER", true], ["calories", "NUMERIC", true], ["distance", "NUMERIC", true], ["distanceAbsolute", "NUMERIC", true], ["distanceDownhill", "NUMERIC", true], ["distanceUphill", "NUMERIC", true], ["heartrate", "NUMERIC", true], ["incline", "NUMERIC", true], ["intensityZone", "INTEGER", true], ["latitude", "NUMERIC", true], ["longitude", "NUMERIC", true], ["percentHRMax", "NUMERIC", true], ["power", "INTEGER", true], ["powerPerKG", "NUMERIC", true], ["relativeRotations", "INTEGER", true], ["riseRate", "NUMERIC", true], ["rotations", "INTEGER", true], ["speed", "NUMERIC", true], ["speedReference", "VARCHAR", true], ["targetZone", "INTEGER", true], ["temperature", "NUMERIC", true], ["trainingTime", "NUMERIC", true], ["trainingTimeAbsolute", "NUMERIC", true], ["trainingTimeDownhill", "NUMERIC", true], ["trainingTimeUphill", "NUMERIC", true], ["workInKJ", "NUMERIC", true], ["zone", "INTEGER", true], ["powerZone", "INTEGER", true], ["motionPoints", "NUMERIC", true], ["stepsLow", "NUMERIC", true], ["stepsMedium", "NUMERIC", true], ["stepsHigh", "NUMERIC", true], ["activTimeLow", "NUMERIC", true], ["activTimeMedium", "NUMERIC", true], ["activTimeHigh", "NUMERIC", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "VARCHAR", true], ["emptyField4", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS ActivityIdOnActivityEntry ON ActivityEntry (activityId)";
            return loc1;
        }

        public static function generateDBColumns(arg1:core.activities.ActivityEntry):Array
        {
            var loc1:*=[];
            loc1.push("activityEntryId");
            loc1.push("activityId");
            if (arg1.altitudeDefined) 
            {
                loc1.push("altitude");
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push("altitudeDifferencesDownhill");
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push("altitudeDifferencesUphill");
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push("cadence");
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push("calories");
            }
            if (arg1.distanceDefined) 
            {
                loc1.push("distance");
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push("distanceAbsolute");
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push("distanceDownhill");
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push("distanceUphill");
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push("heartrate");
            }
            if (arg1.inclineDefined) 
            {
                loc1.push("incline");
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push("intensityZone");
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push("latitude");
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push("longitude");
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push("percentHRMax");
            }
            if (arg1.powerDefined) 
            {
                loc1.push("power");
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push("powerPerKG");
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push("relativeRotations");
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push("riseRate");
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push("rotations");
            }
            if (arg1.speedDefined) 
            {
                loc1.push("speed");
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push("speedReference");
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push("targetZone");
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push("temperature");
            }
            loc1.push("trainingTime");
            loc1.push("trainingTimeAbsolute");
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push("trainingTimeDownhill");
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push("trainingTimeUphill");
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push("workInKJ");
            }
            if (arg1.zoneDefined) 
            {
                loc1.push("zone");
            }
            if (arg1.normalizedPowerDefined) 
            {
                loc1.push("normalizedPower");
            }
            if (arg1.rightBalanceDefined) 
            {
                loc1.push("rightBalance");
            }
            if (arg1.leftBalanceDefined) 
            {
                loc1.push("leftBalance");
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push("powerZone");
            }
            if (arg1.isActiveDefined) 
            {
                loc1.push("motionPoints");
            }
            if (arg1.stepsDefined) 
            {
                loc1.push("stepsLow");
            }
            if (arg1.stepTypeDefined) 
            {
                loc1.push("stepsMedium");
            }
            if (arg1.sleepPhaseDefined) 
            {
                loc1.push("stepsHigh");
            }
            if (arg1.activeHourDefined) 
            {
                loc1.push("activTimeLow");
            }
            if (arg1.timeStartDefined) 
            {
                loc1.push("timeStart");
            }
            if (arg1.phaseNumberDefined) 
            {
                loc1.push("phaseNumber");
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push("timeBelowIntensityZones");
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push("timeInIntensityZone1");
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push("timeInIntensityZone2");
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push("timeInIntensityZone3");
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push("timeInIntensityZone4");
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push("timeAboveIntensityZones");
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push("timeInPowerZone1");
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push("timeInPowerZone2");
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push("timeInPowerZone3");
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push("timeInPowerZone4");
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push("timeInPowerZone5");
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push("timeInPowerZone6");
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push("timeInPowerZone7");
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push("timeBelowTargetZone");
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push("timeInTargetZone");
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push("timeAboveTargetZone");
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push("pedalingTime");
            }
            return loc1;
        }

        public static function generateDBInsertStmtParameter(arg1:core.activities.ActivityEntry, arg2:Object):void
        {
            if (arg1.activityEntryId > 0) 
            {
                arg2[":activityEntryId"] = arg1.activityEntryId;
            }
            else 
            {
                arg2[":activityEntryId"] = null;
            }
            arg2[":activityId"] = arg1.activityId;
            if (arg1.altitudeDefined) 
            {
                arg2[":altitude"] = arg1.altitude;
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg2[":altitudeDifferencesDownhill"] = arg1.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg2[":altitudeDifferencesUphill"] = arg1.altitudeDifferencesUphill;
            }
            if (arg1.cadenceDefined) 
            {
                arg2[":cadence"] = arg1.cadence;
            }
            if (arg1.caloriesDefined) 
            {
                arg2[":calories"] = arg1.calories;
            }
            if (arg1.distanceDefined) 
            {
                arg2[":distance"] = arg1.distance;
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                arg2[":distanceAbsolute"] = arg1.distanceAbsolute;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg2[":distanceDownhill"] = arg1.distanceDownhill;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg2[":distanceUphill"] = arg1.distanceUphill;
            }
            if (arg1.heartrateDefined) 
            {
                arg2[":heartrate"] = arg1.heartrate;
            }
            if (arg1.inclineDefined) 
            {
                arg2[":incline"] = arg1.incline;
            }
            if (arg1.intensityZoneDefined) 
            {
                arg2[":intensityZone"] = arg1.intensityZone;
            }
            if (arg1.latitudeDefined) 
            {
                arg2[":latitude"] = arg1.latitude;
            }
            if (arg1.longitudeDefined) 
            {
                arg2[":longitude"] = arg1.longitude;
            }
            if (arg1.percentHRMaxDefined) 
            {
                arg2[":percentHRMax"] = arg1.percentHRMax;
            }
            if (arg1.powerDefined) 
            {
                arg2[":power"] = arg1.power;
            }
            if (arg1.powerPerKGDefined) 
            {
                arg2[":powerPerKG"] = arg1.powerPerKG;
            }
            if (arg1.relativeRotationsDefined) 
            {
                arg2[":relativeRotations"] = arg1.relativeRotations;
            }
            if (arg1.riseRateDefined) 
            {
                arg2[":riseRate"] = arg1.riseRate;
            }
            if (arg1.rotationsDefined) 
            {
                arg2[":rotations"] = arg1.rotations;
            }
            if (arg1.speedDefined) 
            {
                arg2[":speed"] = arg1.speed;
            }
            if (arg1.speedReferenceDefined) 
            {
                arg2[":speedReference"] = arg1.speedReference;
            }
            if (arg1.targetZoneDefined) 
            {
                arg2[":targetZone"] = arg1.targetZone;
            }
            if (arg1.zoneDefined) 
            {
                arg2[":zone"] = arg1.zone;
            }
            if (arg1.normalizedPowerDefined) 
            {
                arg2[":normalizedPower"] = arg1.normalizedPower;
            }
            if (arg1.rightBalanceDefined) 
            {
                arg2[":rightBalance"] = arg1.rightBalance;
            }
            if (arg1.leftBalanceDefined) 
            {
                arg2[":leftBalance"] = arg1.leftBalance;
            }
            if (arg1.temperatureDefined) 
            {
                arg2[":temperature"] = arg1.temperature;
            }
            arg2[":trainingTime"] = arg1.trainingTime;
            arg2[":trainingTimeAbsolute"] = arg1.trainingTimeAbsolute;
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg2[":trainingTimeDownhill"] = arg1.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg2[":trainingTimeUphill"] = arg1.trainingTimeUphill;
            }
            if (arg1.workInKJDefined) 
            {
                arg2[":workInKJ"] = arg1.workInKJ;
            }
            if (arg1.powerZoneDefined) 
            {
                arg2[":powerZone"] = arg1.powerZone;
            }
            if (arg1.isActiveDefined) 
            {
                arg2[":motionPoints"] = arg1.isActive ? 1 : 0;
            }
            if (arg1.stepsDefined) 
            {
                arg2[":stepsLow"] = arg1.steps;
            }
            if (arg1.stepTypeDefined) 
            {
                arg2[":stepsMedium"] = arg1.stepType;
            }
            if (arg1.sleepPhaseDefined) 
            {
                arg2[":stepsHigh"] = arg1.sleepPhase;
            }
            if (arg1.activeHourDefined) 
            {
                arg2[":activTimeLow"] = arg1.activeHour;
            }
            if (arg1.timeStartDefined) 
            {
                arg2[":timeStart"] = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.timeStart);
            }
            if (arg1.phaseNumberDefined) 
            {
                arg2[":phaseNumber"] = arg1.phaseNumber;
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                arg2[":timeBelowIntensityZones"] = arg1.timeBelowIntensityZones;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg2[":timeInIntensityZone1"] = arg1.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg2[":timeInIntensityZone2"] = arg1.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg2[":timeInIntensityZone3"] = arg1.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg2[":timeInIntensityZone4"] = arg1.timeInIntensityZone4;
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                arg2[":timeAboveIntensityZones"] = arg1.timeAboveIntensityZones;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg2[":timeInPowerZone1"] = arg1.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg2[":timeInPowerZone2"] = arg1.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg2[":timeInPowerZone3"] = arg1.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg2[":timeInPowerZone4"] = arg1.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg2[":timeInPowerZone5"] = arg1.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg2[":timeInPowerZone6"] = arg1.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg2[":timeInPowerZone7"] = arg1.timeInPowerZone7;
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                arg2[":timeBelowTargetZone"] = arg1.timeBelowTargetZone;
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                arg2[":timeInTargetZone"] = arg1.timeInTargetZone;
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                arg2[":timeAboveTargetZone"] = arg1.timeAboveTargetZone;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg2[":pedalingTime"] = arg1.pedalingTime;
            }
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO ActivityEntry (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function generateXML(arg1:core.activities.ActivityEntry):XML
        {
            var loc1:*=new XML("<Entry/>");
            if (arg1.altitudeDefined) 
            {
                var loc2:*;
                loc1.@altitude = loc2 = arg1.altitude;
            }
            undefined;
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.@altitudeDifferencesDownhill = loc2 = arg1.altitudeDifferencesDownhill;
            }
            undefined;
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.@altitudeDifferencesUphill = loc2 = arg1.altitudeDifferencesUphill;
            }
            undefined;
            if (arg1.cadenceDefined) 
            {
                loc1.@cadence = loc2 = arg1.cadence;
            }
            undefined;
            if (arg1.caloriesDefined) 
            {
                loc1.@calories = loc2 = arg1.calories;
            }
            undefined;
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.@distanceAbsolute = loc2 = arg1.distanceAbsolute;
            }
            undefined;
            if (arg1.distanceDefined) 
            {
                loc1.@distance = loc2 = arg1.distance;
            }
            undefined;
            if (arg1.distanceDownhillDefined) 
            {
                loc1.@distanceDownhill = loc2 = arg1.distanceDownhill;
            }
            undefined;
            if (arg1.distanceUphillDefined) 
            {
                loc1.@distanceUphill = loc2 = arg1.distanceUphill;
            }
            undefined;
            if (arg1.heartrateDefined) 
            {
                loc1.@heartrate = loc2 = arg1.heartrate;
            }
            undefined;
            if (arg1.inclineDefined) 
            {
                loc1.@incline = loc2 = arg1.incline;
            }
            undefined;
            if (arg1.intensityZoneDefined) 
            {
                loc1.@intensityZone = loc2 = arg1.intensityZone;
            }
            undefined;
            if (arg1.latitudeDefined) 
            {
                loc1.@latitude = loc2 = arg1.latitude;
            }
            undefined;
            if (arg1.longitudeDefined) 
            {
                loc1.@longitude = loc2 = arg1.longitude;
            }
            undefined;
            if (arg1.percentHRMaxDefined) 
            {
                loc1.@percentHRMax = loc2 = arg1.percentHRMax;
            }
            undefined;
            if (arg1.powerDefined) 
            {
                loc1.@power = loc2 = arg1.power;
            }
            undefined;
            if (arg1.powerPerKGDefined) 
            {
                loc1.@powerPerKG = loc2 = arg1.powerPerKG;
            }
            undefined;
            if (arg1.relativeRotationsDefined) 
            {
                loc1.@relativeRotations = loc2 = arg1.relativeRotations;
            }
            undefined;
            if (arg1.riseRateDefined) 
            {
                loc1.@riseRate = loc2 = arg1.riseRate;
            }
            undefined;
            if (arg1.rotationsDefined) 
            {
                loc1.@rotations = loc2 = arg1.rotations;
            }
            undefined;
            if (arg1.speedDefined) 
            {
                loc1.@speed = loc2 = arg1.speed;
            }
            undefined;
            if (arg1.speedReferenceDefined) 
            {
                loc1.@speedReference = loc2 = arg1.speedReference;
            }
            undefined;
            if (arg1.speedTimeDefined) 
            {
                loc1.@speedTime = loc2 = arg1.speedTime;
            }
            undefined;
            if (arg1.targetZoneDefined) 
            {
                loc1.@targetZone = loc2 = arg1.targetZone;
            }
            undefined;
            if (arg1.temperatureDefined) 
            {
                loc1.@temperature = loc2 = arg1.temperature;
            }
            undefined;
            loc1.@trainingTime = arg1.trainingTime;
            loc1.@trainingTimeAbsolute = arg1.trainingTimeAbsolute;
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.@trainingTimeDownhill = loc2 = arg1.trainingTimeDownhill;
            }
            undefined;
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.@trainingTimeUphill = loc2 = arg1.trainingTimeUphill;
            }
            undefined;
            if (arg1.workInKJDefined) 
            {
                loc1.@workInKJ = loc2 = arg1.workInKJ;
            }
            undefined;
            if (arg1.zoneDefined) 
            {
                loc1.@zone = loc2 = arg1.zone;
            }
            undefined;
            if (arg1.powerZoneDefined) 
            {
                loc1.@powerZone = loc2 = arg1.powerZone;
            }
            undefined;
            if (arg1.stepsDefined) 
            {
                loc1.@steps = loc2 = arg1.steps;
            }
            undefined;
            if (arg1.stepTypeDefined) 
            {
                loc1.@stepType = loc2 = arg1.stepType;
            }
            undefined;
            if (arg1.sleepPhaseDefined) 
            {
                loc1.@sleepPhase = loc2 = arg1.sleepPhase;
            }
            undefined;
            if (arg1.activeHourDefined) 
            {
                loc1.@activeHour = loc2 = arg1.activeHour;
            }
            undefined;
            if (arg1.timeStartDefined) 
            {
                loc1.@timeStart = loc2 = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.timeStart);
            }
            undefined;
            if (arg1.isActiveDefined) 
            {
                loc1.@isActive = loc2 = arg1.isActive ? 1 : 0;
            }
            undefined;
            if (arg1.phaseNumberDefined) 
            {
                loc1.@phaseNumber = loc2 = arg1.phaseNumber;
            }
            undefined;
            if (arg1.normalizedPowerDefined) 
            {
                loc1.@normalizedPower = loc2 = arg1.normalizedPower;
            }
            undefined;
            if (arg1.rightBalanceDefined) 
            {
                loc1.@rightBalance = loc2 = arg1.rightBalance;
            }
            undefined;
            if (arg1.leftBalanceDefined) 
            {
                loc1.@leftBalance = loc2 = arg1.leftBalance;
            }
            undefined;
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.@timeBelowIntensityZones = loc2 = arg1.timeBelowIntensityZones;
            }
            undefined;
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.@timeInIntensityZone1 = loc2 = arg1.timeInIntensityZone1;
            }
            undefined;
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.@timeInIntensityZone2 = loc2 = arg1.timeInIntensityZone2;
            }
            undefined;
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.@timeInIntensityZone3 = loc2 = arg1.timeInIntensityZone3;
            }
            undefined;
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.@timeInIntensityZone4 = loc2 = arg1.timeInIntensityZone4;
            }
            undefined;
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.@timeAboveIntensityZones = loc2 = arg1.timeAboveIntensityZones;
            }
            undefined;
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.@timeInPowerZone1 = loc2 = arg1.timeInPowerZone1;
            }
            undefined;
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.@timeInPowerZone2 = loc2 = arg1.timeInPowerZone2;
            }
            undefined;
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.@timeInPowerZone3 = loc2 = arg1.timeInPowerZone3;
            }
            undefined;
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.@timeInPowerZone4 = loc2 = arg1.timeInPowerZone4;
            }
            undefined;
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.@timeInPowerZone5 = loc2 = arg1.timeInPowerZone5;
            }
            undefined;
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.@timeInPowerZone6 = loc2 = arg1.timeInPowerZone6;
            }
            undefined;
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.@timeInPowerZone7 = loc2 = arg1.timeInPowerZone7;
            }
            undefined;
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.@timeBelowTargetZone = loc2 = arg1.timeBelowTargetZone;
            }
            undefined;
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.@timeInTargetZone = loc2 = arg1.timeInTargetZone;
            }
            undefined;
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.@timeAboveTargetZone = loc2 = arg1.timeAboveTargetZone;
            }
            undefined;
            if (arg1.pedalingTimeDefined) 
            {
                loc1.@pedalingTime = loc2 = arg1.pedalingTime;
            }
            undefined;
            return loc1;
        }

        internal static function fromXML200To210(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*;
            if ((loc1 = arg1.Altitude).length() == 1) 
            {
                arg1.Altitude = loc1[0] * 1000;
            }
            if ((loc1 = arg1.RiseRate).length() == 1) 
            {
                arg1.RiseRate = loc1[0] * 1000;
            }
            if ((loc1 = arg1.AltitudeDifferenceDownhill).length() == 1) 
            {
                arg1.AltitudeDifferenceDownhill = loc1[0] * 1000;
            }
            if ((loc1 = arg1.AltitudeDifferenceUphill).length() == 1) 
            {
                arg1.AltitudeDifferenceUphill = loc1[0] * 1000;
            }
            return fromXML300To330(arg1, arg2, arg3);
        }

        internal static function fromXML300To330(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*=undefined;
            if (arg2 != null) 
            {
                arg3.number = arg2.number + 1;
            }
            else 
            {
                arg3.number = 0;
            }
            loc1 = arg1.Altitude;
            var loc2:*;
            arg3.altitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitude = loc1;
            }
            loc1 = arg1.AltitudeDifferenceDownhill;
            arg3.altitudeDifferencesDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesDownhill = loc1;
            }
            loc1 = arg1.AltitudeDifferenceUphill;
            arg3.altitudeDifferencesUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesUphill = loc1;
            }
            loc1 = arg1.Cadence;
            arg3.cadenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.cadence = loc1;
            }
            loc1 = arg1.Calories;
            arg3.caloriesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.calories = loc1;
            }
            loc1 = arg1.Distance;
            arg3.distanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distance = loc1;
            }
            loc1 = arg1.DistanceAbsolute;
            arg3.distanceAbsoluteDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                if (!(arg2 == null) && arg3.distanceDefined) 
                {
                    arg3.distanceAbsolute = arg3.distance + arg2.distanceAbsolute;
                }
                else if (arg3.distanceDefined) 
                {
                    arg3.distanceAbsolute = arg3.distance;
                }
                else 
                {
                    arg3.distanceAbsolute = loc1;
                }
            }
            if (!(arg1.RideTime == undefined) != true) 
            {
                if (arg1.Time != undefined) 
                {
                    arg3.trainingTime = arg1.Time;
                }
            }
            else 
            {
                arg3.trainingTime = arg1.RideTime;
            }
            if (arg2 == null) 
            {
                arg3.trainingTimeAbsolute = arg3.trainingTime;
            }
            else 
            {
                arg3.trainingTimeAbsolute = arg3.trainingTime + arg2.trainingTimeAbsolute;
            }
            arg3.trainingTime = arg3.trainingTime * 100;
            arg3.trainingTimeAbsolute = arg3.trainingTimeAbsolute * 100;
            loc1 = arg1.DistanceDownhill;
            arg3.distanceDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceDownhill = loc1;
            }
            loc1 = arg1.DistanceUphill;
            arg3.distanceUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceUphill = loc1;
            }
            loc1 = arg1.Heartrate;
            arg3.heartrateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.heartrate = loc1;
            }
            loc1 = arg1.Incline;
            arg3.inclineDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.incline = loc1;
            }
            loc1 = arg1.IntensityZone;
            arg3.intensityZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.intensityZone = loc1;
            }
            loc1 = arg1.Latitude;
            arg3.latitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.latitude = loc1;
            }
            loc1 = arg1.Longitude;
            arg3.longitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.longitude = loc1;
            }
            if (arg1.IsPause == "true") 
            {
                arg3.isPause = true;
            }
            loc1 = arg1.PercentHRMax;
            arg3.percentHRMaxDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.percentHRMax = loc1;
            }
            loc1 = arg1.Power;
            arg3.powerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.power = loc1;
            }
            loc1 = arg1.PowerPerKG;
            arg3.powerPerKGDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerPerKG = loc1;
            }
            loc1 = arg1.RelativeRotations;
            arg3.relativeRotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.relativeRotations = loc1;
            }
            loc1 = arg1.RideTimeDownhill;
            arg3.trainingTimeDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeDownhill = loc1;
                arg3.trainingTimeDownhill = arg3.trainingTimeDownhill * 100;
            }
            loc1 = arg1.RideTimeUphill;
            arg3.trainingTimeUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeUphill = loc1;
                arg3.trainingTimeUphill = arg3.trainingTimeUphill * 100;
            }
            loc1 = arg1.RiseRate;
            arg3.riseRateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.riseRate = loc1;
            }
            loc1 = arg1.Rotations;
            arg3.rotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rotations = loc1;
            }
            loc1 = arg1.Speed;
            arg3.speedDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speed = loc1;
            }
            loc1 = arg1.SpeedReference;
            arg3.speedReferenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedReference = loc1;
            }
            loc1 = arg1.SpeedTime;
            arg3.speedTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 != true) 
            {
                if (arg3.speedDefined) 
                {
                    arg3.speedTime = utils.Calculations.calculateSpeedTime(arg3.speed);
                    arg3.speedTimeDefined = true;
                }
            }
            else 
            {
                arg3.speedTime = loc1;
            }
            loc1 = arg1.TargetZone;
            arg3.targetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.targetZone = loc1;
            }
            loc1 = arg1.Temperature;
            arg3.temperatureDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.temperature = loc1;
            }
            if (arg1.IsWaypoint == "true") 
            {
                arg3.isWaypoint = true;
            }
            loc1 = arg1.WorkInKJ;
            arg3.workInKJDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.workInKJ = loc1;
            }
            loc1 = arg1.Zone;
            arg3.zoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.zone = loc1;
            }
            return arg3;
        }

        public static const col_calories:String="calories";

        public static const col_distance:String="distance";

        public static const col_distanceAbsolute:String="distanceAbsolute";

        public static const col_distanceDownhill:String="distanceDownhill";

        public static const col_distanceUphill:String="distanceUphill";

        public static const col_heartrate:String="heartrate";

        public static const col_incline:String="incline";

        public static const col_intensityZone:String="intensityZone";

        public static const col_isActive:String="motionPoints";

        public static const col_latitude:String="latitude";

        public static const col_leftBalance:String="leftBalance";

        public static const col_longitude:String="longitude";

        public static const col_normalizedPower:String="normalizedPower";

        public static const col_pedalingTime:String="pedalingTime";

        public static const col_percentHRMax:String="percentHRMax";

        public static const col_phaseNumber:String="phaseNumber";

        public static const col_power:String="power";

        public static const col_powerPerKG:String="powerPerKG";

        public static const col_powerZone:String="powerZone";

        public static const col_relativeRotations:String="relativeRotations";

        public static const col_rightBalance:String="rightBalance";

        public static const col_riseRate:String="riseRate";

        public static const col_rotations:String="rotations";

        public static const col_sleepPhase:String="stepsHigh";

        public static const col_speed:String="speed";

        public static const col_speedReference:String="speedReference";

        public static const col_stepType:String="stepsMedium";

        public static const col_altitude:String="altitude";

        public static const col_targetZone:String="targetZone";

        public static const col_temperature:String="temperature";

        public static const col_timeAboveIntensityZones:String="timeAboveIntensityZones";

        public static const col_timeAboveTargetZone:String="timeAboveTargetZone";

        public static const col_timeBelowIntensityZones:String="timeBelowIntensityZones";

        public static const col_timeBelowTargetZone:String="timeBelowTargetZone";

        public static const col_timeInIntensityZone1:String="timeInIntensityZone1";

        public static const col_timeInIntensityZone2:String="timeInIntensityZone2";

        public static const col_timeInIntensityZone3:String="timeInIntensityZone3";

        public static const col_timeInIntensityZone4:String="timeInIntensityZone4";

        public static const col_timeInPowerZone1:String="timeInPowerZone1";

        public static const col_timeInPowerZone2:String="timeInPowerZone2";

        public static const col_timeInPowerZone3:String="timeInPowerZone3";

        public static const col_timeInPowerZone4:String="timeInPowerZone4";

        public static const col_timeInPowerZone5:String="timeInPowerZone5";

        public static const col_timeInPowerZone6:String="timeInPowerZone6";

        public static const col_timeInPowerZone7:String="timeInPowerZone7";

        public static const col_timeInTargetZone:String="timeInTargetZone";

        public static const col_timeStart:String="timeStart";

        public static const col_trainingTimeAbsolute:String="trainingTimeAbsolute";

        public static const col_trainingTimeDownhill:String="trainingTimeDownhill";

        public static const col_trainingTimeUphill:String="trainingTimeUphill";

        public static const col_workInKJ:String="workInKJ";

        public static const col_zone:String="zone";

        public static const field_phaseNumber:String="phaseNumber";

        public static const table_name:String="ActivityEntry";

        public static const col_steps:String="stepsLow";

        public static const col_activTimeHeigh:String="activTimeHigh";

        public static const col_activTimeMedium:String="activTimeMedium";

        public static const col_activeHour:String="activTimeLow";

        public static const col_activityEntryId:String="activityEntryId";

        public static const col_activityId:String="activityId";

        public static const col_altitudeDifferencesDownhill:String="altitudeDifferencesDownhill";

        public static const col_altitudeDifferencesUphill:String="altitudeDifferencesUphill";

        public static const col_cadence:String="cadence";

        public static const col_trainingTime:String="trainingTime";

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;
    }
}


