//class _frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.component.*;
    
    public class _frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2]], null);
            arg5[2].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.component.ActivityGraphComp.watcherSetupUtil = new _frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil();
            return;
        }
    }
}


