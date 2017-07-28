//class BleEvent
package de.pagecon.bleane 
{
    import flash.events.*;
    
    public class BleEvent extends flash.events.Event
    {
        public function BleEvent(arg1:String, arg2:Object, arg3:Boolean=true, arg4:Boolean=true)
        {
            super(arg1, arg3, arg4);
            this.content = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.bleane.BleEvent(type, content);
        }

        public static const CONNECTION_REQUESTS_CANCELLED:String="CONNECTION_REQUESTS_CANCELLED";

        public static const DATA_RECEIVED:String="DATA_RECEIVED";

        public static const DATA_SEND:String="DATA_WRITTEN";

        public static const DEVICE_CONNECTED:String="DEVICE_CONNECTED";

        public static const DEVICE_DISCONNECTED:String="DEVICE_DISCONNECTED";

        public static const DEVICE_DISCOVERED:String="DEVICE_DISCOVERED";

        public static const DEVICE_NOT_PAIRED:String="DEVICE_NOT_PAIRED";

        public static const DEVICE_PAIRED:String="DEVICE_PAIRED";

        public static const ENABLED_STATE_CHANGED:String="ENABLED_STATE_CHANGED";

        public static const ERROR:String="ERROR";

        public static const IDS_CHECKED:String="IDS_CHECKED";

        public static const INFO:String="INFO";

        public static const SCANNING_STATE_CHANGED:String="SCANNING_STATE_CHANGED";

        public static const SELECTED_STATE_CHANGED:String="SELECTED_STATE_CHANGED";

        public var content:Object;
    }
}


