//class SportprofileMapper
package core.sportprofiles 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import database.*;
    import handler.*;
    import init.*;
    import utils.*;
    
    public class SportprofileMapper extends Object
    {
        public function SportprofileMapper()
        {
            super();
            return;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.sportprofiles.Sportprofile):String
        {
            return "SELECT sportprofileId FROM Sportprofiles WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Sportprofiles SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDonSportprofile ON Sportprofiles (unitGUID)";
            return loc1;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (500 === loc2) 
            {
                DB_TABLE_500 = new database.DatabaseTable("Sportprofiles");
                DB_TABLE_500.addColumns([["sportprofileId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["unitGUID", "VARCHAR", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["sportId", "INTEGER", true], ["profileName", "VARCHAR", true], ["autoPause", "BOOLEAN", true], ["autoLap", "INTEGER", true], ["autoLapDistance", "INTEGER", true], ["autoLapCalories", "INTEGER", true], ["autoLapTime", "INTEGER", true], ["set_alert_basedon_distance", "VARCHAR", true], ["set_alert_basedon_time", "VARCHAR", true], ["set_alert_basedon_kcal", "VARCHAR", true], ["set_bike_name", "VARCHAR", true], ["set_bike_wheel_size", "INTEGER", true], ["set_bike_weight", "INTEGER", true], ["set_bike_type", "VARCHAR", true], ["set_avg_calc_power_inclzero", "VARCHAR", true], ["set_avg_calc_cad_inclzero", "VARCHAR", true], ["set_powerones_ftp", "VARCHAR", true], ["powerIntensityZone1Start", "INTEGER", true], ["powerIntensityZone2Start", "INTEGER", true], ["powerIntensityZone3Start", "INTEGER", true], ["powerIntensityZone4Start", "INTEGER", true], ["powerIntensityZone5Start", "INTEGER", true], ["powerIntensityZone6Start", "INTEGER", true], ["powerIntensityZone7Start", "INTEGER", true], ["powerIntensityZone7End", "INTEGER", true], ["intensityZone1", "NUMERIC", true], ["intensityZone2", "NUMERIC", true], ["intensityZone3", "NUMERIC", true], ["intensityZone4", "NUMERIC", true], ["intensityZone4End", "NUMERIC", true], ["gpsStatus", "BOOLEAN", true], ["fav_set_1", "VARCHAR", true], ["fav_set_2", "VARCHAR", true], ["fav_set_3", "VARCHAR", true], ["fav_set_4", "VARCHAR", true], ["fav_set_5", "VARCHAR", true], ["fav_set_6", "VARCHAR", true], ["fav_set_7", "VARCHAR", true], ["fav_set_8", "VARCHAR", true], ["fav_set_9", "VARCHAR", true], ["fav_set_10", "VARCHAR", true]]);
                loc1 = DB_TABLE_500;
            }
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Sportprofiles (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectSportprofiles(arg1:String, arg2:String="profileName", arg3:Boolean=false):String
        {
            return "SELECT * FROM Sportprofiles where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateXML(arg1:core.sportprofiles.Sportprofile):XML
        {
            var loc1:*=new XML("<Sportprofile/>");
            loc1.sportId = arg1.sportId;
            loc1.GUID = arg1.GUID;
            loc1.unitGUID = arg1.unitGUID;
            loc1.unitType = arg1.unit.type.toString();
            loc1.profileName = arg1.profileName;
            loc1.modificationDate = arg1.modificationDate;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                loc1.autoPause = (arg1 as core.settings.interfaces.IAutoPause).autoPause ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                loc1.autoLap = (arg1 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                loc1.autoLapBasedOnDistance = (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                loc1.autoLapBasedOnCalories = (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                loc1.autoLapBasedOnTime = (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                loc1.wheelSize1 = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                loc1.bikeWeight1 = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                loc1.bikeType1 = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IPowerFTP) 
            {
                loc1.thresholdPower = (arg1 as core.settings.interfaces.IPowerFTP).powerFTP;
            }
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc1.powerIntensityZone1Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
                loc1.powerIntensityZone2Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
                loc1.powerIntensityZone3Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
                loc1.powerIntensityZone4Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
                loc1.powerIntensityZone5Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
                loc1.powerIntensityZone6Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
                loc1.powerIntensityZone7Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
                loc1.powerIntensityZone7End = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc1.intensityZone1PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
                loc1.intensityZone2PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
                loc1.intensityZone3PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
                loc1.intensityZone4PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
                loc1.intensityZone4PercentageEnd = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                loc1.gpsStatus = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IFavSets) 
            {
                loc1.fav_set_1 = (arg1 as core.settings.interfaces.IFavSets).fav_set_1;
                loc1.fav_set_2 = (arg1 as core.settings.interfaces.IFavSets).fav_set_2;
                loc1.fav_set_3 = (arg1 as core.settings.interfaces.IFavSets).fav_set_3;
                loc1.fav_set_4 = (arg1 as core.settings.interfaces.IFavSets).fav_set_4;
                loc1.fav_set_5 = (arg1 as core.settings.interfaces.IFavSets).fav_set_5;
                loc1.fav_set_6 = (arg1 as core.settings.interfaces.IFavSets).fav_set_6;
                loc1.fav_set_7 = (arg1 as core.settings.interfaces.IFavSets).fav_set_7;
                loc1.fav_set_8 = (arg1 as core.settings.interfaces.IFavSets).fav_set_8;
                loc1.fav_set_9 = (arg1 as core.settings.interfaces.IFavSets).fav_set_9;
                loc1.fav_set_10 = (arg1 as core.settings.interfaces.IFavSets).fav_set_10;
            }
            if (arg1 is core.settings.interfaces.ILapFavSets) 
            {
                loc1.lap_fav_set_1 = (arg1 as core.settings.interfaces.ILapFavSets).lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAutoLapFavSets) 
            {
                loc1.auto_lap_fav_set_1 = (arg1 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAlarmDistance) 
            {
                loc1.alarmDistance = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistance ? "true" : "false";
                loc1.alarmDistanceBase = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmTime) 
            {
                loc1.alarmTime = (arg1 as core.settings.interfaces.IAlarmTime).alarmTime ? "true" : "false";
                loc1.alarmTimeBase = (arg1 as core.settings.interfaces.IAlarmTime).alarmTimeBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmCalories) 
            {
                loc1.alarmCalories = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCalories ? "true" : "false";
                loc1.alarmCaloriesBase = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase;
            }
            if (arg1 is core.settings.interfaces.IAutoWheelsize) 
            {
                loc1.autoWheelsize = (arg1 as core.settings.interfaces.IAutoWheelsize).autoWheelsize ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IAvgCadInclZero) 
            {
                loc1.avgCadInclZero = (arg1 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero;
            }
            if (arg1 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                loc1.avgPowerInclZero = (arg1 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero;
            }
            return loc1;
        }

        public static function fromXML(arg1:XML):core.sportprofiles.Sportprofile
        {
            var loc3:*=undefined;
            arg1.normalize();
            var loc2:*=arg1.name();
            if (loc2.localName != "Sportprofile") 
            {
                return null;
            }
            var loc1:*=core.general.UnitType.fromString(arg1.unitType);
            var loc4:*;
            (loc4 = core.sportprofiles.SportprofileFactory.createSportprofileFromUnitType(loc1)).sportId = arg1.sportId;
            loc4.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(loc4.sportId);
            loc4.GUID = arg1.GUID;
            loc4.unitGUID = arg1.unitGUID;
            loc4.unit = handler.AppDeviceHandlerCommon.deviceDicGUID[loc4.unitGUID];
            loc4.profileName = arg1.profileName;
            loc4.modificationDate = arg1.modificationDate;
            if (loc4 is core.settings.interfaces.IAutoPause) 
            {
                if ((loc3 = arg1.autoPause) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoPause).autoPause = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLap) 
            {
                if ((loc3 = arg1.autoLap) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLap).autoLap = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                if ((loc3 = arg1.autoLapBasedOnDistance) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                if ((loc3 = arg1.autoLapBasedOnCalories) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                if ((loc3 = arg1.autoLapBasedOnTime) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IWheelSize1) 
            {
                if ((loc3 = arg1.wheelSize1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IBikeWeight1) 
            {
                if ((loc3 = arg1.bikeWeight1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IBikeType1) 
            {
                if ((loc3 = arg1.bikeType1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IBikeType1).bikeType1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IPowerFTP) 
            {
                if ((loc3 = arg1.thresholdPower) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerFTP).powerFTP = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IPowerIntensityZone) 
            {
                if ((loc3 = arg1.powerIntensityZone1Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone2Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone3Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone4Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone5Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone6Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone7Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone7End) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = loc3;
                }
            }
            if (loc4 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                if ((loc3 = arg1.intensityZone1PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone2PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone3PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone4PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone4PercentageEnd) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IGPSStatus) 
            {
                if ((loc3 = arg1.gpsStatus) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IGPSStatus).gpsStatus = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IFavSets) 
            {
                if ((loc3 = arg1.fav_set_1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_1 = loc3;
                }
                if ((loc3 = arg1.fav_set_2) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_2 = loc3;
                }
                if ((loc3 = arg1.fav_set_3) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_3 = loc3;
                }
                if ((loc3 = arg1.fav_set_4) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_4 = loc3;
                }
                if ((loc3 = arg1.fav_set_5) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_5 = loc3;
                }
                if ((loc3 = arg1.fav_set_6) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_6 = loc3;
                }
                if ((loc3 = arg1.fav_set_7) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_7 = loc3;
                }
                if ((loc3 = arg1.fav_set_8) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_8 = loc3;
                }
                if ((loc3 = arg1.fav_set_9) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_9 = loc3;
                }
                if ((loc3 = arg1.fav_set_10) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_10 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.ILapFavSets) 
            {
                if ((loc3 = arg1.lap_fav_set_1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.ILapFavSets).lap_fav_set_1 = loc3;
                }
                if ((loc3 = arg1.lap_fav_set_2) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmDistance) 
            {
                if ((loc3 = arg1.alarmDistance) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmDistance).alarmDistance = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmDistanceBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmTime) 
            {
                if ((loc3 = arg1.alarmTime) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmTime).alarmTime = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmTimeBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmTime).alarmTimeBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmCalories) 
            {
                if ((loc3 = arg1.alarmCalories) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmCalories).alarmCalories = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmCaloriesBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoWheelsize) 
            {
                if ((loc3 = arg1.autoWheelsize) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoWheelsize).autoWheelsize = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IAvgCadInclZero) 
            {
                if ((loc3 = arg1.avgCadInclZero) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                if ((loc3 = arg1.avgPowerInclZero) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero = loc3;
                }
            }
            return loc4;
        }

        public static function generateDBInsert(arg1:core.sportprofiles.Sportprofile, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("sportprofileId");
            ++loc1;
            arg3[loc1] = arg1.sportprofileId > 0 ? arg1.sportprofileId : null;
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
            arg2.push("sportId");
            ++loc1;
            arg3[loc1] = arg1.sportId;
            arg2.push("profileName");
            ++loc1;
            arg3[loc1] = arg1.profileName;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                arg2.push("autoPause");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                arg2.push("autoLap");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                arg2.push("autoLapDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                arg2.push("autoLapCalories");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                arg2.push("autoLapTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                arg2.push("wheelSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                arg2.push("bikeWeight1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                arg2.push("bikeType1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IPowerFTP) 
            {
                arg2.push("powerFTP");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerFTP).powerFTP;
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
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
                arg2.push("intensityZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
                arg2.push("intensityZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
                arg2.push("intensityZone4");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
                arg2.push("intensityZone4End");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                arg2.push("gpsStatus");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            if (arg1 is core.settings.interfaces.IFavSets) 
            {
                arg2.push("fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_1;
                arg2.push("fav_set_2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_2;
                arg2.push("fav_set_3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_3;
                arg2.push("fav_set_4");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_4;
                arg2.push("fav_set_5");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_5;
                arg2.push("fav_set_6");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_6;
                arg2.push("fav_set_7");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_7;
                arg2.push("fav_set_8");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_8;
                arg2.push("fav_set_9");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_9;
                arg2.push("fav_set_10");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_10;
            }
            if (arg1 is core.settings.interfaces.ILapFavSets) 
            {
                arg2.push("lap_fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILapFavSets).lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAutoLapFavSets) 
            {
                arg2.push("auto_lap_fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAlarmDistance) 
            {
                arg2.push("alarmDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistance;
                arg2.push("alarmDistanceBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmTime) 
            {
                arg2.push("alarmTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmTime).alarmTime;
                arg2.push("alarmTimeBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmTime).alarmTimeBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmCalories) 
            {
                arg2.push("alarmCalories");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCalories;
                arg2.push("alarmCaloriesBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase;
            }
            if (arg1 is core.settings.interfaces.IAutoWheelsize) 
            {
                arg2.push("autoWheelsize");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoWheelsize).autoWheelsize;
            }
            if (arg1 is core.settings.interfaces.IAvgCadInclZero) 
            {
                arg2.push("avgCadInclZero");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero;
            }
            if (arg1 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                arg2.push("avgPowerInclZero");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero;
            }
            return;
        }

        public static function fromDB(arg1:Object, arg2:core.sportprofiles.Sportprofile, arg3:core.units.Unit=null):core.sportprofiles.Sportprofile
        {
            if (!arg2) 
            {
                if (arg3) 
                {
                    arg2 = core.sportprofiles.SportprofileFactory.createSportprofileFromUnitType(arg3.type);
                    arg2.unit = arg3;
                }
                else 
                {
                    arg2 = new core.sportprofiles.Sportprofile();
                }
            }
            arg2.sportprofileId = arg1["sportprofileId"];
            arg2.GUID = arg1["GUID"];
            arg2.unitGUID = arg1["unitGUID"];
            arg2.modificationDate = arg1["modificationDate"];
            arg2.isDeleted = arg1["isDeleted"];
            arg2.sportId = arg1["sportId"];
            arg2.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg2.sportId);
            arg2.profileName = arg1["profileName"];
            if (arg2 is core.settings.interfaces.IAutoPause) 
            {
                (arg2 as core.settings.interfaces.IAutoPause).autoPause = arg1["autoPause"];
            }
            if (arg2 is core.settings.interfaces.IAutoLap) 
            {
                (arg2 as core.settings.interfaces.IAutoLap).autoLap = arg1["autoLap"];
                (arg2 as core.settings.interfaces.IAutoLap).autoLapBasedOn = (arg2 as core.settings.interfaces.IAutoLap).autoLap > 0 ? ((arg2 as core.settings.interfaces.IAutoLap).autoLap - 1) : (arg2 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = arg1["autoLapDistance"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories = arg1["autoLapCalories"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime = arg1["autoLapTime"];
            }
            if (arg2 is core.settings.interfaces.IWheelSize1) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1).wheelSize1 = arg1["wheelSize1"];
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = arg1["bikeWeight1"];
            }
            if (arg2 is core.settings.interfaces.IBikeType1) 
            {
                (arg2 as core.settings.interfaces.IBikeType1).bikeType1 = arg1["bikeType1"];
            }
            if (arg2 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = arg1["powerIntensityZone1Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = arg1["powerIntensityZone2Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = arg1["powerIntensityZone3Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = arg1["powerIntensityZone4Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = arg1["powerIntensityZone5Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = arg1["powerIntensityZone6Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = arg1["powerIntensityZone7Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = arg1["powerIntensityZone7End"];
            }
            if (arg2 is core.settings.interfaces.IPowerFTP) 
            {
                (arg2 as core.settings.interfaces.IPowerFTP).powerFTP = arg1["powerFTP"];
            }
            if (arg2 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = arg1["intensityZone1"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = arg1["intensityZone2"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = arg1["intensityZone3"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = arg1["intensityZone4"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = arg1["intensityZone4End"];
            }
            if (arg2 is core.settings.interfaces.IGPSStatus) 
            {
                (arg2 as core.settings.interfaces.IGPSStatus).gpsStatus = arg1["gpsStatus"];
            }
            if (arg2 is core.settings.interfaces.IFavSets) 
            {
                (arg2 as core.settings.interfaces.IFavSets).fav_set_1 = arg1["fav_set_1"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_2 = arg1["fav_set_2"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_3 = arg1["fav_set_3"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_4 = arg1["fav_set_4"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_5 = arg1["fav_set_5"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_6 = arg1["fav_set_6"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_7 = arg1["fav_set_7"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_8 = arg1["fav_set_8"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_9 = arg1["fav_set_9"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_10 = arg1["fav_set_10"];
            }
            if (arg2 is core.settings.interfaces.ILapFavSets) 
            {
                (arg2 as core.settings.interfaces.ILapFavSets).lap_fav_set_1 = arg1["lap_fav_set_1"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapFavSets) 
            {
                (arg2 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1 = arg1["auto_lap_fav_set_1"];
            }
            if (arg2 is core.settings.interfaces.IAlarmDistance) 
            {
                (arg2 as core.settings.interfaces.IAlarmDistance).alarmDistance = arg1["alarmDistance"];
                (arg2 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase = arg1["alarmDistanceBase"];
            }
            if (arg2 is core.settings.interfaces.IAlarmTime) 
            {
                (arg2 as core.settings.interfaces.IAlarmTime).alarmTime = arg1["alarmTime"];
                (arg2 as core.settings.interfaces.IAlarmTime).alarmTimeBase = arg1["alarmTimeBase"];
            }
            if (arg2 is core.settings.interfaces.IAlarmCalories) 
            {
                (arg2 as core.settings.interfaces.IAlarmCalories).alarmCalories = arg1["alarmCalories"];
                (arg2 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase = arg1["alarmCaloriesBase"];
            }
            if (arg2 is core.settings.interfaces.IAutoWheelsize) 
            {
                (arg2 as core.settings.interfaces.IAutoWheelsize).autoWheelsize = arg1["autoWheelsize"];
            }
            if (arg2 is core.settings.interfaces.IAvgCadInclZero) 
            {
                (arg2 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero = arg1["avgCadInclZero"];
            }
            if (arg2 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                (arg2 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero = arg1["avgPowerInclZero"];
            }
            return arg2;
        }

        public static function generateDBDelete(arg1:core.sportprofiles.Sportprofile):String
        {
            return "delete from Sportprofiles where Sportprofiles.GUID = " + arg1.GUID;
        }

        public static const col_alarmDistanceBase:String="alarmDistanceBase";

        public static const col_alarmTime:String="alarmTime";

        public static const col_alarmTimeBase:String="alarmTimeBase";

        public static const col_autoLap:String="autoLap";

        public static const col_autoLapBasedOn:String="autoLapBasedOn";

        public static const col_autoLapCalories:String="autoLapCalories";

        public static const col_autoLapDistance:String="autoLapDistance";

        public static const col_autoLapTime:String="autoLapTime";

        public static const col_autoPause:String="autoPause";

        public static const col_autoWheelsize:String="autoWheelsize";

        public static const col_auto_lap_fav_set_1:String="auto_lap_fav_set_1";

        public static const col_avgCadInclZero:String="avgCadInclZero";

        public static const col_avgPowerInclZero:String="avgPowerInclZero";

        public static const col_bikeType1:String="bikeType1";

        public static const col_bikeWeight1:String="bikeWeight1";

        public static const col_fav_set_1:String="fav_set_1";

        public static const col_fav_set_10:String="fav_set_10";

        public static const col_fav_set_2:String="fav_set_2";

        public static const col_fav_set_3:String="fav_set_3";

        public static const col_fav_set_4:String="fav_set_4";

        public static const col_fav_set_5:String="fav_set_5";

        public static const col_fav_set_6:String="fav_set_6";

        public static const col_fav_set_7:String="fav_set_7";

        public static const col_GUID:String="GUID";

        public static const col_fav_set_9:String="fav_set_9";

        public static const col_gpsStatus:String="gpsStatus";

        public static const col_intensityZone1:String="intensityZone1";

        public static const col_intensityZone2:String="intensityZone2";

        public static const col_intensityZone3:String="intensityZone3";

        public static const col_intensityZone4:String="intensityZone4";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_isDeleted:String="isDeleted";

        public static const col_lap_fav_set_1:String="lap_fav_set_1";

        public static const col_modificationDate:String="modificationDate";

        public static const col_powerFTP:String="powerFTP";

        public static const col_powerIntensityZone1Start:String="powerIntensityZone1Start";

        public static const col_powerIntensityZone2Start:String="powerIntensityZone2Start";

        public static const col_powerIntensityZone3Start:String="powerIntensityZone3Start";

        public static const col_powerIntensityZone4Start:String="powerIntensityZone4Start";

        public static const col_powerIntensityZone5Start:String="powerIntensityZone5Start";

        public static const col_powerIntensityZone6Start:String="powerIntensityZone6Start";

        public static const col_powerIntensityZone7End:String="powerIntensityZone7End";

        public static const col_profileName:String="profileName";

        public static const col_sportId:String="sportId";

        public static const col_sportprofileId:String="sportprofileId";

        public static const col_unitGUID:String="unitGUID";

        public static const col_wheelSize1:String="wheelSize1";

        public static const col_fav_set_8:String="fav_set_8";

        public static const ATTR_SQL_STATEMENT:String="sqlStatement";

        public static const ATTR_SQL_UPDATE_LINES:String="sqlUpdateLines";

        public static const INDEX_NAME:String="UnitGUIDonSportprofile";

        public static const TABLE_NAME:String="Sportprofiles";

        public static const col_alarmCalories:String="alarmCalories";

        public static const col_alarmCaloriesBase:String="alarmCaloriesBase";

        public static const col_alarmDistance:String="alarmDistance";

        public static const col_powerIntensityZone7Start:String="powerIntensityZone7Start";

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


