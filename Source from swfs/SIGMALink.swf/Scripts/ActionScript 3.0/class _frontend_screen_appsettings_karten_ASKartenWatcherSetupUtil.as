//class _frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.karten.*;
    
    public class _frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[3], arg4[11]], null);
            arg5[6] = new feathers.binding.PropertyWatcher("_dirSizeLabel", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[6].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.karten.ASKarten.watcherSetupUtil = new _frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil();
            return;
        }
    }
}


