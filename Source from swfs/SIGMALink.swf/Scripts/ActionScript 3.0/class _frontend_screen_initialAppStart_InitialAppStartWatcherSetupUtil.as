//class _frontend_screen_initialAppStart_InitialAppStartWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialAppStartWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialAppStartWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[4] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[8]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[3], arg4[6], arg4[9]], null);
            arg5[4].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialAppStart.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialAppStartWatcherSetupUtil();
            return;
        }
    }
}


