//class TextBlockTextRenderer
package feathers.controls.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import feathers.utils.textures.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.text.engine.*;
    import starling.core.*;
    import starling.display.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TextBlockTextRenderer extends feathers.controls.text.BaseTextRenderer implements feathers.core.ITextRenderer
    {
        public function TextBlockTextRenderer()
        {
            this._textLines = new Vector.<flash.text.engine.TextLine>(0);
            this._measurementTextLines = new Vector.<flash.text.engine.TextLine>(0);
            this._textJustifier = new flash.text.engine.SpaceJustifier();
            super();
            this.isQuickHitAreaEnabled = true;
            return;
        }

        public function set lineRotation(arg1:String):void
        {
            if (this._lineRotation == arg1) 
            {
                return;
            }
            this._lineRotation = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get tabStops():__AS3__.vec.Vector.<flash.text.engine.TabStop>
        {
            return this._tabStops;
        }

        public function set tabStops(arg1:__AS3__.vec.Vector.<flash.text.engine.TabStop>):void
        {
            if (this._tabStops == arg1) 
            {
                return;
            }
            this._tabStops = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textJustifier():flash.text.engine.TextJustifier
        {
            return this._textJustifier;
        }

        public function set textJustifier(arg1:flash.text.engine.TextJustifier):void
        {
            if (this._textJustifier == arg1) 
            {
                return;
            }
            this._textJustifier = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get userData():*
        {
            return this._userData;
        }

        public function set userData(arg1:*):void
        {
            if (this._userData === arg1) 
            {
                return;
            }
            this._userData = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public function get truncationText():String
        {
            return this._truncationText;
        }

        public function set truncationText(arg1:String):void
        {
            if (this._truncationText == arg1) 
            {
                return;
            }
            this._truncationText = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get truncateToFit():Boolean
        {
            return this._truncateToFit;
        }

        public function set content(arg1:flash.text.engine.ContentElement):void
        {
            if (this._content === arg1) 
            {
                return;
            }
            if (arg1 is flash.text.engine.TextElement) 
            {
                this._textElement = flash.text.engine.TextElement(arg1);
            }
            else 
            {
                this._textElement = null;
            }
            this._content = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set truncateToFit(arg1:Boolean):void
        {
            if (this._truncateToFit == arg1) 
            {
                return;
            }
            this._truncateToFit = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
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
            this.textBlock = null;
            this._textLineContainer = null;
            this._textLines = null;
            this._measurementTextLineContainer = null;
            this._measurementTextLines = null;
            this._textElement = null;
            this._content = null;
            this._previousLayoutActualWidth = NaN;
            this._previousLayoutActualHeight = NaN;
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
                    if (!(loc8 == this._lastGlobalScaleX) || !(loc9 == this._lastGlobalScaleY) || !(loc1.contentScaleFactor == this._lastGlobalContentScaleFactor)) 
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

        public function getElementFormatForState(arg1:String):flash.text.engine.ElementFormat
        {
            if (this._elementFormatForState === null) 
            {
                return null;
            }
            return flash.text.engine.ElementFormat(this._elementFormatForState[arg1]);
        }

        public function setElementFormatForState(arg1:String, arg2:flash.text.engine.ElementFormat):void
        {
            if (arg2) 
            {
                if (!this._elementFormatForState) 
                {
                    this._elementFormatForState = {};
                }
                this._elementFormatForState[arg1] = arg2;
            }
            else 
            {
                delete this._elementFormatForState[arg1];
            }
            if (this._stateContext && this._stateContext.currentState === arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_STATE);
            }
            return;
        }

        protected override function initialize():void
        {
            if (!this.textBlock) 
            {
                this.textBlock = new flash.text.engine.TextBlock();
            }
            if (!this._textLineContainer) 
            {
                this._textLineContainer = new flash.display.Sprite();
            }
            if (!this._measurementTextLineContainer) 
            {
                this._measurementTextLineContainer = new flash.display.Sprite();
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            this.commit();
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layout(loc1);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.text.TextBlockTextRenderer.globalStyleProvider;
        }

        public override function set maxWidth(arg1:Number):void
        {
            var loc1:*=arg1 > this._explicitMaxWidth && this._lastMeasurementWasTruncated;
            super.maxWidth = arg1;
            if (loc1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get numLines():int
        {
            return this._textLines.length;
        }

        public override function set text(arg1:String):void
        {
            if (this._text == arg1) 
            {
                return;
            }
            if (this._textElement === null) 
            {
                this._textElement = new flash.text.engine.TextElement(arg1);
            }
            this._textElement.text = arg1;
            this.content = this._textElement;
            super.text = arg1;
            return;
        }

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc2 || loc1 || loc3) 
            {
                this.refreshElementFormat();
            }
            if (loc1) 
            {
                this._textBlockChanged = true;
                this.textBlock.applyNonLinearFontScaling = this._applyNonLinearFontScaling;
                this.textBlock.baselineFontDescription = this._baselineFontDescription;
                this.textBlock.baselineFontSize = this._baselineFontSize;
                this.textBlock.baselineZero = this._baselineZero;
                this.textBlock.bidiLevel = this._bidiLevel;
                this.textBlock.lineRotation = this._lineRotation;
                this.textBlock.tabStops = this._tabStops;
                this.textBlock.textJustifier = this._textJustifier;
                this.textBlock.userData = this._userData;
                this._textLineContainer.filters = this._nativeFilters;
            }
            if (loc2) 
            {
                this._textBlockChanged = true;
                this.textBlock.content = this._content;
            }
            return;
        }

        public function get content():flash.text.engine.ContentElement
        {
            return this._content;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            var loc5:*=false;
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=this._explicitWidth;
            var loc4:*=this._explicitHeight;
            if (loc1) 
            {
                loc3 = this._explicitMaxWidth;
                if (loc3 > MAX_TEXT_LINE_WIDTH) 
                {
                    loc3 = MAX_TEXT_LINE_WIDTH;
                }
            }
            if (loc2) 
            {
                loc4 = this._explicitMaxHeight;
            }
            if (this._wordWrap) 
            {
                loc5 = !(loc3 === this._lastMeasurementWidth);
            }
            else 
            {
                loc5 = loc3 < this._lastMeasurementWidth;
                loc5 = loc5 || this._lastMeasurementWasTruncated && !(loc3 === this._lastMeasurementWidth);
            }
            if (this._textBlockChanged || loc5) 
            {
                this.refreshTextLines(this._measurementTextLines, this._measurementTextLineContainer, loc3, loc4, HELPER_RESULT);
                this._lastMeasurementWidth = HELPER_RESULT.width;
                this._lastMeasurementHeight = HELPER_RESULT.height;
                this._lastMeasurementWasTruncated = HELPER_RESULT.isTruncated;
                this._textBlockChanged = false;
            }
            if (loc1) 
            {
                loc3 = Math.ceil(this._measurementTextLineContainer.width);
                if (loc3 > this._explicitMaxWidth) 
                {
                    loc3 = this._explicitMaxWidth;
                }
            }
            if (loc2) 
            {
                loc4 = Math.ceil(this._lastMeasurementHeight);
                if (loc4 <= 0 && this._elementFormat) 
                {
                    loc4 = this._elementFormat.fontSize;
                }
            }
            arg1.x = loc3;
            arg1.y = loc4;
            return arg1;
        }

        public function get currentElementFormat():flash.text.engine.ElementFormat
        {
            if (this._textElement === null) 
            {
                return null;
            }
            return this._textElement.elementFormat;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc5:*=null;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=loc1 || loc2 || loc3 || !(this.actualWidth === this._previousLayoutActualWidth) || !(this.actualHeight === this._previousLayoutActualHeight);
            if (loc4) 
            {
                this._previousLayoutActualWidth = this.actualWidth;
                this._previousLayoutActualHeight = this.actualHeight;
                if (this._content !== null) 
                {
                    this.refreshTextLines(this._textLines, this._textLineContainer, this.actualWidth, this.actualHeight, HELPER_RESULT);
                    this._savedTextLinesWidth = HELPER_RESULT.width;
                    this._savedTextLinesHeight = HELPER_RESULT.height;
                    this._verticalAlignOffsetY = this.getVerticalAlignOffsetY();
                }
            }
            if (loc4 || arg1) 
            {
                this.calculateSnapshotDimensions();
            }
            if (loc4 || this._needsNewTexture) 
            {
                if (this._content !== null) 
                {
                    this.refreshSnapshot();
                }
                if (this.textSnapshot !== null) 
                {
                    this.textSnapshot.visible = this._snapshotWidth > 0 && this._snapshotHeight > 0 && !(this._content === null);
                    this.textSnapshot.pixelSnapping = this._pixelSnapping;
                }
                if (this.textSnapshots !== null) 
                {
                    var loc6:*=0;
                    var loc7:*=this.textSnapshots;
                    for each (loc5 in loc7) 
                    {
                        loc5.pixelSnapping = this._pixelSnapping;
                    }
                }
            }
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
            if (loc1 || loc2) 
            {
                this.measure(HELPER_POINT);
            }
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

        protected function refreshElementFormat():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._stateContext === null) 
            {
                if (!this._isEnabled && !(this._disabledElementFormat === null)) 
                {
                    loc1 = this._disabledElementFormat;
                }
            }
            else 
            {
                if (this._elementFormatForState !== null) 
                {
                    loc2 = this._stateContext.currentState;
                    if (loc2 in this._elementFormatForState) 
                    {
                        loc1 = flash.text.engine.ElementFormat(this._elementFormatForState[loc2]);
                    }
                }
                if (loc1 === null && !(this._disabledElementFormat === null) && this._stateContext is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(this._stateContext).isEnabled) 
                {
                    loc1 = this._disabledElementFormat;
                }
                if (loc1 === null && !(this._selectedElementFormat === null) && this._stateContext is feathers.core.IToggle && feathers.core.IToggle(this._stateContext).isSelected) 
                {
                    loc1 = this._selectedElementFormat;
                }
            }
            if (loc1 === null) 
            {
                loc1 = this._elementFormat;
            }
            if (loc1 !== null) 
            {
                this._currentVerticalAlign = starling.utils.Align.TOP;
            }
            else 
            {
                loc1 = this.getElementFormatFromFontStyles();
            }
            if (this._textAlign !== null) 
            {
                this._currentHorizontalAlign = this._textAlign;
            }
            if (this._textElement === null) 
            {
                return;
            }
            if (this._textElement.elementFormat !== loc1) 
            {
                this._textBlockChanged = true;
                this._textElement.elementFormat = loc1;
            }
            return;
        }

        protected function getElementFormatFromFontStyles():flash.text.engine.ElementFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (this.isInvalid(INVALIDATION_FLAG_STYLES) || this.isInvalid(INVALIDATION_FLAG_STATE)) 
            {
                if (this._fontStyles !== null) 
                {
                    loc1 = this._fontStyles.getTextFormatForTarget(this);
                }
                if (loc1 === null) 
                {
                    if (this._fontStylesElementFormat === null) 
                    {
                        this._fontStylesElementFormat = new flash.text.engine.ElementFormat();
                        this._currentVerticalAlign = starling.utils.Align.TOP;
                        this._currentHorizontalAlign = starling.utils.Align.LEFT;
                    }
                }
                else 
                {
                    loc2 = flash.text.engine.FontWeight.NORMAL;
                    if (loc1.bold) 
                    {
                        loc2 = flash.text.engine.FontWeight.BOLD;
                    }
                    loc3 = flash.text.engine.FontPosture.NORMAL;
                    if (loc1.italic) 
                    {
                        loc3 = flash.text.engine.FontPosture.ITALIC;
                    }
                    loc4 = flash.text.engine.FontLookup.DEVICE;
                    if (starling.utils.SystemUtil.isEmbeddedFont(loc1.font, loc1.bold, loc1.italic, flash.text.FontType.EMBEDDED_CFF)) 
                    {
                        loc4 = flash.text.engine.FontLookup.EMBEDDED_CFF;
                    }
                    loc5 = new flash.text.engine.FontDescription(loc1.font, loc2, loc3, loc4);
                    this._fontStylesElementFormat = new flash.text.engine.ElementFormat(loc5, loc1.size, loc1.color);
                    this._currentVerticalAlign = loc1.verticalAlign;
                    this._currentHorizontalAlign = loc1.horizontalAlign;
                }
            }
            return this._fontStylesElementFormat;
        }

        protected function createTextureOnRestoreCallback(arg1:starling.display.Image):void
        {
            var snapshot:starling.display.Image;
            var self:feathers.controls.text.TextBlockTextRenderer;
            var texture:starling.textures.Texture;

            var loc1:*;
            self = null;
            texture = null;
            snapshot = arg1;
            self = this;
            texture = snapshot.texture;
            texture.root.onRestore = function ():void
            {
                var loc3:*=null;
                var loc1:*=self.stage === null ? starling.core.Starling.current : self.stage.starling;
                var loc2:*=loc1.contentScaleFactor;
                if (texture.scale == loc2) 
                {
                    HELPER_MATRIX.identity();
                    HELPER_MATRIX.scale(loc2, loc2);
                    loc3 = self.drawTextLinesRegionToBitmapData(snapshot.x, snapshot.y, texture.nativeWidth, texture.nativeHeight);
                    texture.root.uploadBitmapData(loc3);
                    loc3.dispose();
                }
                else 
                {
                    invalidate(INVALIDATION_FLAG_SIZE);
                }
                return;
            }
            return;
        }

        public function get elementFormat():flash.text.engine.ElementFormat
        {
            return this._elementFormat;
        }

        public function set elementFormat(arg1:flash.text.engine.ElementFormat):void
        {
            if (this._elementFormat == arg1) 
            {
                return;
            }
            this._elementFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function drawTextLinesRegionToBitmapData(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:flash.display.BitmapData=null):flash.display.BitmapData
        {
            var loc1:*=this._snapshotVisibleWidth - arg1;
            var loc2:*=this._snapshotVisibleHeight - arg2;
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
            var loc3:*=1;
            var loc4:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (loc4 && loc4.supportHighResolutions) 
            {
                loc3 = loc4.nativeStage.contentsScaleFactor;
            }
            HELPER_MATRIX.tx = -arg1 - this._textSnapshotScrollX * loc3 - this._textSnapshotOffsetX;
            HELPER_MATRIX.ty = -arg2 - this._textSnapshotScrollY * loc3 - this._textSnapshotOffsetY;
            var loc5:*=starling.utils.Pool.getRectangle(0, 0, loc1, loc2);
            arg5.draw(this._textLineContainer, HELPER_MATRIX, null, null, loc5);
            starling.utils.Pool.putRectangle(loc5);
            return arg5;
        }

        public function get disabledElementFormat():flash.text.engine.ElementFormat
        {
            return this._disabledElementFormat;
        }

        public function set disabledElementFormat(arg1:flash.text.engine.ElementFormat):void
        {
            if (this._disabledElementFormat == arg1) 
            {
                return;
            }
            this._disabledElementFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function calculateSnapshotDimensions():void
        {
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            if (this._savedTextLinesWidth < this.actualWidth) 
            {
                loc5 = Math.ceil(this._savedTextLinesWidth * loc2);
            }
            else 
            {
                loc5 = Math.ceil(this.actualWidth * loc2);
            }
            if (this._savedTextLinesHeight < this.actualHeight) 
            {
                loc6 = Math.ceil(this._savedTextLinesHeight * loc2);
            }
            else 
            {
                loc6 = Math.ceil(this.actualHeight * loc2);
            }
            if (this._updateSnapshotOnScaleChange) 
            {
                this.getTransformationMatrix(this.stage, HELPER_MATRIX);
                loc5 = loc5 * feathers.utils.geom.matrixToScaleX(HELPER_MATRIX);
                loc6 = loc6 * feathers.utils.geom.matrixToScaleY(HELPER_MATRIX);
            }
            if (loc5 >= 1 && loc6 >= 1 && !(this._nativeFilters === null) && this._nativeFilters.length > 0) 
            {
                loc5 = this._textSnapshotNativeFiltersWidth;
                loc6 = this._textSnapshotNativeFiltersHeight;
            }
            var loc3:*=starling.utils.Pool.getPoint();
            feathers.utils.textures.calculateSnapshotTextureDimensions(loc5, loc6, this._maxTextureDimensions, !(loc1.profile === flash.display3D.Context3DProfile.BASELINE_CONSTRAINED), loc3);
            this._snapshotWidth = loc3.x;
            this._snapshotHeight = loc3.y;
            this._snapshotVisibleWidth = loc5;
            this._snapshotVisibleHeight = loc6;
            starling.utils.Pool.putPoint(loc3);
            var loc4:*=this.textSnapshot ? this.textSnapshot.texture.root : null;
            this._needsNewTexture = this._needsNewTexture || this.textSnapshot === null || !(loc4 === null) && (!(loc4.scale === loc2) || !(this._snapshotWidth === loc4.nativeWidth) || !(this._snapshotHeight === loc4.nativeHeight));
            return;
        }

        public function get selectedElementFormat():flash.text.engine.ElementFormat
        {
            return this._selectedElementFormat;
        }

        public function set selectedElementFormat(arg1:flash.text.engine.ElementFormat):void
        {
            if (this._selectedElementFormat == arg1) 
            {
                return;
            }
            this._selectedElementFormat = arg1;
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
                    loc7 = this.drawTextLinesRegionToBitmapData(loc5, loc6, loc11, loc12, loc7);
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
                this._lastGlobalContentScaleFactor = loc2;
            }
            this._needsNewTexture = false;
            return;
        }

        public function get leading():Number
        {
            return this._leading;
        }

        public function set leading(arg1:Number):void
        {
            if (this._leading == arg1) 
            {
                return;
            }
            this._leading = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function calculateLineAscent(arg1:flash.text.engine.TextLine):Number
        {
            var loc1:*=arg1.ascent + arg1.descent;
            if (arg1.totalAscent > loc1) 
            {
                loc1 = arg1.totalAscent;
            }
            return loc1;
        }

        public function get textAlign():String
        {
            return this._textAlign;
        }

        public function set textAlign(arg1:String):void
        {
            if (this._textAlign == arg1) 
            {
                return;
            }
            this._textAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get baseline():Number
        {
            if (this._textLines.length == 0) 
            {
                return 0;
            }
            return this.calculateLineAscent(this._textLines[0]);
        }

        protected function refreshTextElementText():void
        {
            if (this._textElement === null) 
            {
                return;
            }
            if (this._text) 
            {
                this._textElement.text = this._text;
                if (!(this._text === null) && this._text.charAt((this._text.length - 1)) == " ") 
                {
                    this._textElement.text = this._textElement.text + String.fromCharCode(3);
                }
            }
            else 
            {
                this._textElement.text = String.fromCharCode(3);
            }
            return;
        }

        public function get applyNonLinearFontScaling():Boolean
        {
            return this._applyNonLinearFontScaling;
        }

        public function set applyNonLinearFontScaling(arg1:Boolean):void
        {
            if (this._applyNonLinearFontScaling == arg1) 
            {
                return;
            }
            this._applyNonLinearFontScaling = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshTextLines(arg1:__AS3__.vec.Vector.<flash.text.engine.TextLine>, arg2:flash.display.DisplayObjectContainer, arg3:Number, arg4:Number, arg5:feathers.controls.text.MeasureTextResult=null):feathers.controls.text.MeasureTextResult
        {
            var loc5:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=false;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=0;
            var loc16:*=false;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=0;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=null;
            var loc23:*=NaN;
            var loc24:*=null;
            var loc25:*=null;
            var loc1:*=false;
            this.refreshTextElementText();
            HELPER_TEXT_LINES.length = 0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=arg1.length;
            var loc6:*=loc4;
            var loc7:*=0;
            while (loc7 < loc4) 
            {
                loc8 = arg1[loc7];
                if (loc8.validity !== flash.text.engine.TextLineValidity.VALID) 
                {
                    loc8 = loc5;
                    if (loc5 !== null) 
                    {
                        loc3 = loc5.y;
                        loc5 = null;
                    }
                    loc6 = loc7;
                    break;
                }
                else 
                {
                    loc5 = loc8;
                }
                ++loc7;
            }
            while (loc7 < loc4) 
            {
                HELPER_TEXT_LINES[int(loc7 - loc6)] = arg1[loc7];
                ++loc7;
            }
            arg1.length = loc6;
            if (arg3 >= 0) 
            {
                loc9 = 0;
                loc10 = this._truncateToFit && this._textElement && !this._wordWrap;
                loc11 = arg1.length;
                loc12 = HELPER_TEXT_LINES.length;
                for (;;) 
                {
                    this._truncationOffset = 0;
                    loc13 = loc8;
                    loc14 = arg3;
                    if (!this._wordWrap) 
                    {
                        loc14 = MAX_TEXT_LINE_WIDTH;
                    }
                    if (loc12 > 0) 
                    {
                        loc18 = HELPER_TEXT_LINES[0];
                        loc8 = this.textBlock.recreateTextLine(loc18, loc13, loc14, 0, true);
                        if (loc8) 
                        {
                            HELPER_TEXT_LINES.shift();
                            --loc12;
                        }
                    }
                    else 
                    {
                        loc8 = this.textBlock.createTextLine(loc13, loc14, 0, true);
                        if (loc8) 
                        {
                            arg2.addChild(loc8);
                        }
                    }
                    if (loc8) 
                    {
                    };
                    loc15 = loc8.rawTextLength;
                    loc16 = false;
                    loc17 = 0;
                    for (;;) 
                    {
                        if (loc10) 
                        {
                            loc10;
                            loc17 = loc26 = loc8.width - arg3;
                        }
                        if (!loc10) 
                        {
                            break;
                        }
                        loc16 = true;
                        if (this._truncationOffset == 0) 
                        {
                            loc21 = loc8.getAtomIndexAtPoint(arg3, 0);
                            if (loc21 >= 0) 
                            {
                                this._truncationOffset = loc8.rawTextLength - loc21;
                            }
                        }
                        var loc26:*;
                        var loc27:*=((loc26 = this)._truncationOffset + 1);
                        loc26._truncationOffset = loc27;
                        loc19 = loc15 - this._truncationOffset;
                        this._textElement.text = this._text.substr(loc9, loc19) + this._truncationText;
                        loc20 = this._text.indexOf(LINE_FEED, loc9);
                        if (loc20 < 0) 
                        {
                            loc20 = this._text.indexOf(CARRIAGE_RETURN, loc9);
                        }
                        if (loc20 >= 0) 
                        {
                            this._textElement.text = this._textElement.text + this._text.substr(loc20);
                        }
                        loc8 = this.textBlock.recreateTextLine(loc8, null, loc14, 0, true);
                        if (!(loc19 <= 0)) 
                        {
                            continue;
                        }
                        break;
                    }
                    if (loc11 > 0) 
                    {
                        loc3 = loc3 + this._leading;
                    }
                    if (loc8.width > loc2) 
                    {
                        loc2 = loc8.width;
                    }
                    loc3 = loc3 + this.calculateLineAscent(loc8);
                    loc8.y = loc3;
                    loc3 = loc3 + loc8.totalDescent;
                    arg1[loc11] = loc8;
                    ++loc11;
                    loc9 = loc9 + loc15;
                    loc1 = loc1 || loc16;
                }
            }
            if (arg1 !== this._measurementTextLines) 
            {
                this.alignTextLines(arg1, arg3, this._currentHorizontalAlign);
            }
            if (this._currentHorizontalAlign !== starling.utils.Align.RIGHT) 
            {
                if (this._currentHorizontalAlign === starling.utils.Align.CENTER) 
                {
                    loc2 = (arg3 + loc2) / 2;
                }
            }
            else 
            {
                loc2 = arg3;
            }
            loc12 = HELPER_TEXT_LINES.length;
            loc7 = 0;
            while (loc7 < loc12) 
            {
                loc8 = HELPER_TEXT_LINES[loc7];
                arg2.removeChild(loc8);
                ++loc7;
            }
            HELPER_TEXT_LINES.length = 0;
            if (arg5 !== null) 
            {
                arg5.width = loc2;
                arg5.height = loc3;
                arg5.isTruncated = loc1;
            }
            else 
            {
                arg5 = new feathers.controls.text.MeasureTextResult(loc2, loc3, loc1);
            }
            if (arg1 !== this._measurementTextLines) 
            {
                if (arg5.width >= 1 && arg5.height >= 1 && !(this._nativeFilters === null) && this._nativeFilters.length > 0) 
                {
                    loc22 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                    loc23 = loc22.contentScaleFactor;
                    HELPER_MATRIX.identity();
                    HELPER_MATRIX.scale(loc23, loc23);
                    loc24 = new flash.display.BitmapData(arg5.width, arg5.height, true, 16711935);
                    loc25 = starling.utils.Pool.getRectangle();
                    loc24.draw(this._textLineContainer, HELPER_MATRIX, null, null, loc25);
                    this.measureNativeFilters(loc24, loc25);
                    loc24.dispose();
                    loc24 = null;
                    this._textSnapshotOffsetX = loc25.x;
                    this._textSnapshotOffsetY = loc25.y;
                    this._textSnapshotNativeFiltersWidth = loc25.width;
                    this._textSnapshotNativeFiltersHeight = loc25.height;
                    starling.utils.Pool.putRectangle(loc25);
                }
                else 
                {
                    this._textSnapshotOffsetX = 0;
                    this._textSnapshotOffsetY = 0;
                    this._textSnapshotNativeFiltersWidth = 0;
                    this._textSnapshotNativeFiltersHeight = 0;
                }
            }
            return arg5;
        }

        public function get baselineFontDescription():flash.text.engine.FontDescription
        {
            return this._baselineFontDescription;
        }

        public function set baselineFontDescription(arg1:flash.text.engine.FontDescription):void
        {
            if (this._baselineFontDescription == arg1) 
            {
                return;
            }
            this._baselineFontDescription = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function getVerticalAlignOffsetY():Number
        {
            if (this._savedTextLinesHeight > this.actualHeight) 
            {
                return 0;
            }
            if (this._currentVerticalAlign === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - this._savedTextLinesHeight;
            }
            if (this._currentVerticalAlign === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - this._savedTextLinesHeight) / 2;
            }
            return 0;
        }

        public function get baselineFontSize():Number
        {
            return this._baselineFontSize;
        }

        public function set baselineFontSize(arg1:Number):void
        {
            if (this._baselineFontSize == arg1) 
            {
                return;
            }
            this._baselineFontSize = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function alignTextLines(arg1:__AS3__.vec.Vector.<flash.text.engine.TextLine>, arg2:Number, arg3:String):void
        {
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg1[loc2];
                if (arg3 != feathers.layout.HorizontalAlign.CENTER) 
                {
                    if (arg3 != feathers.layout.HorizontalAlign.RIGHT) 
                    {
                        loc3.x = 0;
                    }
                    else 
                    {
                        loc3.x = arg2 - loc3.width;
                    }
                }
                else 
                {
                    loc3.x = (arg2 - loc3.width) / 2;
                }
                ++loc2;
            }
            return;
        }

        public function get baselineZero():String
        {
            return this._baselineZero;
        }

        public function set baselineZero(arg1:String):void
        {
            if (this._baselineZero == arg1) 
            {
                return;
            }
            this._baselineZero = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        
        {
            HELPER_TEXT_LINES = new Vector.<flash.text.engine.TextLine>(0);
        }

        public function get bidiLevel():int
        {
            return this._bidiLevel;
        }

        public function set bidiLevel(arg1:int):void
        {
            if (this._bidiLevel == arg1) 
            {
                return;
            }
            this._bidiLevel = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get lineRotation():String
        {
            return this._lineRotation;
        }

        protected static const MAX_TEXT_LINE_WIDTH:Number=1000000;

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        internal static const HELPER_RESULT:feathers.controls.text.MeasureTextResult=new feathers.controls.text.MeasureTextResult();

        internal static const HELPER_MATRIX:flash.geom.Matrix=new flash.geom.Matrix();

        protected static const LINE_FEED:String="\n";

        protected static const CARRIAGE_RETURN:String="\r";

        protected static const FUZZY_TRUNCATION_DIFFERENCE:Number=1e-006;

        public static const TEXT_ALIGN_LEFT:String="left";

        public static const TEXT_ALIGN_CENTER:String="center";

        public static const TEXT_ALIGN_RIGHT:String="right";

        protected var _lastGlobalScaleY:Number=0;

        protected var _lastGlobalContentScaleFactor:Number=0;

        protected var _textLineContainer:flash.display.Sprite;

        protected var _textLines:__AS3__.vec.Vector.<flash.text.engine.TextLine>;

        protected var _measurementTextLineContainer:flash.display.Sprite;

        protected var _measurementTextLines:__AS3__.vec.Vector.<flash.text.engine.TextLine>;

        protected var _previousLayoutActualHeight:Number=NaN;

        protected var _savedTextLinesWidth:Number=NaN;

        protected var _savedTextLinesHeight:Number=NaN;

        protected var _snapshotWidth:int=0;

        protected var _snapshotHeight:int=0;

        protected var _snapshotVisibleWidth:int=0;

        protected var _snapshotVisibleHeight:int=0;

        protected var _needsNewTexture:Boolean=false;

        protected var _truncationOffset:int=0;

        protected var _textElement:flash.text.engine.TextElement;

        protected var _content:flash.text.engine.ContentElement;

        protected var _previousLayoutActualWidth:Number=NaN;

        protected var _fontStylesElementFormat:flash.text.engine.ElementFormat;

        protected var _currentVerticalAlign:String;

        protected var _currentHorizontalAlign:String;

        protected var _verticalAlignOffsetY:Number=0;

        protected var _elementFormatForState:Object;

        protected var _elementFormat:flash.text.engine.ElementFormat;

        protected var _disabledElementFormat:flash.text.engine.ElementFormat;

        protected var _selectedElementFormat:flash.text.engine.ElementFormat;

        protected var _leading:Number=0;

        protected var _textAlign:String=null;

        protected var _applyNonLinearFontScaling:Boolean=true;

        protected var _baselineFontDescription:flash.text.engine.FontDescription;

        protected var _baselineFontSize:Number=12;

        protected var _baselineZero:String="roman";

        protected var _bidiLevel:int=0;

        protected var _lastMeasurementWidth:Number=0;

        protected var _lastMeasurementHeight:Number=0;

        protected var _lastMeasurementWasTruncated:Boolean=false;

        protected var _textBlockChanged:Boolean=true;

        protected var _tabStops:__AS3__.vec.Vector.<flash.text.engine.TabStop>;

        protected var _truncationText:String="...";

        protected var _userData:*;

        protected var _maxTextureDimensions:int=2048;

        protected var _truncateToFit:Boolean=true;

        protected var textBlock:flash.text.engine.TextBlock;

        protected var _lineRotation:String="rotate0";

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        protected var _nativeFilters:Array;

        protected var textSnapshot:starling.display.Image;

        protected var textSnapshots:__AS3__.vec.Vector.<starling.display.Image>;

        protected var _textSnapshotScrollX:Number=0;

        internal static var HELPER_TEXT_LINES:__AS3__.vec.Vector.<flash.text.engine.TextLine>;

        protected var _textJustifier:flash.text.engine.TextJustifier;

        protected var _textSnapshotScrollY:Number=0;

        protected var _textSnapshotOffsetX:Number=0;

        protected var _textSnapshotOffsetY:Number=0;

        protected var _textSnapshotNativeFiltersWidth:Number=0;

        protected var _textSnapshotNativeFiltersHeight:Number=0;

        protected var _lastGlobalScaleX:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _pixelSnapping:Boolean=true;
    }
}


