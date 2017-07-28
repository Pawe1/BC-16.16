//package text
//  class BaseTextRenderer
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.text.*;
    import starling.events.*;
    
    public class BaseTextRenderer extends feathers.core.FeathersControl implements feathers.core.IStateObserver
    {
        public function BaseTextRenderer()
        {
            super();
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

        public function get stateContext():feathers.core.IStateContext
        {
            return this._stateContext;
        }

        public function set stateContext(arg1:feathers.core.IStateContext):void
        {
            if (this._stateContext === arg1) 
            {
                return;
            }
            if (this._stateContext) 
            {
                this._stateContext.removeEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this._stateContext = arg1;
            if (this._stateContext) 
            {
                this._stateContext.addEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this._wordWrap == arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public override function dispose():void
        {
            this.stateContext = null;
            this.fontStyles = null;
            super.dispose();
            return;
        }

        protected function stateContext_stateChangeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        protected function fontStylesSet_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected var _text:String=null;

        protected var _stateContext:feathers.core.IStateContext;

        protected var _wordWrap:Boolean=false;

        protected var _fontStyles:feathers.text.FontStylesSet;
    }
}


//  class BitmapFontTextRenderer
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

//  class ITextEditorViewPort
package feathers.controls.text 
{
    import feathers.controls.supportClasses.*;
    import feathers.core.*;
    
    public interface ITextEditorViewPort extends feathers.core.ITextEditor, feathers.controls.supportClasses.IViewPort
    {
    }
}


//  class MeasureTextResult
package feathers.controls.text 
{
    public class MeasureTextResult extends Object
    {
        public function MeasureTextResult(arg1:Number=0, arg2:Number=0, arg3:Boolean=false)
        {
            super();
            this.width = arg1;
            this.height = arg2;
            this.isTruncated = arg3;
            return;
        }

        public var width:Number;

        public var height:Number;

        public var isTruncated:Boolean;
    }
}


//  class StageTextTextEditor
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.display.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class StageTextTextEditor extends feathers.core.BaseTextEditor implements feathers.core.IMultilineTextEditor, feathers.core.INativeFocusOwner
    {
        public function StageTextTextEditor()
        {
            super();
            this._stageTextIsTextField = new RegExp("^(Windows|Mac OS|Linux) .*").exec(flash.system.Capabilities.os) || flash.system.Capabilities.playerType === "Desktop" && flash.system.Capabilities.isDebugger;
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textEditor_removedFromStageHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
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
            var loc5:*=starling.utils.Pool.getPoint();
            this.measure(loc5);
            var loc6:*=this.saveMeasurements(loc5.x, loc5.y, loc5.x, loc5.y);
            starling.utils.Pool.putPoint(loc5);
            return loc6;
        }

        public function get nativeFocus():Object
        {
            if (!this._isEditable) 
            {
                return null;
            }
            return this.stageText;
        }

        protected function refreshMeasureProperties():void
        {
            var loc2:*=null;
            this._measureTextField.displayAsPassword = this._displayAsPassword;
            this._measureTextField.maxChars = this._maxChars;
            this._measureTextField.restrict = this._restrict;
            this._measureTextField.multiline = this._multiline;
            this._measureTextField.wordWrap = this._multiline;
            var loc1:*=this._measureTextField.defaultTextFormat;
            if (this._fontStyles !== null) 
            {
                loc2 = this._fontStyles.getTextFormatForTarget(this);
            }
            if (this._fontFamily === null) 
            {
                if (loc2 === null) 
                {
                    loc1.font = null;
                }
                else 
                {
                    loc1.font = loc2.font;
                }
            }
            else 
            {
                loc1.font = this._fontFamily;
            }
            if (this._fontSize > 0) 
            {
                loc1.size = this._fontSize;
            }
            else if (loc2 === null) 
            {
                loc1.size = 12;
            }
            else 
            {
                loc1.size = loc2.size;
            }
            if (this._fontWeight === null) 
            {
                if (loc2 === null) 
                {
                    loc1.bold = false;
                }
                else 
                {
                    loc1.bold = loc2.bold;
                }
            }
            else 
            {
                loc1.bold = this._fontWeight === flash.text.engine.FontWeight.BOLD;
            }
            if (this._fontPosture === null) 
            {
                if (loc2 === null) 
                {
                    loc1.italic = false;
                }
                else 
                {
                    loc1.italic = loc2.italic;
                }
            }
            else 
            {
                loc1.italic = this._fontPosture === flash.text.engine.FontPosture.ITALIC;
            }
            this._measureTextField.defaultTextFormat = loc1;
            this._measureTextField.setTextFormat(loc1);
            if (this._text.length != 0) 
            {
                this._measureTextField.text = this._text;
            }
            else 
            {
                this._measureTextField.text = " ";
            }
            return;
        }

        protected function refreshStageTextProperties():void
        {
            var loc1:*=null;
            if (this.stageText.multiline != this._multiline) 
            {
                if (this.stageText) 
                {
                    this.disposeStageText();
                }
                this.createStageText();
            }
            if (this._fontStyles !== null) 
            {
                loc1 = this._fontStyles.getTextFormatForTarget(this);
            }
            this.stageText.autoCapitalize = this._autoCapitalize;
            this.stageText.autoCorrect = this._autoCorrect;
            if (this._isEnabled) 
            {
                if (this._color !== uint.MAX_VALUE) 
                {
                    this.stageText.color = this._color;
                }
                else if (loc1 === null) 
                {
                    this.stageText.color = 0;
                }
                else 
                {
                    this.stageText.color = loc1.color;
                }
            }
            else if (this._disabledColor !== uint.MAX_VALUE) 
            {
                this.stageText.color = this._disabledColor;
            }
            else if (this._color !== uint.MAX_VALUE) 
            {
                this.stageText.color = this._color;
            }
            else if (loc1 === null) 
            {
                this.stageText.color = 0;
            }
            else 
            {
                this.stageText.color = loc1.color;
            }
            this.stageText.displayAsPassword = this._displayAsPassword;
            var loc2:*=this._fontFamily;
            if (loc2 === null && !(loc1 === null)) 
            {
                loc2 = loc1.font;
            }
            this.stageText.fontFamily = loc2;
            var loc3:*=this._fontPosture;
            if (loc3 === null) 
            {
                if (!(loc1 === null) && loc1.italic) 
                {
                    loc3 = flash.text.engine.FontPosture.ITALIC;
                }
                else 
                {
                    loc3 = flash.text.engine.FontPosture.NORMAL;
                }
            }
            this.stageText.fontPosture = loc3;
            var loc4:*=this._fontWeight;
            if (loc4 === null) 
            {
                if (!(loc1 === null) && loc1.bold) 
                {
                    loc4 = flash.text.engine.FontWeight.BOLD;
                }
                else 
                {
                    loc4 = flash.text.engine.FontWeight.NORMAL;
                }
            }
            this.stageText.fontWeight = loc4;
            this.stageText.locale = this._locale;
            this.stageText.maxChars = this._maxChars;
            this.stageText.restrict = this._restrict;
            this.stageText.returnKeyLabel = this._returnKeyLabel;
            this.stageText.softKeyboardType = this._softKeyboardType;
            var loc5:*=this._textAlign;
            if (loc5 === null) 
            {
                if (!(loc1 === null) && loc1.horizontalAlign) 
                {
                    loc5 = loc1.horizontalAlign;
                }
                else 
                {
                    loc5 = flash.text.TextFormatAlign.START;
                }
            }
            this.stageText.textAlign = loc5;
            return;
        }

        protected function doPendingActions():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._isWaitingToSetFocus) 
            {
                this._isWaitingToSetFocus = false;
                this.setFocus();
            }
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                loc1 = this._pendingSelectionBeginIndex;
                loc2 = this._pendingSelectionEndIndex < 0 ? this._pendingSelectionBeginIndex : this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                if (!(this.stageText.selectionAnchorIndex == loc1) || !(this.stageText.selectionActiveIndex == loc2)) 
                {
                    this.selectRange(loc1, loc2);
                }
            }
            return;
        }

        protected function texture_onRestore():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (this.textSnapshot.texture.scale == loc1.contentScaleFactor) 
            {
                this.refreshSnapshot();
                if (this.textSnapshot) 
                {
                    this.textSnapshot.visible = !this._stageTextHasFocus;
                    this.textSnapshot.alpha = this._text.length > 0 ? 1 : 0;
                }
                if (!this._stageTextHasFocus) 
                {
                    this.stageText.visible = false;
                }
            }
            else 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        protected function refreshSnapshot():void
        {
            var starling:starling.core.Starling;
            var viewPort:flash.geom.Rectangle;
            var nativeScaleFactor:Number;
            var newTexture:starling.textures.Texture;
            var matrix:flash.geom.Matrix;
            var globalScaleX:Number;
            var globalScaleY:Number;
            var bitmapData:flash.display.BitmapData;
            var scaleFactor:Number;
            var existingTexture:starling.textures.Texture;

            var loc1:*;
            viewPort = null;
            newTexture = null;
            bitmapData = null;
            scaleFactor = NaN;
            existingTexture = null;
            starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!(this.stage === null) && this.stageText.stage === null) 
            {
                this.stageText.stage = starling.nativeStage;
            }
            if (this.stageText.stage === null) 
            {
                this.invalidate(INVALIDATION_FLAG_DATA);
                return;
            }
            viewPort = this.stageText.viewPort;
            if (viewPort.width == 0 || viewPort.height == 0) 
            {
                return;
            }
            nativeScaleFactor = 1;
            if (starling.supportHighResolutions) 
            {
                nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
            }
            try 
            {
                bitmapData = new flash.display.BitmapData(viewPort.width * nativeScaleFactor, viewPort.height * nativeScaleFactor, true, 16711935);
                this.stageText.drawViewPortToBitmapData(bitmapData);
            }
            catch (error:Error)
            {
                bitmapData.dispose();
                bitmapData = new flash.display.BitmapData(viewPort.width, viewPort.height, true, 16711935);
                this.stageText.drawViewPortToBitmapData(bitmapData);
            }
            if (!this.textSnapshot || this._needsNewTexture) 
            {
                scaleFactor = starling.contentScaleFactor;
                newTexture = starling.textures.Texture.empty(bitmapData.width / scaleFactor, bitmapData.height / scaleFactor, true, false, false, scaleFactor);
                newTexture.root.uploadBitmapData(bitmapData);
                newTexture.root.onRestore = this.texture_onRestore;
            }
            if (this.textSnapshot) 
            {
                if (this._needsNewTexture) 
                {
                    this.textSnapshot.texture.dispose();
                    this.textSnapshot.texture = newTexture;
                    this.textSnapshot.readjustSize();
                }
                else 
                {
                    existingTexture = this.textSnapshot.texture;
                    existingTexture.root.uploadBitmapData(bitmapData);
                    this.textSnapshot.setRequiresRedraw();
                }
            }
            else 
            {
                this.textSnapshot = new starling.display.Image(newTexture);
                this.textSnapshot.pixelSnapping = true;
                this.addChild(this.textSnapshot);
            }
            matrix = starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, matrix);
            globalScaleX = feathers.utils.geom.matrixToScaleX(matrix);
            globalScaleY = feathers.utils.geom.matrixToScaleY(matrix);
            starling.utils.Pool.putMatrix(matrix);
            if (this._updateSnapshotOnScaleChange) 
            {
                this.textSnapshot.scaleX = 1 / globalScaleX;
                this.textSnapshot.scaleY = 1 / globalScaleY;
                this._lastGlobalScaleX = globalScaleX;
                this._lastGlobalScaleY = globalScaleY;
            }
            else 
            {
                this.textSnapshot.scaleX = 1;
                this.textSnapshot.scaleY = 1;
            }
            if (nativeScaleFactor > 1 && bitmapData.width == viewPort.width) 
            {
                this.textSnapshot.scaleX = this.textSnapshot.scaleX * nativeScaleFactor;
                this.textSnapshot.scaleY = this.textSnapshot.scaleY * nativeScaleFactor;
            }
            bitmapData.dispose();
            this._needsNewTexture = false;
            return;
        }

        protected function refreshViewPortAndFontSize():void
        {
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=null;
            var loc1:*=starling.utils.Pool.getMatrix();
            var loc2:*=starling.utils.Pool.getPoint();
            var loc3:*=0;
            var loc4:*=0;
            if (this._stageTextIsTextField) 
            {
                loc3 = 2;
                loc4 = 4;
            }
            this.getTransformationMatrix(this.stage, loc1);
            if (this._stageTextHasFocus || this._updateSnapshotOnScaleChange) 
            {
                loc15 = feathers.utils.geom.matrixToScaleX(loc1);
                loc16 = feathers.utils.geom.matrixToScaleY(loc1);
                loc17 = loc15;
                if (loc16 < loc17) 
                {
                    loc17 = loc16;
                }
            }
            else 
            {
                loc15 = 1;
                loc16 = 1;
                loc17 = 1;
            }
            var loc5:*=this.getVerticalAlignmentOffsetY();
            if (this.is3D) 
            {
                loc18 = starling.utils.Pool.getMatrix3D();
                loc19 = starling.utils.Pool.getPoint3D();
                this.getTransformationMatrix3D(this.stage, loc18);
                starling.utils.MatrixUtil.transformCoords3D(loc18, -loc3, -loc3 + loc5, 0, loc19);
                loc2.setTo(loc19.x, loc19.y);
                starling.utils.Pool.putPoint3D(loc19);
                starling.utils.Pool.putMatrix3D(loc18);
            }
            else 
            {
                starling.utils.MatrixUtil.transformCoords(loc1, -loc3, -loc3 + loc5, loc2);
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc7:*=1;
            if (loc6.supportHighResolutions) 
            {
                loc7 = loc6.nativeStage.contentsScaleFactor;
            }
            var loc8:*=loc6.contentScaleFactor / loc7;
            var loc9:*=loc6.viewPort;
            var loc10:*=this.stageText.viewPort;
            if (!loc10) 
            {
                loc10 = new flash.geom.Rectangle();
            }
            loc10.x = Math.round(loc9.x + loc2.x * loc8);
            loc10.y = Math.round(loc9.y + loc2.y * loc8);
            var loc11:*=Math.round((this.actualWidth + loc4) * loc8 * loc15);
            if (loc11 < 1 || !(loc11 === loc11)) 
            {
                loc11 = 1;
            }
            var loc12:*=Math.round((this.actualHeight + loc4) * loc8 * loc16);
            if (loc12 < 1 || !(loc12 === loc12)) 
            {
                loc12 = 1;
            }
            loc10.width = loc11;
            loc10.height = loc12;
            this.stageText.viewPort = loc10;
            var loc13:*=12;
            if (this._fontSize > 0) 
            {
                loc13 = this._fontSize;
            }
            else if (this._fontStyles !== null) 
            {
                loc20 = this._fontStyles.getTextFormatForTarget(this);
                if (loc20 !== null) 
                {
                    loc13 = loc20.size;
                }
            }
            var loc14:*=loc13 * loc8 * loc17;
            if (this.stageText.fontSize != loc14) 
            {
                this.stageText.fontSize = loc14;
            }
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function refreshMeasureTextFieldDimensions():void
        {
            this._measureTextField.width = this.actualWidth + 4;
            this._measureTextField.height = this.actualHeight;
            return;
        }

        protected function positionSnapshot():void
        {
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            var loc2:*=0;
            if (this._stageTextIsTextField) 
            {
                loc2 = 2;
            }
            this.textSnapshot.x = Math.round(loc1.tx) - loc1.tx - loc2;
            this.textSnapshot.y = Math.round(loc1.ty) - loc1.ty - loc2 + this.getVerticalAlignmentOffsetY();
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.stageText) 
            {
                return this.stageText.selectionAnchorIndex;
            }
            return 0;
        }

        protected function disposeStageText():void
        {
            if (!this.stageText) 
            {
                return;
            }
            this.stageText.removeEventListener(flash.events.Event.CHANGE, this.stageText_changeHandler);
            this.stageText.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.stageText_keyDownHandler);
            this.stageText.removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.stageText_keyUpHandler);
            this.stageText.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.stageText_focusInHandler);
            this.stageText.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.stageText_focusOutHandler);
            this.stageText.removeEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.stageText.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.stageText_softKeyboardActivateHandler);
            this.stageText.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.stageText_softKeyboardDeactivateHandler);
            this.stageText.stage = null;
            this.stageText.dispose();
            this.stageText = null;
            return;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.stageText) 
            {
                return this.stageText.selectionActiveIndex;
            }
            return 0;
        }

        protected function createStageText():void
        {
            var StageTextType:Class;
            var initOptions:Object;
            var StageTextInitOptionsType:Class;

            var loc1:*;
            StageTextType = null;
            initOptions = null;
            StageTextInitOptionsType = null;
            this._stageTextIsComplete = false;
            try 
            {
                StageTextType = Class(flash.utils.getDefinitionByName("flash.text.StageText"));
                StageTextInitOptionsType = Class(flash.utils.getDefinitionByName("flash.text.StageTextInitOptions"));
                initOptions = new StageTextInitOptionsType(this._multiline);
            }
            catch (error:Error)
            {
                StageTextType = feathers.text.StageTextField;
                initOptions = {"multiline":this._multiline};
            }
            this.stageText = new StageTextType(initOptions);
            this.stageText.visible = false;
            this.stageText.addEventListener(flash.events.Event.CHANGE, this.stageText_changeHandler);
            this.stageText.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.stageText_keyDownHandler);
            this.stageText.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.stageText_keyUpHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.stageText_focusInHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.stageText_focusOutHandler);
            this.stageText.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.stageText_softKeyboardActivateHandler);
            this.stageText.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.stageText_softKeyboardDeactivateHandler);
            this.stageText.addEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.stageText_mouseFocusChangeHandler);
            this.invalidate();
            return;
        }

        public function get baseline():Number
        {
            if (!this._measureTextField) 
            {
                return 0;
            }
            return this._measureTextField.getLineMetrics(0).ascent;
        }

        protected function getVerticalAlignment():String
        {
            var loc2:*=null;
            var loc1:*=null;
            if (this._fontStyles !== null) 
            {
                loc2 = this._fontStyles.getTextFormatForTarget(this);
                if (loc2 !== null) 
                {
                    loc1 = loc2.verticalAlign;
                }
            }
            if (loc1 === null) 
            {
                loc1 = starling.utils.Align.TOP;
            }
            return loc1;
        }

        public function get autoCapitalize():String
        {
            return this._autoCapitalize;
        }

        public function set autoCapitalize(arg1:String):void
        {
            if (this._autoCapitalize == arg1) 
            {
                return;
            }
            this._autoCapitalize = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function getVerticalAlignmentOffsetY():Number
        {
            var loc1:*=this.getVerticalAlignment();
            if (this._measureTextField.textHeight > this.actualHeight) 
            {
                return 0;
            }
            if (loc1 === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - this._measureTextField.textHeight;
            }
            if (loc1 === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - this._measureTextField.textHeight) / 2;
            }
            return 0;
        }

        public function get autoCorrect():Boolean
        {
            return this._autoCorrect;
        }

        public function set autoCorrect(arg1:Boolean):void
        {
            if (this._autoCorrect == arg1) 
            {
                return;
            }
            this._autoCorrect = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dispatchKeyFocusChangeEvent(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=new flash.events.FocusEvent(flash.events.FocusEvent.KEY_FOCUS_CHANGE, true, false, null, arg1.shiftKey, arg1.keyCode);
            loc1.nativeStage.dispatchEvent(loc2);
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            if (this._color == arg1) 
            {
                return;
            }
            this._color = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stageText.stage = null;
            return;
        }

        public function get disabledColor():uint
        {
            return this._disabledColor;
        }

        public function set disabledColor(arg1:uint):void
        {
            if (this._disabledColor == arg1) 
            {
                return;
            }
            this._disabledColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_changeHandler(arg1:flash.events.Event):void
        {
            if (this._ignoreStageTextChanges) 
            {
                return;
            }
            this.text = this.stageText.text;
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

        protected function stageText_completeHandler(arg1:flash.events.Event):void
        {
            this.stageText.removeEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.invalidate();
            this._stageTextIsComplete = true;
            return;
        }

        public function get isEditable():Boolean
        {
            return this._isEditable;
        }

        public function set isEditable(arg1:Boolean):void
        {
            if (this._isEditable == arg1) 
            {
                return;
            }
            this._isEditable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this._stageTextHasFocus = true;
            if (!this._isEditable) 
            {
                this.stageText.editable = false;
            }
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            if (this.textSnapshot) 
            {
                this.textSnapshot.visible = false;
            }
            this.invalidate(INVALIDATION_FLAG_SKIN);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get setTouchFocusOnEndedPhase():Boolean
        {
            return true;
        }

        protected function stageText_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this._stageTextHasFocus = false;
            this.stageText.selectRange(1, 1);
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.invalidate(INVALIDATION_FLAG_SKIN);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        public function get fontFamily():String
        {
            return this._fontFamily;
        }

        public function set fontFamily(arg1:String):void
        {
            if (this._fontFamily == arg1) 
            {
                return;
            }
            this._fontFamily = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this._stageTextHasFocus) 
            {
                loc1 = this;
                do 
                {
                    if (!loc1.visible) 
                    {
                        this.stageText.stage.focus = null;
                        break;
                    }
                    loc1 = loc1.parent;
                }
                while (loc1);
            }
            else 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            }
            return;
        }

        public function get fontPosture():String
        {
            return this._fontPosture;
        }

        public function set fontPosture(arg1:String):void
        {
            if (this._fontPosture == arg1) 
            {
                return;
            }
            this._fontPosture = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_mouseFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            if (!this._maintainTouchFocus) 
            {
                return;
            }
            arg1.preventDefault();
            return;
        }

        public function get fontSize():int
        {
            return this._fontSize;
        }

        public function set fontSize(arg1:int):void
        {
            if (this._fontSize == arg1) 
            {
                return;
            }
            this._fontSize = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=null;
            if (!this._multiline && (arg1.keyCode == flash.ui.Keyboard.ENTER || arg1.keyCode == flash.ui.Keyboard.NEXT)) 
            {
                arg1.preventDefault();
                this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
            }
            else if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.focus = loc1.nativeStage;
            }
            if (arg1.keyCode === flash.ui.Keyboard.TAB && feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                arg1.preventDefault();
                this.dispatchKeyFocusChangeEvent(arg1);
            }
            return;
        }

        public function get fontWeight():String
        {
            return this._fontWeight;
        }

        public function set fontWeight(arg1:String):void
        {
            if (this._fontWeight == arg1) 
            {
                return;
            }
            this._fontWeight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_keyUpHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (!this._multiline && (arg1.keyCode == flash.ui.Keyboard.ENTER || arg1.keyCode == flash.ui.Keyboard.NEXT)) 
            {
                arg1.preventDefault();
            }
            if (arg1.keyCode === flash.ui.Keyboard.TAB && feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                arg1.preventDefault();
            }
            return;
        }

        public function get locale():String
        {
            return this._locale;
        }

        public function set locale(arg1:String):void
        {
            if (this._locale == arg1) 
            {
                return;
            }
            this._locale = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_softKeyboardActivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATE, true);
            return;
        }

        public function get maxChars():int
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:int):void
        {
            if (this._maxChars == arg1) 
            {
                return;
            }
            this._maxChars = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_softKeyboardDeactivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_DEACTIVATE, true);
            return;
        }

        public function get multiline():Boolean
        {
            return this._multiline;
        }

        public function set multiline(arg1:Boolean):void
        {
            if (this._multiline == arg1) 
            {
                return;
            }
            this._multiline = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get restrict():String
        {
            return this._restrict;
        }

        public function set restrict(arg1:String):void
        {
            if (this._restrict == arg1) 
            {
                return;
            }
            this._restrict = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get returnKeyLabel():String
        {
            return this._returnKeyLabel;
        }

        public function set returnKeyLabel(arg1:String):void
        {
            if (this._returnKeyLabel == arg1) 
            {
                return;
            }
            this._returnKeyLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get softKeyboardType():String
        {
            return this._softKeyboardType;
        }

        public function set softKeyboardType(arg1:String):void
        {
            if (this._softKeyboardType == arg1) 
            {
                return;
            }
            this._softKeyboardType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public function get maintainTouchFocus():Boolean
        {
            return this._maintainTouchFocus;
        }

        public function set maintainTouchFocus(arg1:Boolean):void
        {
            this._maintainTouchFocus = arg1;
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
            var loc1:*=null;
            if (this._measureTextField !== null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.removeChild(this._measureTextField);
                this._measureTextField = null;
            }
            if (this.stageText) 
            {
                this.disposeStageText();
            }
            if (this.textSnapshot) 
            {
                this.textSnapshot.texture.dispose();
                this.removeChild(this.textSnapshot, true);
                this.textSnapshot = null;
            }
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            if (this._stageTextHasFocus) 
            {
                arg1.excludeFromCache(this);
            }
            if (this.textSnapshot && this._updateSnapshotOnScaleChange) 
            {
                loc1 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc1);
                if (!(feathers.utils.geom.matrixToScaleX(loc1) === this._lastGlobalScaleX) || !(feathers.utils.geom.matrixToScaleY(loc1) === this._lastGlobalScaleY)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                    this.validate();
                }
                starling.utils.Pool.putMatrix(loc1);
            }
            if (this.stageText && this.stageText.visible) 
            {
                this.refreshViewPortAndFontSize();
            }
            if (this.textSnapshot) 
            {
                this.positionSnapshot();
            }
            super.render(arg1);
            return;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var position:flash.geom.Point=null;
            var starling:starling.core.Starling;
            var positionX:Number;
            var positionY:Number;
            var lineIndex:int;
            var bounds:flash.geom.Rectangle;
            var boundsX:Number;

            var loc1:*;
            starling = null;
            positionX = NaN;
            positionY = NaN;
            lineIndex = 0;
            bounds = null;
            boundsX = NaN;
            position = arg1;
            if (!this._isEditable && starling.utils.SystemUtil.platform === "AND") 
            {
                return;
            }
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (!(this.stage === null) && this.stageText.stage === null) 
            {
                starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this.stageText.stage = starling.nativeStage;
            }
            if (this.stageText && this._stageTextIsComplete) 
            {
                if (position) 
                {
                    positionX = position.x + 2;
                    positionY = position.y + 2;
                    if (positionX < 0) 
                    {
                        var loc2:*;
                        this._pendingSelectionEndIndex = loc2 = 0;
                        this._pendingSelectionBeginIndex = loc2;
                    }
                    else 
                    {
                        this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX, positionY);
                        if (this._pendingSelectionBeginIndex < 0) 
                        {
                            if (this._multiline) 
                            {
                                lineIndex = int(positionY / this._measureTextField.getLineMetrics(0).height);
                                try 
                                {
                                    this._pendingSelectionBeginIndex = this._measureTextField.getLineOffset(lineIndex) + this._measureTextField.getLineLength(lineIndex);
                                    if (this._pendingSelectionBeginIndex != this._text.length) 
                                    {
                                        var loc3:*=((loc2 = this)._pendingSelectionBeginIndex - 1);
                                        loc2._pendingSelectionBeginIndex = loc3;
                                    }
                                }
                                catch (error:Error)
                                {
                                    this._pendingSelectionBeginIndex = this._text.length;
                                }
                            }
                            else 
                            {
                                this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX, this._measureTextField.getLineMetrics(0).ascent / 2);
                                if (this._pendingSelectionBeginIndex < 0) 
                                {
                                    this._pendingSelectionBeginIndex = this._text.length;
                                }
                            }
                        }
                        else 
                        {
                            bounds = this._measureTextField.getCharBoundaries(this._pendingSelectionBeginIndex);
                            boundsX = bounds.x;
                            if (bounds && boundsX + bounds.width - positionX < positionX - boundsX) 
                            {
                                loc3 = ((loc2 = this)._pendingSelectionBeginIndex + 1);
                                loc2._pendingSelectionBeginIndex = loc3;
                            }
                        }
                        this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
                    }
                }
                else 
                {
                    this._pendingSelectionEndIndex = loc2 = -1;
                    this._pendingSelectionBeginIndex = loc2;
                }
                this.stageText.visible = true;
                if (!this._isEditable) 
                {
                    this.stageText.editable = true;
                }
                this.stageText.assignFocus();
            }
            else 
            {
                this._isWaitingToSetFocus = true;
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._stageTextHasFocus) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.focus = null;
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            if (this._stageTextIsComplete && this.stageText) 
            {
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.stageText.selectRange(arg1, arg2);
            }
            else 
            {
                this._pendingSelectionBeginIndex = arg1;
                this._pendingSelectionEndIndex = arg2;
            }
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
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            if (loc3 || loc4) 
            {
                this.refreshMeasureProperties();
            }
            arg1 = this.measure(arg1);
            return arg1;
        }

        protected override function initialize():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!(this._measureTextField === null) && this._measureTextField.parent === null) 
            {
                loc1.nativeStage.addChild(this._measureTextField);
            }
            else if (!this._measureTextField) 
            {
                this._measureTextField = new flash.text.TextField();
                this._measureTextField.visible = false;
                var loc2:*;
                this._measureTextField.mouseWheelEnabled = loc2 = false;
                this._measureTextField.mouseEnabled = loc2;
                this._measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this._measureTextField.multiline = false;
                this._measureTextField.wordWrap = false;
                this._measureTextField.embedFonts = false;
                this._measureTextField.defaultTextFormat = new flash.text.TextFormat(null, 11, 0, false, false, false);
                loc1.nativeStage.addChild(this._measureTextField);
            }
            this.createStageText();
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

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            if (loc2 || loc3) 
            {
                this.refreshMeasureProperties();
            }
            var loc4:*=this._ignoreStageTextChanges;
            this._ignoreStageTextChanges = true;
            if (loc1 || loc2) 
            {
                this.refreshStageTextProperties();
            }
            if (loc3) 
            {
                if (this.stageText.text != this._text) 
                {
                    if (this._pendingSelectionBeginIndex < 0) 
                    {
                        this._pendingSelectionBeginIndex = this.stageText.selectionActiveIndex;
                        this._pendingSelectionEndIndex = this.stageText.selectionAnchorIndex;
                    }
                    this.stageText.text = this._text;
                }
            }
            this._ignoreStageTextChanges = loc4;
            if (loc2 || loc1) 
            {
                this.stageText.editable = this._isEditable && this._isEnabled;
            }
            return;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            this._measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            var loc3:*=this._explicitWidth;
            if (loc1) 
            {
                loc3 = this._measureTextField.textWidth;
                if (loc3 < this._explicitMinWidth) 
                {
                    loc3 = this._explicitMinWidth;
                }
                else if (loc3 > this._explicitMaxWidth) 
                {
                    loc3 = this._explicitMaxWidth;
                }
            }
            this._measureTextField.width = loc3 + 4;
            var loc4:*=this._explicitHeight;
            if (loc2) 
            {
                if (this._stageTextIsTextField) 
                {
                    loc4 = this._measureTextField.textHeight;
                }
                else 
                {
                    loc4 = this._measureTextField.height;
                }
                if (loc4 < this._explicitMinHeight) 
                {
                    loc4 = this._explicitMinHeight;
                }
                else if (loc4 > this._explicitMaxHeight) 
                {
                    loc4 = this._explicitMaxHeight;
                }
            }
            this._measureTextField.autoSize = flash.text.TextFieldAutoSize.NONE;
            this._measureTextField.width = this.actualWidth + 4;
            this._measureTextField.height = this.actualHeight;
            arg1.x = loc3;
            arg1.y = loc4;
            return arg1;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SKIN);
            if (arg1 || loc2 || loc4 || loc1) 
            {
                loc5 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this.refreshViewPortAndFontSize();
                this.refreshMeasureTextFieldDimensions();
                loc6 = this.stageText.viewPort;
                loc7 = this.textSnapshot ? this.textSnapshot.texture.root : null;
                this._needsNewTexture = this._needsNewTexture || !this.textSnapshot || !(loc7 === null) && (!(loc7.scale === loc5.contentScaleFactor) || !(loc6.width === loc7.nativeWidth) || !(loc6.height === loc7.nativeHeight));
            }
            if (!this._stageTextHasFocus && (loc1 || loc2 || loc3 || arg1 || this._needsNewTexture)) 
            {
                loc8 = this._text.length > 0;
                if (loc8) 
                {
                    this.refreshSnapshot();
                }
                if (this.textSnapshot) 
                {
                    this.textSnapshot.visible = !this._stageTextHasFocus;
                    this.textSnapshot.alpha = loc8 ? 1 : 0;
                }
                this.stageText.visible = false;
            }
            this.doPendingActions();
            return;
        }

        protected var stageText:Object;

        protected var textSnapshot:starling.display.Image;

        protected var _needsNewTexture:Boolean=false;

        protected var _ignoreStageTextChanges:Boolean=false;

        protected var _measureTextField:flash.text.TextField;

        protected var _stageTextIsTextField:Boolean=false;

        protected var _stageTextHasFocus:Boolean=false;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _stageTextIsComplete:Boolean=false;

        protected var _autoCapitalize:String="none";

        protected var _autoCorrect:Boolean=false;

        protected var _color:uint=4294967295;

        protected var _disabledColor:uint=4294967295;

        protected var _displayAsPassword:Boolean=false;

        protected var _isEditable:Boolean=true;

        protected var _isSelectable:Boolean=true;

        protected var _fontFamily:String=null;

        protected var _fontPosture:String;

        protected var _fontSize:int=0;

        protected var _fontWeight:String=null;

        protected var _locale:String="en";

        protected var _maxChars:int=0;

        protected var _multiline:Boolean=false;

        protected var _lastGlobalScaleY:Number=0;

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        protected var _softKeyboardType:String="default";

        protected var _restrict:String;

        protected var _maintainTouchFocus:Boolean=false;

        protected var _returnKeyLabel:String="default";

        protected var _textAlign:String;

        protected var _lastGlobalScaleX:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


//  class TextBlockTextEditor
package feathers.controls.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.text.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    
    public class TextBlockTextEditor extends feathers.controls.text.TextBlockTextRenderer implements feathers.core.IIMETextEditor, feathers.core.INativeFocusOwner
    {
        public function TextBlockTextEditor()
        {
            super();
            this._text = "";
            this._textElement = new flash.text.engine.TextElement(this._text);
            this._content = this._textElement;
            this.isQuickHitAreaEnabled = true;
            this.truncateToFit = false;
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.textEditor_touchHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected function getSelectedText():String
        {
            if (this._selectionBeginIndex == this._selectionEndIndex) 
            {
                return null;
            }
            return this._text.substr(this._selectionBeginIndex, this._selectionEndIndex - this._selectionBeginIndex);
        }

        protected function deleteSelectedText():void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            this.text = loc1.substr(0, this._selectionBeginIndex) + loc1.substr(this._selectionEndIndex);
            this.validate();
            this.selectRange(this._selectionBeginIndex, this._selectionBeginIndex);
            return;
        }

        protected function replaceSelectedText(arg1:String):void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            var loc2:*=loc1.substr(0, this._selectionBeginIndex) + arg1 + loc1.substr(this._selectionEndIndex);
            if (this._maxChars > 0 && loc2.length > this._maxChars) 
            {
                return;
            }
            this.text = loc2;
            this.validate();
            var loc3:*=this._selectionBeginIndex + arg1.length;
            this.selectRange(loc3, loc3);
            return;
        }

        protected function imeClientStartCallback():void
        {
            return;
        }

        public function get selectionSkin():starling.display.DisplayObject
        {
            return this._selectionSkin;
        }

        public function set selectionSkin(arg1:starling.display.DisplayObject):void
        {
            if (this._selectionSkin == arg1) 
            {
                return;
            }
            if (this._selectionSkin && this._selectionSkin.parent == this) 
            {
                this._selectionSkin.removeFromParent();
            }
            this._selectionSkin = arg1;
            if (this._selectionSkin) 
            {
                this._selectionSkin.visible = false;
                this.addChildAt(this._selectionSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function imeClientUpdateCallback(arg1:String, arg2:__AS3__.vec.Vector.<flash.text.ime.CompositionAttributeRange>, arg3:int, arg4:int):void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            this._imeText = loc1.substr(0, this._selectionBeginIndex) + arg1 + loc1.substr(this._selectionEndIndex);
            this._imeCursorIndex = this._selectionBeginIndex + arg3;
            this._cursorSkin.visible = this._hasFocus;
            this._selectionSkin.visible = false;
            this.setInvalidationFlag(INVALIDATION_FLAG_DATA);
            this.validate();
            return;
        }

        public function get cursorSkin():starling.display.DisplayObject
        {
            return this._cursorSkin;
        }

        public function set cursorSkin(arg1:starling.display.DisplayObject):void
        {
            if (this._cursorSkin == arg1) 
            {
                return;
            }
            if (this._cursorSkin && this._cursorSkin.parent == this) 
            {
                this._cursorSkin.removeFromParent();
            }
            this._cursorSkin = arg1;
            if (this._cursorSkin) 
            {
                this._cursorSkin.visible = false;
                this.addChild(this._cursorSkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function imeClientConfirmCallback(arg1:String=null, arg2:Boolean=false):void
        {
            this._ignoreNextTextInputEvent = true;
            return;
        }

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this;
            do 
            {
                if (!loc1.visible) 
                {
                    this.clearFocus();
                    break;
                }
                loc1 = loc1.parent;
            }
            while (loc1);
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
            if (this._displayAsPassword) 
            {
                this._unmaskedText = this._text;
                this.refreshMaskedText();
            }
            else 
            {
                this._text = this._unmaskedText;
                this._unmaskedText = null;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (!this._isEnabled || !this._isEditable && !this._isSelectable) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchPointID);
                loc1.getLocation(this, HELPER_POINT);
                HELPER_POINT.x = HELPER_POINT.x + this._textSnapshotScrollX;
                this.selectRange(this._selectionAnchorIndex, this.getSelectionIndexAtPoint(HELPER_POINT.x, HELPER_POINT.y));
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    this.touchPointID = -1;
                    if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && this._hasFocus) 
                    {
                        this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
                    }
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.tapCount === 2) 
                {
                    loc2 = feathers.utils.text.TextInputNavigation.findCurrentWordStartIndex(this._text, this._selectionBeginIndex);
                    loc3 = feathers.utils.text.TextInputNavigation.findCurrentWordEndIndex(this._text, this._selectionEndIndex);
                    this.selectRange(loc2, loc3);
                    return;
                }
                if (loc1.tapCount > 2) 
                {
                    this.selectRange(0, this._text.length);
                    return;
                }
                this.touchPointID = loc1.id;
                loc1.getLocation(this, HELPER_POINT);
                HELPER_POINT.x = HELPER_POINT.x + this._textSnapshotScrollX;
                if (arg1.shiftKey) 
                {
                    if (this._selectionAnchorIndex < 0) 
                    {
                        this._selectionAnchorIndex = this._selectionBeginIndex;
                    }
                    this.selectRange(this._selectionAnchorIndex, this.getSelectionIndexAtPoint(HELPER_POINT.x, HELPER_POINT.y));
                }
                else 
                {
                    this.setFocus(HELPER_POINT);
                }
            }
            return;
        }

        public function get passwordCharCode():int
        {
            return this._passwordCharCode;
        }

        public function set passwordCharCode(arg1:int):void
        {
            if (this._passwordCharCode == arg1) 
            {
                return;
            }
            this._passwordCharCode = arg1;
            if (this._displayAsPassword) 
            {
                this.refreshMaskedText();
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=arg1.getTouch(this.stage, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            loc1.getLocation(this.stage, HELPER_POINT);
            var loc2:*=this.contains(this.stage.hitTest(HELPER_POINT));
            if (loc2) 
            {
                return;
            }
            this.clearFocus();
            return;
        }

        public function get isEditable():Boolean
        {
            return this._isEditable;
        }

        public function set isEditable(arg1:Boolean):void
        {
            if (this._isEditable == arg1) 
            {
                return;
            }
            this._isEditable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function nativeFocus_textInputHandler(arg1:flash.events.TextEvent):void
        {
            if (this._ignoreNextTextInputEvent) 
            {
                this._ignoreNextTextInputEvent = false;
                return;
            }
            if (!this._isEditable || !this._isEnabled) 
            {
                return;
            }
            this._imeText = null;
            this._imeCursorIndex = -1;
            var loc1:*=arg1.text;
            if (loc1 === CARRIAGE_RETURN || loc1 === LINE_FEED) 
            {
                return;
            }
            var loc2:*=loc1.charCodeAt(0);
            if (!this._restrict || this._restrict.isCharacterAllowed(loc2)) 
            {
                this.replaceSelectedText(loc1);
            }
            return;
        }

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get setTouchFocusOnEndedPhase():Boolean
        {
            return false;
        }

        public override function get text():String
        {
            if (this._displayAsPassword) 
            {
                return this._unmaskedText;
            }
            return this._text;
        }

        public override function set text(arg1:String):void
        {
            if (arg1 === null) 
            {
                arg1 = "";
            }
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            if (loc1 == arg1) 
            {
                return;
            }
            if (this._displayAsPassword) 
            {
                this._unmaskedText = arg1;
                this.refreshMaskedText();
            }
            else 
            {
                super.text = arg1;
            }
            var loc2:*=this._text.length;
            if (this._selectionAnchorIndex > loc2) 
            {
                this._selectionAnchorIndex = loc2;
            }
            if (this._selectionBeginIndex > loc2) 
            {
                this.selectRange(loc2, loc2);
            }
            else if (this._selectionEndIndex > loc2) 
            {
                this.selectRange(this._selectionBeginIndex, loc2);
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function nativeFocus_selectAllHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable) 
            {
                return;
            }
            this._selectionAnchorIndex = 0;
            this.selectRange(0, this._text.length);
            return;
        }

        public function get maxChars():int
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:int):void
        {
            if (this._maxChars == arg1) 
            {
                return;
            }
            this._maxChars = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            super.draw();
            if (loc1 || loc2) 
            {
                this.positionCursorAtCharIndex(this.getCursorIndexFromSelectionRange());
                this.positionSelectionBackground();
            }
            return;
        }

        public function get restrict():String
        {
            if (!this._restrict) 
            {
                return null;
            }
            return this._restrict.restrict;
        }

        public function set restrict(arg1:String):void
        {
            if (this._restrict && this._restrict.restrict === arg1) 
            {
                return;
            }
            if (!this._restrict && arg1 === null) 
            {
                return;
            }
            if (arg1 !== null) 
            {
                if (this._restrict) 
                {
                    this._restrict.restrict = arg1;
                }
                else 
                {
                    this._restrict = new feathers.utils.text.TextInputRestrict(arg1);
                }
            }
            else 
            {
                this._restrict = null;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function nativeFocus_cutHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this._selectionBeginIndex == this._selectionEndIndex || this._displayAsPassword) 
            {
                return;
            }
            flash.desktop.Clipboard.generalClipboard.setData(flash.desktop.ClipboardFormats.TEXT_FORMAT, this.getSelectedText());
            if (!this._isEditable) 
            {
                return;
            }
            this.deleteSelectedText();
            return;
        }

        public function get selectionBeginIndex():int
        {
            return this._selectionBeginIndex;
        }

        protected function nativeFocus_copyHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this._selectionBeginIndex == this._selectionEndIndex || this._displayAsPassword) 
            {
                return;
            }
            flash.desktop.Clipboard.generalClipboard.setData(flash.desktop.ClipboardFormats.TEXT_FORMAT, this.getSelectedText());
            return;
        }

        public function get selectionEndIndex():int
        {
            return this._selectionEndIndex;
        }

        protected function nativeFocus_pasteHandler(arg1:flash.events.Event):void
        {
            if (!this._isEditable || !this._isEnabled) 
            {
                return;
            }
            var loc1:*=flash.desktop.Clipboard.generalClipboard.getData(flash.desktop.ClipboardFormats.TEXT_FORMAT) as String;
            if (loc1 === null) 
            {
                return;
            }
            if (this._restrict) 
            {
                loc1 = this._restrict.filterText(loc1);
            }
            this.replaceSelectedText(loc1);
            return;
        }

        public function get selectionAnchorIndex():int
        {
            return this._selectionAnchorIndex;
        }

        public function get selectionActiveIndex():int
        {
            if (this._selectionAnchorIndex === this._selectionBeginIndex) 
            {
                return this._selectionEndIndex;
            }
            return this._selectionBeginIndex;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            var loc3:*=null;
            var loc4:*=0;
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this.touchPointID >= 0 || arg1.isDefaultPrevented()) 
            {
                return;
            }
            var loc1:*=arg1.charCode;
            if (arg1.ctrlKey && (loc1 == 97 || loc1 == 99 || loc1 == 118 || loc1 == 120)) 
            {
                return;
            }
            var loc2:*=-1;
            if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && arg1.keyCode == flash.ui.Keyboard.TAB) 
            {
                this.clearFocus();
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.HOME || arg1.keyCode == flash.ui.Keyboard.UP) 
            {
                loc2 = 0;
            }
            else if (arg1.keyCode == flash.ui.Keyboard.END || arg1.keyCode == flash.ui.Keyboard.DOWN) 
            {
                loc2 = this._text.length;
            }
            else if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                {
                    if (arg1.shiftKey) 
                    {
                        if (this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionEndIndex && !(this._selectionBeginIndex == this._selectionEndIndex)) 
                        {
                            loc2 = this._selectionBeginIndex + 1;
                            this.selectRange(loc2, this._selectionEndIndex);
                        }
                        else 
                        {
                            loc2 = this._selectionEndIndex + 1;
                            if (loc2 < 0 || loc2 > this._text.length) 
                            {
                                loc2 = this._text.length;
                            }
                            this.selectRange(this._selectionBeginIndex, loc2);
                        }
                        return;
                    }
                    if (this._selectionBeginIndex == this._selectionEndIndex) 
                    {
                        if (arg1.altKey || arg1.ctrlKey) 
                        {
                            loc2 = feathers.utils.text.TextInputNavigation.findNextWordStartIndex(this._text, this._selectionEndIndex);
                        }
                        else 
                        {
                            loc2 = this._selectionEndIndex + 1;
                        }
                        if (loc2 < 0 || loc2 > this._text.length) 
                        {
                            loc2 = this._text.length;
                        }
                    }
                    else 
                    {
                        loc2 = this._selectionEndIndex;
                    }
                }
            }
            else 
            {
                if (arg1.shiftKey) 
                {
                    if (this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionBeginIndex && !(this._selectionBeginIndex == this._selectionEndIndex)) 
                    {
                        loc2 = (this._selectionEndIndex - 1);
                        this.selectRange(this._selectionBeginIndex, loc2);
                    }
                    else 
                    {
                        loc2 = (this._selectionBeginIndex - 1);
                        if (loc2 < 0) 
                        {
                            loc2 = 0;
                        }
                        this.selectRange(loc2, this._selectionEndIndex);
                    }
                    return;
                }
                if (this._selectionBeginIndex == this._selectionEndIndex) 
                {
                    if (arg1.altKey || arg1.ctrlKey) 
                    {
                        loc2 = feathers.utils.text.TextInputNavigation.findPreviousWordStartIndex(this._text, this._selectionBeginIndex);
                    }
                    else 
                    {
                        loc2 = (this._selectionBeginIndex - 1);
                    }
                    if (loc2 < 0) 
                    {
                        loc2 = 0;
                    }
                }
                else 
                {
                    loc2 = this._selectionBeginIndex;
                }
            }
            if (loc2 < 0) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.ENTER) 
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
                    return;
                }
                if (!this._isEditable) 
                {
                    return;
                }
                loc3 = this._text;
                if (this._displayAsPassword) 
                {
                    loc3 = this._unmaskedText;
                }
                if (arg1.keyCode != flash.ui.Keyboard.DELETE) 
                {
                    if (arg1.keyCode == flash.ui.Keyboard.BACKSPACE) 
                    {
                        if (arg1.altKey || arg1.ctrlKey) 
                        {
                            loc2 = feathers.utils.text.TextInputNavigation.findPreviousWordStartIndex(this._text, this._selectionBeginIndex);
                            this.text = loc3.substr(0, loc2) + loc3.substr(this._selectionEndIndex);
                        }
                        else if (this._selectionBeginIndex == this._selectionEndIndex) 
                        {
                            if (this._selectionBeginIndex > 0) 
                            {
                                loc2 = (this._selectionBeginIndex - 1);
                                this.text = loc3.substr(0, (this._selectionBeginIndex - 1)) + loc3.substr(this._selectionEndIndex);
                            }
                        }
                        else 
                        {
                            this.deleteSelectedText();
                        }
                    }
                }
                else if (arg1.altKey || arg1.ctrlKey) 
                {
                    loc4 = feathers.utils.text.TextInputNavigation.findNextWordStartIndex(this._text, this._selectionEndIndex);
                    this.text = loc3.substr(0, this._selectionBeginIndex) + loc3.substr(loc4);
                }
                else if (this._selectionBeginIndex == this._selectionEndIndex) 
                {
                    if (this._selectionEndIndex < loc3.length) 
                    {
                        this.text = loc3.substr(0, this._selectionBeginIndex) + loc3.substr(this._selectionEndIndex + 1);
                    }
                }
                else 
                {
                    this.deleteSelectedText();
                }
            }
            if (loc2 >= 0) 
            {
                this.validate();
                this.selectRange(loc2, loc2);
            }
            return;
        }

        public function get nativeFocus():Object
        {
            return this._nativeFocus;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._hasFocus && !arg1) 
            {
                return;
            }
            if (this._nativeFocus === null) 
            {
                this._isWaitingToSetFocus = true;
            }
            else 
            {
                if (this._nativeFocus.parent === null) 
                {
                    loc2 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                    loc2.nativeStage.addChild(this._nativeFocus);
                }
                loc1 = -1;
                if (arg1 !== null) 
                {
                    loc1 = this.getSelectionIndexAtPoint(arg1.x, arg1.y);
                }
                if (loc1 >= 0) 
                {
                    this.selectRange(loc1, loc1);
                }
                this.focusIn();
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._hasFocus) 
            {
                return;
            }
            this._hasFocus = false;
            this._cursorSkin.visible = false;
            this._selectionSkin.visible = false;
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.nativeStage;
            if (loc2.focus === this._nativeFocus) 
            {
                loc2.focus = null;
            }
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            var loc1:*=0;
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (arg2 < arg1) 
            {
                loc1 = arg2;
                arg2 = arg1;
                arg1 = loc1;
            }
            this._selectionBeginIndex = arg1;
            this._selectionEndIndex = arg2;
            if (arg1 !== arg2) 
            {
                this._cursorSkin.visible = false;
                this._selectionSkin.visible = true;
            }
            else 
            {
                this._selectionAnchorIndex = arg1;
                if (arg1 < 0) 
                {
                    this._cursorSkin.visible = false;
                }
                else 
                {
                    this._cursorSkin.visible = this._hasFocus && this._isEditable;
                }
                this._selectionSkin.visible = false;
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public override function dispose():void
        {
            if (this._nativeFocus && this._nativeFocus.parent) 
            {
                this._nativeFocus.parent.removeChild(this._nativeFocus);
            }
            this._nativeFocus = null;
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=this._textSnapshotOffsetX;
            var loc2:*=this._cursorSkin.x;
            this._cursorSkin.x = this._cursorSkin.x - this._textSnapshotScrollX;
            super.render(arg1);
            this._textSnapshotOffsetX = loc1;
            this._cursorSkin.x = loc2;
            return;
        }

        protected override function initialize():void
        {
            if (!this._nativeFocus) 
            {
                this._nativeFocus = new feathers.utils.text.TextEditorIMEClient(this, this.imeClientStartCallback, this.imeClientUpdateCallback, this.imeClientConfirmCallback);
                this._nativeFocus.tabEnabled = false;
                this._nativeFocus.tabChildren = false;
                this._nativeFocus.mouseEnabled = false;
                this._nativeFocus.mouseChildren = false;
                this._nativeFocus.needsSoftKeyboard = true;
            }
            this._nativeFocus.addEventListener(flash.events.Event.CUT, this.nativeFocus_cutHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.COPY, this.nativeFocus_copyHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.PASTE, this.nativeFocus_pasteHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.SELECT_ALL, this.nativeFocus_selectAllHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.TextEvent.TEXT_INPUT, this.nativeFocus_textInputHandler, false, 0, true);
            if (!this._cursorSkin) 
            {
                this.cursorSkin = new starling.display.Quad(1, 1, 0);
            }
            if (!this._selectionSkin) 
            {
                this.selectionSkin = new starling.display.Quad(1, 1, 0);
            }
            super.initialize();
            return;
        }

        protected override function refreshTextElementText():void
        {
            if (this._textElement === null) 
            {
                return;
            }
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            if (loc1) 
            {
                this._textElement.text = loc1;
                if (!(loc1 === null) && loc1.charAt((loc1.length - 1)) == " ") 
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

        protected override function refreshTextLines(arg1:__AS3__.vec.Vector.<flash.text.engine.TextLine>, arg2:flash.display.DisplayObjectContainer, arg3:Number, arg4:Number, arg5:feathers.controls.text.MeasureTextResult=null):feathers.controls.text.MeasureTextResult
        {
            arg5 = super.refreshTextLines(arg1, arg2, arg3, arg4, arg5);
            if (!(arg1 === this._measurementTextLines) && arg2.width > arg3) 
            {
                this.alignTextLines(arg1, arg3, flash.text.TextFormatAlign.LEFT);
            }
            return arg5;
        }

        protected function refreshMaskedText():void
        {
            var loc1:*="";
            var loc2:*=this._unmaskedText.length;
            var loc3:*=String.fromCharCode(this._passwordCharCode);
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc1 = loc1 + loc3;
                ++loc4;
            }
            super.text = loc1;
            return;
        }

        protected function focusIn():void
        {
            var loc3:*=null;
            var loc1:*=(this._isEditable || this._isSelectable) && this._selectionBeginIndex >= 0 && !(this._selectionBeginIndex === this._selectionEndIndex);
            var loc2:*=this._isEditable && this._selectionBeginIndex >= 0 && this._selectionBeginIndex === this._selectionEndIndex;
            this._cursorSkin.visible = loc2;
            this._selectionSkin.visible = loc1;
            if (!feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc3.nativeStage.focus = this._nativeFocus;
            }
            this._nativeFocus.requestSoftKeyboard();
            if (this._hasFocus) 
            {
                return;
            }
            this._hasFocus = true;
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        protected function getSelectionIndexAtPoint(arg1:Number, arg2:Number):int
        {
            if (!this._text || this._textLines.length == 0) 
            {
                return 0;
            }
            var loc1:*=this._textLines[0];
            if (arg1 - loc1.x <= 0) 
            {
                return 0;
            }
            if (arg1 - loc1.x >= loc1.width) 
            {
                return this._text.length;
            }
            var loc2:*=loc1.getAtomIndexAtPoint(arg1, arg2);
            if (loc2 < 0) 
            {
                loc2 = loc1.getAtomIndexAtPoint(arg1, loc1.ascent / 2);
            }
            if (loc2 < 0) 
            {
                return this._text.length;
            }
            if (loc2 > this._text.length) 
            {
                loc2 = this._text.length;
            }
            var loc3:*=loc1.getAtomBounds(loc2);
            if (arg1 - loc1.x - loc3.x > loc3.width / 2) 
            {
                return loc2 + 1;
            }
            return loc2;
        }

        protected function getXPositionOfCharIndex(arg1:int):Number
        {
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            if (!loc1 || this._textLines.length == 0) 
            {
                if (this._textAlign == flash.text.TextFormatAlign.CENTER) 
                {
                    return Math.round(this.actualWidth / 2);
                }
                if (this._textAlign == flash.text.TextFormatAlign.RIGHT) 
                {
                    return this.actualWidth;
                }
                return 0;
            }
            var loc2:*=this._textLines[0];
            if (arg1 == loc1.length) 
            {
                return loc2.x + loc2.width;
            }
            var loc3:*=loc2.getAtomIndexAtCharIndex(arg1);
            return loc2.x + loc2.getAtomBounds(loc3).x;
        }

        protected function positionCursorAtCharIndex(arg1:int):void
        {
            var loc6:*=null;
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            var loc1:*=this.getXPositionOfCharIndex(arg1);
            loc1 = int(loc1 - this._cursorSkin.width / 2);
            this._cursorSkin.x = loc1;
            this._cursorSkin.y = this._verticalAlignOffsetY;
            if (this._textLines.length > 0) 
            {
                loc6 = this._textLines[0];
                this._cursorSkin.height = this.calculateLineAscent(loc6) + loc6.totalDescent;
            }
            else 
            {
                this._cursorSkin.height = this.currentElementFormat.fontSize;
            }
            var loc2:*=loc1 + this._cursorSkin.width - this.actualWidth;
            var loc3:*=this._text;
            if (this._imeText !== null) 
            {
                loc3 = this._imeText;
            }
            var loc4:*=this.getXPositionOfCharIndex(loc3.length) - this.actualWidth;
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            var loc5:*=this._textSnapshotScrollX;
            if (this._textSnapshotScrollX < loc2) 
            {
                this._textSnapshotScrollX = loc2;
            }
            else if (this._textSnapshotScrollX > loc1) 
            {
                this._textSnapshotScrollX = loc1;
            }
            if (this._textSnapshotScrollX > loc4) 
            {
                this._textSnapshotScrollX = loc4;
            }
            if (this._textSnapshotScrollX != loc5) 
            {
                this.invalidate(INVALIDATION_FLAG_DATA);
            }
            return;
        }

        protected function getCursorIndexFromSelectionRange():int
        {
            if (this._imeCursorIndex >= 0) 
            {
                return this._imeCursorIndex;
            }
            var loc1:*=this._selectionEndIndex;
            if (this.touchPointID >= 0 && this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionEndIndex) 
            {
                loc1 = this._selectionBeginIndex;
            }
            return loc1;
        }

        protected function positionSelectionBackground():void
        {
            var loc6:*=null;
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            var loc2:*=this._selectionBeginIndex;
            if (loc2 > loc1.length) 
            {
                loc2 = loc1.length;
            }
            var loc3:*=this.getXPositionOfCharIndex(loc2) - this._textSnapshotScrollX;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            var loc4:*=this._selectionEndIndex;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=this.getXPositionOfCharIndex(loc4) - this._textSnapshotScrollX;
            if (loc5 < 0) 
            {
                loc5 = 0;
            }
            else if (loc5 > this.actualWidth) 
            {
                loc5 = this.actualWidth;
            }
            this._selectionSkin.x = loc3;
            this._selectionSkin.width = loc5 - loc3;
            this._selectionSkin.y = this._verticalAlignOffsetY;
            if (this._textLines.length > 0) 
            {
                loc6 = this._textLines[0];
                this._selectionSkin.height = this.calculateLineAscent(loc6) + loc6.totalDescent;
            }
            else 
            {
                this._selectionSkin.height = this.currentElementFormat.fontSize;
            }
            return;
        }

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const TEXT_ALIGN_LEFT:String="left";

        public static const TEXT_ALIGN_CENTER:String="center";

        public static const TEXT_ALIGN_RIGHT:String="right";

        protected var _ignoreNextTextInputEvent:Boolean=false;

        protected var _imeText:String;

        protected var _imeCursorIndex:int=-1;

        protected var _selectionSkin:starling.display.DisplayObject;

        protected var _cursorSkin:starling.display.DisplayObject;

        protected var _unmaskedText:String;

        protected var _displayAsPassword:Boolean=false;

        protected var _passwordCharCode:int=42;

        protected var _isEditable:Boolean=true;

        protected var _isSelectable:Boolean=true;

        protected var _maxChars:int=0;

        protected var _selectionBeginIndex:int=0;

        protected var _selectionEndIndex:int=0;

        protected var _selectionAnchorIndex:int=0;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var touchPointID:int=-1;

        protected var _restrict:feathers.utils.text.TextInputRestrict;

        protected var _nativeFocus:flash.display.Sprite;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


//  class TextBlockTextRenderer
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


//  class TextFieldTextEditor
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TextFieldTextEditor extends feathers.core.BaseTextEditor implements feathers.core.ITextEditor, feathers.core.INativeFocusOwner
    {
        public function TextFieldTextEditor()
        {
            this._textFieldSnapshotClipRect = new flash.geom.Rectangle();
            super();
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.textEditor_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textEditor_removedFromStageHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            this.commit();
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layout(loc1);
            return;
        }

        public function get nativeFocus():Object
        {
            return this.textField;
        }

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc2 || loc1 || loc3) 
            {
                this.refreshTextFormat();
                this.commitStylesAndData(this.textField);
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
            var loc5:*=starling.utils.Pool.getPoint();
            this.measure(loc5);
            var loc6:*=this.saveMeasurements(loc5.x, loc5.y, loc5.x, loc5.y);
            starling.utils.Pool.putPoint(loc5);
            return loc6;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
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
            this.commitStylesAndData(this.measureTextField);
            var loc3:*=4;
            if (this._useGutter) 
            {
                loc3 = 0;
            }
            var loc4:*=this._explicitWidth;
            if (loc1) 
            {
                this.measureTextField.wordWrap = false;
                loc4 = this.measureTextField.width - loc3;
                if (loc4 < this._explicitMinWidth) 
                {
                    loc4 = this._explicitMinWidth;
                }
                else if (loc4 > this._explicitMaxWidth) 
                {
                    loc4 = this._explicitMaxWidth;
                }
            }
            var loc5:*=this._explicitHeight;
            if (loc2) 
            {
                this.measureTextField.wordWrap = this._wordWrap;
                this.measureTextField.width = loc4 + loc3;
                loc5 = this.measureTextField.height - loc3;
                if (this._useGutter) 
                {
                    loc5 = loc5 + 4;
                }
                if (loc5 < this._explicitMinHeight) 
                {
                    loc5 = this._explicitMinHeight;
                }
                else if (loc5 > this._explicitMaxHeight) 
                {
                    loc5 = this._explicitMaxHeight;
                }
            }
            arg1.x = loc4;
            arg1.y = loc5;
            return arg1;
        }

        protected function commitStylesAndData(arg1:flash.text.TextField):void
        {
            var loc1:*=false;
            arg1.antiAliasType = this._antiAliasType;
            arg1.background = this._background;
            arg1.backgroundColor = this._backgroundColor;
            arg1.border = this._border;
            arg1.borderColor = this._borderColor;
            arg1.gridFitType = this._gridFitType;
            arg1.sharpness = this._sharpness;
            arg1.thickness = this._thickness;
            arg1.maxChars = this._maxChars;
            arg1.restrict = this._restrict;
            arg1.alwaysShowSelection = this._alwaysShowSelection;
            arg1.displayAsPassword = this._displayAsPassword;
            arg1.wordWrap = this._wordWrap;
            arg1.multiline = this._multiline;
            if (!this._embedFonts && this._currentTextFormat === this._fontStylesTextFormat) 
            {
                this.textField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(this._currentTextFormat.font, this._currentTextFormat.bold, this._currentTextFormat.italic, flash.text.FontType.EMBEDDED);
            }
            else 
            {
                this.textField.embedFonts = this._embedFonts;
            }
            arg1.type = this._isEditable ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            arg1.selectable = this._isEnabled && (this._isEditable || this._isSelectable);
            if (arg1 === this.textField) 
            {
                loc1 = !(this._previousTextFormat == this._currentTextFormat);
                this._previousTextFormat = this._currentTextFormat;
            }
            arg1.defaultTextFormat = this._currentTextFormat;
            if (this._isHTML) 
            {
                if (loc1 || !(arg1.htmlText == this._text)) 
                {
                    if (arg1 == this.textField && this._pendingSelectionBeginIndex < 0) 
                    {
                        this._pendingSelectionBeginIndex = this.textField.selectionBeginIndex;
                        this._pendingSelectionEndIndex = this.textField.selectionEndIndex;
                    }
                    arg1.htmlText = this._text;
                }
            }
            else if (loc1 || !(arg1.text == this._text)) 
            {
                if (arg1 == this.textField && this._pendingSelectionBeginIndex < 0) 
                {
                    this._pendingSelectionBeginIndex = this.textField.selectionBeginIndex;
                    this._pendingSelectionEndIndex = this.textField.selectionEndIndex;
                }
                arg1.text = this._text;
            }
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
            }
            if (loc1 === null) 
            {
                loc1 = this._textFormat;
            }
            if (loc1 === null) 
            {
                loc1 = this.getTextFormatFromFontStyles();
            }
            this._currentTextFormat = loc1;
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

        protected function getVerticalAlignment():String
        {
            var loc2:*=null;
            var loc1:*=null;
            if (this._fontStyles !== null) 
            {
                loc2 = this._fontStyles.getTextFormatForTarget(this);
                if (loc2 !== null) 
                {
                    loc1 = loc2.verticalAlign;
                }
            }
            if (loc1 === null) 
            {
                loc1 = starling.utils.Align.TOP;
            }
            return loc1;
        }

        protected function getVerticalAlignmentOffsetY():Number
        {
            var loc1:*=this.getVerticalAlignment();
            var loc2:*=this.textField.textHeight;
            if (loc2 > this.actualHeight) 
            {
                return 0;
            }
            if (loc1 === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - loc2;
            }
            if (loc1 === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - loc2) / 2;
            }
            return 0;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (arg1) 
            {
                this.refreshSnapshotParameters();
                this.refreshTextFieldSize();
                this.transformTextField();
                this.positionSnapshot();
            }
            this.checkIfNewSnapshotIsNeeded();
            if (!this._textFieldHasFocus && (arg1 || loc1 || loc2 || loc3 || this._needsNewTexture)) 
            {
                if (this._useSnapshotDelayWorkaround) 
                {
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.refreshSnapshot_enterFrameHandler);
                }
                else 
                {
                    this.refreshSnapshot();
                }
            }
            this.doPendingActions();
            return;
        }

        protected function getSelectionIndexAtPoint(arg1:Number, arg2:Number):int
        {
            return this.textField.getCharIndexAtPoint(arg1, arg2);
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

        protected function refreshTextFieldSize():void
        {
            var loc1:*=4;
            if (this._useGutter) 
            {
                loc1 = 0;
            }
            this.textField.width = this.actualWidth + loc1;
            this.textField.height = this.actualHeight + loc1;
            return;
        }

        protected function refreshSnapshotParameters():void
        {
            var loc5:*=null;
            this._textFieldOffsetX = 0;
            this._textFieldOffsetY = 0;
            this._textFieldSnapshotClipRect.x = 0;
            this._textFieldSnapshotClipRect.y = 0;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            var loc3:*=this.actualWidth * loc2;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc5 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc5);
                loc3 = loc3 * feathers.utils.geom.matrixToScaleX(loc5);
            }
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            var loc4:*=this.actualHeight * loc2;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc4 = loc4 * feathers.utils.geom.matrixToScaleY(loc5);
                starling.utils.Pool.putMatrix(loc5);
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            this._textFieldSnapshotClipRect.width = loc3;
            this._textFieldSnapshotClipRect.height = loc4;
            return;
        }

        public function get currentTextFormat():flash.text.TextFormat
        {
            return this._currentTextFormat;
        }

        protected function transformTextField():void
        {
            var loc12:*=null;
            var loc13:*=null;
            var loc1:*=starling.utils.Pool.getMatrix();
            var loc2:*=starling.utils.Pool.getPoint();
            this.getTransformationMatrix(this.stage, loc1);
            var loc3:*=feathers.utils.geom.matrixToScaleX(loc1);
            var loc4:*=feathers.utils.geom.matrixToScaleY(loc1);
            var loc5:*=loc3;
            if (loc4 < loc5) 
            {
                loc5 = loc4;
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc7:*=1;
            if (loc6.supportHighResolutions) 
            {
                loc7 = loc6.nativeStage.contentsScaleFactor;
            }
            var loc8:*=loc6.contentScaleFactor / loc7;
            var loc9:*=0;
            if (!this._useGutter) 
            {
                loc9 = 2 * loc5;
            }
            var loc10:*=this.getVerticalAlignmentOffsetY();
            if (this.is3D) 
            {
                loc12 = starling.utils.Pool.getMatrix3D();
                loc13 = starling.utils.Pool.getPoint3D();
                this.getTransformationMatrix3D(this.stage, loc12);
                starling.utils.MatrixUtil.transformCoords3D(loc12, -loc9, -loc9 + loc10, 0, loc13);
                loc2.setTo(loc13.x, loc13.y);
                starling.utils.Pool.putPoint3D(loc13);
                starling.utils.Pool.putMatrix3D(loc12);
            }
            else 
            {
                starling.utils.MatrixUtil.transformCoords(loc1, -loc9, -loc9 + loc10, loc2);
            }
            var loc11:*=loc6.viewPort;
            this.textField.x = Math.round(loc11.x + loc2.x * loc8);
            this.textField.y = Math.round(loc11.y + loc2.y * loc8);
            this.textField.rotation = feathers.utils.geom.matrixToRotation(loc1) * 180 / Math.PI;
            this.textField.scaleX = feathers.utils.geom.matrixToScaleX(loc1) * loc8;
            this.textField.scaleY = feathers.utils.geom.matrixToScaleY(loc1) * loc8;
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function positionSnapshot():void
        {
            if (!this.textSnapshot) 
            {
                return;
            }
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            this.textSnapshot.x = Math.round(loc1.tx) - loc1.tx;
            this.textSnapshot.y = Math.round(loc1.ty) - loc1.ty;
            this.textSnapshot.y = this.textSnapshot.y + this.getVerticalAlignmentOffsetY();
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function checkIfNewSnapshotIsNeeded():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=!(loc1.profile === flash.display3D.Context3DProfile.BASELINE_CONSTRAINED);
            if (loc2) 
            {
                this._snapshotWidth = this._textFieldSnapshotClipRect.width;
                this._snapshotHeight = this._textFieldSnapshotClipRect.height;
            }
            else 
            {
                this._snapshotWidth = starling.utils.MathUtil.getNextPowerOfTwo(this._textFieldSnapshotClipRect.width);
                this._snapshotHeight = starling.utils.MathUtil.getNextPowerOfTwo(this._textFieldSnapshotClipRect.height);
            }
            var loc3:*=this.textSnapshot ? this.textSnapshot.texture.root : null;
            this._needsNewTexture = this._needsNewTexture || !this.textSnapshot || !(loc3 === null) && (!(loc3.scale === loc1.contentScaleFactor) || !(this._snapshotWidth === loc3.nativeWidth) || !(this._snapshotHeight === loc3.nativeHeight));
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
            this._previousTextFormat = null;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function doPendingActions():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._isWaitingToSetFocus) 
            {
                this._isWaitingToSetFocus = false;
                this.setFocus();
            }
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                loc1 = this._pendingSelectionBeginIndex;
                loc2 = this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.selectRange(loc1, loc2);
            }
            return;
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

        protected function texture_onRestore():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (this.textSnapshot && this.textSnapshot.texture && !(this.textSnapshot.texture.scale == loc1.contentScaleFactor)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.refreshSnapshot();
            }
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

        protected function refreshSnapshot():void
        {
            var loc6:*=null;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=null;
            if (this._snapshotWidth <= 0 || this._snapshotHeight <= 0) 
            {
                return;
            }
            var loc1:*=2;
            if (this._useGutter) 
            {
                loc1 = 0;
            }
            var loc2:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc3:*=loc2.contentScaleFactor;
            var loc4:*=starling.utils.Pool.getMatrix();
            if (this._updateSnapshotOnScaleChange) 
            {
                this.getTransformationMatrix(this.stage, loc4);
                loc7 = feathers.utils.geom.matrixToScaleX(loc4);
                loc8 = feathers.utils.geom.matrixToScaleY(loc4);
            }
            loc4.identity();
            loc4.translate(this._textFieldOffsetX - loc1, this._textFieldOffsetY - loc1);
            loc4.scale(loc3, loc3);
            if (this._updateSnapshotOnScaleChange) 
            {
                loc4.scale(loc7, loc8);
            }
            var loc5:*=new flash.display.BitmapData(this._snapshotWidth, this._snapshotHeight, true, 16711935);
            loc5.draw(this.textField, loc4, null, null, this._textFieldSnapshotClipRect);
            starling.utils.Pool.putMatrix(loc4);
            if (!this.textSnapshot || this._needsNewTexture) 
            {
                loc6 = starling.textures.Texture.empty(loc5.width / loc3, loc5.height / loc3, true, false, false, loc3);
                loc6.root.uploadBitmapData(loc5);
                loc6.root.onRestore = this.texture_onRestore;
            }
            if (this.textSnapshot) 
            {
                if (this._needsNewTexture) 
                {
                    this.textSnapshot.texture.dispose();
                    this.textSnapshot.texture = loc6;
                    this.textSnapshot.readjustSize();
                }
                else 
                {
                    loc9 = this.textSnapshot.texture;
                    loc9.root.uploadBitmapData(loc5);
                    this.textSnapshot.setRequiresRedraw();
                }
            }
            else 
            {
                this.textSnapshot = new starling.display.Image(loc6);
                this.textSnapshot.pixelSnapping = true;
                this.addChild(this.textSnapshot);
            }
            if (this._updateSnapshotOnScaleChange) 
            {
                this.textSnapshot.scaleX = 1 / loc7;
                this.textSnapshot.scaleY = 1 / loc8;
                this._lastGlobalScaleX = loc7;
                this._lastGlobalScaleY = loc8;
            }
            this.textSnapshot.alpha = this._text.length > 0 ? 1 : 0;
            loc5.dispose();
            this._needsNewTexture = false;
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this._wordWrap == arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this.textField.parent === null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.addChild(this.textField);
            }
            return;
        }

        public function get multiline():Boolean
        {
            return this._multiline;
        }

        public function set multiline(arg1:Boolean):void
        {
            if (this._multiline == arg1) 
            {
                return;
            }
            this._multiline = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this.textField.parent) 
            {
                this.textField.parent.removeChild(this.textField);
            }
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

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this.textSnapshot) 
            {
                this.textSnapshot.visible = !this._textFieldHasFocus;
            }
            this.textField.visible = this._textFieldHasFocus;
            if (this._textFieldHasFocus) 
            {
                loc1 = this;
                do 
                {
                    if (!loc1.visible) 
                    {
                        this.clearFocus();
                        break;
                    }
                    loc1 = loc1.parent;
                }
                while (loc1);
            }
            else 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            }
            return;
        }

        public function get alwaysShowSelection():Boolean
        {
            return this._alwaysShowSelection;
        }

        public function set alwaysShowSelection(arg1:Boolean):void
        {
            if (this._alwaysShowSelection == arg1) 
            {
                return;
            }
            this._alwaysShowSelection = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshSnapshot_enterFrameHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.refreshSnapshot_enterFrameHandler);
            this.refreshSnapshot();
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

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (this._maintainTouchFocus) 
            {
                return;
            }
            var loc1:*=arg1.getTouch(this.stage, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            var loc2:*=starling.utils.Pool.getPoint();
            loc1.getLocation(this.stage, loc2);
            var loc3:*=this.contains(this.stage.hitTest(loc2));
            starling.utils.Pool.putPoint(loc2);
            if (loc3) 
            {
                return;
            }
            this.clearFocus();
            return;
        }

        public function get maxChars():int
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:int):void
        {
            if (this._maxChars == arg1) 
            {
                return;
            }
            this._maxChars = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textField_changeHandler(arg1:flash.events.Event):void
        {
            if (this._isHTML) 
            {
                this.text = this.textField.htmlText;
            }
            else 
            {
                this.text = this.textField.text;
            }
            return;
        }

        public function get restrict():String
        {
            return this._restrict;
        }

        public function set restrict(arg1:String):void
        {
            if (this._restrict == arg1) 
            {
                return;
            }
            this._restrict = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textField_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this._textFieldHasFocus = true;
            this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        public function get isEditable():Boolean
        {
            return this._isEditable;
        }

        public function set isEditable(arg1:Boolean):void
        {
            if (this._isEditable == arg1) 
            {
                return;
            }
            this._isEditable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textField_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this._textFieldHasFocus = false;
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            if (this.resetScrollOnFocusOut) 
            {
                var loc1:*;
                this.textField.scrollV = loc1 = 0;
                this.textField.scrollH = loc1;
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
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

        protected function textField_mouseFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            if (!this._maintainTouchFocus) 
            {
                return;
            }
            arg1.preventDefault();
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

        protected function textField_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.keyCode != flash.ui.Keyboard.ENTER) 
            {
                if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && arg1.keyCode == flash.ui.Keyboard.TAB) 
                {
                    this.clearFocus();
                }
            }
            else 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
            }
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

        protected function textField_softKeyboardActivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATE, true);
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

        protected function textField_softKeyboardDeactivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_DEACTIVATE, true);
            return;
        }

        public function get background():Boolean
        {
            return this._background;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.textField) 
            {
                return this.textField.selectionBeginIndex;
            }
            return 0;
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

        public function get setTouchFocusOnEndedPhase():Boolean
        {
            return false;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.textField) 
            {
                return this.textField.selectionEndIndex;
            }
            return 0;
        }

        public function get maintainTouchFocus():Boolean
        {
            return this._maintainTouchFocus;
        }

        public function set maintainTouchFocus(arg1:Boolean):void
        {
            this._maintainTouchFocus = arg1;
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
            if (this.textSnapshot) 
            {
                this.textSnapshot.texture.dispose();
                this.removeChild(this.textSnapshot, true);
                this.textSnapshot = null;
            }
            if (this.textField) 
            {
                if (this.textField.parent) 
                {
                    this.textField.parent.removeChild(this.textField);
                }
                this.textField.removeEventListener(flash.events.Event.CHANGE, this.textField_changeHandler);
                this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.textField_focusInHandler);
                this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.textField_focusOutHandler);
                this.textField.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.textField_keyDownHandler);
                this.textField.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.textField_softKeyboardActivateHandler);
                this.textField.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.textField_softKeyboardDeactivateHandler);
            }
            this.textField = null;
            this.measureTextField = null;
            this.stateContext = null;
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            if (this.textSnapshot) 
            {
                if (this._updateSnapshotOnScaleChange) 
                {
                    loc1 = starling.utils.Pool.getMatrix();
                    this.getTransformationMatrix(this.stage, loc1);
                    if (!(feathers.utils.geom.matrixToScaleX(loc1) === this._lastGlobalScaleX) || !(feathers.utils.geom.matrixToScaleY(loc1) === this._lastGlobalScaleY)) 
                    {
                        this.invalidate(INVALIDATION_FLAG_SIZE);
                        this.validate();
                    }
                    starling.utils.Pool.putMatrix(loc1);
                }
                this.positionSnapshot();
            }
            if (this.textField && this.textField.visible) 
            {
                this.transformTextField();
            }
            super.render(arg1);
            return;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var position:flash.geom.Point=null;
            var starling:starling.core.Starling;
            var nativeScaleFactor:Number;
            var scaleFactor:Number;
            var scaleX:Number;
            var scaleY:Number;
            var gutterPositionOffset:Number;
            var positionX:Number;
            var positionY:Number;
            var maxPositionX:Number;
            var maxPositionY:Number;
            var lineIndex:int;
            var bounds:flash.geom.Rectangle;
            var boundsX:Number;

            var loc1:*;
            starling = null;
            nativeScaleFactor = NaN;
            scaleFactor = NaN;
            scaleX = NaN;
            scaleY = NaN;
            gutterPositionOffset = NaN;
            positionX = NaN;
            positionY = NaN;
            maxPositionX = NaN;
            maxPositionY = NaN;
            lineIndex = 0;
            bounds = null;
            boundsX = NaN;
            position = arg1;
            if (this.textField === null) 
            {
                this._isWaitingToSetFocus = true;
            }
            else 
            {
                starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                if (this.textField.parent === null) 
                {
                    starling.nativeStage.addChild(this.textField);
                }
                if (position === null) 
                {
                    this._pendingSelectionEndIndex = loc2 = -1;
                    this._pendingSelectionBeginIndex = loc2;
                }
                else 
                {
                    nativeScaleFactor = 1;
                    if (starling.supportHighResolutions) 
                    {
                        nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
                    }
                    scaleFactor = starling.contentScaleFactor / nativeScaleFactor;
                    scaleX = this.textField.scaleX;
                    scaleY = this.textField.scaleY;
                    gutterPositionOffset = 2;
                    if (this._useGutter) 
                    {
                        gutterPositionOffset = 0;
                    }
                    positionX = position.x + gutterPositionOffset;
                    positionY = position.y + gutterPositionOffset;
                    if (positionX < gutterPositionOffset) 
                    {
                        positionX = gutterPositionOffset;
                    }
                    else 
                    {
                        maxPositionX = this.textField.width / scaleX - gutterPositionOffset;
                        if (positionX > maxPositionX) 
                        {
                            positionX = maxPositionX;
                        }
                    }
                    if (positionY < gutterPositionOffset) 
                    {
                        positionY = gutterPositionOffset;
                    }
                    else 
                    {
                        maxPositionY = this.textField.height / scaleY - gutterPositionOffset;
                        if (positionY > maxPositionY) 
                        {
                            positionY = maxPositionY;
                        }
                    }
                    this._pendingSelectionBeginIndex = this.getSelectionIndexAtPoint(positionX, positionY);
                    if (this._pendingSelectionBeginIndex < 0) 
                    {
                        if (this._multiline) 
                        {
                            lineIndex = this.textField.getLineIndexAtPoint(this.textField.width / 2 / scaleX, positionY);
                            try 
                            {
                                this._pendingSelectionBeginIndex = this.textField.getLineOffset(lineIndex) + this.textField.getLineLength(lineIndex);
                                if (this._pendingSelectionBeginIndex != this._text.length) 
                                {
                                    var loc3:*=((loc2 = this)._pendingSelectionBeginIndex - 1);
                                    loc2._pendingSelectionBeginIndex = loc3;
                                }
                            }
                            catch (error:Error)
                            {
                                this._pendingSelectionBeginIndex = this._text.length;
                            }
                        }
                        else 
                        {
                            this._pendingSelectionBeginIndex = this.getSelectionIndexAtPoint(positionX, this.textField.getLineMetrics(0).ascent / 2);
                            if (this._pendingSelectionBeginIndex < 0) 
                            {
                                this._pendingSelectionBeginIndex = this._text.length;
                            }
                        }
                    }
                    else 
                    {
                        bounds = this.textField.getCharBoundaries(this._pendingSelectionBeginIndex);
                        if (bounds) 
                        {
                            boundsX = bounds.x;
                            if (bounds && boundsX + bounds.width - positionX < positionX - boundsX) 
                            {
                                loc3 = ((loc2 = this)._pendingSelectionBeginIndex + 1);
                                loc2._pendingSelectionBeginIndex = loc3;
                            }
                        }
                    }
                    this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
                }
                if (!feathers.core.FocusManager.isEnabledForStage(this.stage)) 
                {
                    starling.nativeStage.focus = this.textField;
                }
                this.textField.requestSoftKeyboard();
                if (this._textFieldHasFocus) 
                {
                    this.invalidate(INVALIDATION_FLAG_SELECTED);
                }
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._textFieldHasFocus) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.nativeStage;
            if (loc2.focus === this.textField) 
            {
                loc2.focus = null;
            }
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (this.textField) 
            {
                if (!this._isValidating) 
                {
                    this.validate();
                }
                this.textField.setSelection(arg1, arg2);
            }
            else 
            {
                this._pendingSelectionBeginIndex = arg1;
                this._pendingSelectionEndIndex = arg2;
            }
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

        public function getTextFormatForState(arg1:String):flash.text.TextFormat
        {
            if (this._textFormatForState === null) 
            {
                return null;
            }
            return flash.text.TextFormat(this._textFormatForState[arg1]);
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

        protected override function initialize():void
        {
            this.textField = new flash.text.TextField();
            this.textField.tabEnabled = false;
            this.textField.visible = false;
            this.textField.needsSoftKeyboard = true;
            this.textField.addEventListener(flash.events.Event.CHANGE, this.textField_changeHandler);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.textField_focusInHandler);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.textField_focusOutHandler);
            this.textField.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.textField_mouseFocusChangeHandler);
            this.textField.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.textField_keyDownHandler);
            this.textField.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.textField_softKeyboardActivateHandler);
            this.textField.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.textField_softKeyboardDeactivateHandler);
            this.measureTextField = new flash.text.TextField();
            this.measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.measureTextField.selectable = false;
            this.measureTextField.tabEnabled = false;
            this.measureTextField.mouseWheelEnabled = false;
            this.measureTextField.mouseEnabled = false;
            return;
        }

        protected var textField:flash.text.TextField;

        protected var textSnapshot:starling.display.Image;

        protected var measureTextField:flash.text.TextField;

        protected var _snapshotWidth:int=0;

        protected var _snapshotHeight:int=0;

        protected var _textFieldSnapshotClipRect:flash.geom.Rectangle;

        protected var _textFieldOffsetX:Number=0;

        protected var _textFieldOffsetY:Number=0;

        protected var _lastGlobalScaleX:Number=0;

        protected var _lastGlobalScaleY:Number=0;

        protected var _needsNewTexture:Boolean=false;

        protected var _previousTextFormat:flash.text.TextFormat;

        protected var _currentTextFormat:flash.text.TextFormat;

        protected var _textFormatForState:Object;

        protected var _fontStylesTextFormat:flash.text.TextFormat;

        protected var _textFormat:flash.text.TextFormat;

        protected var _disabledTextFormat:flash.text.TextFormat;

        protected var _embedFonts:Boolean=false;

        protected var _wordWrap:Boolean=false;

        protected var _multiline:Boolean=false;

        protected var _isHTML:Boolean=false;

        protected var _alwaysShowSelection:Boolean=false;

        protected var _displayAsPassword:Boolean=false;

        protected var _maxChars:int=0;

        protected var _restrict:String;

        protected var _isEditable:Boolean=true;

        internal var _antiAliasType:String="advanced";

        internal var _gridFitType:String="pixel";

        internal var _sharpness:Number=0;

        internal var _thickness:Number=0;

        internal var _background:Boolean=false;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _useGutter:Boolean=false;

        protected var _maintainTouchFocus:Boolean=false;

        internal var _borderColor:uint=0;

        internal var _backgroundColor:uint=16777215;

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        internal var _border:Boolean=false;

        protected var _textFieldHasFocus:Boolean=false;

        protected var _useSnapshotDelayWorkaround:Boolean=false;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var resetScrollOnFocusOut:Boolean=true;

        protected var _isSelectable:Boolean=true;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


//  class TextFieldTextEditorViewPort
package feathers.controls.text 
{
    import feathers.controls.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.core.*;
    import starling.utils.*;
    
    public class TextFieldTextEditorViewPort extends feathers.controls.text.TextFieldTextEditor implements feathers.controls.text.ITextEditorViewPort
    {
        public function TextFieldTextEditorViewPort()
        {
            super();
            this.multiline = true;
            this.wordWrap = true;
            this.resetScrollOnFocusOut = false;
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected override function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._visibleWidth === this._visibleWidth);
            this.commitStylesAndData(this.measureTextField);
            var loc2:*=4;
            if (this._useGutter) 
            {
                loc2 = 0;
            }
            var loc3:*=this._visibleWidth;
            this.measureTextField.width = loc3 - this._paddingLeft - this._paddingRight + loc2;
            if (loc1) 
            {
                loc3 = this.measureTextField.width + this._paddingLeft + this._paddingRight - loc2;
                if (loc3 < this._minVisibleWidth) 
                {
                    loc3 = this._minVisibleWidth;
                }
                else if (loc3 > this._maxVisibleWidth) 
                {
                    loc3 = this._maxVisibleWidth;
                }
            }
            var loc4:*=this.measureTextField.height + this._paddingTop + this._paddingBottom - loc2;
            if (this._useGutter) 
            {
                loc4 = loc4 + 4;
            }
            if (this._visibleHeight !== this._visibleHeight) 
            {
                if (loc4 < this._minVisibleHeight) 
                {
                    loc4 = this._minVisibleHeight;
                }
            }
            else if (loc4 < this._visibleHeight) 
            {
                loc4 = this._visibleHeight;
            }
            arg1.x = loc3;
            arg1.y = loc4;
            return arg1;
        }

        protected override function refreshSnapshotParameters():void
        {
            var loc7:*=null;
            var loc1:*=this._visibleWidth - this._paddingLeft - this._paddingRight;
            if (loc1 !== loc1) 
            {
                if (this._maxVisibleWidth < Number.POSITIVE_INFINITY) 
                {
                    loc1 = this._maxVisibleWidth - this._paddingLeft - this._paddingRight;
                }
                else 
                {
                    loc1 = this._minVisibleWidth - this._paddingLeft - this._paddingRight;
                }
            }
            var loc2:*=this._visibleHeight - this._paddingTop - this._paddingBottom;
            if (loc2 !== loc2) 
            {
                if (this._maxVisibleHeight < Number.POSITIVE_INFINITY) 
                {
                    loc2 = this._maxVisibleHeight - this._paddingTop - this._paddingBottom;
                }
                else 
                {
                    loc2 = this._minVisibleHeight - this._paddingTop - this._paddingBottom;
                }
            }
            this._textFieldOffsetX = 0;
            this._textFieldOffsetY = 0;
            this._textFieldSnapshotClipRect.x = 0;
            this._textFieldSnapshotClipRect.y = 0;
            var loc3:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc4:*=loc3.contentScaleFactor;
            var loc5:*=loc1 * loc4;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc7 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc7);
                loc5 = loc5 * feathers.utils.geom.matrixToScaleX(loc7);
            }
            if (loc5 < 0) 
            {
                loc5 = 0;
            }
            var loc6:*=loc2 * loc4;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc6 = loc6 * feathers.utils.geom.matrixToScaleY(loc7);
                starling.utils.Pool.putMatrix(loc7);
            }
            if (loc6 < 0) 
            {
                loc6 = 0;
            }
            this._textFieldSnapshotClipRect.width = loc5;
            this._textFieldSnapshotClipRect.height = loc6;
            return;
        }

        public function get minVisibleWidth():Number
        {
            return this._minVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._minVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("minVisibleWidth cannot be NaN");
            }
            this._minVisibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function refreshTextFieldSize():void
        {
            var loc1:*=this._ignoreScrolling;
            var loc2:*=4;
            if (this._useGutter) 
            {
                loc2 = 0;
            }
            this._ignoreScrolling = true;
            this.textField.width = this._visibleWidth - this._paddingLeft - this._paddingRight + loc2;
            var loc3:*=this._visibleHeight - this._paddingTop - this._paddingBottom + loc2;
            if (this.textField.height != loc3) 
            {
                this.textField.height = loc3;
            }
            var loc4:*=feathers.controls.Scroller(this.parent);
            this.textField.scrollV = Math.round(1 + (this.textField.maxScrollV - 1) * this._verticalScrollPosition / loc4.maxVerticalScrollPosition);
            this._ignoreScrolling = loc1;
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
            this._maxVisibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function transformTextField():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc2 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc3:*=loc1.contentScaleFactor / loc2;
            var loc4:*=starling.utils.Pool.getMatrix();
            var loc5:*=starling.utils.Pool.getPoint();
            this.getTransformationMatrix(this.stage, loc4);
            starling.utils.MatrixUtil.transformCoords(loc4, 0, 0, loc5);
            var loc6:*=feathers.utils.geom.matrixToScaleX(loc4) * loc3;
            var loc7:*=feathers.utils.geom.matrixToScaleY(loc4) * loc3;
            var loc8:*=Math.round(this._paddingLeft * loc6);
            var loc9:*=Math.round((this._paddingTop + this._verticalScrollPosition) * loc7);
            var loc10:*=loc1.viewPort;
            var loc11:*=2;
            if (this._useGutter) 
            {
                loc11 = 0;
            }
            this.textField.x = loc8 + Math.round(loc10.x + loc5.x * loc3 - loc11 * loc6);
            this.textField.y = loc9 + Math.round(loc10.y + loc5.y * loc3 - loc11 * loc7);
            this.textField.rotation = feathers.utils.geom.matrixToRotation(loc4) * 180 / Math.PI;
            this.textField.scaleX = loc6;
            this.textField.scaleY = loc7;
            starling.utils.Pool.putPoint(loc5);
            starling.utils.Pool.putMatrix(loc4);
            return;
        }

        public function get visibleWidth():Number
        {
            return this._visibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._visibleWidth == arg1 || !(arg1 === arg1) && !(this._visibleWidth === this._visibleWidth)) 
            {
                return;
            }
            this._visibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function positionSnapshot():void
        {
            if (!this.textSnapshot) 
            {
                return;
            }
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            this.textSnapshot.x = this._paddingLeft + Math.round(loc1.tx) - loc1.tx;
            this.textSnapshot.y = this._paddingTop + this._verticalScrollPosition + Math.round(loc1.ty) - loc1.ty;
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        public function get minVisibleHeight():Number
        {
            return this._minVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._minVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("minVisibleHeight cannot be NaN");
            }
            this._minVisibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function checkIfNewSnapshotIsNeeded():void
        {
            super.checkIfNewSnapshotIsNeeded();
            this._needsNewTexture = this._needsNewTexture || this.isInvalid(INVALIDATION_FLAG_SCROLL);
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
            this._maxVisibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function textField_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this.textField.addEventListener(flash.events.Event.SCROLL, this.textField_scrollHandler);
            super.textField_focusInHandler(arg1);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get visibleHeight():Number
        {
            return this._visibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._visibleHeight == arg1 || !(arg1 === arg1) && !(this._visibleHeight === this._visibleHeight)) 
            {
                return;
            }
            this._visibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
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

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function get horizontalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get verticalScrollStep():Number
        {
            return this._scrollStep;
        }

        protected override function textField_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this.textField.removeEventListener(flash.events.Event.SCROLL, this.textField_scrollHandler);
            super.textField_focusOutHandler(arg1);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            this._horizontalScrollPosition = arg1;
            return;
        }

        protected function textField_scrollHandler(arg1:flash.events.Event):void
        {
            var loc4:*=NaN;
            var loc1:*=this.textField.scrollH;
            var loc2:*=this.textField.scrollV;
            if (this._ignoreScrolling) 
            {
                return;
            }
            var loc3:*=feathers.controls.Scroller(this.parent);
            if (loc3.maxVerticalScrollPosition > 0 && this.textField.maxScrollV > 1) 
            {
                loc4 = loc3.maxVerticalScrollPosition * (loc2 - 1) / (this.textField.maxScrollV - 1);
                loc3.verticalScrollPosition = feathers.utils.math.roundToNearest(loc4, this._scrollStep);
            }
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return false;
        }

        public override function get baseline():Number
        {
            return super.baseline + this._paddingTop + this._verticalScrollPosition;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
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

        public function get paddingRight():Number
        {
            return this._paddingRight;
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

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
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

        protected override function commitStylesAndData(arg1:flash.text.TextField):void
        {
            super.commitStylesAndData(arg1);
            if (arg1 == this.textField) 
            {
                this._scrollStep = arg1.getLineMetrics(0).height;
            }
            return;
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

        public override function setFocus(arg1:flash.geom.Point=null):void
        {
            if (arg1 !== null) 
            {
                arg1.x = arg1.x - this._paddingLeft;
                arg1.y = arg1.y - this._paddingTop;
            }
            super.setFocus(arg1);
            return;
        }

        internal var _ignoreScrolling:Boolean=false;

        internal var _minVisibleWidth:Number=0;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _visibleWidth:Number=NaN;

        internal var _minVisibleHeight:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _visibleHeight:Number=NaN;

        internal var _horizontalScrollPosition:Number=0;

        internal var _verticalScrollPosition:Number=0;

        protected var _paddingTop:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _scrollStep:int=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


//  class TextFieldTextRenderer
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


