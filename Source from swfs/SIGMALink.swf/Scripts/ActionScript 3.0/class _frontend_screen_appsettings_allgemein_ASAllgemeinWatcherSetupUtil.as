//class _frontend_screen_appsettings_allgemein_ASAllgemeinWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.allgemein.*;
    
    public class _frontend_screen_appsettings_allgemein_ASAllgemeinWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_allgemein_ASAllgemeinWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.allgemein.ASAllgemein.watcherSetupUtil = new _frontend_screen_appsettings_allgemein_ASAllgemeinWatcherSetupUtil();
            return;
        }
    }
}


