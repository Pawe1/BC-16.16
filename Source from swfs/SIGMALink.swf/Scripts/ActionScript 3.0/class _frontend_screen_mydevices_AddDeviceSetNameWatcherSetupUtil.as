//class _frontend_screen_mydevices_AddDeviceSetNameWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_AddDeviceSetNameWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_AddDeviceSetNameWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[19] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[20], arg4[29], arg4[33]], null);
            arg5[8] = new feathers.binding.PropertyWatcher("_deviceTexture", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[17] = new feathers.binding.PropertyWatcher("_saveNameObj", {"propertyChange":true}, [arg4[18]], arg2);
            arg5[11] = new feathers.binding.PropertyWatcher("_deviceName", {"propertyChange":true}, [arg4[13]], arg2);
            arg5[20] = new feathers.binding.PropertyWatcher("_showConfirmPairingText", {"propertyChange":true}, [arg4[22], arg4[24], arg4[34], arg4[36]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[2]], null);
            arg5[16] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[17]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [arg4[5]], null);
            arg5[13] = new feathers.binding.PropertyWatcher("_infoLabel", {"propertyChange":true}, [arg4[15]], arg2);
            arg5[14] = new feathers.binding.PropertyWatcher("unit", {"propertyChange":true}, [arg4[16]], arg2);
            arg5[15] = new feathers.binding.PropertyWatcher("externalName", {"externalNameChange":true}, [arg4[16]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7], arg4[25], arg4[37]], null);
            arg5[19].updateParent(SIGMALink);
            arg5[8].updateParent(arg1);
            arg5[17].updateParent(arg1);
            arg5[11].updateParent(arg1);
            arg5[20].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[16].updateParent(frontend.components.menuList.MenuList);
            arg5[5].updateParent(frontend.components.menuList.MenuList);
            arg5[13].updateParent(arg1);
            arg5[14].updateParent(arg1);
            arg5[14].addChild(arg5[15]);
            arg5[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.AddDeviceSetName.watcherSetupUtil = new _frontend_screen_mydevices_AddDeviceSetNameWatcherSetupUtil();
            return;
        }
    }
}


