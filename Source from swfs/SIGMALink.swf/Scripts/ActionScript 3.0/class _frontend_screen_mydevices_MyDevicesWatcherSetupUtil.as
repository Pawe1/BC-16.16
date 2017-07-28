//class _frontend_screen_mydevices_MyDevicesWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_MyDevicesWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_MyDevicesWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.PropertyWatcher("deviceList", {"propertyChange":true}, [arg4[1], arg4[2], arg4[7], arg4[8]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("listLoader", {"propertyChange":true}, [arg4[1], arg4[2], arg4[7], arg4[8]], null);
            arg5[3] = new feathers.binding.PropertyWatcher("listStateHandler", {"propertyChange":true}, [arg4[1], arg4[2], arg4[7], arg4[8]], null);
            arg5[4] = new feathers.binding.PropertyWatcher("editState", {"propertyChange":true}, [arg4[1], arg4[2], arg4[7], arg4[8]], null);
            arg5[1].updateParent(arg1);
            arg5[1].addChild(arg5[2]);
            arg5[2].addChild(arg5[3]);
            arg5[3].addChild(arg5[4]);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.MyDevices.watcherSetupUtil = new _frontend_screen_mydevices_MyDevicesWatcherSetupUtil();
            return;
        }
    }
}


