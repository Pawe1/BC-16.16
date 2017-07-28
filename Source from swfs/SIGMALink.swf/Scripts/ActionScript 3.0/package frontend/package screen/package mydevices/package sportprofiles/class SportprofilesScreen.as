//class SportprofilesScreen
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import core.sportprofiles.*;
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
    
    public class SportprofilesScreen extends frontend.screen.mydevices.list.MenuItemListScreen
    {
        public function SportprofilesScreen()
        {
            super();
            allowCaching = false;
            savePropertiesForBackNavigation = true;
            return;
        }

        protected override function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSportprofileChanged;
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
            loc1.saveCompleteCallback = this.onSportprofileChanged;
            return loc1;
        }

        protected override function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemDateInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            loc1.saveCompleteCallback = this.onSportprofileChanged;
            return loc1;
        }

        protected override function addListItemZoneInput(arg1:String, arg2:String, arg3:String, arg4:Object, arg5:Number, arg6:Number, arg7:Number, arg8:utils.interfaces.ICustomFormatterBase, arg9:utils.converter.IConverter, arg10:Boolean, arg11:int, arg12:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemZoneInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            if (loc1.editable) 
            {
                loc1.saveCompleteCallback = this.onSportprofileChanged;
            }
            return loc1;
        }

        protected override function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getDBObject(arg1);
            loc1.keyField = core.sportprofiles.SportprofileMapper.col_GUID;
            loc1.keyValue = this.sportprofile.GUID;
            loc1.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            loc1.classAttributeName = arg1;
            return loc1;
        }

        protected override function getMultiDBObject(arg1:String, arg2:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getMultiDBObject(arg1, arg2);
            loc1.keyField = core.sportprofiles.SportprofileMapper.col_GUID;
            loc1.keyValue = this.sportprofile.GUID;
            loc1.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            return loc1;
        }

        protected function onSportprofileChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.apply(arg1, arg2);
            return;
        }

        public function apply(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            if (arg1.saveToDbUseUpdateObject.classAttributeName.length > 0) 
            {
                this.sportprofile[arg1.saveToDbUseUpdateObject.classAttributeName] = arg2.rawValue;
            }
            else 
            {
                this.sportprofile[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            }
            var loc1:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc1);
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected function onFavSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
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

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public var sportprofile:core.sportprofiles.Sportprofile;
    }
}


