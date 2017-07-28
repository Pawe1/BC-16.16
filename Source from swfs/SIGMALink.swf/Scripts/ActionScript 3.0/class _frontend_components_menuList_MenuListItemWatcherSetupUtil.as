//class _frontend_components_menuList_MenuListItemWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    
    public class _frontend_components_menuList_MenuListItemWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_menuList_MenuListItemWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[19] = new feathers.binding.PropertyWatcher("maxRightLabelWidth", {"propertyChange":true}, [arg4[26]], arg2);
            arg5[12] = new feathers.binding.PropertyWatcher("leftSubLabelText", {"propertyChange":true}, [arg4[13]], arg2);
            arg5[22] = new feathers.binding.PropertyWatcher("type", {"propertyChange":true}, [arg4[30], arg4[33], arg4[35], arg4[36], arg4[39]], arg2);
            arg5[10] = new feathers.binding.PropertyWatcher("_displaySubText", {"propertyChange":true}, [arg4[11], arg4[14]], arg2);
            arg5[14] = new feathers.binding.PropertyWatcher("leftSubLabelText2", {"propertyChange":true}, [arg4[17]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("minItemHeight", {"propertyChange":true}, [arg4[1], arg4[43], arg4[49]], arg2);
            arg5[33] = new feathers.binding.PropertyWatcher("isSelected", {"propertyChange":true}, [arg4[47]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("itemWidth", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[24] = new feathers.binding.PropertyWatcher("checked", {"propertyChange":true}, [arg4[31]], arg2);
            arg5[0] = new feathers.binding.PropertyWatcher("customBackgroundSkin", {"propertyChange":true}, [arg4[0]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("padding", {"propertyChange":true}, [arg4[4], arg4[21], arg4[38], arg4[48]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("displayText", {"propertyChange":true}, [arg4[7], arg4[10]], arg2);
            arg5[18] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[25], arg4[32]], arg2);
            arg5[13] = new feathers.binding.PropertyWatcher("_displaySubText2", {"propertyChange":true}, [arg4[15], arg4[18]], arg2);
            arg5[28] = new feathers.binding.PropertyWatcher("_functionBtnText", {"propertyChange":true}, [arg4[37]], arg2);
            arg5[9] = new feathers.binding.PropertyWatcher("_leftLabelText", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[17] = new feathers.binding.PropertyWatcher("showValue", {"propertyChange":true}, [arg4[24], arg4[29]], arg2);
            arg5[27] = new feathers.binding.PropertyWatcher("functionButtonVisible", {"propertyChange":true}, [arg4[36], arg4[39]], arg2);
            arg5[3] = new feathers.binding.PropertyWatcher("hasIcon", {"propertyChange":true}, [arg4[3], arg4[5]], arg2);
            arg5[31] = new feathers.binding.PropertyWatcher("selectMode", {"propertyChange":true}, [arg4[44], arg4[45]], arg2);
            arg5[15] = new feathers.binding.PropertyWatcher("hasChild", {"propertyChange":true}, [arg4[20], arg4[23]], arg2);
            arg5[21] = new feathers.binding.PropertyWatcher("formattedValue", {"propertyChange":true}, [arg4[28]], arg2);
            arg5[19].updateParent(arg1);
            arg5[12].updateParent(arg1);
            arg5[22].updateParent(arg1);
            arg5[10].updateParent(arg1);
            arg5[14].updateParent(arg1);
            arg5[1].updateParent(arg1);
            arg5[33].updateParent(arg1);
            arg5[2].updateParent(arg1);
            arg5[24].updateParent(arg1);
            arg5[0].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[7].updateParent(arg1);
            arg5[18].updateParent(arg1);
            arg5[13].updateParent(arg1);
            arg5[28].updateParent(arg1);
            arg5[9].updateParent(arg1);
            arg5[17].updateParent(arg1);
            arg5[27].updateParent(arg1);
            arg5[3].updateParent(arg1);
            arg5[31].updateParent(arg1);
            arg5[15].updateParent(arg1);
            arg5[21].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.components.menuList.MenuListItem.watcherSetupUtil = new _frontend_components_menuList_MenuListItemWatcherSetupUtil();
            return;
        }
    }
}


