//class _frontend_screen_mydevices_pointNavigation_DevicePointNavigationViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.pointNavigation.*;
    
    public class _frontend_screen_mydevices_pointNavigation_DevicePointNavigationViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_pointNavigation_DevicePointNavigationViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[7] = new feathers.binding.PropertyWatcher("_pointSaved", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[4]], null);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[2]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("headerHeight", {"propertyChange":true}, [arg4[5]], null);
            arg5[7].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[2].updateParent(SIGMALink);
            arg5[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.pointNavigation.DevicePointNavigationView.watcherSetupUtil = new _frontend_screen_mydevices_pointNavigation_DevicePointNavigationViewWatcherSetupUtil();
            return;
        }
    }
}


