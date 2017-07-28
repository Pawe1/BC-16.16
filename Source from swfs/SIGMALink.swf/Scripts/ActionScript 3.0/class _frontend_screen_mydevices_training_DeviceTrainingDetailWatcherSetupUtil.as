//class _frontend_screen_mydevices_training_DeviceTrainingDetailWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.training.*;
    
    public class _frontend_screen_mydevices_training_DeviceTrainingDetailWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_training_DeviceTrainingDetailWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[14] = new feathers.binding.PropertyWatcher("_dataProvider", {"propertyChange":true}, [arg4[23]], arg2);
            arg5[15] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[24]], null);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("PADDING_LEFT", {"propertyChange":true}, [arg4[6]], arg3);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[1], arg4[5], arg4[12], arg4[26]], null);
            arg5[6] = new feathers.binding.PropertyWatcher("_unitName", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[14].updateParent(arg1);
            arg5[15].updateParent(SIGMALink);
            arg5[4].updateParent(frontend.screen.mydevices.training.DeviceTrainingDetail);
            arg5[0].updateParent(SIGMALink);
            arg5[6].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.training.DeviceTrainingDetail.watcherSetupUtil = new _frontend_screen_mydevices_training_DeviceTrainingDetailWatcherSetupUtil();
            return;
        }
    }
}


