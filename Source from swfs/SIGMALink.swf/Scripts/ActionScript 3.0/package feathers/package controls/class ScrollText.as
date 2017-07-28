//class ScrollText
package feathers.controls 
{
    import feathers.controls.supportClasses.*;
    import feathers.skins.*;
    import feathers.text.*;
    import flash.text.*;
    import starling.events.*;
    import starling.text.*;
    
    public class ScrollText extends feathers.controls.Scroller
    {
        public function ScrollText()
        {
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this.textViewPort = new feathers.controls.supportClasses.TextFieldViewPort();
            this.textViewPort.addEventListener(starling.events.Event.TRIGGERED, this.textViewPort_triggeredHandler);
            this.viewPort = this.textViewPort;
            return;
        }

        public override function get padding():Number
        {
            return this._textPaddingTop;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return ScrollText.globalStyleProvider;
        }

        public override function get paddingTop():Number
        {
            return this._textPaddingTop;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (!arg1) 
            {
                arg1 = "";
            }
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textPaddingTop === arg1) 
            {
                return;
            }
            this._textPaddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get isHTML():Boolean
        {
            return this._isHTML;
        }

        public function set isHTML(arg1:Boolean):void
        {
            if (this._isHTML == arg1) 
            {
                return;
            }
            this._isHTML = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function get paddingRight():Number
        {
            return this._textPaddingRight;
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

        public override function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textPaddingRight === arg1) 
            {
                return;
            }
            this._textPaddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textFormat():flash.text.TextFormat
        {
            return this._textFormat;
        }

        public function set textFormat(arg1:flash.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textFormat === arg1) 
            {
                return;
            }
            this._textFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function get paddingBottom():Number
        {
            return this._textPaddingBottom;
        }

        public function get disabledTextFormat():flash.text.TextFormat
        {
            return this._disabledTextFormat;
        }

        public function set disabledTextFormat(arg1:flash.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._disabledTextFormat === arg1) 
            {
                return;
            }
            this._disabledTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textPaddingBottom === arg1) 
            {
                return;
            }
            this._textPaddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get styleSheet():flash.text.StyleSheet
        {
            return this._styleSheet;
        }

        public function set styleSheet(arg1:flash.text.StyleSheet):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._styleSheet === arg1) 
            {
                return;
            }
            this._styleSheet = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function get paddingLeft():Number
        {
            return this._textPaddingLeft;
        }

        public function get embedFonts():Boolean
        {
            return this._embedFonts;
        }

        public function set embedFonts(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._embedFonts === arg1) 
            {
                return;
            }
            this._embedFonts = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textPaddingLeft === arg1) 
            {
                return;
            }
            this._textPaddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get antiAliasType():String
        {
            return this._antiAliasType;
        }

        public function set antiAliasType(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._antiAliasType === arg1) 
            {
                return;
            }
            this._antiAliasType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function get visible():Boolean
        {
            return this._visible;
        }

        public function get background():Boolean
        {
            return this._background;
        }

        public function set background(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._background === arg1) 
            {
                return;
            }
            this._background = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            if (this._visible == arg1) 
            {
                return;
            }
            this._visible = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get backgroundColor():uint
        {
            return this._backgroundColor;
        }

        public function set backgroundColor(arg1:uint):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._backgroundColor === arg1) 
            {
                return;
            }
            this._backgroundColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function get alpha():Number
        {
            return this._alpha;
        }

        public function get border():Boolean
        {
            return this._border;
        }

        public function set border(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._border === arg1) 
            {
                return;
            }
            this._border = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function set alpha(arg1:Number):void
        {
            if (this._alpha == arg1) 
            {
                return;
            }
            this._alpha = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get borderColor():uint
        {
            return this._borderColor;
        }

        public function set borderColor(arg1:uint):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._borderColor === arg1) 
            {
                return;
            }
            this._borderColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            if (loc2) 
            {
                this.textViewPort.text = this._text;
                this.textViewPort.isHTML = this._isHTML;
            }
            if (loc4) 
            {
                this.textViewPort.antiAliasType = this._antiAliasType;
                this.textViewPort.background = this._background;
                this.textViewPort.backgroundColor = this._backgroundColor;
                this.textViewPort.border = this._border;
                this.textViewPort.borderColor = this._borderColor;
                this.textViewPort.cacheAsBitmap = this._cacheAsBitmap;
                this.textViewPort.condenseWhite = this._condenseWhite;
                this.textViewPort.displayAsPassword = this._displayAsPassword;
                this.textViewPort.gridFitType = this._gridFitType;
                this.textViewPort.sharpness = this._sharpness;
                this.textViewPort.thickness = this._thickness;
                this.textViewPort.textFormat = this._textFormat;
                this.textViewPort.disabledTextFormat = this._disabledTextFormat;
                this.textViewPort.fontStyles = this._fontStylesSet;
                this.textViewPort.styleSheet = this._styleSheet;
                this.textViewPort.embedFonts = this._embedFonts;
                this.textViewPort.paddingTop = this._textPaddingTop;
                this.textViewPort.paddingRight = this._textPaddingRight;
                this.textViewPort.paddingBottom = this._textPaddingBottom;
                this.textViewPort.paddingLeft = this._textPaddingLeft;
                this.textViewPort.visible = this._visible;
                this.textViewPort.alpha = this._alpha;
            }
            super.draw();
            return;
        }

        public function get cacheAsBitmap():Boolean
        {
            return this._cacheAsBitmap;
        }

        public function set cacheAsBitmap(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._cacheAsBitmap === arg1) 
            {
                return;
            }
            this._cacheAsBitmap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textViewPort_triggeredHandler(arg1:starling.events.Event, arg2:String):void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED, false, arg2);
            return;
        }

        public function get condenseWhite():Boolean
        {
            return this._condenseWhite;
        }

        public function set condenseWhite(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._condenseWhite === arg1) 
            {
                return;
            }
            this._condenseWhite = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get displayAsPassword():Boolean
        {
            return this._displayAsPassword;
        }

        public function set displayAsPassword(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._displayAsPassword === arg1) 
            {
                return;
            }
            this._displayAsPassword = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get gridFitType():String
        {
            return this._gridFitType;
        }

        public function set gridFitType(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._gridFitType === arg1) 
            {
                return;
            }
            this._gridFitType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get sharpness():Number
        {
            return this._sharpness;
        }

        public function set sharpness(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._sharpness === arg1) 
            {
                return;
            }
            this._sharpness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get thickness():Number
        {
            return this._thickness;
        }

        public function set thickness(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._thickness === arg1) 
            {
                return;
            }
            this._thickness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public static const SCROLL_POLICY_ON:String="on";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED_FLOAT:String="fixedFloat";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        internal var _displayAsPassword:Boolean=false;

        protected var _textPaddingTop:Number=0;

        protected var _textPaddingBottom:Number=0;

        protected var _alpha:Number=1;

        internal var _gridFitType:String="pixel";

        protected var _disabledTextFormat:flash.text.TextFormat;

        protected var _textPaddingLeft:Number=0;

        protected var _textPaddingRight:Number=0;

        internal var _thickness:Number=0;

        protected var textViewPort:feathers.controls.supportClasses.TextFieldViewPort;

        internal var _sharpness:Number=0;

        protected var _text:String="";

        protected var _isHTML:Boolean=false;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _textFormat:flash.text.TextFormat;

        protected var _styleSheet:flash.text.StyleSheet;

        protected var _embedFonts:Boolean=false;

        internal var _antiAliasType:String="advanced";

        internal var _background:Boolean=false;

        internal var _backgroundColor:uint=16777215;

        protected var _visible:Boolean=true;

        internal var _border:Boolean=false;

        internal var _borderColor:uint=0;

        internal var _cacheAsBitmap:Boolean=true;

        internal var _condenseWhite:Boolean=false;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


