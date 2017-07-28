//class _frontend_screen_mydevices_MyDeviceGeneralWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_MyDeviceGeneralWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_MyDeviceGeneralWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[7] = new feathers.binding.PropertyWatcher("_saveDeviceNameObj", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[15] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [arg4[25]], null);
            arg5[9] = new feathers.binding.PropertyWatcher("_unitTypeStr", {"propertyChange":true}, [arg4[11], arg4[14]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[3] = new feathers.binding.PropertyWatcher("unit", {"propertyChange":true}, [arg4[5], arg4[10], arg4[15], arg4[20], arg4[24]], arg2);
            arg5[10] = new feathers.binding.PropertyWatcher("serialNumber", {"serialNumberChange":true}, [arg4[15]], null);
            arg5[4] = new feathers.binding.PropertyWatcher("externalName", {"externalNameChange":true}, [arg4[5], arg4[10]], null);
            arg5[12] = new feathers.binding.PropertyWatcher("softwareRevision", {"softwareRevisionChange":true}, [arg4[20]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[6], arg4[12], arg4[16], arg4[21]], null);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[4]], null);
            arg5[11] = new feathers.binding.PropertyWatcher("_firmwareButtonLabel", {"propertyChange":true}, [arg4[18]], arg2);
            arg5[7].updateParent(arg1);
            arg5[15].updateParent(frontend.components.menuList.MenuList);
            arg5[9].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[3].updateParent(arg1);
            arg5[3].addChild(arg5[10]);
            arg5[3].addChild(arg5[4]);
            arg5[3].addChild(arg5[12]);
            arg5[5].updateParent(frontend.components.menuList.MenuList);
            arg5[2].updateParent(SIGMALink);
            arg5[11].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.MyDeviceGeneral.watcherSetupUtil = new _frontend_screen_mydevices_MyDeviceGeneralWatcherSetupUtil();
            return;
        }
    }
}


