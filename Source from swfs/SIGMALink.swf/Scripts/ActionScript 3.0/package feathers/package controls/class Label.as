//class Label
package feathers.controls 
{
    import feathers.core.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.skins.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class Label extends feathers.core.FeathersControl implements feathers.core.ITextBaselineControl, feathers.core.IToolTip
    {
        public function Label()
        {
            super();
            this.isQuickHitAreaEnabled = true;
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Label.globalStyleProvider;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingTop === arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._wordWrap === arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get baseline():Number
        {
            if (!this.textRenderer) 
            {
                return this.scaledActualHeight;
            }
            return this.scaleY * (this.textRenderer.y + this.textRenderer.baseline);
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingRight === arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textRendererFactory():Function
        {
            return this._textRendererFactory;
        }

        public function set textRendererFactory(arg1:Function):void
        {
            if (this._textRendererFactory == arg1) 
            {
                return;
            }
            this._textRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function get customTextRendererStyleName():String
        {
            return this._customTextRendererStyleName;
        }

        public function set customTextRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTextRendererStyleName === arg1) 
            {
                return;
            }
            this._customTextRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingBottom === arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function get textRendererProperties():Object
        {
            if (!this._textRendererProperties) 
            {
                this._textRendererProperties = new feathers.core.PropertyProxy(this.textRendererProperties_onChange);
            }
            return this._textRendererProperties;
        }

        public function set textRendererProperties(arg1:Object):void
        {
            if (this._textRendererProperties == arg1) 
            {
                return;
            }
            if (arg1 && !(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._textRendererProperties) 
            {
                this._textRendererProperties.removeOnChangeCallback(this.textRendererProperties_onChange);
            }
            this._textRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._textRendererProperties) 
            {
                this._textRendererProperties.addOnChangeCallback(this.textRendererProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingLeft === arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            if (loc3 || loc2 || loc4) 
            {
                this.refreshBackgroundSkin();
            }
            if (loc5) 
            {
                this.createTextRenderer();
            }
            if (loc5 || loc1 || loc4) 
            {
                this.refreshTextRendererData();
            }
            if (loc5 || loc4) 
            {
                this.refreshEnabled();
            }
            if (loc5 || loc2) 
            {
                this.refreshTextRendererStyles();
            }
            loc3 = this.autoSizeIfNeeded() || loc3;
            this.layoutChildren();
            return;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(starling.display.DisplayObject(this.textRenderer), this._explicitWidth - this._paddingLeft - this._paddingRight, this._explicitHeight - this._paddingTop - this._paddingBottom, this._explicitMinWidth - this._paddingLeft - this._paddingRight, this._explicitMinHeight - this._paddingTop - this._paddingBottom, this._explicitMaxWidth - this._paddingLeft - this._paddingRight, this._explicitMaxHeight - this._paddingTop - this._paddingBottom, this._explicitTextRendererWidth, this._explicitTextRendererHeight, this._explicitTextRendererMinWidth, this._explicitTextRendererMinHeight, this._explicitTextRendererMaxWidth, this._explicitTextRendererMaxHeight);
            this.textRenderer.maxWidth = this._explicitMaxWidth - this._paddingLeft - this._paddingRight;
            this.textRenderer.maxHeight = this._explicitMaxHeight - this._paddingTop - this._paddingBottom;
            var loc5:*=starling.utils.Pool.getPoint();
            this.textRenderer.measureText(loc5);
            var loc6:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            var loc7:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (this._text && !loc1) 
                {
                    loc7 = loc5.x;
                }
                else 
                {
                    loc7 = 0;
                }
                loc7 = loc7 + (this._paddingLeft + this._paddingRight);
                loc11 = 0;
                if (loc6 === null) 
                {
                    if (this.currentBackgroundSkin !== null) 
                    {
                        loc11 = this._explicitBackgroundMinWidth;
                    }
                }
                else 
                {
                    loc11 = loc6.minWidth;
                }
                if (loc11 > loc7) 
                {
                    loc7 = loc11;
                }
            }
            var loc8:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (this._text) 
                {
                    loc8 = loc5.y;
                }
                else 
                {
                    loc8 = 0;
                }
                loc8 = loc8 + (this._paddingTop + this._paddingBottom);
                loc12 = 0;
                if (loc6 === null) 
                {
                    if (this.currentBackgroundSkin !== null) 
                    {
                        loc12 = this._explicitBackgroundMinHeight;
                    }
                }
                else 
                {
                    loc12 = loc6.minHeight;
                }
                if (loc12 > loc8) 
                {
                    loc8 = loc12;
                }
            }
            var loc9:*=this._explicitWidth;
            if (loc1) 
            {
                if (this._text) 
                {
                    loc9 = loc5.x;
                }
                else 
                {
                    loc9 = 0;
                }
                loc9 = loc9 + (this._paddingLeft + this._paddingRight);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc9) 
                {
                    loc9 = this.currentBackgroundSkin.width;
                }
            }
            var loc10:*=this._explicitHeight;
            if (loc2) 
            {
                if (this._text) 
                {
                    loc10 = loc5.y;
                }
                else 
                {
                    loc10 = 0;
                }
                loc10 = loc10 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc10) 
                {
                    loc10 = this.currentBackgroundSkin.height;
                }
            }
            starling.utils.Pool.putPoint(loc5);
            return this.saveMeasurements(loc9, loc10, loc7, loc8);
        }

        protected function createTextRenderer():void
        {
            if (this.textRenderer !== null) 
            {
                this.removeChild(starling.display.DisplayObject(this.textRenderer), true);
                this.textRenderer = null;
            }
            var loc1:*=this._textRendererFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._textRendererFactory;
            this.textRenderer = feathers.core.ITextRenderer(loc1());
            var loc2:*=this._customTextRendererStyleName == null ? this.textRendererStyleName : this._customTextRendererStyleName;
            this.textRenderer.styleNameList.add(loc2);
            this.addChild(starling.display.DisplayObject(this.textRenderer));
            this.textRenderer.initializeNow();
            this._explicitTextRendererWidth = this.textRenderer.explicitWidth;
            this._explicitTextRendererHeight = this.textRenderer.explicitHeight;
            this._explicitTextRendererMinWidth = this.textRenderer.explicitMinWidth;
            this._explicitTextRendererMinHeight = this.textRenderer.explicitMinHeight;
            this._explicitTextRendererMaxWidth = this.textRenderer.explicitMaxWidth;
            this._explicitTextRendererMaxHeight = this.textRenderer.explicitMaxHeight;
            return;
        }

        protected function refreshBackgroundSkin():void
        {
            var loc2:*=null;
            var loc1:*=this._backgroundSkin;
            if (!this._isEnabled && !(this._backgroundDisabledSkin === null)) 
            {
                loc1 = this._backgroundDisabledSkin;
            }
            if (this.currentBackgroundSkin != loc1) 
            {
                if (this.currentBackgroundSkin !== null) 
                {
                    this.removeChild(this.currentBackgroundSkin);
                }
                this.currentBackgroundSkin = loc1;
                if (this.currentBackgroundSkin !== null) 
                {
                    this.addChildAt(this.currentBackgroundSkin, 0);
                    if (this.currentBackgroundSkin is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentBackgroundSkin).initializeNow();
                    }
                    if (this.currentBackgroundSkin is feathers.core.IMeasureDisplayObject) 
                    {
                        loc2 = feathers.core.IMeasureDisplayObject(this.currentBackgroundSkin);
                        this._explicitBackgroundWidth = loc2.explicitWidth;
                        this._explicitBackgroundHeight = loc2.explicitHeight;
                        this._explicitBackgroundMinWidth = loc2.explicitMinWidth;
                        this._explicitBackgroundMinHeight = loc2.explicitMinHeight;
                        this._explicitBackgroundMaxWidth = loc2.explicitMaxWidth;
                        this._explicitBackgroundMaxHeight = loc2.explicitMaxHeight;
                    }
                    else 
                    {
                        this._explicitBackgroundWidth = this.currentBackgroundSkin.width;
                        this._explicitBackgroundHeight = this.currentBackgroundSkin.height;
                        this._explicitBackgroundMinWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMinHeight = this._explicitBackgroundHeight;
                        this._explicitBackgroundMaxWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMaxHeight = this._explicitBackgroundHeight;
                    }
                }
            }
            if (this.currentBackgroundSkin !== null) 
            {
                this.setChildIndex(this.currentBackgroundSkin, 0);
            }
            return;
        }

        protected function layoutChildren():void
        {
            if (this.currentBackgroundSkin !== null) 
            {
                this.currentBackgroundSkin.x = 0;
                this.currentBackgroundSkin.y = 0;
                this.currentBackgroundSkin.width = this.actualWidth;
                this.currentBackgroundSkin.height = this.actualHeight;
            }
            this.textRenderer.x = this._paddingLeft;
            this.textRenderer.y = this._paddingTop;
            this.textRenderer.width = this.actualWidth - this._paddingLeft - this._paddingRight;
            this.textRenderer.height = this.actualHeight - this._paddingTop - this._paddingBottom;
            this.textRenderer.validate();
            return;
        }

        protected function refreshTextRendererData():void
        {
            this.textRenderer.text = this._text;
            this.textRenderer.visible = this._text && this._text.length > 0;
            return;
        }

        protected function refreshTextRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.textRenderer.fontStyles = this._fontStylesSet;
            this.textRenderer.wordWrap = this._wordWrap;
            var loc3:*=0;
            var loc4:*=this._textRendererProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._textRendererProperties[loc1];
                this.textRenderer[loc1] = loc2;
            }
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textRendererProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshEnabled():void
        {
            this.textRenderer.isEnabled = this._isEnabled;
            return;
        }

        public function get backgroundSkin():starling.display.DisplayObject
        {
            return this._backgroundSkin;
        }

        public function set backgroundSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundSkin === arg1) 
            {
                return;
            }
            if (this._backgroundSkin && this.currentBackgroundSkin == this._backgroundSkin) 
            {
                this.removeChild(this._backgroundSkin);
                this.currentBackgroundSkin = null;
            }
            this._backgroundSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this._backgroundDisabledSkin;
        }

        public function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundDisabledSkin && this.currentBackgroundSkin == this._backgroundDisabledSkin) 
            {
                this.removeChild(this._backgroundDisabledSkin);
                this.currentBackgroundSkin = null;
            }
            this._backgroundDisabledSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_TEXT_RENDERER:String="feathers-label-text-renderer";

        public static const ALTERNATE_STYLE_NAME_HEADING:String="feathers-heading-label";

        public static const ALTERNATE_STYLE_NAME_DETAIL:String="feathers-detail-label";

        public static const ALTERNATE_STYLE_NAME_TOOL_TIP:String="feathers-tool-tip";

        protected var textRendererStyleName:String="feathers-label-text-renderer";

        protected var textRenderer:feathers.core.ITextRenderer;

        protected var _text:String=null;

        protected var _wordWrap:Boolean=false;

        protected var _textRendererFactory:Function;

        protected var _customTextRendererStyleName:String;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _textRendererProperties:feathers.core.PropertyProxy;

        protected var _explicitTextRendererWidth:Number;

        protected var _explicitTextRendererHeight:Number;

        protected var _explicitTextRendererMinHeight:Number;

        protected var _explicitTextRendererMaxWidth:Number;

        protected var _explicitTextRendererMaxHeight:Number;

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var _paddingBottom:Number=0;

        protected var _paddingTop:Number=0;

        protected var currentBackgroundSkin:starling.display.DisplayObject;

        protected var _explicitTextRendererMinWidth:Number;

        protected var _paddingLeft:Number=0;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _paddingRight:Number=0;

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


