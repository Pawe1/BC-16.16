//class CloudAction
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


