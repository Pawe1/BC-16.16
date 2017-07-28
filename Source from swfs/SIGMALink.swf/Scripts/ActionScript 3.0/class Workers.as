//class Workers
package 
{
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class Workers extends flash.events.EventDispatcher
    {
        public function Workers()
        {
            super();
            return;
        }

        public function initializeWorkers():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=0;
            loc2 = new flash.net.URLRequest(FILE_NAME_CLOUD_WORKER);
            loc3 = new flash.display.Loader();
            loc4 = new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain, null);
            loc3.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.cloudWorkerCompleteHandler);
            loc3.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.errorHandler);
            loc3.load(loc2, loc4);
            loc2 = new flash.net.URLRequest(FILE_NAME_DATABASE_WORKER);
            loc3 = new flash.display.Loader();
            loc4 = new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain, null);
            loc3.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.databaseWorkerCompleteHandler);
            loc3.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.errorHandler);
            loc3.load(loc2, loc4);
            return;
        }

        internal function cloudWorkerCompleteHandler(arg1:flash.events.Event):void
        {
            debug.Debug.debug("[CLOUD WORKER INITIALIZED]");
            worker_CloudWorker = arg1.target.bytes;
            cloudWorkerInitialized = true;
            this.checkAllWorkersInitialized();
            return;
        }

        internal function databaseWorkerCompleteHandler(arg1:flash.events.Event):void
        {
            debug.Debug.debug("[DATABASE WORKER INITIALIZED]");
            worker_DatabaseWorker = arg1.target.bytes;
            databaseWorkerInitialized = true;
            this.checkAllWorkersInitialized();
            return;
        }

        internal function checkAllWorkersInitialized():void
        {
            if (databaseWorkerInitialized && cloudWorkerInitialized) 
            {
                dispatchEvent(new flash.events.Event(EVENT_WORKERS_INITIALIZED));
            }
            return;
        }

        internal function errorHandler(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("[ERROR WHILE LOADING WORKER] #" + arg1.errorID + " - " + arg1.text);
            return;
        }

        
        {
            cloudWorkerInitialized = false;
            databaseWorkerInitialized = false;
        }

        public static const EVENT_WORKERS_INITIALIZED:String="workersInitialized";

        internal static const FILE_NAME_CLOUD_WORKER:String="CloudWorker.swf";

        internal static const FILE_NAME_DATABASE_WORKER:String="DatabaseWorker.swf";

        public static var worker_CloudWorker:flash.utils.ByteArray;

        public static var worker_DatabaseWorker:flash.utils.ByteArray;

        internal static var cloudWorkerInitialized:Boolean=false;

        internal static var databaseWorkerInitialized:Boolean=false;
    }
}


