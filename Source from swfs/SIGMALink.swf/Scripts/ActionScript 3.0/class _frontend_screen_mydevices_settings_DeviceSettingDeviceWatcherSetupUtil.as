//class _frontend_screen_mydevices_settings_DeviceSettingDeviceWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.settings.*;
    
    public class _frontend_screen_mydevices_settings_DeviceSettingDeviceWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_settings_DeviceSettingDeviceWatcherSetupUtil()
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
            frontend.screen.mydevices.settings.DeviceSettingDevice.watcherSetupUtil = new _frontend_screen_mydevices_settings_DeviceSettingDeviceWatcherSetupUtil();
            return;
        }
    }
}


