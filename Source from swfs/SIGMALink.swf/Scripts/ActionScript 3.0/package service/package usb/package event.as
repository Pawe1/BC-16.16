//package event
//  class DeviceDataCompleteEvent
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


//  class USBConnectedEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class USBConnectedEvent extends flash.events.Event
    {
        public function USBConnectedEvent(arg1:String, arg2:uint, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            _usbPort = arg2;
            _dockingStation = arg3;
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        public function set dockingStation(arg1:String):void
        {
            _dockingStation = arg1;
            return;
        }

        public function get usbPort():uint
        {
            return _usbPort;
        }

        public function set usbPort(arg1:uint):void
        {
            _usbPort = arg1;
            return;
        }

        public static const USB_CONNECTED:String="usbConnected";

        public static const USB_DISCONNECTED:String="usbDisconnected";

        internal var _dockingStation:String;

        internal var _usbPort:uint;
    }
}


