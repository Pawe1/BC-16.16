//class Juggler
package starling.animation 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.events.*;
    
    public class Juggler extends Object implements starling.animation.IAnimatable
    {
        public function Juggler()
        {
            super();
            this._elapsedTime = 0;
            this._timeScale = 1;
            this._objects = new Vector.<starling.animation.IAnimatable>(0);
            this._objectIDs = new flash.utils.Dictionary(true);
            return;
        }

        public function add(arg1:starling.animation.IAnimatable):uint
        {
            return this.addWithID(arg1, getNextID());
        }

        internal function addWithID(arg1:starling.animation.IAnimatable, arg2:uint):uint
        {
            var loc1:*=null;
            if (arg1 && !(arg1 in this._objectIDs)) 
            {
                loc1 = arg1 as starling.events.EventDispatcher;
                if (loc1) 
                {
                    loc1.addEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onRemove);
                }
                this._objects[this._objects.length] = arg1;
                this._objectIDs[arg1] = arg2;
                return arg2;
            }
            return 0;
        }

        public function contains(arg1:starling.animation.IAnimatable):Boolean
        {
            return arg1 in this._objectIDs;
        }

        public function remove(arg1:starling.animation.IAnimatable):uint
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc1:*=0;
            if (arg1 && arg1 in this._objectIDs) 
            {
                loc2 = arg1 as starling.events.EventDispatcher;
                if (loc2) 
                {
                    loc2.removeEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onRemove);
                }
                loc3 = this._objects.indexOf(arg1);
                this._objects[loc3] = null;
                loc1 = this._objectIDs[arg1];
                delete this._objectIDs[arg1];
            }
            return loc1;
        }

        public function removeByID(arg1:uint):uint
        {
            var loc2:*=null;
            var loc1:*=(this._objects.length - 1);
            while (loc1 >= 0) 
            {
                loc2 = this._objects[loc1];
                if (this._objectIDs[loc2] == arg1) 
                {
                    this.remove(loc2);
                    return arg1;
                }
                --loc1;
            }
            return 0;
        }

        public function removeTweens(arg1:Object):void
        {
            var loc2:*=null;
            if (arg1 == null) 
            {
                return;
            }
            var loc1:*=(this._objects.length - 1);
            while (loc1 >= 0) 
            {
                loc2 = this._objects[loc1] as starling.animation.Tween;
                if (loc2 && loc2.target == arg1) 
                {
                    loc2.removeEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onRemove);
                    this._objects[loc1] = null;
                    delete this._objectIDs[loc2];
                }
                --loc1;
            }
            return;
        }

        public function removeDelayedCalls(arg1:Function):void
        {
            var loc2:*=null;
            if (arg1 == null) 
            {
                return;
            }
            var loc1:*=(this._objects.length - 1);
            while (loc1 >= 0) 
            {
                loc2 = this._objects[loc1] as starling.animation.DelayedCall;
                if (loc2 && loc2.callback == arg1) 
                {
                    loc2.removeEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onRemove);
                    this._objects[loc1] = null;
                    delete this._objectIDs[this.tween];
                }
                --loc1;
            }
            return;
        }

        public function containsTweens(arg1:Object):Boolean
        {
            var loc1:*=0;
            var loc2:*=null;
            if (arg1) 
            {
                loc1 = (this._objects.length - 1);
                while (loc1 >= 0) 
                {
                    loc2 = this._objects[loc1] as starling.animation.Tween;
                    if (loc2 && loc2.target == arg1) 
                    {
                        return true;
                    }
                    --loc1;
                }
            }
            return false;
        }

        public function containsDelayedCalls(arg1:Function):Boolean
        {
            var loc1:*=0;
            var loc2:*=null;
            if (arg1 != null) 
            {
                loc1 = (this._objects.length - 1);
                while (loc1 >= 0) 
                {
                    loc2 = this._objects[loc1] as starling.animation.DelayedCall;
                    if (loc2 && loc2.callback == arg1) 
                    {
                        return true;
                    }
                    --loc1;
                }
            }
            return false;
        }

        public function purge():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=(this._objects.length - 1);
            while (loc1 >= 0) 
            {
                loc2 = this._objects[loc1];
                loc3 = loc2 as starling.events.EventDispatcher;
                if (loc3) 
                {
                    loc3.removeEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onRemove);
                }
                this._objects[loc1] = null;
                delete this._objectIDs[loc2];
                --loc1;
            }
            return;
        }

        public function delayCall(arg1:Function, arg2:Number, ... rest):uint
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("call must not be null");
            }
            var loc2:*;
            var loc1:*=(loc2 = starling.animation.DelayedCall).starling_internal::fromPool(arg1, arg2, rest);
            loc1.addEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onPooledDelayedCallComplete);
            return this.add(loc1);
        }

        public function repeatCall(arg1:Function, arg2:Number, arg3:int=0, ... rest):uint
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("call must not be null");
            }
            var loc2:*;
            var loc1:*=(loc2 = starling.animation.DelayedCall).starling_internal::fromPool(arg1, arg2, rest);
            loc1.repeatCount = arg3;
            loc1.addEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onPooledDelayedCallComplete);
            return this.add(loc1);
        }

        internal function onPooledDelayedCallComplete(arg1:starling.events.Event):void
        {
            var loc1:*;
            (loc1 = starling.animation.DelayedCall).starling_internal::toPool(arg1.target as starling.animation.DelayedCall);
            return;
        }

        public function tween(arg1:Object, arg2:Number, arg3:Object):uint
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 == null) 
            {
                throw new ArgumentError("target must not be null");
            }
            var loc4:*;
            var loc1:*=(loc4 = starling.animation.Tween).starling_internal::fromPool(arg1, arg2);
            loc4 = 0;
            var loc5:*=arg3;
            for (loc2 in loc5) 
            {
                loc3 = arg3[loc2];
                if (loc1.hasOwnProperty(loc2)) 
                {
                    loc1[loc2] = loc3;
                    continue;
                }
                if (arg1.hasOwnProperty(starling.animation.Tween.getPropertyName(loc2))) 
                {
                    loc1.animate(loc2, loc3 as Number);
                    continue;
                }
                throw new ArgumentError("Invalid property: " + loc2);
            }
            loc1.addEventListener(starling.events.Event.REMOVE_FROM_JUGGLER, this.onPooledTweenComplete);
            return this.add(loc1);
        }

        internal function onPooledTweenComplete(arg1:starling.events.Event):void
        {
            var loc1:*;
            (loc1 = starling.animation.Tween).starling_internal::toPool(arg1.target as starling.animation.Tween);
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=this._objects.length;
            var loc2:*=0;
            arg1 = arg1 * this._timeScale;
            if (loc1 == 0 || arg1 == 0) 
            {
                return;
            }
            this._elapsedTime = this._elapsedTime + arg1;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4 = this._objects[loc3];
                if (loc4) 
                {
                    if (loc2 != loc3) 
                    {
                        this._objects[loc2] = loc4;
                        this._objects[loc3] = null;
                    }
                    loc4.advanceTime(arg1);
                    ++loc2;
                }
                ++loc3;
            }
            if (loc2 != loc3) 
            {
                loc1 = this._objects.length;
                while (loc3 < loc1) 
                {
                    this._objects[int(loc2++)] = this._objects[int(loc3++)];
                }
                this._objects.length = loc2;
            }
            return;
        }

        internal function onRemove(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc1:*=this.remove(arg1.target as starling.animation.IAnimatable);
            if (loc1) 
            {
                loc2 = arg1.target as starling.animation.Tween;
                if (loc2 && loc2.isComplete) 
                {
                    this.addWithID(loc2.nextTween, loc1);
                }
            }
            return;
        }

        public function get elapsedTime():Number
        {
            return this._elapsedTime;
        }

        public function get timeScale():Number
        {
            return this._timeScale;
        }

        public function set timeScale(arg1:Number):void
        {
            this._timeScale = arg1;
            return;
        }

        protected function get objects():__AS3__.vec.Vector.<starling.animation.IAnimatable>
        {
            return this._objects;
        }

        internal static function getNextID():uint
        {
            var loc1:*;
            var loc2:*;
            return ++sCurrentObjectID;
        }

        internal var _objects:__AS3__.vec.Vector.<starling.animation.IAnimatable>;

        internal var _objectIDs:flash.utils.Dictionary;

        internal var _elapsedTime:Number;

        internal var _timeScale:Number;

        internal static var sCurrentObjectID:uint;
    }
}


