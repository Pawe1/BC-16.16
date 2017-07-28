//class ActivityMapper
package core.activities 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.marker.*;
    import core.participant.*;
    import core.user.*;
    import database.*;
    import handler.*;
    import init.*;
    import utils.*;
    import utils.date.*;
    import utils.format.*;
    
    public class ActivityMapper extends Object
    {
        public function ActivityMapper()
        {
            super();
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Activity (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.activities.Activity):String
        {
            return "SELECT activityId FROM Activity WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = DB_TABLE_400;
            }
        }

        internal static function loadMarkers(arg1:XML, arg2:core.activities.Activity, arg3:int):void
        {
            var loc4:*=null;
            var loc3:*=0;
            arg2.markerList.splice(0, arg2.markerList.length);
            if (arg3 != 210) 
            {
                if (arg3 >= 300) 
                {
                    loc4 = arg1.Markers.Marker;
                }
                else 
                {
                    return;
                }
            }
            else 
            {
                loc4 = arg1.Laps.Lap;
            }
            var loc1:*=loc4.length();
            var loc2:*=null;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc2 = core.marker.MarkerMapper.fromXML(loc4[loc3], loc2, arg3, arg2);
                arg2.markerList.push(loc2);
                ++loc3;
            }
            return;
        }

        public static function countActivitiesStatement(arg1:String=""):String
        {
            return "SELECT COUNT(*) AS activities FROM Activity WHERE isDeleted = false" + arg1;
        }

        public static function fromDB(arg1:core.activities.Activity, arg2:Object, arg3:Boolean=false):core.activities.Activity
        {
            arg1.activityId = arg2["activityId"];
            if (arg2["simpleHeaderValuesCalculation"]) 
            {
                arg1.simpleHeaderValuesCalculation = arg2["simpleHeaderValuesCalculation"];
            }
            var loc1:*;
            arg1.ageDefined = loc1 = !(arg2["age"] == null);
            if (loc1 == true) 
            {
                arg1.age = arg2["age"];
            }
            if (arg2["GUID"] != null) 
            {
                arg1.GUID = arg2["GUID"];
            }
            if (arg2["modificationDate"] != null) 
            {
                arg1.modificationDate = arg2["modificationDate"];
            }
            if (arg2["activityStatus"] != null) 
            {
                arg1.activityStatus = arg2["activityStatus"];
            }
            arg1.altitudeDifferencesDownhillDefined = loc1 = !(arg2["altitudeDifferencesDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.altitudeDifferencesDownhill = arg2["altitudeDifferencesDownhill"];
            }
            arg1.altitudeDifferencesUphillDefined = loc1 = !(arg2["altitudeDifferencesUphill"] == null);
            if (loc1 == true) 
            {
                arg1.altitudeDifferencesUphill = arg2["altitudeDifferencesUphill"];
            }
            arg1.averageAltitudeDefined = loc1 = !(arg2["averageAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.averageAltitude = arg2["averageAltitude"];
            }
            arg1.averageCadenceDefined = loc1 = !(arg2["averageCadence"] == null);
            if (loc1 == true) 
            {
                arg1.averageCadence = arg2["averageCadence"];
            }
            arg1.averageExpansionDefined = loc1 = !(arg2["averageExpansion"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansion = arg2["averageExpansion"];
            }
            arg1.averageExpansionDownhillDefined = loc1 = !(arg2["averageExpansionDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansionDownhill = arg2["averageExpansionDownhill"];
            }
            arg1.averageExpansionUphillDefined = loc1 = !(arg2["averageExpansionUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansionUphill = arg2["averageExpansionUphill"];
            }
            arg1.averageHeartrateDefined = loc1 = !(arg2["averageHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.averageHeartrate = arg2["averageHeartrate"];
            }
            arg1.averageInclineDownhillDefined = loc1 = !(arg2["averageInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageInclineDownhill = arg2["averageInclineDownhill"];
            }
            arg1.averageInclineUphillDefined = loc1 = !(arg2["averageInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageInclineUphill = arg2["averageInclineUphill"];
            }
            arg1.averagePercentHRMaxDefined = loc1 = !(arg2["averagePercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.averagePercentHRMax = arg2["averagePercentHRMax"];
            }
            arg1.averagePowerDefined = loc1 = !(arg2["averagePower"] == null);
            if (loc1 == true) 
            {
                arg1.averagePower = arg2["averagePower"];
            }
            arg1.averagePowerKJDefined = loc1 = !(arg2["averagePowerKJ"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerKJ = arg2["averagePowerKJ"];
            }
            arg1.averagePowerWattPerKGDefined = loc1 = !(arg2["averagePowerWattPerKG"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerWattPerKG = arg2["averagePowerWattPerKG"];
            }
            arg1.averageRiseRateDefined = loc1 = !(arg2["averageRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRate = arg2["averageRiseRate"];
            }
            arg1.averageRiseRateUphillDefined = loc1 = !(arg2["averageRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRateUphill = arg2["averageRiseRateUphill"];
            }
            arg1.averageRiseRateDownhillDefined = loc1 = !(arg2["averageRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRateDownhill = arg2["averageRiseRateDownhill"];
            }
            arg1.averageSpeedDefined = loc1 = !(arg2["averageSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeed = arg2["averageSpeed"];
            }
            arg1.averageSpeedDownhillDefined = loc1 = !(arg2["averageSpeedDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeedDownhill = arg2["averageSpeedDownhill"];
            }
            arg1.averageSpeedUphillDefined = loc1 = !(arg2["averageSpeedUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeedUphill = arg2["averageSpeedUphill"];
            }
            arg1.averageTemperatureDefined = loc1 = !(arg2["averageTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.averageTemperature = arg2["averageTemperature"];
            }
            arg1.bike = arg2["bike"] == null ? "noBike" : arg2["bike"];
            arg1.bikeTypeDefined = loc1 = !(arg2["bikeType"] == null);
            if (loc1 == true) 
            {
                arg1.bikeType = arg2["bikeType"];
            }
            arg1.bikeWeightDefined = loc1 = !(arg2["bikeWeight"] == null);
            if (loc1 == true) 
            {
                arg1.bikeWeight = arg2["bikeWeight"];
            }
            arg1.bikeWeightUnitDefined = loc1 = !(arg2["bikeWeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bikeWeightUnit = arg2["bikeWeightUnit"];
            }
            arg1.bodyHeightDefined = loc1 = !(arg2["bodyHeight"] == null);
            if (loc1 == true) 
            {
                arg1.bodyHeight = arg2["bodyHeight"];
            }
            arg1.bodyHeightUnitDefined = loc1 = !(arg2["bodyHeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bodyHeightUnit = arg2["bodyHeightUnit"];
            }
            arg1.bodyWeightDefined = loc1 = !(arg2["bodyWeight"] == null);
            if (loc1 == true) 
            {
                arg1.bodyWeight = arg2["bodyWeight"];
            }
            arg1.bodyWeightUnitDefined = loc1 = !(arg2["bodyWeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bodyWeightUnit = arg2["bodyWeightUnit"];
            }
            arg1.calibrationDefined = loc1 = !(arg2["calibration"] == null);
            if (loc1 == true) 
            {
                arg1.calibration = arg2["calibration"];
            }
            arg1.caloriesDefined = loc1 = !(arg2["calories"] == null);
            if (loc1 == true) 
            {
                arg1.calories = arg2["calories"];
            }
            arg1.caloriesDifferenceFactorDefined = loc1 = !(arg2["caloriesDifferenceFactor"] == null);
            if (loc1 == true) 
            {
                arg1.caloriesDifferenceFactor = arg2["caloriesDifferenceFactor"];
            }
            arg1.correctionChestRunDefined = loc1 = !(arg2["correctionChestRun"] == null);
            if (loc1 == true) 
            {
                arg1.correctionChestRun = arg2["correctionChestRun"];
            }
            arg1.correctionChestWalkDefined = loc1 = !(arg2["correctionChestWalk"] == null);
            if (loc1 == true) 
            {
                arg1.correctionChestWalk = arg2["correctionChestWalk"];
            }
            arg1.correctionFactorDefined = loc1 = !(arg2["correctionFactor"] == null);
            if (loc1 == true) 
            {
                arg1.correctionFactor = arg2["correctionFactor"];
            }
            arg1.correctionHipRunDefined = loc1 = !(arg2["correctionHipRun"] == null);
            if (loc1 == true) 
            {
                arg1.correctionHipRun = arg2["correctionHipRun"];
            }
            arg1.correctionHipWalkDefined = loc1 = !(arg2["correctionHipWalk"] == null);
            if (loc1 == true) 
            {
                arg1.correctionHipWalk = arg2["correctionHipWalk"];
            }
            arg1.dataType = arg2["dataType"];
            arg1.dateCodeDefined = loc1 = !(arg2["dateCode"] == null);
            if (loc1 == true) 
            {
                arg1.dateCode = arg2["dateCode"];
            }
            arg1.descriptionDefined = loc1 = !(arg2["description"] == null);
            if (loc1 == true) 
            {
                arg1.description = arg2["description"];
            }
            arg1.distanceDefined = loc1 = !(arg2["distance"] == null);
            if (loc1 == true) 
            {
                arg1.distance = arg2["distance"];
            }
            arg1.distanceDownhillDefined = loc1 = !(arg2["distanceDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.distanceDownhill = arg2["distanceDownhill"];
            }
            arg1.distanceMinusDefined = loc1 = !(arg2["distanceMinus"] == null);
            if (loc1 == true) 
            {
                arg1.distanceMinus = arg2["distanceMinus"];
            }
            arg1.distancePlusDefined = loc1 = !(arg2["distancePlus"] == null);
            if (loc1 == true) 
            {
                arg1.distancePlus = arg2["distancePlus"];
            }
            arg1.distancePlusMinusStatusDefined = loc1 = !(arg2["distancePlusMinusStatus"] == null);
            if (loc1 == true) 
            {
                arg1.distancePlusMinusStatus = arg2["distancePlusMinusStatus"];
            }
            arg1.distanceUphillDefined = loc1 = !(arg2["distanceUphill"] == null);
            if (loc1 == true) 
            {
                arg1.distanceUphill = arg2["distanceUphill"];
            }
            arg1.exerciseTimeDefined = loc1 = !(arg2["exerciseTime"] == null);
            if (loc1 == true) 
            {
                arg1.exerciseTime = arg2["exerciseTime"];
            }
            arg1.externalLinkDefined = loc1 = !(arg2["externalLink"] == null);
            if (loc1 == true) 
            {
                arg1.externalLink = arg2["externalLink"];
            }
            arg1.fuelEconomyDefined = loc1 = !(arg2["fuelEconomy"] == null);
            if (loc1 == true) 
            {
                arg1.fuelEconomy = arg2["fuelEconomy"];
            }
            arg1.genderDefined = loc1 = !(arg2["gender"] == null);
            if (loc1 == true) 
            {
                arg1.gender = arg2["gender"];
            }
            arg1.hrMaxDefined = loc1 = !(arg2["hrMax"] == null);
            if (loc1 == true) 
            {
                arg1.hrMax = arg2["hrMax"];
            }
            arg1.intensityZone1StartDefined = loc1 = !(arg2["intensityZone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone1Start = arg2["intensityZone1Start"];
            }
            arg1.intensityZone2StartDefined = loc1 = !(arg2["intensityZone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone2Start = arg2["intensityZone2Start"];
            }
            arg1.intensityZone3StartDefined = loc1 = !(arg2["intensityZone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone3Start = arg2["intensityZone3Start"];
            }
            arg1.intensityZone4StartDefined = loc1 = !(arg2["intensityZone4Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone4Start = arg2["intensityZone4Start"];
            }
            arg1.intensityZone4EndDefined = loc1 = !(arg2["intensityZone4End"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone4End = arg2["intensityZone4End"];
            }
            arg1.isDeleted = arg2["isDeleted"];
            arg1.latitudeEndDefined = loc1 = !(arg2["latitudeEnd"] == null);
            if (loc1 == true) 
            {
                arg1.latitudeEnd = arg2["latitudeEnd"];
            }
            arg1.latitudeStartDefined = loc1 = !(arg2["latitudeStart"] == null);
            if (loc1 == true) 
            {
                arg1.latitudeStart = arg2["latitudeStart"];
            }
            arg1.linkedRouteIdDefined = loc1 = !(arg2["linkedRouteId"] == null);
            if (loc1 == true) 
            {
                arg1.linkedRouteId = arg2["linkedRouteId"];
            }
            arg1.linkedTrackGUIDDefined = loc1 = !(arg2["linkedTrackGUID"] == null);
            if (loc1 == true) 
            {
                arg1.linkedTrackGUID = arg2["linkedTrackGUID"];
            }
            arg1.logTypeDefined = loc1 = !(arg2["logType"] == null);
            if (loc1 == true) 
            {
                arg1.logType = core.general.LogType.fromString(arg2["logType"]);
            }
            arg1.logVersionDefined = loc1 = !(arg2["logVersion"] == null);
            if (loc1 == true) 
            {
                arg1.logVersion = arg2["logVersion"];
            }
            arg1.longitudeEndDefined = loc1 = !(arg2["longitudeEnd"] == null);
            if (loc1 == true) 
            {
                arg1.longitudeEnd = arg2["longitudeEnd"];
            }
            arg1.longitudeStartDefined = loc1 = !(arg2["longitudeStart"] == null);
            if (loc1 == true) 
            {
                arg1.longitudeStart = arg2["longitudeStart"];
            }
            arg1.lowerLimitDefined = loc1 = !(arg2["lowerLimit"] == null);
            if (loc1 == true) 
            {
                arg1.lowerLimit = arg2["lowerLimit"];
            }
            arg1.manualTemperatureDefined = loc1 = !(arg2["manualTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.manualTemperature = arg2["manualTemperature"];
            }
            arg1.maximumAltitudeDefined = loc1 = !(arg2["maximumAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.maximumAltitude = arg2["maximumAltitude"];
            }
            arg1.maximumCadenceDefined = loc1 = !(arg2["maximumCadence"] == null);
            if (loc1 == true) 
            {
                arg1.maximumCadence = arg2["maximumCadence"];
            }
            arg1.maximumHeartrateDefined = loc1 = !(arg2["maximumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.maximumHeartrate = arg2["maximumHeartrate"];
            }
            arg1.maximumInclineDefined = loc1 = !(arg2["maximumIncline"] == null);
            if (loc1 == true) 
            {
                arg1.maximumIncline = arg2["maximumIncline"];
            }
            arg1.maximumInclineDownhillDefined = loc1 = !(arg2["maximumInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumInclineDownhill = arg2["maximumInclineDownhill"];
            }
            arg1.maximumInclineUphillDefined = loc1 = !(arg2["maximumInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumInclineUphill = arg2["maximumInclineUphill"];
            }
            arg1.maximumPercentHRMaxDefined = loc1 = !(arg2["maximumPercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.maximumPercentHRMax = arg2["maximumPercentHRMax"];
            }
            arg1.maximumPowerDefined = loc1 = !(arg2["maximumPower"] == null);
            if (loc1 == true) 
            {
                arg1.maximumPower = arg2["maximumPower"];
            }
            arg1.maximumRiseRateDefined = loc1 = !(arg2["maximumRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRate = arg2["maximumRiseRate"];
            }
            arg1.maximumRiseRateDownhillDefined = loc1 = !(arg2["maximumRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRateDownhill = arg2["maximumRiseRateDownhill"];
            }
            arg1.maximumRiseRateUphillDefined = loc1 = !(arg2["maximumRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRateUphill = arg2["maximumRiseRateUphill"];
            }
            arg1.maximumSpeedDefined = loc1 = !(arg2["maximumSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.maximumSpeed = arg2["maximumSpeed"];
            }
            arg1.maximumTemperatureDefined = loc1 = !(arg2["maximumTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.maximumTemperature = arg2["maximumTemperature"];
            }
            arg1.minimumAltitudeDefined = loc1 = !(arg2["minimumAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.minimumAltitude = arg2["minimumAltitude"];
            }
            arg1.minimumCadenceDefined = loc1 = !(arg2["minimumCadence"] == null);
            if (loc1 == true) 
            {
                arg1.minimumCadence = arg2["minimumCadence"];
            }
            arg1.minimumHeartrateDefined = loc1 = !(arg2["minimumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.minimumHeartrate = arg2["minimumHeartrate"];
            }
            arg1.minimumInclineDefined = loc1 = !(arg2["minimumIncline"] == null);
            if (loc1 == true) 
            {
                arg1.minimumIncline = arg2["minimumIncline"];
            }
            arg1.minimumInclineUphillDefined = loc1 = !(arg2["minimumInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumInclineUphill = arg2["minimumInclineUphill"];
            }
            arg1.minimumInclineDownhillDefined = loc1 = !(arg2["minimumInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumInclineDownhill = arg2["minimumInclineDownhill"];
            }
            arg1.minimumPercentHRMaxDefined = loc1 = !(arg2["minimumPercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.minimumPercentHRMax = arg2["minimumPercentHRMax"];
            }
            arg1.minimumPowerDefined = loc1 = !(arg2["minimumPower"] == null);
            if (loc1 == true) 
            {
                arg1.minimumPower = arg2["minimumPower"];
            }
            arg1.minimumRiseRateDefined = loc1 = !(arg2["minimumRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRate = arg2["minimumRiseRate"];
            }
            arg1.minimumRiseRateUphillDefined = loc1 = !(arg2["minimumRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRateUphill = arg2["minimumRiseRateUphill"];
            }
            arg1.minimumRiseRateDownhillDefined = loc1 = !(arg2["minimumRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRateDownhill = arg2["minimumRiseRateDownhill"];
            }
            arg1.minimumSpeedDefined = loc1 = !(arg2["minimumSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.minimumSpeed = arg2["minimumSpeed"];
            }
            arg1.minimumTemperatureDefined = loc1 = !(arg2["minimumTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.minimumTemperature = arg2["minimumTemperature"];
            }
            arg1.name = arg2["name"];
            arg1.pauseTimeDefined = loc1 = !(arg2["pauseTime"] == null);
            if (loc1 == true) 
            {
                arg1.pauseTime = arg2["pauseTime"];
            }
            arg1.percentTimeInIntensityZone1Defined = loc1 = !(arg2["percentTimeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone1 = arg2["percentTimeInIntensityZone1"];
            }
            arg1.percentTimeInIntensityZone2Defined = loc1 = !(arg2["percentTimeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone2 = arg2["percentTimeInIntensityZone2"];
            }
            arg1.percentTimeInIntensityZone3Defined = loc1 = !(arg2["percentTimeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone3 = arg2["percentTimeInIntensityZone3"];
            }
            arg1.percentTimeInIntensityZone4Defined = loc1 = !(arg2["percentTimeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone4 = arg2["percentTimeInIntensityZone4"];
            }
            arg1.powerZone1StartDefined = loc1 = !(arg2["powerZone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone1Start = arg2["powerZone1Start"];
            }
            arg1.powerZone2StartDefined = loc1 = !(arg2["powerZone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone2Start = arg2["powerZone2Start"];
            }
            arg1.powerZone3StartDefined = loc1 = !(arg2["powerZone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone3Start = arg2["powerZone3Start"];
            }
            arg1.powerZone4StartDefined = loc1 = !(arg2["powerZone4Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone4Start = arg2["powerZone4Start"];
            }
            arg1.powerZone5StartDefined = loc1 = !(arg2["powerZone5Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone5Start = arg2["powerZone5Start"];
            }
            arg1.powerZone6StartDefined = loc1 = !(arg2["powerZone6Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone6Start = arg2["powerZone6Start"];
            }
            arg1.powerZone7EndDefined = loc1 = !(arg2["powerZone7End"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone7End = arg2["powerZone7End"];
            }
            arg1.powerZone7StartDefined = loc1 = !(arg2["powerZone7Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone7Start = arg2["powerZone7Start"];
            }
            arg1.ratingDefined = loc1 = !(arg2["rating"] == null);
            if (loc1 == true) 
            {
                arg1.rating = arg2["rating"];
            }
            arg1.feelingDefined = loc1 = !(arg2["feeling"] == null);
            if (loc1 == true) 
            {
                arg1.feeling = arg2["feeling"];
            }
            arg1.trainingTimeDownhillDefined = loc1 = !(arg2["trainingTimeDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTimeDownhill = arg2["trainingTimeDownhill"];
            }
            arg1.trainingTimeUphillDefined = loc1 = !(arg2["trainingTimeUphill"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTimeUphill = arg2["trainingTimeUphill"];
            }
            arg1.rxBatteryStatusDefined = loc1 = !(arg2["rxBatteryStatus"] == null);
            if (loc1 == true) 
            {
                arg1.rxBatteryStatus = arg2["rxBatteryStatus"];
            }
            arg1.samplingRateDefined = loc1 = !(arg2["samplingRate"] == null);
            if (loc1 == true) 
            {
                arg1.samplingRate = arg2["samplingRate"];
            }
            arg1.shoulderWidthDefined = loc1 = !(arg2["shoulderWidth"] == null);
            if (loc1 == true) 
            {
                arg1.shoulderWidth = arg2["shoulderWidth"];
            }
            arg1.shoulderWidthUnitDefined = loc1 = !(arg2["shoulderWidthUnit"] == null);
            if (loc1 == true) 
            {
                arg1.shoulderWidthUnit = arg2["shoulderWidthUnit"];
            }
            arg1.speedUnitDefined = loc1 = !(arg2["measurement"] == null);
            if (loc1 == true) 
            {
                arg1.speedUnit = arg2["measurement"];
            }
            arg1.startDateDefined = loc1 = !(arg2["startDate"] == null);
            if (loc1 == true) 
            {
                arg1.startDate = utils.date.DateUtilCommon.dateFromMySqlFormat(arg2["startDate"]);
            }
            arg1.statisticDefined = loc1 = !(arg2["statistic"] == null);
            if (loc1 == true) 
            {
                arg1.statistic = arg2["statistic"];
            }
            arg1.serialNumberDefined = loc1 = !(arg2["serialNumber"] == null);
            if (loc1 == true) 
            {
                arg1.serialNumber = arg2["serialNumber"];
            }
            arg1.thresholdPowerDefined = loc1 = !(arg2["thresholdPower"] == null);
            if (loc1 == true) 
            {
                arg1.thresholdPower = arg2["thresholdPower"];
            }
            arg1.timeInIntensityZone1Defined = loc1 = !(arg2["timeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone1 = arg2["timeInIntensityZone1"];
            }
            arg1.timeInIntensityZone2Defined = loc1 = !(arg2["timeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone2 = arg2["timeInIntensityZone2"];
            }
            arg1.timeInIntensityZone3Defined = loc1 = !(arg2["timeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone3 = arg2["timeInIntensityZone3"];
            }
            arg1.timeInIntensityZone4Defined = loc1 = !(arg2["timeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone4 = arg2["timeInIntensityZone4"];
            }
            arg1.timeInPowerZone1Defined = loc1 = !(arg2["timeInPowerZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone1 = arg2["timeInPowerZone1"];
            }
            arg1.timeInPowerZone2Defined = loc1 = !(arg2["timeInPowerZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone2 = arg2["timeInPowerZone2"];
            }
            arg1.timeInPowerZone3Defined = loc1 = !(arg2["timeInPowerZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone3 = arg2["timeInPowerZone3"];
            }
            arg1.timeInPowerZone4Defined = loc1 = !(arg2["timeInPowerZone4"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone4 = arg2["timeInPowerZone4"];
            }
            arg1.timeInPowerZone5Defined = loc1 = !(arg2["timeInPowerZone5"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone5 = arg2["timeInPowerZone5"];
            }
            arg1.timeInPowerZone6Defined = loc1 = !(arg2["timeInPowerZone6"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone6 = arg2["timeInPowerZone6"];
            }
            arg1.timeInPowerZone7Defined = loc1 = !(arg2["timeInPowerZone7"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone7 = arg2["timeInPowerZone7"];
            }
            arg1.timeInZoneDefined = loc1 = !(arg2["timeInZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone = arg2["timeInZone"];
            }
            arg1.timeInZone1Defined = loc1 = !(arg2["timeInZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone1 = arg2["timeInZone1"];
            }
            arg1.timeInZone2Defined = loc1 = !(arg2["timeInZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone2 = arg2["timeInZone2"];
            }
            arg1.timeInZone3Defined = loc1 = !(arg2["timeInZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone3 = arg2["timeInZone3"];
            }
            arg1.timeOverIntensityZoneDefined = loc1 = !(arg2["timeOverIntensityZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeOverIntensityZone = arg2["timeOverIntensityZone"];
            }
            arg1.timeOverZoneDefined = loc1 = !(arg2["timeOverZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeOverZone = arg2["timeOverZone"];
            }
            arg1.timeUnderIntensityZoneDefined = loc1 = !(arg2["timeUnderIntensityZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeUnderIntensityZone = arg2["timeUnderIntensityZone"];
            }
            arg1.timeUnderZoneDefined = loc1 = !(arg2["timeUnderZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeUnderZone = arg2["timeUnderZone"];
            }
            arg1.trackProfileDefined = loc1 = !(arg2["trackProfile"] == null);
            if (loc1 == true) 
            {
                arg1.trackProfile = arg2["trackProfile"];
            }
            arg1.trainingTimeDefined = loc1 = !(arg2["trainingTime"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTime = arg2["trainingTime"];
            }
            arg1.trainingTypeDefined = loc1 = !(arg2["trainingType"] == null);
            if (loc1 == true) 
            {
                arg1.trainingType = arg2["trainingType"];
            }
            arg1.trainingZoneDefined = loc1 = !(arg2["trainingZone"] == null);
            if (loc1 == true) 
            {
                arg1.trainingZone = arg2["trainingZone"];
            }
            arg1.tripSectionDistanceDefined = loc1 = !(arg2["tripSectionDistance"] == null);
            if (loc1 == true) 
            {
                arg1.tripSectionDistance = arg2["tripSectionDistance"];
            }
            arg1.tripSectionTimeDefined = loc1 = !(arg2["tripSectionTime"] == null);
            if (loc1 == true) 
            {
                arg1.tripSectionTime = arg2["tripSectionTime"];
            }
            arg1.txBatteryStatusDefined = loc1 = !(arg2["txBatteryStatus"] == null);
            if (loc1 == true) 
            {
                arg1.txBatteryStatus = arg2["txBatteryStatus"];
            }
            arg1.unitDefined = loc1 = !(arg2["unitId"] == null);
            if (loc1 == true) 
            {
                arg1.unitId = arg2["unitId"];
            }
            if (arg2["unitType"] != null) 
            {
                arg1.unitType = core.general.UnitType.fromString(arg2["unitType"]);
            }
            arg1.sportId = arg2["sportId"];
            arg1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg1.sportId);
            init.BackendInitializer.getInstance().getSportHandler().sportsInUseDic[arg1.sportId] = arg1.sport;
            arg1.userId = arg2["userId"];
            arg1.upperLimitDefined = loc1 = !(arg2["upperLimit"] == null);
            if (loc1 == true) 
            {
                arg1.upperLimit = arg2["upperLimit"];
            }
            arg1.weatherDefined = loc1 = !(arg2["weather"] == null);
            if (loc1 == true) 
            {
                arg1.weather = arg2["weather"];
            }
            arg1.wheelSizeDefined = loc1 = !(arg2["wheelSize"] == null);
            if (loc1 == true) 
            {
                arg1.wheelSize = arg2["wheelSize"];
            }
            arg1.windDefined = loc1 = !(arg2["wind"] == null);
            if (loc1 == true) 
            {
                arg1.wind = arg2["wind"];
            }
            arg1.workInKJDefined = loc1 = !(arg2["workInKJ"] == null);
            if (loc1 == true) 
            {
                arg1.workInKJ = arg2["workInKJ"];
            }
            arg1.zone1StartDefined = loc1 = !(arg2["zone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone1Start = arg2["zone1Start"];
            }
            arg1.zone2StartDefined = loc1 = !(arg2["zone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone2Start = arg2["zone2Start"];
            }
            arg1.zone3EndDefined = loc1 = !(arg2["zone3End"] == null);
            if (loc1 == true) 
            {
                arg1.zone3End = arg2["zone3End"];
            }
            arg1.zone3StartDefined = loc1 = !(arg2["zone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone3Start = arg2["zone3Start"];
            }
            arg1.chestbeltManufacturerDefined = loc1 = !(arg2["chestbeltManufacturer"] == null);
            if (loc1 == true) 
            {
                arg1.chestbeltManufacturer = arg2["chestbeltManufacturer"];
            }
            arg1.withDeviceDefined = loc1 = !(arg2["withDevice"] == null);
            if (loc1 == true) 
            {
                arg1.withDevice = arg2["withDevice"];
            }
            arg1.stepsDefined = loc1 = !(arg2["steps"] == null);
            if (loc1 == true) 
            {
                arg1.steps = arg2["steps"];
            }
            arg1.targetDayDefined = loc1 = !(arg2["targetDay"] == null);
            if (loc1 == true) 
            {
                arg1.targetDay = arg2["targetDay"];
            }
            arg1.activeTimeLowDefined = loc1 = !(arg2["activTimeLow"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeLow = arg2["activTimeLow"];
            }
            arg1.activeTimeMiddleDefined = loc1 = !(arg2["activTimeMedium"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeMiddle = arg2["activTimeMedium"];
            }
            arg1.activeTimeHighDefined = loc1 = !(arg2["activTimeHigh"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeHigh = arg2["activTimeHigh"];
            }
            arg1.timeWakeUpDefined = loc1 = !(arg2["stepsLow"] == null);
            if (loc1 == true) 
            {
                arg1.timeWakeUp = arg2["stepsLow"];
            }
            arg1.timeLightSleepDefined = loc1 = !(arg2["stepsMedium"] == null);
            if (loc1 == true) 
            {
                arg1.timeLightSleep = arg2["stepsMedium"];
            }
            arg1.timeDeepSleepDefined = loc1 = !(arg2["stepsHigh"] == null);
            if (loc1 == true) 
            {
                arg1.timeDeepSleep = arg2["stepsHigh"];
            }
            arg1.timeSleepDefined = loc1 = !(arg2["timeSleep"] == null);
            if (loc1 == true) 
            {
                arg1.timeSleep = arg2["timeSleep"];
            }
            arg1.best5KTimeDefined = loc1 = !(arg2["best5KTime"] == null);
            if (loc1 == true) 
            {
                arg1.best5KTime = arg2["best5KTime"];
            }
            arg1.best5KEntryDefined = loc1 = !(arg2["best5KEntry"] == null);
            if (loc1 == true) 
            {
                arg1.best5KEntry = arg2["best5KEntry"];
            }
            decodeSharingInformations(arg2["sharingInformations"], arg1);
            arg1.best20minPowerDefined = loc1 = !(arg2["best20minPower"] == null);
            if (loc1 == true) 
            {
                arg1.best20minPower = arg2["best20minPower"];
            }
            arg1.best20minPowerEntryDefined = loc1 = !(arg2["best20minPowerEntry"] == null);
            if (loc1 == true) 
            {
                arg1.best20minPowerEntry = arg2["best20minPowerEntry"];
            }
            arg1.powerNPDefined = loc1 = !(arg2["powerNP"] == null);
            if (loc1 == true) 
            {
                arg1.powerNP = arg2["powerNP"];
            }
            arg1.powerTSSDefined = loc1 = !(arg2["powerTSS"] == null);
            if (loc1 == true) 
            {
                arg1.powerTSS = arg2["powerTSS"];
            }
            arg1.powerFTPDefined = loc1 = !(arg2["powerFTP"] == null);
            if (loc1 == true) 
            {
                arg1.powerFTP = arg2["powerFTP"];
            }
            arg1.pedalingTimeDefined = loc1 = !(arg2["pedalingTime"] == null);
            if (loc1 == true) 
            {
                arg1.pedalingTime = arg2["pedalingTime"];
            }
            arg1.pedalingIndexDefined = loc1 = !(arg2["pedalingIndex"] == null);
            if (loc1 == true) 
            {
                arg1.pedalingIndex = arg2["pedalingIndex"];
            }
            arg1.maximumExpansionDefined = loc1 = !(arg2["maximumExpansion"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansion = arg2["maximumExpansion"];
            }
            arg1.maximumExpansionUphillDefined = loc1 = !(arg2["maximumExpansionUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansionUphill = arg2["maximumExpansionUphill"];
            }
            arg1.maximumExpansionDownhillDefined = loc1 = !(arg2["maximumExpansionDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansionDownhill = arg2["maximumExpansionDownhill"];
            }
            arg1.averageBalanceRightDefined = loc1 = !(arg2["averageBalanceRight"] == null);
            if (loc1 == true) 
            {
                arg1.averageBalanceRight = arg2["averageBalanceRight"];
            }
            arg1.averageBalanceLeftDefined = loc1 = !(arg2["averageBalanceLeft"] == null);
            if (loc1 == true) 
            {
                arg1.averageBalanceLeft = arg2["averageBalanceLeft"];
            }
            arg1.powerIFDefined = loc1 = !(arg2["powerIF"] == null);
            if (loc1 == true) 
            {
                arg1.powerIF = arg2["powerIF"];
            }
            arg1.torqueEffectLeftDefined = loc1 = !(arg2["torqueEffectLeft"] == null);
            if (loc1 == true) 
            {
                arg1.torqueEffectLeft = arg2["torqueEffectLeft"];
            }
            arg1.torqueEffectRightDefined = loc1 = !(arg2["torqueEffectRight"] == null);
            if (loc1 == true) 
            {
                arg1.torqueEffectRight = arg2["torqueEffectRight"];
            }
            arg1.pedalSmoothLeftDefined = loc1 = !(arg2["pedalSmoothLeft"] == null);
            if (loc1 == true) 
            {
                arg1.pedalSmoothLeft = arg2["pedalSmoothLeft"];
            }
            arg1.pedalSmoothRightDefined = loc1 = !(arg2["pedalSmoothRight"] == null);
            if (loc1 == true) 
            {
                arg1.pedalSmoothRight = arg2["pedalSmoothRight"];
            }
            arg1.averageCadenceCalcDefined = loc1 = !(arg2["averageCadenceCalc"] == null);
            if (loc1 == true) 
            {
                arg1.averageCadenceCalc = arg2["averageCadenceCalc"];
            }
            arg1.averagePowerCalcDefined = loc1 = !(arg2["averagePowerCalc"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerCalc = arg2["averagePowerCalc"];
            }
            return arg1;
        }

        public static function fromRecalculationValues(arg1:core.activities.Activity, arg2:core.activities.ActivityRecalculationValues):core.activities.Activity
        {
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg1.altitudeDifferencesDownhill = arg2.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg1.altitudeDifferencesUphill = arg2.altitudeDifferencesUphill;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg1.averageAltitude = arg2.averageAltitude;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg1.averageCadence = arg2.averageCadence;
            }
            if (arg1.averageExpansionDefined) 
            {
                arg1.averageExpansion = arg2.averageExpansion;
            }
            if (arg1.averageExpansionUphillDefined) 
            {
                arg1.averageExpansionUphill = arg2.averageExpansionUphill;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg1.averageHeartrate = arg2.averageHeartrate;
            }
            if (arg1.averageInclineDownhillDefined) 
            {
                arg1.averageInclineDownhill = arg2.averageInclineDownhill;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg1.averageInclineUphill = arg2.averageInclineUphill;
            }
            if (arg1.averagePercentHRMaxDefined) 
            {
                arg1.averagePercentHRMax = arg2.averagePercentHRMax;
            }
            if (arg1.averagePowerDefined) 
            {
                arg1.averagePower = arg2.averagePower;
            }
            if (arg1.averagePowerWattPerKGDefined) 
            {
                arg1.averagePowerWattPerKG = arg2.averagePowerWattPerKG;
            }
            if (arg1.averageRiseRateDefined) 
            {
                arg1.averageRiseRate = arg2.averageRiseRate;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg1.averageRiseRateUphill = arg2.averageRiseRateUphill;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg1.averageRiseRateDownhill = arg2.averageRiseRateDownhill;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg1.averageSpeed = arg2.averageSpeed;
            }
            if (arg1.averageSpeedDownhillDefined) 
            {
                arg1.averageSpeedDownhill = arg2.averageSpeedDownhill;
            }
            if (arg1.averageSpeedUphillDefined) 
            {
                arg1.averageSpeedUphill = arg2.averageSpeedUphill;
            }
            if (arg1.averageTemperatureDefined) 
            {
                arg1.averageTemperature = arg2.averageTemperature;
            }
            if (arg1.caloriesDefined) 
            {
                arg1.calories = arg2.calories;
            }
            if (arg1.distanceDefined) 
            {
                arg1.distance = arg2.distance;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg1.distanceDownhill = arg2.distanceDownhill;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg1.distanceUphill = arg2.distanceUphill;
            }
            if (arg1.exerciseTimeDefined) 
            {
                arg1.exerciseTime = arg2.exerciseTime;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg1.maximumAltitude = arg2.maximumAltitude;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg1.maximumCadence = arg2.maximumCadence;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg1.maximumHeartrate = arg2.maximumHeartrate;
            }
            if (arg1.maximumInclineDefined) 
            {
                arg1.maximumIncline = arg2.maximumIncline;
            }
            if (arg1.maximumInclineDownhillDefined) 
            {
                arg1.maximumInclineDownhill = arg2.maximumInclineDownhill;
            }
            if (arg1.maximumInclineUphillDefined) 
            {
                arg1.maximumInclineUphill = arg2.maximumInclineUphill;
            }
            if (arg1.maximumPercentHRMaxDefined) 
            {
                arg1.maximumPercentHRMax = arg2.maximumPercentHRMax;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg1.maximumPower = arg2.maximumPower;
            }
            if (arg1.maximumRiseRateDefined) 
            {
                arg1.maximumRiseRate = arg2.maximumRiseRate;
            }
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                arg1.maximumRiseRateDownhill = arg2.maximumRiseRateDownhill;
            }
            if (arg1.maximumRiseRateUphillDefined) 
            {
                arg1.maximumRiseRateUphill = arg2.maximumRiseRateUphill;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg1.maximumSpeed = arg2.maximumSpeed;
            }
            if (arg1.maximumTemperatureDefined) 
            {
                arg1.maximumTemperature = arg2.maximumTemperature;
            }
            if (arg1.minimumAltitudeDefined) 
            {
                arg1.minimumAltitude = arg2.minimumAltitude;
            }
            if (arg1.minimumCadenceDefined) 
            {
                arg1.minimumCadence = arg2.minimumCadence;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg1.minimumHeartrate = arg2.minimumHeartrate;
            }
            if (arg1.minimumInclineDefined) 
            {
                arg1.minimumIncline = arg2.minimumIncline;
            }
            if (arg1.minimumInclineUphillDefined) 
            {
                arg1.minimumInclineUphill = arg2.minimumInclineUphill;
            }
            if (arg1.minimumInclineDownhillDefined) 
            {
                arg1.minimumInclineDownhill = arg2.minimumInclineDownhill;
            }
            if (arg1.minimumPercentHRMaxDefined) 
            {
                arg1.minimumPercentHRMax = arg2.minimumPercentHRMax;
            }
            if (arg1.minimumPowerDefined) 
            {
                arg1.minimumPower = arg2.minimumPower;
            }
            if (arg1.minimumRiseRateDefined) 
            {
                arg1.minimumRiseRate = arg2.minimumRiseRate;
            }
            if (arg1.minimumRiseRateUphillDefined) 
            {
                arg1.minimumRiseRateUphill = arg2.minimumRiseRateUphill;
            }
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                arg1.minimumRiseRateDownhill = arg2.minimumRiseRateDownhill;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg1.minimumSpeed = arg2.minimumSpeed;
            }
            if (arg1.minimumTemperatureDefined) 
            {
                arg1.minimumTemperature = arg2.minimumTemperature;
            }
            if (arg1.pauseTimeDefined) 
            {
                arg1.pauseTime = arg2.pauseTime;
            }
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg1.trainingTimeDownhill = arg2.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg1.trainingTimeUphill = arg2.trainingTimeUphill;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg1.timeInIntensityZone1 = arg2.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg1.timeInIntensityZone2 = arg2.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg1.timeInIntensityZone3 = arg2.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg1.timeInIntensityZone4 = arg2.timeInIntensityZone4;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg1.timeInPowerZone1 = arg2.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg1.timeInPowerZone2 = arg2.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg1.timeInPowerZone3 = arg2.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg1.timeInPowerZone4 = arg2.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg1.timeInPowerZone5 = arg2.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg1.timeInPowerZone6 = arg2.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg1.timeInPowerZone7 = arg2.timeInPowerZone7;
            }
            if (arg1.timeInZoneDefined) 
            {
                arg1.timeInZone = arg2.timeInZone;
            }
            if (arg1.timeInZone1Defined) 
            {
                arg1.timeInZone1 = arg2.timeInZone1;
            }
            if (arg1.timeInZone2Defined) 
            {
                arg1.timeInZone2 = arg2.timeInZone2;
            }
            if (arg1.timeInZone3Defined) 
            {
                arg1.timeInZone3 = arg2.timeInZone3;
            }
            if (arg1.timeOverIntensityZoneDefined) 
            {
                arg1.timeOverIntensityZone = arg2.timeOverIntensityZone;
            }
            if (arg1.timeOverZoneDefined) 
            {
                arg1.timeOverZone = arg2.timeOverZone;
            }
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                arg1.timeUnderIntensityZone = arg2.timeUnderIntensityZone;
            }
            if (arg1.timeUnderZoneDefined) 
            {
                arg1.timeUnderZone = arg2.timeUnderZone;
            }
            if (arg1.trainingTimeDefined) 
            {
                arg1.trainingTime = arg2.trainingTime;
            }
            if (arg1.workInKJDefined) 
            {
                arg1.workInKJ = arg2.workInKJ;
            }
            if (arg1.best5KTimeDefined) 
            {
                arg1.best5KTime = arg2.best5KTime;
            }
            if (arg1.best20minPowerDefined) 
            {
                arg1.best20minPower = arg2.best20minPower;
            }
            if (arg1.powerNPDefined) 
            {
                arg1.powerNP = arg2.powerNP;
            }
            if (arg1.powerTSSDefined) 
            {
                arg1.powerTSS = arg2.powerTSS;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg1.pedalingTime = arg2.pedalingTime;
            }
            if (arg1.pedalingIndexDefined) 
            {
                arg1.pedalingIndex = arg2.pedalingIndex;
            }
            if (arg1.averageBalanceRightDefined) 
            {
                arg1.averageBalanceRight = arg2.averageBalanceRight;
            }
            if (arg1.averageBalanceLeftDefined) 
            {
                arg1.averageBalanceLeft = arg2.averageBalanceLeft;
            }
            if (arg1.powerIFDefined) 
            {
                arg1.powerIF = arg2.powerIF;
            }
            if (arg1.torqueEffectLeftDefined) 
            {
                arg1.torqueEffectLeft = arg2.torqueEffectLeft;
            }
            if (arg1.torqueEffectRightDefined) 
            {
                arg1.torqueEffectRight = arg2.torqueEffectRight;
            }
            if (arg1.pedalSmoothLeftDefined) 
            {
                arg1.pedalSmoothLeft = arg2.pedalSmoothLeft;
            }
            if (arg1.pedalSmoothRightDefined) 
            {
                arg1.pedalSmoothRight = arg2.pedalSmoothRight;
            }
            return arg1;
        }

        public static function retrieveUnitTypeFromXML(arg1:XML):core.general.UnitType
        {
            var loc1:*=2147483647;
            if (arg1.GeneralInformation.@unit != undefined) 
            {
                return core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            }
            if (arg1.Computer.@unit != undefined) 
            {
                return core.general.UnitType.fromString(arg1.Computer.@unit);
            }
            if (arg1.Log.Information == undefined) 
            {
                return core.general.UnitType.ROX80;
            }
            return null;
        }

        public static function fromXML(arg1:XML, arg2:core.activities.Activity, arg3:Boolean):core.activities.Activity
        {
            var loc1:*=null;
            var loc3:*=undefined;
            arg1.normalize();
            arg2.modificationDate = new Date().time;
            var loc4:*=2147483647;
            if (arg1.@revision == undefined) 
            {
                if (arg1.name().toString() == "Trip") 
                {
                    arg2.logVersionDefined = true;
                    arg2.logVersion = "100";
                    return arg2;
                }
            }
            else 
            {
                loc4 = parseInt(arg1.@revision);
                arg2.logVersionDefined = true;
            }
            if (arg1.LogEintraege != undefined) 
            {
                arg2.logVersionDefined = true;
                arg2.logVersion = "100";
                return arg2;
            }
            if (loc4 < 400) 
            {
                arg2.serialNumber = arg1.GeneralInformation.@serialNumber;
                arg2.serialNumberDefined = true;
                arg2.unitType = core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
                arg2.unitDefined = true;
                arg2.startDate = new Date(arg1.GeneralInformation.StartDate.text().toString());
                arg2.startDateDefined = true;
                arg2.name = arg1.GeneralInformation.Name;
                arg2.dateCode = arg1.GeneralInformation.DateCode;
                arg2.dateCodeDefined = true;
                arg2.samplingRate = arg1.GeneralInformation.SamplingRate;
                arg2.samplingRateDefined = true;
                arg2.description = arg1.MetaInformation.Notes;
                arg2.descriptionDefined = true;
                arg2.rating = arg1.MetaInformation.Rating;
                arg2.ratingDefined = true;
                arg2.feelingDefined = true;
                arg2.weather = arg1.MetaInformation.Weather;
                arg2.weatherDefined = true;
                arg2.wind = arg1.MetaInformation.Wind;
                arg2.windDefined = true;
                arg2.trainingType = arg1.MetaInformation.TrainingType;
                arg2.trainingTypeDefined = true;
                arg2.trackProfile = arg1.MetaInformation.Profile;
                arg2.trackProfileDefined = true;
                arg2.dataType = retrieveDataTypeFromXMLRootNode(arg1);
                loc1 = arg1.LogValues;
                if (arg2.dataType != "memory") 
                {
                    if (arg2.dataType == "log") 
                    {
                        arg2.logTypeDefined = true;
                        arg2.pauseTimeDefined = true;
                        arg2.pauseTime = loc1.PauseTime;
                        arg2.pauseTime = arg2.pauseTime * 100;
                    }
                }
                else 
                {
                    loc1 = arg1.MemoryValues;
                    arg2.logTypeDefined = false;
                }
                if (200 == loc4 || 210 == loc4) 
                {
                    if (loc1.Time == undefined) 
                    {
                        arg2.trainingTime = loc1.TrainingTime;
                    }
                    else 
                    {
                        arg2.trainingTime = loc1.Time;
                    }
                }
                else if (300 != loc4) 
                {
                    if (310 <= loc4 && loc4 < 400) 
                    {
                        if (arg2.dataType == "log") 
                        {
                            arg2.logType = core.general.LogType.fromString(arg1.GeneralInformation.@logType);
                            arg2.logTypeDefined = !(arg2.logType == null);
                        }
                        arg2.trainingTime = loc1.TrainingTime;
                    }
                }
                else 
                {
                    arg2.trainingTime = loc1.TrainingTime;
                }
                arg2.trainingTimeDefined = true;
                arg2.trainingTime = arg2.trainingTime * 100;
                if (loc4 < 210) 
                {
                    arg2.manualTemperature = arg1.GeneralInformation.Temperature;
                    arg2.manualTemperatureDefined = true;
                }
                else if (loc4 >= 210) 
                {
                    arg2.manualTemperature = arg1.MetaInformation.Temperature;
                    arg2.manualTemperatureDefined = true;
                    arg2.externalLink = arg1.MetaInformation.ExternalLink;
                    arg2.externalLinkDefined = true;
                }
                arg2.statisticDefined = !(arg1.MetaInformation.Statistic == undefined);
                if (arg2.statisticDefined) 
                {
                    if (arg1.MetaInformation.Statistic != "true") 
                    {
                        arg2.statistic = false;
                    }
                    else 
                    {
                        arg2.statistic = true;
                    }
                }
                loc3 = loc1.TripSectionDistance;
                var loc5:*;
                arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.tripSectionDistance = loc3;
                }
                loc3 = loc1.TripSectionTime;
                arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.tripSectionTime = loc3 * 100;
                }
                loc3 = loc1.FuelEconomy;
                arg2.fuelEconomyDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.fuelEconomy = loc3;
                }
                var loc7:*=0;
                var loc6:*=arg1.MetaInformation.Participant.Person;
                for each (var loc2:* in loc6) 
                {
                    arg2.participant.push(core.participant.Person.createFromXML(loc2));
                }
                if (undefined == arg1.GeneralInformation.Age) 
                {
                    if (loc1.Age != undefined) 
                    {
                        arg2.ageDefined = true;
                        arg2.age = loc1.Age;
                    }
                }
                else 
                {
                    arg2.ageDefined = true;
                    arg2.age = arg1.GeneralInformation.Age;
                }
                loc3 = loc1.AverageCadence;
                arg2.averageCadenceDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageCadence = loc3;
                }
                loc3 = loc1.AverageExpansion;
                arg2.averageExpansionDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageExpansion = loc3;
                }
                loc3 = loc1.AverageExpansionDownhill;
                arg2.averageExpansionDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageExpansionDownhill = loc3;
                }
                loc3 = loc1.AverageExpansionUphill;
                arg2.averageExpansionUphillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageExpansionUphill = loc3;
                }
                loc3 = loc1.AverageHeartrate;
                arg2.averageHeartrateDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageHeartrate = loc3;
                }
                loc3 = loc1.AverageInclineDownhill;
                arg2.averageInclineDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageInclineDownhill = loc3;
                }
                loc3 = loc1.AverageInclineUphill;
                arg2.averageInclineUphillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageInclineUphill = loc3;
                }
                loc3 = loc1.AveragePercentHRMax;
                arg2.averagePercentHRMaxDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averagePercentHRMax = loc3;
                }
                loc3 = loc1.AveragePower;
                arg2.averagePowerDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averagePower = loc3;
                }
                loc3 = loc1.AvgPowerWattPerKG;
                arg2.averagePowerWattPerKGDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averagePowerWattPerKG = loc3;
                }
                loc3 = loc1.AverageSpeed;
                arg2.averageSpeedDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageSpeed = loc3;
                }
                loc3 = loc1.AverageSpeedUphill;
                arg2.averageSpeedUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageSpeedUphill = loc3;
                }
                loc3 = loc1.AverageSpeedDownhill;
                arg2.averageSpeedDownhillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageSpeedDownhill = loc3;
                }
                loc3 = loc1.AverageTemperature;
                arg2.averageTemperatureDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageTemperature = loc3;
                }
                loc3 = arg1.GeneralInformation.Bike;
                arg2.bike = loc3 == undefined ? "noBike" : loc3;
                loc3 = loc1.BikeType1;
                arg2.bikeTypeDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.bikeType = loc3;
                }
                if (undefined == arg1.GeneralInformation.BodyWeight) 
                {
                    if (loc1.Weight == undefined) 
                    {
                        arg2.bodyWeightDefined = false;
                    }
                    else 
                    {
                        arg2.bodyWeightDefined = true;
                        arg2.bodyWeight = loc1.Weight;
                    }
                }
                else 
                {
                    arg2.bodyWeightDefined = true;
                    arg2.bodyWeight = arg1.GeneralInformation.BodyWeight;
                }
                if (undefined == arg1.GeneralInformation.BodyWeightUnit) 
                {
                    if (loc1.BodyWeightUnit == undefined) 
                    {
                        arg2.bodyWeightUnitDefined = false;
                    }
                    else 
                    {
                        arg2.bodyWeightUnitDefined = true;
                        arg2.bodyWeightUnit = loc1.BodyWeightUnit;
                    }
                }
                else 
                {
                    arg2.bodyWeightUnitDefined = true;
                    arg2.bodyWeightUnit = arg1.GeneralInformation.BodyWeightUnit;
                }
                arg2.calibrationDefined = !(loc1.Calibration == undefined);
                arg2.calibration = loc1.Calibration != "true" ? false : true;
                loc3 = loc1.Calories;
                arg2.caloriesDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.calories = loc3;
                }
                loc3 = loc1.CaloriesDifferenceFactor;
                arg2.caloriesDifferenceFactorDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.caloriesDifferenceFactor = loc3;
                }
                loc3 = loc1.CorrectionChestRun;
                arg2.correctionChestRunDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.correctionChestRun = loc3;
                    arg2.correctionChestWalk = loc1.CorrectionChestWalk;
                    arg2.correctionHipRun = loc1.CorrectionHipRun;
                    arg2.correctionHipWalk = loc1.CorrectionHipWalk;
                }
                arg2.correctionChestWalkDefined = arg2.correctionChestRunDefined;
                arg2.correctionHipRunDefined = arg2.correctionChestRunDefined;
                arg2.correctionHipWalkDefined = arg2.correctionChestRunDefined;
                loc3 = loc1.CorrectionFactor;
                arg2.correctionFactorDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.correctionFactor = loc3;
                }
                loc3 = loc1.Distance;
                arg2.distanceDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.distance = loc3;
                }
                loc3 = loc1.DistancePlus;
                arg2.distancePlusDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.distancePlus = loc3;
                }
                loc3 = loc1.DistanceMinus;
                arg2.distanceMinusDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.distanceMinus = loc3;
                }
                loc3 = loc1.DistanceDownhill;
                arg2.distanceDownhillDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.distanceDownhill = loc3;
                }
                loc3 = loc1.DistanceUphill;
                arg2.distanceUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.distanceUphill = loc3;
                }
                loc3 = arg1.GeneralInformation.ExerciseTime;
                arg2.exerciseTimeDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.exerciseTime = loc3;
                    arg2.exerciseTime = arg2.exerciseTime * 100;
                }
                if (undefined == arg1.GeneralInformation.Gender) 
                {
                    if (loc1.Gender == undefined) 
                    {
                        arg2.genderDefined = false;
                    }
                    else 
                    {
                        arg2.genderDefined = true;
                        arg2.gender = loc1.Gender;
                    }
                }
                else 
                {
                    arg2.genderDefined = true;
                    arg2.gender = arg1.GeneralInformation.Gender;
                }
                loc3 = loc1.HrMax;
                arg2.hrMaxDefined = loc7 = !(loc3 == undefined);
                if (loc7 != true) 
                {
                    loc3 = arg1.GeneralInformation.HRMax;
                    arg2.hrMaxDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.hrMax = loc3;
                    }
                }
                else 
                {
                    arg2.hrMax = loc3;
                }
                loc3 = loc1.IntensityZone1Start;
                arg2.intensityZone1StartDefined = loc5 = !(loc3 == undefined);
                if (loc5 != true) 
                {
                    if (arg2.hrMaxDefined) 
                    {
                        arg2.intensityZone1Start = Math.round(arg2.hrMax * 0.6);
                        arg2.intensityZone2Start = Math.round(arg2.hrMax * 0.7);
                        arg2.intensityZone3Start = Math.round(arg2.hrMax * 0.8);
                        arg2.intensityZone4Start = Math.round(arg2.hrMax * 0.9);
                    }
                }
                else 
                {
                    arg2.intensityZone1Start = loc3;
                    arg2.intensityZone2Start = loc1.IntensityZone2Start;
                    arg2.intensityZone3Start = loc1.IntensityZone3Start;
                    arg2.intensityZone4Start = loc1.IntensityZone4Start;
                }
                if ((loc3 = loc1.IntensityZone4End) == undefined) 
                {
                    if (arg2.hrMaxDefined) 
                    {
                        arg2.intensityZone4End = arg2.hrMax;
                        arg2.intensityZone4EndDefined = true;
                    }
                }
                else 
                {
                    arg2.intensityZone4End = loc3;
                    arg2.intensityZone4EndDefined = true;
                }
                arg2.intensityZone4StartDefined = loc7 = arg2.intensityZone1StartDefined;
                arg2.intensityZone3StartDefined = loc6 = loc7;
                arg2.intensityZone2StartDefined = loc6;
                loc3 = loc1.LatitudeEnd;
                arg2.latitudeEndDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.latitudeEnd = loc3;
                    arg2.latitudeStart = loc1.LatitudeStart;
                    arg2.longitudeEnd = loc1.LongitudeEnd;
                    arg2.longitudeStart = loc1.LongitudeStart;
                }
                arg2.longitudeStartDefined = loc7 = arg2.latitudeEndDefined;
                arg2.longitudeEndDefined = loc6 = loc7;
                arg2.latitudeStartDefined = loc6;
                loc3 = loc1.LowerLimit;
                arg2.lowerLimitDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.lowerLimit = loc3;
                }
                if (parseInt(arg1.@revision) <= 210) 
                {
                    loc3 = loc1.MinimumAltitude;
                    arg2.minimumAltitudeDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.minimumAltitude = loc1.MinimumAltitude * 1000;
                        arg2.maximumAltitude = loc1.MaximumAltitude * 1000;
                        arg2.averageAltitude = loc1.AverageAltitude * 1000;
                    }
                    arg2.averageAltitudeDefined = loc6 = arg2.minimumAltitudeDefined;
                    arg2.maximumAltitudeDefined = loc6;
                    loc3 = loc1.MinimumRiseRate;
                    arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumRiseRate = loc1.MinimumRiseRate * 1000;
                        arg2.maximumRiseRate = loc1.MaximumRiseRate * 1000;
                        arg2.averageRiseRate = loc1.AverageRiseRate * 1000;
                    }
                    arg2.averageRiseRateDefined = loc7 = arg2.minimumRiseRateDefined;
                    arg2.maximumRiseRateDefined = loc7;
                    loc3 = loc1.AltitudeDifferencesUphill;
                    arg2.altitudeDifferencesUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.altitudeDifferencesUphill = loc1.AltitudeDifferencesUphill * 1000;
                        arg2.altitudeDifferencesDownhill = loc1.AltitudeDifferencesDownhill * 1000;
                    }
                    arg2.altitudeDifferencesDownhillDefined = arg2.altitudeDifferencesUphillDefined;
                }
                else 
                {
                    loc3 = loc1.MinimumAltitude;
                    arg2.minimumAltitudeDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumAltitude = loc3;
                    }
                    loc3 = loc1.MaximumAltitude;
                    arg2.maximumAltitudeDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.maximumAltitude = loc3;
                    }
                    loc3 = loc1.AverageAltitude;
                    arg2.averageAltitudeDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.averageAltitude = loc3;
                    }
                    loc3 = loc1.MinimumRiseRate;
                    arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumRiseRate = loc1.MinimumRiseRate;
                        arg2.maximumRiseRate = loc1.MaximumRiseRate;
                        arg2.averageRiseRate = loc1.AverageRiseRate;
                    }
                    arg2.averageRiseRateDefined = loc7 = arg2.minimumRiseRateDefined;
                    arg2.maximumRiseRateDefined = loc7;
                    loc3 = loc1.AltitudeDifferencesUphill;
                    arg2.altitudeDifferencesUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.altitudeDifferencesUphill = loc3;
                    }
                    loc3 = loc1.AltitudeDifferencesDownhill;
                    arg2.altitudeDifferencesDownhillDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.altitudeDifferencesDownhill = loc3;
                    }
                }
                loc3 = loc1.MaximumCadence;
                arg2.maximumCadenceDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumCadence = loc3;
                }
                loc3 = loc1.MaximumHeartrate;
                arg2.maximumHeartrateDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumHeartrate = loc3;
                }
                loc3 = loc1.MaximumIncline;
                arg2.maximumInclineDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.maximumIncline = loc3;
                }
                loc3 = loc1.MaximumInclineDownhill;
                arg2.maximumInclineDownhillDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumInclineDownhill = loc3;
                }
                loc3 = loc1.MaximumInclineUphill;
                arg2.maximumInclineUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumInclineUphill = loc3;
                }
                loc3 = loc1.MaximumPercentHRMax;
                arg2.maximumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.maximumPercentHRMax = loc3;
                }
                loc3 = loc1.MaximumPower;
                arg2.maximumPowerDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumPower = loc3;
                }
                loc3 = loc1.MaximumSpeed;
                arg2.maximumSpeedDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumSpeed = loc3;
                }
                loc3 = loc1.MaximumTemperature;
                arg2.maximumTemperatureDefined = loc5 = !(loc3 == undefined);
                if (loc5 != true) 
                {
                    loc3 = loc1.MaximalTemperature;
                    arg2.maximumTemperatureDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.maximumTemperature = loc3;
                    }
                }
                else 
                {
                    arg2.maximumTemperature = loc3;
                }
                loc3 = loc1.MinimumCadence;
                arg2.minimumCadenceDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.minimumCadence = loc3;
                }
                loc3 = loc1.MinimumHeartrate;
                arg2.minimumHeartrateDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.minimumHeartrate = loc3;
                }
                loc3 = loc1.MinimumIncline;
                arg2.minimumInclineDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.minimumIncline = loc3;
                }
                loc3 = loc1.MinimumPercentHRMax;
                arg2.minimumPercentHRMaxDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.minimumPercentHRMax = loc3;
                }
                loc3 = loc1.MinimumPower;
                arg2.minimumPowerDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.minimumPower = loc3;
                }
                loc3 = loc1.MinimumSpeed;
                arg2.minimumSpeedDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.minimumSpeed = loc3;
                }
                loc3 = loc1.MinimumTemperature;
                arg2.minimumTemperatureDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = loc1.MinimalTemperature;
                    arg2.minimumTemperatureDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumTemperature = loc3;
                    }
                }
                else 
                {
                    arg2.minimumTemperature = loc3;
                }
                loc3 = loc1.PowerZone1Start;
                arg2.powerZone1StartDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.powerZone1Start = loc3;
                    arg2.powerZone2Start = loc1.PowerZone2Start;
                    arg2.powerZone3Start = loc1.PowerZone3Start;
                    arg2.powerZone4Start = loc1.PowerZone4Start;
                    arg2.powerZone5Start = loc1.PowerZone5Start;
                    arg2.powerZone6Start = loc1.PowerZone6Start;
                    arg2.powerZone7End = loc1.PowerZone7End;
                    arg2.powerZone7Start = loc1.PowerZone7Start;
                }
                arg2.powerZone7StartDefined = loc6 = arg2.powerZone1StartDefined;
                arg2.powerZone7EndDefined = loc5 = loc6;
                arg2.powerZone6StartDefined = loc7 = loc5;
                arg2.powerZone5StartDefined = loc6 = loc7;
                arg2.powerZone4StartDefined = loc5 = loc6;
                arg2.powerZone3StartDefined = loc7 = loc5;
                arg2.powerZone2StartDefined = loc7;
                loc3 = loc1.RideTimeDownhill;
                arg2.trainingTimeDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = loc1.TimeDownhill;
                    arg2.trainingTimeDownhillDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.trainingTimeDownhill = loc3;
                        arg2.trainingTimeDownhill = arg2.trainingTimeDownhill * 100;
                    }
                }
                else 
                {
                    arg2.trainingTimeDownhill = loc3;
                    arg2.trainingTimeDownhill = arg2.trainingTimeDownhill * 100;
                }
                loc3 = loc1.RideTimeUphill;
                arg2.trainingTimeUphillDefined = loc7 = !(loc3 == undefined);
                if (loc7 != true) 
                {
                    loc3 = loc1.TimeUphill;
                    arg2.trainingTimeUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.trainingTimeUphill = loc3;
                        arg2.trainingTimeUphill = arg2.trainingTimeUphill * 100;
                    }
                }
                else 
                {
                    arg2.trainingTimeUphill = loc3;
                    arg2.trainingTimeUphill = arg2.trainingTimeUphill * 100;
                }
                loc3 = loc1.RXBatteryStatus;
                arg2.rxBatteryStatusDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.rxBatteryStatus = loc3;
                }
                loc3 = loc1.ShoulderWidth;
                arg2.shoulderWidthDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.shoulderWidth = loc3;
                }
                loc3 = loc1.ShoulderWidthUnit;
                arg2.shoulderWidthUnitDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.shoulderWidthUnit = loc3;
                }
                loc3 = loc1.ThresholdPower;
                arg2.thresholdPowerDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.thresholdPower = loc3;
                }
                loc3 = loc1.TimeInIntensityZone1;
                arg2.timeInIntensityZone1Defined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.timeInIntensityZone1 = loc3;
                    arg2.timeInIntensityZone1 = arg2.timeInIntensityZone1 * 100;
                    arg2.timeInIntensityZone2 = loc1.TimeInIntensityZone2;
                    arg2.timeInIntensityZone2 = arg2.timeInIntensityZone2 * 100;
                    arg2.timeInIntensityZone3 = loc1.TimeInIntensityZone3;
                    arg2.timeInIntensityZone3 = arg2.timeInIntensityZone3 * 100;
                    arg2.timeInIntensityZone4 = loc1.TimeInIntensityZone4;
                    arg2.timeInIntensityZone4 = arg2.timeInIntensityZone4 * 100;
                    arg2.timeOverIntensityZone = loc1.TimeOverIntensityZone;
                    arg2.timeOverIntensityZone = arg2.timeOverIntensityZone * 100;
                    arg2.timeUnderIntensityZone = loc1.TimeUnderIntensityZone;
                    arg2.timeUnderIntensityZone = arg2.timeUnderIntensityZone * 100;
                }
                arg2.timeUnderIntensityZoneDefined = loc6 = arg2.timeInIntensityZone1Defined;
                arg2.timeOverIntensityZoneDefined = loc5 = loc6;
                arg2.timeInIntensityZone4Defined = loc7 = loc5;
                arg2.timeInIntensityZone3Defined = loc6 = loc7;
                arg2.timeInIntensityZone2Defined = loc6;
                if (undefined == loc1.TimeInZone) 
                {
                    if (undefined == loc1.TimeInTargetZone) 
                    {
                        arg2.timeInZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeInZoneDefined = true;
                        arg2.timeInZone = loc1.TimeInTargetZone;
                        arg2.timeInZone = arg2.timeInZone * 100;
                    }
                }
                else 
                {
                    arg2.timeInZoneDefined = true;
                    arg2.timeInZone = loc1.TimeInZone;
                    arg2.timeInZone = arg2.timeInZone * 100;
                }
                if (undefined == loc1.TimeOverZone) 
                {
                    if (undefined == loc1.TimeOverTargetZone) 
                    {
                        arg2.timeOverZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeOverZoneDefined = true;
                        arg2.timeOverZone = loc1.TimeOverTargetZone;
                        arg2.timeOverZone = arg2.timeOverZone * 100;
                    }
                }
                else 
                {
                    arg2.timeOverZoneDefined = true;
                    arg2.timeOverZone = loc1.TimeOverZone;
                    arg2.timeOverZone = arg2.timeOverZone * 100;
                }
                if (undefined == loc1.TimeUnderZone) 
                {
                    if (undefined == loc1.TimeUnderTargetZone) 
                    {
                        arg2.timeUnderZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeUnderZoneDefined = true;
                        arg2.timeUnderZone = loc1.TimeUnderTargetZone;
                        arg2.timeUnderZone = arg2.timeUnderZone * 100;
                    }
                }
                else 
                {
                    arg2.timeUnderZoneDefined = true;
                    arg2.timeUnderZone = loc1.TimeUnderZone;
                    arg2.timeUnderZone = arg2.timeUnderZone * 100;
                }
                loc3 = loc1.TimeInZone1;
                arg2.timeInZone1Defined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.timeInZone1 = loc1.TimeInZone1;
                    arg2.timeInZone1 = arg2.timeInZone1 * 100;
                    arg2.timeInZone2 = loc1.TimeInZone2;
                    arg2.timeInZone2 = arg2.timeInZone2 * 100;
                    arg2.timeInZone3 = loc1.TimeInZone3;
                    arg2.timeInZone3 = arg2.timeInZone3 * 100;
                }
                arg2.timeInZone3Defined = loc7 = arg2.timeInZone1Defined;
                arg2.timeInZone2Defined = loc7;
                if (undefined == loc1.TargetZone) 
                {
                    if (undefined == loc1.TrainingZone) 
                    {
                        arg2.trainingZoneDefined = false;
                    }
                    else 
                    {
                        arg2.trainingZoneDefined = true;
                        arg2.trainingZone = loc1.TrainingZone;
                    }
                }
                else 
                {
                    arg2.trainingZoneDefined = true;
                    arg2.trainingZone = loc1.TargetZone;
                }
                loc3 = loc1.TXBatteryStatus;
                arg2.txBatteryStatusDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.txBatteryStatus = loc3;
                }
                loc3 = loc1.UpperLimit;
                arg2.upperLimitDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.upperLimit = loc3;
                }
                loc3 = loc1.WorkInKJ;
                arg2.workInKJDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.workInKJ = loc3;
                }
                loc3 = loc1.Zone1Start;
                arg2.zone1StartDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = arg1.GeneralInformation.StartZone1;
                    arg2.zone1StartDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.zone1Start = loc3;
                        arg2.zone2Start = arg1.GeneralInformation.StartZone2;
                        arg2.zone3Start = arg1.GeneralInformation.StartZone3;
                        arg2.zone3End = arg1.GeneralInformation.EndZone3;
                    }
                }
                else 
                {
                    arg2.zone1Start = loc3;
                    arg2.zone2Start = loc1.Zone2Start;
                    arg2.zone3End = loc1.Zone3End;
                    arg2.zone3Start = loc1.Zone3Start;
                }
                arg2.zone3StartDefined = loc7 = arg2.zone1StartDefined;
                arg2.zone3EndDefined = loc6 = loc7;
                arg2.zone2StartDefined = loc6;
            }
            else 
            {
                fromSLF400(arg1, arg2);
            }
            if (arg3) 
            {
                loadEntries(arg1, arg2, loc4);
                loadMarkers(arg1, arg2, loc4);
                if (arg2.entries.length > 0 || arg2.markerList.length > 0) 
                {
                    arg2.dataType = "log";
                }
            }
            if (loc4 < 400 && arg2.dataType == "log") 
            {
                handler.ActivityCalculator.calculateMinMaxAvgValues(arg2);
            }
            if (arg2.userId == 0) 
            {
                arg2.userId = 1;
            }
            return arg2;
        }

        public static function generateCSV(arg1:core.activities.Activity):__AS3__.vec.Vector.<String>
        {
            var loc1:*=(arg1.ageDefined ? arg1.age + "," : "") + (arg1.GUID == "" ? "" : arg1.GUID + ",") + (arg1.modificationDate == 0 ? "" : arg1.modificationDate + ",") + (arg1.altitudeDifferencesDownhillDefined ? arg1.altitudeDifferencesDownhill + "," : "") + (arg1.altitudeDifferencesUphillDefined ? arg1.altitudeDifferencesUphill + "," : "") + (arg1.averageCadenceDefined ? arg1.averageCadence + "," : "") + (arg1.averageExpansionDefined ? arg1.averageExpansion + "," : "") + (arg1.averageExpansionDownhillDefined ? arg1.averageExpansionDownhill + "," : "") + (arg1.averageExpansionUphillDefined ? arg1.averageExpansionUphill + "," : "") + (arg1.averageHeartrateDefined ? arg1.averageHeartrate + "," : "") + (arg1.averageInclineDownhillDefined ? arg1.averageInclineDownhill + "," : "") + (arg1.averageInclineUphillDefined ? arg1.averageInclineUphill + "," : "") + (arg1.averagePercentHRMaxDefined ? arg1.averagePercentHRMax + "," : "") + (arg1.averagePowerKJDefined ? arg1.averagePowerKJ + "," : "") + (arg1.averagePowerWattPerKGDefined ? arg1.averagePowerWattPerKG + "," : "") + (arg1.averageSpeedDefined ? arg1.averageSpeed + "," : "") + (arg1.averageSpeedDownhillDefined ? arg1.averageSpeedDownhill + "," : "") + (arg1.averageSpeedUphillDefined ? arg1.averageSpeedUphill + "," : "") + arg1.bike + "," + (arg1.caloriesDefined ? arg1.calories + "," : "") + (arg1.unitDefined ? arg1.unitType.toString() + "," : "") + (arg1.descriptionDefined ? arg1.description + "," : "") + (arg1.distanceDefined ? arg1.distance + "," : "") + (arg1.distanceDownhillDefined ? arg1.distanceDownhill + "," : "") + (arg1.distanceMinusDefined ? arg1.distanceMinus + "," : "") + (arg1.distancePlusDefined ? arg1.distancePlus + "," : "") + (arg1.distancePlusMinusStatusDefined ? arg1.distancePlusMinusStatus + "," : "") + (arg1.distanceUphillDefined ? arg1.distanceUphill + "," : "") + (arg1.zone1StartDefined ? arg1.zone1Start + "," : "") + (arg1.zone2StartDefined ? arg1.zone2Start + "," : "") + (arg1.zone3StartDefined ? arg1.zone3Start + "," : "") + (arg1.zone3EndDefined ? arg1.zone3End + "," : "") + (arg1.exerciseTimeDefined ? arg1.exerciseTime + "," : "") + (arg1.fuelEconomyDefined ? arg1.fuelEconomy + "," : "") + (arg1.hrMaxDefined ? arg1.hrMax + "," : "") + (arg1.percentTimeInIntensityZone1Defined ? arg1.percentTimeInIntensityZone1Defined + "," : "") + (arg1.percentTimeInIntensityZone2Defined ? arg1.percentTimeInIntensityZone2Defined + "," : "") + (arg1.percentTimeInIntensityZone3Defined ? arg1.percentTimeInIntensityZone3Defined + "," : "") + (arg1.percentTimeInIntensityZone4Defined ? arg1.percentTimeInIntensityZone4Defined + "," : "") + (arg1.maximumAltitudeDefined ? arg1.maximumAltitude + "," : "") + (arg1.maximumCadenceDefined ? arg1.maximumCadence + "," : "") + (arg1.maximumHeartrateDefined ? arg1.maximumHeartrate + "," : "") + (arg1.maximumInclineDownhillDefined ? arg1.maximumInclineDownhill + "," : "") + (arg1.maximumInclineUphillDefined ? arg1.maximumInclineUphill + "," : "") + (arg1.maximumPowerDefined ? arg1.maximumPower + "," : "") + (arg1.maximumRiseRateDownhillDefined ? arg1.maximumRiseRateDownhill + "," : "") + (arg1.maximumRiseRateUphillDefined ? arg1.maximumRiseRateUphill + "," : "") + (arg1.maximumSpeedDefined ? arg1.maximumSpeed + "," : "") + (arg1.maximumTemperatureDefined ? arg1.maximumTemperature + "," : "") + (arg1.minimumTemperatureDefined ? arg1.minimumTemperature + "," : "") + arg1.name + "," + (arg1.participant ? arg1.participant.toLocaleString() + "," : "") + (arg1.trackProfileDefined ? arg1.trackProfileDefined + "," : "") + (arg1.ratingDefined ? arg1.rating + "," : "") + (arg1.feelingDefined ? arg1.feeling + "," : "") + (arg1.trainingTimeDownhillDefined ? arg1.trainingTimeDownhill + "," : "") + (arg1.trainingTimeUphillDefined ? arg1.trainingTimeUphill + "," : "") + (arg1.serialNumberDefined ? arg1.serialNumber + "," : "") + (arg1.startDateDefined ? arg1.startDate + "," : "") + (arg1.manualTemperatureDefined ? arg1.manualTemperature + "," : "") + (arg1.timeInIntensityZone1Defined ? arg1.timeInIntensityZone1 + "," : "") + (arg1.timeInIntensityZone2Defined ? arg1.timeInIntensityZone2 + "," : "") + (arg1.timeInIntensityZone3Defined ? arg1.timeInIntensityZone3 + "," : "") + (arg1.timeInIntensityZone4Defined ? arg1.timeInIntensityZone4 + "," : "") + (arg1.timeInPowerZone1Defined ? arg1.timeInPowerZone1 + "," : "") + (arg1.timeInPowerZone2Defined ? arg1.timeInPowerZone2 + "," : "") + (arg1.timeInPowerZone3Defined ? arg1.timeInPowerZone3 + "," : "") + (arg1.timeInPowerZone4Defined ? arg1.timeInPowerZone4 + "," : "") + (arg1.timeInPowerZone5Defined ? arg1.timeInPowerZone5 + "," : "") + (arg1.timeInPowerZone6Defined ? arg1.timeInPowerZone6 + "," : "") + (arg1.timeInPowerZone7Defined ? arg1.timeInPowerZone7 + "," : "") + (arg1.timeInZone1Defined ? arg1.timeInZone1 + "," : "") + (arg1.timeInZone2Defined ? arg1.timeInZone2 + "," : "") + (arg1.timeInZone3Defined ? arg1.timeInZone3 + "," : "") + (arg1.trainingTypeDefined ? arg1.trainingType.toString() + "," : "") + (arg1.trainingTimeDefined ? arg1.trainingTime + "," : "") + (arg1.tripSectionDistanceDefined ? arg1.tripSectionDistance + "," : "") + (arg1.tripSectionTimeDefined ? arg1.tripSectionTime + "," : "") + (arg1.weatherDefined ? arg1.weather + "," : "") + (arg1.wheelSizeDefined ? arg1.wheelSize + "," : "") + (arg1.windDefined ? arg1.wind + "" : "");
            return __AS3__.vec.Vector.<String>(loc1.split(","));
        }

        public static function generateDBInsert(arg1:core.activities.Activity, arg2:Array, arg3:Object):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            arg2.push("activityStatus");
            arg3[":activityStatus"] = arg1.activityStatus;
            if (arg1.activityId > 0) 
            {
                arg2.push("activityId");
                arg3[":activityId"] = arg1.activityId;
            }
            if (arg1.GUID != "") 
            {
                arg2.push("GUID");
                arg3[":GUID"] = arg1.GUID;
            }
            if (arg1.modificationDate != 0) 
            {
                arg2.push("modificationDate");
                arg3[":modificationDate"] = arg1.modificationDate;
            }
            if (arg1.ageDefined) 
            {
                arg2.push("age");
                arg3[":age"] = arg1.age;
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg2.push("altitudeDifferencesDownhill");
                arg3[":altitudeDifferencesDownhill"] = arg1.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg2.push("altitudeDifferencesUphill");
                arg3[":altitudeDifferencesUphill"] = arg1.altitudeDifferencesUphill;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg2.push("averageAltitude");
                arg3[":averageAltitude"] = arg1.averageAltitude;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg2.push("averageCadence");
                arg3[":averageCadence"] = arg1.averageCadence;
            }
            if (arg1.averageExpansionDefined) 
            {
                arg2.push("averageExpansion");
                arg3[":averageExpansion"] = arg1.averageExpansion;
            }
            if (arg1.averageExpansionDownhillDefined) 
            {
                arg2.push("averageExpansionDownhill");
                arg3[":averageExpansionDownhill"] = arg1.averageExpansionDownhill;
            }
            if (arg1.averageExpansionUphillDefined) 
            {
                arg2.push("averageExpansionUphill");
                arg3[":averageExpansionUphill"] = arg1.averageExpansionUphill;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg2.push("averageHeartrate");
                arg3[":averageHeartrate"] = arg1.averageHeartrate;
            }
            if (arg1.averageInclineDownhill) 
            {
                arg2.push("averageInclineDownhill");
                arg3[":averageInclineDownhill"] = arg1.averageInclineDownhill;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg2.push("averageInclineUphill");
                arg3[":averageInclineUphill"] = arg1.averageInclineUphill;
            }
            if (arg1.averagePercentHRMaxDefined) 
            {
                arg2.push("averagePercentHRMax");
                arg3[":averagePercentHRMax"] = arg1.averagePercentHRMax;
            }
            if (arg1.averagePowerDefined) 
            {
                arg2.push("averagePower");
                arg3[":averagePower"] = arg1.averagePower;
            }
            if (arg1.averagePowerKJDefined) 
            {
                arg2.push("averagePowerKJ");
                arg3[":averagePowerKJ"] = arg1.averagePowerKJ;
            }
            if (arg1.averagePowerWattPerKGDefined) 
            {
                arg2.push("averagePowerWattPerKG");
                arg3[":averagePowerWattPerKG"] = arg1.averagePowerWattPerKG;
            }
            if (arg1.averageRiseRateDefined) 
            {
                arg2.push("averageRiseRate");
                arg3[":averageRiseRate"] = arg1.averageRiseRate;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg2.push("averageRiseRateUphill");
                arg3[":averageRiseRateUphill"] = arg1.averageRiseRateUphill;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg2.push("averageRiseRateDownhill");
                arg3[":averageRiseRateDownhill"] = arg1.averageRiseRateDownhill;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg2.push("averageSpeed");
                arg3[":averageSpeed"] = arg1.averageSpeed;
            }
            if (arg1.averageSpeedDownhillDefined) 
            {
                arg2.push("averageSpeedDownhill");
                arg3[":averageSpeedDownhill"] = arg1.averageSpeedDownhill;
            }
            if (arg1.averageSpeedUphillDefined) 
            {
                arg2.push("averageSpeedUphill");
                arg3[":averageSpeedUphill"] = arg1.averageSpeedUphill;
            }
            if (arg1.averageTemperatureDefined) 
            {
                arg2.push("averageTemperature");
                arg3[":averageTemperature"] = arg1.averageTemperature;
            }
            arg2.push("bike");
            arg3[":bike"] = arg1.bike;
            if (arg1.bikeTypeDefined) 
            {
                arg2.push("bikeType");
                arg3[":bikeType"] = arg1.bikeType;
            }
            if (arg1.bikeWeightDefined) 
            {
                arg2.push("bikeWeight");
                arg3[":bikeWeight"] = arg1.bikeWeight;
            }
            if (arg1.bikeWeightUnitDefined) 
            {
                arg2.push("bikeWeightUnit");
                arg3[":bikeWeightUnit"] = arg1.bikeWeightUnit;
            }
            if (arg1.bodyHeightDefined) 
            {
                arg2.push("bodyHeight");
                arg3[":bodyHeight"] = arg1.bodyHeight;
            }
            if (arg1.bodyHeightUnitDefined) 
            {
                arg2.push("bodyHeightUnit");
                arg3[":bodyHeightUnit"] = arg1.bodyHeightUnit;
            }
            if (arg1.bodyWeightDefined) 
            {
                arg2.push("bodyWeight");
                arg3[":bodyWeight"] = arg1.bodyWeight;
            }
            if (arg1.bodyWeightUnitDefined) 
            {
                arg2.push("bodyWeightUnit");
                arg3[":bodyWeightUnit"] = arg1.bodyWeightUnit;
            }
            if (arg1.calibrationDefined) 
            {
                arg2.push("calibration");
                arg3[":calibration"] = arg1.calibration;
            }
            if (arg1.caloriesDefined) 
            {
                arg2.push("calories");
                arg3[":calories"] = arg1.calories;
            }
            if (arg1.caloriesDifferenceFactorDefined) 
            {
                arg2.push("caloriesDifferenceFactor");
                arg3[":caloriesDifferenceFactor"] = arg1.caloriesDifferenceFactor;
            }
            if (arg1.correctionChestRunDefined) 
            {
                arg2.push("correctionChestRun");
                arg3[":correctionChestRun"] = arg1.correctionChestRun;
            }
            if (arg1.correctionChestWalkDefined) 
            {
                arg2.push("correctionChestWalk");
                arg3[":correctionChestWalk"] = arg1.correctionChestWalk;
            }
            if (arg1.correctionFactorDefined) 
            {
                arg2.push("correctionFactor");
                arg3[":correctionFactor"] = arg1.correctionFactor;
            }
            if (arg1.correctionHipRunDefined) 
            {
                arg2.push("correctionHipRun");
                arg3[":correctionHipRun"] = arg1.correctionHipRun;
            }
            if (arg1.correctionHipWalkDefined) 
            {
                arg2.push("correctionHipWalk");
                arg3[":correctionHipWalk"] = arg1.correctionHipWalk;
            }
            arg2.push("dataType");
            arg3[":dataType"] = arg1.dataType;
            if (arg1.dateCodeDefined) 
            {
                arg2.push("dateCode");
                arg3[":dateCode"] = arg1.dateCode;
            }
            if (arg1.descriptionDefined) 
            {
                arg2.push("description");
                arg3[":description"] = arg1.description;
            }
            if (arg1.distanceDefined) 
            {
                arg2.push("distance");
                arg3[":distance"] = arg1.distance;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg2.push("distanceDownhill");
                arg3[":distanceDownhill"] = arg1.distanceDownhill;
            }
            if (arg1.distanceMinusDefined) 
            {
                arg2.push("distanceMinus");
                arg3[":distanceMinus"] = arg1.distanceMinus;
            }
            if (arg1.distancePlusDefined) 
            {
                arg2.push("distancePlus");
                arg3[":distancePlus"] = arg1.distancePlus;
            }
            if (arg1.distancePlusMinusStatusDefined) 
            {
                arg2.push("distancePlusMinusStatus");
                arg3[":distancePlusMinusStatus"] = arg1.distancePlusMinusStatus;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg2.push("distanceUphill");
                arg3[":distanceUphill"] = arg1.distanceUphill;
            }
            if (arg1.exerciseTimeDefined) 
            {
                arg2.push("exerciseTime");
                arg3[":exerciseTime"] = arg1.exerciseTime;
            }
            if (arg1.externalLinkDefined) 
            {
                arg2.push("externalLink");
                arg3[":externalLink"] = arg1.externalLink;
            }
            if (arg1.fuelEconomyDefined) 
            {
                arg2.push("fuelEconomy");
                arg3[":fuelEconomy"] = arg1.fuelEconomy;
            }
            if (arg1.genderDefined) 
            {
                arg2.push("gender");
                arg3[":gender"] = arg1.gender;
            }
            if (arg1.hrMaxDefined) 
            {
                arg2.push("hrMax");
                arg3[":hrMax"] = arg1.hrMax;
            }
            if (arg1.intensityZone1StartDefined) 
            {
                arg2.push("intensityZone1Start");
                arg3[":intensityZone1Start"] = arg1.intensityZone1Start;
            }
            if (arg1.intensityZone2StartDefined) 
            {
                arg2.push("intensityZone2Start");
                arg3[":intensityZone2Start"] = arg1.intensityZone2Start;
            }
            if (arg1.intensityZone3StartDefined) 
            {
                arg2.push("intensityZone3Start");
                arg3[":intensityZone3Start"] = arg1.intensityZone3Start;
            }
            if (arg1.intensityZone4StartDefined) 
            {
                arg2.push("intensityZone4Start");
                arg3[":intensityZone4Start"] = arg1.intensityZone4Start;
            }
            if (arg1.intensityZone4EndDefined) 
            {
                arg2.push("intensityZone4End");
                arg3[":intensityZone4End"] = arg1.intensityZone4End;
            }
            arg2.push("isDeleted");
            arg3[":isDeleted"] = arg1.isDeleted;
            if (arg1.latitudeEndDefined) 
            {
                arg2.push("latitudeEnd");
                arg3[":latitudeEnd"] = arg1.latitudeEnd;
            }
            if (arg1.latitudeStartDefined) 
            {
                arg2.push("latitudeStart");
                arg3[":latitudeStart"] = arg1.latitudeStart;
            }
            if (arg1.linkedRouteIdDefined) 
            {
                arg2.push("linkedRouteId");
                arg3[":linkedRouteId"] = arg1.linkedRouteId;
            }
            arg2.push("linkedTrackGUID");
            arg3[":linkedTrackGUID"] = arg1.linkedTrackGUID;
            if (arg1.logTypeDefined && arg1.logType) 
            {
                arg2.push("logType");
                arg3[":logType"] = arg1.logType.toString();
            }
            if (arg1.logVersionDefined) 
            {
                arg2.push("logVersion");
                arg3[":logVersion"] = arg1.logVersion;
            }
            if (arg1.longitudeEndDefined) 
            {
                arg2.push("longitudeEnd");
                arg3[":longitudeEnd"] = arg1.longitudeEnd;
            }
            if (arg1.longitudeStartDefined) 
            {
                arg2.push("longitudeStart");
                arg3[":longitudeStart"] = arg1.longitudeStart;
            }
            if (arg1.lowerLimitDefined) 
            {
                arg2.push("lowerLimit");
                arg3[":lowerLimit"] = arg1.lowerLimit;
            }
            if (arg1.manualTemperatureDefined) 
            {
                arg2.push("manualTemperature");
                arg3[":manualTemperature"] = arg1.manualTemperature;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg2.push("maximumAltitude");
                arg3[":maximumAltitude"] = arg1.maximumAltitude;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg2.push("maximumCadence");
                arg3[":maximumCadence"] = arg1.maximumCadence;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg2.push("maximumHeartrate");
                arg3[":maximumHeartrate"] = arg1.maximumHeartrate;
            }
            if (arg1.maximumInclineDefined) 
            {
                arg2.push("maximumIncline");
                arg3[":maximumIncline"] = arg1.maximumIncline;
            }
            if (arg1.maximumInclineDownhillDefined) 
            {
                arg2.push("maximumInclineDownhill");
                arg3[":maximumInclineDownhill"] = arg1.maximumInclineDownhill;
            }
            if (arg1.maximumInclineUphillDefined) 
            {
                arg2.push("maximumInclineUphill");
                arg3[":maximumInclineUphill"] = arg1.maximumInclineUphill;
            }
            if (arg1.maximumPercentHRMaxDefined) 
            {
                arg2.push("maximumPercentHRMax");
                arg3[":maximumPercentHRMax"] = arg1.maximumPercentHRMax;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg2.push("maximumPower");
                arg3[":maximumPower"] = arg1.maximumPower;
            }
            if (arg1.maximumRiseRateDefined) 
            {
                arg2.push("maximumRiseRate");
                arg3[":maximumRiseRate"] = arg1.maximumRiseRate;
            }
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                arg2.push("maximumRiseRateDownhill");
                arg3[":maximumRiseRateDownhill"] = arg1.maximumRiseRateDownhill;
            }
            if (arg1.maximumRiseRateUphillDefined) 
            {
                arg2.push("maximumRiseRateUphill");
                arg3[":maximumRiseRateUphill"] = arg1.maximumRiseRateUphill;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg2.push("maximumSpeed");
                arg3[":maximumSpeed"] = arg1.maximumSpeed;
            }
            if (arg1.maximumTemperatureDefined) 
            {
                arg2.push("maximumTemperature");
                arg3[":maximumTemperature"] = arg1.maximumTemperature;
            }
            if (arg1.speedUnitDefined) 
            {
                arg2.push("measurement");
                arg3[":measurement"] = arg1.speedUnit;
            }
            if (arg1.minimumAltitudeDefined) 
            {
                arg2.push("minimumAltitude");
                arg3[":minimumAltitude"] = arg1.minimumAltitude;
            }
            if (arg1.minimumCadenceDefined) 
            {
                arg2.push("minimumCadence");
                arg3[":minimumCadence"] = arg1.minimumCadence;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg2.push("minimumHeartrate");
                arg3[":minimumHeartrate"] = arg1.minimumHeartrate;
            }
            if (arg1.minimumInclineDefined) 
            {
                arg2.push("minimumIncline");
                arg3[":minimumIncline"] = arg1.minimumIncline;
            }
            if (arg1.minimumInclineUphillDefined) 
            {
                arg2.push("minimumInclineUphill");
                arg3[":minimumInclineUphill"] = arg1.minimumInclineUphill;
            }
            if (arg1.minimumInclineDownhillDefined) 
            {
                arg2.push("minimumInclineDownhill");
                arg3[":minimumInclineDownhill"] = arg1.minimumInclineDownhill;
            }
            if (arg1.minimumPercentHRMaxDefined) 
            {
                arg2.push("minimumPercentHRMax");
                arg3[":minimumPercentHRMax"] = arg1.minimumPercentHRMax;
            }
            if (arg1.minimumPowerDefined) 
            {
                arg2.push("minimumPower");
                arg3[":minimumPower"] = arg1.minimumPower;
            }
            if (arg1.minimumRiseRateDefined) 
            {
                arg2.push("minimumRiseRate");
                arg3[":minimumRiseRate"] = arg1.minimumRiseRate;
            }
            if (arg1.minimumRiseRateUphillDefined) 
            {
                arg2.push("minimumRiseRateUphill");
                arg3[":minimumRiseRateUphill"] = arg1.minimumRiseRateUphill;
            }
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                arg2.push("minimumRiseRateDownhill");
                arg3[":minimumRiseRateDownhill"] = arg1.minimumRiseRateDownhill;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg2.push("minimumSpeed");
                arg3[":minimumSpeed"] = arg1.minimumSpeed;
            }
            if (arg1.minimumTemperatureDefined) 
            {
                arg2.push("minimumTemperature");
                arg3[":minimumTemperature"] = arg1.minimumTemperature;
            }
            arg2.push("name");
            arg3[":name"] = arg1.name;
            if (arg1.pauseTimeDefined) 
            {
                arg2.push("pauseTime");
                arg3[":pauseTime"] = arg1.pauseTime;
            }
            if (arg1.percentTimeInIntensityZone1Defined) 
            {
                arg2.push("percentTimeInIntensityZone1");
                arg3[":percentTimeInIntensityZone1"] = arg1.percentTimeInIntensityZone1;
            }
            if (arg1.percentTimeInIntensityZone2Defined) 
            {
                arg2.push("percentTimeInIntensityZone2");
                arg3[":percentTimeInIntensityZone2"] = arg1.percentTimeInIntensityZone2;
            }
            if (arg1.percentTimeInIntensityZone3Defined) 
            {
                arg2.push("percentTimeInIntensityZone3");
                arg3[":percentTimeInIntensityZone3"] = arg1.percentTimeInIntensityZone3;
            }
            if (arg1.percentTimeInIntensityZone4Defined) 
            {
                arg2.push("percentTimeInIntensityZone4");
                arg3[":percentTimeInIntensityZone4"] = arg1.percentTimeInIntensityZone4;
            }
            if (arg1.powerZone1StartDefined) 
            {
                arg2.push("powerZone1Start");
                arg3[":powerZone1Start"] = arg1.powerZone1Start;
            }
            if (arg1.powerZone2StartDefined) 
            {
                arg2.push("powerZone2Start");
                arg3[":powerZone2Start"] = arg1.powerZone2Start;
            }
            if (arg1.powerZone3StartDefined) 
            {
                arg2.push("powerZone3Start");
                arg3[":powerZone3Start"] = arg1.powerZone3Start;
            }
            if (arg1.powerZone4StartDefined) 
            {
                arg2.push("powerZone4Start");
                arg3[":powerZone4Start"] = arg1.powerZone4Start;
            }
            if (arg1.powerZone5StartDefined) 
            {
                arg2.push("powerZone5Start");
                arg3[":powerZone5Start"] = arg1.powerZone5Start;
            }
            if (arg1.powerZone6StartDefined) 
            {
                arg2.push("powerZone6Start");
                arg3[":powerZone6Start"] = arg1.powerZone6Start;
            }
            if (arg1.powerZone7StartDefined) 
            {
                arg2.push("powerZone7Start");
                arg3[":powerZone7Start"] = arg1.powerZone7Start;
            }
            if (arg1.powerZone7EndDefined) 
            {
                arg2.push("powerZone7End");
                arg3[":powerZone7End"] = arg1.powerZone7End;
            }
            if (arg1.ratingDefined) 
            {
                arg2.push("rating");
                arg3[":rating"] = arg1.rating;
            }
            if (arg1.feelingDefined) 
            {
                arg2.push("feeling");
                arg3[":feeling"] = arg1.feeling;
            }
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg2.push("trainingTimeDownhill");
                arg3[":trainingTimeDownhill"] = arg1.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg2.push("trainingTimeUphill");
                arg3[":trainingTimeUphill"] = arg1.trainingTimeUphill;
            }
            if (arg1.rxBatteryStatusDefined) 
            {
                arg2.push("rxBatteryStatus");
                arg3[":rxBatteryStatus"] = arg1.rxBatteryStatus;
            }
            if (arg1.samplingRateDefined) 
            {
                arg2.push("samplingRate");
                arg3[":samplingRate"] = arg1.samplingRate;
            }
            if (arg1.shoulderWidthDefined) 
            {
                arg2.push("shoulderWidth");
                arg3[":shoulderWidth"] = arg1.shoulderWidth;
            }
            if (arg1.shoulderWidthUnitDefined) 
            {
                arg2.push("shoulderWidthUnit");
                arg3[":shoulderWidthUnit"] = arg1.shoulderWidthUnit;
            }
            if (arg1.startDateDefined) 
            {
                arg2.push("startDate");
                arg3[":startDate"] = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.startDate);
            }
            if (arg1.statisticDefined) 
            {
                arg2.push("statistic");
                arg3[":statistic"] = arg1.statistic ? 1 : 0;
            }
            if (arg1.serialNumberDefined) 
            {
                arg2.push("serialNumber");
                arg3[":serialNumber"] = arg1.serialNumber;
            }
            if (arg1.thresholdPowerDefined) 
            {
                arg2.push("thresholdPower");
                arg3[":thresholdPower"] = arg1.thresholdPower;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg2.push("timeInIntensityZone1");
                arg3[":timeInIntensityZone1"] = arg1.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg2.push("timeInIntensityZone2");
                arg3[":timeInIntensityZone2"] = arg1.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg2.push("timeInIntensityZone3");
                arg3[":timeInIntensityZone3"] = arg1.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg2.push("timeInIntensityZone4");
                arg3[":timeInIntensityZone4"] = arg1.timeInIntensityZone4;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg2.push("timeInPowerZone1");
                arg3[":timeInPowerZone1"] = arg1.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg2.push("timeInPowerZone2");
                arg3[":timeInPowerZone2"] = arg1.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg2.push("timeInPowerZone3");
                arg3[":timeInPowerZone3"] = arg1.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg2.push("timeInPowerZone4");
                arg3[":timeInPowerZone4"] = arg1.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg2.push("timeInPowerZone5");
                arg3[":timeInPowerZone5"] = arg1.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg2.push("timeInPowerZone6");
                arg3[":timeInPowerZone6"] = arg1.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg2.push("timeInPowerZone7");
                arg3[":timeInPowerZone7"] = arg1.timeInPowerZone7;
            }
            if (arg1.timeInZoneDefined) 
            {
                arg2.push("timeInZone");
                arg3[":timeInZone"] = arg1.timeInZone;
            }
            if (arg1.timeInZone1Defined) 
            {
                arg2.push("timeInZone1");
                arg3[":timeInZone1"] = arg1.timeInZone1;
            }
            if (arg1.timeInZone2Defined) 
            {
                arg2.push("timeInZone2");
                arg3[":timeInZone2"] = arg1.timeInZone2;
            }
            if (arg1.timeInZone3Defined) 
            {
                arg2.push("timeInZone3");
                arg3[":timeInZone3"] = arg1.timeInZone3;
            }
            if (arg1.timeOverIntensityZoneDefined) 
            {
                arg2.push("timeOverIntensityZone");
                arg3[":timeOverIntensityZone"] = arg1.timeOverIntensityZone;
            }
            if (arg1.timeOverZoneDefined) 
            {
                arg2.push("timeOverZone");
                arg3[":timeOverZone"] = arg1.timeOverZone;
            }
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                arg2.push("timeUnderIntensityZone");
                arg3[":timeUnderIntensityZone"] = arg1.timeUnderIntensityZone;
            }
            if (arg1.timeUnderZoneDefined) 
            {
                arg2.push("timeUnderZone");
                arg3[":timeUnderZone"] = arg1.timeUnderZone;
            }
            if (arg1.trackProfileDefined) 
            {
                arg2.push("trackProfile");
                arg3[":trackProfile"] = arg1.trackProfile;
            }
            if (arg1.trainingTimeDefined) 
            {
                arg2.push("trainingTime");
                arg3[":trainingTime"] = arg1.trainingTime;
            }
            if (arg1.trainingTypeDefined) 
            {
                arg2.push("trainingType");
                arg3[":trainingType"] = arg1.trainingType.toString();
            }
            if (arg1.trainingZoneDefined) 
            {
                arg2.push("trainingZone");
                arg3[":trainingZone"] = arg1.trainingZone;
            }
            if (arg1.tripSectionDistanceDefined) 
            {
                arg2.push("tripSectionDistance");
                arg3[":tripSectionDistance"] = arg1.tripSectionDistance;
            }
            if (arg1.tripSectionTimeDefined) 
            {
                arg2.push("tripSectionTime");
                arg3[":tripSectionTime"] = arg1.tripSectionTime;
            }
            if (arg1.txBatteryStatusDefined) 
            {
                arg2.push("txBatteryStatus");
                arg3[":txBatteryStatus"] = arg1.txBatteryStatus;
            }
            if (arg1.unitDefined) 
            {
                arg2.push("unitId");
                if (arg1.unit == null) 
                {
                    arg3[":unitId"] = arg1.unitId;
                }
                else 
                {
                    arg3[":unitId"] = arg1.unit.unitId;
                }
            }
            if (arg1.unitType != null) 
            {
                arg2.push("unitType");
                arg3[":unitType"] = arg1.unitType.toString();
            }
            arg2.push("sportId");
            arg3[":sportId"] = arg1.sportId;
            if (arg1.upperLimitDefined) 
            {
                arg2.push("upperLimit");
                arg3[":upperLimit"] = arg1.upperLimit;
            }
            arg2.push("userId");
            arg3[":userId"] = arg1.userId;
            if (arg1.weatherDefined) 
            {
                arg2.push("weather");
                arg3[":weather"] = arg1.weather;
            }
            if (arg1.wheelSizeDefined) 
            {
                arg2.push("wheelSize");
                arg3[":wheelSize"] = arg1.wheelSize;
            }
            if (arg1.windDefined) 
            {
                arg2.push("wind");
                arg3[":wind"] = arg1.wind;
            }
            if (arg1.workInKJDefined) 
            {
                arg2.push("workInKJ");
                arg3[":workInKJ"] = arg1.workInKJ;
            }
            if (arg1.zone1StartDefined) 
            {
                arg2.push("zone1Start");
                arg3[":zone1Start"] = arg1.zone1Start;
            }
            if (arg1.zone2StartDefined) 
            {
                arg2.push("zone2Start");
                arg3[":zone2Start"] = arg1.zone2Start;
            }
            if (arg1.zone3StartDefined) 
            {
                arg2.push("zone3Start");
                arg3[":zone3Start"] = arg1.zone3Start;
            }
            if (arg1.zone3EndDefined) 
            {
                arg2.push("zone3End");
                arg3[":zone3End"] = arg1.zone3End;
            }
            if (arg1.chestbeltManufacturerDefined) 
            {
                arg2.push("chestbeltManufacturer");
                arg3[":chestbeltManufacturer"] = arg1.chestbeltManufacturer;
            }
            if (arg1.withDeviceDefined) 
            {
                arg2.push("withDevice");
                arg3[":withDevice"] = arg1.chestbeltManufacturer;
            }
            if (arg1.stepsDefined) 
            {
                arg2.push("steps");
                arg3[":steps"] = arg1.steps;
            }
            if (arg1.targetDayDefined) 
            {
                arg2.push("targetDay");
                arg3[":targetDay"] = arg1.targetDay;
            }
            if (arg1.activeTimeLowDefined) 
            {
                arg2.push("activTimeLow");
                arg3[":activTimeLow"] = arg1.activeTimeLow;
            }
            if (arg1.activeTimeMiddleDefined) 
            {
                arg2.push("activTimeMedium");
                arg3[":activTimeMedium"] = arg1.activeTimeMiddle;
            }
            if (arg1.activeTimeHighDefined) 
            {
                arg2.push("activTimeHigh");
                arg3[":activTimeHigh"] = arg1.activeTimeHigh;
            }
            if (arg1.timeWakeUpDefined) 
            {
                arg2.push("stepsLow");
                arg3[":stepsLow"] = arg1.timeWakeUp;
            }
            if (arg1.timeLightSleepDefined) 
            {
                arg2.push("stepsMedium");
                arg3[":stepsMedium"] = arg1.timeLightSleep;
            }
            if (arg1.timeDeepSleepDefined) 
            {
                arg2.push("stepsHigh");
                arg3[":stepsHigh"] = arg1.timeDeepSleep;
            }
            if (arg1.timeSleepDefined) 
            {
                arg2.push("timeSleep");
                arg3[":timeSleep"] = arg1.timeSleep;
            }
            if (arg1.best5KTimeDefined) 
            {
                arg2.push("best5KTime");
                arg3[":best5KTime"] = arg1.best5KTime;
            }
            if (arg1.best5KEntryDefined) 
            {
                arg2.push("best5KEntry");
                arg3[":best5KEntry"] = arg1.best5KEntry;
            }
            arg2.push("sharingInformations");
            arg3[":sharingInformations"] = encodeSharingInformations(arg1);
            if (arg1.best20minPowerDefined) 
            {
                arg2.push("best20minPower");
                arg3[":best20minPower"] = arg1.best20minPower;
            }
            if (arg1.best20minPowerEntryDefined) 
            {
                arg2.push("best20minPowerEntry");
                arg3[":best20minPowerEntry"] = arg1.best20minPowerEntry;
            }
            if (arg1.powerNPDefined) 
            {
                arg2.push("powerNP");
                arg3[":powerNP"] = arg1.powerNP;
            }
            if (arg1.powerTSSDefined) 
            {
                arg2.push("powerTSS");
                arg3[":powerTSS"] = arg1.powerTSS;
            }
            if (arg1.powerFTPDefined) 
            {
                arg2.push("powerFTP");
                arg3[":powerFTP"] = arg1.powerFTP;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg2.push("pedalingTime");
                arg3[":pedalingTime"] = arg1.pedalingTime;
            }
            if (arg1.pedalingIndexDefined) 
            {
                arg2.push("pedalingIndex");
                arg3[":pedalingIndex"] = arg1.pedalingIndex;
            }
            if (arg1.maximumExpansionDefined) 
            {
                arg2.push("maximumExpansion");
                arg3[":maximumExpansion"] = arg1.maximumExpansion;
            }
            if (arg1.maximumExpansionUphillDefined) 
            {
                arg2.push("maximumExpansionUphill");
                arg3[":maximumExpansionUphill"] = arg1.maximumExpansionUphill;
            }
            if (arg1.maximumExpansionDownhillDefined) 
            {
                arg2.push("maximumExpansionDownhill");
                arg3[":maximumExpansionDownhill"] = arg1.maximumExpansionDownhill;
            }
            if (arg1.averageBalanceRightDefined) 
            {
                arg2.push("averageBalanceRight");
                arg3[":averageBalanceRight"] = arg1.averageBalanceRight;
            }
            if (arg1.averageBalanceLeftDefined) 
            {
                arg2.push("averageBalanceLeft");
                arg3[":averageBalanceLeft"] = arg1.averageBalanceLeft;
            }
            if (arg1.powerIFDefined) 
            {
                arg2.push("powerIF");
                arg3[":powerIF"] = arg1.powerIF;
            }
            if (arg1.torqueEffectLeftDefined) 
            {
                arg2.push("torqueEffectLeft");
                arg3[":torqueEffectLeft"] = arg1.torqueEffectLeft;
            }
            if (arg1.torqueEffectRightDefined) 
            {
                arg2.push("torqueEffectRight");
                arg3[":torqueEffectRight"] = arg1.torqueEffectRight;
            }
            if (arg1.pedalSmoothLeftDefined) 
            {
                arg2.push("pedalSmoothLeft");
                arg3[":pedalSmoothLeft"] = arg1.pedalSmoothLeft;
            }
            if (arg1.pedalSmoothRightDefined) 
            {
                arg2.push("pedalSmoothRight");
                arg3[":pedalSmoothRight"] = arg1.pedalSmoothRight;
            }
            if (arg1.averageCadenceCalcDefined) 
            {
                arg2.push("averageCadenceCalc");
                arg3[":averageCadenceCalc"] = arg1.averageCadenceCalc;
            }
            if (arg1.averagePowerCalcDefined) 
            {
                arg2.push("averagePowerCalc");
                arg3[":averagePowerCalc"] = arg1.averagePowerCalc;
            }
            arg2.push("simpleHeaderValuesCalculation");
            arg3[":simpleHeaderValuesCalculation"] = arg1.simpleHeaderValuesCalculation;
            return;
        }

        public static function generateCSVHeader(arg1:core.activities.Activity):__AS3__.vec.Vector.<String>
        {
            var loc1:*=(arg1.ageDefined ? "Age," : "") + (arg1.GUID ? "GUID," : "") + (arg1.modificationDate ? "Modification Date," : "") + (arg1.altitudeDifferencesDownhillDefined ? "AltitudeDifferencesDownhill [m]," : "") + (arg1.altitudeDifferencesUphillDefined ? "AltitudeDifferencesUphill [m]," : "") + (arg1.averageCadenceDefined ? "AverageCadence [U/min]," : "") + (arg1.averageExpansionDefined ? "AverageExpansion [m/r]," : "") + (arg1.averageExpansionDownhillDefined ? "AverageExpansionDownhill [m]," : "") + (arg1.averageExpansionUphillDefined ? "AverageExpansionUphill [m/r]," : "") + (arg1.averageHeartrateDefined ? "AverageHeartrate [bpm]," : "") + (arg1.averageInclineDownhillDefined ? "AverageInclineDownhill [%]," : "") + (arg1.averageInclineUphillDefined ? "AverageInclineUphill [%]," : "") + (arg1.averagePercentHRMaxDefined ? "AveragePercentHRMax [%]," : "") + (arg1.averagePowerKJDefined ? "AveragePower [KJ]," : "") + (arg1.averagePowerWattPerKGDefined ? "AveragePower [W/KG]," : "") + (arg1.averageSpeedDefined ? "AverageSpeed [m/s]," : "") + (arg1.averageSpeedDownhillDefined ? "AverageSpeedDownhill [m/s]," : "") + (arg1.averageSpeedUphillDefined ? "AverageSpeedUphill [m/s]," : "") + "Bike," + (arg1.caloriesDefined ? "Calories [kcal]," : "") + (arg1.unitDefined ? "Computer," : "") + (arg1.descriptionDefined ? "Description," : "") + (arg1.distanceDefined ? "Distance [m]," : "") + (arg1.distanceDownhillDefined ? "DistanceDownhill [m]," : "") + (arg1.distanceMinusDefined ? "DistanceMinus [m]," : "") + (arg1.distancePlusDefined ? "DistancePlus [m]," : "") + (arg1.distancePlusMinusStatusDefined ? "DistancePlusMinusStatus," : "") + (arg1.distanceUphillDefined ? "DistanceUphill [m]," : "") + (arg1.zone1StartDefined ? "StartZone1 [bpm]," : "") + (arg1.zone2StartDefined ? "StartZone2 [bpm]," : "") + (arg1.zone3StartDefined ? "StartZone3 [bpm]," : "") + (arg1.zone3EndDefined ? "EndZone3 [bpm]," : "") + (arg1.exerciseTimeDefined ? "ExerciseTime [s]," : "") + (arg1.fuelEconomyDefined ? "FuelEconomy [ml]," : "") + (arg1.hrMaxDefined ? "HRMax [bpm]," : "") + (arg1.percentTimeInIntensityZone1Defined ? "InIntensityZone1 [%]," : "") + (arg1.percentTimeInIntensityZone2Defined ? "InIntensityZone2 [%]," : "") + (arg1.percentTimeInIntensityZone3Defined ? "InIntensityZone3 [%]," : "") + (arg1.percentTimeInIntensityZone4Defined ? "InIntensityZone4 [%]," : "") + (arg1.maximumAltitudeDefined ? "MaximumAltitude [m]," : "") + (arg1.maximumCadenceDefined ? "MaximumCadence [U/min]," : "") + (arg1.maximumHeartrateDefined ? "MaximumHeartrate [bpm]," : "") + (arg1.maximumInclineDownhillDefined ? "MaximumInclineDownhill [%]," : "") + (arg1.maximumInclineUphillDefined ? "MaximumInclineUphill [%]," : "") + (arg1.maximumPowerDefined ? "MaximumPower [W]," : "") + (arg1.maximumRiseRateDownhillDefined ? "MaximumRiseRateDownhill [m/min]," : "") + (arg1.maximumRiseRateUphillDefined ? "MaximumRiseRateUphill [m/min]," : "") + (arg1.maximumSpeedDefined ? "MaximumSpeed [m/s]," : "") + (arg1.maximumTemperatureDefined ? "MaximumTemperature [°C]," : "") + (arg1.minimumTemperatureDefined ? "MinimumTemperature [°C]," : "") + "Name," + (arg1.participant ? "Participant," : "") + (arg1.trackProfileDefined ? "Profile," : "") + (arg1.ratingDefined ? "Rating," : "") + (arg1.feelingDefined ? "Feeling," : "") + (arg1.trainingTimeDownhillDefined ? "RideTimeDownhill [s]," : "") + (arg1.trainingTimeUphillDefined ? "RideTimeUphill [s]," : "") + (arg1.serialNumberDefined ? "SerialNumber," : "") + (arg1.startDateDefined ? "StartDate," : "") + (arg1.manualTemperatureDefined ? "Temperature [°C]," : "") + (arg1.timeInIntensityZone1Defined ? "TimeInIntensityZone1 [s]," : "") + (arg1.timeInIntensityZone2Defined ? "TimeInIntensityZone2 [s]," : "") + (arg1.timeInIntensityZone3Defined ? "TimeInIntensityZone3 [s]," : "") + (arg1.timeInIntensityZone4Defined ? "TimeInIntensityZone4 [s]," : "") + (arg1.timeInPowerZone1Defined ? "TimeInPowerZone1 [s]," : "") + (arg1.timeInPowerZone2Defined ? "TimeInPowerZone2 [s]," : "") + (arg1.timeInPowerZone3Defined ? "TimeInPowerZone3 [s]," : "") + (arg1.timeInPowerZone4Defined ? "TimeInPowerZone4 [s]," : "") + (arg1.timeInPowerZone5Defined ? "TimeInPowerZone5 [s]," : "") + (arg1.timeInPowerZone6Defined ? "TimeInPowerZone6 [s]," : "") + (arg1.timeInPowerZone7Defined ? "TimeInPowerZone7 [s]," : "") + (arg1.timeInZone1Defined ? "TimeInZone1 [s]," : "") + (arg1.timeInZone2Defined ? "TimeInZone2 [s]," : "") + (arg1.timeInZone3Defined ? "TimeInZone3 [s]," : "") + (arg1.trainingTypeDefined ? "Training type," : "") + (arg1.trainingTimeDefined ? "TrainingTime [s]," : "") + (arg1.tripSectionDistanceDefined ? "TripSectionDistance [m]," : "") + (arg1.tripSectionTimeDefined ? "TripSectionTime [s]," : "") + (arg1.weatherDefined ? "Weather," : "") + (arg1.wheelSizeDefined ? "WheelSize [mm]," : "") + (arg1.windDefined ? "Wind" : "");
            return __AS3__.vec.Vector.<String>(loc1.split(","));
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Activity");
                DB_TABLE_400.addColumns([["activityId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["age", "INTEGER", true], ["altitudeDifferencesDownhill", "INTEGER", true], ["altitudeDifferencesUphill", "INTEGER", true], ["averageAltitude", "NUMERIC", true], ["averageCadence", "NUMERIC", true], ["averageExpansion", "NUMERIC", true], ["averageExpansionDownhill", "NUMERIC", true], ["averageExpansionUphill", "NUMERIC", true], ["averageHeartrate", "INTEGER", true], ["averageInclineDownhill", "NUMERIC", true], ["averageInclineUphill", "NUMERIC", true], ["averagePercentHRMax", "NUMERIC", true], ["averagePower", "NUMERIC", true], ["averagePowerKJ", "NUMERIC", true], ["averagePowerWatt", "NUMERIC", true], ["averagePowerWattPerKG", "NUMERIC", true], ["averageRiseRate", "NUMERIC", true], ["averageRiseRateUphill", "NUMERIC", true], ["averageRiseRateDownhill", "NUMERIC", true], ["averageSpeed", "NUMERIC", true], ["averageSpeedDownhill", "NUMERIC", true], ["averageSpeedUphill", "NUMERIC", true], ["averageTemperature", "NUMERIC", true], ["bike", "VARCHAR", true], ["bikeType", "VARCHAR", true], ["bikeWeight", "INTEGER", true], ["bikeWeightUnit", "VARCHAR", true], ["bodyHeight", "NUMERIC", true], ["bodyHeightUnit", "VARCHAR", true], ["bodyWeight", "INTEGER", true], ["bodyWeightUnit", "VARCHAR", true], ["calibration", "BOOL", true], ["calories", "NUMERIC", true], ["caloriesDifferenceFactor", "NUMERIC", true], ["correctionChestRun", "NUMERIC", true], ["correctionChestWalk", "NUMERIC", true], ["correctionFactor", "NUMERIC", true], ["correctionHipRun", "NUMERIC", true], ["correctionHipWalk", "NUMERIC", true], ["dataType", "VARCHAR", true], ["dateCode", "VARCHAR", true], ["description", "TEXT", true], ["distance", "NUMERIC", true], ["distanceDownhill", "NUMERIC", true], ["distanceMinus", "NUMERIC", true], ["distancePlus", "NUMERIC", true], ["distancePlusMinusStatus", "VARCHAR", true], ["distanceUphill", "NUMERIC", true], ["exerciseTime", "NUMERIC", true], ["externalLink", "VARCHAR", true], ["fuelEconomy", "NUMERIC", true], ["gender", "VARCHAR", true], ["hrMax", "INTEGER", true], ["intensityZone1Start", "NUMERIC", true], ["intensityZone2Start", "NUMERIC", true], ["intensityZone3Start", "NUMERIC", true], ["intensityZone4Start", "NUMERIC", true], ["intensityZone4End", "NUMERIC", true], ["isDeleted", "BOOL", true], ["latitudeEnd", "NUMERIC", true], ["latitudeStart", "NUMERIC", true], ["linkedRouteId", "INTEGER", true], ["logType", "VARCHAR", true], ["logVersion", "VARCHAR", true], ["longitudeEnd", "NUMERIC", true], ["longitudeStart", "NUMERIC", true], ["lowerLimit", "INTEGER", true], ["manualTemperature", "NUMERIC", true], ["maximumAltitude", "NUMERIC", true], ["maximumCadence", "INTEGER", true], ["maximumHeartrate", "INTEGER", true], ["maximumIncline", "NUMERIC", true], ["maximumInclineDownhill", "NUMERIC", true], ["maximumInclineUphill", "NUMERIC", true], ["maximumPercentHRMax", "NUMERIC", true], ["maximumPower", "INTEGER", true], ["maximumRiseRate", "NUMERIC", true], ["maximumRiseRateDownhill", "NUMERIC", true], ["maximumRiseRateUphill", "NUMERIC", true], ["maximumSpeed", "NUMERIC", true], ["maximumTemperature", "NUMERIC", true], ["measurement", "VARCHAR", true], ["minimumAltitude", "NUMERIC", true], ["minimumCadence", "INTEGER", true], ["minimumHeartrate", "NUMERIC", true], ["minimumIncline", "NUMERIC", true], ["minimumInclineUphill", "NUMERIC", true], ["minimumInclineDownhill", "NUMERIC", true], ["minimumPercentHRMax", "NUMERIC", true], ["minimumPower", "INTEGER", true], ["minimumRiseRate", "NUMERIC", true], ["minimumRiseRateUphill", "NUMERIC", true], ["minimumRiseRateDownhill", "NUMERIC", true], ["minimumSpeed", "NUMERIC", true], ["minimumTemperature", "NUMERIC", true], ["name", "VARCHAR", true], ["pageHeaderData", "BLOB", true], ["pauseTime", "NUMERIC", true], ["percentTimeInIntensityZone1", "NUMERIC", true], ["percentTimeInIntensityZone2", "NUMERIC", true], ["percentTimeInIntensityZone3", "NUMERIC", true], ["percentTimeInIntensityZone4", "NUMERIC", true], ["powerZone1Start", "INTEGER", true], ["powerZone2Start", "INTEGER", true], ["powerZone3Start", "INTEGER", true], ["powerZone4Start", "INTEGER", true], ["powerZone5Start", "INTEGER", true], ["powerZone6Start", "INTEGER", true], ["powerZone7End", "INTEGER", true], ["powerZone7Start", "INTEGER", true], ["rating", "INTEGER", true], ["feeling", "INTEGER", true], ["trainingTimeDownhill", "NUMERIC", true], ["trainingTimeUphill", "NUMERIC", true], ["rxBatteryStatus", "VARCHAR", true], ["samplingRate", "NUMERIC", true], ["shoulderWidth", "NUMERIC", true], ["shoulderWidthUnit", "VARCHAR", true], ["startDate", "Date", true], ["statistic", "BOOL", true], ["serialNumber", "VARCHAR", true], ["thresholdPower", "NUMERIC", true], ["timeInIntensityZone1", "NUMERIC", true], ["timeInIntensityZone2", "NUMERIC", true], ["timeInIntensityZone3", "NUMERIC", true], ["timeInIntensityZone4", "NUMERIC", true], ["timeInPowerZone1", "NUMERIC", true], ["timeInPowerZone2", "NUMERIC", true], ["timeInPowerZone3", "NUMERIC", true], ["timeInPowerZone4", "NUMERIC", true], ["timeInPowerZone5", "NUMERIC", true], ["timeInPowerZone6", "NUMERIC", true], ["timeInPowerZone7", "NUMERIC", true], ["timeInZone", "NUMERIC", true], ["timeInZone1", "NUMERIC", true], ["timeInZone2", "NUMERIC", true], ["timeInZone3", "NUMERIC", true], ["timeOverIntensityZone", "NUMERIC", true], ["timeOverZone", "NUMERIC", true], ["timeUnderIntensityZone", "NUMERIC", true], ["timeUnderZone", "NUMERIC", true], ["trackProfile", "INTEGER", true], ["trackReferenceId", "INTEGER", true], ["trainingTime", "NUMERIC", true], ["trainingType", "VARCHAR", true], ["trainingZone", "VARCHAR", true], ["tripSectionDistance", "NUMERIC", true], ["tripSectionTime", "NUMERIC", true], ["txBatteryStatus", "VARCHAR", true], ["unitId", "INTEGER", true], ["unitType", "VARCHAR", true], ["sportId", "INTEGER", true], ["userId", "INTEGER", true], ["upperLimit", "INTEGER", true], ["weather", "INTEGER", true], ["wheelSize", "INTEGER", true], ["wind", "INTEGER", true], ["workInKJ", "NUMERIC", true], ["zone1Start", "INTEGER", true], ["zone2Start", "INTEGER", true], ["zone3End", "INTEGER", true], ["zone3Start", "INTEGER", true], ["chestbeltManufacturer", "VARCHAR", true], ["withDevice", "VARCHAR", true], ["stepsLow", "NUMERIC", true], ["stepsMedium", "NUMERIC", true], ["stepsHigh", "NUMERIC", true], ["activTimeLow", "NUMERIC", true], ["activTimeMedium", "NUMERIC", true], ["activTimeHigh", "NUMERIC", true], ["dayActivity", "BOOL", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true], ["emptyField5", "VARCHAR", true], ["emptyField6", "VARCHAR", true], ["emptyField7", "VARCHAR", true], ["emptyField8", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX UnitIdOnActivity ON Activity (unitId)";
            return loc1;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS ActivityTrigger AFTER DELETE ON Activity FOR EACH ROW BEGIN DELETE FROM ActivityEntry WHERE ActivityEntry.activityId = OLD.activityId;DELETE FROM Marker WHERE Marker.activityId = OLD.activityId;DELETE FROM ActivityPerson WHERE ActivityPerson.activityId = OLD.activityId;END";
            }
        }

        public static function generateDBDelete(arg1:core.activities.Activity):String
        {
            return "DELETE FROM Activity WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function generateLoadActivitiesStatement(arg1:int, arg2:int, arg3:Array=null):String
        {
            var loc1:*=["GUID", "activityId", "startDate", "isDeleted", "name", "distance", "sportId", "trainingTime", "sharingInformations"];
            var loc2:*="SELECT " + loc1.join(", ") + " FROM Activity WHERE isDeleted = false";
            if (arg3 && arg3.length > 0) 
            {
                loc2 = loc2 + (" AND " + arg3.join(" AND "));
            }
            return loc2 = loc2 + " ORDER BY startDate DESC ";
        }

        public static function generateXML(arg1:core.activities.Activity, arg2:core.user.User, arg3:Boolean=true):XML
        {
            var loc3:*;
            (loc3 = new XML("<Activity/>")).@fileDate = new Date();
            loc3.@revision = 400;
            if (arg1.unitType == null) 
            {
                loc3.Computer.@unit = "user defined";
            }
            else 
            {
                loc3.Computer.@unit = arg1.unitType.toString();
            }
            if (arg1.serialNumberDefined) 
            {
                var loc4:*;
                loc3.Computer.@serial = loc4 = arg1.serialNumber;
            }
            undefined;
            if (arg1.logType != null) 
            {
                loc3.Computer.@activityType = loc4 = arg1.logType.toString();
            }
            undefined;
            if (arg1.dateCodeDefined) 
            {
                loc3.Computer.@dateCode = loc4 = arg1.dateCode;
            }
            undefined;
            var loc2:*;
            (loc2 = new XML("<GeneralInformation/>")).user = utils.format.CDATAFormat.getCDataAsXMLNode("user", arg2.name);
            loc2.user.@color = arg2.color;
            loc2.user.@gender = arg2.gender;
            loc2.sport = utils.format.CDATAFormat.getCDataAsXMLNode("sport", arg1.sport.keyName);
            if (arg1.ageDefined) 
            {
                loc2.age = loc4 = arg1.age;
            }
            undefined;
            if (arg1.GUID != "") 
            {
                loc2.GUID = loc4 = arg1.GUID;
            }
            undefined;
            loc2.activityStatus = arg1.activityStatus;
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc2.altitudeDifferencesDownhill = loc4 = arg1.altitudeDifferencesDownhill;
            }
            undefined;
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc2.altitudeDifferencesUphill = loc4 = arg1.altitudeDifferencesUphill;
            }
            undefined;
            if (arg1.averageAltitudeDefined) 
            {
                loc2.averageAltitude = loc4 = arg1.averageAltitude;
            }
            undefined;
            if (arg1.averageCadenceDefined) 
            {
                loc2.averageCadence = loc4 = arg1.averageCadence;
            }
            undefined;
            if (arg1.averageExpansionDefined) 
            {
                loc2.averageExpansion = loc4 = arg1.averageExpansion;
            }
            undefined;
            if (arg1.averageExpansionDownhillDefined) 
            {
                loc2.averageExpansionDownhill = loc4 = arg1.averageExpansionDownhill;
            }
            undefined;
            if (arg1.averageExpansionUphillDefined) 
            {
                loc2.averageExpansionUphill = loc4 = arg1.averageExpansionUphill;
            }
            undefined;
            if (arg1.averageHeartrateDefined) 
            {
                loc2.averageHeartrate = loc4 = arg1.averageHeartrate;
            }
            undefined;
            if (arg1.averageInclineDownhillDefined) 
            {
                loc2.averageInclineDownhill = loc4 = arg1.averageInclineDownhill;
            }
            undefined;
            if (arg1.averageInclineUphillDefined) 
            {
                loc2.averageInclineUphill = loc4 = arg1.averageInclineUphill;
            }
            undefined;
            if (arg1.averagePercentHRMaxDefined) 
            {
                loc2.averagePercentHRMax = loc4 = arg1.averagePercentHRMax;
            }
            undefined;
            if (arg1.averagePowerDefined) 
            {
                loc2.averagePower = loc4 = arg1.averagePower;
            }
            undefined;
            if (arg1.averagePowerKJDefined) 
            {
                loc2.averagePowerKJ = loc4 = arg1.averagePowerKJ;
            }
            undefined;
            if (arg1.averagePowerWattPerKGDefined) 
            {
                loc2.averagePowerWattPerKG = loc4 = arg1.averagePowerWattPerKG;
            }
            undefined;
            if (arg1.averageRiseRateDefined) 
            {
                loc2.averageRiseRate = loc4 = arg1.averageRiseRate;
            }
            undefined;
            if (arg1.averageRiseRateUphillDefined) 
            {
                loc2.averageRiseRateUphill = loc4 = arg1.averageRiseRateUphill;
            }
            undefined;
            if (arg1.averageRiseRateDownhillDefined) 
            {
                loc2.averageRiseRateDownhill = loc4 = arg1.averageRiseRateDownhill;
            }
            undefined;
            if (arg1.averageSpeedDefined) 
            {
                loc2.averageSpeed = loc4 = arg1.averageSpeed;
            }
            undefined;
            if (arg1.averageSpeedDownhillDefined) 
            {
                loc2.averageSpeedDownhill = loc4 = arg1.averageSpeedDownhill;
            }
            undefined;
            if (arg1.averageSpeedUphillDefined) 
            {
                loc2.averageSpeedUphill = loc4 = arg1.averageSpeedUphill;
            }
            undefined;
            if (arg1.averageTemperatureDefined) 
            {
                loc2.averageTemperature = loc4 = arg1.averageTemperature;
            }
            undefined;
            loc2.bike = arg1.bike;
            if (arg1.bikeTypeDefined) 
            {
                loc2.bikeType = loc4 = arg1.bikeType;
            }
            undefined;
            if (arg1.bikeWeightDefined) 
            {
                loc2.bikeWeight = loc4 = arg1.bikeWeight;
            }
            undefined;
            if (arg1.bikeWeightUnitDefined) 
            {
                loc2.bikeWeightUnit = loc4 = arg1.bikeWeightUnit;
            }
            undefined;
            if (arg1.bodyHeightDefined) 
            {
                loc2.bodyHeight = loc4 = arg1.bodyHeight;
            }
            undefined;
            if (arg1.bodyHeightUnitDefined) 
            {
                loc2.bodyHeightUnit = loc4 = arg1.bodyHeightUnit;
            }
            undefined;
            if (arg1.bodyWeightDefined) 
            {
                loc2.bodyWeight = loc4 = arg1.bodyWeight;
            }
            undefined;
            if (arg1.bodyWeightUnitDefined) 
            {
                loc2.bodyWeightUnit = loc4 = arg1.bodyWeightUnit;
            }
            undefined;
            if (arg1.calibrationDefined) 
            {
                loc2.calibration = loc4 = arg1.calibration;
            }
            undefined;
            if (arg1.caloriesDefined) 
            {
                loc2.calories = loc4 = arg1.calories;
            }
            undefined;
            if (arg1.caloriesDifferenceFactorDefined) 
            {
                loc2.caloriesDifferenceFactor = loc4 = arg1.caloriesDifferenceFactor;
            }
            undefined;
            if (arg1.correctionChestRunDefined) 
            {
                loc2.correctionChestRun = loc4 = arg1.correctionChestRun;
            }
            undefined;
            if (arg1.correctionChestWalkDefined) 
            {
                loc2.correctionChestWalk = loc4 = arg1.correctionChestWalk;
            }
            undefined;
            if (arg1.correctionFactorDefined) 
            {
                loc2.correctionFactor = loc4 = arg1.correctionFactor;
            }
            undefined;
            if (arg1.correctionHipRunDefined) 
            {
                loc2.correctionHipRun = loc4 = arg1.correctionHipRun;
            }
            undefined;
            if (arg1.correctionHipWalkDefined) 
            {
                loc2.correctionHipWalk = loc4 = arg1.correctionHipWalk;
            }
            undefined;
            if (arg1.descriptionDefined) 
            {
                loc2.description = loc4 = utils.format.CDATAFormat.getCDataAsXMLNode("description", arg1.description);
            }
            undefined;
            if (arg1.distanceDefined) 
            {
                loc2.distance = loc4 = arg1.distance;
            }
            undefined;
            if (arg1.distanceDownhillDefined) 
            {
                loc2.distanceDownhill = loc4 = arg1.distanceDownhill;
            }
            undefined;
            if (arg1.distanceMinusDefined) 
            {
                loc2.distanceMinus = loc4 = arg1.distanceMinus;
            }
            undefined;
            if (arg1.distancePlusDefined) 
            {
                loc2.distancePlus = loc4 = arg1.distancePlus;
            }
            undefined;
            if (arg1.distancePlusMinusStatusDefined) 
            {
                loc2.distancePlusMinusStatus = loc4 = arg1.distancePlusMinusStatus;
            }
            undefined;
            if (arg1.distanceUphillDefined) 
            {
                loc2.distanceUphill = loc4 = arg1.distanceUphill;
            }
            undefined;
            if (arg1.exerciseTimeDefined) 
            {
                loc2.exerciseTime = loc4 = arg1.exerciseTime;
            }
            undefined;
            if (arg1.externalLinkDefined) 
            {
                loc2.externalLink = loc4 = utils.format.CDATAFormat.getCDataAsXMLNode("externalLink", arg1.externalLink);
            }
            undefined;
            if (arg1.fuelEconomyDefined) 
            {
                loc2.fuelEconomy = loc4 = arg1.fuelEconomy;
            }
            undefined;
            if (arg1.genderDefined) 
            {
                loc2.gender = loc4 = arg1.gender;
            }
            undefined;
            if (arg1.hrMaxDefined) 
            {
                loc2.hrMax = loc4 = arg1.hrMax;
            }
            undefined;
            if (arg1.intensityZone1StartDefined) 
            {
                loc2.intensityZone1Start = loc4 = arg1.intensityZone1Start;
            }
            undefined;
            if (arg1.intensityZone2StartDefined) 
            {
                loc2.intensityZone2Start = loc4 = arg1.intensityZone2Start;
            }
            undefined;
            if (arg1.intensityZone3StartDefined) 
            {
                loc2.intensityZone3Start = loc4 = arg1.intensityZone3Start;
            }
            undefined;
            if (arg1.intensityZone4StartDefined) 
            {
                loc2.intensityZone4Start = loc4 = arg1.intensityZone4Start;
            }
            undefined;
            if (arg1.intensityZone4EndDefined) 
            {
                loc2.intensityZone4End = loc4 = arg1.intensityZone4End;
            }
            undefined;
            if (arg1.latitudeEndDefined) 
            {
                loc2.latitudeEnd = loc4 = arg1.latitudeEnd;
            }
            undefined;
            if (arg1.latitudeStartDefined) 
            {
                loc2.latitudeStart = loc4 = arg1.latitudeStart;
            }
            undefined;
            if (arg1.linkedTrackGUIDDefined) 
            {
                loc2.linkedTrackGUID = loc4 = arg1.linkedTrackGUID;
            }
            undefined;
            if (arg1.longitudeEndDefined) 
            {
                loc2.longitudeEnd = loc4 = arg1.longitudeEnd;
            }
            undefined;
            if (arg1.longitudeStartDefined) 
            {
                loc2.longitudeStart = loc4 = arg1.longitudeStart;
            }
            undefined;
            if (arg1.lowerLimitDefined) 
            {
                loc2.lowerLimit = loc4 = arg1.lowerLimit;
            }
            undefined;
            if (arg1.manualTemperatureDefined) 
            {
                loc2.manualTemperature = loc4 = arg1.manualTemperature;
            }
            undefined;
            if (arg1.maximumAltitudeDefined) 
            {
                loc2.maximumAltitude = loc4 = arg1.maximumAltitude;
            }
            undefined;
            if (arg1.maximumCadenceDefined) 
            {
                loc2.maximumCadence = loc4 = arg1.maximumCadence;
            }
            undefined;
            if (arg1.maximumHeartrateDefined) 
            {
                loc2.maximumHeartrate = loc4 = arg1.maximumHeartrate;
            }
            undefined;
            if (arg1.maximumInclineDefined) 
            {
                loc2.maximumIncline = loc4 = arg1.maximumIncline;
            }
            undefined;
            if (arg1.maximumInclineDownhillDefined) 
            {
                loc2.maximumInclineDownhill = loc4 = arg1.maximumInclineDownhill;
            }
            undefined;
            if (arg1.maximumInclineUphillDefined) 
            {
                loc2.maximumInclineUphill = loc4 = arg1.maximumInclineUphill;
            }
            undefined;
            if (arg1.maximumPercentHRMaxDefined) 
            {
                loc2.maximumPercentHRMax = loc4 = arg1.maximumPercentHRMax;
            }
            undefined;
            if (arg1.maximumPowerDefined) 
            {
                loc2.maximumPower = loc4 = arg1.maximumPower;
            }
            undefined;
            if (arg1.maximumRiseRateDefined) 
            {
                loc2.maximumRiseRate = loc4 = arg1.maximumRiseRate;
            }
            undefined;
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                loc2.maximumRiseRateDownhill = loc4 = arg1.maximumRiseRateDownhill;
            }
            undefined;
            if (arg1.maximumRiseRateUphillDefined) 
            {
                loc2.maximumRiseRateUphill = loc4 = arg1.maximumRiseRateUphill;
            }
            undefined;
            if (arg1.maximumSpeedDefined) 
            {
                loc2.maximumSpeed = loc4 = arg1.maximumSpeed;
            }
            undefined;
            if (arg1.maximumTemperatureDefined) 
            {
                loc2.maximumTemperature = loc4 = arg1.maximumTemperature;
            }
            undefined;
            if (arg1.speedUnitDefined) 
            {
                loc2.measurement = loc4 = arg1.speedUnit;
            }
            undefined;
            if (arg1.minimumAltitudeDefined) 
            {
                loc2.minimumAltitude = loc4 = arg1.minimumAltitude;
            }
            undefined;
            if (arg1.minimumCadenceDefined) 
            {
                loc2.minimumCadence = loc4 = arg1.minimumCadence;
            }
            undefined;
            if (arg1.minimumHeartrateDefined) 
            {
                loc2.minimumHeartrate = loc4 = arg1.minimumHeartrate;
            }
            undefined;
            if (arg1.minimumInclineDefined) 
            {
                loc2.minimumIncline = loc4 = arg1.minimumIncline;
            }
            undefined;
            if (arg1.minimumInclineUphillDefined) 
            {
                loc2.minimumInclineUphill = loc4 = arg1.minimumInclineUphill;
            }
            undefined;
            if (arg1.minimumInclineDownhillDefined) 
            {
                loc2.minimumInclineDownhill = loc4 = arg1.minimumInclineDownhill;
            }
            undefined;
            if (arg1.minimumPercentHRMaxDefined) 
            {
                loc2.minimumPercentHRMax = loc4 = arg1.minimumPercentHRMax;
            }
            undefined;
            if (arg1.minimumPowerDefined) 
            {
                loc2.minimumPower = loc4 = arg1.minimumPower;
            }
            undefined;
            if (arg1.minimumRiseRateDefined) 
            {
                loc2.minimumRiseRate = loc4 = arg1.minimumRiseRate;
            }
            undefined;
            if (arg1.minimumRiseRateUphillDefined) 
            {
                loc2.minimumRiseRateUphill = loc4 = arg1.minimumRiseRateUphill;
            }
            undefined;
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                loc2.minimumRiseRateDownhill = loc4 = arg1.minimumRiseRateDownhill;
            }
            undefined;
            if (arg1.minimumSpeedDefined) 
            {
                loc2.minimumSpeed = loc4 = arg1.minimumSpeed;
            }
            undefined;
            if (arg1.minimumTemperatureDefined) 
            {
                loc2.minimumTemperature = loc4 = arg1.minimumTemperature;
            }
            undefined;
            loc2.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", arg1.name);
            if (arg1.pageHeaderDataDefined) 
            {
                loc2.pageHeaderData = loc4 = arg1.pageHeaderData;
            }
            undefined;
            if (arg1.pauseTimeDefined) 
            {
                loc2.pauseTime = loc4 = arg1.pauseTime;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone1Defined) 
            {
                loc2.percentTimeInIntensityZone1 = loc4 = arg1.percentTimeInIntensityZone1;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone2Defined) 
            {
                loc2.percentTimeInIntensityZone2 = loc4 = arg1.percentTimeInIntensityZone2;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone3Defined) 
            {
                loc2.percentTimeInIntensityZone3 = loc4 = arg1.percentTimeInIntensityZone3;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone4Defined) 
            {
                loc2.percentTimeInIntensityZone4 = loc4 = arg1.percentTimeInIntensityZone4;
            }
            undefined;
            if (arg1.powerZone1StartDefined) 
            {
                loc2.powerZone1Start = loc4 = arg1.powerZone1Start;
            }
            undefined;
            if (arg1.powerZone2StartDefined) 
            {
                loc2.powerZone2Start = loc4 = arg1.powerZone2Start;
            }
            undefined;
            if (arg1.powerZone3StartDefined) 
            {
                loc2.powerZone3Start = loc4 = arg1.powerZone3Start;
            }
            undefined;
            if (arg1.powerZone4StartDefined) 
            {
                loc2.powerZone4Start = loc4 = arg1.powerZone4Start;
            }
            undefined;
            if (arg1.powerZone5StartDefined) 
            {
                loc2.powerZone5Start = loc4 = arg1.powerZone5Start;
            }
            undefined;
            if (arg1.powerZone6StartDefined) 
            {
                loc2.powerZone6Start = loc4 = arg1.powerZone6Start;
            }
            undefined;
            if (arg1.powerZone7EndDefined) 
            {
                loc2.powerZone7End = loc4 = arg1.powerZone7End;
            }
            undefined;
            if (arg1.powerZone7StartDefined) 
            {
                loc2.powerZone7Start = loc4 = arg1.powerZone7Start;
            }
            undefined;
            if (arg1.ratingDefined) 
            {
                loc2.rating = loc4 = arg1.rating;
            }
            undefined;
            if (arg1.feelingDefined) 
            {
                loc2.feeling = loc4 = arg1.feeling;
            }
            undefined;
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc2.trainingTimeDownhill = loc4 = arg1.trainingTimeDownhill;
            }
            undefined;
            if (arg1.trainingTimeUphillDefined) 
            {
                loc2.trainingTimeUphill = loc4 = arg1.trainingTimeUphill;
            }
            undefined;
            if (arg1.rxBatteryStatusDefined) 
            {
                loc2.rxBatteryStatus = loc4 = arg1.rxBatteryStatus;
            }
            undefined;
            if (arg1.samplingRateDefined) 
            {
                loc2.samplingRate = loc4 = arg1.samplingRate;
            }
            undefined;
            if (arg1.shoulderWidthDefined) 
            {
                loc2.shoulderWidth = loc4 = arg1.shoulderWidth;
            }
            undefined;
            if (arg1.shoulderWidthUnitDefined) 
            {
                loc2.shoulderWidthUnit = loc4 = arg1.shoulderWidthUnit;
            }
            undefined;
            if (arg1.startDateDefined) 
            {
                loc2.startDate = loc4 = arg1.startDate;
            }
            undefined;
            loc2.statistic = arg1.statistic ? "true" : "false";
            if (arg1.thresholdPowerDefined) 
            {
                loc2.thresholdPower = loc4 = arg1.thresholdPower;
            }
            undefined;
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc2.timeInIntensityZone1 = loc4 = arg1.timeInIntensityZone1;
            }
            undefined;
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc2.timeInIntensityZone2 = loc4 = arg1.timeInIntensityZone2;
            }
            undefined;
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc2.timeInIntensityZone3 = loc4 = arg1.timeInIntensityZone3;
            }
            undefined;
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc2.timeInIntensityZone4 = loc4 = arg1.timeInIntensityZone4;
            }
            undefined;
            if (arg1.timeInZoneDefined) 
            {
                loc2.timeInTargetZone = loc4 = arg1.timeInZone;
            }
            undefined;
            if (arg1.timeInZone1Defined) 
            {
                loc2.timeInZone1 = loc4 = arg1.timeInZone1;
            }
            undefined;
            if (arg1.timeInZone2Defined) 
            {
                loc2.timeInZone2 = loc4 = arg1.timeInZone2;
            }
            undefined;
            if (arg1.timeInZone3Defined) 
            {
                loc2.timeInZone3 = loc4 = arg1.timeInZone3;
            }
            undefined;
            if (arg1.timeOverIntensityZoneDefined) 
            {
                loc2.timeOverIntensityZone = loc4 = arg1.timeOverIntensityZone;
            }
            undefined;
            if (arg1.timeOverZoneDefined) 
            {
                loc2.timeOverTargetZone = loc4 = arg1.timeOverZone;
            }
            undefined;
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                loc2.timeUnderIntensityZone = loc4 = arg1.timeUnderIntensityZone;
            }
            undefined;
            if (arg1.timeUnderZoneDefined) 
            {
                loc2.timeUnderTargetZone = loc4 = arg1.timeUnderZone;
            }
            undefined;
            if (arg1.trackProfileDefined) 
            {
                loc2.trackProfile = loc4 = arg1.trackProfile;
            }
            undefined;
            if (arg1.trainingTimeDefined) 
            {
                loc2.trainingTime = loc4 = arg1.trainingTime;
            }
            undefined;
            if (arg1.trainingTypeDefined) 
            {
                loc2.trainingType = loc4 = arg1.trainingType.toString();
            }
            undefined;
            if (arg1.trainingZoneDefined) 
            {
                loc2.trainingZone = loc4 = arg1.trainingZone;
            }
            undefined;
            if (arg1.tripSectionDistanceDefined) 
            {
                loc2.tripSectionDistance = loc4 = arg1.tripSectionDistance;
            }
            undefined;
            if (arg1.tripSectionTimeDefined) 
            {
                loc2.tripSectionTime = loc4 = arg1.tripSectionTime;
            }
            undefined;
            if (arg1.txBatteryStatusDefined) 
            {
                loc2.txBatteryStatus = loc4 = arg1.txBatteryStatus;
            }
            undefined;
            if (arg1.upperLimitDefined) 
            {
                loc2.upperLimit = loc4 = arg1.upperLimit;
            }
            undefined;
            if (arg1.weatherDefined) 
            {
                loc2.weather = loc4 = arg1.weather;
            }
            undefined;
            if (arg1.wheelSizeDefined) 
            {
                loc2.wheelSize = loc4 = arg1.wheelSize;
            }
            undefined;
            if (arg1.windDefined) 
            {
                loc2.wind = loc4 = arg1.wind;
            }
            undefined;
            if (arg1.workInKJDefined) 
            {
                loc2.workInKJ = loc4 = arg1.workInKJ;
            }
            undefined;
            if (arg1.zone1StartDefined) 
            {
                loc2.zone1Start = loc4 = arg1.zone1Start;
            }
            undefined;
            if (arg1.zone2StartDefined) 
            {
                loc2.zone2Start = loc4 = arg1.zone2Start;
            }
            undefined;
            if (arg1.zone3EndDefined) 
            {
                loc2.zone3End = loc4 = arg1.zone3End;
            }
            undefined;
            if (arg1.zone3StartDefined) 
            {
                loc2.zone3Start = loc4 = arg1.zone3Start;
            }
            undefined;
            if (arg1.chestbeltManufacturerDefined) 
            {
                loc2.chestbeltManufacturer = loc4 = arg1.chestbeltManufacturer;
            }
            undefined;
            if (arg1.withDeviceDefined) 
            {
                loc2.withDevice = loc4 = arg1.withDevice;
            }
            undefined;
            if (arg1.motionPointsDefined) 
            {
                loc2.motionPoints = loc4 = arg1.motionPoints;
            }
            undefined;
            if (arg1.stepsDefined) 
            {
                loc2.steps = loc4 = arg1.steps;
            }
            undefined;
            if (arg1.activeTimeLowDefined) 
            {
                loc2.timeActiveLow = loc4 = arg1.activeTimeLow;
            }
            undefined;
            if (arg1.activeTimeMiddleDefined) 
            {
                loc2.timeActiveMiddle = loc4 = arg1.activeTimeMiddle;
            }
            undefined;
            if (arg1.activeTimeHighDefined) 
            {
                loc2.timeActiveHigh = loc4 = arg1.activeTimeHigh;
            }
            undefined;
            if (arg1.timeDeepSleepDefined) 
            {
                loc2.timeDeepSleep = loc4 = arg1.timeDeepSleep;
            }
            undefined;
            if (arg1.timeLightSleepDefined) 
            {
                loc2.timeLightSleep = loc4 = arg1.timeLightSleep;
            }
            undefined;
            if (arg1.timeWakeUpDefined) 
            {
                loc2.timeWakeUp = loc4 = arg1.timeWakeUp;
            }
            undefined;
            if (arg1.timeSleepDefined) 
            {
                loc2.timeSleep = loc4 = arg1.timeSleep;
            }
            undefined;
            if (arg1.targetDayDefined) 
            {
                loc2.targetDay = loc4 = arg1.targetDay;
            }
            undefined;
            if (arg1.best5KTimeDefined) 
            {
                loc2.best5KTime = loc4 = arg1.best5KTime;
            }
            undefined;
            if (arg1.best5KEntryDefined) 
            {
                loc2.best5KEntry = loc4 = arg1.best5KEntry;
            }
            undefined;
            if (arg1.best20minPowerDefined) 
            {
                loc2.best20minPower = loc4 = arg1.best20minPower;
            }
            undefined;
            if (arg1.best20minPowerEntryDefined) 
            {
                loc2.best20minPowerEntry = loc4 = arg1.best20minPowerEntry;
            }
            undefined;
            if (arg1.powerNPDefined) 
            {
                loc2.powerNP = loc4 = arg1.powerNP;
            }
            undefined;
            if (arg1.powerTSSDefined) 
            {
                loc2.powerTSS = loc4 = arg1.powerTSS;
            }
            undefined;
            if (arg1.powerFTPDefined) 
            {
                loc2.powerFTP = loc4 = arg1.powerFTP;
            }
            undefined;
            if (arg1.pedalingTimeDefined) 
            {
                loc2.pedalingTime = loc4 = arg1.pedalingTime;
            }
            undefined;
            if (arg1.pedalingIndexDefined) 
            {
                loc2.pedalingIndex = loc4 = arg1.pedalingIndex;
            }
            undefined;
            if (arg1.maximumExpansionDefined) 
            {
                loc2.maximumExpansion = loc4 = arg1.maximumExpansion;
            }
            undefined;
            if (arg1.maximumExpansionUphillDefined) 
            {
                loc2.maximumExpansionUphill = loc4 = arg1.maximumExpansionUphill;
            }
            undefined;
            if (arg1.maximumExpansionDownhillDefined) 
            {
                loc2.maximumExpansionDownhill = loc4 = arg1.maximumExpansionDownhill;
            }
            undefined;
            if (arg1.averageBalanceRightDefined) 
            {
                loc2.averageBalanceRight = loc4 = arg1.averageBalanceRight;
            }
            undefined;
            if (arg1.averageBalanceLeftDefined) 
            {
                loc2.averageBalanceLeft = loc4 = arg1.averageBalanceLeft;
            }
            undefined;
            if (arg1.powerFTPDefined) 
            {
                loc2.powerIF = loc4 = arg1.powerIF;
            }
            undefined;
            if (arg1.torqueEffectLeftDefined) 
            {
                loc2.torqueEffectLeft = loc4 = arg1.torqueEffectLeft;
            }
            undefined;
            if (arg1.torqueEffectRightDefined) 
            {
                loc2.torqueEffectRight = loc4 = arg1.torqueEffectRight;
            }
            undefined;
            if (arg1.pedalSmoothLeftDefined) 
            {
                loc2.pedalSmoothLeft = loc4 = arg1.pedalSmoothLeft;
            }
            undefined;
            if (arg1.pedalSmoothRightDefined) 
            {
                loc2.pedalSmoothRight = loc4 = arg1.pedalSmoothRight;
            }
            undefined;
            if (arg1.averageCadenceCalcDefined) 
            {
                loc2.averageCadenceCalc = loc4 = arg1.averageCadenceCalc;
            }
            undefined;
            if (arg1.averagePowerCalcDefined) 
            {
                loc2.averagePowerCalc = loc4 = arg1.averagePowerCalc;
            }
            undefined;
            loc2.simpleHeaderValuesCalculation = arg1.simpleHeaderValuesCalculation ? "true" : "false";
            loc2.sharingInfo = encodeSharingInformations(arg1);
            loc3.appendChild(loc2);
            loc3.GeneralInformation.Participant = new XML("<Participant/>");
            var loc6:*=0;
            var loc5:*=arg1.participant;
            for each (var loc1:* in loc5) 
            {
                loc3.GeneralInformation.Participant.appendChild(loc1.toXML());
            }
            if (!arg3) 
            {
                return loc3;
            }
            loc3.appendChild(generateEntries(arg1));
            loc3.appendChild(generateMarkers(arg1));
            return loc3;
        }

        public static function encodeSharingInformations(arg1:core.activities.Activity):String
        {
            var loc1:*=new core.activities.ActivityShareObject(arg1);
            return loc1.toJson();
        }

        public static function decodeSharingInformations(arg1:String, arg2:core.activities.Activity):void
        {
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.fromJson(arg1);
            loc1.saveToActivity(arg2);
            return;
        }

        public static function isShared(arg1:String):Boolean
        {
            if (!arg1) 
            {
                return false;
            }
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.fromJson(arg1);
            return loc1.isAnyShared();
        }

        public static function resetSharingInformation(arg1:core.activities.Activity):void
        {
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.reset();
            loc1.saveToActivity(arg1);
            return;
        }

        internal static function fromSLF400(arg1:XML, arg2:core.activities.Activity):void
        {
            var loc3:*=undefined;
            arg2.unitType = core.general.UnitType.fromString(arg1.Computer.@unit);
            if (arg2.unitType == null) 
            {
                arg2.serialNumberDefined = false;
                arg2.dateCodeDefined = false;
                arg2.logTypeDefined = false;
                arg2.logVersionDefined = false;
            }
            else 
            {
                arg2.serialNumberDefined = true;
                arg2.serialNumber = arg1.Computer.@serial;
                arg2.dateCodeDefined = true;
                arg2.dateCode = arg1.Computer.@dateCode;
                arg2.logType = core.general.LogType.fromString(arg1.Computer.@activityType);
                arg2.logTypeDefined = !(arg2.logType == null);
            }
            var loc1:*=arg1.GeneralInformation;
            loc3 = loc1.age;
            var loc5:*;
            arg2.ageDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.age = loc3;
            }
            if ((loc3 = loc1.activityStatus) != undefined) 
            {
                arg2.activityStatus = loc3;
            }
            loc3 = loc1.altitudeDifferencesDownhill;
            arg2.altitudeDifferencesDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.altitudeDifferencesDownhill = loc3;
            }
            loc3 = loc1.altitudeDifferencesUphill;
            arg2.altitudeDifferencesUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.altitudeDifferencesUphill = loc3;
            }
            loc3 = loc1.averageAltitude;
            arg2.averageAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageAltitude = loc3;
            }
            loc3 = loc1.averageCadence;
            arg2.averageCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageCadence = loc3;
            }
            loc3 = loc1.averageExpansion;
            arg2.averageExpansionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansion = loc3;
            }
            loc3 = loc1.averageExpansionDownhill;
            arg2.averageExpansionDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansionDownhill = loc3;
            }
            loc3 = loc1.averageExpansionUphill;
            arg2.averageExpansionUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansionUphill = loc3;
            }
            loc3 = loc1.averageHeartrate;
            arg2.averageHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageHeartrate = loc3;
            }
            loc3 = loc1.averageInclineDownhill;
            arg2.averageInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageInclineDownhill = loc3;
            }
            loc3 = loc1.averageInclineUphill;
            arg2.averageInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageInclineUphill = loc3;
            }
            loc3 = loc1.averagePercentHRMax;
            arg2.averagePercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePercentHRMax = loc3;
            }
            loc3 = loc1.averagePower;
            arg2.averagePowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePower = loc3;
            }
            loc3 = loc1.averagePowerKJ;
            arg2.averagePowerKJDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerKJ = loc3;
            }
            loc3 = loc1.averagePowerWattPerKG;
            arg2.averagePowerWattPerKGDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerWattPerKG = loc3;
            }
            loc3 = loc1.averageRiseRate;
            arg2.averageRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRate = loc3;
            }
            loc3 = loc1.averageRiseRateUphill;
            arg2.averageRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRateUphill = loc3;
            }
            loc3 = loc1.averageRiseRateDownhill;
            arg2.averageRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRateDownhill = loc3;
            }
            loc3 = loc1.averageSpeed;
            arg2.averageSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeed = loc3;
            }
            loc3 = loc1.averageSpeedDownhill;
            arg2.averageSpeedDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeedDownhill = loc3;
            }
            loc3 = loc1.averageSpeedUphill;
            arg2.averageSpeedUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeedUphill = loc3;
            }
            loc3 = loc1.averageTemperature;
            arg2.averageTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageTemperature = loc3;
            }
            loc3 = loc1.bike;
            arg2.bike = loc3 == undefined ? "noBike" : loc3;
            loc3 = loc1.bikeType;
            arg2.bikeTypeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeType = loc3;
            }
            loc3 = loc1.bikeWeight;
            arg2.bikeWeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeWeight = loc3;
            }
            loc3 = loc1.bikeWeightUnit;
            arg2.bikeWeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeWeightUnit = loc3;
            }
            loc3 = loc1.bodyHeight;
            arg2.bodyHeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyHeight = loc3;
            }
            loc3 = loc1.bodyHeightUnit;
            arg2.bodyHeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyHeightUnit = loc3;
            }
            loc3 = loc1.bodyWeight;
            arg2.bodyWeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyWeight = loc3;
            }
            loc3 = loc1.bodyWeightUnit;
            arg2.bodyWeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyWeightUnit = loc3;
            }
            loc3 = loc1.calibration;
            arg2.calibrationDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.calibration = loc3;
            }
            loc3 = loc1.calories;
            arg2.caloriesDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.calories = loc3;
            }
            loc3 = loc1.caloriesDifferenceFactor;
            arg2.caloriesDifferenceFactorDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.caloriesDifferenceFactor = loc3;
            }
            loc3 = loc1.correctionChestRun;
            arg2.correctionChestRunDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionChestRun = loc3;
            }
            loc3 = loc1.correctionChestWalk;
            arg2.correctionChestWalkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionChestWalk = loc3;
            }
            loc3 = loc1.correctionFactor;
            arg2.correctionFactorDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionFactor = loc3;
            }
            loc3 = loc1.correctionHipRun;
            arg2.correctionHipRunDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionHipRun = loc3;
            }
            loc3 = loc1.correctionHipWalk;
            arg2.correctionHipWalkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionHipWalk = loc3;
            }
            loc3 = loc1.description;
            arg2.descriptionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.description = loc3;
            }
            loc3 = loc1.distance;
            arg2.distanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distance = loc3;
            }
            loc3 = loc1.distanceDownhill;
            arg2.distanceDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceDownhill = loc3;
            }
            loc3 = loc1.distanceMinus;
            arg2.distanceMinusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceMinus = loc3;
            }
            loc3 = loc1.distancePlus;
            arg2.distancePlusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distancePlus = loc3;
            }
            loc3 = loc1.distancePlusMinusStatus;
            arg2.distancePlusMinusStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distancePlusMinusStatus = loc3;
            }
            loc3 = loc1.distanceUphill;
            arg2.distanceUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceUphill = loc3;
            }
            loc3 = loc1.exerciseTime;
            arg2.exerciseTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.exerciseTime = loc3;
            }
            loc3 = loc1.externalLink;
            arg2.externalLinkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.externalLink = loc3;
            }
            loc3 = loc1.fuelEconomy;
            arg2.fuelEconomyDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.fuelEconomy = loc3;
            }
            loc3 = loc1.tripSectionDistance;
            arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionDistance = loc3;
            }
            loc3 = loc1.tripSectionTime;
            arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionTime = loc3;
            }
            loc3 = loc1.gender;
            arg2.genderDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.gender = loc3;
            }
            loc3 = loc1.hrMax;
            arg2.hrMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.hrMax = loc3;
            }
            loc3 = loc1.intensityZone1Start;
            arg2.intensityZone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone1Start = loc3;
            }
            loc3 = loc1.intensityZone2Start;
            arg2.intensityZone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone2Start = loc3;
            }
            loc3 = loc1.intensityZone3Start;
            arg2.intensityZone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone3Start = loc3;
            }
            loc3 = loc1.intensityZone4Start;
            arg2.intensityZone4StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone4Start = loc3;
            }
            loc3 = loc1.intensityZone4End;
            arg2.intensityZone4EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone4End = loc3;
            }
            loc3 = loc1.latitudeEnd;
            arg2.latitudeEndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.latitudeEnd = loc3;
            }
            loc3 = loc1.latitudeStart;
            arg2.latitudeStartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.latitudeStart = loc3;
            }
            loc3 = loc1.linkedRouteId;
            arg2.linkedRouteIdDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.linkedRouteId = loc3;
            }
            loc3 = loc1.linkedTrackGUID;
            arg2.linkedTrackGUIDDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.linkedTrackGUID = loc3;
            }
            loc3 = loc1.longitudeEnd;
            arg2.longitudeEndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.longitudeEnd = loc3;
            }
            loc3 = loc1.longitudeStart;
            arg2.longitudeStartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.longitudeStart = loc3;
            }
            loc3 = loc1.lowerLimit;
            arg2.lowerLimitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.lowerLimit = loc3;
            }
            loc3 = loc1.manualTemperature;
            arg2.manualTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.manualTemperature = loc3;
            }
            loc3 = loc1.maximumAltitude;
            arg2.maximumAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumAltitude = loc3;
            }
            loc3 = loc1.maximumCadence;
            arg2.maximumCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumCadence = loc3;
            }
            loc3 = loc1.maximumHeartrate;
            arg2.maximumHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumHeartrate = loc3;
            }
            loc3 = loc1.maximumIncline;
            arg2.maximumInclineDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumIncline = loc3;
            }
            loc3 = loc1.maximumInclineDownhill;
            arg2.maximumInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumInclineDownhill = loc3;
            }
            loc3 = loc1.maximumInclineUphill;
            arg2.maximumInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumInclineUphill = loc3;
            }
            loc3 = loc1.maximumPercentHRMax;
            arg2.maximumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumPercentHRMax = loc3;
            }
            loc3 = loc1.maximumPower;
            arg2.maximumPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumPower = loc3;
            }
            loc3 = loc1.maximumRiseRate;
            arg2.maximumRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRate = loc3;
            }
            loc3 = loc1.maximumRiseRateDownhill;
            arg2.maximumRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRateDownhill = loc3;
            }
            loc3 = loc1.maximumRiseRateUphill;
            arg2.maximumRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRateUphill = loc3;
            }
            loc3 = loc1.maximumSpeed;
            arg2.maximumSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumSpeed = loc3;
            }
            loc3 = loc1.maximumTemperature;
            arg2.maximumTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumTemperature = loc3;
            }
            loc3 = loc1.measurement;
            arg2.speedUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.speedUnit = loc3;
            }
            loc3 = loc1.minimumAltitude;
            arg2.minimumAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumAltitude = loc3;
            }
            loc3 = loc1.minimumCadence;
            arg2.minimumCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumCadence = loc3;
            }
            loc3 = loc1.minimumHeartrate;
            arg2.minimumHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumHeartrate = loc3;
            }
            loc3 = loc1.minimumIncline;
            arg2.minimumInclineDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumIncline = loc3;
            }
            loc3 = loc1.minimumInclineUphill;
            arg2.minimumInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumInclineUphill = loc3;
            }
            loc3 = loc1.minimumInclineDownhill;
            arg2.minimumInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumInclineDownhill = loc3;
            }
            loc3 = loc1.minimumPercentHRMax;
            arg2.minimumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumPercentHRMax = loc3;
            }
            loc3 = loc1.minimumPower;
            arg2.minimumPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumPower = loc3;
            }
            loc3 = loc1.minimumRiseRate;
            arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRate = loc3;
            }
            loc3 = loc1.minimumRiseRateUphill;
            arg2.minimumRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRateUphill = loc3;
            }
            loc3 = loc1.minimumRiseRateDownhill;
            arg2.minimumRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRateDownhill = loc3;
            }
            loc3 = loc1.minimumSpeed;
            arg2.minimumSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumSpeed = loc3;
            }
            loc3 = loc1.minimumTemperature;
            arg2.minimumTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumTemperature = loc3;
            }
            loc3 = utils.format.CDATAFormat.getCDataAsXMLNode("name", loc1.name);
            arg2.name = loc3;
            loc3 = loc1.pageHeaderData;
            arg2.pageHeaderDataDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pageHeaderData = (loc3 as XMLList).toString().split(",");
            }
            loc3 = loc1.pauseTime;
            arg2.pauseTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pauseTime = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone1;
            arg2.percentTimeInIntensityZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone1 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone2;
            arg2.percentTimeInIntensityZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone2 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone3;
            arg2.percentTimeInIntensityZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone3 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone4;
            arg2.percentTimeInIntensityZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone4 = loc3;
            }
            loc3 = loc1.powerZone1Start;
            arg2.powerZone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone1Start = loc3;
            }
            loc3 = loc1.powerZone2Start;
            arg2.powerZone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone2Start = loc3;
            }
            loc3 = loc1.powerZone3Start;
            arg2.powerZone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone3Start = loc3;
            }
            loc3 = loc1.powerZone4Start;
            arg2.powerZone4StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone4Start = loc3;
            }
            loc3 = loc1.powerZone5Start;
            arg2.powerZone5StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone5Start = loc3;
            }
            loc3 = loc1.powerZone6Start;
            arg2.powerZone6StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone6Start = loc3;
            }
            loc3 = loc1.powerZone7End;
            arg2.powerZone7EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone7End = loc3;
            }
            loc3 = loc1.powerZone7Start;
            arg2.powerZone7StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone7Start = loc3;
            }
            loc3 = loc1.rating;
            arg2.ratingDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.rating = loc3;
            }
            loc3 = loc1.feeling;
            arg2.feelingDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.feeling = loc3;
            }
            loc3 = loc1.trainingTimeDownhill;
            arg2.trainingTimeDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTimeDownhill = loc3;
            }
            loc3 = loc1.trainingTimeUphill;
            arg2.trainingTimeUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTimeUphill = loc3;
            }
            loc3 = loc1.rxBatteryStatus;
            arg2.rxBatteryStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.rxBatteryStatus = loc3;
            }
            loc3 = loc1.samplingRate;
            arg2.samplingRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.samplingRate = loc3;
            }
            loc3 = loc1.shoulderWidth;
            arg2.shoulderWidthDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.shoulderWidth = loc3;
            }
            loc3 = loc1.shoulderWidthUnit;
            arg2.shoulderWidthUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.shoulderWidthUnit = loc3;
            }
            loc3 = loc1.startDate;
            arg2.startDateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.startDate = new Date(arg1.GeneralInformation.startDate.text().toString());
            }
            arg2.statistic = loc1.statistic.text().toString() != "true" ? false : true;
            loc3 = loc1.thresholdPower;
            arg2.thresholdPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.thresholdPower = loc3;
            }
            loc3 = loc1.timeInIntensityZone1;
            arg2.timeInIntensityZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone1 = loc3;
            }
            loc3 = loc1.timeInIntensityZone2;
            arg2.timeInIntensityZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone2 = loc3;
            }
            loc3 = loc1.timeInIntensityZone3;
            arg2.timeInIntensityZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone3 = loc3;
            }
            loc3 = loc1.timeInIntensityZone4;
            arg2.timeInIntensityZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone4 = loc3;
            }
            loc3 = loc1.timeInPowerZone1;
            arg2.timeInPowerZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone1 = loc3;
            }
            loc3 = loc1.timeInPowerZone2;
            arg2.timeInPowerZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone2 = loc3;
            }
            loc3 = loc1.timeInPowerZone3;
            arg2.timeInPowerZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone3 = loc3;
            }
            loc3 = loc1.timeInPowerZone4;
            arg2.timeInPowerZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone4 = loc3;
            }
            loc3 = loc1.timeInPowerZone5;
            arg2.timeInPowerZone5Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone5 = loc3;
            }
            loc3 = loc1.timeInPowerZone6;
            arg2.timeInPowerZone6Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone6 = loc3;
            }
            loc3 = loc1.timeInPowerZone7;
            arg2.timeInPowerZone7Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone7 = loc3;
            }
            loc3 = loc1.timeInTargetZone;
            arg2.timeInZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone = loc3;
            }
            loc3 = loc1.timeInZone1;
            arg2.timeInZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone1 = loc3;
            }
            loc3 = loc1.timeInZone2;
            arg2.timeInZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone2 = loc3;
            }
            loc3 = loc1.timeInZone3;
            arg2.timeInZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone3 = loc3;
            }
            loc3 = loc1.timeOverIntensityZone;
            arg2.timeOverIntensityZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeOverIntensityZone = loc3;
            }
            loc3 = loc1.timeOverTargetZone;
            arg2.timeOverZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeOverZone = loc3;
            }
            loc3 = loc1.timeUnderIntensityZone;
            arg2.timeUnderIntensityZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeUnderIntensityZone = loc3;
            }
            loc3 = loc1.timeUnderTargetZone;
            arg2.timeUnderZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeUnderZone = loc3;
            }
            loc3 = loc1.trackProfile;
            arg2.trackProfileDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trackProfile = loc3;
            }
            loc3 = loc1.trainingTime;
            arg2.trainingTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTime = loc3;
            }
            loc3 = loc1.trainingType;
            arg2.trainingTypeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingType = loc3;
            }
            loc3 = loc1.trainingZone;
            arg2.trainingZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingZone = loc3;
            }
            loc3 = loc1.tripSectionDistance;
            arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionDistance = loc3;
            }
            loc3 = loc1.tripSectionTime;
            arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionTime = loc3;
            }
            loc3 = loc1.txBatteryStatus;
            arg2.txBatteryStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.txBatteryStatus = loc3;
            }
            loc3 = loc1.upperLimit;
            arg2.upperLimitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.upperLimit = loc3;
            }
            loc3 = loc1.weather;
            arg2.weatherDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.weather = loc3;
            }
            loc3 = loc1.wheelSize;
            arg2.wheelSizeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.wheelSize = loc3;
            }
            loc3 = loc1.wind;
            arg2.windDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.wind = loc3;
            }
            loc3 = loc1.workInKJ;
            arg2.workInKJDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.workInKJ = loc3;
            }
            loc3 = loc1.zone1Start;
            arg2.zone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone1Start = loc3;
            }
            loc3 = loc1.zone2Start;
            arg2.zone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone2Start = loc3;
            }
            loc3 = loc1.zone3End;
            arg2.zone3EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone3End = loc3;
            }
            loc3 = loc1.zone3Start;
            arg2.zone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone3Start = loc3;
            }
            loc3 = loc1.chestbeltManufacturer;
            arg2.chestbeltManufacturerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.chestbeltManufacturer = loc3;
            }
            loc3 = loc1.withDevice;
            arg2.withDeviceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.withDevice = loc3;
            }
            loc3 = loc1.motionPoints;
            arg2.motionPointsDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.motionPoints = loc3;
            }
            loc3 = loc1.steps;
            arg2.stepsDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.steps = loc3;
            }
            loc3 = loc1.timeActiveLow;
            arg2.activeTimeLowDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeLow = loc3;
            }
            loc3 = loc1.timeActiveMiddle;
            arg2.activeTimeMiddleDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeMiddle = loc3;
            }
            loc3 = loc1.timeActiveHigh;
            arg2.activeTimeHighDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeHigh = loc3;
            }
            loc3 = loc1.timeDeepSleep;
            arg2.timeDeepSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeDeepSleep = loc3;
            }
            loc3 = loc1.timeLightSleep;
            arg2.timeLightSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeLightSleep = loc3;
            }
            loc3 = loc1.timeWakeUp;
            arg2.timeWakeUpDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeWakeUp = loc3;
            }
            loc3 = loc1.timeSleep;
            arg2.timeSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeSleep = loc3;
            }
            loc3 = loc1.percentDeepSleep;
            arg2.percentDeepSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentDeepSleep = loc3;
            }
            loc3 = loc1.percentLightSleep;
            arg2.percentLightSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentLightSleep = loc3;
            }
            loc3 = loc1.percentWakeUp;
            arg2.percentWakeUpDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentWakeUp = loc3;
            }
            loc3 = loc1.targetDay;
            arg2.targetDayDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.targetDay = loc3;
            }
            loc3 = loc1.best5KTime;
            arg2.best5KTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best5KTime = loc3;
            }
            loc3 = loc1.best5KEntry;
            arg2.best5KEntryDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best5KEntry = loc3;
            }
            loc3 = loc1.best20minPower;
            arg2.best20minPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best20minPower = loc3;
            }
            loc3 = loc1.best20minPowerEntry;
            arg2.best20minPowerEntryDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best20minPowerEntry = loc3;
            }
            loc3 = loc1.powerNP;
            arg2.powerNPDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerNP = loc3;
            }
            loc3 = loc1.powerTSS;
            arg2.powerTSSDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerTSS = loc3;
            }
            loc3 = loc1.powerFTP;
            arg2.powerFTPDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerFTP = loc3;
            }
            loc3 = loc1.pedalingTime;
            arg2.pedalingTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalingTime = loc3;
            }
            loc3 = loc1.pedalingIndex;
            arg2.pedalingIndexDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalingIndex = loc3;
            }
            loc3 = loc1.maximumExpansion;
            arg2.maximumExpansionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansion = loc3;
            }
            loc3 = loc1.maximumExpansionUphill;
            arg2.maximumExpansionUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansionUphill = loc3;
            }
            loc3 = loc1.maximumExpansionDownhill;
            arg2.maximumExpansionDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansionDownhill = loc3;
            }
            loc3 = loc1.averageBalanceRight;
            arg2.averageBalanceRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageBalanceRight = loc3;
            }
            loc3 = loc1.averageBalanceLeft;
            arg2.averageBalanceLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageBalanceLeft = loc3;
            }
            loc3 = loc1.powerIF;
            arg2.powerIFDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerIF = loc3;
            }
            loc3 = loc1.torqueEffectLeft;
            arg2.torqueEffectLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.torqueEffectLeft = loc3;
            }
            loc3 = loc1.torqueEffectRight;
            arg2.torqueEffectRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.torqueEffectRight = loc3;
            }
            loc3 = loc1.pedalSmoothLeft;
            arg2.pedalSmoothLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalSmoothLeft = loc3;
            }
            loc3 = loc1.pedalSmoothRight;
            arg2.pedalSmoothRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalSmoothRight = loc3;
            }
            loc3 = loc1.averageCadenceCalc;
            arg2.averageCadenceCalcDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageCadenceCalc = loc3;
            }
            loc3 = loc1.averagePowerCalc;
            arg2.averagePowerCalcDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerCalc = loc3;
            }
            var loc7:*=0;
            var loc6:*=arg1.GeneralInformation.Participant.Person;
            for each (var loc2:* in loc6) 
            {
                arg2.participant.push(core.participant.Person.createFromXML(loc2));
            }
            if ((loc3 = loc1.simpleHeaderValuesCalculation) != undefined) 
            {
                arg2.simpleHeaderValuesCalculation = loc1.simpleHeaderValuesCalculation.text().toString() != "true" ? false : true;
            }
            decodeSharingInformations(loc1.sharingInfo, arg2);
            var loc4:*;
            if (loc4 = core.activities.TrainingPartnerHandlerCommon.getInstance()) 
            {
                loc4.validatePersons(arg2.participant);
            }
            return;
        }

        internal static function retrieveDataTypeFromXMLRootNode(arg1:XML):String
        {
            var loc1:*=null;
            if (!(arg1.LogEntries == undefined) || !(arg1.Entries == undefined)) 
            {
                return "log";
            }
            return "memory";
        }

        internal static function generateEntries(arg1:core.activities.Activity):XML
        {
            var loc4:*=0;
            var loc2:*=null;
            var loc1:*=new XML("<Entries/>");
            var loc3:*=arg1.entries.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1.appendChild(core.activities.ActivityEntryMapper.generateXML(arg1.entries[loc4]));
                ++loc4;
            }
            return loc1;
        }

        internal static function generateMarkers(arg1:core.activities.Activity):XML
        {
            var loc4:*=0;
            var loc2:*=null;
            var loc3:*=new XML("<Markers/>");
            var loc1:*=arg1.markerList.length;
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc3.appendChild(core.marker.MarkerMapper.generateXML(arg1.markerList[loc4]));
                ++loc4;
            }
            return loc3;
        }

        internal static function getSecondsOf(arg1:String):Number
        {
            var loc1:*=0;
            var loc2:*=arg1.split(":");
            if (loc2.length == 3) 
            {
                loc1 = parseInt(loc2[0]) * 3600;
                loc1 = loc1 + parseInt(loc2[1]) * 60;
                loc1 = loc1 + parseInt(loc2[2]);
            }
            return loc1;
        }

        internal static function loadEntries(arg1:XML, arg2:core.activities.Activity, arg3:int):void
        {
            var loc3:*=0;
            var loc7:*=0;
            var loc1:*=null;
            arg2.entries.splice(0, arg2.entries.length);
            var loc4:*=false;
            var loc5:*=0;
            var loc8:*=0;
            if (arg3 < 400) 
            {
                loc1 = arg1.LogEntries.LogEntry;
            }
            else 
            {
                loc1 = arg1.Entries.Entry;
            }
            loc3 = loc1.length();
            if (arg2.calories > 0 && loc3 > 0 && (core.general.UnitType.ROX91.equals(arg2.unitType) || core.general.UnitType.RC1411.equals(arg2.unitType)) && 210 <= arg3 && arg3 <= 300) 
            {
                loc4 = true;
            }
            var loc6:*=null;
            var loc2:*=null;
            loc7 = 0;
            while (loc7 < loc3) 
            {
                loc6 = core.activities.ActivityFactory.createLogEntryFromLog(arg2);
                core.activities.ActivityEntryMapper.fromXML(loc1[loc7], loc2, arg3, loc6);
                if (loc4) 
                {
                    loc6.calories = utils.Calculations.calculateCalories(arg2, loc6, arg2.bikeWeightUnit);
                    loc6.caloriesDefined = true;
                    loc8 = loc8 + loc6.calories;
                }
                arg2.entries.push(loc6);
                loc2 = loc6;
                ++loc7;
            }
            if (loc4) 
            {
                arg2.caloriesDifferenceFactorDefined = true;
                utils.Calculations.calculateCaloriesDifferenceFactor(arg2, arg2.calories, loc8);
                arg2.calories = loc8;
                loc7 = 0;
                while (loc7 < loc3) 
                {
                    arg2.entries[loc7].calories = arg2.entries[loc7].calories - arg2.entries[loc7].calories * arg2.caloriesDifferenceFactor;
                    ++loc7;
                }
            }
            return;
        }

        public static const col_averagePowerWattPerKG:String="averagePowerWattPerKG";

        public static const col_averageRiseRate:String="averageRiseRate";

        public static const col_averageRiseRateDownhill:String="averageRiseRateDownhill";

        public static const col_averageRiseRateUphill:String="averageRiseRateUphill";

        public static const col_averageSpeed:String="averageSpeed";

        public static const col_averageSpeedDownhill:String="averageSpeedDownhill";

        public static const col_averageSpeedUphill:String="averageSpeedUphill";

        public static const col_averageTemperature:String="averageTemperature";

        public static const col_best20minPower:String="best20minPower";

        public static const col_best20minPowerEntry:String="best20minPowerEntry";

        public static const col_best5KEntry:String="best5KEntry";

        public static const col_best5KTime:String="best5KTime";

        public static const col_bike:String="bike";

        public static const col_bikeType:String="bikeType";

        public static const col_bikeWeight:String="bikeWeight";

        public static const col_bikeWeightUnit:String="bikeWeightUnit";

        public static const col_bodyHeight:String="bodyHeight";

        public static const col_bodyHeightUnit:String="bodyHeightUnit";

        public static const col_bodyWeight:String="bodyWeight";

        public static const col_bodyWeightUnit:String="bodyWeightUnit";

        public static const col_calibration:String="calibration";

        public static const col_calories:String="calories";

        public static const col_caloriesDifferenceFactor:String="caloriesDifferenceFactor";

        public static const col_chestbeltManufacturer:String="chestbeltManufacturer";

        public static const col_correctionChestRun:String="correctionChestRun";

        public static const col_correctionChestWalk:String="correctionChestWalk";

        public static const col_correctionFactor:String="correctionFactor";

        public static const col_correctionHipRun:String="correctionHipRun";

        public static const col_correctionHipWalk:String="correctionHipWalk";

        public static const col_dataType:String="dataType";

        public static const col_dateCode:String="dateCode";

        public static const col_dayActivity:String="dayActivity";

        public static const col_description:String="description";

        public static const col_distance:String="distance";

        public static const col_distanceDownhill:String="distanceDownhill";

        public static const col_distanceMinus:String="distanceMinus";

        public static const col_distancePlus:String="distancePlus";

        public static const col_distancePlusMinusStatus:String="distancePlusMinusStatus";

        public static const col_distanceUphill:String="distanceUphill";

        public static const col_exerciseTime:String="exerciseTime";

        public static const col_externalLink:String="externalLink";

        public static const col_feeling:String="feeling";

        public static const col_fuelEconomy:String="fuelEconomy";

        public static const col_gender:String="gender";

        public static const col_hrMax:String="hrMax";

        public static const col_intensityZone1Start:String="intensityZone1Start";

        public static const col_intensityZone2Start:String="intensityZone2Start";

        public static const col_intensityZone3Start:String="intensityZone3Start";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_intensityZone4Start:String="intensityZone4Start";

        public static const col_isDeleted:String="isDeleted";

        public static const col_latitudeEnd:String="latitudeEnd";

        public static const col_latitudeStart:String="latitudeStart";

        public static const col_linkedRouteId:String="linkedRouteId";

        public static const col_linkedTrackGUID:String="linkedTrackGUID";

        public static const col_logType:String="logType";

        public static const col_logVersion:String="logVersion";

        public static const col_longitudeEnd:String="longitudeEnd";

        public static const col_longitudeStart:String="longitudeStart";

        public static const col_lowerLimit:String="lowerLimit";

        public static const col_manualTemperature:String="manualTemperature";

        public static const col_maximumAltitude:String="maximumAltitude";

        public static const col_maximumCadence:String="maximumCadence";

        public static const col_maximumExpansion:String="maximumExpansion";

        public static const col_maximumExpansionDownhill:String="maximumExpansionDownhill";

        public static const col_maximumExpansionUphill:String="maximumExpansionUphill";

        public static const col_maximumHeartrate:String="maximumHeartrate";

        public static const col_maximumIncline:String="maximumIncline";

        public static const col_maximumInclineDownhill:String="maximumInclineDownhill";

        public static const col_maximumInclineUphill:String="maximumInclineUphill";

        public static const col_maximumPercentHRMax:String="maximumPercentHRMax";

        public static const col_maximumPower:String="maximumPower";

        public static const col_maximumRiseRate:String="maximumRiseRate";

        public static const col_maximumRiseRateDownhill:String="maximumRiseRateDownhill";

        public static const col_maximumRiseRateUphill:String="maximumRiseRateUphill";

        public static const col_maximumSpeed:String="maximumSpeed";

        public static const col_maximumTemperature:String="maximumTemperature";

        public static const col_measurement:String="measurement";

        public static const col_minimumAltitude:String="minimumAltitude";

        public static const col_minimumCadence:String="minimumCadence";

        public static const col_minimumHeartrate:String="minimumHeartrate";

        public static const col_minimumIncline:String="minimumIncline";

        public static const col_minimumInclineDownhill:String="minimumInclineDownhill";

        public static const col_minimumInclineUphill:String="minimumInclineUphill";

        public static const col_minimumPercentHRMax:String="minimumPercentHRMax";

        public static const col_minimumPower:String="minimumPower";

        public static const col_minimumRiseRate:String="minimumRiseRate";

        public static const col_minimumRiseRateDownhill:String="minimumRiseRateDownhill";

        public static const col_minimumRiseRateUphill:String="minimumRiseRateUphill";

        public static const col_minimumSpeed:String="minimumSpeed";

        public static const col_minimumTemperature:String="minimumTemperature";

        public static const col_modificationDate:String="modificationDate";

        public static const col_name:String="name";

        public static const col_pauseTime:String="pauseTime";

        public static const col_pedalSmoothLeft:String="pedalSmoothLeft";

        public static const col_pedalSmoothRight:String="pedalSmoothRight";

        public static const col_pedalingIndex:String="pedalingIndex";

        public static const col_pedalingTime:String="pedalingTime";

        public static const col_percentTimeInIntensityZone1:String="percentTimeInIntensityZone1";

        public static const col_percentTimeInIntensityZone2:String="percentTimeInIntensityZone2";

        public static const col_percentTimeInIntensityZone3:String="percentTimeInIntensityZone3";

        public static const col_percentTimeInIntensityZone4:String="percentTimeInIntensityZone4";

        public static const col_powerFTP:String="powerFTP";

        public static const col_powerIF:String="powerIF";

        public static const col_powerNP:String="powerNP";

        public static const col_powerTSS:String="powerTSS";

        public static const col_powerZone1Start:String="powerZone1Start";

        public static const col_powerZone2Start:String="powerZone2Start";

        public static const col_powerZone3Start:String="powerZone3Start";

        public static const col_powerZone4Start:String="powerZone4Start";

        public static const col_powerZone5Start:String="powerZone5Start";

        public static const col_powerZone6Start:String="powerZone6Start";

        public static const col_powerZone7End:String="powerZone7End";

        public static const col_powerZone7Start:String="powerZone7Start";

        public static const col_rating:String="rating";

        public static const col_rxBatteryStatus:String="rxBatteryStatus";

        public static const col_samplingRate:String="samplingRate";

        public static const col_serialNumber:String="serialNumber";

        public static const col_sharingInformations:String="sharingInformations";

        public static const col_shoulderWidth:String="shoulderWidth";

        public static const col_shoulderWidthUnit:String="shoulderWidthUnit";

        public static const col_simpleHeaderValuesCalculation:String="simpleHeaderValuesCalculation";

        public static const col_sportId:String="sportId";

        public static const col_startDate:String="startDate";

        public static const col_statistic:String="statistic";

        public static const col_steps:String="steps";

        public static const col_targetDay:String="targetDay";

        public static const col_thresholdPower:String="thresholdPower";

        public static const col_timeDeepSleep:String="stepsHigh";

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

        public static const col_timeInZone:String="timeInZone";

        public static const col_timeInZone1:String="timeInZone1";

        public static const col_timeInZone2:String="timeInZone2";

        public static const col_timeInZone3:String="timeInZone3";

        public static const col_timeLightSleep:String="stepsMedium";

        public static const col_timeOverIntensityZone:String="timeOverIntensityZone";

        public static const col_timeOverZone:String="timeOverZone";

        public static const col_timeSleep:String="timeSleep";

        public static const col_timeUnderIntensityZone:String="timeUnderIntensityZone";

        public static const col_timeUnderZone:String="timeUnderZone";

        public static const col_timeWakeUp:String="stepsLow";

        public static const col_torqueEffectLeft:String="torqueEffectLeft";

        public static const col_torqueEffectRight:String="torqueEffectRight";

        public static const col_trackReferenceId:String="trackReferenceId";

        public static const col_trainingTime:String="trainingTime";

        public static const col_trainingTimeDownhill:String="trainingTimeDownhill";

        public static const col_trainingTimeUphill:String="trainingTimeUphill";

        public static const col_trainingType:String="trainingType";

        public static const col_trainingZone:String="trainingZone";

        public static const col_tripSectionDistance:String="tripSectionDistance";

        public static const col_tripSectionTime:String="tripSectionTime";

        public static const col_txBatteryStatus:String="txBatteryStatus";

        public static const col_unitId:String="unitId";

        public static const col_unitType:String="unitType";

        public static const col_upperLimit:String="upperLimit";

        public static const col_userId:String="userId";

        public static const col_weather:String="weather";

        public static const col_wheelSize:String="wheelSize";

        public static const col_wind:String="wind";

        public static const col_withDevice:String="withDevice";

        public static const col_workInKJ:String="workInKJ";

        public static const col_zone1Start:String="zone1Start";

        public static const col_zone2Start:String="zone2Start";

        public static const col_zone3End:String="zone3End";

        public static const col_zone3Start:String="zone3Start";

        public static const field_activeTimeHigh:String="activeTimeHigh";

        public static const field_activeTimeLow:String="activeTimeLow";

        public static const field_activeTimeMiddle:String="activeTimeMiddle";

        public static const field_steps:String="steps";

        public static const field_targetDay:String="targetDay";

        public static const field_timeDeepSleep:String="timeDeepSleep";

        public static const field_timeLightSleep:String="timeLightSleep";

        public static const col_trackProfile:String="trackProfile";

        public static const field_timeWakeUp:String="timeWakeUp";

        public static const table_name:String="Activity";

        public static const col_GUID:String="GUID";

        public static const col_activeTimeHigh:String="activTimeHigh";

        public static const col_activeTimeLow:String="activTimeLow";

        public static const col_activeTimeMiddle:String="activTimeMedium";

        public static const col_activityId:String="activityId";

        public static const col_activityStatus:String="activityStatus";

        public static const col_age:String="age";

        public static const col_altitudeDifferencesDownhill:String="altitudeDifferencesDownhill";

        public static const col_altitudeDifferencesUphill:String="altitudeDifferencesUphill";

        public static const col_averageAltitude:String="averageAltitude";

        public static const col_averageBalanceLeft:String="averageBalanceLeft";

        public static const col_averageBalanceRight:String="averageBalanceRight";

        public static const col_averageCadence:String="averageCadence";

        public static const col_averageCadenceCalc:String="averageCadenceCalc";

        public static const col_averageExpansion:String="averageExpansion";

        public static const col_averageExpansionDownhill:String="averageExpansionDownhill";

        public static const col_averageExpansionUphill:String="averageExpansionUphill";

        public static const col_averageHeartrate:String="averageHeartrate";

        public static const col_averageInclineDownhill:String="averageInclineDownhill";

        public static const col_averageInclineUphill:String="averageInclineUphill";

        public static const col_averagePercentHRMax:String="averagePercentHRMax";

        public static const col_averagePower:String="averagePower";

        public static const col_averagePowerCalc:String="averagePowerCalc";

        public static const col_averagePowerKJ:String="averagePowerKJ";

        public static const field_timeSleep:String="timeSleep";

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


