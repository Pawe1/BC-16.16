//class CloudHandler
package handler 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.activities.*;
    import core.gps.*;
    import core.route.*;
    import core.settings.*;
    import core.sportprofiles.*;
    import core.totals.*;
    import core.training.*;
    import core.units.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import flash.utils.*;
    import service.cloud.*;
    
    public class CloudHandler extends service.cloud.CommonCloudHandler
    {
        public function CloudHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this._dataToLoad = [];
            this._mergedSyncList = [];
            this._syncList = new flash.utils.Dictionary();
            super(arg1);
            _firstSyncInterval = 0;
            return;
        }

        public override function startActivitySynchronisation():void
        {
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_ACTIVITY, core.activities.ActivityMapper.table_name);
            return;
        }

        public override function startTrackSynchronisation():void
        {
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_TRACK, core.route.Route.TABLE_NAME);
            return;
        }

        public override function startDeviceSynchronisation():void
        {
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_DEVICE, core.units.Unit.table_name);
            return;
        }

        public override function startDeviceDataSynchronisation():void
        {
            this._dataToLoad = [core.settings.SettingsMapper.table_name, core.sportprofiles.SportprofileMapper.TABLE_NAME, core.gps.PointNavigationMapper.table_name];
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        public override function startDeviceTotalsSynchronisation():void
        {
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS, core.totals.TotalsEntity.table_name);
            return;
        }

        public override function startTrainingProgramSynchronisation():void
        {
            addEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM, core.training.TrainingMapper.table_name);
            return;
        }

        public function loadCloudSyncList(arg1:String, arg2:String=null):void
        {
            if (arg1 == service.cloud.CloudConfig.TYPE_DEVICE_SETTING) 
            {
                arg2 = this._dataToLoad.shift();
                debug.Debug.cloud("loadCloudSyncList - p_tableName");
            }
            var loc1:*="SELECT GUID, modificationDate, isDeleted FROM " + arg2 + " WHERE modificationDate > " + configCache.ConfigCache.getInstance().configCacheObject.lastSyncDate() + " OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadSyncDataComplete, this.loadSyncDataError, null, arg1);
            return;
        }

        internal function loadSyncDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            var loc2:*=arg1.data.data as String;
            if (!loc1) 
            {
                loc1 = [];
            }
            if (loc2 != service.cloud.CloudConfig.TYPE_DEVICE_SETTING) 
            {
                debug.Debug.cloud("loadCloudSyncList - " + loc2 + " complete");
                dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.SYNC_LIST_LOADED, loc2, generateSyncList(loc1, loc2)));
            }
            else 
            {
                this._mergedSyncList.push.apply(this, loc1);
                if (this._dataToLoad.length > 0) 
                {
                    this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
                }
                else 
                {
                    debug.Debug.cloud("loadCloudSyncList - " + loc2 + " complete");
                    dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.SYNC_LIST_LOADED, loc2, generateSyncList(this._mergedSyncList, loc2)));
                }
            }
            return;
        }

        internal function loadSyncDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.cloud("loadCloudSyncList - ERROR");
            var loc1:*=arg1.data.data as String;
            if (loc1 != service.cloud.CloudConfig.TYPE_DEVICE_SETTING) 
            {
                dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.SYNC_LIST_LOADED, loc1, generateSyncList([], loc1)));
            }
            else if (this._dataToLoad.length > 0) 
            {
                this.loadCloudSyncList(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            }
            else 
            {
                dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.SYNC_LIST_LOADED, loc1, generateSyncList(this._mergedSyncList, loc1)));
            }
            return;
        }

        protected override function addAutoSyncEventListener():void
        {
            handler.ActivityHandler.getInstance().addEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            handler.RouteHandler.getInstance().addEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            handler.AppDeviceHandler.getInstance().addEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            return;
        }

        protected override function removeAutoSyncEventListener():void
        {
            handler.ActivityHandler.getInstance().removeEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            handler.RouteHandler.getInstance().removeEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            handler.AppDeviceHandler.getInstance().removeEventListener(service.cloud.CloudEvent.DATA_CHANGED, startAutoSync);
            return;
        }

        protected override function createSyncRequestString(arg1:String):String
        {
            super.createSyncRequestString(arg1);
            return this._syncList[arg1];
        }

        internal function onSyncListLoaded(arg1:service.cloud.CloudEvent):void
        {
            removeEventListener(service.cloud.CloudEvent.SYNC_LIST_LOADED, this.onSyncListLoaded);
            this._syncList[arg1.dataType] = arg1.data;
            var loc1:*=arg1.dataType;
            switch (loc1) 
            {
                case service.cloud.CloudConfig.TYPE_ACTIVITY:
                {
                    super.startActivitySynchronisation();
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRACK:
                {
                    super.startTrackSynchronisation();
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE:
                {
                    super.startDeviceSynchronisation();
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_TOTALS:
                {
                    super.startDeviceTotalsSynchronisation();
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_SETTING:
                {
                    super.startDeviceDataSynchronisation();
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM:
                {
                    super.startTrainingProgramSynchronisation();
                    break;
                }
            }
            return;
        }

        public static function getInstance():handler.CloudHandler
        {
            if (_instance == null) 
            {
                _instance = new CloudHandler();
                configCache.ConfigCache.getInstance().configCacheObject.setProperty(configCache.ConfigCacheObject.CLOUD_AUTO_SYNC, true);
                service.cloud.CommonCloudHandler.setInstance(_instance);
                handler.CloudSyncHandler.getInstance();
            }
            return _instance;
        }

        internal var _dataToLoad:Array;

        internal var _mergedSyncList:Array;

        internal var _syncList:flash.utils.Dictionary;

        internal static var _instance:handler.CloudHandler;
    }
}


