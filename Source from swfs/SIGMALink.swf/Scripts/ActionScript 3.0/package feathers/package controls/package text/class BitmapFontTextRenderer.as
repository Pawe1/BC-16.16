//class BitmapFontTextRenderer
package feathers.controls.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.skins.*;
    import feathers.text.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.display.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class BitmapFontTextRenderer extends feathers.controls.text.BaseTextRenderer implements feathers.core.ITextRenderer
    {
        public function BitmapFontTextRenderer()
        {
            super();
            if (!CHAR_LOCATION_POOL) 
            {
                CHAR_LOCATION_POOL = new Vector.<CharLocation>(0);
            }
            if (!CHARACTER_BUFFER) 
            {
                CHARACTER_BUFFER = new Vector.<CharLocation>(0);
            }
            this.isQuickHitAreaEnabled = true;
            return;
        }

        public function get baseline():Number
        {
            if (this._currentTextFormat === null) 
            {
                return 0;
            }
            var loc1:*=this._currentTextFormat.font;
            var loc2:*=this._currentTextFormat.size;
            var loc3:*=loc2 / loc1.size;
            if (loc3 !== loc3) 
            {
                loc3 = 1;
            }
            var loc4:*=loc1.baseline;
            this._compilerWorkaround = loc4;
            if (loc4 !== loc4) 
            {
                return loc1.lineHeight * loc3;
            }
            return loc4 * loc3;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            this._characterBatch.x = this._batchX;
            this._characterBatch.y = this._verticalAlignOffsetY;
            super.render(arg1);
            return;
        }

        public function measureText(arg1:flash.geom.Point=null):flash.geom.Point
        {
            var loc21:*=0;
            var loc22:*=null;
            var loc23:*=NaN;
            var loc24:*=false;
            var loc25:*=false;
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
            if (this.isInvalid(INVALIDATION_FLAG_STYLES) || this.isInvalid(INVALIDATION_FLAG_STATE)) 
            {
                this.refreshTextFormat();
            }
            if (!this._currentTextFormat || this._text === null) 
            {
                arg1.setTo(0, 0);
                return arg1;
            }
            var loc3:*=this._currentTextFormat.font;
            var loc4:*=this._currentTextFormat.size;
            var loc5:*=this._currentTextFormat.letterSpacing;
            var loc6:*=this._currentTextFormat.isKerningEnabled;
            var loc7:*=loc4 / loc3.size;
            if (loc7 !== loc7) 
            {
                loc7 = 1;
            }
            var loc8:*=loc3.lineHeight * loc7 + this._currentTextFormat.leading;
            var loc9:*=this._explicitWidth;
            if (loc9 !== loc9) 
            {
                loc9 = this._explicitMaxWidth;
            }
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=NaN;
            var loc14:*=this._text.length;
            var loc15:*=0;
            var loc16:*=0;
            var loc17:*=0;
            var loc18:*="";
            var loc19:*="";
            var loc20:*=0;
            while (loc20 < loc14) 
            {
                loc21 = this._text.charCodeAt(loc20);
                if (loc21 == CHARACTER_ID_LINE_FEED || loc21 == CHARACTER_ID_CARRIAGE_RETURN) 
                {
                    loc11 = loc11 - loc5;
                    if (loc11 < 0) 
                    {
                        loc11 = 0;
                    }
                    if (loc10 < loc11) 
                    {
                        loc10 = loc11;
                    }
                    loc13 = NaN;
                    loc11 = 0;
                    loc12 = loc12 + loc8;
                    loc15 = 0;
                    loc17 = 0;
                    loc16 = 0;
                }
                else 
                {
                    loc22 = loc3.getChar(loc21);
                    if (loc22) 
                    {
                        if (loc6 && loc13 === loc13) 
                        {
                            loc11 = loc11 + loc22.getKerning(loc13) * loc7;
                        }
                        loc23 = loc22.xAdvance * loc7;
                        if (this._wordWrap) 
                        {
                            loc24 = loc21 == CHARACTER_ID_SPACE || loc21 == CHARACTER_ID_TAB;
                            loc25 = loc13 == CHARACTER_ID_SPACE || loc13 == CHARACTER_ID_TAB;
                            if (loc24) 
                            {
                                if (!loc25) 
                                {
                                    loc16 = 0;
                                }
                                loc16 = loc16 + loc23;
                            }
                            else if (loc25) 
                            {
                                loc15 = loc11;
                                ++loc17;
                                loc18 = loc18 + loc19;
                                loc19 = "";
                            }
                            if (!loc24 && loc17 > 0 && loc11 + loc23 > loc9) 
                            {
                                loc16 = loc15 - loc16;
                                if (loc10 < loc16) 
                                {
                                    loc10 = loc16;
                                }
                                loc13 = NaN;
                                loc11 = loc11 - loc15;
                                loc12 = loc12 + loc8;
                                loc15 = 0;
                                loc16 = 0;
                                loc17 = 0;
                                loc18 = "";
                            }
                        }
                        loc11 = loc11 + (loc23 + loc5);
                        loc13 = loc21;
                        loc19 = loc19 + String.fromCharCode(loc21);
                    }
                    else 
                    {
                        trace("Missing character " + String.fromCharCode(loc21) + " in font " + loc3.name + ".");
                    }
                }
                ++loc20;
            }
            loc11 = loc11 - loc5;
            if (loc11 < 0) 
            {
                loc11 = 0;
            }
            if (this._wordWrap) 
            {
                while (loc11 > loc9 && !starling.utils.MathUtil.isEquivalent(loc11, loc9)) 
                {
                    loc11 = loc11 - loc9;
                    loc12 = loc12 + loc8;
                    if (loc9 !== 0) 
                    {
                        continue;
                    }
                }
            }
            if (loc10 < loc11) 
            {
                loc10 = loc11;
            }
            if (loc1) 
            {
                arg1.x = loc10;
            }
            else 
            {
                arg1.x = this._explicitWidth;
            }
            if (loc2) 
            {
                arg1.y = loc12 + loc8 - this._currentTextFormat.leading;
            }
            else 
            {
                arg1.y = this._explicitHeight;
            }
            return arg1;
        }

        public function getTextFormatForState(arg1:String):feathers.text.BitmapFontTextFormat
        {
            if (this._textFormatForState === null) 
            {
                return null;
            }
            return feathers.text.BitmapFontTextFormat(this._textFormatForState[arg1]);
        }

        public function setTextFormatForState(arg1:String, arg2:feathers.text.BitmapFontTextFormat):void
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

        protected override function initialize():void
        {
            if (!this._characterBatch) 
            {
                this._characterBatch = new starling.display.MeshBatch();
                this._characterBatch.touchable = false;
                this.addChild(this._characterBatch);
            }
            return;
        }

        protected override function draw():void
        {
            var loc5:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc2 || loc3) 
            {
                this.refreshTextFormat();
            }
            if (loc2) 
            {
                this._characterBatch.pixelSnapping = this._pixelSnapping;
                this._characterBatch.batchable = !this._useSeparateBatch;
            }
            var loc4:*=this._explicitWidth;
            if (loc4 !== loc4) 
            {
                loc4 = this._explicitMaxWidth;
            }
            if (this._wordWrap) 
            {
                loc5 = !(loc4 === this._lastLayoutWidth);
            }
            else 
            {
                loc5 = loc4 < this._lastLayoutWidth;
                loc5 = loc5 || this._lastLayoutIsTruncated && !(loc4 === this._lastLayoutWidth);
                loc5 = loc5 || !(this._currentTextFormat.align === flash.text.TextFormatAlign.LEFT);
            }
            if (loc1 || loc5 || this._textFormatChanged) 
            {
                this._textFormatChanged = false;
                this._characterBatch.clear();
                if (!this._currentTextFormat || this._text === null) 
                {
                    this.saveMeasurements(0, 0, 0, 0);
                    return;
                }
                this.layoutCharacters(HELPER_RESULT);
                this._lastLayoutWidth = HELPER_RESULT.width;
                this._lastLayoutHeight = HELPER_RESULT.height;
                this._lastLayoutIsTruncated = HELPER_RESULT.isTruncated;
            }
            this.saveMeasurements(this._lastLayoutWidth, this._lastLayoutHeight, this._lastLayoutWidth, this._lastLayoutHeight);
            this._verticalAlignOffsetY = this.getVerticalAlignOffsetY();
            return;
        }

        public function get currentTextFormat():feathers.text.BitmapFontTextFormat
        {
            return this._currentTextFormat;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.text.BitmapFontTextRenderer.globalStyleProvider;
        }

        public override function set maxWidth(arg1:Number):void
        {
            var loc1:*=arg1 > this._explicitMaxWidth && this._lastLayoutIsTruncated;
            super.maxWidth = arg1;
            if (loc1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        protected function layoutCharacters(arg1:feathers.controls.text.MeasureTextResult=null):feathers.controls.text.MeasureTextResult
        {
            var loc24:*=null;
            var loc25:*=0;
            var loc26:*=null;
            var loc27:*=NaN;
            var loc28:*=false;
            var loc29:*=false;
            var loc30:*=null;
            var loc31:*=null;
            if (!arg1) 
            {
                arg1 = new feathers.controls.text.MeasureTextResult();
            }
            this._numLines = 1;
            var loc1:*=this._currentTextFormat.font;
            var loc2:*=this._currentTextFormat.size;
            var loc3:*=this._currentTextFormat.letterSpacing;
            var loc4:*=this._currentTextFormat.isKerningEnabled;
            var loc5:*=loc2 / loc1.size;
            if (loc5 !== loc5) 
            {
                loc5 = 1;
            }
            var loc6:*=loc1.lineHeight * loc5 + this._currentTextFormat.leading;
            var loc7:*=loc1.offsetX * loc5;
            var loc8:*=loc1.offsetY * loc5;
            var loc9:*=this._explicitWidth === this._explicitWidth;
            var loc10:*=!(this._currentTextFormat.align == flash.text.TextFormatAlign.LEFT);
            var loc11:*=loc9 ? this._explicitWidth : this._explicitMaxWidth;
            if (loc10 && loc11 == Number.POSITIVE_INFINITY) 
            {
                this.measureText(HELPER_POINT);
                loc11 = HELPER_POINT.x;
            }
            var loc12:*=this._text;
            if (this._truncateToFit) 
            {
                loc24 = this.getTruncatedText(loc11);
                arg1.isTruncated = !(loc24 === loc12);
                loc12 = loc24;
            }
            else 
            {
                arg1.isTruncated = false;
            }
            CHARACTER_BUFFER.length = 0;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            var loc16:*=NaN;
            var loc17:*=false;
            var loc18:*=0;
            var loc19:*=0;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=loc12 ? loc12.length : 0;
            var loc23:*=0;
            while (loc23 < loc22) 
            {
                loc17 = false;
                loc25 = loc12.charCodeAt(loc23);
                if (loc25 == CHARACTER_ID_LINE_FEED || loc25 == CHARACTER_ID_CARRIAGE_RETURN) 
                {
                    loc14 = loc14 - loc3;
                    if (loc14 < 0) 
                    {
                        loc14 = 0;
                    }
                    if (this._wordWrap || loc10) 
                    {
                        this.alignBuffer(loc11, loc14, 0);
                        this.addBufferToBatch(0);
                    }
                    if (loc13 < loc14) 
                    {
                        loc13 = loc14;
                    }
                    loc16 = NaN;
                    loc14 = 0;
                    loc15 = loc15 + loc6;
                    loc18 = 0;
                    loc19 = 0;
                    loc20 = 0;
                    loc21 = 0;
                    var loc32:*;
                    var loc33:*=((loc32 = this)._numLines + 1);
                    loc32._numLines = loc33;
                }
                else 
                {
                    loc26 = loc1.getChar(loc25);
                    if (loc26) 
                    {
                        if (loc4 && loc16 === loc16) 
                        {
                            loc14 = loc14 + loc26.getKerning(loc16) * loc5;
                        }
                        loc27 = loc26.xAdvance * loc5;
                        if (this._wordWrap) 
                        {
                            loc28 = loc25 == CHARACTER_ID_SPACE || loc25 == CHARACTER_ID_TAB;
                            loc29 = loc16 == CHARACTER_ID_SPACE || loc16 == CHARACTER_ID_TAB;
                            if (loc28) 
                            {
                                if (!loc29) 
                                {
                                    loc19 = 0;
                                }
                                loc19 = loc19 + loc27;
                            }
                            else if (loc29) 
                            {
                                loc18 = loc14;
                                loc20 = 0;
                                ++loc21;
                                loc17 = true;
                            }
                            if (loc17 && !loc10) 
                            {
                                this.addBufferToBatch(0);
                            }
                            if (!loc28 && loc21 > 0 && loc14 + loc27 - loc11 > FUZZY_MAX_WIDTH_PADDING) 
                            {
                                if (loc10) 
                                {
                                    this.trimBuffer(loc20);
                                    this.alignBuffer(loc11, loc18 - loc19, loc20);
                                    this.addBufferToBatch(loc20);
                                }
                                this.moveBufferedCharacters(-loc18, loc6, 0);
                                loc19 = loc18 - loc19;
                                if (loc13 < loc19) 
                                {
                                    loc13 = loc19;
                                }
                                loc16 = NaN;
                                loc14 = loc14 - loc18;
                                loc15 = loc15 + loc6;
                                loc18 = 0;
                                loc19 = 0;
                                loc20 = 0;
                                loc17 = false;
                                loc21 = 0;
                                loc33 = ((loc32 = this)._numLines + 1);
                                loc32._numLines = loc33;
                            }
                        }
                        if (this._wordWrap || loc10) 
                        {
                            loc30 = CHAR_LOCATION_POOL.length > 0 ? CHAR_LOCATION_POOL.shift() : new CharLocation();
                            loc30.char = loc26;
                            loc30.x = loc14 + loc7 + loc26.xOffset * loc5;
                            loc30.y = loc15 + loc8 + loc26.yOffset * loc5;
                            loc30.scale = loc5;
                            CHARACTER_BUFFER[CHARACTER_BUFFER.length] = loc30;
                            ++loc20;
                        }
                        else 
                        {
                            this.addCharacterToBatch(loc26, loc14 + loc7 + loc26.xOffset * loc5, loc15 + loc8 + loc26.yOffset * loc5, loc5);
                        }
                        loc14 = loc14 + (loc27 + loc3);
                        loc16 = loc25;
                    }
                    else 
                    {
                        trace("Missing character " + String.fromCharCode(loc25) + " in font " + loc1.name + ".");
                    }
                }
                ++loc23;
            }
            loc14 = loc14 - loc3;
            if (loc14 < 0) 
            {
                loc14 = 0;
            }
            if (this._wordWrap || loc10) 
            {
                this.alignBuffer(loc11, loc14, 0);
                this.addBufferToBatch(0);
            }
            if (this._wordWrap) 
            {
                while (loc14 > loc11 && !starling.utils.MathUtil.isEquivalent(loc14, loc11)) 
                {
                    loc14 = loc14 - loc11;
                    loc15 = loc15 + loc6;
                    if (loc11 !== 0) 
                    {
                        continue;
                    }
                }
            }
            if (loc13 < loc14) 
            {
                loc13 = loc14;
            }
            if (loc10 && !loc9) 
            {
                loc31 = this._currentTextFormat.align;
                if (loc31 != flash.text.TextFormatAlign.CENTER) 
                {
                    if (loc31 == flash.text.TextFormatAlign.RIGHT) 
                    {
                        this._batchX = loc13 - loc11;
                    }
                }
                else 
                {
                    this._batchX = (loc13 - loc11) / 2;
                }
            }
            else 
            {
                this._batchX = 0;
            }
            this._characterBatch.x = this._batchX;
            arg1.width = loc13;
            arg1.height = loc15 + loc6 - this._currentTextFormat.leading;
            return arg1;
        }

        public function get numLines():int
        {
            return this._numLines;
        }

        protected function trimBuffer(arg1:int):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc1:*=0;
            var loc2:*=CHARACTER_BUFFER.length - arg1;
            var loc3:*;
            --loc3;
            while (loc3 >= 0) 
            {
                loc4 = CHARACTER_BUFFER[loc3];
                loc5 = loc4.char;
                loc6 = loc5.charID;
                if (loc6 == CHARACTER_ID_SPACE || loc6 == CHARACTER_ID_TAB) 
                {
                    ++loc1;
                }
                else 
                {
                    break;
                }
                --loc3;
            }
            if (loc1 > 0) 
            {
                CHARACTER_BUFFER.splice(loc3 + 1, loc1);
            }
            return;
        }

        protected function alignBuffer(arg1:Number, arg2:Number, arg3:int):void
        {
            var loc1:*=this._currentTextFormat.align;
            if (loc1 != flash.text.TextFormatAlign.CENTER) 
            {
                if (loc1 == flash.text.TextFormatAlign.RIGHT) 
                {
                    this.moveBufferedCharacters(arg1 - arg2, 0, arg3);
                }
            }
            else 
            {
                this.moveBufferedCharacters(Math.round((arg1 - arg2) / 2), 0, arg3);
            }
            return;
        }

        public function get textFormat():feathers.text.BitmapFontTextFormat
        {
            return this._textFormat;
        }

        public function set textFormat(arg1:feathers.text.BitmapFontTextFormat):void
        {
            if (this._textFormat == arg1) 
            {
                return;
            }
            this._textFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addBufferToBatch(arg1:int):void
        {
            var loc4:*=null;
            var loc1:*=CHARACTER_BUFFER.length - arg1;
            var loc2:*=CHAR_LOCATION_POOL.length;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = CHARACTER_BUFFER.shift();
                this.addCharacterToBatch(loc4.char, loc4.x, loc4.y, loc4.scale);
                loc4.char = null;
                CHAR_LOCATION_POOL[loc2] = loc4;
                ++loc2;
                ++loc3;
            }
            return;
        }

        public function get disabledTextFormat():feathers.text.BitmapFontTextFormat
        {
            return this._disabledTextFormat;
        }

        public function set disabledTextFormat(arg1:feathers.text.BitmapFontTextFormat):void
        {
            if (this._disabledTextFormat == arg1) 
            {
                return;
            }
            this._disabledTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function moveBufferedCharacters(arg1:Number, arg2:Number, arg3:int):void
        {
            var loc3:*=null;
            var loc1:*=CHARACTER_BUFFER.length - arg3;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = CHARACTER_BUFFER[loc2];
                loc3.x = loc3.x + arg1;
                loc3.y = loc3.y + arg2;
                ++loc2;
            }
            return;
        }

        public function get selectedTextFormat():feathers.text.BitmapFontTextFormat
        {
            return this._selectedTextFormat;
        }

        public function set selectedTextFormat(arg1:feathers.text.BitmapFontTextFormat):void
        {
            if (this._selectedTextFormat == arg1) 
            {
                return;
            }
            this._selectedTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addCharacterToBatch(arg1:starling.text.BitmapChar, arg2:Number, arg3:Number, arg4:Number, arg5:starling.rendering.Painter=null):void
        {
            var loc1:*=arg1.texture;
            var loc2:*=loc1.frame;
            if (loc2) 
            {
                if (loc2.width === 0 || loc2.height === 0) 
                {
                    return;
                }
            }
            else if (loc1.width === 0 || loc1.height === 0) 
            {
                return;
            }
            if (HELPER_IMAGE) 
            {
                HELPER_IMAGE.texture = loc1;
                HELPER_IMAGE.readjustSize();
            }
            else 
            {
                HELPER_IMAGE = new starling.display.Image(loc1);
            }
            var loc3:*;
            HELPER_IMAGE.scaleY = loc3 = arg4;
            HELPER_IMAGE.scaleX = loc3;
            HELPER_IMAGE.x = arg2;
            HELPER_IMAGE.y = arg3;
            HELPER_IMAGE.color = this._currentTextFormat.color;
            HELPER_IMAGE.textureSmoothing = this._textureSmoothing;
            HELPER_IMAGE.pixelSnapping = this._pixelSnapping;
            if (this._style !== null) 
            {
                HELPER_IMAGE.style = this._style;
            }
            if (arg5 === null) 
            {
                this._characterBatch.addMesh(HELPER_IMAGE);
            }
            else 
            {
                arg5.pushState();
                arg5.setStateTo(HELPER_IMAGE.transformationMatrix);
                arg5.batchMesh(HELPER_IMAGE);
                arg5.popState();
            }
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            if (this._textureSmoothing == arg1) 
            {
                return;
            }
            this._textureSmoothing = arg1;
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
                        loc1 = feathers.text.BitmapFontTextFormat(this._textFormatForState[loc2]);
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
            if (this._currentTextFormat !== loc1) 
            {
                this._currentTextFormat = loc1;
                this._textFormatChanged = true;
            }
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

        protected function getTextFormatFromFontStyles():feathers.text.BitmapFontTextFormat
        {
            var loc1:*=null;
            var loc2:*=null;
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
                        if (!starling.text.TextField.getBitmapFont(starling.text.BitmapFont.MINI)) 
                        {
                            loc2 = new starling.text.BitmapFont();
                            starling.text.TextField.registerCompositor(loc2, loc2.name);
                        }
                        this._fontStylesTextFormat = new feathers.text.BitmapFontTextFormat(starling.text.BitmapFont.MINI, NaN, 0);
                        this._currentVerticalAlign = starling.utils.Align.TOP;
                    }
                }
                else 
                {
                    this._fontStylesTextFormat = new feathers.text.BitmapFontTextFormat(loc1.font, loc1.size, loc1.color, loc1.horizontalAlign, loc1.leading);
                    this._currentVerticalAlign = loc1.verticalAlign;
                }
            }
            return this._fontStylesTextFormat;
        }

        public function get truncateToFit():Boolean
        {
            return this._truncateToFit;
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

        protected function getTruncatedText(arg1:Number):String
        {
            var loc11:*=0;
            var loc12:*=null;
            var loc13:*=NaN;
            var loc14:*=NaN;
            if (!this._text) 
            {
                return "";
            }
            if (arg1 == Number.POSITIVE_INFINITY || this._wordWrap || this._text.indexOf(String.fromCharCode(CHARACTER_ID_LINE_FEED)) >= 0 || this._text.indexOf(String.fromCharCode(CHARACTER_ID_CARRIAGE_RETURN)) >= 0) 
            {
                return this._text;
            }
            var loc1:*=this._currentTextFormat.font;
            var loc2:*=this._currentTextFormat.size;
            var loc3:*=this._currentTextFormat.letterSpacing;
            var loc4:*=this._currentTextFormat.isKerningEnabled;
            var loc5:*=loc2 / loc1.size;
            if (loc5 !== loc5) 
            {
                loc5 = 1;
            }
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=this._text.length;
            var loc9:*=-1;
            var loc10:*=0;
            while (loc10 < loc8) 
            {
                loc11 = this._text.charCodeAt(loc10);
                loc12 = loc1.getChar(loc11);
                if (loc12) 
                {
                    loc13 = 0;
                    if (loc4 && loc7 === loc7) 
                    {
                        loc13 = loc12.getKerning(loc7) * loc5;
                    }
                    loc6 = loc6 + (loc13 + loc12.xAdvance * loc5);
                    if (loc6 > arg1) 
                    {
                        loc14 = Math.abs(loc6 - arg1);
                        if (loc14 > FUZZY_MAX_WIDTH_PADDING) 
                        {
                            loc9 = loc10;
                            break;
                        }
                    }
                    loc6 = loc6 + loc3;
                    loc7 = loc11;
                }
                ++loc10;
            }
            if (loc9 >= 0) 
            {
                loc8 = this._truncationText.length;
                loc10 = 0;
                while (loc10 < loc8) 
                {
                    loc11 = this._truncationText.charCodeAt(loc10);
                    loc12 = loc1.getChar(loc11);
                    if (loc12) 
                    {
                        loc13 = 0;
                        if (loc4 && loc7 === loc7) 
                        {
                            loc13 = loc12.getKerning(loc7) * loc5;
                        }
                        loc6 = loc6 + (loc13 + loc12.xAdvance * loc5 + loc3);
                        loc7 = loc11;
                    }
                    ++loc10;
                }
                loc6 = loc6 - loc3;
                loc10 = loc9;
                while (loc10 >= 0) 
                {
                    loc11 = this._text.charCodeAt(loc10);
                    loc7 = loc10 > 0 ? this._text.charCodeAt((loc10 - 1)) : NaN;
                    loc12 = loc1.getChar(loc11);
                    if (loc12) 
                    {
                        loc13 = 0;
                        if (loc4 && loc7 === loc7) 
                        {
                            loc13 = loc12.getKerning(loc7) * loc5;
                        }
                        loc6 = loc6 - (loc13 + loc12.xAdvance * loc5 + loc3);
                        if (loc6 <= arg1) 
                        {
                            return this._text.substr(0, loc10) + this._truncationText;
                        }
                    }
                    --loc10;
                }
                return this._truncationText;
            }
            return this._text;
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

        protected function getVerticalAlignOffsetY():Number
        {
            var loc1:*=this._currentTextFormat.font;
            var loc2:*=this._currentTextFormat.size;
            var loc3:*=loc2 / loc1.size;
            if (loc3 !== loc3) 
            {
                loc3 = 1;
            }
            var loc4:*=loc1.lineHeight * loc3 + this._currentTextFormat.leading;
            var loc5:*=this._numLines * loc4;
            if (loc5 > this.actualHeight) 
            {
                return 0;
            }
            if (this._currentVerticalAlign === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - loc5;
            }
            if (this._currentVerticalAlign === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - loc5) / 2;
            }
            return 0;
        }

        public function get useSeparateBatch():Boolean
        {
            return this._useSeparateBatch;
        }

        public function set useSeparateBatch(arg1:Boolean):void
        {
            if (this._useSeparateBatch == arg1) 
            {
                return;
            }
            this._useSeparateBatch = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            if (this._style == arg1) 
            {
                return;
            }
            this._style = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        internal static const HELPER_RESULT:feathers.controls.text.MeasureTextResult=new feathers.controls.text.MeasureTextResult();

        internal static const CHARACTER_ID_SPACE:int=32;

        internal static const CHARACTER_ID_TAB:int=9;

        internal static const CHARACTER_ID_LINE_FEED:int=10;

        internal static const CHARACTER_ID_CARRIAGE_RETURN:int=13;

        internal static const FUZZY_MAX_WIDTH_PADDING:Number=1e-006;

        protected var _numLines:int=0;

        protected var _textFormatForState:Object;

        protected var _textFormat:feathers.text.BitmapFontTextFormat;

        protected var _disabledTextFormat:feathers.text.BitmapFontTextFormat;

        protected var _selectedTextFormat:feathers.text.BitmapFontTextFormat;

        protected var _textureSmoothing:String="bilinear";

        protected var _pixelSnapping:Boolean=true;

        protected var _truncateToFit:Boolean=true;

        protected var _truncationText:String="...";

        protected var _useSeparateBatch:Boolean=true;

        protected var _style:starling.styles.MeshStyle;

        protected var _lastLayoutWidth:Number=0;

        protected var _lastLayoutHeight:Number=0;

        protected var _lastLayoutIsTruncated:Boolean=false;

        internal var _compilerWorkaround:Object;

        internal static var HELPER_IMAGE:starling.display.Image;

        protected var _characterBatch:starling.display.MeshBatch;

        protected var _batchX:Number=0;

        protected var _textFormatChanged:Boolean=true;

        protected var _fontStylesTextFormat:feathers.text.BitmapFontTextFormat;

        protected var _currentVerticalAlign:String;

        protected var _verticalAlignOffsetY:Number=0;

        internal static var CHARACTER_BUFFER:__AS3__.vec.Vector.<CharLocation>;

        internal static var CHAR_LOCATION_POOL:__AS3__.vec.Vector.<CharLocation>;

        protected var _currentTextFormat:feathers.text.BitmapFontTextFormat;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}

import starling.text.*;


class CharLocation extends Object
{
    public function CharLocation()
    {
        super();
        return;
    }

    public var char:starling.text.BitmapChar;

    public var scale:Number;

    public var x:Number;

    public var y:Number;
}

