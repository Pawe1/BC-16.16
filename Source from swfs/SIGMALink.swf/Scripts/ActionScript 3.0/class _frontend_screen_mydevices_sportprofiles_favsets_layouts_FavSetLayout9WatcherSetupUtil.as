//class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout9WatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    
    public class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout9WatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout9WatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.PropertyWatcher("hLayout", {"propertyChange":true}, [arg4[1]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[6], arg4[12], arg4[18]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("defaultFunctions", {"propertyChange":true}, [arg4[5], arg4[11], arg4[17]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("favFunctionList", {"propertyChange":true}, [arg4[7], arg4[13], arg4[19]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("showLabel", {"propertyChange":true}, [arg4[8], arg4[14], arg4[20]], arg2);
            arg5[1].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[4].updateParent(arg1);
            arg5[6].updateParent(arg1);
            arg5[7].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout9.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout9WatcherSetupUtil();
            return;
        }
    }
}


