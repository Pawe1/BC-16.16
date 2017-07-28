//class ActivityTCXMapper
package core.tcx 
{
    import __AS3__.vec.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.sport.*;
    import flash.desktop.*;
    import handler.*;
    import utils.*;
    
    public class ActivityTCXMapper extends Object
    {
        public function ActivityTCXMapper()
        {
            super();
            return;
        }

        internal static function mapSportToTCX(arg1:core.sport.Sport):String
        {
            if ("bmx" == arg1.keyName || "cyclecross" == arg1.keyName || "cycling" == arg1.keyName || "ebike" == arg1.keyName || "enduro" == arg1.keyName || "indoor_cycling" == arg1.keyName || "mountainbike" == arg1.keyName || "racing_bycicle" == arg1.keyName) 
            {
                return "Biking";
            }
            if ("activityTracker" == arg1.keyName || "fitness" == arg1.keyName || "hiking" == arg1.keyName || "running" == arg1.keyName || "treadmill" == arg1.keyName || "walking" == arg1.keyName) 
            {
                return "Running";
            }
            return "Other";
        }

        public static function formatDate(arg1:Date):String
        {
            var loc1:*=new utils.ISO8601Util();
            var loc2:*=loc1.formatExtendedDateTime(arg1);
            return loc2;
        }

        public static function fromTCX(arg1:XML, arg2:core.activities.Activity, arg3:*):core.activities.Activity
        {
            var loc24:*=null;
            var loc16:*=null;
            var loc30:*=null;
            var loc1:*=null;
            var loc17:*=null;
            var loc11:*=null;
            var loc40:*=null;
            var loc31:*=null;
            var loc9:*=NaN;
            var loc36:*=NaN;
            var loc28:*=null;
            var loc21:*=null;
            var loc39:*=arg1.namespaceDeclarations();
            var loc33:*=new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            var loc18:*=0;
            var loc5:*=0;
            var loc38:*=false;
            var loc12:*=0;
            var loc34:*=0;
            var loc26:*=0;
            var loc14:*=0;
            var loc22:*=false;
            var loc7:*=0;
            var loc19:*=new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc23:*=0;
            var loc27:*=0;
            var loc41:*=0;
            var loc2:*=0;
            var loc25:*=false;
            var loc29:*=false;
            var loc10:*=false;
            var loc32:*=false;
            var loc35:*=false;
            var loc8:*=0;
            var loc37:*=1000;
            var loc20:*=100;
        }

        internal static function validateXmlDate(arg1:String):Date
        {
            arg1 = arg1.replace(new RegExp("-", "g"), "/");
            arg1 = arg1.replace("T", " ");
            arg1 = arg1.replace("Z", " GMT-0000");
            return new Date(Date.parse(arg1));
        }

        internal static function sportFromString(arg1:String):core.sport.Sport
        {
            arg1 = arg1.toUpperCase();
            var loc1:*=arg1;
            while ("RUNNING" === loc1) 
            {
                break;
            }
            return null;
        }

        internal static function sortByTimeAbsolute(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            if (arg1.timeAbsolute.valueOf() < arg2.timeAbsolute.valueOf()) 
            {
                return -1;
            }
            if (arg1.timeAbsolute.valueOf() > arg2.timeAbsolute.valueOf()) 
            {
                return 1;
            }
            return 0;
        }

        internal static function appendActivtyEntries(arg1:XML, arg2:uint, arg3:Number, arg4:Number):uint
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc5:*=0;
            var loc2:*;
            var loc6:*=(loc2 = sourceActivity.entries).length;
            var loc4:*=0;
            loc5 = arg2;
            while (loc5 < loc6) 
            {
                if ((loc1 = loc2[loc5]).trainingTimeAbsolute > arg3) 
                {
                    break;
                }
                loc3 = new XML("<Trackpoint/>");
                arg1.Track.appendChild(loc3);
                loc3.Time = formatDate(new Date(sourceActivity.startDate.time + (loc1.trainingTimeAbsolute + arg4) * 10));
                if (loc1.latitudeDefined) 
                {
                    loc3.Position.LatitudeDegrees = loc1.latitude;
                    loc3.Position.LongitudeDegrees = loc1.longitude;
                }
                if (loc1.altitudeDefined) 
                {
                    loc3.AltitudeMeters = loc1.altitude * 0.001;
                }
                if (loc1.distanceDefined) 
                {
                    loc3.DistanceMeters = loc1.distanceAbsolute;
                }
                if (loc1.heartrateDefined && loc1.heartrate > 0) 
                {
                    loc3.HeartRateBpm.Value = Math.round(loc1.heartrate);
                    loc3.HeartRateBpm.@nameSpace_xsi::type = "HeartRateInBeatsPerMinute_t";
                }
                if (loc1.cadenceDefined) 
                {
                    loc3.Cadence = Math.round(loc1.cadence);
                }
                if (loc1.speedDefined && loc1.speed > 0) 
                {
                    loc3.Extensions.nameSpace_extv2::TPX.nameSpace_extv2::Speed = loc1.speed;
                }
                if (loc1.stepsDefined) 
                {
                    loc3.Extensions.nameSpace_extv2::TPX.nameSpace_extv2::RunCadence = loc1.steps;
                    stepsPerLap = stepsPerLap + loc1.steps;
                    stepsMaxPerMin = Math.max(stepsMaxPerMin, loc1.steps);
                    ++entriesPerLap;
                }
                if (loc1.powerDefined) 
                {
                    loc3.Extensions.nameSpace_extv2::TPX.nameSpace_extv2::Watts = Math.round(loc1.power);
                }
                ++loc5;
            }
            return loc5;
        }

        internal static function appendMarker(arg1:XML, arg2:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            var loc9:*=null;
            var loc12:*=0;
            var loc11:*=arg2.length;
            var loc3:*=new XML("<Lap><Track/></Lap>");
            var loc8:*=0;
            var loc2:*=0;
            var loc10:*=0;
            var loc1:*=0;
            var loc4:*;
            var loc6:*=(loc4 = sourceActivity.entries).length;
            var loc5:*=0;
            var loc7:*=handler.ActivityCalculator.getLastMarker(sourceActivity, "l");
            loc12 = 0;
            while (loc12 < loc11) 
            {
                if ((loc9 = arg2[loc12]).type != "p") 
                {
                    loc1 = appendActivtyEntries(loc3, loc1, loc9.timeAbsolute, loc5);
                    loc3.@StartTime = formatDate(new Date(sourceActivity.startDate.time + loc8 * 10 + loc5 * 10));
                    stepsPerLap = 0;
                    entriesPerLap = 0;
                    stepsMaxPerMin = 0;
                    loc3.TotalTimeSeconds = (loc9.timeAbsolute - loc8 + loc5) * 0.01;
                    loc5 = 0;
                    loc3.DistanceMeters = loc9.distanceAbsolute - loc10;
                    if (loc9.maximumSpeedDefined) 
                    {
                        loc3.MaximumSpeed = loc9.maximumSpeed;
                    }
                    if (loc9.caloriesDefined) 
                    {
                        loc3.Calories = loc9.calories;
                    }
                    else 
                    {
                        loc3.Calories = 0;
                    }
                    if (loc9.averageHeartrateDefined && loc9.averageHeartrate > 0) 
                    {
                        loc3.AverageHeartRateBpm.Value = loc9.averageHeartrate;
                        loc3.AverageHeartRateBpm.@nameSpace_xsi::type = "HeartRateInBeatsPerMinute_t";
                    }
                    if (loc9.maximumHeartrateDefined && loc9.maximumHeartrate > 0) 
                    {
                        loc3.MaximumHeartRateBpm.Value = loc9.maximumHeartrate;
                        loc3.MaximumHeartRateBpm.@nameSpace_xsi::type = "HeartRateInBeatsPerMinute_t";
                    }
                    loc3.Intensity = "Active";
                    if (loc9.averageCadenceDefined) 
                    {
                        loc3.Cadence = loc9.averageCadenceOutputString;
                    }
                    loc3.TriggerMethod = "Manual";
                    loc3.Notes = loc9.description;
                    if (loc9.averageSpeedDefined && loc9.averageSpeed > 0) 
                    {
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::AvgSpeed = loc9.averageSpeed;
                    }
                    if (loc9.maximumCadenceDefined) 
                    {
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::MaxBikeCadence = loc9.maximumCadence;
                    }
                    if (sourceActivity.entries.length > 0 && sourceActivity.entries[0].stepsDefined) 
                    {
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::AvgRunCadence = stepsPerLap / entriesPerLap;
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::MaxRunCadence = stepsMaxPerMin;
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::Steps = stepsPerLap;
                    }
                    if (loc9.averagePowerDefined) 
                    {
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::AvgWatts = loc9.averagePower;
                    }
                    if (loc9.maximumPowerDefined) 
                    {
                        loc3.Extensions.nameSpace_extv2::LX.nameSpace_extv2::MaxWatts = loc9.maximumPower;
                    }
                    arg1.appendChild(loc3);
                    loc3 = new XML("<Lap><Track/></Lap>");
                    loc8 = loc9.timeAbsolute;
                    loc10 = loc9.distanceAbsolute;
                }
                else 
                {
                    loc1 = appendActivtyEntries(loc3, loc1, loc9.timeAbsolute, loc5);
                    if (calculateWithBreakes) 
                    {
                        loc5 = loc5 + loc9.duration;
                    }
                }
                ++loc12;
            }
            return;
        }

        public static function generateXML(arg1:core.activities.Activity, arg2:Boolean=true):XML
        {
            var loc12:*=null;
            var loc1:*=null;
            sourceActivity = arg1;
            var loc5:*=new XML("<TrainingCenterDatabase xmlns=\"http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2\" xmlns:extv2=\"http://www.garmin.com/xmlschemas/ActivityExtension/v2\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.garmin.com/xmlschemas/ActivityExtension/v1 http://www.garmin.com/xmlschemas/ActivityExtensionv1.xsd http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd\"/>");
            var loc10:*=new XML("<Activities/>");
            var loc11:*=new XML("<Activity/>");
            var loc8:*=new XML("<Id>" + formatDate(arg1.startDate) + "</Id>");
            nameSpace_xsi = loc5.namespace("xsi");
            nameSpace_extv2 = loc5.namespace("extv2");
            loc5.appendChild(loc10);
            loc11.appendChild(loc8);
            loc10.appendChild(loc11);
            calculateWithBreakes = core.general.UnitType.ROX100.equals(sourceActivity.unitType);
            if (arg1.markerList.length != 0) 
            {
                appendMarker(loc11, arg1.markerList.concat().sort(sortByTimeAbsolute));
            }
            else 
            {
                loc12 = core.marker.MarkerFactory.createMarkerFromLog(arg1);
                var loc7:*=new __AS3__.vec.Vector.<core.marker.Marker>();
                loc12.timeAbsolute = arg1.trainingTime;
                loc12.distanceAbsolute = arg1.distance;
                if (arg1.maximumSpeedDefined) 
                {
                    loc12.maximumSpeed = arg1.maximumSpeed;
                }
                if (arg1.caloriesDefined) 
                {
                    loc12.calories = arg1.calories;
                }
                if (arg1.averageHeartrateDefined) 
                {
                    loc12.averageHeartrate = arg1.averageHeartrate;
                }
                if (arg1.maximumHeartrateDefined) 
                {
                    loc12.maximumHeartrate = arg1.maximumHeartrate;
                }
                if (arg1.averageCadenceDefined) 
                {
                    loc12.averageCadence = arg1.averageCadence;
                }
                if (arg1.descriptionDefined) 
                {
                    loc12.description = arg1.description;
                }
                loc7.push(loc12);
                appendMarker(loc11, loc7);
            }
            loc11.@Sport = mapSportToTCX(arg1.sport);
            if (sourceActivity.unitType != null) 
            {
                loc1 = core.general.UnitType.formatUnit(sourceActivity.unitType);
                loc11.Creator.Name = loc1 ? loc1 : sourceActivity.unitType.data;
                loc11.Creator.@nameSpace_xsi::type = "Device_t";
                loc11.Creator.UnitId = 4294967295;
                loc11.Creator.ProductID = 65535;
                loc11.Creator.Version.VersionMajor = 0;
                loc11.Creator.Version.VersionMinor = 0;
            }
            var loc4:*=new XML("<Author/>");
            var loc9:*;
            var loc2:*=(loc9 = flash.desktop.NativeApplication.nativeApplication.applicationDescriptor).namespace();
            var loc6:*=loc9.loc2::versionNumber.toString().split(".");
            var loc3:*=loc9.loc2::name;
            loc5.appendChild(loc4);
            loc4.@nameSpace_xsi::type = "Application_t";
            loc4.Name = loc3;
            loc4.Build.Version.VersionMajor = loc6[0];
            loc4.Build.Version.VersionMinor = loc6[1] + "" + loc6[2];
            loc4.Build.Version.BuildMajor = 0;
            loc4.Build.Version.BuildMinor = 0;
            loc4.Build.Type = "Release";
            loc4.Build.Time = "Sep 1 2015, 14:19:54";
            loc4.LangID = core.MeasurementConfig.language.substr(0, 2).toUpperCase();
            loc4.PartNumber = "XXX-XXXXX-XX";
            return loc5;
        }

        public static const CONFIG_CACHE_VAR_TCX_IMPORT_ENABLED:String="tcxImportEnabled";

        internal static var calculateWithBreakes:Boolean;

        internal static var entriesPerLap:uint;

        internal static var nameSpace_extv2:Namespace;

        internal static var nameSpace_xsi:Namespace;

        internal static var sourceActivity:core.activities.Activity;

        internal static var stepsMaxPerMin:uint;

        internal static var stepsPerLap:uint;
    }
}


