//class _frontend_screen_appsettings_konten_facebook_ASFacebookWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.appsettings.konten.facebook.*;
    
    public class _frontend_screen_appsettings_konten_facebook_ASFacebookWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_facebook_ASFacebookWatcherSetupUtil()
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
            frontend.screen.appsettings.konten.facebook.ASFacebook.watcherSetupUtil = new _frontend_screen_appsettings_konten_facebook_ASFacebookWatcherSetupUtil();
            return;
        }
    }
}


