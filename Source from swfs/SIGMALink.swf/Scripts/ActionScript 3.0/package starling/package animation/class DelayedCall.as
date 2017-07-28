//class DelayedCall
package starling.animation 
{
    import __AS3__.vec.*;
    import starling.core.*;
    import starling.events.*;
    
    use namespace starling_internal;
    
    public class DelayedCall extends starling.events.EventDispatcher implements starling.animation.IAnimatable
    {
        public function DelayedCall(arg1:Function, arg2:Number, arg3:Array=null)
        {
            super();
            this.reset(arg1, arg2, arg3);
            return;
        }

        public function reset(arg1:Function, arg2:Number, arg3:Array=null):starling.animation.DelayedCall
        {
            this._currentTime = 0;
            this._totalTime = Math.max(arg2, 0.0001);
            this._callback = arg1;
            this._args = arg3;
            this._repeatCount = 1;
            return this;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._currentTime;
            this._currentTime = this._currentTime + arg1;
            if (this._currentTime > this._totalTime) 
            {
                this._currentTime = this._totalTime;
            }
            if (loc1 < this._totalTime && this._currentTime >= this._totalTime) 
            {
                if (this._repeatCount == 0 || this._repeatCount > 1) 
                {
                    this._callback.apply(null, this._args);
                    if (this._repeatCount > 0) 
                    {
                        --this._repeatCount;
                    }
                    this._currentTime = 0;
                    this.advanceTime(loc1 + arg1 - this._totalTime);
                }
                else 
                {
                    loc2 = this._callback;
                    loc3 = this._args;
                    dispatchEventWith(starling.events.Event.REMOVE_FROM_JUGGLER);
                    loc2.apply(null, loc3);
                }
            }
            return;
        }

        public function complete():void
        {
            var loc1:*=this._totalTime - this._currentTime;
            if (loc1 > 0) 
            {
                this.advanceTime(loc1);
            }
            return;
        }

        public function get isComplete():Boolean
        {
            return this._repeatCount == 1 && this._currentTime >= this._totalTime;
        }

        public function get totalTime():Number
        {
            return this._totalTime;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function get repeatCount():int
        {
            return this._repeatCount;
        }

        public function set repeatCount(arg1:int):void
        {
            this._repeatCount = arg1;
            return;
        }

        public function get callback():Function
        {
            return this._callback;
        }

        public function get arguments():Array
        {
            return this._args;
        }

        starling_internal static function fromPool(arg1:Function, arg2:Number, arg3:Array=null):starling.animation.DelayedCall
        {
            if (sPool.length) 
            {
                return sPool.pop().reset(arg1, arg2, arg3);
            }
            return new DelayedCall(arg1, arg2, arg3);
        }

        starling_internal static function toPool(arg1:starling.animation.DelayedCall):void
        {
            arg1._callback = null;
            arg1._args = null;
            arg1.removeEventListeners();
            sPool.push(arg1);
            return;
        }

        
        {
            sPool = new Vector.<>(0);
        }

        internal var _currentTime:Number;

        internal var _totalTime:Number;

        internal var _callback:Function;

        internal var _args:Array;

        internal var _repeatCount:int;

        internal static var sPool:__AS3__.vec.Vector.<starling.animation.DelayedCall>;
    }
}


