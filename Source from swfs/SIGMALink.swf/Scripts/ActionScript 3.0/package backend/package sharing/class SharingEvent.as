//class SharingEvent
package backend.sharing 
{
    import core.activities.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.components.popup.oauth.*;
    
    public class SharingEvent extends flash.events.Event
    {
        public function SharingEvent(arg1:String, arg2:core.activities.Activity, arg3:flash.events.Event=null, arg4:frontend.components.popup.oauth.CustomOAuth=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            super(arg1, arg5, arg6);
            this.activity = arg2;
            this.eventTarget = arg3;
            this.oauthInstance = arg4;
            return;
        }

        public static const MULTI_SHARING_FINISHED:String="multiSharingFinished";

        public static const SCREENSHOT_READY:String="EVENT_SCREENSHOT_READY";

        public static const SHARING_COMPLETE:String="sharingCompleteEvent";

        public static const SHARING_ERROR:String="sharingErrorEvent";

        public static const SHARING_HTTP_RESPONSE_STATUS:String="sharingHTTPResponseStatusEvent";

        public static const SHARING_PROGRESS:String="sharingProgressEvent";

        public var activity:core.activities.Activity;

        public var eventTarget:flash.events.Event;

        public var oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        public var screenshot:flash.utils.ByteArray;
    }
}


