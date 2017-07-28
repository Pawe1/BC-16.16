//class Padding
package starling.utils 
{
    import starling.events.*;
    
    public class Padding extends starling.events.EventDispatcher
    {
        public function Padding(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0)
        {
            super();
            this.setTo(arg1, arg2, arg3, arg4);
            return;
        }

        public function setTo(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0):void
        {
            var loc1:*=!(this._left == arg1) || !(this._right == arg2) || !(this._top == arg3) || !(this._bottom == arg4);
            this._left = arg1;
            this._right = arg2;
            this._top = arg3;
            this._bottom = arg4;
            if (loc1) 
            {
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function copyFrom(arg1:starling.utils.Padding):void
        {
            if (arg1 != null) 
            {
                this.setTo(arg1._left, arg1._right, arg1._top, arg1._bottom);
            }
            else 
            {
                this.setTo(0, 0, 0, 0);
            }
            return;
        }

        public function clone():starling.utils.Padding
        {
            return new starling.utils.Padding(this._left, this._right, this._top, this._bottom);
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left != arg1) 
            {
                this._left = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right != arg1) 
            {
                this._right = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            if (this._top != arg1) 
            {
                this._top = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom != arg1) 
            {
                this._bottom = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        internal var _left:Number;

        internal var _right:Number;

        internal var _top:Number;

        internal var _bottom:Number;
    }
}


