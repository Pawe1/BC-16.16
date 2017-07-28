//class MyDeviceTrainingsRenderer
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


