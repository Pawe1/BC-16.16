//class StageTextField
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


