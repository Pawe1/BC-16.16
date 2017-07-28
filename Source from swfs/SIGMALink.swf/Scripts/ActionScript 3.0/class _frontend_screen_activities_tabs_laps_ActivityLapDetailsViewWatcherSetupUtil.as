//class _frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.tabs.laps.*;
    
    public class _frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[15] = new feathers.binding.PropertyWatcher("_nextButtonEnabled", {"propertyChange":true}, [arg4[20]], arg2);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[3], arg4[6], arg4[7], arg4[11], arg4[12], arg4[16], arg4[17], arg4[21], arg4[22]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("lapCurrent", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[9] = new feathers.binding.PropertyWatcher("lapTypeLabel", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[12] = new feathers.binding.PropertyWatcher("_prevButtonEnabled", {"propertyChange":true}, [arg4[15]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[4], arg4[5], arg4[10]], null);
            arg5[8] = new feathers.binding.PropertyWatcher("lapAmount", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[15].updateParent(arg1);
            arg5[5].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            arg5[7].updateParent(arg1);
            arg5[9].updateParent(arg1);
            arg5[12].updateParent(arg1);
            arg5[3].updateParent(SIGMALink);
            arg5[8].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.laps.ActivityLapDetailsView.watcherSetupUtil = new _frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil();
            return;
        }
    }
}


