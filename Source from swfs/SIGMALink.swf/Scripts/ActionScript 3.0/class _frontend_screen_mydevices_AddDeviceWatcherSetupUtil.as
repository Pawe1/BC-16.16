//class _frontend_screen_mydevices_AddDeviceWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_AddDeviceWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_AddDeviceWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.PropertyWatcher("unit", {"propertyChange":true}, [arg4[1]], arg2);
            arg5[1].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.AddDevice.watcherSetupUtil = new _frontend_screen_mydevices_AddDeviceWatcherSetupUtil();
            return;
        }
    }
}


