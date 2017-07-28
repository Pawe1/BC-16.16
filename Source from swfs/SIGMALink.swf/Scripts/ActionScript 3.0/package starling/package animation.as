//package animation
//  class DelayedCall
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


//  class IAnimatable
package starling.animation 
{
    public interface IAnimatable
    {
        function advanceTime(arg1:Number):void;
    }
}


//  class Juggler
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


//  class Transitions
package starling.animation 
{
    import flash.utils.*;
    import starling.errors.*;
    
    public class Transitions extends Object
    {
        public function Transitions()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        protected static function linear(arg1:Number):Number
        {
            return arg1;
        }

        protected static function easeIn(arg1:Number):Number
        {
            return arg1 * arg1 * arg1;
        }

        protected static function easeOut(arg1:Number):Number
        {
            var loc1:*;
            --loc1;
            return loc1 * loc1 * loc1 + 1;
        }

        protected static function easeInOut(arg1:Number):Number
        {
            return easeCombined(easeIn, easeOut, arg1);
        }

        protected static function easeOutIn(arg1:Number):Number
        {
            return easeCombined(easeOut, easeIn, arg1);
        }

        protected static function easeInBack(arg1:Number):Number
        {
            var loc1:*=1.70158;
            return Math.pow(arg1, 2) * ((loc1 + 1) * arg1 - loc1);
        }

        protected static function easeOutBack(arg1:Number):Number
        {
            var loc1:*;
            --loc1;
            var loc2:*=1.70158;
            return Math.pow(loc1, 2) * ((loc2 + 1) * loc1 + loc2) + 1;
        }

        protected static function easeInOutBack(arg1:Number):Number
        {
            return easeCombined(easeInBack, easeOutBack, arg1);
        }

        protected static function easeOutInBack(arg1:Number):Number
        {
            return easeCombined(easeOutBack, easeInBack, arg1);
        }

        protected static function easeInElastic(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg1 == 0 || arg1 == 1) 
            {
                return arg1;
            }
            loc1 = 0.3;
            loc2 = loc1 / 4;
            --loc3;
            return -1 * Math.pow(2, 10 * loc3) * Math.sin((loc3 - loc2) * 2 * Math.PI / loc1);
        }

        protected static function easeOutElastic(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg1 == 0 || arg1 == 1) 
            {
                return arg1;
            }
            loc1 = 0.3;
            loc2 = loc1 / 4;
            return Math.pow(2, -10 * arg1) * Math.sin((arg1 - loc2) * 2 * Math.PI / loc1) + 1;
        }

        protected static function easeInOutElastic(arg1:Number):Number
        {
            return easeCombined(easeInElastic, easeOutElastic, arg1);
        }

        protected static function easeOutInElastic(arg1:Number):Number
        {
            return easeCombined(easeOutElastic, easeInElastic, arg1);
        }

        protected static function easeInBounce(arg1:Number):Number
        {
            return 1 - easeOutBounce(1 - arg1);
        }

        protected static function easeOutBounce(arg1:Number):Number
        {
            var loc3:*=NaN;
            var loc1:*=7.5625;
            var loc2:*=2.75;
            if (arg1 < 1 / loc2) 
            {
                loc3 = loc1 * Math.pow(arg1, 2);
            }
            else if (arg1 < 2 / loc2) 
            {
                arg1 = arg1 - 1.5 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.75;
            }
            else if (arg1 < 2.5 / loc2) 
            {
                arg1 = arg1 - 2.25 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.9375;
            }
            else 
            {
                arg1 = arg1 - 2.625 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.984375;
            }
            return loc3;
        }

        protected static function easeInOutBounce(arg1:Number):Number
        {
            return easeCombined(easeInBounce, easeOutBounce, arg1);
        }

        protected static function easeOutInBounce(arg1:Number):Number
        {
            return easeCombined(easeOutBounce, easeInBounce, arg1);
        }

        protected static function easeCombined(arg1:Function, arg2:Function, arg3:Number):Number
        {
            if (arg3 < 0.5) 
            {
                return 0.5 * arg1(arg3 * 2);
            }
            return 0.5 * arg2((arg3 - 0.5) * 2) + 0.5;
        }

        public static function getTransition(arg1:String):Function
        {
            if (sTransitions == null) 
            {
                registerDefaults();
            }
            return sTransitions[arg1];
        }

        public static function register(arg1:String, arg2:Function):void
        {
            if (sTransitions == null) 
            {
                registerDefaults();
            }
            sTransitions[arg1] = arg2;
            return;
        }

        internal static function registerDefaults():void
        {
            sTransitions = new flash.utils.Dictionary();
            register(LINEAR, linear);
            register(EASE_IN, easeIn);
            register(EASE_OUT, easeOut);
            register(EASE_IN_OUT, easeInOut);
            register(EASE_OUT_IN, easeOutIn);
            register(EASE_IN_BACK, easeInBack);
            register(EASE_OUT_BACK, easeOutBack);
            register(EASE_IN_OUT_BACK, easeInOutBack);
            register(EASE_OUT_IN_BACK, easeOutInBack);
            register(EASE_IN_ELASTIC, easeInElastic);
            register(EASE_OUT_ELASTIC, easeOutElastic);
            register(EASE_IN_OUT_ELASTIC, easeInOutElastic);
            register(EASE_OUT_IN_ELASTIC, easeOutInElastic);
            register(EASE_IN_BOUNCE, easeInBounce);
            register(EASE_OUT_BOUNCE, easeOutBounce);
            register(EASE_IN_OUT_BOUNCE, easeInOutBounce);
            register(EASE_OUT_IN_BOUNCE, easeOutInBounce);
            return;
        }

        public static const LINEAR:String="linear";

        public static const EASE_IN:String="easeIn";

        public static const EASE_OUT:String="easeOut";

        public static const EASE_IN_OUT:String="easeInOut";

        public static const EASE_OUT_IN:String="easeOutIn";

        public static const EASE_IN_BACK:String="easeInBack";

        public static const EASE_OUT_BACK:String="easeOutBack";

        public static const EASE_IN_OUT_BACK:String="easeInOutBack";

        public static const EASE_OUT_IN_BACK:String="easeOutInBack";

        public static const EASE_IN_ELASTIC:String="easeInElastic";

        public static const EASE_OUT_ELASTIC:String="easeOutElastic";

        public static const EASE_IN_OUT_ELASTIC:String="easeInOutElastic";

        public static const EASE_OUT_IN_ELASTIC:String="easeOutInElastic";

        public static const EASE_IN_BOUNCE:String="easeInBounce";

        public static const EASE_OUT_BOUNCE:String="easeOutBounce";

        public static const EASE_IN_OUT_BOUNCE:String="easeInOutBounce";

        public static const EASE_OUT_IN_BOUNCE:String="easeOutInBounce";

        internal static var sTransitions:flash.utils.Dictionary;
    }
}


//  class Tween
package starling.animation 
{
    import __AS3__.vec.*;
    import starling.core.*;
    import starling.events.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Tween extends starling.events.EventDispatcher implements starling.animation.IAnimatable
    {
        public function Tween(arg1:Object, arg2:Number, arg3:Object="linear")
        {
            super();
            this.reset(arg1, arg2, arg3);
            return;
        }

        public function get roundToInt():Boolean
        {
            return this._roundToInt;
        }

        public function set roundToInt(arg1:Boolean):void
        {
            this._roundToInt = arg1;
            return;
        }

        public function get onStart():Function
        {
            return this._onStart;
        }

        public function set onStart(arg1:Function):void
        {
            this._onStart = arg1;
            return;
        }

        public function get onUpdate():Function
        {
            return this._onUpdate;
        }

        public function set onUpdate(arg1:Function):void
        {
            this._onUpdate = arg1;
            return;
        }

        public function get onRepeat():Function
        {
            return this._onRepeat;
        }

        public function set onRepeat(arg1:Function):void
        {
            this._onRepeat = arg1;
            return;
        }

        public function get onComplete():Function
        {
            return this._onComplete;
        }

        public function get transition():String
        {
            return this._transitionName;
        }

        public function set onComplete(arg1:Function):void
        {
            this._onComplete = arg1;
            return;
        }

        public function get onStartArgs():Array
        {
            return this._onStartArgs;
        }

        public function set onStartArgs(arg1:Array):void
        {
            this._onStartArgs = arg1;
            return;
        }

        public function get onUpdateArgs():Array
        {
            return this._onUpdateArgs;
        }

        public function set onUpdateArgs(arg1:Array):void
        {
            this._onUpdateArgs = arg1;
            return;
        }

        public function get onRepeatArgs():Array
        {
            return this._onRepeatArgs;
        }

        public function set onRepeatArgs(arg1:Array):void
        {
            this._onRepeatArgs = arg1;
            return;
        }

        public function set onCompleteArgs(arg1:Array):void
        {
            this._onCompleteArgs = arg1;
            return;
        }

        public function get nextTween():starling.animation.Tween
        {
            return this._nextTween;
        }

        public function set nextTween(arg1:starling.animation.Tween):void
        {
            this._nextTween = arg1;
            return;
        }

        static function getPropertyHint(arg1:String):String
        {
            if (!(arg1.indexOf("color") == -1) || !(arg1.indexOf("Color") == -1)) 
            {
                return "rgb";
            }
            var loc1:*=arg1.indexOf(HINT_MARKER);
            if (loc1 != -1) 
            {
                return arg1.substr(loc1 + 1);
            }
            return null;
        }

        static function getPropertyName(arg1:String):String
        {
            var loc1:*=arg1.indexOf(HINT_MARKER);
            if (loc1 != -1) 
            {
                return arg1.substring(0, loc1);
            }
            return arg1;
        }

        starling_internal static function fromPool(arg1:Object, arg2:Number, arg3:Object="linear"):starling.animation.Tween
        {
            if (sTweenPool.length) 
            {
                return sTweenPool.pop().reset(arg1, arg2, arg3);
            }
            return new Tween(arg1, arg2, arg3);
        }

        starling_internal static function toPool(arg1:starling.animation.Tween):void
        {
            var loc1:*;
            arg1._onComplete = loc1 = null;
            arg1._onRepeat = loc1 = loc1;
            arg1._onUpdate = loc1 = loc1;
            arg1._onStart = loc1;
            arg1._onCompleteArgs = loc1 = null;
            arg1._onRepeatArgs = loc1 = loc1;
            arg1._onUpdateArgs = loc1 = loc1;
            arg1._onStartArgs = loc1;
            arg1._target = null;
            arg1._transitionFunc = null;
            arg1.removeEventListeners();
            sTweenPool.push(arg1);
            return;
        }

        
        {
            sTweenPool = new Vector.<>(0);
        }

        public function reset(arg1:Object, arg2:Number, arg3:Object="linear"):starling.animation.Tween
        {
            this._target = arg1;
            this._currentTime = 0;
            this._totalTime = Math.max(0.0001, arg2);
            this._progress = 0;
            var loc1:*;
            this._repeatDelay = loc1 = 0;
            this._delay = loc1;
            this._onComplete = loc1 = null;
            this._onRepeat = loc1 = loc1;
            this._onUpdate = loc1 = loc1;
            this._onStart = loc1;
            this._onCompleteArgs = loc1 = null;
            this._onRepeatArgs = loc1 = loc1;
            this._onUpdateArgs = loc1 = loc1;
            this._onStartArgs = loc1;
            this._reverse = loc1 = false;
            this._roundToInt = loc1;
            this._repeatCount = 1;
            this._currentCycle = -1;
            this._nextTween = null;
            if (arg3 is String) 
            {
                this.transition = arg3 as String;
            }
            else if (arg3 is Function) 
            {
                this.transitionFunc = arg3 as Function;
            }
            else 
            {
                throw new ArgumentError("Transition must be either a string or a function");
            }
            if (this._properties) 
            {
                this._properties.length = 0;
            }
            else 
            {
                this._properties = new Vector.<String>(0);
            }
            if (this._startValues) 
            {
                this._startValues.length = 0;
            }
            else 
            {
                this._startValues = new Vector.<Number>(0);
            }
            if (this._endValues) 
            {
                this._endValues.length = 0;
            }
            else 
            {
                this._endValues = new Vector.<Number>(0);
            }
            if (this._updateFuncs) 
            {
                this._updateFuncs.length = 0;
            }
            else 
            {
                this._updateFuncs = new Vector.<Function>(0);
            }
            return this;
        }

        public function animate(arg1:String, arg2:Number):void
        {
            if (this._target == null) 
            {
                return;
            }
            var loc1:*=this._properties.length;
            var loc2:*=this.getUpdateFuncFromProperty(arg1);
            this._properties[loc1] = getPropertyName(arg1);
            this._startValues[loc1] = Number.NaN;
            this._endValues[loc1] = arg2;
            this._updateFuncs[loc1] = loc2;
            return;
        }

        public function scaleTo(arg1:Number):void
        {
            this.animate("scaleX", arg1);
            this.animate("scaleY", arg1);
            return;
        }

        public function moveTo(arg1:Number, arg2:Number):void
        {
            this.animate("x", arg1);
            this.animate("y", arg2);
            return;
        }

        public function fadeTo(arg1:Number):void
        {
            this.animate("alpha", arg1);
            return;
        }

        public function rotateTo(arg1:Number, arg2:String="rad"):void
        {
            this.animate("rotation#" + arg2, arg1);
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc1:*=0;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            if (arg1 == 0 || this._repeatCount == 1 && this._currentTime == this._totalTime) 
            {
                return;
            }
            var loc2:*=this._currentTime;
            var loc3:*=this._totalTime - this._currentTime;
            var loc4:*=arg1 > loc3 ? arg1 - loc3 : 0;
            this._currentTime = this._currentTime + arg1;
            if (this._currentTime <= 0) 
            {
                return;
            }
            if (this._currentTime > this._totalTime) 
            {
                this._currentTime = this._totalTime;
            }
            if (this._currentCycle < 0 && loc2 <= 0 && this._currentTime > 0) 
            {
                var loc11:*;
                var loc12:*=((loc11 = this)._currentCycle + 1);
                loc11._currentCycle = loc12;
                if (this._onStart != null) 
                {
                    this._onStart.apply(this, this._onStartArgs);
                }
            }
            var loc5:*=this._currentTime / this._totalTime;
            var loc6:*=this._reverse && this._currentCycle % 2 == 1;
            var loc7:*=this._startValues.length;
            this._progress = loc6 ? this._transitionFunc(1 - loc5) : this._transitionFunc(loc5);
            loc1 = 0;
            while (loc1 < loc7) 
            {
                if (this._startValues[loc1] != this._startValues[loc1]) 
                {
                    this._startValues[loc1] = this._target[this._properties[loc1]] as Number;
                }
                loc8 = this._updateFuncs[loc1] as Function;
                loc8(this._properties[loc1], this._startValues[loc1], this._endValues[loc1]);
                ++loc1;
            }
            if (this._onUpdate != null) 
            {
                this._onUpdate.apply(this, this._onUpdateArgs);
            }
            if (loc2 < this._totalTime && this._currentTime >= this._totalTime) 
            {
                if (this._repeatCount == 0 || this._repeatCount > 1) 
                {
                    this._currentTime = -this._repeatDelay;
                    loc12 = ((loc11 = this)._currentCycle + 1);
                    loc11._currentCycle = loc12;
                    if (this._repeatCount > 1) 
                    {
                        loc12 = ((loc11 = this)._repeatCount - 1);
                        loc11._repeatCount = loc12;
                    }
                    if (this._onRepeat != null) 
                    {
                        this._onRepeat.apply(this, this._onRepeatArgs);
                    }
                }
                else 
                {
                    loc9 = this._onComplete;
                    loc10 = this._onCompleteArgs;
                    dispatchEventWith(starling.events.Event.REMOVE_FROM_JUGGLER);
                    if (loc9 != null) 
                    {
                        loc9.apply(this, loc10);
                    }
                    if (this._currentTime == 0) 
                    {
                        loc4 = 0;
                    }
                }
            }
            if (loc4) 
            {
                this.advanceTime(loc4);
            }
            return;
        }

        internal function getUpdateFuncFromProperty(arg1:String):Function
        {
            var loc1:*=null;
            var loc2:*=getPropertyHint(arg1);
            var loc3:*=loc2;
            switch (loc3) 
            {
                case null:
                {
                    loc1 = this.updateStandard;
                    break;
                }
                case "rgb":
                {
                    loc1 = this.updateRgb;
                    break;
                }
                case "rad":
                {
                    loc1 = this.updateRad;
                    break;
                }
                case "deg":
                {
                    loc1 = this.updateDeg;
                    break;
                }
                default:
                {
                    trace("[Starling] Ignoring unknown property hint:", loc2);
                    loc1 = this.updateStandard;
                }
            }
            return loc1;
        }

        internal function updateStandard(arg1:String, arg2:Number, arg3:Number):void
        {
            var loc1:*=arg2 + this._progress * (arg3 - arg2);
            if (this._roundToInt) 
            {
                loc1 = Math.round(loc1);
            }
            this._target[arg1] = loc1;
            return;
        }

        internal function updateRgb(arg1:String, arg2:Number, arg3:Number):void
        {
            this._target[arg1] = starling.utils.Color.interpolate(uint(arg2), uint(arg3), this._progress);
            return;
        }

        internal function updateRad(arg1:String, arg2:Number, arg3:Number):void
        {
            this.updateAngle(Math.PI, arg1, arg2, arg3);
            return;
        }

        internal function updateDeg(arg1:String, arg2:Number, arg3:Number):void
        {
            this.updateAngle(180, arg1, arg2, arg3);
            return;
        }

        internal function updateAngle(arg1:Number, arg2:String, arg3:Number, arg4:Number):void
        {
            while (Math.abs(arg4 - arg3) > arg1) 
            {
                if (arg3 < arg4) 
                {
                    arg4 = arg4 - 2 * arg1;
                    continue;
                }
                arg4 = arg4 + 2 * arg1;
            }
            this.updateStandard(arg2, arg3, arg4);
            return;
        }

        public function getEndValue(arg1:String):Number
        {
            var loc1:*=this._properties.indexOf(arg1);
            if (loc1 == -1) 
            {
                throw new ArgumentError("The property \'" + arg1 + "\' is not animated");
            }
            return this._endValues[loc1] as Number;
        }

        public function get isComplete():Boolean
        {
            return this._currentTime >= this._totalTime && this._repeatCount == 1;
        }

        public function get target():Object
        {
            return this._target;
        }

        public function get onCompleteArgs():Array
        {
            return this._onCompleteArgs;
        }

        public function set transition(arg1:String):void
        {
            this._transitionName = arg1;
            this._transitionFunc = starling.animation.Transitions.getTransition(arg1);
            if (this._transitionFunc == null) 
            {
                throw new ArgumentError("Invalid transiton: " + arg1);
            }
            return;
        }

        public function get transitionFunc():Function
        {
            return this._transitionFunc;
        }

        public function set transitionFunc(arg1:Function):void
        {
            this._transitionName = "custom";
            this._transitionFunc = arg1;
            return;
        }

        public function get totalTime():Number
        {
            return this._totalTime;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function get progress():Number
        {
            return this._progress;
        }

        public function get delay():Number
        {
            return this._delay;
        }

        public function set delay(arg1:Number):void
        {
            this._currentTime = this._currentTime + this._delay - arg1;
            this._delay = arg1;
            return;
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

        public function get repeatDelay():Number
        {
            return this._repeatDelay;
        }

        public function set repeatDelay(arg1:Number):void
        {
            this._repeatDelay = arg1;
            return;
        }

        public function get reverse():Boolean
        {
            return this._reverse;
        }

        public function set reverse(arg1:Boolean):void
        {
            this._reverse = arg1;
            return;
        }

        internal static const HINT_MARKER:String="#";

        internal var _target:Object;

        internal var _transitionFunc:Function;

        internal var _transitionName:String;

        internal var _properties:__AS3__.vec.Vector.<String>;

        internal var _startValues:__AS3__.vec.Vector.<Number>;

        internal var _endValues:__AS3__.vec.Vector.<Number>;

        internal var _updateFuncs:__AS3__.vec.Vector.<Function>;

        internal var _onStart:Function;

        internal var _onUpdate:Function;

        internal var _onComplete:Function;

        internal var _onStartArgs:Array;

        internal var _onUpdateArgs:Array;

        internal var _onRepeatArgs:Array;

        internal var _onCompleteArgs:Array;

        internal var _totalTime:Number;

        internal var _currentTime:Number;

        internal var _progress:Number;

        internal var _delay:Number;

        internal var _roundToInt:Boolean;

        internal var _nextTween:starling.animation.Tween;

        internal var _repeatCount:int;

        internal var _repeatDelay:Number;

        internal var _reverse:Boolean;

        internal var _currentCycle:int;

        internal var _onRepeat:Function;

        internal static var sTweenPool:__AS3__.vec.Vector.<starling.animation.Tween>;
    }
}


