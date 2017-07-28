//class MarkerMapper
package core.marker 
{
    import core.activities.*;
    import core.general.*;
    import core.training.type.*;
    import database.*;
    
    public class MarkerMapper extends Object
    {
        public function MarkerMapper()
        {
            super();
            return;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS ActivityIdOnMarker ON Marker (activityId)";
            return loc1;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Marker");
                DB_TABLE_400.addColumns([["markerId", "INTEGER", false, true, true], ["activityId", "INTEGER", false], ["altitudeDownhill", "INTEGER", true], ["altitudeUphill", "INTEGER", true], ["averageAltitude", "INTEGER", true], ["averageCadence", "NUMERIC", true], ["averageHeartrate", "INTEGER", true], ["averageInclineDownhill", "NUMERIC", true], ["averageInclineUphill", "NUMERIC", true], ["averagePower", "NUMERIC", true], ["averageRiseRateDownhill", "NUMERIC", true], ["averageRiseRateUphill", "NUMERIC", true], ["averageSpeed", "NUMERIC", true], ["calories", "NUMERIC", true], ["description", "TEXT", true], ["distance", "NUMERIC", true], ["distanceAbsolute", "NUMERIC", true], ["distanceDownhill", "NUMERIC", true], ["distanceUphill", "NUMERIC", true], ["duration", "NUMERIC", true], ["fastLap", "BOOL", true], ["latitude", "NUMERIC", true], ["longitude", "NUMERIC", true], ["maximumAltitude", "INTEGER", true], ["maximumCadence", "NUMERIC", true], ["maximumHeartrate", "INTEGER", true], ["maximumInclineDownhill", "NUMERIC", true], ["maximumInclineUphill", "NUMERIC", true], ["maximumPower", "NUMERIC", true], ["maximumRiseRateDownhill", "NUMERIC", true], ["maximumRiseRateUphill", "NUMERIC", true], ["maximumSpeed", "NUMERIC", true], ["minimumHeartrate", "INTEGER", true], ["minimumSpeed", "NUMERIC", true], ["number", "INTEGER", true], ["time", "NUMERIC", true], ["timeAbsolute", "NUMERIC", true], ["timeDownhill", "NUMERIC", true], ["timeUphill", "NUMERIC", true], ["title", "VARCHAR", true], ["type", "VARCHAR", true], ["tXSensorPosition", "VARCHAR", true], ["timeUnderTargetZone", "NUMERIC", true], ["timeInTargetZone", "NUMERIC", true], ["timeOverTargetZone", "NUMERIC", true], ["intervalCount", "INTEGER", true], ["plannedAutoChange", "VARCHAR", true], ["plannedLoadRecovery", "STRING", true], ["plannedLowerLimit", "INTEGER", true], ["plannedPhaseControl", "STRING", true], ["plannedRecoveryLowerLimit", "INTEGER", true], ["plannedRecoveryPhaseControl", "STRING", true], ["plannedRecoveryTime", "NUMERIC", true], ["plannedRecoveryUpperLimit", "INTEGER", true], ["plannedTime", "NUMERIC", true], ["plannedUpperLimit", "INTEGER", true], ["plannedDistance", "NUMERIC", true], ["plannedRecoveryDistance", "NUMERIC", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function fromDB(arg1:Object, arg2:core.marker.Marker):void
        {
            arg2.markerId = arg1["markerId"];
            arg2.activityId = arg1["activityId"];
            arg2.description = arg1["description"];
            var loc1:*;
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
            arg2.duration = arg1["duration"];
            arg2.number = arg1["number"];
            arg2.time = arg1["time"];
            arg2.timeAbsolute = arg1["timeAbsolute"];
            arg2.title = arg1["title"];
            arg2.type = arg1["type"];
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
            if ("p" == arg2.type && true) 
            {
                return;
            }
            arg2.altitudeDownhillDefined = loc1 = !(arg1["altitudeDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeDownhill = arg1["altitudeDownhill"];
            }
            arg2.altitudeUphillDefined = loc1 = !(arg1["altitudeUphill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeUphill = arg1["altitudeUphill"];
            }
            arg2.averageAltitudeDefined = loc1 = !(arg1["averageAltitude"] == null);
            if (loc1 == true) 
            {
                arg2.averageAltitude = arg1["averageAltitude"];
            }
            arg2.averageCadenceDefined = loc1 = !(arg1["averageCadence"] == null);
            if (loc1 == true) 
            {
                arg2.averageCadence = arg1["averageCadence"];
            }
            arg2.averageHeartrateDefined = loc1 = !(arg1["averageHeartrate"] == null);
            if (loc1 == true) 
            {
                arg2.averageHeartrate = arg1["averageHeartrate"];
            }
            arg2.averageInclineDownhillDefined = loc1 = !(arg1["averageInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.averageInclineDownhill = arg1["averageInclineDownhill"];
            }
            arg2.averageInclineUphillDefined = loc1 = !(arg1["averageInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg2.averageInclineUphill = arg1["averageInclineUphill"];
            }
            arg2.averagePowerDefined = loc1 = !(arg1["averagePower"] == null);
            if (loc1 == true) 
            {
                arg2.averagePower = arg1["averagePower"];
            }
            arg2.averageRiseRateDownhillDefined = loc1 = !(arg1["averageRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.averageRiseRateDownhill = arg1["averageRiseRateDownhill"];
            }
            arg2.averageRiseRateUphillDefined = loc1 = !(arg1["averageRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg2.averageRiseRateUphill = arg1["averageRiseRateUphill"];
            }
            arg2.averageSpeedDefined = loc1 = !(arg1["averageSpeed"] == null);
            if (loc1 == true) 
            {
                arg2.averageSpeed = arg1["averageSpeed"];
            }
            arg2.caloriesDefined = loc1 = !(arg1["calories"] == null);
            if (loc1 == true) 
            {
                arg2.calories = arg1["calories"];
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
            arg2.fastLapDefined = loc1 = !(arg1["fastLap"] == null);
            if (loc1 == true) 
            {
                arg2.fastLap = arg1["fastLap"];
            }
            arg2.maximumAltitudeDefined = loc1 = !(arg1["maximumAltitude"] == null);
            if (loc1 == true) 
            {
                arg2.maximumAltitude = arg1["maximumAltitude"];
            }
            arg2.maximumCadenceDefined = loc1 = !(arg1["maximumCadence"] == null);
            if (loc1 == true) 
            {
                arg2.maximumCadence = arg1["maximumCadence"];
            }
            arg2.maximumHeartrateDefined = loc1 = !(arg1["maximumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg2.maximumHeartrate = arg1["maximumHeartrate"];
            }
            arg2.maximumInclineDownhillDefined = loc1 = !(arg1["maximumInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.maximumInclineDownhill = arg1["maximumInclineDownhill"];
            }
            arg2.maximumInclineUphillDefined = loc1 = !(arg1["maximumInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg2.maximumInclineUphill = arg1["maximumInclineUphill"];
            }
            arg2.maximumPowerDefined = loc1 = !(arg1["maximumPower"] == null);
            if (loc1 == true) 
            {
                arg2.maximumPower = arg1["maximumPower"];
            }
            arg2.maximumRiseRateDownhillDefined = loc1 = !(arg1["maximumRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.maximumRiseRateDownhill = arg1["maximumRiseRateDownhill"];
            }
            arg2.maximumRiseRateUphillDefined = loc1 = !(arg1["maximumRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg2.maximumRiseRateUphill = arg1["maximumRiseRateUphill"];
            }
            arg2.maximumSpeedDefined = loc1 = !(arg1["maximumSpeed"] == null);
            if (loc1 == true) 
            {
                arg2.maximumSpeed = arg1["maximumSpeed"];
            }
            arg2.minimumHeartrateDefined = loc1 = !(arg1["minimumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg2.minimumHeartrate = arg1["minimumHeartrate"];
            }
            arg2.minimumSpeedDefined = loc1 = !(arg1["minimumSpeed"] == null);
            if (loc1 == true) 
            {
                arg2.minimumSpeed = arg1["minimumSpeed"];
            }
            arg2.timeDownhillDefined = loc1 = !(arg1["timeDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.timeDownhill = arg1["timeDownhill"];
            }
            arg2.timeUphillDefined = loc1 = !(arg1["timeUphill"] == null);
            if (loc1 == true) 
            {
                arg2.timeUphill = arg1["timeUphill"];
            }
            arg2.normalizedPowerDefined = loc1 = !(arg1["normalizedPower"] == null);
            if (loc1 == true) 
            {
                arg2.normalizedPower = arg1["normalizedPower"];
            }
            arg2.averageBalanceDefined = loc1 = !(arg1["averageBalance"] == null);
            if (loc1 == true) 
            {
                arg2.averageBalance = arg1["averageBalance"];
            }
            arg2.pedalingTimeDefined = loc1 = !(arg1["pedalingTime"] == null);
            if (loc1 == true) 
            {
                arg2.pedalingTime = arg1["pedalingTime"];
            }
            arg2.leftTorqueEffectivityDefined = loc1 = !(arg1["leftTorqueEffectivity"] == null);
            if (loc1 == true) 
            {
                arg2.leftTorqueEffectivity = arg1["leftTorqueEffectivity"];
            }
            arg2.rightTorqueEffectivityDefined = loc1 = !(arg1["rightTorqueEffectivity"] == null);
            if (loc1 == true) 
            {
                arg2.rightTorqueEffectivity = arg1["rightTorqueEffectivity"];
            }
            arg2.leftPedalingSmoothnessDefined = loc1 = !(arg1["leftPedalingSmoothness"] == null);
            if (loc1 == true) 
            {
                arg2.leftPedalingSmoothness = arg1["leftPedalingSmoothness"];
            }
            arg2.rightPedalingSmoothnessDefined = loc1 = !(arg1["rightPedalingSmoothness"] == null);
            if (loc1 == true) 
            {
                arg2.rightPedalingSmoothness = arg1["rightPedalingSmoothness"];
            }
            arg2.timeUnderTargetZoneDefined = loc1 = !(arg1["timeUnderTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeUnderTargetZone = arg1["timeUnderTargetZone"];
            }
            arg2.timeInTargetZoneDefined = loc1 = !(arg1["timeInTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeInTargetZone = arg1["timeInTargetZone"];
            }
            arg2.timeOverTargetZoneDefined = loc1 = !(arg1["timeOverTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeOverTargetZone = arg1["timeOverTargetZone"];
            }
            arg2.intervalCountDefined = loc1 = !(arg1["intervalCount"] == null);
            if (loc1 == true) 
            {
                arg2.intervalCount = arg1["intervalCount"];
            }
            loc1 = arg2.type;
            while ("IntervalPhase" === loc1) 
            {
                arg2.logReference.phaseDefined = true;
            }
        }

        public static function fromXML(arg1:XML, arg2:core.marker.Marker, arg3:int, arg4:core.activities.Activity):core.marker.Marker
        {
            var loc1:*=arg3;
            while (200 === loc1) 
            {
                return fromOldXML(arg1, arg2, arg3, arg4);
                return fromXML400(arg1, arg2, arg4);
                return null;
            }
        }

        internal static function fromXML400(arg1:XML, arg2:core.marker.Marker, arg3:core.activities.Activity):core.marker.Marker
        {
            var loc2:*=undefined;
            var loc1:*;
            (loc1 = core.marker.MarkerFactory.createMarkerFromLog(arg3)).logReference = arg3;
            loc1.number = arg1.@number;
            loc2 = arg1.@altitudeDownhill;
            var loc3:*;
            loc1.altitudeDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.altitudeDownhill = loc2;
            }
            loc2 = arg1.@altitudeUphill;
            loc1.altitudeUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.altitudeUphill = loc2;
            }
            loc2 = arg1.@averageAltitude;
            loc1.averageAltitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageAltitude = loc2;
            }
            loc2 = arg1.@averageCadence;
            loc1.averageCadenceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageCadence = loc2;
            }
            loc2 = arg1.@averageHeartrate;
            loc1.averageHeartrateDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageHeartrate = loc2;
            }
            loc2 = arg1.@averageInclineDownhill;
            loc1.averageInclineDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageInclineDownhill = loc2;
            }
            loc2 = arg1.@averageInclineUphill;
            loc1.averageInclineUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageInclineUphill = loc2;
            }
            loc2 = arg1.@averagePower;
            loc1.averagePowerDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averagePower = loc2;
            }
            loc2 = arg1.@averageRiseRateDownhill;
            loc1.averageRiseRateDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageRiseRateDownhill = loc2;
            }
            loc2 = arg1.@averageRiseRateUphill;
            loc1.averageRiseRateUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageRiseRateUphill = loc2;
            }
            loc2 = arg1.@averageSpeed;
            loc1.averageSpeedDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageSpeed = loc2;
            }
            loc2 = arg1.@calories;
            loc1.caloriesDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.calories = loc2;
            }
            loc1.description = arg1.@description;
            loc2 = arg1.@distance;
            loc1.distanceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distance = loc2;
            }
            loc2 = arg1.@distanceAbsolute;
            loc1.distanceAbsoluteDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceAbsolute = loc2;
            }
            loc2 = arg1.@distanceDownhill;
            loc1.distanceDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceDownhill = loc2;
            }
            loc2 = arg1.@distanceUphill;
            loc1.distanceUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceUphill = loc2;
            }
            loc1.duration = arg1.@duration;
            loc2 = arg1.@fastLap;
            loc1.fastLapDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.fastLap = loc2;
            }
            loc2 = arg1.@latitude;
            loc1.latitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.latitude = loc2;
            }
            loc2 = arg1.@longitude;
            loc1.longitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.longitude = loc2;
            }
            loc2 = arg1.@maximumAltitude;
            loc1.maximumAltitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumAltitude = loc2;
            }
            loc2 = arg1.@maximumCadence;
            loc1.maximumCadenceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumCadence = loc2;
            }
            loc2 = arg1.@maximumHeartrate;
            loc1.maximumHeartrateDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumHeartrate = loc2;
            }
            loc2 = arg1.@maximumInclineDownhill;
            loc1.maximumInclineDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumInclineDownhill = loc2;
            }
            loc2 = arg1.@maximumInclineUphill;
            loc1.maximumInclineUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumInclineUphill = loc2;
            }
            loc2 = arg1.@maximumPower;
            loc1.maximumPowerDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumPower = loc2;
            }
            loc2 = arg1.@maximumRiseRateDownhill;
            loc1.maximumRiseRateDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumRiseRateDownhill = loc2;
            }
            loc2 = arg1.@maximumRiseRateUphill;
            loc1.maximumRiseRateUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumRiseRateUphill = loc2;
            }
            loc2 = arg1.@maximumSpeed;
            loc1.maximumSpeedDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumSpeed = loc2;
            }
            loc2 = arg1.@minimumHeartrate;
            loc1.minimumHeartrateDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.minimumHeartrate = loc2;
            }
            loc2 = arg1.@minimumSpeed;
            loc1.minimumSpeedDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.minimumSpeed = loc2;
            }
            loc1.time = arg1.@time;
            loc1.timeAbsolute = arg1.@timeAbsolute;
            loc2 = arg1.@timeDownhill;
            loc1.timeDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeDownhill = loc2;
            }
            loc2 = arg1.@timeUphill;
            loc1.timeUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeUphill = loc2;
            }
            loc2 = arg1.@normalizedPower;
            loc1.normalizedPowerDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.normalizedPower = loc2;
            }
            loc2 = arg1.@averageBalance;
            loc1.averageBalanceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageBalance = loc2;
            }
            loc2 = arg1.@pedalingTime;
            loc1.pedalingTimeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.pedalingTime = loc2;
            }
            loc2 = arg1.@leftTorqueEffectivity;
            loc1.leftTorqueEffectivityDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.leftTorqueEffectivity = loc2;
            }
            loc2 = arg1.@rightTorqueEffectivity;
            loc1.rightTorqueEffectivityDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.rightTorqueEffectivity = loc2;
            }
            loc2 = arg1.@leftPedalingSmoothness;
            loc1.leftPedalingSmoothnessDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.leftPedalingSmoothness = loc2;
            }
            loc2 = arg1.rightPedalingSmoothness;
            loc1.rightPedalingSmoothnessDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.rightPedalingSmoothness = loc2;
            }
            loc2 = arg1.@timeUnderTargetZone;
            loc1.timeUnderTargetZoneDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeUnderTargetZone = loc2;
            }
            loc2 = arg1.@timeInTargetZone;
            loc1.timeInTargetZoneDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeInTargetZone = loc2;
            }
            loc2 = arg1.@timeOverTargetZone;
            loc1.timeOverTargetZoneDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeOverTargetZone = loc2;
            }
            loc2 = arg1.@intervalCount;
            loc1.intervalCountDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.intervalCount = loc2;
            }
            loc1.title = arg1.@title;
            loc2 = arg1.@tXSensorPosition;
            loc1.tXSensorPositionDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.tXSensorPosition = loc2;
            }
            loc1.type = arg1.@type;
            loc3 = loc1.type;
            while ("IntervalPhase" === loc3) 
            {
                loc1.logReference.phaseDefined = true;
            }
        }

        public static function generateDBColumns(arg1:core.marker.Marker):Array
        {
            var loc1:*=[];
            loc1.push("markerId");
            loc1.push("activityId");
            loc1.push("altitudeDownhill");
            loc1.push("altitudeUphill");
            loc1.push("averageAltitude");
            loc1.push("averageCadence");
            loc1.push("averageHeartrate");
            loc1.push("averageInclineDownhill");
            loc1.push("averageInclineUphill");
            loc1.push("averagePower");
            loc1.push("averageRiseRateDownhill");
            loc1.push("averageRiseRateUphill");
            loc1.push("averageSpeed");
            loc1.push("calories");
            loc1.push("description");
            loc1.push("distance");
            loc1.push("distanceAbsolute");
            loc1.push("distanceDownhill");
            loc1.push("distanceUphill");
            loc1.push("duration");
            loc1.push("fastLap");
            loc1.push("latitude");
            loc1.push("longitude");
            loc1.push("maximumAltitude");
            loc1.push("maximumCadence");
            loc1.push("maximumHeartrate");
            loc1.push("maximumInclineDownhill");
            loc1.push("maximumInclineUphill");
            loc1.push("maximumPower");
            loc1.push("maximumRiseRateDownhill");
            loc1.push("maximumRiseRateUphill");
            loc1.push("maximumSpeed");
            loc1.push("minimumHeartrate");
            loc1.push("minimumSpeed");
            loc1.push("number");
            loc1.push("time");
            loc1.push("timeAbsolute");
            loc1.push("timeDownhill");
            loc1.push("timeUphill");
            loc1.push("normalizedPower");
            loc1.push("averageBalance");
            loc1.push("pedalingTime");
            loc1.push("leftTorqueEffectivity");
            loc1.push("rightTorqueEffectivity");
            loc1.push("leftPedalingSmoothness");
            loc1.push("rightPedalingSmoothness");
            loc1.push("title");
            loc1.push("tXSensorPosition");
            loc1.push("timeUnderTargetZone");
            loc1.push("timeInTargetZone");
            loc1.push("timeOverTargetZone");
            loc1.push("intervalCount");
            loc1.push("type");
            loc1.push("plannedAutoChange");
            loc1.push("plannedLoadRecovery");
            loc1.push("plannedLowerLimit");
            loc1.push("plannedPhaseControl");
            loc1.push("plannedRecoveryLowerLimit");
            loc1.push("plannedRecoveryPhaseControl");
            loc1.push("plannedRecoveryTime");
            loc1.push("plannedRecoveryUpperLimit");
            loc1.push("plannedTime");
            loc1.push("plannedUpperLimit");
            loc1.push("plannedDistance");
            loc1.push("plannedRecoveryDistance");
            return loc1;
        }

        public static function generateDBInsertStmtText(arg1:core.marker.Marker):String
        {
            var loc1:*=generateDBColumns(arg1);
            return generateDBInsertStmt(loc1);
        }

        public static function generateDBInsertStmt(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Marker (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function generateDBDelete(arg1:core.marker.Marker):String
        {
            return "DELETE FROM Marker WHERE Marker.markerId = " + arg1.markerId;
        }

        public static function generateDBInsertStmtParameter(arg1:core.marker.Marker, arg2:Object):void
        {
            arg2[":activityId"] = arg1.activityId;
            if (arg1.markerId > 0) 
            {
                arg2[":markerId"] = arg1.markerId;
            }
            else 
            {
                arg2[":markerId"] = null;
            }
            if (arg1.altitudeDownhillDefined) 
            {
                arg2[":altitudeDownhill"] = arg1.altitudeDownhill;
            }
            else 
            {
                arg2[":altitudeDownhill"] = null;
            }
            if (arg1.altitudeUphillDefined) 
            {
                arg2[":altitudeUphill"] = arg1.altitudeUphill;
            }
            else 
            {
                arg2[":altitudeUphill"] = null;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg2[":averageAltitude"] = arg1.averageAltitude;
            }
            else 
            {
                arg2[":averageAltitude"] = null;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg2[":averageCadence"] = arg1.averageCadence;
            }
            else 
            {
                arg2[":averageCadence"] = null;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg2[":averageHeartrate"] = arg1.averageHeartrate;
            }
            else 
            {
                arg2[":averageHeartrate"] = null;
            }
            if (arg1.averageInclineDownhillDefined) 
            {
                arg2[":averageInclineDownhill"] = arg1.averageInclineDownhill;
            }
            else 
            {
                arg2[":averageInclineDownhill"] = null;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg2[":averageInclineUphill"] = arg1.averageInclineUphill;
            }
            else 
            {
                arg2[":averageInclineUphill"] = null;
            }
            if (arg1.averagePowerDefined) 
            {
                arg2[":averagePower"] = arg1.averagePower;
            }
            else 
            {
                arg2[":averagePower"] = null;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg2[":averageRiseRateDownhill"] = arg1.averageRiseRateDownhill;
            }
            else 
            {
                arg2[":averageRiseRateDownhill"] = null;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg2[":averageRiseRateUphill"] = arg1.averageRiseRateUphill;
            }
            else 
            {
                arg2[":averageRiseRateUphill"] = null;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg2[":averageSpeed"] = arg1.averageSpeed;
            }
            else 
            {
                arg2[":averageSpeed"] = null;
            }
            if (arg1.caloriesDefined) 
            {
                arg2[":calories"] = arg1.calories;
            }
            else 
            {
                arg2[":calories"] = null;
            }
            arg2[":description"] = arg1.description;
            if (arg1.distanceDefined) 
            {
                arg2[":distance"] = arg1.distance;
            }
            else 
            {
                arg2[":distance"] = null;
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                arg2[":distanceAbsolute"] = arg1.distanceAbsolute;
            }
            else 
            {
                arg2[":distanceAbsolute"] = null;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg2[":distanceDownhill"] = arg1.distanceDownhill;
            }
            else 
            {
                arg2[":distanceDownhill"] = null;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg2[":distanceUphill"] = arg1.distanceUphill;
            }
            else 
            {
                arg2[":distanceUphill"] = null;
            }
            arg2[":duration"] = arg1.duration;
            if (arg1.fastLapDefined) 
            {
                arg2[":fastLap"] = arg1.fastLap;
            }
            else 
            {
                arg2[":fastLap"] = null;
            }
            if (arg1.latitudeDefined) 
            {
                arg2[":latitude"] = arg1.latitude;
            }
            else 
            {
                arg2[":latitude"] = null;
            }
            if (arg1.longitudeDefined) 
            {
                arg2[":longitude"] = arg1.longitude;
            }
            else 
            {
                arg2[":longitude"] = null;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg2[":maximumAltitude"] = arg1.maximumAltitude;
            }
            else 
            {
                arg2[":maximumAltitude"] = null;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg2[":maximumCadence"] = arg1.maximumCadence;
            }
            else 
            {
                arg2[":maximumCadence"] = null;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg2[":maximumHeartrate"] = arg1.maximumHeartrate;
            }
            else 
            {
                arg2[":maximumHeartrate"] = null;
            }
            if (arg1.maximumInclineDownhillDefined) 
            {
                arg2[":maximumInclineDownhill"] = arg1.maximumInclineDownhill;
            }
            else 
            {
                arg2[":maximumInclineDownhill"] = null;
            }
            if (arg1.maximumInclineUphillDefined) 
            {
                arg2[":maximumInclineUphill"] = arg1.maximumInclineUphill;
            }
            else 
            {
                arg2[":maximumInclineUphill"] = null;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg2[":maximumPower"] = arg1.maximumPower;
            }
            else 
            {
                arg2[":maximumPower"] = null;
            }
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                arg2[":maximumRiseRateDownhill"] = arg1.maximumRiseRateDownhill;
            }
            else 
            {
                arg2[":maximumRiseRateDownhill"] = null;
            }
            if (arg1.maximumRiseRateUphillDefined) 
            {
                arg2[":maximumRiseRateUphill"] = arg1.maximumRiseRateUphill;
            }
            else 
            {
                arg2[":maximumRiseRateUphill"] = null;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg2[":maximumSpeed"] = arg1.maximumSpeed;
            }
            else 
            {
                arg2[":maximumSpeed"] = null;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg2[":minimumHeartrate"] = arg1.minimumHeartrate;
            }
            else 
            {
                arg2[":minimumHeartrate"] = null;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg2[":minimumSpeed"] = arg1.minimumSpeed;
            }
            else 
            {
                arg2[":minimumSpeed"] = null;
            }
            arg2[":number"] = arg1.number;
            arg2[":time"] = arg1.time;
            arg2[":timeAbsolute"] = arg1.timeAbsolute;
            if (arg1.timeDownhillDefined) 
            {
                arg2[":timeDownhill"] = arg1.timeDownhill;
            }
            else 
            {
                arg2[":timeDownhill"] = null;
            }
            if (arg1.timeUphillDefined) 
            {
                arg2[":timeUphill"] = arg1.timeUphill;
            }
            else 
            {
                arg2[":timeUphill"] = null;
            }
            if (arg1.normalizedPowerDefined) 
            {
                arg2[":normalizedPower"] = arg1.normalizedPower;
            }
            else 
            {
                arg2[":normalizedPower"] = null;
            }
            if (arg1.averageBalanceDefined) 
            {
                arg2[":averageBalance"] = arg1.averageBalance;
            }
            else 
            {
                arg2[":averageBalance"] = null;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg2[":pedalingTime"] = arg1.pedalingTime;
            }
            else 
            {
                arg2[":pedalingTime"] = null;
            }
            if (arg1.leftTorqueEffectivityDefined) 
            {
                arg2[":leftTorqueEffectivity"] = arg1.leftTorqueEffectivity;
            }
            else 
            {
                arg2[":leftTorqueEffectivity"] = null;
            }
            if (arg1.rightTorqueEffectivityDefined) 
            {
                arg2[":rightTorqueEffectivity"] = arg1.rightTorqueEffectivity;
            }
            else 
            {
                arg2[":rightTorqueEffectivity"] = null;
            }
            if (arg1.leftPedalingSmoothnessDefined) 
            {
                arg2[":leftPedalingSmoothness"] = arg1.leftPedalingSmoothness;
            }
            else 
            {
                arg2[":leftPedalingSmoothness"] = null;
            }
            if (arg1.rightPedalingSmoothnessDefined) 
            {
                arg2[":rightPedalingSmoothness"] = arg1.rightPedalingSmoothness;
            }
            else 
            {
                arg2[":rightPedalingSmoothness"] = null;
            }
            arg2[":title"] = arg1.title;
            if (arg1.tXSensorPositionDefined) 
            {
                arg2[":tXSensorPosition"] = arg1.tXSensorPosition;
            }
            else 
            {
                arg2[":tXSensorPosition"] = null;
            }
            arg2[":type"] = arg1.type;
            if (arg1.timeUnderTargetZoneDefined) 
            {
                arg2[":timeUnderTargetZone"] = arg1.timeUnderTargetZone;
            }
            else 
            {
                arg2[":timeUnderTargetZone"] = null;
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                arg2[":timeInTargetZone"] = arg1.timeInTargetZone;
            }
            else 
            {
                arg2[":timeInTargetZone"] = null;
            }
            if (arg1.timeOverTargetZoneDefined) 
            {
                arg2[":timeOverTargetZone"] = arg1.timeOverTargetZone;
            }
            else 
            {
                arg2[":timeOverTargetZone"] = null;
            }
            if (arg1.intervalCountDefined) 
            {
                arg2[":intervalCount"] = arg1.intervalCount;
            }
            else 
            {
                arg2[":intervalCount"] = null;
            }
            if (arg1.plannedAutoChangeDefined) 
            {
                arg2[":plannedAutoChange"] = arg1.plannedAutoChange.toString();
            }
            else 
            {
                arg2[":plannedAutoChange"] = null;
            }
            if (arg1.plannedLoadRecoveryDefined) 
            {
                arg2[":plannedLoadRecovery"] = arg1.plannedLoadRecovery.toString();
            }
            else 
            {
                arg2[":plannedLoadRecovery"] = null;
            }
            if (arg1.plannedLowerLimitDefined) 
            {
                arg2[":plannedLowerLimit"] = arg1.plannedLowerLimit;
            }
            else 
            {
                arg2[":plannedLowerLimit"] = null;
            }
            if (arg1.plannedPhaseControlDefined) 
            {
                arg2[":plannedPhaseControl"] = arg1.plannedPhaseControl.toString();
            }
            else 
            {
                arg2[":plannedPhaseControl"] = null;
            }
            if (arg1.plannedRecoveryLowerLimitDefined) 
            {
                arg2[":plannedRecoveryLowerLimit"] = arg1.plannedRecoveryLowerLimit;
            }
            else 
            {
                arg2[":plannedRecoveryLowerLimit"] = null;
            }
            if (arg1.plannedRecoveryPhaseControlDefined) 
            {
                arg2[":plannedRecoveryPhaseControl"] = arg1.plannedRecoveryPhaseControl.toString();
            }
            else 
            {
                arg2[":plannedRecoveryPhaseControl"] = null;
            }
            if (arg1.plannedRecoveryTimeDefined) 
            {
                arg2[":plannedRecoveryTime"] = arg1.plannedRecoveryTime;
            }
            else 
            {
                arg2[":plannedRecoveryTime"] = null;
            }
            if (arg1.plannedRecoveryUpperLimitDefined) 
            {
                arg2[":plannedRecoveryUpperLimit"] = arg1.plannedRecoveryUpperLimit;
            }
            else 
            {
                arg2[":plannedRecoveryUpperLimit"] = null;
            }
            if (arg1.plannedTimeDefined) 
            {
                arg2[":plannedTime"] = arg1.plannedTime;
            }
            else 
            {
                arg2[":plannedTime"] = null;
            }
            if (arg1.plannedUpperLimitDefined) 
            {
                arg2[":plannedUpperLimit"] = arg1.plannedUpperLimit;
            }
            else 
            {
                arg2[":plannedUpperLimit"] = null;
            }
            if (arg1.plannedDistanceDefined) 
            {
                arg2[":plannedDistance"] = arg1.plannedDistance;
            }
            else 
            {
                arg2[":plannedDistance"] = null;
            }
            if (arg1.plannedRecoveryDistanceDefined) 
            {
                arg2[":plannedRecoveryDistance"] = arg1.plannedRecoveryDistance;
            }
            else 
            {
                arg2[":plannedRecoveryDistance"] = null;
            }
            return;
        }

        public static function generateXML(arg1:core.marker.Marker):XML
        {
            var loc1:*=new XML("<Marker/>");
            loc1.@calories = arg1.calories;
            loc1.@description = arg1.description;
            loc1.@duration = arg1.duration;
            loc1.@number = arg1.number;
            loc1.@time = arg1.time;
            loc1.@timeAbsolute = arg1.timeAbsolute;
            loc1.@title = arg1.title;
            loc1.@type = arg1.type;
            if (arg1.altitudeDownhillDefined) 
            {
                var loc2:*;
                loc1.@altitudeDownhill = loc2 = arg1.altitudeDownhill;
            }
            undefined;
            if (arg1.altitudeUphillDefined) 
            {
                loc1.@altitudeUphill = loc2 = arg1.altitudeUphill;
            }
            undefined;
            if (arg1.averageAltitudeDefined) 
            {
                loc1.@averageAltitude = loc2 = arg1.averageAltitude;
            }
            undefined;
            if (arg1.averageCadenceDefined) 
            {
                loc1.@averageCadence = loc2 = arg1.averageCadence;
            }
            undefined;
            if (arg1.averageHeartrateDefined) 
            {
                loc1.@averageHeartrate = loc2 = arg1.averageHeartrate;
            }
            undefined;
            if (arg1.averageInclineDownhillDefined) 
            {
                loc1.@averageInclineDownhill = loc2 = arg1.averageInclineDownhill;
            }
            undefined;
            if (arg1.averageInclineUphillDefined) 
            {
                loc1.@averageInclineUphill = loc2 = arg1.averageInclineUphill;
            }
            undefined;
            if (arg1.averagePowerDefined) 
            {
                loc1.@averagePower = loc2 = arg1.averagePower;
            }
            undefined;
            if (arg1.averageRiseRateDownhillDefined) 
            {
                loc1.@averageRiseRateDownhill = loc2 = arg1.averageRiseRateDownhill;
            }
            undefined;
            if (arg1.averageRiseRateUphillDefined) 
            {
                loc1.@averageRiseRateUphill = loc2 = arg1.averageRiseRateUphill;
            }
            undefined;
            if (arg1.averageSpeedDefined) 
            {
                loc1.@averageSpeed = loc2 = arg1.averageSpeed;
            }
            undefined;
            if (arg1.distanceDefined) 
            {
                loc1.@distance = loc2 = arg1.distance;
            }
            undefined;
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.@distanceAbsolute = loc2 = arg1.distanceAbsolute;
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
            if (arg1.fastLapDefined) 
            {
                loc1.@fastLap = loc2 = arg1.fastLap;
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
            if (arg1.maximumAltitudeDefined) 
            {
                loc1.@maximumAltitude = loc2 = arg1.maximumAltitude;
            }
            undefined;
            if (arg1.maximumCadenceDefined) 
            {
                loc1.@maximumCadence = loc2 = arg1.maximumCadence;
            }
            undefined;
            if (arg1.maximumHeartrateDefined) 
            {
                loc1.@maximumHeartrate = loc2 = arg1.maximumHeartrate;
            }
            undefined;
            if (arg1.maximumInclineDownhillDefined) 
            {
                loc1.@maximumInclineDownhill = loc2 = arg1.maximumInclineDownhill;
            }
            undefined;
            if (arg1.maximumInclineUphillDefined) 
            {
                loc1.@maximumInclineUphill = loc2 = arg1.maximumInclineUphill;
            }
            undefined;
            if (arg1.maximumPowerDefined) 
            {
                loc1.@maximumPower = loc2 = arg1.maximumPower;
            }
            undefined;
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                loc1.@maximumRiseRateDownhill = loc2 = arg1.maximumRiseRateDownhill;
            }
            undefined;
            if (arg1.maximumRiseRateUphillDefined) 
            {
                loc1.@maximumRiseRateUphill = loc2 = arg1.maximumRiseRateUphill;
            }
            undefined;
            if (arg1.maximumSpeedDefined) 
            {
                loc1.@maximumSpeed = loc2 = arg1.maximumSpeed;
            }
            undefined;
            if (arg1.minimumHeartrateDefined) 
            {
                loc1.@minimumHeartrate = loc2 = arg1.minimumHeartrate;
            }
            undefined;
            if (arg1.minimumSpeedDefined) 
            {
                loc1.@minimumSpeed = loc2 = arg1.minimumSpeed;
            }
            undefined;
            if (arg1.timeDownhillDefined) 
            {
                loc1.@timeDownhill = loc2 = arg1.timeDownhill;
            }
            undefined;
            if (arg1.timeUphillDefined) 
            {
                loc1.@timeUphill = loc2 = arg1.timeUphill;
            }
            undefined;
            if (arg1.normalizedPowerDefined) 
            {
                loc1.@normalizedPower = loc2 = arg1.normalizedPower;
            }
            undefined;
            if (arg1.averageBalanceDefined) 
            {
                loc1.@averageBalance = loc2 = arg1.averageBalance;
            }
            undefined;
            if (arg1.pedalingTimeDefined) 
            {
                loc1.@pedalingTime = loc2 = arg1.pedalingTime;
            }
            undefined;
            if (arg1.leftTorqueEffectivityDefined) 
            {
                loc1.@leftTorqueEffectivity = loc2 = arg1.leftTorqueEffectivity;
            }
            undefined;
            if (arg1.rightTorqueEffectivityDefined) 
            {
                loc1.@rightTorqueEffectivity = loc2 = arg1.rightTorqueEffectivity;
            }
            undefined;
            if (arg1.leftPedalingSmoothnessDefined) 
            {
                loc1.@leftPedalingSmoothness = loc2 = arg1.leftPedalingSmoothness;
            }
            undefined;
            if (arg1.rightPedalingSmoothnessDefined) 
            {
                loc1.@rightPedalingSmoothness = loc2 = arg1.rightPedalingSmoothness;
            }
            undefined;
            if (arg1.tXSensorPositionDefined) 
            {
                loc1.@tXSensorPosition = loc2 = arg1.tXSensorPosition;
            }
            undefined;
            if (arg1.timeUnderTargetZoneDefined) 
            {
                loc1.@timeUnderTargetZone = loc2 = arg1.timeUnderTargetZone;
            }
            undefined;
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.@timeInTargetZone = loc2 = arg1.timeInTargetZone;
            }
            undefined;
            if (arg1.timeOverTargetZoneDefined) 
            {
                loc1.@timeOverTargetZone = loc2 = arg1.timeOverTargetZone;
            }
            undefined;
            if (arg1.intervalCountDefined) 
            {
                loc1.@intervalCount = loc2 = arg1.intervalCount;
            }
            undefined;
            if (arg1.plannedAutoChangeDefined) 
            {
                loc1.@plannedAutoChange = loc2 = arg1.plannedAutoChange.toString();
            }
            undefined;
            if (arg1.plannedLoadRecoveryDefined) 
            {
                loc1.@plannedLoadRecovery = loc2 = arg1.plannedLoadRecovery.toString();
            }
            undefined;
            if (arg1.plannedLowerLimitDefined) 
            {
                loc1.@plannedLowerLimit = loc2 = arg1.plannedLowerLimit;
            }
            undefined;
            if (arg1.plannedPhaseControlDefined) 
            {
                loc1.@plannedPhaseControl = loc2 = arg1.plannedPhaseControl.toString();
            }
            undefined;
            if (arg1.plannedRecoveryLowerLimitDefined) 
            {
                loc1.@plannedRecoveryLowerLimit = loc2 = arg1.plannedRecoveryLowerLimit;
            }
            undefined;
            if (arg1.plannedRecoveryPhaseControlDefined) 
            {
                loc1.@plannedRecoveryPhaseControl = loc2 = arg1.plannedRecoveryPhaseControl.toString();
            }
            undefined;
            if (arg1.plannedRecoveryTimeDefined) 
            {
                loc1.@plannedRecoveryTime = loc2 = arg1.plannedRecoveryTime;
            }
            undefined;
            if (arg1.plannedRecoveryUpperLimitDefined) 
            {
                loc1.@plannedRecoveryUpperLimit = loc2 = arg1.plannedRecoveryUpperLimit;
            }
            undefined;
            if (arg1.plannedTimeDefined) 
            {
                loc1.@plannedTime = loc2 = arg1.plannedTime;
            }
            undefined;
            if (arg1.plannedUpperLimitDefined) 
            {
                loc1.@plannedUpperLimit = loc2 = arg1.plannedUpperLimit;
            }
            undefined;
            if (arg1.plannedDistanceDefined) 
            {
                loc1.@plannedDistance = loc2 = arg1.plannedDistance;
            }
            undefined;
            if (arg1.plannedRecoveryDistanceDefined) 
            {
                loc1.@plannedRecoveryDistance = loc2 = arg1.plannedRecoveryDistance;
            }
            undefined;
            return loc1;
        }

        internal static function fromOldXML(arg1:XML, arg2:core.marker.Marker, arg3:int, arg4:core.activities.Activity):core.marker.Marker
        {
            var loc2:*=undefined;
            var loc1:*;
            (loc1 = core.marker.MarkerFactory.createMarkerFromLog(arg4)).title = arg1.Title;
            loc1.description = arg1.Description;
            loc1.time = arg1.Time;
            loc1.time = loc1.time * 100;
            loc1.timeAbsolute = arg1.TimeAbsolute;
            loc1.timeAbsolute = loc1.timeAbsolute * 100;
            if (arg3 >= 300) 
            {
                loc1.type = arg1.MarkerType;
                loc1.number = arg1.MarkerNumber;
                loc1.duration = arg1.Duration;
                loc1.duration = loc1.duration * 100;
            }
            else if (arg3 == 210 && core.general.UnitType.RC1411 == arg4.unitType) 
            {
                loc1.type = "l";
                loc1.number = arg1.LapNumber;
                loc1.duration = 0;
            }
            loc2 = arg1.FastLap;
            var loc3:*;
            loc1.fastLapDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.fastLapDefined = loc2;
            }
            loc2 = arg4.unitType == core.general.UnitType.ROX50 || arg4.unitType == core.general.UnitType.ROX60 ? arg1.Downhill : arg1.AltitudeDownhill;
            loc1.altitudeDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.altitudeDownhill = loc2;
            }
            loc2 = arg4.unitType == core.general.UnitType.ROX50 || arg4.unitType == core.general.UnitType.ROX60 ? arg1.Uphill : arg1.AltitudeUphill;
            loc1.altitudeUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.altitudeUphill = loc2;
            }
            loc2 = arg1.AverageAltitude;
            loc1.averageAltitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageAltitude = loc2;
            }
            loc2 = arg1.AverageCadence;
            loc1.averageCadenceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageCadence = loc2;
            }
            loc2 = arg1.AverageHeartrate;
            loc1.averageHeartrateDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageHeartrate = loc2;
            }
            loc2 = arg1.AverageInclineDownhill;
            loc1.averageInclineDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageInclineDownhill = loc2;
            }
            loc2 = arg1.AverageInclineUphill;
            loc1.averageInclineUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageInclineUphill = loc2;
            }
            loc2 = arg1.AveragePower;
            loc1.averagePowerDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averagePower = loc2;
            }
            loc2 = arg1.AverageRiseRateDownhill;
            loc1.averageRiseRateDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageRiseRateDownhill = loc2;
            }
            loc2 = arg1.AverageRiseRateUphill;
            loc1.averageRiseRateUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageRiseRateUphill = loc2;
            }
            loc2 = arg1.AverageSpeed;
            loc1.averageSpeedDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.averageSpeed = Math.round(loc2 * 100) / 100;
            }
            loc2 = arg4.unitType != core.general.UnitType.ROX90 ? arg1.Calories : arg1.MarkerCalories;
            loc1.caloriesDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.calories = loc2;
            }
            loc2 = arg1.Distance;
            loc1.distanceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distance = loc2;
            }
            loc2 = arg1.DistanceAbsolute;
            loc1.distanceAbsoluteDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceAbsolute = loc2;
            }
            loc2 = arg1.distanceDownhill;
            loc1.distanceDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceDownhill = loc2;
            }
            loc2 = arg1.DistanceUphill;
            loc1.distanceUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.distanceUphill = loc2;
            }
            loc2 = arg1.Latitude;
            loc1.latitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.latitude = loc2;
            }
            loc2 = arg1.Longitude;
            loc1.longitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.longitude = loc2;
            }
            loc2 = arg1.MaximumAltitude;
            loc1.maximumAltitudeDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumAltitude = loc2;
            }
            loc2 = arg1.MaximumCadence;
            loc1.maximumCadenceDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumCadence = loc2;
            }
            loc2 = arg1.MaximumHeartrate;
            loc1.maximumHeartrateDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumHeartrate = loc2;
            }
            loc2 = arg1.MaximumInclineDownhill;
            loc1.maximumInclineDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumInclineDownhill = loc2;
            }
            loc2 = arg1.MaximumInclineUphill;
            loc1.maximumInclineUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumInclineUphill = loc2;
            }
            loc2 = arg1.MaximumPower;
            loc1.maximumPowerDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumPower = loc2;
            }
            loc2 = arg1.MaximumRiseRateDownhill;
            loc1.maximumRiseRateDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumRiseRateDownhill = loc2;
            }
            loc2 = arg1.MaximumRiseRateUphill;
            loc1.maximumRiseRateUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumRiseRateUphill = loc2;
            }
            loc2 = arg1.MaximumSpeed;
            loc1.maximumSpeedDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.maximumSpeed = Math.round(loc2 * 100) / 100;
            }
            loc1.maximumSpeed = Math.round(arg1.MaximumSpeed * 100) / 100;
            loc2 = arg1.MinimumHeartrate;
            if (!(arg4.unitType == core.general.UnitType.ROX100)) 
            {
                !(arg4.unitType == core.general.UnitType.ROX100);
                loc1.minimumHeartrateDefined = loc3 = !(loc2 == undefined);
            }
            if (!(arg4.unitType == core.general.UnitType.ROX100)) 
            {
                loc1.minimumHeartrate = loc2;
            }
            loc2 = arg1.MinimumSpeed;
            if (!(arg4.unitType == core.general.UnitType.ROX100)) 
            {
                !(arg4.unitType == core.general.UnitType.ROX100);
                loc1.minimumSpeedDefined = loc3 = !(loc2 == undefined);
            }
            if (!(arg4.unitType == core.general.UnitType.ROX100)) 
            {
                loc1.minimumSpeed = Math.round(loc2 * 100) / 100;
            }
            loc2 = arg1.TimeDownhill;
            loc1.timeDownhillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeDownhill = loc2;
                loc1.timeDownhill = loc1.timeDownhill * 100;
            }
            loc2 = arg1.TimeUphill;
            loc1.timeUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeUphill = loc2;
                loc1.timeUphill = loc1.timeUphill * 100;
            }
            loc2 = arg1.TimeUphill;
            loc1.timeUphillDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.timeUphill = loc2;
                loc1.timeUphill = loc1.timeUphill * 100;
            }
            loc2 = arg1.SensorPosition;
            loc1.tXSensorPositionDefined = loc3 = !(loc2 == undefined);
            if (loc3 == true) 
            {
                loc1.tXSensorPosition = loc2;
            }
            return loc1;
        }

        public static const col_averageInclineUphill:String="averageInclineUphill";

        public static const col_averagePower:String="averagePower";

        public static const col_averageRiseRateDownhill:String="averageRiseRateDownhill";

        public static const col_averageRiseRateUphill:String="averageRiseRateUphill";

        public static const col_averageSpeed:String="averageSpeed";

        public static const col_calories:String="calories";

        public static const col_description:String="description";

        public static const col_distance:String="distance";

        public static const col_distanceAbsolute:String="distanceAbsolute";

        public static const col_distanceDownhill:String="distanceDownhill";

        public static const col_distanceUphill:String="distanceUphill";

        public static const col_duration:String="duration";

        public static const col_fastLap:String="fastLap";

        public static const col_intervalCount:String="intervalCount";

        public static const col_latitude:String="latitude";

        public static const col_leftPedalingSmoothness:String="leftPedalingSmoothness";

        public static const col_leftTorqueEffectivity:String="leftTorqueEffectivity";

        public static const col_longitude:String="longitude";

        public static const col_markerId:String="markerId";

        public static const col_maximumAltitude:String="maximumAltitude";

        public static const col_maximumCadence:String="maximumCadence";

        public static const col_maximumHeartrate:String="maximumHeartrate";

        public static const col_maximumInclineDownhill:String="maximumInclineDownhill";

        public static const col_maximumInclineUphill:String="maximumInclineUphill";

        public static const col_maximumPower:String="maximumPower";

        public static const col_maximumRiseRateDownhill:String="maximumRiseRateDownhill";

        public static const col_maximumRiseRateUphill:String="maximumRiseRateUphill";

        public static const col_maximumSpeed:String="maximumSpeed";

        public static const col_averageCadence:String="averageCadence";

        public static const col_minimumSpeed:String="minimumSpeed";

        public static const col_normalizedPower:String="normalizedPower";

        public static const col_number:String="number";

        public static const col_pedalingTime:String="pedalingTime";

        public static const col_plannedAutoChange:String="plannedAutoChange";

        public static const col_plannedDistance:String="plannedDistance";

        public static const col_plannedLoadRecovery:String="plannedLoadRecovery";

        public static const col_plannedLowerLimit:String="plannedLowerLimit";

        public static const col_plannedPhaseControl:String="plannedPhaseControl";

        public static const col_plannedRecoveryDistance:String="plannedRecoveryDistance";

        public static const col_plannedRecoveryLowerLimit:String="plannedRecoveryLowerLimit";

        public static const col_plannedRecoveryPhaseControl:String="plannedRecoveryPhaseControl";

        public static const col_plannedRecoveryTime:String="plannedRecoveryTime";

        public static const col_plannedRecoveryUpperLimit:String="plannedRecoveryUpperLimit";

        public static const col_plannedTime:String="plannedTime";

        public static const col_plannedUpperLimit:String="plannedUpperLimit";

        public static const col_rightPedalingSmoothness:String="rightPedalingSmoothness";

        public static const col_rightTorqueEffectivity:String="rightTorqueEffectivity";

        public static const col_tXSensorPosition:String="tXSensorPosition";

        public static const col_time:String="time";

        public static const col_timeDownhill:String="timeDownhill";

        public static const col_timeInTargetZone:String="timeInTargetZone";

        public static const col_timeOverTargetZone:String="timeOverTargetZone";

        public static const col_timeUnderTargetZone:String="timeUnderTargetZone";

        public static const col_timeUphill:String="timeUphill";

        public static const col_title:String="title";

        public static const col_type:String="type";

        public static const table_name:String="Marker";

        public static const col_minimumHeartrate:String="minimumHeartrate";

        public static const col_activityId:String="activityId";

        public static const col_altitudeDownhill:String="altitudeDownhill";

        public static const col_altitudeUphill:String="altitudeUphill";

        public static const col_averageAltitude:String="averageAltitude";

        public static const col_averageBalance:String="averageBalance";

        public static const col_averageHeartrate:String="averageHeartrate";

        public static const col_averageInclineDownhill:String="averageInclineDownhill";

        public static const col_timeAbsolute:String="timeAbsolute";

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;
    }
}


