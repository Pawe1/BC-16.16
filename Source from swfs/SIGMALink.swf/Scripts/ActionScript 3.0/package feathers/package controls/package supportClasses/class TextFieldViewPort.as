//class TextFieldViewPort
package feathers.controls.supportClasses 
{
    import feathers.core.*;
    import feathers.text.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class TextFieldViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function TextFieldViewPort()
        {
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            if (this._horizontalScrollPosition == arg1) 
            {
                return;
            }
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
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

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
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

        public function get requiresMeasurementOnScroll():Boolean
        {
            return false;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function get fontStyles():feathers.text.FontStylesSet
        {
            return this._fontStyles;
        }

        public function set fontStyles(arg1:feathers.text.FontStylesSet):void
        {
            if (this._fontStyles === arg1) 
            {
                return;
            }
            if (this._fontStyles !== null) 
            {
                this._fontStyles.removeEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this._fontStyles = arg1;
            if (this._fontStyles !== null) 
            {
                this._fontStyles.addEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this._paddingTop == arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set antiAliasType(arg1:String):void
        {
            if (this._antiAliasType == arg1) 
            {
                return;
            }
            this._antiAliasType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textFormat():flash.text.TextFormat
        {
            return this._textFormat;
        }

        public function set textFormat(arg1:flash.text.TextFormat):void
        {
            if (this._textFormat == arg1) 
            {
                return;
            }
            this._textFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function get disabledTextFormat():flash.text.TextFormat
        {
            return this._disabledTextFormat;
        }

        public function set disabledTextFormat(arg1:flash.text.TextFormat):void
        {
            if (this._disabledTextFormat == arg1) 
            {
                return;
            }
            this._disabledTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this._paddingRight == arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get styleSheet():flash.text.StyleSheet
        {
            return this._styleSheet;
        }

        public function set styleSheet(arg1:flash.text.StyleSheet):void
        {
            if (this._styleSheet == arg1) 
            {
                return;
            }
            this._styleSheet = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function fontStylesSet_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get embedFonts():Boolean
        {
            return this._embedFonts;
        }

        public function set embedFonts(arg1:Boolean):void
        {
            if (this._embedFonts == arg1) 
            {
                return;
            }
            this._embedFonts = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this._paddingBottom == arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get antiAliasType():String
        {
            return this._antiAliasType;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this._paddingLeft == arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get background():Boolean
        {
            return this._background;
        }

        public function set background(arg1:Boolean):void
        {
            if (this._background == arg1) 
            {
                return;
            }
            this._background = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.excludeFromCache(this);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.viewPort;
            var loc3:*=starling.utils.Pool.getMatrix();
            var loc4:*=starling.utils.Pool.getPoint();
            this.parent.getTransformationMatrix(this.stage, loc3);
            starling.utils.MatrixUtil.transformCoords(loc3, 0, 0, loc4);
            var loc5:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc5 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc6:*=loc1.contentScaleFactor / loc5;
            this._textFieldContainer.x = loc2.x + loc4.x * loc6;
            this._textFieldContainer.y = loc2.y + loc4.y * loc6;
            this._textFieldContainer.scaleX = feathers.utils.geom.matrixToScaleX(loc3) * loc6;
            this._textFieldContainer.scaleY = feathers.utils.geom.matrixToScaleY(loc3) * loc6;
            this._textFieldContainer.rotation = feathers.utils.geom.matrixToRotation(loc3) * 180 / Math.PI;
            this._textFieldContainer.alpha = arg1.state.alpha;
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putMatrix(loc3);
            super.render(arg1);
            return;
        }

        public function get backgroundColor():uint
        {
            return this._backgroundColor;
        }

        public function set backgroundColor(arg1:uint):void
        {
            if (this._backgroundColor == arg1) 
            {
                return;
            }
            this._backgroundColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            this._textFieldContainer = new flash.display.Sprite();
            this._textFieldContainer.visible = false;
            this._textField = new flash.text.TextField();
            this._textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this._textField.selectable = false;
            this._textField.mouseWheelEnabled = false;
            this._textField.wordWrap = true;
            this._textField.multiline = true;
            this._textField.addEventListener(flash.events.TextEvent.LINK, this.textField_linkHandler);
            this._textFieldContainer.addChild(this._textField);
            return;
        }

        public function get border():Boolean
        {
            return this._border;
        }

        public function set border(arg1:Boolean):void
        {
            if (this._border == arg1) 
            {
                return;
            }
            this._border = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc10:*=null;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc4) 
            {
                this.refreshTextFormat();
                this._textField.antiAliasType = this._antiAliasType;
                this._textField.background = this._background;
                this._textField.backgroundColor = this._backgroundColor;
                this._textField.border = this._border;
                this._textField.borderColor = this._borderColor;
                this._textField.condenseWhite = this._condenseWhite;
                this._textField.displayAsPassword = this._displayAsPassword;
                this._textField.gridFitType = this._gridFitType;
                this._textField.sharpness = this._sharpness;
                this._textField.thickness = this._thickness;
                this._textField.cacheAsBitmap = this._cacheAsBitmap;
                this._textField.x = this._paddingLeft;
                this._textField.y = this._paddingTop;
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (loc1 || loc4 || loc5) 
            {
                if (this._styleSheet === null) 
                {
                    if (!this._embedFonts && this._currentTextFormat === this._fontStylesTextFormat) 
                    {
                        this._textField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(this._currentTextFormat.font, this._currentTextFormat.bold, this._currentTextFormat.italic, flash.text.FontType.EMBEDDED);
                    }
                    else 
                    {
                        this._textField.embedFonts = this._embedFonts;
                    }
                    this._textField.styleSheet = null;
                    this._textField.defaultTextFormat = this._currentTextFormat;
                }
                else 
                {
                    this._textField.embedFonts = this._embedFonts;
                    this._textField.styleSheet = this._styleSheet;
                }
                if (this._isHTML) 
                {
                    this._textField.htmlText = this._text;
                }
                else 
                {
                    this._textField.text = this._text;
                }
                this._scrollStep = this._textField.getLineMetrics(0).height * loc6.contentScaleFactor;
            }
            var loc7:*=this._explicitVisibleWidth;
            if (loc7 != loc7) 
            {
                if (this.stage === null) 
                {
                    loc7 = loc6.stage.stageWidth;
                }
                else 
                {
                    loc7 = this.stage.stageWidth;
                }
                if (loc7 < this._explicitMinVisibleWidth) 
                {
                    loc7 = this._explicitMinVisibleWidth;
                }
                else if (loc7 > this._maxVisibleWidth) 
                {
                    loc7 = this._maxVisibleWidth;
                }
            }
            this._textField.width = loc7 - this._paddingLeft - this._paddingRight;
            var loc8:*=this._textField.height + this._paddingTop + this._paddingBottom;
            var loc9:*=this._explicitVisibleHeight;
            if (loc9 != loc9) 
            {
                loc9 = loc8;
                if (loc9 < this._explicitMinVisibleHeight) 
                {
                    loc9 = this._explicitMinVisibleHeight;
                }
                else if (loc9 > this._maxVisibleHeight) 
                {
                    loc9 = this._maxVisibleHeight;
                }
            }
            loc2 = this.saveMeasurements(loc7, loc8, loc7, loc8) || loc2;
            this._actualVisibleWidth = loc7;
            this._actualVisibleHeight = loc9;
            this._actualMinVisibleWidth = loc7;
            this._actualMinVisibleHeight = loc9;
            if (loc2 || loc3) 
            {
                loc10 = this._textFieldContainer.scrollRect;
                if (!loc10) 
                {
                    loc10 = new flash.geom.Rectangle();
                }
                loc10.width = loc7;
                loc10.height = loc9;
                loc10.x = this._horizontalScrollPosition;
                loc10.y = this._verticalScrollPosition;
                this._textFieldContainer.scrollRect = loc10;
            }
            return;
        }

        public function get borderColor():uint
        {
            return this._borderColor;
        }

        public function set borderColor(arg1:uint):void
        {
            if (this._borderColor == arg1) 
            {
                return;
            }
            this._borderColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshTextFormat():void
        {
            if (!this._isEnabled && !(this._disabledTextFormat === null)) 
            {
                this._currentTextFormat = this._disabledTextFormat;
            }
            else if (this._textFormat === null) 
            {
                if (this._fontStyles !== null) 
                {
                    this._currentTextFormat = this.getTextFormatFromFontStyles();
                }
            }
            else 
            {
                this._currentTextFormat = this._textFormat;
            }
            return;
        }

        public function get cacheAsBitmap():Boolean
        {
            return this._cacheAsBitmap;
        }

        public function set cacheAsBitmap(arg1:Boolean):void
        {
            if (this._cacheAsBitmap == arg1) 
            {
                return;
            }
            this._cacheAsBitmap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function getTextFormatFromFontStyles():flash.text.TextFormat
        {
            var loc1:*=null;
            if (this.isInvalid(INVALIDATION_FLAG_STYLES) || this.isInvalid(INVALIDATION_FLAG_STATE)) 
            {
                if (this._fontStyles !== null) 
                {
                    loc1 = this._fontStyles.getTextFormatForTarget(this);
                }
                if (loc1 === null) 
                {
                    if (this._fontStylesTextFormat === null) 
                    {
                        this._fontStylesTextFormat = new flash.text.TextFormat();
                    }
                }
                else 
                {
                    this._fontStylesTextFormat = loc1.toNativeFormat(this._fontStylesTextFormat);
                }
            }
            return this._fontStylesTextFormat;
        }

        public function get condenseWhite():Boolean
        {
            return this._condenseWhite;
        }

        public function set condenseWhite(arg1:Boolean):void
        {
            if (this._condenseWhite == arg1) 
            {
                return;
            }
            this._condenseWhite = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function addedToStageHandler(arg1:starling.events.Event):void
        {
            this.stage.starling.nativeStage.addChild(this._textFieldContainer);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
            return;
        }

        public function get displayAsPassword():Boolean
        {
            return this._displayAsPassword;
        }

        public function set displayAsPassword(arg1:Boolean):void
        {
            if (this._displayAsPassword == arg1) 
            {
                return;
            }
            this._displayAsPassword = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.starling.nativeStage.removeChild(this._textFieldContainer);
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
            return;
        }

        public function get gridFitType():String
        {
            return this._gridFitType;
        }

        public function set gridFitType(arg1:String):void
        {
            if (this._gridFitType == arg1) 
            {
                return;
            }
            this._gridFitType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this;
            do 
            {
                if (!loc1.visible) 
                {
                    this._textFieldContainer.visible = false;
                    return;
                }
                loc1 = loc1.parent;
            }
            while (loc1);
            this._textFieldContainer.visible = true;
            return;
        }

        public function get sharpness():Number
        {
            return this._sharpness;
        }

        public function set sharpness(arg1:Number):void
        {
            if (this._sharpness == arg1) 
            {
                return;
            }
            this._sharpness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function textField_linkHandler(arg1:flash.events.TextEvent):void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED, false, arg1.text);
            return;
        }

        public function get thickness():Number
        {
            return this._thickness;
        }

        public function set thickness(arg1:Number):void
        {
            if (this._thickness == arg1) 
            {
                return;
            }
            this._thickness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get visibleWidth():Number
        {
            if (this._explicitVisibleWidth !== this._explicitVisibleWidth) 
            {
                return this._actualVisibleWidth;
            }
            return this._explicitVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get visibleHeight():Number
        {
            if (this._explicitVisibleHeight !== this._explicitVisibleHeight) 
            {
                return this._actualVisibleHeight;
            }
            return this._explicitVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get contentX():Number
        {
            return 0;
        }

        public function get contentY():Number
        {
            return 0;
        }

        public function get horizontalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get verticalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        internal var _textFieldContainer:flash.display.Sprite;

        internal var _textField:flash.text.TextField;

        internal var _text:String="";

        internal var _isHTML:Boolean=false;

        protected var _fontStylesTextFormat:flash.text.TextFormat;

        protected var _fontStyles:feathers.text.FontStylesSet;

        internal var _currentTextFormat:flash.text.TextFormat;

        internal var _disabledTextFormat:flash.text.TextFormat;

        protected var _styleSheet:flash.text.StyleSheet;

        internal var _embedFonts:Boolean=false;

        internal var _antiAliasType:String="advanced";

        internal var _textFormat:flash.text.TextFormat;

        internal var _background:Boolean=false;

        internal var _backgroundColor:uint=16777215;

        internal var _border:Boolean=false;

        internal var _borderColor:uint=0;

        internal var _cacheAsBitmap:Boolean=true;

        internal var _condenseWhite:Boolean=false;

        internal var _displayAsPassword:Boolean=false;

        internal var _gridFitType:String="pixel";

        internal var _sharpness:Number=0;

        internal var _thickness:Number=0;

        internal var _actualVisibleWidth:Number=0;

        internal var _paddingBottom:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _explicitVisibleWidth:Number=NaN;

        internal var _paddingLeft:Number=0;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleHeight:Number=0;

        internal var _verticalScrollPosition:Number=0;

        internal var _explicitVisibleHeight:Number=NaN;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _paddingTop:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _explicitMinVisibleWidth:Number;

        internal var _paddingRight:Number=0;

        internal var _scrollStep:Number;

        internal var _horizontalScrollPosition:Number=0;
    }
}


