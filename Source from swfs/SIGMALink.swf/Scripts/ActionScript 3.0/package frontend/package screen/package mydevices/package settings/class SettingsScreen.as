//class SettingsScreen
package frontend.screen.mydevices.settings 
{
    import __AS3__.vec.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import feathers.data.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class SettingsScreen extends frontend.screen.mydevices.list.MenuItemListScreen
    {
        public function SettingsScreen()
        {
            super();
            allowCaching = false;
            savePropertiesForBackNavigation = true;
            return;
        }

        protected override function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addFavListItem(arg1:String, arg2:String, arg3:Object, arg4:feathers.data.ListCollection):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addFavListItem(arg1, arg2, arg3, arg4);
            loc1.saveCompleteCallback = this.onFavSettingsChanged;
            return loc1;
        }

        protected override function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemNumberInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemDateInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addListItemZoneInput(arg1:String, arg2:String, arg3:String, arg4:Object, arg5:Number, arg6:Number, arg7:Number, arg8:utils.interfaces.ICustomFormatterBase, arg9:utils.converter.IConverter, arg10:Boolean, arg11:int, arg12:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemZoneInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            if (arg10) 
            {
                loc1.saveCompleteCallback = this.onSettingsChanged;
            }
            return loc1;
        }

        protected override function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getDBObject(arg1);
            loc1.keyField = core.settings.SettingsMapper.col_GUID;
            loc1.keyValue = this.setting.GUID;
            loc1.table = core.settings.SettingsMapper.table_name;
            return loc1;
        }

        protected override function getMultiDBObject(arg1:String, arg2:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getMultiDBObject(arg1, arg2);
            loc1.keyField = core.settings.SettingsMapper.col_GUID;
            loc1.keyValue = this.setting.GUID;
            loc1.table = core.settings.SettingsMapper.table_name;
            return loc1;
        }

        protected function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            var loc1:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc1);
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected function onFavSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=arg1.saveToDbUseUpdateObject.updateField;
            if (hasString(loc5, "favoritesTrip1_", "favoritesTrip2_")) 
            {
                loc1 = loc5.split("_");
                if (hasString(loc5, "favoritesTrip1_")) 
                {
                    (this.setting as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc1[1]] = arg2.rawValue.toString();
                }
                else 
                {
                    (this.setting as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc1[1]] = arg2.rawValue.toString();
                }
            }
            else if (hasString(loc5, "favoritesTrack1_", "favoritesTrack2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesTrack1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesTrack).favoritesTrack[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesAltitude1_", "favoritesAltitude2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesAltitude1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesLap1_", "favoritesLap2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesLap1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesLap).favoritesLap[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesCustomA_PageCount", "favoritesCustomB_PageCount")) 
            {
                loc3 = hasString(loc5, "favoritesCustomA_PageCount") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[loc3] = parseInt(arg2.rawValue.toString());
            }
            else if (hasString(loc5, "favoritesCustom")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("favoritesCustom");
                loc1 = (loc1[1] as String).split("_");
                loc2 = (parseInt(loc1[0]) - 1);
                loc3 = loc1[1] != "A" ? 1 : 0;
                (this.setting as core.settings.interfaces.IFavoritesCustom).favoritesCustom[loc3][loc2] = arg2.rawValue.toString();
            }
            var loc6:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc6);
            return;
        }

        protected override function createFooterButtons():void
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.image = frontend.Textures.uploadicon;
            loc1.touchHandler = this.toDevice_handler;
            var loc2:*=new Vector.<frontend.components.button.IconButton>();
            loc2.push(loc1);
            footer.setButtonGroup(loc2);
            return;
        }

        protected function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER, {"unit":this.unit, "settings":this.setting, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public var setting:core.settings.Settings;

        public var unit:core.units.Unit;
    }
}


