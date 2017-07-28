//class _frontend_screen_dashboard_DashboardWatcherSetupUtil
package 
{
    import backend.utils.*;
    import feathers.binding.*;
    import frontend.screen.dashboard.*;
    
    public class _frontend_screen_dashboard_DashboardWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_dashboard_DashboardWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("padding", {"propertyChange":true}, [arg4[3], arg4[5]], arg3);
            arg5[17] = new feathers.binding.PropertyWatcher("_optionalShortcutsPaddingBottom", {"propertyChange":true}, [arg4[32]], arg2);
            arg5[16] = new feathers.binding.StaticPropertyWatcher("unitStringDistance", {"propertyChange":true}, [arg4[26]], null);
            arg5[1].updateParent(frontend.screen.dashboard.Dashboard);
            arg5[17].updateParent(arg1);
            arg5[16].updateParent(backend.utils.DataUtils);
            return;
        }

        public static function init():void
        {
            frontend.screen.dashboard.Dashboard.watcherSetupUtil = new _frontend_screen_dashboard_DashboardWatcherSetupUtil();
            return;
        }
    }
}


