//package list
//  class MenuItemListScreen
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


//  class MyDevicePointNavigationListItem
package frontend.screen.mydevices.list 
{
    import core.gps.*;
    import frontend.components.list.*;
    
    public class MyDevicePointNavigationListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDevicePointNavigationListItem()
        {
            super();
            return;
        }

        public var pointNavigation:core.gps.PointNavigation;
    }
}


//  class MyDevicePointNavigationRenderer
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class MyDevicePointNavigationRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyDevicePointNavigationRenderer()
        {
            super();
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (pointNavigationEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            pointNavigationEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                this.pointNavigation().addSelection();
            }
            else 
            {
                this.pointNavigation().removeSelection();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._optionGroup = new feathers.controls.LayoutGroup();
            this._optionGroup.touchGroup = true;
            this._optionGroup.layout = new feathers.layout.AnchorLayout();
            this._optionGroup.width = OPTION_GROUP_WIDTH;
            this._optionGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._optionGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            this._optionGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onUploadTouch);
            this._group.addChild(this._optionGroup);
            this._sendToDeviceIcon = new frontend.components.TextureImage();
            this._sendToDeviceIcon.touchable = false;
            this._sendToDeviceIcon.textureName = frontend.Textures.uploadicon;
            this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._optionGroup.addChild(this._sendToDeviceIcon);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._name);
            this._description = new feathers.controls.Label();
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, DESCRIPTION_PADDING_BOTTOM, NAME_PADDING_LEFT);
            this._group.addChild(this._description);
            this._subMenuIcon = new frontend.components.TextureImage();
            this._subMenuIcon.touchable = false;
            this._subMenuIcon.textureName = frontend.Textures.pfeilmitbg;
            this._subMenuIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._subMenuIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        internal function onUploadTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.callBackFunction == null) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            arg1.stopImmediatePropagation();
            this.callBackFunction(this.pointNavigation());
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.pointNavigation();
            (this._name.layoutData as feathers.layout.AnchorLayoutData).left = NAME_PADDING_LEFT;
            (this._description.layoutData as feathers.layout.AnchorLayoutData).left = NAME_PADDING_LEFT;
            this._name.text = loc1.pointNavigation.text1;
            this._description.text = loc1.pointNavigation.text2;
            this._subMenuIcon.visible = !pointNavigationEditState;
            this._subMenuIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._subMenuIcon.validate();
            this._maxLabelWidth = this._group.width - this._subMenuIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            this._description.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            editGroup.visible = pointNavigationEditState;
            var loc1:*;
            this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
            this._optionGroup.visible = loc1;
            checkbox.isSelected = this.pointNavigation().isSelected();
            return;
        }

        internal function pointNavigation():frontend.screen.mydevices.list.MyDevicePointNavigationListItem
        {
            if (data is frontend.screen.mydevices.list.MyDevicePointNavigationListItem) 
            {
                return data as frontend.screen.mydevices.list.MyDevicePointNavigationListItem;
            }
            return new frontend.screen.mydevices.list.MyDevicePointNavigationListItem();
        }

        internal static function get NAME_PADDING_LEFT():Number
        {
            return frontend.screen.mydevices.list.MyDevicePointNavigationRenderer._78149431NAME_PADDING_LEFT;
        }

        internal static function set NAME_PADDING_LEFT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.mydevices.list.MyDevicePointNavigationRenderer._78149431NAME_PADDING_LEFT;
            if (loc1 !== arg1) 
            {
                frontend.screen.mydevices.list.MyDevicePointNavigationRenderer._78149431NAME_PADDING_LEFT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "NAME_PADDING_LEFT", loc1, arg1, frontend.screen.mydevices.list.MyDevicePointNavigationRenderer);
                loc3 = frontend.screen.mydevices.list.MyDevicePointNavigationRenderer.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            DESCRIPTION_PADDING_BOTTOM = 35 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            _78149431NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            NAME_PADDING_TOP = 35 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 75 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            pointNavigationEditState = false;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public var callBackFunction:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _description:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;

        internal var _subMenuIcon:frontend.components.TextureImage;

        internal static var DESCRIPTION_PADDING_BOTTOM:Number;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var _78149431NAME_PADDING_LEFT:Number;

        internal static var NAME_PADDING_TOP:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var pointNavigationEditState:Boolean=false;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class MyDeviceSettingsListItem
package frontend.screen.mydevices.list 
{
    import core.settings.*;
    import frontend.components.list.*;
    
    public class MyDeviceSettingsListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceSettingsListItem()
        {
            super();
            return;
        }

        public var lastChanges:String;

        public var name:String;

        public var setting:core.settings.Settings;
    }
}


//  class MyDeviceSettingsRenderer
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class MyDeviceSettingsRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyDeviceSettingsRenderer()
        {
            super();
            this._lastChangesPrefix = utils.LanguageManager.getString("DATA_LAST_CHANGES");
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (settingsEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            settingsEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                this.setting().addSelection();
            }
            else 
            {
                this.setting().removeSelection();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._optionGroup = new feathers.controls.LayoutGroup();
            this._optionGroup.touchGroup = true;
            this._optionGroup.layout = new feathers.layout.AnchorLayout();
            this._optionGroup.width = OPTION_GROUP_WIDTH;
            this._optionGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._optionGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            this._optionGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onUploadTouch);
            this._group.addChild(this._optionGroup);
            this._sendToDeviceIcon = new frontend.components.TextureImage();
            this._sendToDeviceIcon.touchable = false;
            this._sendToDeviceIcon.textureName = frontend.Textures.uploadicon;
            this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._optionGroup.addChild(this._sendToDeviceIcon);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._name);
            this._description = new feathers.controls.Label();
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, DESCRIPTION_PADDING_BOTTOM, NAME_PADDING_LEFT);
            this._group.addChild(this._description);
            this._subMenuIcon = new frontend.components.TextureImage();
            this._subMenuIcon.touchable = false;
            this._subMenuIcon.textureName = frontend.Textures.pfeilmitbg;
            this._subMenuIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._subMenuIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        internal function onUploadTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.callBackFunction == null) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            arg1.stopImmediatePropagation();
            this.callBackFunction(this.setting());
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.setting();
            (this._name.layoutData as feathers.layout.AnchorLayoutData).left = NAME_PADDING_LEFT;
            (this._description.layoutData as feathers.layout.AnchorLayoutData).left = NAME_PADDING_LEFT;
            this._name.text = loc1.name;
            this._description.text = this._lastChangesPrefix + " " + loc1.lastChanges;
            this._subMenuIcon.visible = !settingsEditState;
            this._subMenuIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._subMenuIcon.validate();
            this._maxLabelWidth = this._group.width - this._subMenuIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            this._description.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            editGroup.visible = settingsEditState;
            var loc1:*;
            this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
            this._optionGroup.visible = loc1;
            checkbox.isSelected = this.setting().isSelected();
            return;
        }

        internal function setting():frontend.screen.mydevices.list.MyDeviceSettingsListItem
        {
            if (data is frontend.screen.mydevices.list.MyDeviceSettingsListItem) 
            {
                return data as frontend.screen.mydevices.list.MyDeviceSettingsListItem;
            }
            return new frontend.screen.mydevices.list.MyDeviceSettingsListItem();
        }

        internal static function get NAME_PADDING_LEFT():Number
        {
            return frontend.screen.mydevices.list.MyDeviceSettingsRenderer._78149431NAME_PADDING_LEFT;
        }

        internal static function set NAME_PADDING_LEFT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.mydevices.list.MyDeviceSettingsRenderer._78149431NAME_PADDING_LEFT;
            if (loc1 !== arg1) 
            {
                frontend.screen.mydevices.list.MyDeviceSettingsRenderer._78149431NAME_PADDING_LEFT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "NAME_PADDING_LEFT", loc1, arg1, frontend.screen.mydevices.list.MyDeviceSettingsRenderer);
                loc3 = frontend.screen.mydevices.list.MyDeviceSettingsRenderer.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            DESCRIPTION_PADDING_BOTTOM = 35 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            _78149431NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            NAME_PADDING_TOP = 35 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 75 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            settingsEditState = false;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public var callBackFunction:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _description:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _lastChangesPrefix:String;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;

        internal var _subMenuIcon:frontend.components.TextureImage;

        internal static var DESCRIPTION_PADDING_BOTTOM:Number;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var _78149431NAME_PADDING_LEFT:Number;

        internal static var NAME_PADDING_TOP:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var settingsEditState:Boolean=false;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class MyDeviceSportprofilesListItem
package frontend.screen.mydevices.list 
{
    import core.sportprofiles.*;
    import frontend.components.list.*;
    import utils.*;
    
    public class MyDeviceSportprofilesListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceSportprofilesListItem()
        {
            super();
            return;
        }

        public function get sportprofile():core.sportprofiles.Sportprofile
        {
            return this._sportprofile;
        }

        public function set sportprofile(arg1:core.sportprofiles.Sportprofile):void
        {
            this._sportprofile = arg1;
            if (this._sportprofile != null) 
            {
                this.GUID = this._sportprofile.GUID;
            }
            if (this.GUID == "") 
            {
                var loc1:*;
                this._sportprofile.GUID = loc1 = utils.GUID.create();
                this.GUID = loc1;
            }
            return;
        }

        internal var _sportprofile:core.sportprofiles.Sportprofile;
    }
}


//  class MyDeviceSportprofilesRenderer
package frontend.screen.mydevices.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class MyDeviceSportprofilesRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyDeviceSportprofilesRenderer()
        {
            super();
            this._lastChangesPrefix = utils.LanguageManager.getString("DATA_LAST_CHANGES");
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (settingsEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        public function isEditState(arg1:Boolean):void
        {
            settingsEditState = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            settingsEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if (allowMultiSelection) 
            {
                if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
                {
                    this.sportprofile().addSelection();
                }
                else 
                {
                    this.sportprofile().removeSelection();
                }
            }
            else if (toggleGroup && toggleGroup.selectedItem == radio) 
            {
                this.sportprofile().currentSelected();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            if (this.showOptionGroup) 
            {
                this._optionGroup = new feathers.controls.LayoutGroup();
                this._optionGroup.touchGroup = true;
                this._optionGroup.layout = new feathers.layout.AnchorLayout();
                this._optionGroup.width = OPTION_GROUP_WIDTH;
                this._optionGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
                this._optionGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
                this._optionGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onUploadTouch);
                this._group.addChild(this._optionGroup);
                this._sendToDeviceIcon = new frontend.components.TextureImage();
                this._sendToDeviceIcon.textureName = frontend.Textures.uploadicon;
                this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                this._optionGroup.addChild(this._sendToDeviceIcon);
            }
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            if (this.showOptionGroup) 
            {
                this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, NAME_PADDING_LEFT);
            }
            else 
            {
                this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, NaN);
            }
            this._group.addChild(this._name);
            this._description = new feathers.controls.Label();
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, DESCRIPTION_PADDING_BOTTOM, NAME_PADDING_LEFT);
            this._group.addChild(this._description);
            this._sportIcon = new frontend.components.SportIcon();
            this._sportIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._sportIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        internal function onUploadTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.callBackFunction == null) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            arg1.stopImmediatePropagation();
            this.callBackFunction(this.sportprofile());
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.sportprofile();
            this._name.text = loc1.sportprofile.profileName;
            this._description.text = this._lastChangesPrefix + " " + backend.utils.DataUtils.dateFormatter.format(loc1.sportprofile.modificationDate);
            this._group.x = settingsEditState ? editGroupWidth + 1 : 0;
            this._group.width = settingsEditState ? (SIGMALink.appWidth - editGroupWidth - 1) : SIGMALink.appWidth;
            this._sportIcon.sportId = loc1.sportprofile.sportId;
            this._sportIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._sportIcon.validate();
            this._maxLabelWidth = this._group.width - this._sportIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, settingsEditState ? customPadding : NAME_PADDING_LEFT);
            this._description.width = this._maxLabelWidth;
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, DESCRIPTION_PADDING_BOTTOM, settingsEditState ? customPadding : NAME_PADDING_LEFT);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            editGroup.visible = settingsEditState;
            if (allowMultiSelection) 
            {
                checkbox.isSelected = this.sportprofile().isSelected();
            }
            else 
            {
                radio.isSelected = this.sportprofile().isSelected();
            }
            if (this.showOptionGroup) 
            {
                var loc1:*;
                this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
                this._optionGroup.visible = loc1;
            }
            return;
        }

        internal function sportprofile():frontend.screen.mydevices.list.MyDeviceSportprofilesListItem
        {
            if (data is frontend.screen.mydevices.list.MyDeviceSportprofilesListItem) 
            {
                return data as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem;
            }
            return new frontend.screen.mydevices.list.MyDeviceSportprofilesListItem();
        }

        
        {
            DESCRIPTION_PADDING_BOTTOM = 35 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            NAME_PADDING_TOP = 35 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 65 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            settingsEditState = false;
        }

        public var callBackFunction:Function;

        public var showOptionGroup:Boolean=true;

        internal var _bottomLine:starling.display.Quad;

        internal var _description:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _lastChangesPrefix:String;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;

        internal var _sportIcon:frontend.components.SportIcon;

        internal static var DESCRIPTION_PADDING_BOTTOM:Number;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var NAME_PADDING_TOP:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var settingsEditState:Boolean=false;
    }
}


//  class MyDeviceTrainingsListItem
package frontend.screen.mydevices.list 
{
    import core.training.*;
    import frontend.components.list.*;
    import utils.*;
    
    public class MyDeviceTrainingsListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceTrainingsListItem(arg1:core.training.Training=null)
        {
            super();
            if (this.training != null) 
            {
                this.training = arg1;
            }
            else 
            {
                this.training = new core.training.Training();
            }
            return;
        }

        public function get training():core.training.Training
        {
            return this._training;
        }

        public function set training(arg1:core.training.Training):void
        {
            this._training = arg1;
            if (this._training != null) 
            {
                this.GUID = this._training.GUID;
            }
            if (this.GUID == "") 
            {
                var loc1:*;
                this._training.GUID = loc1 = utils.GUID.create();
                this.GUID = loc1;
            }
            return;
        }

        internal var _training:core.training.Training;
    }
}


//  class MyDeviceTrainingsRenderer
package frontend.screen.mydevices.list 
{
    import backend.utils.*;
    import core.general.*;
    import core.training.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class MyDeviceTrainingsRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyDeviceTrainingsRenderer()
        {
            super();
            this._lastChangesPrefix = utils.LanguageManager.getString("DATA_LAST_CHANGES");
            return;
        }

        internal function training():frontend.screen.mydevices.list.MyDeviceTrainingsListItem
        {
            if (data is frontend.screen.mydevices.list.MyDeviceTrainingsListItem) 
            {
                return data as frontend.screen.mydevices.list.MyDeviceTrainingsListItem;
            }
            return new frontend.screen.mydevices.list.MyDeviceTrainingsListItem();
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (settingsEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        
        {
            DESCRIPTION_PADDING_BOTTOM = 35 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            LABEL_GAP = 5 * SIGMALink.scaleFactor;
            NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            NAME_PADDING_TOP = 35 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 65 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            settingsEditState = false;
        }

        public function isEditState(arg1:Boolean):void
        {
            settingsEditState = arg1;
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                this.training().addSelection();
            }
            else 
            {
                this.training().removeSelection();
            }
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            settingsEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._optionGroup = new feathers.controls.LayoutGroup();
            this._optionGroup.touchGroup = true;
            this._optionGroup.layout = new feathers.layout.AnchorLayout();
            this._optionGroup.width = OPTION_GROUP_WIDTH;
            this._optionGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._optionGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            this._optionGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onUploadTouch);
            this._group.addChild(this._optionGroup);
            this._sendToDeviceIcon = new frontend.components.TextureImage();
            this._sendToDeviceIcon.textureName = frontend.Textures.uploadicon;
            this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._optionGroup.addChild(this._sendToDeviceIcon);
            this._labelGroup = new feathers.controls.LayoutGroup();
            this._labelGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NAME_PADDING_LEFT, 0, 0);
            this._labelGroup.layout = new feathers.layout.VerticalLayout();
            (this._labelGroup.layout as feathers.layout.VerticalLayout).gap = LABEL_GAP;
            this._group.addChild(this._labelGroup);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._labelGroup.addChild(this._name);
            this._description = new feathers.controls.Label();
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._labelGroup.addChild(this._description);
            this._lastChange = new feathers.controls.Label();
            this._lastChange.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._labelGroup.addChild(this._lastChange);
            this._subMenuIcon = new frontend.components.TextureImage();
            this._subMenuIcon.textureName = frontend.Textures.pfeilmitbg;
            this._subMenuIcon.touchable = false;
            this._subMenuIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._subMenuIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        internal function onUploadTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.callBackFunction == null) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.callBackFunction(this.training());
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.training().training;
            this._name.text = loc1.name;
            this._description.text = loc1.estimatedDurationFormatted + " " + frontend.Locales.getString("UNIT_HOUR") + ", " + loc1.phasesList.length + " " + PHASES_TEXT;
            this._lastChange.text = this._lastChangesPrefix + " " + backend.utils.DataUtils.dateFormatter.format(loc1.modificationDate);
            this._group.x = 0;
            this._group.width = SIGMALink.appWidth;
            this._subMenuIcon.visible = !settingsEditState;
            this._subMenuIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._subMenuIcon.validate();
            this._maxLabelWidth = this._group.width - this._subMenuIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            var loc2:*;
            this._lastChange.width = loc2 = this._maxLabelWidth;
            this._description.width = loc2 = loc2;
            this._name.width = loc2;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            editGroup.visible = settingsEditState;
            var loc1:*;
            this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
            this._optionGroup.visible = loc1;
            checkbox.isSelected = this.training().isSelected();
            return;
        }

        internal static const PHASES_TEXT:String=frontend.Locales.getString("DEVICEVIEW.TRAINING_PROGRAM_PHASES");

        public var callBackFunction:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _description:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelGroup:feathers.controls.LayoutGroup;

        internal var _lastChange:feathers.controls.Label;

        internal var _lastChangesPrefix:String;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;

        internal var _subMenuIcon:frontend.components.TextureImage;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var LABEL_GAP:Number;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var NAME_PADDING_TOP:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var settingsEditState:Boolean=false;

        internal static var DESCRIPTION_PADDING_BOTTOM:Number;
    }
}


//  class MyDevicesListItem
package frontend.screen.mydevices.list 
{
    import core.units.*;
    import feathers.events.*;
    import frontend.components.list.*;
    import starling.events.*;
    
    public class MyDevicesListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDevicesListItem()
        {
            super();
            return;
        }

        public function get icon():String
        {
            return this._3226745icon;
        }

        public function set icon(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3226745icon;
            if (loc1 !== arg1) 
            {
                this._3226745icon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "icon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unit():core.units.Unit
        {
            return this._3594628unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3594628unit;
            if (loc1 !== arg1) 
            {
                this._3594628unit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unit", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _3226745icon:String="noimage";

        internal var _3594628unit:core.units.Unit;
    }
}


//  class MyDevicesRenderer
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class MyDevicesRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyDevicesRenderer()
        {
            super();
            this._firmwarePrefix = utils.LanguageManager.getString("DEVICES.FIRMWARE");
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (devicesEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            devicesEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            var loc1:*=this.unit();
            if (!loc1) 
            {
                return;
            }
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                loc1.addSelection();
            }
            else 
            {
                loc1.removeSelection();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._deviceImage = new frontend.components.button.DevicePictureButton();
            this._deviceImage.layoutData = new feathers.layout.AnchorLayoutData(NAME_DEVICEIMAGE_TOP, NaN, NaN, NAME_DEVICEIMAGE_LEFT);
            this._group.addChild(this._deviceImage);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NAME_PADDING_TOP, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._name);
            this._firmwareLabel = new feathers.controls.Label();
            this._firmwareLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._firmwareLabel.layoutData = new feathers.layout.AnchorLayoutData(FIRMWARE_PADDING_TOP, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._firmwareLabel);
            this._subMenuIcon = new frontend.components.TextureImage();
            this._subMenuIcon.touchable = false;
            this._subMenuIcon.textureName = frontend.Textures.pfeilmitbg;
            this._subMenuIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._subMenuIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.unit();
            if (!loc1) 
            {
                return;
            }
            this._deviceImage.unitType = loc1.unit.type;
            this._name.text = loc1.unit.externalName;
            this._firmwareLabel.text = this._firmwarePrefix + " " + loc1.unit.softwareRevision;
            this._group.x = devicesEditState ? editGroupWidth : 0;
            this._group.width = devicesEditState ? SIGMALink.appWidth - editGroupWidth : SIGMALink.appWidth;
            this._bottomLine.y = height - this._bottomLine.height;
            this._subMenuIcon.visible = !devicesEditState;
            this._subMenuIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._subMenuIcon.validate();
            this._maxLabelWidth = this._group.width - this._subMenuIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            this._firmwareLabel.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            var loc1:*=this.unit();
            if (!loc1) 
            {
                return;
            }
            editGroup.visible = devicesEditState;
            checkbox.isSelected = loc1.isSelected();
            return;
        }

        internal function unit():frontend.screen.mydevices.list.MyDevicesListItem
        {
            if (data is frontend.screen.mydevices.list.MyDevicesListItem) 
            {
                return data as frontend.screen.mydevices.list.MyDevicesListItem;
            }
            return null;
        }

        
        {
            FIRMWARE_PADDING_TOP = 60 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            NAME_DEVICEIMAGE_LEFT = 15 * SIGMALink.scaleFactor;
            NAME_DEVICEIMAGE_TOP = 20 * SIGMALink.scaleFactor;
            NAME_PADDING_LEFT = 120 * SIGMALink.scaleFactor;
            NAME_PADDING_TOP = 20 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            devicesEditState = false;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _deviceImage:frontend.components.button.DevicePictureButton;

        internal var _firmwareLabel:feathers.controls.Label;

        internal var _firmwarePrefix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _subMenuIcon:frontend.components.TextureImage;

        internal static var FIRMWARE_PADDING_TOP:Number;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var NAME_DEVICEIMAGE_LEFT:Number;

        internal static var NAME_DEVICEIMAGE_TOP:Number;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var NAME_PADDING_TOP:Number;

        internal static var customPadding:Number;

        internal static var devicesEditState:Boolean=false;
    }
}


//  class PossibleDevicesListItem
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import frontend.components.list.*;
    
    public class PossibleDevicesListItem extends frontend.components.list.SelectableListItem
    {
        public function PossibleDevicesListItem(arg1:core.general.UnitType)
        {
            super();
            this.unitType = arg1;
            this._label = arg1.getLabel();
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        internal var _label:String;

        public var unitType:core.general.UnitType;
    }
}


//  class PossibleDevicesRenderer
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class PossibleDevicesRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function PossibleDevicesRenderer()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._deviceImage = new frontend.components.button.DevicePictureButton();
            this._deviceImage.layoutData = new feathers.layout.AnchorLayoutData(NAME_DEVICEIMAGE_TOP, NaN, NaN, NAME_DEVICEIMAGE_LEFT, NaN, 0);
            this._group.addChild(this._deviceImage);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NAME_PADDING_LEFT, NaN, 0);
            this._group.addChild(this._name);
            this._subMenuIcon = new frontend.components.TextureImage();
            this._subMenuIcon.textureName = frontend.Textures.pfeilmitbg;
            this._subMenuIcon.touchable = false;
            this._subMenuIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_RIGHT, NaN, NaN, NaN, 0);
            this._group.addChild(this._subMenuIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data || !(data is frontend.screen.mydevices.list.PossibleDevicesListItem)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.mydevices.list.PossibleDevicesListItem;
            this._name.text = loc1.label;
            this._deviceImage.unitType = loc1.unitType;
            this._bottomLine.y = height - this._bottomLine.height;
            this._subMenuIcon.invalidate(INVALIDATION_FLAG_SIZE);
            this._subMenuIcon.validate();
            this._maxLabelWidth = this._group.width - this._subMenuIcon.width - ICON_PADDING_RIGHT - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            this._bottomLine.y = height - this._bottomLine.height;
            return;
        }

        
        {
            ICON_PADDING_LEFT = 15 * SIGMALink.scaleFactor;
            ICON_PADDING_RIGHT = 15 * SIGMALink.scaleFactor;
            NAME_DEVICEIMAGE_LEFT = 15 * SIGMALink.scaleFactor;
            NAME_DEVICEIMAGE_TOP = 20 * SIGMALink.scaleFactor;
            NAME_PADDING_LEFT = 120 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _deviceImage:frontend.components.button.DevicePictureButton;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _subMenuIcon:frontend.components.TextureImage;

        internal static var ICON_PADDING_LEFT:Number;

        internal static var ICON_PADDING_RIGHT:Number;

        internal static var NAME_DEVICEIMAGE_LEFT:Number;

        internal static var NAME_DEVICEIMAGE_TOP:Number;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var customPadding:Number;
    }
}


