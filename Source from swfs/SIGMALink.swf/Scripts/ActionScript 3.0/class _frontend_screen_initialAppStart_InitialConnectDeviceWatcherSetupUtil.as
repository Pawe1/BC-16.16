//class _frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7]], null);
            arg5[8] = new feathers.binding.PropertyWatcher("_selectUnitState", {"propertyChange":true}, [arg4[9], arg4[10], arg4[12], arg4[13]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("_compHeight", {"propertyChange":true}, [arg4[8], arg4[11]], arg2);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("PADDING", {"propertyChange":true}, [arg4[4], arg4[7]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[8].updateParent(arg1);
            arg5[7].updateParent(arg1);
            arg5[3].updateParent(frontend.screen.initialAppStart.InitialAppStart);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialConnectDevice.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil();
            return;
        }
    }
}


