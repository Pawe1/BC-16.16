//class Alert
package feathers.controls 
{
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.skins.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    
    public class Alert extends feathers.controls.Panel
    {
        public function Alert()
        {
            super();
            this.headerStyleName = DEFAULT_CHILD_STYLE_NAME_HEADER;
            this.footerStyleName = DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP;
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this.buttonGroupFactory = defaultButtonGroupFactory;
            return;
        }

        protected function createMessage():void
        {
            if (this.messageTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.messageTextRenderer), true);
                this.messageTextRenderer = null;
            }
            var loc1:*=this._messageFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._messageFactory;
            this.messageTextRenderer = feathers.core.ITextRenderer(loc1());
            this.messageTextRenderer.wordWrap = true;
            var loc2:*=this._customMessageStyleName == null ? this.messageStyleName : this._customMessageStyleName;
            var loc3:*=feathers.core.IFeathersControl(this.messageTextRenderer);
            loc3.styleNameList.add(loc2);
            loc3.touchable = false;
            this.addChild(starling.display.DisplayObject(this.messageTextRenderer));
            return;
        }

        protected override function refreshFooterStyles():void
        {
            super.refreshFooterStyles();
            this.buttonGroupFooter.dataProvider = this._buttonsDataProvider;
            return;
        }

        protected function refreshMessageStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.messageTextRenderer.fontStyles = this._fontStylesSet;
            var loc3:*=0;
            var loc4:*=this._messageProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._messageProperties[loc1];
                this.messageTextRenderer[loc1] = loc2;
            }
            return;
        }

        protected override function calculateViewPortOffsets(arg1:Boolean=false, arg2:Boolean=false):void
        {
            var loc1:*=NaN;
            super.calculateViewPortOffsets(arg1, arg2);
            if (this._icon !== null) 
            {
                if (this._icon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._icon).validate();
                }
                loc1 = this._icon.width;
                if (loc1 === loc1) 
                {
                    this._leftViewPortOffset = this._leftViewPortOffset + (loc1 + this._gap);
                }
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return Alert.globalStyleProvider;
        }

        protected function buttonsFooter_triggeredHandler(arg1:starling.events.Event, arg2:Object):void
        {
            this.removeFromParent();
            this.dispatchEventWith(starling.events.Event.CLOSE, false, arg2);
            this.dispose();
            return;
        }

        public function get message():String
        {
            return this._message;
        }

        public function set message(arg1:String):void
        {
            if (this._message == arg1) 
            {
                return;
            }
            this._message = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function icon_resizeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get icon():starling.display.DisplayObject
        {
            return this._icon;
        }

        public function set icon(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._icon === arg1) 
            {
                return;
            }
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            if (this._icon) 
            {
                this._icon.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.icon_resizeHandler);
                this.removeChild(this._icon);
            }
            this._icon = arg1;
            if (this._icon) 
            {
                this._icon.addEventListener(feathers.events.FeathersEventType.RESIZE, this.icon_resizeHandler);
                this.addChild(this._icon);
            }
            this.displayListBypassEnabled = loc1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._gap === arg1) 
            {
                return;
            }
            this._gap = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        
        {
            alertFactory = defaultAlertFactory;
        }

        public function get buttonsDataProvider():feathers.data.ListCollection
        {
            return this._buttonsDataProvider;
        }

        public function set buttonsDataProvider(arg1:feathers.data.ListCollection):void
        {
            if (this._buttonsDataProvider == arg1) 
            {
                return;
            }
            this._buttonsDataProvider = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static function defaultAlertFactory():feathers.controls.Alert
        {
            return new Alert();
        }

        public function get fontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.format;
        }

        public function set fontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.format = arg1;
            return;
        }

        public function get disabledFontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.disabledFormat;
        }

        public function set disabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.disabledFormat = arg1;
            return;
        }

        public function get customMessageStyleName():String
        {
            return this._customMessageStyleName;
        }

        public function get messageFactory():Function
        {
            return this._messageFactory;
        }

        public function set messageFactory(arg1:Function):void
        {
            if (this._messageFactory == arg1) 
            {
                return;
            }
            this._messageFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public static function show(arg1:String, arg2:String=null, arg3:feathers.data.ListCollection=null, arg4:starling.display.DisplayObject=null, arg5:Boolean=true, arg6:Boolean=true, arg7:Function=null, arg8:Function=null):feathers.controls.Alert
        {
            var loc1:*=arg7;
            if (loc1 == null) 
            {
                loc1 = alertFactory == null ? defaultAlertFactory : alertFactory;
            }
            var loc2:*=Alert(loc1());
            loc2.title = arg2;
            loc2.message = arg1;
            loc2.buttonsDataProvider = arg3;
            loc2.icon = arg4;
            loc1 = arg8;
            if (loc1 == null) 
            {
                loc1 = overlayFactory;
            }
            feathers.core.PopUpManager.addPopUp(loc2, arg5, arg6, loc1);
            return loc2;
        }

        public function get messageProperties():Object
        {
            if (!this._messageProperties) 
            {
                this._messageProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._messageProperties;
        }

        public function set messageProperties(arg1:Object):void
        {
            if (this._messageProperties == arg1) 
            {
                return;
            }
            if (arg1 && !(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._messageProperties) 
            {
                this._messageProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._messageProperties = feathers.core.PropertyProxy(arg1);
            if (this._messageProperties) 
            {
                this._messageProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function defaultButtonGroupFactory():feathers.controls.ButtonGroup
        {
            return new feathers.controls.ButtonGroup();
        }

        public function set buttonGroupProperties(arg1:Object):void
        {
            super.footerProperties = arg1;
            return;
        }

        public function set customMessageStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customMessageStyleName === arg1) 
            {
                return;
            }
            this._customMessageStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function get buttonGroupFactory():Function
        {
            return super.footerFactory;
        }

        public function set buttonGroupFactory(arg1:Function):void
        {
            super.footerFactory = arg1;
            return;
        }

        public function get customButtonGroupStyleName():String
        {
            return super.customFooterStyleName;
        }

        public function set customButtonGroupStyleName(arg1:String):void
        {
            super.customFooterStyleName = arg1;
            return;
        }

        public function get buttonGroupProperties():Object
        {
            return super.footerProperties;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (this._layout === null) 
            {
                loc1 = new feathers.layout.VerticalLayout();
                loc1.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
                this._layout = loc1;
            }
            super.initialize();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            if (loc4) 
            {
                this.createMessage();
            }
            if (loc4 || loc1) 
            {
                this.messageTextRenderer.text = this._message;
            }
            if (loc4 || loc2) 
            {
                this.refreshMessageStyles();
            }
            super.draw();
            if (this._icon !== null) 
            {
                if (this._icon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._icon).validate();
                }
                this._icon.x = this._paddingLeft;
                this._icon.y = this._topViewPortOffset + (this._viewPort.visibleHeight - this._icon.height) / 2;
            }
            return;
        }

        protected override function autoSizeIfNeeded():Boolean
        {
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=NaN;
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE) 
            {
                return super.autoSizeIfNeeded();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            var loc5:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            if (this._icon is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._icon).validate();
            }
            var loc6:*=this._explicitWidth;
            var loc7:*=this._explicitHeight;
            var loc8:*=this._explicitMinWidth;
            var loc9:*=this._explicitMinHeight;
            if (loc1) 
            {
                if (this._measureViewPort) 
                {
                    loc6 = this._viewPort.visibleWidth;
                }
                else 
                {
                    loc6 = 0;
                }
                loc6 = loc6 + (this._rightViewPortOffset + this._leftViewPortOffset);
                loc10 = this.header.width + this._outerPaddingLeft + this._outerPaddingRight;
                if (loc10 > loc6) 
                {
                    loc6 = loc10;
                }
                if (this.footer !== null) 
                {
                    loc11 = this.footer.width + this._outerPaddingLeft + this._outerPaddingRight;
                    if (loc11 > loc6) 
                    {
                        loc6 = loc11;
                    }
                }
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc6) 
                {
                    loc6 = this.currentBackgroundSkin.width;
                }
            }
            if (loc2) 
            {
                if (this._measureViewPort) 
                {
                    loc7 = this._viewPort.visibleHeight;
                }
                else 
                {
                    loc7 = 0;
                }
                if (this._icon !== null) 
                {
                    loc12 = this._icon.height;
                    if (loc12 === loc12 && loc12 > loc7) 
                    {
                        loc7 = loc12;
                    }
                }
                loc7 = loc7 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc7) 
                {
                    loc7 = this.currentBackgroundSkin.height;
                }
            }
            if (loc3) 
            {
                if (this._measureViewPort) 
                {
                    loc8 = this._viewPort.minVisibleWidth;
                }
                else 
                {
                    loc8 = 0;
                }
                loc8 = loc8 + (this._rightViewPortOffset + this._leftViewPortOffset);
                loc13 = this.header.minWidth + this._outerPaddingLeft + this._outerPaddingRight;
                if (loc13 > loc8) 
                {
                    loc8 = loc13;
                }
                if (this.footer !== null) 
                {
                    loc14 = this.footer.minWidth + this._outerPaddingLeft + this._outerPaddingRight;
                    if (loc14 > loc8) 
                    {
                        loc8 = loc14;
                    }
                }
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinWidth > loc8) 
                        {
                            loc8 = this._explicitBackgroundMinWidth;
                        }
                    }
                    else if (loc5.minWidth > loc8) 
                    {
                        loc8 = loc5.minWidth;
                    }
                }
            }
            if (loc4) 
            {
                if (this._measureViewPort) 
                {
                    loc9 = this._viewPort.minVisibleHeight;
                }
                else 
                {
                    loc9 = 0;
                }
                if (this._icon !== null) 
                {
                    loc12 = this._icon.height;
                    if (loc12 === loc12 && loc12 > loc9) 
                    {
                        loc9 = loc12;
                    }
                }
                loc9 = loc9 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinHeight > loc9) 
                        {
                            loc9 = this._explicitBackgroundMinHeight;
                        }
                    }
                    else if (loc5.minHeight > loc9) 
                    {
                        loc9 = loc5.minHeight;
                    }
                }
            }
            return this.saveMeasurements(loc6, loc7, loc8, loc9);
        }

        protected override function createHeader():void
        {
            super.createHeader();
            this.headerHeader = feathers.controls.Header(this.header);
            return;
        }

        protected function createButtonGroup():void
        {
            if (this.buttonGroupFooter) 
            {
                this.buttonGroupFooter.removeEventListener(starling.events.Event.TRIGGERED, this.buttonsFooter_triggeredHandler);
            }
            super.createFooter();
            this.buttonGroupFooter = feathers.controls.ButtonGroup(this.footer);
            this.buttonGroupFooter.addEventListener(starling.events.Event.TRIGGERED, this.buttonsFooter_triggeredHandler);
            return;
        }

        protected override function createFooter():void
        {
            this.createButtonGroup();
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_HEADER:String="feathers-alert-header";

        public static const DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP:String="feathers-alert-button-group";

        public static const DEFAULT_CHILD_STYLE_NAME_MESSAGE:String="feathers-alert-message";

        protected var messageStyleName:String="feathers-alert-message";

        protected var headerHeader:feathers.controls.Header;

        protected var buttonGroupFooter:feathers.controls.ButtonGroup;

        protected var messageTextRenderer:feathers.core.ITextRenderer;

        protected var _message:String=null;

        protected var _icon:starling.display.DisplayObject;

        protected var _gap:Number=0;

        protected var _buttonsDataProvider:feathers.data.ListCollection;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _messageProperties:feathers.core.PropertyProxy;

        protected var _customMessageStyleName:String;

        public static var alertFactory:Function;

        public static var overlayFactory:Function;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _messageFactory:Function;
    }
}


