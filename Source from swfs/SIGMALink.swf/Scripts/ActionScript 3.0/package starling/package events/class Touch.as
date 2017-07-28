//class Touch
package starling.events 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.utils.*;
    
    public class Touch extends Object
    {
        public function Touch(arg1:int)
        {
            super();
            this._id = arg1;
            this._tapCount = 0;
            this._phase = starling.events.TouchPhase.HOVER;
            var loc1:*;
            this._height = loc1 = 1;
            this._width = loc1 = loc1;
            this._pressure = loc1;
            this._bubbleChain = new Vector.<starling.events.EventDispatcher>(0);
            return;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target != arg1) 
            {
                this._target = arg1;
                this.updateBubbleChain();
            }
            return;
        }

        public function get timestamp():Number
        {
            return this._timestamp;
        }

        public function set timestamp(arg1:Number):void
        {
            this._timestamp = arg1;
            return;
        }

        public function get pressure():Number
        {
            return this._pressure;
        }

        public function set pressure(arg1:Number):void
        {
            this._pressure = arg1;
            return;
        }

        public function get previousGlobalY():Number
        {
            return this._previousGlobalY;
        }

        public function get width():Number
        {
            return this._width;
        }

        public function set width(arg1:Number):void
        {
            this._width = arg1;
            return;
        }

        public function get height():Number
        {
            return this._height;
        }

        public function get cancelled():Boolean
        {
            return this._cancelled;
        }

        public function set cancelled(arg1:Boolean):void
        {
            this._cancelled = arg1;
            return;
        }

        function dispatchEvent(arg1:starling.events.TouchEvent):void
        {
            if (this._target) 
            {
                arg1.dispatch(this._bubbleChain);
            }
            return;
        }

        function get bubbleChain():__AS3__.vec.Vector.<starling.events.EventDispatcher>
        {
            return this._bubbleChain.concat();
        }

        
        {
            sHelperPoint = new flash.geom.Point();
        }

        public function getLocation(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            sHelperPoint.setTo(this._globalX, this._globalY);
            return arg1.globalToLocal(sHelperPoint, arg2);
        }

        public function getPreviousLocation(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            sHelperPoint.setTo(this._previousGlobalX, this._previousGlobalY);
            return arg1.globalToLocal(sHelperPoint, arg2);
        }

        public function getMovement(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Point();
            }
            this.getLocation(arg1, arg2);
            var loc1:*=arg2.x;
            var loc2:*=arg2.y;
            this.getPreviousLocation(arg1, arg2);
            arg2.setTo(loc1 - arg2.x, loc2 - arg2.y);
            return arg2;
        }

        public function isTouching(arg1:starling.display.DisplayObject):Boolean
        {
            return !(this._bubbleChain.indexOf(arg1) == -1);
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[Touch {0}: globalX={1}, globalY={2}, phase={3}]", this._id, this._globalX, this._globalY, this._phase);
        }

        public function clone():starling.events.Touch
        {
            var loc1:*=new starling.events.Touch(this._id);
            loc1._globalX = this._globalX;
            loc1._globalY = this._globalY;
            loc1._previousGlobalX = this._previousGlobalX;
            loc1._previousGlobalY = this._previousGlobalY;
            loc1._phase = this._phase;
            loc1._tapCount = this._tapCount;
            loc1._timestamp = this._timestamp;
            loc1._pressure = this._pressure;
            loc1._width = this._width;
            loc1._height = this._height;
            loc1._cancelled = this._cancelled;
            loc1.target = this._target;
            return loc1;
        }

        internal function updateBubbleChain():void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._target) 
            {
                loc1 = 1;
                loc2 = this._target;
                this._bubbleChain.length = 1;
                this._bubbleChain[0] = loc2;
                for (;;) 
                {
                    var loc3:*;
                    loc2 = loc3 = loc2.parent;
                    if (loc3 == null) 
                    {
                        break;
                    }
                    this._bubbleChain[int(loc1++)] = loc2;
                }
            }
            else 
            {
                this._bubbleChain.length = 0;
            }
            return;
        }

        public function get id():int
        {
            return this._id;
        }

        public function get previousGlobalX():Number
        {
            return this._previousGlobalX;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
            return;
        }

        public function get globalX():Number
        {
            return this._globalX;
        }

        public function set globalX(arg1:Number):void
        {
            this._previousGlobalX = this._globalX == this._globalX ? this._globalX : arg1;
            this._globalX = arg1;
            return;
        }

        public function get globalY():Number
        {
            return this._globalY;
        }

        public function set globalY(arg1:Number):void
        {
            this._previousGlobalY = this._globalY == this._globalY ? this._globalY : arg1;
            this._globalY = arg1;
            return;
        }

        public function get tapCount():int
        {
            return this._tapCount;
        }

        public function set tapCount(arg1:int):void
        {
            this._tapCount = arg1;
            return;
        }

        public function get phase():String
        {
            return this._phase;
        }

        public function set phase(arg1:String):void
        {
            this._phase = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        internal var _id:int;

        internal var _globalX:Number;

        internal var _globalY:Number;

        internal var _previousGlobalX:Number;

        internal var _previousGlobalY:Number;

        internal var _phase:String;

        internal var _target:starling.display.DisplayObject;

        internal var _timestamp:Number;

        internal var _pressure:Number;

        internal var _width:Number;

        internal var _height:Number;

        internal var _cancelled:Boolean;

        internal var _bubbleChain:__AS3__.vec.Vector.<starling.events.EventDispatcher>;

        internal static var sHelperPoint:flash.geom.Point;

        internal var _tapCount:int;
    }
}


