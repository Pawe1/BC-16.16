//class AnchorLayoutData
package feathers.layout 
{
    import starling.display.*;
    import starling.events.*;
    
    public class AnchorLayoutData extends starling.events.EventDispatcher implements feathers.layout.ILayoutData
    {
        public function AnchorLayoutData(arg1:Number=NaN, arg2:Number=NaN, arg3:Number=NaN, arg4:Number=NaN, arg5:Number=NaN, arg6:Number=NaN)
        {
            super();
            this.top = arg1;
            this.right = arg2;
            this.bottom = arg3;
            this.left = arg4;
            this.horizontalCenter = arg5;
            this.verticalCenter = arg6;
            return;
        }

        public function get horizontalCenter():Number
        {
            return this._horizontalCenter;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            if (this._percentWidth == arg1) 
            {
                return;
            }
            this._percentWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            if (this._horizontalCenter == arg1) 
            {
                return;
            }
            this._horizontalCenter = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            if (this._percentHeight == arg1) 
            {
                return;
            }
            this._percentHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set verticalCenter(arg1:Number):void
        {
            if (this._verticalCenter == arg1) 
            {
                return;
            }
            this._verticalCenter = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get topAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._topAnchorDisplayObject;
        }

        public function set topAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._topAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._topAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalCenterAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._verticalCenterAnchorDisplayObject;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            if (this._top == arg1) 
            {
                return;
            }
            this._top = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set verticalCenterAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._verticalCenterAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._verticalCenterAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get rightAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._rightAnchorDisplayObject;
        }

        public function set rightAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._rightAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._rightAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set bottomAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._bottomAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._bottomAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right == arg1) 
            {
                return;
            }
            this._right = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalCenter():Number
        {
            return this._verticalCenter;
        }

        public function get bottomAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._bottomAnchorDisplayObject;
        }

        public function get leftAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._leftAnchorDisplayObject;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom == arg1) 
            {
                return;
            }
            this._bottom = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set leftAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._leftAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._leftAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left == arg1) 
            {
                return;
            }
            this._left = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get horizontalCenterAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._horizontalCenterAnchorDisplayObject;
        }

        public function set horizontalCenterAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._horizontalCenterAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._horizontalCenterAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _percentWidth:Number=NaN;

        protected var _percentHeight:Number=NaN;

        protected var _topAnchorDisplayObject:starling.display.DisplayObject;

        protected var _top:Number=NaN;

        protected var _rightAnchorDisplayObject:starling.display.DisplayObject;

        protected var _bottomAnchorDisplayObject:starling.display.DisplayObject;

        protected var _leftAnchorDisplayObject:starling.display.DisplayObject;

        protected var _right:Number=NaN;

        protected var _horizontalCenterAnchorDisplayObject:starling.display.DisplayObject;

        protected var _bottom:Number=NaN;

        protected var _left:Number=NaN;

        protected var _verticalCenter:Number=NaN;

        protected var _horizontalCenter:Number=NaN;

        protected var _verticalCenterAnchorDisplayObject:starling.display.DisplayObject;
    }
}


