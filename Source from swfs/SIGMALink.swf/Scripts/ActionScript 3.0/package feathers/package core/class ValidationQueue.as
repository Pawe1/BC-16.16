//class ValidationQueue
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.core.*;
    
    public final class ValidationQueue extends Object implements starling.animation.IAnimatable
    {
        public function ValidationQueue(arg1:starling.core.Starling)
        {
            this._queue = new Vector.<feathers.core.IValidating>(0);
            super();
            this._starling = arg1;
            return;
        }

        public function get isValidating():Boolean
        {
            return this._isValidating;
        }

        public function dispose():void
        {
            if (this._starling) 
            {
                this._starling.juggler.remove(this);
                this._starling = null;
            }
            return;
        }

        public function addControl(arg1:feathers.core.IValidating):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            if (!this._starling.juggler.contains(this)) 
            {
                this._starling.juggler.add(this);
            }
            if (this._queue.indexOf(arg1) >= 0) 
            {
                return;
            }
            var loc1:*=this._queue.length;
            if (this._isValidating) 
            {
                loc2 = arg1.depth;
                --loc3;
                while (loc3 >= 0) 
                {
                    loc4 = feathers.core.IValidating(this._queue[loc3]);
                    loc5 = loc4.depth;
                    if (loc2 >= loc5) 
                    {
                        break;
                    }
                    --loc3;
                }
                ++loc3;
                this._queue.insertAt(loc3, arg1);
            }
            else 
            {
                this._queue[loc1] = arg1;
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc2:*=null;
            if (this._isValidating || !this._starling.contextValid) 
            {
                return;
            }
            var loc1:*=this._queue.length;
            if (loc1 === 0) 
            {
                return;
            }
            this._isValidating = true;
            if (loc1 > 1) 
            {
                this._queue = this._queue.sort(this.queueSortFunction);
            }
            while (this._queue.length > 0) 
            {
                loc2 = this._queue.shift();
                if (loc2.depth < 0) 
                {
                    continue;
                }
                loc2.validate();
            }
            this._isValidating = false;
            return;
        }

        protected function queueSortFunction(arg1:feathers.core.IValidating, arg2:feathers.core.IValidating):int
        {
            var loc1:*=arg2.depth - arg1.depth;
            if (loc1 > 0) 
            {
                return -1;
            }
            if (loc1 < 0) 
            {
                return 1;
            }
            return 0;
        }

        public static function forStarling(arg1:starling.core.Starling):feathers.core.ValidationQueue
        {
            if (!arg1) 
            {
                return null;
            }
            var loc1:*=STARLING_TO_VALIDATION_QUEUE[arg1];
            if (!loc1) 
            {
                var loc2:*;
                loc1 = loc2 = new ValidationQueue(arg1);
                STARLING_TO_VALIDATION_QUEUE[arg1] = loc2;
            }
            return loc1;
        }

        internal static const STARLING_TO_VALIDATION_QUEUE:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        internal var _starling:starling.core.Starling;

        internal var _isValidating:Boolean=false;

        internal var _queue:__AS3__.vec.Vector.<feathers.core.IValidating>;
    }
}


