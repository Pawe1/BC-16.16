//class _frontend_screen_activities_ActivityViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.*;
    
    public class _frontend_screen_activities_ActivityViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_ActivityViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[7]], null);
            arg5[8] = new feathers.binding.PropertyWatcher("_ghostVisible", {"propertyChange":true}, [arg4[11], arg4[13], arg4[14]], arg2);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[5]], null);
            arg5[1].updateParent(SIGMALink);
            arg5[8].updateParent(arg1);
            arg5[4].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.ActivityView.watcherSetupUtil = new _frontend_screen_activities_ActivityViewWatcherSetupUtil();
            return;
        }
    }
}


