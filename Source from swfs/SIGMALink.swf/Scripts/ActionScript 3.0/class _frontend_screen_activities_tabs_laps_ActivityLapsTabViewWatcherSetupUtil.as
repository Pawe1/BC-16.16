//class _frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.tabs.laps.*;
    
    public class _frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[4] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[4], arg4[7], arg4[10], arg4[12], arg4[15]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[5], arg4[11], arg4[13]], null);
            arg5[4].updateParent(SIGMALink);
            arg5[5].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.laps.ActivityLapsTabView.watcherSetupUtil = new _frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil();
            return;
        }
    }
}


