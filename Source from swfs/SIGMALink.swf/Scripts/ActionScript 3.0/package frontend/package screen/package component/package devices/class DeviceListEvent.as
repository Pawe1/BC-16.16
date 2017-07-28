//class DeviceListEvent
package frontend.screen.component.devices 
{
    import core.units.*;
    import flash.events.*;
    
    public class DeviceListEvent extends flash.events.Event
    {
        public function DeviceListEvent(arg1:String, arg2:core.units.Unit=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.unit = arg2;
            return;
        }

        public static const DELETE:String="deleteDeviceEvent";

        public static const RELOAD:String="reloadDevicesEvent";

        public static const UPDATE:String="updateDeviceEvent";

        public var unit:core.units.Unit;
    }
}


