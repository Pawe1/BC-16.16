//class _frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    
    public class _frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[3], arg4[4], arg4[7]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("_labelMaxWidth", {"propertyChange":true}, [arg4[10]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("label", {"propertyChange":true}, [arg4[12]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("showLabel", {"propertyChange":true}, [arg4[8], arg4[13]], arg2);
            arg5[1].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[7].updateParent(arg1);
            arg5[4].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.watcherSetupUtil = new _frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil();
            return;
        }
    }
}


