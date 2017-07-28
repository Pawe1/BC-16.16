//class ActivityRecalculationValues
package core.activities 
{
    import core.general.*;
    import flash.data.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    
    public class ActivityRecalculationValues extends flash.events.EventDispatcher
    {
        public function ActivityRecalculationValues(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            var loc1:*=flash.utils.getQualifiedClassName(this);
            return;
        }

        public static function generateSelectStatement(arg1:Object):String
        {
            var loc1:*=null;
            var loc8:*=null;
            var loc2:*=null;
            var loc3:*="SELECT ";
            var loc4:*;
            (loc4 = []).push("ActivityEntry.activityId as id");
            if (arg1.unitType == core.general.UnitType.ROX100.toString() || arg1.unitType == core.general.UnitType.ROX70.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc1 = "heartrate > 0";
                loc8 = "heartrate >= 0";
            }
            else 
            {
                loc1 = loc8 = "heartrate > 0 AND heartrate != 20";
            }
            loc4.push("MIN(CASE WHEN " + loc8 + " THEN heartrate END) as minimumHeartrate");
            loc4.push("MAX(CASE WHEN " + loc8 + " THEN heartrate END) as maximumHeartrate");
            loc4.push("ROUND(AVG(CASE WHEN " + loc1 + " THEN heartrate END)) as averageHeartrate");
            loc4.push("MIN(CASE WHEN " + loc8 + " THEN percentHRMax END) as minimumPercentHRMax");
            loc4.push("MAX(CASE WHEN " + loc8 + " THEN percentHRMax END) as maximumPercentHRMax");
            loc4.push("ROUND(AVG(CASE WHEN " + loc1 + " THEN percentHRMax END)) as averagePercentHRMax");
            if (arg1.unitType != core.general.UnitType.RC1411.toString()) 
            {
                loc2 = "speed >= 0";
            }
            else 
            {
                loc2 = "speed > 0";
            }
            loc4.push("MIN(CASE WHEN " + loc2 + " THEN speed END) as minimumSpeed");
            loc4.push("MIN(CASE WHEN distanceUphill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as minimumSpeedUphill");
            loc4.push("MIN(CASE WHEN distanceDownhill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as minimumSpeedDownhill");
            loc4.push("MAX(CASE WHEN " + loc2 + " THEN speed END) as maximumSpeed");
            loc4.push("MAX(CASE WHEN distanceUphill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as maximumSpeedUphill");
            loc4.push("MAX(CASE WHEN distanceDownhill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as maximumSpeedDownhill");
            loc4.push("MIN(altitude) as minimumAltitude");
            loc4.push("MAX(altitude) as maximumAltitude");
            loc4.push("AVG(altitude) as averageAltitude");
            loc4.push("MIN(incline) as minimumIncline");
            loc4.push("MIN(CASE WHEN incline > 0 THEN incline ELSE 0 END) as minimumInclineUphill");
            loc4.push("MIN(CASE WHEN incline < 0 THEN incline ELSE 0 END) as minimumInclineDownhill");
            loc4.push("MAX(incline) as maximumIncline");
            loc4.push("MAX(CASE WHEN incline > 0 THEN incline ELSE 0 END) as maximumInclineUphill");
            loc4.push("MAX(CASE WHEN incline < 0 THEN incline ELSE 0 END) as maximumInclineDownhill");
            loc4.push("AVG(incline) as averageIncline");
            loc4.push("(TOTAL(CASE WHEN incline > 0 THEN incline END)/COUNT(CASE WHEN incline > 0 THEN 1 END)) as averageInclineUphill");
            loc4.push("(TOTAL(CASE WHEN incline < 0 THEN incline END)/COUNT(CASE WHEN incline < 0 THEN 1 END)) as averageInclineDownhill");
            loc4.push("MIN(riseRate) as minimumRiseRate");
            loc4.push("MIN(CASE WHEN riseRate > 0 THEN riseRate ELSE 0 END) as minimumRiseRateUphill");
            loc4.push("MIN(CASE WHEN riseRate < 0 THEN riseRate ELSE 0 END) as minimumRiseRateDownhill");
            loc4.push("MAX(riseRate) as maximumRiseRate");
            loc4.push("MAX(CASE WHEN riseRate > 0 THEN riseRate ELSE 0 END) as maximumRiseRateUphill");
            loc4.push("MAX(CASE WHEN riseRate < 0 THEN riseRate ELSE 0 END) as maximumRiseRateDownhill");
            loc4.push("AVG(riseRate) as averageRiseRate");
            loc4.push("AVG(CASE WHEN riseRate > 0 THEN riseRate END) as averageRiseRateUphill");
            loc4.push("AVG(CASE WHEN riseRate < 0 THEN riseRate END) as averageRiseRateDownhill");
            var loc6:*=">= 0";
            var loc7:*=arg1.avgCadInclZero ? ">= 0" : "> 0";
            loc4.push("MIN(CASE WHEN cadence " + loc6 + " THEN cadence END) as minimumCadence");
            loc4.push("MAX(CASE WHEN cadence " + loc6 + " THEN cadence END) as maximumCadence");
            loc4.push("ROUND(AVG(CASE WHEN cadence " + loc7 + " THEN cadence END)) as averageCadence");
            var loc5:*=">= 0";
            var loc10:*=arg1.avgPowerInclZero ? ">= 0" : "> 0";
            loc4.push("MIN(CASE WHEN power " + loc5 + " THEN " + "power" + " END) as minimumPower");
            loc4.push("MAX(CASE WHEN power " + loc5 + " THEN " + "power" + " END) as maximumPower");
            loc4.push("ROUND(AVG(CASE WHEN power " + loc10 + " THEN " + "power" + " END)) as " + "averagePower");
            loc4.push("AVG(CASE WHEN normalizedPower " + loc10 + " THEN " + "normalizedPower" + " END) as " + "powerNP");
            loc4.push("AVG(CASE WHEN powerPerKG " + loc10 + " THEN powerPerKG END) as averagePowerWattPerKG");
            loc4.push("MIN(temperature) as minimumTemperature");
            loc4.push("MAX(temperature) as maximumTemperature");
            loc4.push("AVG(temperature) as averageTemperature");
            loc4.push("ROUND(TOTAL(calories)) as calories");
            loc4.push("ROUND(TOTAL(workInKJ)) as workInKJ");
            loc4.push("TOTAL(distance) as distance");
            var loc9:*="";
            if (arg1.unitType == core.general.UnitType.ROX70.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("(TOTAL(trainingTime) + (SELECT TOTAL(duration) FROM Marker WHERE Marker.activityId = " + arg1.activityId + " AND " + "Marker.timeAbsolute >= " + arg1.startTimeAbsolute + " AND " + "Marker.timeAbsolute <= " + arg1.endTimeAbsolute + ")) as exerciseTime");
                loc9 = "TOTAL(trainingTime) as trainingTime";
                loc4.push(loc9);
            }
            else if (arg1.exerciseTimeDefined) 
            {
                loc4.push("TOTAL(trainingTime) as exerciseTime");
                loc9 = "TOTAL(CASE WHEN speed > 0 THEN trainingTime ELSE 0 END) as trainingTime";
                loc4.push(loc9);
            }
            else 
            {
                loc9 = "TOTAL(trainingTime) as trainingTime";
                loc4.push(loc9);
            }
            loc4.push("TOTAL(pedalingTime) as pedalingTime");
            loc4.push("ROUND(TOTAL(pedalingTime)*100 / TOTAL(trainingTime)) as pedalingIndex");
            if (arg1.unitType == core.general.UnitType.BC2316STS.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(distanceUphill) as distanceUphill");
                loc4.push("TOTAL(distanceDownhill) as distanceDownhill");
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN distanceUphill > 0 THEN distance ELSE 0 END) as distanceUphill");
                loc4.push("TOTAL(CASE WHEN distanceDownhill > 0 THEN distance ELSE 0 END) as distanceDownhill");
            }
            loc4.push("TOTAL(CASE WHEN trainingTimeUphill > 0 THEN trainingTime ELSE 0 END) as trainingTimeUphill");
            loc4.push("TOTAL(CASE WHEN trainingTimeDownhill > 0 THEN trainingTime ELSE 0 END) as trainingTimeDownhill");
            loc4.push("TOTAL(altitudeDifferencesUphill) as altitudeDifferencesUphill");
            loc4.push("TOTAL(altitudeDifferencesDownhill) as altitudeDifferencesDownhill");
            if (arg1.targetZoneDefined) 
            {
                if (arg1.unitType != core.general.UnitType.BC2316STS.toString()) 
                {
                    loc4.push("TOTAL(CASE WHEN targetZone = 0 THEN trainingTime ELSE 0 END) as timeUnderZone");
                    loc4.push("TOTAL(CASE WHEN targetZone = 1 THEN trainingTime ELSE 0 END) as timeInZone");
                    loc4.push("TOTAL(CASE WHEN targetZone = 2 THEN trainingTime ELSE 0 END) as timeOverZone");
                }
                else 
                {
                    loc4.push("TOTAL(timeBelowTargetZone) as timeUnderZone");
                    loc4.push("TOTAL(timeInTargetZone) as timeInZone");
                    loc4.push("TOTAL(timeAboveTargetZone) as timeOverZone");
                }
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN zone = 0 THEN trainingTime ELSE 0 END) as timeUnderZone");
                loc4.push("TOTAL(CASE WHEN zone = 1 THEN trainingTime ELSE 0 END) as timeInZone1");
                loc4.push("TOTAL(CASE WHEN zone = 2 THEN trainingTime ELSE 0 END) as timeInZone2");
                loc4.push("TOTAL(CASE WHEN zone = 3 THEN trainingTime ELSE 0 END) as timeInZone3");
                loc4.push("TOTAL(CASE WHEN zone = 4 THEN trainingTime ELSE 0 END) as timeOverZone");
            }
            if (arg1.intensityZoneStartsDefined && !(arg1.unitType == core.general.UnitType.BC2316STS.toString()) && !(arg1.unitType == core.general.UnitType.ROX110.toString())) 
            {
                loc4.push("TOTAL(CASE WHEN heartrate <= " + arg1["intensityZone1Start"] + " THEN trainingTime ELSE 0 END) as timeUnderIntensityZone");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone1Start"] + " AND heartrate <= " + arg1["intensityZone2Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone1");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone2Start"] + " AND heartrate <= " + arg1["intensityZone3Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone2");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone3Start"] + " AND heartrate <= " + arg1["intensityZone4Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone3");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone4Start"] + " AND heartrate <= " + arg1["intensityZone4End"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone4");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone4End"] + " THEN trainingTime ELSE 0 END) as timeOverIntensityZone");
            }
            else if (arg1.unitType == core.general.UnitType.BC2316STS.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(timeBelowIntensityZones) as timeUnderIntensityZone");
                loc4.push("TOTAL(timeInIntensityZone1) as timeInIntensityZone1");
                loc4.push("TOTAL(timeInIntensityZone2) as timeInIntensityZone2");
                loc4.push("TOTAL(timeInIntensityZone3) as timeInIntensityZone3");
                loc4.push("TOTAL(timeInIntensityZone4) as timeInIntensityZone4");
                loc4.push("TOTAL(timeAboveIntensityZones) as timeOverIntensityZone");
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN intensityZone = 0 THEN trainingTime ELSE 0 END) as timeUnderIntensityZone");
                loc4.push("TOTAL(CASE WHEN intensityZone = 1 THEN trainingTime ELSE 0 END) as timeInIntensityZone1");
                loc4.push("TOTAL(CASE WHEN intensityZone = 2 THEN trainingTime ELSE 0 END) as timeInIntensityZone2");
                loc4.push("TOTAL(CASE WHEN intensityZone = 3 THEN trainingTime ELSE 0 END) as timeInIntensityZone3");
                loc4.push("TOTAL(CASE WHEN intensityZone = 4 THEN trainingTime ELSE 0 END) as timeInIntensityZone4");
                loc4.push("TOTAL(CASE WHEN intensityZone = 5 THEN trainingTime ELSE 0 END) as timeOverIntensityZone");
            }
            if (arg1.unitType != core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(CASE WHEN powerZone = 1 THEN trainingTime ELSE 0 END) as timeInPowerZone1");
                loc4.push("TOTAL(CASE WHEN powerZone = 2 THEN trainingTime ELSE 0 END) as timeInPowerZone2");
                loc4.push("TOTAL(CASE WHEN powerZone = 3 THEN trainingTime ELSE 0 END) as timeInPowerZone3");
                loc4.push("TOTAL(CASE WHEN powerZone = 4 THEN trainingTime ELSE 0 END) as timeInPowerZone4");
                loc4.push("TOTAL(CASE WHEN powerZone = 5 THEN trainingTime ELSE 0 END) as timeInPowerZone5");
                loc4.push("TOTAL(CASE WHEN powerZone = 6 THEN trainingTime ELSE 0 END) as timeInPowerZone6");
                loc4.push("TOTAL(CASE WHEN powerZone = 7 THEN trainingTime ELSE 0 END) as timeInPowerZone7");
            }
            else 
            {
                loc4.push("TOTAL(timeInPowerZone1) as timeInPowerZone1");
                loc4.push("TOTAL(timeInPowerZone2) as timeInPowerZone2");
                loc4.push("TOTAL(timeInPowerZone3) as timeInPowerZone3");
                loc4.push("TOTAL(timeInPowerZone4) as timeInPowerZone4");
                loc4.push("TOTAL(timeInPowerZone5) as timeInPowerZone5");
                loc4.push("TOTAL(timeInPowerZone6) as timeInPowerZone6");
                loc4.push("TOTAL(timeInPowerZone7) as timeInPowerZone7");
            }
            loc4.push("AVG(leftBalance) as averageBalanceLeft");
            loc4.push("AVG(rightBalance) as averageBalanceRight");
            return loc3 = (loc3 = (loc3 = (loc3 = (loc3 = loc3 + loc4.join(", ")) + " FROM ActivityEntry ") + (" WHERE ActivityEntry.activityId = " + arg1.activityId)) + (" AND ActivityEntry.activityEntryId >= " + arg1.selectedStartEntry)) + (" AND ActivityEntry.activityEntryId <= " + arg1.selectedEndEntry);
        }

        public function initialize(arg1:Number):void
        {
            minimumHeartrate = arg1;
            minimumSpeed = arg1;
            minimumSpeedUphill = arg1;
            minimumSpeedDownhill = arg1;
            minimumTemperature = arg1;
            minimumIncline = arg1;
            minimumInclineUphill = arg1;
            minimumInclineDownhill = arg1;
            minimumAltitude = arg1;
            minimumRiseRate = arg1;
            minimumRiseRateUphill = arg1;
            minimumRiseRateDownhill = arg1;
            minimumCadence = arg1;
            minimumPower = arg1;
            minimumPercentHRMax = arg1;
            maximumHeartrate = arg1;
            maximumSpeed = arg1;
            maximumSpeedUphill = arg1;
            maximumSpeedDownhill = arg1;
            maximumTemperature = arg1;
            maximumIncline = arg1;
            maximumInclineUphill = arg1;
            maximumInclineDownhill = arg1;
            maximumAltitude = arg1;
            maximumRiseRate = arg1;
            maximumRiseRateUphill = arg1;
            maximumRiseRateDownhill = arg1;
            maximumCadence = arg1;
            maximumPower = arg1;
            maximumPercentHRMax = arg1;
            averageHeartrate = arg1;
            averageSpeed = arg1;
            averageSpeedUphill = arg1;
            averageSpeedDownhill = arg1;
            averageTemperature = arg1;
            averageInclineUphill = arg1;
            averageInclineDownhill = arg1;
            averageAltitude = arg1;
            averageRiseRate = arg1;
            averageRiseRateUphill = arg1;
            averageRiseRateDownhill = arg1;
            averageCadence = arg1;
            averagePower = arg1;
            averagePercentHRMax = arg1;
            averagePowerWattPerKG = arg1;
            averageExpansion = arg1;
            averageExpansionUphill = arg1;
            calories = arg1;
            workInKJ = arg1;
            distance = arg1;
            pauseTime = arg1;
            trainingTime = arg1;
            exerciseTime = arg1;
            distanceUphill = arg1;
            distanceDownhill = arg1;
            trainingTimeUphill = arg1;
            trainingTimeDownhill = arg1;
            altitudeDifferencesUphill = arg1;
            altitudeDifferencesDownhill = arg1;
            timeUnderZone = arg1;
            timeInZone = arg1;
            timeOverZone = arg1;
            timeInZone1 = arg1;
            timeInZone2 = arg1;
            timeInZone3 = arg1;
            timeUnderIntensityZone = arg1;
            timeInIntensityZone1 = arg1;
            timeInIntensityZone2 = arg1;
            timeInIntensityZone3 = arg1;
            timeInIntensityZone4 = arg1;
            timeOverIntensityZone = arg1;
            timeInPowerZone1 = arg1;
            timeInPowerZone2 = arg1;
            timeInPowerZone3 = arg1;
            timeInPowerZone4 = arg1;
            timeInPowerZone5 = arg1;
            timeInPowerZone6 = arg1;
            timeInPowerZone7 = arg1;
            powerNP = arg1;
            pedalingTime = arg1;
            pedalingIndex = arg1;
            averageBalanceLeft = arg1;
            averageBalanceRight = arg1;
            return;
        }

        public function fromSQLResult(arg1:flash.data.SQLResult):void
        {
            var loc1:*=null;
            var loc2:*=arg1.data;
            if (loc2.length == 1) 
            {
                loc1 = loc2[0] as Object;
                activityId = loc1.id;
                minimumHeartrate = loc1.minimumHeartrate;
                minimumSpeed = loc1.minimumSpeed;
                minimumSpeedUphill = loc1.minimumSpeedUphill;
                minimumSpeedDownhill = loc1.minimumSpeedDownhill;
                minimumTemperature = loc1.minimumTemperature;
                minimumIncline = loc1.minimumIncline;
                minimumInclineUphill = loc1.minimumInclineUphill;
                minimumInclineDownhill = loc1.minimumInclineDownhill;
                minimumAltitude = loc1.minimumAltitude;
                minimumRiseRate = loc1.minimumRiseRate;
                minimumRiseRateUphill = loc1.minimumRiseRateUphill;
                minimumRiseRateDownhill = loc1.minimumRiseRateDownhill;
                minimumCadence = loc1.minimumCadence;
                minimumPower = loc1.minimumPower;
                minimumPercentHRMax = loc1.minimumPercentHRMax;
                maximumHeartrate = loc1.maximumHeartrate;
                maximumSpeed = loc1.maximumSpeed;
                maximumSpeedUphill = loc1.maximumSpeedUphill;
                maximumSpeedDownhill = loc1.maximumSpeedDownhill;
                maximumTemperature = loc1.maximumTemperature;
                maximumIncline = loc1.maximumIncline;
                maximumInclineUphill = loc1.maximumInclineUphill;
                maximumInclineDownhill = loc1.maximumInclineDownhill;
                maximumAltitude = loc1.maximumAltitude;
                maximumRiseRate = loc1.maximumRiseRate;
                maximumRiseRateUphill = loc1.maximumRiseRateUphill;
                maximumRiseRateDownhill = loc1.maximumRiseRateDownhill;
                maximumCadence = loc1.maximumCadence;
                maximumPower = loc1.maximumPower;
                maximumPercentHRMax = loc1.maximumPercentHRMax;
                averageHeartrate = loc1.averageHeartrate;
                averageSpeed = loc1.averageSpeed;
                averageSpeedUphill = loc1.averageSpeedUphill;
                averageSpeedDownhill = loc1.averageSpeedDownhill;
                averageTemperature = loc1.averageTemperature;
                averageInclineUphill = loc1.averageInclineUphill;
                averageInclineDownhill = loc1.averageInclineDownhill;
                averageAltitude = loc1.averageAltitude;
                averageRiseRate = loc1.averageRiseRate;
                averageRiseRateUphill = loc1.averageRiseRateUphill;
                averageRiseRateDownhill = loc1.averageRiseRateDownhill;
                averageCadence = loc1.averageCadence;
                averagePower = loc1.averagePower;
                averagePercentHRMax = loc1.averagePercentHRMax;
                averagePowerWattPerKG = loc1.averagePowerWattPerKG;
                averageExpansion = loc1.averageExpansion;
                averageExpansionUphill = loc1.averageExpansionUphill;
                calories = loc1.calories;
                workInKJ = loc1.workInKJ;
                distance = loc1.distance;
                pauseTime = loc1.pauseTime;
                trainingTime = loc1.trainingTime;
                exerciseTime = loc1.exerciseTime;
                distanceUphill = loc1.distanceUphill;
                distanceDownhill = loc1.distanceDownhill;
                trainingTimeUphill = loc1.trainingTimeUphill;
                trainingTimeDownhill = loc1.trainingTimeDownhill;
                altitudeDifferencesUphill = loc1.altitudeDifferencesUphill;
                altitudeDifferencesDownhill = loc1.altitudeDifferencesDownhill;
                timeUnderZone = loc1.timeUnderZone;
                timeInZone = loc1.timeInZone;
                timeInZone1 = loc1.timeInZone1;
                timeInZone2 = loc1.timeInZone2;
                timeInZone3 = loc1.timeInZone3;
                timeOverZone = loc1.timeOverZone;
                timeUnderIntensityZone = loc1.timeUnderIntensityZone;
                timeInIntensityZone1 = loc1.timeInIntensityZone1;
                timeInIntensityZone2 = loc1.timeInIntensityZone2;
                timeInIntensityZone3 = loc1.timeInIntensityZone3;
                timeInIntensityZone4 = loc1.timeInIntensityZone4;
                timeOverIntensityZone = loc1.timeOverIntensityZone;
                timeInPowerZone1 = loc1.timeInPowerZone1;
                timeInPowerZone2 = loc1.timeInPowerZone2;
                timeInPowerZone3 = loc1.timeInPowerZone3;
                timeInPowerZone4 = loc1.timeInPowerZone4;
                timeInPowerZone5 = loc1.timeInPowerZone5;
                timeInPowerZone6 = loc1.timeInPowerZone6;
                timeInPowerZone7 = loc1.timeInPowerZone7;
                powerNP = loc1["powerNP"];
                averageBalanceLeft = loc1["averageBalanceLeft"];
                averageBalanceRight = loc1["averageBalanceRight"];
                pedalingTime = loc1["pedalingTime"];
                pedalingIndex = loc1["pedalingIndex"];
            }
            return;
        }

        public static const VALUES_CHANGED:String="valuesChangedEvent";

        public var averageBalanceLeft:Number;

        public var averageBalanceRight:Number;

        public var averageCadence:Number;

        public var averageExpansion:Number;

        public var averageExpansionUphill:Number;

        public var averageHeartrate:Number;

        public var averageInclineDownhill:Number;

        public var averageInclineUphill:Number;

        public var averagePercentHRMax:Number;

        public var averagePower:Number;

        public var averagePowerWattPerKG:Number;

        public var averageRiseRate:Number;

        public var averageRiseRateDownhill:Number;

        public var averageRiseRateUphill:Number;

        public var averageSpeed:Number;

        public var averageSpeedDownhill:Number;

        public var averageSpeedUphill:Number;

        public var averageTemperature:Number;

        public var best20minPower:Number=0;

        public var best5KTime:Number=0;

        public var calories:Number;

        public var distance:Number;

        public var distanceDownhill:Number;

        public var distanceUphill:Number;

        public var exerciseTime:Number;

        public var maximumAltitude:Number;

        public var maximumCadence:Number;

        public var maximumHeartrate:Number;

        public var maximumIncline:Number;

        public var maximumInclineDownhill:Number;

        public var maximumInclineUphill:Number;

        public var maximumPercentHRMax:Number;

        public var maximumPower:Number;

        public var maximumRiseRate:Number;

        public var maximumRiseRateDownhill:Number;

        public var maximumRiseRateUphill:Number;

        public var maximumSpeed:Number;

        public var maximumSpeedDownhill:Number;

        public var maximumSpeedUphill:Number;

        public var maximumTemperature:Number;

        public var minimumAltitude:Number;

        public var minimumCadence:Number;

        public var minimumHeartrate:Number;

        public var minimumIncline:Number;

        public var minimumInclineDownhill:Number;

        public var minimumInclineUphill:Number;

        public var minimumPercentHRMax:Number;

        public var minimumPower:Number;

        public var minimumRiseRate:Number;

        public var minimumRiseRateDownhill:Number;

        public var minimumRiseRateUphill:Number;

        public var minimumSpeed:Number;

        public var minimumSpeedDownhill:Number;

        public var minimumSpeedUphill:Number;

        public var minimumTemperature:Number;

        public var pauseTime:Number;

        public var pedalSmoothLeft:Number=0;

        public var pedalSmoothRight:Number=0;

        public var pedalingIndex:Number=0;

        public var pedalingTime:Number=0;

        public var powerIF:Number=0;

        public var powerNP:Number;

        public var powerTSS:Number=0;

        public var timeInIntensityZone1:Number;

        public var timeInIntensityZone2:Number;

        public var timeInIntensityZone3:Number;

        public var timeInIntensityZone4:Number;

        public var activityId:int=0;

        public var timeInPowerZone2:Number;

        public var timeInPowerZone3:Number;

        public var timeInPowerZone4:Number;

        public var timeInPowerZone5:Number;

        public var timeInPowerZone6:Number;

        public var timeInPowerZone7:Number;

        public var timeInZone:Number;

        public var timeInZone1:Number;

        public var timeInZone2:Number;

        public var timeInZone3:Number;

        public var timeOverIntensityZone:Number;

        public var timeInPowerZone1:Number;

        public var timeUnderIntensityZone:Number;

        public var timeUnderZone:Number;

        public var torqueEffectLeft:Number=0;

        public var torqueEffectRight:Number=0;

        public var trainingTime:Number;

        public var trainingTimeDownhill:Number;

        public var trainingTimeUphill:Number;

        public var workInKJ:Number;

        public var altitudeDifferencesDownhill:Number;

        public var altitudeDifferencesUphill:Number;

        public var averageAltitude:Number;

        public var timeOverZone:Number;
    }
}


