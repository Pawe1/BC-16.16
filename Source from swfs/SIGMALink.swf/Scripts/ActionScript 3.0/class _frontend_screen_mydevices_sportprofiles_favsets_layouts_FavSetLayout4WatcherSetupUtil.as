//class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout4WatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    
    public class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout4WatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout4WatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[4] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[4], arg4[10]], arg2);
            arg5[3] = new feathers.binding.PropertyWatcher("defaultFunctions", {"propertyChange":true}, [arg4[3], arg4[9]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("favFunctionList", {"propertyChange":true}, [arg4[5], arg4[11]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("showLabel", {"propertyChange":true}, [arg4[6], arg4[12]], arg2);
            arg5[4].updateParent(arg1);
            arg5[3].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[6].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout4.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout4WatcherSetupUtil();
            return;
        }
    }
}


