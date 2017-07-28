//class ConfigCache
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


