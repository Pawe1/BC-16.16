//class _frontend_screen_mydevices_transfer_ActivitiesTransferWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.transfer.*;
    
    public class _frontend_screen_mydevices_transfer_ActivitiesTransferWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_transfer_ActivitiesTransferWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.transfer.ActivitiesTransfer.watcherSetupUtil = new _frontend_screen_mydevices_transfer_ActivitiesTransferWatcherSetupUtil();
            return;
        }
    }
}


