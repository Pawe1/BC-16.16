//class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.*;
    
    public class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[2]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[1].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.DeviceSportprofileView.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil();
            return;
        }
    }
}


