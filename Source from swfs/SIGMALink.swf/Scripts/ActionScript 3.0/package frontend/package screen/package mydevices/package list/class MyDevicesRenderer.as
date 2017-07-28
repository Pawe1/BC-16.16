//class MyDevicesRenderer
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


