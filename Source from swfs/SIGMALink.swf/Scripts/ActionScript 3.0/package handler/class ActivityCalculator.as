//class ActivityCalculator
package handler 
{
    import __AS3__.vec.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.units.*;
    import debug.*;
    import flash.events.*;
    import utils.*;
    import utils.sort.*;
    
    public class ActivityCalculator extends flash.events.EventDispatcher
    {
        public function ActivityCalculator(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        internal static function sortMarker(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "timeAbsolute", false);
        }

        internal static function recalcMarkerDistanceAbsolute(arg1:core.activities.Activity):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc2:*=arg1.markerList.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if ((loc4 = arg1.markerList[loc3]).type != "p") 
                {
                    if (loc1 != null) 
                    {
                        if (loc4.distanceDefined && loc4.distanceAbsoluteDefined) 
                        {
                            loc4.distanceAbsolute = loc1.distanceAbsolute + loc4.distance;
                        }
                        loc1 = loc4;
                    }
                    else 
                    {
                        loc1 = loc4;
                    }
                }
                ++loc3;
            }
            return;
        }

        internal static function resetResult(arg1:core.activities.ActivityRecalculationValues):void
        {
            arg1.initialize(0);
            return;
        }

        internal static function countLaps(arg1:core.activities.Activity):uint
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=0;
            if (arg1.markerList != null) 
            {
                loc2 = arg1.markerList.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    if (arg1.markerList[loc3].type == "l") 
                    {
                        ++loc1;
                    }
                    ++loc3;
                }
            }
            return loc1;
        }

        internal static function getPrevLapAsEntryIndex(arg1:uint, arg2:core.marker.Marker, arg3:core.activities.Activity):uint
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=arg1;
            if (arg3.markerList != null) 
            {
                loc2 = arg3.markerList.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    if (arg3.markerList[loc3].type == "l") 
                    {
                        if (loc1 != null) 
                        {
                            if (arg3.markerList[loc3].timeAbsolute < arg2.timeAbsolute) 
                            {
                                loc1 = arg3.markerList[loc3];
                            }
                        }
                        else 
                        {
                            loc1 = arg3.markerList[loc3];
                        }
                    }
                    ++loc3;
                }
                if (loc1 != null) 
                {
                    loc3 = arg1;
                    while (loc3 < arg3.entries.length) 
                    {
                        if (arg3.entries[loc3].trainingTimeAbsolute >= loc1.timeAbsolute) 
                        {
                            loc4 = loc3;
                        }
                        ++loc3;
                    }
                }
            }
            return loc4;
        }

        public static function calculateChartEntries(arg1:core.activities.Activity, arg2:Number):__AS3__.vec.Vector.<Object>
        {
            var p_activity:core.activities.Activity;
            var p_maxEntries:Number;
            var everyEntry:int;
            var lastUsedIndex:int;
            var res:__AS3__.vec.Vector.<core.activities.ActivityEntry>;
            var i:int;
            var len:int;
            var objVec:__AS3__.vec.Vector.<Object>;

            var loc1:*;
            p_activity = arg1;
            p_maxEntries = arg2;
            everyEntry = p_activity.entries.length / p_maxEntries;
            lastUsedIndex = 0;
            res = p_activity.entries.filter(function (arg1:Object, arg2:int=0, arg3:*=null):Boolean
            {
                var loc1:*=false;
                if (arg2 == 0 || arg2 == (p_activity.entries.length - 1)) 
                {
                    loc1 = true;
                }
                else if (arg2 % everyEntry != 0) 
                {
                    if (arg1.hasOwnProperty("speed") && arg1["speed"] == p_activity.maximumSpeed && p_activity.maximumSpeed > 0) 
                    {
                        loc1 = true;
                    }
                    if (arg1.hasOwnProperty("altitude") && arg1["altitude"] == p_activity.maximumAltitude && !(p_activity.maximumAltitude == 0)) 
                    {
                        loc1 = true;
                    }
                    if (arg1.hasOwnProperty("heartrate") && arg1["heartrate"] == p_activity.maximumHeartrate && p_activity.maximumHeartrate > 0) 
                    {
                        loc1 = true;
                    }
                }
                else 
                {
                    loc1 = true;
                }
                if (loc1) 
                {
                    lastUsedIndex = arg2;
                }
                return loc1;
            })
            objVec = new __AS3__.vec.Vector.<Object>();
            len = res.length;
            i = 0;
            while (i < len) 
            {
                objVec.push(res[i]);
                ++i;
            }
            return objVec;
        }

        public static function calculateMarkerAbsoluteValues(arg1:core.activities.Activity, arg2:String):void
        {
            var loc4:*=null;
            var loc3:*=null;
            var loc2:*=0;
            var loc1:*=arg1.markerList.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if ((loc3 = arg1.markerList[loc2]).type == arg2) 
                {
                    if (loc4 != null) 
                    {
                        loc3.timeAbsolute = loc3.time + loc4.timeAbsolute;
                        if (loc3.distanceAbsoluteDefined) 
                        {
                            loc3.distanceAbsolute = loc3.distance + loc4.distanceAbsolute;
                        }
                    }
                    else 
                    {
                        loc3.timeAbsolute = loc3.time;
                        if (loc3.distanceAbsoluteDefined) 
                        {
                            loc3.distanceAbsolute = loc3.distance;
                        }
                    }
                    loc4 = loc3;
                }
                ++loc2;
            }
            arg1.markerList.sort(sortMarker);
            return;
        }

        public static function calculateMarkerValuesByEntries(arg1:core.activities.Activity):void
        {
            var loc12:*=null;
            var loc44:*=null;
            var loc47:*=0;
            var loc49:*=null;
            var loc22:*=null;
            var loc51:*=0;
            var loc25:*=arg1.entries;
            var loc4:*=0;
            var loc48:*=0;
            var loc35:*;
            var loc17:*=!((loc35 = arg1.unitType) == core.general.UnitType.ROX100) && !(loc35 == core.general.UnitType.RC1411);
            var loc14:*=0;
            var loc32:*=0;
            var loc33:*=0;
            var loc38:*=0;
            var loc30:*=new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc10:*=core.marker.MarkerFactory.createMarkerFromLog(arg1);
            var loc37:*=0;
            loc30.push(loc10);
            var loc2:*=core.marker.MarkerFactory.createMarkerFromLog(arg1);
            var loc45:*=1;
            if (loc17) 
            {
                loc30.push(loc2);
            }
            var loc34:*=0;
            var loc8:*=0;
            var loc36:*=0;
            var loc11:*=0;
            var loc3:*=0;
            var loc39:*=0;
            var loc16:*=0;
            var loc41:*=0;
            var loc5:*=0;
            var loc26:*=0;
            var loc23:*=0;
            var loc18:*=0;
            var loc28:*=0;
            var loc7:*=0;
            var loc9:*=0;
            var loc20:*=0;
            var loc19:*=0;
            var loc40:*=0;
            var loc42:*=0;
            var loc6:*=0;
            var loc52:*=0;
            var loc50:*=0;
            var loc1:*=0;
            var loc46:*=0;
            var loc43:*=0;
            var loc24:*=0;
            var loc13:*=0;
            var loc31:*=0;
            var loc15:*=0;
            var loc27:*=loc25.length;
            var loc21:*=true;
            var loc29:*=true;
            loc47 = 0;
            while (loc47 < loc27) 
            {
                loc12 = loc25[loc47];
                if (loc17) 
                {
                    loc2 = loc30[loc45];
                }
                loc10 = loc30[loc37];
                if (loc12.isPause) 
                {
                    ++loc4;
                }
                else 
                {
                    ++loc48;
                }
                if (loc12.heartrateDefined && loc10.minimumHeartrateDefined && loc10.maximumHeartrateDefined && loc12.heartrate > 20) 
                {
                    if (loc17) 
                    {
                        loc36 = loc36 + loc12.heartrate;
                        if (loc29) 
                        {
                            loc2.minimumHeartrate = loc12.heartrate;
                            loc2.maximumHeartrate = loc12.heartrate;
                        }
                        else 
                        {
                            loc2.minimumHeartrate = Math.min(loc2.minimumHeartrate, loc12.heartrate);
                            loc2.maximumHeartrate = Math.max(loc2.maximumHeartrate, loc12.heartrate);
                        }
                    }
                    ++loc14;
                    loc20 = loc20 + loc12.heartrate;
                    if (loc21) 
                    {
                        loc10.minimumHeartrate = loc12.heartrate;
                        loc10.maximumHeartrate = loc12.heartrate;
                    }
                    else 
                    {
                        loc10.minimumHeartrate = Math.min(loc10.minimumHeartrate, loc12.heartrate);
                        loc10.maximumHeartrate = Math.max(loc10.maximumHeartrate, loc12.heartrate);
                    }
                }
                if (loc12.speedDefined && loc10.minimumSpeedDefined && loc10.maximumSpeedDefined && loc12.speed > 0) 
                {
                    if (loc17) 
                    {
                        loc11 = loc11 + loc12.speed;
                        if (loc29) 
                        {
                            loc2.minimumSpeed = loc12.speed;
                            loc2.maximumSpeed = loc12.speed;
                        }
                        else 
                        {
                            loc2.minimumSpeed = Math.min(loc2.minimumSpeed, loc12.speed);
                            loc2.maximumSpeed = Math.max(loc2.maximumSpeed, loc12.speed);
                        }
                    }
                    ++loc32;
                    loc19 = loc19 + loc12.speed;
                    if (loc21) 
                    {
                        loc10.minimumSpeed = loc12.speed;
                        loc10.maximumSpeed = loc12.speed;
                    }
                    else 
                    {
                        loc10.minimumSpeed = Math.min(loc10.minimumSpeed, loc12.speed);
                        loc10.maximumSpeed = Math.max(loc10.maximumSpeed, loc12.speed);
                    }
                }
                if (loc12.powerDefined && loc10.maximumPowerDefined) 
                {
                    if (loc17) 
                    {
                        loc23 = loc23 + loc12.power;
                        if (loc29) 
                        {
                            loc2.maximumPower = loc12.power;
                        }
                        else 
                        {
                            loc2.maximumPower = Math.max(loc2.maximumPower, loc12.power);
                        }
                    }
                    ++loc33;
                    loc46 = loc46 + loc12.power;
                    if (loc21) 
                    {
                        loc10.maximumPower = loc12.power;
                    }
                    else 
                    {
                        loc10.maximumPower = Math.max(loc10.maximumPower, loc12.power);
                    }
                }
                if (loc12.cadenceDefined && loc10.maximumCadenceDefined) 
                {
                    if (loc17) 
                    {
                        loc26 = loc26 + loc12.cadence;
                        if (loc29) 
                        {
                            loc2.maximumCadence = loc12.cadence;
                        }
                        else 
                        {
                            loc2.maximumCadence = Math.max(loc2.maximumCadence, loc12.cadence);
                        }
                    }
                    ++loc38;
                    loc1 = loc1 + loc12.cadence;
                    if (loc21) 
                    {
                        loc10.maximumCadence = loc12.cadence;
                    }
                    else 
                    {
                        loc10.maximumCadence = Math.max(loc10.maximumCadence, loc12.cadence);
                    }
                }
                if (loc12.altitudeDefined && loc10.maximumAltitudeDefined) 
                {
                    if (loc17) 
                    {
                        loc5 = loc5 + loc12.altitude;
                        if (loc29) 
                        {
                            loc2.maximumAltitude = loc12.altitude;
                        }
                        else 
                        {
                            loc2.maximumAltitude = Math.max(loc2.maximumAltitude, loc12.altitude);
                        }
                    }
                    loc50 = loc50 + loc12.altitude;
                    if (loc21) 
                    {
                        loc10.maximumAltitude = loc12.altitude;
                    }
                    else 
                    {
                        loc10.maximumAltitude = Math.max(loc10.maximumAltitude, loc12.altitude);
                    }
                }
                if (loc12.inclineDefined && loc10.maximumInclineUphillDefined && loc10.maximumInclineDownhillDefined) 
                {
                    if (loc12.incline > 0) 
                    {
                        if (loc17) 
                        {
                            ++loc18;
                            loc3 = loc3 + loc12.incline;
                            if (loc29) 
                            {
                                loc2.maximumInclineUphill = loc12.incline;
                            }
                            else 
                            {
                                loc2.maximumInclineUphill = Math.max(loc2.maximumInclineUphill, loc12.incline);
                            }
                        }
                        ++loc43;
                        loc40 = loc40 + loc12.incline;
                        if (loc21) 
                        {
                            loc10.maximumInclineUphill = loc12.incline;
                        }
                        else 
                        {
                            loc10.maximumInclineUphill = Math.max(loc10.maximumInclineUphill, loc12.incline);
                        }
                    }
                    else if (loc12.incline < 0) 
                    {
                        if (loc17) 
                        {
                            ++loc28;
                            loc39 = loc39 + loc12.incline;
                            if (loc29) 
                            {
                                loc2.maximumInclineDownhill = loc12.incline;
                            }
                            else 
                            {
                                loc2.maximumInclineDownhill = Math.min(loc2.maximumInclineDownhill, loc12.incline);
                            }
                        }
                        ++loc24;
                        loc42 = loc42 + loc12.incline;
                        if (loc21) 
                        {
                            loc10.maximumInclineDownhill = loc12.incline;
                        }
                        else 
                        {
                            loc10.maximumInclineDownhill = Math.min(loc10.maximumInclineDownhill, loc12.incline);
                        }
                    }
                }
                if (loc12.riseRateDefined && loc10.maximumRiseRateUphillDefined && loc10.maximumRiseRateDownhillDefined) 
                {
                    if (loc12.riseRate > 0) 
                    {
                        if (loc17) 
                        {
                            ++loc7;
                            loc16 = loc16 + loc12.riseRate;
                            if (loc29) 
                            {
                                loc2.maximumRiseRateUphill = loc12.riseRate;
                            }
                            else 
                            {
                                loc2.maximumRiseRateUphill = Math.max(loc2.maximumRiseRateUphill, loc12.riseRate);
                            }
                        }
                        ++loc13;
                        loc6 = loc6 + loc12.riseRate;
                        if (loc21) 
                        {
                            loc10.maximumRiseRateUphill = loc12.riseRate;
                        }
                        else 
                        {
                            loc10.maximumRiseRateUphill = Math.max(loc10.maximumRiseRateUphill, loc12.riseRate);
                        }
                    }
                    else if (loc12.riseRate < 0) 
                    {
                        if (loc17) 
                        {
                            ++loc9;
                            loc41 = loc41 + loc12.riseRate;
                            if (loc29) 
                            {
                                loc2.maximumRiseRateDownhill = loc12.riseRate;
                            }
                            else 
                            {
                                loc2.maximumRiseRateDownhill = Math.min(loc2.maximumRiseRateDownhill, loc12.riseRate);
                            }
                        }
                        ++loc31;
                        loc52 = loc52 + loc12.riseRate;
                        if (loc21) 
                        {
                            loc10.maximumRiseRateDownhill = loc12.riseRate;
                        }
                        else 
                        {
                            loc10.maximumRiseRateDownhill = Math.min(loc10.maximumRiseRateDownhill, loc12.riseRate);
                        }
                    }
                }
                if (loc10.caloriesDefined && loc10.calculateMarkerCalories) 
                {
                    if (loc12.caloriesDefined) 
                    {
                        loc15 = loc12.calories;
                    }
                    else 
                    {
                        loc15 = utils.Calculations.calculateCalories(arg1, loc12);
                    }
                    if (loc17) 
                    {
                        loc2.calories = loc2.calories + loc15;
                    }
                    loc10.calories = loc10.calories + loc15;
                }
                if (loc12.distanceDefined && loc10.distanceDefined) 
                {
                    if (loc17) 
                    {
                        loc2.distance = loc2.distance + loc12.distance;
                    }
                    loc10.distance = loc10.distance + loc12.distance;
                }
                if (loc12.distanceAbsoluteDefined && loc10.distanceAbsoluteDefined) 
                {
                    if (loc17) 
                    {
                        loc2.distanceAbsolute = loc12.distanceAbsolute;
                    }
                    loc10.distanceAbsolute = loc12.distanceAbsolute;
                }
                if (loc12.distanceUphillDefined && loc10.distanceUphillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.distanceUphill = loc2.distanceUphill + loc12.distanceUphill;
                    }
                    loc10.distanceUphill = loc10.distanceUphill + loc12.distanceUphill;
                }
                if (loc12.distanceDownhillDefined && loc10.distanceDownhillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.distanceDownhill = loc2.distanceDownhill + loc12.distanceDownhill;
                    }
                    loc10.distanceDownhill = loc10.distanceDownhill + loc12.distanceDownhill;
                }
                if (loc17) 
                {
                    loc2.time = loc2.time + loc12.trainingTime;
                    loc2.timeAbsolute = loc12.trainingTimeAbsolute;
                }
                loc10.time = loc10.time + loc12.trainingTime;
                loc10.timeAbsolute = loc12.trainingTimeAbsolute;
                if (loc12.trainingTimeUphillDefined && loc10.timeUphillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.timeUphill = loc2.timeUphill + loc12.trainingTimeUphill;
                    }
                    loc10.timeUphill = loc10.timeUphill + loc12.trainingTimeUphill;
                }
                if (loc12.trainingTimeDownhillDefined && loc10.timeDownhillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.timeDownhill = loc2.timeDownhill + loc12.trainingTimeDownhill;
                    }
                    loc10.timeDownhill = loc10.timeDownhill + loc12.trainingTimeDownhill;
                }
                if (loc12.altitudeDifferencesUphillDefined && loc10.altitudeUphillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.altitudeUphill = loc2.altitudeUphill + loc12.altitudeDifferencesUphill;
                    }
                    loc10.altitudeUphill = loc10.altitudeUphill + loc12.altitudeDifferencesUphill;
                }
                if (loc12.altitudeDifferencesDownhillDefined && loc10.altitudeDownhillDefined) 
                {
                    if (loc17) 
                    {
                        loc2.altitudeDownhill = loc2.altitudeDownhill + loc12.altitudeDifferencesDownhill;
                    }
                    loc10.altitudeDownhill = loc10.altitudeDownhill + loc12.altitudeDifferencesDownhill;
                }
                loc21 = false;
                loc29 = false;
                if (loc12.isPause) 
                {
                    loc10.type = "p";
                    loc10.duration = loc12.pauseTime;
                    loc10.number = loc34;
                    if (loc4 > 0) 
                    {
                        if (loc10.averageHeartrateDefined) 
                        {
                            loc10.averageHeartrate = loc20 / loc4;
                        }
                        if (loc10.averageSpeedDefined) 
                        {
                            loc10.averageSpeed = loc19 / loc4;
                        }
                        if (loc10.averageAltitudeDefined) 
                        {
                            loc10.averageAltitude = loc50 / loc4;
                        }
                        if (loc10.averagePowerDefined) 
                        {
                            loc10.averagePower = loc46 / loc4;
                        }
                        if (loc10.averageCadenceDefined) 
                        {
                            loc10.averageCadence = loc1 / loc4;
                        }
                    }
                    if (loc43 > 0 && loc10.averageInclineUphillDefined) 
                    {
                        loc10.averageInclineUphill = loc40 / loc43;
                    }
                    if (loc24 > 0 && loc10.averageInclineDownhillDefined) 
                    {
                        loc10.averageInclineDownhill = loc42 / loc24;
                    }
                    if (loc13 > 0 && loc10.averageRiseRateUphillDefined) 
                    {
                        loc10.averageRiseRateUphill = loc6 / loc13;
                    }
                    if (loc31 > 0 && loc10.averageRiseRateDownhillDefined) 
                    {
                        loc10.averageRiseRateDownhill = loc52 / loc31;
                    }
                    if (loc10.latitudeDefined && loc10.longitudeDefined && loc12.latitudeDefined && loc12.longitudeDefined) 
                    {
                        loc10.latitude = loc12.latitude;
                        loc10.longitude = loc12.longitude;
                    }
                    loc20 = 0;
                    loc19 = 0;
                    loc40 = 0;
                    loc42 = 0;
                    loc6 = 0;
                    loc52 = 0;
                    loc50 = 0;
                    loc46 = 0;
                    loc1 = 0;
                    loc4 = 0;
                    loc14 = 0;
                    loc32 = 0;
                    loc33 = 0;
                    loc38 = 0;
                    loc43 = 0;
                    loc24 = 0;
                    loc13 = 0;
                    loc31 = 0;
                    loc21 = true;
                    ++loc34;
                    if (loc47 < (loc27 - 1)) 
                    {
                        loc49 = core.marker.MarkerFactory.createMarkerFromLog(arg1);
                        loc30.push(loc49);
                        loc37 = loc30.indexOf(loc49);
                    }
                }
                if (loc47 == (loc27 - 1) && (loc12.isPause == false || core.general.UnitType.RC1411 == loc35)) 
                {
                    removeMarkerFromMarkersVector(loc30[loc37], loc30);
                }
                if (loc17) 
                {
                    if (loc12.isWaypoint || loc47 == (loc27 - 1)) 
                    {
                        loc2.type = "l";
                        loc2.number = loc8;
                        if (loc48 > 0) 
                        {
                            if (loc2.averageHeartrateDefined) 
                            {
                                loc2.averageHeartrate = loc36 / loc48;
                            }
                            if (loc2.averageSpeedDefined) 
                            {
                                loc2.averageSpeed = loc2.distance / (loc2.time / 100);
                            }
                            if (loc2.averageAltitudeDefined) 
                            {
                                loc2.averageAltitude = loc5 / loc48;
                            }
                            if (loc2.averagePowerDefined) 
                            {
                                loc2.averagePower = loc23 / loc48;
                            }
                            if (loc2.averageCadenceDefined) 
                            {
                                loc2.averageCadence = loc26 / loc48;
                            }
                        }
                        if (loc18 > 0 && loc2.averageInclineUphillDefined) 
                        {
                            loc2.averageInclineUphill = loc3 / loc18;
                        }
                        if (loc28 > 0 && loc2.averageInclineDownhillDefined) 
                        {
                            loc2.averageInclineDownhill = loc39 / loc28;
                        }
                        if (loc7 > 0 && loc2.averageRiseRateUphillDefined) 
                        {
                            loc2.averageRiseRateUphill = loc16 / loc7;
                        }
                        if (loc9 > 0 && loc2.averageRiseRateDownhillDefined) 
                        {
                            loc2.averageRiseRateDownhill = loc41 / loc9;
                        }
                        loc36 = 0;
                        loc11 = 0;
                        loc3 = 0;
                        loc39 = 0;
                        loc16 = 0;
                        loc41 = 0;
                        loc5 = 0;
                        loc26 = 0;
                        loc23 = 0;
                        loc48 = 0;
                        loc18 = 0;
                        loc28 = 0;
                        loc7 = 0;
                        loc9 = 0;
                        loc29 = true;
                        ++loc8;
                        if (loc47 < (loc27 - 1)) 
                        {
                            loc22 = core.marker.MarkerFactory.createMarkerFromLog(arg1);
                            loc30.push(loc22);
                            loc45 = loc30.indexOf(loc22);
                        }
                    }
                }
                loc44 = loc12;
                ++loc47;
            }
            if (core.general.UnitType.RC1411 != loc35) 
            {
                arg1.markerList = loc30;
            }
            else 
            {
                loc51 = 0;
                while (loc51 < loc30.length) 
                {
                    arg1.markerList.push(loc30[loc51]);
                    ++loc51;
                }
                recalcMarkerDistanceAbsolute(arg1);
            }
            return;
        }

        public static function validateActivityStatus_HeaderData(arg1:core.activities.Activity):void
        {
            if (!core.activities.ActivityStatus.hasStatus(arg1, "headerDataValid")) 
            {
                calculateMinMaxAvgValues(arg1);
                core.activities.ActivityStatus.addStatus(arg1, "headerDataValid");
                arg1.modificationDate = new Date().time;
            }
            return;
        }

        public static function calculateMinMaxAvgValues(arg1:core.activities.Activity):void
        {
            var loc2:*=null;
            var loc41:*=false;
            var loc37:*=false;
            var loc50:*=false;
            var loc5:*=false;
            var loc7:*=false;
            var loc13:*=null;
            var loc52:*=0;
            if (arg1.simpleHeaderValuesCalculation) 
            {
                return;
            }
            var loc29:*=arg1.recalculatedValues;
            resetResult(loc29);
            loc29.activityId = arg1.activityId;
            var loc27:*;
            var loc3:*;
            if ((loc3 = (loc27 = arg1.entries).length) == 0) 
            {
                return;
            }
            var loc36:*;
            --loc36;
            var loc14:*=0;
            var loc6:*=0;
            var loc1:*=0;
            var loc19:*=0;
            var loc58:*=0;
            var loc42:*=0;
            var loc10:*=0;
            var loc48:*=0;
            var loc24:*=0;
            var loc55:*=0;
            var loc25:*=0;
            var loc57:*=0;
            var loc47:*=0;
            var loc21:*=0;
            var loc30:*=0;
            var loc46:*=0;
            var loc31:*=0;
            var loc26:*=0;
            var loc23:*=0;
            var loc15:*=0;
            var loc59:*=0;
            var loc35:*=0;
            var loc17:*=0;
            var loc12:*=0;
            var loc28:*=0;
            var loc4:*=0;
            var loc9:*=0;
            var loc44:*=0;
            var loc16:*=0;
            var loc38:*=true;
            var loc54:*=true;
            var loc49:*=true;
            var loc32:*=true;
            var loc18:*=true;
            var loc8:*=true;
            var loc39:*=true;
            var loc11:*=true;
            var loc33:*=true;
            var loc56:*=true;
            var loc45:*=true;
            var loc22:*=true;
            var loc40:*=true;
            var loc43:*=true;
            var loc34:*=true;
            var loc51:*=true;
            var loc20:*=true;
            var loc53:*=0;
            if (loc3 > 0) 
            {
                if (loc7 = loc27[0].heartrateDefined) 
                {
                    if (arg1.lowerLimitDefined) 
                    {
                        loc37 = true;
                    }
                    else if (arg1.unitType != core.general.UnitType.PC2814) 
                    {
                        loc50 = true;
                    }
                    if (arg1.hrMaxDefined) 
                    {
                        loc5 = true;
                        loc13 = configCache.ConfigCache.getInstance().getIntensityZoneValue(arg1.sport);
                        if (!arg1.intensityZone1StartDefined && loc13) 
                        {
                            arg1.intensityZone1Start = arg1.hrMax * loc13.intensityZone1Start / 100;
                            arg1.intensityZone1StartDefined = true;
                        }
                        if (!arg1.intensityZone2StartDefined && loc13) 
                        {
                            arg1.intensityZone2Start = arg1.hrMax * loc13.intensityZone2Start / 100;
                            arg1.intensityZone2StartDefined = true;
                        }
                        if (!arg1.intensityZone3StartDefined && loc13) 
                        {
                            arg1.intensityZone3Start = arg1.hrMax * loc13.intensityZone3Start / 100;
                            arg1.intensityZone3StartDefined = true;
                        }
                        if (!arg1.intensityZone4StartDefined && loc13) 
                        {
                            arg1.intensityZone4Start = arg1.hrMax * loc13.intensityZone4Start / 100;
                            arg1.intensityZone4StartDefined = true;
                        }
                        if (!arg1.intensityZone4EndDefined && loc13) 
                        {
                            arg1.intensityZone4End = arg1.hrMax * loc13.intensityZone4End / 100;
                            arg1.intensityZone4EndDefined = true;
                        }
                    }
                }
            }
            if (loc7) 
            {
                arg1.minimumHeartrateDefined = true;
                arg1.maximumHeartrateDefined = true;
                arg1.averageHeartrateDefined = true;
                if (arg1.lowerLimitDefined) 
                {
                    arg1.timeUnderZoneDefined = true;
                    arg1.timeInZoneDefined = true;
                    arg1.timeOverZoneDefined = true;
                }
                else if (!(arg1.unitType == null || arg1.unitType == core.general.UnitType.SigmaMove || arg1.unitType == core.general.UnitType.PC2814)) 
                {
                    arg1.timeUnderZoneDefined = true;
                    arg1.timeInZone1Defined = true;
                    arg1.timeInZone2Defined = true;
                    arg1.timeInZone3Defined = true;
                    arg1.timeOverZoneDefined = true;
                }
                if (arg1.hrMaxDefined) 
                {
                    arg1.timeUnderIntensityZoneDefined = true;
                    arg1.timeInIntensityZone1Defined = true;
                    arg1.timeInIntensityZone2Defined = true;
                    arg1.timeInIntensityZone3Defined = true;
                    arg1.timeInIntensityZone4Defined = true;
                    arg1.timeOverIntensityZoneDefined = true;
                }
            }
            loc53 = 0;
            while (loc53 <= loc36) 
            {
                if (loc3 != loc53) 
                {
                    loc41 = loc53 != 0 ? false : true;
                    loc2 = loc27[loc53];
                    loc2.heartrateDefined = loc7;
                    loc2.targetZoneDefined = loc37;
                    loc2.zoneDefined = loc50;
                    loc2.intensityZoneDefined = loc5;
                    ++loc31;
                    if (loc7) 
                    {
                        loc38 = true;
                        loc54 = true;
                        if (arg1.unitType != core.general.UnitType.ROX100) 
                        {
                            loc38 = loc54 = loc2.heartrate > 0 && !(loc2.heartrate == 20);
                        }
                        else 
                        {
                            loc38 = loc2.heartrate > 0;
                            loc54 = loc2.heartrate >= 0;
                        }
                        if (loc54) 
                        {
                            if (loc49) 
                            {
                                loc49 = false;
                                loc29.minimumHeartrate = loc2.heartrate;
                                loc29.maximumHeartrate = loc2.heartrate;
                            }
                            else 
                            {
                                loc29.minimumHeartrate = Math.min(loc29.minimumHeartrate, loc2.heartrate);
                                loc29.maximumHeartrate = Math.max(loc29.maximumHeartrate, loc2.heartrate);
                            }
                            if (loc2.percentHRMaxDefined) 
                            {
                                if (loc32) 
                                {
                                    loc32 = false;
                                    loc29.minimumPercentHRMax = loc2.percentHRMax;
                                    loc29.maximumPercentHRMax = loc2.percentHRMax;
                                }
                                else 
                                {
                                    loc29.minimumPercentHRMax = Math.min(loc29.minimumPercentHRMax, loc2.percentHRMax);
                                    loc29.maximumPercentHRMax = Math.max(loc29.maximumPercentHRMax, loc2.percentHRMax);
                                }
                            }
                            if (arg1.lowerLimitDefined) 
                            {
                                if (loc2.heartrate < arg1.lowerLimit) 
                                {
                                    loc29.timeUnderZone = loc29.timeUnderZone + loc2.trainingTime;
                                    loc2.targetZone = 0;
                                }
                                else if (loc2.heartrate >= arg1.lowerLimit && loc2.heartrate < arg1.upperLimit) 
                                {
                                    loc29.timeInZone = loc29.timeInZone + loc2.trainingTime;
                                    loc2.targetZone = 1;
                                }
                                else if (loc2.heartrate >= arg1.upperLimit) 
                                {
                                    loc29.timeOverZone = loc29.timeOverZone + loc2.trainingTime;
                                    loc2.targetZone = 2;
                                }
                            }
                            else if (arg1.zone1StartDefined && loc2.heartrate < arg1.zone1Start) 
                            {
                                loc29.timeUnderZone = loc29.timeUnderZone + loc2.trainingTime;
                                loc2.zone = 0;
                            }
                            else if (arg1.zone1StartDefined && arg1.zone2StartDefined && loc2.heartrate >= arg1.zone1Start && loc2.heartrate < arg1.zone2Start) 
                            {
                                loc29.timeInZone1 = loc29.timeInZone1 + loc2.trainingTime;
                                loc2.zone = 1;
                            }
                            else if (arg1.zone2StartDefined && arg1.zone3StartDefined && loc2.heartrate >= arg1.zone2Start && loc2.heartrate < arg1.zone3Start) 
                            {
                                loc29.timeInZone2 = loc29.timeInZone2 + loc2.trainingTime;
                                loc2.zone = 2;
                            }
                            else if (arg1.zone3StartDefined && arg1.zone3EndDefined && loc2.heartrate >= arg1.zone3Start && loc2.heartrate < arg1.zone3End) 
                            {
                                loc29.timeInZone3 = loc29.timeInZone3 + loc2.trainingTime;
                                loc2.zone = 3;
                            }
                            else 
                            {
                                loc29.timeOverZone = loc29.timeOverZone + loc2.trainingTime;
                                loc2.zone = 4;
                            }
                            if (arg1.hrMaxDefined) 
                            {
                                if (arg1.intensityZone1StartDefined && loc2.heartrate <= arg1.intensityZone1Start) 
                                {
                                    loc29.timeUnderIntensityZone = loc29.timeUnderIntensityZone + loc2.trainingTime;
                                    loc2.intensityZone = 0;
                                }
                                else if (loc2.heartrate > arg1.intensityZone1Start && loc2.heartrate <= arg1.intensityZone2Start) 
                                {
                                    loc29.timeInIntensityZone1 = loc29.timeInIntensityZone1 + loc2.trainingTime;
                                    loc2.intensityZone = 1;
                                }
                                else if (loc2.heartrate > arg1.intensityZone2Start && loc2.heartrate <= arg1.intensityZone3Start) 
                                {
                                    loc29.timeInIntensityZone2 = loc29.timeInIntensityZone2 + loc2.trainingTime;
                                    loc2.intensityZone = 2;
                                }
                                else if (loc2.heartrate > arg1.intensityZone3Start && loc2.heartrate <= arg1.intensityZone4Start) 
                                {
                                    loc29.timeInIntensityZone3 = loc29.timeInIntensityZone3 + loc2.trainingTime;
                                    loc2.intensityZone = 3;
                                }
                                else if (loc2.heartrate > arg1.intensityZone4Start && loc2.heartrate <= arg1.hrMax) 
                                {
                                    loc29.timeInIntensityZone4 = loc29.timeInIntensityZone4 + loc2.trainingTime;
                                    loc2.intensityZone = 4;
                                }
                                else if (loc2.heartrate > arg1.hrMax) 
                                {
                                    loc29.timeOverIntensityZone = loc29.timeOverIntensityZone + loc2.trainingTime;
                                    loc2.intensityZone = 5;
                                }
                            }
                        }
                        if (loc38) 
                        {
                            ++loc35;
                            loc14 = loc14 + loc2.heartrate;
                            if (loc2.percentHRMaxDefined) 
                            {
                                loc6 = loc6 + loc2.percentHRMax;
                            }
                        }
                    }
                    if (loc2.speedDefined) 
                    {
                        loc8 = true;
                        arg1.minimumSpeedDefined = true;
                        arg1.maximumSpeedDefined = true;
                        arg1.averageSpeedDefined = true;
                        if (arg1.unitType != core.general.UnitType.RC1411) 
                        {
                            loc8 = loc2.speed >= 0;
                        }
                        else 
                        {
                            loc8 = loc2.speed > 0;
                        }
                        if (loc8) 
                        {
                            if (loc39) 
                            {
                                loc39 = false;
                                loc29.minimumSpeed = loc2.speed;
                                loc29.maximumSpeed = loc2.speed;
                            }
                            else 
                            {
                                loc29.minimumSpeed = Math.min(loc29.minimumSpeed, loc2.speed);
                                loc29.maximumSpeed = Math.max(loc29.maximumSpeed, loc2.speed);
                            }
                        }
                    }
                    if (loc2.temperatureDefined) 
                    {
                        loc11 = true;
                        loc33 = true;
                        arg1.minimumTemperatureDefined = true;
                        arg1.maximumTemperatureDefined = true;
                        arg1.averageTemperatureDefined = true;
                        if (loc33) 
                        {
                            if (loc56) 
                            {
                                loc56 = false;
                                loc29.minimumTemperature = loc2.temperature;
                                loc29.maximumTemperature = loc2.temperature;
                            }
                            else 
                            {
                                loc29.minimumTemperature = Math.min(loc29.minimumTemperature, loc2.temperature);
                                loc29.maximumTemperature = Math.max(loc29.maximumTemperature, loc2.temperature);
                            }
                        }
                        if (loc11) 
                        {
                            ++loc16;
                            loc42 = loc42 + loc2.temperature;
                        }
                    }
                    if (loc2.inclineDefined) 
                    {
                        arg1.minimumInclineDefined = true;
                        arg1.maximumInclineDefined = true;
                        arg1.averageInclineUphillDefined = true;
                        arg1.averageInclineDownhillDefined = true;
                        loc10 = loc10 + loc2.incline;
                        if (loc41) 
                        {
                            loc29.minimumIncline = loc2.incline;
                            loc29.maximumIncline = loc2.incline;
                        }
                        else 
                        {
                            loc29.minimumIncline = Math.min(loc29.minimumIncline, loc2.incline);
                            loc29.maximumIncline = Math.max(loc29.maximumIncline, loc2.incline);
                        }
                        if (loc2.incline > 0) 
                        {
                            ++loc17;
                            loc24 = loc24 + loc2.incline;
                            if (loc41) 
                            {
                                loc29.minimumInclineUphill = loc2.incline;
                                loc29.maximumInclineUphill = loc2.incline;
                            }
                            else 
                            {
                                loc29.minimumInclineUphill = Math.min(loc29.minimumInclineUphill, loc2.incline);
                                loc29.maximumInclineUphill = Math.max(loc29.maximumInclineUphill, loc2.incline);
                            }
                        }
                        else if (loc2.incline < 0) 
                        {
                            --loc12;
                            loc48 = loc48 + loc2.incline;
                            if (loc41) 
                            {
                                loc29.minimumInclineDownhill = loc2.incline;
                                loc29.maximumInclineDownhill = loc2.incline;
                            }
                            else 
                            {
                                loc29.minimumInclineDownhill = Math.min(loc29.minimumInclineDownhill, loc2.incline);
                                loc29.maximumInclineDownhill = Math.max(loc29.maximumInclineDownhill, loc2.incline);
                            }
                        }
                    }
                    if (loc2.altitudeDefined) 
                    {
                        arg1.minimumAltitudeDefined = true;
                        arg1.maximumAltitudeDefined = true;
                        arg1.averageAltitudeDefined = true;
                        loc55 = loc55 + loc2.altitude;
                        if (loc41) 
                        {
                            loc29.minimumAltitude = loc2.altitude;
                            loc29.maximumAltitude = loc2.altitude;
                        }
                        else 
                        {
                            loc29.minimumAltitude = Math.min(loc29.minimumAltitude, loc2.altitude);
                            loc29.maximumAltitude = Math.max(loc29.maximumAltitude, loc2.altitude);
                        }
                    }
                    if (loc2.riseRateDefined) 
                    {
                        arg1.minimumRiseRateDefined = true;
                        arg1.maximumRiseRateDefined = true;
                        arg1.averageRiseRateDefined = true;
                        arg1.averageRiseRateDownhillDefined = true;
                        arg1.averageRiseRateUphillDefined = true;
                        loc25 = loc25 + loc2.riseRate;
                        if (loc41) 
                        {
                            loc29.minimumRiseRate = loc2.riseRate;
                            loc29.maximumRiseRate = loc2.riseRate;
                        }
                        else 
                        {
                            loc29.minimumRiseRate = Math.min(loc29.minimumRiseRate, loc2.riseRate);
                            loc29.maximumRiseRate = Math.max(loc29.maximumRiseRate, loc2.riseRate);
                        }
                        if (loc2.riseRate > 0) 
                        {
                            ++loc28;
                            loc57 = loc57 + loc2.riseRate;
                            if (loc41) 
                            {
                                loc29.minimumRiseRateUphill = loc2.riseRate;
                                loc29.maximumRiseRateUphill = loc2.riseRate;
                            }
                            else 
                            {
                                loc29.minimumRiseRateUphill = Math.min(loc29.minimumRiseRateUphill, loc2.riseRate);
                                loc29.maximumRiseRateUphill = Math.max(loc29.maximumRiseRateUphill, loc2.riseRate);
                            }
                        }
                        else if (loc2.riseRate < 0) 
                        {
                            ++loc4;
                            loc47 = loc47 + loc2.riseRate;
                            if (loc41) 
                            {
                                loc29.minimumRiseRateDownhill = loc2.riseRate;
                                loc29.maximumRiseRateDownhill = loc2.riseRate;
                            }
                            else 
                            {
                                loc29.minimumRiseRateDownhill = Math.min(loc29.minimumRiseRateDownhill, loc2.riseRate);
                                loc29.maximumRiseRateDownhill = Math.max(loc29.maximumRiseRateDownhill, loc2.riseRate);
                            }
                        }
                    }
                    if (loc2.cadenceDefined) 
                    {
                        arg1.minimumCadenceDefined = true;
                        arg1.maximumCadenceDefined = true;
                        arg1.averageCadenceDefined = true;
                        loc45 = loc2.cadence > 0;
                        if (loc22 = loc2.cadence >= 0) 
                        {
                            if (loc40) 
                            {
                                loc40 = false;
                                loc29.minimumCadence = loc2.cadence;
                                loc29.maximumCadence = loc2.cadence;
                            }
                            else 
                            {
                                loc29.minimumCadence = Math.min(loc29.minimumCadence, loc2.cadence);
                                loc29.maximumCadence = Math.max(loc29.maximumCadence, loc2.cadence);
                            }
                        }
                        if (loc45) 
                        {
                            ++loc59;
                            loc21 = loc21 + loc2.cadence;
                        }
                    }
                    if (loc2.powerDefined) 
                    {
                        arg1.minimumPowerDefined = true;
                        arg1.maximumPowerDefined = true;
                        arg1.averagePowerDefined = true;
                        loc43 = loc2.power > 0;
                        if (loc34 = loc2.power >= 0) 
                        {
                            if (loc20) 
                            {
                                loc20 = false;
                                loc29.minimumPower = loc2.power;
                                loc29.maximumPower = loc2.power;
                            }
                            else 
                            {
                                loc29.minimumPower = Math.min(loc29.minimumPower, loc2.power);
                                loc29.maximumPower = Math.max(loc29.maximumPower, loc2.power);
                            }
                        }
                        if (loc43) 
                        {
                            ++loc9;
                            loc30 = loc30 + loc2.power;
                        }
                        if (loc2.powerDefined && arg1.powerZone1StartDefined && arg1.powerZone2StartDefined && arg1.powerZone3StartDefined && arg1.powerZone4StartDefined && arg1.powerZone5StartDefined && arg1.powerZone6StartDefined && arg1.powerZone7StartDefined && arg1.powerZone7EndDefined) 
                        {
                            arg1.timeInPowerZone1Defined = true;
                            arg1.timeInPowerZone2Defined = true;
                            arg1.timeInPowerZone3Defined = true;
                            arg1.timeInPowerZone4Defined = true;
                            arg1.timeInPowerZone5Defined = true;
                            arg1.timeInPowerZone6Defined = true;
                            arg1.timeInPowerZone7Defined = true;
                            loc2.powerZoneDefined = true;
                            if ((loc52 = loc2.power) >= arg1.powerZone1Start && loc52 <= arg1.powerZone2Start) 
                            {
                                loc29.timeInPowerZone1 = loc29.timeInPowerZone1 + loc2.trainingTime;
                                loc2.powerZone = 1;
                            }
                            else if (loc52 > arg1.powerZone2Start && loc52 <= arg1.powerZone3Start) 
                            {
                                loc29.timeInPowerZone2 = loc29.timeInPowerZone2 + loc2.trainingTime;
                                loc2.powerZone = 2;
                            }
                            else if (loc52 > arg1.powerZone3Start && loc52 <= arg1.powerZone4Start) 
                            {
                                loc29.timeInPowerZone3 = loc29.timeInPowerZone3 + loc2.trainingTime;
                                loc2.powerZone = 3;
                            }
                            else if (loc52 > arg1.powerZone4Start && loc52 <= arg1.powerZone5Start) 
                            {
                                loc29.timeInPowerZone4 = loc29.timeInPowerZone4 + loc2.trainingTime;
                                loc2.powerZone = 4;
                            }
                            else if (loc52 > arg1.powerZone5Start && loc52 <= arg1.powerZone6Start) 
                            {
                                loc29.timeInPowerZone5 = loc29.timeInPowerZone5 + loc2.trainingTime;
                                loc2.powerZone = 5;
                            }
                            else if (loc52 > arg1.powerZone6Start && loc52 <= arg1.powerZone7Start) 
                            {
                                loc29.timeInPowerZone6 = loc29.timeInPowerZone6 + loc2.trainingTime;
                                loc2.powerZone = 6;
                            }
                            else if (loc52 > arg1.powerZone7Start && loc52 <= arg1.powerZone7End) 
                            {
                                loc29.timeInPowerZone7 = loc29.timeInPowerZone7 + loc2.trainingTime;
                                loc2.powerZone = 7;
                            }
                        }
                    }
                    if (loc2.powerPerKGDefined) 
                    {
                        arg1.averagePowerKJDefined = true;
                        if (loc51 = loc2.powerPerKG > 0) 
                        {
                            loc46 = loc46 + loc2.powerPerKG;
                            ++loc44;
                        }
                    }
                    if (loc2.workInKJDefined) 
                    {
                        arg1.workInKJDefined = true;
                        loc29.workInKJ = loc29.workInKJ + loc2.workInKJ;
                    }
                    loc29.calories = loc29.calories + loc2.calories;
                    if (loc2.distanceDefined) 
                    {
                        loc29.distance = loc29.distance + loc2.distance;
                        if (!loc2.distanceAbsoluteDefined) 
                        {
                            loc2.distanceAbsoluteDefined = true;
                        }
                        loc2.distanceAbsolute = loc29.distance;
                    }
                    if (arg1.exerciseTimeDefined && arg1.trainingTimeDefined) 
                    {
                        loc29.exerciseTime = loc29.exerciseTime + loc2.trainingTime;
                        if (loc2.speedDefined && loc2.speed > 0 || arg1.unit is core.units.UnitROX70) 
                        {
                            loc29.trainingTime = loc29.trainingTime + loc2.trainingTime;
                        }
                        loc2.trainingTimeAbsolute = loc29.exerciseTime;
                    }
                    else if (arg1.trainingTimeDefined && !arg1.exerciseTimeDefined) 
                    {
                        loc29.trainingTime = loc29.trainingTime + loc2.trainingTime;
                        loc2.trainingTimeAbsolute = loc29.trainingTime;
                    }
                    if (loc2.distanceUphillDefined) 
                    {
                        loc29.distanceUphill = loc29.distanceUphill + loc2.distanceUphill;
                    }
                    if (loc2.distanceDownhillDefined) 
                    {
                        loc29.distanceDownhill = loc29.distanceDownhill + loc2.distanceDownhill;
                    }
                    if (loc2.trainingTimeUphillDefined) 
                    {
                        loc29.trainingTimeUphill = loc29.trainingTimeUphill + loc2.trainingTimeUphill;
                    }
                    if (loc2.trainingTimeDownhillDefined) 
                    {
                        loc29.trainingTimeDownhill = loc29.trainingTimeDownhill + loc2.trainingTimeDownhill;
                    }
                    if (loc2.altitudeDifferencesUphillDefined) 
                    {
                        loc29.altitudeDifferencesUphill = loc29.altitudeDifferencesUphill + loc2.altitudeDifferencesUphill;
                    }
                    if (loc2.altitudeDifferencesDownhillDefined) 
                    {
                        loc29.altitudeDifferencesDownhill = loc29.altitudeDifferencesDownhill + loc2.altitudeDifferencesDownhill;
                    }
                }
                ++loc53;
            }
            if (loc2.heartrateDefined && !(loc35 == 0)) 
            {
                loc29.averageHeartrate = loc14 / loc35;
            }
            if (loc2.percentHRMaxDefined) 
            {
                loc29.averagePercentHRMax = loc6 / loc35;
            }
            if (arg1.unitType != core.general.UnitType.BC2316STS) 
            {
                if (loc2.speedDefined && !(loc31 == 0)) 
                {
                    loc29.averageSpeed = loc29.distance / (loc29.trainingTime / 100);
                    if (loc2.distanceUphillDefined) 
                    {
                        arg1.distanceUphillDefined = true;
                        arg1.averageSpeedUphillDefined = true;
                        loc29.averageSpeedUphill = loc29.distanceUphill / (loc29.trainingTimeUphill / 100);
                    }
                    if (loc2.distanceDownhillDefined) 
                    {
                        arg1.distanceDownhillDefined = true;
                        arg1.averageSpeedDownhillDefined = true;
                        loc29.averageSpeedDownhill = loc29.distanceDownhill / (loc29.trainingTimeDownhill / 100);
                    }
                }
            }
            if (loc2.temperatureDefined && !(loc16 == 0)) 
            {
                loc29.averageTemperature = loc42 / loc16;
            }
            if (loc2.inclineDefined && !(loc31 == 0)) 
            {
                if (loc17 != 0) 
                {
                    loc29.averageInclineUphill = loc24 / loc17;
                }
                if (loc12 != 0) 
                {
                    loc29.averageInclineDownhill = loc48 / loc12;
                }
            }
            if (loc2.altitudeDefined && !(loc31 == 0)) 
            {
                loc29.averageAltitude = loc55 / loc31;
            }
            if (loc2.riseRateDefined && !(loc31 == 0)) 
            {
                loc29.averageRiseRate = loc25 / loc31;
                if (loc28 != 0) 
                {
                    loc29.averageRiseRateUphill = loc57 / loc28;
                }
                if (loc4 != 0) 
                {
                    loc29.averageRiseRateDownhill = loc47 / loc4;
                }
            }
            if (loc2.cadenceDefined && !(loc59 == 0)) 
            {
                loc29.averageCadence = loc21 / loc59;
            }
            if (loc2.powerDefined && !(loc9 == 0)) 
            {
                loc29.averagePower = loc30 / loc9;
            }
            if (loc2.powerPerKGDefined && !(loc44 == 0)) 
            {
                loc29.averagePowerWattPerKG = loc46 / loc44;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg1.minimumHeartrate = loc29.minimumHeartrate;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg1.maximumHeartrate = loc29.maximumHeartrate;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg1.averageHeartrate = loc29.averageHeartrate;
            }
            if (arg1.minimumPercentHRMaxDefined) 
            {
                arg1.minimumPercentHRMax = loc29.minimumPercentHRMax;
            }
            if (arg1.maximumPercentHRMaxDefined) 
            {
                arg1.maximumPercentHRMax = loc29.maximumPercentHRMax;
            }
            if (arg1.averagePercentHRMaxDefined) 
            {
                arg1.averagePercentHRMax = loc29.averagePercentHRMax;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg1.minimumSpeed = loc29.minimumSpeed;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg1.maximumSpeed = loc29.maximumSpeed;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg1.averageSpeed = loc29.averageSpeed;
            }
            if (arg1.averageSpeedUphillDefined) 
            {
                arg1.averageSpeedUphill = loc29.averageSpeedUphill;
            }
            if (arg1.averageSpeedDownhillDefined) 
            {
                arg1.averageSpeedDownhill = loc29.averageSpeedDownhill;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg1.distanceUphill = loc29.distanceUphill;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg1.distanceDownhill = loc29.distanceDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg1.trainingTimeUphill = loc29.trainingTimeUphill;
            }
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg1.trainingTimeDownhill = loc29.trainingTimeDownhill;
            }
            if (arg1.minimumTemperatureDefined) 
            {
                arg1.minimumTemperature = loc29.minimumTemperature;
            }
            if (arg1.maximumTemperatureDefined) 
            {
                arg1.maximumTemperature = loc29.maximumTemperature;
            }
            if (arg1.averageTemperatureDefined) 
            {
                arg1.averageTemperature = loc29.averageTemperature;
            }
            if (arg1.minimumInclineDefined) 
            {
                arg1.minimumIncline = loc29.minimumIncline;
            }
            if (arg1.maximumInclineDefined) 
            {
                arg1.maximumIncline = loc29.maximumIncline;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg1.averageInclineUphill = loc29.averageInclineUphill;
            }
            if (arg1.averageInclineDownhillDefined) 
            {
                arg1.averageInclineDownhill = loc29.averageInclineDownhill;
            }
            if (arg1.minimumAltitudeDefined) 
            {
                arg1.minimumAltitude = loc29.minimumAltitude;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg1.maximumAltitude = loc29.maximumAltitude;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg1.averageAltitude = loc29.averageAltitude;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg1.altitudeDifferencesUphill = loc29.altitudeDifferencesUphill;
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg1.altitudeDifferencesDownhill = loc29.altitudeDifferencesDownhill;
            }
            if (arg1.workInKJDefined) 
            {
                arg1.workInKJ = loc29.workInKJ;
            }
            if (arg1.minimumRiseRateDefined) 
            {
                arg1.minimumRiseRate = loc29.minimumRiseRate;
            }
            if (arg1.maximumRiseRateDefined) 
            {
                arg1.maximumRiseRate = loc29.maximumRiseRate;
            }
            if (arg1.averageRiseRateDefined) 
            {
                arg1.averageRiseRate = loc29.averageRiseRate;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg1.averageRiseRateUphill = loc29.averageRiseRateUphill;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg1.averageRiseRateDownhill = loc29.averageRiseRateDownhill;
            }
            if (arg1.minimumCadenceDefined) 
            {
                arg1.minimumCadence = loc29.minimumCadence;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg1.maximumCadence = loc29.maximumCadence;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg1.averageCadence = loc29.averageCadence;
            }
            if (arg1.minimumPowerDefined) 
            {
                arg1.minimumPower = loc29.minimumPower;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg1.maximumPower = loc29.maximumPower;
            }
            if (arg1.averagePowerDefined) 
            {
                arg1.averagePower = loc29.averagePower;
            }
            if (arg1.averagePowerWattPerKGDefined) 
            {
                arg1.averagePowerWattPerKG = loc29.averagePowerWattPerKG;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg1.timeInPowerZone1 = loc29.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg1.timeInPowerZone2 = loc29.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg1.timeInPowerZone3 = loc29.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg1.timeInPowerZone4 = loc29.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg1.timeInPowerZone5 = loc29.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg1.timeInPowerZone6 = loc29.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg1.timeInPowerZone7 = loc29.timeInPowerZone7;
            }
            arg1.lastSelectedStartEntry = arg1.selectedStartEntry;
            arg1.lastSelectedEndEntry = arg1.selectedEndEntry;
            arg1.dispatchEvent(new flash.events.Event("intensityZonesRecalculated"));
            arg1.dispatchEvent(new flash.events.Event("powerZonesRecalculated"));
            return;
        }

        public static function getLastMarker(arg1:core.activities.Activity, arg2:String):core.marker.Marker
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=core.marker.MarkerFactory.createMarkerFromLog(arg1, arg2);
            if (arg1.markerList != null) 
            {
                loc3 = (loc2 = arg1.markerList.length - 1);
                while (loc3 >= 0) 
                {
                    loc4 = arg1.markerList[loc3];
                    if (arg2 == null || loc4.type == arg2) 
                    {
                        loc1 = loc4;
                    }
                    --loc3;
                }
            }
            return loc1;
        }

        public static function createAutoLapsByDistance(arg1:core.activities.Activity, arg2:Number=5000, arg3:Boolean=true):void
        {
            var loc14:*=null;
            var loc1:*=null;
            var loc7:*=null;
            var loc8:*=0;
            var loc2:*=null;
            var loc12:*=null;
            var loc4:*=0;
            var loc3:*=NaN;
            var loc6:*=NaN;
            var loc9:*=NaN;
            var loc15:*=NaN;
            var loc10:*=arg1.entries.length;
            var loc5:*=arg2;
            var loc11:*=0;
            var loc13:*=false;
            loc4 = 0;
            while (loc4 < loc10) 
            {
                loc7 = arg1.entries[loc4];
                loc13 = loc4 == (loc10 - 1);
                if (loc7.distanceAbsolute >= loc5 || loc13 && arg3) 
                {
                    if (loc4 > 1) 
                    {
                        loc12 = arg1.entries[(loc4 - 1)];
                    }
                    if (loc13) 
                    {
                        (loc14 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "l")).type = "l";
                        loc14.logReference = arg1;
                        loc14.number = 0;
                        (loc14 = calculateMarkerValues(arg1, loc14, 0, (loc10 - 1))).distanceAbsolute = loc7.distanceAbsolute;
                        loc14.timeAbsolute = loc7.trainingTimeAbsolute;
                    }
                    else 
                    {
                        (loc14 = core.marker.MarkerFactory.createMarkerFromLog(arg1, "al")).type = "al";
                        loc14.logReference = arg1;
                        loc14.number = loc11;
                        (loc14 = calculateMarkerValues(arg1, loc14, arg1.entries.indexOf(loc2) + 1, arg1.entries.indexOf(loc7))).distance = arg2;
                        loc14.distanceAbsolute = loc5;
                        if (loc12) 
                        {
                            loc3 = loc7.trainingTimeAbsolute - loc12.trainingTimeAbsolute;
                            loc6 = loc7.distanceAbsolute - loc12.distanceAbsolute;
                            loc9 = loc14.distanceAbsolute - loc12.distanceAbsolute;
                            loc15 = loc3 * loc9 / loc6;
                            loc14.timeAbsolute = loc12.trainingTimeAbsolute + loc15;
                        }
                        else 
                        {
                            loc14.timeAbsolute = loc7.trainingTimeAbsolute;
                        }
                        if (loc1) 
                        {
                            loc14.time = loc14.timeAbsolute - loc1.timeAbsolute;
                        }
                        else 
                        {
                            loc14.time = loc14.timeAbsolute;
                        }
                    }
                    arg1.markerList.push(loc14);
                    ++loc11;
                    loc5 = loc11 * arg2 + arg2;
                    loc2 = loc7;
                    loc1 = loc14;
                }
                ++loc4;
            }
            return;
        }

        public static function addLap(arg1:core.activities.Activity):void
        {
            var loc9:*=null;
            var loc2:*=0;
            if (arg1.selectedMiddleEntry == null) 
            {
                return;
            }
            var loc8:*=-1;
            var loc1:*=-1;
            var loc3:*=0;
            var loc7:*=0;
            var loc4:*=arg1.markerList.length;
            var loc6:*=arg1.selectedMiddleEntry;
            loc7 = 0;
            while (loc7 < loc4) 
            {
                if ((loc9 = arg1.markerList[loc7]).type == "l") 
                {
                    if (loc9.timeAbsolute < loc6.trainingTimeAbsolute) 
                    {
                        loc8 = Math.max(loc9.number, loc8);
                        loc1 = loc7;
                    }
                    else if (loc9.timeAbsolute > loc6.trainingTimeAbsolute) 
                    {
                        loc9.number = loc9.number + 1;
                        ++loc3;
                    }
                    else 
                    {
                        debug.Debug.warning("lap bereits vorhanden...");
                        return;
                    }
                }
                ++loc7;
            }
            ++loc8;
            ++loc1;
            var loc10:*;
            (loc10 = core.marker.MarkerFactory.createMarkerFromLog(arg1)).logReference = arg1;
            loc10.type = "l";
            loc10.isSelected = true;
            loc10.number = loc8;
            if (loc10.distanceAbsoluteDefined && loc6.distanceAbsoluteDefined) 
            {
                loc10.distanceAbsolute = loc6.distanceAbsolute;
            }
            loc10.timeAbsolute = loc6.trainingTimeAbsolute;
            arg1.markerList.push(loc10);
            arg1.markerList.sort(sortMarker);
            var loc5:*;
            if ((loc5 = recalculateMarkerValues(arg1, null, loc10)).length > 0) 
            {
                handler.ActivityHandlerCommon.getInstance().addEventListener("activitySaveError", onMarkerError);
                handler.ActivityHandlerCommon.getInstance().addEventListener("activityMarkerSaved", onMarkerSaved);
                handler.ActivityHandlerCommon.getInstance().saveActivityMarker(arg1);
            }
            else 
            {
                loc2 = arg1.markerList.indexOf(loc10);
                if (loc2 != -1) 
                {
                    arg1.markerList.splice(loc2, 1);
                }
                loc4 = arg1.markerList.length;
                loc7 = loc1;
                while (loc7 < loc4) 
                {
                    if ((loc9 = arg1.markerList[loc7]).type == "l") 
                    {
                        --loc9.number;
                        --loc3;
                    }
                    ++loc7;
                }
                if (loc3 == 0) 
                {
                };
            }
            return;
        }

        public static function recalculateMarkerValues(arg1:core.activities.Activity, arg2:core.marker.Marker, arg3:core.marker.Marker=null):__AS3__.vec.Vector.<core.marker.Marker>
        {
            var loc35:*=null;
            var loc26:*=null;
            var loc13:*=0;
            var loc21:*=0;
            var loc2:*=false;
            var loc11:*=false;
            var loc1:*=0;
            var loc6:*=null;
            var loc8:*=null;
            var loc27:*=0;
            var loc7:*=0;
            var loc16:*=0;
            var loc23:*=0;
            var loc17:*=0;
            var loc33:*=0;
            var loc22:*=null;
            var loc19:*=0;
            var loc5:*=null;
            var loc9:*=NaN;
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc18:*=NaN;
            var loc15:*=NaN;
            var loc10:*=NaN;
            var loc32:*=NaN;
            var loc20:*=NaN;
            var loc3:*=NaN;
            var loc12:*=NaN;
            var loc4:*=NaN;
            var loc24:*=NaN;
            var loc14:*=NaN;
            var loc25:*=NaN;
            var loc31:*=new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc30:*=arg1.entries;
            arg1.markerList.sort(sortMarker);
            var loc34:*=arg1.markerList;
        }

        public static function removeEntryFromEntriesVector(arg1:core.activities.ActivityEntry, arg2:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            if (arg2.indexOf(arg1) > -1) 
            {
                arg2.splice(arg2.indexOf(arg1), 1);
                removeEntryFromEntriesVector(arg1, arg2);
            }
            return;
        }

        public static function removeMarkerFromMarkersVector(arg1:core.marker.Marker, arg2:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            var loc1:*=arg2.indexOf(arg1);
            if (loc1 > -1) 
            {
                arg2.splice(loc1, 1);
            }
            return;
        }

        public static function calculateBest20MinPowerStartEntry(arg1:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=null;
            if (arg1.best20minPowerEntryDefined && arg1.best20minPowerDefined) 
            {
                loc3 = arg1.entries[arg1.best20minPowerEntry];
                loc1 = new utils.LogEntrySearch().searchNearestIndex(loc3.trainingTimeAbsolute - 120000, arg1.entries, "trainingTimeAbsolute");
                if (!(loc1 == -1) && !(arg1.best20minPowerEntry == loc1)) 
                {
                    loc2 = arg1.entries[loc1];
                }
            }
            return loc2;
        }

        public static function calculateBest5KStartEntry(arg1:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=null;
            if (arg1.best5KEntryDefined && arg1.best5KTimeDefined) 
            {
                loc3 = arg1.entries[arg1.best5KEntry];
                loc1 = new utils.LogEntrySearch().searchNearestIndex(loc3.trainingTimeAbsolute - arg1.best5KTime, arg1.entries, "trainingTimeAbsolute");
                loc2 = arg1.entries[loc1];
            }
            return loc2;
        }

        public static function calculateNewBest5KEntry(arg1:core.activities.Activity, arg2:int, arg3:int):void
        {
            if (arg1.best5KEntryDefined) 
            {
                if (arg3 >= arg1.best5KEntry) 
                {
                    arg1.best5KEntry = arg1.best5KEntry - arg2;
                    if (arg1.entries[arg1.best5KEntry].trainingTimeAbsolute - arg1.best5KTime < 0) 
                    {
                        removeBest5KProperties(arg1);
                    }
                }
                else 
                {
                    removeBest5KProperties(arg1);
                }
            }
            return;
        }

        public static function updateNewBest20MinPowerEntry(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*;
            if ((loc2 = arg1.entries.indexOf(arg2)) == -1) 
            {
                arg1.best20minPowerEntry = 0;
            }
            else 
            {
                loc1 = arg1.entries[loc2];
                if (!(loc3 = ActivityCalculator.calculateBest20MinPowerStartEntry(arg1)) || loc1.trainingTimeAbsolute < 120000) 
                {
                    arg1.best20minPowerEntry = 0;
                }
                else 
                {
                    arg1.best20minPowerEntry = loc2;
                }
            }
            return;
        }

        public static function removeBest5KProperties(arg1:*):void
        {
            arg1.best5KEntry = 0;
            arg1.best5KTime = 0;
            return;
        }

        public static function calculateAbsoluteValues(arg1:core.activities.Activity):void
        {
            var loc6:*=null;
            var loc2:*=null;
            var loc5:*=0;
            var loc3:*=arg1.entries.length;
            var loc7:*=0;
            var loc4:*=0;
            var loc1:*=0;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                (loc6 = arg1.entries[loc5]).number = loc5;
                if (loc2 == null) 
                {
                    loc6.trainingTime = 0;
                    loc6.trainingTimeAbsolute = 0;
                }
                else 
                {
                    loc6.trainingTimeAbsolute = loc2.trainingTimeAbsolute;
                }
                loc6.trainingTimeAbsolute = loc6.trainingTimeAbsolute + loc6.trainingTime;
                if (arg1.exerciseTimeDefined) 
                {
                    loc4 = loc4 + loc6.trainingTime;
                    if (arg1.trainingTime != arg1.exerciseTime) 
                    {
                        if (loc6.speedDefined && loc6.speed > 0) 
                        {
                            loc1 = loc1 + loc6.trainingTime;
                        }
                    }
                    else 
                    {
                        loc1 = loc1 + loc6.trainingTime;
                    }
                }
                else 
                {
                    loc1 = loc1 + loc6.trainingTime;
                }
                if (loc6.distanceAbsoluteDefined) 
                {
                    if (loc2 == null) 
                    {
                        loc6.distance = 0;
                        loc6.distanceAbsolute = 0;
                    }
                    else 
                    {
                        loc6.distanceAbsolute = loc2.distanceAbsolute;
                    }
                    loc6.distanceAbsolute = loc6.distanceAbsolute + loc6.distance;
                }
                loc2 = loc6;
                if (loc6.caloriesDefined && loc6.calories > 0) 
                {
                    loc7 = loc7 + loc6.calories;
                }
                ++loc5;
            }
            if (arg1.caloriesDefined) 
            {
                arg1.calories = loc7;
            }
            arg1.trainingTime = loc1;
            if (arg1.exerciseTimeDefined) 
            {
                arg1.exerciseTime = loc4;
            }
            if (loc6.distanceAbsoluteDefined && arg1.distanceDefined) 
            {
                arg1.distance = loc6.distanceAbsolute;
            }
            return;
        }

        public static function calculateFirstLastMarkerValues(arg1:core.activities.Activity, arg2:uint, arg3:uint):void
        {
            var loc25:*=null;
            var loc70:*=null;
            var loc65:*=0;
            var loc34:*=0;
            var loc43:*=null;
            var loc12:*=null;
            var loc13:*=false;
            var loc14:*=null;
            var loc18:*=null;
            var loc67:*=0;
            var loc73:*=0;
            var loc7:*=NaN;
            var loc20:*=NaN;
            var loc66:*=NaN;
            var loc49:*=NaN;
            var loc4:*=NaN;
            var loc56:*=NaN;
            var loc64:*=NaN;
            var loc51:*=NaN;
            var loc53:*=NaN;
            var loc16:*=NaN;
            var loc3:*=NaN;
            var loc57:*=NaN;
            var loc26:*=NaN;
            var loc60:*=NaN;
            var loc5:*=NaN;
            var loc39:*=NaN;
            var loc35:*=NaN;
            var loc30:*=0;
            var loc42:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc32:*=NaN;
            var loc31:*=NaN;
            var loc59:*=NaN;
            var loc61:*=NaN;
            var loc9:*=NaN;
            var loc74:*=NaN;
            var loc71:*=NaN;
            var loc2:*=NaN;
            var loc63:*=NaN;
            var loc62:*=0;
            var loc36:*=0;
            var loc19:*=0;
            var loc47:*=0;
            var loc33:*=false;
            var loc44:*=false;
            var loc52:*=false;
            var loc28:*=false;
            var loc72:*=NaN;
            var loc38:*=NaN;
            var loc17:*=false;
            var loc22:*=false;
            var loc41:*=false;
            var loc54:*=false;
            var loc24:*=NaN;
            var loc29:*=NaN;
            var loc69:*=NaN;
            var loc58:*=NaN;
            var loc46:*=NaN;
            var loc68:*=null;
            var loc37:*=arg1.entries;
            var loc1:*=arg1.markerList;
            var loc15:*;
            var loc40:*=(loc15 = arg1.unitType != null ? arg1.unitType.toString() : null) == core.general.UnitType.ROX100.toString();
            var loc23:*=loc15 == core.general.UnitType.RC1411.toString();
            var loc21:*=loc37[arg2];
            var loc48:*=loc37[arg3];
            var loc55:*=0;
            var loc8:*=0;
            var loc45:*=0;
            var loc50:*=0;
            loc55 = loc21.trainingTimeAbsolute;
            if (loc21.distanceAbsoluteDefined) 
            {
                loc8 = loc21.distanceAbsolute;
            }
            var loc6:*=0;
            var loc27:*=0;
            if (loc1 != null) 
            {
                loc65 = 0;
                loc34 = loc1.length;
                loc65 = 0;
                while (loc65 < loc34) 
                {
                    if ((loc43 = loc1[loc65]).type == "p") 
                    {
                        if (loc25 != null) 
                        {
                            if (loc43.timeAbsolute < loc25.timeAbsolute) 
                            {
                                loc25 = loc43;
                            }
                        }
                        else 
                        {
                            loc25 = loc43;
                        }
                        loc43.number = loc45;
                        ++loc45;
                    }
                    if (loc43.type == "l") 
                    {
                        if (loc70 != null) 
                        {
                            if (loc43.timeAbsolute < loc70.timeAbsolute) 
                            {
                                loc70 = loc43;
                            }
                        }
                        else 
                        {
                            loc70 = loc43;
                        }
                        loc43.number = loc50;
                        ++loc50;
                    }
                    ++loc65;
                }
                loc12 = getLastMarker(arg1, "l");
                loc13 = true;
                loc14 = configCache.ConfigCache.getInstance().getSportBaseValue(arg1.sport);
                if (loc12.isLastMarker == false) 
                {
                    if (loc14 == "distanceAbsolute" && loc12.distanceAbsoluteDefined) 
                    {
                        if (loc12.distanceAbsolute >= loc48.distanceAbsolute) 
                        {
                            loc12.isLastMarker = true;
                            loc13 = false;
                        }
                    }
                    else if (loc14 == "trainingTimeAbsolute" || !loc12.distanceAbsoluteDefined) 
                    {
                        if (loc12.timeAbsolute >= loc48.trainingTimeAbsolute) 
                        {
                            loc12.isLastMarker = true;
                            loc13 = false;
                        }
                    }
                    if (loc13) 
                    {
                        (loc12 = core.marker.MarkerFactory.createMarkerFromLog(arg1)).logReference = arg1;
                        loc12.type = "l";
                        loc12.isLastMarker = true;
                        loc12.calculateMarkerCalories = true;
                        loc12.timeAbsolute = loc48.trainingTimeAbsolute;
                        if (loc12.distanceAbsoluteDefined) 
                        {
                            loc12.distanceAbsolute = loc48.distanceAbsolute;
                        }
                        arg1.markerList.push(loc12);
                        loc12.number = (countLaps(arg1) - 1);
                    }
                }
                if (loc70 != null) 
                {
                    loc70.calculateMarkerCalories = true;
                }
                else 
                {
                    loc70 = loc12;
                }
                loc67 = 0;
                loc73 = 0;
                loc7 = 0;
                loc20 = 0;
                loc66 = 0;
                loc49 = 0;
                loc4 = 0;
                loc56 = 0;
                loc64 = 0;
                loc51 = 0;
                loc53 = 0;
                loc16 = 0;
                loc3 = 0;
                loc57 = 0;
                loc26 = 0;
                loc60 = 0;
                loc5 = 0;
                loc39 = 0;
                loc35 = 0;
                loc30 = 0;
                loc42 = 0;
                loc10 = 0;
                loc11 = 0;
                loc32 = 0;
                loc31 = 0;
                loc59 = 0;
                loc61 = 0;
                loc9 = 0;
                loc74 = 0;
                loc71 = 0;
                loc2 = 0;
                loc63 = 0;
                loc62 = 0;
                loc36 = 0;
                loc19 = 0;
                loc47 = 0;
                loc33 = true;
                loc44 = true;
                loc52 = !(loc25 == null);
                loc28 = true;
                loc72 = -1;
                loc38 = -1;
                loc65 = arg2;
                while (loc65 <= arg3) 
                {
                    loc18 = loc37[loc65];
                    ++loc67;
                    ++loc73;
                    if (loc18.heartrateDefined && loc70.minimumHeartrateDefined && loc70.maximumHeartrateDefined) 
                    {
                        loc17 = true;
                        if (loc23 && (loc18.heartrate == 0 || loc18.heartrate == 20)) 
                        {
                            loc17 = false;
                        }
                        if (loc28 && loc17) 
                        {
                            ++loc7;
                            if (loc53 != 0) 
                            {
                                loc70.minimumHeartrate = Math.min(loc70.minimumHeartrate, loc18.heartrate);
                                loc70.maximumHeartrate = Math.max(loc70.maximumHeartrate, loc18.heartrate);
                            }
                            else 
                            {
                                loc70.minimumHeartrate = loc18.heartrate;
                                loc70.maximumHeartrate = loc18.heartrate;
                            }
                            loc53 = loc53 + loc18.heartrate;
                        }
                        if (loc52 && loc17) 
                        {
                            ++loc20;
                            if (loc32 != 0) 
                            {
                                loc25.minimumHeartrate = Math.min(loc25.minimumHeartrate, loc18.heartrate);
                                loc25.maximumHeartrate = Math.max(loc25.maximumHeartrate, loc18.heartrate);
                            }
                            else 
                            {
                                loc25.minimumHeartrate = loc18.heartrate;
                                loc25.maximumHeartrate = loc18.heartrate;
                            }
                            loc32 = loc32 + loc18.heartrate;
                        }
                    }
                    if (loc18.speedDefined && loc70.minimumSpeedDefined && loc70.maximumSpeedDefined) 
                    {
                        loc22 = true;
                        if ((loc23 || loc40) && loc18.speed == 0) 
                        {
                            loc22 = false;
                        }
                        if (loc28 && loc22) 
                        {
                            ++loc66;
                            if (loc16 != 0) 
                            {
                                loc70.minimumSpeed = Math.min(loc70.minimumSpeed, loc18.speed);
                                loc70.maximumSpeed = Math.max(loc70.maximumSpeed, loc18.speed);
                            }
                            else 
                            {
                                loc70.minimumSpeed = loc18.speed;
                                loc70.maximumSpeed = loc18.speed;
                            }
                            loc16 = loc16 + loc18.speed;
                        }
                        if (loc52 && loc22) 
                        {
                            ++loc49;
                            if (loc31 != 0) 
                            {
                                loc25.minimumSpeed = Math.min(loc25.minimumSpeed, loc18.speed);
                                loc25.maximumSpeed = Math.max(loc25.maximumSpeed, loc18.speed);
                            }
                            else 
                            {
                                loc25.minimumSpeed = loc18.speed;
                                loc25.maximumSpeed = loc18.speed;
                            }
                            loc31 = loc31 + loc18.speed;
                        }
                    }
                    if (loc18.powerDefined && loc70.maximumPowerDefined) 
                    {
                        loc41 = true;
                        if (loc40 && loc18.power == 0) 
                        {
                            loc41 = false;
                        }
                        if (loc28 && loc41) 
                        {
                            ++loc64;
                            if (loc35 != 0) 
                            {
                                loc70.maximumPower = Math.max(loc70.maximumPower, loc18.power);
                            }
                            else 
                            {
                                loc70.maximumPower = loc18.power;
                            }
                            loc35 = loc35 + loc18.power;
                        }
                        if (loc52 && loc41) 
                        {
                            ++loc51;
                            if (loc63 != 0) 
                            {
                                loc25.maximumPower = Math.max(loc25.maximumPower, loc18.power);
                            }
                            else 
                            {
                                loc25.maximumPower = loc18.power;
                            }
                            loc63 = loc63 + loc18.power;
                        }
                    }
                    if (loc18.cadenceDefined && loc70.maximumCadenceDefined) 
                    {
                        loc54 = true;
                        if (loc40 && loc18.cadence == 0) 
                        {
                            loc54 = false;
                        }
                        if (loc28 && loc54) 
                        {
                            ++loc4;
                            if (loc39 != 0) 
                            {
                                loc70.maximumCadence = Math.max(loc70.maximumCadence, loc18.cadence);
                            }
                            else 
                            {
                                loc70.maximumCadence = loc18.cadence;
                            }
                            loc39 = loc39 + loc18.cadence;
                        }
                        if (loc52 && loc54) 
                        {
                            ++loc56;
                            if (loc2 != 0) 
                            {
                                loc25.maximumCadence = Math.max(loc25.maximumCadence, loc18.cadence);
                            }
                            else 
                            {
                                loc25.maximumCadence = loc18.cadence;
                            }
                            loc2 = loc2 + loc18.cadence;
                        }
                    }
                    if (loc18.altitudeDefined && loc70.maximumAltitudeDefined) 
                    {
                        if (loc28) 
                        {
                            loc5 = loc5 + loc18.altitude;
                            if (loc44) 
                            {
                                loc70.maximumAltitude = loc18.altitude;
                            }
                            else 
                            {
                                loc70.maximumAltitude = Math.max(loc70.maximumAltitude, loc18.altitude);
                            }
                        }
                        if (loc52) 
                        {
                            loc71 = loc71 + loc18.altitude;
                            if (loc33) 
                            {
                                loc25.maximumAltitude = loc18.altitude;
                            }
                            else 
                            {
                                loc25.maximumAltitude = Math.max(loc25.maximumAltitude, loc18.altitude);
                            }
                        }
                    }
                    if (loc18.inclineDefined && loc70.maximumInclineUphillDefined && loc70.maximumInclineDownhillDefined) 
                    {
                        if (loc18.incline > 0) 
                        {
                            if (loc28) 
                            {
                                ++loc30;
                                loc3 = loc3 + loc18.incline;
                                if (loc44) 
                                {
                                    loc70.maximumInclineUphill = loc18.incline;
                                }
                                else 
                                {
                                    loc70.maximumInclineUphill = Math.max(loc70.maximumInclineUphill, loc18.incline);
                                }
                            }
                            if (loc52) 
                            {
                                ++loc62;
                                loc59 = loc59 + loc18.incline;
                                if (loc33) 
                                {
                                    loc25.maximumInclineUphill = loc18.incline;
                                }
                                else 
                                {
                                    loc25.maximumInclineUphill = Math.max(loc25.maximumInclineUphill, loc18.incline);
                                }
                            }
                        }
                        else if (loc18.incline < 0) 
                        {
                            if (loc28) 
                            {
                                ++loc42;
                                loc57 = loc57 + loc18.incline;
                                if (loc44) 
                                {
                                    loc70.maximumInclineDownhill = loc18.incline;
                                }
                                else 
                                {
                                    loc70.maximumInclineDownhill = Math.min(loc70.maximumInclineDownhill, loc18.incline);
                                }
                            }
                            if (loc52) 
                            {
                                ++loc36;
                                loc61 = loc61 + loc18.incline;
                                if (loc33) 
                                {
                                    loc25.maximumInclineDownhill = loc18.incline;
                                }
                                else 
                                {
                                    loc25.maximumInclineDownhill = Math.min(loc25.maximumInclineDownhill, loc18.incline);
                                }
                            }
                        }
                    }
                    if (loc18.riseRateDefined && loc70.maximumRiseRateUphillDefined && loc70.maximumRiseRateDownhillDefined) 
                    {
                        if (loc18.riseRate > 0) 
                        {
                            if (loc28) 
                            {
                                ++loc10;
                                loc26 = loc26 + loc18.riseRate;
                                if (loc44) 
                                {
                                    loc70.maximumRiseRateUphill = loc18.riseRate;
                                }
                                else 
                                {
                                    loc70.maximumRiseRateUphill = Math.max(loc70.maximumRiseRateUphill, loc18.riseRate);
                                }
                            }
                            if (loc52) 
                            {
                                ++loc19;
                                loc9 = loc9 + loc18.riseRate;
                                if (loc33) 
                                {
                                    loc25.maximumRiseRateUphill = loc18.riseRate;
                                }
                                else 
                                {
                                    loc25.maximumRiseRateUphill = Math.max(loc25.maximumRiseRateUphill, loc18.riseRate);
                                }
                            }
                        }
                        else if (loc18.riseRate < 0) 
                        {
                            if (loc28) 
                            {
                                ++loc11;
                                loc60 = loc60 + loc18.riseRate;
                                if (loc44) 
                                {
                                    loc70.maximumRiseRateDownhill = loc18.riseRate;
                                }
                                else 
                                {
                                    loc70.maximumRiseRateDownhill = Math.min(loc70.maximumRiseRateDownhill, loc18.riseRate);
                                }
                            }
                            if (loc52) 
                            {
                                ++loc47;
                                loc74 = loc74 + loc18.riseRate;
                                if (loc33) 
                                {
                                    loc25.maximumRiseRateDownhill = loc18.riseRate;
                                }
                                else 
                                {
                                    loc25.maximumRiseRateDownhill = Math.min(loc25.maximumRiseRateDownhill, loc18.riseRate);
                                }
                            }
                        }
                    }
                    if (loc70.caloriesDefined && loc70.calculateMarkerCalories) 
                    {
                        if (loc18.caloriesDefined && loc18.calories > 0) 
                        {
                            loc24 = loc18.calories;
                        }
                        else 
                        {
                            loc24 = utils.Calculations.calculateCalories(arg1, loc18);
                        }
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.calories = 0;
                            }
                            else 
                            {
                                loc70.calories = loc70.calories + loc24;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.calories = 0;
                            }
                            else 
                            {
                                loc25.calories = loc25.calories + loc24;
                            }
                        }
                    }
                    if (loc18.distanceDefined && loc70.distanceDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.distance = 0;
                                loc72 = loc18.distance;
                            }
                            else 
                            {
                                loc70.distance = loc70.distance + loc18.distance;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.distance = 0;
                            }
                            else 
                            {
                                loc25.distance = loc25.distance + loc18.distance;
                            }
                        }
                    }
                    if (loc18.distanceUphillDefined && loc70.distanceUphillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.distanceUphill = 0;
                            }
                            else 
                            {
                                loc70.distanceUphill = loc70.distanceUphill + loc18.distanceUphill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.distanceUphill = 0;
                            }
                            else 
                            {
                                loc25.distanceUphill = loc25.distanceUphill + loc18.distanceUphill;
                            }
                        }
                    }
                    if (loc18.distanceDownhillDefined && loc70.distanceDownhillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.distanceDownhill = 0;
                            }
                            else 
                            {
                                loc70.distanceDownhill = loc70.distanceDownhill + loc18.distanceDownhill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.distanceDownhill = 0;
                            }
                            else 
                            {
                                loc25.distanceDownhill = loc25.distanceDownhill + loc18.distanceDownhill;
                            }
                        }
                    }
                    if (loc28) 
                    {
                        if (loc44) 
                        {
                            loc70.time = 0;
                            loc38 = loc18.trainingTime;
                        }
                        else 
                        {
                            loc70.time = loc70.time + loc18.trainingTime;
                        }
                    }
                    if (loc52) 
                    {
                        if (loc33) 
                        {
                            loc25.time = 0;
                        }
                        else 
                        {
                            loc25.time = loc25.time + loc18.trainingTime;
                        }
                    }
                    if (loc18.trainingTimeUphillDefined && loc70.timeUphillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.timeUphill = 0;
                            }
                            else 
                            {
                                loc70.timeUphill = loc70.timeUphill + loc18.trainingTimeUphill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.timeUphill = 0;
                            }
                            else 
                            {
                                loc25.timeUphill = loc25.timeUphill + loc18.trainingTimeUphill;
                            }
                        }
                    }
                    if (loc18.trainingTimeDownhillDefined && loc70.timeUphillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.timeDownhill = 0;
                            }
                            else 
                            {
                                loc70.timeDownhill = loc70.timeDownhill + loc18.trainingTimeDownhill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.timeDownhill = 0;
                            }
                            else 
                            {
                                loc25.timeDownhill = loc25.timeDownhill + loc18.trainingTimeDownhill;
                            }
                        }
                    }
                    if (loc18.altitudeDifferencesUphillDefined && loc70.altitudeUphillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.altitudeUphill = 0;
                            }
                            else 
                            {
                                loc70.altitudeUphill = loc70.altitudeUphill + loc18.altitudeDifferencesUphill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.altitudeUphill = 0;
                            }
                            else 
                            {
                                loc25.altitudeUphill = loc25.altitudeUphill + loc18.altitudeDifferencesUphill;
                            }
                        }
                    }
                    if (loc18.altitudeDifferencesDownhillDefined && loc70.altitudeDownhillDefined) 
                    {
                        if (loc28) 
                        {
                            if (loc44) 
                            {
                                loc70.altitudeDownhill = 0;
                            }
                            else 
                            {
                                loc70.altitudeDownhill = loc70.altitudeDownhill + loc18.altitudeDifferencesDownhill;
                            }
                        }
                        if (loc52) 
                        {
                            if (loc33) 
                            {
                                loc25.altitudeDownhill = 0;
                            }
                            else 
                            {
                                loc25.altitudeDownhill = loc25.altitudeDownhill + loc18.altitudeDifferencesDownhill;
                            }
                        }
                    }
                    loc33 = false;
                    loc44 = false;
                    if (loc52) 
                    {
                        if (loc18.trainingTimeAbsolute >= loc25.timeAbsolute) 
                        {
                            loc25.type = "p";
                            loc25.number = 0;
                            if (loc67 > 0) 
                            {
                                if (loc25.averageHeartrateDefined) 
                                {
                                    loc25.averageHeartrate = loc32 / loc20;
                                }
                                if (loc25.averageSpeedDefined) 
                                {
                                    loc25.averageSpeed = loc31 / loc49;
                                }
                                if (loc25.averageAltitudeDefined) 
                                {
                                    loc25.averageAltitude = loc71 / loc67;
                                }
                                if (loc25.averagePowerDefined) 
                                {
                                    loc25.averagePower = loc63 / loc51;
                                }
                                if (loc25.averageCadenceDefined) 
                                {
                                    loc25.averageCadence = loc2 / loc56;
                                }
                            }
                            if (loc62 > 0 && loc25.averageInclineUphillDefined) 
                            {
                                loc25.averageInclineUphill = loc59 / loc62;
                            }
                            if (loc36 > 0 && loc25.averageInclineDownhillDefined) 
                            {
                                loc25.averageInclineDownhill = loc61 / loc36;
                            }
                            if (loc19 > 0 && loc25.averageRiseRateUphillDefined) 
                            {
                                loc25.averageRiseRateUphill = loc9 / loc19;
                            }
                            if (loc47 > 0 && loc25.averageRiseRateDownhillDefined) 
                            {
                                loc25.averageRiseRateDownhill = loc74 / loc47;
                            }
                            if (loc25.latitudeDefined && loc18.latitudeDefined) 
                            {
                                loc25.latitude = loc18.latitude;
                            }
                            if (loc25.longitudeDefined && loc18.longitudeDefined) 
                            {
                                loc25.longitude = loc18.longitude;
                            }
                            loc52 = false;
                        }
                    }
                    if (loc28) 
                    {
                        if (loc18.trainingTimeAbsolute >= loc70.timeAbsolute || loc65 == arg3) 
                        {
                            if (loc73 > 0) 
                            {
                                if (loc70.averageHeartrateDefined) 
                                {
                                    loc70.averageHeartrate = loc53 / loc7;
                                }
                                if (loc70.averageSpeedDefined) 
                                {
                                    loc70.averageSpeed = loc16 / loc66;
                                }
                                if (loc70.averageAltitudeDefined) 
                                {
                                    loc70.averageAltitude = loc5 / loc73;
                                }
                                if (loc70.averagePowerDefined) 
                                {
                                    loc70.averagePower = loc35 / loc64;
                                }
                                if (loc70.averageCadenceDefined) 
                                {
                                    loc70.averageCadence = loc39 / loc4;
                                }
                            }
                            if (loc30 > 0 && loc70.averageInclineUphillDefined) 
                            {
                                loc70.averageInclineUphill = loc3 / loc30;
                            }
                            if (loc42 > 0 && loc70.averageInclineDownhillDefined) 
                            {
                                loc70.averageInclineDownhill = loc57 / loc42;
                            }
                            if (loc10 > 0 && loc70.averageRiseRateUphillDefined) 
                            {
                                loc70.averageRiseRateUphill = loc26 / loc10;
                            }
                            if (loc11 > 0 && loc70.averageRiseRateDownhillDefined) 
                            {
                                loc70.averageRiseRateDownhill = loc60 / loc11;
                            }
                            if (loc70.longitudeDefined && loc18.longitudeDefined) 
                            {
                                loc70.longitude = loc18.longitude;
                            }
                            if (loc70.latitudeDefined && loc18.latitudeDefined) 
                            {
                                loc70.latitude = loc18.latitude;
                            }
                            if (loc70 != loc12) 
                            {
                                if (loc13) 
                                {
                                    loc65 = getPrevLapAsEntryIndex(arg2, loc12, arg1);
                                }
                                else 
                                {
                                    loc65 = arg3;
                                }
                                loc70 = loc12;
                                loc53 = 0;
                                loc16 = 0;
                                loc3 = 0;
                                loc57 = 0;
                                loc26 = 0;
                                loc60 = 0;
                                loc5 = 0;
                                loc35 = 0;
                                loc39 = 0;
                                loc73 = 0;
                                loc30 = 0;
                                loc42 = 0;
                                loc10 = 0;
                                loc11 = 0;
                                loc7 = 0;
                                loc66 = 0;
                                loc64 = 0;
                                loc44 = true;
                            }
                            else 
                            {
                                loc28 = false;
                            }
                        }
                        if (!loc28 && !loc52) 
                        {
                            loc65 = arg3;
                        }
                    }
                    ++loc65;
                }
                loc29 = 0;
                loc69 = 0;
                loc58 = 0;
                loc46 = 0;
                loc65 = 0;
                while (loc65 < arg1.markerList.length) 
                {
                    loc68.timeAbsolute = (loc68 = loc1[loc65]).timeAbsolute - loc55;
                    loc68.timeAbsolute = loc68.timeAbsolute - loc68.timeAbsolute % 1;
                    if (loc68.distanceAbsoluteDefined) 
                    {
                        loc68.distanceAbsolute = loc68.distanceAbsolute - loc8;
                        loc68.distanceAbsolute = loc68.distanceAbsolute - loc68.distanceAbsolute % 1;
                    }
                    ++loc65;
                }
            }
            return;
        }

        internal static function calculateMarkerValues(arg1:core.activities.Activity, arg2:core.marker.Marker, arg3:int, arg4:int):core.marker.Marker
        {
            var loc16:*=null;
            var loc25:*=0;
            var loc30:*=arg1.entries;
            var loc7:*=0;
            var loc31:*=0;
            var loc10:*=0;
            var loc26:*=0;
            var loc21:*=0;
            var loc12:*=0;
            var loc17:*=0;
            var loc1:*=0;
            var loc13:*=0;
            var loc34:*=0;
            var loc11:*=0;
            var loc5:*=0;
            var loc3:*=0;
            var loc27:*=0;
            var loc18:*=0;
            var loc6:*=0;
            var loc24:*=0;
            var loc19:*=0;
            var loc4:*=true;
            var loc28:*=-1;
            var loc35:*=-1;
            var loc2:*=true;
            var loc29:*=true;
            var loc20:*=true;
            var loc8:*=true;
            var loc15:*=true;
            var loc32:*=true;
            var loc14:*=true;
            var loc22:*=true;
            var loc9:*=true;
            var loc33:*=true;
            var loc23:*=true;
            loc25 = arg3;
            while (loc25 <= arg4) 
            {
                loc16 = loc30[loc25];
                ++loc7;
                if (loc16.heartrateDefined) 
                {
                    loc2 = true;
                    loc29 = true;
                    if (arg1.unitType != core.general.UnitType.ROX100) 
                    {
                        if (loc16.heartrate <= 0 || loc16.heartrate == 20) 
                        {
                            loc2 = false;
                            loc29 = false;
                        }
                    }
                    else if (loc16.heartrate == 0) 
                    {
                        loc2 = false;
                    }
                    if (loc29) 
                    {
                        if (loc34 != 0) 
                        {
                            if (arg2.minimumHeartrateDefined) 
                            {
                                arg2.minimumHeartrate = Math.min(arg2.minimumHeartrate, loc16.heartrate);
                            }
                            if (arg2.maximumHeartrateDefined) 
                            {
                                arg2.maximumHeartrate = Math.max(arg2.maximumHeartrate, loc16.heartrate);
                            }
                        }
                        else 
                        {
                            if (arg2.minimumHeartrateDefined) 
                            {
                                arg2.minimumHeartrate = loc16.heartrate;
                            }
                            if (arg2.maximumHeartrateDefined) 
                            {
                                arg2.maximumHeartrate = loc16.heartrate;
                            }
                        }
                    }
                    if (loc2) 
                    {
                        ++loc31;
                        loc34 = loc34 + loc16.heartrate;
                    }
                }
                if (loc16.speedDefined) 
                {
                    loc20 = true;
                    loc8 = true;
                    if (arg1.unitType == core.general.UnitType.RC1411) 
                    {
                        if (loc16.speed == 0) 
                        {
                            loc20 = false;
                            loc8 = false;
                        }
                    }
                    if (arg1.unitType == core.general.UnitType.ROX100) 
                    {
                        if (loc16.speed == 0) 
                        {
                            loc20 = false;
                        }
                    }
                    if (loc8) 
                    {
                        if (loc11 != 0) 
                        {
                            if (arg2.minimumSpeedDefined) 
                            {
                                arg2.minimumSpeed = Math.min(arg2.minimumSpeed, loc16.speed);
                            }
                            if (arg2.maximumSpeedDefined) 
                            {
                                arg2.maximumSpeed = Math.max(arg2.maximumSpeed, loc16.speed);
                            }
                        }
                        else 
                        {
                            if (arg2.minimumSpeedDefined) 
                            {
                                arg2.minimumSpeed = loc16.speed;
                            }
                            if (arg2.maximumSpeedDefined) 
                            {
                                arg2.maximumSpeed = loc16.speed;
                            }
                        }
                    }
                    if (loc20) 
                    {
                        ++loc10;
                        loc11 = loc11 + loc16.speed;
                    }
                }
                if (loc16.powerDefined && arg2.maximumPowerDefined) 
                {
                    loc9 = true;
                    loc33 = true;
                    if (arg1.unitType == core.general.UnitType.ROX100) 
                    {
                        if (loc16.power == 0) 
                        {
                            loc9 = false;
                        }
                    }
                    if (loc33) 
                    {
                        if (loc19 != 0) 
                        {
                            arg2.maximumPower = Math.max(arg2.maximumPower, loc16.power);
                        }
                        else 
                        {
                            arg2.maximumPower = loc16.power;
                        }
                    }
                    if (loc9) 
                    {
                        ++loc13;
                        loc19 = loc19 + loc16.power;
                    }
                }
                if (loc16.cadenceDefined && arg2.maximumCadenceDefined) 
                {
                    loc14 = true;
                    loc22 = true;
                    if (arg1.unitType == core.general.UnitType.ROX100) 
                    {
                        if (loc16.cadence == 0) 
                        {
                            loc14 = false;
                        }
                    }
                    if (loc22) 
                    {
                        if (loc24 != 0) 
                        {
                            arg2.maximumCadence = Math.max(arg2.maximumCadence, loc16.cadence);
                        }
                        else 
                        {
                            arg2.maximumCadence = loc16.cadence;
                        }
                    }
                    if (loc14) 
                    {
                        ++loc26;
                        loc24 = loc24 + loc16.cadence;
                    }
                }
                if (loc16.altitudeDefined && arg2.maximumAltitudeDefined) 
                {
                    loc6 = loc6 + loc16.altitude;
                    if (loc4) 
                    {
                        arg2.maximumAltitude = loc16.altitude;
                    }
                    else 
                    {
                        arg2.maximumAltitude = Math.max(arg2.maximumAltitude, loc16.altitude);
                    }
                }
                if (loc16.inclineDefined && arg2.maximumInclineUphillDefined && arg2.maximumInclineDownhillDefined) 
                {
                    if (loc16.incline > 0) 
                    {
                        ++loc21;
                        loc5 = loc5 + loc16.incline;
                        if (loc4) 
                        {
                            arg2.maximumInclineUphill = loc16.incline;
                        }
                        else 
                        {
                            arg2.maximumInclineUphill = Math.max(arg2.maximumInclineUphill, loc16.incline);
                        }
                    }
                    else if (loc16.incline < 0) 
                    {
                        ++loc12;
                        loc3 = loc3 + loc16.incline;
                        if (loc4) 
                        {
                            arg2.maximumInclineDownhill = loc16.incline;
                        }
                        else 
                        {
                            arg2.maximumInclineDownhill = Math.min(arg2.maximumInclineDownhill, loc16.incline);
                        }
                    }
                }
                if (loc16.riseRateDefined && arg2.maximumRiseRateUphillDefined && arg2.maximumRiseRateDownhillDefined) 
                {
                    if (loc16.riseRate > 0) 
                    {
                        ++loc17;
                        loc27 = loc27 + loc16.riseRate;
                        if (loc4) 
                        {
                            arg2.maximumRiseRateUphill = loc16.riseRate;
                        }
                        else 
                        {
                            arg2.maximumRiseRateUphill = Math.max(arg2.maximumRiseRateUphill, loc16.riseRate);
                        }
                    }
                    else if (loc16.riseRate < 0) 
                    {
                        ++loc1;
                        loc18 = loc18 + loc16.riseRate;
                        if (loc4) 
                        {
                            arg2.maximumRiseRateDownhill = loc16.riseRate;
                        }
                        else 
                        {
                            arg2.maximumRiseRateDownhill = Math.min(arg2.maximumRiseRateDownhill, loc16.riseRate);
                        }
                    }
                }
                if (loc16.caloriesDefined && arg2.caloriesDefined) 
                {
                    if (loc4) 
                    {
                        arg2.calories = loc16.calories;
                    }
                    else 
                    {
                        arg2.calories = arg2.calories + loc16.calories;
                    }
                }
                if (loc16.distanceDefined && arg2.distanceDefined) 
                {
                    if (loc4) 
                    {
                        arg2.distance = 0;
                    }
                    arg2.distance = arg2.distance + loc16.distance;
                }
                if (loc16.distanceUphillDefined && arg2.distanceUphillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.distanceUphill = 0;
                    }
                    arg2.distanceUphill = arg2.distanceUphill + loc16.distanceUphill;
                }
                if (loc16.distanceDownhillDefined && arg2.distanceDownhillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.distanceDownhill = 0;
                    }
                    arg2.distanceDownhill = arg2.distanceDownhill + loc16.distanceDownhill;
                }
                if (loc4) 
                {
                    arg2.time = 0;
                }
                arg2.time = arg2.time + loc16.trainingTime;
                if (loc16.trainingTimeUphillDefined && arg2.timeUphillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.timeUphill = 0;
                    }
                    arg2.timeUphill = arg2.timeUphill + loc16.trainingTimeUphill;
                }
                if (loc16.trainingTimeDownhillDefined && arg2.timeDownhillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.timeDownhill = 0;
                    }
                    arg2.timeDownhill = arg2.timeDownhill + loc16.trainingTimeDownhill;
                }
                if (loc16.altitudeDifferencesUphillDefined && arg2.altitudeUphillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.altitudeUphill = 0;
                    }
                    arg2.altitudeUphill = arg2.altitudeUphill + loc16.altitudeDifferencesUphill;
                }
                if (loc16.altitudeDifferencesDownhillDefined && arg2.altitudeDownhillDefined) 
                {
                    if (loc4) 
                    {
                        arg2.altitudeDownhill = 0;
                    }
                    arg2.altitudeDownhill = arg2.altitudeDownhill + loc16.altitudeDifferencesDownhill;
                }
                loc4 = false;
                ++loc25;
            }
            if (arg2.averageHeartrateDefined && loc31 > 0) 
            {
                arg2.averageHeartrate = loc34 / loc31;
            }
            if (arg2.averageSpeedDefined && loc10 > 0) 
            {
                arg2.averageSpeed = loc11 / loc10;
            }
            if (arg2.averageAltitudeDefined && loc7 > 0) 
            {
                arg2.averageAltitude = loc6 / loc7;
            }
            if (arg2.averagePowerDefined && loc13 > 0) 
            {
                arg2.averagePower = loc19 / loc13;
            }
            if (arg2.averageCadenceDefined && loc26 > 0) 
            {
                arg2.averageCadence = loc24 / loc26;
            }
            if (loc21 > 0 && arg2.averageInclineUphillDefined) 
            {
                arg2.averageInclineUphill = loc5 / loc21;
            }
            if (loc12 > 0 && arg2.averageInclineDownhillDefined) 
            {
                arg2.averageInclineDownhill = loc3 / loc12;
            }
            if (loc17 > 0 && arg2.averageRiseRateUphillDefined) 
            {
                arg2.averageRiseRateUphill = loc27 / loc17;
            }
            if (loc1 > 0 && arg2.averageRiseRateDownhillDefined) 
            {
                arg2.averageRiseRateDownhill = loc18 / loc1;
            }
            if (arg2.latitudeDefined && loc16.latitudeDefined) 
            {
                arg2.latitude = loc16.latitude;
            }
            if (arg2.longitudeDefined && loc16.longitudeDefined) 
            {
                arg2.longitude = loc16.longitude;
            }
            return arg2;
        }

        internal static function onMarkerSaved(arg1:flash.events.Event):void
        {
            handler.ActivityHandlerCommon.getInstance().removeEventListener("activitySaveError", onMarkerError);
            handler.ActivityHandlerCommon.getInstance().removeEventListener("activityMarkerSaved", onMarkerSaved);
            handler.ActivityHandlerCommon.getInstance().dispatchLapAddedEvent();
            return;
        }

        internal static function onMarkerError(arg1:flash.events.Event):void
        {
            handler.ActivityHandlerCommon.getInstance().removeEventListener("activitySaveError", onMarkerError);
            handler.ActivityHandlerCommon.getInstance().removeEventListener("activityMarkerSaved", onMarkerSaved);
            return;
        }

        protected static const INTENSITY_ZONES_RECALCULATED:String="intensityZonesRecalculated";

        protected static const INTENSITY_ZONES_UPDATED:String="intensityZonesUpdated";

        protected static const MARKER_CALCULATION_COMPLETE:String="markerCalculationCompleteEvent";

        protected static const POWER_ZONES_RECALCULATED:String="powerZonesRecalculated";

        protected static const POWER_ZONES_UPDATED:String="powerZonesUpdated";

        internal static const _20Min:Number=120000;
    }
}


