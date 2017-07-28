//class BLEDeviceEvent
package service.ble.event 
{
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class BLEDeviceEvent extends flash.events.Event
    {
        public function BLEDeviceEvent(arg1:String, arg2:core.units.interfaces.IBLEDeviceInfo, arg3:Boolean=false, arg4:Boolean=false)
        {
            bleDevice = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public static const DEVICE_ALREADY_CONNECTED:String="bleDeviceAlreadyConnectedEvent";

        public static const DEVICE_CONNECTED:String="bleDeviceConnectedEvent";

        public static const DEVICE_DISCONNECTED:String="bleDeviceDisconnectedEvent";

        public static const DEVICE_FOUND:String="bleDeviceFoundEvent";

        public var bleDevice:core.units.interfaces.IBLEDeviceInfo;
    }
}


