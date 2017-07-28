//class CloudEvent
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


