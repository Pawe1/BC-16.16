//class MyDeviceSportprofilesRenderer
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


