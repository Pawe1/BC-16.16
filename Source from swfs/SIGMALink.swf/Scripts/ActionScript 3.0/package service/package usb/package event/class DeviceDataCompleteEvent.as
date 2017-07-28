//class DeviceDataCompleteEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class DeviceDataCompleteEvent extends flash.events.Event
    {
        public function DeviceDataCompleteEvent(arg1:String, arg2:String, arg3:Array, arg4:String=null, arg5:Boolean=false)
        {
            super(arg1, arg5);
            command = arg2;
            data = arg3;
            startAdress = arg4;
            return;
        }

        public override function toString():String
        {
            return "[DataCompleteEvent extends Event]";
        }

        public static const DATA_COMPLETE:String="usbComplete";

        public var command:String;

        public var data:Array;

        public var startAdress:String;
    }
}


