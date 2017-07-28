//class _frontend_screen_activities_ActivitiesListWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.*;
    
    public class _frontend_screen_activities_ActivitiesListWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_ActivitiesListWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("footerHeight", {"propertyChange":true}, [arg4[2]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[5]], null);
            arg5[3] = new feathers.binding.PropertyWatcher("_activityList", {"propertyChange":true}, [arg4[3]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[5].updateParent(SIGMALink);
            arg5[3].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.ActivitiesList.watcherSetupUtil = new _frontend_screen_activities_ActivitiesListWatcherSetupUtil();
            return;
        }
    }
}


