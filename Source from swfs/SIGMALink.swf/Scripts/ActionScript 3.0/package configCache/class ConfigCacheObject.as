//class ConfigCacheObject
package configCache 
{
    import core.general.*;
    import debug.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class ConfigCacheObject extends Object
    {
        public function ConfigCacheObject()
        {
            props = new flash.utils.Dictionary();
            super();
            props = new flash.utils.Dictionary();
            debug.Debug.debug(flash.system.Capabilities.language);
            props["language"] = core.general.LanguageSoftware.fromSystemLanguage();
            props["deviceButtonSelected"] = false;
            props["selectedSportIds"] = [];
            props["selectedUserIds"] = [];
            props["lastMapLocationLat"] = 6452966.80074;
            props["lastMapLocationLon"] = 1034446.19017;
            props["lastMapZoom"] = 5;
            props["lastSyncDate"] = 0;
            props["accessToken"] = "";
            props["autoSync"] = true;
            props["filters"] = [];
            props["preferredRoutingType"] = "racing";
            return;
        }

        public static function toSharedObject(arg1:configCache.ConfigCacheObject):Object
        {
            var loc2:*=undefined;
            var loc1:*={};
            var loc4:*=0;
            var loc3:*=arg1.props;
            for (loc2 in loc3) 
            {
                loc1[loc2] = arg1.props[loc2];
            }
            return loc1;
        }

        public function deviceButtonInitalSelected():Boolean
        {
            return props["deviceButtonSelected"];
        }

        public function selectedSportIds():Array
        {
            return props["selectedSportIds"];
        }

        public function selectedUserIds():Array
        {
            return props["selectedUserIds"];
        }

        public function lastMapLocationLat():Number
        {
            return props["lastMapLocationLat"];
        }

        public function lastMapLocationLon():Number
        {
            return props["lastMapLocationLon"];
        }

        public function lastMapZoom():Number
        {
            return props["lastMapZoom"];
        }

        public function lastSyncDate():Number
        {
            return props["lastSyncDate"];
        }

        public function accessToken():String
        {
            return props["accessToken"];
        }

        public function autoSync():Boolean
        {
            return props["autoSync"];
        }

        public function filters():Array
        {
            return props["filters"];
        }

        public function preferredRoutingType():String
        {
            return props["preferredRoutingType"];
        }

        public function setProperty(arg1:*, arg2:*):void
        {
            props[arg1] = arg2;
            return;
        }

        public function getProperty(arg1:*):*
        {
            return props[arg1];
        }

        public function hasProperty(arg1:*):Boolean
        {
            return !(props[arg1] == null);
        }

        public static function getInstance():configCache.ConfigCacheObject
        {
            if (!_instance) 
            {
                _instance = new ConfigCacheObject();
            }
            return _instance;
        }

        public static function fromSharedObject(arg1:Object):configCache.ConfigCacheObject
        {
            var loc1:*=undefined;
            var loc2:*=getInstance();
            var loc4:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                loc2.setProperty(loc1, arg1[loc1]);
            }
            return loc2;
        }

        public static const ALPHA_2:String="logCompareAlpha2";

        public static const ALTITUDE:String="logChartAltitude";

        public static const AUTO_LAPS:String="logChartAutoLaps";

        public static const AVG_ALTITUDE:String="logChartAverageAltitude";

        public static const AVG_BALANCE:String="logChartAverageBalance";

        public static const AVG_CADENCE:String="logChartAverageCadence";

        public static const AVG_HEARTRATE:String="logChartAverageHeartrate";

        public static const AVG_POWER:String="logChartAveragePower";

        public static const AVG_SPEED:String="logChartAverageSpeed";

        public static const AVG_TEMPERATURE:String="logChartAverageTemperature";

        public static const BALANCE:String="logChartBalance";

        public static const BEST_20MIN_POWER:String="logChartBest20MinPower";

        public static const BEST_5K_TIME:String="logChartBest5KTime";

        public static const BREAKS:String="logChartPause";

        public static const CADENCE:String="logChartCadence";

        public static const CALENDAR_STATE:String="calendarState";

        public static const CLOUD_ACCESS_TOKEN:String="accessToken";

        public static const CLOUD_AUTO_SYNC:String="autoSync";

        public static const CLOUD_SYNC_WIFI_ONLY:String="wifiSyncOnly";

        public static const DASHBOARD_STATISTIC_SELECTED_TIME:String="dashboardStatisticTime";

        public static const DASHBOARD_STATISTIC_SELECTED_VALUE:String="dashboardStatisticValue";

        public static const DEVICE_BUTTON_SELECTED:String="deviceButtonSelected";

        public static const DEVICE_POINT_NAVIGATION_SORT_ASCENDING:String="SortAscending";

        public static const DEVICE_POINT_NAVIGATION_SORT_FIELD:String="devicePointNavigationSortField";

        public static const DEVICE_SETTINGS_SORT_ASCENDING:String="SortAscending";

        public static const DEVICE_SETTINGS_SORT_FIELD:String="deviceSettingsSortField";

        public static const DEVICE_SPORTPROFILES_SORT_ASCENDING:String="deviceSportprofilesSortAscending";

        public static const DEVICE_SPORTPROFILES_SORT_FIELD:String="deviceSportprofilesSortField";

        public static const DEVICE_TRAININGS_SORT_ASCENDING:String="SortAscending";

        public static const DEVICE_TRAININGS_SORT_FIELD:String="deviceSettingsSortField";

        public static const FILTERS:String="filters";

        public static const GPSIES_SORT_ASCENDING:String="GPSIESSortAscending";

        public static const GPSIES_SORT_FIELD:String="GPSIESSortField";

        public static const HEARTRATE:String="logChartHeartrate";

        public static const HR_ZONES:String="logChartHeartrateZones";

        public static const INCLINE:String="logChartIncline";

        public static const INITIAL_APP_START:String="initialAppStart";

        public static const INTENSITY_ZONES:String="logChartIntensityZones";

        public static const INTERVAL:String="logChartInterval";

        public static const LAPS:String="logChartLaps";

        public static const LAST_MAP_LOCATION_LAT:String="lastMapLocationLat";

        public static const LAST_MAP_LOCATION_LON:String="lastMapLocationLon";

        public static const LAST_MAP_ZOOM:String="lastMapZoom";

        public static const LAST_SYNC_DATE:String="lastSyncDate";

        public static const LEFT_AXIS_RENDERER:String="leftAxisRenderer";

        public static const MARKER:String="logChartMarker";

        public static const MARKER_ZONES:String="logChartMarkerZones";

        public static const NOT_DEFINED:String="not_defined";

        public static const PHASE:String="logChartPhase";

        public static const POWER:String="logChartPower";

        public static const POWER_NP:String="logChartPowerNP";

        public static const POWER_ZONES:String="logChartPowerZones";

        public static const PREFERRED_ROUTING_TYPE:String="preferredRoutingType";

        public static const RECALCULATIONVALUES_PRINT:String="recalculationValues_print";

        public static const RENDERER_ALTITUDE_LEFT:String="renderer_altitude";

        public static const RENDERER_ALTITUDE_RIGHT:String="renderer_altitude_right";

        public static const RENDERER_BALANCE_LEFT:String="renderer_balance";

        public static const RENDERER_BALANCE_RIGHT:String="renderer_balance_right";

        public static const RENDERER_CADENCE_LEFT:String="renderer_cadence";

        public static const RENDERER_CADENCE_RIGHT:String="renderer_cadence_right";

        public static const RENDERER_HEARTRATE_LEFT:String="renderer_heartrate";

        public static const RENDERER_HEARTRATE_RIGHT:String="renderer_heartrate_right";

        public static const RENDERER_INCLINE_LEFT:String="renderer_incline";

        public static const RENDERER_INCLINE_RIGHT:String="renderer_incline_right";

        public static const RENDERER_POWER_LEFT:String="renderer_power";

        public static const RENDERER_POWER_RIGHT:String="renderer_power_right";

        public static const RENDERER_RISE_RATE_LEFT:String="renderer_riseRate";

        public static const RENDERER_RISE_RATE_RIGHT:String="renderer_riseRate_right";

        public static const RENDERER_SPEED_LEFT:String="renderer_speed";

        public static const RENDERER_SPEED_RIGHT:String="renderer_speed_right";

        public static const RENDERER_SPEED_TIME_RIGHT:String="renderer_speed_time_right";

        public static const RENDERER_TEMPERATURE_LEFT:String="renderer_temperature";

        public static const RENDERER_TEMPERATURE_RIGHT:String="renderer_temperature_right";

        public static const RIGHT_AXIS_RENDERER:String="rightAxisRenderer";

        public static const RISE_RATE:String="logChartRiseRate";

        public static const SELECTED_SPORT_IDS:String="selectedSportIds";

        public static const SELECTED_USER_IDS:String="selectedUserIds";

        public static const SOFTWARE_LANGUAGE:String="language";

        public static const SPEED:String="logChartSpeed";

        public static const SPEED_TIME:String="logChartTimeSpeed";

        public static const STATISTIC_SELECTED_TAB:String="statisticSelectedTab";

        public static const STATISTIC_SELECTED_YEAR:String="statisticSelectedYear";

        public static const TARGET_ZONE:String="logChartTrainingZone";

        public static const RENDERER_SPEED_TIME_LEFT:String="renderer_speed_time";

        public static const TRACKS_SORT_ASCENDING:String="TracksSortAscending";

        public static const TRACKS_SORT_FIELD:String="tracksSortField";

        public static const TRACK_AUTO_LAPS:String="logTrackAutoLaps";

        public static const TRACK_BEST_20MIN_POWER:String="logTrackBest20MinPower";

        public static const TRACK_BEST_5K_TIME:String="logTrackBest5KTime";

        public static const TRACK_BREAKS:String="logTrackPause";

        public static const TRACK_INTERVAL:String="logTrackInterval";

        public static const TRACK_LAPS:String="logTrackLaps";

        public static const TRACK_PHASE:String="logTrackPhase";

        public static const VALUES_MODULE_SELECTED_TAB:String="valuesModuleSelectedTab";

        public static const AGPS_LAST_SYNC_DATE:String="agpsLastSyncDate";

        public static const ALPHA_1:String="logCompareAlpha1";

        public static const TEMPERATURE:String="logChartTemperature";

        internal static var _instance:configCache.ConfigCacheObject;

        public var props:flash.utils.Dictionary;
    }
}


