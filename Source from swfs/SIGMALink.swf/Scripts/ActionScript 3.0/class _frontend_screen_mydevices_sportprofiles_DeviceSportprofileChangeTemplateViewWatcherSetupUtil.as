//class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.*;
    
    public class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[6] = new feathers.binding.PropertyWatcher("gap", {"propertyChange":true}, [arg4[7], arg4[8]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[6]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("_cols", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[6].updateParent(arg1);
            arg5[3].updateParent(SIGMALink);
            arg5[7].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeTemplateView.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil();
            return;
        }
    }
}


