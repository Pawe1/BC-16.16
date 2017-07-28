//class Calculations
package utils 
{
    import __AS3__.vec.*;
    import core.*;
    import core.activities.*;
    import core.route.*;
    import core.route.interfaces.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import utils.converter.*;
    
    public class Calculations extends Object
    {
        public function Calculations()
        {
            super();
            return;
        }

        public static function calculateCalories(arg1:Object, arg2:Object, arg3:String=null):Number
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc2:*=null;
            var loc7:*=0;
            var loc5:*=NaN;
            var loc8:*=null;
            var loc4:*=null;
            var loc6:*=0;
            if (arg2.heartrate == 0) 
            {
                return 0;
            }
            if (canCalculateCalories(arg1, arg2)) 
            {
                loc3 = arg2.heartrate;
                loc1 = arg1.hrMax;
                loc2 = arg1.gender;
                loc7 = arg1.age;
                loc5 = arg1.hasOwnProperty("bodyWeight") ? arg1.bodyWeight : arg1.weight;
                loc8 = arg1.hasOwnProperty("bodyWeightUnit") ? arg1.bodyWeightUnit : arg1.weightUnit;
                loc4 = new utils.converter.WeightConverter();
                if (arg3 != null) 
                {
                    loc4.inputFormat = arg3;
                    loc4.outputFormat = "g";
                    loc5 = loc4.convert(loc5);
                }
                loc4.inputFormat = "g";
                loc4.outputFormat = "kg";
                loc5 = loc4.convert(loc5);
                if (loc2 != "male") 
                {
                    loc6 = (-1.68 + 0.043 * loc3 - 0.105 * loc5 + 0.095 * loc7 + 0.00134 * loc3 * loc5 - 0.0011 * loc3) / 60;
                }
                else 
                {
                    loc6 = (-1.68 + 0.043 * loc3 - 0.105 * loc5 + 0.095 * loc7 + 10.84 + 0.00134 * loc3 * loc5 - 0.106 * loc3 - 0.0011 * loc3 * loc7 - 0.101 * loc5 - 0.107 * loc7 + 0.00119 * loc3 * loc5 + 0.0011 * loc3 * loc7) / 60;
                }
                if (loc6 < 0) 
                {
                    loc6 = 0;
                }
                loc6 = loc6 * arg2.trainingTime / 100;
                if (arg1.hasOwnProperty("caloriesDifferenceFactor") && loc6 > 0) 
                {
                    loc6 = loc6 - loc6 * arg1.caloriesDifferenceFactor;
                }
            }
            return loc6;
        }

        public static function calculateCaloriesDifferenceFactor(arg1:core.activities.Activity, arg2:Number, arg3:Number):void
        {
            if (arg1.caloriesDefined && arg1.caloriesDifferenceFactorDefined) 
            {
                if (arg1.caloriesDifferenceFactor == 0 && !(arg3 == 0)) 
                {
                    arg1.caloriesDifferenceFactor = (arg3 - arg2) / arg3;
                }
            }
            return;
        }

        public static function calculateCaloriesBasedOnSpeed(arg1:core.activities.Activity):void
        {
            var loc1:*=null;
            var loc6:*=NaN;
            var loc2:*=NaN;
            var loc5:*=0;
            var loc3:*=arg1.entries.length;
            var loc4:*=arg1.calories / loc3;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                loc1 = arg1.entries[loc5];
                loc1.calories = loc4;
                ++loc5;
            }
            return;
        }

        public static function calculateWeight(arg1:Number, arg2:Number):Number
        {
            return (210 - arg1 / 2 + 4 - arg2) / 0.11023;
        }

        public static function speedTimeMaximum():int
        {
            return core.MeasurementConfig.distanceFormat != "kilometer" ? 1980 : 1200;
        }

        public static function speedTimeFactor():Number
        {
            return core.MeasurementConfig.distanceFormat != "kilometer" ? 1.609344 : 1;
        }

        public static function calculateSpeedTime(arg1:Number):Number
        {
            var loc1:*=0;
            if (arg1 > 0) 
            {
                loc1 = Math.floor(1000 / arg1 * speedTimeFactor());
            }
            else 
            {
                loc1 = speedTimeMaximum();
            }
            if (loc1 > speedTimeMaximum()) 
            {
                loc1 = speedTimeMaximum();
            }
            return loc1;
        }

        public static function calculateSpeed(arg1:Number):Number
        {
            var loc1:*=0;
            if (arg1 > 0 && arg1 < speedTimeMaximum()) 
            {
                loc1 = 1000 * speedTimeFactor() / arg1;
            }
            else 
            {
                loc1 = 0;
            }
            return loc1;
        }

        public static function RDP(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:Number):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc7:*=NaN;
            var loc10:*=NaN;
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc11:*=undefined;
            var loc1:*=undefined;
            var loc2:*=undefined;
            var loc9:*=arg1[0];
            var loc8:*=arg1[(arg1.length - 1)];
            if (arg1.length < 3) 
            {
                return arg1;
            }
            var loc5:*=-1;
            var loc6:*=0;
            loc7 = 1;
            while (loc7 < (arg1.length - 1)) 
            {
                if ((loc10 = findPerpendicularDistance(arg1[loc7], loc9, loc8)) > loc6) 
                {
                    loc6 = loc10;
                    loc5 = loc7;
                }
                ++loc7;
            }
            if (loc6 > arg2) 
            {
                loc3 = arg1.slice(0, loc5 + 1);
                loc4 = arg1.slice(loc5);
                loc11 = RDP(loc3, arg2);
                loc1 = RDP(loc4, arg2);
                return loc2 = loc11.slice(0, (loc11.length - 1)).concat(loc1);
            }
            return new __AS3__.vec.Vector.<core.route.RoutePoint>(loc9, loc8);
            return null;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:Number):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc5:*=0;
            var loc11:*=0;
            var loc2:*=NaN;
            var loc9:*=null;
            var loc12:*=null;
            var loc4:*=null;
            var loc3:*=null;
            var loc8:*=new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc7:*;
            if ((loc7 = arg1.length) < 1) 
            {
                return null;
            }
            var loc10:*=0;
            var loc1:*=new __AS3__.vec.Vector.<Array>();
            var loc14:*=new Array(loc7);
            loc5 = 0;
            while (loc5 < loc7) 
            {
                loc14[loc5] = 0;
                ++loc5;
            }
            loc14[0] = 1;
            loc14[(loc7 - 1)] = 1;
            var loc6:*=0;
            if (loc7 > 2) 
            {
                loc12 = [0, (loc7 - 1)];
                loc1.push(loc12);
                while (loc1.length > 0) 
                {
                    loc9 = loc1.pop();
                    loc2 = 0;
                    loc11 = loc9[0] + 1;
                    while (loc11 < loc9[1]) 
                    {
                        if ((loc6 = distance(arg1[loc11], arg1[loc9[0]], arg1[loc9[1]])) > loc2) 
                        {
                            loc2 = loc6;
                            loc10 = loc11;
                        }
                        ++loc11;
                    }
                    if (!(loc2 > arg2)) 
                    {
                        continue;
                    }
                    loc14[loc10] = loc2;
                    loc4 = [loc9[0], loc10];
                    loc1.push(loc4);
                    loc3 = [loc10, loc9[1]];
                    loc1.push(loc3);
                }
            }
            loc5 = 0;
            loc11 = 0;
            var loc16:*=0;
            var loc15:*=arg1;
            for each (var loc13:* in loc15) 
            {
                if (loc14[loc11] != 0) 
                {
                    loc8.push(loc13);
                    ++loc5;
                }
                ++loc11;
            }
            return loc8;
        }

        public static function simplifyActivityEntries(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>, arg2:Number):__AS3__.vec.Vector.<core.activities.ActivityEntry>
        {
            var loc5:*=0;
            var loc11:*=0;
            var loc2:*=NaN;
            var loc9:*=null;
            var loc12:*=null;
            var loc4:*=null;
            var loc3:*=null;
            var loc8:*=new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            var loc7:*;
            if ((loc7 = arg1.length) < 1) 
            {
                return null;
            }
            var loc10:*=0;
            var loc1:*=new __AS3__.vec.Vector.<Array>();
            var loc14:*=new Array(loc7);
            loc5 = 0;
            while (loc5 < loc7) 
            {
                loc14[loc5] = 0;
                ++loc5;
            }
            loc14[0] = 1;
            loc14[(loc7 - 1)] = 1;
            var loc6:*=0;
            if (loc7 > 2) 
            {
                loc12 = [0, (loc7 - 1)];
                loc1.push(loc12);
                while (loc1.length > 0) 
                {
                    loc9 = loc1.pop();
                    loc2 = 0;
                    loc11 = loc9[0] + 1;
                    while (loc11 < loc9[1]) 
                    {
                        if ((loc6 = distanceActivityEntry(arg1[loc11], arg1[loc9[0]], arg1[loc9[1]])) > loc2) 
                        {
                            loc2 = loc6;
                            loc10 = loc11;
                        }
                        ++loc11;
                    }
                    if (!(loc2 > arg2)) 
                    {
                        continue;
                    }
                    loc14[loc10] = loc2;
                    loc4 = [loc9[0], loc10];
                    loc1.push(loc4);
                    loc3 = [loc10, loc9[1]];
                    loc1.push(loc3);
                }
            }
            loc5 = 0;
            loc11 = 0;
            var loc16:*=0;
            var loc15:*=arg1;
            for each (var loc13:* in loc15) 
            {
                if (loc14[loc11] != 0) 
                {
                    loc8.push(loc13);
                    ++loc5;
                }
                ++loc11;
            }
            return loc8;
        }

        public static function distanceBetweenRoutePoints(arg1:Object, arg2:Object):Number
        {
            var loc1:*=distanceBetweenGeoPositions(arg1.latitude, arg1.longitude, arg2.latitude, arg2.longitude);
            return loc1;
        }

        public static function distanceBetweenGeoPositions(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc5:*=degreesToRadians(arg3 - arg1);
            var loc4:*=degreesToRadians(arg4 - arg2);
            var loc1:*=Math.sin(loc5 / 2) * Math.sin(loc5 / 2) + Math.sin(loc4 / 2) * Math.sin(loc4 / 2) * Math.cos(degreesToRadians(arg1)) * Math.cos(degreesToRadians(arg3));
            var loc2:*=2 * Math.atan2(Math.sqrt(loc1), Math.sqrt(1 - loc1));
            var loc3:*;
            return loc3 = 6371 * loc2 * 1000;
        }

        public static function indexOfNearestRoutePoint(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:core.route.RoutePoint):int
        {
            var loc5:*=0;
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc6:*=-1;
            var loc4:*=arg1.length;
            loc5 = 0;
            while (loc5 < loc4) 
            {
                loc1 = arg1[loc5];
                loc2 = Calculations.distanceBetweenRoutePoints(arg2, loc1);
                if (isNaN(loc3) || loc2 < loc3) 
                {
                    loc3 = loc2;
                    loc6 = loc5;
                }
                ++loc5;
            }
            return loc6;
        }

        public static function degreesToRadians(arg1:Number):Number
        {
            return arg1 * 3.14159265359 / 180;
        }

        public static function calculateAge(arg1:Object):Number
        {
            var loc1:*=null;
            var loc4:*=NaN;
            var loc6:*=NaN;
            var loc5:*=NaN;
            var loc2:*=0;
            var loc3:*=new Date();
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                loc1 = (arg1 as core.settings.interfaces.IBirthDate).birthDate;
                loc4 = 0;
                loc6 = 0;
                loc4 = (loc5 = loc3.getTime() - loc1.getTime()) / 86400000;
                loc2 = Math.floor(loc4 / 365.24);
                if ((loc6 = Math.floor((loc4 - loc2 * 365.24) / 30.4375)) == 12) 
                {
                    loc6 = 11;
                }
            }
            else if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc2 = loc3.fullYear - (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            return loc2;
        }

        public static function calculateFitStartValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 70 / 100;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.7);
        }

        public static function calculateFitEndValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 7999 / 10000;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.8);
        }

        public static function calculateFatStartValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 55 / 100;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.55);
        }

        public static function calculateFatEndValue(arg1:core.settings.Settings):int
        {
            if (arg1 is core.settings.SettingsROX100) 
            {
                return (arg1 as core.settings.interfaces.IHRmax).hrMax * 6999 / 10000;
            }
            return Math.round((arg1 as core.settings.interfaces.IHRmax).hrMax * 0.7);
        }

        public static function calculateThreeZonesValues(arg1:core.settings.Settings):void
        {
            if (arg1 is core.settings.interfaces.IThreeZones && arg1 is core.settings.interfaces.IHRmax) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone1 = Math.round(55 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).startZone2 = Math.round(70 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).startZone3 = Math.round(80 * (arg1 as core.settings.interfaces.IHRmax).hrMax / 100);
                (arg1 as core.settings.interfaces.IThreeZones).endZone3 = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            return;
        }

        public static function calculateHRMax(arg1:core.settings.Settings):void
        {
            var loc3:*=NaN;
            var loc2:*=(arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            var loc1:*=(arg1 as core.settings.interfaces.IGender).gender;
            if (arg1 is core.settings.interfaces.IBirthDate || arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc3 = Calculations.calculateAge(arg1);
            }
            else if (arg1 is core.settings.interfaces.IAge) 
            {
                loc3 = (arg1 as core.settings.interfaces.IAge).age;
            }
            var loc4:*=loc1;
            while ("male" === loc4) 
            {
                (arg1 as core.settings.interfaces.IHRmax).hrMax = Math.round(210 - loc3 / 2 - 0.05 * loc2 / 1000 * 2.2046 + 4);
            }
        }

        internal static function canCalculateCalories(arg1:Object, arg2:Object):Boolean
        {
            return arg1.hasOwnProperty("hrMax") && arg1.hasOwnProperty("gender") && arg1.hasOwnProperty("age") && (arg1.hasOwnProperty("bodyWeight") || arg1.hasOwnProperty("weight")) && (arg1.hasOwnProperty("bodyWeightUnit") || arg1.hasOwnProperty("weightUnit")) && arg1.hasOwnProperty("samplingRate") && arg2.hasOwnProperty("heartrate");
        }

        internal static function findPerpendicularDistance(arg1:core.route.RoutePoint, arg2:core.route.RoutePoint, arg3:core.route.RoutePoint):Number
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc2:*=NaN;
            if (arg2.longitude != arg3.longitude) 
            {
                loc3 = (arg3.latitude - arg2.latitude) / (arg3.longitude - arg2.longitude);
                loc2 = arg2.latitude - loc3 * arg2.longitude;
                loc1 = Math.abs(loc3 * arg1.longitude - arg1.latitude + loc2) / Math.sqrt(Math.pow(loc3, 2) + 1);
            }
            else 
            {
                loc1 = Math.abs(arg1.longitude - arg2.longitude);
            }
            return loc1;
        }

        internal static function distance(arg1:core.route.interfaces.ILatLon, arg2:core.route.interfaces.ILatLon, arg3:core.route.interfaces.ILatLon):Number
        {
            if (arg2.equalsRoutePoint(arg3)) 
            {
                return distanceBetweenRoutePoints(arg3, arg1);
            }
            var loc8:*=arg1.latitude;
            var loc2:*=arg1.longitude;
            var loc7:*=arg2.latitude;
            var loc5:*=arg2.longitude;
            var loc6:*=arg3.latitude;
            var loc4:*=arg3.longitude;
            var loc3:*=loc6 - loc7;
            var loc1:*=loc4 - loc5;
            var loc11:*=((loc8 - loc7) * loc3 + (loc2 - loc5) * loc1) / (loc3 * loc3 + loc1 * loc1);
            var loc10:*=new core.route.RoutePoint();
            var loc9:*=new core.route.RoutePoint();
            if (loc11 <= 0) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc7;
                loc9.longitude = loc5;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            if (loc11 >= 1) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc6;
                loc9.longitude = loc4;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            loc10.latitude = loc8 - loc7;
            loc10.longitude = loc2 - loc5;
            loc9.latitude = loc11 * (loc6 - loc7);
            loc9.longitude = loc11 * (loc4 - loc5);
            return distanceBetweenRoutePoints(loc10, loc9);
        }

        internal static function distanceActivityEntry(arg1:core.activities.ActivityEntry, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):Number
        {
            if (arg2.equalsRoutePoint(arg3)) 
            {
                return distanceBetweenRoutePoints(arg3, arg1);
            }
            var loc8:*=arg1.latitude;
            var loc2:*=arg1.longitude;
            var loc7:*=arg2.latitude;
            var loc5:*=arg2.longitude;
            var loc6:*=arg3.latitude;
            var loc4:*=arg3.longitude;
            var loc3:*=loc6 - loc7;
            var loc1:*=loc4 - loc5;
            var loc11:*=((loc8 - loc7) * loc3 + (loc2 - loc5) * loc1) / (loc3 * loc3 + loc1 * loc1);
            var loc10:*=new core.route.RoutePoint();
            var loc9:*=new core.route.RoutePoint();
            if (loc11 <= 0) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc7;
                loc9.longitude = loc5;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            if (loc11 >= 1) 
            {
                loc10.latitude = loc8;
                loc10.longitude = loc2;
                loc9.latitude = loc6;
                loc9.longitude = loc4;
                return distanceBetweenRoutePoints(loc10, loc9);
            }
            loc10.latitude = loc8 - loc7;
            loc10.longitude = loc2 - loc5;
            loc9.latitude = loc11 * (loc6 - loc7);
            loc9.longitude = loc11 * (loc4 - loc5);
            return distanceBetweenRoutePoints(loc10, loc9);
        }
    }
}


