//class _frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[3], arg4[5]], null);
            arg5[3] = new feathers.binding.PropertyWatcher("_scrollerHeight", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[6]], null);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("PADDING", {"propertyChange":true}, [arg4[5]], null);
            arg5[2].updateParent(frontend.components.menuList.MenuList);
            arg5[3].updateParent(arg1);
            arg5[5].updateParent(SIGMALink);
            arg5[4].updateParent(frontend.screen.initialAppStart.InitialAppStart);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialAppSettings.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil();
            return;
        }
    }
}


