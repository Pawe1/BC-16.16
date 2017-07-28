//class _frontend_screen_component_devices_CommunicationStateWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.component.devices.*;
    
    public class _frontend_screen_component_devices_CommunicationStateWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_component_devices_CommunicationStateWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[11] = new feathers.binding.PropertyWatcher("_howtoImageTextureName", {"propertyChange":true}, [arg4[14]], arg2);
            arg5[9] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [arg4[11], arg4[19], arg4[31]], null);
            arg5[28] = new feathers.binding.PropertyWatcher("unitChangeable", {"propertyChange":true}, [arg4[48], arg4[51]], arg2);
            arg5[23] = new feathers.binding.PropertyWatcher("_deviceTexture", {"propertyChange":true}, [arg4[41]], arg2);
            arg5[12] = new feathers.binding.PropertyWatcher("_showConnectPicture", {"propertyChange":true}, [arg4[15]], arg2);
            arg5[27] = new feathers.binding.PropertyWatcher("_deviceName", {"propertyChange":true}, [arg4[47]], arg2);
            arg5[8] = new feathers.binding.PropertyWatcher("_spacerHeight", {"propertyChange":true}, [arg4[9], arg4[38]], arg2);
            arg5[14] = new feathers.binding.PropertyWatcher("_infoText", {"propertyChange":true}, [arg4[18]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("_useSmallLayout", {"propertyChange":true}, [arg4[3], arg4[6], arg4[9], arg4[13], arg4[28], arg4[30]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("headline", {"propertyChange":true}, [arg4[5]], arg2);
            arg5[16] = new feathers.binding.PropertyWatcher("_showEnableBLEButton", {"propertyChange":true}, [arg4[22], arg4[24]], arg2);
            arg5[24] = new feathers.binding.StaticPropertyWatcher("NAME_PADDING_LEFT", {"propertyChange":true}, [arg4[43]], arg3);
            arg5[7] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [arg4[9], arg4[36]], null);
            arg5[15] = new feathers.binding.PropertyWatcher("loading", {"propertyChange":true}, [arg4[20], arg4[21]], arg2);
            arg5[18] = new feathers.binding.PropertyWatcher("_showEnableNFCButton", {"propertyChange":true}, [arg4[25], arg4[27]], arg2);
            arg5[6] = new feathers.binding.StaticPropertyWatcher("HEADLINE_HEIGHT", {"propertyChange":true}, [arg4[9]], null);
            arg5[13] = new feathers.binding.PropertyWatcher("_infoStyleName", {"propertyChange":true}, [arg4[17]], arg2);
            arg5[10] = new feathers.binding.StaticPropertyWatcher("ICON_PADDING_LEFT", {"propertyChange":true}, [arg4[12], arg4[16], arg4[40]], arg3);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[7], arg4[10], arg4[16], arg4[39]], null);
            arg5[22] = new feathers.binding.PropertyWatcher("videoText", {"propertyChange":true}, [arg4[34]], arg2);
            arg5[11].updateParent(arg1);
            arg5[9].updateParent(SIGMALink);
            arg5[28].updateParent(arg1);
            arg5[23].updateParent(arg1);
            arg5[12].updateParent(arg1);
            arg5[27].updateParent(arg1);
            arg5[8].updateParent(arg1);
            arg5[14].updateParent(arg1);
            arg5[2].updateParent(arg1);
            arg5[4].updateParent(arg1);
            arg5[16].updateParent(arg1);
            arg5[24].updateParent(frontend.screen.component.devices.CommunicationState);
            arg5[7].updateParent(frontend.components.menuList.MenuList);
            arg5[15].updateParent(arg1);
            arg5[18].updateParent(arg1);
            arg5[6].updateParent(frontend.components.menuList.MenuList);
            arg5[13].updateParent(arg1);
            arg5[10].updateParent(frontend.screen.component.devices.CommunicationState);
            arg5[1].updateParent(SIGMALink);
            arg5[22].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.component.devices.CommunicationState.watcherSetupUtil = new _frontend_screen_component_devices_CommunicationStateWatcherSetupUtil();
            return;
        }
    }
}


