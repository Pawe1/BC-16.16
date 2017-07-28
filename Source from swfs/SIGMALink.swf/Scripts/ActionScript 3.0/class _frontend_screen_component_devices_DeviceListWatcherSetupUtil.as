//class _frontend_screen_component_devices_DeviceListWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.component.devices.*;
    
    public class _frontend_screen_component_devices_DeviceListWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_component_devices_DeviceListWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[0] = new feathers.binding.PropertyWatcher("_defaultHeight", {"propertyChange":true}, [arg4[0], arg4[3]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[5]], null);
            arg5[2] = new feathers.binding.PropertyWatcher("_deviceList", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[0].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[2].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.component.devices.DeviceList.watcherSetupUtil = new _frontend_screen_component_devices_DeviceListWatcherSetupUtil();
            return;
        }
    }
}


