//class _frontend_screen_mydevices_MyDeviceSettingsWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_MyDeviceSettingsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_MyDeviceSettingsWatcherSetupUtil()
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
            frontend.screen.mydevices.MyDeviceSettings.watcherSetupUtil = new _frontend_screen_mydevices_MyDeviceSettingsWatcherSetupUtil();
            return;
        }
    }
}


