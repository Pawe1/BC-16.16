//class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout14WatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    
    public class _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout14WatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout14WatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[6], arg4[12], arg4[18], arg4[26], arg4[32]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("defaultFunctions", {"propertyChange":true}, [arg4[5], arg4[11], arg4[17], arg4[25], arg4[31]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("showLabel", {"propertyChange":true}, [arg4[8], arg4[14], arg4[20], arg4[28], arg4[34]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("hLayout", {"propertyChange":true}, [arg4[1], arg4[21]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("favFunctionList", {"propertyChange":true}, [arg4[7], arg4[13], arg4[19], arg4[27], arg4[33]], arg2);
            arg5[5].updateParent(arg1);
            arg5[4].updateParent(arg1);
            arg5[7].updateParent(arg1);
            arg5[1].updateParent(arg1);
            arg5[6].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout14.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout14WatcherSetupUtil();
            return;
        }
    }
}


