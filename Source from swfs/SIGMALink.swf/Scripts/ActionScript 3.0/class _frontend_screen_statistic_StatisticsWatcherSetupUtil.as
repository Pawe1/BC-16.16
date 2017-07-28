//class _frontend_screen_statistic_StatisticsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.statistic.*;
    
    public class _frontend_screen_statistic_StatisticsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_statistic_StatisticsWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.PropertyWatcher("_buttonIconOffsetX", {"propertyChange":true}, [arg4[6]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2]], null);
            arg5[3] = new feathers.binding.PropertyWatcher("loading", {"propertyChange":true}, [arg4[3], arg4[5]], arg2);
            arg5[9] = new feathers.binding.PropertyWatcher("_buttonLabelOffsetY", {"propertyChange":true}, [arg4[10]], arg2);
            arg5[8] = new feathers.binding.PropertyWatcher("_buttonLabelOffsetX", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("yearSelectionVisible", {"propertyChange":true}, [arg4[8], arg4[12]], arg2);
            arg5[5].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[3].updateParent(arg1);
            arg5[9].updateParent(arg1);
            arg5[8].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[7].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.statistic.Statistics.watcherSetupUtil = new _frontend_screen_statistic_StatisticsWatcherSetupUtil();
            return;
        }
    }
}


