//class _frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.konten.*;
    
    public class _frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[8] = new feathers.binding.PropertyWatcher("_showNextButton", {"propertyChange":true}, [arg4[11], arg4[12]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("oauthInstance", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[3], arg4[4]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[8].updateParent(arg1);
            arg5[2].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.konten.ASKontoSettings.watcherSetupUtil = new _frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil();
            return;
        }
    }
}


