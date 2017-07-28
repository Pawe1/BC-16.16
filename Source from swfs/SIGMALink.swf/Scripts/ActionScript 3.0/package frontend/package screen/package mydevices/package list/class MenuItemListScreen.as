//class MenuItemListScreen
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.settings.*;
    import starling.display.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class MenuItemListScreen extends frontend.screen.component.CustomScreen
    {
        public function MenuItemListScreen()
        {
            super();
            hasBackwardNavigation = true;
            this.dataProvider = new feathers.data.ListCollection();
            return;
        }

        public override function set mxmlContent(arg1:Array):void
        {
            var loc1:*=null;
            loc1 = [];
            this.menuItemList = new frontend.components.list.CustomList();
            this.menuItemList.allowMultipleSelection = false;
            this.menuItemList.dataProvider = this.dataProvider;
            this.menuItemList.height = SIGMALink.containerHeight;
            this.menuItemList.itemRendererFactory = this.itemRenderer;
            this.menuItemList.width = SIGMALink.appWidth;
            this.menuItemList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.footer = new frontend.screen.component.Footer();
            this.createFooterButtons();
            loc1.push(this.menuItemList);
            loc1.push(this.footer);
            super.mxmlContent = loc1;
            return;
        }

        protected function createFooterButtons():void
        {
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            return new frontend.screen.mydevices.settings.MenuItemListRenderer();
        }

        protected function addHeadline(arg1:String):feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.text = arg1;
            this.dataProvider.addItem(loc1);
            return loc1;
        }

        protected function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = true;
            loc1.type = arg4;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.saveToDbUseUpdateObject.dateAsString = arg7;
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.unitString = arg8;
            if (arg4 != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE) 
            {
                if (arg5) 
                {
                    loc1.dataProvider = arg5;
                }
                loc1.defaultValue = arg3;
            }
            else 
            {
                loc1.checkable = true;
                loc1.checked = arg3;
            }
            if (arg6) 
            {
                loc1.formatter = arg6;
            }
            this.dataProvider.addItem(loc1);
            return loc1;
        }

        protected function addFavListItem(arg1:String, arg2:String, arg3:Object, arg4:feathers.data.ListCollection):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = true;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = false;
            loc1.useLocalesForTitle = false;
            loc1.dataProvider = arg4;
            loc1.defaultValue = arg3;
            this.dataProvider.addItem(loc1);
            return loc1;
        }

        protected function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = true;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.converter = arg7;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            loc1.unitString = arg8;
            this.dataProvider.addItem(loc1);
            return loc1;
        }

        protected function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = true;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.saveToDbUseUpdateObject.dateAsString = arg7;
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            this.dataProvider.addItem(loc1);
            return loc1;
        }

        protected function addListItemZoneInput(arg1:String, arg2:String, arg3:String, arg4:Object, arg5:Number, arg6:Number, arg7:Number, arg8:utils.interfaces.ICustomFormatterBase, arg9:utils.converter.IConverter, arg10:Boolean, arg11:int, arg12:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = arg10;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.saveToDbUseUpdate = arg10;
            if (loc1.saveToDbUseUpdate) 
            {
                loc1.saveToDbUseUpdateObject = this.getMultiDBObject(arg2, arg3);
            }
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.defaultValue = arg4;
            loc1.formatter = arg8;
            loc1.minimum = arg5;
            loc1.maximum = arg6;
            loc1.minimumDifference = arg7;
            loc1.unitString = arg12;
            if (arg11 == -1) 
            {
                this.dataProvider.addItem(loc1);
            }
            else 
            {
                this.dataProvider.addItemAt(loc1, arg11);
            }
            return loc1;
        }

        protected function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.updateField = arg1;
            loc1.updateModificationDate = true;
            return loc1;
        }

        protected function getMultiDBObject(arg1:String, arg2:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.updateField = arg1;
            loc1.updateField2 = arg2;
            loc1.updateModificationDate = true;
            return loc1;
        }

        protected function hasString(arg1:String, arg2:String, arg3:String=""):Boolean
        {
            var loc1:*=!(arg1.indexOf(arg2) == -1);
            var loc2:*=arg3 == "" ? false : !(arg1.indexOf(arg3) == -1);
            return loc1 || loc2;
        }

        protected function getSizeConverter(arg1:String, arg2:String):utils.converter.IConverter
        {
            var loc1:*=new utils.converter.SizeConverter();
            loc1.inputFormat = arg1;
            loc1.outputFormat = arg2;
            return loc1;
        }

        protected function validateEditableElement(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.MenuListItem, arg3:int=1):void
        {
            var loc1:*=this.dataProvider.getItemIndex(arg1);
            var loc2:*=this.dataProvider.getItemIndex(arg2);
            if (arg2.editable) 
            {
                if (loc2 == -1) 
                {
                    this.dataProvider.addItemAt(arg2, loc1 + arg3);
                    this.dataProvider.updateItemAt(loc1 + arg3);
                }
                arg2.validateSizesAndPositions();
            }
            else if (loc2 != -1) 
            {
                this.dataProvider.removeItemAt(loc2);
                this.dataProvider.updateItemAt(loc2);
            }
            return;
        }

        public var dataProvider:feathers.data.ListCollection;

        public var footer:frontend.screen.component.Footer;

        public var menuItemList:frontend.components.list.CustomList;
    }
}


