//class URLRequestBufferEvent
package frontend.components.map 
{
    import flash.events.*;
    
    public class URLRequestBufferEvent extends flash.events.Event
    {
        public function URLRequestBufferEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:frontend.components.map.URLRequestBufferItem=null)
        {
            super(arg1, arg2, arg3);
            this._item = arg4;
            return;
        }

        public function get item():frontend.components.map.URLRequestBufferItem
        {
            return this._item;
        }

        public override function clone():flash.events.Event
        {
            return new frontend.components.map.URLRequestBufferEvent(type, bubbles, cancelable, this.item);
        }

        public static const ACTIVE_REQUEST_ADDED:String="URLRequestBufferActiveRequestAdded";

        public static const ACTIVE_REQUEST_REMOVED:String="URLRequestBufferActiveRequestRemoved";

        public static const REQUEST_TIMEOUT:String="URLRequestBufferRequestTimeout";

        public static const WAITING_REQUEST_ADDED:String="URLRequestBufferWaitingRequestAdded";

        public static const WAITING_REQUEST_REMOVED:String="URLRequestBufferWaitingRequestRemoved";

        internal var _item:frontend.components.map.URLRequestBufferItem;
    }
}


