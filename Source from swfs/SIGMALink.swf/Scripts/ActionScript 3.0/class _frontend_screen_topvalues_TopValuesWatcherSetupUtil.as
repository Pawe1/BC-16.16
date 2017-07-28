//class _frontend_screen_topvalues_TopValuesWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.topvalues.*;
    
    public class _frontend_screen_topvalues_TopValuesWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_topvalues_TopValuesWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.PropertyWatcher("_topValuesList", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("_buttonIconOffsetX", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("selectedYear", {"propertyChange":true}, [arg4[6]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3]], null);
            arg5[9] = new feathers.binding.PropertyWatcher("_buttonLabelOffsetY", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[8] = new feathers.binding.PropertyWatcher("_buttonLabelOffsetX", {"propertyChange":true}, [arg4[7]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(arg1);
            arg5[4].updateParent(arg1);
            arg5[6].updateParent(arg1);
            arg5[3].updateParent(SIGMALink);
            arg5[9].updateParent(arg1);
            arg5[8].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.topvalues.TopValues.watcherSetupUtil = new _frontend_screen_topvalues_TopValuesWatcherSetupUtil();
            return;
        }
    }
}


