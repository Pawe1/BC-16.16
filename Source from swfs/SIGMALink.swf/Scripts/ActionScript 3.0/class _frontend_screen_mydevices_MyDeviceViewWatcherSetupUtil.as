//class _frontend_screen_mydevices_MyDeviceViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_MyDeviceViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_MyDeviceViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[3]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.MyDeviceView.watcherSetupUtil = new _frontend_screen_mydevices_MyDeviceViewWatcherSetupUtil();
            return;
        }
    }
}


