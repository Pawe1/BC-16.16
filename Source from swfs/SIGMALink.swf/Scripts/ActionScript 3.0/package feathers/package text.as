//package text
//  class BitmapFontTextFormat
package feathers.text 
{
    import starling.text.*;
    
    public class BitmapFontTextFormat extends Object
    {
        public function BitmapFontTextFormat(arg1:Object, arg2:Number=NaN, arg3:uint=16777215, arg4:String="left", arg5:Number=0)
        {
            super();
            if (arg1 is String) 
            {
                arg1 = starling.text.TextField.getBitmapFont(arg1 as String);
            }
            if (!(arg1 is starling.text.BitmapFont)) 
            {
                throw new ArgumentError("BitmapFontTextFormat font must be a BitmapFont instance or a String representing the name of a registered bitmap font.");
            }
            this.font = starling.text.BitmapFont(arg1);
            this.size = arg2;
            this.color = arg3;
            this.align = arg4;
            this.leading = arg5;
            return;
        }

        public function get fontName():String
        {
            return this.font ? this.font.name : null;
        }

        public var font:starling.text.BitmapFont;

        public var color:uint;

        public var size:Number;

        public var letterSpacing:Number=0;

        public var align:String="left";

        public var leading:Number;

        public var isKerningEnabled:Boolean=true;
    }
}


//  class FontStylesSet
package feathers.text 
{
    import feathers.core.*;
    import starling.events.*;
    import starling.text.*;
    
    public class FontStylesSet extends starling.events.EventDispatcher
    {
        public function FontStylesSet()
        {
            super();
            return;
        }

        public function get format():starling.text.TextFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.text.TextFormat):void
        {
            if (this._format === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._format === null)) 
            {
                this._format.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._format = null;
            }
            else if (arg1 !== null) 
            {
                if (this._format !== null) 
                {
                    this._format.copyFrom(arg1);
                }
                else 
                {
                    this._format = arg1.clone();
                    this._format.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get disabledFormat():starling.text.TextFormat
        {
            return this._disabledFormat;
        }

        public function set disabledFormat(arg1:starling.text.TextFormat):void
        {
            if (this._disabledFormat === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._disabledFormat === null)) 
            {
                this._disabledFormat.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._disabledFormat = null;
            }
            else if (arg1 !== null) 
            {
                if (this._disabledFormat !== null) 
                {
                    this._disabledFormat.copyFrom(arg1);
                }
                else 
                {
                    this._disabledFormat = arg1.clone();
                    this._disabledFormat.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get selectedFormat():starling.text.TextFormat
        {
            return this._selectedFormat;
        }

        public function set selectedFormat(arg1:starling.text.TextFormat):void
        {
            if (this._selectedFormat === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._selectedFormat === null)) 
            {
                this._selectedFormat.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._selectedFormat = null;
            }
            else if (arg1 !== null) 
            {
                if (this._selectedFormat !== null) 
                {
                    this._selectedFormat.copyFrom(arg1);
                }
                else 
                {
                    this._selectedFormat = arg1.clone();
                    this._selectedFormat.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function getFormatForState(arg1:String):starling.text.TextFormat
        {
            if (this._stateToFormat === null) 
            {
                return null;
            }
            return starling.text.TextFormat(this._stateToFormat[arg1]);
        }

        public function setFormatForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            var loc1:*=null;
            if (arg2 === null) 
            {
                if (this._stateToFormat !== null) 
                {
                    loc1 = starling.text.TextFormat(this._stateToFormat[arg1]);
                    if (loc1 !== null) 
                    {
                        loc1.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                        delete this._stateToFormat[arg1];
                    }
                }
            }
            else 
            {
                if (this._stateToFormat !== null) 
                {
                    loc1 = starling.text.TextFormat(this._stateToFormat[arg1]);
                }
                else 
                {
                    this._stateToFormat = {};
                }
                if (loc1 !== null) 
                {
                    loc1.copyFrom(arg2);
                }
                else 
                {
                    loc1 = arg2.clone();
                    loc1.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                    this._stateToFormat[arg1] = loc1;
                }
            }
            return;
        }

        public function getTextFormatForTarget(arg1:feathers.core.IFeathersControl):starling.text.TextFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is feathers.core.IStateObserver) 
            {
                loc2 = feathers.core.IStateObserver(arg1).stateContext;
            }
            if (loc2 === null) 
            {
                if (!(this._disabledFormat === null) && !arg1.isEnabled) 
                {
                    loc1 = this._disabledFormat;
                }
            }
            else 
            {
                if (this._stateToFormat !== null) 
                {
                    loc3 = loc2.currentState;
                    if (loc3 in this._stateToFormat) 
                    {
                        loc1 = starling.text.TextFormat(this._stateToFormat[loc3]);
                    }
                }
                if (loc1 === null && !(this._disabledFormat === null) && loc2 is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(loc2).isEnabled) 
                {
                    loc1 = this._disabledFormat;
                }
                if (loc1 === null && !(this._selectedFormat === null) && loc2 is feathers.core.IToggle && feathers.core.IToggle(loc2).isSelected) 
                {
                    loc1 = this._selectedFormat;
                }
            }
            if (loc1 === null) 
            {
                loc1 = this._format;
            }
            return loc1;
        }

        protected function format_changeHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _stateToFormat:Object;

        protected var _format:starling.text.TextFormat;

        protected var _disabledFormat:starling.text.TextFormat;

        protected var _selectedFormat:starling.text.TextFormat;
    }
}


//  class StageTextField
package feathers.text 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.text.engine.*;
    
    public final class StageTextField extends flash.events.EventDispatcher
    {
        public function StageTextField(arg1:Object=null)
        {
            this._viewPort = new flash.geom.Rectangle();
            super();
            this.initialize(arg1);
            return;
        }

        public function assignFocus():void
        {
            if (!this._textField.parent) 
            {
                return;
            }
            this._textField.stage.focus = this._textField;
            return;
        }

        public function dispose():void
        {
            this.stage = null;
            this._textField = null;
            this._textFormat = null;
            return;
        }

        public function drawViewPortToBitmapData(arg1:flash.display.BitmapData):void
        {
            if (!arg1) 
            {
                throw new Error("The bitmap is null.");
            }
            if (!(arg1.width == this._viewPort.width) || !(arg1.height == this._viewPort.height)) 
            {
                throw new ArgumentError("The bitmap\'s width or height is different from view port\'s width or height.");
            }
            arg1.draw(this._textField);
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            this._textField.setSelection(arg1, arg2);
            return;
        }

        public function get autoCapitalize():String
        {
            return this._autoCapitalize;
        }

        public function set autoCapitalize(arg1:String):void
        {
            this._autoCapitalize = arg1;
            return;
        }

        public function set displayAsPassword(arg1:Boolean):void
        {
            this._textField.displayAsPassword = arg1;
            return;
        }

        public function get autoCorrect():Boolean
        {
            return this._autoCorrect;
        }

        public function set autoCorrect(arg1:Boolean):void
        {
            this._autoCorrect = arg1;
            return;
        }

        internal function dispatchCompleteIfPossible():void
        {
            if (!this._textField.stage || this._viewPort.isEmpty()) 
            {
                this._isComplete = false;
            }
            if (this._textField.stage && !this._viewPort.isEmpty()) 
            {
                this._isComplete = true;
                this.dispatchEvent(new flash.events.Event(flash.events.Event.COMPLETE));
            }
            return;
        }

        public function get color():uint
        {
            return this._textFormat.color as uint;
        }

        public function set color(arg1:uint):void
        {
            if (this._textFormat.color == arg1) 
            {
                return;
            }
            this._textFormat.color = arg1;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        public function get displayAsPassword():Boolean
        {
            return this._textField.displayAsPassword;
        }

        internal function initialize(arg1:Object):void
        {
            this._textField = new flash.text.TextField();
            this._textField.type = flash.text.TextFieldType.INPUT;
            var loc1:*=arg1 && arg1.hasOwnProperty("multiline") && arg1.multiline;
            this._textField.multiline = loc1;
            this._textField.wordWrap = loc1;
            this._textField.addEventListener(flash.events.Event.CHANGE, this.textField_eventHandler);
            this._textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.textField_eventHandler);
            this._textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.textField_eventHandler);
            this._textField.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.textField_eventHandler);
            this._textField.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.textField_eventHandler);
            this._textField.addEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, this.textField_keyFocusChangeHandler);
            this._textFormat = new flash.text.TextFormat(null, 11, 0, false, false, false);
            this._textField.defaultTextFormat = this._textFormat;
            return;
        }

        public function get editable():Boolean
        {
            return this._textField.type == flash.text.TextFieldType.INPUT;
        }

        public function set editable(arg1:Boolean):void
        {
            this._textField.type = arg1 ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            return;
        }

        internal function textField_eventHandler(arg1:flash.events.Event):void
        {
            this.dispatchEvent(arg1);
            return;
        }

        public function get fontFamily():String
        {
            return this._textFormat.font;
        }

        public function set fontFamily(arg1:String):void
        {
            if (this._textFormat.font == arg1) 
            {
                return;
            }
            this._textFormat.font = arg1;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        public function get fontPosture():String
        {
            return this._textFormat.italic ? flash.text.engine.FontPosture.ITALIC : flash.text.engine.FontPosture.NORMAL;
        }

        public function set fontPosture(arg1:String):void
        {
            if (this.fontPosture == arg1) 
            {
                return;
            }
            this._textFormat.italic = arg1 == flash.text.engine.FontPosture.ITALIC;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        public function get fontSize():int
        {
            return this._textFormat.size as int;
        }

        public function set fontSize(arg1:int):void
        {
            if (this._textFormat.size == arg1) 
            {
                return;
            }
            this._textFormat.size = arg1;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        public function get fontWeight():String
        {
            return this._textFormat.bold ? flash.text.engine.FontWeight.BOLD : flash.text.engine.FontWeight.NORMAL;
        }

        public function set fontWeight(arg1:String):void
        {
            if (this.fontWeight == arg1) 
            {
                return;
            }
            this._textFormat.bold = arg1 == flash.text.engine.FontWeight.BOLD;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        internal function textField_keyFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            arg1.preventDefault();
            arg1.stopImmediatePropagation();
            arg1.stopPropagation();
            return;
        }

        public function get locale():String
        {
            return this._locale;
        }

        public function set locale(arg1:String):void
        {
            this._locale = arg1;
            return;
        }

        public function get maxChars():int
        {
            return this._textField.maxChars;
        }

        public function set maxChars(arg1:int):void
        {
            this._textField.maxChars = arg1;
            return;
        }

        public function get multiline():Boolean
        {
            return this._textField.multiline;
        }

        public function get restrict():String
        {
            return this._textField.restrict;
        }

        public function set restrict(arg1:String):void
        {
            this._textField.restrict = arg1;
            return;
        }

        public function get returnKeyLabel():String
        {
            return this._returnKeyLabel;
        }

        public function set returnKeyLabel(arg1:String):void
        {
            this._returnKeyLabel = arg1;
            return;
        }

        public function get selectionActiveIndex():int
        {
            return this._textField.selectionBeginIndex;
        }

        public function get selectionAnchorIndex():int
        {
            return this._textField.selectionEndIndex;
        }

        public function get softKeyboardType():String
        {
            return this._softKeyboardType;
        }

        public function set softKeyboardType(arg1:String):void
        {
            this._softKeyboardType = arg1;
            return;
        }

        public function get stage():flash.display.Stage
        {
            return this._textField.stage;
        }

        public function set stage(arg1:flash.display.Stage):void
        {
            if (this._textField.stage == arg1) 
            {
                return;
            }
            if (this._textField.stage) 
            {
                this._textField.parent.removeChild(this._textField);
            }
            if (arg1) 
            {
                arg1.addChild(this._textField);
                this.dispatchCompleteIfPossible();
            }
            return;
        }

        public function get text():String
        {
            return this._textField.text;
        }

        public function set text(arg1:String):void
        {
            this._textField.text = arg1;
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
            if (arg1 != flash.text.TextFormatAlign.START) 
            {
                if (arg1 == flash.text.TextFormatAlign.END) 
                {
                    arg1 = flash.text.TextFormatAlign.RIGHT;
                }
            }
            else 
            {
                arg1 = flash.text.TextFormatAlign.LEFT;
            }
            this._textFormat.align = arg1;
            this._textField.defaultTextFormat = this._textFormat;
            this._textField.setTextFormat(this._textFormat);
            return;
        }

        public function get viewPort():flash.geom.Rectangle
        {
            return this._viewPort;
        }

        public function set viewPort(arg1:flash.geom.Rectangle):void
        {
            if (!arg1 || arg1.width < 0 || arg1.height < 0) 
            {
                throw new RangeError("The Rectangle value is not valid.");
            }
            this._viewPort = arg1;
            this._textField.x = this._viewPort.x;
            this._textField.y = this._viewPort.y;
            this._textField.width = this._viewPort.width;
            this._textField.height = this._viewPort.height;
            this.dispatchCompleteIfPossible();
            return;
        }

        public function get visible():Boolean
        {
            return this._textField.visible;
        }

        public function set visible(arg1:Boolean):void
        {
            this._textField.visible = arg1;
            return;
        }

        internal var _textField:flash.text.TextField;

        internal var _textFormat:flash.text.TextFormat;

        internal var _isComplete:Boolean=false;

        internal var _autoCapitalize:String="none";

        internal var _color:uint=0;

        internal var _autoCorrect:Boolean=false;

        internal var _fontFamily:String=null;

        internal var _locale:String="en";

        internal var _textAlign:String="start";

        internal var _returnKeyLabel:String="default";

        internal var _softKeyboardType:String="default";

        internal var _viewPort:flash.geom.Rectangle;
    }
}


