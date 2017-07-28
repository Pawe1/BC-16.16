//class _frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.tabs.map.*;
    
    public class _frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[7] = new feathers.binding.StaticPropertyWatcher("footerHeight", {"propertyChange":true}, [arg4[4]], null);
            arg5[9] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[6]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[6] = new feathers.binding.StaticPropertyWatcher("headerHeight", {"propertyChange":true}, [arg4[4], arg4[7]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appHeight", {"propertyChange":true}, [arg4[4]], null);
            arg5[7].updateParent(SIGMALink);
            arg5[9].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            arg5[6].updateParent(SIGMALink);
            arg5[5].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.map.ActivityMapTabView.watcherSetupUtil = new _frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil();
            return;
        }
    }
}


