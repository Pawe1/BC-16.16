//class _frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[7] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[9]], null);
            arg5[0] = new feathers.binding.PropertyWatcher("vl", {"propertyChange":true}, [arg4[0], arg4[8]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7], arg4[10], arg4[12], arg4[14]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("PADDING", {"propertyChange":true}, [arg4[4], arg4[7], arg4[9], arg4[10], arg4[12], arg4[14]], null);
            arg5[7].updateParent(SIGMALink);
            arg5[0].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[3].updateParent(frontend.screen.initialAppStart.InitialAppStart);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialStartComplete.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil();
            return;
        }
    }
}


