//class TextFormat
package starling.text 
{
    import flash.text.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TextFormat extends starling.events.EventDispatcher
    {
        public function TextFormat(arg1:String="Verdana", arg2:Number=12, arg3:uint=0, arg4:String="center", arg5:String="center")
        {
            super();
            this._font = arg1;
            this._size = arg2;
            this._color = arg3;
            this._horizontalAlign = arg4;
            this._verticalAlign = arg5;
            this._kerning = true;
            this._leading = 0;
            return;
        }

        public function get underline():Boolean
        {
            return this._underline;
        }

        public function set underline(arg1:Boolean):void
        {
            if (arg1 != this._underline) 
            {
                this._underline = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (!starling.utils.Align.isValidHorizontal(arg1)) 
            {
                throw new ArgumentError("Invalid horizontal alignment");
            }
            if (arg1 != this._horizontalAlign) 
            {
                this._horizontalAlign = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (!starling.utils.Align.isValidVertical(arg1)) 
            {
                throw new ArgumentError("Invalid vertical alignment");
            }
            if (arg1 != this._verticalAlign) 
            {
                this._verticalAlign = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get kerning():Boolean
        {
            return this._kerning;
        }

        public function set kerning(arg1:Boolean):void
        {
            if (arg1 != this._kerning) 
            {
                this._kerning = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get leading():Number
        {
            return this._leading;
        }

        public function set leading(arg1:Number):void
        {
            if (arg1 != this._leading) 
            {
                this._leading = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function copyFrom(arg1:starling.text.TextFormat):void
        {
            this._font = arg1._font;
            this._size = arg1._size;
            this._color = arg1._color;
            this._bold = arg1._bold;
            this._italic = arg1._italic;
            this._underline = arg1._underline;
            this._horizontalAlign = arg1._horizontalAlign;
            this._verticalAlign = arg1._verticalAlign;
            this._kerning = arg1._kerning;
            this._leading = arg1._leading;
            dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function clone():starling.text.TextFormat
        {
            var loc1:*=new starling.text.TextFormat();
            loc1.copyFrom(this);
            return loc1;
        }

        public function setTo(arg1:String="Verdana", arg2:Number=12, arg3:uint=0, arg4:String="center", arg5:String="center"):void
        {
            this._font = arg1;
            this._size = arg2;
            this._color = arg3;
            this._horizontalAlign = arg4;
            this._verticalAlign = arg5;
            dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function toNativeFormat(arg1:flash.text.TextFormat=null):flash.text.TextFormat
        {
            if (arg1 == null) 
            {
                arg1 = new flash.text.TextFormat();
            }
            arg1.font = this._font;
            arg1.size = this._size;
            arg1.color = this._color;
            arg1.bold = this._bold;
            arg1.italic = this._italic;
            arg1.underline = this._underline;
            arg1.align = this._horizontalAlign;
            arg1.kerning = this._kerning;
            arg1.leading = this._leading;
            return arg1;
        }

        public function get font():String
        {
            return this._font;
        }

        public function set font(arg1:String):void
        {
            if (arg1 != this._font) 
            {
                this._font = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get size():Number
        {
            return this._size;
        }

        public function set size(arg1:Number):void
        {
            if (arg1 != this._size) 
            {
                this._size = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            if (arg1 != this._color) 
            {
                this._color = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get bold():Boolean
        {
            return this._bold;
        }

        public function set bold(arg1:Boolean):void
        {
            if (arg1 != this._bold) 
            {
                this._bold = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get italic():Boolean
        {
            return this._italic;
        }

        public function set italic(arg1:Boolean):void
        {
            if (arg1 != this._italic) 
            {
                this._italic = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        internal var _font:String;

        internal var _size:Number;

        internal var _color:uint;

        internal var _bold:Boolean;

        internal var _italic:Boolean;

        internal var _underline:Boolean;

        internal var _horizontalAlign:String;

        internal var _verticalAlign:String;

        internal var _kerning:Boolean;

        internal var _leading:Number;
    }
}


