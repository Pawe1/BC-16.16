//class _frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.tabs.graph.*;
    
    public class _frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[4]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[5].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.tabs.graph.ActivityGraphTabView.watcherSetupUtil = new _frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil();
            return;
        }
    }
}


