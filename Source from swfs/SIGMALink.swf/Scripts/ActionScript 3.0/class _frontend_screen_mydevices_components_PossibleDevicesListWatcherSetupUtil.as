//class _frontend_screen_mydevices_components_PossibleDevicesListWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.components.*;
    
    public class _frontend_screen_mydevices_components_PossibleDevicesListWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_components_PossibleDevicesListWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.PropertyWatcher("_dataProvider", {"propertyChange":true}, [arg4[3]], arg2);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[6]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0], arg4[4]], null);
            arg5[2].updateParent(arg1);
            arg5[4].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.components.PossibleDevicesList.watcherSetupUtil = new _frontend_screen_mydevices_components_PossibleDevicesListWatcherSetupUtil();
            return;
        }
    }
}


