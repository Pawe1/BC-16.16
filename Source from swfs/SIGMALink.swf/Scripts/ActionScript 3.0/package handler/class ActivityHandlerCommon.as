//class ActivityHandlerCommon
package handler 
{
    import core.activities.*;
    import flash.events.*;
    
    public class ActivityHandlerCommon extends flash.events.EventDispatcher
    {
        public function ActivityHandlerCommon(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function saveActivityMarker(arg1:core.activities.Activity):void
        {
            return;
        }

        public function dispatchLapAddedEvent():void
        {
            return;
        }

        public static function getInstance():handler.ActivityHandlerCommon
        {
            return _instance as ActivityHandlerCommon;
        }

        public static function setInstace(arg1:handler.ActivityHandlerCommon):void
        {
            _instance = arg1;
            return;
        }

        public static const ACTIVITY_MARKER_SAVED:String="activityMarkerSaved";

        public static const ACTIVITY_SAVE_ERROR:String="activitySaveError";

        internal static var _instance:handler.ActivityHandlerCommon;
    }
}


