//package event
//  class DeviceCommunicationEvent
package service.event 
{
    import flash.events.*;
    
    public class DeviceCommunicationEvent extends flash.events.Event
    {
        public function DeviceCommunicationEvent(arg1:String, arg2:String="")
        {
            super(arg1);
            message = arg2;
            return;
        }

        public static const EVENT_COMMUNICATION_ERROR:String="eventCommunicationError";

        public var message:String="";
    }
}


//  class DeviceConnectionEvent
package service.event 
{
    import flash.events.*;
    
    public class DeviceConnectionEvent extends flash.events.Event
    {
        public function DeviceConnectionEvent(arg1:String, arg2:String, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            _connectedDevicePort = arg2;
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

        public function get usbPort():String
        {
            return _connectedDevicePort;
        }

        public function set usbPort(arg1:String):void
        {
            _connectedDevicePort = arg1;
            return;
        }

        public static const DEVICE_ALREADY_CONNECTED:String="deviceAlreadyConnected";

        public static const DEVICE_CONNECTED:String="deviceConnected";

        public static const DEVICE_DISCONNECTED:String="deviceDisconnected";

        public static const DEVICE_FOUND:String="deviceFound";

        internal var _dockingStation:String;

        internal var _connectedDevicePort:String;
    }
}


