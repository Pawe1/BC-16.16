//class _frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil
package 
{
    import backend.utils.*;
    import feathers.binding.*;
    import frontend.screen.activities.tabs.phases.*;
    
    public class _frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[15] = new feathers.binding.StaticPropertyWatcher("unitStringTimeHours", {"propertyChange":true}, [arg4[13], arg4[17]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[3]], null);
            arg5[9] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[6], arg4[10]], null);
            arg5[19] = new feathers.binding.StaticPropertyWatcher("unitStringHeartrate", {"propertyChange":true}, [arg4[21]], null);
            arg5[15].updateParent(backend.utils.DataUtils);
            arg5[3].updateParent(SIGMALink);
            arg5[9].updateParent(SIGMALink);
            arg5[19].updateParent(backend.utils.DataUtils);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.phases.ActivityPhasesTabView.watcherSetupUtil = new _frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil();
            return;
        }
    }
}


