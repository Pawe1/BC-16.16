//class CommonCloudHandler
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


