//class _frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.charts.*;
    
    public class _frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[2], arg4[7], arg4[8], arg4[10]], null);
            arg5[4] = new feathers.binding.PropertyWatcher("calloutTitel", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("_calloutWidth", {"propertyChange":true}, [arg4[1], arg4[6], arg4[11], arg4[13]], arg2);
            arg5[2].updateParent(SIGMALink);
            arg5[4].updateParent(arg1);
            arg5[1].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.components.charts.StatisticColumnChartCallout.watcherSetupUtil = new _frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil();
            return;
        }
    }
}


