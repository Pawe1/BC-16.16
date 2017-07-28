//package configCache
//  class ConfigCache
package configCache 
{
    import com.logging.*;
    import core.filter.*;
    import core.sport.*;
    import flash.events.*;
    
    public dynamic class ConfigCache extends flash.events.EventDispatcher
    {
        public function ConfigCache()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function setValue(arg1:String, arg2:*):void
        {
            if (arg2 == null) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "ConfigCache > setValue: " + arg1 + " is null"));
            }
            configCacheObject.setProperty(arg1, arg2);
            saveCache();
            return;
        }

        public function saveFilter(arg1:core.filter.Filter, arg2:Boolean=false):void
        {
            var loc4:*=0;
            var loc3:*=null;
            var loc6:*=configCacheObject.filters();
            var loc1:*=-1;
            var loc5:*=false;
            var loc2:*=loc6.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                if ((loc3 = loc6[loc4]).GUID == arg1.GUID) 
                {
                    loc1 = loc4;
                    loc6[loc4] = core.filter.Filter.toSharedObject(arg1);
                    loc5 = true;
                    break;
                }
                ++loc4;
            }
            if (arg2) 
            {
                loc6.splice(loc1, 1);
            }
            else if (!loc5) 
            {
                loc6.push(core.filter.Filter.toSharedObject(arg1));
            }
            configCacheObject.setProperty("filters", loc6);
            saveCache();
            return;
        }

        public static function getInstance():configCache.ConfigCache
        {
            if (_configCacheInstance == null) 
            {
                _configCacheInstance = new ConfigCache();
            }
            return _configCacheInstance;
        }

        public function get configCacheObject():configCache.ConfigCacheObject
        {
            if (_configCacheObject == null) 
            {
                _configCacheObject = configCache.ConfigCacheObject.getInstance();
            }
            return configCache.ConfigCacheObject.getInstance();
        }

        public function set configCacheObject(arg1:configCache.ConfigCacheObject):void
        {
            _configCacheObject = arg1;
            return;
        }

        public static function getSyncDateCorrection():Number
        {
            return 86400000;
        }

        public function loadCache():void
        {
            try 
            {
                if (_configCachePersistenceManager == null) 
                {
                    _configCachePersistenceManager = new configCache.ConfigPersistenceManager();
                }
                if (_configCachePersistenceManager.load()) 
                {
                    _configCacheObject = configCache.ConfigCacheObject.fromSharedObject(_configCachePersistenceManager.getProperty("Object"));
                }
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "ConfigCache > loadCache complete"));
            }
            catch (e:Error)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "ConfigCache > loadCache: " + e.message));
            }
            cacheLoaded = true;
            return;
        }

        public function saveCache():void
        {
            if (blockSaveCache) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "ConfigCache > saveCache blocked"));
                return;
            }
            try 
            {
                if (_configCachePersistenceManager == null) 
                {
                    _configCachePersistenceManager = new configCache.ConfigPersistenceManager();
                }
                _configCachePersistenceManager.clear();
                _configCachePersistenceManager.setProperty("Object", configCache.ConfigCacheObject.toSharedObject(_configCacheObject));
                _configCachePersistenceManager.save();
                dispatchEvent(new flash.events.Event("configCacheSavedEvent"));
            }
            catch (e:Error)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "ConfigCache > saveCache: " + e.message));
            }
            return;
        }

        public function updateLastSyncDate():void
        {
            configCacheObject.setProperty("lastSyncDate", new Date().time - getSyncDateCorrection());
            saveCache();
            return;
        }

        public function resetLastSyncDate():void
        {
            configCacheObject.setProperty("lastSyncDate", 0);
            saveCache();
            return;
        }

        public function enableSport(arg1:uint):void
        {
            var loc1:*=configCacheObject.selectedSportIds();
            if (loc1.indexOf(arg1) == -1) 
            {
                if (loc1.length == 1 && loc1[0] == 0) 
                {
                    configCacheObject.setProperty("selectedSportIds", []);
                }
                if (arg1 == 0) 
                {
                    return;
                }
                loc1.push(arg1);
                loc1.sort();
                configCacheObject.setProperty("selectedSportIds", loc1);
                saveCache();
            }
            return;
        }

        public function disableSport(arg1:uint):void
        {
            var loc2:*=configCacheObject.selectedSportIds();
            var loc1:*=loc2.indexOf(arg1);
            if (loc1 != -1) 
            {
                loc2.splice(loc1, 1);
                loc2.sort();
                configCacheObject.setProperty("selectedSportIds", loc2);
                saveCache();
            }
            return;
        }

        public function enableUserAndSport(arg1:Array, arg2:Array):void
        {
            configCacheObject.setProperty("selectedUserIds", arg1);
            configCacheObject.setProperty("selectedSportIds", arg2);
            saveCache();
            return;
        }

        public function enableUser(arg1:uint):void
        {
            var loc1:*=configCacheObject.selectedUserIds();
            if (loc1.indexOf(arg1) == -1) 
            {
                if (loc1.length == 1 && loc1[0] == 0) 
                {
                    configCacheObject.setProperty("selectedUserIds", []);
                }
                if (arg1 == 0) 
                {
                    return;
                }
                loc1.push(arg1);
                configCacheObject.setProperty("selectedUserIds", loc1);
                saveCache();
            }
            return;
        }

        public function disableUser(arg1:uint):void
        {
            var loc2:*=configCacheObject.selectedUserIds();
            var loc1:*=loc2.indexOf(arg1);
            if (loc1 != -1) 
            {
                loc2.splice(loc1, 1);
                configCacheObject.setProperty("selectedUserIds", loc2);
                saveCache();
            }
            return;
        }

        public function getSportBaseValue(arg1:core.sport.Sport):String
        {
            var loc1:*="logBaseValue_" + arg1.keyName;
            if (configCacheObject.hasProperty(loc1)) 
            {
                return configCacheObject.getProperty(loc1);
            }
            return arg1.defaultXAxisUnit;
        }

        public function setSportBaseValue(arg1:core.sport.Sport, arg2:String):void
        {
            var loc1:*="logBaseValue_" + arg1.keyName;
            configCacheObject.setProperty(loc1, arg2);
            saveCache();
            return;
        }

        public function getSportSpeedFormatValue(arg1:core.sport.Sport):String
        {
            var loc1:*="logSpeedFormat_" + arg1.keyName;
            if (configCacheObject.hasProperty(loc1)) 
            {
                return configCacheObject.getProperty(loc1);
            }
            return arg1.defaultSpeedFormat;
        }

        public function setSportSpeedFormatValue(arg1:core.sport.Sport, arg2:String):void
        {
            var loc1:*="logSpeedFormat_" + arg1.keyName;
            configCacheObject.setProperty(loc1, arg2);
            saveCache();
            return;
        }

        public function getActivityModuleValue(arg1:core.sport.Sport, arg2:String, arg3:uint):*
        {
            var loc1:*=arg2 + arg1.keyName + arg3;
            if (configCacheObject.hasProperty(loc1)) 
            {
                return configCacheObject.getProperty(loc1);
            }
            if (arg1.hasOwnProperty(arg2)) 
            {
                return arg1[arg2];
            }
            return null;
        }

        public function setActivityModuleValue(arg1:core.sport.Sport, arg2:String, arg3:uint, arg4:*):void
        {
            var loc1:*=arg2 + arg1.keyName + arg3;
            configCacheObject.setProperty(loc1, arg4);
            saveCache();
            return;
        }

        public function setPowerZoneValue(arg1:core.sport.Sport, arg2:Object, arg3:Boolean=true):void
        {
            var loc1:*="PowerZoneValues_" + arg1.keyName;
            configCacheObject.setProperty(loc1, arg2);
            if (arg3) 
            {
                saveCache();
            }
            return;
        }

        public function getPowerZoneValue(arg1:core.sport.Sport):Object
        {
            var loc1:*="PowerZoneValues_" + arg1.keyName;
            if (configCacheObject.hasProperty(loc1)) 
            {
                return configCacheObject.getProperty(loc1);
            }
            return null;
        }

        public function setIntensityZoneValue(arg1:core.sport.Sport, arg2:Object, arg3:Boolean=true):void
        {
            var loc1:*="IntensityZoneValues_" + arg1.keyName;
            configCacheObject.setProperty(loc1, arg2);
            if (arg3) 
            {
                saveCache();
            }
            return;
        }

        public function getIntensityZoneValue(arg1:core.sport.Sport):Object
        {
            if (!arg1) 
            {
                return null;
            }
            var loc1:*="IntensityZoneValues_" + arg1.keyName;
            if (configCacheObject.hasProperty(loc1)) 
            {
                return configCacheObject.getProperty(loc1);
            }
            return null;
        }

        public function getValue(arg1:String, arg2:*):*
        {
            if (configCacheObject.hasProperty(arg1)) 
            {
                return configCacheObject.getProperty(arg1);
            }
            return arg2;
        }

        public static const CONFIG_CACHE_SAVED:String="configCacheSavedEvent";

        public var blockSaveCache:Boolean=false;

        public var cacheLoaded:Boolean=false;

        internal var _configCacheObject:configCache.ConfigCacheObject;

        internal var _configCachePersistenceManager:configCache.ConfigPersistenceManager;

        internal static var _configCacheInstance:configCache.ConfigCache;
    }
}


//  class ConfigCacheAttributeNames
package configCache 
{
    public class ConfigCacheAttributeNames extends Object
    {
        public function ConfigCacheAttributeNames()
        {
            super();
            return;
        }

        public static const ALTITUDE_FORMAT:String="altitudeFormat";

        public static const AUTOMATIC_DATA_TRANSMISSION:String="autoDataTransmission";

        public static const CLOCK_FORMAT:String="clockFormat";

        public static const DATE_FORMAT:String="dateFormat";

        public static const DISTANCE_FORMAT:String="distanceFormat";

        public static const ENABLE_MAP_CACHING:String="enableMapCaching";

        public static const LANGUAGE:String="language";

        public static const SPEED_FORMAT:String="speedFormat";

        public static const TEMPERATURE_FORMAT:String="temperatureFormat";

        public static const WEIGHT_FORMAT:String="weightFormat";
    }
}


//  class ConfigCacheObject
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


//  class ConfigPersistenceManager
package configCache 
{
    import flash.net.*;
    
    public class ConfigPersistenceManager extends Object implements configCache.IPersistenceManager
    {
        public function ConfigPersistenceManager()
        {
            super();
            return;
        }

        public function load():Boolean
        {
            if (initialized) 
            {
                return true;
            }
            try 
            {
                so = flash.net.SharedObject.getLocal("ConfigAppCache");
                initialized = true;
            }
            catch (e:Error)
            {
            };
            return initialized;
        }

        public function setProperty(arg1:String, arg2:Object):void
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                so.data[arg1] = arg2;
            }
            return;
        }

        public function getProperty(arg1:String):Object
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                return so.data[arg1];
            }
            return null;
        }

        public function clear():void
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                so.clear();
            }
            return;
        }

        public function save():Boolean
        {
            try 
            {
                so.flush();
            }
            catch (e:Error)
            {
                var loc2:*=false;
                return loc2;
            }
            return true;
        }

        internal static const SHARED_OBJECT_NAME:String="ConfigAppCache";

        internal var initialized:Boolean=false;

        internal var so:flash.net.SharedObject;
    }
}


//  class IPersistenceManager
package configCache 
{
    public dynamic interface IPersistenceManager
    {
        function clear():void;

        function save():Boolean;

        function load():Boolean;

        function getProperty(arg1:String):Object;

        function setProperty(arg1:String, arg2:Object):void;
    }
}


