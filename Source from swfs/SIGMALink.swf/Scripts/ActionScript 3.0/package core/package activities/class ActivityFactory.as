//class ActivityFactory
package core.activities 
{
    import __AS3__.vec.*;
    import configCache.*;
    import core.general.*;
    import core.tcx.*;
    import init.*;
    
    public class ActivityFactory extends Object
    {
        public function ActivityFactory()
        {
            super();
            return;
        }

        public static function createLogEntryFromLog(arg1:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc1:*=new core.activities.ActivityEntry(INSTANCE_CHECK_OBJECT);
            if (arg1.unitType) 
            {
                configEntryDefinitions(loc1, arg1.unitType, arg1.logType);
            }
            loc1.logReference = arg1;
            return loc1;
        }

        public static function createLogFromDB(arg1:Object, arg2:Boolean=false):core.activities.Activity
        {
            return core.activities.ActivityMapper.fromDB(new core.activities.Activity(INSTANCE_CHECK_OBJECT), arg1, arg2);
        }

        public static function createLogFromFIT(arg1:__AS3__.vec.Vector.<Object>):core.activities.Activity
        {
            var loc1:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            loc1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByType(null);
            return loc1;
        }

        public static function createLogFromTcx(arg1:XML, arg2:Boolean=true):core.activities.Activity
        {
            var loc1:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            return core.tcx.ActivityTCXMapper.fromTCX(arg1, loc1, INSTANCE_CHECK_OBJECT);
        }

        public static function createLogFromSLF(arg1:XML, arg2:Boolean=false):core.activities.Activity
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.Computer.@unit);
            var loc4:*=arg1.@revision;
            var loc3:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            if (!(loc4 == 0) && loc4 < 400) 
            {
                loc2 = null;
                if (core.general.UnitType.ROX50 == loc1 || core.general.UnitType.ROX60 == loc1) 
                {
                    loc2 = core.general.LogType.fromString(arg1.GeneralInformation.@logType);
                }
                if (loc1) 
                {
                    configActivityDefinitions(loc3, loc1, loc2);
                }
            }
            loc3.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByKeyName(arg1.GeneralInformation.sport);
            return core.activities.ActivityMapper.fromXML(arg1, loc3, arg2);
        }

        public static function createActivityFromUnitType(arg1:core.general.UnitType, arg2:String, arg3:core.general.LogType=null):core.activities.Activity
        {
            var loc1:*;
            (loc1 = new core.activities.Activity(INSTANCE_CHECK_OBJECT)).unitType = arg1;
            loc1.dataType = arg2;
            loc1.logType = arg3;
            configActivityDefinitions(loc1, arg1, arg3);
            loc1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByType(arg1);
            return loc1;
        }

        public static function isCreatedByFactory(arg1:Object):Boolean
        {
            return INSTANCE_CHECK_OBJECT == arg1;
        }

        public static function applyZoneValues(arg1:core.activities.Activity, arg2:Boolean, arg3:Boolean):void
        {
            var loc2:*=null;
            var loc1:*=null;
            if (arg1 == null) 
            {
                return;
            }
            if (arg2 && arg1.hrMaxDefined) 
            {
                loc2 = configCache.ConfigCache.getInstance().getIntensityZoneValue(arg1.sport);
                arg1.intensityZone1Start = arg1.hrMax * loc2.intensityZone1Start / 100;
                arg1.intensityZone1StartDefined = true;
                arg1.intensityZone2Start = arg1.hrMax * loc2.intensityZone2Start / 100;
                arg1.intensityZone2StartDefined = true;
                arg1.intensityZone3Start = arg1.hrMax * loc2.intensityZone3Start / 100;
                arg1.intensityZone3StartDefined = true;
                arg1.intensityZone4Start = arg1.hrMax * loc2.intensityZone4Start / 100;
                arg1.intensityZone4StartDefined = true;
                arg1.intensityZone4End = arg1.hrMax * loc2.intensityZone4End / 100;
                arg1.intensityZone4EndDefined = true;
            }
            if (arg3) 
            {
                loc1 = configCache.ConfigCache.getInstance().getPowerZoneValue(arg1.sport);
                arg1.powerZone1Start = loc1.pZone1Start;
                arg1.powerZone1StartDefined = true;
                arg1.powerZone2Start = loc1.pZone2Start;
                arg1.powerZone2StartDefined = true;
                arg1.powerZone3Start = loc1.pZone3Start;
                arg1.powerZone3StartDefined = true;
                arg1.powerZone4Start = loc1.pZone4Start;
                arg1.powerZone4StartDefined = true;
                arg1.powerZone5Start = loc1.pZone5Start;
                arg1.powerZone5StartDefined = true;
                arg1.powerZone6Start = loc1.pZone6Start;
                arg1.powerZone6StartDefined = true;
                arg1.powerZone7Start = loc1.pZone7Start;
                arg1.powerZone7StartDefined = true;
                arg1.powerZone7End = loc1.pZone7End;
                arg1.powerZone7EndDefined = true;
            }
            return;
        }

        internal static function configActivityDefinitions(arg1:core.activities.Activity, arg2:core.general.UnitType, arg3:core.general.LogType=null):void
        {
            var loc1:*=false;
            var loc2:*=arg2;
            while (core.general.UnitType.ROX8.toString() === loc2) 
            {
                if (arg1.dataType != "memory") 
                {
                    arg1.logType = core.general.LogType.CYCLING;
                    arg1.altitudeDifferencesDownhillDefined = true;
                    arg1.altitudeDifferencesUphillDefined = true;
                    arg1.averageAltitudeDefined = true;
                    arg1.averageHeartrateDefined = true;
                    arg1.averageInclineUphillDefined = true;
                    arg1.averageInclineDownhillDefined = true;
                    arg1.averageRiseRateDefined = true;
                    arg1.averageRiseRateUphillDefined = true;
                    arg1.averageRiseRateDownhillDefined = true;
                    arg1.averageTemperatureDefined = true;
                    arg1.caloriesDefined = true;
                    arg1.caloriesDifferenceFactorDefined = true;
                    arg1.distanceDownhillDefined = true;
                    arg1.distanceUphillDefined = true;
                    arg1.hrMaxDefined = true;
                    arg1.intensityZone1StartDefined = true;
                    arg1.intensityZone2StartDefined = true;
                    arg1.intensityZone3StartDefined = true;
                    arg1.intensityZone4EndDefined = true;
                    arg1.intensityZone4StartDefined = true;
                    arg1.maximumAltitudeDefined = true;
                    arg1.maximumHeartrateDefined = true;
                    arg1.maximumInclineDefined = true;
                    arg1.maximumRiseRateDefined = true;
                    arg1.maximumTemperatureDefined = true;
                    arg1.minimumAltitudeDefined = true;
                    arg1.minimumHeartrateDefined = true;
                    arg1.minimumInclineDefined = true;
                    arg1.minimumRiseRateDefined = true;
                    arg1.minimumTemperatureDefined = true;
                    arg1.timeInIntensityZone1Defined = true;
                    arg1.timeInIntensityZone2Defined = true;
                    arg1.timeInIntensityZone3Defined = true;
                    arg1.timeInIntensityZone4Defined = true;
                    arg1.timeInZone1Defined = true;
                    arg1.timeInZone2Defined = true;
                    arg1.timeInZone3Defined = true;
                    arg1.timeInZoneDefined = true;
                    arg1.timeOverIntensityZoneDefined = true;
                    arg1.timeOverZoneDefined = true;
                    arg1.timeUnderIntensityZoneDefined = true;
                    arg1.timeUnderZoneDefined = true;
                    arg1.trainingTimeDownhillDefined = true;
                    arg1.trainingTimeUphillDefined = true;
                    arg1.zone1StartDefined = true;
                    arg1.zone2StartDefined = true;
                    arg1.zone3EndDefined = true;
                    arg1.zone3StartDefined = true;
                    arg1.distanceDefined = true;
                    arg1.minimumSpeedDefined = true;
                    arg1.maximumSpeedDefined = true;
                    arg1.averageSpeedDefined = true;
                    arg1.averageSpeedDownhillDefined = true;
                    arg1.averageSpeedUphillDefined = true;
                    arg1.wheelSizeDefined = true;
                    arg1.speedUnitDefined = true;
                }
                else 
                {
                    arg1.logType = core.general.LogType.CYCLING;
                    arg1.averageCadenceDefined = true;
                    arg1.maximumCadenceDefined = true;
                    arg1.altitudeDifferencesDownhillDefined = true;
                    arg1.altitudeDifferencesUphillDefined = true;
                    arg1.averageHeartrateDefined = true;
                    arg1.averageInclineUphillDefined = true;
                    arg1.averageInclineDownhillDefined = true;
                    arg1.averageRiseRateUphillDefined = true;
                    arg1.averageRiseRateDownhillDefined = true;
                    arg1.caloriesDefined = true;
                    arg1.distanceDownhillDefined = true;
                    arg1.distanceUphillDefined = true;
                    arg1.hrMaxDefined = true;
                    arg1.maximumAltitudeDefined = true;
                    arg1.maximumHeartrateDefined = true;
                    arg1.maximumInclineDownhillDefined = true;
                    arg1.maximumRiseRateDefined = true;
                    arg1.maximumTemperatureDefined = true;
                    arg1.maximumInclineUphillDefined = true;
                    arg1.minimumRiseRateDefined = true;
                    arg1.minimumTemperatureDefined = true;
                    arg1.timeInZone1Defined = true;
                    arg1.timeInZone2Defined = true;
                    arg1.timeInZone3Defined = true;
                    arg1.timeOverZoneDefined = true;
                    arg1.timeUnderZoneDefined = true;
                    arg1.trainingTimeDownhillDefined = true;
                    arg1.trainingTimeUphillDefined = true;
                    arg1.zone1StartDefined = true;
                    arg1.zone2StartDefined = true;
                    arg1.zone3EndDefined = true;
                    arg1.zone3StartDefined = true;
                    arg1.timeInZoneDefined = true;
                    arg1.distanceDefined = true;
                    arg1.maximumSpeedDefined = true;
                    arg1.averageSpeedDefined = true;
                    arg1.averageSpeedDownhillDefined = true;
                    arg1.averageSpeedUphillDefined = true;
                    arg1.wheelSizeDefined = true;
                    arg1.speedUnitDefined = true;
                }
            }
        }

        internal static function configEntryDefinitions(arg1:core.activities.ActivityEntry, arg2:core.general.UnitType, arg3:core.general.LogType=null):void
        {
            var loc1:*=arg2;
            while (core.general.UnitType.ROX100.toString() === loc1) 
            {
                arg1.distanceDefined = true;
                arg1.distanceAbsoluteDefined = true;
                arg1.distanceUphillDefined = true;
                arg1.distanceDownhillDefined = true;
                arg1.trainingTimeUphillDefined = true;
                arg1.trainingTimeDownhillDefined = true;
                arg1.heartrateDefined = true;
                arg1.speedDefined = true;
                arg1.speedTimeDefined = true;
                arg1.speedReferenceDefined = true;
                arg1.inclineDefined = true;
                arg1.riseRateDefined = true;
                arg1.altitudeDefined = true;
                arg1.altitudeDifferencesUphillDefined = true;
                arg1.altitudeDifferencesDownhillDefined = true;
                arg1.temperatureDefined = true;
                arg1.cadenceDefined = true;
                arg1.powerDefined = true;
                arg1.powerPerKGDefined = true;
                arg1.intensityZoneDefined = true;
                arg1.targetZoneDefined = true;
                arg1.latitudeDefined = true;
                arg1.longitudeDefined = true;
                arg1.caloriesDefined = true;
                arg1.percentHRMaxDefined = true;
                arg1.workInKJDefined = true;
            }
        }

        internal static const INSTANCE_CHECK_OBJECT:Object={};
    }
}


