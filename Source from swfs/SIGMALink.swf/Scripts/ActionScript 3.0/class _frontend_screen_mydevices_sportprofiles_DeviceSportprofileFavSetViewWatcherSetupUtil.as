//class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.*;
    
    public class _frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[14] = new feathers.binding.PropertyWatcher("_favSetMaxCount", {"propertyChange":true}, [arg4[19]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("active", {"propertyChange":true}, [arg4[5]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[13]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("_pageLabel", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("favsetNr", {"propertyChange":true}, [arg4[6], arg4[7]], arg2);
            arg5[14].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[2].updateParent(SIGMALink);
            arg5[7].updateParent(arg1);
            arg5[6].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.DeviceSportprofileFavSetView.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil();
            return;
        }
    }
}


