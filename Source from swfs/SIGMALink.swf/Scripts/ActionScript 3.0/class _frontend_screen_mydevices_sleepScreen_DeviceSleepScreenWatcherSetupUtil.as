//class _frontend_screen_mydevices_sleepScreen_DeviceSleepScreenWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sleepScreen.*;
    
    public class _frontend_screen_mydevices_sleepScreen_DeviceSleepScreenWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sleepScreen_DeviceSleepScreenWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[5]], null);
            arg5[2] = new feathers.binding.PropertyWatcher("dataProvider", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[3]], null);
            arg5[5].updateParent(SIGMALink);
            arg5[2].updateParent(arg1);
            arg5[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sleepScreen.DeviceSleepScreen.watcherSetupUtil = new _frontend_screen_mydevices_sleepScreen_DeviceSleepScreenWatcherSetupUtil();
            return;
        }
    }
}


