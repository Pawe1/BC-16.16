//class _frontend_screen_appsettings_konten_twitter_ASTwitterWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.konten.twitter.*;
    
    public class _frontend_screen_appsettings_konten_twitter_ASTwitterWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_twitter_ASTwitterWatcherSetupUtil()
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
            frontend.screen.appsettings.konten.twitter.ASTwitter.watcherSetupUtil = new _frontend_screen_appsettings_konten_twitter_ASTwitterWatcherSetupUtil();
            return;
        }
    }
}


