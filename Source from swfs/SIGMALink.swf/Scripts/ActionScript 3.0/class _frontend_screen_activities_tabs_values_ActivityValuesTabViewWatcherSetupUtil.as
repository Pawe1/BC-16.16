//class _frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.tabs.values.*;
    
    public class _frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[6] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[7]], null);
            arg5[2] = new feathers.binding.PropertyWatcher("dataProvider", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[5]], null);
            arg5[6].updateParent(SIGMALink);
            arg5[2].updateParent(arg1);
            arg5[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.values.ActivityValuesTabView.watcherSetupUtil = new _frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil();
            return;
        }
    }
}


