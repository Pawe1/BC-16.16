//class _frontend_screen_activities_ActivityEditWatcherSetupUtil
package 
{
    import backend.utils.*;
    import feathers.binding.*;
    import flash.system.*;
    import frontend.components.menuList.*;
    import frontend.screen.activities.*;
    
    public class _frontend_screen_activities_ActivityEditWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_ActivityEditWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[14] = new feathers.binding.PropertyWatcher("_saveUserObj", {"propertyChange":true}, [arg4[18]], arg2);
            arg5[18] = new feathers.binding.PropertyWatcher("_saveBikeObj", {"propertyChange":true}, [arg4[24]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("activity", {"propertyChange":true}, [arg4[3], arg4[7], arg4[12]], arg2);
            arg5[3] = new feathers.binding.PropertyWatcher("name", {"propertyChange":true}, [arg4[3]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("startDate", {"propertyChange":true}, [arg4[7], arg4[12]], null);
            arg5[19] = new feathers.binding.PropertyWatcher("isLog", {"propertyChange":true}, [arg4[28], arg4[31]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("_saveNameObj", {"propertyChange":true}, [arg4[5]], arg2);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[8] = new feathers.binding.StaticPropertyWatcher("dateFormatter", {"propertyChange":true}, [arg4[8]], null);
            arg5[16] = new feathers.binding.PropertyWatcher("_saveSportObj", {"propertyChange":true}, [arg4[21]], arg2);
            arg5[9] = new feathers.binding.PropertyWatcher("_saveDateObj", {"propertyChange":true}, [arg4[10]], arg2);
            arg5[11] = new feathers.binding.StaticPropertyWatcher("dateTimeFormatter", {"propertyChange":true}, [arg4[13]], null);
            arg5[12] = new feathers.binding.PropertyWatcher("_saveDatetimeObj", {"propertyChange":true}, [arg4[15]], arg2);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[4], arg4[9], arg4[14], arg4[17], arg4[20], arg4[23], arg4[26], arg4[29], arg4[33]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[2]], null);
            arg5[20] = new feathers.binding.StaticPropertyWatcher("isDebugger", null, [arg4[32], arg4[35]], null);
            arg5[14].updateParent(arg1);
            arg5[18].updateParent(arg1);
            arg5[2].updateParent(arg1);
            arg5[2].addChild(arg5[3]);
            arg5[2].addChild(arg5[7]);
            arg5[19].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[0].updateParent(SIGMALink);
            arg5[8].updateParent(backend.utils.DataUtils);
            arg5[16].updateParent(arg1);
            arg5[9].updateParent(arg1);
            arg5[11].updateParent(backend.utils.DataUtils);
            arg5[12].updateParent(arg1);
            arg5[4].updateParent(frontend.components.menuList.MenuList);
            arg5[1].updateParent(SIGMALink);
            arg5[20].updateParent(flash.system.Capabilities);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.ActivityEdit.watcherSetupUtil = new _frontend_screen_activities_ActivityEditWatcherSetupUtil();
            return;
        }
    }
}


