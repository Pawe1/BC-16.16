//class CloudSyncHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.database.*;
    import configCache.*;
    import debug.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.events.*;
    import service.cloud.*;
    import worker.*;
    
    public class CloudSyncHandler extends flash.events.EventDispatcher
    {
        public function CloudSyncHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this._cacheUpdates = new flash.utils.Dictionary();
            super(arg1);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CommonCloudHandler.SYNC_ANSWER_READY, this.onSyncAnswerReady);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CommonCloudHandler.STOP_SYNC, this.onSyncStopped);
            return;
        }

        public function onSyncStopped(arg1:service.cloud.CloudEvent):void
        {
            this.syncStopped = true;
            if (flash.system.Worker.isSupported && handler.ApplicationHandler.useWorker) 
            {
                this.sendToWorker([worker.CloudWorker.ON_LOGGED_OUT, null]);
            }
            else 
            {
                handler.CommonSyncHandler.getInstance().stopSync();
            }
            return;
        }

        public function onSyncAnswerReady(arg1:service.cloud.CloudEvent):void
        {
            var loc2:*=null;
            logSyncStatus("onSyncAnswerReady: " + arg1.toString());
            var loc1:*=new Object();
            loc1.data = arg1.data;
            loc1.access_token = arg1.access_token;
            if (flash.system.Worker.isSupported && handler.ApplicationHandler.useWorker) 
            {
                loc2 = new flash.utils.ByteArray();
                loc2.writeObject(loc1);
                this.sendToWorker([worker.CloudWorker.ON_ANSWER_READY, loc2]);
            }
            else 
            {
                handler.CommonSyncHandler.getInstance().progressCallback = this.syncProgress;
                handler.CommonSyncHandler.getInstance().completeCallback = this.syncComplete;
                handler.CommonSyncHandler.getInstance().updateCacheCallback = this.updateCache;
                handler.CommonSyncHandler.getInstance().errorCallback = this.onSyncError;
                handler.CommonSyncHandler.getInstance().readAnswer(arg1.data as String, false, arg1.access_token);
            }
            return;
        }

        public function onSyncError(arg1:String):void
        {
            logSyncStatus("onSyncError: " + arg1);
            handler.CloudHandler.getInstance().onSyncError(arg1);
            return;
        }

        internal function getCloudWorker(arg1:Boolean=true):flash.system.Worker
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=flash.system.WorkerDomain.current.listWorkers();
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc5 = loc1[loc2];
                if (loc5.getSharedProperty(worker.CloudWorker.TO_BG_CHANNEL)) 
                {
                    return loc5;
                }
                ++loc2;
            }
            if (arg1) 
            {
                loc4 = flash.system.WorkerDomain.current.createWorker(Workers.worker_CloudWorker, true);
                this._toBGChannel = flash.system.Worker.current.createMessageChannel(loc4);
                this._toMainChannel = loc4.createMessageChannel(flash.system.Worker.current);
                loc4.setSharedProperty(worker.CloudWorker.TO_BG_CHANNEL, this._toBGChannel);
                loc4.setSharedProperty(worker.CloudWorker.TO_MAIN_CHANNEL, this._toMainChannel);
                this._toMainChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onWorkerChannelMessage);
            }
            return loc4;
        }

        public function destroyWorker():void
        {
            var workerInstance:flash.system.Worker;
            var tryToTerminate:Boolean;

            var loc1:*;
            logSyncStatus("destroyWorker");
            workerInstance = this.getCloudWorker(false);
            tryToTerminate = false;
            if (workerInstance) 
            {
                try 
                {
                    if (tryToTerminate) 
                    {
                        workerInstance.terminate();
                    }
                    else 
                    {
                        this.onWorkerTerminated();
                    }
                }
                catch (e:Error)
                {
                    debug.Debug.cloud("destroyWorker error: " + e.message);
                }
                catch (e:*)
                {
                    debug.Debug.error("destroyWorker error");
                }
            }
            return;
        }

        public function sendToWorker(arg1:Array):void
        {
            var p_array:Array;
            var workerInstance:flash.system.Worker;

            var loc1:*;
            p_array = arg1;
            if (!flash.system.Worker.isSupported || !handler.ApplicationHandler.useWorker) 
            {
                return;
            }
            if (this._sendToWorkerTimeout != 0) 
            {
                flash.utils.clearTimeout(this._sendToWorkerTimeout);
                this._sendToWorkerTimeout = 0;
            }
            workerInstance = this.getCloudWorker();
            if (workerInstance.state == flash.system.WorkerState.NEW) 
            {
                logSyncStatus("try to start worker (state: " + workerInstance.state + ")");
                try 
                {
                    workerInstance.addEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
                    workerInstance.start();
                    logSyncStatus("start worker complete: " + workerInstance.state);
                }
                catch (error:Error)
                {
                    logSyncStatus("start worker failed: " + error.message);
                }
            }
            if (!this._workerInitComplete) 
            {
                logSyncStatus("sendToWorker ::: _workerInitComplete = false ::: retry");
                this._sendToWorkerTimeout = flash.utils.setTimeout(this.sendToWorker, 500, p_array);
                return;
            }
            try 
            {
                logSyncStatus("sendToWorker ::: start sending");
                this._toBGChannel.send(p_array);
                logSyncStatus("sendToWorker ::: sent");
            }
            catch (error:Error)
            {
                logSyncStatus("error: " + error.message);
            }
            return;
        }

        internal function onWorkerStateChanged(arg1:flash.events.Event):void
        {
            logSyncStatus("onWorkerStateChanged: " + (arg1.currentTarget as flash.system.Worker).state);
            if ((arg1.target as flash.system.Worker).state != flash.system.WorkerState.RUNNING) 
            {
                if ((arg1.target as flash.system.Worker).state == flash.system.WorkerState.TERMINATED) 
                {
                    if (this._toBGChannel.state == flash.system.MessageChannelState.OPEN) 
                    {
                        this._toBGChannel.close();
                    }
                    if (this._toMainChannel.state == flash.system.MessageChannelState.OPEN) 
                    {
                        this._toMainChannel.close();
                    }
                    this._workerInitComplete = false;
                    this.onWorkerTerminated();
                }
            }
            else 
            {
                this._toBGChannel.send([worker.CloudWorker.INIT_DATABASE, backend.database.DatabaseDefinition.getInstance().currentDatabase.file.nativePath]);
                this._toBGChannel.send([worker.CloudWorker.INIT_ERROR_LOGGING, backend.database.DatabaseDefinition.getInstance().currentDatabase.workDirectory.nativePath]);
                this._workerInitComplete = true;
            }
            return;
        }

        internal function onWorkerTerminated():void
        {
            handler.CloudHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudConfig.SYNC_END));
            return;
        }

        internal function syncProgress(arg1:service.cloud.CloudEvent):void
        {
            logSyncStatus("syncProgress: " + arg1.toString());
            this.onSyncStateChange(service.cloud.CloudConfig.SYNC_PROGRESS, arg1);
            return;
        }

        internal function syncComplete(arg1:service.cloud.CloudEvent):void
        {
            logSyncStatus("syncComplete: " + arg1.toString());
            this.onSyncStateChange(service.cloud.CloudConfig.SYNC_COMPLETE, arg1);
            return;
        }

        internal function updateCache(arg1:String, arg2:int):void
        {
            logSyncStatus("updateCache -> p_type:" + arg1 + " / p_id:" + arg2);
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "user":
                {
                    configCache.ConfigCache.getInstance().enableUser(arg2);
                    break;
                }
                case "sport":
                {
                    configCache.ConfigCache.getInstance().enableSport(arg2);
                    break;
                }
                default:
                {
                    return;
                }
            }
            configCache.ConfigCache.getInstance().saveCache();
            return;
        }

        internal function onWorkerChannelMessage(arg1:flash.events.Event):void
        {
            logSyncStatus("onWorkerChannelMessage - messageAvailable: " + (arg1.currentTarget as flash.system.MessageChannel).messageAvailable + ", state: " + (arg1.currentTarget as flash.system.MessageChannel).state);
            var loc1:*=this._toMainChannel.receive();
            var loc2:*=loc1[0];
            var loc3:*=loc2;
            switch (loc3) 
            {
                case service.cloud.CloudConfig.SYNC_UPDATE_CACHE:
                {
                    if (this._cacheUpdates["sport"] == null) 
                    {
                        this._cacheUpdates["sport"] = [];
                        this._cacheUpdates["user"] = [];
                    }
                    if ((this._cacheUpdates[loc1[1] as String] as Array).indexOf(loc1[2] as int) == -1) 
                    {
                        (this._cacheUpdates[loc1[1] as String] as Array).push(loc1[2] as int);
                    }
                    break;
                }
                case service.cloud.CloudConfig.SYNC_ERROR:
                {
                    this.onSyncError(loc1[1] as String);
                    break;
                }
                case service.cloud.CloudConfig.SYNC_PROGRESS:
                {
                    this.onSyncStateChange(loc2, service.cloud.CloudEvent.fromObject(loc1[1]));
                    break;
                }
                case service.cloud.CloudConfig.SYNC_COMPLETE:
                {
                    this.onSyncStateChange(loc2, service.cloud.CloudEvent.fromObject(loc1[1]));
                    break;
                }
            }
            return;
        }

        internal function onSyncStateChange(arg1:String, arg2:service.cloud.CloudEvent):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            logSyncStatus("onSyncStateChange - mode: " + arg1 + ", dataType: " + arg2.dataType + ", syncStatus: " + arg2.syncStatus.join(","));
            var loc6:*=arg1;
            switch (loc6) 
            {
                case service.cloud.CloudConfig.SYNC_PROGRESS:
                {
                    handler.CloudHandler.getInstance().dispatchEvent(arg2);
                    break;
                }
                case service.cloud.CloudConfig.SYNC_COMPLETE:
                {
                    loc1 = this.syncStopped;
                    loc6 = arg2.dataType;
                    switch (loc6) 
                    {
                        case service.cloud.CloudConfig.TYPE_ACTIVITY:
                        {
                            loc2 = this._cacheUpdates["sport"] as Array;
                            loc3 = this._cacheUpdates["user"] as Array;
                            if (loc2) 
                            {
                                loc5 = loc2.length;
                                loc4 = 0;
                                while (loc4 < loc5) 
                                {
                                    this.updateCache("sport", loc2[loc4]);
                                    ++loc4;
                                }
                            }
                            if (loc3) 
                            {
                                loc5 = loc3.length;
                                loc4 = 0;
                                while (loc4 < loc5) 
                                {
                                    this.updateCache("user", loc3[loc4]);
                                    ++loc4;
                                }
                            }
                            this._cacheUpdates["sport"] = [];
                            this._cacheUpdates["user"] = [];
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.ACTIVITY_SYNC_COMPLETE));
                            break;
                        }
                        case service.cloud.CloudConfig.TYPE_TRACK:
                        {
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.TRACK_SYNC_COMPLETE));
                            break;
                        }
                        case service.cloud.CloudConfig.TYPE_DEVICE:
                        {
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.DEVICE_SYNC_COMPLETE));
                            break;
                        }
                        case service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM:
                        {
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.TRAINING_PROGRAM_SYNC_COMPLETE));
                            break;
                        }
                        case service.cloud.CloudConfig.TYPE_DEVICE_SETTING:
                        {
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.DEVICE_DATA_SYNC_COMPLETE));
                            break;
                        }
                        case service.cloud.CloudConfig.TYPE_DEVICE_TOTALS:
                        {
                            loc1 = true;
                            handler.CloudHandler.getInstance().dispatchEvent(new flash.events.Event(service.cloud.CloudConfig.DEVICE_TOTALS_SYNC_COMPLETE));
                            break;
                        }
                    }
                    if (loc1) 
                    {
                        this.destroyWorker();
                    }
                    this.syncStopped = false;
                    break;
                }
            }
            return;
        }

        public static function getInstance():handler.CloudSyncHandler
        {
            if (!_instance) 
            {
                _instance = new CloudSyncHandler();
            }
            return _instance;
        }

        public static function logSyncStatus(arg1:String):void
        {
            debug.Debug.cloud("[CloudSyncHandler] " + arg1);
            return;
        }

        public static function get syncLogging():String
        {
            return handler.CloudSyncHandler._1299303356syncLogging;
        }

        public static function set syncLogging(arg1:String):void
        {
            var loc2:*=null;
            var loc1:*=handler.CloudSyncHandler._1299303356syncLogging;
            if (loc1 !== arg1) 
            {
                handler.CloudSyncHandler._1299303356syncLogging = arg1;
                loc2 = handler.CloudSyncHandler.staticEventDispatcher;
                if (!(loc2 == null) && loc2.hasEventListener("propertyChange")) 
                {
                    loc2.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(handler.CloudSyncHandler, "syncLogging", loc1, arg1));
                }
            }
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _1299303356syncLogging = "";
            _staticBindingEventDispatcher = new flash.events.EventDispatcher();
        }

        internal var _cacheUpdates:flash.utils.Dictionary;

        internal var _sendToWorkerTimeout:uint=0;

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        internal var _workerInitComplete:Boolean=false;

        internal var syncStopped:Boolean=false;

        internal static var _1299303356syncLogging:String="";

        internal static var _instance:handler.CloudSyncHandler;

        internal static var _staticBindingEventDispatcher:flash.events.EventDispatcher;
    }
}


