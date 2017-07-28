//class SettingsMapper
package core.settings 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.training.type.*;
    import core.units.*;
    import core.units.interfaces.*;
    import database.*;
    import handler.*;
    import utils.*;
    import utils.format.*;
    
    public class SettingsMapper extends Object
    {
        public function SettingsMapper()
        {
            super();
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Settings (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.settings.Settings):String
        {
            return "SELECT settingsId FROM Settings WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Settings");
                DB_TABLE_400.addColumns([["settingsId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["unitGUID", "VARCHAR", true], ["modificationDate", "NUMERIC", false], ["isDeleted", "BOOL", true], ["actualAltitude", "INTEGER", true], ["age", "INTEGER", true], ["alarm", "VARCHAR", true], ["alarmMode", "VARCHAR", true], ["altitudeReference", "VARCHAR", true], ["altitudeUnit", "VARCHAR", true], ["autoPause", "BOOL", true], ["autoZoomTrack", "BOOL", true], ["autoOffTime", "VARCHAR", true], ["backlightTime", "NUMERIC", true], ["bikeType1", "VARCHAR", true], ["bikeType2", "VARCHAR", true], ["bikeType3", "VARCHAR", true], ["bikeWeight1", "NUMERIC", true], ["bikeWeight1Unit", "VARCHAR", true], ["bikeWeight2", "NUMERIC", true], ["bikeWeight2Unit", "VARCHAR", true], ["bikeWeight3", "NUMERIC", true], ["birthDate", "VARCHAR", true], ["bodyHeight", "NUMERIC", true], ["bodyHeightUnit", "VARCHAR", true], ["bodyWeight", "NUMERIC", true], ["bodyWeightUnit", "VARCHAR", true], ["buttonInfo", "BOOL", true], ["buttonTone", "BOOL", true], ["calibration", "BOOL", true], ["clockMode", "VARCHAR", true], ["contrast", "INTEGER", true], ["correctionFactor", "NUMERIC", true], ["countdown", "NUMERIC", true], ["countdownOn", "BOOL", true], ["date", "VARCHAR", true], ["dateFormat", "VARCHAR", true], ["distanceUnit", "VARCHAR", true], ["endZone3", "INTEGER", true], ["favoritesAltitude1_1_A", "VARCHAR", true], ["favoritesAltitude1_1_B", "VARCHAR", true], ["favoritesAltitude1_2_A", "VARCHAR", true], ["favoritesAltitude1_2_B", "VARCHAR", true], ["favoritesAltitude1_3_A", "VARCHAR", true], ["favoritesAltitude1_3_B", "VARCHAR", true], ["favoritesAltitude2_1_A", "VARCHAR", true], ["favoritesAltitude2_1_B", "VARCHAR", true], ["favoritesAltitude2_2_A", "VARCHAR", true], ["favoritesAltitude2_2_B", "VARCHAR", true], ["favoritesAltitude2_3_A", "VARCHAR", true], ["favoritesAltitude2_3_B", "VARCHAR", true], ["favoritesLap1_1_A", "VARCHAR", true], ["favoritesLap1_1_B", "VARCHAR", true], ["favoritesLap1_2_A", "VARCHAR", true], ["favoritesLap1_2_B", "VARCHAR", true], ["favoritesLap1_3_A", "VARCHAR", true], ["favoritesLap1_3_B", "VARCHAR", true], ["favoritesLap2_1_A", "VARCHAR", true], ["favoritesLap2_1_B", "VARCHAR", true], ["favoritesLap2_2_A", "VARCHAR", true], ["favoritesLap2_2_B", "VARCHAR", true], ["favoritesLap2_3_A", "VARCHAR", true], ["favoritesLap2_3_B", "VARCHAR", true], ["favoritesSelected", "INTEGER", true], ["favoritesTrack1_1_A", "VARCHAR", true], ["favoritesTrack1_1_B", "VARCHAR", true], ["favoritesTrack1_2_A", "VARCHAR", true], ["favoritesTrack1_2_B", "VARCHAR", true], ["favoritesTrack1_3_A", "VARCHAR", true], ["favoritesTrack1_3_B", "VARCHAR", true], ["favoritesTrack2_1_A", "VARCHAR", true], ["favoritesTrack2_1_B", "VARCHAR", true], ["favoritesTrack2_2_A", "VARCHAR", true], ["favoritesTrack2_2_B", "VARCHAR", true], ["favoritesTrack2_3_A", "VARCHAR", true], ["favoritesTrack2_3_B", "VARCHAR", true], ["favoritesCustomA_PageCount", "INTEGER", true], ["favoritesCustom1_A", "VARCHAR", true], ["favoritesCustom2_A", "VARCHAR", true], ["favoritesCustom3_A", "VARCHAR", true], ["favoritesCustom4_A", "VARCHAR", true], ["favoritesCustom5_A", "VARCHAR", true], ["favoritesCustom6_A", "VARCHAR", true], ["favoritesCustomB_PageCount", "INTEGER", true], ["favoritesCustom1_B", "VARCHAR", true], ["favoritesCustom2_B", "VARCHAR", true], ["favoritesCustom3_B", "VARCHAR", true], ["favoritesCustom4_B", "VARCHAR", true], ["favoritesCustom5_B", "VARCHAR", true], ["favoritesCustom6_B", "VARCHAR", true], ["favoritesTrip1_0", "VARCHAR", true], ["favoritesTrip1_1", "VARCHAR", true], ["favoritesTrip1_2", "VARCHAR", true], ["favoritesTrip1_3", "VARCHAR", true], ["favoritesTrip1_4", "VARCHAR", true], ["favoritesTrip1_5", "VARCHAR", true], ["favoritesTrip1_6", "VARCHAR", true], ["favoritesTrip1_7", "VARCHAR", true], ["favoritesTrip1_8", "VARCHAR", true], ["favoritesTrip1_9", "VARCHAR", true], ["favoritesTrip2_0", "VARCHAR", true], ["favoritesTrip2_1", "VARCHAR", true], ["favoritesTrip2_2", "VARCHAR", true], ["favoritesTrip2_3", "VARCHAR", true], ["favoritesTrip2_4", "VARCHAR", true], ["favoritesTrip2_5", "VARCHAR", true], ["favoritesTrip2_6", "VARCHAR", true], ["favoritesTrip2_7", "VARCHAR", true], ["favoritesTrip2_8", "VARCHAR", true], ["favoritesTrip2_9", "VARCHAR", true], ["freeTrainingTargetZone", "VARCHAR", true], ["freeTrainingTargetZoneLowerLimit", "INTEGER", true], ["freeTrainingTargetZoneUpperLimit", "INTEGER", true], ["fuelConsumption", "NUMERIC", true], ["gender", "VARCHAR", true], ["gpsFormat", "VARCHAR", true], ["gpsStatus", "BOOL", true], ["homeAltitude1", "INTEGER", true], ["homeAltitude2", "INTEGER", true], ["homeAltitude3", "INTEGER", true], ["hrMax", "INTEGER", true], ["intensityZone1", "INTEGER", true], ["intensityZone2", "INTEGER", true], ["intensityZone3", "INTEGER", true], ["intensityZone4", "INTEGER", true], ["intensityZone4End", "INTEGER", true], ["intervalCoolDownTargetZoneLowerLimit", "INTEGER", true], ["intervalCoolDownTargetZoneUpperLimit", "INTEGER", true], ["intervalCoolDownTime", "INTEGER", true], ["intervalRecoveryHR", "INTEGER", true], ["intervalRecoveryMode", "VARCHAR", true], ["intervalRecoveryTime", "INTEGER", true], ["intervalTargetZoneLowerLimit", "INTEGER", true], ["intervalTargetZoneUpperLimit", "INTEGER", true], ["intervalTime", "INTEGER", true], ["intervalWarmUpTargetZoneLowerLimit", "INTEGER", true], ["intervalWarmUpTargetZoneUpperLimit", "INTEGER", true], ["intervalWarmUpTime", "INTEGER", true], ["language", "VARCHAR", true], ["lowBatDetectLevel", "VARCHAR", true], ["lowerLimit", "INTEGER", true], ["measurement", "VARCHAR", true], ["myName", "VARCHAR", true], ["name", "VARCHAR", true], ["offTrackAlarm", "NUMERIC", true], ["powerMeterFormula", "INTEGER", true], ["powerTargetZoneEnabled", "BOOL", true], ["powerTargetZoneLowerLimit", "INTEGER", true], ["powerTargetZoneUpperLimit", "INTEGER", true], ["powerIntensityZone1Start", "INTEGER", true], ["powerIntensityZone2Start", "INTEGER", true], ["powerIntensityZone3Start", "INTEGER", true], ["powerIntensityZone4Start", "INTEGER", true], ["powerIntensityZone5Start", "INTEGER", true], ["powerIntensityZone6Start", "INTEGER", true], ["powerIntensityZone7Start", "INTEGER", true], ["powerIntensityZone7End", "INTEGER", true], ["samplingRate", "NUMERIC", true], ["scanFlagOn", "BOOL", true], ["seaLevel", "NUMERIC", true], ["serviceInterval", "INTEGER", true], ["serviceStatusOn", "BOOL", true], ["shoulderWidth", "NUMERIC", true], ["shoulderWidthUnit", "VARCHAR", true], ["showTotals", "INTEGER", true], ["startZone1", "INTEGER", true], ["startZone2", "INTEGER", true], ["startZone3", "INTEGER", true], ["summerTime", "BOOL", true], ["systemTone", "BOOL", true], ["temperatureUnit", "VARCHAR", true], ["timeZone", "INTEGER", true], ["trainingZone", "VARCHAR", true], ["upperLimit", "INTEGER", true], ["volume", "INTEGER", true], ["waypointAlarm", "NUMERIC", true], ["wheelSize1", "INTEGER", true], ["wheelSize2", "INTEGER", true], ["wheelSize3", "INTEGER", true], ["yearOfBirth", "INTEGER", true], ["zoneAlarm", "BOOL", true], ["phaseAlarm", "BOOL", true], ["keyLock", "BOOL", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true], ["emptyField5", "VARCHAR", true], ["emptyField6", "VARCHAR", true], ["emptyField7", "VARCHAR", true], ["emptyField8", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function fromDB(arg1:core.settings.Settings, arg2:Object):void
        {
            var loc6:*=0;
            var loc7:*=0;
            var loc1:*=undefined;
            var loc8:*=undefined;
            var loc2:*=undefined;
            var loc4:*=undefined;
            var loc5:*=undefined;
            arg1.settingsId = arg2["settingsId"];
            arg1.GUID = arg2["GUID"];
            arg1.unitGUID = arg2["unitGUID"];
            arg1.modificationDate = arg2.modificationDate;
            arg1.isDeleted = arg2.isDeleted;
            arg1.date = new Date(arg2["date"]);
            arg1.name = arg2["name"];
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                var loc9:*;
                (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude = loc9 = arg2["actualAltitude"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAge) 
            {
                (arg1 as core.settings.interfaces.IAge).age = loc9 = arg2["age"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarm) 
            {
                (arg1 as core.settings.interfaces.IAlarm).alarm = loc9 = new Date(arg2["alarm"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                (arg1 as core.settings.interfaces.IAlarmMode).alarmMode = loc9 = arg2["alarmMode"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference = loc9 = arg2["altitudeReference"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit = loc9 = arg2["altitudeUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                (arg1 as core.settings.interfaces.IAutoPause).autoPause = loc9 = arg2["autoPause"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack = loc9 = arg2["autoZoomTrack"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoOffTime) 
            {
                (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime = loc9 = core.general.AutoOffTimeUnit.fromString(arg2["autoOffTime"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                (arg1 as core.settings.interfaces.IBacklightTime).backlightTime = loc9 = arg2["backlightTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel = loc9 = arg2["backlightLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                (arg1 as core.settings.interfaces.IBikeType1).bikeType1 = loc9 = arg2["bikeType1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                (arg1 as core.settings.interfaces.IBikeType2).bikeType2 = loc9 = arg2["bikeType2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                (arg1 as core.settings.interfaces.IBikeType3).bikeType3 = loc9 = arg2["bikeType3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = loc9 = arg2["bikeWeight1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit = loc9 = arg2["bikeWeight1Unit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2 = loc9 = arg2["bikeWeight2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit = loc9 = arg2["bikeWeight2Unit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3 = loc9 = arg2["bikeWeight3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                (arg1 as core.settings.interfaces.IBirthDate).birthDate = loc9 = new Date(arg2["birthDate"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight = loc9 = arg2["bodyHeight"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit = loc9 = arg2["bodyHeightUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight = loc9 = arg2["bodyWeight"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit = loc9 = arg2["bodyWeightUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo = loc9 = arg2["buttonInfo"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                (arg1 as core.settings.interfaces.IButtonTone).buttonTone = loc9 = arg2["buttonTone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                (arg1 as core.settings.interfaces.ICalibration).calibration = loc9 = arg2["calibration"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                (arg1 as core.settings.interfaces.IClockMode).clockMode = loc9 = arg2["clockMode"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                (arg1 as core.settings.interfaces.IContrast).contrast = loc9 = arg2["contrast"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor = loc9 = arg2["correctionFactor"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                (arg1 as core.settings.interfaces.ICountdown).countdown = loc9 = arg2["countdown"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                (arg1 as core.settings.interfaces.ICountdown).countdownOn = loc9 = arg2["countdownOn"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                (arg1 as core.settings.interfaces.IDateFormat).dateFormat = loc9 = arg2["dateFormat"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit = loc9 = arg2["distanceUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).endZone3 = loc9 = arg2["endZone3"];
            }
            undefined;
            if (arg1 is core.settings.SettingsROX100) 
            {
                (arg1 as core.settings.SettingsROX100).favoritesSelected = loc9 = arg2["favoritesSelected"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc9 = arg2["fuelConsumption"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit = loc9 = arg2["fuelConsumptionUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone = loc9 = arg2["freeTrainingTargetZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit = loc9 = arg2["freeOwnZone1LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit = loc9 = arg2["freeOwnZone1UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit = loc9 = arg2["freeOwnZone2LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit = loc9 = arg2["freeOwnZone2UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit = loc9 = arg2["freeOwnZone3LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit = loc9 = arg2["freeOwnZone3UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGender) 
            {
                (arg1 as core.settings.interfaces.IGender).gender = loc9 = arg2["gender"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat = loc9 = arg2["gpsFormat"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus = loc9 = arg2["gpsStatus"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled = loc9 = arg2["stravaSegmentsEnabled"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                (arg1 as core.settings.interfaces.ITrackDirection).trackDirection = loc9 = arg2["trackDirection"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = loc9 = arg2["homeAltitude1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = loc9 = arg2["homeAltitude2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 = loc9 = arg2["homeAltitude3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                (arg1 as core.settings.interfaces.IHRmax).hrMax = loc9 = arg2["hrMax"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = loc9 = arg2["intensityZone1"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = loc9 = arg2["intensityZone2"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = loc9 = arg2["intensityZone3"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = loc9 = arg2["intensityZone4End"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = loc9 = arg2["intensityZone4"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit = loc9 = arg2["intervalCoolDownTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit = loc9 = arg2["intervalCoolDownTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime = loc9 = arg2["intervalCoolDownTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR = loc9 = arg2["intervalRecoveryHR"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode = loc9 = core.training.type.PhaseControl.fromString(arg2["intervalRecoveryMode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime = loc9 = arg2["intervalRecoveryTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit = loc9 = arg2["intervalTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit = loc9 = arg2["intervalTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime = loc9 = arg2["intervalTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit = loc9 = arg2["intervalWarmUpTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit = loc9 = arg2["intervalWarmUpTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime = loc9 = arg2["intervalWarmUpTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                (arg1 as core.settings.interfaces.ILanguage).language = loc9 = arg2["language"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel = loc9 = arg2["lowBatDetectLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit = loc9 = arg2["lowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive = loc9 = arg2["heartrateSensorActive"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = loc9 = arg2["cadenceSensorActive"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                (arg1 as core.settings.interfaces.IMyName).myName = loc9 = arg2["myName"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm = loc9 = arg2["offTrackAlarm"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula = loc9 = arg2["powerMeterFormula"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled = loc9 = arg2["powerTargetZoneEnabled"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit = loc9 = arg2["powerTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit = loc9 = arg2["powerTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = loc9 = arg2["powerIntensityZone1Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = loc9 = arg2["powerIntensityZone2Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = loc9 = arg2["powerIntensityZone3Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = loc9 = arg2["powerIntensityZone4Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = loc9 = arg2["powerIntensityZone5Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = loc9 = arg2["powerIntensityZone6Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = loc9 = arg2["powerIntensityZone7Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                (arg1 as core.settings.interfaces.ISamplingRate).samplingRate = loc9 = arg2["samplingRate"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                arg2["scanFlagOn"] = loc9 = 0;
                (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn = loc9 = loc9 ? false : true;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                (arg1 as core.settings.interfaces.ISeaLevel).seaLevel = loc9 = arg2["seaLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                (arg1 as core.settings.interfaces.IService).serviceInterval = loc9 = arg2["serviceInterval"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                (arg1 as core.settings.interfaces.IService).serviceStatusOn = loc9 = arg2["serviceInterval"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth = loc9 = arg2["shoulderWidth"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit = loc9 = arg2["shoulderWidthUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                (arg1 as core.settings.interfaces.IShowTotals).showTotals = loc9 = arg2["showTotals"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit = loc9 = arg2["speedUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone1 = loc9 = arg2["startZone1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone2 = loc9 = arg2["startZone2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone3 = loc9 = arg2["startZone3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                (arg1 as core.settings.interfaces.ISummerTime).summerTime = loc9 = arg2["summerTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                (arg1 as core.settings.interfaces.ISystemTone).systemTone = loc9 = arg2["systemTone"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit = loc9 = arg2["temperatureUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                (arg1 as core.settings.interfaces.ITimeZone).timeZone = loc9 = arg2["timeZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                (arg1 as core.settings.interfaces.ITireSize1).tireSize1 = loc9 = core.general.TireSize.fromString(arg2["tireSize1"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                (arg1 as core.settings.interfaces.ITireSize2).tireSize2 = loc9 = core.general.TireSize.fromString(arg2["tireSize2"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                (arg1 as core.settings.interfaces.ITrainingZone).trainingZone = loc9 = arg2["trainingZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit = loc9 = arg2["upperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                (arg1 as core.settings.interfaces.IVolume).volume = loc9 = arg2["volume"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm = loc9 = arg2["waypointAlarm"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc9 = arg2["wheelSize1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2 = loc9 = arg2["wheelSize2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3 = loc9 = arg2["wheelSize3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode = loc9 = core.general.WheelSizeSelectionMode.fromString(arg2["wheelSize1Mode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode = loc9 = core.general.WheelSizeSelectionMode.fromString(arg2["wheelSize2Mode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth = loc9 = arg2["yearOfBirth"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm = loc9 = arg2["zoneAlarm"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm = loc9 = arg2["phaseAlarm"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                (arg1 as core.settings.interfaces.IKeyLock).keyLock = loc9 = arg2["keyLock"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = loc9 = arg2["powerSaveModeActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                (arg1 as core.settings.interfaces.IBacklight).backlightActive = loc9 = arg2["backlightActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc9 = new Date(arg2["backlightTimeOn"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc9 = new Date(arg2["backlightTimeOff"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.INfc) 
            {
                (arg1 as core.settings.interfaces.INfc).nfcActive = loc9 = arg2["nfcActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                (arg1 as core.settings.interfaces.IETADistance).etaDistance = loc9 = arg2["etaDistance"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = loc9 = arg2["etaArivalFlag"] != 0 ? true : false;
            }
            undefined;
            var loc3:*=0;
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1 = new __AS3__.vec.Vector.<String>((arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size, true);
                loc6 = 0;
                while (loc6 < (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc6] = arg2["favoritesTrip1_" + loc6];
                    ++loc6;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2 = new __AS3__.vec.Vector.<String>((arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size, true);
                loc7 = 0;
                while (loc7 < (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc7] = arg2["favoritesTrip2_" + loc7];
                    ++loc7;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoritesTrack) 
            {
                loc1 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true);
                loc1[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc1[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][0][0] = arg2["favoritesTrack1_1_A"];
                loc1[0][0][1] = arg2["favoritesTrack1_1_B"];
                loc1[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][1][0] = arg2["favoritesTrack1_2_A"];
                loc1[0][1][1] = arg2["favoritesTrack1_2_B"];
                loc1[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][2][0] = arg2["favoritesTrack1_3_A"];
                loc1[0][2][1] = arg2["favoritesTrack1_3_B"];
                loc1[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc1[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][0][0] = arg2["favoritesTrack2_1_A"];
                loc1[1][0][1] = arg2["favoritesTrack2_1_B"];
                loc1[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][1][0] = arg2["favoritesTrack2_2_A"];
                loc1[1][1][1] = arg2["favoritesTrack2_2_B"];
                loc1[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][2][0] = arg2["favoritesTrack2_3_A"];
                loc1[1][2][1] = arg2["favoritesTrack2_3_B"];
                (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack = loc1;
            }
            if (arg1 is core.settings.interfaces.IFavoritesCustom) 
            {
                (loc8 = new __AS3__.vec.Vector.<int>(2, true))[0] = arg2["favoritesCustomA_PageCount"];
                loc8[1] = arg2["favoritesCustomB_PageCount"];
                (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount = loc8;
                (loc2 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(2, true))[0] = new __AS3__.vec.Vector.<String>(6, true);
                loc2[0][0] = arg2["favoritesCustom1_A"];
                loc2[0][1] = arg2["favoritesCustom2_A"];
                loc2[0][2] = arg2["favoritesCustom3_A"];
                loc2[0][3] = arg2["favoritesCustom4_A"];
                loc2[0][4] = arg2["favoritesCustom5_A"];
                loc2[0][5] = arg2["favoritesCustom6_A"];
                loc2[1] = new __AS3__.vec.Vector.<String>(6, true);
                loc2[1][0] = arg2["favoritesCustom1_B"];
                loc2[1][1] = arg2["favoritesCustom2_B"];
                loc2[1][2] = arg2["favoritesCustom3_B"];
                loc2[1][3] = arg2["favoritesCustom4_B"];
                loc2[1][4] = arg2["favoritesCustom5_B"];
                loc2[1][5] = arg2["favoritesCustom6_B"];
                (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom = loc2;
            }
            if (arg1 is core.settings.interfaces.IFavoritesAltitude) 
            {
                (loc4 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true))[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc4[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][0][0] = arg2["favoritesAltitude1_1_A"];
                loc4[0][0][1] = arg2["favoritesAltitude1_1_B"];
                loc4[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][1][0] = arg2["favoritesAltitude1_2_A"];
                loc4[0][1][1] = arg2["favoritesAltitude1_2_B"];
                loc4[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][2][0] = arg2["favoritesAltitude1_3_A"];
                loc4[0][2][1] = arg2["favoritesAltitude1_3_B"];
                loc4[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc4[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][0][0] = arg2["favoritesAltitude2_1_A"];
                loc4[1][0][1] = arg2["favoritesAltitude2_1_B"];
                loc4[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][1][0] = arg2["favoritesAltitude2_2_A"];
                loc4[1][1][1] = arg2["favoritesAltitude2_2_B"];
                loc4[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][2][0] = arg2["favoritesAltitude2_3_A"];
                loc4[1][2][1] = arg2["favoritesAltitude2_3_B"];
                (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude = loc4;
            }
            if (arg1 is core.settings.interfaces.IFavoritesLap) 
            {
                (loc5 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true))[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc5[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][0][0] = arg2["favoritesLap1_1_A"];
                loc5[0][0][1] = arg2["favoritesLap1_1_B"];
                loc5[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][1][0] = arg2["favoritesLap1_2_A"];
                loc5[0][1][1] = arg2["favoritesLap1_2_B"];
                loc5[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][2][0] = arg2["favoritesLap1_3_A"];
                loc5[0][2][1] = arg2["favoritesLap1_3_B"];
                loc5[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc5[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][0][0] = arg2["favoritesLap2_1_A"];
                loc5[1][0][1] = arg2["favoritesLap2_1_B"];
                loc5[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][1][0] = arg2["favoritesLap2_2_A"];
                loc5[1][1][1] = arg2["favoritesLap2_2_B"];
                loc5[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][2][0] = arg2["favoritesLap2_3_A"];
                loc5[1][2][1] = arg2["favoritesLap2_3_B"];
                (arg1 as core.settings.SettingsROX100).favoritesLap = loc5;
            }
            return;
        }

        public static function selectSettings(arg1:String, arg2:String="modificationDate", arg3:Boolean=false):String
        {
            return "SELECT * FROM Settings where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Settings SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDOnSettings ON Settings (unitGUID)";
            return loc1;
        }

        public static function fromXML(arg1:XML, arg2:core.settings.Settings):void
        {
            var loc9:*=undefined;
            var loc1:*=null;
            var loc5:*=0;
            var loc8:*=0;
            var loc2:*=undefined;
            var loc4:*=null;
            var loc3:*=undefined;
            var loc6:*=undefined;
            var loc7:*=undefined;
            var loc10:*;
            if ((loc10 = arg1.name()).localName != "SettingInformation") 
            {
                return;
            }
            if (arg1.GeneralInformation.GUID != undefined) 
            {
                arg2.GUID = arg1.GeneralInformation.GUID;
            }
            if (arg1.GeneralInformation.unitGUID != undefined) 
            {
                arg2.unitGUID = arg1.GeneralInformation.unitGUID;
                arg2.unit = handler.AppDeviceHandlerCommon.deviceDicGUID[arg2.unitGUID];
            }
            if (arg1.GeneralInformation.modificationDate != undefined) 
            {
                arg2.modificationDate = arg1.GeneralInformation.modificationDate;
            }
            if (arg2 is core.settings.interfaces.IActualAltitude) 
            {
                (arg2 as core.settings.interfaces.IActualAltitude).actualAltitude = arg1.SettingValues.ActualAltitude;
            }
            if (arg2 is core.settings.interfaces.IAge) 
            {
                (arg2 as core.settings.interfaces.IAge).age = arg1.SettingValues.Age;
            }
            if (arg2 is core.settings.interfaces.IAlarm) 
            {
                (arg2 as core.settings.interfaces.IAlarm).alarm = new Date(arg1.SettingValues.Alarm.text().toString());
            }
            if (arg2 is core.settings.interfaces.IAlarmMode) 
            {
                (arg2 as core.settings.interfaces.IAlarmMode).alarmMode = arg1.SettingValues.AlarmMode;
            }
            if (arg2 is core.settings.interfaces.IAltitudeReference) 
            {
                if ((loc9 = arg1.SettingValues.AltitudeReference) == undefined) 
                {
                    loc9 = arg1.SettingValues.ReferenceMark;
                }
                (arg2 as core.settings.interfaces.IAltitudeReference).altitudeReference = loc9;
            }
            if (arg2 is core.settings.interfaces.IAltitudeUnit) 
            {
                (arg2 as core.settings.interfaces.IAltitudeUnit).altitudeUnit = arg1.SettingValues.AltitudeUnit;
            }
            if (arg2 is core.settings.interfaces.IAutoPause) 
            {
                (arg2 as core.settings.interfaces.IAutoPause).autoPause = arg1.SettingValues.AutoPause != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IAutoZoomTrack) 
            {
                (arg2 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack = arg1.SettingValues.AutoZoomTrack != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IAutoOffTime) 
            {
                (arg2 as core.settings.interfaces.IAutoOffTime).autoOffTime = core.general.AutoOffTimeUnit.fromString(arg1.SettingValues.AutoOffTime);
            }
            if (arg2 is core.settings.interfaces.IBacklightTime) 
            {
                (arg2 as core.settings.interfaces.IBacklightTime).backlightTime = arg1.SettingValues.BacklightTime;
            }
            if (arg2 is core.settings.interfaces.IBikeType1) 
            {
                (arg2 as core.settings.interfaces.IBikeType1).bikeType1 = arg1.SettingValues.BikeType1;
            }
            if (arg2 is core.settings.interfaces.IBikeType2) 
            {
                (arg2 as core.settings.interfaces.IBikeType2).bikeType2 = arg1.SettingValues.BikeType2;
            }
            if (arg2 is core.settings.interfaces.IBikeType3) 
            {
                (arg2 as core.settings.interfaces.IBikeType3).bikeType3 = arg1.SettingValues.BikeType3;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = arg1.SettingValues.BikeWeight1;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit = arg1.SettingValues.BikeWeight1Unit;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight2) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight2).bikeWeight2 = arg1.SettingValues.BikeWeight2;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit = arg1.SettingValues.BikeWeight2Unit;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight3) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight3).bikeWeight3 = arg1.SettingValues.BikeWeight3;
            }
            if (arg2 is core.settings.interfaces.IBirthDate) 
            {
                (arg2 as core.settings.interfaces.IBirthDate).birthDate = new Date(arg1.SettingValues.BirthDate.text().toString());
            }
            if (arg2 is core.settings.interfaces.IBodyHeight) 
            {
                (arg2 as core.settings.interfaces.IBodyHeight).bodyHeight = arg1.SettingValues.BodyHeight;
            }
            if (arg2 is core.settings.interfaces.IBodyHeightUnit) 
            {
                (arg2 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit = arg1.SettingValues.BodyHeightUnit;
            }
            if (arg2 is core.settings.interfaces.IBodyWeight) 
            {
                if ((loc9 = arg1.SettingValues.BodyWeight) == undefined) 
                {
                    loc9 = arg1.SettingValues.Weight;
                }
                (arg2 as core.settings.interfaces.IBodyWeight).bodyWeight = loc9;
            }
            if (arg2 is core.settings.interfaces.IBodyWeightUnit) 
            {
                if ((loc9 = arg1.SettingValues.WeightUnit) == undefined) 
                {
                    loc9 = arg1.SettingValues.BodyWeightUnit;
                }
                (arg2 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit = loc9;
            }
            if (arg2 is core.settings.interfaces.IButtonInfo) 
            {
                (arg2 as core.settings.interfaces.IButtonInfo).buttonInfo = arg1.SettingValues.ButtonInfo != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IButtonTone) 
            {
                (arg2 as core.settings.interfaces.IButtonTone).buttonTone = arg1.SettingValues.ButtonTone != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ICalibration) 
            {
                (arg2 as core.settings.interfaces.ICalibration).calibration = arg1.SettingValues.Calibration != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IClockMode) 
            {
                (arg2 as core.settings.interfaces.IClockMode).clockMode = arg1.SettingValues.ClockMode;
            }
            if (arg2 is core.settings.interfaces.IContrast) 
            {
                (arg2 as core.settings.interfaces.IContrast).contrast = arg1.SettingValues.Contrast;
            }
            if (arg2 is core.settings.interfaces.ICorrectionFactor) 
            {
                (arg2 as core.settings.interfaces.ICorrectionFactor).correctionFactor = arg1.SettingValues.CorrectionFactor;
            }
            if (arg2 is core.settings.interfaces.ICountdown) 
            {
                (arg2 as core.settings.interfaces.ICountdown).countdown = arg1.SettingValues.Countdown;
                (arg2 as core.settings.interfaces.ICountdown).countdownOn = arg1.SettingValues.CountdownOn != "true" ? false : true;
            }
            arg2.date = new Date(Date.parse(arg1.SettingValues.Date + ""));
            if (arg2 is core.settings.interfaces.IDateFormat) 
            {
                (arg2 as core.settings.interfaces.IDateFormat).dateFormat = arg1.SettingValues.DateFormat;
            }
            if (arg2 is core.settings.interfaces.IDistanceUnit) 
            {
                (arg2 as core.settings.interfaces.IDistanceUnit).distanceUnit = arg1.SettingValues.DistanceUnit;
            }
            if (arg2 is core.settings.interfaces.IThreeZones) 
            {
                (arg2 as core.settings.interfaces.IThreeZones).endZone3 = arg1.SettingValues.EndZone3;
            }
            if (arg2 is core.settings.SettingsROX100) 
            {
                (arg2 as core.settings.SettingsROX100).favoritesSelected = arg1.SettingValues.FavoritesSelected;
            }
            if (arg2 is core.settings.interfaces.IFuelConsumption) 
            {
                (arg2 as core.settings.interfaces.IFuelConsumption).fuelConsumption = arg1.SettingValues.FuelConsumption;
            }
            if (arg2 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit = arg1.SettingValues.FuelConsumptionUnit;
            }
            if (arg2 is core.settings.interfaces.ITrainingFree) 
            {
                (arg2 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone = arg1.SettingValues.FreeTrainingTargetZone;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit = arg1.SettingValues.FreeOwnZone1LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone1LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit = arg1.SettingValues.FreeOwnZone1UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone1UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit = arg1.SettingValues.FreeOwnZone2LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone2LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit = arg1.SettingValues.FreeOwnZone2UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone2UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit = arg1.SettingValues.FreeOwnZone3LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone3LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit = arg1.SettingValues.FreeOwnZone3UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone3UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimitDefault;
            }
            loc9 = arg1.SettingValues.Gender;
            if (arg2 is core.settings.interfaces.IGender) 
            {
                (arg2 as core.settings.interfaces.IGender).gender = loc9;
            }
            if (arg2 is core.settings.interfaces.IGPSFormat) 
            {
                (arg2 as core.settings.interfaces.IGPSFormat).gpsFormat = arg1.SettingValues.GPSFormat;
            }
            if (arg2 is core.settings.interfaces.IGPSStatus) 
            {
                (arg2 as core.settings.interfaces.IGPSStatus).gpsStatus = arg1.SettingValues.GPSStatus != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                (arg2 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled = arg1.SettingValues.StravaSegmentsEnabled != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ITrackDirection) 
            {
                (arg2 as core.settings.interfaces.ITrackDirection).trackDirection = arg1.SettingValues.TrackDirection;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude1) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = arg1.SettingValues.HomeAltitude1;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude2) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = arg1.SettingValues.HomeAltitude2;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude3) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 = arg1.SettingValues.HomeAltitude3;
            }
            if (arg2 is core.settings.interfaces.IHRmax) 
            {
                (arg2 as core.settings.interfaces.IHRmax).hrMax = arg1.SettingValues.HrMax;
            }
            if (arg2 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = arg1.SettingValues.IntensityZone1;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = arg1.SettingValues.IntensityZone2;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = arg1.SettingValues.IntensityZone3;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = arg1.SettingValues.IntensityZone4End;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = arg1.SettingValues.IntensityZone4;
            }
            if (arg2 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit = arg1.SettingValues.IntervalCoolDownTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit = arg1.SettingValues.IntervalCoolDownTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime = arg1.SettingValues.IntervalCoolDownTime;
            }
            if (arg2 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR = arg1.SettingValues.IntervalRecoveryHR;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode = core.training.type.PhaseControl.fromString(arg1.SettingValues.IntervalRecoveryMode);
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime = arg1.SettingValues.IntervalRecoveryTime;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit = arg1.SettingValues.IntervalTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit = arg1.SettingValues.IntervalTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTime = arg1.SettingValues.intervalTime;
            }
            if (arg2 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit = arg1.SettingValues.IntervalWarmUpTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit = arg1.SettingValues.IntervalWarmUpTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime = arg1.SettingValues.IntervalWarmUpTime;
            }
            if (arg2 is core.settings.interfaces.ILanguage) 
            {
                (arg2 as core.settings.interfaces.ILanguage).language = arg1.SettingValues.Language;
            }
            if (arg2 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                (arg2 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel = arg1.SettingValues.LowBatteryDetectLevel;
            }
            if (arg2 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg2 as core.settings.interfaces.IHeartrateLimits).lowerLimit = arg1.SettingValues.LowerLimit;
            }
            if (arg2 is core.settings.interfaces.IHeartrateSensor) 
            {
                (arg2 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive = arg1.SettingValues.HeartrateSensorActive;
            }
            if (arg2 is core.settings.interfaces.ICadenceSensor) 
            {
                (arg2 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = arg1.SettingValues.CadenceSensorActive;
            }
            if (arg2 is core.settings.interfaces.IMyName) 
            {
                (arg2 as core.settings.interfaces.IMyName).myName = arg1.SettingValues.MyName;
            }
            arg2.name = arg1.SettingValues.Name;
            if (arg2 is core.settings.interfaces.IOffTrackAlarm) 
            {
                (arg2 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm = arg1.SettingValues.OffTrackAlarm;
            }
            if (arg2 is core.settings.interfaces.IPowerMeterFormula) 
            {
                (arg2 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula = arg1.SettingValues.PowerMeterFormula;
            }
            if (arg2 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled = arg1.SettingValues.PowerTargetZoneEnabled != "true" ? false : true;
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit = arg1.SettingValues.PowerTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit = arg1.SettingValues.PowerTargetZoneUpperLimit;
            }
            if (arg2 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = arg1.SettingValues.PowerIntensityZone1Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = arg1.SettingValues.PowerIntensityZone2Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = arg1.SettingValues.PowerIntensityZone3Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = arg1.SettingValues.PowerIntensityZone4Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = arg1.SettingValues.PowerIntensityZone5Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = arg1.SettingValues.PowerIntensityZone6Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = arg1.SettingValues.PowerIntensityZone7Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = arg1.SettingValues.PowerIntensityZone7End;
            }
            if (arg2 is core.settings.interfaces.ISamplingRate) 
            {
                (arg2 as core.settings.interfaces.ISamplingRate).samplingRate = arg1.SettingValues.SamplingRate;
            }
            if (arg2 is core.settings.interfaces.IAutoScan) 
            {
                (arg2 as core.settings.interfaces.IAutoScan).scanFlagOn = arg1.SettingValues.AutoScan != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ISeaLevel) 
            {
                (arg2 as core.settings.interfaces.ISeaLevel).seaLevel = arg1.SettingValues.SeaLevel;
            }
            if (arg2 is core.settings.interfaces.IService) 
            {
                (arg2 as core.settings.interfaces.IService).serviceInterval = arg1.SettingValues.ServiceInterval;
                (arg2 as core.settings.interfaces.IService).serviceStatusOn = arg1.SettingValues.ServiceStatus != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IShoulderWidth) 
            {
                (arg2 as core.settings.interfaces.IShoulderWidth).shoulderWidth = arg1.SettingValues.ShoulderWidth;
            }
            if (arg2 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                (arg2 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit = arg1.SettingValues.ShoulderWidthUnit;
            }
            if (arg2 is core.settings.interfaces.IShowTotals) 
            {
                (arg2 as core.settings.interfaces.IShowTotals).showTotals = arg1.SettingValues.ShowTotals;
            }
            if (arg2 is core.settings.interfaces.ISpeedUnit) 
            {
                (arg2 as core.settings.interfaces.ISpeedUnit).speedUnit = arg1.SettingValues.Measurement;
            }
            if (arg2 is core.settings.interfaces.IThreeZones) 
            {
                (arg2 as core.settings.interfaces.IThreeZones).startZone1 = arg1.SettingValues.StartZone1;
                (arg2 as core.settings.interfaces.IThreeZones).startZone2 = arg1.SettingValues.StartZone2;
                (arg2 as core.settings.interfaces.IThreeZones).startZone3 = arg1.SettingValues.StartZone3;
            }
            if (arg2 is core.settings.interfaces.ISummerTime) 
            {
                (arg2 as core.settings.interfaces.ISummerTime).summerTime = arg1.SettingValues.SummerTime != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ISystemTone) 
            {
                (arg2 as core.settings.interfaces.ISystemTone).systemTone = arg1.SettingValues.SystemTone != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ITrainingZone) 
            {
                if ((loc9 = arg1.SettingValues.TrainingZone) == undefined) 
                {
                    loc9 = arg1.SettingValues.TargetZone;
                }
                (arg2 as core.settings.interfaces.ITrainingZone).trainingZone = loc9;
            }
            if (arg2 is core.settings.interfaces.ITemperatureUnit) 
            {
                (arg2 as core.settings.interfaces.ITemperatureUnit).temperatureUnit = arg1.SettingValues.TemperatureUnit;
            }
            if (arg2 is core.settings.interfaces.ITimeZone) 
            {
                (arg2 as core.settings.interfaces.ITimeZone).timeZone = arg1.SettingValues.TimeZone;
            }
            arg2.unitType = core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            if (arg2 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg2 as core.settings.interfaces.IHeartrateLimits).upperLimit = arg1.SettingValues.UpperLimit;
            }
            if (arg2 is core.settings.interfaces.IVolume) 
            {
                (arg2 as core.settings.interfaces.IVolume).volume = arg1.SettingValues.Volume;
            }
            if (arg2 is core.settings.interfaces.IWayPointAlarm) 
            {
                (arg2 as core.settings.interfaces.IWayPointAlarm).waypointAlarm = arg1.SettingValues.WaypointAlarm;
            }
            if (arg2 is core.settings.interfaces.IWheelSize1) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1).wheelSize1 = arg1.SettingValues.WheelSize1;
            }
            if (arg2 is core.settings.interfaces.IWheelSize2) 
            {
                (arg2 as core.settings.interfaces.IWheelSize2).wheelSize2 = arg1.SettingValues.WheelSize2;
            }
            if (arg2 is core.settings.interfaces.IWheelSize3) 
            {
                (arg2 as core.settings.interfaces.IWheelSize3).wheelSize3 = arg1.SettingValues.WheelSize3;
            }
            if (arg2 is core.settings.interfaces.IWheelSize1Mode) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode = core.general.WheelSizeSelectionMode.fromString(arg1.SettingValues.WheelSize1Mode);
            }
            if (arg2 is core.settings.interfaces.IWheelSize2Mode) 
            {
                (arg2 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode = core.general.WheelSizeSelectionMode.fromString(arg1.SettingValues.WheelSize2Mode);
            }
            if (arg2 is core.settings.interfaces.ITireSize1) 
            {
                (arg2 as core.settings.interfaces.ITireSize1).tireSize1 = core.general.TireSize.fromString(arg1.SettingValues.TireSize1);
            }
            if (arg2 is core.settings.interfaces.ITireSize2) 
            {
                (arg2 as core.settings.interfaces.ITireSize2).tireSize2 = core.general.TireSize.fromString(arg1.SettingValues.TireSize2);
            }
            if (arg2 is core.settings.interfaces.IYearOfBirth) 
            {
                (arg2 as core.settings.interfaces.IYearOfBirth).yearOfBirth = arg1.SettingValues.YearOfBirth;
            }
            if (arg2 is core.settings.interfaces.IZoneAlarm) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.ZoneAlarm;
                }
                (arg2 as core.settings.interfaces.IZoneAlarm).zoneAlarm = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IPhaseAlarm) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.PhaseAlarm;
                }
                (arg2 as core.settings.interfaces.IPhaseAlarm).phaseAlarm = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IKeyLock) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.KeyLock;
                }
                (arg2 as core.settings.interfaces.IKeyLock).keyLock = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IPowerSaveMode) 
            {
                if ((loc9 = arg1.SettingValues.PowerSaveModeActive) == undefined) 
                {
                    loc9 = true;
                }
                (arg2 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IBacklight) 
            {
                if ((loc9 = arg1.SettingValues.BacklightActive) == undefined) 
                {
                    loc9 = false;
                }
                (arg2 as core.settings.interfaces.IBacklight).backlightActive = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOn) 
            {
                (arg2 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = new Date(arg1.SettingValues.BacklightTimeOn.text().toString());
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOff) 
            {
                (arg2 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = new Date(arg1.SettingValues.BacklightTimeOff.text().toString());
            }
            if (arg2 is core.settings.interfaces.INfc) 
            {
                if ((loc9 = arg1.SettingValues.NFCActive) != undefined) 
                {
                    (arg2 as core.settings.interfaces.INfc).nfcActive = loc9 != "true" ? false : true;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.INfc).nfcActive = true;
                }
            }
            if (arg2 is core.settings.interfaces.IETADistance) 
            {
                if ((loc9 = arg1.SettingValues.ETADistance) != undefined) 
                {
                    (arg2 as core.settings.interfaces.IETADistance).etaDistance = loc9;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.IETADistance).etaDistance = 0;
                }
            }
            if (arg2 is core.settings.interfaces.IETAArivalFlag) 
            {
                if ((loc9 = arg1.SettingValues.ETAArivalFlag) != undefined) 
                {
                    (arg2 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = loc9;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = false;
                }
            }
            loc1 = arg1.SettingValues.Favourites1.children();
            if (loc1.length() == 0) 
            {
                loc1 = arg1.SettingValues.FavouritesTrip1.children();
            }
            if (arg2 is core.settings.interfaces.IFavoriteTrip1) 
            {
                (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1 = new __AS3__.vec.Vector.<String>((arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size, true);
                loc8 = 0;
                while (loc8 < (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc8] = loc1[loc8];
                    ++loc8;
                }
            }
            loc1 = arg1.SettingValues.Favourites2.children();
            if (loc1.length() == 0) 
            {
                loc1 = arg1.SettingValues.FavouritesTrip2.children();
            }
            if (arg2 as core.settings.interfaces.IFavoriteTrip2) 
            {
                (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2 = new __AS3__.vec.Vector.<String>((arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size, true);
                loc8 = 0;
                while (loc8 < (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc8] = loc1[loc8];
                    ++loc8;
                }
            }
            if (arg2 is core.settings.SettingsROX100) 
            {
                (loc2 = (arg2 as core.settings.SettingsROX100).favoritesTrack).splice(0, 2);
                loc2[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc2[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][0][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1A.text().toString();
                loc2[0][0][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1B.text().toString();
                loc2[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][1][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2A.text().toString();
                loc2[0][1][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2B.text().toString();
                loc2[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][2][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3A.text().toString();
                loc2[0][2][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3B.text().toString();
                loc2[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc2[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][0][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1A.text().toString();
                loc2[1][0][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1B.text().toString();
                loc2[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][1][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2A.text().toString();
                loc2[1][1][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2B.text().toString();
                loc2[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][2][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3A.text().toString();
                loc2[1][2][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3B.text().toString();
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount = new __AS3__.vec.Vector.<int>(2, true);
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0] = parseInt(arg1.SettingValues.FavouritesCustomA_PageCount.text().toString());
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1] = parseInt(arg1.SettingValues.FavouritesCustomB_PageCount.text().toString());
                if ((loc4 = handler.AppDeviceHandlerCommon.deviceDicGUID[(arg2 as core.settings.SettingsROX100).unitGUID]) && core.units.UnitROX100.getSoftwareRevisionNumber(loc4.softwareRevision) >= 1403271) 
                {
                    (loc3 = (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustom).splice(0, 2);
                    loc3[0] = new __AS3__.vec.Vector.<String>(6, true);
                    loc3[0][0] = arg1.SettingValues.FavouriteCustom1A.text().toString();
                    loc3[0][1] = arg1.SettingValues.FavouriteCustom2A.text().toString();
                    loc3[0][2] = arg1.SettingValues.FavouriteCustom3A.text().toString();
                    loc3[0][3] = arg1.SettingValues.FavouriteCustom4A.text().toString();
                    loc3[0][4] = arg1.SettingValues.FavouriteCustom5A.text().toString();
                    loc3[0][5] = arg1.SettingValues.FavouriteCustom6A.text().toString();
                    loc3[1] = new __AS3__.vec.Vector.<String>(6, true);
                    loc3[1][0] = arg1.SettingValues.FavouriteCustom1B.text().toString();
                    loc3[1][1] = arg1.SettingValues.FavouriteCustom2B.text().toString();
                    loc3[1][2] = arg1.SettingValues.FavouriteCustom3B.text().toString();
                    loc3[1][3] = arg1.SettingValues.FavouriteCustom4B.text().toString();
                    loc3[1][4] = arg1.SettingValues.FavouriteCustom5B.text().toString();
                    loc3[1][5] = arg1.SettingValues.FavouriteCustom6B.text().toString();
                }
                (loc6 = (arg2 as core.settings.SettingsROX100).favoritesAltitude).splice(0, 2);
                loc6[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc6[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][0][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1A.text().toString();
                loc6[0][0][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1B.text().toString();
                loc6[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][1][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2A.text().toString();
                loc6[0][1][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2B.text().toString();
                loc6[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][2][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3A.text().toString();
                loc6[0][2][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3B.text().toString();
                loc6[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc6[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][0][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1A.text().toString();
                loc6[1][0][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1B.text().toString();
                loc6[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][1][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2A.text().toString();
                loc6[1][1][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2B.text().toString();
                loc6[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][2][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3A.text().toString();
                loc6[1][2][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3B.text().toString();
                (loc7 = (arg2 as core.settings.SettingsROX100).favoritesLap).splice(0, 2);
                loc7[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc7[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][0][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_1.FavouriteLap1A.text().toString();
                loc7[0][0][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_1.FavouriteLap1B.text().toString();
                loc7[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][1][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_2.FavouriteLap2A.text().toString();
                loc7[0][1][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_2.FavouriteLap2B.text().toString();
                loc7[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][2][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_3.FavouriteLap3A.text().toString();
                loc7[0][2][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_3.FavouriteLap3B.text().toString();
                loc7[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc7[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][0][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_1.FavouriteLap1A.text().toString();
                loc7[1][0][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_1.FavouriteLap1B.text().toString();
                loc7[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][1][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_2.FavouriteLap2A.text().toString();
                loc7[1][1][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_2.FavouriteLap2B.text().toString();
                loc7[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][2][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_3.FavouriteLap3A.text().toString();
                loc7[1][2][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_3.FavouriteLap3B.text().toString();
            }
            return;
        }

        public static function generateXML(arg1:core.settings.Settings):XML
        {
            var loc3:*=undefined;
            var loc4:*=0;
            var loc2:*=undefined;
            var loc5:*=0;
            var loc1:*=new XML("<SettingInformation/>");
            var loc6:*;
            (loc6 = new XML("<GeneralInformation/>")).@unit = arg1.unit.type.toString();
            loc6.@serialNumber = arg1.unit.serialNumber;
            loc6.GUID = arg1.GUID;
            loc6.unitGUID = arg1.unitGUID;
            loc6.modificationDate = arg1.modificationDate;
            loc6.FileDate = new Date();
            loc1.appendChild(loc6);
            var loc7:*=new XML("<SettingValues/>");
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                var loc8:*;
                loc7.ActualAltitude = loc8 = (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAge) 
            {
                loc7.Age = loc8 = (arg1 as core.settings.interfaces.IAge).age;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarm) 
            {
                loc7.Alarm = loc8 = (arg1 as core.settings.interfaces.IAlarm).alarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                loc7.AlarmMode = loc8 = (arg1 as core.settings.interfaces.IAlarmMode).alarmMode;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                loc7.AltitudeReference = loc8 = (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                loc7.AltitudeUnit = loc8 = (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                loc7.AutoPause = loc8 = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                loc7.AutoZoomTrack = loc8 = (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoOffTime && (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime) 
            {
                loc7.AutoOffTime = loc8 = (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                loc7.BacklightTime = loc8 = (arg1 as core.settings.interfaces.IBacklightTime).backlightTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                loc7.BacklightLevel = loc8 = (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                loc7.BikeType1 = loc8 = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                loc7.BikeType2 = loc8 = (arg1 as core.settings.interfaces.IBikeType2).bikeType2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                loc7.BikeType3 = loc8 = (arg1 as core.settings.interfaces.IBikeType3).bikeType3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                loc7.BikeWeight1 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                loc7.BikeWeight1Unit = loc8 = (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                loc7.BikeWeight2 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                loc7.BikeWeight2Unit = loc8 = (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                loc7.BikeWeight3 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                loc7.BirthDate = loc8 = (arg1 as core.settings.interfaces.IBirthDate).birthDate;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                loc7.BodyHeight = loc8 = (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                loc7.BodyHeightUnit = loc8 = (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                loc7.BodyWeight = loc8 = (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                loc7.WeightUnit = loc8 = (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                loc7.ButtonInfo = loc8 = (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                loc7.ButtonTone = loc8 = (arg1 as core.settings.interfaces.IButtonTone).buttonTone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                loc7.Calibration = loc8 = (arg1 as core.settings.interfaces.ICalibration).calibration;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                loc7.ClockMode = loc8 = (arg1 as core.settings.interfaces.IClockMode).clockMode;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                loc7.Contrast = loc8 = (arg1 as core.settings.interfaces.IContrast).contrast;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                loc7.CorrectionFactor = loc8 = (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                loc7.Countdown = loc8 = (arg1 as core.settings.interfaces.ICountdown).countdown;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                loc7.CountdownOn = loc8 = (arg1 as core.settings.interfaces.ICountdown).countdownOn;
            }
            undefined;
            loc7.Date = arg1.date;
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                loc7.DateFormat = loc8 = (arg1 as core.settings.interfaces.IDateFormat).dateFormat;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                loc7.DistanceUnit = loc8 = (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.EndZone3 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).endZone3;
            }
            undefined;
            if (arg1 is core.settings.SettingsROX100) 
            {
                loc7.FavoritesSelected = loc8 = (arg1 as core.settings.SettingsROX100).favoritesSelected;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeTrainingTargetZone = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone1LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone1UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone2LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone2UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone3LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone3UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                loc7.FuelConsumption = loc8 = (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                loc7.FuelConsumptionUnit = loc8 = (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGender) 
            {
                loc7.Gender = loc8 = (arg1 as core.settings.interfaces.IGender).gender;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                loc7.GPSFormat = loc8 = (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                loc7.GPSStatus = loc8 = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                loc7.StravaSegmentsEnabled = loc8 = (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                loc7.TrackDirection = loc8 = (arg1 as core.settings.interfaces.ITrackDirection).trackDirection;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                loc7.HomeAltitude1 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                loc7.HomeAltitude2 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                loc7.HomeAltitude3 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                loc7.HrMax = loc8 = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone1 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone2 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone3 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone4End = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone4 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTime = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalRecoveryHR = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval && (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode) 
            {
                loc7.IntervalRecoveryMode = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalRecoveryTime = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTime = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTime = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                loc7.Language = loc8 = (arg1 as core.settings.interfaces.ILanguage).language;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                loc7.LowBatteryDetectLevel = loc8 = (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                loc7.LowerLimit = loc8 = (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                loc7.HeartrateSensorActive = loc8 = (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                loc7.CadenceSensorActive = loc8 = (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                loc7.myName = loc8 = utils.format.CDATAFormat.getCDataAsXMLNode("MyName", (arg1 as core.settings.interfaces.IMyName).myName);
            }
            undefined;
            loc7.name = utils.format.CDATAFormat.getCDataAsXMLNode("Name", arg1.name);
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                loc7.OffTrackAlarm = loc8 = (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                loc7.PowerMeterFormula = loc8 = (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneEnabled = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone1Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone2Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone3Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone4Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone5Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone6Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone7Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone7End = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                loc7.SamplingRate = loc8 = (arg1 as core.settings.interfaces.ISamplingRate).samplingRate;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                loc7.AutoScan = loc8 = (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                loc7.SeaLevel = loc8 = (arg1 as core.settings.interfaces.ISeaLevel).seaLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                loc7.ServiceInterval = loc8 = (arg1 as core.settings.interfaces.IService).serviceInterval;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                loc7.ServiceStatus = loc8 = (arg1 as core.settings.interfaces.IService).serviceStatusOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                loc7.ShoulderWidth = loc8 = (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                loc7.ShoulderWidthUnit = loc8 = (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                loc7.ShowTotals = loc8 = (arg1 as core.settings.interfaces.IShowTotals).showTotals;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                loc7.Measurement = loc8 = (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone1 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone2 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone3 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                loc7.SummerTime = loc8 = (arg1 as core.settings.interfaces.ISummerTime).summerTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                loc7.SystemTone = loc8 = (arg1 as core.settings.interfaces.ISystemTone).systemTone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                loc7.TemperatureUnit = loc8 = (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                loc7.TimeZone = loc8 = (arg1 as core.settings.interfaces.ITimeZone).timeZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                loc7.TrainingZone = loc8 = (arg1 as core.settings.interfaces.ITrainingZone).trainingZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                loc7.UpperLimit = loc8 = (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                loc7.Volume = loc8 = (arg1 as core.settings.interfaces.IVolume).volume;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                loc7.WaypointAlarm = loc8 = (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                loc7.WheelSize1 = loc8 = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                loc7.WheelSize2 = loc8 = (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                loc7.WheelSize3 = loc8 = (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                loc7.WheelSize1Mode = loc8 = (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                loc7.WheelSize2Mode = loc8 = (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                loc7.TireSize1 = loc8 = (arg1 as core.settings.interfaces.ITireSize1).tireSize1.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                loc7.TireSize2 = loc8 = (arg1 as core.settings.interfaces.ITireSize2).tireSize2.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc7.YearOfBirth = loc8 = (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                loc7.ZoneAlarm = loc8 = (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                loc7.PhaseAlarm = loc8 = (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                loc7.KeyLock = loc8 = (arg1 as core.settings.interfaces.IKeyLock).keyLock;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                loc7.PowerSaveModeActive = loc8 = (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                loc7.BacklightActive = loc8 = (arg1 as core.settings.interfaces.IBacklight).backlightActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                loc7.BacklightTimeOn = loc8 = (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc7.BacklightTimeOff = loc8 = (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff;
            }
            undefined;
            if (arg1 is core.settings.interfaces.INfc) 
            {
                loc7.NFCActive = loc8 = (arg1 as core.settings.interfaces.INfc).nfcActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                loc7.ETADistance = loc8 = (arg1 as core.settings.interfaces.IETADistance).etaDistance;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                loc7.ETAArivalFlag = loc8 = (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc3 = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1;
                loc4 = 0;
                while (loc4 < (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    loc7.FavouritesTrip1["Fav" + (loc4 + 1)] = loc3[loc4];
                    ++loc4;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                loc2 = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2;
                loc5 = 0;
                while (loc5 < (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    loc7.FavouritesTrip2["Fav" + (loc5 + 1)] = loc2[loc5];
                    ++loc5;
                }
            }
            if (arg1 is core.settings.SettingsROX100) 
            {
                loc7.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][0][0];
                loc7.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][0][1];
                loc7.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][1][0];
                loc7.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][1][1];
                loc7.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][2][0];
                loc7.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][2][1];
                loc7.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][0][0];
                loc7.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][0][1];
                loc7.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][1][0];
                loc7.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][1][1];
                loc7.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][2][0];
                loc7.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][2][1];
                if (core.units.UnitROX100.getSoftwareRevisionNumber((arg1 as core.settings.SettingsROX100).unit.softwareRevision) >= 1403271) 
                {
                    loc7.FavouritesCustomA_PageCount = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0];
                    loc7.FavouriteCustom1A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][0];
                    loc7.FavouriteCustom2A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][1];
                    loc7.FavouriteCustom3A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][2];
                    loc7.FavouriteCustom4A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][3];
                    loc7.FavouriteCustom5A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][4];
                    loc7.FavouriteCustom6A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][5];
                    loc7.FavouritesCustomB_PageCount = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1];
                    loc7.FavouriteCustom1B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][0];
                    loc7.FavouriteCustom2B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][1];
                    loc7.FavouriteCustom3B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][2];
                    loc7.FavouriteCustom4B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][3];
                    loc7.FavouriteCustom5B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][4];
                    loc7.FavouriteCustom6B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][5];
                }
                loc7.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][0][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][0][1];
                loc7.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][1][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][1][1];
                loc7.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][2][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][2][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][0][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][0][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][1][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][1][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][2][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][2][1];
                loc7.FavouritesLap1.FavouritesLap1_1.FavouriteLap1A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][0][0];
                loc7.FavouritesLap1.FavouritesLap1_1.FavouriteLap1B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][0][1];
                loc7.FavouritesLap1.FavouritesLap1_2.FavouriteLap2A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][1][0];
                loc7.FavouritesLap1.FavouritesLap1_2.FavouriteLap2B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][1][1];
                loc7.FavouritesLap1.FavouritesLap1_3.FavouriteLap3A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][2][0];
                loc7.FavouritesLap1.FavouritesLap1_3.FavouriteLap3B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][2][1];
                loc7.FavouritesLap2.FavouritesLap2_1.FavouriteLap1A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][0][0];
                loc7.FavouritesLap2.FavouritesLap2_1.FavouriteLap1B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][0][1];
                loc7.FavouritesLap2.FavouritesLap2_2.FavouriteLap2A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][1][0];
                loc7.FavouritesLap2.FavouritesLap2_2.FavouriteLap2B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][1][1];
                loc7.FavouritesLap2.FavouritesLap2_3.FavouriteLap3A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][2][0];
                loc7.FavouritesLap2.FavouritesLap2_3.FavouriteLap3B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][2][1];
            }
            loc1.appendChild(loc7);
            return loc1;
        }

        public static function generateDBInsert(arg1:core.settings.Settings, arg2:Array, arg3:Object):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=0;
            var loc5:*=0;
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("settingsId");
            ++loc1;
            arg3[loc1] = arg1.settingsId > 0 ? arg1.settingsId : null;
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("date");
            ++loc1;
            arg3[loc1] = arg1.date.toString();
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                arg2.push("actualAltitude");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude;
            }
            if (arg1 is core.settings.interfaces.IAge) 
            {
                arg2.push("age");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAge).age;
            }
            if (arg1 is core.settings.interfaces.IAlarm && (arg1 as core.settings.interfaces.IAlarm).alarm) 
            {
                arg2.push("alarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarm).alarm.toString();
            }
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                arg2.push("alarmMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmMode).alarmMode;
            }
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                arg2.push("altitudeReference");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference;
            }
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                arg2.push("altitudeUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit;
            }
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                arg2.push("autoPause");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                arg2.push("autoZoomTrack");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack;
            }
            if (arg1 is core.settings.interfaces.IAutoOffTime && (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime) 
            {
                arg2.push("autoOffTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime.toString();
            }
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                arg2.push("backlightTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTime).backlightTime;
            }
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                arg2.push("backlightLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                arg2.push("bikeType1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                arg2.push("bikeType2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType2).bikeType2;
            }
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                arg2.push("bikeType3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType3).bikeType3;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                arg2.push("bikeWeight1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                arg2.push("bikeWeight1Unit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                arg2.push("bikeWeight2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                arg2.push("bikeWeight2Unit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                arg2.push("bikeWeight3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3;
            }
            if (arg1 is core.settings.interfaces.IBirthDate && (arg1 as core.settings.interfaces.IBirthDate).birthDate) 
            {
                arg2.push("birthDate");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBirthDate).birthDate.toString();
            }
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                arg2.push("bodyHeight");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight;
            }
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                arg2.push("bodyHeightUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit;
            }
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                arg2.push("bodyWeight");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            }
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                arg2.push("bodyWeightUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit;
            }
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                arg2.push("buttonInfo");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo;
            }
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                arg2.push("buttonTone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IButtonTone).buttonTone;
            }
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                arg2.push("calibration");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICalibration).calibration;
            }
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                arg2.push("clockMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IClockMode).clockMode;
            }
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                arg2.push("contrast");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IContrast).contrast;
            }
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                arg2.push("correctionFactor");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor;
            }
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                arg2.push("countdown");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICountdown).countdown;
                arg2.push("countdownOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICountdown).countdownOn;
            }
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                arg2.push("dateFormat");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IDateFormat).dateFormat;
            }
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                arg2.push("distanceUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("endZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).endZone3;
            }
            if (arg1 is core.settings.interfaces.IFavoritesAltitude) 
            {
                arg2.push("favoritesAltitude1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][0][0];
                arg2.push("favoritesAltitude1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][0][1];
                arg2.push("favoritesAltitude1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][1][0];
                arg2.push("favoritesAltitude1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][1][1];
                arg2.push("favoritesAltitude1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][2][0];
                arg2.push("favoritesAltitude1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][2][1];
                arg2.push("favoritesAltitude2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][0][0];
                arg2.push("favoritesAltitude2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][0][1];
                arg2.push("favoritesAltitude2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][1][0];
                arg2.push("favoritesAltitude2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][1][1];
                arg2.push("favoritesAltitude2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][2][0];
                arg2.push("favoritesAltitude2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][2][1];
            }
            if (arg1 is core.settings.interfaces.IFavoritesLap) 
            {
                arg2.push("favoritesLap1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][0][0];
                arg2.push("favoritesLap1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][0][1];
                arg2.push("favoritesLap1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][1][0];
                arg2.push("favoritesLap1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][1][1];
                arg2.push("favoritesLap1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][2][0];
                arg2.push("favoritesLap1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][2][1];
                arg2.push("favoritesLap2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][0][0];
                arg2.push("favoritesLap2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][0][1];
                arg2.push("favoritesLap2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][1][0];
                arg2.push("favoritesLap2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][1][1];
                arg2.push("favoritesLap2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][2][0];
                arg2.push("favoritesLap2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][2][1];
            }
            if (arg1 is core.settings.SettingsROX100) 
            {
                arg2.push("favoritesSelected");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.SettingsROX100).favoritesSelected;
            }
            if (arg1 is core.settings.interfaces.IFavoritesTrack) 
            {
                arg2.push("favoritesTrack1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][0][0];
                arg2.push("favoritesTrack1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][0][1];
                arg2.push("favoritesTrack1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][1][0];
                arg2.push("favoritesTrack1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][1][1];
                arg2.push("favoritesTrack1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][2][0];
                arg2.push("favoritesTrack1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][2][1];
                arg2.push("favoritesTrack2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][0][0];
                arg2.push("favoritesTrack2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][0][1];
                arg2.push("favoritesTrack2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][1][0];
                arg2.push("favoritesTrack2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][1][1];
                arg2.push("favoritesTrack2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][2][0];
                arg2.push("favoritesTrack2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][2][1];
            }
            if (arg1 is core.settings.interfaces.IFavoritesCustom) 
            {
                arg2.push("favoritesCustomA_PageCount");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0];
                arg2.push("favoritesCustom1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][0];
                arg2.push("favoritesCustom2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][1];
                arg2.push("favoritesCustom3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][2];
                arg2.push("favoritesCustom4_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][3];
                arg2.push("favoritesCustom5_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][4];
                arg2.push("favoritesCustom6_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][5];
                arg2.push("favoritesCustomB_PageCount");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1];
                arg2.push("favoritesCustom1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][0];
                arg2.push("favoritesCustom2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][1];
                arg2.push("favoritesCustom3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][2];
                arg2.push("favoritesCustom4_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][3];
                arg2.push("favoritesCustom5_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][4];
                arg2.push("favoritesCustom6_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][5];
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc3 = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    arg2.push("favoritesTrip1_" + loc4);
                    ++loc1;
                    arg3[loc1] = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc4];
                    ++loc4;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                loc2 = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size;
                loc5 = 0;
                while (loc5 < loc2) 
                {
                    arg2.push("favoritesTrip2_" + loc5);
                    ++loc1;
                    arg3[loc1] = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc5];
                    ++loc5;
                }
            }
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                arg2.push("freeTrainingTargetZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone;
                arg2.push("freeOwnZone1LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit;
                arg2.push("freeOwnZone1UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit;
                arg2.push("freeOwnZone2LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit;
                arg2.push("freeOwnZone2UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit;
                arg2.push("freeOwnZone3LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit;
                arg2.push("freeOwnZone3UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit;
            }
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                arg2.push("fuelConsumption");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption;
            }
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                arg2.push("fuelConsumptionUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
            }
            if (arg1 is core.settings.interfaces.IGender) 
            {
                arg2.push("gender");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGender).gender;
            }
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                arg2.push("gpsFormat");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                arg2.push("gpsStatus");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                arg2.push("stravaSegmentsEnabled");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled;
            }
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                arg2.push("trackDirection");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrackDirection).trackDirection;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                arg2.push("homeAltitude1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                arg2.push("homeAltitude2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                arg2.push("homeAltitude3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3;
            }
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                arg2.push("hrMax");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone4");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone4End");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryHR");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode.toString();
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime;
            }
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                arg2.push("language");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILanguage).language;
            }
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                arg2.push("lowBatDetectLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel;
            }
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                arg2.push("lowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            }
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                arg2.push("heartrateSensorActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive;
            }
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                arg2.push("cadenceSensorActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive;
            }
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                arg2.push("myName");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IMyName).myName;
            }
            arg2.push("name");
            ++loc1;
            arg3[loc1] = arg1.name;
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                arg2.push("offTrackAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm;
            }
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                arg2.push("powerMeterFormula");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula;
            }
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                arg2.push("powerTargetZoneEnabled");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled;
                arg2.push("powerTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit;
                arg2.push("powerTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                arg2.push("powerIntensityZone1Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
                arg2.push("powerIntensityZone2Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
                arg2.push("powerIntensityZone3Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
                arg2.push("powerIntensityZone4Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
                arg2.push("powerIntensityZone5Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
                arg2.push("powerIntensityZone6Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
                arg2.push("powerIntensityZone7Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
                arg2.push("powerIntensityZone7End");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                arg2.push("samplingRate");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISamplingRate).samplingRate;
            }
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                arg2.push("scanFlagOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn;
            }
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                arg2.push("seaLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISeaLevel).seaLevel;
            }
            if (arg1 is core.settings.interfaces.IService) 
            {
                arg2.push("serviceInterval");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IService).serviceInterval;
                arg2.push("serviceStatusOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IService).serviceStatusOn;
            }
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                arg2.push("shoulderWidth");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth;
            }
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                arg2.push("shoulderWidthUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit;
            }
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                arg2.push("showTotals");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShowTotals).showTotals;
            }
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                arg2.push("speedUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone1;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone2;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone3;
            }
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                arg2.push("summerTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISummerTime).summerTime;
            }
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                arg2.push("systemTone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISystemTone).systemTone;
            }
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                arg2.push("temperatureUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit;
            }
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                arg2.push("timeZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITimeZone).timeZone;
            }
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                arg2.push("trainingZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingZone).trainingZone;
            }
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                arg2.push("upperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit;
            }
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                arg2.push("volume");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IVolume).volume;
            }
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                arg2.push("waypointAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                arg2.push("wheelSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                arg2.push("wheelSize2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2;
            }
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                arg2.push("wheelSize3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3;
            }
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                arg2.push("yearOfBirth");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                arg2.push("zoneAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm;
            }
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                arg2.push("phaseAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm;
            }
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                arg2.push("keyLock");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IKeyLock).keyLock;
            }
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                arg2.push("powerSaveModeActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive;
            }
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                arg2.push("backlightActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklight).backlightActive;
            }
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                arg2.push("backlightTimeOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.toString();
            }
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                arg2.push("backlightTimeOff");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.toString();
            }
            if (arg1 is core.settings.interfaces.INfc) 
            {
                arg2.push("nfcActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.INfc).nfcActive;
            }
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                arg2.push("tireSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITireSize1).tireSize1 ? (arg1 as core.settings.interfaces.ITireSize1).tireSize1.data : "";
            }
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                arg2.push("tireSize2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITireSize2).tireSize2 ? (arg1 as core.settings.interfaces.ITireSize2).tireSize2.data : "";
            }
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                arg2.push("wheelSize1Mode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode ? (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode.toString() : "";
            }
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                arg2.push("wheelSize2Mode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode ? (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode.toString() : "";
            }
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                arg2.push("etaDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IETADistance).etaDistance;
            }
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                arg2.push("etaArivalFlag");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag;
            }
            return;
        }

        public static const col_altitudeUnit:String="altitudeUnit";

        public static const col_autoOffTime:String="autoOffTime";

        public static const col_autoPause:String="autoPause";

        public static const col_autoZoomTrack:String="autoZoomTrack";

        public static const col_backlightActive:String="backlightActive";

        public static const col_backlightLevel:String="backlightLevel";

        public static const col_backlightTime:String="backlightTime";

        public static const col_backlightTimeOff:String="backlightTimeOff";

        public static const col_backlightTimeOn:String="backlightTimeOn";

        public static const col_bikeType1:String="bikeType1";

        public static const col_bikeType2:String="bikeType2";

        public static const col_bikeType3:String="bikeType3";

        public static const col_bikeWeight1:String="bikeWeight1";

        public static const col_bikeWeight1Unit:String="bikeWeight1Unit";

        public static const col_bikeWeight2:String="bikeWeight2";

        public static const col_bikeWeight2Unit:String="bikeWeight2Unit";

        public static const col_bikeWeight3:String="bikeWeight3";

        public static const col_birthDate:String="birthDate";

        public static const col_bodyHeight:String="bodyHeight";

        public static const col_bodyHeightUnit:String="bodyHeightUnit";

        public static const col_bodyWeight:String="bodyWeight";

        public static const col_bodyWeightUnit:String="bodyWeightUnit";

        public static const col_buttonInfo:String="buttonInfo";

        public static const col_buttonTone:String="buttonTone";

        public static const col_cadenceSensorActive:String="cadenceSensorActive";

        public static const col_calibration:String="calibration";

        public static const col_clockMode:String="clockMode";

        public static const col_contrast:String="contrast";

        public static const col_correctionFactor:String="correctionFactor";

        public static const col_countdown:String="countdown";

        public static const col_countdownOn:String="countdownOn";

        public static const col_date:String="date";

        public static const col_dateFormat:String="dateFormat";

        public static const col_distanceUnit:String="distanceUnit";

        public static const col_endZone3:String="endZone3";

        public static const col_etaArivalFlag:String="etaArivalFlag";

        public static const col_etaDistance:String="etaDistance";

        public static const col_favoritesAltitude1_1_A:String="favoritesAltitude1_1_A";

        public static const col_favoritesAltitude1_1_B:String="favoritesAltitude1_1_B";

        public static const col_favoritesAltitude1_2_A:String="favoritesAltitude1_2_A";

        public static const col_favoritesAltitude1_2_B:String="favoritesAltitude1_2_B";

        public static const col_favoritesAltitude1_3_A:String="favoritesAltitude1_3_A";

        public static const col_favoritesAltitude1_3_B:String="favoritesAltitude1_3_B";

        public static const col_favoritesAltitude2_1_A:String="favoritesAltitude2_1_A";

        public static const col_favoritesAltitude2_1_B:String="favoritesAltitude2_1_B";

        public static const col_favoritesAltitude2_2_A:String="favoritesAltitude2_2_A";

        public static const col_favoritesAltitude2_2_B:String="favoritesAltitude2_2_B";

        public static const col_favoritesAltitude2_3_A:String="favoritesAltitude2_3_A";

        public static const col_favoritesAltitude2_3_B:String="favoritesAltitude2_3_B";

        public static const col_favoritesCustom1_A:String="favoritesCustom1_A";

        public static const col_favoritesCustom1_B:String="favoritesCustom1_B";

        public static const col_favoritesCustom2_A:String="favoritesCustom2_A";

        public static const col_favoritesCustom2_B:String="favoritesCustom2_B";

        public static const col_favoritesCustom3_A:String="favoritesCustom3_A";

        public static const col_favoritesCustom3_B:String="favoritesCustom3_B";

        public static const col_favoritesCustom4_A:String="favoritesCustom4_A";

        public static const col_favoritesCustom4_B:String="favoritesCustom4_B";

        public static const col_favoritesCustom5_A:String="favoritesCustom5_A";

        public static const col_favoritesCustom5_B:String="favoritesCustom5_B";

        public static const col_favoritesCustom6_A:String="favoritesCustom6_A";

        public static const col_favoritesCustom6_B:String="favoritesCustom6_B";

        public static const col_favoritesCustomA_PageCount:String="favoritesCustomA_PageCount";

        public static const col_favoritesCustomB_PageCount:String="favoritesCustomB_PageCount";

        public static const col_favoritesLap1_1_A:String="favoritesLap1_1_A";

        public static const col_favoritesLap1_1_B:String="favoritesLap1_1_B";

        public static const col_favoritesLap1_2_A:String="favoritesLap1_2_A";

        public static const col_favoritesLap1_2_B:String="favoritesLap1_2_B";

        public static const col_favoritesLap1_3_A:String="favoritesLap1_3_A";

        public static const col_favoritesLap1_3_B:String="favoritesLap1_3_B";

        public static const col_favoritesLap2_1_A:String="favoritesLap2_1_A";

        public static const col_favoritesLap2_1_B:String="favoritesLap2_1_B";

        public static const col_favoritesLap2_2_A:String="favoritesLap2_2_A";

        public static const col_favoritesLap2_2_B:String="favoritesLap2_2_B";

        public static const col_favoritesLap2_3_A:String="favoritesLap2_3_A";

        public static const col_favoritesLap2_3_B:String="favoritesLap2_3_B";

        public static const col_favoritesSelected:String="favoritesSelected";

        public static const col_favoritesTrack1_1_A:String="favoritesTrack1_1_A";

        public static const col_favoritesTrack1_1_B:String="favoritesTrack1_1_B";

        public static const col_favoritesTrack1_2_A:String="favoritesTrack1_2_A";

        public static const col_favoritesTrack1_2_B:String="favoritesTrack1_2_B";

        public static const col_favoritesTrack1_3_A:String="favoritesTrack1_3_A";

        public static const col_favoritesTrack1_3_B:String="favoritesTrack1_3_B";

        public static const col_favoritesTrack2_1_A:String="favoritesTrack2_1_A";

        public static const col_favoritesTrack2_1_B:String="favoritesTrack2_1_B";

        public static const col_favoritesTrack2_2_A:String="favoritesTrack2_2_A";

        public static const col_favoritesTrack2_2_B:String="favoritesTrack2_2_B";

        public static const col_favoritesTrack2_3_A:String="favoritesTrack2_3_A";

        public static const col_favoritesTrack2_3_B:String="favoritesTrack2_3_B";

        public static const col_favoritesTrip1_0:String="favoritesTrip1_0";

        public static const col_favoritesTrip1_1:String="favoritesTrip1_1";

        public static const col_favoritesTrip1_2:String="favoritesTrip1_2";

        public static const col_favoritesTrip1_3:String="favoritesTrip1_3";

        public static const col_favoritesTrip1_4:String="favoritesTrip1_4";

        public static const col_favoritesTrip1_5:String="favoritesTrip1_5";

        public static const col_favoritesTrip1_6:String="favoritesTrip1_6";

        public static const col_favoritesTrip1_7:String="favoritesTrip1_7";

        public static const col_favoritesTrip1_8:String="favoritesTrip1_8";

        public static const col_favoritesTrip1_9:String="favoritesTrip1_9";

        public static const col_favoritesTrip2_0:String="favoritesTrip2_0";

        public static const col_favoritesTrip2_1:String="favoritesTrip2_1";

        public static const col_favoritesTrip2_2:String="favoritesTrip2_2";

        public static const col_favoritesTrip2_3:String="favoritesTrip2_3";

        public static const col_favoritesTrip2_4:String="favoritesTrip2_4";

        public static const col_favoritesTrip2_5:String="favoritesTrip2_5";

        public static const col_favoritesTrip2_6:String="favoritesTrip2_6";

        public static const col_favoritesTrip2_7:String="favoritesTrip2_7";

        public static const col_favoritesTrip2_8:String="favoritesTrip2_8";

        public static const col_favoritesTrip2_9:String="favoritesTrip2_9";

        public static const col_freeOwnZone1LowerLimit:String="freeOwnZone1LowerLimit";

        public static const col_freeOwnZone1UpperLimit:String="freeOwnZone1UpperLimit";

        public static const col_freeOwnZone2LowerLimit:String="freeOwnZone2LowerLimit";

        public static const col_freeOwnZone2UpperLimit:String="freeOwnZone2UpperLimit";

        public static const col_freeOwnZone3LowerLimit:String="freeOwnZone3LowerLimit";

        public static const col_freeOwnZone3UpperLimit:String="freeOwnZone3UpperLimit";

        public static const col_freeTrainingTargetZone:String="freeTrainingTargetZone";

        public static const col_fuelConsumption:String="fuelConsumption";

        public static const col_fuelConsumptionUnit:String="fuelConsumptionUnit";

        public static const col_gender:String="gender";

        public static const col_gpsFormat:String="gpsFormat";

        public static const col_gpsStatus:String="gpsStatus";

        public static const col_heartrateSensorActive:String="heartrateSensorActive";

        public static const col_homeAltitude1:String="homeAltitude1";

        public static const col_homeAltitude2:String="homeAltitude2";

        public static const col_homeAltitude3:String="homeAltitude3";

        public static const col_hrMax:String="hrMax";

        public static const col_intensityZone1:String="intensityZone1";

        public static const col_intensityZone2:String="intensityZone2";

        public static const col_intensityZone3:String="intensityZone3";

        public static const col_intensityZone4:String="intensityZone4";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_intervalCoolDownTargetZoneLowerLimit:String="intervalCoolDownTargetZoneLowerLimit";

        public static const col_intervalCoolDownTargetZoneUpperLimit:String="intervalCoolDownTargetZoneUpperLimit";

        public static const col_intervalCoolDownTime:String="intervalCoolDownTime";

        public static const col_intervalRecoveryHR:String="intervalRecoveryHR";

        public static const col_intervalRecoveryMode:String="intervalRecoveryMode";

        public static const col_intervalRecoveryTime:String="intervalRecoveryTime";

        public static const col_intervalTargetZoneLowerLimit:String="intervalTargetZoneLowerLimit";

        public static const col_intervalTargetZoneUpperLimit:String="intervalTargetZoneUpperLimit";

        public static const col_intervalTime:String="intervalTime";

        public static const col_intervalWarmUpTargetZoneLowerLimit:String="intervalWarmUpTargetZoneLowerLimit";

        public static const col_intervalWarmUpTargetZoneUpperLimit:String="intervalWarmUpTargetZoneUpperLimit";

        public static const col_intervalWarmUpTime:String="intervalWarmUpTime";

        public static const col_isDeleted:String="isDeleted";

        public static const col_keyLock:String="keyLock";

        public static const col_language:String="language";

        public static const col_lowBatDetectLevel:String="lowBatDetectLevel";

        public static const col_lowerLimit:String="lowerLimit";

        public static const col_modificationDate:String="modificationDate";

        public static const col_myName:String="myName";

        public static const col_name:String="name";

        public static const col_nfcActive:String="nfcActive";

        public static const col_offTrackAlarm:String="offTrackAlarm";

        public static const col_phaseAlarm:String="phaseAlarm";

        public static const col_powerIntensityZone1Start:String="powerIntensityZone1Start";

        public static const col_powerIntensityZone2Start:String="powerIntensityZone2Start";

        public static const col_powerIntensityZone4Start:String="powerIntensityZone4Start";

        public static const col_powerIntensityZone5Start:String="powerIntensityZone5Start";

        public static const col_powerIntensityZone6Start:String="powerIntensityZone6Start";

        public static const col_powerIntensityZone7End:String="powerIntensityZone7End";

        public static const col_powerIntensityZone7Start:String="powerIntensityZone7Start";

        public static const col_powerMeterFormula:String="powerMeterFormula";

        public static const col_powerSaveModeActive:String="powerSaveModeActive";

        public static const col_powerTargetZoneEnabled:String="powerTargetZoneEnabled";

        public static const col_powerTargetZoneLowerLimit:String="powerTargetZoneLowerLimit";

        public static const col_powerTargetZoneUpperLimit:String="powerTargetZoneUpperLimit";

        public static const col_samplingRate:String="samplingRate";

        public static const col_scanFlagOn:String="scanFlagOn";

        public static const col_seaLevel:String="seaLevel";

        public static const col_serviceInterval:String="serviceInterval";

        public static const col_serviceStatusOn:String="serviceStatusOn";

        public static const col_settingsId:String="settingsId";

        public static const col_shoulderWidth:String="shoulderWidth";

        public static const col_shoulderWidthUnit:String="shoulderWidthUnit";

        public static const col_showTotals:String="showTotals";

        public static const col_speedUnit:String="speedUnit";

        public static const col_startZone1:String="startZone1";

        public static const col_startZone2:String="startZone2";

        public static const col_startZone3:String="startZone3";

        public static const col_stravaSegmentsEnabled:String="stravaSegmentsEnabled";

        public static const col_summerTime:String="summerTime";

        public static const col_systemTone:String="systemTone";

        public static const col_powerIntensityZone3Start:String="powerIntensityZone3Start";

        public static const col_timeZone:String="timeZone";

        public static const col_tireSize1:String="tireSize1";

        public static const col_tireSize2:String="tireSize2";

        public static const col_trackDirection:String="trackDirection";

        public static const col_trainingZone:String="trainingZone";

        public static const col_unitGUID:String="unitGUID";

        public static const col_upperLimit:String="upperLimit";

        public static const col_volume:String="volume";

        public static const col_waypointAlarm:String="waypointAlarm";

        public static const col_wheelSize1:String="wheelSize1";

        public static const col_wheelSize2:String="wheelSize2";

        public static const col_wheelSize3:String="wheelSize3";

        public static const col_wheelSizeMode1:String="wheelSize1Mode";

        public static const col_wheelSizeMode2:String="wheelSize2Mode";

        public static const col_yearOfBirth:String="yearOfBirth";

        public static const col_zoneAlarm:String="zoneAlarm";

        public static const table_name:String="Settings";

        public static const col_GUID:String="GUID";

        public static const col_actual_altitude:String="actualAltitude";

        public static const col_age:String="age";

        public static const col_alarm:String="alarm";

        public static const col_alarmMode:String="alarmMode";

        public static const col_altitudeReference:String="altitudeReference";

        public static const col_temperatureUnit:String="temperatureUnit";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


