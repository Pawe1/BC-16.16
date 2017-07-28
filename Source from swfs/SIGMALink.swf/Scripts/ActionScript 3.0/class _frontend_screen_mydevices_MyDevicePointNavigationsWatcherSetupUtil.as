//class _frontend_screen_mydevices_MyDevicePointNavigationsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_MyDevicePointNavigationsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_MyDevicePointNavigationsWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[7] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[7]], null);
            arg5[10] = new feathers.binding.PropertyWatcher("listLoader", {"propertyChange":true}, [arg4[10], arg4[11], arg4[18], arg4[19]], arg2);
            arg5[11] = new feathers.binding.PropertyWatcher("listStateHandler", {"propertyChange":true}, [arg4[10], arg4[11], arg4[18], arg4[19]], null);
            arg5[12] = new feathers.binding.PropertyWatcher("editState", {"propertyChange":true}, [arg4[10], arg4[11], arg4[18], arg4[19]], null);
            arg5[9] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[9]], null);
            arg5[8] = new feathers.binding.PropertyWatcher("_customList", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[7].updateParent(SIGMALink);
            arg5[10].updateParent(arg1);
            arg5[10].addChild(arg5[11]);
            arg5[11].addChild(arg5[12]);
            arg5[9].updateParent(SIGMALink);
            arg5[8].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.MyDevicePointNavigations.watcherSetupUtil = new _frontend_screen_mydevices_MyDevicePointNavigationsWatcherSetupUtil();
            return;
        }
    }
}


