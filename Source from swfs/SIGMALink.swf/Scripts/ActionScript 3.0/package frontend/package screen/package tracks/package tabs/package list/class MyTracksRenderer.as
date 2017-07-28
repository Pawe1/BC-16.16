//class MyTracksRenderer
package frontend.screen.tracks.tabs.list 
{
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
    
    public class MyTracksRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyTracksRenderer()
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
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._name);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_LEFT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._leftValuesGroup = new feathers.controls.LayoutGroup();
            this._leftValuesGroup.layout = this._hLayout;
            this._leftValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, NAME_PADDING_LEFT);
            this._group.addChild(this._leftValuesGroup);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_RIGHT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._rightValuesGroup = new feathers.controls.LayoutGroup();
            this._rightValuesGroup.layout = this._hLayout;
            this._rightValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING, NaN);
            this._group.addChild(this._rightValuesGroup);
            this._imageDistance = new frontend.components.TextureImage();
            this._imageDistance.textureName = frontend.Textures.streckesmall;
            this._imageDistance.touchable = false;
            this._leftValuesGroup.addChild(this._imageDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.width = VALUE_WIDTH;
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._leftValuesGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._leftValuesGroup.addChild(this._labelDistanceUnit);
            this._imageAltitude = new frontend.components.TextureImage();
            this._imageAltitude.textureName = frontend.Textures.bergauf;
            this._imageAltitude.touchable = false;
            this._rightValuesGroup.addChild(this._imageAltitude);
            this._labelAltitude = new feathers.controls.Label();
            this._labelAltitude.width = VALUE_WIDTH;
            this._labelAltitude.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._rightValuesGroup.addChild(this._labelAltitude);
            this._labelAltitudeUnit = new feathers.controls.Label();
            this._labelAltitudeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._rightValuesGroup.addChild(this._labelAltitudeUnit);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (editState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.route();
            if (loc1.track) 
            {
                this._name.text = loc1.track.name;
            }
            this._name.invalidate(INVALIDATION_FLAG_SIZE);
            this._name.validate();
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = loc1.distanceUnit;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelAltitude.text = loc1.altitude;
            this._labelAltitude.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitude.validate();
            this._labelAltitudeUnit.text = loc1.altitudeUnit;
            this._labelAltitudeUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitudeUnit.validate();
            this._bottomLine.y = height - this._bottomLine.height;
            this._maxLabelWidth = this._group.width - NAME_PADDING_LEFT - customPadding;
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
            editGroup.visible = editState;
            var loc1:*;
            this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
            this._optionGroup.visible = loc1;
            checkbox.isSelected = this.route().isSelected();
            return;
        }

        internal function route():frontend.screen.tracks.tabs.list.MyTracksListItem
        {
            if (data is frontend.screen.tracks.tabs.list.MyTracksListItem) 
            {
                return data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            }
            return new frontend.screen.tracks.tabs.list.MyTracksListItem();
        }

        
        {
            NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 75 * SIGMALink.scaleFactor;
            PADDING = 20 * SIGMALink.scaleFactor;
            VALUE_WIDTH = 100 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            editState = false;
        }

        public function isEditState(arg1:Boolean):void
        {
            editState = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            editState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                this.route().addSelection();
            }
            else 
            {
                this.route().removeSelection();
            }
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
            this.callBackFunction(this.route());
            return;
        }

        public var callBackFunction:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _imageAltitude:frontend.components.TextureImage;

        internal var _imageDistance:frontend.components.TextureImage;

        internal var _labelAltitude:feathers.controls.Label;

        internal var _labelAltitudeUnit:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _leftValuesGroup:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _rightValuesGroup:feathers.controls.LayoutGroup;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var PADDING:Number;

        internal static var VALUE_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var editState:Boolean=false;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;
    }
}


