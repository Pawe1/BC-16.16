//class PossibleDevicesRenderer
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


