//class _frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.component.*;
    
    public class _frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[8] = new feathers.binding.PropertyWatcher("valueLayout", {"propertyChange":true}, [arg4[12]], arg2);
            arg5[3] = new feathers.binding.PropertyWatcher("padding", {"propertyChange":true}, [arg4[3], arg4[4], arg4[5], arg4[10], arg4[15], arg4[21], arg4[22]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("iconAndLabelLayout", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("gap", {"propertyChange":true}, [arg4[9], arg4[13], arg4[19]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[7]], null);
            arg5[10] = new feathers.binding.PropertyWatcher("unitLayout", {"propertyChange":true}, [arg4[17]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [arg4[1], arg4[6]], arg2);
            arg5[8].updateParent(arg1);
            arg5[3].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[6].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[10].updateParent(arg1);
            arg5[1].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.component.ActivityValueComp.watcherSetupUtil = new _frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil();
            return;
        }
    }
}


