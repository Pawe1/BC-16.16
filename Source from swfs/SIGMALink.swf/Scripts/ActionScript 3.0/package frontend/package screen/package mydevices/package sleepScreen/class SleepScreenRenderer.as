//class SleepScreenRenderer
package frontend.screen.mydevices.sleepScreen 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SleepScreenRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function SleepScreenRenderer()
        {
            super();
            height = TITLE_ROW_HEIGHT + SCREEN_HEIGHT + 34 * SIGMALink.scaleFactor + FOOTER_ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            hasLabelTextRenderer = false;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = height;
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChild(this._group);
            this._header = new feathers.controls.LayoutGroup();
            this._header.width = SIGMALink.appWidth;
            this._header.height = TITLE_ROW_HEIGHT;
            this._header.layout = new feathers.layout.AnchorLayout();
            this._group.addChild(this._header);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._header.addChild(this._name);
            this._sendToDeviceIcon = new frontend.components.TextureImage();
            this._sendToDeviceIcon.textureName = frontend.Textures.uploadiconRed;
            this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, customPadding, NaN, NaN, NaN, 0);
            this._sendToDeviceIcon.addEventListener(starling.events.Event.TRIGGERED, this.onUploadTriggered);
            this._header.addChild(this._sendToDeviceIcon);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            this._screen = new frontend.components.TextureImage();
            this._screen.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, FOOTER_ROW_HEIGHT + customPadding, NaN, 0);
            this._group.addChild(this._screen);
            this._footer = new feathers.controls.LayoutGroup();
            this._footer.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._footer.height = FOOTER_ROW_HEIGHT;
            this._footer.width = SIGMALink.appWidth;
            this._footer.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, 0);
            this._group.addChild(this._footer);
            return;
        }

        internal function onUploadTriggered(arg1:starling.events.Event):void
        {
            if (this.uploadCallback != null) 
            {
                this.uploadCallback(this.sleepScreen());
            }
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.sleepScreen();
            if (!loc1) 
            {
                return;
            }
            this._name.text = loc1.title;
            this._name.invalidate(INVALIDATION_FLAG_SIZE);
            this._name.validate();
            this._screen.source = loc1.texture;
            this._bottomLine.y = TITLE_ROW_HEIGHT;
            this._maxLabelWidth = this._group.width - TITLE_ROW_HEIGHT;
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

        internal function sleepScreen():frontend.screen.mydevices.sleepScreen.SleepScreenItem
        {
            if (data is frontend.screen.mydevices.sleepScreen.SleepScreenItem) 
            {
                return data as frontend.screen.mydevices.sleepScreen.SleepScreenItem;
            }
            return null;
        }

        
        {
            SCREEN_HEIGHT = 80 * SIGMALink.scaleFactor;
            SCREEN_WIDTH = 200 * SIGMALink.scaleFactor;
            FOOTER_ROW_HEIGHT = 17 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 65 * SIGMALink.scaleFactor;
            TITLE_ROW_HEIGHT = 75 * SIGMALink.scaleFactor;
            VALUE_WIDTH = 100 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
        }

        public var uploadCallback:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _footer:feathers.controls.LayoutGroup;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _header:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number;

        internal var _name:feathers.controls.Label;

        internal var _screen:frontend.components.TextureImage;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;

        public static var SCREEN_HEIGHT:Number;

        public static var SCREEN_WIDTH:Number;

        internal static var FOOTER_ROW_HEIGHT:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var TITLE_ROW_HEIGHT:Number;

        internal static var VALUE_WIDTH:Number;

        internal static var customPadding:Number;
    }
}


