//class _frontend_screen_appsettings_konten_strava_ASStravaWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.konten.strava.*;
    
    public class _frontend_screen_appsettings_konten_strava_ASStravaWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_strava_ASStravaWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.konten.strava.ASStrava.watcherSetupUtil = new _frontend_screen_appsettings_konten_strava_ASStravaWatcherSetupUtil();
            return;
        }
    }
}


