//class TextFieldTextRenderer
package feathers.controls.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import feathers.utils.math.*;
    import feathers.utils.textures.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TextFieldTextRenderer extends feathers.controls.text.BaseTextRenderer implements feathers.core.ITextRenderer
    {
        public function TextFieldTextRenderer()
        {
            super();
            this.isQuickHitAreaEnabled = true;
            return;
        }

        public function get maxTextureDimensions():int
        {
            return this._maxTextureDimensions;
        }

        public function set maxTextureDimensions(arg1:int):void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (loc1.profile === flash.display3D.Context3DProfile.BASELINE_CONSTRAINED) 
            {
                arg1 = starling.utils.MathUtil.getNextPowerOfTwo(arg1);
            }
            if (this._maxTextureDimensions == arg1) 
            {
                return;
            }
            this._maxTextureDimensions = arg1;
            this._needsNewTexture = true;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get nativeFilters():Array
        {
            return this._nativeFilters;
        }

        public function set nativeFilters(arg1:Array):void
        {
            if (this._nativeFilters == arg1) 
            {
                return;
            }
            this._nativeFilters = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get useGutter():Boolean
        {
            return this._useGutter;
        }

        public function set useGutter(arg1:Boolean):void
        {
            if (this._useGutter == arg1) 
            {
                return;
            }
            this._useGutter = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get updateSnapshotOnScaleChange():Boolean
        {
            return this._updateSnapshotOnScaleChange;
        }

        public function set updateSnapshotOnScaleChange(arg1:Boolean):void
        {
            if (this._updateSnapshotOnScaleChange == arg1) 
            {
                return;
            }
            this._updateSnapshotOnScaleChange = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get useSnapshotDelayWorkaround():Boolean
        {
            return this._useSnapshotDelayWorkaround;
        }

        public function set useSnapshotDelayWorkaround(arg1:Boolean):void
        {
            if (this._useSnapshotDelayWorkaround == arg1) 
            {
                return;
            }
            this._useSnapshotDelayWorkaround = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (this.textSnapshot) 
            {
                this.textSnapshot.texture.dispose();
                this.removeChild(this.textSnapshot, true);
                this.textSnapshot = null;
            }
            if (this.textSnapshots) 
            {
                loc1 = this.textSnapshots.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = this.textSnapshots[loc2];
                    loc3.texture.dispose();
                    this.removeChild(loc3, true);
                    ++loc2;
                }
                this.textSnapshots = null;
            }
            this.textField = null;
            this._previousActualWidth = NaN;
            this._previousActualHeight = NaN;
            this._needsNewTexture = false;
            this._snapshotWidth = 0;
            this._snapshotHeight = 0;
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            if (this.textSnapshot !== null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                if (this._updateSnapshotOnScaleChange) 
                {
                    this.getTransformationMatrix(this.stage, HELPER_MATRIX);
                    loc8 = feathers.utils.geom.matrixToScaleX(HELPER_MATRIX);
                    loc9 = feathers.utils.geom.matrixToScaleY(HELPER_MATRIX);
                    if (!(loc8 == this._lastGlobalScaleX) || !(loc9 == this._lastGlobalScaleY) || !(loc1.contentScaleFactor == this._lastContentScaleFactor)) 
                    {
                        this.invalidate(INVALIDATION_FLAG_SIZE);
                        this.validate();
                    }
                }
                loc2 = loc1.contentScaleFactor;
                if (!this._nativeFilters || this._nativeFilters.length === 0) 
                {
                    loc10 = 0;
                    loc11 = 0;
                }
                else 
                {
                    loc10 = this._textSnapshotOffsetX / loc2;
                    loc11 = this._textSnapshotOffsetY / loc2;
                }
                loc11 = loc11 + this._verticalAlignOffsetY * loc2;
                loc3 = -1;
                loc4 = this._snapshotWidth;
                loc5 = this._snapshotHeight;
                loc6 = loc10;
                loc7 = loc11;
                do 
                {
                    loc12 = loc4;
                    if (loc12 > this._maxTextureDimensions) 
                    {
                        loc12 = this._maxTextureDimensions;
                    }
                    do 
                    {
                        loc13 = loc5;
                        if (loc13 > this._maxTextureDimensions) 
                        {
                            loc13 = this._maxTextureDimensions;
                        }
                        if (loc3 < 0) 
                        {
                            loc14 = this.textSnapshot;
                        }
                        else 
                        {
                            loc14 = this.textSnapshots[loc3];
                        }
                        loc14.x = loc6 / loc2;
                        loc14.y = loc7 / loc2;
                        if (this._updateSnapshotOnScaleChange) 
                        {
                            loc14.x = loc14.x / this._lastGlobalScaleX;
                            loc14.y = loc14.y / this._lastGlobalScaleX;
                        }
                        ++loc3;
                        loc7 = loc7 + loc13;
                        loc5 = loc5 - loc13;
                    }
                    while (loc5 > 0);
                    loc6 = loc6 + loc12;
                    loc4 = loc4 - loc12;
                    loc7 = loc11;
                    loc5 = this._snapshotHeight;
                }
                while (loc4 > 0);
            }
            super.render(arg1);
            return;
        }

        public function measureText(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            if (!loc1 && !loc2) 
            {
                arg1.x = this._explicitWidth;
                arg1.y = this._explicitHeight;
                return arg1;
            }
            if (!this._isInitialized) 
            {
                this.initializeNow();
            }
            this.commit();
            arg1 = this.measure(arg1);
            return arg1;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return TextFieldTextRenderer.globalStyleProvider;
        }

        public override function set text(arg1:String):void
        {
            if (arg1 === null) 
            {
                arg1 = "";
            }
            super.text = arg1;
            return;
        }

        public function getTextFormatForState(arg1:String):flash.text.TextFormat
        {
            if (this._textFormatForState === null) 
            {
                return null;
            }
            return flash.text.TextFormat(this._textFormatForState[arg1]);
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

        public function get numLines():int
        {
            if (this.textField === null) 
            {
                return 0;
            }
            return this.textField.numLines;
        }

        public function setTextFormatForState(arg1:String, arg2:flash.text.TextFormat):void
        {
            if (arg2) 
            {
                if (!this._textFormatForState) 
                {
                    this._textFormatForState = {};
                }
                this._textFormatForState[arg1] = arg2;
            }
            else 
            {
                delete this._textFormatForState[arg1];
            }
            if (this._stateContext && this._stateContext.currentState === arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_STATE);
            }
            return;
        }

        public function get currentTextFormat():flash.text.TextFormat
        {
            return this._currentTextFormat;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (this.textField === null) 
            {
                this.textField = new flash.text.TextField();
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc2 = loc1.contentScaleFactor;
                this.textField.scaleX = loc2;
                this.textField.scaleY = loc2;
                var loc3:*;
                this.textField.mouseWheelEnabled = loc3 = false;
                this.textField.mouseEnabled = loc3;
                this.textField.selectable = false;
                this.textField.multiline = true;
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            this.commit();
            this._hasMeasured = false;
            loc1 = this.autoSizeIfNeeded() || loc1;
            this._verticalAlignOffsetY = this.getVerticalAlignOffsetY();
            this.layout(loc1);
            return;
        }

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc1 || loc3) 
            {
                this.refreshTextFormat();
            }
            if (loc1) 
            {
                this.textField.antiAliasType = this._antiAliasType;
                this.textField.background = this._background;
                this.textField.backgroundColor = this._backgroundColor;
                this.textField.border = this._border;
                this.textField.borderColor = this._borderColor;
                this.textField.condenseWhite = this._condenseWhite;
                this.textField.displayAsPassword = this._displayAsPassword;
                this.textField.gridFitType = this._gridFitType;
                this.textField.sharpness = this._sharpness;
                this.textField.thickness = this._thickness;
                this.textField.filters = this._nativeFilters;
            }
            if (loc2 || loc1 || loc3) 
            {
                this.textField.wordWrap = this._wordWrap;
                if (this._styleSheet) 
                {
                    this.textField.embedFonts = this._embedFonts;
                    this.textField.styleSheet = this._styleSheet;
                }
                else 
                {
                    if (!this._embedFonts && this._currentTextFormat === this._fontStylesTextFormat) 
                    {
                        this.textField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(this._currentTextFormat.font, this._currentTextFormat.bold, this._currentTextFormat.italic, flash.text.FontType.EMBEDDED);
                    }
                    else 
                    {
                        this.textField.embedFonts = this._embedFonts;
                    }
                    this.textField.styleSheet = null;
                    this.textField.defaultTextFormat = this._currentTextFormat;
                }
                if (this._isHTML) 
                {
                    this.textField.htmlText = this._text;
                }
                else 
                {
                    this.textField.text = this._text;
                }
            }
            return;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            var loc8:*=NaN;
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textField.wordWrap = false;
            var loc3:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc4:*=loc3.contentScaleFactor;
            var loc5:*=4;
            if (this._useGutter) 
            {
                loc5 = 0;
            }
            var loc6:*=this._explicitWidth;
            if (loc1) 
            {
                loc8 = this.textField.width;
                loc6 = this.textField.width / loc4 - loc5;
                if (loc6 < this._explicitMinWidth) 
                {
                    loc6 = this._explicitMinWidth;
                }
                else if (loc6 > this._explicitMaxWidth) 
                {
                    loc6 = this._explicitMaxWidth;
                }
            }
            if (!loc1 || this.textField.width / loc4 - loc5 > loc6) 
            {
                this.textField.width = loc6 + loc5;
                this.textField.wordWrap = this._wordWrap;
            }
            var loc7:*=this._explicitHeight;
            if (loc2) 
            {
                loc7 = this.textField.height / loc4 - loc5;
                loc7 = feathers.utils.math.roundUpToNearest(loc7, 0.05);
                if (loc7 < this._explicitMinHeight) 
                {
                    loc7 = this._explicitMinHeight;
                }
                else if (loc7 > this._explicitMaxHeight) 
                {
                    loc7 = this._explicitMaxHeight;
                }
            }
            this.textField.autoSize = flash.text.TextFieldAutoSize.NONE;
            this.textField.width = this.actualWidth + loc5;
            this.textField.height = this.actualHeight + loc5;
            arg1.x = loc6;
            arg1.y = loc7;
            this._hasMeasured = true;
            return arg1;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc7:*=false;
            var loc8:*=null;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc5:*=loc4.contentScaleFactor;
            var loc6:*=4;
            if (this._useGutter) 
            {
                loc6 = 0;
            }
            if (!this._hasMeasured && this._wordWrap) 
            {
                this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.textField.wordWrap = false;
                if (this.textField.width / loc5 - loc6 > this.actualWidth) 
                {
                    this.textField.wordWrap = true;
                }
                this.textField.autoSize = flash.text.TextFieldAutoSize.NONE;
                this.textField.width = this.actualWidth + loc6;
            }
            if (arg1) 
            {
                this.textField.width = this.actualWidth + loc6;
                this.textField.height = this.actualHeight + loc6;
                this.calculateSnapshotDimensions();
            }
            if (loc1 || loc2 || loc3 || this._needsNewTexture || !(this.actualWidth === this._previousActualWidth) || !(this.actualHeight === this._previousActualHeight)) 
            {
                this._previousActualWidth = this.actualWidth;
                this._previousActualHeight = this.actualHeight;
                loc7 = this._text.length > 0;
                if (loc7) 
                {
                    if (this._useSnapshotDelayWorkaround) 
                    {
                        this.addEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
                    }
                    else 
                    {
                        this.refreshSnapshot();
                    }
                }
                if (this.textSnapshot) 
                {
                    this.textSnapshot.visible = loc7 && this._snapshotWidth > 0 && this._snapshotHeight > 0;
                    this.textSnapshot.pixelSnapping = this._pixelSnapping;
                }
                if (this.textSnapshots) 
                {
                    var loc9:*=0;
                    var loc10:*=this.textSnapshots;
                    for each (loc8 in loc10) 
                    {
                        loc8.pixelSnapping = this._pixelSnapping;
                    }
                }
            }
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

        protected function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            this.measure(HELPER_POINT);
            var loc5:*=this._explicitWidth;
            if (loc1) 
            {
                loc5 = HELPER_POINT.x;
            }
            var loc6:*=this._explicitHeight;
            if (loc2) 
            {
                loc6 = HELPER_POINT.y;
            }
            var loc7:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc1) 
                {
                    loc7 = 0;
                }
                else 
                {
                    loc7 = loc5;
                }
            }
            var loc8:*=this._explicitMinHeight;
            if (loc4) 
            {
                loc8 = loc6;
            }
            return this.saveMeasurements(loc5, loc6, loc7, loc8);
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

        protected function measureNativeFilters(arg1:flash.display.BitmapData, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            if (!arg2) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=this._nativeFilters.length;
            var loc6:*=0;
            while (loc6 < loc5) 
            {
                loc7 = this._nativeFilters[loc6];
                loc8 = arg1.generateFilterRect(arg1.rect, loc7);
                loc9 = loc8.x;
                loc10 = loc8.y;
                loc11 = loc8.width;
                loc12 = loc8.height;
                if (loc1 > loc9) 
                {
                    loc1 = loc9;
                }
                if (loc2 > loc10) 
                {
                    loc2 = loc10;
                }
                if (loc3 < loc11) 
                {
                    loc3 = loc11;
                }
                if (loc4 < loc12) 
                {
                    loc4 = loc12;
                }
                ++loc6;
            }
            arg2.setTo(loc1, loc2, loc3, loc4);
            return arg2;
        }

        public function get selectedTextFormat():flash.text.TextFormat
        {
            return this._selectedTextFormat;
        }

        public function set selectedTextFormat(arg1:flash.text.TextFormat):void
        {
            if (this._selectedTextFormat == arg1) 
            {
                return;
            }
            this._selectedTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshTextFormat():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._stateContext === null) 
            {
                if (!this._isEnabled && !(this._disabledTextFormat === null)) 
                {
                    loc1 = this._disabledTextFormat;
                }
            }
            else 
            {
                if (this._textFormatForState !== null) 
                {
                    loc2 = this._stateContext.currentState;
                    if (loc2 in this._textFormatForState) 
                    {
                        loc1 = flash.text.TextFormat(this._textFormatForState[loc2]);
                    }
                }
                if (loc1 === null && !(this._disabledTextFormat === null) && this._stateContext is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(this._stateContext).isEnabled) 
                {
                    loc1 = this._disabledTextFormat;
                }
                if (loc1 === null && !(this._selectedTextFormat === null) && this._stateContext is feathers.core.IToggle && feathers.core.IToggle(this._stateContext).isSelected) 
                {
                    loc1 = this._selectedTextFormat;
                }
            }
            if (loc1 === null) 
            {
                loc1 = this._textFormat;
            }
            if (loc1 !== null) 
            {
                this._currentVerticalAlign = starling.utils.Align.TOP;
            }
            else 
            {
                loc1 = this.getTextFormatFromFontStyles();
            }
            this._currentTextFormat = loc1;
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
                        this._currentVerticalAlign = starling.utils.Align.TOP;
                    }
                }
                else 
                {
                    this._fontStylesTextFormat = loc1.toNativeFormat(this._fontStylesTextFormat);
                    this._currentVerticalAlign = loc1.verticalAlign;
                }
            }
            return this._fontStylesTextFormat;
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

        public function get baseline():Number
        {
            if (!this.textField) 
            {
                return 0;
            }
            var loc1:*=0;
            if (this._useGutter) 
            {
                loc1 = 2;
            }
            return loc1 + this.textField.getLineMetrics(0).ascent;
        }

        protected function getVerticalAlignOffsetY():Number
        {
            var loc1:*=this.textField.textHeight;
            if (loc1 > this.actualHeight) 
            {
                return 0;
            }
            if (this._currentVerticalAlign === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - loc1;
            }
            if (this._currentVerticalAlign === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - loc1) / 2;
            }
            return 0;
        }

        public function get pixelSnapping():Boolean
        {
            return this._pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            if (this._pixelSnapping === arg1) 
            {
                return;
            }
            this._pixelSnapping = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function createTextureOnRestoreCallback(arg1:starling.display.Image):void
        {
            var snapshot:starling.display.Image;
            var self:feathers.controls.text.TextFieldTextRenderer;
            var texture:starling.textures.Texture;

            var loc1:*;
            self = null;
            texture = null;
            snapshot = arg1;
            self = this;
            texture = snapshot.texture;
            texture.root.onRestore = function ():void
            {
                var loc1:*=self.stage === null ? starling.core.Starling.current : self.stage.starling;
                var loc2:*=loc1.contentScaleFactor;
                HELPER_MATRIX.identity();
                HELPER_MATRIX.scale(loc2, loc2);
                var loc3:*=self.drawTextFieldRegionToBitmapData(snapshot.x, snapshot.y, texture.nativeWidth, texture.nativeHeight);
                texture.root.uploadBitmapData(loc3);
                loc3.dispose();
                return;
            }
            return;
        }

        public function get antiAliasType():String
        {
            return this._antiAliasType;
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

        protected function drawTextFieldRegionToBitmapData(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:flash.display.BitmapData=null):flash.display.BitmapData
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            var loc3:*=this._snapshotVisibleWidth - arg1;
            var loc4:*=this._snapshotVisibleHeight - arg2;
            if (!arg5 || !(arg5.width == arg3) || !(arg5.height == arg4)) 
            {
                if (arg5) 
                {
                    arg5.dispose();
                }
                arg5 = new flash.display.BitmapData(arg3, arg4, true, 16711935);
            }
            else 
            {
                arg5.fillRect(arg5.rect, 16711935);
            }
            var loc5:*=2 * loc2;
            if (this._useGutter) 
            {
                loc5 = 0;
            }
            HELPER_MATRIX.tx = -(arg1 + loc5) - this._textSnapshotOffsetX;
            HELPER_MATRIX.ty = -(arg2 + loc5) - this._textSnapshotOffsetY;
            HELPER_RECTANGLE.setTo(0, 0, loc3, loc4);
            arg5.draw(this.textField, HELPER_MATRIX, null, null, HELPER_RECTANGLE);
            return arg5;
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

        protected function calculateSnapshotDimensions():void
        {
            var loc7:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            var loc3:*=Math.ceil(this.textField.width);
            var loc4:*=Math.ceil(this.textField.height);
            if (this._updateSnapshotOnScaleChange) 
            {
                this.getTransformationMatrix(this.stage, HELPER_MATRIX);
                loc3 = loc3 * feathers.utils.geom.matrixToScaleX(HELPER_MATRIX);
                loc4 = loc4 * feathers.utils.geom.matrixToScaleY(HELPER_MATRIX);
            }
            if (loc3 >= 1 && loc4 >= 1 && !(this._nativeFilters === null) && this._nativeFilters.length > 0) 
            {
                HELPER_MATRIX.identity();
                HELPER_MATRIX.scale(loc2, loc2);
                loc7 = new flash.display.BitmapData(loc3, loc4, true, 16711935);
                loc7.draw(this.textField, HELPER_MATRIX, null, null, HELPER_RECTANGLE);
                this.measureNativeFilters(loc7, HELPER_RECTANGLE);
                loc7.dispose();
                loc7 = null;
                this._textSnapshotOffsetX = HELPER_RECTANGLE.x;
                this._textSnapshotOffsetY = HELPER_RECTANGLE.y;
                loc3 = HELPER_RECTANGLE.width;
                loc4 = HELPER_RECTANGLE.height;
            }
            var loc5:*=starling.utils.Pool.getPoint();
            feathers.utils.textures.calculateSnapshotTextureDimensions(loc3, loc4, this._maxTextureDimensions, !(loc1.profile === flash.display3D.Context3DProfile.BASELINE_CONSTRAINED), loc5);
            this._snapshotWidth = loc5.x;
            this._snapshotHeight = loc5.y;
            this._snapshotVisibleWidth = loc3;
            this._snapshotVisibleHeight = loc4;
            starling.utils.Pool.putPoint(loc5);
            var loc6:*=this.textSnapshot ? this.textSnapshot.texture.root : null;
            this._needsNewTexture = this._needsNewTexture || this.textSnapshot === null || !(loc6 === null) && (!(loc6.scale === loc2) || !(this._snapshotWidth === loc6.nativeWidth) || !(this._snapshotHeight === loc6.nativeHeight));
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

        protected function refreshSnapshot():void
        {
            var loc7:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=0;
            var loc17:*=0;
            if (this._snapshotWidth <= 0 || this._snapshotHeight <= 0) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            if (this._updateSnapshotOnScaleChange) 
            {
                this.getTransformationMatrix(this.stage, HELPER_MATRIX);
                loc9 = feathers.utils.geom.matrixToScaleX(HELPER_MATRIX);
                loc10 = feathers.utils.geom.matrixToScaleY(HELPER_MATRIX);
            }
            HELPER_MATRIX.identity();
            HELPER_MATRIX.scale(loc2, loc2);
            if (this._updateSnapshotOnScaleChange) 
            {
                HELPER_MATRIX.scale(loc9, loc10);
            }
            var loc3:*=this._snapshotWidth;
            var loc4:*=this._snapshotHeight;
            var loc5:*=0;
            var loc6:*=0;
            var loc8:*=-1;
            do 
            {
                loc11 = loc3;
                if (loc11 > this._maxTextureDimensions) 
                {
                    loc11 = this._maxTextureDimensions;
                }
                do 
                {
                    loc12 = loc4;
                    if (loc12 > this._maxTextureDimensions) 
                    {
                        loc12 = this._maxTextureDimensions;
                    }
                    loc7 = this.drawTextFieldRegionToBitmapData(loc5, loc6, loc11, loc12, loc7);
                    if (!this.textSnapshot || this._needsNewTexture) 
                    {
                        loc13 = starling.textures.Texture.empty(loc7.width / loc2, loc7.height / loc2, true, false, false, loc2);
                        loc13.root.uploadBitmapData(loc7);
                    }
                    loc14 = null;
                    if (loc8 >= 0) 
                    {
                        if (this.textSnapshots) 
                        {
                            if (this.textSnapshots.length > loc8) 
                            {
                                loc14 = this.textSnapshots[loc8];
                            }
                        }
                        else 
                        {
                            this.textSnapshots = new Vector.<starling.display.Image>(0);
                        }
                    }
                    else 
                    {
                        loc14 = this.textSnapshot;
                    }
                    if (loc14) 
                    {
                        if (this._needsNewTexture) 
                        {
                            loc14.texture.dispose();
                            loc14.texture = loc13;
                            loc14.readjustSize();
                        }
                        else 
                        {
                            loc15 = loc14.texture;
                            loc15.root.uploadBitmapData(loc7);
                            this.textSnapshot.setRequiresRedraw();
                        }
                    }
                    else 
                    {
                        loc14 = new starling.display.Image(loc13);
                        loc14.pixelSnapping = true;
                        this.addChild(loc14);
                    }
                    if (loc13) 
                    {
                        this.createTextureOnRestoreCallback(loc14);
                    }
                    if (loc8 >= 0) 
                    {
                        this.textSnapshots[loc8] = loc14;
                    }
                    else 
                    {
                        this.textSnapshot = loc14;
                    }
                    loc14.x = loc5 / loc2;
                    loc14.y = loc6 / loc2;
                    if (this._updateSnapshotOnScaleChange) 
                    {
                        loc14.scaleX = 1 / loc9;
                        loc14.scaleY = 1 / loc10;
                        loc14.x = loc14.x / loc9;
                        loc14.y = loc14.y / loc10;
                    }
                    ++loc8;
                    loc6 = loc6 + loc12;
                    loc4 = loc4 - loc12;
                }
                while (loc4 > 0);
                loc5 = loc5 + loc11;
                loc3 = loc3 - loc11;
                loc6 = 0;
                loc4 = this._snapshotHeight;
            }
            while (loc3 > 0);
            loc7.dispose();
            if (this.textSnapshots) 
            {
                loc16 = this.textSnapshots.length;
                loc17 = loc8;
                while (loc17 < loc16) 
                {
                    loc14 = this.textSnapshots[loc17];
                    loc14.texture.dispose();
                    loc14.removeFromParent(true);
                    ++loc17;
                }
                if (loc8 != 0) 
                {
                    this.textSnapshots.length = loc8;
                }
                else 
                {
                    this.textSnapshots = null;
                }
            }
            if (this._updateSnapshotOnScaleChange) 
            {
                this._lastGlobalScaleX = loc9;
                this._lastGlobalScaleY = loc10;
                this._lastContentScaleFactor = loc2;
            }
            this._needsNewTexture = false;
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

        protected function enterFrameHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
            this.refreshSnapshot();
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

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        internal static const HELPER_MATRIX:flash.geom.Matrix=new flash.geom.Matrix();

        internal static const HELPER_RECTANGLE:flash.geom.Rectangle=new flash.geom.Rectangle();

        protected var _textSnapshotOffsetX:Number=0;

        protected var _textSnapshotOffsetY:Number=0;

        protected var _previousActualWidth:Number=NaN;

        protected var _previousActualHeight:Number=NaN;

        protected var _snapshotWidth:int=0;

        protected var _snapshotHeight:int=0;

        protected var _snapshotVisibleWidth:int=0;

        protected var _snapshotVisibleHeight:int=0;

        protected var _needsNewTexture:Boolean=false;

        protected var _hasMeasured:Boolean=false;

        protected var _isHTML:Boolean=false;

        protected var _currentTextFormat:flash.text.TextFormat;

        protected var _fontStylesTextFormat:flash.text.TextFormat;

        protected var _currentVerticalAlign:String;

        protected var _verticalAlignOffsetY:Number=0;

        protected var _textFormatForState:Object;

        protected var _textFormat:flash.text.TextFormat;

        protected var _disabledTextFormat:flash.text.TextFormat;

        protected var _selectedTextFormat:flash.text.TextFormat;

        protected var _styleSheet:flash.text.StyleSheet;

        protected var _embedFonts:Boolean=false;

        protected var _pixelSnapping:Boolean=true;

        internal var _antiAliasType:String="advanced";

        internal var _background:Boolean=false;

        internal var _backgroundColor:uint=16777215;

        internal var _border:Boolean=false;

        internal var _borderColor:uint=0;

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        internal var _gridFitType:String="pixel";

        internal var _condenseWhite:Boolean=false;

        protected var _useSnapshotDelayWorkaround:Boolean=false;

        protected var _nativeFilters:Array;

        internal var _thickness:Number=0;

        internal var _displayAsPassword:Boolean=false;

        protected var _useGutter:Boolean=false;

        internal var _sharpness:Number=0;

        protected var _maxTextureDimensions:int=2048;

        protected var _lastGlobalScaleX:Number=0;

        protected var _lastGlobalScaleY:Number=0;

        protected var _lastContentScaleFactor:Number=0;

        protected var textField:flash.text.TextField;

        protected var textSnapshot:starling.display.Image;

        protected var textSnapshots:__AS3__.vec.Vector.<starling.display.Image>;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


