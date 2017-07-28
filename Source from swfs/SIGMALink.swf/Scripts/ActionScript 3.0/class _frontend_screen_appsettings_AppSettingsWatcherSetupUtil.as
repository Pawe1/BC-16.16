//class _frontend_screen_appsettings_AppSettingsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.*;
    
    public class _frontend_screen_appsettings_AppSettingsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_AppSettingsWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [arg4[6], arg4[10], arg4[14], arg4[18], arg4[22], arg4[26]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[3]], null);
            arg5[5].updateParent(frontend.components.menuList.MenuList);
            arg5[1].updateParent(SIGMALink);
            arg5[2].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.AppSettings.watcherSetupUtil = new _frontend_screen_appsettings_AppSettingsWatcherSetupUtil();
            return;
        }
    }
}


