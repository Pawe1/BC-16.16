//package cloud
//  class CloudAction
package service.cloud 
{
    import core.general.interfaces.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    
    public class CloudAction extends Object
    {
        public function CloudAction(arg1:Function, arg2:String, arg3:String=null, arg4:Object=null, arg5:core.general.interfaces.ISynchronisable=null)
        {
            super();
            func = arg1;
            type = arg3;
            data = arg4;
            action = arg2;
            dataObject = arg5;
            return;
        }

        public function loadData(arg1:Function):void
        {
            completeCallback = arg1;
            if (dispatcher) 
            {
                dispatcher.addEventListener(completeEvent, onLoadDataComplete);
                func();
            }
            else 
            {
                func();
                completeCallback();
            }
            return;
        }

        internal function onLoadDataComplete(arg1:flash.events.Event):void
        {
            dispatcher.removeEventListener(completeEvent, onLoadDataComplete);
            if (completeCallback != null) 
            {
                completeCallback();
            }
            return;
        }

        public static function loadDataAction(arg1:flash.events.IEventDispatcher, arg2:Function, arg3:String=""):service.cloud.CloudAction
        {
            var loc1:*;
            (loc1 = new CloudAction(arg2, "loadData")).dispatcher = arg1;
            loc1.completeEvent = arg3;
            return loc1;
        }

        public static const ACTION_DELETE:String="actionDelete";

        public static const ACTION_DOWNLOAD:String="actionDownload";

        public static const ACTION_UPLOAD:String="actionUpload";

        public static const LOAD_DATA:String="loadData";

        public var action:String;

        public var completeCallback:Function;

        public var completeEvent:String;

        public var data:Object;

        public var dataObject:core.general.interfaces.ISynchronisable;

        public var deleteList:Array;

        public var dispatcher:flash.events.IEventDispatcher;

        public var file:flash.filesystem.File;

        public var func:Function;

        public var type:String;

        public var urlRequest:flash.net.URLRequest;

        public var urlStream:service.cloud.CloudURLStream;
    }
}


//  class CloudConfig
package service.cloud 
{
    public class CloudConfig extends Object
    {
        public function CloudConfig()
        {
            super();
            return;
        }

        public static const ACTIVITY_SYNC_COMPLETE:String="activitySyncComplete";

        public static const AUTO_SYNC_CHANGED:String="autoSyncChanged";

        public static const BASE_URL:String="https://www.sigma-data-cloud.com";

        public static const CLIENT_ID_ANDROID:String="dfed306c44564f565065687d534d6ec1";

        public static const CLIENT_ID_IOS:String="fd3d306c44564f5fd065687d534d6ea1";

        public static const CLIENT_ID_MAC:String="de3d306c44114f565065687d534d6efa";

        public static const CLIENT_ID_WINDOWS:String="653d306c44564f565065687d534d6e14";

        public static const CLIENT_SECRET_ANDROID:String="edffc4f97ed15a2c2ae4ea49d545e42c";

        public static const CLIENT_SECRET_IOS:String="1a9dcaf97ed15adeefe4ead9d545e4d1";

        public static const CLIENT_SECRET_MAC:String="d145ca897ed15ade3feffad9d545e4ef";

        public static const CLIENT_SECRET_WINDOWS:String="f869c4f97ed15ade2ae4ea49d545e46f";

        public static const DEVICE_DATA_SYNC_COMPLETE:String="deviceDataSyncComplete";

        public static const DEVICE_SYNC_COMPLETE:String="deviceSyncComplete";

        public static const DEVICE_TOTALS_SYNC_COMPLETE:String="deviceTotalsSyncComplete";

        public static const LOGIN_URL:String="https://www.sigma-data-cloud.com/portal/#/login";

        public static const PING_URL:String="https://www.sigma-data-cloud.com/portal";

        public static const REGISTRATION_URL:String="https://www.sigma-data-cloud.com/portal/#/login";

        public static const STATUS_DELETE:String="DELETE";

        public static const STATUS_DOWNLOAD:String="DOWNLOAD";

        public static const STATUS_UPLOAD:String="UPLOAD";

        public static const SYNC_COMPLETE:String="syncCompleteEvent";

        public static const SYNC_END:String="onSyncEnd";

        public static const SYNC_ERROR:String="syncErrorEvent";

        public static const SYNC_MESSAGE_CHANGED:String="syncMessageEvent";

        public static const SYNC_PROGRESS:String="syncProgressEvent";

        public static const SYNC_REQUEST_IOERROR:String="syncRequestIOError";

        public static const SYNC_STARTED:String="syncStartedEvent";

        public static const SYNC_UPDATE_CACHE:String="updateCacheEvent";

        public static const SYNC_URL:String="https://www.sigma-data-cloud.com/sync";

        public static const TRACK_SYNC_COMPLETE:String="trackSyncComplete";

        public static const TRAINING_PROGRAM_SYNC_COMPLETE:String="trainingProgramSyncComplete";

        public static const TYPE_ACTIVITY:String="ACTIVITY";

        public static const TYPE_DEVICE:String="DEVICE";

        public static const TYPE_DEVICE_SETTING:String="DEVICE_SETTING";

        public static const TYPE_DEVICE_TOTALS:String="DEVICE_TOTALS";

        public static const TYPE_TRACK:String="TRACK";

        public static const TYPE_TRAINING_PROGRAM:String="TRAINING_PROGRAM";

        public static const UPLOAD_ACTIVITY_URL:String="https://www.sigma-data-cloud.com/sync/upload/activity";

        public static const UPLOAD_DEVICE_SETTINGS_URL:String="https://www.sigma-data-cloud.com/sync/upload/device_settings";

        public static const UPLOAD_DEVICE_TOTALS_URL:String="https://www.sigma-data-cloud.com/sync/upload/device_totals";

        public static const UPLOAD_DEVICE_URL:String="https://www.sigma-data-cloud.com/sync/upload/device";

        public static const UPLOAD_TRACK_URL:String="https://www.sigma-data-cloud.com/sync/upload/track";

        public static const UPLOAD_TRAINING_PROGRAM_URL:String="https://www.sigma-data-cloud.com/sync/upload/training_program";
    }
}


//  class CloudEvent
package service.cloud 
{
    import flash.events.*;
    
    public class CloudEvent extends flash.events.Event
    {
        public function CloudEvent(arg1:String, arg2:String="", arg3:Object=null, arg4:String="", arg5:Number=NaN, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg6, arg7);
            dataType = arg2;
            data = arg3;
            GUID = arg4;
            modificationDate = arg5;
            return;
        }

        public static function fromObject(arg1:Object):service.cloud.CloudEvent
        {
            var loc1:*=new CloudEvent(arg1.type, arg1.dataType, arg1.data, arg1.GUID, arg1.modificationDate, arg1.bubbles, arg1.cancelable);
            loc1.access_token = arg1.access_token;
            loc1.displayLabel = arg1.displayLabel;
            loc1.syncStatus = arg1.syncStatus;
            loc1.syncStatusType = arg1.syncStatusType;
            return loc1;
        }

        public static function toObject(arg1:service.cloud.CloudEvent):Object
        {
            return {"type":arg1.type, "dataType":arg1.dataType, "displayLabel":arg1.displayLabel, "data":arg1.data, "GUID":arg1.GUID, "modificationDate":arg1.modificationDate, "access_token":arg1.access_token, "bubbles":arg1.bubbles, "cancelable":arg1.cancelable, "syncStatus":arg1.syncStatus, "syncStatusType":arg1.syncStatusType};
        }

        public static const DATA_CHANGED:String="dataChangedEvent";

        public static const DELETE_RESULT:String="deleteResult";

        public static const DOWNLOAD_RESULT:String="downloadResult";

        public static const PROGRESS:String="progressEvent";

        public static const START_SYNC:String="startSyncEvent";

        public static const SYNC_LIST_LOADED:String="syncListLoaded";

        public var GUID:String;

        public var access_token:String;

        public var data:Object;

        public var dataType:String;

        public var displayLabel:String;

        public var modificationDate:Number;

        public var syncStatus:Array;

        public var syncStatusType:String;
    }
}


//  class CloudURLStream
package service.cloud 
{
    import flash.net.*;
    
    public class CloudURLStream extends flash.net.URLStream
    {
        public function CloudURLStream()
        {
            super();
            return;
        }

        public var data:Object;

        public var type:String;
    }
}


//  class CommonCloudHandler
package service.cloud 
{
    import com.adobe.serialization.json.*;
    import configCache.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.events.*;
    import utils.*;
    
    public class CommonCloudHandler extends flash.events.EventDispatcher
    {
        public function CommonCloudHandler(arg1:flash.events.IEventDispatcher=null)
        {
            syncRunning = false;
            _urlLoader = new flash.net.URLLoader();
            _intitialSyncStatus = [0, 0, 0, 0, 0, 0, 0];
            _syncSequence = ["ACTIVITY", "TRACK", "DEVICE", "TRAINING_PROGRAM", "DEVICE_SETTING", "DEVICE_TOTALS"];
            super(arg1);
            return;
        }

        public function startTrainingProgramSynchronisation():void
        {
            logSyncStatus("startTrainingProgramSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "TRAINING_PROGRAM";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_TRAINING_PROGRAMS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("TRAINING_PROGRAM"));
            return;
        }

        public function onError(arg1:flash.events.IOErrorEvent):void
        {
            _urlLoader.removeEventListener("complete", answerReady);
            _urlLoader.removeEventListener("ioError", onError);
            var loc1:*=arg1.text;
            logSyncStatus("Error: " + loc1);
            stopSync();
            dispatchEvent(new flash.events.Event("syncRequestIOError"));
            return;
        }

        public function get syncRunning():Boolean
        {
            return this.syncRunning;
        }

        public function set syncRunning(arg1:Boolean):void
        {
            var loc1:*=this.syncRunning;
            if (loc1 !== arg1) 
            {
                this.syncRunning = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "syncRunning", loc1, arg1));
                }
            }
            return;
        }

        public function answerReady(arg1:flash.events.Event):void
        {
            _urlLoader.removeEventListener("complete", answerReady);
            _urlLoader.removeEventListener("ioError", onError);
            var loc2:*=(arg1.target as flash.net.URLLoader).data;
            logSyncStatus("Antwort: " + loc2.toString().substr(0, 200));
            var loc1:*=new service.cloud.CloudEvent("onSyncAnswerReady", null, loc2);
            loc1.access_token = configCache.ConfigCache.getInstance().configCacheObject.accessToken();
            dispatchEvent(loc1);
            return;
        }

        public function startAutoSync(arg1:service.cloud.CloudEvent):void
        {
            if (!configCache.ConfigCache.getInstance().configCacheObject.autoSync()) 
            {
                return;
            }
            if (syncRunning) 
            {
                flash.utils.setTimeout(startAutoSync, _autoSyncOnDataChangeInterval, arg1);
                return;
            }
            if (_currentSyncTimeout == 0) 
            {
                logSyncStatus("startAutoSync");
            }
            else 
            {
                logSyncStatus("startAutoSync (reset)");
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            _currentSyncTimeout = flash.utils.setTimeout(doSync, _autoSyncOnDataChangeInterval);
            return;
        }

        public function onSyncError(arg1:String):void
        {
            logSyncStatus("onSyncError: " + arg1);
            stopSync();
            dispatchEvent(new flash.events.Event("syncRequestIOError"));
            return;
        }

        protected function addAutoSyncEventListener():void
        {
            return;
        }

        protected function removeAutoSyncEventListener():void
        {
            return;
        }

        protected function createSyncRequestString(arg1:String):String
        {
            return "";
        }

        protected function generateSyncList(arg1:*, arg2:String):String
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=arg1;
            var loc4:*=[];
            var loc5:*=configCache.ConfigCache.getInstance().configCacheObject.lastSyncDate();
            logSyncStatus("generateSyncList: " + arg2 + ", lastSyncDate: " + loc5);
            var loc6:*;
            (loc6 = {}).dataList = {};
            loc6.dataList.type = arg2;
            loc6.dataList.lastSync = loc5;
            var loc8:*=0;
            var loc7:*=loc2;
            for each (loc3 in loc7) 
            {
                loc1 = {};
                if (!(!(loc3.GUID == "") && (loc3.modificationDate > loc5 || loc3.isDeleted))) 
                {
                    continue;
                }
                loc1.GUID = loc3.GUID;
                loc1.modificationDate = loc3.modificationDate;
                loc1.toDelete = loc3.isDeleted;
                loc4.push(loc1);
            }
            loc6.dataList.list = loc4;
            return com.adobe.serialization.json.JSON.encode(loc6);
        }

        protected function repeatSync():void
        {
            _syncStopped = true;
            _syncSequenceIndex = 0;
            flash.utils.clearTimeout(_currentSyncTimeout);
            _currentSyncTimeout = 0;
            flash.utils.clearTimeout(_maxSyncDurationTimeout);
            _maxSyncDurationTimeout = 0;
            syncRunning = false;
            logSyncStatus("repeatSync");
            dispatchEvent(new flash.events.Event("syncCompleteEvent"));
            dispatchEvent(new service.cloud.CloudEvent("onSyncStopped"));
            _currentSyncTimeout = flash.utils.setTimeout(doSync, 2000);
            return;
        }

        internal function doSync():void
        {
            logSyncStatus("doSync - sync running: " + syncRunning);
            if (_syncSequenceIndex >= _syncSequence.length || loggedOut) 
            {
                logSyncStatus("\n< sync complete");
                if (!loggedOut) 
                {
                    configCache.ConfigCache.getInstance().updateLastSyncDate();
                }
                stopSync();
                if (configCache.ConfigCache.getInstance().configCacheObject.autoSync() && !loggedOut) 
                {
                    _currentSyncTimeout = flash.utils.setTimeout(doSync, _autoSyncWithoutChangesInterval);
                }
                return;
            }
            if (_syncSequenceIndex == 0) 
            {
                logSyncStatus("sync started >");
                _maxSyncDurationTimeout = flash.utils.setTimeout(repeatSync, _maxSyncDuration);
                syncRunning = true;
                dispatchEvent(new flash.events.Event("syncStartedEvent"));
            }
            var loc1:*=_syncSequence[_syncSequenceIndex];
            logSyncStatus("\n- sync: " + loc1);
            var loc2:*=loc1;
            while ("ACTIVITY" === loc2) 
            {
                addEventListener("activitySyncComplete", onTypeSyncComplete);
                startActivitySynchronisation();
            }
        }

        internal function sendSyncRequest(arg1:String):void
        {
            var loc1:*=new flash.net.URLRequest("https://www.sigma-data-cloud.com/sync?access_token=" + configCache.ConfigCache.getInstance().configCacheObject.accessToken());
            loc1.idleTimeout = 300000;
            loc1.data = arg1;
            loc1.method = "POST";
            loc1.contentType = "application/json";
            logSyncStatus("sendSyncRequest - Anfrage: " + arg1);
            _urlLoader.addEventListener("complete", answerReady);
            _urlLoader.addEventListener("ioError", onError);
            return;
        }

        public static function getInstance():service.cloud.CommonCloudHandler
        {
            if (_instance == null) 
            {
                _instance = new CommonCloudHandler();
            }
            return _instance;
        }

        public static function setInstance(arg1:service.cloud.CommonCloudHandler):void
        {
            _instance = arg1;
            return;
        }

        public function logSyncStatus(arg1:String):void
        {
            debug.Debug.cloud("[CommonCloudHandler] " + arg1);
            return;
        }

        public function initAccoutEvents(arg1:flash.display.Stage):void
        {
            logSyncStatus("initAccoutEvents");
            return;
        }

        public function onLoggedIn(arg1:flash.events.Event):void
        {
            if (loggedOut) 
            {
                loggedOut = false;
                logSyncStatus("onLoggedIn: " + arg1.toString());
                startFirstSync();
                addAutoSyncEventListener();
            }
            return;
        }

        public function onLoggedOut(arg1:flash.events.Event):void
        {
            if (!loggedOut) 
            {
                loggedOut = true;
                logSyncStatus("onLoggedOut: " + arg1.toString());
                stopSync();
                configCache.ConfigCache.getInstance().resetLastSyncDate();
                removeAutoSyncEventListener();
            }
            return;
        }

        public function startFullManualSync():void
        {
            configCache.ConfigCache.getInstance().resetLastSyncDate();
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            doSync();
            return;
        }

        public function startFirstSync():void
        {
            if (!configCache.ConfigCache.getInstance().configCacheObject.autoSync() || syncRunning) 
            {
                return;
            }
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            _currentSyncTimeout = flash.utils.setTimeout(doSync, _firstSyncInterval);
            return;
        }

        public function startManualSync():void
        {
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            doSync();
            return;
        }

        public function setAutoSync(arg1:Boolean):void
        {
            autoSync = arg1;
            if (!arg1) 
            {
                if (syncRunning) 
                {
                    stopSync();
                }
                else if (_currentSyncTimeout != 0) 
                {
                    flash.utils.clearTimeout(_currentSyncTimeout);
                    _currentSyncTimeout = 0;
                }
            }
            configCache.ConfigCache.getInstance().configCacheObject.setProperty("autoSync", arg1);
            configCache.ConfigCache.getInstance().saveCache();
            if (!syncRunning && arg1) 
            {
                startFirstSync();
            }
            dispatchEvent(new flash.events.Event("autoSyncChanged"));
            return;
        }

        internal function onTypeSyncComplete(arg1:flash.events.Event):void
        {
            logSyncStatus("onTypeSyncComplete: " + arg1.type + ", syncRunning: " + syncRunning + ", syncStopped: " + _syncStopped);
            var loc1:*=arg1.type;
            while ("activitySyncComplete" === loc1) 
            {
                removeEventListener("activitySyncComplete", onTypeSyncComplete);
            }
        }

        public function stopSync():void
        {
            var loc1:*=null;
            logSyncStatus("stopSync");
            _syncSequenceIndex = 0;
            flash.utils.clearTimeout(_currentSyncTimeout);
            _currentSyncTimeout = 0;
            flash.utils.clearTimeout(_maxSyncDurationTimeout);
            _maxSyncDurationTimeout = 0;
            if (syncRunning) 
            {
                syncRunning = false;
                dispatchEvent(new flash.events.Event("syncCompleteEvent"));
                loc1 = new service.cloud.CloudEvent("onSyncStopped");
                dispatchEvent(loc1);
            }
            return;
        }

        public function getCurrentTypeDisplayLabel():String
        {
            var loc1:*="";
            var loc2:*=_syncSequence[_syncSequenceIndex];
            while ("ACTIVITY" === loc2) 
            {
                loc1 = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_ACTIVITY");
            }
        }

        public function startActivitySynchronisation():void
        {
            logSyncStatus("startActivitySynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "ACTIVITY";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_ACTIVITY");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("ACTIVITY"));
            return;
        }

        public function startTrackSynchronisation():void
        {
            logSyncStatus("startTrackSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "TRACK";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_TRACKS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("TRACK"));
            return;
        }

        public function startDeviceSynchronisation():void
        {
            logSyncStatus("startDeviceSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICES");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE"));
            return;
        }

        public function startDeviceTotalsSynchronisation():void
        {
            logSyncStatus("startDeviceTotalsSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE_TOTALS";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICE_TOTALS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE_TOTALS"));
            return;
        }

        public function startDeviceDataSynchronisation():void
        {
            logSyncStatus("startDeviceSettingsSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE_SETTING";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICE_DATA");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE_SETTING"));
            return;
        }

        public static const SYNC_ANSWER_READY:String="onSyncAnswerReady";

        public static const STOP_SYNC:String="onSyncStopped";

        public var autoSync:Boolean=true;

        internal var syncRunning:Boolean;

        protected var _firstSyncInterval:int=3000;

        internal var _autoSyncOnDataChangeInterval:int=20000;

        internal var _autoSyncWithoutChangesInterval:int=300000;

        internal var _currentSyncTimeout:int=0;

        internal var _intitialSyncStatus:Array;

        internal var _maxSyncDuration:int=5400000;

        internal var _maxSyncDurationTimeout:int=0;

        internal var _syncSequence:Array;

        internal var _syncSequenceIndex:uint=0;

        internal var _syncStopped:Boolean=false;

        internal var loggedOut:Boolean=true;

        internal static var _instance:service.cloud.CommonCloudHandler;

        protected var _urlLoader:flash.net.URLLoader;
    }
}


