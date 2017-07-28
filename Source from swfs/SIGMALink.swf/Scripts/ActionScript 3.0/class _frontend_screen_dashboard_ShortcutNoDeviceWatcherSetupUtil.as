//class _frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.dashboard.*;
    
    public class _frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3]], null);
            arg5[4] = new feathers.binding.PropertyWatcher("_leftGroupWidth", {"propertyChange":true}, [arg4[7], arg4[9]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("padding", {"propertyChange":true}, [arg4[5]], null);
            arg5[1].updateParent(SIGMALink);
            arg5[4].updateParent(arg1);
            arg5[2].updateParent(frontend.screen.dashboard.Dashboard);
            return;
        }

        public static function init():void
        {
            frontend.screen.dashboard.ShortcutNoDevice.watcherSetupUtil = new _frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil();
            return;
        }
    }
}


