//class CloudWorker
package worker 
{
    import backend.database.*;
    import backend.utils.dataprovider.*;
    import com.logging.*;
    import core.general.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.system.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.formatter.*;
    import handler.*;
    import service.cloud.*;
    import utils.*;
    
    public class CloudWorker extends flash.display.Sprite
    {
        public function CloudWorker()
        {
            super();
            if (!flash.system.Worker.current.isPrimordial) 
            {
                this._toBGChannel = flash.system.Worker.current.getSharedProperty(TO_BG_CHANNEL) as flash.system.MessageChannel;
                this._toMainChannel = flash.system.Worker.current.getSharedProperty(TO_MAIN_CHANNEL) as flash.system.MessageChannel;
                this._toBGChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onMainMessage);
                loaderInfo.uncaughtErrorEvents.addEventListener(flash.events.UncaughtErrorEvent.UNCAUGHT_ERROR, this.onError);
            }
            return;
        }

        internal function onMainMessage(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (!this._toBGChannel.messageAvailable) 
            {
                return;
            }
            var loc1:*=this._toBGChannel.receive();
            var loc2:*=loc1[0];
            var loc7:*=loc2;
            switch (loc7) 
            {
                case INIT_DATABASE:
                {
                    utils.LanguageManager.getStringFunction = frontend.Locales.locale().getString;
                    frontend.Locales.locale().localeChain = ["de_DE"];
                    frontend.Locales.locale().addBundle("de_DE", frontend.Locales.DEFAULT_LANGUAGE_BUNDLENAME, true, this.onLocaleInitialized);
                    loc3 = new flash.filesystem.File(loc1[1]);
                    frontend.formatter.LinkBackendInitializer.getInstance();
                    handler.SportHandler.init();
                    handler.AppDBHandler.getInstance();
                    backend.database.DatabaseDefinition.getInstance().currentDatabase.initDatabaseFile(loc3.parent.nativePath);
                    break;
                }
                case INIT_ERROR_LOGGING:
                {
                    loc4 = loc1[1];
                    com.logging.ErrorLogging.getInstance().filename = "app-error";
                    com.logging.ErrorLogging.getInstance().loggingPath = loc4;
                    debug.Debug.setCustomFilePath(loc4 + "/worker2_" + debug.Debug.DEFAULT_FILENAME);
                    break;
                }
                case ON_ANSWER_READY:
                {
                    loc5 = (loc1[1] as flash.utils.ByteArray).readObject();
                    loc6 = loc5.data as String;
                    handler.CommonSyncHandler.getInstance().progressCallback = this.syncProgress;
                    handler.CommonSyncHandler.getInstance().completeCallback = this.syncComplete;
                    handler.CommonSyncHandler.getInstance().updateCacheCallback = this.updateCache;
                    handler.CommonSyncHandler.getInstance().errorCallback = this.onSyncError;
                    handler.CommonSyncHandler.getInstance().readAnswer(loc6, true, loc5.access_token);
                    break;
                }
                case ON_LOGGED_OUT:
                {
                    handler.CommonSyncHandler.getInstance().stopSync();
                    break;
                }
            }
            return;
        }

        internal function onLocaleInitialized(arg1:Object, arg2:Object, arg3:Object):void
        {
            backend.utils.dataprovider.DataProviderUtil.initDataProviders();
            return;
        }

        internal function syncComplete(arg1:service.cloud.CloudEvent):void
        {
            this._toMainChannel.send([service.cloud.CloudConfig.SYNC_COMPLETE, service.cloud.CloudEvent.toObject(arg1)]);
            return;
        }

        internal function syncProgress(arg1:service.cloud.CloudEvent):void
        {
            this._toMainChannel.send([service.cloud.CloudConfig.SYNC_PROGRESS, service.cloud.CloudEvent.toObject(arg1)]);
            return;
        }

        internal function updateCache(arg1:String, arg2:int):void
        {
            this._toMainChannel.send([service.cloud.CloudConfig.SYNC_UPDATE_CACHE, arg1, arg2]);
            return;
        }

        internal function onSyncError(arg1:String):void
        {
            this._toMainChannel.send([service.cloud.CloudConfig.SYNC_ERROR, arg1]);
            return;
        }

        internal function onError(arg1:flash.events.UncaughtErrorEvent):void
        {
            var loc1:*=null;
            arg1.preventDefault();
            arg1.stopImmediatePropagation();
            if (arg1.error is Error) 
            {
                var loc3:*;
                loc1 = loc3 = (arg1.error as Error).getStackTrace();
                loc3;
            }
            else if (arg1.error is flash.events.ErrorEvent) 
            {
                loc1 = loc3 = flash.events.ErrorEvent(arg1.error).text;
                loc3;
            }
            else 
            {
                loc1 = loc3 = arg1.error.toString();
                loc3;
            }
            var loc2:*=new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_UNCAUGHT_EXCEPTION, loc1, "CloudWorker");
            com.logging.ErrorLogging.getInstance().receiveMessageFromStaticFunction(loc2, false);
            return;
        }

        
        {
            INIT_DATABASE = "cloudWorker_initDataBase";
            INIT_ERROR_LOGGING = "cloudWorker_initErrorLogging";
            ON_ANSWER_READY = "cloudWorker_answerReady";
            ON_LOGGED_OUT = "cloudWorker_stopSync";
            TO_BG_CHANNEL = "cloudWorker_toBGChannel";
            TO_MAIN_CHANNEL = "cloudWorker_toMainChannel";
        }

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        public static var INIT_DATABASE:String="cloudWorker_initDataBase";

        public static var INIT_ERROR_LOGGING:String="cloudWorker_initErrorLogging";

        public static var ON_ANSWER_READY:String="cloudWorker_answerReady";

        public static var ON_LOGGED_OUT:String="cloudWorker_stopSync";

        public static var TO_BG_CHANNEL:String="cloudWorker_toBGChannel";

        public static var TO_MAIN_CHANNEL:String="cloudWorker_toMainChannel";
    }
}


