//class _frontend_screen_mydevices_settings_DeviceSettingUserWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.settings.*;
    
    public class _frontend_screen_mydevices_settings_DeviceSettingUserWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_settings_DeviceSettingUserWatcherSetupUtil()
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
            frontend.screen.mydevices.settings.DeviceSettingUser.watcherSetupUtil = new _frontend_screen_mydevices_settings_DeviceSettingUserWatcherSetupUtil();
            return;
        }
    }
}


