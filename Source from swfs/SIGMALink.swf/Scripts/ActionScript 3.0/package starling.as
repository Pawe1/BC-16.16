//package starling
//  package animation
//    class DelayedCall
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


//    class IAnimatable
package starling.animation 
{
    public interface IAnimatable
    {
        function advanceTime(arg1:Number):void;
    }
}


//    class Juggler
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


//    class Transitions
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


//    class Tween
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


//  package core
//    class Starling
package starling.core 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Starling extends starling.events.EventDispatcher
    {
        public function Starling(arg1:Class, arg2:flash.display.Stage, arg3:flash.geom.Rectangle=null, arg4:flash.display.Stage3D=null, arg5:String="auto", arg6:Object="auto")
        {
            var loc1:*=null;
            super();
            if (arg2 == null) 
            {
                throw new ArgumentError("Stage must not be null");
            }
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle(0, 0, arg2.stageWidth, arg2.stageHeight);
            }
            if (arg4 == null) 
            {
                arg4 = arg2.stage3Ds[0];
            }
            starling.utils.SystemUtil.initialize();
            sAll.push(this);
            this.makeCurrent();
            this._rootClass = arg1;
            this._viewPort = arg3;
            this._previousViewPort = new flash.geom.Rectangle();
            this._stage = new starling.display.Stage(arg3.width, arg3.height, arg2.color);
            this._nativeOverlay = new flash.display.Sprite();
            this._nativeStage = arg2;
            this._nativeStage.addChild(this._nativeOverlay);
            this._touchProcessor = new starling.events.TouchProcessor(this._stage);
            this._juggler = new starling.animation.Juggler();
            this._antiAliasing = 0;
            this._supportHighResolutions = false;
            this._painter = new starling.rendering.Painter(arg4);
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            this._frameID = 1;
            arg2.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            arg2.align = flash.display.StageAlign.TOP_LEFT;
            var loc2:*=0;
            var loc3:*=this.touchEventTypes;
            for each (loc1 in loc3) 
            {
                arg2.addEventListener(loc1, this.onTouch, false, 0, true);
            }
            arg2.addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
            arg2.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKey, false, 0, true);
            arg2.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKey, false, 0, true);
            arg2.addEventListener(flash.events.Event.RESIZE, this.onResize, false, 0, true);
            arg2.addEventListener(flash.events.Event.MOUSE_LEAVE, this.onMouseLeave, false, 0, true);
            arg4.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 10, true);
            arg4.addEventListener(flash.events.ErrorEvent.ERROR, this.onStage3DError, false, 10, true);
            if (this._painter.shareContext) 
            {
                flash.utils.setTimeout(this.initialize, 1);
            }
            else 
            {
                if (!starling.utils.SystemUtil.supportsDepthAndStencil) 
                {
                    trace("[Starling] Mask support requires \'depthAndStencil\' to be enabled" + " in the application descriptor.");
                }
                this._painter.requestContext3D(arg5, arg6);
            }
            return;
        }

        public function set rootClass(arg1:Class):void
        {
            if (!(this._rootClass == null) && !(this._root == null)) 
            {
                throw new Error("Root class may not change after root has been instantiated");
            }
            if (this._rootClass == null) 
            {
                this._rootClass = arg1;
                if (this.context) 
                {
                    this.initializeRoot();
                }
            }
            return;
        }

        public function get shareContext():Boolean
        {
            return this._painter.shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            this._painter.shareContext = arg1;
            return;
        }

        public function get profile():String
        {
            return this._painter.profile;
        }

        public function get supportHighResolutions():Boolean
        {
            return this._supportHighResolutions;
        }

        public function set supportHighResolutions(arg1:Boolean):void
        {
            if (this._supportHighResolutions != arg1) 
            {
                this._supportHighResolutions = arg1;
                if (this.contextValid) 
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }

        public function get skipUnchangedFrames():Boolean
        {
            return this._skipUnchangedFrames;
        }

        public function set skipUnchangedFrames(arg1:Boolean):void
        {
            this._skipUnchangedFrames = arg1;
            this._nativeStageEmpty = false;
            return;
        }

        public function get touchProcessor():starling.events.TouchProcessor
        {
            return this._touchProcessor;
        }

        public function set touchProcessor(arg1:starling.events.TouchProcessor):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("TouchProcessor must not be null");
            }
            if (arg1 != this._touchProcessor) 
            {
                this._touchProcessor.dispose();
                this._touchProcessor = arg1;
            }
            return;
        }

        public function get isStarted():Boolean
        {
            return this._started;
        }

        public function get frameID():uint
        {
            return this._frameID;
        }

        public function get contextValid():Boolean
        {
            return this._painter.contextValid;
        }

        public static function get current():starling.core.Starling
        {
            return sCurrent;
        }

        public static function get all():__AS3__.vec.Vector.<starling.core.Starling>
        {
            return sAll;
        }

        public static function get context():flash.display3D.Context3D
        {
            return sCurrent ? sCurrent.context : null;
        }

        public static function get juggler():starling.animation.Juggler
        {
            return sCurrent ? sCurrent._juggler : null;
        }

        public static function get painter():starling.rendering.Painter
        {
            return sCurrent ? sCurrent._painter : null;
        }

        public static function get contentScaleFactor():Number
        {
            return sCurrent ? sCurrent.contentScaleFactor : 1;
        }

        public static function get multitouchEnabled():Boolean
        {
            return flash.ui.Multitouch.inputMode == flash.ui.MultitouchInputMode.TOUCH_POINT;
        }

        public static function set multitouchEnabled(arg1:Boolean):void
        {
            if (sCurrent) 
            {
                throw new flash.errors.IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
            }
            flash.ui.Multitouch.inputMode = arg1 ? flash.ui.MultitouchInputMode.TOUCH_POINT : flash.ui.MultitouchInputMode.NONE;
            return;
        }

        public static function get frameID():uint
        {
            return sCurrent ? sCurrent._frameID : 0;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            this.stop(true);
            this._nativeStage.removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame, false);
            this._nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKey, false);
            this._nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKey, false);
            this._nativeStage.removeEventListener(flash.events.Event.RESIZE, this.onResize, false);
            this._nativeStage.removeEventListener(flash.events.Event.MOUSE_LEAVE, this.onMouseLeave, false);
            this._nativeStage.removeChild(this._nativeOverlay);
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false);
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextRestored, false);
            this.stage3D.removeEventListener(flash.events.ErrorEvent.ERROR, this.onStage3DError, false);
            var loc3:*=0;
            var loc4:*=this.touchEventTypes;
            for each (loc1 in loc4) 
            {
                this._nativeStage.removeEventListener(loc1, this.onTouch, false);
            }
            this._touchProcessor.dispose();
            this._painter.dispose();
            this._stage.dispose();
            loc2 = sAll.indexOf(this);
            if (loc2 != -1) 
            {
                sAll.removeAt(loc2);
            }
            if (sCurrent == this) 
            {
                sCurrent = null;
            }
            return;
        }

        internal function initialize():void
        {
            this.makeCurrent();
            this.updateViewPort(true);
            dispatchEventWith(flash.events.Event.CONTEXT3D_CREATE, false, this.context);
            this.initializeRoot();
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            return;
        }

        internal function initializeRoot():void
        {
            if (this._root == null && !(this._rootClass == null)) 
            {
                this._root = new this._rootClass() as starling.display.DisplayObject;
                if (this._root == null) 
                {
                    throw new Error("Invalid root class: " + this._rootClass);
                }
                this._stage.addChildAt(this._root, 0);
                dispatchEventWith(starling.events.Event.ROOT_CREATED, false, this._root);
            }
            return;
        }

        public function nextFrame():void
        {
            var loc1:*=flash.utils.getTimer() / 1000;
            var loc2:*=loc1 - this._frameTimestamp;
            this._frameTimestamp = loc1;
            if (loc2 > 1) 
            {
                loc2 = 1;
            }
            if (loc2 < 0) 
            {
                loc2 = 1 / this._nativeStage.frameRate;
            }
            this.advanceTime(loc2);
            this.render();
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            if (!this.contextValid) 
            {
                return;
            }
            this.makeCurrent();
            this._touchProcessor.advanceTime(arg1);
            this._stage.advanceTime(arg1);
            this._juggler.advanceTime(arg1);
            return;
        }

        public function render():void
        {
            var loc2:*=false;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!this.contextValid) 
            {
                return;
            }
            this.makeCurrent();
            this.updateViewPort();
            var loc1:*=this._stage.requiresRedraw || this.mustAlwaysRender;
            if (loc1) 
            {
                dispatchEventWith(starling.events.Event.RENDER);
                loc2 = this._painter.shareContext;
                loc3 = this._viewPort.width / this._stage.stageWidth;
                loc4 = this._viewPort.height / this._stage.stageHeight;
                this._painter.nextFrame();
                this._painter.pixelSize = 1 / this.contentScaleFactor;
                this._painter.state.setProjectionMatrix(this._viewPort.x < 0 ? (-this._viewPort.x) / loc3 : 0, this._viewPort.y < 0 ? (-this._viewPort.y) / loc4 : 0, this._clippedViewPort.width / loc3, this._clippedViewPort.height / loc4, this._stage.stageWidth, this._stage.stageHeight, this._stage.cameraPosition);
                if (!loc2) 
                {
                    this._painter.clear(this._stage.color, 0);
                }
                this._stage.render(this._painter);
                this._painter.finishFrame();
                var loc5:*;
                var loc6:*;
                this._painter.frameID = loc5._frameID = loc6 = ((loc5 = this)._frameID + 1);
                if (!loc2) 
                {
                    this._painter.present();
                }
            }
            if (this._statsDisplay) 
            {
                this._statsDisplay.drawCount = this._painter.drawCount;
                if (!loc1) 
                {
                    this._statsDisplay.markFrameAsSkipped();
                }
            }
            return;
        }

        internal function updateViewPort(arg1:Boolean=false):void
        {
            var loc1:*=NaN;
            if (arg1 || !starling.utils.RectangleUtil.compare(this._viewPort, this._previousViewPort)) 
            {
                this._previousViewPort.setTo(this._viewPort.x, this._viewPort.y, this._viewPort.width, this._viewPort.height);
                this._clippedViewPort = this._viewPort.intersection(new flash.geom.Rectangle(0, 0, this._nativeStage.stageWidth, this._nativeStage.stageHeight));
                loc1 = this._supportHighResolutions ? this._nativeStage.contentsScaleFactor : 1;
                this._painter.configureBackBuffer(this._clippedViewPort, loc1, this._antiAliasing, true);
            }
            return;
        }

        internal function updateNativeOverlay():void
        {
            this._nativeOverlay.x = this._viewPort.x;
            this._nativeOverlay.y = this._viewPort.y;
            this._nativeOverlay.scaleX = this._viewPort.width / this._stage.stageWidth;
            this._nativeOverlay.scaleY = this._viewPort.height / this._stage.stageHeight;
            return;
        }

        public function stopWithFatalError(arg1:String):void
        {
            var loc1:*=new flash.display.Shape();
            loc1.graphics.beginFill(0, 0.8);
            loc1.graphics.drawRect(0, 0, this._stage.stageWidth, this._stage.stageHeight);
            loc1.graphics.endFill();
            var loc2:*=new flash.text.TextField();
            var loc3:*=new flash.text.TextFormat("Verdana", 14, 16777215);
            loc3.align = flash.text.TextFormatAlign.CENTER;
            loc2.defaultTextFormat = loc3;
            loc2.wordWrap = true;
            loc2.width = this._stage.stageWidth * 0.75;
            loc2.autoSize = flash.text.TextFieldAutoSize.CENTER;
            loc2.text = arg1;
            loc2.x = (this._stage.stageWidth - loc2.width) / 2;
            loc2.y = (this._stage.stageHeight - loc2.height) / 2;
            loc2.background = true;
            loc2.backgroundColor = 5570560;
            this.updateNativeOverlay();
            this.nativeOverlay.addChild(loc1);
            this.nativeOverlay.addChild(loc2);
            this.stop(true);
            trace("[Starling]", arg1);
            dispatchEventWith(starling.events.Event.FATAL_ERROR, false, arg1);
            return;
        }

        public function makeCurrent():void
        {
            sCurrent = this;
            return;
        }

        public function start():void
        {
            var loc1:*;
            this._rendering = loc1 = true;
            this._started = loc1;
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            flash.utils.setTimeout(this.setRequiresRedraw, 100);
            return;
        }

        public function stop(arg1:Boolean=false):void
        {
            this._started = false;
            this._rendering = !arg1;
            return;
        }

        public function setRequiresRedraw():void
        {
            this._stage.setRequiresRedraw();
            return;
        }

        internal function onStage3DError(arg1:flash.events.ErrorEvent):void
        {
            var loc1:*=null;
            if (arg1.errorID != 3702) 
            {
                this.stopWithFatalError("Stage3D error: " + arg1.text);
            }
            else 
            {
                loc1 = flash.system.Capabilities.playerType != "Desktop" ? "wmode" : "renderMode";
                this.stopWithFatalError("Context3D not available! Possible reasons: wrong " + loc1 + " or missing device support.");
            }
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextRestored, false, 10, true);
            trace("[Starling] Context ready. Display Driver:", this.context.driverInfo);
            this.initialize();
            return;
        }

        internal function onContextRestored(arg1:flash.events.Event):void
        {
            trace("[Starling] Context restored.");
            this.updateViewPort(true);
            dispatchEventWith(flash.events.Event.CONTEXT3D_CREATE, false, this.context);
            return;
        }

        internal function onEnterFrame(arg1:flash.events.Event):void
        {
            if (!this.shareContext) 
            {
                if (this._started) 
                {
                    this.nextFrame();
                }
                else if (this._rendering) 
                {
                    this.render();
                }
            }
            this.updateNativeOverlay();
            return;
        }

        internal function onKey(arg1:flash.events.KeyboardEvent):void
        {
            if (!this._started) 
            {
                return;
            }
            var loc1:*=new starling.events.KeyboardEvent(arg1.type, arg1.charCode, arg1.keyCode, arg1.keyLocation, arg1.ctrlKey, arg1.altKey, arg1.shiftKey);
            this.makeCurrent();
            this._stage.dispatchEvent(loc1);
            if (loc1.isDefaultPrevented()) 
            {
                arg1.preventDefault();
            }
            return;
        }

        internal function onResize(arg1:flash.events.Event):void
        {
            var event:flash.events.Event;
            var stageWidth:int;
            var stageHeight:int;
            var dispatchResizeEvent:Function;

            var loc1:*;
            stageWidth = 0;
            stageHeight = 0;
            dispatchResizeEvent = null;
            event = arg1;
            dispatchResizeEvent = function ():void
            {
                makeCurrent();
                removeEventListener(flash.events.Event.CONTEXT3D_CREATE, dispatchResizeEvent);
                _stage.dispatchEvent(new starling.events.ResizeEvent(flash.events.Event.RESIZE, stageWidth, stageHeight));
                return;
            }
            stageWidth = event.target.stageWidth;
            stageHeight = event.target.stageHeight;
            if (this.contextValid) 
            {
                dispatchResizeEvent();
            }
            else 
            {
                addEventListener(flash.events.Event.CONTEXT3D_CREATE, dispatchResizeEvent);
            }
            return;
        }

        internal function onMouseLeave(arg1:flash.events.Event):void
        {
            this._touchProcessor.enqueueMouseLeftStage();
            return;
        }

        internal function onTouch(arg1:flash.events.Event):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (!this._started) 
            {
                return;
            }
            var loc5:*=1;
            var loc6:*=1;
            var loc7:*=1;
            if (arg1 is flash.events.MouseEvent) 
            {
                loc8 = arg1 as flash.events.MouseEvent;
                loc1 = loc8.stageX;
                loc2 = loc8.stageY;
                loc3 = 0;
                if (arg1.type != flash.events.MouseEvent.MOUSE_DOWN) 
                {
                    if (arg1.type == flash.events.MouseEvent.MOUSE_UP) 
                    {
                        this._leftMouseDown = false;
                    }
                }
                else 
                {
                    this._leftMouseDown = true;
                }
            }
            else 
            {
                loc9 = arg1 as flash.events.TouchEvent;
                if (flash.ui.Mouse.supportsCursor && loc9.isPrimaryTouchPoint) 
                {
                    return;
                }
                loc1 = loc9.stageX;
                loc2 = loc9.stageY;
                loc3 = loc9.touchPointID;
                loc5 = loc9.pressure;
                loc6 = loc9.sizeX;
                loc7 = loc9.sizeY;
            }
            var loc10:*=arg1.type;
            switch (loc10) 
            {
                case flash.events.TouchEvent.TOUCH_BEGIN:
                {
                    loc4 = starling.events.TouchPhase.BEGAN;
                    break;
                }
                case flash.events.TouchEvent.TOUCH_MOVE:
                {
                    loc4 = starling.events.TouchPhase.MOVED;
                    break;
                }
                case flash.events.TouchEvent.TOUCH_END:
                {
                    loc4 = starling.events.TouchPhase.ENDED;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_DOWN:
                {
                    loc4 = starling.events.TouchPhase.BEGAN;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_UP:
                {
                    loc4 = starling.events.TouchPhase.ENDED;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_MOVE:
                {
                    loc4 = this._leftMouseDown ? starling.events.TouchPhase.MOVED : starling.events.TouchPhase.HOVER;
                    break;
                }
            }
            loc1 = this._stage.stageWidth * (loc1 - this._viewPort.x) / this._viewPort.width;
            loc2 = this._stage.stageHeight * (loc2 - this._viewPort.y) / this._viewPort.height;
            this._touchProcessor.enqueue(loc3, loc4, loc1, loc2, loc5, loc6, loc7);
            if (arg1.type == flash.events.MouseEvent.MOUSE_UP && flash.ui.Mouse.supportsCursor) 
            {
                this._touchProcessor.enqueue(loc3, starling.events.TouchPhase.HOVER, loc1, loc2);
            }
            return;
        }

        internal function get touchEventTypes():Array
        {
            var loc1:*=[];
            if (multitouchEnabled) 
            {
                loc1.push(flash.events.TouchEvent.TOUCH_BEGIN, flash.events.TouchEvent.TOUCH_MOVE, flash.events.TouchEvent.TOUCH_END);
            }
            if (!multitouchEnabled || flash.ui.Mouse.supportsCursor) 
            {
                loc1.push(flash.events.MouseEvent.MOUSE_DOWN, flash.events.MouseEvent.MOUSE_MOVE, flash.events.MouseEvent.MOUSE_UP);
            }
            return loc1;
        }

        internal function get mustAlwaysRender():Boolean
        {
            var loc1:*=false;
            var loc2:*=false;
            if (!this._skipUnchangedFrames || this._painter.shareContext) 
            {
                return true;
            }
            if (starling.utils.SystemUtil.isDesktop && !(this.profile == flash.display3D.Context3DProfile.BASELINE_CONSTRAINED)) 
            {
                return false;
            }
            loc1 = isNativeDisplayObjectEmpty(this._nativeStage);
            loc2 = !loc1 || !this._nativeStageEmpty;
            this._nativeStageEmpty = loc1;
            return loc2;
        }

        
        {
            sAll = new Vector.<>(0);
        }

        public function get juggler():starling.animation.Juggler
        {
            return this._juggler;
        }

        public function get painter():starling.rendering.Painter
        {
            return this._painter;
        }

        public function get context():flash.display3D.Context3D
        {
            return this._painter.context;
        }

        public function get simulateMultitouch():Boolean
        {
            return this._touchProcessor.simulateMultitouch;
        }

        public function set simulateMultitouch(arg1:Boolean):void
        {
            this._touchProcessor.simulateMultitouch = arg1;
            return;
        }

        public function get enableErrorChecking():Boolean
        {
            return this._painter.enableErrorChecking;
        }

        public function set enableErrorChecking(arg1:Boolean):void
        {
            this._painter.enableErrorChecking = arg1;
            return;
        }

        public function get antiAliasing():int
        {
            return this._antiAliasing;
        }

        public function set antiAliasing(arg1:int):void
        {
            if (this._antiAliasing != arg1) 
            {
                this._antiAliasing = arg1;
                if (this.contextValid) 
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }

        public function get viewPort():flash.geom.Rectangle
        {
            return this._viewPort;
        }

        public function set viewPort(arg1:flash.geom.Rectangle):void
        {
            this._viewPort = arg1.clone();
            return;
        }

        public function get contentScaleFactor():Number
        {
            return this._viewPort.width * this._painter.backBufferScaleFactor / this._stage.stageWidth;
        }

        public function get nativeOverlay():flash.display.Sprite
        {
            return this._nativeOverlay;
        }

        public function get showStats():Boolean
        {
            return this._showStats;
        }

        public function set showStats(arg1:Boolean):void
        {
            this._showStats = arg1;
            if (arg1) 
            {
                if (this._statsDisplay) 
                {
                    this._stage.addChild(this._statsDisplay);
                }
                else 
                {
                    this.showStatsAt();
                }
            }
            else if (this._statsDisplay) 
            {
                this._statsDisplay.removeFromParent();
            }
            return;
        }

        public function showStatsAt(arg1:String="left", arg2:String="top", arg3:Number=1):void
        {
            var horizontalAlign:String="left";
            var verticalAlign:String="top";
            var scale:Number=1;
            var onRootCreated:Function;
            var stageWidth:int;
            var stageHeight:int;

            var loc1:*;
            onRootCreated = null;
            stageWidth = 0;
            stageHeight = 0;
            horizontalAlign = arg1;
            verticalAlign = arg2;
            scale = arg3;
            onRootCreated = function ():void
            {
                if (_showStats) 
                {
                    showStatsAt(horizontalAlign, verticalAlign, scale);
                }
                removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                return;
            }
            this._showStats = true;
            if (this.context != null) 
            {
                stageWidth = this._stage.stageWidth;
                stageHeight = this._stage.stageHeight;
                if (this._statsDisplay == null) 
                {
                    this._statsDisplay = new StatsDisplay();
                    this._statsDisplay.touchable = false;
                }
                this._stage.addChild(this._statsDisplay);
                var loc2:*;
                this._statsDisplay.scaleY = loc2 = scale;
                this._statsDisplay.scaleX = loc2;
                if (horizontalAlign != starling.utils.Align.LEFT) 
                {
                    if (horizontalAlign != starling.utils.Align.RIGHT) 
                    {
                        if (horizontalAlign != starling.utils.Align.CENTER) 
                        {
                            throw new ArgumentError("Invalid horizontal alignment: " + horizontalAlign);
                        }
                        else 
                        {
                            this._statsDisplay.x = (stageWidth - this._statsDisplay.width) / 2;
                        }
                    }
                    else 
                    {
                        this._statsDisplay.x = stageWidth - this._statsDisplay.width;
                    }
                }
                else 
                {
                    this._statsDisplay.x = 0;
                }
                if (verticalAlign != starling.utils.Align.TOP) 
                {
                    if (verticalAlign != starling.utils.Align.BOTTOM) 
                    {
                        if (verticalAlign != starling.utils.Align.CENTER) 
                        {
                            throw new ArgumentError("Invalid vertical alignment: " + verticalAlign);
                        }
                        else 
                        {
                            this._statsDisplay.y = (stageHeight - this._statsDisplay.height) / 2;
                        }
                    }
                    else 
                    {
                        this._statsDisplay.y = stageHeight - this._statsDisplay.height;
                    }
                }
                else 
                {
                    this._statsDisplay.y = 0;
                }
            }
            else 
            {
                addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
            }
            return;
        }

        public function get stage():starling.display.Stage
        {
            return this._stage;
        }

        public function get stage3D():flash.display.Stage3D
        {
            return this._painter.stage3D;
        }

        public function get nativeStage():flash.display.Stage
        {
            return this._nativeStage;
        }

        public function get root():starling.display.DisplayObject
        {
            return this._root;
        }

        public function get rootClass():Class
        {
            return this._rootClass;
        }

        public static const VERSION:String="2.1";

        internal var _stage:starling.display.Stage;

        internal var _rootClass:Class;

        internal var _root:starling.display.DisplayObject;

        internal var _juggler:starling.animation.Juggler;

        internal var _painter:starling.rendering.Painter;

        internal var _touchProcessor:starling.events.TouchProcessor;

        internal var _antiAliasing:int;

        internal var _frameTimestamp:Number;

        internal var _frameID:uint;

        internal var _leftMouseDown:Boolean;

        internal var _started:Boolean;

        internal var _rendering:Boolean;

        internal var _supportHighResolutions:Boolean;

        internal var _skipUnchangedFrames:Boolean;

        internal var _showStats:Boolean;

        internal var _viewPort:flash.geom.Rectangle;

        internal var _previousViewPort:flash.geom.Rectangle;

        internal var _clippedViewPort:flash.geom.Rectangle;

        internal var _nativeStage:flash.display.Stage;

        internal var _nativeStageEmpty:Boolean;

        internal var _nativeOverlay:flash.display.Sprite;

        internal var _statsDisplay:StatsDisplay;

        internal static var sAll:__AS3__.vec.Vector.<starling.core.Starling>;

        internal static var sCurrent:starling.core.Starling;
    }
}


const isNativeDisplayObjectEmpty:Function=function (arg1:flash.display.DisplayObject):Boolean
{
    var loc1:*=null;
    var loc2:*=0;
    var loc3:*=0;
    if (arg1 == null) 
    {
        return true;
    }
    if (arg1 is flash.display.DisplayObjectContainer) 
    {
        loc1 = arg1 as flash.display.DisplayObjectContainer;
        loc2 = loc1.numChildren;
        loc3 = 0;
        while (loc3 < loc2) 
        {
            if (!isNativeDisplayObjectEmpty(loc1.getChildAt(loc3))) 
            {
                return false;
            }
            ++loc3;
        }
        return true;
    }
    return !arg1.visible;
}

//    class StatsDisplay
package starling.core 
{
    import flash.system.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.text.*;
    import starling.utils.*;
    
    internal class StatsDisplay extends starling.display.Sprite
    {
        public function StatsDisplay()
        {
            super();
            var loc1:*=starling.text.BitmapFont.MINI;
            var loc2:*=starling.text.BitmapFont.NATIVE_SIZE;
            var loc3:*=16777215;
            var loc4:*=90;
            var loc5:*=this.supportsGpuMem ? 35 : 27;
            var loc6:*=this.supportsGpuMem ? "\ngpu memory:" : "";
            var loc7:*="frames/sec:\nstd memory:" + loc6 + "\ndraw calls:";
            this._labels = new starling.text.TextField(loc4, loc5, loc7);
            this._labels.format.setTo(loc1, loc2, loc3, starling.utils.Align.LEFT);
            this._labels.batchable = true;
            this._labels.x = 2;
            this._values = new starling.text.TextField((loc4 - 1), loc5, "");
            this._values.format.setTo(loc1, loc2, loc3, starling.utils.Align.RIGHT);
            this._values.batchable = true;
            this._background = new starling.display.Quad(loc4, loc5, 0);
            if (this._background.style.type != starling.styles.MeshStyle) 
            {
                this._background.style = new starling.styles.MeshStyle();
            }
            if (this._labels.style.type != starling.styles.MeshStyle) 
            {
                this._labels.style = new starling.styles.MeshStyle();
            }
            if (this._values.style.type != starling.styles.MeshStyle) 
            {
                this._values.style = new starling.styles.MeshStyle();
            }
            addChild(this._background);
            addChild(this._labels);
            addChild(this._values);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        internal function onAddedToStage():void
        {
            addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            var loc1:*;
            this._skipCount = loc1 = 0;
            this._frameCount = loc1 = loc1;
            this._totalTime = loc1;
            this.update();
            return;
        }

        internal function onRemovedFromStage():void
        {
            removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }

        internal function onEnterFrame(arg1:starling.events.EnterFrameEvent):void
        {
            this._totalTime = this._totalTime + arg1.passedTime;
            var loc1:*;
            var loc2:*=((loc1 = this)._frameCount + 1);
            loc1._frameCount = loc2;
            if (this._totalTime > UPDATE_INTERVAL) 
            {
                this.update();
                this._totalTime = loc1 = 0;
                this._skipCount = loc1 = loc1;
                this._frameCount = loc1;
            }
            return;
        }

        public function update():void
        {
            this._background.color = this._skipCount > this._frameCount / 2 ? 16128 : 0;
            this._fps = this._totalTime > 0 ? this._frameCount / this._totalTime : 0;
            this._memory = flash.system.System.totalMemory * B_TO_MB;
            this._gpuMemory = this.supportsGpuMem ? starling.core.Starling.context["totalGPUMemory"] * B_TO_MB : -1;
            var loc1:*=this._fps.toFixed(this._fps < 100 ? 1 : 0);
            var loc2:*=this._memory.toFixed(this._memory < 100 ? 1 : 0);
            var loc3:*=this._gpuMemory.toFixed(this._gpuMemory < 100 ? 1 : 0);
            var loc4:*=(this._totalTime > 0 ? this._drawCount - 2 : this._drawCount).toString();
            this._values.text = loc1 + "\n" + loc2 + "\n" + (this._gpuMemory >= 0 ? loc3 + "\n" : "") + loc4;
            return;
        }

        public function markFrameAsSkipped():void
        {
            this._skipCount = this._skipCount + 1;
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.excludeFromCache(this);
            arg1.finishMeshBatch();
            super.render(arg1);
            return;
        }

        internal function get supportsGpuMem():Boolean
        {
            return "totalGPUMemory" in starling.core.Starling.context;
        }

        public function get drawCount():int
        {
            return this._drawCount;
        }

        public function set drawCount(arg1:int):void
        {
            this._drawCount = arg1;
            return;
        }

        public function get fps():Number
        {
            return this._fps;
        }

        public function set fps(arg1:Number):void
        {
            this._fps = arg1;
            return;
        }

        public function get memory():Number
        {
            return this._memory;
        }

        public function set memory(arg1:Number):void
        {
            this._memory = arg1;
            return;
        }

        public function get gpuMemory():Number
        {
            return this._gpuMemory;
        }

        public function set gpuMemory(arg1:Number):void
        {
            this._gpuMemory = arg1;
            return;
        }

        internal static const UPDATE_INTERVAL:Number=0.5;

        internal static const B_TO_MB:Number=1 / (1024 * 1024);

        internal var _background:starling.display.Quad;

        internal var _labels:starling.text.TextField;

        internal var _values:starling.text.TextField;

        internal var _frameCount:int=0;

        internal var _totalTime:Number=0;

        internal var _fps:Number=0;

        internal var _memory:Number=0;

        internal var _gpuMemory:Number=0;

        internal var _drawCount:int=0;

        internal var _skipCount:int=0;
    }
}


//    namespace starling_internal
package starling.core 
{
    public namespace starling_internal="starling.core:starling_internal";
}


//  package display
//    class BlendMode
package starling.display 
{
    import flash.display3D.*;
    import starling.core.*;
    
    public class BlendMode extends Object
    {
        public function BlendMode(arg1:String, arg2:String, arg3:String)
        {
            super();
            this._name = arg1;
            this._sourceFactor = arg2;
            this._destinationFactor = arg3;
            return;
        }

        public function activate():void
        {
            starling.core.Starling.context.setBlendFactors(this._sourceFactor, this._destinationFactor);
            return;
        }

        public function toString():String
        {
            return this._name;
        }

        public function get sourceFactor():String
        {
            return this._sourceFactor;
        }

        public function get destinationFactor():String
        {
            return this._destinationFactor;
        }

        public function get name():String
        {
            return this._name;
        }

        public static function get(arg1:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            if (arg1 in sBlendModes) 
            {
                return sBlendModes[arg1];
            }
            throw new ArgumentError("Blend mode not found: " + arg1);
        }

        public static function register(arg1:String, arg2:String, arg3:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            var loc1:*=new BlendMode(arg1, arg2, arg3);
            sBlendModes[arg1] = loc1;
            return loc1;
        }

        internal static function registerDefaults():void
        {
            if (sBlendModes) 
            {
                return;
            }
            sBlendModes = {};
            register("none", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ZERO);
            register("normal", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("add", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE);
            register("multiply", flash.display3D.Context3DBlendFactor.DESTINATION_COLOR, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("screen", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
            register("erase", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("mask", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.SOURCE_ALPHA);
            register("below", flash.display3D.Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA, flash.display3D.Context3DBlendFactor.DESTINATION_ALPHA);
            return;
        }

        public static const AUTO:String="auto";

        public static const NONE:String="none";

        public static const NORMAL:String="normal";

        public static const ADD:String="add";

        public static const MULTIPLY:String="multiply";

        public static const SCREEN:String="screen";

        public static const ERASE:String="erase";

        public static const MASK:String="mask";

        public static const BELOW:String="below";

        internal var _name:String;

        internal var _sourceFactor:String;

        internal var _destinationFactor:String;

        internal static var sBlendModes:Object;
    }
}


//    class DisplayObject
package starling.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class DisplayObject extends starling.events.EventDispatcher
    {
        public function DisplayObject()
        {
            this._pushToken = new starling.rendering.BatchToken();
            this._popToken = new starling.rendering.BatchToken();
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.display::DisplayObject") 
            {
                throw new starling.errors.AbstractClassError();
            }
            var loc1:*;
            this._skewY = loc1 = 0;
            this._skewX = loc1 = loc1;
            this._rotation = loc1 = loc1;
            this._pivotY = loc1 = loc1;
            this._pivotX = loc1 = loc1;
            this._y = loc1 = loc1;
            this._x = loc1;
            this._alpha = loc1 = 1;
            this._scaleY = loc1 = loc1;
            this._scaleX = loc1;
            this._hasVisibleArea = loc1 = true;
            this._touchable = loc1 = loc1;
            this._visible = loc1;
            this._blendMode = starling.display.BlendMode.AUTO;
            this._transformationMatrix = new flash.geom.Matrix();
            return;
        }

        public function get scale():Number
        {
            return this.scaleX;
        }

        public function set scale(arg1:Number):void
        {
            var loc1:*;
            this.scaleY = loc1 = arg1;
            this.scaleX = loc1;
            return;
        }

        public function get skewX():Number
        {
            return this._skewX;
        }

        public function set skewX(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._skewX != arg1) 
            {
                this._skewX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get skewY():Number
        {
            return this._skewY;
        }

        public function set skewY(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._skewY != arg1) 
            {
                this._skewY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get rotation():Number
        {
            return this._rotation;
        }

        public function set rotation(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._rotation != arg1) 
            {
                this._rotation = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        function get isRotated():Boolean
        {
            return !(this._rotation == 0) || !(this._skewX == 0) || !(this._skewY == 0);
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            if (arg1 != this._alpha) 
            {
                this._alpha = arg1 < 0 ? 0 : arg1 > 1 ? 1 : arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get visible():Boolean
        {
            return this._visible;
        }

        public function set visible(arg1:Boolean):void
        {
            if (arg1 != this._visible) 
            {
                this._visible = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get is3D():Boolean
        {
            return this._is3D;
        }

        public function get touchable():Boolean
        {
            return this._touchable;
        }

        public function set touchable(arg1:Boolean):void
        {
            this._touchable = arg1;
            return;
        }

        public function get blendMode():String
        {
            return this._blendMode;
        }

        public function set blendMode(arg1:String):void
        {
            if (arg1 != this._blendMode) 
            {
                this._blendMode = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get filter():starling.filters.FragmentFilter
        {
            return this._filter;
        }

        public function set filter(arg1:starling.filters.FragmentFilter):void
        {
            if (arg1 != this._filter) 
            {
                if (this._filter) 
                {
                    this._filter.starling_internal::setTarget(null);
                }
                if (arg1) 
                {
                    arg1.starling_internal::setTarget(this);
                }
                this._filter = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get mask():starling.display.DisplayObject
        {
            return this._mask;
        }

        public function set mask(arg1:starling.display.DisplayObject):void
        {
            if (this._mask != arg1) 
            {
                if (this._mask) 
                {
                    this._mask._maskee = null;
                }
                if (arg1) 
                {
                    arg1._maskee = this;
                    arg1._hasVisibleArea = false;
                }
                this._mask = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get base():starling.display.DisplayObject
        {
            var loc1:*=this;
            while (loc1._parent) 
            {
                loc1 = loc1._parent;
            }
            return loc1;
        }

        public function get root():starling.display.DisplayObject
        {
            var loc1:*=this;
            while (loc1._parent) 
            {
                if (loc1._parent is starling.display.Stage) 
                {
                    return loc1;
                }
                loc1 = loc1.parent;
            }
            return null;
        }

        public function get stage():starling.display.Stage
        {
            return this.base as starling.display.Stage;
        }

        internal static function findCommonParent(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):starling.display.DisplayObject
        {
            var loc1:*=arg1;
            while (loc1) 
            {
                sAncestors[sAncestors.length] = loc1;
                loc1 = loc1._parent;
            }
            loc1 = arg2;
            while (loc1 && sAncestors.indexOf(loc1) == -1) 
            {
                loc1 = loc1._parent;
            }
            sAncestors.length = 0;
            if (loc1) 
            {
                return loc1;
            }
            throw new ArgumentError("Object not connected to target");
        }

        
        {
            sAncestors = new Vector.<>(0);
            sHelperPoint = new flash.geom.Point();
            sHelperPoint3D = new flash.geom.Vector3D();
            sHelperPointAlt3D = new flash.geom.Vector3D();
            sHelperRect = new flash.geom.Rectangle();
            sHelperMatrix = new flash.geom.Matrix();
            sHelperMatrixAlt = new flash.geom.Matrix();
            sHelperMatrix3D = new flash.geom.Matrix3D();
            sHelperMatrixAlt3D = new flash.geom.Matrix3D();
        }

        public function dispose():void
        {
            if (this._filter) 
            {
                this._filter.dispose();
            }
            if (this._mask) 
            {
                this._mask.dispose();
            }
            this.removeEventListeners();
            this.mask = null;
            return;
        }

        public function removeFromParent(arg1:Boolean=false):void
        {
            if (this._parent) 
            {
                this._parent.removeChild(this, arg1);
            }
            else if (arg1) 
            {
                this.dispose();
            }
            return;
        }

        public function getTransformationMatrix(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null):flash.geom.Matrix
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg2) 
            {
                arg2.identity();
            }
            else 
            {
                arg2 = new flash.geom.Matrix();
            }
            if (arg1 == this) 
            {
                return arg2;
            }
            if (arg1 == this._parent || arg1 == null && this._parent == null) 
            {
                arg2.copyFrom(this.transformationMatrix);
                return arg2;
            }
            if (arg1 == null || arg1 == this.base) 
            {
                loc2 = this;
                while (loc2 != arg1) 
                {
                    arg2.concat(loc2.transformationMatrix);
                    loc2 = loc2._parent;
                }
                return arg2;
            }
            if (arg1._parent == this) 
            {
                arg1.getTransformationMatrix(this, arg2);
                arg2.invert();
                return arg2;
            }
            loc1 = findCommonParent(this, arg1);
            loc2 = this;
            while (loc2 != loc1) 
            {
                arg2.concat(loc2.transformationMatrix);
                loc2 = loc2._parent;
            }
            if (loc1 == arg1) 
            {
                return arg2;
            }
            sHelperMatrix.identity();
            loc2 = arg1;
            while (loc2 != loc1) 
            {
                sHelperMatrix.concat(loc2.transformationMatrix);
                loc2 = loc2._parent;
            }
            sHelperMatrix.invert();
            arg2.concat(sHelperMatrix);
            return arg2;
        }

        public function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            throw new starling.errors.AbstractMethodError();
        }

        public function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!this._visible || !this._touchable) 
            {
                return null;
            }
            if (this._mask && !this.hitTestMask(arg1)) 
            {
                return null;
            }
            if (this.getBounds(this, sHelperRect).containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public function hitTestMask(arg1:flash.geom.Point):Boolean
        {
            var loc1:*=null;
            if (this._mask) 
            {
                if (this._mask.stage) 
                {
                    this.getTransformationMatrix(this._mask, sHelperMatrixAlt);
                }
                else 
                {
                    sHelperMatrixAlt.copyFrom(this._mask.transformationMatrix);
                    sHelperMatrixAlt.invert();
                }
                loc1 = arg1 != sHelperPoint ? sHelperPoint : new flash.geom.Point();
                starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, loc1);
                return !(this._mask.hitTest(loc1) == null);
            }
            return true;
        }

        public function localToGlobal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this.is3D) 
            {
                sHelperPoint3D.setTo(arg1.x, arg1.y, 0);
                return this.local3DToGlobal(sHelperPoint3D, arg2);
            }
            this.getTransformationMatrix(this.base, sHelperMatrixAlt);
            return starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, arg2);
        }

        public function globalToLocal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this.is3D) 
            {
                this.globalToLocal3D(arg1, sHelperPoint3D);
                this.stage.getCameraPosition(this, sHelperPointAlt3D);
                return starling.utils.MathUtil.intersectLineWithXYPlane(sHelperPointAlt3D, sHelperPoint3D, arg2);
            }
            this.getTransformationMatrix(this.base, sHelperMatrixAlt);
            sHelperMatrixAlt.invert();
            return starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, arg2);
        }

        public function render(arg1:starling.rendering.Painter):void
        {
            throw new starling.errors.AbstractMethodError();
        }

        public function alignPivot(arg1:String="center", arg2:String="center"):void
        {
            var loc1:*=this.getBounds(this, sHelperRect);
            this.setOrientationChanged();
            if (arg1 != starling.utils.Align.LEFT) 
            {
                if (arg1 != starling.utils.Align.CENTER) 
                {
                    if (arg1 != starling.utils.Align.RIGHT) 
                    {
                        throw new ArgumentError("Invalid horizontal alignment: " + arg1);
                    }
                    else 
                    {
                        this._pivotX = loc1.x + loc1.width;
                    }
                }
                else 
                {
                    this._pivotX = loc1.x + loc1.width / 2;
                }
            }
            else 
            {
                this._pivotX = loc1.x;
            }
            if (arg2 != starling.utils.Align.TOP) 
            {
                if (arg2 != starling.utils.Align.CENTER) 
                {
                    if (arg2 != starling.utils.Align.BOTTOM) 
                    {
                        throw new ArgumentError("Invalid vertical alignment: " + arg2);
                    }
                    else 
                    {
                        this._pivotY = loc1.y + loc1.height;
                    }
                }
                else 
                {
                    this._pivotY = loc1.y + loc1.height / 2;
                }
            }
            else 
            {
                this._pivotY = loc1.y;
            }
            return;
        }

        public function getTransformationMatrix3D(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg2) 
            {
                arg2.identity();
            }
            else 
            {
                arg2 = new flash.geom.Matrix3D();
            }
            if (arg1 == this) 
            {
                return arg2;
            }
            if (arg1 == this._parent || arg1 == null && this._parent == null) 
            {
                arg2.copyFrom(this.transformationMatrix3D);
                return arg2;
            }
            if (arg1 == null || arg1 == this.base) 
            {
                loc2 = this;
                while (loc2 != arg1) 
                {
                    arg2.append(loc2.transformationMatrix3D);
                    loc2 = loc2._parent;
                }
                return arg2;
            }
            if (arg1._parent == this) 
            {
                arg1.getTransformationMatrix3D(this, arg2);
                arg2.invert();
                return arg2;
            }
            loc1 = findCommonParent(this, arg1);
            loc2 = this;
            while (loc2 != loc1) 
            {
                arg2.append(loc2.transformationMatrix3D);
                loc2 = loc2._parent;
            }
            if (loc1 == arg1) 
            {
                return arg2;
            }
            sHelperMatrix3D.identity();
            loc2 = arg1;
            while (loc2 != loc1) 
            {
                sHelperMatrix3D.append(loc2.transformationMatrix3D);
                loc2 = loc2._parent;
            }
            sHelperMatrix3D.invert();
            arg2.append(sHelperMatrix3D);
            return arg2;
        }

        public function local3DToGlobal(arg1:flash.geom.Vector3D, arg2:flash.geom.Point=null):flash.geom.Point
        {
            var loc1:*=this.stage;
            if (loc1 == null) 
            {
                throw new flash.errors.IllegalOperationError("Object not connected to stage");
            }
            this.getTransformationMatrix3D(loc1, sHelperMatrixAlt3D);
            starling.utils.MatrixUtil.transformPoint3D(sHelperMatrixAlt3D, arg1, sHelperPoint3D);
            return starling.utils.MathUtil.intersectLineWithXYPlane(loc1.cameraPosition, sHelperPoint3D, arg2);
        }

        public function globalToLocal3D(arg1:flash.geom.Point, arg2:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            var loc1:*=this.stage;
            if (loc1 == null) 
            {
                throw new flash.errors.IllegalOperationError("Object not connected to stage");
            }
            this.getTransformationMatrix3D(loc1, sHelperMatrixAlt3D);
            sHelperMatrixAlt3D.invert();
            return starling.utils.MatrixUtil.transformCoords3D(sHelperMatrixAlt3D, arg1.x, arg1.y, 0, arg2);
        }

        starling_internal function setParent(arg1:starling.display.DisplayObjectContainer):void
        {
            var loc1:*=arg1;
            while (!(loc1 == this) && !(loc1 == null)) 
            {
                loc1 = loc1._parent;
            }
            if (loc1 == this) 
            {
                throw new ArgumentError("An object cannot be added as a child to itself or one " + "of its children (or children\'s children, etc.)");
            }
            this._parent = arg1;
            return;
        }

        function setIs3D(arg1:Boolean):void
        {
            this._is3D = arg1;
            return;
        }

        function get isMask():Boolean
        {
            return !(this._maskee == null);
        }

        public function setRequiresRedraw():void
        {
            var loc1:*=this._parent || this._maskee;
            var loc2:*=starling.core.Starling.frameID;
            this._lastParentOrSelfChangeFrameID = loc2;
            this._hasVisibleArea = !(this._alpha == 0) && this._visible && this._maskee == null && !(this._scaleX == 0) && !(this._scaleY == 0);
            while (loc1 && !(loc1._lastChildChangeFrameID == loc2)) 
            {
                loc1._lastChildChangeFrameID = loc2;
                loc1 = loc1._parent || loc1._maskee;
            }
            return;
        }

        public function get requiresRedraw():Boolean
        {
            var loc1:*=starling.core.Starling.frameID;
            return this._lastParentOrSelfChangeFrameID == loc1 || this._lastChildChangeFrameID == loc1;
        }

        starling_internal function excludeFromCache():void
        {
            var loc1:*=this;
            var loc2:*=4294967295;
            while (loc1 && !(loc1._tokenFrameID == loc2)) 
            {
                loc1._tokenFrameID = loc2;
                loc1 = loc1._parent;
            }
            return;
        }

        internal function setOrientationChanged():void
        {
            this._orientationChanged = true;
            this.setRequiresRedraw();
            return;
        }

        public override function dispatchEvent(arg1:starling.events.Event):void
        {
            if (arg1.type == starling.events.Event.REMOVED_FROM_STAGE && this.stage == null) 
            {
                return;
            }
            super.dispatchEvent(arg1);
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && !hasEventListener(arg1)) 
            {
                this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                if (this.stage) 
                {
                    this.addEnterFrameListenerToStage();
                }
            }
            super.addEventListener(arg1, arg2);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function):void
        {
            super.removeEventListener(arg1, arg2);
            if (arg1 == starling.events.Event.ENTER_FRAME && !hasEventListener(arg1)) 
            {
                this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            return;
        }

        public override function removeEventListeners(arg1:String=null):void
        {
            if ((arg1 == null || arg1 == starling.events.Event.ENTER_FRAME) && hasEventListener(starling.events.Event.ENTER_FRAME)) 
            {
                this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            super.removeEventListeners(arg1);
            return;
        }

        internal function addEnterFrameListenerToStage():void
        {
            starling.core.Starling.current.stage.addEnterFrameListener(this);
            return;
        }

        internal function removeEnterFrameListenerFromStage():void
        {
            starling.core.Starling.current.stage.removeEnterFrameListener(this);
            return;
        }

        public function get transformationMatrix():flash.geom.Matrix
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            if (this._orientationChanged) 
            {
                this._orientationChanged = false;
                if (this._skewX == 0 && this._skewY == 0) 
                {
                    if (this._rotation != 0) 
                    {
                        loc1 = Math.cos(this._rotation);
                        loc2 = Math.sin(this._rotation);
                        loc3 = this._scaleX * loc1;
                        loc4 = this._scaleX * loc2;
                        loc5 = this._scaleY * (-loc2);
                        loc6 = this._scaleY * loc1;
                        loc7 = this._x - this._pivotX * loc3 - this._pivotY * loc5;
                        loc8 = this._y - this._pivotX * loc4 - this._pivotY * loc6;
                        this._transformationMatrix.setTo(loc3, loc4, loc5, loc6, loc7, loc8);
                    }
                    else 
                    {
                        this._transformationMatrix.setTo(this._scaleX, 0, 0, this._scaleY, this._x - this._pivotX * this._scaleX, this._y - this._pivotY * this._scaleY);
                    }
                }
                else 
                {
                    this._transformationMatrix.identity();
                    this._transformationMatrix.scale(this._scaleX, this._scaleY);
                    starling.utils.MatrixUtil.skew(this._transformationMatrix, this._skewX, this._skewY);
                    this._transformationMatrix.rotate(this._rotation);
                    this._transformationMatrix.translate(this._x, this._y);
                    if (!(this._pivotX == 0) || !(this._pivotY == 0)) 
                    {
                        this._transformationMatrix.tx = this._x - this._transformationMatrix.a * this._pivotX - this._transformationMatrix.c * this._pivotY;
                        this._transformationMatrix.ty = this._y - this._transformationMatrix.b * this._pivotX - this._transformationMatrix.d * this._pivotY;
                    }
                }
            }
            return this._transformationMatrix;
        }

        public function set transformationMatrix(arg1:flash.geom.Matrix):void
        {
            var loc1:*=Math.PI / 4;
            this.setRequiresRedraw();
            this._orientationChanged = false;
            this._transformationMatrix.copyFrom(arg1);
            var loc2:*;
            this._pivotY = loc2 = 0;
            this._pivotX = loc2;
            this._x = arg1.tx;
            this._y = arg1.ty;
            this._skewX = Math.atan((-arg1.c) / arg1.d);
            this._skewY = Math.atan(arg1.b / arg1.a);
            if (this._skewX != this._skewX) 
            {
                this._skewX = 0;
            }
            if (this._skewY != this._skewY) 
            {
                this._skewY = 0;
            }
            this._scaleY = this._skewX > -loc1 && this._skewX < loc1 ? arg1.d / Math.cos(this._skewX) : (-arg1.c) / Math.sin(this._skewX);
            this._scaleX = this._skewY > -loc1 && this._skewY < loc1 ? arg1.a / Math.cos(this._skewY) : arg1.b / Math.sin(this._skewY);
            if (starling.utils.MathUtil.isEquivalent(this._skewX, this._skewY)) 
            {
                this._rotation = this._skewX;
                this._skewY = loc2 = 0;
                this._skewX = loc2;
            }
            else 
            {
                this._rotation = 0;
            }
            return;
        }

        public function get transformationMatrix3D():flash.geom.Matrix3D
        {
            if (this._transformationMatrix3D == null) 
            {
                this._transformationMatrix3D = new flash.geom.Matrix3D();
            }
            return starling.utils.MatrixUtil.convertTo3D(this.transformationMatrix, this._transformationMatrix3D);
        }

        public function get parent():starling.display.DisplayObjectContainer
        {
            return this._parent;
        }

        public function get useHandCursor():Boolean
        {
            return this._useHandCursor;
        }

        public function set useHandCursor(arg1:Boolean):void
        {
            if (arg1 == this._useHandCursor) 
            {
                return;
            }
            this._useHandCursor = arg1;
            if (this._useHandCursor) 
            {
                this.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            else 
            {
                this.removeEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            flash.ui.Mouse.cursor = arg1.interactsWith(this) ? flash.ui.MouseCursor.BUTTON : flash.ui.MouseCursor.AUTO;
            return;
        }

        public function get bounds():flash.geom.Rectangle
        {
            return this.getBounds(this._parent);
        }

        public function get width():Number
        {
            return this.getBounds(this._parent, sHelperRect).width;
        }

        public function set width(arg1:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=!(this._scaleX == this._scaleX);
            if (this._scaleX == 0 || loc2) 
            {
                this.scaleX = 1;
                loc1 = this.width;
            }
            else 
            {
                loc1 = Math.abs(this.width / this._scaleX);
            }
            if (loc1) 
            {
                this.scaleX = arg1 / loc1;
            }
            return;
        }

        public function get height():Number
        {
            return this.getBounds(this._parent, sHelperRect).height;
        }

        public function set height(arg1:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=!(this._scaleY == this._scaleY);
            if (this._scaleY == 0 || loc2) 
            {
                this.scaleY = 1;
                loc1 = this.height;
            }
            else 
            {
                loc1 = Math.abs(this.height / this._scaleY);
            }
            if (loc1) 
            {
                this.scaleY = arg1 / loc1;
            }
            return;
        }

        public function get x():Number
        {
            return this._x;
        }

        public function set x(arg1:Number):void
        {
            if (this._x != arg1) 
            {
                this._x = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get y():Number
        {
            return this._y;
        }

        public function set y(arg1:Number):void
        {
            if (this._y != arg1) 
            {
                this._y = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get pivotX():Number
        {
            return this._pivotX;
        }

        public function set pivotX(arg1:Number):void
        {
            if (this._pivotX != arg1) 
            {
                this._pivotX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get pivotY():Number
        {
            return this._pivotY;
        }

        public function set pivotY(arg1:Number):void
        {
            if (this._pivotY != arg1) 
            {
                this._pivotY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get scaleX():Number
        {
            return this._scaleX;
        }

        public function set scaleX(arg1:Number):void
        {
            if (this._scaleX != arg1) 
            {
                this._scaleX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get scaleY():Number
        {
            return this._scaleY;
        }

        public function set scaleY(arg1:Number):void
        {
            if (this._scaleY != arg1) 
            {
                this._scaleY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        internal var _x:Number;

        internal var _y:Number;

        internal var _pivotX:Number;

        internal var _pivotY:Number;

        internal var _scaleX:Number;

        internal var _scaleY:Number;

        internal var _skewX:Number;

        internal var _skewY:Number;

        internal var _rotation:Number;

        internal var _alpha:Number;

        internal var _visible:Boolean;

        internal var _touchable:Boolean;

        internal var _blendMode:String;

        internal var _useHandCursor:Boolean;

        internal var _transformationMatrix:flash.geom.Matrix;

        internal var _transformationMatrix3D:flash.geom.Matrix3D;

        internal var _orientationChanged:Boolean;

        internal var _is3D:Boolean;

        internal var _maskee:starling.display.DisplayObject;

        var _parent:starling.display.DisplayObjectContainer;

        var _lastParentOrSelfChangeFrameID:uint;

        var _lastChildChangeFrameID:uint;

        var _tokenFrameID:uint;

        var _pushToken:starling.rendering.BatchToken;

        var _popToken:starling.rendering.BatchToken;

        var _hasVisibleArea:Boolean;

        var _filter:starling.filters.FragmentFilter;

        var _mask:starling.display.DisplayObject;

        internal static var sHelperPoint:flash.geom.Point;

        internal static var sHelperPoint3D:flash.geom.Vector3D;

        internal static var sHelperPointAlt3D:flash.geom.Vector3D;

        internal static var sHelperRect:flash.geom.Rectangle;

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperMatrixAlt:flash.geom.Matrix;

        internal static var sHelperMatrix3D:flash.geom.Matrix3D;

        internal static var sHelperMatrixAlt3D:flash.geom.Matrix3D;

        internal var _name:String;

        internal static var sAncestors:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


//    class DisplayObjectContainer
package starling.display 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class DisplayObjectContainer extends starling.display.DisplayObject
    {
        public function DisplayObjectContainer()
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.display::DisplayObjectContainer") 
            {
                throw new starling.errors.AbstractClassError();
            }
            this._children = new Vector.<starling.display.DisplayObject>(0);
            return;
        }

        internal static function mergeSort(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Function, arg3:int, arg4:int, arg5:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            if (arg4 > 1) 
            {
                loc2 = arg3 + arg4;
                loc3 = arg4 / 2;
                loc4 = arg3;
                loc5 = arg3 + loc3;
                mergeSort(arg1, arg2, arg3, loc3, arg5);
                mergeSort(arg1, arg2, arg3 + loc3, arg4 - loc3, arg5);
                loc1 = 0;
                while (loc1 < arg4) 
                {
                    if (loc4 < arg3 + loc3 && (loc5 == loc2 || arg2(arg1[loc4], arg1[loc5]) <= 0)) 
                    {
                        arg5[loc1] = arg1[loc4];
                        ++loc4;
                    }
                    else 
                    {
                        arg5[loc1] = arg1[loc5];
                        ++loc5;
                    }
                    ++loc1;
                }
                loc1 = arg3;
                while (loc1 < loc2) 
                {
                    arg1[loc1] = arg5[int(loc1 - arg3)];
                    ++loc1;
                }
            }
            return;
        }

        
        {
            sHelperMatrix = new flash.geom.Matrix();
            sHelperPoint = new flash.geom.Point();
            sBroadcastListeners = new Vector.<starling.display.DisplayObject>(0);
            sSortBuffer = new Vector.<starling.display.DisplayObject>(0);
            sCacheToken = new starling.rendering.BatchToken();
        }

        public override function dispose():void
        {
            var loc1:*=(this._children.length - 1);
            while (loc1 >= 0) 
            {
                this._children[loc1].dispose();
                --loc1;
            }
            super.dispose();
            return;
        }

        public function addChild(arg1:starling.display.DisplayObject):starling.display.DisplayObject
        {
            return this.addChildAt(arg1, this._children.length);
        }

        public function addChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=this._children.length;
            if (arg2 >= 0 && arg2 <= loc1) 
            {
                setRequiresRedraw();
                if (arg1.parent != this) 
                {
                    this._children.insertAt(arg2, arg1);
                    arg1.removeFromParent();
                    arg1.starling_internal::setParent(this);
                    arg1.dispatchEventWith(starling.events.Event.ADDED, true);
                    if (stage) 
                    {
                        loc2 = arg1 as starling.display.DisplayObjectContainer;
                        if (loc2) 
                        {
                            loc2.broadcastEventWith(starling.events.Event.ADDED_TO_STAGE);
                        }
                        else 
                        {
                            arg1.dispatchEventWith(starling.events.Event.ADDED_TO_STAGE);
                        }
                    }
                }
                else 
                {
                    this.setChildIndex(arg1, arg2);
                }
                return arg1;
            }
            throw new RangeError("Invalid child index");
        }

        public function removeChild(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=this.getChildIndex(arg1);
            if (loc1 != -1) 
            {
                return this.removeChildAt(loc1, arg2);
            }
            return null;
        }

        public function removeChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 >= 0 && arg1 < this._children.length) 
            {
                setRequiresRedraw();
                loc1 = this._children[arg1];
                loc1.dispatchEventWith(starling.events.Event.REMOVED, true);
                if (stage) 
                {
                    loc2 = loc1 as starling.display.DisplayObjectContainer;
                    if (loc2) 
                    {
                        loc2.broadcastEventWith(starling.events.Event.REMOVED_FROM_STAGE);
                    }
                    else 
                    {
                        loc1.dispatchEventWith(starling.events.Event.REMOVED_FROM_STAGE);
                    }
                }
                loc1.starling_internal::setParent(null);
                arg1 = this._children.indexOf(loc1);
                if (arg1 >= 0) 
                {
                    this._children.removeAt(arg1);
                }
                if (arg2) 
                {
                    loc1.dispose();
                }
                return loc1;
            }
            throw new RangeError("Invalid child index");
        }

        public function removeChildren(arg1:int=0, arg2:int=-1, arg3:Boolean=false):void
        {
            if (arg2 < 0 || arg2 >= this.numChildren) 
            {
                arg2 = (this.numChildren - 1);
            }
            var loc1:*=arg1;
            while (loc1 <= arg2) 
            {
                this.removeChildAt(arg1, arg3);
                ++loc1;
            }
            return;
        }

        public function getChildAt(arg1:int):starling.display.DisplayObject
        {
            var loc1:*=this._children.length;
            if (arg1 < 0) 
            {
                arg1 = loc1 + arg1;
            }
            if (arg1 >= 0 && arg1 < loc1) 
            {
                return this._children[arg1];
            }
            throw new RangeError("Invalid child index");
        }

        public function getChildByName(arg1:String):starling.display.DisplayObject
        {
            var loc1:*=this._children.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._children[loc2].name == arg1) 
                {
                    return this._children[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getChildIndex(arg1:starling.display.DisplayObject):int
        {
            return this._children.indexOf(arg1);
        }

        public function setChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            var loc1:*=this.getChildIndex(arg1);
            if (loc1 == arg2) 
            {
                return;
            }
            if (loc1 == -1) 
            {
                throw new ArgumentError("Not a child of this container");
            }
            this._children.removeAt(loc1);
            this._children.insertAt(arg2, arg1);
            setRequiresRedraw();
            return;
        }

        public function swapChildren(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            var loc1:*=this.getChildIndex(arg1);
            var loc2:*=this.getChildIndex(arg2);
            if (loc1 == -1 || loc2 == -1) 
            {
                throw new ArgumentError("Not a child of this container");
            }
            this.swapChildrenAt(loc1, loc2);
            return;
        }

        public function swapChildrenAt(arg1:int, arg2:int):void
        {
            var loc1:*=this.getChildAt(arg1);
            var loc2:*=this.getChildAt(arg2);
            this._children[arg1] = loc2;
            this._children[arg2] = loc1;
            setRequiresRedraw();
            return;
        }

        public function sortChildren(arg1:Function):void
        {
            sSortBuffer.length = this._children.length;
            mergeSort(this._children, arg1, 0, this._children.length, sSortBuffer);
            sSortBuffer.length = 0;
            setRequiresRedraw();
            return;
        }

        public function contains(arg1:starling.display.DisplayObject):Boolean
        {
            while (arg1) 
            {
                if (arg1 == this) 
                {
                    return true;
                }
                arg1 = arg1.parent;
            }
            return false;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc1:*=this._children.length;
            if (loc1 != 0) 
            {
                if (loc1 != 1) 
                {
                    loc2 = Number.MAX_VALUE;
                    loc3 = -Number.MAX_VALUE;
                    loc4 = Number.MAX_VALUE;
                    loc5 = -Number.MAX_VALUE;
                    loc6 = 0;
                    while (loc6 < loc1) 
                    {
                        this._children[loc6].getBounds(arg1, arg2);
                        if (loc2 > arg2.x) 
                        {
                            loc2 = arg2.x;
                        }
                        if (loc3 < arg2.right) 
                        {
                            loc3 = arg2.right;
                        }
                        if (loc4 > arg2.y) 
                        {
                            loc4 = arg2.y;
                        }
                        if (loc5 < arg2.bottom) 
                        {
                            loc5 = arg2.bottom;
                        }
                        ++loc6;
                    }
                    arg2.setTo(loc2, loc4, loc3 - loc2, loc5 - loc4);
                }
                else 
                {
                    this._children[0].getBounds(arg1, arg2);
                }
            }
            else 
            {
                getTransformationMatrix(arg1, sHelperMatrix);
                starling.utils.MatrixUtil.transformCoords(sHelperMatrix, 0, 0, sHelperPoint);
                arg2.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc6:*=null;
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            var loc1:*=null;
            var loc2:*=arg1.x;
            var loc3:*=arg1.y;
            var loc4:*=this._children.length;
            var loc5:*;
            --loc5;
            while (loc5 >= 0) 
            {
                loc6 = this._children[loc5];
                if (!loc6.isMask) 
                {
                    sHelperMatrix.copyFrom(loc6.transformationMatrix);
                    sHelperMatrix.invert();
                    starling.utils.MatrixUtil.transformCoords(sHelperMatrix, loc2, loc3, sHelperPoint);
                    loc1 = loc6.hitTest(sHelperPoint);
                    if (loc1) 
                    {
                        return this._touchGroup ? this : loc1;
                    }
                }
                --loc5;
            }
            return null;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=this._children.length;
            var loc2:*=arg1.frameID;
            var loc3:*=!(loc2 == 0);
            var loc4:*=_lastParentOrSelfChangeFrameID == loc2;
            var loc5:*=0;
            while (loc5 < loc1) 
            {
                loc6 = this._children[loc5];
                if (loc6._hasVisibleArea) 
                {
                    if (loc4) 
                    {
                        loc6._lastParentOrSelfChangeFrameID = loc2;
                    }
                    if (!(loc6._lastParentOrSelfChangeFrameID == loc2) && !(loc6._lastChildChangeFrameID == loc2) && loc6._tokenFrameID == (loc2 - 1) && loc3) 
                    {
                        arg1.pushState(sCacheToken);
                        arg1.drawFromCache(loc6._pushToken, loc6._popToken);
                        arg1.popState(loc6._popToken);
                        loc6._pushToken.copyFrom(sCacheToken);
                    }
                    else 
                    {
                        loc7 = loc3 ? loc6._pushToken : null;
                        loc8 = loc3 ? loc6._popToken : null;
                        loc9 = loc6._filter;
                        loc10 = loc6._mask;
                        arg1.pushState(loc7);
                        arg1.setStateTo(loc6.transformationMatrix, loc6.alpha, loc6.blendMode);
                        if (loc10) 
                        {
                            arg1.drawMask(loc10, loc6);
                        }
                        if (loc9) 
                        {
                            loc9.render(arg1);
                        }
                        else 
                        {
                            loc6.render(arg1);
                        }
                        if (loc10) 
                        {
                            arg1.eraseMask(loc10, loc6);
                        }
                        arg1.popState(loc8);
                    }
                    if (loc3) 
                    {
                        loc6._tokenFrameID = loc2;
                    }
                }
                ++loc5;
            }
            return;
        }

        public function broadcastEvent(arg1:starling.events.Event):void
        {
            if (arg1.bubbles) 
            {
                throw new ArgumentError("Broadcast of bubbling events is prohibited");
            }
            var loc1:*=sBroadcastListeners.length;
            this.getChildEventListeners(this, arg1.type, sBroadcastListeners);
            var loc2:*=sBroadcastListeners.length;
            var loc3:*=loc1;
            while (loc3 < loc2) 
            {
                sBroadcastListeners[loc3].dispatchEvent(arg1);
                ++loc3;
            }
            sBroadcastListeners.length = loc1;
            return;
        }

        public function broadcastEventWith(arg1:String, arg2:Object=null):void
        {
            var loc1:*=starling.events.Event.starling_internal::fromPool(arg1, false, arg2);
            this.broadcastEvent(loc1);
            starling.events.Event.starling_internal::toPool(loc1);
            return;
        }

        public function get numChildren():int
        {
            return this._children.length;
        }

        public function get touchGroup():Boolean
        {
            return this._touchGroup;
        }

        public function set touchGroup(arg1:Boolean):void
        {
            this._touchGroup = arg1;
            return;
        }

        function getChildEventListeners(arg1:starling.display.DisplayObject, arg2:String, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=arg1 as starling.display.DisplayObjectContainer;
            if (arg1.hasEventListener(arg2)) 
            {
                arg3[arg3.length] = arg1;
            }
            if (loc1) 
            {
                loc2 = loc1._children;
                loc3 = loc2.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    this.getChildEventListeners(loc2[loc4], arg2, arg3);
                    ++loc4;
                }
            }
            return;
        }

        internal var _children:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _touchGroup:Boolean;

        internal static var sBroadcastListeners:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal static var sSortBuffer:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal static var sCacheToken:starling.rendering.BatchToken;

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperPoint:flash.geom.Point;
    }
}


//    class Image
package starling.display 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.rendering.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Image extends starling.display.Quad
    {
        public function Image(arg1:starling.textures.Texture)
        {
            super(100, 100);
            this.texture = arg1;
            readjustSize();
            return;
        }

        public function get scale9Grid():flash.geom.Rectangle
        {
            return this._scale9Grid;
        }

        public function set scale9Grid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._scale9Grid != null) 
                {
                    this._scale9Grid.copyFrom(arg1);
                }
                else 
                {
                    this._scale9Grid = arg1.clone();
                }
                readjustSize();
                this._tileGrid = null;
            }
            else 
            {
                this._scale9Grid = null;
            }
            this.setupVertices();
            return;
        }

        public function get tileGrid():flash.geom.Rectangle
        {
            return this._tileGrid;
        }

        public function set tileGrid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._tileGrid != null) 
                {
                    this._tileGrid.copyFrom(arg1);
                }
                else 
                {
                    this._tileGrid = arg1.clone();
                }
                this._scale9Grid = null;
            }
            else 
            {
                this._tileGrid = null;
            }
            this.setupVertices();
            return;
        }

        protected override function setupVertices():void
        {
            if (texture && this._scale9Grid) 
            {
                this.setupScale9Grid();
            }
            else if (texture && this._tileGrid) 
            {
                this.setupTileGrid();
            }
            else 
            {
                super.setupVertices();
            }
            return;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                if (this._scale9Grid && arg1) 
                {
                    readjustSize();
                }
            }
            return;
        }

        internal function setupScale9Grid():void
        {
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=NaN;
            var loc18:*=0;
            var loc19:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=scaleX > 0 ? scaleX : -scaleX;
            var loc4:*=scaleY > 0 ? scaleY : -scaleY;
            if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.width, loc1.frameWidth)) 
            {
                loc4 = loc4 / loc3;
            }
            else if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.height, loc1.frameHeight)) 
            {
                loc3 = loc3 / loc4;
            }
            var loc5:*=1 / loc3;
            var loc6:*=1 / loc4;
            var loc7:*=this.vertexData;
            var loc8:*=this.indexData;
            var loc9:*=loc7.numVertices;
            var loc13:*=starling.utils.Pool.getRectangle();
            var loc14:*=starling.utils.Pool.getRectangle();
            var loc15:*=starling.utils.Pool.getRectangle();
            var loc16:*=starling.utils.Pool.getRectangle();
            loc13.copyFrom(this._scale9Grid);
            loc14.setTo(0, 0, loc1.frameWidth, loc1.frameHeight);
            if (loc2) 
            {
                loc15.setTo(-loc2.x, -loc2.y, loc1.width, loc1.height);
            }
            else 
            {
                loc15.copyFrom(loc14);
            }
            starling.utils.RectangleUtil.intersect(loc13, loc15, loc16);
            var loc20:*;
            sBasCols[2] = loc20 = 0;
            sBasCols[0] = loc20;
            sBasRows[2] = loc20 = 0;
            sBasRows[0] = loc20;
            sBasCols[1] = loc16.width;
            sBasRows[1] = loc16.height;
            if (loc15.x < loc13.x) 
            {
                sBasCols[0] = loc13.x - loc15.x;
            }
            if (loc15.y < loc13.y) 
            {
                sBasRows[0] = loc13.y - loc15.y;
            }
            if (loc15.right > loc13.right) 
            {
                sBasCols[2] = loc15.right - loc13.right;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sBasRows[2] = loc15.bottom - loc13.bottom;
            }
            if (loc15.x < loc13.x) 
            {
                sPadding.left = loc15.x * loc5;
            }
            else 
            {
                sPadding.left = loc13.x * loc5 + loc15.x - loc13.x;
            }
            if (loc15.right > loc13.right) 
            {
                sPadding.right = (loc14.width - loc15.right) * loc5;
            }
            else 
            {
                sPadding.right = (loc14.width - loc13.right) * loc5 + loc13.right - loc15.right;
            }
            if (loc15.y < loc13.y) 
            {
                sPadding.top = loc15.y * loc6;
            }
            else 
            {
                sPadding.top = loc13.y * loc6 + loc15.y - loc13.y;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sPadding.bottom = (loc14.height - loc15.bottom) * loc6;
            }
            else 
            {
                sPadding.bottom = (loc14.height - loc13.bottom) * loc6 + loc13.bottom - loc15.bottom;
            }
            sPosCols[0] = sBasCols[0] * loc5;
            sPosCols[2] = sBasCols[2] * loc5;
            sPosCols[1] = loc14.width - sPadding.left - sPadding.right - sPosCols[0] - sPosCols[2];
            sPosRows[0] = sBasRows[0] * loc6;
            sPosRows[2] = sBasRows[2] * loc6;
            sPosRows[1] = loc14.height - sPadding.top - sPadding.bottom - sPosRows[0] - sPosRows[2];
            if (sPosCols[1] <= 0) 
            {
                loc12 = loc14.width / (loc14.width - loc13.width) * loc3;
                sPadding.left = sPadding.left * loc12;
                sPosCols[0] = sPosCols[0] * loc12;
                sPosCols[1] = 0;
                sPosCols[2] = sPosCols[2] * loc12;
            }
            if (sPosRows[1] <= 0) 
            {
                loc12 = loc14.height / (loc14.height - loc13.height) * loc4;
                sPadding.top = sPadding.top * loc12;
                sPosRows[0] = sPosRows[0] * loc12;
                sPosRows[1] = 0;
                sPosRows[2] = sPosRows[2] * loc12;
            }
            sTexCols[0] = sBasCols[0] / loc15.width;
            sTexCols[2] = sBasCols[2] / loc15.width;
            sTexCols[1] = 1 - sTexCols[0] - sTexCols[2];
            sTexRows[0] = sBasRows[0] / loc15.height;
            sTexRows[2] = sBasRows[2] / loc15.height;
            sTexRows[1] = 1 - sTexRows[0] - sTexRows[2];
            loc10 = this.setupScale9GridAttributes(sPadding.left, sPadding.top, sPosCols, sPosRows, sTexCols, sTexRows);
            loc11 = loc10 / 4;
            loc7.numVertices = loc10;
            loc8.numIndices = 0;
            var loc17:*=0;
            while (loc17 < loc11) 
            {
                loc8.addQuad(loc17 * 4, loc17 * 4 + 1, loc17 * 4 + 2, loc17 * 4 + 3);
                ++loc17;
            }
            if (loc10 != loc9) 
            {
                loc18 = loc9 ? loc7.getColor(0) : 16777215;
                loc19 = loc9 ? loc7.getAlpha(0) : 1;
                loc7.colorize("color", loc18, loc19);
            }
            starling.utils.Pool.putRectangle(loc14);
            starling.utils.Pool.putRectangle(loc15);
            starling.utils.Pool.putRectangle(loc13);
            starling.utils.Pool.putRectangle(loc16);
            setRequiresRedraw();
            return;
        }

        internal function setupScale9GridAttributes(arg1:Number, arg2:Number, arg3:__AS3__.vec.Vector.<Number>, arg4:__AS3__.vec.Vector.<Number>, arg5:__AS3__.vec.Vector.<Number>, arg6:__AS3__.vec.Vector.<Number>):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc9:*=this.vertexData;
            var loc10:*=this.texture;
            var loc11:*=arg1;
            var loc12:*=arg2;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            loc3 = 0;
            while (loc3 < 3) 
            {
                loc6 = arg4[loc3];
                loc8 = arg6[loc3];
                if (loc6 > 0) 
                {
                    loc4 = 0;
                    while (loc4 < 3) 
                    {
                        loc5 = arg3[loc4];
                        loc7 = arg5[loc4];
                        if (loc5 > 0) 
                        {
                            loc9.setPoint(loc15, loc1, loc11, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14 + loc8);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14 + loc8);
                            ++loc15;
                            loc11 = loc11 + loc5;
                        }
                        loc13 = loc13 + loc7;
                        ++loc4;
                    }
                    loc12 = loc12 + loc6;
                }
                loc11 = arg1;
                loc13 = 0;
                loc14 = loc14 + loc8;
                ++loc3;
            }
            return loc15;
        }

        internal function setupTileGrid():void
        {
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc31:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=this.vertexData;
            var loc4:*=this.indexData;
            var loc5:*=getBounds(this, sBounds);
            var loc6:*=loc3.numVertices;
            var loc7:*=loc6 ? loc3.getColor(0) : 16777215;
            var loc8:*=loc6 ? loc3.getAlpha(0) : 1;
            var loc9:*=scaleX > 0 ? 1 / scaleX : -1 / scaleX;
            var loc10:*=scaleY > 0 ? 1 / scaleY : -1 / scaleY;
            var loc11:*=this._tileGrid.width > 0 ? this._tileGrid.width : loc1.frameWidth;
            var loc12:*=this._tileGrid.height > 0 ? this._tileGrid.height : loc1.frameHeight;
            loc11 = loc11 * loc9;
            loc12 = loc12 * loc10;
            var loc13:*=loc2 ? (-loc2.x) * loc11 / loc2.width : 0;
            var loc14:*=loc2 ? (-loc2.y) * loc12 / loc2.height : 0;
            var loc15:*=loc1.width * loc11 / loc1.frameWidth;
            var loc16:*=loc1.height * loc12 / loc1.frameHeight;
            var loc17:*=this._tileGrid.x * loc9 % loc11;
            var loc18:*=this._tileGrid.y * loc10 % loc12;
            if (loc17 < 0) 
            {
                loc17 = loc17 + loc11;
            }
            if (loc18 < 0) 
            {
                loc18 = loc18 + loc12;
            }
            var loc19:*=loc17 + loc13;
            var loc20:*=loc18 + loc14;
            if (loc19 > loc11 - loc15) 
            {
                loc19 = loc19 - loc11;
            }
            if (loc20 > loc12 - loc16) 
            {
                loc20 = loc20 - loc12;
            }
            var loc29:*="position";
            var loc30:*="texCoords";
            var loc32:*=loc20;
            var loc33:*=0;
            loc4.numIndices = 0;
            while (loc32 < loc5.height) 
            {
                loc31 = loc19;
                while (loc31 < loc5.width) 
                {
                    loc4.addQuad(loc33, loc33 + 1, loc33 + 2, loc33 + 3);
                    loc21 = loc31 < 0 ? 0 : loc31;
                    loc23 = loc32 < 0 ? 0 : loc32;
                    loc22 = loc31 + loc15 > loc5.width ? loc5.width : loc31 + loc15;
                    loc24 = loc32 + loc16 > loc5.height ? loc5.height : loc32 + loc16;
                    loc3.setPoint(loc33, loc29, loc21, loc23);
                    loc3.setPoint(loc33 + 1, loc29, loc22, loc23);
                    loc3.setPoint(loc33 + 2, loc29, loc21, loc24);
                    loc3.setPoint(loc33 + 3, loc29, loc22, loc24);
                    loc25 = (loc21 - loc31) / loc15;
                    loc27 = (loc23 - loc32) / loc16;
                    loc26 = (loc22 - loc31) / loc15;
                    loc28 = (loc24 - loc32) / loc16;
                    loc1.setTexCoords(loc3, loc33, loc30, loc25, loc27);
                    loc1.setTexCoords(loc3, loc33 + 1, loc30, loc26, loc27);
                    loc1.setTexCoords(loc3, loc33 + 2, loc30, loc25, loc28);
                    loc1.setTexCoords(loc3, loc33 + 3, loc30, loc26, loc28);
                    loc31 = loc31 + loc11;
                    loc33 = loc33 + 4;
                }
                loc32 = loc32 + loc12;
            }
            loc3.numVertices = loc33;
            var loc34:*=loc6;
            while (loc34 < loc33) 
            {
                loc3.setColor(loc34, "color", loc7);
                loc3.setAlpha(loc34, "color", loc8);
                ++loc34;
            }
            setRequiresRedraw();
            return;
        }

        
        {
            sPadding = new starling.utils.Padding();
            sBounds = new flash.geom.Rectangle();
            sBasCols = new Vector.<Number>(3, true);
            sBasRows = new Vector.<Number>(3, true);
            sPosCols = new Vector.<Number>(3, true);
            sPosRows = new Vector.<Number>(3, true);
            sTexCols = new Vector.<Number>(3, true);
            sTexRows = new Vector.<Number>(3, true);
        }

        internal var _scale9Grid:flash.geom.Rectangle;

        internal var _tileGrid:flash.geom.Rectangle;

        internal static var sPadding:starling.utils.Padding;

        internal static var sBounds:flash.geom.Rectangle;

        internal static var sBasCols:__AS3__.vec.Vector.<Number>;

        internal static var sBasRows:__AS3__.vec.Vector.<Number>;

        internal static var sPosCols:__AS3__.vec.Vector.<Number>;

        internal static var sPosRows:__AS3__.vec.Vector.<Number>;

        internal static var sTexCols:__AS3__.vec.Vector.<Number>;

        internal static var sTexRows:__AS3__.vec.Vector.<Number>;
    }
}


//    class Mesh
package starling.display 
{
    import flash.geom.*;
    import starling.core.*;
    import starling.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Mesh extends starling.display.DisplayObject
    {
        public function Mesh(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:starling.styles.MeshStyle=null)
        {
            super();
            if (arg1 == null) 
            {
                throw new ArgumentError("VertexData must not be null");
            }
            if (arg2 == null) 
            {
                throw new ArgumentError("IndexData must not be null");
            }
            this._vertexData = arg1;
            this._indexData = arg2;
            this.setStyle(arg3, false);
            return;
        }

        public static function get defaultStyleFactory():Function
        {
            return sDefaultStyleFactory;
        }

        public static function set defaultStyleFactory(arg1:Function):void
        {
            sDefaultStyleFactory = arg1;
            return;
        }

        public static function fromPolygon(arg1:starling.geom.Polygon, arg2:starling.styles.MeshStyle=null):starling.display.Mesh
        {
            var loc1:*=new starling.rendering.VertexData(null, arg1.numVertices);
            var loc2:*=new starling.rendering.IndexData(arg1.numTriangles);
            arg1.copyToVertexData(loc1);
            arg1.triangulate(loc2);
            return new Mesh(loc1, loc2, arg2);
        }

        
        {
            sDefaultStyle = starling.styles.MeshStyle;
            sDefaultStyleFactory = null;
        }

        public override function dispose():void
        {
            this._vertexData.clear();
            this._indexData.clear();
            super.dispose();
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            return starling.utils.MeshUtil.containsPoint(this._vertexData, this._indexData, arg1) ? this : null;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            return starling.utils.MeshUtil.calculateBounds(this._vertexData, this, arg1, arg2);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            arg1.batchMesh(this);
            return;
        }

        public function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            if (arg1 != null) 
            {
                if (arg1 == this._style) 
                {
                    return;
                }
                if (arg1.target) 
                {
                    arg1.target.setStyle();
                }
            }
            else 
            {
                arg1 = this.createDefaultMeshStyle();
            }
            if (this._style) 
            {
                if (arg2) 
                {
                    arg1.copyFrom(this._style);
                }
                this._style.starling_internal::setTarget(null);
            }
            this._style = arg1;
            this._style.starling_internal::setTarget(this, this._vertexData, this._indexData);
            return;
        }

        internal function createDefaultMeshStyle():starling.styles.MeshStyle
        {
            var loc1:*=null;
            if (sDefaultStyleFactory != null) 
            {
                if (sDefaultStyleFactory.length != 0) 
                {
                    loc1 = sDefaultStyleFactory(this);
                }
                else 
                {
                    loc1 = sDefaultStyleFactory();
                }
            }
            if (loc1 == null) 
            {
                loc1 = new sDefaultStyle() as starling.styles.MeshStyle;
            }
            return loc1;
        }

        public function setVertexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function setIndexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function getVertexPosition(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getVertexPosition(arg1, arg2);
        }

        public function setVertexPosition(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setVertexPosition(arg1, arg2, arg3);
            return;
        }

        public function getVertexAlpha(arg1:int):Number
        {
            return this._style.getVertexAlpha(arg1);
        }

        public function setVertexAlpha(arg1:int, arg2:Number):void
        {
            this._style.setVertexAlpha(arg1, arg2);
            return;
        }

        public function getVertexColor(arg1:int):uint
        {
            return this._style.getVertexColor(arg1);
        }

        public function setVertexColor(arg1:int, arg2:uint):void
        {
            this._style.setVertexColor(arg1, arg2);
            return;
        }

        public function getTexCoords(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getTexCoords(arg1, arg2);
        }

        public function setTexCoords(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setTexCoords(arg1, arg2, arg3);
            return;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            return this._indexData;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            this.setStyle(arg1);
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._style.texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            this._style.texture = arg1;
            return;
        }

        public function get color():uint
        {
            return this._style.color;
        }

        public function set color(arg1:uint):void
        {
            this._style.color = arg1;
            return;
        }

        public function get textureSmoothing():String
        {
            return this._style.textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            this._style.textureSmoothing = arg1;
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._style.textureRepeat;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._style.textureRepeat = arg1;
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            this._pixelSnapping = arg1;
            return;
        }

        public function get numVertices():int
        {
            return this._vertexData.numVertices;
        }

        public function get numIndices():int
        {
            return this._indexData.numIndices;
        }

        public function get numTriangles():int
        {
            return this._indexData.numTriangles;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return this._style.vertexFormat;
        }

        public static function get defaultStyle():Class
        {
            return sDefaultStyle;
        }

        public static function set defaultStyle(arg1:Class):void
        {
            sDefaultStyle = arg1;
            return;
        }

        var _style:starling.styles.MeshStyle;

        var _vertexData:starling.rendering.VertexData;

        var _indexData:starling.rendering.IndexData;

        var _pixelSnapping:Boolean;

        internal static var sDefaultStyle:Class;

        internal static var sDefaultStyleFactory:Function=null;
    }
}


//    class MeshBatch
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class MeshBatch extends starling.display.Mesh
    {
        public function MeshBatch()
        {
            var loc1:*=new starling.rendering.VertexData();
            var loc2:*=new starling.rendering.IndexData();
            super(loc1, loc2);
            return;
        }

        public override function dispose():void
        {
            if (this._effect) 
            {
                this._effect.dispose();
            }
            super.dispose();
            return;
        }

        public override function setVertexDataChanged():void
        {
            this._vertexSyncRequired = true;
            super.setVertexDataChanged();
            return;
        }

        public override function setIndexDataChanged():void
        {
            this._indexSyncRequired = true;
            super.setIndexDataChanged();
            return;
        }

        internal function setVertexAndIndexDataChanged():void
        {
            var loc1:*;
            this._indexSyncRequired = loc1 = true;
            this._vertexSyncRequired = loc1;
            return;
        }

        internal function syncVertexBuffer():void
        {
            this._effect.uploadVertexData(_vertexData);
            this._vertexSyncRequired = false;
            return;
        }

        internal function syncIndexBuffer():void
        {
            this._effect.uploadIndexData(_indexData);
            this._indexSyncRequired = false;
            return;
        }

        public function clear():void
        {
            if (_parent) 
            {
                setRequiresRedraw();
            }
            _vertexData.numVertices = 0;
            _indexData.numIndices = 0;
            this._vertexSyncRequired = true;
            this._indexSyncRequired = true;
            return;
        }

        public function addMesh(arg1:starling.display.Mesh, arg2:flash.geom.Matrix=null, arg3:Number=1, arg4:starling.utils.MeshSubset=null, arg5:Boolean=false):void
        {
            if (arg5) 
            {
                arg2 = null;
            }
            else if (arg2 == null) 
            {
                arg2 = arg1.transformationMatrix;
            }
            if (arg4 == null) 
            {
                arg4 = sFullMeshSubset;
            }
            var loc1:*=_vertexData.numVertices;
            var loc2:*=_indexData.numIndices;
            var loc3:*=arg1._style;
            if (loc1 == 0) 
            {
                this.setupFor(arg1);
            }
            loc3.batchVertexData(_style, loc1, arg2, arg4.vertexID, arg4.numVertices);
            loc3.batchIndexData(_style, loc2, loc1 - arg4.vertexID, arg4.indexID, arg4.numIndices);
            if (arg3 != 1) 
            {
                _vertexData.scaleAlphas("color", arg3, loc1, arg4.numVertices);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc4:*;
            this._vertexSyncRequired = loc4 = true;
            this._indexSyncRequired = loc4;
            return;
        }

        public function addMeshAt(arg1:starling.display.Mesh, arg2:int, arg3:int):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.numVertices;
            var loc3:*=arg1.transformationMatrix;
            var loc4:*=arg1._style;
            if (_vertexData.numVertices == 0) 
            {
                this.setupFor(arg1);
            }
            loc4.batchVertexData(_style, arg3, loc3, 0, loc2);
            loc4.batchIndexData(_style, arg2, arg3, 0, loc1);
            if (alpha != 1) 
            {
                _vertexData.scaleAlphas("color", alpha, arg3, loc2);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc5:*;
            this._vertexSyncRequired = loc5 = true;
            this._indexSyncRequired = loc5;
            return;
        }

        internal function setupFor(arg1:starling.display.Mesh):void
        {
            var loc1:*=arg1._style;
            var loc2:*=loc1.type;
            if (_style.type != loc2) 
            {
                this.setStyle(new loc2() as starling.styles.MeshStyle, false);
            }
            _style.copyFrom(loc1);
            return;
        }

        public function canAddMesh(arg1:starling.display.Mesh, arg2:int=-1):Boolean
        {
            var loc1:*=_vertexData.numVertices;
            if (loc1 == 0) 
            {
                return true;
            }
            if (arg2 < 0) 
            {
                arg2 = arg1.numVertices;
            }
            if (arg2 == 0) 
            {
                return true;
            }
            if (arg2 + loc1 > MAX_NUM_VERTICES) 
            {
                return false;
            }
            return _style.canBatchWith(arg1._style);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (_vertexData.numVertices == 0) 
            {
                return;
            }
            if (_pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            if (this._batchable) 
            {
                arg1.batchMesh(this);
            }
            else 
            {
                arg1.finishMeshBatch();
                arg1.drawCount = arg1.drawCount + 1;
                arg1.prepareToDraw();
                arg1.excludeFromCache(this);
                if (this._vertexSyncRequired) 
                {
                    this.syncVertexBuffer();
                }
                if (this._indexSyncRequired) 
                {
                    this.syncIndexBuffer();
                }
                _style.updateEffect(this._effect, arg1.state);
                this._effect.render(0, _indexData.numTriangles);
            }
            return;
        }

        public override function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            super.setStyle(arg1, arg2);
            if (this._effect) 
            {
                this._effect.dispose();
            }
            this._effect = style.createEffect();
            this._effect.onRestore = this.setVertexAndIndexDataChanged;
            return;
        }

        public function set numVertices(arg1:int):void
        {
            if (_vertexData.numVertices != arg1) 
            {
                _vertexData.numVertices = arg1;
                this._vertexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function set numIndices(arg1:int):void
        {
            if (_indexData.numIndices != arg1) 
            {
                _indexData.numIndices = arg1;
                this._indexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function get batchable():Boolean
        {
            return this._batchable;
        }

        public function set batchable(arg1:Boolean):void
        {
            if (this._batchable != arg1) 
            {
                this._batchable = arg1;
                setRequiresRedraw();
            }
            return;
        }

        
        {
            sFullMeshSubset = new starling.utils.MeshSubset();
        }

        public static const MAX_NUM_VERTICES:int=65535;

        internal var _effect:starling.rendering.MeshEffect;

        internal var _batchable:Boolean;

        internal var _vertexSyncRequired:Boolean;

        internal var _indexSyncRequired:Boolean;

        internal static var sFullMeshSubset:starling.utils.MeshSubset;
    }
}


//    class MovieClip
package starling.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.media.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.textures.*;
    
    public class MovieClip extends starling.display.Image implements starling.animation.IAnimatable
    {
        public function MovieClip(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number=12)
        {
            if (arg1.length > 0) 
            {
                super(arg1[0]);
                this.init(arg1, arg2);
            }
            else 
            {
                throw new ArgumentError("Empty texture array");
            }
            return;
        }

        public function set muted(arg1:Boolean):void
        {
            this._muted = arg1;
            return;
        }

        public function get soundTransform():flash.media.SoundTransform
        {
            return this._soundTransform;
        }

        public function set soundTransform(arg1:flash.media.SoundTransform):void
        {
            this._soundTransform = arg1;
            return;
        }

        public function get currentFrame():int
        {
            return this._currentFrameID;
        }

        internal function init(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number):void
        {
            if (arg2 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg2);
            }
            var loc1:*=arg1.length;
            this._defaultFrameDuration = 1 / arg2;
            this._loop = true;
            this._playing = true;
            this._currentTime = 0;
            this._currentFrameID = 0;
            this._wasStopped = true;
            this._frames = new Vector.<MovieClipFrame>(0);
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this._frames[loc2] = new MovieClipFrame(arg1[loc2], this._defaultFrameDuration, this._defaultFrameDuration * loc2);
                ++loc2;
            }
            return;
        }

        public function set currentFrame(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this.currentTime = this._frames[arg1].startTime;
            return;
        }

        public function get fps():Number
        {
            return 1 / this._defaultFrameDuration;
        }

        public function set fps(arg1:Number):void
        {
            if (arg1 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg1);
            }
            var loc1:*=1 / arg1;
            var loc2:*=loc1 / this._defaultFrameDuration;
            this._currentTime = this._currentTime * loc2;
            this._defaultFrameDuration = loc1;
            var loc3:*=0;
            while (loc3 < this.numFrames) 
            {
                this._frames[loc3].duration = this._frames[loc3].duration * loc2;
                ++loc3;
            }
            this.updateStartTimes();
            return;
        }

        public function get isPlaying():Boolean
        {
            if (this._playing) 
            {
                return this._loop || this._currentTime < this.totalTime;
            }
            return false;
        }

        public function get isComplete():Boolean
        {
            return !this._loop && this._currentTime >= this.totalTime;
        }

        public function addFrame(arg1:starling.textures.Texture, arg2:flash.media.Sound=null, arg3:Number=-1):void
        {
            this.addFrameAt(this.numFrames, arg1, arg2, arg3);
            return;
        }

        public function addFrameAt(arg1:int, arg2:starling.textures.Texture, arg3:flash.media.Sound=null, arg4:Number=-1):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg1 < 0 || arg1 > this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (arg4 < 0) 
            {
                arg4 = this._defaultFrameDuration;
            }
            var loc1:*=new MovieClipFrame(arg2, arg4);
            loc1.sound = arg3;
            this._frames.insertAt(arg1, loc1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            else 
            {
                loc2 = arg1 > 0 ? this._frames[(arg1 - 1)].startTime : 0;
                loc3 = arg1 > 0 ? this._frames[(arg1 - 1)].duration : 0;
                loc1.startTime = loc2 + loc3;
            }
            return;
        }

        public function removeFrameAt(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (this.numFrames == 1) 
            {
                throw new flash.errors.IllegalOperationError("Movie clip must not be empty");
            }
            this._frames.removeAt(arg1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            return;
        }

        public function getFrameTexture(arg1:int):starling.textures.Texture
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].texture;
        }

        public function setFrameTexture(arg1:int, arg2:starling.textures.Texture):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].texture = arg2;
            return;
        }

        public function getFrameSound(arg1:int):flash.media.Sound
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].sound;
        }

        public function setFrameSound(arg1:int, arg2:flash.media.Sound):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].sound = arg2;
            return;
        }

        public function getFrameAction(arg1:int):Function
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].action;
        }

        public function setFrameAction(arg1:int, arg2:Function):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].action = arg2;
            return;
        }

        public function getFrameDuration(arg1:int):Number
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].duration;
        }

        public function setFrameDuration(arg1:int, arg2:Number):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].duration = arg2;
            this.updateStartTimes();
            return;
        }

        public function reverseFrames():void
        {
            this._frames.reverse();
            this._currentTime = this.totalTime - this._currentTime;
            this._currentFrameID = (this.numFrames - this._currentFrameID - 1);
            this.updateStartTimes();
            return;
        }

        public function play():void
        {
            this._playing = true;
            return;
        }

        public function pause():void
        {
            this._playing = false;
            return;
        }

        public function stop():void
        {
            this._playing = false;
            this._wasStopped = true;
            this.currentFrame = 0;
            return;
        }

        internal function updateStartTimes():void
        {
            var loc1:*=this.numFrames;
            var loc2:*=this._frames[0];
            loc2.startTime = 0;
            var loc3:*=1;
            while (loc3 < loc1) 
            {
                this._frames[loc3].startTime = loc2.startTime + loc2.duration;
                loc2 = this._frames[loc3];
                ++loc3;
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc7:*=false;
            if (!this._playing) 
            {
                return;
            }
            var loc1:*=this._frames[this._currentFrameID];
            if (this._wasStopped) 
            {
                this._wasStopped = false;
                loc1.playSound(this._soundTransform);
                if (loc1.action != null) 
                {
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
            }
            if (this._currentTime == this.totalTime) 
            {
                if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc1 = this._frames[0];
                    loc1.playSound(this._soundTransform);
                    texture = loc1.texture;
                    if (loc1.action != null) 
                    {
                        loc1.executeAction(this, this._currentFrameID);
                        this.advanceTime(arg1);
                        return;
                    }
                }
                else 
                {
                    return;
                }
            }
            var loc2:*=(this._frames.length - 1);
            var loc3:*=loc1.duration - this._currentTime + loc1.startTime;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=this._currentFrameID;
            while (arg1 >= loc3) 
            {
                loc7 = false;
                arg1 = arg1 - loc3;
                this._currentTime = loc1.startTime + loc1.duration;
                if (this._currentFrameID != loc2) 
                {
                    this._currentFrameID = this._currentFrameID + 1;
                    loc7 = true;
                }
                else if (hasEventListener(starling.events.Event.COMPLETE)) 
                {
                    loc4 = true;
                }
                else if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc7 = true;
                }
                else 
                {
                    return;
                }
                loc1 = this._frames[this._currentFrameID];
                loc5 = loc1.action;
                if (loc7) 
                {
                    loc1.playSound(this._soundTransform);
                }
                if (loc4) 
                {
                    texture = loc1.texture;
                    dispatchEventWith(starling.events.Event.COMPLETE);
                    this.advanceTime(arg1);
                    return;
                }
                if (loc5 != null) 
                {
                    texture = loc1.texture;
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
                loc3 = loc1.duration;
                if (!(arg1 + 0.0001 > loc3 && arg1 - 0.0001 < loc3)) 
                {
                    continue;
                }
                arg1 = loc3;
            }
            if (loc6 != this._currentFrameID) 
            {
                texture = this._frames[this._currentFrameID].texture;
            }
            this._currentTime = this._currentTime + arg1;
            return;
        }

        public function get numFrames():int
        {
            return this._frames.length;
        }

        public function get totalTime():Number
        {
            var loc1:*=this._frames[(this._frames.length - 1)];
            return loc1.startTime + loc1.duration;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function set currentTime(arg1:Number):void
        {
            if (arg1 < 0 || arg1 > this.totalTime) 
            {
                throw new ArgumentError("Invalid time: " + arg1);
            }
            var loc1:*=(this._frames.length - 1);
            this._currentTime = arg1;
            this._currentFrameID = 0;
            while (this._currentFrameID < loc1 && this._frames[this._currentFrameID + 1].startTime <= arg1) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this)._currentFrameID + 1);
                loc3._currentFrameID = loc4;
            }
            var loc2:*=this._frames[this._currentFrameID];
            texture = loc2.texture;
            return;
        }

        public function get loop():Boolean
        {
            return this._loop;
        }

        public function set loop(arg1:Boolean):void
        {
            this._loop = arg1;
            return;
        }

        public function get muted():Boolean
        {
            return this._muted;
        }

        internal var _frames:__AS3__.vec.Vector.<MovieClipFrame>;

        internal var _defaultFrameDuration:Number;

        internal var _currentTime:Number;

        internal var _currentFrameID:int;

        internal var _playing:Boolean;

        internal var _muted:Boolean;

        internal var _wasStopped:Boolean;

        internal var _soundTransform:flash.media.SoundTransform;

        internal var _loop:Boolean;
    }
}

import flash.media.*;
import starling.textures.*;


class MovieClipFrame extends Object
{
    public function MovieClipFrame(arg1:starling.textures.Texture, arg2:Number=0.1, arg3:Number=0)
    {
        super();
        this.texture = arg1;
        this.duration = arg2;
        this.startTime = arg3;
        return;
    }

    public function playSound(arg1:flash.media.SoundTransform):void
    {
        if (this.sound) 
        {
            this.sound.play(0, 0, arg1);
        }
        return;
    }

    public function executeAction(arg1:starling.display.MovieClip, arg2:int):void
    {
        var loc1:*=0;
        if (this.action != null) 
        {
            loc1 = this.action.length;
            if (loc1 != 0) 
            {
                if (loc1 != 1) 
                {
                    if (loc1 != 2) 
                    {
                        throw new Error("Frame actions support zero, one or two parameters: " + "movie:MovieClip, frameID:int");
                    }
                    else 
                    {
                        this.action(arg1, arg2);
                    }
                }
                else 
                {
                    this.action(arg1);
                }
            }
            else 
            {
                this.action();
            }
        }
        return;
    }

    public var texture:starling.textures.Texture;

    public var sound:flash.media.Sound;

    public var duration:Number;

    public var startTime:Number;

    public var action:Function;
}

//    class Quad
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Quad extends starling.display.Mesh
    {
        public function Quad(arg1:Number, arg2:Number, arg3:uint=16777215)
        {
            this._bounds = new flash.geom.Rectangle(0, 0, arg1, arg2);
            var loc1:*=new starling.rendering.VertexData(starling.styles.MeshStyle.VERTEX_FORMAT, 4);
            var loc2:*=new starling.rendering.IndexData(6);
            super(loc1, loc2);
            if (arg1 == 0 || arg2 == 0) 
            {
                throw new ArgumentError("Invalid size: width and height must not be zero");
            }
            this.setupVertices();
            this.color = arg3;
            return;
        }

        protected function setupVertices():void
        {
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc3:*=style.texture;
            var loc4:*=this.vertexData;
            var loc5:*=this.indexData;
            loc5.numIndices = 0;
            loc5.addQuad(0, 1, 2, 3);
            if (loc4.numVertices != 4) 
            {
                loc4.numVertices = 4;
                loc4.trim();
            }
            if (loc3) 
            {
                loc3.setupVertexPositions(loc4, 0, "position", this._bounds);
                loc3.setupTextureCoordinates(loc4, 0, loc2);
            }
            else 
            {
                loc4.setPoint(0, loc1, this._bounds.left, this._bounds.top);
                loc4.setPoint(1, loc1, this._bounds.right, this._bounds.top);
                loc4.setPoint(2, loc1, this._bounds.left, this._bounds.bottom);
                loc4.setPoint(3, loc1, this._bounds.right, this._bounds.bottom);
                loc4.setPoint(0, loc2, 0, 0);
                loc4.setPoint(1, loc2, 1, 0);
                loc4.setPoint(2, loc2, 0, 1);
                loc4.setPoint(3, loc2, 1, 1);
            }
            setRequiresRedraw();
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            if (arg1 != this) 
            {
                if (arg1 == parent && !isRotated) 
                {
                    loc1 = this.scaleX;
                    loc2 = this.scaleY;
                    arg2.setTo(x - pivotX * loc1, y - pivotY * loc2, this._bounds.width * loc1, this._bounds.height * loc2);
                    if (loc1 < 0) 
                    {
                        arg2.width = arg2.width * -1;
                        arg2.x = arg2.x - arg2.width;
                    }
                    if (loc2 < 0) 
                    {
                        arg2.height = arg2.height * -1;
                        arg2.y = arg2.y - arg2.height;
                    }
                }
                else if (is3D && stage) 
                {
                    stage.getCameraPosition(arg1, sPoint3D);
                    getTransformationMatrix3D(arg1, sMatrix3D);
                    starling.utils.RectangleUtil.getBoundsProjected(this._bounds, sMatrix3D, sPoint3D, arg2);
                }
                else 
                {
                    getTransformationMatrix(arg1, sMatrix);
                    starling.utils.RectangleUtil.getBounds(this._bounds, sMatrix, arg2);
                }
            }
            else 
            {
                arg2.copyFrom(this._bounds);
            }
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            if (this._bounds.containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public function readjustSize(arg1:Number=-1, arg2:Number=-1):void
        {
            if (arg1 <= 0) 
            {
                arg1 = texture ? texture.frameWidth : this._bounds.width;
            }
            if (arg2 <= 0) 
            {
                arg2 = texture ? texture.frameHeight : this._bounds.height;
            }
            if (!(arg1 == this._bounds.width) || !(arg2 == this._bounds.height)) 
            {
                this._bounds.setTo(0, 0, arg1, arg2);
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                this.setupVertices();
            }
            return;
        }

        public static function fromTexture(arg1:starling.textures.Texture):starling.display.Quad
        {
            var loc1:*=new Quad(100, 100);
            loc1.texture = arg1;
            loc1.readjustSize();
            return loc1;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal var _bounds:flash.geom.Rectangle;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


//    class Sprite
package starling.display 
{
    public class Sprite extends starling.display.DisplayObjectContainer
    {
        public function Sprite()
        {
            super();
            return;
        }
    }
}


//    class Stage
package starling.display 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Stage extends starling.display.DisplayObjectContainer
    {
        public function Stage(arg1:int, arg2:int, arg3:uint=0)
        {
            super();
            this._width = arg1;
            this._height = arg2;
            this._color = arg3;
            this._fieldOfView = 1;
            this._projectionOffset = new flash.geom.Point();
            this._cameraPosition = new flash.geom.Vector3D();
            this._enterFrameEvent = new starling.events.EnterFrameEvent(starling.events.Event.ENTER_FRAME, 0);
            this._enterFrameListeners = new Vector.<starling.display.DisplayObject>(0);
            return;
        }

        public function get focalLength():Number
        {
            return this._width / (2 * Math.tan(this._fieldOfView / 2));
        }

        public function set focalLength(arg1:Number):void
        {
            this._fieldOfView = 2 * Math.atan(this.stageWidth / (2 * arg1));
            return;
        }

        public function get fieldOfView():Number
        {
            return this._fieldOfView;
        }

        public function set fieldOfView(arg1:Number):void
        {
            this._fieldOfView = arg1;
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable) 
            {
                return null;
            }
            if (arg1.x < 0 || arg1.x > this._width || arg1.y < 0 || arg1.y > this._height) 
            {
                return null;
            }
            var loc1:*=super.hitTest(arg1);
            return loc1 ? loc1 : this;
        }

        public function get projectionOffset():flash.geom.Point
        {
            return this._projectionOffset;
        }

        public function set projectionOffset(arg1:flash.geom.Point):void
        {
            this._projectionOffset.setTo(arg1.x, arg1.y);
            return;
        }

        public function get cameraPosition():flash.geom.Vector3D
        {
            return this.getCameraPosition(null, this._cameraPosition);
        }

        public function advanceTime(arg1:Number):void
        {
            this._enterFrameEvent.starling_internal::reset(starling.events.Event.ENTER_FRAME, false, arg1);
            broadcastEvent(this._enterFrameEvent);
            return;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        public function drawToBitmapData(arg1:flash.display.BitmapData=null, arg2:Boolean=true):flash.display.BitmapData
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=starling.core.Starling.painter;
            var loc2:*=loc1.state;
            var loc3:*=loc1.context;
            if (arg1 == null) 
            {
                loc4 = loc3.backBufferWidth;
                loc5 = loc3.backBufferHeight;
                arg1 = new flash.display.BitmapData(loc4, loc5, arg2);
            }
            loc1.pushState();
            loc2.renderTarget = null;
            loc2.setProjectionMatrix(0, 0, this._width, this._height, this._width, this._height, this.cameraPosition);
            if (arg2) 
            {
                loc1.clear();
            }
            else 
            {
                loc1.clear(this._color, 1);
            }
            render(loc1);
            loc1.finishMeshBatch();
            loc3.drawToBitmapData(arg1);
            loc3.present();
            loc1.popState();
            return arg1;
        }

        public function getStageBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            arg2.setTo(0, 0, this._width, this._height);
            getTransformationMatrix(arg1, sMatrix);
            return starling.utils.RectangleUtil.getBounds(arg2, sMatrix, arg2);
        }

        public function getCameraPosition(arg1:starling.display.DisplayObject=null, arg2:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            getTransformationMatrix3D(arg1, sMatrix3D);
            return starling.utils.MatrixUtil.transformCoords3D(sMatrix3D, this._width / 2 + this._projectionOffset.x, this._height / 2 + this._projectionOffset.y, -this.focalLength, arg2);
        }

        function addEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 < 0) 
            {
                this._enterFrameListeners[this._enterFrameListeners.length] = arg1;
            }
            return;
        }

        function removeEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 >= 0) 
            {
                this._enterFrameListeners.removeAt(loc1);
            }
            return;
        }

        override function getChildEventListeners(arg1:starling.display.DisplayObject, arg2:String, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg2 == starling.events.Event.ENTER_FRAME && arg1 == this) 
            {
                loc1 = 0;
                loc2 = this._enterFrameListeners.length;
                while (loc1 < loc2) 
                {
                    arg3[arg3.length] = this._enterFrameListeners[loc1];
                    ++loc1;
                }
            }
            else 
            {
                super.getChildEventListeners(arg1, arg2, arg3);
            }
            return;
        }

        public override function set width(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set width of stage");
        }

        public override function set height(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set height of stage");
        }

        public override function set x(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set x-coordinate of stage");
        }

        public override function set y(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set y-coordinate of stage");
        }

        public override function set scaleX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set scaleY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set rotation(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot rotate stage");
        }

        public override function set skewX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set skewY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set filter(arg1:starling.filters.FragmentFilter):void
        {
            throw new flash.errors.IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            this._color = arg1;
            return;
        }

        public function get stageWidth():int
        {
            return this._width;
        }

        public function set stageWidth(arg1:int):void
        {
            this._width = arg1;
            return;
        }

        public function get stageHeight():int
        {
            return this._height;
        }

        public function set stageHeight(arg1:int):void
        {
            this._height = arg1;
            return;
        }

        public function get starling():starling.core.Starling
        {
            var loc1:*=starling.core.Starling.all;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (loc1[loc3].stage == this) 
                {
                    return loc1[loc3];
                }
                ++loc3;
            }
            return null;
        }

        internal var _width:int;

        internal var _height:int;

        internal var _color:uint;

        internal var _fieldOfView:Number;

        internal var _cameraPosition:flash.geom.Vector3D;

        internal var _enterFrameEvent:starling.events.EnterFrameEvent;

        internal var _enterFrameListeners:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _projectionOffset:flash.geom.Point;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix:flash.geom.Matrix;
    }
}


//  package errors
//    class AbstractClassError
package starling.errors 
{
    public class AbstractClassError extends Error
    {
        public function AbstractClassError(arg1:*="Cannot instantiate abstract class", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


//    class AbstractMethodError
package starling.errors 
{
    public class AbstractMethodError extends Error
    {
        public function AbstractMethodError(arg1:*="Method needs to be implemented in subclass", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


//    class MissingContextError
package starling.errors 
{
    public class MissingContextError extends Error
    {
        public function MissingContextError(arg1:*="Starling context is missing", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


//    class NotSupportedError
package starling.errors 
{
    public class NotSupportedError extends Error
    {
        public function NotSupportedError(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


//  package events
//    class EnterFrameEvent
package starling.events 
{
    public class EnterFrameEvent extends starling.events.Event
    {
        public function EnterFrameEvent(arg1:String, arg2:Number, arg3:Boolean=false)
        {
            super(arg1, arg3, arg2);
            return;
        }

        public function get passedTime():Number
        {
            return data as Number;
        }

        public static const ENTER_FRAME:String="enterFrame";
    }
}


//    class Event
package starling.events 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Event extends Object
    {
        public function Event(arg1:String, arg2:Boolean=false, arg3:Object=null)
        {
            super();
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            return;
        }

        function setData(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        function get stopsPropagation():Boolean
        {
            return this._stopsPropagation;
        }

        function get stopsImmediatePropagation():Boolean
        {
            return this._stopsImmediatePropagation;
        }

        starling_internal function reset(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            var loc1:*;
            this._currentTarget = loc1 = null;
            this._target = loc1;
            this._stopsImmediatePropagation = loc1 = false;
            this._stopsPropagation = loc1;
            return this;
        }

        starling_internal static function toPool(arg1:starling.events.Event):void
        {
            var loc1:*;
            arg1._currentTarget = loc1 = null;
            arg1._target = loc1 = loc1;
            arg1._data = loc1;
            sEventPool[sEventPool.length] = arg1;
            return;
        }

        public function get target():starling.events.EventDispatcher
        {
            return this._target;
        }

        starling_internal static function fromPool(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            if (sEventPool.length) 
            {
                return sEventPool.pop().reset(arg1, arg2, arg3);
            }
            return new Event(arg1, arg2, arg3);
        }

        public function stopPropagation():void
        {
            this._stopsPropagation = true;
            return;
        }

        public function stopImmediatePropagation():void
        {
            var loc1:*;
            this._stopsImmediatePropagation = loc1 = true;
            this._stopsPropagation = loc1;
            return;
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[{0} type=\"{1}\" bubbles={2}]", flash.utils.getQualifiedClassName(this).split("::").pop(), this._type, this._bubbles);
        }

        public function get bubbles():Boolean
        {
            return this._bubbles;
        }

        
        {
            sEventPool = new Vector.<>(0);
        }

        public function get currentTarget():starling.events.EventDispatcher
        {
            return this._currentTarget;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get data():Object
        {
            return this._data;
        }

        function setTarget(arg1:starling.events.EventDispatcher):void
        {
            this._target = arg1;
            return;
        }

        function setCurrentTarget(arg1:starling.events.EventDispatcher):void
        {
            this._currentTarget = arg1;
            return;
        }

        public static const FATAL_ERROR:String="fatalError";

        public static const READY:String="ready";

        public static const UPDATE:String="update";

        public static const SELECT:String="select";

        public static const ADDED:String="added";

        public static const ADDED_TO_STAGE:String="addedToStage";

        public static const ENTER_FRAME:String="enterFrame";

        public static const REMOVED:String="removed";

        public static const REMOVED_FROM_STAGE:String="removedFromStage";

        public static const TRIGGERED:String="triggered";

        public static const RESIZE:String="resize";

        public static const COMPLETE:String="complete";

        public static const CONTEXT3D_CREATE:String="context3DCreate";

        public static const RENDER:String="render";

        public static const ROOT_CREATED:String="rootCreated";

        public static const REMOVE_FROM_JUGGLER:String="removeFromJuggler";

        public static const TEXTURES_RESTORED:String="texturesRestored";

        public static const IO_ERROR:String="ioError";

        public static const SECURITY_ERROR:String="securityError";

        public static const PARSE_ERROR:String="parseError";

        public static const CHANGE:String="change";

        public static const CANCEL:String="cancel";

        public static const SCROLL:String="scroll";

        public static const OPEN:String="open";

        public static const CLOSE:String="close";

        internal var _target:starling.events.EventDispatcher;

        internal var _currentTarget:starling.events.EventDispatcher;

        internal var _type:String;

        internal var _bubbles:Boolean;

        internal static var sEventPool:__AS3__.vec.Vector.<starling.events.Event>;

        internal var _data:Object;

        internal var _stopsPropagation:Boolean;

        internal var _stopsImmediatePropagation:Boolean;
    }
}


//    class EventDispatcher
package starling.events 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    use namespace starling_internal;
    
    public class EventDispatcher extends Object
    {
        public function EventDispatcher()
        {
            super();
            return;
        }

        public function addEventListener(arg1:String, arg2:Function):void
        {
            if (this._eventListeners == null) 
            {
                this._eventListeners = new flash.utils.Dictionary();
            }
            var loc1:*=this._eventListeners[arg1] as Vector.<Function>;
            if (loc1 != null) 
            {
                if (loc1.indexOf(arg2) == -1) 
                {
                    loc1[loc1.length] = arg2;
                }
            }
            else 
            {
                new Vector.<Function>(1)[0] = arg2;
                this._eventListeners[arg1] = new Vector.<Function>(1);
            }
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            if (this._eventListeners) 
            {
                loc1 = this._eventListeners[arg1] as Vector.<Function>;
                loc2 = loc1 ? loc1.length : 0;
                if (loc2 > 0) 
                {
                    loc3 = loc1.indexOf(arg2);
                    if (loc3 != -1) 
                    {
                        loc4 = loc1.slice(0, loc3);
                        loc5 = loc3 + 1;
                        while (loc5 < loc2) 
                        {
                            loc4[(loc5 - 1)] = loc1[loc5];
                            ++loc5;
                        }
                        this._eventListeners[arg1] = loc4;
                    }
                }
            }
            return;
        }

        public function removeEventListeners(arg1:String=null):void
        {
            if (arg1 && this._eventListeners) 
            {
                delete this._eventListeners[arg1];
            }
            else 
            {
                this._eventListeners = null;
            }
            return;
        }

        public function dispatchEvent(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.bubbles;
            if (!loc1 && (this._eventListeners == null || !(arg1.type in this._eventListeners))) 
            {
                return;
            }
            var loc2:*=arg1.target;
            arg1.setTarget(this);
            if (loc1 && this is starling.display.DisplayObject) 
            {
                this.bubbleEvent(arg1);
            }
            else 
            {
                this.invokeEvent(arg1);
            }
            if (loc2) 
            {
                arg1.setTarget(loc2);
            }
            return;
        }

        function invokeEvent(arg1:starling.events.Event):Boolean
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=this._eventListeners ? this._eventListeners[arg1.type] as Vector.<Function> : null;
            var loc2:*=loc1 != null ? loc1.length : 0;
            if (loc2) 
            {
                arg1.setCurrentTarget(this);
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = loc1[loc3] as Function;
                    loc5 = loc4.length;
                    if (loc5 != 0) 
                    {
                        if (loc5 != 1) 
                        {
                            loc4(arg1, arg1.data);
                        }
                        else 
                        {
                            loc4(arg1);
                        }
                    }
                    else 
                    {
                        loc4();
                    }
                    if (arg1.stopsImmediatePropagation) 
                    {
                        return true;
                    }
                    ++loc3;
                }
                return arg1.stopsPropagation;
            }
            return false;
        }

        function bubbleEvent(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc5:*=false;
            var loc2:*=this as starling.display.DisplayObject;
            var loc3:*=1;
            if (sBubbleChains.length > 0) 
            {
                loc1 = sBubbleChains.pop();
                loc1[0] = loc2;
            }
            else 
            {
                new Vector.<starling.events.EventDispatcher>(1)[0] = loc2;
                loc1 = new Vector.<starling.events.EventDispatcher>(1);
            }
            for (;;) 
            {
                var loc6:*;
                loc2 = loc6 = loc2.parent;
                if (loc6 == null) 
                {
                    break;
                }
                loc1[int(loc3++)] = loc2;
            }
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = loc1[loc4].invokeEvent(arg1);
                if (loc5) 
                {
                    break;
                }
                ++loc4;
            }
            loc1.length = 0;
            sBubbleChains[sBubbleChains.length] = loc1;
            return;
        }

        public function dispatchEventWith(arg1:String, arg2:Boolean=false, arg3:Object=null):void
        {
            var loc1:*=null;
            if (arg2 || this.hasEventListener(arg1)) 
            {
                loc1 = starling.events.Event.starling_internal::fromPool(arg1, arg2, arg3);
                this.dispatchEvent(loc1);
                starling.events.Event.starling_internal::toPool(loc1);
            }
            return;
        }

        public function hasEventListener(arg1:String, arg2:Function=null):Boolean
        {
            var loc1:*=this._eventListeners ? this._eventListeners[arg1] : null;
            if (loc1 == null) 
            {
                return false;
            }
            if (arg2 != null) 
            {
                return !(loc1.indexOf(arg2) == -1);
            }
            return !(loc1.length == 0);
        }

        
        {
            sBubbleChains = [];
        }

        internal var _eventListeners:flash.utils.Dictionary;

        internal static var sBubbleChains:Array;
    }
}


//    class KeyboardEvent
package starling.events 
{
    public class KeyboardEvent extends starling.events.Event
    {
        public function KeyboardEvent(arg1:String, arg2:uint=0, arg3:uint=0, arg4:uint=0, arg5:Boolean=false, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, false, arg3);
            this._charCode = arg2;
            this._keyCode = arg3;
            this._keyLocation = arg4;
            this._ctrlKey = arg5;
            this._altKey = arg6;
            this._shiftKey = arg7;
            return;
        }

        public function preventDefault():void
        {
            this._isDefaultPrevented = true;
            return;
        }

        public function isDefaultPrevented():Boolean
        {
            return this._isDefaultPrevented;
        }

        public function get charCode():uint
        {
            return this._charCode;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function get keyLocation():uint
        {
            return this._keyLocation;
        }

        public function get altKey():Boolean
        {
            return this._altKey;
        }

        public function get ctrlKey():Boolean
        {
            return this._ctrlKey;
        }

        public function get shiftKey():Boolean
        {
            return this._shiftKey;
        }

        public static const KEY_UP:String="keyUp";

        public static const KEY_DOWN:String="keyDown";

        internal var _charCode:uint;

        internal var _keyCode:uint;

        internal var _keyLocation:uint;

        internal var _altKey:Boolean;

        internal var _ctrlKey:Boolean;

        internal var _shiftKey:Boolean;

        internal var _isDefaultPrevented:Boolean;
    }
}


//    class ResizeEvent
package starling.events 
{
    import flash.geom.*;
    
    public class ResizeEvent extends starling.events.Event
    {
        public function ResizeEvent(arg1:String, arg2:int, arg3:int, arg4:Boolean=false)
        {
            super(arg1, arg4, new flash.geom.Point(arg2, arg3));
            return;
        }

        public function get width():int
        {
            return (data as flash.geom.Point).x;
        }

        public function get height():int
        {
            return (data as flash.geom.Point).y;
        }

        public static const RESIZE:String="resize";
    }
}


//    class Touch
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


//    class TouchEvent
package starling.events 
{
    import __AS3__.vec.*;
    import starling.core.*;
    import starling.display.*;
    
    use namespace starling_internal;
    
    public class TouchEvent extends starling.events.Event
    {
        public function TouchEvent(arg1:String, arg2:__AS3__.vec.Vector.<starling.events.Touch>=null, arg3:Boolean=false, arg4:Boolean=false, arg5:Boolean=true)
        {
            super(arg1, arg5, arg2);
            this._shiftKey = arg3;
            this._ctrlKey = arg4;
            this._visitedObjects = new Vector.<starling.events.EventDispatcher>(0);
            this.updateTimestamp(arg2);
            return;
        }

        function resetTo(arg1:String, arg2:__AS3__.vec.Vector.<starling.events.Touch>=null, arg3:Boolean=false, arg4:Boolean=false, arg5:Boolean=true):starling.events.TouchEvent
        {
            super.starling_internal::reset(arg1, arg5, arg2);
            this._shiftKey = arg3;
            this._ctrlKey = arg4;
            this._visitedObjects.length = 0;
            this.updateTimestamp(arg2);
            return this;
        }

        internal function updateTimestamp(arg1:__AS3__.vec.Vector.<starling.events.Touch>):void
        {
            this._timestamp = -1;
            var loc1:*=arg1 ? arg1.length : 0;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (arg1[loc2].timestamp > this._timestamp) 
                {
                    this._timestamp = arg1[loc2].timestamp;
                }
                ++loc2;
            }
            return;
        }

        public function getTouches(arg1:starling.display.DisplayObject, arg2:String=null, arg3:__AS3__.vec.Vector.<starling.events.Touch>=null):__AS3__.vec.Vector.<starling.events.Touch>
        {
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=false;
            if (arg3 == null) 
            {
                arg3 = new Vector.<starling.events.Touch>(0);
            }
            var loc1:*=data as Vector.<starling.events.Touch>;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                loc5 = loc4.isTouching(arg1);
                loc6 = arg2 == null || arg2 == loc4.phase;
                if (loc5 && loc6) 
                {
                    arg3[arg3.length] = loc4;
                }
                ++loc3;
            }
            return arg3;
        }

        public function getTouch(arg1:starling.display.DisplayObject, arg2:String=null, arg3:int=-1):starling.events.Touch
        {
            var loc2:*=null;
            var loc3:*=0;
            this.getTouches(arg1, arg2, sTouches);
            var loc1:*=sTouches.length;
            if (loc1 > 0) 
            {
                loc2 = null;
                if (arg3 < 0) 
                {
                    loc2 = sTouches[0];
                }
                else 
                {
                    loc3 = 0;
                    while (loc3 < loc1) 
                    {
                        if (sTouches[loc3].id == arg3) 
                        {
                            loc2 = sTouches[loc3];
                        }
                        ++loc3;
                    }
                }
                sTouches.length = 0;
                return loc2;
            }
            return null;
        }

        public function interactsWith(arg1:starling.display.DisplayObject):Boolean
        {
            var loc1:*=false;
            this.getTouches(arg1, null, sTouches);
            var loc2:*=(sTouches.length - 1);
            while (loc2 >= 0) 
            {
                if (sTouches[loc2].phase != starling.events.TouchPhase.ENDED) 
                {
                    loc1 = true;
                    break;
                }
                --loc2;
            }
            sTouches.length = 0;
            return loc1;
        }

        function dispatch(arg1:__AS3__.vec.Vector.<starling.events.EventDispatcher>):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=false;
            if (arg1 && arg1.length) 
            {
                loc1 = bubbles ? arg1.length : 1;
                loc2 = target;
                setTarget(arg1[0] as starling.events.EventDispatcher);
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    loc4 = arg1[loc3] as starling.events.EventDispatcher;
                    if (this._visitedObjects.indexOf(loc4) == -1) 
                    {
                        loc5 = loc4.invokeEvent(this);
                        this._visitedObjects[this._visitedObjects.length] = loc4;
                        if (loc5) 
                        {
                            break;
                        }
                    }
                    ++loc3;
                }
                setTarget(loc2);
            }
            return;
        }

        public function get timestamp():Number
        {
            return this._timestamp;
        }

        public function get touches():__AS3__.vec.Vector.<starling.events.Touch>
        {
            return (data as Vector.<starling.events.Touch>).concat();
        }

        public function get shiftKey():Boolean
        {
            return this._shiftKey;
        }

        public function get ctrlKey():Boolean
        {
            return this._ctrlKey;
        }

        
        {
            sTouches = new Vector.<starling.events.Touch>(0);
        }

        public static const TOUCH:String="touch";

        internal var _shiftKey:Boolean;

        internal var _ctrlKey:Boolean;

        internal var _timestamp:Number;

        internal var _visitedObjects:__AS3__.vec.Vector.<starling.events.EventDispatcher>;

        internal static var sTouches:__AS3__.vec.Vector.<starling.events.Touch>;
    }
}


//    class TouchMarker
package starling.events 
{
    import flash.display.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    
    internal class TouchMarker extends starling.display.Sprite
    {
        public function TouchMarker()
        {
            var loc2:*=null;
            super();
            this._center = new flash.geom.Point();
            this._texture = this.createTexture();
            var loc1:*=0;
            while (loc1 < 2) 
            {
                loc2 = new starling.display.Image(this._texture);
                loc2.pivotX = this._texture.width / 2;
                loc2.pivotY = this._texture.height / 2;
                loc2.touchable = false;
                addChild(loc2);
                ++loc1;
            }
            return;
        }

        public override function dispose():void
        {
            this._texture.dispose();
            super.dispose();
            return;
        }

        public function moveMarker(arg1:Number, arg2:Number, arg3:Boolean=false):void
        {
            if (arg3) 
            {
                this._center.x = this._center.x + (arg1 - this.realMarker.x);
                this._center.y = this._center.y + (arg2 - this.realMarker.y);
            }
            this.realMarker.x = arg1;
            this.realMarker.y = arg2;
            this.mockMarker.x = 2 * this._center.x - arg1;
            this.mockMarker.y = 2 * this._center.y - arg2;
            return;
        }

        public function moveCenter(arg1:Number, arg2:Number):void
        {
            this._center.x = arg1;
            this._center.y = arg2;
            this.moveMarker(this.realX, this.realY);
            return;
        }

        internal function createTexture():starling.textures.Texture
        {
            var loc1:*=starling.core.Starling.contentScaleFactor;
            var loc2:*=12 * loc1;
            var loc3:*=32 * loc1;
            var loc4:*=32 * loc1;
            var loc5:*=1.5 * loc1;
            var loc6:*=new flash.display.Shape();
            loc6.graphics.lineStyle(loc5, 0, 0.3);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2 + loc5);
            loc6.graphics.beginFill(16777215, 0.4);
            loc6.graphics.lineStyle(loc5, 16777215);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2);
            loc6.graphics.endFill();
            var loc7:*=new flash.display.BitmapData(loc3, loc4, true, 0);
            loc7.draw(loc6);
            return starling.textures.Texture.fromBitmapData(loc7, false, false, loc1);
        }

        internal function get realMarker():starling.display.Image
        {
            return getChildAt(0) as starling.display.Image;
        }

        internal function get mockMarker():starling.display.Image
        {
            return getChildAt(1) as starling.display.Image;
        }

        public function get realX():Number
        {
            return this.realMarker.x;
        }

        public function get realY():Number
        {
            return this.realMarker.y;
        }

        public function get mockX():Number
        {
            return this.mockMarker.x;
        }

        public function get mockY():Number
        {
            return this.mockMarker.y;
        }

        internal var _center:flash.geom.Point;

        internal var _texture:starling.textures.Texture;
    }
}


//    class TouchPhase
package starling.events 
{
    import starling.errors.*;
    
    public final class TouchPhase extends Object
    {
        public function TouchPhase()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static const HOVER:String="hover";

        public static const BEGAN:String="began";

        public static const MOVED:String="moved";

        public static const STATIONARY:String="stationary";

        public static const ENDED:String="ended";
    }
}


//    class TouchProcessor
package starling.events 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class TouchProcessor extends Object
    {
        public function TouchProcessor(arg1:starling.display.Stage)
        {
            super();
            var loc1:*;
            this._stage = loc1 = arg1;
            this._root = loc1;
            this._elapsedTime = 0;
            this._currentTouches = new Vector.<starling.events.Touch>(0);
            this._queue = new Vector.<Array>(0);
            this._lastTaps = new Vector.<starling.events.Touch>(0);
            this._touchEvent = new starling.events.TouchEvent(starling.events.TouchEvent.TOUCH);
            this._stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.onKey);
            this._stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.onKey);
            this.monitorInterruptions(true);
            return;
        }

        public function set simulateMultitouch(arg1:Boolean):void
        {
            var value:Boolean;
            var target:starling.core.Starling;
            var createTouchMarker:Function;

            var loc1:*;
            target = null;
            createTouchMarker = null;
            value = arg1;
            createTouchMarker = function ():void
            {
                target.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, createTouchMarker);
                if (_touchMarker == null) 
                {
                    _touchMarker = new TouchMarker();
                    _touchMarker.visible = false;
                    _stage.addChild(_touchMarker);
                }
                return;
            }
            if (this.simulateMultitouch == value) 
            {
                return;
            }
            this._simulateMultitouch = value;
            target = starling.core.Starling.current;
            if (value && this._touchMarker == null) 
            {
                if (starling.core.Starling.current.contextValid) 
                {
                    createTouchMarker();
                }
                else 
                {
                    target.addEventListener(starling.events.Event.CONTEXT3D_CREATE, createTouchMarker);
                }
            }
            else if (!value && this._touchMarker) 
            {
                this._touchMarker.removeFromParent(true);
                this._touchMarker = null;
            }
            return;
        }

        public function get multitapTime():Number
        {
            return this._multitapTime;
        }

        public function set multitapTime(arg1:Number):void
        {
            this._multitapTime = arg1;
            return;
        }

        public function get multitapDistance():Number
        {
            return this._multitapDistance;
        }

        internal function updateTapCount(arg1:starling.events.Touch):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc1:*=null;
            var loc2:*=this._multitapDistance * this._multitapDistance;
            var loc5:*=0;
            var loc6:*=this._lastTaps;
            for each (loc3 in loc6) 
            {
                loc4 = Math.pow(loc3.globalX - arg1.globalX, 2) + Math.pow(loc3.globalY - arg1.globalY, 2);
                if (!(loc4 <= loc2)) 
                {
                    continue;
                }
                loc1 = loc3;
                break;
            }
            if (loc1) 
            {
                arg1.tapCount = loc1.tapCount + 1;
                this._lastTaps.removeAt(this._lastTaps.indexOf(loc1));
            }
            else 
            {
                arg1.tapCount = 1;
            }
            this._lastTaps[this._lastTaps.length] = arg1.clone();
            return;
        }

        public function set multitapDistance(arg1:Number):void
        {
            this._multitapDistance = arg1;
            return;
        }

        public function get root():starling.display.DisplayObject
        {
            return this._root;
        }

        public function set root(arg1:starling.display.DisplayObject):void
        {
            this._root = arg1;
            return;
        }

        public function get stage():starling.display.Stage
        {
            return this._stage;
        }

        public function get numCurrentTouches():int
        {
            return this._currentTouches.length;
        }

        internal function onKey(arg1:starling.events.KeyboardEvent):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.keyCode == 17 || arg1.keyCode == 15) 
            {
                loc1 = this._ctrlDown;
                this._ctrlDown = arg1.type == starling.events.KeyboardEvent.KEY_DOWN;
                if (this._touchMarker && !(loc1 == this._ctrlDown)) 
                {
                    this._touchMarker.visible = this._ctrlDown;
                    this._touchMarker.moveCenter(this._stage.stageWidth / 2, this._stage.stageHeight / 2);
                    loc2 = this.getCurrentTouch(0);
                    loc3 = this.getCurrentTouch(1);
                    if (loc2) 
                    {
                        this._touchMarker.moveMarker(loc2.globalX, loc2.globalY);
                    }
                    if (loc1 && loc3 && !(loc3.phase == starling.events.TouchPhase.ENDED)) 
                    {
                        this._queue.unshift([1, starling.events.TouchPhase.ENDED, loc3.globalX, loc3.globalY]);
                    }
                    else if (this._ctrlDown && loc2) 
                    {
                        if (loc2.phase == starling.events.TouchPhase.HOVER || loc2.phase == starling.events.TouchPhase.ENDED) 
                        {
                            this._queue.unshift([1, starling.events.TouchPhase.HOVER, this._touchMarker.mockX, this._touchMarker.mockY]);
                        }
                        else 
                        {
                            this._queue.unshift([1, starling.events.TouchPhase.BEGAN, this._touchMarker.mockX, this._touchMarker.mockY]);
                        }
                    }
                }
            }
            else if (arg1.keyCode == 16) 
            {
                this._shiftDown = arg1.type == starling.events.KeyboardEvent.KEY_DOWN;
            }
            return;
        }

        internal function onInterruption(arg1:Object):void
        {
            this.cancelTouches();
            return;
        }

        
        {
            sUpdatedTouches = new Vector.<starling.events.Touch>(0);
            sHoveringTouchData = new Vector.<Object>(0);
            sHelperPoint = new flash.geom.Point();
        }

        public function dispose():void
        {
            this.monitorInterruptions(false);
            this._stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.onKey);
            this._stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.onKey);
            if (this._touchMarker) 
            {
                this._touchMarker.dispose();
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            this._elapsedTime = this._elapsedTime + arg1;
            sUpdatedTouches.length = 0;
            if (this._lastTaps.length > 0) 
            {
                loc1 = (this._lastTaps.length - 1);
                while (loc1 >= 0) 
                {
                    if (this._elapsedTime - this._lastTaps[loc1].timestamp > this._multitapTime) 
                    {
                        this._lastTaps.removeAt(loc1);
                    }
                    --loc1;
                }
            }
            while (this._queue.length > 0) 
            {
                var loc4:*=0;
                var loc5:*=this._currentTouches;
                for each (loc2 in loc5) 
                {
                    if (!(loc2.phase == starling.events.TouchPhase.BEGAN || loc2.phase == starling.events.TouchPhase.MOVED)) 
                    {
                        continue;
                    }
                    loc2.phase = starling.events.TouchPhase.STATIONARY;
                }
                while (this._queue.length > 0 && !this.containsTouchWithID(sUpdatedTouches, this._queue[(this._queue.length - 1)][0])) 
                {
                    loc3 = this._queue.pop();
                    loc2 = this.createOrUpdateTouch(loc3[0], loc3[1], loc3[2], loc3[3], loc3[4], loc3[5], loc3[6]);
                    sUpdatedTouches[sUpdatedTouches.length] = loc2;
                }
                this.processTouches(sUpdatedTouches, this._shiftDown, this._ctrlDown);
                loc1 = (this._currentTouches.length - 1);
                while (loc1 >= 0) 
                {
                    if (this._currentTouches[loc1].phase == starling.events.TouchPhase.ENDED) 
                    {
                        this._currentTouches.removeAt(loc1);
                    }
                    --loc1;
                }
                sUpdatedTouches.length = 0;
            }
            return;
        }

        protected function processTouches(arg1:__AS3__.vec.Vector.<starling.events.Touch>, arg2:Boolean, arg3:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            sHoveringTouchData.length = 0;
            this._touchEvent.resetTo(starling.events.TouchEvent.TOUCH, this._currentTouches, arg2, arg3);
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc1 in loc4) 
            {
                if (loc1.phase == starling.events.TouchPhase.HOVER && loc1.target) 
                {
                    sHoveringTouchData[sHoveringTouchData.length] = {"touch":loc1, "target":loc1.target, "bubbleChain":loc1.bubbleChain};
                }
                if (!(loc1.phase == starling.events.TouchPhase.HOVER || loc1.phase == starling.events.TouchPhase.BEGAN)) 
                {
                    continue;
                }
                sHelperPoint.setTo(loc1.globalX, loc1.globalY);
                loc1.target = this._root.hitTest(sHelperPoint);
            }
            loc3 = 0;
            loc4 = sHoveringTouchData;
            for each (loc2 in loc4) 
            {
                if (loc2.touch.target == loc2.target) 
                {
                    continue;
                }
                this._touchEvent.dispatch(loc2.bubbleChain);
            }
            loc3 = 0;
            loc4 = arg1;
            for each (loc1 in loc4) 
            {
                loc1.dispatchEvent(this._touchEvent);
            }
            this._touchEvent.resetTo(starling.events.TouchEvent.TOUCH);
            return;
        }

        public function enqueue(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number=1, arg6:Number=1, arg7:Number=1):void
        {
            this._queue.unshift(arguments);
            if (this._ctrlDown && this._touchMarker && arg1 == 0) 
            {
                this._touchMarker.moveMarker(arg3, arg4, this._shiftDown);
                this._queue.unshift([1, arg2, this._touchMarker.mockX, this._touchMarker.mockY]);
            }
            return;
        }

        public function enqueueMouseLeftStage():void
        {
            var loc1:*=this.getCurrentTouch(0);
            if (loc1 == null || !(loc1.phase == starling.events.TouchPhase.HOVER)) 
            {
                return;
            }
            var loc2:*=1;
            var loc3:*=loc1.globalX;
            var loc4:*=loc1.globalY;
            var loc5:*=loc1.globalX;
            var loc6:*=this._stage.stageWidth - loc5;
            var loc7:*=loc1.globalY;
            var loc8:*=this._stage.stageHeight - loc7;
            var loc9:*=Math.min(loc5, loc6, loc7, loc8);
            if (loc9 != loc5) 
            {
                if (loc9 != loc6) 
                {
                    if (loc9 != loc7) 
                    {
                        loc4 = this._stage.stageHeight + loc2;
                    }
                    else 
                    {
                        loc4 = -loc2;
                    }
                }
                else 
                {
                    loc3 = this._stage.stageWidth + loc2;
                }
            }
            else 
            {
                loc3 = -loc2;
            }
            this.enqueue(0, starling.events.TouchPhase.HOVER, loc3, loc4);
            return;
        }

        public function cancelTouches():void
        {
            var loc1:*=null;
            if (this._currentTouches.length > 0) 
            {
                var loc2:*=0;
                var loc3:*=this._currentTouches;
                for each (loc1 in loc3) 
                {
                    if (!(loc1.phase == starling.events.TouchPhase.BEGAN || loc1.phase == starling.events.TouchPhase.MOVED || loc1.phase == starling.events.TouchPhase.STATIONARY)) 
                    {
                        continue;
                    }
                    loc1.phase = starling.events.TouchPhase.ENDED;
                    loc1.cancelled = true;
                }
                this.processTouches(this._currentTouches, this._shiftDown, this._ctrlDown);
            }
            this._currentTouches.length = 0;
            this._queue.length = 0;
            return;
        }

        internal function createOrUpdateTouch(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number=1, arg6:Number=1, arg7:Number=1):starling.events.Touch
        {
            var loc1:*=this.getCurrentTouch(arg1);
            if (loc1 == null) 
            {
                loc1 = new starling.events.Touch(arg1);
                this.addCurrentTouch(loc1);
            }
            loc1.globalX = arg3;
            loc1.globalY = arg4;
            loc1.phase = arg2;
            loc1.timestamp = this._elapsedTime;
            loc1.pressure = arg5;
            loc1.width = arg6;
            loc1.height = arg7;
            if (arg2 == starling.events.TouchPhase.BEGAN) 
            {
                this.updateTapCount(loc1);
            }
            return loc1;
        }

        internal function monitorInterruptions(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                loc1 = flash.utils.getDefinitionByName("flash.desktop::NativeApplication");
                loc2 = loc1["nativeApplication"];
                if (arg1) 
                {
                    loc2.addEventListener("deactivate", this.onInterruption, false, 0, true);
                }
                else 
                {
                    loc2.removeEventListener("deactivate", this.onInterruption);
                }
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function addCurrentTouch(arg1:starling.events.Touch):void
        {
            var loc1:*=(this._currentTouches.length - 1);
            while (loc1 >= 0) 
            {
                if (this._currentTouches[loc1].id == arg1.id) 
                {
                    this._currentTouches.removeAt(loc1);
                }
                --loc1;
            }
            this._currentTouches[this._currentTouches.length] = arg1;
            return;
        }

        internal function getCurrentTouch(arg1:int):starling.events.Touch
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._currentTouches;
            for each (loc1 in loc3) 
            {
                if (loc1.id != arg1) 
                {
                    continue;
                }
                return loc1;
            }
            return null;
        }

        internal function containsTouchWithID(arg1:__AS3__.vec.Vector.<starling.events.Touch>, arg2:int):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for each (loc1 in loc3) 
            {
                if (loc1.id != arg2) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        public function get simulateMultitouch():Boolean
        {
            return this._simulateMultitouch;
        }

        internal var _stage:starling.display.Stage;

        internal var _root:starling.display.DisplayObject;

        internal var _elapsedTime:Number;

        internal var _lastTaps:__AS3__.vec.Vector.<starling.events.Touch>;

        internal var _ctrlDown:Boolean=false;

        internal var _multitapTime:Number=0.3;

        internal var _multitapDistance:Number=25;

        internal var _touchEvent:starling.events.TouchEvent;

        internal var _touchMarker:TouchMarker;

        internal var _simulateMultitouch:Boolean;

        protected var _queue:__AS3__.vec.Vector.<Array>;

        protected var _currentTouches:__AS3__.vec.Vector.<starling.events.Touch>;

        internal static var sUpdatedTouches:__AS3__.vec.Vector.<starling.events.Touch>;

        internal static var sHoveringTouchData:__AS3__.vec.Vector.<Object>;

        internal static var sHelperPoint:flash.geom.Point;

        internal var _shiftDown:Boolean=false;
    }
}


//  package filters
//    class FilterHelper
package starling.filters 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    internal class FilterHelper extends Object implements starling.filters.IFilterHelper
    {
        public function FilterHelper(arg1:String="bgra")
        {
            this.sRegion = new flash.geom.Rectangle();
            super();
            this._usePotTextures = starling.core.Starling.current.profile == flash.display3D.Context3DProfile.BASELINE_CONSTRAINED;
            this._preferredScale = starling.core.Starling.contentScaleFactor;
            this._textureFormat = arg1;
            this._sizeStep = 64;
            this._pool = new Vector.<starling.textures.Texture>(0);
            this._projectionMatrix = new flash.geom.Matrix3D();
            this._targetBounds = new flash.geom.Rectangle();
            this.setSize(this._sizeStep, this._sizeStep);
            return;
        }

        public function putTexture(arg1:starling.textures.Texture):void
        {
            if (arg1) 
            {
                if (arg1.root.nativeWidth == this._nativeWidth && arg1.root.nativeHeight == this._nativeHeight) 
                {
                    this._pool.insertAt(this._pool.length, arg1);
                }
                else 
                {
                    arg1.dispose();
                }
            }
            return;
        }

        public function purge():void
        {
            var loc1:*=0;
            var loc2:*=this._pool.length;
            while (loc1 < loc2) 
            {
                this._pool[loc1].dispose();
                ++loc1;
            }
            this._pool.length = 0;
            return;
        }

        internal function setSize(arg1:Number, arg2:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=this._preferredScale;
            var loc3:*=starling.textures.Texture.maxSize;
            var loc4:*=this.getNativeSize(arg1, loc2);
            var loc5:*=this.getNativeSize(arg2, loc2);
            if (loc4 > loc3 || loc5 > loc3) 
            {
                loc1 = loc3 / Math.max(loc4, loc5);
                loc4 = loc4 * loc1;
                loc5 = loc5 * loc1;
                loc2 = loc2 * loc1;
            }
            if (!(this._nativeWidth == loc4) || !(this._nativeHeight == loc5) || !(this._scale == loc2)) 
            {
                this.purge();
                this._scale = loc2;
                this._nativeWidth = loc4;
                this._nativeHeight = loc5;
            }
            this._width = arg1;
            this._height = arg2;
            return;
        }

        internal function getNativeSize(arg1:Number, arg2:Number):int
        {
            var loc1:*=arg1 * arg2;
            if (this._usePotTextures) 
            {
                return loc1 > this._sizeStep ? starling.utils.MathUtil.getNextPowerOfTwo(loc1) : this._sizeStep;
            }
            return Math.ceil(loc1 / this._sizeStep) * this._sizeStep;
        }

        public function get projectionMatrix3D():flash.geom.Matrix3D
        {
            return this._projectionMatrix;
        }

        public function set projectionMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this._projectionMatrix.copyFrom(arg1);
            return;
        }

        public function get renderTarget():starling.textures.Texture
        {
            return this._renderTarget;
        }

        public function set renderTarget(arg1:starling.textures.Texture):void
        {
            this._renderTarget = arg1;
            return;
        }

        public function get targetBounds():flash.geom.Rectangle
        {
            return this._targetBounds;
        }

        public function set targetBounds(arg1:flash.geom.Rectangle):void
        {
            this._targetBounds.copyFrom(arg1);
            this.setSize(arg1.width, arg1.height);
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            this._target = arg1;
            return;
        }

        public function get textureScale():Number
        {
            return this._preferredScale;
        }

        public function set textureScale(arg1:Number):void
        {
            this._preferredScale = arg1 > 0 ? arg1 : starling.core.Starling.contentScaleFactor;
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public function set textureFormat(arg1:String):void
        {
            this._textureFormat = arg1;
            return;
        }

        public function dispose():void
        {
            this.purge();
            return;
        }

        public function start(arg1:int, arg2:Boolean):void
        {
            this._numPasses = arg2 ? arg1 : -1;
            return;
        }

        public function getTexture(arg1:Number=1):starling.textures.Texture
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._numPasses >= 0) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this)._numPasses - 1);
                loc3._numPasses = loc4;
                if ((loc3 = this)._numPasses == 0) 
                {
                    return null;
                }
            }
            if (this._pool.length) 
            {
                loc1 = this._pool.pop();
            }
            else 
            {
                loc1 = starling.textures.Texture.empty(this._nativeWidth / this._scale, this._nativeHeight / this._scale, true, false, true, this._scale, this._textureFormat);
            }
            if (!starling.utils.MathUtil.isEquivalent(loc1.width, this._width, 0.1) || !starling.utils.MathUtil.isEquivalent(loc1.height, this._height, 0.1) || !starling.utils.MathUtil.isEquivalent(loc1.scale, this._scale * arg1)) 
            {
                this.sRegion.setTo(0, 0, this._width * arg1, this._height * arg1);
                loc2 = loc1 as starling.textures.SubTexture;
                if (loc2) 
                {
                    loc2.starling_internal::setTo(loc1.root, this.sRegion, true, null, false, arg1);
                }
                else 
                {
                    loc1 = new starling.textures.SubTexture(loc1.root, this.sRegion, true, null, false, arg1);
                }
            }
            loc1.root.clear();
            return loc1;
        }

        internal var _width:Number;

        internal var _height:Number;

        internal var _nativeWidth:int;

        internal var _nativeHeight:int;

        internal var _pool:__AS3__.vec.Vector.<starling.textures.Texture>;

        internal var _usePotTextures:Boolean;

        internal var _textureFormat:String;

        internal var _preferredScale:Number;

        internal var _scale:Number;

        internal var _sizeStep:int;

        internal var _numPasses:int;

        internal var _projectionMatrix:flash.geom.Matrix3D;

        internal var _renderTarget:starling.textures.Texture;

        internal var _targetBounds:flash.geom.Rectangle;

        internal var _target:starling.display.DisplayObject;

        internal var sRegion:flash.geom.Rectangle;
    }
}


//    class FragmentFilter
package starling.filters 
{
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class FragmentFilter extends starling.events.EventDispatcher
    {
        public function FragmentFilter()
        {
            super();
            this._resolution = 1;
            this._textureFormat = flash.display3D.Context3DTextureFormat.BGRA;
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            starling.core.Starling.current.stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 0, true);
            return;
        }

        protected function onTargetAssigned(arg1:starling.display.DisplayObject):void
        {
            return;
        }

        public function get padding():starling.utils.Padding
        {
            if (this._padding == null) 
            {
                this._padding = new starling.utils.Padding();
                this._padding.addEventListener(starling.events.Event.CHANGE, this.setRequiresRedraw);
            }
            return this._padding;
        }

        public function set padding(arg1:starling.utils.Padding):void
        {
            this.padding.copyFrom(arg1);
            return;
        }

        public function get isCached():Boolean
        {
            return this._cached;
        }

        public override function addEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            }
            super.addEventListener(arg1, arg2);
            return;
        }

        public function get resolution():Number
        {
            return this._resolution;
        }

        public function set resolution(arg1:Number):void
        {
            if (arg1 != this._resolution) 
            {
                if (arg1 > 0) 
                {
                    this._resolution = arg1;
                }
                else 
                {
                    throw new ArgumentError("resolution must be > 0");
                }
                this.setRequiresRedraw();
            }
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            if (arg1 != this._textureSmoothing) 
            {
                this._textureSmoothing = arg1;
                if (this._quad) 
                {
                    this._quad.textureSmoothing = arg1;
                }
                this.setRequiresRedraw();
            }
            return;
        }

        public function set textureFormat(arg1:String):void
        {
            if (arg1 != this._textureFormat) 
            {
                this._textureFormat = arg1;
                if (this._helper) 
                {
                    this._helper.textureFormat = arg1;
                }
                this.setRequiresRedraw();
            }
            return;
        }

        public function get alwaysDrawToBackBuffer():Boolean
        {
            return this._alwaysDrawToBackBuffer;
        }

        public function set alwaysDrawToBackBuffer(arg1:Boolean):void
        {
            this._alwaysDrawToBackBuffer = arg1;
            return;
        }

        starling_internal function setTarget(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            if (arg1 != this._target) 
            {
                loc1 = this._target;
                this._target = arg1;
                if (arg1 == null) 
                {
                    if (this._helper) 
                    {
                        this._helper.purge();
                    }
                    if (this._effect) 
                    {
                        this._effect.purgeBuffers();
                    }
                    if (this._quad) 
                    {
                        this._quad.disposeTexture();
                    }
                }
                if (loc1) 
                {
                    loc1.filter = null;
                    loc1.removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                }
                if (arg1) 
                {
                    if (hasEventListener(starling.events.Event.ENTER_FRAME)) 
                    {
                        arg1.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                    }
                    this.onTargetAssigned(arg1);
                }
            }
            return;
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (this._helper) 
            {
                this._helper.dispose();
            }
            if (this._effect) 
            {
                this._effect.dispose();
            }
            if (this._quad) 
            {
                this._quad.dispose();
            }
            this._effect = null;
            this._quad = null;
            return;
        }

        internal function onContextCreated(arg1:Object):void
        {
            this.setRequiresRedraw();
            return;
        }

        public function render(arg1:starling.rendering.Painter):void
        {
            if (this._target == null) 
            {
                throw new flash.errors.IllegalOperationError("Cannot render filter without target");
            }
            if (this._target.is3D) 
            {
                var loc1:*;
                this._cacheRequested = loc1 = false;
                this._cached = loc1;
            }
            if (!this._cached || this._cacheRequested) 
            {
                this.renderPasses(arg1, this._cacheRequested);
                this._cacheRequested = false;
            }
            else if (this._quad.visible) 
            {
                this._quad.render(arg1);
            }
            return;
        }

        internal function renderPasses(arg1:starling.rendering.Painter, arg2:Boolean):void
        {
            var loc7:*=null;
            var loc10:*=null;
            if (this._helper == null) 
            {
                this._helper = new FilterHelper(this._textureFormat);
            }
            if (this._quad != null) 
            {
                this._helper.putTexture(this._quad.texture);
                this._quad.texture = null;
            }
            else 
            {
                this._quad = new FilterQuad(this._textureSmoothing);
            }
            var loc1:*=starling.utils.Pool.getRectangle();
            var loc2:*=false;
            var loc3:*=this._resolution;
            var loc4:*=this._target.stage || this._target.parent;
            var loc5:*=loc4 is starling.display.Stage;
            var loc6:*=starling.core.Starling.current.stage;
            if (!arg2 && (this._alwaysDrawToBackBuffer || this._target.requiresRedraw)) 
            {
                loc2 = arg1.state.alpha == 1;
                arg1.excludeFromCache(this._target);
            }
            if (this._target != starling.core.Starling.current.root) 
            {
                this._target.getBounds(loc4, loc1);
                if (!arg2 && loc5) 
                {
                    loc7 = loc6.getStageBounds(null, starling.utils.Pool.getRectangle());
                    starling.utils.RectangleUtil.intersect(loc1, loc7, loc1);
                    starling.utils.Pool.putRectangle(loc7);
                }
            }
            else 
            {
                loc6.getStageBounds(this._target, loc1);
            }
            this._quad.visible = !loc1.isEmpty();
            if (!this._quad.visible) 
            {
                starling.utils.Pool.putRectangle(loc1);
                return;
            }
            if (this._padding) 
            {
                starling.utils.RectangleUtil.extend(loc1, this._padding.left, this._padding.right, this._padding.top, this._padding.bottom);
            }
            loc1.setTo(Math.floor(loc1.x), Math.floor(loc1.y), Math.ceil(loc1.width), Math.ceil(loc1.height));
            this._helper.textureScale = starling.core.Starling.contentScaleFactor * this._resolution;
            this._helper.projectionMatrix3D = arg1.state.projectionMatrix3D;
            this._helper.renderTarget = arg1.state.renderTarget;
            this._helper.targetBounds = loc1;
            this._helper.target = this._target;
            this._helper.start(this.numPasses, loc2);
            this._quad.setBounds(loc1);
            this._resolution = 1;
            var loc8:*=arg1.cacheEnabled;
            var loc9:*=this._helper.getTexture();
            arg1.cacheEnabled = false;
            arg1.pushState();
            arg1.state.alpha = 1;
            arg1.state.renderTarget = loc9;
            arg1.state.setProjectionMatrix(loc1.x, loc1.y, loc9.root.width, loc9.root.height, loc6.stageWidth, loc6.stageHeight, loc6.cameraPosition);
            this._target.render(arg1);
            arg1.finishMeshBatch();
            arg1.state.setModelviewMatricesToIdentity();
            arg1.state.clipRect = null;
            loc10 = this.process(arg1, this._helper, loc9);
            arg1.popState();
            arg1.cacheEnabled = loc8;
            if (loc10) 
            {
                arg1.pushState();
                if (this._target.is3D) 
                {
                    arg1.state.setModelviewMatricesToIdentity();
                }
                else 
                {
                    this._quad.moveVertices(loc4, this._target);
                }
                this._quad.texture = loc10;
                this._quad.render(arg1);
                arg1.finishMeshBatch();
                arg1.popState();
            }
            this._helper.target = null;
            this._helper.putTexture(loc9);
            this._resolution = loc3;
            starling.utils.Pool.putRectangle(loc1);
            return;
        }

        public function process(arg1:starling.rendering.Painter, arg2:starling.filters.IFilterHelper, arg3:starling.textures.Texture=null, arg4:starling.textures.Texture=null, arg5:starling.textures.Texture=null, arg6:starling.textures.Texture=null):starling.textures.Texture
        {
            var loc3:*=null;
            var loc5:*=null;
            var loc1:*=this.effect;
            var loc2:*=arg2.getTexture(this._resolution);
            var loc4:*=null;
            if (loc2) 
            {
                loc5 = loc2;
                loc3 = starling.utils.MatrixUtil.createPerspectiveProjectionMatrix(0, 0, loc2.root.width / this._resolution, loc2.root.height / this._resolution, 0, 0, null, sMatrix3D);
            }
            else 
            {
                loc4 = arg2.targetBounds;
                loc5 = (arg2 as FilterHelper).renderTarget;
                loc3 = (arg2 as FilterHelper).projectionMatrix3D;
                loc1.textureSmoothing = this._textureSmoothing;
            }
            arg1.state.renderTarget = loc5;
            arg1.prepareToDraw();
            arg1.drawCount = arg1.drawCount + 1;
            arg3.setupVertexPositions(this.vertexData, 0, "position", loc4);
            arg3.setupTextureCoordinates(this.vertexData);
            loc1.texture = arg3;
            loc1.mvpMatrix3D = loc3;
            loc1.uploadVertexData(this.vertexData);
            loc1.uploadIndexData(this.indexData);
            loc1.render(0, this.indexData.numTriangles);
            return loc2;
        }

        protected function createEffect():starling.rendering.FilterEffect
        {
            return new starling.rendering.FilterEffect();
        }

        public function cache():void
        {
            var loc1:*;
            this._cacheRequested = loc1 = true;
            this._cached = loc1;
            this.setRequiresRedraw();
            return;
        }

        public function clearCache():void
        {
            var loc1:*;
            this._cacheRequested = loc1 = false;
            this._cached = loc1;
            this.setRequiresRedraw();
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public override function removeEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.removeEventListener(arg1, this.onEnterFrame);
            }
            super.removeEventListener(arg1, arg2);
            return;
        }

        internal function onEnterFrame(arg1:starling.events.Event):void
        {
            dispatchEvent(arg1);
            return;
        }

        protected function get effect():starling.rendering.FilterEffect
        {
            if (this._effect == null) 
            {
                this._effect = this.createEffect();
            }
            return this._effect;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            if (this._vertexData == null) 
            {
                this._vertexData = new starling.rendering.VertexData(this.effect.vertexFormat, 4);
            }
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            if (this._indexData == null) 
            {
                this._indexData = new starling.rendering.IndexData(6);
                this._indexData.addQuad(0, 1, 2, 3);
            }
            return this._indexData;
        }

        protected function setRequiresRedraw():void
        {
            dispatchEventWith(starling.events.Event.CHANGE);
            if (this._target) 
            {
                this._target.setRequiresRedraw();
            }
            if (this._cached) 
            {
                this._cacheRequested = true;
            }
            return;
        }

        public function get numPasses():int
        {
            return 1;
        }

        internal var _quad:FilterQuad;

        internal var _target:starling.display.DisplayObject;

        internal var _effect:starling.rendering.FilterEffect;

        internal var _vertexData:starling.rendering.VertexData;

        internal var _padding:starling.utils.Padding;

        internal var _helper:FilterHelper;

        internal var _resolution:Number;

        internal var _textureFormat:String;

        internal var _textureSmoothing:String;

        internal var _alwaysDrawToBackBuffer:Boolean;

        internal var _cacheRequested:Boolean;

        internal var _cached:Boolean;

        internal var _indexData:starling.rendering.IndexData;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}

import flash.geom.*;
import starling.display.*;
import starling.rendering.*;
import starling.textures.*;


class FilterQuad extends starling.display.Mesh
{
    public function FilterQuad(arg1:String)
    {
        var loc1:*=new starling.rendering.VertexData(null, 4);
        loc1.numVertices = 4;
        var loc2:*=new starling.rendering.IndexData(6);
        loc2.addQuad(0, 1, 2, 3);
        super(loc1, loc2);
        textureSmoothing = arg1;
        pixelSnapping = false;
        return;
    }

    public override function dispose():void
    {
        this.disposeTexture();
        super.dispose();
        return;
    }

    public function disposeTexture():void
    {
        if (texture) 
        {
            texture.dispose();
            this.texture = null;
        }
        return;
    }

    public function moveVertices(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
    {
        if (arg2.is3D) 
        {
            throw new Error("cannot move vertices into 3D space");
        }
        if (arg1 != arg2) 
        {
            arg2.getTransformationMatrix(arg1, sMatrix).invert();
            vertexData.transformPoints("position", sMatrix);
        }
        return;
    }

    public function setBounds(arg1:flash.geom.Rectangle):void
    {
        var loc1:*=this.vertexData;
        var loc2:*="position";
        loc1.setPoint(0, loc2, arg1.x, arg1.y);
        loc1.setPoint(1, loc2, arg1.right, arg1.y);
        loc1.setPoint(2, loc2, arg1.x, arg1.bottom);
        loc1.setPoint(3, loc2, arg1.right, arg1.bottom);
        return;
    }

    public override function set texture(arg1:starling.textures.Texture):void
    {
        super.texture = arg1;
        if (arg1) 
        {
            arg1.setupTextureCoordinates(vertexData);
        }
        return;
    }

    
    {
        sMatrix = new flash.geom.Matrix();
    }

    internal static var sMatrix:flash.geom.Matrix;
}

//    class IFilterHelper
package starling.filters 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.textures.*;
    
    public interface IFilterHelper
    {
        function getTexture(arg1:Number=1):starling.textures.Texture;

        function putTexture(arg1:starling.textures.Texture):void;

        function get targetBounds():flash.geom.Rectangle;

        function get target():starling.display.DisplayObject;
    }
}


//  package geom
//    class Polygon
package starling.geom 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Polygon extends Object
    {
        public function Polygon(arg1:Array=null)
        {
            super();
            this._coords = new Vector.<Number>(0);
            this.addVertices.apply(this, arg1);
            return;
        }

        public function clone():starling.geom.Polygon
        {
            var loc1:*=new starling.geom.Polygon();
            var loc2:*=this._coords.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1._coords[loc3] = this._coords[loc3];
                ++loc3;
            }
            return loc1;
        }

        public function reverse():void
        {
            var loc3:*=NaN;
            var loc1:*=this._coords.length;
            var loc2:*=loc1 / 2;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc3 = this._coords[loc4];
                this._coords[loc4] = this._coords[loc1 - loc4 - 2];
                this._coords[loc1 - loc4 - 2] = loc3;
                loc3 = this._coords[loc4 + 1];
                this._coords[loc4 + 1] = this._coords[(loc1 - loc4 - 1)];
                this._coords[(loc1 - loc4 - 1)] = loc3;
                loc4 = loc4 + 2;
            }
            return;
        }

        public function addVertices(... rest):void
        {
            var loc1:*=0;
            var loc2:*=rest.length;
            var loc3:*=this._coords.length;
            if (loc2 > 0) 
            {
                if (rest[0] is flash.geom.Point) 
                {
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this._coords[loc3 + loc1 * 2] = (rest[loc1] as flash.geom.Point).x;
                        this._coords[loc3 + loc1 * 2 + 1] = (rest[loc1] as flash.geom.Point).y;
                        ++loc1;
                    }
                }
                else if (rest[0] is Number) 
                {
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this._coords[loc3 + loc1] = rest[loc1];
                        ++loc1;
                    }
                }
                else 
                {
                    throw new ArgumentError("Invalid type: " + flash.utils.getQualifiedClassName(rest[0]));
                }
            }
            return;
        }

        public function setVertex(arg1:int, arg2:Number, arg3:Number):void
        {
            if (arg1 >= 0 && arg1 <= this.numVertices) 
            {
                this._coords[arg1 * 2] = arg2;
                this._coords[arg1 * 2 + 1] = arg3;
            }
            else 
            {
                throw new RangeError("Invalid index: " + arg1);
            }
            return;
        }

        public function getVertex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (arg1 >= 0 && arg1 < this.numVertices) 
            {
                arg2 = arg2 || new flash.geom.Point();
                arg2.setTo(this._coords[arg1 * 2], this._coords[arg1 * 2 + 1]);
                return arg2;
            }
            throw new RangeError("Invalid index: " + arg1);
        }

        public function contains(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc2:*=(this.numVertices - 1);
            var loc3:*=0;
            loc1 = 0;
            while (loc1 < this.numVertices) 
            {
                loc4 = this._coords[loc1 * 2];
                loc5 = this._coords[loc1 * 2 + 1];
                loc6 = this._coords[loc2 * 2];
                loc7 = this._coords[loc2 * 2 + 1];
                if ((loc5 < arg2 && loc7 >= arg2 || loc7 < arg2 && loc5 >= arg2) && (loc4 <= arg1 || loc6 <= arg1)) 
                {
                    loc3 = loc3 ^ uint(loc4 + (arg2 - loc5) / (loc7 - loc5) * (loc6 - loc4) < arg1);
                }
                loc2 = loc1;
                ++loc1;
            }
            return !(loc3 == 0);
        }

        public function containsPoint(arg1:flash.geom.Point):Boolean
        {
            return this.contains(arg1.x, arg1.y);
        }

        public function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc10:*=0;
            var loc11:*=false;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=0;
            var loc1:*=this.numVertices;
            var loc2:*=this.numTriangles;
            if (arg1 == null) 
            {
                arg1 = new starling.rendering.IndexData(loc2 * 3);
            }
            if (loc2 == 0) 
            {
                return arg1;
            }
            sRestIndices.length = loc1;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                sRestIndices[loc3] = loc3;
                ++loc3;
            }
            loc4 = 0;
            loc5 = loc1;
            var loc6:*=starling.utils.Pool.getPoint();
            var loc7:*=starling.utils.Pool.getPoint();
            var loc8:*=starling.utils.Pool.getPoint();
            var loc9:*=starling.utils.Pool.getPoint();
            while (loc5 > 3) 
            {
                loc11 = false;
                loc12 = sRestIndices[loc4 % loc5];
                loc13 = sRestIndices[(loc4 + 1) % loc5];
                loc14 = sRestIndices[(loc4 + 2) % loc5];
                loc6.setTo(this._coords[2 * loc12], this._coords[2 * loc12 + 1]);
                loc7.setTo(this._coords[2 * loc13], this._coords[2 * loc13 + 1]);
                loc8.setTo(this._coords[2 * loc14], this._coords[2 * loc14 + 1]);
                if (isConvexTriangle(loc6.x, loc6.y, loc7.x, loc7.y, loc8.x, loc8.y)) 
                {
                    loc11 = true;
                    loc3 = 3;
                    while (loc3 < loc5) 
                    {
                        loc10 = sRestIndices[(loc4 + loc3) % loc5];
                        loc9.setTo(this._coords[2 * loc10], this._coords[2 * loc10 + 1]);
                        if (starling.utils.MathUtil.isPointInTriangle(loc9, loc6, loc7, loc8)) 
                        {
                            loc11 = false;
                        }
                        ++loc3;
                    }
                }
                if (loc11) 
                {
                    arg1.addTriangle(loc12 + arg2, loc13 + arg2, loc14 + arg2);
                    sRestIndices.removeAt((loc4 + 1) % loc5);
                    --loc5;
                    loc4 = 0;
                    continue;
                }
                ++loc4;
                if (loc4 != loc5) 
                {
                    continue;
                }
                break;
            }
            starling.utils.Pool.putPoint(loc6);
            starling.utils.Pool.putPoint(loc7);
            starling.utils.Pool.putPoint(loc8);
            starling.utils.Pool.putPoint(loc9);
            arg1.addTriangle(sRestIndices[0] + arg2, sRestIndices[1] + arg2, sRestIndices[2] + arg2);
            return arg1;
        }

        public function copyToVertexData(arg1:starling.rendering.VertexData=null, arg2:int=0, arg3:String="position"):void
        {
            var loc1:*=this.numVertices;
            var loc2:*=arg2 + loc1;
            if (arg1.numVertices < loc2) 
            {
                arg1.numVertices = loc2;
            }
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                arg1.setPoint(arg2 + loc3, arg3, this._coords[loc3 * 2], this._coords[loc3 * 2 + 1]);
                ++loc3;
            }
            return;
        }

        public function toString():String
        {
            var loc1:*="[Polygon";
            var loc2:*=this.numVertices;
            if (loc2 > 0) 
            {
                loc1 = loc1 + "\n";
            }
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = loc1 + ("  [Vertex " + loc3 + ": " + "x=" + this._coords[loc3 * 2].toFixed(1) + ", " + "y=" + this._coords[loc3 * 2 + 1].toFixed(1) + "]" + (loc3 != (loc2 - 1) ? ",\n" : "\n"));
                ++loc3;
            }
            return loc1 + "]";
        }

        public function get isSimple():Boolean
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=0;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc1:*=this._coords.length;
            if (loc1 <= 6) 
            {
                return true;
            }
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._coords[loc2];
                loc4 = this._coords[loc2 + 1];
                loc5 = this._coords[(loc2 + 2) % loc1];
                loc6 = this._coords[(loc2 + 3) % loc1];
                loc7 = loc2 + loc1 - 2;
                loc8 = loc2 + 4;
                while (loc8 < loc7) 
                {
                    loc9 = this._coords[loc8 % loc1];
                    loc10 = this._coords[(loc8 + 1) % loc1];
                    loc11 = this._coords[(loc8 + 2) % loc1];
                    loc12 = this._coords[(loc8 + 3) % loc1];
                    if (areVectorsIntersecting(loc3, loc4, loc5, loc6, loc9, loc10, loc11, loc12)) 
                    {
                        return false;
                    }
                    loc8 = loc8 + 2;
                }
                loc2 = loc2 + 2;
            }
            return true;
        }

        public function get isConvex():Boolean
        {
            var loc2:*=0;
            var loc1:*=this._coords.length;
            if (loc1 < 6) 
            {
                return true;
            }
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (!isConvexTriangle(this._coords[loc2], this._coords[loc2 + 1], this._coords[(loc2 + 2) % loc1], this._coords[(loc2 + 3) % loc1], this._coords[(loc2 + 4) % loc1], this._coords[(loc2 + 5) % loc1])) 
                {
                    return false;
                }
                loc2 = loc2 + 2;
            }
            return true;
        }

        public function get area():Number
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc2:*=this._coords.length;
            if (loc2 >= 6) 
            {
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc1 = loc1 + this._coords[loc3] * this._coords[(loc3 + 3) % loc2];
                    loc1 = loc1 - this._coords[loc3 + 1] * this._coords[(loc3 + 2) % loc2];
                    loc3 = loc3 + 2;
                }
            }
            return loc1 / 2;
        }

        public function get numVertices():int
        {
            return this._coords.length / 2;
        }

        public function set numVertices(arg1:int):void
        {
            var loc2:*=0;
            var loc1:*=this.numVertices;
            this._coords.length = arg1 * 2;
            if (loc1 < arg1) 
            {
                loc2 = loc1;
                while (loc2 < arg1) 
                {
                    var loc3:*;
                    this._coords[loc2 * 2 + 1] = loc3 = 0;
                    this._coords[loc2 * 2] = loc3;
                    ++loc2;
                }
            }
            return;
        }

        public function get numTriangles():int
        {
            var loc1:*=this.numVertices;
            return loc1 >= 3 ? loc1 - 2 : 0;
        }

        public static function createEllipse(arg1:Number, arg2:Number, arg3:Number, arg4:Number):starling.geom.Polygon
        {
            return new Ellipse(arg1, arg2, arg3, arg4);
        }

        public static function createCircle(arg1:Number, arg2:Number, arg3:Number):starling.geom.Polygon
        {
            return new Ellipse(arg1, arg2, arg3, arg3);
        }

        public static function createRectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number):starling.geom.Polygon
        {
            return new Rectangle(arg1, arg2, arg3, arg4);
        }

        internal static function isConvexTriangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Boolean
        {
            return (arg2 - arg4) * (arg5 - arg3) + (arg3 - arg1) * (arg6 - arg4) >= 0;
        }

        internal static function areVectorsIntersecting(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):Boolean
        {
            if (arg1 == arg3 && arg2 == arg4 || arg5 == arg7 && arg6 == arg8) 
            {
                return false;
            }
            var loc1:*=arg3 - arg1;
            var loc2:*=arg4 - arg2;
            var loc3:*=arg7 - arg5;
            var loc4:*=arg8 - arg6;
            var loc5:*=loc4 * loc1 - loc3 * loc2;
            if (loc5 == 0) 
            {
                return false;
            }
            var loc6:*=(loc2 * (arg5 - arg1) - loc1 * (arg6 - arg2)) / loc5;
            if (loc6 < 0 || loc6 > 1) 
            {
                return false;
            }
            var loc7:*=loc2 ? (arg6 - arg2 + loc6 * loc4) / loc2 : (arg5 - arg1 + loc6 * loc3) / loc1;
            return loc7 >= 0 && loc7 <= 1;
        }

        
        {
            sRestIndices = new Vector.<uint>(0);
        }

        internal var _coords:__AS3__.vec.Vector.<Number>;

        internal static var sRestIndices:__AS3__.vec.Vector.<uint>;
    }
}

import flash.errors.*;
import flash.utils.*;
import starling.rendering.*;


class ImmutablePolygon extends starling.geom.Polygon
{
    public function ImmutablePolygon(arg1:Array)
    {
        super(arg1);
        this._frozen = true;
        return;
    }

    public override function addVertices(... rest):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.addVertices.apply(this, rest);
        return;
    }

    public override function setVertex(arg1:int, arg2:Number, arg3:Number):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.setVertex(arg1, arg2, arg3);
        return;
    }

    public override function reverse():void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.reverse();
        return;
    }

    public override function set numVertices(arg1:int):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.reverse();
        return;
    }

    internal function getImmutableError():Error
    {
        var loc1:*=flash.utils.getQualifiedClassName(this).split("::").pop();
        var loc2:*=loc1 + " cannot be modified. Call \'clone\' to create a mutable copy.";
        return new flash.errors.IllegalOperationError(loc2);
    }

    internal var _frozen:Boolean;
}

class Ellipse extends ImmutablePolygon
{
    public function Ellipse(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int=-1)
    {
        this._x = arg1;
        this._y = arg2;
        this._radiusX = arg3;
        this._radiusY = arg4;
        super(this.getVertices(arg5));
        return;
    }

    internal function getVertices(arg1:int):Array
    {
        if (arg1 < 0) 
        {
            arg1 = Math.PI * (this._radiusX + this._radiusY) / 4;
        }
        if (arg1 < 6) 
        {
            arg1 = 6;
        }
        var loc1:*=[];
        var loc2:*=2 * Math.PI / arg1;
        var loc3:*=0;
        var loc4:*=0;
        while (loc4 < arg1) 
        {
            loc1[loc4 * 2] = Math.cos(loc3) * this._radiusX + this._x;
            loc1[loc4 * 2 + 1] = Math.sin(loc3) * this._radiusY + this._y;
            loc3 = loc3 + loc2;
            ++loc4;
        }
        return loc1;
    }

    public override function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
    {
        if (arg1 == null) 
        {
            arg1 = new starling.rendering.IndexData((numVertices - 2) * 3);
        }
        var loc1:*=1;
        var loc2:*=(numVertices - 1);
        var loc3:*=loc1;
        while (loc3 < loc2) 
        {
            arg1.addTriangle(arg2, arg2 + loc3, arg2 + loc3 + 1);
            ++loc3;
        }
        return arg1;
    }

    public override function contains(arg1:Number, arg2:Number):Boolean
    {
        var loc1:*=arg1 - this._x;
        var loc2:*=arg2 - this._y;
        var loc3:*=loc1 / this._radiusX;
        var loc4:*=loc2 / this._radiusY;
        return loc3 * loc3 + loc4 * loc4 <= 1;
    }

    public override function get area():Number
    {
        return Math.PI * this._radiusX * this._radiusY;
    }

    public override function get isSimple():Boolean
    {
        return true;
    }

    public override function get isConvex():Boolean
    {
        return true;
    }

    internal var _x:Number;

    internal var _y:Number;

    internal var _radiusX:Number;

    internal var _radiusY:Number;
}

class Rectangle extends ImmutablePolygon
{
    public function Rectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number)
    {
        this._x = arg1;
        this._y = arg2;
        this._width = arg3;
        this._height = arg4;
        super([arg1, arg2, arg1 + arg3, arg2, arg1 + arg3, arg2 + arg4, arg1, arg2 + arg4]);
        return;
    }

    public override function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
    {
        if (arg1 == null) 
        {
            arg1 = new starling.rendering.IndexData(6);
        }
        arg1.addTriangle(arg2, arg2 + 1, arg2 + 3);
        arg1.addTriangle(arg2 + 1, arg2 + 2, arg2 + 3);
        return arg1;
    }

    public override function contains(arg1:Number, arg2:Number):Boolean
    {
        return arg1 >= this._x && arg1 <= this._x + this._width && arg2 >= this._y && arg2 <= this._y + this._height;
    }

    public override function get area():Number
    {
        return this._width * this._height;
    }

    public override function get isSimple():Boolean
    {
        return true;
    }

    public override function get isConvex():Boolean
    {
        return true;
    }

    internal var _x:Number;

    internal var _y:Number;

    internal var _width:Number;

    internal var _height:Number;
}

//  package rendering
//    class BatchProcessor
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.utils.*;
    
    internal class BatchProcessor extends Object
    {
        public function BatchProcessor()
        {
            super();
            this._batches = new Vector.<starling.display.MeshBatch>(0);
            this._batchPool = new BatchPool();
            this._cacheToken = new starling.rendering.BatchToken();
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._batches;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            this._batches.length = 0;
            this._batchPool.purge();
            this._currentBatch = null;
            this._onBatchComplete = null;
            return;
        }

        public function addMesh(arg1:starling.display.Mesh, arg2:starling.rendering.RenderState, arg3:starling.utils.MeshSubset=null, arg4:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (arg3 != null) 
            {
                if (arg3.numVertices < 0) 
                {
                    arg3.numVertices = arg1.numVertices - arg3.vertexID;
                }
                if (arg3.numIndices < 0) 
                {
                    arg3.numIndices = arg1.numIndices - arg3.indexID;
                }
            }
            else 
            {
                arg3 = sMeshSubset;
                var loc3:*;
                arg3.indexID = loc3 = 0;
                arg3.vertexID = loc3;
                arg3.numVertices = arg1.numVertices;
                arg3.numIndices = arg1.numIndices;
            }
            if (arg3.numVertices > 0) 
            {
                if (this._currentBatch == null || !this._currentBatch.canAddMesh(arg1, arg3.numVertices)) 
                {
                    this.finishBatch();
                    this._currentStyleType = arg1.style.type;
                    this._currentBatch = this._batchPool.get(this._currentStyleType);
                    this._currentBatch.blendMode = arg2 ? arg2.blendMode : arg1.blendMode;
                    this._cacheToken.setTo(this._batches.length);
                    this._batches[this._batches.length] = this._currentBatch;
                }
                loc1 = arg2 ? arg2._modelviewMatrix : null;
                loc2 = arg2 ? arg2._alpha : 1;
                this._currentBatch.addMesh(arg1, loc1, loc2, arg3, arg4);
                this._cacheToken.vertexID = this._cacheToken.vertexID + arg3.numVertices;
                this._cacheToken.indexID = this._cacheToken.indexID + arg3.numIndices;
            }
            return;
        }

        public function finishBatch():void
        {
            var loc1:*=this._currentBatch;
            if (loc1) 
            {
                this._currentBatch = null;
                this._currentStyleType = null;
                if (this._onBatchComplete != null) 
                {
                    this._onBatchComplete(loc1);
                }
            }
            return;
        }

        public function clear():void
        {
            var loc1:*=this._batches.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this._batchPool.put(this._batches[loc2]);
                ++loc2;
            }
            this._batches.length = 0;
            this._currentBatch = null;
            this._currentStyleType = null;
            this._cacheToken.reset();
            return;
        }

        public function getBatchAt(arg1:int):starling.display.MeshBatch
        {
            return this._batches[arg1];
        }

        public function trim():void
        {
            this._batchPool.purge();
            return;
        }

        public function fillToken(arg1:starling.rendering.BatchToken):starling.rendering.BatchToken
        {
            arg1.batchID = this._cacheToken.batchID;
            arg1.vertexID = this._cacheToken.vertexID;
            arg1.indexID = this._cacheToken.indexID;
            return arg1;
        }

        public function get numBatches():int
        {
            return this._batches.length;
        }

        public function get onBatchComplete():Function
        {
            return this._onBatchComplete;
        }

        public function set onBatchComplete(arg1:Function):void
        {
            this._onBatchComplete = arg1;
            return;
        }

        
        {
            sMeshSubset = new starling.utils.MeshSubset();
        }

        internal var _batches:__AS3__.vec.Vector.<starling.display.MeshBatch>;

        internal var _batchPool:BatchPool;

        internal var _currentBatch:starling.display.MeshBatch;

        internal var _currentStyleType:Class;

        internal var _onBatchComplete:Function;

        internal var _cacheToken:starling.rendering.BatchToken;

        internal static var sMeshSubset:starling.utils.MeshSubset;
    }
}

import __AS3__.vec.*;
import flash.utils.*;
import starling.display.*;


class BatchPool extends Object
{
    public function BatchPool()
    {
        super();
        this._batchLists = new flash.utils.Dictionary();
        return;
    }

    public function purge():void
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=0;
        var loc4:*=this._batchLists;
        for each (loc1 in loc4) 
        {
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2].dispose();
                ++loc2;
            }
            loc1.length = 0;
        }
        return;
    }

    public function get(arg1:Class):starling.display.MeshBatch
    {
        var loc1:*=this._batchLists[arg1];
        if (loc1 == null) 
        {
            loc1 = new Vector.<starling.display.MeshBatch>(0);
            this._batchLists[arg1] = loc1;
        }
        if (loc1.length > 0) 
        {
            return loc1.pop();
        }
        return new starling.display.MeshBatch();
    }

    public function put(arg1:starling.display.MeshBatch):void
    {
        var loc1:*=arg1.style.type;
        var loc2:*=this._batchLists[loc1];
        if (loc2 == null) 
        {
            loc2 = new Vector.<starling.display.MeshBatch>(0);
            this._batchLists[loc1] = loc2;
        }
        arg1.clear();
        loc2[loc2.length] = arg1;
        return;
    }

    internal var _batchLists:flash.utils.Dictionary;
}

//    class BatchToken
package starling.rendering 
{
    import starling.utils.*;
    
    public class BatchToken extends Object
    {
        public function BatchToken(arg1:int=0, arg2:int=0, arg3:int=0)
        {
            super();
            this.setTo(arg1, arg2, arg3);
            return;
        }

        public function copyFrom(arg1:starling.rendering.BatchToken):void
        {
            this.batchID = arg1.batchID;
            this.vertexID = arg1.vertexID;
            this.indexID = arg1.indexID;
            return;
        }

        public function setTo(arg1:int=0, arg2:int=0, arg3:int=0):void
        {
            this.batchID = arg1;
            this.vertexID = arg2;
            this.indexID = arg3;
            return;
        }

        public function reset():void
        {
            var loc1:*;
            this.indexID = loc1 = 0;
            this.vertexID = loc1 = loc1;
            this.batchID = loc1;
            return;
        }

        public function equals(arg1:starling.rendering.BatchToken):Boolean
        {
            return this.batchID == arg1.batchID && this.vertexID == arg1.vertexID && this.indexID == arg1.indexID;
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[BatchToken batchID={0} vertexID={1} indexID={2}]", this.batchID, this.vertexID, this.indexID);
        }

        public var batchID:int;

        public var vertexID:int;

        public var indexID:int;
    }
}


//    class Effect
package starling.rendering 
{
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;
    
    public class Effect extends Object
    {
        public function Effect()
        {
            super();
            this._mvpMatrix3D = new flash.geom.Matrix3D();
            this._programBaseName = flash.utils.getQualifiedClassName(this);
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 20, true);
            return;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            return this._mvpMatrix3D;
        }

        public function set mvpMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this._mvpMatrix3D.copyFrom(arg1);
            return;
        }

        protected function get indexBuffer():flash.display3D.IndexBuffer3D
        {
            return this._indexBuffer;
        }

        protected function get indexBufferSize():int
        {
            return this._indexBufferSize;
        }

        protected function get vertexBuffer():flash.display3D.VertexBuffer3D
        {
            return this._vertexBuffer;
        }

        protected function get vertexBufferSize():int
        {
            return this._vertexBufferSize;
        }

        
        {
            sProgramNameCache = new flash.utils.Dictionary();
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.purgeBuffers();
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.purgeBuffers();
            starling.utils.execute(this._onRestore, this);
            return;
        }

        public function purgeBuffers(arg1:Boolean=true, arg2:Boolean=true):void
        {
            if (this._vertexBuffer && arg1) 
            {
                try 
                {
                    this._vertexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._vertexBuffer = null;
            }
            if (this._indexBuffer && arg2) 
            {
                try 
                {
                    this._indexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._indexBuffer = null;
            }
            return;
        }

        public function uploadIndexData(arg1:starling.rendering.IndexData, arg2:String="staticDraw"):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.useQuadLayout;
            var loc3:*=this._indexBufferUsesQuadLayout;
            if (this._indexBuffer) 
            {
                if (loc1 <= this._indexBufferSize) 
                {
                    if (!loc2 || !loc3) 
                    {
                        arg1.uploadToIndexBuffer(this._indexBuffer);
                        this._indexBufferUsesQuadLayout = loc2 && loc1 == this._indexBufferSize;
                    }
                }
                else 
                {
                    this.purgeBuffers(false, true);
                }
            }
            if (this._indexBuffer == null) 
            {
                this._indexBuffer = arg1.createIndexBuffer(true, arg2);
                this._indexBufferSize = loc1;
                this._indexBufferUsesQuadLayout = loc2;
            }
            return;
        }

        public function uploadVertexData(arg1:starling.rendering.VertexData, arg2:String="staticDraw"):void
        {
            if (this._vertexBuffer) 
            {
                if (arg1.size <= this._vertexBufferSize) 
                {
                    arg1.uploadToVertexBuffer(this._vertexBuffer);
                }
                else 
                {
                    this.purgeBuffers(true, false);
                }
            }
            if (this._vertexBuffer == null) 
            {
                this._vertexBuffer = arg1.createVertexBuffer(true, arg2);
                this._vertexBufferSize = arg1.size;
            }
            return;
        }

        public function render(arg1:int=0, arg2:int=-1):void
        {
            if (arg2 < 0) 
            {
                arg2 = this._indexBufferSize / 3;
            }
            if (arg2 == 0) 
            {
                return;
            }
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            this.beforeDraw(loc1);
            loc1.drawTriangles(this.indexBuffer, arg1, arg2);
            this.afterDraw(loc1);
            return;
        }

        protected function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            this.program.activate(arg1);
            this.vertexFormat.setVertexBufferAt(0, this.vertexBuffer, "position");
            arg1.setProgramConstantsFromMatrix(flash.display3D.Context3DProgramType.VERTEX, 0, this.mvpMatrix3D, true);
            return;
        }

        protected function afterDraw(arg1:flash.display3D.Context3D):void
        {
            arg1.setVertexBufferAt(0, null);
            return;
        }

        protected function createProgram():starling.rendering.Program
        {
            var loc1:*=["m44 op, va0, vc0", "seq v0, va0, va0"].join("\n");
            var loc2:*="mov oc, v0";
            return starling.rendering.Program.fromSource(loc1, loc2);
        }

        protected function get programVariantName():uint
        {
            return 0;
        }

        protected function get programBaseName():String
        {
            return this._programBaseName;
        }

        protected function set programBaseName(arg1:String):void
        {
            this._programBaseName = arg1;
            return;
        }

        protected function get programName():String
        {
            var loc1:*=this.programBaseName;
            var loc2:*=this.programVariantName;
            var loc3:*=sProgramNameCache[loc1];
            if (loc3 == null) 
            {
                loc3 = new flash.utils.Dictionary();
                sProgramNameCache[loc1] = loc3;
            }
            var loc4:*=loc3[loc2];
            if (loc4 == null) 
            {
                if (loc2) 
                {
                    loc4 = loc1 + "#" + loc2.toString(16);
                }
                else 
                {
                    loc4 = loc1;
                }
                loc3[loc2] = loc4;
            }
            return loc4;
        }

        protected function get program():starling.rendering.Program
        {
            var loc1:*=this.programName;
            var loc2:*=starling.core.Starling.painter;
            var loc3:*=loc2.getProgram(loc1);
            if (loc3 == null) 
            {
                loc3 = this.createProgram();
                loc2.registerProgram(loc1, loc3);
            }
            return loc3;
        }

        public function get onRestore():Function
        {
            return this._onRestore;
        }

        public function set onRestore(arg1:Function):void
        {
            this._onRestore = arg1;
            return;
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.VertexDataFormat.fromString("position:float2");

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;

        internal var _vertexBufferSize:int;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _indexBufferSize:int;

        internal var _indexBufferUsesQuadLayout:Boolean;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal var _onRestore:Function;

        internal var _programBaseName:String;

        internal static var sProgramNameCache:flash.utils.Dictionary;
    }
}


//    class FilterEffect
package starling.rendering 
{
    import flash.display3D.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class FilterEffect extends starling.rendering.Effect
    {
        public function FilterEffect()
        {
            super();
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            return;
        }

        protected override function get programVariantName():uint
        {
            return starling.utils.RenderUtil.getTextureVariantBits(this._texture);
        }

        protected override function createProgram():starling.rendering.Program
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._texture) 
            {
                loc1 = STD_VERTEX_SHADER;
                loc2 = tex("oc", "v0", 0, this._texture);
                return starling.rendering.Program.fromSource(loc1, loc2);
            }
            return super.createProgram();
        }

        protected override function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            var loc1:*=false;
            super.beforeDraw(arg1);
            if (this._texture) 
            {
                loc1 = this._textureRepeat && this._texture.root.isPotTexture;
                starling.utils.RenderUtil.setSamplerStateAt(0, this._texture.mipMapping, this._textureSmoothing, loc1);
                arg1.setTextureAt(0, this._texture.base);
                this.vertexFormat.setVertexBufferAt(1, vertexBuffer, "texCoords");
            }
            return;
        }

        protected override function afterDraw(arg1:flash.display3D.Context3D):void
        {
            if (this._texture) 
            {
                arg1.setTextureAt(0, null);
                arg1.setVertexBufferAt(1, null);
            }
            super.afterDraw(arg1);
            return;
        }

        public override function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            this._texture = arg1;
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            this._textureSmoothing = arg1;
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._textureRepeat;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._textureRepeat = arg1;
            return;
        }

        protected static function tex(arg1:String, arg2:String, arg3:int, arg4:starling.textures.Texture, arg5:Boolean=true):String
        {
            return starling.utils.RenderUtil.createAGALTexOperation(arg1, arg2, arg3, arg4, arg5);
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.Effect.VERTEX_FORMAT.extend("texCoords:float2");

        public static const STD_VERTEX_SHADER:String="m44 op, va0, vc0 \n" + "mov v0, va1";

        internal var _texture:starling.textures.Texture;

        internal var _textureSmoothing:String;

        internal var _textureRepeat:Boolean;
    }
}


//    class IndexData
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;
    
    public class IndexData extends Object
    {
        public function IndexData(arg1:int=48)
        {
            super();
            this._numIndices = 0;
            this._initialCapacity = arg1;
            this._useQuadLayout = true;
            return;
        }

        public function set useQuadLayout(arg1:Boolean):void
        {
            if (arg1 != this._useQuadLayout) 
            {
                if (arg1) 
                {
                    this.ensureQuadDataCapacity(this._numIndices);
                    this._rawData.length = 0;
                    this._useQuadLayout = true;
                }
                else 
                {
                    this.switchToGenericData();
                }
            }
            return;
        }

        public function get rawData():flash.utils.ByteArray
        {
            if (this._useQuadLayout) 
            {
                return sQuadData;
            }
            return this._rawData;
        }

        internal static function getBasicQuadIndexAt(arg1:int):int
        {
            var loc3:*=0;
            var loc1:*=arg1 / 6;
            var loc2:*=arg1 - loc1 * 6;
            if (loc2 != 0) 
            {
                if (loc2 == 1 || loc2 == 3) 
                {
                    loc3 = 1;
                }
                else if (loc2 == 2 || loc2 == 5) 
                {
                    loc3 = 2;
                }
                else 
                {
                    loc3 = 3;
                }
            }
            else 
            {
                loc3 = 0;
            }
            return loc1 * 4 + loc3;
        }

        
        {
            sQuadData = new flash.utils.ByteArray();
            sQuadDataNumIndices = 0;
            sVector = new Vector.<uint>(0);
            sTrimData = new flash.utils.ByteArray();
        }

        public function clear():void
        {
            if (this._rawData) 
            {
                this._rawData.clear();
            }
            this._numIndices = 0;
            this._useQuadLayout = true;
            return;
        }

        public function clone():starling.rendering.IndexData
        {
            var loc1:*=new starling.rendering.IndexData(this._numIndices);
            if (!this._useQuadLayout) 
            {
                loc1.switchToGenericData();
                loc1._rawData.writeBytes(this._rawData);
            }
            loc1._numIndices = this._numIndices;
            return loc1;
        }

        public function copyTo(arg1:starling.rendering.IndexData, arg2:int=0, arg3:int=0, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=false;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            if (arg5 < 0 || arg4 + arg5 > this._numIndices) 
            {
                arg5 = this._numIndices - arg4;
            }
            var loc3:*=arg2 + arg5;
            if (arg1._numIndices < loc3) 
            {
                arg1._numIndices = loc3;
                if (sQuadDataNumIndices < loc3) 
                {
                    this.ensureQuadDataCapacity(loc3);
                }
            }
            if (this._useQuadLayout) 
            {
                if (arg1._useQuadLayout) 
                {
                    loc4 = true;
                    loc5 = arg2 - arg4;
                    loc6 = loc5 / 6;
                    loc7 = arg3 / 4;
                    if (loc6 == loc7 && (arg3 & 3) == 0 && loc6 * 6 == loc5) 
                    {
                        loc4 = true;
                    }
                    else if (arg5 > 2) 
                    {
                        loc4 = false;
                    }
                    else 
                    {
                        loc8 = 0;
                        while (loc8 < arg5) 
                        {
                            loc4 = loc4 && getBasicQuadIndexAt(arg4 + loc8) + arg3 == getBasicQuadIndexAt(arg2 + loc8);
                            ++loc8;
                        }
                    }
                    if (loc4) 
                    {
                        return;
                    }
                    arg1.switchToGenericData();
                }
                loc1 = sQuadData;
                loc2 = arg1._rawData;
                if ((arg3 & 3) == 0) 
                {
                    arg4 = arg4 + 6 * arg3 / 4;
                    arg3 = 0;
                    this.ensureQuadDataCapacity(arg4 + arg5);
                }
            }
            else 
            {
                if (arg1._useQuadLayout) 
                {
                    arg1.switchToGenericData();
                }
                loc1 = this._rawData;
                loc2 = arg1._rawData;
            }
            loc2.position = arg2 * INDEX_SIZE;
            if (arg3 != 0) 
            {
                loc1.position = arg4 * INDEX_SIZE;
                while (arg5 > 1) 
                {
                    loc9 = loc1.readUnsignedInt();
                    loc10 = ((loc9 & 4294901760) >> 16) + arg3;
                    loc11 = (loc9 & 65535) + arg3;
                    loc2.writeUnsignedInt(loc10 << 16 | loc11);
                    arg5 = arg5 - 2;
                }
                if (arg5) 
                {
                    loc2.writeShort(loc1.readUnsignedShort() + arg3);
                }
            }
            else 
            {
                loc2.writeBytes(loc1, arg4 * INDEX_SIZE, arg5 * INDEX_SIZE);
            }
            return;
        }

        public function setIndex(arg1:int, arg2:uint):void
        {
            if (this._numIndices < arg1 + 1) 
            {
                this.numIndices = arg1 + 1;
            }
            if (this._useQuadLayout) 
            {
                if (getBasicQuadIndexAt(arg1) == arg2) 
                {
                    return;
                }
                this.switchToGenericData();
            }
            this._rawData.position = arg1 * INDEX_SIZE;
            this._rawData.writeShort(arg2);
            return;
        }

        public function getIndex(arg1:int):int
        {
            if (this._useQuadLayout) 
            {
                if (arg1 < this._numIndices) 
                {
                    return getBasicQuadIndexAt(arg1);
                }
                throw new flash.errors.EOFError();
            }
            this._rawData.position = arg1 * INDEX_SIZE;
            return this._rawData.readUnsignedShort();
        }

        public function offsetIndices(arg1:int, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numIndices) 
            {
                arg3 = this._numIndices - arg2;
            }
            var loc1:*=arg2 + arg3;
            var loc2:*=arg2;
            while (loc2 < loc1) 
            {
                this.setIndex(loc2, this.getIndex(loc2) + arg1);
                ++loc2;
            }
            return;
        }

        public function addTriangle(arg1:uint, arg2:uint, arg3:uint):void
        {
            var loc1:*=false;
            var loc2:*=false;
            if (this._useQuadLayout) 
            {
                if (arg1 == getBasicQuadIndexAt(this._numIndices)) 
                {
                    loc1 = !((this._numIndices & 1) == 0);
                    loc2 = !loc1;
                    if (loc2 && arg2 == arg1 + 1 && arg3 == arg2 + 1 || loc1 && arg3 == arg1 + 1 && arg2 == arg3 + 1) 
                    {
                        this._numIndices = this._numIndices + 3;
                        this.ensureQuadDataCapacity(this._numIndices);
                        return;
                    }
                }
                this.switchToGenericData();
            }
            this._rawData.position = this._numIndices * INDEX_SIZE;
            this._rawData.writeShort(arg1);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg3);
            this._numIndices = this._numIndices + 3;
            return;
        }

        public function addQuad(arg1:uint, arg2:uint, arg3:uint, arg4:uint):void
        {
            if (this._useQuadLayout) 
            {
                if (arg1 == getBasicQuadIndexAt(this._numIndices) && arg2 == arg1 + 1 && arg3 == arg2 + 1 && arg4 == arg3 + 1) 
                {
                    this._numIndices = this._numIndices + 6;
                    this.ensureQuadDataCapacity(this._numIndices);
                    return;
                }
                this.switchToGenericData();
            }
            this._rawData.position = this._numIndices * INDEX_SIZE;
            this._rawData.writeShort(arg1);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg3);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg4);
            this._rawData.writeShort(arg3);
            this._numIndices = this._numIndices + 6;
            return;
        }

        public function toVector(arg1:__AS3__.vec.Vector.<uint>=null):__AS3__.vec.Vector.<uint>
        {
            if (arg1 != null) 
            {
                arg1.length = this._numIndices;
            }
            else 
            {
                arg1 = new Vector.<uint>(this._numIndices);
            }
            var loc1:*=this._useQuadLayout ? sQuadData : this._rawData;
            loc1.position = 0;
            var loc2:*=0;
            while (loc2 < this._numIndices) 
            {
                arg1[loc2] = loc1.readUnsignedShort();
                ++loc2;
            }
            return arg1;
        }

        public function toString():String
        {
            var loc1:*=starling.utils.StringUtil.format("[IndexData numIndices={0} indices=\"{1}\"]", this._numIndices, this.toVector(sVector).join());
            sVector.length = 0;
            return loc1;
        }

        internal function switchToGenericData():void
        {
            if (this._useQuadLayout) 
            {
                this._useQuadLayout = false;
                if (this._rawData == null) 
                {
                    this._rawData = new flash.utils.ByteArray();
                    this._rawData.endian = flash.utils.Endian.LITTLE_ENDIAN;
                    this._rawData.length = this._initialCapacity * INDEX_SIZE;
                    this._rawData.length = this._numIndices * INDEX_SIZE;
                }
                if (this._numIndices) 
                {
                    this._rawData.writeBytes(sQuadData, 0, this._numIndices * INDEX_SIZE);
                }
            }
            return;
        }

        internal function ensureQuadDataCapacity(arg1:int):void
        {
            var loc1:*=0;
            if (sQuadDataNumIndices >= arg1) 
            {
                return;
            }
            var loc2:*=sQuadDataNumIndices / 6;
            var loc3:*=Math.ceil(arg1 / 6);
            sQuadData.endian = flash.utils.Endian.LITTLE_ENDIAN;
            sQuadData.position = sQuadData.length;
            sQuadDataNumIndices = loc3 * 6;
            loc1 = loc2;
            while (loc1 < loc3) 
            {
                sQuadData.writeShort(4 * loc1);
                sQuadData.writeShort(4 * loc1 + 1);
                sQuadData.writeShort(4 * loc1 + 2);
                sQuadData.writeShort(4 * loc1 + 1);
                sQuadData.writeShort(4 * loc1 + 3);
                sQuadData.writeShort(4 * loc1 + 2);
                ++loc1;
            }
            return;
        }

        public function createIndexBuffer(arg1:Boolean=false, arg2:String="staticDraw"):flash.display3D.IndexBuffer3D
        {
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            if (this._numIndices == 0) 
            {
                return null;
            }
            var loc2:*=loc1.createIndexBuffer(this._numIndices, arg2);
            if (arg1) 
            {
                this.uploadToIndexBuffer(loc2);
            }
            return loc2;
        }

        public function uploadToIndexBuffer(arg1:flash.display3D.IndexBuffer3D, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numIndices) 
            {
                arg3 = this._numIndices - arg2;
            }
            if (arg3 > 0) 
            {
                arg1.uploadFromByteArray(this.rawData, 0, arg2, arg3);
            }
            return;
        }

        public function trim():void
        {
            if (this._useQuadLayout) 
            {
                return;
            }
            sTrimData.length = this._rawData.length;
            sTrimData.position = 0;
            sTrimData.writeBytes(this._rawData);
            this._rawData.clear();
            this._rawData.length = sTrimData.length;
            this._rawData.writeBytes(sTrimData);
            sTrimData.clear();
            return;
        }

        public function get numIndices():int
        {
            return this._numIndices;
        }

        public function set numIndices(arg1:int):void
        {
            if (arg1 != this._numIndices) 
            {
                if (this._useQuadLayout) 
                {
                    this.ensureQuadDataCapacity(arg1);
                }
                else 
                {
                    this._rawData.length = arg1 * INDEX_SIZE;
                }
                if (arg1 == 0) 
                {
                    this._useQuadLayout = true;
                }
                this._numIndices = arg1;
            }
            return;
        }

        public function get numTriangles():int
        {
            return this._numIndices / 3;
        }

        public function set numTriangles(arg1:int):void
        {
            this.numIndices = arg1 * 3;
            return;
        }

        public function get numQuads():int
        {
            return this._numIndices / 6;
        }

        public function set numQuads(arg1:int):void
        {
            this.numIndices = arg1 * 6;
            return;
        }

        public function get indexSizeInBytes():int
        {
            return INDEX_SIZE;
        }

        public function get useQuadLayout():Boolean
        {
            return this._useQuadLayout;
        }

        internal static const INDEX_SIZE:int=2;

        internal var _rawData:flash.utils.ByteArray;

        internal var _numIndices:int;

        internal var _initialCapacity:int;

        internal var _useQuadLayout:Boolean;

        internal static var sQuadDataNumIndices:uint=0;

        internal static var sVector:__AS3__.vec.Vector.<uint>;

        internal static var sTrimData:flash.utils.ByteArray;

        internal static var sQuadData:flash.utils.ByteArray;
    }
}


//    class MeshEffect
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.utils.*;
    
    public class MeshEffect extends starling.rendering.FilterEffect
    {
        public function MeshEffect()
        {
            super();
            this._alpha = 1;
            this._optimizeIfNotTinted = flash.utils.getQualifiedClassName(this) == "starling.rendering::MeshEffect";
            return;
        }

        protected override function get programVariantName():uint
        {
            var loc1:*=uint(this._optimizeIfNotTinted && !this._tinted && this._alpha == 1);
            return super.programVariantName | loc1 << 3;
        }

        protected override function createProgram():starling.rendering.Program
        {
            var loc1:*=null;
            var loc2:*=null;
            if (texture) 
            {
                if (this._optimizeIfNotTinted && !this._tinted && this._alpha == 1) 
                {
                    return super.createProgram();
                }
                loc1 = "m44 op, va0, vc0 \n" + "mov v0, va1      \n" + "mul v1, va2, vc4 \n";
                loc2 = tex("ft0", "v0", 0, texture) + "mul oc, ft0, v1  \n";
            }
            else 
            {
                loc1 = "m44 op, va0, vc0 \n" + "mul v0, va2, vc4 \n";
                loc2 = "mov oc, v0       \n";
            }
            return starling.rendering.Program.fromSource(loc1, loc2);
        }

        protected override function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            super.beforeDraw(arg1);
            var loc1:*;
            sRenderAlpha[3] = loc1 = this._alpha;
            sRenderAlpha[2] = loc1 = loc1;
            sRenderAlpha[1] = loc1 = loc1;
            sRenderAlpha[0] = loc1;
            arg1.setProgramConstantsFromVector(flash.display3D.Context3DProgramType.VERTEX, 4, sRenderAlpha);
            if (this._tinted || !(this._alpha == 1) || !this._optimizeIfNotTinted || texture == null) 
            {
                this.vertexFormat.setVertexBufferAt(2, vertexBuffer, "color");
            }
            return;
        }

        protected override function afterDraw(arg1:flash.display3D.Context3D):void
        {
            arg1.setVertexBufferAt(2, null);
            super.afterDraw(arg1);
            return;
        }

        public override function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get tinted():Boolean
        {
            return this._tinted;
        }

        public function set tinted(arg1:Boolean):void
        {
            this._tinted = arg1;
            return;
        }

        
        {
            sRenderAlpha = new Vector.<Number>(4, true);
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.FilterEffect.VERTEX_FORMAT.extend("color:bytes4");

        internal var _alpha:Number;

        internal var _tinted:Boolean;

        internal var _optimizeIfNotTinted:Boolean;

        internal static var sRenderAlpha:__AS3__.vec.Vector.<Number>;
    }
}


//    class Painter
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Painter extends Object
    {
        public function Painter(arg1:flash.display.Stage3D)
        {
            super();
            this._stage3D = arg1;
            this._stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 40, true);
            this._context = this._stage3D.context3D;
            this._shareContext = this._context && !(this._context.driverInfo == "Disposed");
            this._backBufferWidth = this._context ? this._context.backBufferWidth : 0;
            this._backBufferHeight = this._context ? this._context.backBufferHeight : 0;
            var loc1:*;
            this._pixelSize = loc1 = 1;
            this._backBufferScaleFactor = loc1;
            this._stencilReferenceValues = new flash.utils.Dictionary(true);
            this._clipRectStack = new Vector.<flash.geom.Rectangle>(0);
            this._batchProcessorCurr = new BatchProcessor();
            this._batchProcessorCurr.onBatchComplete = this.drawBatch;
            this._batchProcessorPrev = new BatchProcessor();
            this._batchProcessorPrev.onBatchComplete = this.drawBatch;
            this._batchProcessorSpec = new BatchProcessor();
            this._batchProcessorSpec.onBatchComplete = this.drawBatch;
            this._batchProcessor = this._batchProcessorCurr;
            this._batchCacheExclusions = new Vector.<starling.display.DisplayObject>();
            this._state = new starling.rendering.RenderState();
            this._state.onDrawRequired = this.finishMeshBatch;
            this._stateStack = new Vector.<starling.rendering.RenderState>(0);
            this._stateStackPos = -1;
            this._stateStackLength = 0;
            return;
        }

        public function set drawCount(arg1:int):void
        {
            this._drawCount = arg1;
            return;
        }

        public function get stencilReferenceValue():uint
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            if (loc1 in this._stencilReferenceValues) 
            {
                return this._stencilReferenceValues[loc1];
            }
            return 0;
        }

        public function set stencilReferenceValue(arg1:uint):void
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            this._stencilReferenceValues[loc1] = arg1;
            if (this.contextValid) 
            {
                this._context.setStencilReferenceValue(arg1);
            }
            return;
        }

        public function get cacheEnabled():Boolean
        {
            return this._batchProcessor == this._batchProcessorCurr;
        }

        public function set cacheEnabled(arg1:Boolean):void
        {
            if (arg1 != this.cacheEnabled) 
            {
                this.finishMeshBatch();
                if (arg1) 
                {
                    this._batchProcessor = this._batchProcessorCurr;
                }
                else 
                {
                    this._batchProcessor = this._batchProcessorSpec;
                }
            }
            return;
        }

        public function get state():starling.rendering.RenderState
        {
            return this._state;
        }

        public function get stage3D():flash.display.Stage3D
        {
            return this._stage3D;
        }

        public function get context():flash.display3D.Context3D
        {
            return this._context;
        }

        public function set frameID(arg1:uint):void
        {
            this._frameID = arg1;
            return;
        }

        public function get frameID():uint
        {
            return this._batchProcessor != this._batchProcessorCurr ? 0 : this._frameID;
        }

        public function nextFrame():void
        {
            this._batchProcessor = this.swapBatchProcessors();
            this._batchProcessor.clear();
            this._batchProcessorSpec.clear();
            this._actualBlendMode = null;
            this._actualCulling = null;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this.stencilReferenceValue = 0;
            this._clipRectStack.length = 0;
            this._drawCount = 0;
            this._stateStackPos = -1;
            this._state.reset();
            return;
        }

        public function get pixelSize():Number
        {
            return this._pixelSize;
        }

        public function set pixelSize(arg1:Number):void
        {
            this._pixelSize = arg1;
            return;
        }

        public function get shareContext():Boolean
        {
            return this._shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            this._shareContext = arg1;
            return;
        }

        public function get enableErrorChecking():Boolean
        {
            return this._enableErrorChecking;
        }

        public function set enableErrorChecking(arg1:Boolean):void
        {
            this._enableErrorChecking = arg1;
            if (this._context) 
            {
                this._context.enableErrorChecking = arg1;
            }
            return;
        }

        public function get backBufferWidth():int
        {
            return this._backBufferWidth;
        }

        public function get backBufferHeight():int
        {
            return this._backBufferHeight;
        }

        public function get backBufferScaleFactor():Number
        {
            return this._backBufferScaleFactor;
        }

        public function get contextValid():Boolean
        {
            var loc1:*=null;
            if (this._context) 
            {
                loc1 = this._context.driverInfo;
                return !(loc1 == null) && !(loc1 == "") && !(loc1 == "Disposed");
            }
            return false;
        }

        public function get profile():String
        {
            if (this._context) 
            {
                return this._context.profile;
            }
            return null;
        }

        internal function get programs():flash.utils.Dictionary
        {
            var loc1:*=this.sharedData[PROGRAM_DATA_NAME] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                this.sharedData[PROGRAM_DATA_NAME] = loc1;
            }
            return loc1;
        }

        
        {
            sSharedData = new flash.utils.Dictionary();
            sMatrix = new flash.geom.Matrix();
            sPoint3D = new flash.geom.Vector3D();
            sMatrix3D = new flash.geom.Matrix3D();
            sClipRect = new flash.geom.Rectangle();
            sBufferRect = new flash.geom.Rectangle();
            sScissorRect = new flash.geom.Rectangle();
            sMeshSubset = new starling.utils.MeshSubset();
        }

        public function dispose():void
        {
            this._batchProcessorCurr.dispose();
            this._batchProcessorPrev.dispose();
            this._batchProcessorSpec.dispose();
            if (!this._shareContext) 
            {
                this._context.dispose(false);
                sSharedData = new flash.utils.Dictionary();
            }
            return;
        }

        public function requestContext3D(arg1:String, arg2:*):void
        {
            starling.utils.RenderUtil.requestContext3D(this._stage3D, arg1, arg2);
            return;
        }

        internal function onContextCreated(arg1:Object):void
        {
            this._context = this._stage3D.context3D;
            this._context.enableErrorChecking = this._enableErrorChecking;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this._actualBlendMode = null;
            this._actualCulling = null;
            return;
        }

        public function configureBackBuffer(arg1:flash.geom.Rectangle, arg2:Number, arg3:int, arg4:Boolean):void
        {
            if (!this._shareContext) 
            {
                arg4 = arg4 && starling.utils.SystemUtil.supportsDepthAndStencil;
                if (this._context.profile == "baselineConstrained") 
                {
                    this._context.configureBackBuffer(32, 32, arg3, arg4);
                }
                if (arg1.width * arg2 > this._context.maxBackBufferWidth || arg1.height * arg2 > this._context.maxBackBufferHeight) 
                {
                    arg2 = 1;
                }
                this._stage3D.x = arg1.x;
                this._stage3D.y = arg1.y;
                this._context.configureBackBuffer(arg1.width, arg1.height, arg3, arg4, !(arg2 == 1));
            }
            this._backBufferWidth = arg1.width;
            this._backBufferHeight = arg1.height;
            this._backBufferScaleFactor = arg2;
            return;
        }

        public function registerProgram(arg1:String, arg2:starling.rendering.Program):void
        {
            this.deleteProgram(arg1);
            this.programs[arg1] = arg2;
            return;
        }

        public function deleteProgram(arg1:String):void
        {
            var loc1:*=this.getProgram(arg1);
            if (loc1) 
            {
                loc1.dispose();
                delete this.programs[arg1];
            }
            return;
        }

        public function getProgram(arg1:String):starling.rendering.Program
        {
            return this.programs[arg1] as starling.rendering.Program;
        }

        public function hasProgram(arg1:String):Boolean
        {
            return arg1 in this.programs;
        }

        public function pushState(arg1:starling.rendering.BatchToken=null):void
        {
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos + 1);
            loc1._stateStackPos = loc2;
            if (this._stateStackLength < this._stateStackPos + 1) 
            {
                var loc3:*=((loc2 = this)._stateStackLength + 1);
                loc2._stateStackLength = loc3;
                loc1 = (loc2 = this)._stateStackLength;
                this._stateStack[loc1] = new starling.rendering.RenderState();
            }
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            this._stateStack[this._stateStackPos].copyFrom(this._state);
            return;
        }

        public function setStateTo(arg1:flash.geom.Matrix, arg2:Number=1, arg3:String="auto"):void
        {
            if (arg1) 
            {
                starling.utils.MatrixUtil.prependMatrix(this._state._modelviewMatrix, arg1);
            }
            if (arg2 != 1) 
            {
                this._state._alpha = this._state._alpha * arg2;
            }
            if (arg3 != starling.display.BlendMode.AUTO) 
            {
                this._state.blendMode = arg3;
            }
            return;
        }

        public function popState(arg1:starling.rendering.BatchToken=null):void
        {
            if (this._stateStackPos < 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot pop empty state stack");
            }
            this._state.copyFrom(this._stateStack[this._stateStackPos]);
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos - 1);
            loc1._stateStackPos = loc2;
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            return;
        }

        public function drawMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                arg1.getBounds(arg1, sClipRect);
                starling.utils.RectangleUtil.getBounds(sClipRect, sMatrix, sClipRect);
                this.pushClipRect(sClipRect);
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.INCREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue + 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            this.excludeFromCache(arg2);
            return;
        }

        public function eraseMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                this.popClipRect();
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.DECREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue - 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            return;
        }

        internal function renderMask(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this.cacheEnabled;
            this.pushState();
            this.cacheEnabled = false;
            this._state.alpha = 0;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.stage) 
            {
                this._state.setModelviewMatricesToIdentity();
                if (arg1.is3D) 
                {
                    loc3 = arg1.getTransformationMatrix3D(null, sMatrix3D);
                }
                else 
                {
                    loc2 = arg1.getTransformationMatrix(null, sMatrix);
                }
            }
            else if (arg1.is3D) 
            {
                loc3 = arg1.transformationMatrix3D;
            }
            else 
            {
                loc2 = arg1.transformationMatrix;
            }
            if (loc3) 
            {
                this._state.transformModelviewMatrix3D(loc3);
            }
            else 
            {
                this._state.transformModelviewMatrix(loc2);
            }
            arg1.render(this);
            this.finishMeshBatch();
            this.cacheEnabled = loc1;
            this.popState();
            return;
        }

        internal function pushClipRect(arg1:flash.geom.Rectangle):void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            var loc3:*=starling.utils.Pool.getRectangle();
            if (loc2) 
            {
                starling.utils.RectangleUtil.intersect(loc1[(loc2 - 1)], arg1, loc3);
            }
            else 
            {
                loc3.copyFrom(arg1);
            }
            loc1[loc2] = loc3;
            this._state.clipRect = loc3;
            return;
        }

        internal function popClipRect():void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            if (loc2 == 0) 
            {
                throw new Error("Trying to pop from empty clip rectangle stack");
            }
            --loc2;
            starling.utils.Pool.putRectangle(loc1.pop());
            this._state.clipRect = loc2 ? loc1[(loc2 - 1)] : null;
            return;
        }

        internal function isRectangularMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:flash.geom.Matrix):Boolean
        {
            var loc1:*=arg1 as starling.display.Quad;
            var loc2:*=arg1.is3D || arg2 && arg2.is3D && arg1.stage == null;
            if (loc1 && !loc2 && loc1.texture == null) 
            {
                if (arg1.stage) 
                {
                    arg1.getTransformationMatrix(null, arg3);
                }
                else 
                {
                    arg3.copyFrom(arg1.transformationMatrix);
                    arg3.concat(this._state.modelviewMatrix);
                }
                return starling.utils.MathUtil.isEquivalent(arg3.a, 0) && starling.utils.MathUtil.isEquivalent(arg3.d, 0) || starling.utils.MathUtil.isEquivalent(arg3.b, 0) && starling.utils.MathUtil.isEquivalent(arg3.c, 0);
            }
            return false;
        }

        public function batchMesh(arg1:starling.display.Mesh, arg2:starling.utils.MeshSubset=null):void
        {
            this._batchProcessor.addMesh(arg1, this._state, arg2);
            return;
        }

        public function finishMeshBatch():void
        {
            this._batchProcessor.finishBatch();
            return;
        }

        public function finishFrame():void
        {
            if (this._frameID % 99 == 0) 
            {
                this._batchProcessorCurr.trim();
            }
            if (this._frameID % 150 == 0) 
            {
                this._batchProcessorSpec.trim();
            }
            this._batchProcessor.finishBatch();
            this._batchProcessor = this._batchProcessorSpec;
            this.processCacheExclusions();
            return;
        }

        internal function processCacheExclusions():void
        {
            var loc1:*=0;
            var loc2:*=this._batchCacheExclusions.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this._batchCacheExclusions[loc1].starling_internal::excludeFromCache();
                ++loc1;
            }
            this._batchCacheExclusions.length = 0;
            return;
        }

        public function get sharedData():flash.utils.Dictionary
        {
            var loc1:*=sSharedData[this.stage3D] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                sSharedData[this.stage3D] = loc1;
            }
            return loc1;
        }

        internal function swapBatchProcessors():BatchProcessor
        {
            var loc1:*=this._batchProcessorPrev;
            this._batchProcessorPrev = this._batchProcessorCurr;
            var loc2:*;
            this._batchProcessorCurr = loc2 = loc1;
            return loc2;
        }

        public function drawFromCache(arg1:starling.rendering.BatchToken, arg2:starling.rendering.BatchToken):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=sMeshSubset;
            if (!arg1.equals(arg2)) 
            {
                this.pushState();
                loc3 = arg1.batchID;
                while (loc3 <= arg2.batchID) 
                {
                    loc1 = this._batchProcessorPrev.getBatchAt(loc3);
                    loc2.setTo();
                    if (loc3 == arg1.batchID) 
                    {
                        loc2.vertexID = arg1.vertexID;
                        loc2.indexID = arg1.indexID;
                        loc2.numVertices = loc1.numVertices - loc2.vertexID;
                        loc2.numIndices = loc1.numIndices - loc2.indexID;
                    }
                    if (loc3 == arg2.batchID) 
                    {
                        loc2.numVertices = arg2.vertexID - loc2.vertexID;
                        loc2.numIndices = arg2.indexID - loc2.indexID;
                    }
                    if (loc2.numVertices) 
                    {
                        this._state.alpha = 1;
                        this._state.blendMode = loc1.blendMode;
                        this._batchProcessor.addMesh(loc1, this._state, loc2, true);
                    }
                    ++loc3;
                }
                this.popState();
            }
            return;
        }

        public function excludeFromCache(arg1:starling.display.DisplayObject):void
        {
            if (arg1) 
            {
                this._batchCacheExclusions[this._batchCacheExclusions.length] = arg1;
            }
            return;
        }

        internal function drawBatch(arg1:starling.display.MeshBatch):void
        {
            this.pushState();
            this.state.blendMode = arg1.blendMode;
            this.state.modelviewMatrix.identity();
            this.state.alpha = 1;
            arg1.render(this);
            this.popState();
            return;
        }

        public function prepareToDraw():void
        {
            this.applyBlendMode();
            this.applyRenderTarget();
            this.applyClipRect();
            this.applyCulling();
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            this.applyRenderTarget();
            this.stencilReferenceValue = 0;
            starling.utils.RenderUtil.clear(arg1, arg2);
            return;
        }

        public function present():void
        {
            this._state.renderTarget = null;
            this._actualRenderTarget = null;
            this._context.present();
            return;
        }

        internal function applyBlendMode():void
        {
            var loc1:*=this._state.blendMode;
            if (loc1 != this._actualBlendMode) 
            {
                starling.display.BlendMode.get(this._state.blendMode).activate();
                this._actualBlendMode = loc1;
            }
            return;
        }

        internal function applyCulling():void
        {
            var loc1:*=this._state.culling;
            if (loc1 != this._actualCulling) 
            {
                this._context.setCulling(loc1);
                this._actualCulling = loc1;
            }
            return;
        }

        internal function applyRenderTarget():void
        {
            var loc2:*=0;
            var loc3:*=false;
            var loc1:*=this._state.renderTargetBase;
            if (loc1 != this._actualRenderTarget) 
            {
                if (loc1) 
                {
                    loc2 = this._state.renderTargetAntiAlias;
                    loc3 = this._state.renderTargetSupportsDepthAndStencil;
                    this._context.setRenderToTexture(loc1, loc3, loc2);
                }
                else 
                {
                    this._context.setRenderToBackBuffer();
                }
                this._context.setStencilReferenceValue(this.stencilReferenceValue);
                this._actualRenderTarget = loc1;
            }
            return;
        }

        internal function applyClipRect():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._state.clipRect;
            if (loc1) 
            {
                loc4 = this._state.projectionMatrix3D;
                loc5 = this._state.renderTarget;
                if (loc5) 
                {
                    loc2 = loc5.root.nativeWidth;
                    loc3 = loc5.root.nativeHeight;
                }
                else 
                {
                    loc2 = this._backBufferWidth;
                    loc3 = this._backBufferHeight;
                }
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.x, loc1.y, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.x = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.y = (0.5 - sPoint3D.y * 0.5) * loc3;
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.right, loc1.bottom, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.right = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.bottom = (0.5 - sPoint3D.y * 0.5) * loc3;
                sBufferRect.setTo(0, 0, loc2, loc3);
                starling.utils.RectangleUtil.intersect(sClipRect, sBufferRect, sScissorRect);
                if (sScissorRect.width < 1 || sScissorRect.height < 1) 
                {
                    sScissorRect.setTo(0, 0, 1, 1);
                }
                this._context.setScissorRectangle(sScissorRect);
            }
            else 
            {
                this._context.setScissorRectangle(null);
            }
            return;
        }

        public function get drawCount():int
        {
            return this._drawCount;
        }

        internal static const PROGRAM_DATA_NAME:String="starling.rendering.Painter.Programs";

        internal var _context:flash.display3D.Context3D;

        internal var _shareContext:Boolean;

        internal var _drawCount:int;

        internal var _frameID:uint;

        internal var _pixelSize:Number;

        internal var _enableErrorChecking:Boolean;

        internal var _stencilReferenceValues:flash.utils.Dictionary;

        internal var _clipRectStack:__AS3__.vec.Vector.<flash.geom.Rectangle>;

        internal var _batchCacheExclusions:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _batchProcessorCurr:BatchProcessor;

        internal var _batchProcessorPrev:BatchProcessor;

        internal var _batchProcessorSpec:BatchProcessor;

        internal var _actualRenderTarget:flash.display3D.textures.TextureBase;

        internal var _actualCulling:String;

        internal var _actualBlendMode:String;

        internal var _backBufferWidth:Number;

        internal var _backBufferHeight:Number;

        internal var _backBufferScaleFactor:Number;

        internal var _state:starling.rendering.RenderState;

        internal var _stateStack:__AS3__.vec.Vector.<starling.rendering.RenderState>;

        internal var _stateStackPos:int;

        internal var _stateStackLength:int;

        internal var _stage3D:flash.display.Stage3D;

        internal static var sSharedData:flash.utils.Dictionary;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sClipRect:flash.geom.Rectangle;

        internal static var sBufferRect:flash.geom.Rectangle;

        internal static var sScissorRect:flash.geom.Rectangle;

        internal static var sMeshSubset:starling.utils.MeshSubset;

        internal var _batchProcessor:BatchProcessor;
    }
}


//    class Program
package starling.rendering 
{
    import com.adobe.utils.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    
    public class Program extends Object
    {
        public function Program(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray)
        {
            super();
            this._vertexShader = arg1;
            this._fragmentShader = arg2;
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 30, true);
            return;
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.disposeProgram();
            return;
        }

        public function activate(arg1:flash.display3D.Context3D=null):void
        {
            if (arg1 == null) 
            {
                arg1 = starling.core.Starling.context;
                if (arg1 == null) 
                {
                    throw new starling.errors.MissingContextError();
                }
            }
            if (this._program3D == null) 
            {
                this._program3D = arg1.createProgram();
                this._program3D.upload(this._vertexShader, this._fragmentShader);
            }
            arg1.setProgram(this._program3D);
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.disposeProgram();
            return;
        }

        internal function disposeProgram():void
        {
            if (this._program3D) 
            {
                this._program3D.dispose();
                this._program3D = null;
            }
            return;
        }

        public static function fromSource(arg1:String, arg2:String, arg3:uint=1):starling.rendering.Program
        {
            return new Program(sAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, arg1, arg3), sAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, arg2, arg3));
        }

        
        {
            sAssembler = new com.adobe.utils.AGALMiniAssembler();
        }

        internal var _vertexShader:flash.utils.ByteArray;

        internal var _fragmentShader:flash.utils.ByteArray;

        internal var _program3D:flash.display3D.Program3D;

        internal static var sAssembler:com.adobe.utils.AGALMiniAssembler;
    }
}


//    class RenderState
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class RenderState extends Object
    {
        public function RenderState()
        {
            super();
            this.reset();
            return;
        }

        function get renderTargetBase():flash.display3D.textures.TextureBase
        {
            return this._renderTarget ? this._renderTarget.base : null;
        }

        public function get culling():String
        {
            var loc1:*=(this._miscOptions & 3840) >> 8;
            return CULLING_VALUES[loc1];
        }

        public function set culling(arg1:String):void
        {
            var loc1:*=0;
            if (this.culling != arg1) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                loc1 = CULLING_VALUES.indexOf(arg1);
                if (loc1 == -1) 
                {
                    throw new ArgumentError("Invalid culling mode");
                }
                this._miscOptions = this._miscOptions & 4294963455 | loc1 << 8;
            }
            return;
        }

        public function get clipRect():flash.geom.Rectangle
        {
            return this._clipRect;
        }

        public function get projectionMatrix3D():flash.geom.Matrix3D
        {
            return this._projectionMatrix3D;
        }

        public function set clipRect(arg1:flash.geom.Rectangle):void
        {
            if (!starling.utils.RectangleUtil.compare(this._clipRect, arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                if (arg1) 
                {
                    if (this._clipRect == null) 
                    {
                        this._clipRect = starling.utils.Pool.getRectangle();
                    }
                    this._clipRect.copyFrom(arg1);
                }
                else if (this._clipRect) 
                {
                    starling.utils.Pool.putRectangle(this._clipRect);
                    this._clipRect = null;
                }
            }
            return;
        }

        public function get renderTargetAntiAlias():int
        {
            return this._miscOptions & 15;
        }

        public function get renderTargetSupportsDepthAndStencil():Boolean
        {
            return !((this._miscOptions & 240) == 0);
        }

        public function get is3D():Boolean
        {
            return !(this._modelviewMatrix3D == null);
        }

        function set onDrawRequired(arg1:Function):void
        {
            this._onDrawRequired = arg1;
            return;
        }

        
        {
            new Vector.<String>(4)[0] = flash.display3D.Context3DTriangleFace.NONE;
            new Vector.<String>(4)[1] = flash.display3D.Context3DTriangleFace.FRONT;
            new Vector.<String>(4)[2] = flash.display3D.Context3DTriangleFace.BACK;
            new Vector.<String>(4)[3] = flash.display3D.Context3DTriangleFace.FRONT_AND_BACK;
            sMatrix3D = new flash.geom.Matrix3D();
            sProjectionMatrix3DRev = 0;
        }

        public function copyFrom(arg1:starling.rendering.RenderState):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            if (this._onDrawRequired != null) 
            {
                loc1 = this._renderTarget ? this._renderTarget.base : null;
                loc2 = arg1._renderTarget ? arg1._renderTarget.base : null;
                loc3 = !((this._miscOptions & 3840) == (arg1._miscOptions & 3840));
                loc4 = this._clipRect || arg1._clipRect ? !starling.utils.RectangleUtil.compare(this._clipRect, arg1._clipRect) : false;
                if (!(this._blendMode == arg1._blendMode) || !(loc1 == loc2) || loc4 || loc3) 
                {
                    this._onDrawRequired();
                }
            }
            this._alpha = arg1._alpha;
            this._blendMode = arg1._blendMode;
            this._renderTarget = arg1._renderTarget;
            this._miscOptions = arg1._miscOptions;
            this._modelviewMatrix.copyFrom(arg1._modelviewMatrix);
            if (this._projectionMatrix3DRev != arg1._projectionMatrix3DRev) 
            {
                this._projectionMatrix3DRev = arg1._projectionMatrix3DRev;
                this._projectionMatrix3D.copyFrom(arg1._projectionMatrix3D);
            }
            if (this._modelviewMatrix3D || arg1._modelviewMatrix3D) 
            {
                this.modelviewMatrix3D = arg1._modelviewMatrix3D;
            }
            if (this._clipRect || arg1._clipRect) 
            {
                this.clipRect = arg1._clipRect;
            }
            return;
        }

        public function reset():void
        {
            this.alpha = 1;
            this.blendMode = starling.display.BlendMode.NORMAL;
            this.culling = flash.display3D.Context3DTriangleFace.NONE;
            this.modelviewMatrix3D = null;
            this.renderTarget = null;
            this.clipRect = null;
            this._projectionMatrix3DRev = 0;
            if (this._modelviewMatrix) 
            {
                this._modelviewMatrix.identity();
            }
            else 
            {
                this._modelviewMatrix = new flash.geom.Matrix();
            }
            if (this._projectionMatrix3D) 
            {
                this._projectionMatrix3D.identity();
            }
            else 
            {
                this._projectionMatrix3D = new flash.geom.Matrix3D();
            }
            if (this._mvpMatrix3D == null) 
            {
                this._mvpMatrix3D = new flash.geom.Matrix3D();
            }
            return;
        }

        public function transformModelviewMatrix(arg1:flash.geom.Matrix):void
        {
            starling.utils.MatrixUtil.prependMatrix(this._modelviewMatrix, arg1);
            return;
        }

        public function transformModelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (this._modelviewMatrix3D == null) 
            {
                this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D();
            }
            this._modelviewMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            this._modelviewMatrix3D.prepend(arg1);
            this._modelviewMatrix.identity();
            return;
        }

        public function setProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null):void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            starling.utils.MatrixUtil.createPerspectiveProjectionMatrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, this._projectionMatrix3D);
            return;
        }

        public function setProjectionMatrixChanged():void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            return;
        }

        public function setModelviewMatricesToIdentity():void
        {
            this._modelviewMatrix.identity();
            if (this._modelviewMatrix3D) 
            {
                this._modelviewMatrix3D.identity();
            }
            return;
        }

        public function get modelviewMatrix():flash.geom.Matrix
        {
            return this._modelviewMatrix;
        }

        public function set modelviewMatrix(arg1:flash.geom.Matrix):void
        {
            this._modelviewMatrix.copyFrom(arg1);
            return;
        }

        public function get modelviewMatrix3D():flash.geom.Matrix3D
        {
            return this._modelviewMatrix3D;
        }

        public function set modelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                if (this._modelviewMatrix3D == null) 
                {
                    this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D(false);
                }
                this._modelviewMatrix3D.copyFrom(arg1);
            }
            else if (this._modelviewMatrix3D) 
            {
                starling.utils.Pool.putMatrix3D(this._modelviewMatrix3D);
                this._modelviewMatrix3D = null;
            }
            return;
        }

        function get onDrawRequired():Function
        {
            return this._onDrawRequired;
        }

        public function set projectionMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this.setProjectionMatrixChanged();
            this._projectionMatrix3D.copyFrom(arg1);
            return;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            this._mvpMatrix3D.copyFrom(this._projectionMatrix3D);
            if (this._modelviewMatrix3D) 
            {
                this._mvpMatrix3D.prepend(this._modelviewMatrix3D);
            }
            this._mvpMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            return this._mvpMatrix3D;
        }

        public function setRenderTarget(arg1:starling.textures.Texture, arg2:Boolean=true, arg3:int=0):void
        {
            var loc1:*=this._renderTarget ? this._renderTarget.base : null;
            var loc2:*=arg1 ? arg1.base : null;
            var loc3:*=starling.utils.MathUtil.min(arg3, 16) | uint(arg2) << 4;
            var loc4:*=!(loc3 == (this._miscOptions & 255));
            if (!(loc1 == loc2) || loc4) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._renderTarget = arg1;
                this._miscOptions = this._miscOptions & 4294967040 | loc3;
            }
            return;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get blendMode():String
        {
            return this._blendMode;
        }

        public function set blendMode(arg1:String):void
        {
            if (!(arg1 == starling.display.BlendMode.AUTO) && !(this._blendMode == arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._blendMode = arg1;
            }
            return;
        }

        public function get renderTarget():starling.textures.Texture
        {
            return this._renderTarget;
        }

        public function set renderTarget(arg1:starling.textures.Texture):void
        {
            this.setRenderTarget(arg1);
            return;
        }

        internal static const CULLING_VALUES:__AS3__.vec.Vector.<String>=new Vector.<String>(4);

        var _alpha:Number;

        var _blendMode:String;

        var _modelviewMatrix:flash.geom.Matrix;

        internal var _miscOptions:uint;

        internal var _renderTarget:starling.textures.Texture;

        internal var _onDrawRequired:Function;

        internal var _modelviewMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3DRev:uint;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sProjectionMatrix3DRev:uint=0;

        internal var _clipRect:flash.geom.Rectangle;
    }
}


//    class VertexData
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class VertexData extends Object
    {
        public function VertexData(arg1:*=null, arg2:int=32)
        {
            super();
            if (arg1 != null) 
            {
                if (arg1 is starling.rendering.VertexDataFormat) 
                {
                    this._format = arg1;
                }
                else if (arg1 is String) 
                {
                    this._format = starling.rendering.VertexDataFormat.fromString(arg1 as String);
                }
                else 
                {
                    throw new ArgumentError("\'format\' must be String or VertexDataFormat");
                }
            }
            else 
            {
                this._format = starling.styles.MeshStyle.VERTEX_FORMAT;
            }
            this._attributes = this._format.attributes;
            this._numAttributes = this._attributes.length;
            this._posOffset = this._format.hasAttribute("position") ? this._format.getOffset("position") : 0;
            this._colOffset = this._format.hasAttribute("color") ? this._format.getOffset("color") : 0;
            this._vertexSize = this._format.vertexSize;
            this._numVertices = 0;
            this._premultipliedAlpha = true;
            this._rawData = new flash.utils.ByteArray();
            var loc1:*;
            sBytes.endian = loc1 = flash.utils.Endian.LITTLE_ENDIAN;
            this._rawData.endian = loc1;
            this._rawData.length = arg2 * this._vertexSize;
            this._rawData.length = 0;
            return;
        }

        public function set tinted(arg1:Boolean):void
        {
            this._tinted = arg1;
            return;
        }

        public function get formatString():String
        {
            return this._format.formatString;
        }

        public function get vertexSize():int
        {
            return this._vertexSize;
        }

        public function get vertexSizeIn32Bits():int
        {
            return this._vertexSize / 4;
        }

        public function get size():int
        {
            return this._numVertices * this._vertexSize;
        }

        public function get sizeIn32Bits():int
        {
            return this._numVertices * this._vertexSize / 4;
        }

        internal static function switchEndian(arg1:uint):uint
        {
            return (arg1 & 255) << 24 | (arg1 >> 8 & 255) << 16 | (arg1 >> 16 & 255) << 8 | arg1 >> 24 & 255;
        }

        public function trim():void
        {
            var loc1:*=this._numVertices * this._vertexSize;
            sBytes.length = loc1;
            sBytes.position = 0;
            sBytes.writeBytes(this._rawData, 0, loc1);
            this._rawData.clear();
            this._rawData.length = loc1;
            this._rawData.writeBytes(sBytes);
            sBytes.clear();
            return;
        }

        internal static function premultiplyAlpha(arg1:uint):uint
        {
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1 & 255;
            if (loc1 == 255) 
            {
                return arg1;
            }
            loc2 = loc1 / 255;
            loc3 = (arg1 >> 24 & 255) * loc2;
            loc4 = (arg1 >> 16 & 255) * loc2;
            loc5 = (arg1 >> 8 & 255) * loc2;
            return (loc3 & 255) << 24 | (loc4 & 255) << 16 | (loc5 & 255) << 8 | loc1;
        }

        internal static function unmultiplyAlpha(arg1:uint):uint
        {
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1 & 255;
            if (loc1 == 255 || loc1 == 0) 
            {
                return arg1;
            }
            loc2 = loc1 / 255;
            loc3 = (arg1 >> 24 & 255) / loc2;
            loc4 = (arg1 >> 16 & 255) / loc2;
            loc5 = (arg1 >> 8 & 255) / loc2;
            return (loc3 & 255) << 24 | (loc4 & 255) << 16 | (loc5 & 255) << 8 | loc1;
        }

        public function clear():void
        {
            this._rawData.clear();
            this._numVertices = 0;
            this._tinted = false;
            return;
        }

        public function clone():starling.rendering.VertexData
        {
            var loc1:*=new starling.rendering.VertexData(this._format, this._numVertices);
            loc1._rawData.writeBytes(this._rawData);
            loc1._numVertices = this._numVertices;
            loc1._premultipliedAlpha = this._premultipliedAlpha;
            loc1._tinted = this._tinted;
            return loc1;
        }

        public function copyTo(arg1:starling.rendering.VertexData, arg2:int=0, arg3:flash.geom.Matrix=null, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            if (this._format !== arg1._format) 
            {
                if (arg1._numVertices < arg2 + arg5) 
                {
                    arg1.numVertices = arg2 + arg5;
                }
                loc6 = 0;
                while (loc6 < this._numAttributes) 
                {
                    loc7 = this._attributes[loc6];
                    loc8 = arg1.getAttribute(loc7.name);
                    if (loc8) 
                    {
                        if (loc7.offset != this._posOffset) 
                        {
                            this.copyAttributeTo_internal(arg1, arg2, null, loc7, loc8, arg4, arg5);
                        }
                        else 
                        {
                            this.copyAttributeTo_internal(arg1, arg2, arg3, loc7, loc8, arg4, arg5);
                        }
                    }
                    ++loc6;
                }
            }
            else 
            {
                if (arg1._numVertices < arg2 + arg5) 
                {
                    arg1._numVertices = arg2 + arg5;
                }
                arg1._tinted = arg1._tinted || this._tinted;
                loc1 = arg1._rawData;
                loc1.position = arg2 * this._vertexSize;
                loc1.writeBytes(this._rawData, arg4 * this._vertexSize, arg5 * this._vertexSize);
                if (arg3) 
                {
                    loc4 = arg2 * this._vertexSize + this._posOffset;
                    loc5 = loc4 + arg5 * this._vertexSize;
                    while (loc4 < loc5) 
                    {
                        loc1.position = loc4;
                        loc2 = loc1.readFloat();
                        loc3 = loc1.readFloat();
                        loc1.position = loc4;
                        loc1.writeFloat(arg3.a * loc2 + arg3.c * loc3 + arg3.tx);
                        loc1.writeFloat(arg3.d * loc3 + arg3.b * loc2 + arg3.ty);
                        loc4 = loc4 + this._vertexSize;
                    }
                }
            }
            return;
        }

        public function copyAttributeTo(arg1:starling.rendering.VertexData, arg2:int, arg3:String, arg4:flash.geom.Matrix=null, arg5:int=0, arg6:int=-1):void
        {
            var loc1:*=this.getAttribute(arg3);
            var loc2:*=arg1.getAttribute(arg3);
            if (loc1 == null) 
            {
                throw new ArgumentError("Attribute \'" + arg3 + "\' not found in source data");
            }
            if (loc2 == null) 
            {
                throw new ArgumentError("Attribute \'" + arg3 + "\' not found in target data");
            }
            if (loc1.isColor) 
            {
                arg1._tinted = arg1._tinted || this._tinted;
            }
            this.copyAttributeTo_internal(arg1, arg2, arg4, loc1, loc2, arg5, arg6);
            return;
        }

        internal function copyAttributeTo_internal(arg1:starling.rendering.VertexData, arg2:int, arg3:flash.geom.Matrix, arg4:VertexDataAttribute, arg5:VertexDataAttribute, arg6:int, arg7:int):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (arg4.format != arg5.format) 
            {
                throw new flash.errors.IllegalOperationError("Attribute formats differ between source and target");
            }
            if (arg7 < 0 || arg6 + arg7 > this._numVertices) 
            {
                arg7 = this._numVertices - arg6;
            }
            if (arg1._numVertices < arg2 + arg7) 
            {
                arg1._numVertices = arg2 + arg7;
            }
            var loc5:*=this._rawData;
            var loc6:*=arg1._rawData;
            var loc7:*=this._vertexSize - arg4.size;
            var loc8:*=arg1._vertexSize - arg5.size;
            var loc9:*=arg4.size / 4;
            loc5.position = arg6 * this._vertexSize + arg4.offset;
            loc6.position = arg2 * arg1._vertexSize + arg5.offset;
            if (arg3) 
            {
                loc1 = 0;
                while (loc1 < arg7) 
                {
                    loc3 = loc5.readFloat();
                    loc4 = loc5.readFloat();
                    loc6.writeFloat(arg3.a * loc3 + arg3.c * loc4 + arg3.tx);
                    loc6.writeFloat(arg3.d * loc4 + arg3.b * loc3 + arg3.ty);
                    loc5.position = loc5.position + loc7;
                    loc6.position = loc6.position + loc8;
                    ++loc1;
                }
            }
            else 
            {
                loc1 = 0;
                while (loc1 < arg7) 
                {
                    loc2 = 0;
                    while (loc2 < loc9) 
                    {
                        loc6.writeUnsignedInt(loc5.readUnsignedInt());
                        ++loc2;
                    }
                    loc5.position = loc5.position + loc7;
                    loc6.position = loc6.position + loc8;
                    ++loc1;
                }
            }
            return;
        }

        
        {
            sHelperPoint = new flash.geom.Point();
            sHelperPoint3D = new flash.geom.Vector3D();
            sBytes = new flash.utils.ByteArray();
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[VertexData format=\"{0}\" numVertices={1}]", this._format.formatString, this._numVertices);
        }

        public function getUnsignedInt(arg1:int, arg2:String):uint
        {
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            return this._rawData.readUnsignedInt();
        }

        public function setUnsignedInt(arg1:int, arg2:String, arg3:uint):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeUnsignedInt(arg3);
            return;
        }

        public function getFloat(arg1:int, arg2:String):Number
        {
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            return this._rawData.readFloat();
        }

        public function setFloat(arg1:int, arg2:String, arg3:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            return;
        }

        public function getPoint(arg1:int, arg2:String, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=arg2 != "position" ? this.getAttribute(arg2).offset : this._posOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint(arg1:int, arg2:String, arg3:Number, arg4:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=arg2 != "position" ? this.getAttribute(arg2).offset : this._posOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            return;
        }

        public function getPoint3D(arg1:int, arg2:String, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Vector3D();
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            arg3.z = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint3D(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            this._rawData.writeFloat(arg5);
            return;
        }

        public function getPoint4D(arg1:int, arg2:String, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Vector3D();
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            arg3.z = this._rawData.readFloat();
            arg3.w = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint4D(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number, arg6:Number=1):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            this._rawData.writeFloat(arg5);
            this._rawData.writeFloat(arg6);
            return;
        }

        public function getColor(arg1:int, arg2:String="color"):uint
        {
            var loc1:*=arg2 != "color" ? this.getAttribute(arg2).offset : this._colOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            var loc2:*=switchEndian(this._rawData.readUnsignedInt());
            if (this._premultipliedAlpha) 
            {
                loc2 = unmultiplyAlpha(loc2);
            }
            return loc2 >> 8 & 16777215;
        }

        public function setColor(arg1:int, arg2:String, arg3:uint):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=this.getAlpha(arg1, arg2);
            this.colorize(arg2, arg3, loc1, arg1, 1);
            return;
        }

        public function getAlpha(arg1:int, arg2:String="color"):Number
        {
            var loc1:*=arg2 != "color" ? this.getAttribute(arg2).offset : this._colOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            var loc2:*=switchEndian(this._rawData.readUnsignedInt());
            return (loc2 & 255) / 255;
        }

        public function setAlpha(arg1:int, arg2:String, arg3:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=this.getColor(arg1, arg2);
            this.colorize(arg2, loc1, arg3, arg1, 1);
            return;
        }

        public function getBounds(arg1:String="position", arg2:flash.geom.Matrix=null, arg3:int=0, arg4:int=-1, arg5:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Rectangle();
            }
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            if (arg4 != 0) 
            {
                loc1 = Number.MAX_VALUE;
                loc2 = -Number.MAX_VALUE;
                loc3 = Number.MAX_VALUE;
                loc4 = -Number.MAX_VALUE;
                loc5 = arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
                loc6 = arg3 * this._vertexSize + loc5;
                if (arg2 != null) 
                {
                    loc9 = 0;
                    while (loc9 < arg4) 
                    {
                        this._rawData.position = loc6;
                        loc7 = this._rawData.readFloat();
                        loc8 = this._rawData.readFloat();
                        loc6 = loc6 + this._vertexSize;
                        starling.utils.MatrixUtil.transformCoords(arg2, loc7, loc8, sHelperPoint);
                        if (loc1 > sHelperPoint.x) 
                        {
                            loc1 = sHelperPoint.x;
                        }
                        if (loc2 < sHelperPoint.x) 
                        {
                            loc2 = sHelperPoint.x;
                        }
                        if (loc3 > sHelperPoint.y) 
                        {
                            loc3 = sHelperPoint.y;
                        }
                        if (loc4 < sHelperPoint.y) 
                        {
                            loc4 = sHelperPoint.y;
                        }
                        ++loc9;
                    }
                }
                else 
                {
                    loc9 = 0;
                    while (loc9 < arg4) 
                    {
                        this._rawData.position = loc6;
                        loc7 = this._rawData.readFloat();
                        loc8 = this._rawData.readFloat();
                        loc6 = loc6 + this._vertexSize;
                        if (loc1 > loc7) 
                        {
                            loc1 = loc7;
                        }
                        if (loc2 < loc7) 
                        {
                            loc2 = loc7;
                        }
                        if (loc3 > loc8) 
                        {
                            loc3 = loc8;
                        }
                        if (loc4 < loc8) 
                        {
                            loc4 = loc8;
                        }
                        ++loc9;
                    }
                }
                arg5.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            else if (arg2 != null) 
            {
                starling.utils.MatrixUtil.transformCoords(arg2, 0, 0, sHelperPoint);
                arg5.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            else 
            {
                arg5.setEmpty();
            }
            return arg5;
        }

        public function getBoundsProjected(arg1:String, arg2:flash.geom.Matrix3D, arg3:flash.geom.Vector3D, arg4:int=0, arg5:int=-1, arg6:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (arg6 == null) 
            {
                arg6 = new flash.geom.Rectangle();
            }
            if (arg3 == null) 
            {
                throw new ArgumentError("camPos must not be null");
            }
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            if (arg5 != 0) 
            {
                loc1 = Number.MAX_VALUE;
                loc2 = -Number.MAX_VALUE;
                loc3 = Number.MAX_VALUE;
                loc4 = -Number.MAX_VALUE;
                loc5 = arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
                loc6 = arg4 * this._vertexSize + loc5;
                loc9 = 0;
                while (loc9 < arg5) 
                {
                    this._rawData.position = loc6;
                    loc7 = this._rawData.readFloat();
                    loc8 = this._rawData.readFloat();
                    loc6 = loc6 + this._vertexSize;
                    if (arg2) 
                    {
                        starling.utils.MatrixUtil.transformCoords3D(arg2, loc7, loc8, 0, sHelperPoint3D);
                    }
                    else 
                    {
                        sHelperPoint3D.setTo(loc7, loc8, 0);
                    }
                    starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sHelperPoint3D, sHelperPoint);
                    if (loc1 > sHelperPoint.x) 
                    {
                        loc1 = sHelperPoint.x;
                    }
                    if (loc2 < sHelperPoint.x) 
                    {
                        loc2 = sHelperPoint.x;
                    }
                    if (loc3 > sHelperPoint.y) 
                    {
                        loc3 = sHelperPoint.y;
                    }
                    if (loc4 < sHelperPoint.y) 
                    {
                        loc4 = sHelperPoint.y;
                    }
                    ++loc9;
                }
                arg6.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            else 
            {
                if (arg2) 
                {
                    starling.utils.MatrixUtil.transformCoords3D(arg2, 0, 0, 0, sHelperPoint3D);
                }
                else 
                {
                    sHelperPoint3D.setTo(0, 0, 0);
                }
                starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sHelperPoint3D, sHelperPoint);
                arg6.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            return arg6;
        }

        public function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public function set premultipliedAlpha(arg1:Boolean):void
        {
            this.setPremultipliedAlpha(arg1, false);
            return;
        }

        public function setPremultipliedAlpha(arg1:Boolean, arg2:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            if (arg2 && !(arg1 == this._premultipliedAlpha)) 
            {
                loc1 = 0;
                while (loc1 < this._numAttributes) 
                {
                    loc2 = this._attributes[loc1];
                    if (loc2.isColor) 
                    {
                        loc3 = loc2.offset;
                        loc6 = 0;
                        while (loc6 < this._numVertices) 
                        {
                            this._rawData.position = loc3;
                            loc4 = switchEndian(this._rawData.readUnsignedInt());
                            loc5 = arg1 ? premultiplyAlpha(loc4) : unmultiplyAlpha(loc4);
                            this._rawData.position = loc3;
                            this._rawData.writeUnsignedInt(switchEndian(loc5));
                            loc3 = loc3 + this._vertexSize;
                            ++loc6;
                        }
                    }
                    ++loc1;
                }
            }
            this._premultipliedAlpha = arg1;
            return;
        }

        public function updateTinted(arg1:String="color"):Boolean
        {
            var loc1:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            this._tinted = false;
            var loc2:*=0;
            while (loc2 < this._numVertices) 
            {
                this._rawData.position = loc1;
                if (this._rawData.readUnsignedInt() != 4294967295) 
                {
                    this._tinted = true;
                    break;
                }
                loc1 = loc1 + this._vertexSize;
                ++loc2;
            }
            return this._tinted;
        }

        public function transformPoints(arg1:String, arg2:flash.geom.Matrix, arg3:int=0, arg4:int=-1):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            var loc3:*=arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
            var loc4:*=arg3 * this._vertexSize + loc3;
            var loc5:*=loc4 + arg4 * this._vertexSize;
            while (loc4 < loc5) 
            {
                this._rawData.position = loc4;
                loc1 = this._rawData.readFloat();
                loc2 = this._rawData.readFloat();
                this._rawData.position = loc4;
                this._rawData.writeFloat(arg2.a * loc1 + arg2.c * loc2 + arg2.tx);
                this._rawData.writeFloat(arg2.d * loc2 + arg2.b * loc1 + arg2.ty);
                loc4 = loc4 + this._vertexSize;
            }
            return;
        }

        public function translatePoints(arg1:String, arg2:Number, arg3:Number, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            var loc3:*=arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
            var loc4:*=arg4 * this._vertexSize + loc3;
            var loc5:*=loc4 + arg5 * this._vertexSize;
            while (loc4 < loc5) 
            {
                this._rawData.position = loc4;
                loc1 = this._rawData.readFloat();
                loc2 = this._rawData.readFloat();
                this._rawData.position = loc4;
                this._rawData.writeFloat(loc1 + arg2);
                this._rawData.writeFloat(loc2 + arg3);
                loc4 = loc4 + this._vertexSize;
            }
            return;
        }

        public function scaleAlphas(arg1:String, arg2:Number, arg3:int=0, arg4:int=-1):void
        {
            var loc1:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=0;
            if (arg2 == 1) 
            {
                return;
            }
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            this._tinted = true;
            var loc2:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            var loc3:*=arg3 * this._vertexSize + loc2;
            loc1 = 0;
            while (loc1 < arg4) 
            {
                loc4 = loc3 + 3;
                loc5 = this._rawData[loc4] / 255 * arg2;
                if (loc5 > 1) 
                {
                    loc5 = 1;
                }
                else if (loc5 < 0) 
                {
                    loc5 = 0;
                }
                if (loc5 == 1 || !this._premultipliedAlpha) 
                {
                    this._rawData[loc4] = int(loc5 * 255);
                }
                else 
                {
                    this._rawData.position = loc3;
                    loc6 = unmultiplyAlpha(switchEndian(this._rawData.readUnsignedInt()));
                    loc6 = loc6 & 4294967040 | int(loc5 * 255) & 255;
                    loc6 = premultiplyAlpha(loc6);
                    this._rawData.position = loc3;
                    this._rawData.writeUnsignedInt(switchEndian(loc6));
                }
                loc3 = loc3 + this._vertexSize;
                ++loc1;
            }
            return;
        }

        public function colorize(arg1:String="color", arg2:uint=16777215, arg3:Number=1, arg4:int=0, arg5:int=-1):void
        {
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            var loc1:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            var loc2:*=arg4 * this._vertexSize + loc1;
            var loc3:*=loc2 + arg5 * this._vertexSize;
            if (arg3 > 1) 
            {
                arg3 = 1;
            }
            else if (arg3 < 0) 
            {
                arg3 = 0;
            }
            var loc4:*=arg2 << 8 & 4294967040 | int(arg3 * 255) & 255;
            if (loc4 == 4294967295 && arg5 == this._numVertices) 
            {
                this._tinted = false;
            }
            else if (loc4 != 4294967295) 
            {
                this._tinted = true;
            }
            if (this._premultipliedAlpha && !(arg3 == 1)) 
            {
                loc4 = premultiplyAlpha(loc4);
            }
            this._rawData.position = arg4 * this._vertexSize + loc1;
            this._rawData.writeUnsignedInt(switchEndian(loc4));
            while (loc2 < loc3) 
            {
                this._rawData.position = loc2;
                this._rawData.writeUnsignedInt(switchEndian(loc4));
                loc2 = loc2 + this._vertexSize;
            }
            return;
        }

        public function getFormat(arg1:String):String
        {
            return this.getAttribute(arg1).format;
        }

        public function getSize(arg1:String):int
        {
            return this.getAttribute(arg1).size;
        }

        public function getSizeIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).size / 4;
        }

        public function getOffset(arg1:String):int
        {
            return this.getAttribute(arg1).offset;
        }

        public function getOffsetIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).offset / 4;
        }

        public function hasAttribute(arg1:String):Boolean
        {
            return !(this.getAttribute(arg1) == null);
        }

        public function createVertexBuffer(arg1:Boolean=false, arg2:String="staticDraw"):flash.display3D.VertexBuffer3D
        {
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            if (this._numVertices == 0) 
            {
                return null;
            }
            var loc2:*=loc1.createVertexBuffer(this._numVertices, this._vertexSize / 4, arg2);
            if (arg1) 
            {
                this.uploadToVertexBuffer(loc2);
            }
            return loc2;
        }

        public function uploadToVertexBuffer(arg1:flash.display3D.VertexBuffer3D, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numVertices) 
            {
                arg3 = this._numVertices - arg2;
            }
            if (arg3 > 0) 
            {
                arg1.uploadFromByteArray(this._rawData, 0, arg2, arg3);
            }
            return;
        }

        internal final function getAttribute(arg1:String):VertexDataAttribute
        {
            var loc1:*=0;
            var loc2:*=null;
            loc1 = 0;
            while (loc1 < this._numAttributes) 
            {
                loc2 = this._attributes[loc1];
                if (loc2.name == arg1) 
                {
                    return loc2;
                }
                ++loc1;
            }
            return null;
        }

        public function get numVertices():int
        {
            return this._numVertices;
        }

        public function set numVertices(arg1:int):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            if (arg1 > this._numVertices) 
            {
                loc1 = this._numVertices * this.vertexSize;
                loc2 = arg1 * this._vertexSize;
                if (this._rawData.length > loc1) 
                {
                    this._rawData.position = loc1;
                    while (this._rawData.bytesAvailable) 
                    {
                        this._rawData.writeUnsignedInt(0);
                    }
                }
                if (this._rawData.length < loc2) 
                {
                    this._rawData.length = loc2;
                }
                loc3 = 0;
                while (loc3 < this._numAttributes) 
                {
                    loc4 = this._attributes[loc3];
                    if (loc4.isColor) 
                    {
                        loc5 = this._numVertices * this._vertexSize + loc4.offset;
                        loc6 = this._numVertices;
                        while (loc6 < arg1) 
                        {
                            this._rawData.position = loc5;
                            this._rawData.writeUnsignedInt(4294967295);
                            loc5 = loc5 + this._vertexSize;
                            ++loc6;
                        }
                    }
                    ++loc3;
                }
            }
            if (arg1 == 0) 
            {
                this._tinted = false;
            }
            this._numVertices = arg1;
            return;
        }

        public function get rawData():flash.utils.ByteArray
        {
            return this._rawData;
        }

        public function get format():starling.rendering.VertexDataFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.rendering.VertexDataFormat):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc7:*=null;
            var loc8:*=null;
            if (this._format === arg1) 
            {
                return;
            }
            var loc4:*=this._format.vertexSize;
            var loc5:*=arg1.vertexSize;
            var loc6:*=arg1.numAttributes;
            sBytes.length = arg1.vertexSize * this._numVertices;
            loc1 = 0;
            while (loc1 < loc6) 
            {
                loc7 = arg1.attributes[loc1];
                loc8 = this.getAttribute(loc7.name);
                if (loc8) 
                {
                    loc3 = loc7.offset;
                    loc2 = 0;
                    while (loc2 < this._numVertices) 
                    {
                        sBytes.position = loc3;
                        sBytes.writeBytes(this._rawData, loc4 * loc2 + loc8.offset, loc8.size);
                        loc3 = loc3 + loc5;
                        ++loc2;
                    }
                }
                else if (loc7.isColor) 
                {
                    loc3 = loc7.offset;
                    loc2 = 0;
                    while (loc2 < this._numVertices) 
                    {
                        sBytes.position = loc3;
                        sBytes.writeUnsignedInt(4294967295);
                        loc3 = loc3 + loc5;
                        ++loc2;
                    }
                }
                ++loc1;
            }
            this._rawData.clear();
            this._rawData.length = sBytes.length;
            this._rawData.writeBytes(sBytes);
            sBytes.clear();
            this._format = arg1;
            this._attributes = this._format.attributes;
            this._numAttributes = this._attributes.length;
            this._vertexSize = this._format.vertexSize;
            this._posOffset = this._format.hasAttribute("position") ? this._format.getOffset("position") : 0;
            this._colOffset = this._format.hasAttribute("color") ? this._format.getOffset("color") : 0;
            return;
        }

        public function get tinted():Boolean
        {
            return this._tinted;
        }

        internal var _rawData:flash.utils.ByteArray;

        internal var _numVertices:int;

        internal var _format:starling.rendering.VertexDataFormat;

        internal var _attributes:__AS3__.vec.Vector.<VertexDataAttribute>;

        internal var _numAttributes:int;

        internal var _premultipliedAlpha:Boolean;

        internal var _tinted:Boolean;

        internal var _colOffset:int;

        internal var _vertexSize:int;

        internal var _posOffset:int;

        internal static var sHelperPoint3D:flash.geom.Vector3D;

        internal static var sBytes:flash.utils.ByteArray;

        internal static var sHelperPoint:flash.geom.Point;
    }
}


//    class VertexDataAttribute
package starling.rendering 
{
    internal class VertexDataAttribute extends Object
    {
        public function VertexDataAttribute(arg1:String, arg2:String, arg3:int)
        {
            super();
            if (!(arg2 in FORMAT_SIZES)) 
            {
                throw new ArgumentError("Invalid attribute format: " + arg2 + ". " + "Use one of the following: \'float1\'-\'float4\', \'bytes4\'");
            }
            this.name = arg1;
            this.format = arg2;
            this.offset = arg3;
            this.size = FORMAT_SIZES[arg2];
            this.isColor = !(arg1.indexOf("color") == -1) || !(arg1.indexOf("Color") == -1);
            return;
        }

        internal static const FORMAT_SIZES:Object={"bytes4":4, "float1":4, "float2":8, "float3":12, "float4":16};

        public var name:String;

        public var format:String;

        public var isColor:Boolean;

        public var offset:int;

        public var size:int;
    }
}


//    class VertexDataFormat
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    public class VertexDataFormat extends Object
    {
        public function VertexDataFormat()
        {
            super();
            this._attributes = new Vector.<VertexDataAttribute>();
            return;
        }

        public function extend(arg1:String):starling.rendering.VertexDataFormat
        {
            return fromString(this._format + ", " + arg1);
        }

        public function getSize(arg1:String):int
        {
            return this.getAttribute(arg1).size;
        }

        public function getSizeIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).size / 4;
        }

        public function getOffset(arg1:String):int
        {
            return this.getAttribute(arg1).offset;
        }

        public function getOffsetIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).offset / 4;
        }

        public function getFormat(arg1:String):String
        {
            return this.getAttribute(arg1).format;
        }

        public function getName(arg1:int):String
        {
            return this._attributes[arg1].name;
        }

        public function hasAttribute(arg1:String):Boolean
        {
            var loc1:*=this._attributes.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._attributes[loc2].name == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function setVertexBufferAt(arg1:int, arg2:flash.display3D.VertexBuffer3D, arg3:String):void
        {
            var loc1:*=this.getAttribute(arg3);
            starling.core.Starling.context.setVertexBufferAt(arg1, arg2, loc1.offset / 4, loc1.format);
            return;
        }

        internal function parseFormat(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (!(arg1 == null) && !(arg1 == "")) 
            {
                this._attributes.length = 0;
                this._format = "";
                loc1 = arg1.split(",");
                loc2 = loc1.length;
                loc3 = 0;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc5 = loc1[loc4];
                    loc6 = loc5.split(":");
                    if (loc6.length != 2) 
                    {
                        throw new ArgumentError("Missing colon: " + loc5);
                    }
                    loc7 = starling.utils.StringUtil.trim(loc6[0]);
                    loc8 = starling.utils.StringUtil.trim(loc6[1]);
                    if (loc7.length == 0 || loc8.length == 0) 
                    {
                        throw new ArgumentError("Invalid format string: " + loc5);
                    }
                    loc9 = new VertexDataAttribute(loc7, loc8, loc3);
                    loc3 = loc3 + loc9.size;
                    this._format = this._format + ((loc4 != 0 ? ", " : "") + loc9.name + ":" + loc9.format);
                    this._attributes[this._attributes.length] = loc9;
                    ++loc4;
                }
                this._vertexSize = loc3;
            }
            else 
            {
                this._format = "";
            }
            return;
        }

        public function toString():String
        {
            return this._format;
        }

        function getAttribute(arg1:String):VertexDataAttribute
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=this._attributes.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc2 = this._attributes[loc1];
                if (loc2.name == arg1) 
                {
                    return loc2;
                }
                ++loc1;
            }
            return null;
        }

        function get attributes():__AS3__.vec.Vector.<VertexDataAttribute>
        {
            return this._attributes;
        }

        public function get formatString():String
        {
            return this._format;
        }

        public function get vertexSize():int
        {
            return this._vertexSize;
        }

        public function get vertexSizeIn32Bits():int
        {
            return this._vertexSize / 4;
        }

        public function get numAttributes():int
        {
            return this._attributes.length;
        }

        public static function fromString(arg1:String):starling.rendering.VertexDataFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 in sFormats) 
            {
                return sFormats[arg1];
            }
            loc1 = new VertexDataFormat();
            loc1.parseFormat(arg1);
            loc2 = loc1._format;
            if (loc2 in sFormats) 
            {
                loc1 = sFormats[loc2];
            }
            sFormats[arg1] = loc1;
            sFormats[loc2] = loc1;
            return loc1;
        }

        
        {
            sFormats = new flash.utils.Dictionary();
        }

        internal var _format:String;

        internal var _vertexSize:int;

        internal var _attributes:__AS3__.vec.Vector.<VertexDataAttribute>;

        internal static var sFormats:flash.utils.Dictionary;
    }
}


//  package styles
//    class MeshStyle
package starling.styles 
{
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    
    use namespace starling_internal;
    
    public class MeshStyle extends starling.events.EventDispatcher
    {
        public function MeshStyle()
        {
            super();
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            this._type = Object(this).constructor as Class;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 != this._texture) 
            {
                if (arg1) 
                {
                    loc2 = this._vertexData ? this._vertexData.numVertices : 0;
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this.getTexCoords(loc1, sPoint);
                        arg1.setTexCoords(this._vertexData, loc1, "texCoords", sPoint.x, sPoint.y);
                        ++loc1;
                    }
                    this.setVertexDataChanged();
                }
                else 
                {
                    this.setRequiresRedraw();
                }
                this._texture = arg1;
                this._textureBase = arg1 ? arg1.base : null;
            }
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            if (arg1 != this._textureSmoothing) 
            {
                this._textureSmoothing = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._textureRepeat;
        }

        public function updateEffect(arg1:starling.rendering.MeshEffect, arg2:starling.rendering.RenderState):void
        {
            arg1.texture = this._texture;
            arg1.textureRepeat = this._textureRepeat;
            arg1.textureSmoothing = this._textureSmoothing;
            arg1.mvpMatrix3D = arg2.mvpMatrix3D;
            arg1.alpha = arg2.alpha;
            arg1.tinted = this._vertexData.tinted;
            return;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._textureRepeat = arg1;
            return;
        }

        public function get target():starling.display.Mesh
        {
            return this._target;
        }

        public function copyFrom(arg1:starling.styles.MeshStyle):void
        {
            this._texture = arg1._texture;
            this._textureBase = arg1._textureBase;
            this._textureRepeat = arg1._textureRepeat;
            this._textureSmoothing = arg1._textureSmoothing;
            return;
        }

        public function clone():starling.styles.MeshStyle
        {
            var loc1:*=new this._type();
            loc1.copyFrom(this);
            return loc1;
        }

        public function createEffect():starling.rendering.MeshEffect
        {
            return new starling.rendering.MeshEffect();
        }

        
        {
            sPoint = new flash.geom.Point();
        }

        public function canBatchWith(arg1:starling.styles.MeshStyle):Boolean
        {
            var loc1:*=null;
            if (this._type == arg1._type) 
            {
                loc1 = arg1._texture;
                if (this._texture == null && loc1 == null) 
                {
                    return true;
                }
                if (this._texture && loc1) 
                {
                    return this._textureBase == arg1._textureBase && this._textureSmoothing == arg1._textureSmoothing && this._textureRepeat == arg1._textureRepeat;
                }
                return false;
            }
            return false;
        }

        public function batchVertexData(arg1:starling.styles.MeshStyle, arg2:int=0, arg3:flash.geom.Matrix=null, arg4:int=0, arg5:int=-1):void
        {
            this._vertexData.copyTo(arg1._vertexData, arg2, arg3, arg4, arg5);
            return;
        }

        public function batchIndexData(arg1:starling.styles.MeshStyle, arg2:int=0, arg3:int=0, arg4:int=0, arg5:int=-1):void
        {
            this._indexData.copyTo(arg1._indexData, arg2, arg3, arg4, arg5);
            return;
        }

        protected function setRequiresRedraw():void
        {
            if (this._target) 
            {
                this._target.setRequiresRedraw();
            }
            return;
        }

        protected function setVertexDataChanged():void
        {
            if (this._target) 
            {
                this._target.setVertexDataChanged();
            }
            return;
        }

        protected function setIndexDataChanged():void
        {
            if (this._target) 
            {
                this._target.setIndexDataChanged();
            }
            return;
        }

        protected function onTargetAssigned(arg1:starling.display.Mesh):void
        {
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            }
            super.addEventListener(arg1, arg2);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.removeEventListener(arg1, this.onEnterFrame);
            }
            super.removeEventListener(arg1, arg2);
            return;
        }

        internal function onEnterFrame(arg1:starling.events.Event):void
        {
            dispatchEvent(arg1);
            return;
        }

        starling_internal function setTarget(arg1:starling.display.Mesh=null, arg2:starling.rendering.VertexData=null, arg3:starling.rendering.IndexData=null):void
        {
            if (this._target != arg1) 
            {
                if (this._target) 
                {
                    this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                }
                if (arg2) 
                {
                    arg2.format = this.vertexFormat;
                }
                this._target = arg1;
                this._vertexData = arg2;
                this._indexData = arg3;
                if (arg1) 
                {
                    if (hasEventListener(starling.events.Event.ENTER_FRAME)) 
                    {
                        arg1.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                    }
                    this.onTargetAssigned(arg1);
                }
            }
            return;
        }

        public function getVertexPosition(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._vertexData.getPoint(arg1, "position", arg2);
        }

        public function setVertexPosition(arg1:int, arg2:Number, arg3:Number):void
        {
            this._vertexData.setPoint(arg1, "position", arg2, arg3);
            this.setVertexDataChanged();
            return;
        }

        public function getVertexAlpha(arg1:int):Number
        {
            return this._vertexData.getAlpha(arg1);
        }

        public function setVertexAlpha(arg1:int, arg2:Number):void
        {
            this._vertexData.setAlpha(arg1, "color", arg2);
            this.setVertexDataChanged();
            return;
        }

        public function getVertexColor(arg1:int):uint
        {
            return this._vertexData.getColor(arg1);
        }

        public function setVertexColor(arg1:int, arg2:uint):void
        {
            this._vertexData.setColor(arg1, "color", arg2);
            this.setVertexDataChanged();
            return;
        }

        public function getTexCoords(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this._texture) 
            {
                return this._texture.getTexCoords(this._vertexData, arg1, "texCoords", arg2);
            }
            return this._vertexData.getPoint(arg1, "texCoords", arg2);
        }

        public function setTexCoords(arg1:int, arg2:Number, arg3:Number):void
        {
            if (this._texture) 
            {
                this._texture.setTexCoords(this._vertexData, arg1, "texCoords", arg2, arg3);
            }
            else 
            {
                this._vertexData.setPoint(arg1, "texCoords", arg2, arg3);
            }
            this.setVertexDataChanged();
            return;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            return this._indexData;
        }

        public function get type():Class
        {
            return this._type;
        }

        public function get color():uint
        {
            if (this._vertexData.numVertices > 0) 
            {
                return this._vertexData.getColor(0);
            }
            return 0;
        }

        public function set color(arg1:uint):void
        {
            var loc1:*=0;
            var loc2:*=this._vertexData.numVertices;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this._vertexData.setColor(loc1, "color", arg1);
                ++loc1;
            }
            if (arg1 == 16777215 && this._vertexData.tinted) 
            {
                this._vertexData.updateTinted();
            }
            this.setVertexDataChanged();
            return;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.MeshEffect.VERTEX_FORMAT;

        internal var _type:Class;

        internal var _target:starling.display.Mesh;

        internal var _texture:starling.textures.Texture;

        internal var _textureBase:flash.display3D.textures.TextureBase;

        internal var _textureSmoothing:String;

        internal var _vertexData:starling.rendering.VertexData;

        internal var _indexData:starling.rendering.IndexData;

        internal var _textureRepeat:Boolean;

        internal static var sPoint:flash.geom.Point;
    }
}


//  package text
//    class BitmapChar
package starling.text 
{
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class BitmapChar extends Object
    {
        public function BitmapChar(arg1:int, arg2:starling.textures.Texture, arg3:Number, arg4:Number, arg5:Number)
        {
            super();
            this._charID = arg1;
            this._texture = arg2;
            this._xOffset = arg3;
            this._yOffset = arg4;
            this._xAdvance = arg5;
            this._kernings = null;
            return;
        }

        public function addKerning(arg1:int, arg2:Number):void
        {
            if (this._kernings == null) 
            {
                this._kernings = new flash.utils.Dictionary();
            }
            this._kernings[arg1] = arg2;
            return;
        }

        public function getKerning(arg1:int):Number
        {
            if (this._kernings == null || this._kernings[arg1] == undefined) 
            {
                return 0;
            }
            return this._kernings[arg1];
        }

        public function createImage():starling.display.Image
        {
            return new starling.display.Image(this._texture);
        }

        public function get charID():int
        {
            return this._charID;
        }

        public function get xOffset():Number
        {
            return this._xOffset;
        }

        public function get yOffset():Number
        {
            return this._yOffset;
        }

        public function get xAdvance():Number
        {
            return this._xAdvance;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function get width():Number
        {
            return this._texture.width;
        }

        public function get height():Number
        {
            return this._texture.height;
        }

        internal var _texture:starling.textures.Texture;

        internal var _charID:int;

        internal var _xOffset:Number;

        internal var _yOffset:Number;

        internal var _xAdvance:Number;

        internal var _kernings:flash.utils.Dictionary;
    }
}


//    class BitmapFont
package starling.text 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class BitmapFont extends Object implements starling.text.ITextCompositor
    {
        public function BitmapFont(arg1:starling.textures.Texture=null, arg2:XML=null)
        {
            super();
            if (arg1 == null && arg2 == null) 
            {
                arg1 = MiniBitmapFont.texture;
                arg2 = MiniBitmapFont.xml;
            }
            else if (arg1 == null || arg2 == null) 
            {
                throw new ArgumentError("Set both of the \'texture\' and \'fontXml\' arguments to valid objects or leave both of them null.");
            }
            this._name = "unknown";
            var loc1:*;
            this._baseline = loc1 = 14;
            this._size = loc1 = loc1;
            this._lineHeight = loc1;
            this._padding = loc1 = 0;
            this._offsetY = loc1 = loc1;
            this._offsetX = loc1;
            this._texture = arg1;
            this._chars = new flash.utils.Dictionary();
            this._helperImage = new starling.display.Image(arg1);
            this.parseFontXml(arg2);
            return;
        }

        public function get baseline():Number
        {
            return this._baseline;
        }

        public function set baseline(arg1:Number):void
        {
            this._baseline = arg1;
            return;
        }

        public function get offsetX():Number
        {
            return this._offsetX;
        }

        public function set offsetX(arg1:Number):void
        {
            this._offsetX = arg1;
            return;
        }

        public function get size():Number
        {
            return this._size;
        }

        public function get offsetY():Number
        {
            return this._offsetY;
        }

        public function set offsetY(arg1:Number):void
        {
            this._offsetY = arg1;
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        public function set padding(arg1:Number):void
        {
            this._padding = arg1;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function dispose():void
        {
            if (this._texture) 
            {
                this._texture.dispose();
            }
            return;
        }

        internal function parseFontXml(arg1:XML):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=0;
            var loc15:*=0;
            var loc16:*=NaN;
            var loc1:*=this._texture.scale;
            var loc2:*=this._texture.frame;
            var loc3:*=loc2 ? loc2.x : 0;
            var loc4:*=loc2 ? loc2.y : 0;
            this._name = starling.utils.StringUtil.clean(arg1.info.@face);
            this._size = parseFloat(arg1.info.@size) / loc1;
            this._lineHeight = parseFloat(arg1.common.@lineHeight) / loc1;
            this._baseline = parseFloat(arg1.common.@base) / loc1;
            if (arg1.info.@smooth.toString() == "0") 
            {
                this.smoothing = starling.textures.TextureSmoothing.NONE;
            }
            if (this._size <= 0) 
            {
                trace("[Starling] Warning: invalid font size in \'" + this._name + "\' font.");
                this._size = this._size != 0 ? this._size * -1 : 16;
            }
            var loc17:*=0;
            var loc18:*=arg1.chars.char;
            for each (loc5 in loc18) 
            {
                loc7 = parseInt(loc5.@id);
                loc8 = parseFloat(loc5.@xoffset) / loc1;
                loc9 = parseFloat(loc5.@yoffset) / loc1;
                loc10 = parseFloat(loc5.@xadvance) / loc1;
                loc11 = new flash.geom.Rectangle();
                loc11.x = parseFloat(loc5.@x) / loc1 + loc3;
                loc11.y = parseFloat(loc5.@y) / loc1 + loc4;
                loc11.width = parseFloat(loc5.@width) / loc1;
                loc11.height = parseFloat(loc5.@height) / loc1;
                loc12 = starling.textures.Texture.fromTexture(this._texture, loc11);
                loc13 = new starling.text.BitmapChar(loc7, loc12, loc8, loc9, loc10);
                this.addChar(loc7, loc13);
            }
            loc17 = 0;
            loc18 = arg1.kernings.kerning;
            for each (loc6 in loc18) 
            {
                loc14 = parseInt(loc6.@first);
                loc15 = parseInt(loc6.@second);
                loc16 = parseFloat(loc6.@amount) / loc1;
                if (!(loc15 in this._chars)) 
                {
                    continue;
                }
                this.getChar(loc15).addKerning(loc14, loc16);
            }
            return;
        }

        public function getChar(arg1:int):starling.text.BitmapChar
        {
            return this._chars[arg1];
        }

        public function addChar(arg1:int, arg2:starling.text.BitmapChar):void
        {
            this._chars[arg1] = arg2;
            return;
        }

        public function getCharIDs(arg1:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            var loc1:*=undefined;
            if (arg1 == null) 
            {
                arg1 = new Vector.<int>(0);
            }
            var loc2:*=0;
            var loc3:*=this._chars;
            for (loc1 in loc3) 
            {
                arg1[arg1.length] = int(loc1);
            }
            return arg1;
        }

        public function hasChars(arg1:String):Boolean
        {
            var loc1:*=0;
            if (arg1 == null) 
            {
                return true;
            }
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = arg1.charCodeAt(loc3);
                if (!(loc1 == CHAR_SPACE) && !(loc1 == CHAR_TAB) && !(loc1 == CHAR_NEWLINE) && !(loc1 == CHAR_CARRIAGE_RETURN) && this.getChar(loc1) == null) 
                {
                    return false;
                }
                ++loc3;
            }
            return true;
        }

        public function createSprite(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions=null):starling.display.Sprite
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=this.arrangeChars(arg1, arg2, arg3, arg4, arg5);
            var loc2:*=loc1.length;
            var loc3:*=this.smoothing;
            var loc4:*=new starling.display.Sprite();
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                loc6 = loc1[loc5];
                loc7 = loc6.char.createImage();
                loc7.x = loc6.x;
                loc7.y = loc6.y;
                loc7.scale = loc6.scale;
                loc7.color = arg4.color;
                loc7.textureSmoothing = loc3;
                loc4.addChild(loc7);
                ++loc5;
            }
            CharLocation.rechargePool();
            return loc4;
        }

        public function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void
        {
            var loc4:*=null;
            var loc1:*=this.arrangeChars(arg2, arg3, arg4, arg5, arg6);
            var loc2:*=loc1.length;
            this._helperImage.color = arg5.color;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                this._helperImage.texture = loc4.char.texture;
                this._helperImage.readjustSize();
                this._helperImage.x = loc4.x;
                this._helperImage.y = loc4.y;
                this._helperImage.scale = loc4.scale;
                arg1.addMesh(this._helperImage);
                ++loc3;
            }
            CharLocation.rechargePool();
            return;
        }

        public function clearMeshBatch(arg1:starling.display.MeshBatch):void
        {
            arg1.clear();
            return;
        }

        internal function arrangeChars(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions):__AS3__.vec.Vector.<CharLocation>
        {
            var loc9:*=null;
            var loc10:*=0;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=0;
            var loc15:*=0;
            var loc21:*=0;
            var loc22:*=0;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=null;
            var loc26:*=false;
            var loc27:*=0;
            var loc28:*=null;
            var loc29:*=0;
            var loc30:*=null;
            var loc31:*=0;
            var loc32:*=null;
            var loc33:*=NaN;
            var loc34:*=0;
            if (arg3 == null || arg3.length == 0) 
            {
                return CharLocation.vectorFromPool();
            }
            if (arg5 == null) 
            {
                arg5 = sDefaultOptions;
            }
            var loc1:*=arg4.kerning;
            var loc2:*=arg4.leading;
            var loc3:*=arg4.horizontalAlign;
            var loc4:*=arg4.verticalAlign;
            var loc5:*=arg4.size;
            var loc6:*=arg5.autoScale;
            var loc7:*=arg5.wordWrap;
            var loc8:*=false;
            if (loc5 < 0) 
            {
                loc5 = loc5 * (-this._size);
            }
            while (!loc8) 
            {
                sLines.length = 0;
                loc13 = loc5 / this._size;
                loc11 = (arg1 - 2 * this._padding) / loc13;
                loc12 = (arg2 - 2 * this._padding) / loc13;
                if (this._lineHeight <= loc12) 
                {
                    loc21 = -1;
                    loc22 = -1;
                    loc23 = 0;
                    loc24 = 0;
                    loc25 = CharLocation.vectorFromPool();
                    loc10 = arg3.length;
                    loc14 = 0;
                    while (loc14 < loc10) 
                    {
                        loc26 = false;
                        loc27 = arg3.charCodeAt(loc14);
                        loc28 = this.getChar(loc27);
                        if (loc27 == CHAR_NEWLINE || loc27 == CHAR_CARRIAGE_RETURN) 
                        {
                            loc26 = true;
                        }
                        else if (loc28 != null) 
                        {
                            if (loc27 == CHAR_SPACE || loc27 == CHAR_TAB) 
                            {
                                loc21 = loc14;
                            }
                            if (loc1) 
                            {
                                loc23 = loc23 + loc28.getKerning(loc22);
                            }
                            loc9 = CharLocation.instanceFromPool(loc28);
                            loc9.x = loc23 + loc28.xOffset;
                            loc9.y = loc24 + loc28.yOffset;
                            loc25[loc25.length] = loc9;
                            loc23 = loc23 + loc28.xAdvance;
                            loc22 = loc27;
                            if (loc9.x + loc28.width > loc11) 
                            {
                                if (loc7) 
                                {
                                    if (!(loc6 && loc21 == -1)) 
                                    {
                                    };
                                    loc29 = loc21 != -1 ? loc14 - loc21 : 1;
                                    loc15 = 0;
                                    while (loc15 < loc29) 
                                    {
                                        loc25.pop();
                                        ++loc15;
                                    }
                                    if (loc25.length != 0) 
                                    {
                                    };
                                    loc14 = loc14 - loc29;
                                }
                                else 
                                {
                                    if (!loc6) 
                                    {
                                    };
                                    loc25.pop();
                                    while (loc14 < (loc10 - 1) && !(arg3.charCodeAt(loc14) == CHAR_NEWLINE)) 
                                    {
                                        ++loc14;
                                    }
                                }
                                loc26 = true;
                            }
                        }
                        else 
                        {
                            trace("[Starling] Font: " + this.name + " missing character: " + arg3.charAt(loc14) + " id: " + loc27);
                        }
                        if (loc14 != (loc10 - 1)) 
                        {
                            if (loc26) 
                            {
                                sLines[sLines.length] = loc25;
                                if (loc21 == loc14) 
                                {
                                    loc25.pop();
                                }
                                if (loc24 + loc2 + 2 * this._lineHeight <= loc12) 
                                {
                                    loc25 = CharLocation.vectorFromPool();
                                    loc23 = 0;
                                    loc24 = loc24 + (this._lineHeight + loc2);
                                    loc21 = -1;
                                    loc22 = -1;
                                }
                            }
                        }
                        else 
                        {
                            sLines[sLines.length] = loc25;
                            loc8 = true;
                        }
                        ++loc14;
                    }
                }
                if (loc6 && !loc8 && loc5 > 3) 
                {
                    --loc5;
                    continue;
                }
                loc8 = true;
            }
            var loc16:*=CharLocation.vectorFromPool();
            var loc17:*=sLines.length;
            var loc18:*=loc24 + this._lineHeight;
            var loc19:*=0;
            if (loc4 != starling.utils.Align.BOTTOM) 
            {
                if (loc4 == starling.utils.Align.CENTER) 
                {
                    loc19 = (loc12 - loc18) / 2;
                }
            }
            else 
            {
                loc19 = loc12 - loc18;
            }
            var loc20:*=0;
            while (loc20 < loc17) 
            {
                loc30 = sLines[loc20];
                loc10 = loc30.length;
                if (loc10 != 0) 
                {
                    loc31 = 0;
                    loc32 = loc30[(loc30.length - 1)];
                    loc33 = loc32.x - loc32.char.xOffset + loc32.char.xAdvance;
                    if (loc3 != starling.utils.Align.RIGHT) 
                    {
                        if (loc3 == starling.utils.Align.CENTER) 
                        {
                            loc31 = (loc11 - loc33) / 2;
                        }
                    }
                    else 
                    {
                        loc31 = loc11 - loc33;
                    }
                    loc34 = 0;
                    while (loc34 < loc10) 
                    {
                        loc9 = loc30[loc34];
                        loc9.x = loc13 * (loc9.x + loc31 + this._offsetX) + this._padding;
                        loc9.y = loc13 * (loc9.y + loc19 + this._offsetY) + this._padding;
                        loc9.scale = loc13;
                        if (loc9.char.width > 0 && loc9.char.height > 0) 
                        {
                            loc16[loc16.length] = loc9;
                        }
                        ++loc34;
                    }
                }
                ++loc20;
            }
            return loc16;
        }

        public function get name():String
        {
            return this._name;
        }

        
        {
            sLines = [];
            sDefaultOptions = new starling.text.TextOptions();
        }

        public function get lineHeight():Number
        {
            return this._lineHeight;
        }

        public function set lineHeight(arg1:Number):void
        {
            this._lineHeight = arg1;
            return;
        }

        public function get smoothing():String
        {
            return this._helperImage.textureSmoothing;
        }

        public function set smoothing(arg1:String):void
        {
            this._helperImage.textureSmoothing = arg1;
            return;
        }

        public static const NATIVE_SIZE:int=-1;

        public static const MINI:String="mini";

        internal static const CHAR_SPACE:int=32;

        internal static const CHAR_NEWLINE:int=10;

        internal static const CHAR_CARRIAGE_RETURN:int=13;

        internal static const CHAR_TAB:int=9;

        internal var _texture:starling.textures.Texture;

        internal var _chars:flash.utils.Dictionary;

        internal var _name:String;

        internal var _size:Number;

        internal var _baseline:Number;

        internal var _offsetX:Number;

        internal var _offsetY:Number;

        internal var _padding:Number;

        internal var _helperImage:starling.display.Image;

        internal var _lineHeight:Number;

        internal static var sLines:Array;

        internal static var sDefaultOptions:starling.text.TextOptions;
    }
}

import __AS3__.vec.*;


class CharLocation extends Object
{
    public function CharLocation(arg1:starling.text.BitmapChar)
    {
        super();
        this.reset(arg1);
        return;
    }

    internal function reset(arg1:starling.text.BitmapChar):CharLocation
    {
        this.char = arg1;
        return this;
    }

    public static function instanceFromPool(arg1:starling.text.BitmapChar):CharLocation
    {
        var loc1:*=sInstancePool.length > 0 ? sInstancePool.pop() : new CharLocation(arg1);
        loc1.reset(arg1);
        sInstanceLoan[sInstanceLoan.length] = loc1;
        return loc1;
    }

    public static function vectorFromPool():__AS3__.vec.Vector.<CharLocation>
    {
        var loc1:*=sVectorPool.length > 0 ? sVectorPool.pop() : new Vector.<CharLocation>(0);
        loc1.length = 0;
        sVectorLoan[sVectorLoan.length] = loc1;
        return loc1;
    }

    public static function rechargePool():void
    {
        var loc1:*=null;
        var loc2:*=null;
        while (sInstanceLoan.length > 0) 
        {
            loc1 = sInstanceLoan.pop();
            loc1.char = null;
            sInstancePool[sInstancePool.length] = loc1;
        }
        while (sVectorLoan.length > 0) 
        {
            loc2 = sVectorLoan.pop();
            loc2.length = 0;
            sVectorPool[sVectorPool.length] = loc2;
        }
        return;
    }

    
    {
        sInstancePool = new Vector.<>(0);
        sVectorPool = [];
        sInstanceLoan = new Vector.<>(0);
        sVectorLoan = [];
    }

    public var char:starling.text.BitmapChar;

    public var scale:Number;

    public var x:Number;

    public var y:Number;

    internal static var sInstancePool:__AS3__.vec.Vector.<CharLocation>;

    internal static var sVectorPool:Array;

    internal static var sInstanceLoan:__AS3__.vec.Vector.<CharLocation>;

    internal static var sVectorLoan:Array;
}

//    class ITextCompositor
package starling.text 
{
    import starling.display.*;
    
    public interface ITextCompositor
    {
        function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void;

        function clearMeshBatch(arg1:starling.display.MeshBatch):void;

        function dispose():void;
    }
}


//    class MiniBitmapFont
package starling.text 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.textures.*;
    
    internal class MiniBitmapFont extends Object
    {
        public function MiniBitmapFont()
        {
            super();
            return;
        }

        public static function get texture():starling.textures.Texture
        {
            var bitmapData:flash.display.BitmapData;
            var format:String;
            var texture:starling.textures.Texture;

            var loc1:*;
            bitmapData = null;
            texture = null;
            bitmapData = getBitmapData();
            format = flash.display3D.Context3DTextureFormat.BGRA_PACKED;
            texture = starling.textures.Texture.fromBitmapData(bitmapData, false, false, 1, format);
            bitmapData.dispose();
            bitmapData = null;
            texture.root.onRestore = function ():void
            {
                bitmapData = getBitmapData();
                texture.root.uploadBitmapData(bitmapData);
                bitmapData.dispose();
                bitmapData = null;
                return;
            }
            return texture;
        }

        internal static function getBitmapData():flash.display.BitmapData
        {
            var loc1:*=new flash.display.BitmapData(BITMAP_WIDTH, BITMAP_HEIGHT);
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=BITMAP_DATA.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2.writeUnsignedInt(BITMAP_DATA[loc4]);
                ++loc4;
            }
            loc2.uncompress();
            loc1.setPixels(new flash.geom.Rectangle(0, 0, BITMAP_WIDTH, BITMAP_HEIGHT), loc2);
            loc2.clear();
            return loc1;
        }

        public static function get xml():XML
        {
            return XML_DATA;
        }

        internal static const BITMAP_WIDTH:int=128;

        internal static const BITMAP_HEIGHT:int=64;

        internal static const BITMAP_DATA:Array=[2027613533, 3413039936, 202148514, 2266925598, 4206886452, 4286853117, 2034947, 3202703399, 352977282, 2957757964, 3113652880, 2158068882, 1468709156, 2268063717, 2779310143, 2101025806, 3416509055, 4215794539, 3602168838, 1038056207, 1932393374, 3182285627, 3086802234, 1741291262, 2017257123, 3395280843, 984074419, 3049693147, 3986077023, 1055013549, 1806563255, 1754714962, 1577746187, 1124058786, 3888759258, 2482229043, 2916583666, 3743065328, 866060213, 1695195001, 2401582068, 3113347901, 2616521596, 1053798161, 2093370968, 4229025683, 560451479, 854767518, 2610241322, 4279041348, 4181572480, 4031244973, 587139110, 1081376765, 962217926, 783603325, 3605526425, 4102001916, 289204733, 2635140255, 3453981695, 3487854373, 2132197241, 3164775074, 4257640328, 770238970, 144664537, 707141570, 2934433071, 871272893, 512964596, 808491899, 481894297, 3095982481, 3598364156, 1710636358, 2904016319, 1751040139, 596966466, 1363963692, 465815609, 315567311, 4290666159, 4086022551, 179721458, 2221734970, 3942224988, 1519355876, 3292323782, 3933427230, 3314199893, 3736227348, 3846038425, 603088884, 2677349227, 3207069327, 3555275967, 3063054283, 3064577213, 3412044179, 693642210, 4280513949, 762928717, 1802215333, 3774849674, 4221155330, 970959395, 557220237, 2107226136, 3509822982, 3403284788, 4265820019, 898597576, 991077243, 2091615904, 3334716888, 633599866, 4218780109, 2216000376, 834870947, 2118009742, 1362731961, 236280636, 1274945142, 1458729366, 797960805, 3289369720, 2103717340, 3946406003, 2676522889, 1624104606, 1156993903, 3186170404, 2254499071, 1204911924, 1314218830, 3307086392, 2824275959, 3839865679, 2073394964, 1873329433, 1754205930, 1528429545, 1631106062, 2263272465, 4220497047, 3522893765, 3641376303, 707451487, 3452496787, 1390653868, 2620555793, 1027328684, 3419683476, 3662193703, 765701986, 3808279132, 786403271, 3824435837, 713234896, 4261856399, 3471930731, 3993492879, 1447960461, 1398434593, 1914230187, 2398643285, 4156374464, 3859339207, 3220700061, 3373248762, 3186030434, 1315917060, 2809852481, 4008553903, 4105611953, 1599499652, 3513857591, 877854499, 4198259455, 3648560077, 2838035419, 3255594190, 2465578457, 4263505201, 534904657, 2889261598, 1358214576, 1069250354, 3870010557, 2628896583, 3448610878, 442343309, 1024736866, 4015119133, 3250867279, 1513359261, 2442089596, 1944476762, 735490552, 426990058, 4234106111, 1204305707, 3330995265, 2398649368, 4221048123, 1724669255, 3801115709, 3489328790, 3896402933, 3696936939, 2836983295, 3656750393, 3349724512, 3810416287, 3654997608, 4284455103, 2294939563, 4207697932, 642748805, 2476981639, 2319419898, 572956615, 3833238940, 964924880, 2081600351, 3572458416, 2056247513, 1951368808, 2133449703, 2783728628, 512866577, 913279200, 1678129016, 3488578991, 3373952929, 2562996951, 3666058925, 1664169178, 1943591935, 750675303, 154399903, 2571590890, 852654952, 4117307766, 1971649621, 4180195820, 1222535348, 4283953215, 2880662236, 2717410980, 1175907705, 1157322027, 505963121, 2631540616, 3661227656, 3591803353, 2624126821, 1948662907, 3596065103, 1147387734, 256773959, 1173572460, 2361957471, 4210876076, 3080180620, 3464801210, 3821654259, 1465302035, 2851185457, 3143266144, 3793180414, 3368833103, 4274670712, 3473819108, 3487569332, 773123355, 1618635668, 2570176190, 2075248691, 1740805534, 288646743, 1837597401, 603556968, 3182536872, 673184603, 3088757053, 2897054404, 3192651316, 2885335802, 1057233368, 1118437241, 4182126463, 3110464775, 3313191614, 2360987274, 735505357, 2992631425, 2360928811, 4187834527, 279183208, 1586420003, 1174008423, 4062987589, 1162167621, 1162167621, 1162167621, 1162167621, 1174119799, 787274608];

        internal static const XML_DATA:XML=new XML("<font>\n          <info face=\"mini\" size=\"8\" bold=\"0\" italic=\"0\" smooth=\"0\"/>\n          <common lineHeight=\"8\" base=\"7\" scaleW=\"128\" scaleH=\"64\" pages=\"1\" packed=\"0\"/>\n          <chars count=\"191\">\n            <char id=\"195\" x=\"1\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"209\" x=\"7\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"213\" x=\"13\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"253\" x=\"19\" y=\"1\" width=\"4\" height=\"9\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"255\" x=\"24\" y=\"1\" width=\"4\" height=\"9\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"192\" x=\"29\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"193\" x=\"35\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"194\" x=\"41\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"197\" x=\"47\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"200\" x=\"53\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"201\" x=\"59\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"202\" x=\"65\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"210\" x=\"71\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"211\" x=\"77\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"212\" x=\"83\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"217\" x=\"89\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"218\" x=\"95\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"219\" x=\"101\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"221\" x=\"107\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"206\" x=\"113\" y=\"1\" width=\"3\" height=\"8\" xoffset=\"-1\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"204\" x=\"117\" y=\"1\" width=\"2\" height=\"8\" xoffset=\"-1\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"205\" x=\"120\" y=\"1\" width=\"2\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"36\" x=\"1\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"6\"/>\n            <char id=\"196\" x=\"7\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"199\" x=\"13\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"203\" x=\"19\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"214\" x=\"25\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"220\" x=\"31\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"224\" x=\"37\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"225\" x=\"42\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"226\" x=\"47\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"227\" x=\"52\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"232\" x=\"57\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"233\" x=\"62\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"234\" x=\"67\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"235\" x=\"72\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"241\" x=\"77\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"242\" x=\"82\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"243\" x=\"87\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"244\" x=\"92\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"245\" x=\"97\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"249\" x=\"102\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"250\" x=\"107\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"251\" x=\"112\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"254\" x=\"117\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"123\" x=\"122\" y=\"11\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"125\" x=\"1\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"167\" x=\"5\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"207\" x=\"9\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"-1\" yoffset=\"0\" xadvance=\"2\"/>\n            <char id=\"106\" x=\"13\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"40\" x=\"16\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"41\" x=\"19\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"91\" x=\"22\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"93\" x=\"25\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"124\" x=\"28\" y=\"19\" width=\"1\" height=\"7\" xoffset=\"1\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"81\" x=\"30\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"163\" x=\"36\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"6\"/>\n            <char id=\"177\" x=\"42\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"181\" x=\"48\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"103\" x=\"54\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"112\" x=\"59\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"113\" x=\"64\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"121\" x=\"69\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"162\" x=\"74\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"228\" x=\"79\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"229\" x=\"84\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"231\" x=\"89\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"240\" x=\"94\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"246\" x=\"99\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"252\" x=\"104\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"238\" x=\"109\" y=\"19\" width=\"3\" height=\"6\" xoffset=\"-1\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"59\" x=\"113\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"236\" x=\"116\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"-1\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"237\" x=\"119\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"198\" x=\"1\" y=\"27\" width=\"9\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"10\"/>\n            <char id=\"190\" x=\"11\" y=\"27\" width=\"8\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"9\"/>\n            <char id=\"87\" x=\"20\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"188\" x=\"28\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"189\" x=\"36\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"38\" x=\"44\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"164\" x=\"51\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"208\" x=\"58\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"8364\" x=\"65\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"65\" x=\"72\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"66\" x=\"78\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"67\" x=\"84\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"68\" x=\"90\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"69\" x=\"96\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"70\" x=\"102\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"71\" x=\"108\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"72\" x=\"114\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"75\" x=\"120\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"77\" x=\"1\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"78\" x=\"7\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"79\" x=\"13\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"80\" x=\"19\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"82\" x=\"25\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"83\" x=\"31\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"84\" x=\"37\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"85\" x=\"43\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"86\" x=\"49\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"88\" x=\"55\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"89\" x=\"61\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"90\" x=\"67\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"50\" x=\"73\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"51\" x=\"79\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"52\" x=\"85\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"53\" x=\"91\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"54\" x=\"97\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"56\" x=\"103\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"57\" x=\"109\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"48\" x=\"115\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"47\" x=\"121\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"64\" x=\"1\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"92\" x=\"7\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"37\" x=\"13\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"43\" x=\"19\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"35\" x=\"25\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"42\" x=\"31\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"165\" x=\"37\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"169\" x=\"43\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"174\" x=\"49\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"182\" x=\"55\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"216\" x=\"61\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"247\" x=\"67\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"74\" x=\"73\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"76\" x=\"78\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"98\" x=\"83\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"100\" x=\"88\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"104\" x=\"93\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"107\" x=\"98\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"55\" x=\"103\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"63\" x=\"108\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"191\" x=\"113\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"222\" x=\"118\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"223\" x=\"123\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"116\" x=\"1\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"60\" x=\"5\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"62\" x=\"9\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"170\" x=\"13\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"186\" x=\"17\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"239\" x=\"21\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"-1\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"102\" x=\"25\" y=\"45\" width=\"2\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"49\" x=\"28\" y=\"45\" width=\"2\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"73\" x=\"31\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"105\" x=\"33\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"108\" x=\"35\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"33\" x=\"37\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"1\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"161\" x=\"39\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"166\" x=\"41\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"109\" x=\"43\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"119\" x=\"51\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"230\" x=\"59\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"97\" x=\"67\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"99\" x=\"72\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"101\" x=\"77\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"110\" x=\"82\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"111\" x=\"87\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"115\" x=\"92\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"117\" x=\"97\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"118\" x=\"102\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"120\" x=\"107\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"122\" x=\"112\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"215\" x=\"117\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"248\" x=\"122\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"114\" x=\"1\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"178\" x=\"5\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"179\" x=\"9\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"185\" x=\"13\" y=\"51\" width=\"1\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"61\" x=\"15\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"171\" x=\"21\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"172\" x=\"27\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"4\" xadvance=\"6\"/>\n            <char id=\"187\" x=\"33\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"176\" x=\"39\" y=\"51\" width=\"3\" height=\"3\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"44\" x=\"43\" y=\"51\" width=\"2\" height=\"3\" xoffset=\"0\" yoffset=\"6\" xadvance=\"3\"/>\n            <char id=\"58\" x=\"46\" y=\"51\" width=\"1\" height=\"3\" xoffset=\"1\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"94\" x=\"48\" y=\"51\" width=\"4\" height=\"2\" xoffset=\"-1\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"126\" x=\"53\" y=\"51\" width=\"4\" height=\"2\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"34\" x=\"58\" y=\"51\" width=\"3\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"96\" x=\"62\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"180\" x=\"65\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"184\" x=\"68\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"7\" xadvance=\"3\"/>\n            <char id=\"39\" x=\"71\" y=\"51\" width=\"1\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"95\" x=\"73\" y=\"51\" width=\"5\" height=\"1\" xoffset=\"0\" yoffset=\"7\" xadvance=\"6\"/>\n            <char id=\"45\" x=\"79\" y=\"51\" width=\"4\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"5\"/>\n            <char id=\"173\" x=\"84\" y=\"51\" width=\"4\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"5\"/>\n            <char id=\"168\" x=\"89\" y=\"51\" width=\"3\" height=\"1\" xoffset=\"1\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"175\" x=\"93\" y=\"51\" width=\"3\" height=\"1\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"46\" x=\"97\" y=\"51\" width=\"1\" height=\"1\" xoffset=\"0\" yoffset=\"6\" xadvance=\"2\"/>\n            <char id=\"183\" x=\"99\" y=\"51\" width=\"1\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"2\"/>\n            <char id=\"32\" x=\"6\" y=\"56\" width=\"0\" height=\"0\" xoffset=\"0\" yoffset=\"127\" xadvance=\"3\"/>\n          </chars>\n        </font>");
    }
}


//    class TextField
package starling.text 
{
    import flash.display3D.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class TextField extends starling.display.DisplayObjectContainer
    {
        public function TextField(arg1:int, arg2:int, arg3:String="", arg4:starling.text.TextFormat=null)
        {
            this._helperFormat = new starling.text.TextFormat();
            super();
            this._text = arg3 ? arg3 : "";
            this._hitArea = new flash.geom.Rectangle(0, 0, arg1, arg2);
            this._requiresRecomposition = true;
            this._compositor = sDefaultCompositor;
            this._options = new starling.text.TextOptions();
            this._format = arg4 ? arg4.clone() : new starling.text.TextFormat();
            this._format.addEventListener(starling.events.Event.CHANGE, this.setRequiresRecomposition);
            this._meshBatch = new starling.display.MeshBatch();
            this._meshBatch.touchable = false;
            this._meshBatch.pixelSnapping = true;
            addChild(this._meshBatch);
            return;
        }

        public static function get defaultCompositor():starling.text.ITextCompositor
        {
            return sDefaultCompositor;
        }

        public static function set defaultCompositor(arg1:starling.text.ITextCompositor):void
        {
            sDefaultCompositor = arg1;
            return;
        }

        public static function updateEmbeddedFonts():void
        {
            starling.utils.SystemUtil.updateEmbeddedFonts();
            return;
        }

        public static function registerCompositor(arg1:starling.text.ITextCompositor, arg2:String):void
        {
            if (arg2 == null) 
            {
                throw new ArgumentError("name must not be null");
            }
            compositors[convertToLowerCase(arg2)] = arg1;
            return;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sDefaultCompositor = new starling.text.TrueTypeCompositor();
            sDefaultTextureFormat = flash.display3D.Context3DTextureFormat.BGRA_PACKED;
            sStringCache = new flash.utils.Dictionary();
        }

        public static function getCompositor(arg1:String):starling.text.ITextCompositor
        {
            return compositors[convertToLowerCase(arg1)];
        }

        public static function registerBitmapFont(arg1:starling.text.BitmapFont, arg2:String=null):String
        {
            if (arg2 == null) 
            {
                arg2 = arg1.name;
            }
            registerCompositor(arg1, arg2);
            return arg2;
        }

        internal function updateBorder():void
        {
            if (this._border == null) 
            {
                return;
            }
            var loc1:*=this._hitArea.width;
            var loc2:*=this._hitArea.height;
            var loc3:*=this._border.getChildAt(0) as starling.display.Quad;
            var loc4:*=this._border.getChildAt(1) as starling.display.Quad;
            var loc5:*=this._border.getChildAt(2) as starling.display.Quad;
            var loc6:*=this._border.getChildAt(3) as starling.display.Quad;
            loc3.width = loc1;
            loc3.height = 1;
            loc5.width = loc1;
            loc5.height = 1;
            loc6.width = 1;
            loc6.height = loc2;
            loc4.width = 1;
            loc4.height = loc2;
            loc4.x = (loc1 - 1);
            loc5.y = (loc2 - 1);
            var loc7:*;
            loc6.color = loc7 = this._format.color;
            loc5.color = loc7 = loc7;
            loc4.color = loc7 = loc7;
            loc3.color = loc7;
            return;
        }

        public static function unregisterBitmapFont(arg1:String, arg2:Boolean=true):void
        {
            unregisterCompositor(arg1, arg2);
            return;
        }

        public static function getBitmapFont(arg1:String):starling.text.BitmapFont
        {
            return getCompositor(arg1) as starling.text.BitmapFont;
        }

        internal static function get compositors():flash.utils.Dictionary
        {
            var loc1:*=starling.core.Starling.painter.sharedData[COMPOSITOR_DATA_NAME] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                starling.core.Starling.painter.sharedData[COMPOSITOR_DATA_NAME] = loc1;
            }
            return loc1;
        }

        public override function dispose():void
        {
            this._format.removeEventListener(starling.events.Event.CHANGE, this.setRequiresRecomposition);
            this._compositor.clearMeshBatch(this._meshBatch);
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            super.render(arg1);
            return;
        }

        internal function recompose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._requiresRecomposition) 
            {
                this._compositor.clearMeshBatch(this._meshBatch);
                loc1 = this._format.font;
                loc2 = getCompositor(loc1);
                if (loc2 == null && loc1 == starling.text.BitmapFont.MINI) 
                {
                    loc2 = new starling.text.BitmapFont();
                    registerCompositor(loc2, loc1);
                }
                this._compositor = loc2 ? loc2 : sDefaultCompositor;
                this.updateText();
                this.updateBorder();
                this._requiresRecomposition = false;
            }
            return;
        }

        internal function updateText():void
        {
            var loc1:*=this._hitArea.width;
            var loc2:*=this._hitArea.height;
            var loc3:*=this._helperFormat;
            loc3.copyFrom(this._format);
            if (this.isHorizontalAutoSize && !this._options.isHtmlText) 
            {
                loc1 = 100000;
            }
            if (this.isVerticalAutoSize) 
            {
                loc2 = 100000;
            }
            var loc4:*;
            this._meshBatch.y = loc4 = 0;
            this._meshBatch.x = loc4;
            this._options.textureScale = starling.core.Starling.contentScaleFactor;
            this._options.textureFormat = sDefaultTextureFormat;
            this._compositor.fillMeshBatch(this._meshBatch, loc1, loc2, this._text, loc3, this._options);
            if (this._style) 
            {
                this._meshBatch.style = this._style;
            }
            if (this._options.autoSize == starling.text.TextFieldAutoSize.NONE) 
            {
                this._textBounds = null;
            }
            else 
            {
                this._textBounds = this._meshBatch.getBounds(this._meshBatch, this._textBounds);
                if (this.isHorizontalAutoSize) 
                {
                    this._textBounds.x = loc4 = -this._textBounds.x;
                    this._meshBatch.x = loc4;
                    this._hitArea.width = this._textBounds.width;
                    this._textBounds.x = 0;
                }
                if (this.isVerticalAutoSize) 
                {
                    this._textBounds.y = loc4 = -this._textBounds.y;
                    this._meshBatch.y = loc4;
                    this._hitArea.height = this._textBounds.height;
                    this._textBounds.y = 0;
                }
            }
            return;
        }

        internal static function convertToLowerCase(arg1:String):String
        {
            var loc1:*=sStringCache[arg1];
            if (loc1 == null) 
            {
                loc1 = arg1.toLowerCase();
                sStringCache[arg1] = loc1;
            }
            return loc1;
        }

        protected function setRequiresRecomposition():void
        {
            this._requiresRecomposition = true;
            setRequiresRedraw();
            return;
        }

        internal function get isHorizontalAutoSize():Boolean
        {
            return this._options.autoSize == starling.text.TextFieldAutoSize.HORIZONTAL || this._options.autoSize == starling.text.TextFieldAutoSize.BOTH_DIRECTIONS;
        }

        internal function get isVerticalAutoSize():Boolean
        {
            return this._options.autoSize == starling.text.TextFieldAutoSize.VERTICAL || this._options.autoSize == starling.text.TextFieldAutoSize.BOTH_DIRECTIONS;
        }

        public function get textBounds():flash.geom.Rectangle
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            if (this._textBounds == null) 
            {
                this._textBounds = this._meshBatch.getBounds(this);
            }
            return this._textBounds.clone();
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            getTransformationMatrix(arg1, sMatrix);
            return starling.utils.RectangleUtil.getBounds(this._hitArea, sMatrix, arg2);
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            if (this._hitArea.containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public override function set width(arg1:Number):void
        {
            this._hitArea.width = arg1 / (scaleX || 1);
            this.setRequiresRecomposition();
            return;
        }

        public override function set height(arg1:Number):void
        {
            this._hitArea.height = arg1 / (scaleY || 1);
            this.setRequiresRecomposition();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (arg1 == null) 
            {
                arg1 = "";
            }
            if (this._text != arg1) 
            {
                this._text = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get format():starling.text.TextFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.text.TextFormat):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("format cannot be null");
            }
            this._format.copyFrom(arg1);
            return;
        }

        public function get border():Boolean
        {
            return !(this._border == null);
        }

        public function set border(arg1:Boolean):void
        {
            var loc1:*=0;
            if (arg1 && this._border == null) 
            {
                this._border = new starling.display.Sprite();
                addChild(this._border);
                loc1 = 0;
                while (loc1 < 4) 
                {
                    this._border.addChild(new starling.display.Quad(1, 1));
                    ++loc1;
                }
                this.updateBorder();
            }
            else if (!arg1 && !(this._border == null)) 
            {
                this._border.removeFromParent(true);
                this._border = null;
            }
            return;
        }

        public function get autoScale():Boolean
        {
            return this._options.autoScale;
        }

        public function set autoScale(arg1:Boolean):void
        {
            if (this._options.autoScale != arg1) 
            {
                this._options.autoScale = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get autoSize():String
        {
            return this._options.autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            if (this._options.autoSize != arg1) 
            {
                this._options.autoSize = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._options.wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (arg1 != this._options.wordWrap) 
            {
                this._options.wordWrap = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get batchable():Boolean
        {
            return this._meshBatch.batchable;
        }

        public function set batchable(arg1:Boolean):void
        {
            this._meshBatch.batchable = arg1;
            return;
        }

        public function get isHtmlText():Boolean
        {
            return this._options.isHtmlText;
        }

        public function set isHtmlText(arg1:Boolean):void
        {
            if (this._options.isHtmlText != arg1) 
            {
                this._options.isHtmlText = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._meshBatch.pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            this._meshBatch.pixelSnapping = arg1;
            return;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._meshBatch.style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            var loc1:*;
            this._style = loc1 = arg1;
            this._meshBatch.style = loc1;
            this.setRequiresRecomposition();
            return;
        }

        public static function unregisterCompositor(arg1:String, arg2:Boolean=true):void
        {
            arg1 = convertToLowerCase(arg1);
            if (arg2 && !(compositors[arg1] == undefined)) 
            {
                compositors[arg1].dispose();
            }
            delete compositors[arg1];
            return;
        }

        public static function get defaultTextureFormat():String
        {
            return sDefaultTextureFormat;
        }

        public static function set defaultTextureFormat(arg1:String):void
        {
            sDefaultTextureFormat = arg1;
            return;
        }

        internal static const COMPOSITOR_DATA_NAME:String="starling.display.TextField.compositors";

        internal var _text:String;

        internal var _options:starling.text.TextOptions;

        internal var _format:starling.text.TextFormat;

        internal var _textBounds:flash.geom.Rectangle;

        internal var _hitArea:flash.geom.Rectangle;

        internal var _compositor:starling.text.ITextCompositor;

        internal var _requiresRecomposition:Boolean;

        internal var _meshBatch:starling.display.MeshBatch;

        internal var _style:starling.styles.MeshStyle;

        internal var _helperFormat:starling.text.TextFormat;

        internal var _border:starling.display.DisplayObjectContainer;

        internal static var sDefaultTextureFormat:String="bgraPacked4444";

        internal static var sStringCache:flash.utils.Dictionary;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sDefaultCompositor:starling.text.ITextCompositor;
    }
}


//    class TextFieldAutoSize
package starling.text 
{
    import starling.errors.*;
    
    public class TextFieldAutoSize extends Object
    {
        public function TextFieldAutoSize()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static const NONE:String="none";

        public static const HORIZONTAL:String="horizontal";

        public static const VERTICAL:String="vertical";

        public static const BOTH_DIRECTIONS:String="bothDirections";
    }
}


//    class TextFormat
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


//    class TextOptions
package starling.text 
{
    import flash.display3D.*;
    import starling.core.*;
    
    public class TextOptions extends Object
    {
        public function TextOptions(arg1:Boolean=true, arg2:Boolean=false)
        {
            super();
            this._wordWrap = arg1;
            this._autoScale = arg2;
            this._autoSize = starling.text.TextFieldAutoSize.NONE;
            this._textureScale = starling.core.Starling.contentScaleFactor;
            this._textureFormat = flash.display3D.Context3DTextureFormat.BGR_PACKED;
            this._isHtmlText = false;
            return;
        }

        public function copyFrom(arg1:starling.text.TextOptions):void
        {
            this._wordWrap = arg1._wordWrap;
            this._autoScale = arg1._autoScale;
            this._autoSize = arg1._autoSize;
            this._isHtmlText = arg1._isHtmlText;
            this._textureScale = arg1._textureScale;
            this._textureFormat = arg1._textureFormat;
            return;
        }

        public function clone():starling.text.TextOptions
        {
            var loc1:*=new starling.text.TextOptions();
            loc1.copyFrom(this);
            return loc1;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            this._wordWrap = arg1;
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            this._autoSize = arg1;
            return;
        }

        public function get autoScale():Boolean
        {
            return this._autoScale;
        }

        public function set autoScale(arg1:Boolean):void
        {
            this._autoScale = arg1;
            return;
        }

        public function get isHtmlText():Boolean
        {
            return this._isHtmlText;
        }

        public function set isHtmlText(arg1:Boolean):void
        {
            this._isHtmlText = arg1;
            return;
        }

        public function get textureScale():Number
        {
            return this._textureScale;
        }

        public function set textureScale(arg1:Number):void
        {
            this._textureScale = arg1;
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public function set textureFormat(arg1:String):void
        {
            this._textureFormat = arg1;
            return;
        }

        internal var _wordWrap:Boolean;

        internal var _autoScale:Boolean;

        internal var _autoSize:String;

        internal var _isHtmlText:Boolean;

        internal var _textureScale:Number;

        internal var _textureFormat:String;
    }
}


//    class TrueTypeCompositor
package starling.text 
{
    import flash.geom.*;
    import flash.text.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TrueTypeCompositor extends Object implements starling.text.ITextCompositor
    {
        public function TrueTypeCompositor()
        {
            super();
            return;
        }

        public function dispose():void
        {
            return;
        }

        public function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void
        {
            var meshBatch:starling.display.MeshBatch;
            var width:Number;
            var height:Number;
            var text:String;
            var format:starling.text.TextFormat;
            var options:starling.text.TextOptions=null;
            var texture:starling.textures.Texture;
            var textureFormat:String;
            var bitmapData:BitmapDataEx;

            var loc1:*;
            texture = null;
            bitmapData = null;
            meshBatch = arg1;
            width = arg2;
            height = arg3;
            text = arg4;
            format = arg5;
            options = arg6;
            if (text == null || text == "") 
            {
                return;
            }
            textureFormat = options.textureFormat;
            bitmapData = this.renderText(width, height, text, format, options);
            texture = starling.textures.Texture.fromBitmapData(bitmapData, false, false, bitmapData.scale, textureFormat);
            texture.root.onRestore = function ():void
            {
                bitmapData = renderText(width, height, text, format, options);
                texture.root.uploadBitmapData(bitmapData);
                bitmapData.dispose();
                bitmapData = null;
                return;
            }
            bitmapData.dispose();
            bitmapData = null;
            sHelperQuad.texture = texture;
            sHelperQuad.readjustSize();
            if (format.horizontalAlign != starling.utils.Align.LEFT) 
            {
                if (format.horizontalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.x = width - texture.width;
                }
                else 
                {
                    sHelperQuad.x = int((width - texture.width) / 2);
                }
            }
            else 
            {
                sHelperQuad.x = 0;
            }
            if (format.verticalAlign != starling.utils.Align.TOP) 
            {
                if (format.verticalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.y = height - texture.height;
                }
                else 
                {
                    sHelperQuad.y = int((height - texture.height) / 2);
                }
            }
            else 
            {
                sHelperQuad.y = 0;
            }
            meshBatch.addMesh(sHelperQuad);
            sHelperQuad.texture = null;
            return;
        }

        public function clearMeshBatch(arg1:starling.display.MeshBatch):void
        {
            arg1.clear();
            if (arg1.texture) 
            {
                arg1.texture.dispose();
            }
            return;
        }

        internal function renderText(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions):BitmapDataEx
        {
            var loc11:*=null;
            var loc1:*=arg1 * arg5.textureScale;
            var loc2:*=arg2 * arg5.textureScale;
            var loc3:*=arg4.horizontalAlign;
            arg4.toNativeFormat(sNativeFormat);
            sNativeFormat.size = Number(sNativeFormat.size) * arg5.textureScale;
            sNativeTextField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(arg4.font, arg4.bold, arg4.italic);
            sNativeTextField.defaultTextFormat = sNativeFormat;
            sNativeTextField.width = loc1;
            sNativeTextField.height = loc2;
            sNativeTextField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            sNativeTextField.selectable = false;
            sNativeTextField.multiline = true;
            sNativeTextField.wordWrap = arg5.wordWrap;
            if (arg5.isHtmlText) 
            {
                sNativeTextField.htmlText = arg3;
            }
            else 
            {
                sNativeTextField.text = arg3;
            }
            if (arg5.autoScale) 
            {
                this.autoScaleNativeTextField(sNativeTextField, arg3, arg5.isHtmlText);
            }
            var loc4:*=sNativeTextField.textWidth;
            var loc5:*=sNativeTextField.textHeight;
            var loc6:*=Math.ceil(loc4) + 4;
            var loc7:*=Math.ceil(loc5) + 4;
            var loc8:*=starling.textures.Texture.maxSize;
            var loc9:*=1;
            var loc10:*=0;
            if (arg5.isHtmlText) 
            {
                var loc12:*;
                loc6 = loc12 = loc1;
                loc4 = loc12;
            }
            if (loc6 < loc9) 
            {
                loc6 = 1;
            }
            if (loc7 < loc9) 
            {
                loc7 = 1;
            }
            if (loc7 > loc8 || loc6 > loc8) 
            {
                arg5.textureScale = arg5.textureScale * loc8 / Math.max(loc6, loc7);
                return this.renderText(arg1, arg2, arg3, arg4, arg5);
            }
            if (!arg5.isHtmlText) 
            {
                if (loc3 != starling.utils.Align.RIGHT) 
                {
                    if (loc3 == starling.utils.Align.CENTER) 
                    {
                        loc10 = (loc1 - loc4 - 4) / 2;
                    }
                }
                else 
                {
                    loc10 = loc1 - loc4 - 4;
                }
            }
            loc11 = new BitmapDataEx(loc6, loc7);
            sHelperMatrix.setTo(1, 0, 0, 1, -loc10, 0);
            loc11.draw(sNativeTextField, sHelperMatrix);
            loc11.scale = arg5.textureScale;
            sNativeTextField.text = "";
            return loc11;
        }

        internal function autoScaleNativeTextField(arg1:flash.text.TextField, arg2:String, arg3:Boolean):void
        {
            var loc1:*=arg1.defaultTextFormat;
            var loc2:*=arg1.width - 4;
            var loc3:*=arg1.height - 4;
            var loc4:*=Number(loc1.size);
            while (arg1.textWidth > loc2 || arg1.textHeight > loc3) 
            {
                if (loc4 <= 4) 
                {
                    break;
                }
                loc1.size = loc4--;
                arg1.defaultTextFormat = loc1;
                if (arg3) 
                {
                    arg1.htmlText = arg2;
                    continue;
                }
                arg1.text = arg2;
            }
            return;
        }

        
        {
            sHelperMatrix = new flash.geom.Matrix();
            sHelperQuad = new starling.display.Quad(100, 100);
            sNativeTextField = new flash.text.TextField();
            sNativeFormat = new flash.text.TextFormat();
        }

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperQuad:starling.display.Quad;

        internal static var sNativeTextField:flash.text.TextField;

        internal static var sNativeFormat:flash.text.TextFormat;
    }
}

import flash.display.*;


class BitmapDataEx extends flash.display.BitmapData
{
    public function BitmapDataEx(arg1:int, arg2:int, arg3:Boolean=true, arg4:uint=0)
    {
        super(arg1, arg2, arg3, arg4);
        return;
    }

    public function get scale():Number
    {
        return this._scale;
    }

    public function set scale(arg1:Number):void
    {
        this._scale = arg1;
        return;
    }

    internal var _scale:Number=1;
}

//  package textures
//    class AtfData
package starling.textures 
{
    import flash.display3D.*;
    import flash.utils.*;
    
    public class AtfData extends Object
    {
        public function AtfData(arg1:flash.utils.ByteArray)
        {
            var loc2:*=false;
            var loc3:*=0;
            super();
            if (!isAtfData(arg1)) 
            {
                throw new ArgumentError("Invalid ATF data");
            }
            if (arg1[6] != 255) 
            {
                arg1.position = 6;
            }
            else 
            {
                arg1.position = 12;
            }
            var loc1:*=arg1.readUnsignedByte();
            var loc4:*=loc1 & 127;
            switch (loc4) 
            {
                case 0:
                case 1:
                {
                    this._format = flash.display3D.Context3DTextureFormat.BGRA;
                    break;
                }
                case 12:
                case 2:
                case 3:
                {
                    this._format = flash.display3D.Context3DTextureFormat.COMPRESSED;
                    break;
                }
                case 13:
                case 4:
                case 5:
                {
                    this._format = "compressedAlpha";
                    break;
                }
                default:
                {
                    throw new Error("Invalid ATF format");
                }
            }
            this._width = Math.pow(2, arg1.readUnsignedByte());
            this._height = Math.pow(2, arg1.readUnsignedByte());
            this._numTextures = arg1.readUnsignedByte();
            this._isCubeMap = !((loc1 & 128) == 0);
            this._data = arg1;
            if (!(arg1[5] == 0) && arg1[6] == 255) 
            {
                loc2 = (arg1[5] & 1) == 1;
                loc3 = arg1[5] >> 1 & 127;
                this._numTextures = loc2 ? 1 : loc3;
            }
            return;
        }

        public function get format():String
        {
            return this._format;
        }

        public function get width():int
        {
            return this._width;
        }

        public function get height():int
        {
            return this._height;
        }

        public function get numTextures():int
        {
            return this._numTextures;
        }

        public function get isCubeMap():Boolean
        {
            return this._isCubeMap;
        }

        public function get data():flash.utils.ByteArray
        {
            return this._data;
        }

        public static function isAtfData(arg1:flash.utils.ByteArray):Boolean
        {
            var loc1:*=null;
            if (arg1.length < 3) 
            {
                return false;
            }
            loc1 = String.fromCharCode(arg1[0], arg1[1], arg1[2]);
            return loc1 == "ATF";
        }

        internal var _format:String;

        internal var _width:int;

        internal var _height:int;

        internal var _numTextures:int;

        internal var _isCubeMap:Boolean;

        internal var _data:flash.utils.ByteArray;
    }
}


//    class ConcretePotTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    internal class ConcretePotTexture extends starling.textures.ConcreteTexture
    {
        public function ConcretePotTexture(arg1:flash.display3D.textures.Texture, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean, arg7:Boolean=false, arg8:Number=1)
        {
            super(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            if (arg3 != starling.utils.MathUtil.getNextPowerOfTwo(arg3)) 
            {
                throw new ArgumentError("width must be a power of two");
            }
            if (arg4 != starling.utils.MathUtil.getNextPowerOfTwo(arg4)) 
            {
                throw new ArgumentError("height must be a power of two");
            }
            return;
        }

        public override function dispose():void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            super.dispose();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createTexture(nativeWidth, nativeHeight, format, optimizedForRenderTexture);
        }

        public override function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            this.potBase.uploadFromBitmapData(arg1);
            var loc1:*=null;
            if (!(arg1.width == nativeWidth) || !(arg1.height == nativeHeight)) 
            {
                loc1 = new flash.display.BitmapData(nativeWidth, nativeHeight, true, 0);
                loc1.copyPixels(arg1, arg1.rect, sOrigin);
                arg1 = loc1;
            }
            if (mipMapping && arg1.width > 1 && arg1.height > 1) 
            {
                loc2 = arg1.width >> 1;
                loc3 = arg1.height >> 1;
                loc4 = 1;
                loc5 = new flash.display.BitmapData(loc2, loc3, true, 0);
                loc6 = sRectangle;
                loc7 = sMatrix;
                loc7.setTo(0.5, 0, 0, 0.5, 0, 0);
                while (loc2 >= 1 || loc3 >= 1) 
                {
                    loc6.setTo(0, 0, loc2, loc3);
                    loc5.fillRect(loc6, 0);
                    loc5.draw(arg1, loc7, null, null, null, true);
                    this.potBase.uploadFromBitmapData(loc5, loc4++);
                    loc7.scale(0.5, 0.5);
                    loc2 = loc2 >> 1;
                    loc3 = loc3 >> 1;
                }
                loc5.dispose();
            }
            if (loc1) 
            {
                loc1.dispose();
            }
            setDataUploaded();
            return;
        }

        public override function get isPotTexture():Boolean
        {
            return true;
        }

        public override function uploadAtfData(arg1:flash.utils.ByteArray, arg2:int=0, arg3:*=null):void
        {
            var loc1:*=arg3 is Function || arg3 === true;
            if (arg3 is Function) 
            {
                this._textureReadyCallback = arg3 as Function;
                base.addEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            }
            this.potBase.uploadCompressedTextureFromByteArray(arg1, arg2, loc1);
            setDataUploaded();
            return;
        }

        internal function onTextureReady(arg1:flash.events.Event):void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            starling.utils.execute(this._textureReadyCallback, this);
            this._textureReadyCallback = null;
            return;
        }

        internal function get potBase():flash.display3D.textures.Texture
        {
            return base as flash.display3D.textures.Texture;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sRectangle = new flash.geom.Rectangle();
            sOrigin = new flash.geom.Point();
        }

        internal var _textureReadyCallback:Function;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sRectangle:flash.geom.Rectangle;

        internal static var sOrigin:flash.geom.Point;
    }
}


//    class ConcreteRectangleTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import starling.core.*;
    
    internal class ConcreteRectangleTexture extends starling.textures.ConcreteTexture
    {
        public function ConcreteRectangleTexture(arg1:flash.display3D.textures.RectangleTexture, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean=false, arg7:Number=1)
        {
            super(arg1, arg2, arg3, arg4, false, arg5, arg6, arg7);
            return;
        }

        public override function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            this.rectangleBase.uploadFromBitmapData(arg1);
            setDataUploaded();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createRectangleTexture(nativeWidth, nativeHeight, format, optimizedForRenderTexture);
        }

        internal function get rectangleBase():flash.display3D.textures.RectangleTexture
        {
            return base as flash.display3D.textures.RectangleTexture;
        }
    }
}


//    class ConcreteTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class ConcreteTexture extends starling.textures.Texture
    {
        public function ConcreteTexture(arg1:flash.display3D.textures.TextureBase, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean, arg7:Boolean=false, arg8:Number=1)
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.textures::ConcreteTexture") 
            {
                throw new starling.errors.AbstractClassError();
            }
            this._scale = arg8 <= 0 ? 1 : arg8;
            this._base = arg1;
            this._format = arg2;
            this._width = arg3;
            this._height = arg4;
            this._mipMapping = arg5;
            this._premultipliedAlpha = arg6;
            this._optimizedForRenderTexture = arg7;
            this._onRestore = null;
            this._dataUploaded = false;
            return;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this;
        }

        public override function get format():String
        {
            return this._format;
        }

        public override function get width():Number
        {
            return this._width / this._scale;
        }

        public override function get height():Number
        {
            return this._height / this._scale;
        }

        public override function get nativeWidth():Number
        {
            return this._width;
        }

        public override function get nativeHeight():Number
        {
            return this._height;
        }

        public override function get scale():Number
        {
            return this._scale;
        }

        public override function get mipMapping():Boolean
        {
            return this._mipMapping;
        }

        public override function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public override function dispose():void
        {
            if (this._base) 
            {
                this._base.dispose();
            }
            this.onRestore = null;
            super.dispose();
            return;
        }

        public function uploadBitmap(arg1:flash.display.Bitmap):void
        {
            this.uploadBitmapData(arg1.bitmapData);
            return;
        }

        public function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            throw new starling.errors.NotSupportedError();
        }

        public function uploadAtfData(arg1:flash.utils.ByteArray, arg2:int=0, arg3:*=null):void
        {
            throw new starling.errors.NotSupportedError();
        }

        public function attachNetStream(arg1:flash.net.NetStream, arg2:Function=null):void
        {
            this.attachVideo("NetStream", arg1, arg2);
            return;
        }

        public function attachCamera(arg1:flash.media.Camera, arg2:Function=null):void
        {
            this.attachVideo("Camera", arg1, arg2);
            return;
        }

        function attachVideo(arg1:String, arg2:Object, arg3:Function=null):void
        {
            throw new starling.errors.NotSupportedError();
        }

        internal function onContextCreated():void
        {
            this._dataUploaded = false;
            this._base = this.createBase();
            starling.utils.execute(this._onRestore, this);
            if (!this._dataUploaded) 
            {
                this.clear();
            }
            return;
        }

        protected function createBase():flash.display3D.textures.TextureBase
        {
            throw new starling.errors.AbstractMethodError();
        }

        starling_internal function recreateBase():void
        {
            this._base = this.createBase();
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            if (this._premultipliedAlpha && arg2 < 1) 
            {
                arg1 = starling.utils.Color.rgb(starling.utils.Color.getRed(arg1) * arg2, starling.utils.Color.getGreen(arg1) * arg2, starling.utils.Color.getBlue(arg1) * arg2);
            }
            var loc1:*=starling.core.Starling.painter;
            loc1.pushState();
            loc1.state.renderTarget = this;
            try 
            {
                loc1.clear(arg1, arg2);
            }
            catch (e:Error)
            {
            };
            loc1.popState();
            this.setDataUploaded();
            return;
        }

        protected function setDataUploaded():void
        {
            this._dataUploaded = true;
            return;
        }

        public function get optimizedForRenderTexture():Boolean
        {
            return this._optimizedForRenderTexture;
        }

        public function get isPotTexture():Boolean
        {
            return false;
        }

        public function get onRestore():Function
        {
            return this._onRestore;
        }

        public function set onRestore(arg1:Function):void
        {
            starling.core.Starling.current.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (arg1 == null) 
            {
                this._onRestore = null;
            }
            else 
            {
                this._onRestore = arg1;
                starling.core.Starling.current.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            }
            return;
        }

        internal var _base:flash.display3D.textures.TextureBase;

        internal var _format:String;

        internal var _width:int;

        internal var _height:int;

        internal var _mipMapping:Boolean;

        internal var _premultipliedAlpha:Boolean;

        internal var _optimizedForRenderTexture:Boolean;

        internal var _scale:Number;

        internal var _onRestore:Function;

        internal var _dataUploaded:Boolean;
    }
}


//    class ConcreteVideoTexture
package starling.textures 
{
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.events.*;
    import starling.core.*;
    import starling.utils.*;
    
    internal class ConcreteVideoTexture extends starling.textures.ConcreteTexture
    {
        public function ConcreteVideoTexture(arg1:flash.display3D.textures.VideoTexture, arg2:Number=1)
        {
            super(arg1, flash.display3D.Context3DTextureFormat.BGRA, arg1.videoWidth, arg1.videoHeight, false, false, false, arg2);
            return;
        }

        public override function dispose():void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            super.dispose();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createVideoTexture();
        }

        override function attachVideo(arg1:String, arg2:Object, arg3:Function=null):void
        {
            this._textureReadyCallback = arg3;
            var loc1:*;
            (loc1 = base)["attach" + arg1](arg2);
            base.addEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            setDataUploaded();
            return;
        }

        internal function onTextureReady(arg1:flash.events.Event):void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            starling.utils.execute(this._textureReadyCallback, this);
            this._textureReadyCallback = null;
            return;
        }

        public override function get nativeWidth():Number
        {
            return this.videoBase.videoWidth;
        }

        public override function get nativeHeight():Number
        {
            return this.videoBase.videoHeight;
        }

        public override function get width():Number
        {
            return this.nativeWidth / scale;
        }

        public override function get height():Number
        {
            return this.nativeHeight / scale;
        }

        internal function get videoBase():flash.display3D.textures.VideoTexture
        {
            return base as flash.display3D.textures.VideoTexture;
        }

        internal var _textureReadyCallback:Function;
    }
}


//    class RenderTexture
package starling.textures 
{
    import flash.display3D.textures.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class RenderTexture extends starling.textures.SubTexture
    {
        public function RenderTexture(arg1:int, arg2:int, arg3:Boolean=true, arg4:Number=-1, arg5:String="bgra")
        {
            this._isPersistent = arg3;
            this._activeTexture = starling.textures.Texture.empty(arg1, arg2, true, false, true, arg4, arg5);
            this._activeTexture.root.onRestore = this._activeTexture.root.clear;
            super(this._activeTexture, new flash.geom.Rectangle(0, 0, arg1, arg2), true, null, false);
            if (arg3 && useDoubleBuffering) 
            {
                this._bufferTexture = starling.textures.Texture.empty(arg1, arg2, true, false, true, arg4, arg5);
                this._bufferTexture.root.onRestore = this._bufferTexture.root.clear;
                this._helperImage = new starling.display.Image(this._bufferTexture);
                this._helperImage.textureSmoothing = starling.textures.TextureSmoothing.NONE;
            }
            return;
        }

        public override function dispose():void
        {
            this._activeTexture.dispose();
            if (this.isDoubleBuffered) 
            {
                this._bufferTexture.dispose();
                this._helperImage.dispose();
            }
            super.dispose();
            return;
        }

        public function draw(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null, arg3:Number=1, arg4:int=0):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (this._drawing) 
            {
                this.render(arg1, arg2, arg3);
            }
            else 
            {
                this.renderBundled(this.render, arg1, arg2, arg3, arg4);
            }
            return;
        }

        public function drawBundled(arg1:Function, arg2:int=0):void
        {
            this.renderBundled(arg1, null, null, 1, arg2);
            return;
        }

        internal function render(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null, arg3:Number=1):void
        {
            var loc1:*=starling.core.Starling.painter;
            var loc2:*=loc1.state;
            var loc3:*=loc1.cacheEnabled;
            var loc4:*=arg1.filter;
            var loc5:*=arg1.mask;
            loc1.cacheEnabled = false;
            loc1.pushState();
            loc2.alpha = arg1.alpha * arg3;
            loc2.setModelviewMatricesToIdentity();
            loc2.blendMode = arg1.blendMode != starling.display.BlendMode.AUTO ? arg1.blendMode : starling.display.BlendMode.NORMAL;
            if (arg2) 
            {
                loc2.transformModelviewMatrix(arg2);
            }
            else 
            {
                loc2.transformModelviewMatrix(arg1.transformationMatrix);
            }
            if (loc5) 
            {
                loc1.drawMask(loc5);
            }
            if (loc4) 
            {
                loc4.render(loc1);
            }
            else 
            {
                arg1.render(loc1);
            }
            if (loc5) 
            {
                loc1.eraseMask(loc5);
            }
            loc1.popState();
            loc1.cacheEnabled = loc3;
            return;
        }

        internal function renderBundled(arg1:Function, arg2:starling.display.DisplayObject=null, arg3:flash.geom.Matrix=null, arg4:Number=1, arg5:int=0):void
        {
            var renderBlock:Function;
            var object:starling.display.DisplayObject=null;
            var matrix:flash.geom.Matrix=null;
            var alpha:Number=1;
            var antiAliasing:int=0;
            var painter:starling.rendering.Painter;
            var state:starling.rendering.RenderState;
            var rootTexture:starling.textures.Texture;
            var tmpTexture:starling.textures.Texture;

            var loc1:*;
            tmpTexture = null;
            renderBlock = arg1;
            object = arg2;
            matrix = arg3;
            alpha = arg4;
            antiAliasing = arg5;
            painter = starling.core.Starling.painter;
            state = painter.state;
            if (!starling.core.Starling.current.contextValid) 
            {
                return;
            }
            if (this.isDoubleBuffered) 
            {
                tmpTexture = this._activeTexture;
                this._activeTexture = this._bufferTexture;
                this._bufferTexture = tmpTexture;
                this._helperImage.texture = this._bufferTexture;
            }
            painter.pushState();
            rootTexture = this._activeTexture.root;
            state.setProjectionMatrix(0, 0, rootTexture.width, rootTexture.height, width, height);
            sClipRect.setTo(0, 0, this._activeTexture.width, this._activeTexture.height);
            state.clipRect = sClipRect;
            state.setRenderTarget(this._activeTexture, true, antiAliasing);
            painter.prepareToDraw();
            if (this.isDoubleBuffered || !this.isPersistent || !this._bufferReady) 
            {
                painter.clear();
            }
            if (this.isDoubleBuffered && this._bufferReady) 
            {
                this._helperImage.render(painter);
            }
            else 
            {
                this._bufferReady = true;
            }
            try 
            {
                this._drawing = true;
                starling.utils.execute(renderBlock, object, matrix, alpha);
            }
            finally
            {
                this._drawing = false;
                painter.popState();
            }
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            this._activeTexture.root.clear(arg1, arg2);
            this._bufferReady = true;
            return;
        }

        internal function get isDoubleBuffered():Boolean
        {
            return !(this._bufferTexture == null);
        }

        public function get isPersistent():Boolean
        {
            return this._isPersistent;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._activeTexture.base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this._activeTexture.root;
        }

        public static function get useDoubleBuffering():Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (starling.core.Starling.current) 
            {
                loc1 = starling.core.Starling.painter;
                loc2 = loc1.sharedData;
                if (USE_DOUBLE_BUFFERING_DATA_NAME in loc2) 
                {
                    return loc2[USE_DOUBLE_BUFFERING_DATA_NAME];
                }
                loc3 = loc1.profile ? loc1.profile : "baseline";
                loc4 = loc3 == "baseline" || loc3 == "baselineConstrained";
                loc2[USE_DOUBLE_BUFFERING_DATA_NAME] = loc4;
                return loc4;
            }
            return false;
        }

        public static function set useDoubleBuffering(arg1:Boolean):void
        {
            if (starling.core.Starling.current == null) 
            {
                throw new flash.errors.IllegalOperationError("Starling not yet initialized");
            }
            starling.core.Starling.painter.sharedData[USE_DOUBLE_BUFFERING_DATA_NAME] = arg1;
            return;
        }

        
        {
            sClipRect = new flash.geom.Rectangle();
        }

        internal static const USE_DOUBLE_BUFFERING_DATA_NAME:String="starling.textures.RenderTexture.useDoubleBuffering";

        internal var _activeTexture:starling.textures.Texture;

        internal var _bufferTexture:starling.textures.Texture;

        internal var _helperImage:starling.display.Image;

        internal var _drawing:Boolean;

        internal var _bufferReady:Boolean;

        internal var _isPersistent:Boolean;

        internal static var sClipRect:flash.geom.Rectangle;
    }
}


//    class SubTexture
package starling.textures 
{
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.core.*;
    
    use namespace starling_internal;
    
    public class SubTexture extends starling.textures.Texture
    {
        public function SubTexture(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1)
        {
            super();
            var loc1:*;
            starling_internal::setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return;
        }

        starling_internal function setTo(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1):void
        {
            if (this._region == null) 
            {
                this._region = new flash.geom.Rectangle();
            }
            if (arg2) 
            {
                this._region.copyFrom(arg2);
            }
            else 
            {
                this._region.setTo(0, 0, arg1.width, arg1.height);
            }
            if (arg4) 
            {
                if (this._frame) 
                {
                    this._frame.copyFrom(arg4);
                }
                else 
                {
                    this._frame = arg4.clone();
                }
            }
            else 
            {
                this._frame = null;
            }
            this._parent = arg1;
            this._ownsParent = arg3;
            this._rotated = arg5;
            this._width = (arg5 ? this._region.height : this._region.width) / arg6;
            this._height = (arg5 ? this._region.width : this._region.height) / arg6;
            this._scale = this._parent.scale * arg6;
            if (this._frame && (this._frame.x > 0 || this._frame.y > 0 || this._frame.right < this._width || this._frame.bottom < this._height)) 
            {
                trace("[Starling] Warning: frames inside the texture\'s region are unsupported.");
            }
            this.updateMatrices();
            return;
        }

        internal function updateMatrices():void
        {
            if (this._transformationMatrix) 
            {
                this._transformationMatrix.identity();
            }
            else 
            {
                this._transformationMatrix = new flash.geom.Matrix();
            }
            if (this._transformationMatrixToRoot) 
            {
                this._transformationMatrixToRoot.identity();
            }
            else 
            {
                this._transformationMatrixToRoot = new flash.geom.Matrix();
            }
            if (this._rotated) 
            {
                this._transformationMatrix.translate(0, -1);
                this._transformationMatrix.rotate(Math.PI / 2);
            }
            this._transformationMatrix.scale(this._region.width / this._parent.width, this._region.height / this._parent.height);
            this._transformationMatrix.translate(this._region.x / this._parent.width, this._region.y / this._parent.height);
            var loc1:*=this;
            while (loc1) 
            {
                this._transformationMatrixToRoot.concat(loc1._transformationMatrix);
                loc1 = loc1.parent as starling.textures.SubTexture;
            }
            return;
        }

        public override function dispose():void
        {
            if (this._ownsParent) 
            {
                this._parent.dispose();
            }
            super.dispose();
            return;
        }

        public function get parent():starling.textures.Texture
        {
            return this._parent;
        }

        public function get ownsParent():Boolean
        {
            return this._ownsParent;
        }

        public function get rotated():Boolean
        {
            return this._rotated;
        }

        public function get region():flash.geom.Rectangle
        {
            return this._region;
        }

        public override function get transformationMatrix():flash.geom.Matrix
        {
            return this._transformationMatrix;
        }

        public override function get transformationMatrixToRoot():flash.geom.Matrix
        {
            return this._transformationMatrixToRoot;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._parent.base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this._parent.root;
        }

        public override function get format():String
        {
            return this._parent.format;
        }

        public override function get width():Number
        {
            return this._width;
        }

        public override function get height():Number
        {
            return this._height;
        }

        public override function get nativeWidth():Number
        {
            return this._width * this._scale;
        }

        public override function get nativeHeight():Number
        {
            return this._height * this._scale;
        }

        public override function get mipMapping():Boolean
        {
            return this._parent.mipMapping;
        }

        public override function get premultipliedAlpha():Boolean
        {
            return this._parent.premultipliedAlpha;
        }

        public override function get scale():Number
        {
            return this._scale;
        }

        public override function get frame():flash.geom.Rectangle
        {
            return this._frame;
        }

        internal var _parent:starling.textures.Texture;

        internal var _ownsParent:Boolean;

        internal var _region:flash.geom.Rectangle;

        internal var _frame:flash.geom.Rectangle;

        internal var _rotated:Boolean;

        internal var _width:Number;

        internal var _height:Number;

        internal var _scale:Number;

        internal var _transformationMatrix:flash.geom.Matrix;

        internal var _transformationMatrixToRoot:flash.geom.Matrix;
    }
}


//    class Texture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Texture extends Object
    {
        public function Texture()
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.textures::Texture") 
            {
                throw new starling.errors.AbstractClassError();
            }
            return;
        }

        public function dispose():void
        {
            return;
        }

        public function setupVertexPositions(arg1:starling.rendering.VertexData, arg2:int=0, arg3:String="position", arg4:flash.geom.Rectangle=null):void
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc1:*=this.frame;
            var loc2:*=this.width;
            var loc3:*=this.height;
            if (loc1) 
            {
                sRectangle.setTo(-loc1.x, -loc1.y, loc2, loc3);
            }
            else 
            {
                sRectangle.setTo(0, 0, loc2, loc3);
            }
            arg1.setPoint(arg2, arg3, sRectangle.left, sRectangle.top);
            arg1.setPoint(arg2 + 1, arg3, sRectangle.right, sRectangle.top);
            arg1.setPoint(arg2 + 2, arg3, sRectangle.left, sRectangle.bottom);
            arg1.setPoint(arg2 + 3, arg3, sRectangle.right, sRectangle.bottom);
            if (arg4) 
            {
                loc4 = arg4.width / this.frameWidth;
                loc5 = arg4.height / this.frameHeight;
                if (!(loc4 == 1) || !(loc5 == 1) || !(arg4.x == 0) || !(arg4.y == 0)) 
                {
                    sMatrix.identity();
                    sMatrix.scale(loc4, loc5);
                    sMatrix.translate(arg4.x, arg4.y);
                    arg1.transformPoints(arg3, sMatrix, arg2, 4);
                }
            }
            return;
        }

        public function setupTextureCoordinates(arg1:starling.rendering.VertexData, arg2:int=0, arg3:String="texCoords"):void
        {
            this.setTexCoords(arg1, arg2, arg3, 0, 0);
            this.setTexCoords(arg1, arg2 + 1, arg3, 1, 0);
            this.setTexCoords(arg1, arg2 + 2, arg3, 0, 1);
            this.setTexCoords(arg1, arg2 + 3, arg3, 1, 1);
            return;
        }

        public function localToGlobal(arg1:Number, arg2:Number, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            if (this != this.root) 
            {
                starling.utils.MatrixUtil.transformCoords(this.transformationMatrixToRoot, arg1, arg2, arg3);
            }
            else 
            {
                arg3.setTo(arg1, arg2);
            }
            return arg3;
        }

        public function globalToLocal(arg1:Number, arg2:Number, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            if (this != this.root) 
            {
                sMatrix.identity();
                sMatrix.copyFrom(this.transformationMatrixToRoot);
                sMatrix.invert();
                starling.utils.MatrixUtil.transformCoords(sMatrix, arg1, arg2, arg3);
            }
            else 
            {
                arg3.setTo(arg1, arg2);
            }
            return arg3;
        }

        public function setTexCoords(arg1:starling.rendering.VertexData, arg2:int, arg3:String, arg4:Number, arg5:Number):void
        {
            this.localToGlobal(arg4, arg5, sPoint);
            arg1.setPoint(arg2, arg3, sPoint.x, sPoint.y);
            return;
        }

        public function getTexCoords(arg1:starling.rendering.VertexData, arg2:int, arg3:String="texCoords", arg4:flash.geom.Point=null):flash.geom.Point
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Point();
            }
            arg1.getPoint(arg2, arg3, arg4);
            return this.globalToLocal(arg4.x, arg4.y, arg4);
        }

        public function get frame():flash.geom.Rectangle
        {
            return null;
        }

        public function get frameWidth():Number
        {
            return this.frame ? this.frame.width : this.width;
        }

        public function get frameHeight():Number
        {
            return this.frame ? this.frame.height : this.height;
        }

        public function get width():Number
        {
            return 0;
        }

        public function get height():Number
        {
            return 0;
        }

        public function get nativeWidth():Number
        {
            return 0;
        }

        public function get nativeHeight():Number
        {
            return 0;
        }

        public function get scale():Number
        {
            return 1;
        }

        public function get base():flash.display3D.textures.TextureBase
        {
            return null;
        }

        public function get root():starling.textures.ConcreteTexture
        {
            return null;
        }

        public function get format():String
        {
            return flash.display3D.Context3DTextureFormat.BGRA;
        }

        public function get mipMapping():Boolean
        {
            return false;
        }

        public function get premultipliedAlpha():Boolean
        {
            return false;
        }

        public function get transformationMatrix():flash.geom.Matrix
        {
            return null;
        }

        public function get transformationMatrixToRoot():flash.geom.Matrix
        {
            return null;
        }

        public static function fromData(arg1:Object, arg2:starling.textures.TextureOptions=null):starling.textures.Texture
        {
            if (arg1 is flash.display.Bitmap) 
            {
                arg1 = (arg1 as flash.display.Bitmap).bitmapData;
            }
            if (arg2 == null) 
            {
                arg2 = sDefaultOptions;
            }
            if (arg1 is Class) 
            {
                return fromEmbeddedAsset(arg1 as Class, arg2.mipMapping, arg2.optimizeForRenderToTexture, arg2.scale, arg2.format, arg2.forcePotTexture);
            }
            if (arg1 is flash.display.BitmapData) 
            {
                return fromBitmapData(arg1 as flash.display.BitmapData, arg2.mipMapping, arg2.optimizeForRenderToTexture, arg2.scale, arg2.format, arg2.forcePotTexture);
            }
            if (arg1 is flash.utils.ByteArray) 
            {
                return fromAtfData(arg1 as flash.utils.ByteArray, arg2.scale, arg2.mipMapping, arg2.onReady);
            }
            throw new ArgumentError("Unsupported \'data\' type: " + flash.utils.getQualifiedClassName(arg1));
        }

        public static function fromTextureBase(arg1:flash.display3D.textures.TextureBase, arg2:int, arg3:int, arg4:starling.textures.TextureOptions=null):starling.textures.ConcreteTexture
        {
            if (arg4 == null) 
            {
                arg4 = sDefaultOptions;
            }
            if (arg1 is flash.display3D.textures.Texture) 
            {
                return new ConcretePotTexture(arg1 as flash.display3D.textures.Texture, arg4.format, arg2, arg3, arg4.mipMapping, arg4.premultipliedAlpha, arg4.optimizeForRenderToTexture, arg4.scale);
            }
            if (arg1 is flash.display3D.textures.RectangleTexture) 
            {
                return new ConcreteRectangleTexture(arg1 as flash.display3D.textures.RectangleTexture, arg4.format, arg2, arg3, arg4.premultipliedAlpha, arg4.optimizeForRenderToTexture, arg4.scale);
            }
            if (arg1 is flash.display3D.textures.VideoTexture) 
            {
                return new ConcreteVideoTexture(arg1 as flash.display3D.textures.VideoTexture, arg4.scale);
            }
            throw new ArgumentError("Unsupported \'base\' type: " + flash.utils.getQualifiedClassName(arg1));
        }

        public static function fromEmbeddedAsset(arg1:Class, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            var assetClass:Class;
            var mipMapping:Boolean=false;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;
            var asset:Object;

            var loc1:*;
            texture = null;
            assetClass = arg1;
            mipMapping = arg2;
            optimizeForRenderToTexture = arg3;
            scale = arg4;
            format = arg5;
            forcePotTexture = arg6;
            asset = new assetClass();
            if (asset is flash.display.Bitmap) 
            {
                texture = starling.textures.Texture.fromBitmap(asset as flash.display.Bitmap, mipMapping, optimizeForRenderToTexture, scale, format, forcePotTexture);
                texture.root.onRestore = function ():void
                {
                    texture.root.uploadBitmap(new assetClass());
                    return;
                }
            }
            else if (asset is flash.utils.ByteArray) 
            {
                texture = starling.textures.Texture.fromAtfData(asset as flash.utils.ByteArray, scale, mipMapping, null);
                texture.root.onRestore = function ():void
                {
                    texture.root.uploadAtfData(new assetClass());
                    return;
                }
            }
            else 
            {
                throw new ArgumentError("Invalid asset type: " + flash.utils.getQualifiedClassName(asset));
            }
            asset = null;
            return texture;
        }

        public static function fromBitmap(arg1:flash.display.Bitmap, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            return fromBitmapData(arg1.bitmapData, arg2, arg3, arg4, arg5, arg6);
        }

        public static function fromBitmapData(arg1:flash.display.BitmapData, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            var data:flash.display.BitmapData;
            var generateMipMaps:Boolean=false;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;

            var loc1:*;
            texture = null;
            data = arg1;
            generateMipMaps = arg2;
            optimizeForRenderToTexture = arg3;
            scale = arg4;
            format = arg5;
            forcePotTexture = arg6;
            texture = starling.textures.Texture.empty(data.width / scale, data.height / scale, true, generateMipMaps, optimizeForRenderToTexture, scale, format, forcePotTexture);
            texture.root.uploadBitmapData(data);
            texture.root.onRestore = function ():void
            {
                texture.root.uploadBitmapData(data);
                return;
            }
            return texture;
        }

        public static function fromAtfData(arg1:flash.utils.ByteArray, arg2:Number=1, arg3:Boolean=true, arg4:Function=null, arg5:Boolean=false):starling.textures.Texture
        {
            var data:flash.utils.ByteArray;
            var scale:Number=1;
            var useMipMaps:Boolean=true;
            var async:Function=null;
            var premultipliedAlpha:Boolean=false;
            var context:flash.display3D.Context3D;
            var atfData:starling.textures.AtfData;
            var nativeTexture:flash.display3D.textures.Texture;
            var concreteTexture:starling.textures.ConcreteTexture;

            var loc1:*;
            concreteTexture = null;
            data = arg1;
            scale = arg2;
            useMipMaps = arg3;
            async = arg4;
            premultipliedAlpha = arg5;
            context = starling.core.Starling.context;
            if (context == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            atfData = new starling.textures.AtfData(data);
            nativeTexture = context.createTexture(atfData.width, atfData.height, atfData.format, false);
            concreteTexture = new ConcretePotTexture(nativeTexture, atfData.format, atfData.width, atfData.height, useMipMaps && atfData.numTextures > 1, premultipliedAlpha, false, scale);
            concreteTexture.uploadAtfData(data, 0, async);
            concreteTexture.onRestore = function ():void
            {
                concreteTexture.uploadAtfData(data, 0);
                return;
            }
            return concreteTexture;
        }

        public static function fromNetStream(arg1:flash.net.NetStream, arg2:Number=1, arg3:Function=null):starling.textures.Texture
        {
            var stream:flash.net.NetStream;
            var scale:Number=1;
            var onComplete:Function=null;

            var loc1:*;
            stream = arg1;
            scale = arg2;
            onComplete = arg3;
            if (stream.client == stream && !("onMetaData" in stream)) 
            {
                stream.client = {"onMetaData":function (arg1:Object):void
                {
                    return;
                }}
            }
            return fromVideoAttachment("NetStream", stream, scale, onComplete);
        }

        public static function fromCamera(arg1:flash.media.Camera, arg2:Number=1, arg3:Function=null):starling.textures.Texture
        {
            return fromVideoAttachment("Camera", arg1, arg2, arg3);
        }

        internal static function fromVideoAttachment(arg1:String, arg2:Object, arg3:Number, arg4:Function):starling.textures.Texture
        {
            var type:String;
            var attachment:Object;
            var scale:Number;
            var onComplete:Function;
            var context:flash.display3D.Context3D;
            var base:flash.display3D.textures.VideoTexture;
            var texture:starling.textures.ConcreteTexture;

            var loc1:*;
            texture = null;
            type = arg1;
            attachment = arg2;
            scale = arg3;
            onComplete = arg4;
            if (!starling.utils.SystemUtil.supportsVideoTexture) 
            {
                throw new starling.errors.NotSupportedError("Video Textures are not supported on this platform");
            }
            context = starling.core.Starling.context;
            if (context == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            base = context.createVideoTexture();
            texture = new ConcreteVideoTexture(base, scale);
            texture.attachVideo(type, attachment, onComplete);
            texture.onRestore = function ():void
            {
                texture.root.attachVideo(type, attachment);
                return;
            }
            return texture;
        }

        public static function fromColor(arg1:Number, arg2:Number, arg3:uint=16777215, arg4:Number=1, arg5:Boolean=false, arg6:Number=-1, arg7:String="bgra", arg8:Boolean=false):starling.textures.Texture
        {
            var width:Number;
            var height:Number;
            var color:uint=16777215;
            var alpha:Number=1;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=-1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;

            var loc1:*;
            texture = null;
            width = arg1;
            height = arg2;
            color = arg3;
            alpha = arg4;
            optimizeForRenderToTexture = arg5;
            scale = arg6;
            format = arg7;
            forcePotTexture = arg8;
            texture = starling.textures.Texture.empty(width, height, true, false, optimizeForRenderToTexture, scale, format, forcePotTexture);
            texture.root.clear(color, alpha);
            texture.root.onRestore = function ():void
            {
                texture.root.clear(color, alpha);
                return;
            }
            return texture;
        }

        public static function empty(arg1:Number, arg2:Number, arg3:Boolean=true, arg4:Boolean=false, arg5:Boolean=false, arg6:Number=-1, arg7:String="bgra", arg8:Boolean=false):starling.textures.Texture
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (arg6 <= 0) 
            {
                arg6 = starling.core.Starling.contentScaleFactor;
            }
            var loc5:*=starling.core.Starling.context;
            if (loc5 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            var loc6:*=arg1 * arg6;
            var loc7:*=arg2 * arg6;
            var loc8:*=!arg8 && !arg4 && !(starling.core.Starling.current.profile == "baselineConstrained") && arg7.indexOf("compressed") == -1;
            if (loc8) 
            {
                loc1 = Math.ceil(loc6 - 1e-009);
                loc2 = Math.ceil(loc7 - 1e-009);
                loc3 = loc5.createRectangleTexture(loc1, loc2, arg7, arg5);
                loc4 = new ConcreteRectangleTexture(loc3 as flash.display3D.textures.RectangleTexture, arg7, loc1, loc2, arg3, arg5, arg6);
            }
            else 
            {
                loc1 = starling.utils.MathUtil.getNextPowerOfTwo(loc6);
                loc2 = starling.utils.MathUtil.getNextPowerOfTwo(loc7);
                loc3 = loc5.createTexture(loc1, loc2, arg7, arg5);
                loc4 = new ConcretePotTexture(loc3 as flash.display3D.textures.Texture, arg7, loc1, loc2, arg4, arg3, arg5, arg6);
            }
            loc4.onRestore = loc4.clear;
            if (loc1 - loc6 < 0.001 && loc2 - loc7 < 0.001) 
            {
                return loc4;
            }
            return new starling.textures.SubTexture(loc4, new flash.geom.Rectangle(0, 0, arg1, arg2), true);
        }

        public static function fromTexture(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:flash.geom.Rectangle=null, arg4:Boolean=false, arg5:Number=1):starling.textures.Texture
        {
            return new starling.textures.SubTexture(arg1, arg2, false, arg3, arg4, arg5);
        }

        public static function get maxSize():int
        {
            var loc1:*=starling.core.Starling.current;
            var loc2:*=loc1 ? loc1.profile : "baseline";
            if (loc2 == "baseline" || loc2 == "baselineConstrained") 
            {
                return 2048;
            }
            return 4096;
        }

        
        {
            sDefaultOptions = new starling.textures.TextureOptions();
            sRectangle = new flash.geom.Rectangle();
            sMatrix = new flash.geom.Matrix();
            sPoint = new flash.geom.Point();
        }

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sPoint:flash.geom.Point;

        internal static var sDefaultOptions:starling.textures.TextureOptions;

        internal static var sRectangle:flash.geom.Rectangle;
    }
}


//    class TextureAtlas
package starling.textures 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.utils.*;
    
    public class TextureAtlas extends Object
    {
        public function TextureAtlas(arg1:starling.textures.Texture, arg2:XML=null)
        {
            super();
            this._subTextures = new flash.utils.Dictionary();
            this._atlasTexture = arg1;
            if (arg2) 
            {
                this.parseAtlasXml(arg2);
            }
            return;
        }

        public function dispose():void
        {
            this._atlasTexture.dispose();
            return;
        }

        protected function parseAtlasXml(arg1:XML):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=false;
            var loc1:*=this._atlasTexture.scale;
            var loc2:*=new flash.geom.Rectangle();
            var loc3:*=new flash.geom.Rectangle();
            var loc15:*=0;
            var loc16:*=arg1.SubTexture;
            for each (loc4 in loc16) 
            {
                loc5 = starling.utils.StringUtil.clean(loc4.@name);
                loc6 = parseFloat(loc4.@x) / loc1;
                loc7 = parseFloat(loc4.@y) / loc1;
                loc8 = parseFloat(loc4.@width) / loc1;
                loc9 = parseFloat(loc4.@height) / loc1;
                loc10 = parseFloat(loc4.@frameX) / loc1;
                loc11 = parseFloat(loc4.@frameY) / loc1;
                loc12 = parseFloat(loc4.@frameWidth) / loc1;
                loc13 = parseFloat(loc4.@frameHeight) / loc1;
                loc14 = parseBool(loc4.@rotated);
                loc2.setTo(loc6, loc7, loc8, loc9);
                loc3.setTo(loc10, loc11, loc12, loc13);
                if (loc12 > 0 && loc13 > 0) 
                {
                    this.addRegion(loc5, loc2, loc3, loc14);
                    continue;
                }
                this.addRegion(loc5, loc2, null, loc14);
            }
            return;
        }

        public function getTexture(arg1:String):starling.textures.Texture
        {
            return this._subTextures[arg1];
        }

        public function getTextures(arg1:String="", arg2:__AS3__.vec.Vector.<starling.textures.Texture>=null):__AS3__.vec.Vector.<starling.textures.Texture>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<starling.textures.Texture>(0);
            }
            var loc2:*=0;
            var loc3:*=this.getNames(arg1, sNames);
            for each (loc1 in loc3) 
            {
                arg2[arg2.length] = this.getTexture(loc1);
            }
            sNames.length = 0;
            return arg2;
        }

        public function getNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<String>(0);
            }
            if (this._subTextureNames == null) 
            {
                this._subTextureNames = new Vector.<String>(0);
                var loc2:*=0;
                var loc3:*=this._subTextures;
                for (loc1 in loc3) 
                {
                    this._subTextureNames[this._subTextureNames.length] = loc1;
                }
                this._subTextureNames.sort(Array.CASEINSENSITIVE);
            }
            loc2 = 0;
            loc3 = this._subTextureNames;
            for each (loc1 in loc3) 
            {
                if (loc1.indexOf(arg1) != 0) 
                {
                    continue;
                }
                arg2[arg2.length] = loc1;
            }
            return arg2;
        }

        public function getRegion(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.region : null;
        }

        public function getFrame(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.frame : null;
        }

        public function getRotation(arg1:String):Boolean
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.rotated : false;
        }

        public function addRegion(arg1:String, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null, arg4:Boolean=false):void
        {
            this._subTextures[arg1] = new starling.textures.SubTexture(this._atlasTexture, arg2, false, arg3, arg4);
            this._subTextureNames = null;
            return;
        }

        public function removeRegion(arg1:String):void
        {
            var loc1:*=this._subTextures[arg1];
            if (loc1) 
            {
                loc1.dispose();
            }
            delete this._subTextures[arg1];
            this._subTextureNames = null;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._atlasTexture;
        }

        internal static function parseBool(arg1:String):Boolean
        {
            return arg1.toLowerCase() == "true";
        }

        
        {
            sNames = new Vector.<String>(0);
        }

        internal var _atlasTexture:starling.textures.Texture;

        internal var _subTextures:flash.utils.Dictionary;

        internal var _subTextureNames:__AS3__.vec.Vector.<String>;

        internal static var sNames:__AS3__.vec.Vector.<String>;
    }
}


//    class TextureOptions
package starling.textures 
{
    import starling.core.*;
    
    public class TextureOptions extends Object
    {
        public function TextureOptions(arg1:Number=1, arg2:Boolean=false, arg3:String="bgra", arg4:Boolean=true, arg5:Boolean=false)
        {
            super();
            this._scale = arg1;
            this._format = arg3;
            this._mipMapping = arg2;
            this._forcePotTexture = arg5;
            this._premultipliedAlpha = arg4;
            return;
        }

        public function clone():starling.textures.TextureOptions
        {
            var loc1:*=new starling.textures.TextureOptions(this._scale, this._mipMapping, this._format);
            loc1._optimizeForRenderToTexture = this._optimizeForRenderToTexture;
            loc1._premultipliedAlpha = this._premultipliedAlpha;
            loc1._forcePotTexture = this._forcePotTexture;
            loc1._onReady = this._onReady;
            return loc1;
        }

        public function get scale():Number
        {
            return this._scale;
        }

        public function set scale(arg1:Number):void
        {
            this._scale = arg1 > 0 ? arg1 : starling.core.Starling.contentScaleFactor;
            return;
        }

        public function get format():String
        {
            return this._format;
        }

        public function set format(arg1:String):void
        {
            this._format = arg1;
            return;
        }

        public function get mipMapping():Boolean
        {
            return this._mipMapping;
        }

        public function set mipMapping(arg1:Boolean):void
        {
            this._mipMapping = arg1;
            return;
        }

        public function get optimizeForRenderToTexture():Boolean
        {
            return this._optimizeForRenderToTexture;
        }

        public function set optimizeForRenderToTexture(arg1:Boolean):void
        {
            this._optimizeForRenderToTexture = arg1;
            return;
        }

        public function get forcePotTexture():Boolean
        {
            return this._forcePotTexture;
        }

        public function set forcePotTexture(arg1:Boolean):void
        {
            this._forcePotTexture = arg1;
            return;
        }

        public function get onReady():Function
        {
            return this._onReady;
        }

        public function set onReady(arg1:Function):void
        {
            this._onReady = arg1;
            return;
        }

        public function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public function set premultipliedAlpha(arg1:Boolean):void
        {
            this._premultipliedAlpha = arg1;
            return;
        }

        internal var _scale:Number;

        internal var _format:String;

        internal var _mipMapping:Boolean;

        internal var _optimizeForRenderToTexture:Boolean=false;

        internal var _premultipliedAlpha:Boolean;

        internal var _forcePotTexture:Boolean;

        internal var _onReady:Function=null;
    }
}


//    class TextureSmoothing
package starling.textures 
{
    import starling.errors.*;
    
    public class TextureSmoothing extends Object
    {
        public function TextureSmoothing()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == BILINEAR || arg1 == TRILINEAR;
        }

        public static const NONE:String="none";

        public static const BILINEAR:String="bilinear";

        public static const TRILINEAR:String="trilinear";
    }
}


//  package utils
//    class Align
package starling.utils 
{
    import starling.errors.*;
    
    public final class Align extends Object
    {
        public function Align()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == RIGHT || arg1 == CENTER || arg1 == TOP || arg1 == BOTTOM;
        }

        public static function isValidHorizontal(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == CENTER || arg1 == RIGHT;
        }

        public static function isValidVertical(arg1:String):Boolean
        {
            return arg1 == TOP || arg1 == CENTER || arg1 == BOTTOM;
        }

        public static const LEFT:String="left";

        public static const RIGHT:String="right";

        public static const TOP:String="top";

        public static const BOTTOM:String="bottom";

        public static const CENTER:String="center";
    }
}


//    class AssetManager
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.events.*;
    import starling.text.*;
    import starling.textures.*;
    
    public class AssetManager extends starling.events.EventDispatcher
    {
        public function AssetManager(arg1:Number=1, arg2:Boolean=false)
        {
            super();
            this._defaultTextureOptions = new starling.textures.TextureOptions(arg1, arg2);
            this._textures = new flash.utils.Dictionary();
            this._atlases = new flash.utils.Dictionary();
            this._sounds = new flash.utils.Dictionary();
            this._xmls = new flash.utils.Dictionary();
            this._objects = new flash.utils.Dictionary();
            this._byteArrays = new flash.utils.Dictionary();
            this._numConnections = 3;
            this._verbose = true;
            this._queue = [];
            return;
        }

        public function get useMipMaps():Boolean
        {
            return this._defaultTextureOptions.mipMapping;
        }

        public function set useMipMaps(arg1:Boolean):void
        {
            this._defaultTextureOptions.mipMapping = arg1;
            return;
        }

        public function get scaleFactor():Number
        {
            return this._defaultTextureOptions.scale;
        }

        public function set scaleFactor(arg1:Number):void
        {
            this._defaultTextureOptions.scale = arg1;
            return;
        }

        public function get textureFormat():String
        {
            return this._defaultTextureOptions.format;
        }

        public function set textureFormat(arg1:String):void
        {
            this._defaultTextureOptions.format = arg1;
            return;
        }

        public function get forcePotTextures():Boolean
        {
            return this._defaultTextureOptions.forcePotTexture;
        }

        public function set forcePotTextures(arg1:Boolean):void
        {
            this._defaultTextureOptions.forcePotTexture = arg1;
            return;
        }

        public function get checkPolicyFile():Boolean
        {
            return this._checkPolicyFile;
        }

        public function getTextures(arg1:String="", arg2:__AS3__.vec.Vector.<starling.textures.Texture>=null):__AS3__.vec.Vector.<starling.textures.Texture>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<starling.textures.Texture>(0);
            }
            var loc2:*=0;
            var loc3:*=this.getTextureNames(arg1, sNames);
            for each (loc1 in loc3) 
            {
                arg2[arg2.length] = this.getTexture(loc1);
            }
            sNames.length = 0;
            return arg2;
        }

        public function set checkPolicyFile(arg1:Boolean):void
        {
            this._checkPolicyFile = arg1;
            return;
        }

        public function get keepAtlasXmls():Boolean
        {
            return this._keepAtlasXmls;
        }

        public function set keepAtlasXmls(arg1:Boolean):void
        {
            this._keepAtlasXmls = arg1;
            return;
        }

        public function get keepFontXmls():Boolean
        {
            return this._keepFontXmls;
        }

        public function set keepFontXmls(arg1:Boolean):void
        {
            this._keepFontXmls = arg1;
            return;
        }

        public function get numConnections():int
        {
            return this._numConnections;
        }

        public function set numConnections(arg1:int):void
        {
            this._numConnections = arg1;
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=this._textures;
            for each (loc1 in loc6) 
            {
                loc1.dispose();
            }
            loc5 = 0;
            loc6 = this._atlases;
            for each (loc2 in loc6) 
            {
                loc2.dispose();
            }
            loc5 = 0;
            loc6 = this._xmls;
            for each (loc3 in loc6) 
            {
                flash.system.System.disposeXML(loc3);
            }
            loc5 = 0;
            loc6 = this._byteArrays;
            for each (loc4 in loc6) 
            {
                loc4.clear();
            }
            return;
        }

        public function getTexture(arg1:String):starling.textures.Texture
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 in this._textures) 
            {
                return this._textures[arg1];
            }
            var loc3:*=0;
            var loc4:*=this._atlases;
            for each (loc1 in loc4) 
            {
                loc2 = loc1.getTexture(arg1);
                if (!loc2) 
                {
                    continue;
                }
                return loc2;
            }
            return null;
        }

        
        {
            sNames = new Vector.<String>(0);
        }

        public function getTextureNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            arg2 = this.getDictionaryKeys(this._textures, arg1, arg2);
            var loc2:*=0;
            var loc3:*=this._atlases;
            for each (loc1 in loc3) 
            {
                loc1.getNames(arg1, arg2);
            }
            arg2.sort(Array.CASEINSENSITIVE);
            return arg2;
        }

        public function getTextureAtlas(arg1:String):starling.textures.TextureAtlas
        {
            return this._atlases[arg1] as starling.textures.TextureAtlas;
        }

        public function getTextureAtlasNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._atlases, arg1, arg2);
        }

        public function getSound(arg1:String):flash.media.Sound
        {
            return this._sounds[arg1];
        }

        public function getSoundNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._sounds, arg1, arg2);
        }

        public function playSound(arg1:String, arg2:Number=0, arg3:int=0, arg4:flash.media.SoundTransform=null):flash.media.SoundChannel
        {
            if (arg1 in this._sounds) 
            {
                return this.getSound(arg1).play(arg2, arg3, arg4);
            }
            return null;
        }

        public function getXml(arg1:String):XML
        {
            return this._xmls[arg1];
        }

        public function getXmlNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._xmls, arg1, arg2);
        }

        public function getObject(arg1:String):Object
        {
            return this._objects[arg1];
        }

        public function getObjectNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._objects, arg1, arg2);
        }

        public function getByteArray(arg1:String):flash.utils.ByteArray
        {
            return this._byteArrays[arg1];
        }

        public function getByteArrayNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._byteArrays, arg1, arg2);
        }

        public function addTexture(arg1:String, arg2:starling.textures.Texture):void
        {
            this.log("Adding texture \'" + arg1 + "\'");
            if (arg1 in this._textures) 
            {
                this.log("Warning: name was already in use; the previous texture will be replaced.");
                this._textures[arg1].dispose();
            }
            this._textures[arg1] = arg2;
            return;
        }

        public function addTextureAtlas(arg1:String, arg2:starling.textures.TextureAtlas):void
        {
            this.log("Adding texture atlas \'" + arg1 + "\'");
            if (arg1 in this._atlases) 
            {
                this.log("Warning: name was already in use; the previous atlas will be replaced.");
                this._atlases[arg1].dispose();
            }
            this._atlases[arg1] = arg2;
            return;
        }

        public function addSound(arg1:String, arg2:flash.media.Sound):void
        {
            this.log("Adding sound \'" + arg1 + "\'");
            if (arg1 in this._sounds) 
            {
                this.log("Warning: name was already in use; the previous sound will be replaced.");
            }
            this._sounds[arg1] = arg2;
            return;
        }

        public function addXml(arg1:String, arg2:XML):void
        {
            this.log("Adding XML \'" + arg1 + "\'");
            if (arg1 in this._xmls) 
            {
                this.log("Warning: name was already in use; the previous XML will be replaced.");
                flash.system.System.disposeXML(this._xmls[arg1]);
            }
            this._xmls[arg1] = arg2;
            return;
        }

        public function addObject(arg1:String, arg2:Object):void
        {
            this.log("Adding object \'" + arg1 + "\'");
            if (arg1 in this._objects) 
            {
                this.log("Warning: name was already in use; the previous object will be replaced.");
            }
            this._objects[arg1] = arg2;
            return;
        }

        public function addByteArray(arg1:String, arg2:flash.utils.ByteArray):void
        {
            this.log("Adding byte array \'" + arg1 + "\'");
            if (arg1 in this._byteArrays) 
            {
                this.log("Warning: name was already in use; the previous byte array will be replaced.");
                this._byteArrays[arg1].clear();
            }
            this._byteArrays[arg1] = arg2;
            return;
        }

        public function removeTexture(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing texture \'" + arg1 + "\'");
            if (arg2 && arg1 in this._textures) 
            {
                this._textures[arg1].dispose();
            }
            delete this._textures[arg1];
            return;
        }

        public function removeTextureAtlas(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing texture atlas \'" + arg1 + "\'");
            if (arg2 && arg1 in this._atlases) 
            {
                this._atlases[arg1].dispose();
            }
            delete this._atlases[arg1];
            return;
        }

        public function removeSound(arg1:String):void
        {
            this.log("Removing sound \'" + arg1 + "\'");
            delete this._sounds[arg1];
            return;
        }

        public function removeXml(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing xml \'" + arg1 + "\'");
            if (arg2 && arg1 in this._xmls) 
            {
                flash.system.System.disposeXML(this._xmls[arg1]);
            }
            delete this._xmls[arg1];
            return;
        }

        public function removeObject(arg1:String):void
        {
            this.log("Removing object \'" + arg1 + "\'");
            delete this._objects[arg1];
            return;
        }

        public function removeByteArray(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing byte array \'" + arg1 + "\'");
            if (arg2 && arg1 in this._byteArrays) 
            {
                this._byteArrays[arg1].clear();
            }
            delete this._byteArrays[arg1];
            return;
        }

        public function purgeQueue():void
        {
            this._queue.length = 0;
            dispatchEventWith(starling.events.Event.CANCEL);
            return;
        }

        public function purge():void
        {
            this.log("Purging all assets, emptying queue");
            this.purgeQueue();
            this.dispose();
            this._textures = new flash.utils.Dictionary();
            this._atlases = new flash.utils.Dictionary();
            this._sounds = new flash.utils.Dictionary();
            this._xmls = new flash.utils.Dictionary();
            this._objects = new flash.utils.Dictionary();
            this._byteArrays = new flash.utils.Dictionary();
            return;
        }

        public function enqueue(... rest):void
        {
            var rawAssets:Array;
            var rawAsset:Object;
            var typeXml:XML;
            var childNode:XML;

            var loc1:*;
            rawAsset = null;
            typeXml = null;
            childNode = null;
            rawAssets = rest;
            var loc2:*=0;
            var loc3:*=rawAssets;
            for each (rawAsset in loc3) 
            {
                if (rawAsset is Array) 
                {
                    this.enqueue.apply(this, rawAsset);
                    continue;
                }
                if (rawAsset is Class) 
                {
                    typeXml = flash.utils.describeType(rawAsset);
                    if (this._verbose) 
                    {
                        this.log("Looking for static embedded assets in \'" + typeXml.@name.split("::").pop() + "\'");
                    }
                    var loc4:*=0;
                    var loc7:*=0;
                    var loc8:*=typeXml.constant;
                    var loc6:*=new XMLList("");
                    for each (var loc9:* in loc8) 
                    {
                        var loc10:*;
                        with (loc10 = loc9) 
                        {
                            if (@type == "Class") 
                            {
                                loc6[loc7] = loc9;
                            }
                        }
                    }
                    var loc5:*=loc6;
                    for each (childNode in loc5) 
                    {
                        this.enqueueWithName(rawAsset[childNode.@name], childNode.@name);
                    }
                    loc4 = 0;
                    loc7 = 0;
                    loc8 = typeXml.variable;
                    loc6 = new XMLList("");
                    for each (loc9 in loc8) 
                    {
                        with (loc10 = loc9) 
                        {
                            if (@type == "Class") 
                            {
                                loc6[loc7] = loc9;
                            }
                        }
                    }
                    loc5 = loc6;
                    for each (childNode in loc5) 
                    {
                        this.enqueueWithName(rawAsset[childNode.@name], childNode.@name);
                    }
                    continue;
                }
                if (flash.utils.getQualifiedClassName(rawAsset) == "flash.filesystem::File") 
                {
                    if (rawAsset["exists"]) 
                    {
                        if (!rawAsset["isHidden"]) 
                        {
                            if (rawAsset["isDirectory"]) 
                            {
                                this.enqueue.apply(this, (loc4 = rawAsset)["getDirectoryListing"]());
                            }
                            else 
                            {
                                this.enqueueWithName(rawAsset);
                            }
                        }
                    }
                    else 
                    {
                        this.log("File or directory not found: \'" + rawAsset["url"] + "\'");
                    }
                    continue;
                }
                if (rawAsset is String || rawAsset is flash.net.URLRequest) 
                {
                    this.enqueueWithName(rawAsset);
                    continue;
                }
                this.log("Ignoring unsupported asset type: " + flash.utils.getQualifiedClassName(rawAsset));
            }
            return;
        }

        public function enqueueWithName(arg1:Object, arg2:String=null, arg3:starling.textures.TextureOptions=null):String
        {
            var loc1:*=null;
            if (flash.utils.getQualifiedClassName(arg1) == "flash.filesystem::File") 
            {
                loc1 = arg1["name"];
                arg1 = decodeURI(arg1["url"]);
            }
            if (arg2 == null) 
            {
                arg2 = this.getName(arg1);
            }
            if (arg3 != null) 
            {
                arg3 = arg3.clone();
            }
            else 
            {
                arg3 = this._defaultTextureOptions.clone();
            }
            this.log("Enqueuing \'" + (loc1 || arg2) + "\'");
            this._queue.push({"name":arg2, "asset":arg1, "options":arg3});
            return arg2;
        }

        public function loadQueue(arg1:Function):void
        {
            var onProgress:Function;
            var PROGRESS_PART_ASSETS:Number=0.9;
            var PROGRESS_PART_XMLS:Number=0.1;
            var i:int;
            var canceled:Boolean;
            var xmls:__AS3__.vec.Vector.<XML>;
            var assetInfos:Array;
            var assetCount:int;
            var assetProgress:Array;
            var assetIndex:int;
            var loadNextQueueElement:Function;
            var loadQueueElement:Function;
            var updateAssetProgress:Function;
            var processXmls:Function;
            var processXml:Function;
            var cancel:Function;
            var finish:Function;

            var loc1:*;
            PROGRESS_PART_ASSETS = NaN;
            PROGRESS_PART_XMLS = NaN;
            i = 0;
            canceled = false;
            xmls = null;
            assetInfos = null;
            assetCount = 0;
            assetProgress = null;
            assetIndex = 0;
            processXml = null;
            cancel = null;
            onProgress = arg1;
            loadNextQueueElement = function ():void
            {
                var loc1:*=0;
                if (assetIndex < assetInfos.length) 
                {
                    var loc2:*;
                    loc1 = assetIndex++;
                    loadQueueElement(loc1, assetInfos[loc1]);
                }
                return;
            }
            loadQueueElement = function (arg1:int, arg2:Object):void
            {
                var index:int;
                var assetInfo:Object;
                var onElementProgress:Function;
                var onElementLoaded:Function;

                var loc1:*;
                index = arg1;
                assetInfo = arg2;
                if (canceled) 
                {
                    return;
                }
                onElementProgress = function (arg1:Number):void
                {
                    updateAssetProgress(index, arg1 * 0.8);
                    return;
                }
                onElementLoaded = function ():void
                {
                    updateAssetProgress(index, 1);
                    var loc1:*;
                    assetCount--;
                    if (assetCount > 0) 
                    {
                        loadNextQueueElement();
                    }
                    else 
                    {
                        processXmls();
                    }
                    return;
                }
                processRawAsset(assetInfo.name, assetInfo.asset, assetInfo.options, xmls, onElementProgress, onElementLoaded);
                return;
            }
            updateAssetProgress = function (arg1:int, arg2:Number):void
            {
                assetProgress[arg1] = arg2;
                var loc1:*=0;
                var loc2:*=assetProgress.length;
                i = 0;
                while (i < loc2) 
                {
                    loc1 = loc1 + assetProgress[i];
                    var loc3:*;
                    i++;
                }
                onProgress(loc1 / loc2 * PROGRESS_PART_ASSETS);
                return;
            }
            processXmls = function ():void
            {
                var loc1:*;
                xmls.sort(function (arg1:XML, arg2:XML):int
                {
                    return arg1.localName() != "TextureAtlas" ? 1 : -1;
                })
                flash.utils.setTimeout(processXml, 1, 0);
                return;
            }
            processXml = function (arg1:int):void
            {
                var loc1:*=null;
                var loc2:*=null;
                if (canceled) 
                {
                    return;
                }
                if (arg1 == xmls.length) 
                {
                    finish();
                    return;
                }
                var loc3:*=xmls[arg1];
                var loc4:*=loc3.localName();
                var loc5:*=(arg1 + 1) / (xmls.length + 1);
                if (loc4 != "TextureAtlas") 
                {
                    if (loc4 != "font") 
                    {
                        throw new Error("XML contents not recognized: " + loc4);
                    }
                    else 
                    {
                        loc1 = getName(loc3.pages.page.@file.toString());
                        loc2 = getTexture(loc1);
                        if (loc2) 
                        {
                            log("Adding bitmap font \'" + loc1 + "\'");
                            starling.text.TextField.registerCompositor(new starling.text.BitmapFont(loc2, loc3), loc1);
                            removeTexture(loc1, false);
                            if (_keepFontXmls) 
                            {
                                addXml(loc1, loc3);
                            }
                            else 
                            {
                                flash.system.System.disposeXML(loc3);
                            }
                        }
                        else 
                        {
                            log("Cannot create bitmap font: texture \'" + loc1 + "\' is missing.");
                        }
                    }
                }
                else 
                {
                    loc1 = getName(loc3.@imagePath.toString());
                    loc2 = getTexture(loc1);
                    if (loc2) 
                    {
                        addTextureAtlas(loc1, new starling.textures.TextureAtlas(loc2, loc3));
                        removeTexture(loc1, false);
                        if (_keepAtlasXmls) 
                        {
                            addXml(loc1, loc3);
                        }
                        else 
                        {
                            flash.system.System.disposeXML(loc3);
                        }
                    }
                    else 
                    {
                        log("Cannot create atlas: texture \'" + loc1 + "\' is missing.");
                    }
                }
                onProgress(PROGRESS_PART_ASSETS + PROGRESS_PART_XMLS * loc5);
                flash.utils.setTimeout(processXml, 1, arg1 + 1);
                return;
            }
            cancel = function ():void
            {
                removeEventListener(starling.events.Event.CANCEL, cancel);
                var loc1:*;
                _numLoadingQueues--;
                canceled = true;
                return;
            }
            finish = function ():void
            {
                var loc1:*;
                flash.utils.setTimeout(function ():void
                {
                    if (!canceled) 
                    {
                        cancel();
                        onProgress(1);
                    }
                    return;
                }, 1)
                return;
            }
            if (onProgress == null) 
            {
                throw new ArgumentError("Argument \'onProgress\' must not be null");
            }
            if (this._queue.length == 0) 
            {
                onProgress(1);
                return;
            }
            this._starling = starling.core.Starling.current;
            if (this._starling == null || this._starling.context == null) 
            {
                throw new Error("The Starling instance needs to be ready before assets can be loaded.");
            }
            PROGRESS_PART_ASSETS = 0.9;
            PROGRESS_PART_XMLS = 1 - PROGRESS_PART_ASSETS;
            canceled = false;
            xmls = new Vector.<XML>(0);
            assetInfos = this._queue.concat();
            assetCount = this._queue.length;
            assetProgress = [];
            assetIndex = 0;
            i = 0;
            while (i < assetCount) 
            {
                assetProgress[i] = 0;
                ++i;
            }
            i = 0;
            while (i < this._numConnections) 
            {
                loadNextQueueElement();
                ++i;
            }
            this._queue.length = 0;
            var loc2:*;
            var loc3:*=((loc2 = this)._numLoadingQueues + 1);
            loc2._numLoadingQueues = loc3;
            addEventListener(starling.events.Event.CANCEL, cancel);
            return;
        }

        internal function processRawAsset(arg1:String, arg2:Object, arg3:starling.textures.TextureOptions, arg4:__AS3__.vec.Vector.<XML>, arg5:Function, arg6:Function):void
        {
            var name:String;
            var rawAsset:Object;
            var options:starling.textures.TextureOptions;
            var xmls:__AS3__.vec.Vector.<XML>;
            var onProgress:Function;
            var onComplete:Function;
            var canceled:Boolean;
            var process:Function;
            var progress:Function;
            var cancel:Function;

            var loc1:*;
            canceled = false;
            process = null;
            progress = null;
            cancel = null;
            name = arg1;
            rawAsset = arg2;
            options = arg3;
            xmls = arg4;
            onProgress = arg5;
            onComplete = arg6;
            process = function (arg1:Object):void
            {
                var asset:Object;
                var texture:starling.textures.Texture;
                var bytes:flash.utils.ByteArray;
                var object:Object;
                var xml:XML;

                var loc1:*;
                texture = null;
                bytes = null;
                asset = arg1;
                object = null;
                xml = null;
                _starling.makeCurrent();
                if (!canceled) 
                {
                    if (asset != null) 
                    {
                        if (asset is flash.media.Sound) 
                        {
                            addSound(name, asset as flash.media.Sound);
                            onComplete();
                        }
                        else if (asset is XML) 
                        {
                            xml = asset as XML;
                            if (xml.localName() == "TextureAtlas" || xml.localName() == "font") 
                            {
                                xmls.push(xml);
                            }
                            else 
                            {
                                addXml(name, xml);
                            }
                            onComplete();
                        }
                        else 
                        {
                            if (_starling.context.driverInfo == "Disposed") 
                            {
                                log("Context lost while processing assets, retrying ...");
                                flash.utils.setTimeout(process, 1, asset);
                                return;
                            }
                            if (asset is flash.display.Bitmap) 
                            {
                                texture = starling.textures.Texture.fromData(asset, options);
                                texture.root.onRestore = function ():void
                                {
                                    var loc1:*;
                                    var loc2:*;
                                    _numLostTextures++;
                                    loadRawAsset(rawAsset, null, function (arg1:Object):void
                                    {
                                        var asset:Object;

                                        var loc1:*;
                                        asset = arg1;
                                        try 
                                        {
                                            if (asset == null) 
                                            {
                                                throw new Error("Reload failed");
                                            }
                                            texture.root.uploadBitmap(asset as flash.display.Bitmap);
                                            asset.bitmapData.dispose();
                                        }
                                        catch (e:Error)
                                        {
                                            log("Texture restoration failed for \'" + name + "\': " + e.message);
                                        }
                                        _numRestoredTextures++;
                                        starling.core.Starling.current.stage.setRequiresRedraw();
                                        if (_numLostTextures == _numRestoredTextures) 
                                        {
                                            dispatchEventWith(starling.events.Event.TEXTURES_RESTORED);
                                        }
                                        return;
                                    })
                                    return;
                                }
                                asset.bitmapData.dispose();
                                addTexture(name, texture);
                                onComplete();
                            }
                            else if (asset is flash.utils.ByteArray) 
                            {
                                bytes = asset as flash.utils.ByteArray;
                                if (starling.textures.AtfData.isAtfData(bytes)) 
                                {
                                    options.onReady = prependCallback(options.onReady, function ():void
                                    {
                                        addTexture(name, texture);
                                        onComplete();
                                        return;
                                    })
                                    texture = starling.textures.Texture.fromData(bytes, options);
                                    texture.root.onRestore = function ():void
                                    {
                                        var loc1:*;
                                        var loc2:*;
                                        _numLostTextures++;
                                        loadRawAsset(rawAsset, null, function (arg1:Object):void
                                        {
                                            var asset:Object;

                                            var loc1:*;
                                            asset = arg1;
                                            try 
                                            {
                                                if (asset == null) 
                                                {
                                                    throw new Error("Reload failed");
                                                }
                                                texture.root.uploadAtfData(asset as flash.utils.ByteArray, 0, false);
                                                asset.clear();
                                            }
                                            catch (e:Error)
                                            {
                                                log("Texture restoration failed for \'" + name + "\': " + e.message);
                                            }
                                            _numRestoredTextures++;
                                            starling.core.Starling.current.stage.setRequiresRedraw();
                                            if (_numLostTextures == _numRestoredTextures) 
                                            {
                                                dispatchEventWith(starling.events.Event.TEXTURES_RESTORED);
                                            }
                                            return;
                                        })
                                        return;
                                    }
                                    bytes.clear();
                                }
                                else if (byteArrayStartsWith(bytes, "{") || byteArrayStartsWith(bytes, "[")) 
                                {
                                    try 
                                    {
                                        object = JSON.parse(bytes.readUTFBytes(bytes.length));
                                    }
                                    catch (e:Error)
                                    {
                                        log("Could not parse JSON: " + e.message);
                                        dispatchEventWith(starling.events.Event.PARSE_ERROR, false, name);
                                    }
                                    if (object) 
                                    {
                                        addObject(name, object);
                                    }
                                    bytes.clear();
                                    onComplete();
                                }
                                else if (byteArrayStartsWith(bytes, "<")) 
                                {
                                    try 
                                    {
                                        xml = new XML(bytes);
                                    }
                                    catch (e:Error)
                                    {
                                        log("Could not parse XML: " + e.message);
                                        dispatchEventWith(starling.events.Event.PARSE_ERROR, false, name);
                                    }
                                    process(xml);
                                    bytes.clear();
                                }
                                else 
                                {
                                    addByteArray(name, bytes);
                                    onComplete();
                                }
                            }
                            else 
                            {
                                addObject(name, asset);
                                onComplete();
                            }
                        }
                    }
                    else 
                    {
                        onComplete();
                    }
                }
                asset = null;
                bytes = null;
                removeEventListener(starling.events.Event.CANCEL, cancel);
                return;
            }
            progress = function (arg1:Number):void
            {
                if (!canceled) 
                {
                    onProgress(arg1);
                }
                return;
            }
            cancel = function ():void
            {
                canceled = true;
                return;
            }
            canceled = false;
            addEventListener(starling.events.Event.CANCEL, cancel);
            this.loadRawAsset(rawAsset, progress, process);
            return;
        }

        protected function loadRawAsset(arg1:Object, arg2:Function, arg3:Function):void
        {
            var rawAsset:Object;
            var onProgress:Function;
            var onComplete:Function;
            var extension:String;
            var loaderInfo:flash.display.LoaderInfo;
            var urlLoader:flash.net.URLLoader;
            var urlRequest:flash.net.URLRequest;
            var url:String;
            var onIoError:Function;
            var onSecurityError:Function;
            var onHttpResponseStatus:Function;
            var onLoadProgress:Function;
            var onUrlLoaderComplete:Function;
            var onLoaderComplete:Function;
            var complete:Function;

            var loc1:*;
            extension = null;
            loaderInfo = null;
            urlLoader = null;
            url = null;
            onIoError = null;
            onSecurityError = null;
            onHttpResponseStatus = null;
            onLoadProgress = null;
            onUrlLoaderComplete = null;
            onLoaderComplete = null;
            complete = null;
            rawAsset = arg1;
            onProgress = arg2;
            onComplete = arg3;
            onIoError = function (arg1:flash.events.IOErrorEvent):void
            {
                log("IO error: " + arg1.text);
                dispatchEventWith(starling.events.Event.IO_ERROR, false, url);
                complete(null);
                return;
            }
            onSecurityError = function (arg1:flash.events.SecurityErrorEvent):void
            {
                log("security error: " + arg1.text);
                dispatchEventWith(starling.events.Event.SECURITY_ERROR, false, url);
                complete(null);
                return;
            }
            onHttpResponseStatus = function (arg1:flash.events.HTTPStatusEvent):void
            {
                var loc1:*=null;
                var loc2:*=null;
                if (extension == null) 
                {
                    loc1 = arg1["responseHeaders"];
                    loc2 = getHttpHeader(loc1, "Content-Type");
                    if (loc2 && new RegExp("(audio|image)\\/").exec(loc2)) 
                    {
                        extension = loc2.split("/").pop();
                    }
                }
                return;
            }
            onLoadProgress = function (arg1:flash.events.ProgressEvent):void
            {
                if (!(onProgress == null) && arg1.bytesTotal > 0) 
                {
                    onProgress(arg1.bytesLoaded / arg1.bytesTotal);
                }
                return;
            }
            onUrlLoaderComplete = function (arg1:Object):void
            {
                var loc2:*=null;
                var loc3:*=null;
                var loc4:*=null;
                var loc1:*=transformData(urlLoader.data as flash.utils.ByteArray, url);
                if (loc1 == null) 
                {
                    complete(null);
                    return;
                }
                if (extension) 
                {
                    extension = extension.toLowerCase();
                }
                var loc5:*=extension;
                switch (loc5) 
                {
                    case "mpeg":
                    case "mp3":
                    {
                        loc2 = new flash.media.Sound();
                        loc2.loadCompressedDataFromByteArray(loc1, loc1.length);
                        loc1.clear();
                        complete(loc2);
                        break;
                    }
                    case "jpg":
                    case "jpeg":
                    case "png":
                    case "gif":
                    {
                        loc3 = new flash.system.LoaderContext(_checkPolicyFile);
                        loc4 = new flash.display.Loader();
                        loc3.imageDecodingPolicy = flash.system.ImageDecodingPolicy.ON_LOAD;
                        loaderInfo = loc4.contentLoaderInfo;
                        loaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                        loaderInfo.addEventListener(starling.events.Event.COMPLETE, onLoaderComplete);
                        loc4.loadBytes(loc1, loc3);
                        break;
                    }
                    default:
                    {
                        complete(loc1);
                        break;
                    }
                }
                return;
            }
            onLoaderComplete = function (arg1:Object):void
            {
                urlLoader.data.clear();
                complete(arg1.target.content);
                return;
            }
            complete = function (arg1:Object):void
            {
                if (urlLoader) 
                {
                    urlLoader.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                    urlLoader.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                    urlLoader.removeEventListener(HTTP_RESPONSE_STATUS, onHttpResponseStatus);
                    urlLoader.removeEventListener(flash.events.ProgressEvent.PROGRESS, onLoadProgress);
                    urlLoader.removeEventListener(starling.events.Event.COMPLETE, onUrlLoaderComplete);
                }
                if (loaderInfo) 
                {
                    loaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                    loaderInfo.removeEventListener(starling.events.Event.COMPLETE, onLoaderComplete);
                }
                if (starling.utils.SystemUtil.isDesktop) 
                {
                    onComplete(arg1);
                }
                else 
                {
                    starling.utils.SystemUtil.executeWhenApplicationIsActive(onComplete, arg1);
                }
                return;
            }
            extension = null;
            loaderInfo = null;
            urlLoader = null;
            urlRequest = null;
            url = null;
            if (rawAsset is Class) 
            {
                flash.utils.setTimeout(complete, 1, new rawAsset());
            }
            else if (rawAsset is String || rawAsset is flash.net.URLRequest) 
            {
                urlRequest = rawAsset as flash.net.URLRequest || new flash.net.URLRequest(rawAsset as String);
                url = urlRequest.url;
                extension = this.getExtensionFromUrl(url);
                urlLoader = new flash.net.URLLoader();
                urlLoader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
                urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                urlLoader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                urlLoader.addEventListener(HTTP_RESPONSE_STATUS, onHttpResponseStatus);
                urlLoader.addEventListener(flash.events.ProgressEvent.PROGRESS, onLoadProgress);
                urlLoader.addEventListener(starling.events.Event.COMPLETE, onUrlLoaderComplete);
                urlLoader.load(urlRequest);
            }
            return;
        }

        protected function getName(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                loc1 = arg1 as String;
            }
            else if (arg1 is flash.net.URLRequest) 
            {
                loc1 = (arg1 as flash.net.URLRequest).url;
            }
            else if (arg1 is flash.net.FileReference) 
            {
                loc1 = (arg1 as flash.net.FileReference).name;
            }
            if (loc1) 
            {
                loc1 = loc1.replace(new RegExp("%20", "g"), " ");
                loc1 = this.getBasenameFromUrl(loc1);
                if (loc1) 
                {
                    return loc1;
                }
                throw new ArgumentError("Could not extract name from String \'" + arg1 + "\'");
            }
            loc1 = flash.utils.getQualifiedClassName(arg1);
            throw new ArgumentError("Cannot extract names for objects of type \'" + loc1 + "\'");
        }

        protected function transformData(arg1:flash.utils.ByteArray, arg2:String):flash.utils.ByteArray
        {
            return arg1;
        }

        protected function log(arg1:String):void
        {
            if (this._verbose) 
            {
                trace("[AssetManager]", arg1);
            }
            return;
        }

        internal function byteArrayStartsWith(arg1:flash.utils.ByteArray, arg2:String):Boolean
        {
            var loc5:*=0;
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc3:*=arg2.charCodeAt(0);
            if (loc2 >= 4 && arg1[0] == 0 && arg1[1] == 0 && arg1[2] == 254 && arg1[3] == 255 || arg1[0] == 255 && arg1[1] == 254 && arg1[2] == 0 && arg1[3] == 0) 
            {
                loc1 = 4;
            }
            else if (loc2 >= 3 && arg1[0] == 239 && arg1[1] == 187 && arg1[2] == 191) 
            {
                loc1 = 3;
            }
            else if (loc2 >= 2 && arg1[0] == 254 && arg1[1] == 255 || arg1[0] == 255 && arg1[1] == 254) 
            {
                loc1 = 2;
            }
            var loc4:*=loc1;
            while (loc4 < loc2) 
            {
                loc5 = arg1[loc4];
                if (!(loc5 == 0 || loc5 == 10 || loc5 == 13 || loc5 == 32)) 
                {
                    return loc5 == loc3;
                }
                ++loc4;
            }
            return false;
        }

        internal function getDictionaryKeys(arg1:flash.utils.Dictionary, arg2:String="", arg3:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            if (arg3 == null) 
            {
                arg3 = new Vector.<String>(0);
            }
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                if (loc1.indexOf(arg2) != 0) 
                {
                    continue;
                }
                arg3[arg3.length] = loc1;
            }
            arg3.sort(Array.CASEINSENSITIVE);
            return arg3;
        }

        internal function getHttpHeader(arg1:Array, arg2:String):String
        {
            var loc1:*=null;
            if (arg1) 
            {
                var loc2:*=0;
                var loc3:*=arg1;
                for each (loc1 in loc3) 
                {
                    if (loc1.name != arg2) 
                    {
                        continue;
                    }
                    return loc1.value;
                }
            }
            return null;
        }

        protected function getBasenameFromUrl(arg1:String):String
        {
            var loc1:*=NAME_REGEX.exec(arg1);
            if (loc1 && loc1.length > 0) 
            {
                return loc1[1];
            }
            return null;
        }

        protected function getExtensionFromUrl(arg1:String):String
        {
            var loc1:*=NAME_REGEX.exec(arg1);
            if (loc1 && loc1.length > 1) 
            {
                return loc1[2];
            }
            return null;
        }

        internal function prependCallback(arg1:Function, arg2:Function):Function
        {
            var oldCallback:Function;
            var newCallback:Function;

            var loc1:*;
            oldCallback = arg1;
            newCallback = arg2;
            if (oldCallback == null) 
            {
                return newCallback;
            }
            if (newCallback == null) 
            {
                return oldCallback;
            }
            return function ():void
            {
                newCallback();
                oldCallback();
                return;
            }
        }

        protected function get queue():Array
        {
            return this._queue;
        }

        public function get numQueuedAssets():int
        {
            return this._queue.length;
        }

        public function get verbose():Boolean
        {
            return this._verbose;
        }

        public function set verbose(arg1:Boolean):void
        {
            this._verbose = arg1;
            return;
        }

        public function get isLoading():Boolean
        {
            return this._numLoadingQueues > 0;
        }

        internal static const NAME_REGEX:RegExp=new RegExp("([^\\?\\/\\\\]+?)(?:\\.([\\w\\-]+))?(?:\\?.*)?$");

        internal static const HTTP_RESPONSE_STATUS:String="httpResponseStatus";

        internal var _starling:starling.core.Starling;

        internal var _numLostTextures:int;

        internal var _numRestoredTextures:int;

        internal var _numLoadingQueues:int;

        internal var _defaultTextureOptions:starling.textures.TextureOptions;

        internal var _checkPolicyFile:Boolean;

        internal var _keepAtlasXmls:Boolean;

        internal var _keepFontXmls:Boolean;

        internal var _numConnections:int;

        internal var _queue:Array;

        internal var _textures:flash.utils.Dictionary;

        internal var _atlases:flash.utils.Dictionary;

        internal var _sounds:flash.utils.Dictionary;

        internal var _xmls:flash.utils.Dictionary;

        internal var _objects:flash.utils.Dictionary;

        internal var _byteArrays:flash.utils.Dictionary;

        internal var _verbose:Boolean;

        internal static var sNames:__AS3__.vec.Vector.<String>;
    }
}


//    class Color
package starling.utils 
{
    import __AS3__.vec.*;
    import starling.errors.*;
    
    public class Color extends Object
    {
        public function Color()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getAlpha(arg1:uint):int
        {
            return arg1 >> 24 & 255;
        }

        public static function getRed(arg1:uint):int
        {
            return arg1 >> 16 & 255;
        }

        public static function getGreen(arg1:uint):int
        {
            return arg1 >> 8 & 255;
        }

        public static function getBlue(arg1:uint):int
        {
            return arg1 & 255;
        }

        public static function rgb(arg1:int, arg2:int, arg3:int):uint
        {
            return arg1 << 16 | arg2 << 8 | arg3;
        }

        public static function argb(arg1:int, arg2:int, arg3:int, arg4:int):uint
        {
            return arg1 << 24 | arg2 << 16 | arg3 << 8 | arg4;
        }

        public static function toVector(arg1:uint, arg2:__AS3__.vec.Vector.<Number>=null):__AS3__.vec.Vector.<Number>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<Number>(4, true);
            }
            arg2[0] = (arg1 >> 16 & 255) / 255;
            arg2[1] = (arg1 >> 8 & 255) / 255;
            arg2[2] = (arg1 & 255) / 255;
            arg2[3] = (arg1 >> 24 & 255) / 255;
            return arg2;
        }

        public static function multiply(arg1:uint, arg2:Number):uint
        {
            var loc1:*=(arg1 >> 24 & 255) * arg2;
            var loc2:*=(arg1 >> 16 & 255) * arg2;
            var loc3:*=(arg1 >> 8 & 255) * arg2;
            var loc4:*=(arg1 & 255) * arg2;
            if (loc1 > 255) 
            {
                loc1 = 255;
            }
            if (loc2 > 255) 
            {
                loc2 = 255;
            }
            if (loc3 > 255) 
            {
                loc3 = 255;
            }
            if (loc4 > 255) 
            {
                loc4 = 255;
            }
            return argb(loc1, loc2, loc3, loc4);
        }

        public static function interpolate(arg1:uint, arg2:uint, arg3:Number):uint
        {
            var loc1:*=arg1 >> 24 & 255;
            var loc2:*=arg1 >> 16 & 255;
            var loc3:*=arg1 >> 8 & 255;
            var loc4:*=arg1 & 255;
            var loc5:*=arg2 >> 24 & 255;
            var loc6:*=arg2 >> 16 & 255;
            var loc7:*=arg2 >> 8 & 255;
            var loc8:*=arg2 & 255;
            var loc9:*=loc1 + (loc5 - loc1) * arg3;
            var loc10:*=loc2 + (loc6 - loc2) * arg3;
            var loc11:*=loc3 + (loc7 - loc3) * arg3;
            var loc12:*=loc4 + (loc8 - loc4) * arg3;
            return loc9 << 24 | loc10 << 16 | loc11 << 8 | loc12;
        }

        public static const WHITE:uint=16777215;

        public static const SILVER:uint=12632256;

        public static const GRAY:uint=8421504;

        public static const BLACK:uint=0;

        public static const RED:uint=16711680;

        public static const MAROON:uint=8388608;

        public static const YELLOW:uint=16776960;

        public static const OLIVE:uint=8421376;

        public static const LIME:uint=65280;

        public static const GREEN:uint=32768;

        public static const AQUA:uint=65535;

        public static const TEAL:uint=32896;

        public static const BLUE:uint=255;

        public static const NAVY:uint=128;

        public static const FUCHSIA:uint=16711935;

        public static const PURPLE:uint=8388736;
    }
}


//    class MathUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.errors.*;
    
    public class MathUtil extends Object
    {
        public function MathUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersectLineWithXYPlane(arg1:flash.geom.Vector3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=arg2.x - arg1.x;
            var loc2:*=arg2.y - arg1.y;
            var loc3:*=arg2.z - arg1.z;
            var loc4:*=(-arg1.z) / loc3;
            arg3.x = arg1.x + loc4 * loc1;
            arg3.y = arg1.y + loc4 * loc2;
            return arg3;
        }

        public static function isPointInTriangle(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):Boolean
        {
            var loc1:*=arg4.x - arg2.x;
            var loc2:*=arg4.y - arg2.y;
            var loc3:*=arg3.x - arg2.x;
            var loc4:*=arg3.y - arg2.y;
            var loc5:*=arg1.x - arg2.x;
            var loc6:*=arg1.y - arg2.y;
            var loc7:*=loc1 * loc1 + loc2 * loc2;
            var loc8:*=loc1 * loc3 + loc2 * loc4;
            var loc9:*=loc1 * loc5 + loc2 * loc6;
            var loc10:*=loc3 * loc3 + loc4 * loc4;
            var loc11:*=loc3 * loc5 + loc4 * loc6;
            var loc12:*=1 / (loc7 * loc10 - loc8 * loc8);
            var loc13:*=(loc10 * loc9 - loc8 * loc11) * loc12;
            var loc14:*=(loc7 * loc11 - loc8 * loc9) * loc12;
            return loc13 >= 0 && loc14 >= 0 && loc13 + loc14 < 1;
        }

        public static function normalizeAngle(arg1:Number):Number
        {
            arg1 = arg1 % TWO_PI;
            if (arg1 < -Math.PI) 
            {
                arg1 = arg1 + TWO_PI;
            }
            if (arg1 > Math.PI) 
            {
                arg1 = arg1 - TWO_PI;
            }
            return arg1;
        }

        public static function getNextPowerOfTwo(arg1:Number):int
        {
            var loc1:*=0;
            if (arg1 is int && arg1 > 0 && (arg1 & (arg1 - 1)) == 0) 
            {
                return arg1;
            }
            loc1 = 1;
            arg1 = arg1 - 1e-009;
            while (loc1 < arg1) 
            {
                loc1 = loc1 << 1;
            }
            return loc1;
        }

        public static function isEquivalent(arg1:Number, arg2:Number, arg3:Number=0.0001):Boolean
        {
            return arg1 - arg3 < arg2 && arg1 + arg3 > arg2;
        }

        public static function max(arg1:Number, arg2:Number):Number
        {
            return arg1 > arg2 ? arg1 : arg2;
        }

        public static function min(arg1:Number, arg2:Number):Number
        {
            return arg1 < arg2 ? arg1 : arg2;
        }

        public static function clamp(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return arg1 < arg2 ? arg2 : arg1 > arg3 ? arg3 : arg1;
        }

        internal static const TWO_PI:Number=Math.PI * 2;
    }
}


//    class MatrixUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class MatrixUtil extends Object
    {
        public function MatrixUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function convertTo3D(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix3D();
            }
            sRawData[0] = arg1.a;
            sRawData[1] = arg1.b;
            sRawData[4] = arg1.c;
            sRawData[5] = arg1.d;
            sRawData[12] = arg1.tx;
            sRawData[13] = arg1.ty;
            arg2.copyRawDataFrom(sRawData);
            return arg2;
        }

        public static function convertTo2D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix();
            }
            arg1.copyRawDataTo(sRawData2);
            arg2.a = sRawData2[0];
            arg2.b = sRawData2[1];
            arg2.c = sRawData2[4];
            arg2.d = sRawData2[5];
            arg2.tx = sRawData2[12];
            arg2.ty = sRawData2[13];
            return arg2;
        }

        public static function isIdentity(arg1:flash.geom.Matrix):Boolean
        {
            return arg1.a == 1 && arg1.b == 0 && arg1.c == 0 && arg1.d == 1 && arg1.tx == 0 && arg1.ty == 0;
        }

        public static function isIdentity3D(arg1:flash.geom.Matrix3D):Boolean
        {
            var loc1:*=sRawData2;
            arg1.copyRawDataTo(loc1);
            return loc1[0] == 1 && loc1[1] == 0 && loc1[2] == 0 && loc1[3] == 0 && loc1[4] == 0 && loc1[5] == 1 && loc1[6] == 0 && loc1[7] == 0 && loc1[8] == 0 && loc1[9] == 0 && loc1[10] == 1 && loc1[11] == 0 && loc1[12] == 0 && loc1[13] == 0 && loc1[14] == 0 && loc1[15] == 1;
        }

        public static function transformPoint(arg1:flash.geom.Matrix, arg2:flash.geom.Point, arg3:flash.geom.Point=null):flash.geom.Point
        {
            return transformCoords(arg1, arg2.x, arg2.y, arg3);
        }

        public static function transformPoint3D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            return transformCoords3D(arg1, arg2.x, arg2.y, arg2.z, arg3);
        }

        public static function transformCoords(arg1:flash.geom.Matrix, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):flash.geom.Point
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Point();
            }
            arg4.x = arg1.a * arg2 + arg1.c * arg3 + arg1.tx;
            arg4.y = arg1.d * arg3 + arg1.b * arg2 + arg1.ty;
            return arg4;
        }

        public static function transformCoords3D(arg1:flash.geom.Matrix3D, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Vector3D();
            }
            arg1.copyRawDataTo(sRawData2);
            arg5.x = arg2 * sRawData2[0] + arg3 * sRawData2[4] + arg4 * sRawData2[8] + sRawData2[12];
            arg5.y = arg2 * sRawData2[1] + arg3 * sRawData2[5] + arg4 * sRawData2[9] + sRawData2[13];
            arg5.z = arg2 * sRawData2[2] + arg3 * sRawData2[6] + arg4 * sRawData2[10] + sRawData2[14];
            arg5.w = arg2 * sRawData2[3] + arg3 * sRawData2[7] + arg4 * sRawData2[11] + sRawData2[15];
            return arg5;
        }

        public static function skew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 - arg1.b * loc1, arg1.a * loc3 + arg1.b * loc2, arg1.c * loc4 - arg1.d * loc1, arg1.c * loc3 + arg1.d * loc2, arg1.tx * loc4 - arg1.ty * loc1, arg1.tx * loc3 + arg1.ty * loc2);
            return;
        }

        public static function prependMatrix(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix):void
        {
            arg1.setTo(arg1.a * arg2.a + arg1.c * arg2.b, arg1.b * arg2.a + arg1.d * arg2.b, arg1.a * arg2.c + arg1.c * arg2.d, arg1.b * arg2.c + arg1.d * arg2.d, arg1.tx + arg1.a * arg2.tx + arg1.c * arg2.ty, arg1.ty + arg1.b * arg2.tx + arg1.d * arg2.ty);
            return;
        }

        public static function prependTranslation(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.tx = arg1.tx + (arg1.a * arg2 + arg1.c * arg3);
            arg1.ty = arg1.ty + (arg1.b * arg2 + arg1.d * arg3);
            return;
        }

        public static function prependScale(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.setTo(arg1.a * arg2, arg1.b * arg2, arg1.c * arg3, arg1.d * arg3, arg1.tx, arg1.ty);
            return;
        }

        public static function prependRotation(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            arg1.setTo(arg1.a * loc2 + arg1.c * loc1, arg1.b * loc2 + arg1.d * loc1, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function prependSkew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 + arg1.c * loc3, arg1.b * loc4 + arg1.d * loc3, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function toString3D(arg1:flash.geom.Matrix3D, arg2:Boolean=true, arg3:int=3):String
        {
            if (arg2) 
            {
                arg1.transpose();
            }
            arg1.copyRawDataTo(sRawData2);
            if (arg2) 
            {
                arg1.transpose();
            }
            return "[Matrix3D rawData=\n" + formatRawData(sRawData2, 4, 4, arg3) + "\n]";
        }

        public static function toString(arg1:flash.geom.Matrix, arg2:int=3):String
        {
            sRawData2[0] = arg1.a;
            sRawData2[1] = arg1.c;
            sRawData2[2] = arg1.tx;
            sRawData2[3] = arg1.b;
            sRawData2[4] = arg1.d;
            sRawData2[5] = arg1.ty;
            return "[Matrix rawData=\n" + formatRawData(sRawData2, 3, 2, arg2) + "\n]";
        }

        internal static function formatRawData(arg1:__AS3__.vec.Vector.<Number>, arg2:int, arg3:int, arg4:int, arg5:String="  "):String
        {
            var loc4:*=null;
            var loc5:*=NaN;
            var loc9:*=0;
            var loc1:*=arg5;
            var loc2:*=arg2 * arg3;
            var loc3:*=0;
            var loc6:*=0;
            while (loc6 < loc2) 
            {
                loc5 = Math.abs(arg1[loc6]);
                if (loc5 > loc3) 
                {
                    loc3 = loc5;
                }
                ++loc6;
            }
            var loc7:*=loc3.toFixed(arg4).length + 1;
            var loc8:*=0;
            while (loc8 < arg3) 
            {
                loc9 = 0;
                while (loc9 < arg2) 
                {
                    loc5 = arg1[arg2 * loc8 + loc9];
                    loc4 = loc5.toFixed(arg4);
                    while (loc4.length < loc7) 
                    {
                        loc4 = " " + loc4;
                    }
                    loc1 = loc1 + loc4;
                    if (loc9 != (arg2 - 1)) 
                    {
                        loc1 = loc1 + ", ";
                    }
                    ++loc9;
                }
                if (loc8 != (arg3 - 1)) 
                {
                    loc1 = loc1 + ("\n" + arg5);
                }
                ++loc8;
            }
            return loc1;
        }

        public static function snapToPixels(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=0.0001;
            var loc2:*=false;
            if (arg1.b + loc1 > 0 && arg1.b - loc1 < 0 && arg1.c + loc1 > 0 && arg1.c - loc1 < 0) 
            {
                loc3 = arg1.a * arg1.a;
                loc6 = arg1.d * arg1.d;
                loc2 = loc3 + loc1 > 1 && loc3 - loc1 < 1 && loc6 + loc1 > 1 && loc6 - loc1 < 1;
            }
            else if (arg1.a + loc1 > 0 && arg1.a - loc1 < 0 && arg1.d + loc1 > 0 && arg1.d - loc1 < 0) 
            {
                loc4 = arg1.b * arg1.b;
                loc5 = arg1.c * arg1.c;
                loc2 = loc4 + loc1 > 1 && loc4 - loc1 < 1 && loc5 + loc1 > 1 && loc5 - loc1 < 1;
            }
            if (loc2) 
            {
                arg1.tx = Math.round(arg1.tx / arg2) * arg2;
                arg1.ty = Math.round(arg1.ty / arg2) * arg2;
            }
            return;
        }

        public static function createPerspectiveProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null, arg8:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            var loc1:*=NaN;
            if (arg8 == null) 
            {
                arg8 = new flash.geom.Matrix3D();
            }
            if (arg5 <= 0) 
            {
                arg5 = arg3;
            }
            if (arg6 <= 0) 
            {
                arg6 = arg4;
            }
            if (arg7 == null) 
            {
                arg7 = sPoint3D;
                arg7.setTo(arg5 / 2, arg6 / 2, arg5 / Math.tan(0.5) * 0.5);
            }
            loc1 = Math.abs(arg7.z);
            var loc2:*=arg7.x - arg5 / 2;
            var loc3:*=arg7.y - arg6 / 2;
            var loc4:*=loc1 * 20;
            var loc5:*=1;
            var loc6:*=arg5 / arg3;
            var loc7:*=arg6 / arg4;
            sMatrixData[0] = 2 * loc1 / arg5;
            sMatrixData[5] = -2 * loc1 / arg6;
            sMatrixData[10] = loc4 / (loc4 - loc5);
            sMatrixData[14] = (-loc4) * loc5 / (loc4 - loc5);
            sMatrixData[11] = 1;
            sMatrixData[0] = sMatrixData[0] * loc6;
            sMatrixData[5] = sMatrixData[5] * loc7;
            sMatrixData[8] = (loc6 - 1) - 2 * loc6 * (arg1 - loc2) / arg5;
            sMatrixData[9] = -loc7 + 1 + 2 * loc7 * (arg2 - loc3) / arg6;
            arg8.copyRawDataFrom(sMatrixData);
            arg8.prependTranslation((-arg5) / 2 - loc2, (-arg6) / 2 - loc3, loc1);
            return arg8;
        }

        public static function createOrthographicProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Matrix();
            }
            arg5.setTo(2 / arg3, 0, 0, -2 / arg4, (-(2 * arg1 + arg3)) / arg3, (2 * arg2 + arg4) / arg4);
            return arg5;
        }

        
        {
            new Vector.<Number>(16)[0] = 1;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 1;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 1;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 1;
            sRawData = new Vector.<Number>(16);
            sRawData2 = new Vector.<Number>(16, true);
            sPoint3D = new flash.geom.Vector3D();
            new Vector.<Number>(16)[0] = 0;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 0;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 0;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 0;
            sMatrixData = new Vector.<Number>(16);
        }

        internal static var sRawData:__AS3__.vec.Vector.<Number>;

        internal static var sRawData2:__AS3__.vec.Vector.<Number>;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrixData:__AS3__.vec.Vector.<Number>;
    }
}


//    class MeshSubset
package starling.utils 
{
    public class MeshSubset extends Object
    {
        public function MeshSubset(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1)
        {
            super();
            this.setTo(arg1, arg2, arg3, arg4);
            return;
        }

        public function setTo(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1):void
        {
            this.vertexID = arg1;
            this.numVertices = arg2;
            this.indexID = arg3;
            this.numIndices = arg4;
            return;
        }

        public var vertexID:int;

        public var numVertices:int;

        public var indexID:int;

        public var numIndices:int;
    }
}


//    class MeshUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.rendering.*;
    
    public class MeshUtil extends Object
    {
        public function MeshUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function containsPoint(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:flash.geom.Point):Boolean
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=arg2.numIndices;
            var loc4:*=starling.utils.Pool.getPoint();
            var loc5:*=starling.utils.Pool.getPoint();
            var loc6:*=starling.utils.Pool.getPoint();
            loc1 = 0;
            while (loc1 < loc3) 
            {
                arg1.getPoint(arg2.getIndex(loc1), "position", loc4);
                arg1.getPoint(arg2.getIndex(loc1 + 1), "position", loc5);
                arg1.getPoint(arg2.getIndex(loc1 + 2), "position", loc6);
                if (starling.utils.MathUtil.isPointInTriangle(arg3, loc4, loc5, loc6)) 
                {
                    loc2 = true;
                    break;
                }
                loc1 = loc1 + 3;
            }
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putPoint(loc5);
            starling.utils.Pool.putPoint(loc6);
            return loc2;
        }

        public static function calculateBounds(arg1:starling.rendering.VertexData, arg2:starling.display.DisplayObject, arg3:starling.display.DisplayObject, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            var loc1:*=arg2.stage;
            if (arg2.is3D && loc1) 
            {
                loc1.getCameraPosition(arg3, sPoint3D);
                arg2.getTransformationMatrix3D(arg3, sMatrix3D);
                arg1.getBoundsProjected("position", sMatrix3D, sPoint3D, 0, -1, arg4);
            }
            else 
            {
                arg2.getTransformationMatrix(arg3, sMatrix);
                arg1.getBounds("position", sMatrix, 0, -1, arg4);
            }
            return arg4;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


//    class Padding
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


//    class Pool
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class Pool extends Object
    {
        public function Pool()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getPoint(arg1:Number=0, arg2:Number=0):flash.geom.Point
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Point(arg1, arg2);
            }
            loc1 = sPoints.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            return loc1;
        }

        public static function putPoint(arg1:flash.geom.Point):void
        {
            if (arg1) 
            {
                sPoints[sPoints.length] = arg1;
            }
            return;
        }

        public static function getPoint3D(arg1:Number=0, arg2:Number=0, arg3:Number=0):flash.geom.Vector3D
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Vector3D(arg1, arg2, arg3);
            }
            loc1 = sPoints3D.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            loc1.z = arg3;
            return loc1;
        }

        public static function putPoint3D(arg1:flash.geom.Vector3D):void
        {
            if (arg1) 
            {
                sPoints3D[sPoints3D.length] = arg1;
            }
            return;
        }

        public static function getMatrix(arg1:Number=1, arg2:Number=0, arg3:Number=0, arg4:Number=1, arg5:Number=0, arg6:Number=0):flash.geom.Matrix
        {
            var loc1:*=null;
            if (sMatrices.length == 0) 
            {
                return new flash.geom.Matrix(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            loc1 = sMatrices.pop();
            loc1.setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return loc1;
        }

        public static function putMatrix(arg1:flash.geom.Matrix):void
        {
            if (arg1) 
            {
                sMatrices[sMatrices.length] = arg1;
            }
            return;
        }

        public static function getMatrix3D(arg1:Boolean=true):flash.geom.Matrix3D
        {
            var loc1:*=null;
            if (sMatrices3D.length == 0) 
            {
                return new flash.geom.Matrix3D();
            }
            loc1 = sMatrices3D.pop();
            if (arg1) 
            {
                loc1.identity();
            }
            return loc1;
        }

        public static function putMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                sMatrices3D[sMatrices3D.length] = arg1;
            }
            return;
        }

        public static function getRectangle(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0):flash.geom.Rectangle
        {
            var loc1:*=null;
            if (sRectangles.length == 0) 
            {
                return new flash.geom.Rectangle(arg1, arg2, arg3, arg4);
            }
            loc1 = sRectangles.pop();
            loc1.setTo(arg1, arg2, arg3, arg4);
            return loc1;
        }

        public static function putRectangle(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                sRectangles[sRectangles.length] = arg1;
            }
            return;
        }

        
        {
            sPoints = new Vector.<flash.geom.Point>(0);
            sPoints3D = new Vector.<flash.geom.Vector3D>(0);
            sMatrices = new Vector.<flash.geom.Matrix>(0);
            sMatrices3D = new Vector.<flash.geom.Matrix3D>(0);
            sRectangles = new Vector.<flash.geom.Rectangle>(0);
        }

        internal static var sPoints:__AS3__.vec.Vector.<flash.geom.Point>;

        internal static var sPoints3D:__AS3__.vec.Vector.<flash.geom.Vector3D>;

        internal static var sMatrices:__AS3__.vec.Vector.<flash.geom.Matrix>;

        internal static var sMatrices3D:__AS3__.vec.Vector.<flash.geom.Matrix3D>;

        internal static var sRectangles:__AS3__.vec.Vector.<flash.geom.Rectangle>;
    }
}


//    class RectangleUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class RectangleUtil extends Object
    {
        public function RectangleUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersect(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.x > arg2.x ? arg1.x : arg2.x;
            var loc2:*=arg1.right < arg2.right ? arg1.right : arg2.right;
            var loc3:*=arg1.y > arg2.y ? arg1.y : arg2.y;
            var loc4:*=arg1.bottom < arg2.bottom ? arg1.bottom : arg2.bottom;
            if (loc1 > loc2 || loc3 > loc4) 
            {
                arg3.setEmpty();
            }
            else 
            {
                arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            return arg3;
        }

        public static function fit(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:String="showAll", arg4:Boolean=false, arg5:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (!starling.utils.ScaleMode.isValid(arg3)) 
            {
                throw new ArgumentError("Invalid scaleMode: " + arg3);
            }
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.width;
            var loc2:*=arg1.height;
            var loc3:*=arg2.width / loc1;
            var loc4:*=arg2.height / loc2;
            var loc5:*=1;
            if (arg3 != starling.utils.ScaleMode.SHOW_ALL) 
            {
                if (arg3 == starling.utils.ScaleMode.NO_BORDER) 
                {
                    loc5 = loc3 > loc4 ? loc3 : loc4;
                    if (arg4) 
                    {
                        loc5 = nextSuitableScaleFactor(loc5, true);
                    }
                }
            }
            else 
            {
                loc5 = loc3 < loc4 ? loc3 : loc4;
                if (arg4) 
                {
                    loc5 = nextSuitableScaleFactor(loc5, false);
                }
            }
            loc1 = loc1 * loc5;
            loc2 = loc2 * loc5;
            arg5.setTo(arg2.x + (arg2.width - loc1) / 2, arg2.y + (arg2.height - loc2) / 2, loc1, loc2);
            return arg5;
        }

        internal static function nextSuitableScaleFactor(arg1:Number, arg2:Boolean):Number
        {
            var loc1:*=1;
            if (arg2) 
            {
                if (arg1 >= 0.5) 
                {
                    return Math.ceil(arg1);
                }
                while (1 / (loc1 + 1) > arg1) 
                {
                    ++loc1;
                }
            }
            else 
            {
                if (arg1 >= 1) 
                {
                    return Math.floor(arg1);
                }
                while (1 / loc1 > arg1) 
                {
                    ++loc1;
                }
            }
            return 1 / loc1;
        }

        public static function normalize(arg1:flash.geom.Rectangle):void
        {
            if (arg1.width < 0) 
            {
                arg1.width = -arg1.width;
                arg1.x = arg1.x - arg1.width;
            }
            if (arg1.height < 0) 
            {
                arg1.height = -arg1.height;
                arg1.y = arg1.y - arg1.height;
            }
            return;
        }

        public static function extend(arg1:flash.geom.Rectangle, arg2:Number=0, arg3:Number=0, arg4:Number=0, arg5:Number=0):void
        {
            arg1.x = arg1.x - arg2;
            arg1.y = arg1.y - arg4;
            arg1.width = arg1.width + (arg2 + arg3);
            arg1.height = arg1.height + (arg4 + arg5);
            return;
        }

        public static function getBounds(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                starling.utils.MatrixUtil.transformCoords(arg2, loc5[loc6].x, loc5[loc6].y, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg3;
        }

        public static function getBoundsProjected(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix3D, arg3:flash.geom.Vector3D, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc7:*=null;
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            if (arg3 == null) 
            {
                throw new ArgumentError("camPos must not be null");
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                loc7 = loc5[loc6];
                if (arg2) 
                {
                    starling.utils.MatrixUtil.transformCoords3D(arg2, loc7.x, loc7.y, 0, sPoint3D);
                }
                else 
                {
                    sPoint3D.setTo(loc7.x, loc7.y, 0);
                }
                starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sPoint3D, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg4.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg4;
        }

        public static function getPositions(arg1:flash.geom.Rectangle, arg2:__AS3__.vec.Vector.<flash.geom.Point>=null):__AS3__.vec.Vector.<flash.geom.Point>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<flash.geom.Point>(4, true);
            }
            var loc1:*=0;
            while (loc1 < 4) 
            {
                if (arg2[loc1] == null) 
                {
                    arg2[loc1] = new flash.geom.Point();
                }
                ++loc1;
            }
            arg2[0].x = arg1.left;
            arg2[0].y = arg1.top;
            arg2[1].x = arg1.right;
            arg2[1].y = arg1.top;
            arg2[2].x = arg1.left;
            arg2[2].y = arg1.bottom;
            arg2[3].x = arg1.right;
            arg2[3].y = arg1.bottom;
            return arg2;
        }

        public static function compare(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:Number=0.0001):Boolean
        {
            if (arg1 == null) 
            {
                return arg2 == null;
            }
            if (arg2 == null) 
            {
                return false;
            }
            return arg1.x > arg2.x - arg3 && arg1.x < arg2.x + arg3 && arg1.y > arg2.y - arg3 && arg1.y < arg2.y + arg3 && arg1.width > arg2.width - arg3 && arg1.width < arg2.width + arg3 && arg1.height > arg2.height - arg3 && arg1.height < arg2.height + arg3;
        }

        
        {
            new Vector.<flash.geom.Point>(4)[0] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[1] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[2] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[3] = new flash.geom.Point();
        }

        internal static const sPoint:flash.geom.Point=new flash.geom.Point();

        internal static const sPoint3D:flash.geom.Vector3D=new flash.geom.Vector3D();

        internal static const sPositions:__AS3__.vec.Vector.<flash.geom.Point>=new Vector.<flash.geom.Point>(4);
    }
}


//    class RenderUtil
package starling.utils 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.textures.*;
    
    public class RenderUtil extends Object
    {
        public function RenderUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function clear(arg1:uint=0, arg2:Number=0):void
        {
            starling.core.Starling.context.clear(starling.utils.Color.getRed(arg1) / 255, starling.utils.Color.getGreen(arg1) / 255, starling.utils.Color.getBlue(arg1) / 255, arg2);
            return;
        }

        public static function getTextureLookupFlags(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:String="bilinear"):String
        {
            var loc1:*=["2d", arg3 ? "repeat" : "clamp"];
            if (arg1 != flash.display3D.Context3DTextureFormat.COMPRESSED) 
            {
                if (arg1 == "compressedAlpha") 
                {
                    loc1.push("dxt5");
                }
            }
            else 
            {
                loc1.push("dxt1");
            }
            if (arg4 != starling.textures.TextureSmoothing.NONE) 
            {
                if (arg4 != starling.textures.TextureSmoothing.BILINEAR) 
                {
                    loc1.push("linear", arg2 ? "miplinear" : "mipnone");
                }
                else 
                {
                    loc1.push("linear", arg2 ? "mipnearest" : "mipnone");
                }
            }
            else 
            {
                loc1.push("nearest", arg2 ? "mipnearest" : "mipnone");
            }
            return "<" + loc1.join() + ">";
        }

        public static function getTextureVariantBits(arg1:starling.textures.Texture):uint
        {
            if (arg1 == null) 
            {
                return 0;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.format;
            switch (loc3) 
            {
                case flash.display3D.Context3DTextureFormat.COMPRESSED_ALPHA:
                {
                    loc2 = 3;
                    break;
                }
                case flash.display3D.Context3DTextureFormat.COMPRESSED:
                {
                    loc2 = 2;
                    break;
                }
                default:
                {
                    loc2 = 1;
                }
            }
            loc1 = loc1 | loc2;
            if (!arg1.premultipliedAlpha) 
            {
                loc1 = loc1 | 1 << 2;
            }
            return loc1;
        }

        public static function setSamplerStateAt(arg1:int, arg2:Boolean, arg3:String="bilinear", arg4:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=arg4 ? flash.display3D.Context3DWrapMode.REPEAT : flash.display3D.Context3DWrapMode.CLAMP;
            if (arg3 != starling.textures.TextureSmoothing.NONE) 
            {
                if (arg3 != starling.textures.TextureSmoothing.BILINEAR) 
                {
                    loc2 = flash.display3D.Context3DTextureFilter.LINEAR;
                    loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPLINEAR : flash.display3D.Context3DMipFilter.MIPNONE;
                }
                else 
                {
                    loc2 = flash.display3D.Context3DTextureFilter.LINEAR;
                    loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPNEAREST : flash.display3D.Context3DMipFilter.MIPNONE;
                }
            }
            else 
            {
                loc2 = flash.display3D.Context3DTextureFilter.NEAREST;
                loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPNEAREST : flash.display3D.Context3DMipFilter.MIPNONE;
            }
            starling.core.Starling.context.setSamplerStateAt(arg1, loc1, loc2, loc3);
            return;
        }

        public static function createAGALTexOperation(arg1:String, arg2:String, arg3:int, arg4:starling.textures.Texture, arg5:Boolean=true, arg6:String="ft0"):String
        {
            var loc2:*=null;
            var loc1:*=arg4.format;
            var loc6:*=loc1;
            switch (loc6) 
            {
                case flash.display3D.Context3DTextureFormat.COMPRESSED:
                {
                    loc2 = "dxt1";
                    break;
                }
                case flash.display3D.Context3DTextureFormat.COMPRESSED_ALPHA:
                {
                    loc2 = "dxt5";
                    break;
                }
                default:
                {
                    loc2 = "rgba";
                }
            }
            var loc3:*=arg5 && !arg4.premultipliedAlpha;
            var loc4:*=loc3 && arg1 == "oc" ? arg6 : arg1;
            var loc5:*="tex " + loc4 + ", " + arg2 + ", fs" + arg3 + " <2d, " + loc2 + ">\n";
            if (loc3) 
            {
                if (arg1 != "oc") 
                {
                    loc5 = loc5 + ("mul " + arg1 + ".xyz, " + loc4 + ".xyz, " + loc4 + ".www\n");
                }
                else 
                {
                    loc5 = loc5 + ("mul " + loc4 + ".xyz, " + loc4 + ".xyz, " + loc4 + ".www\n");
                    loc5 = loc5 + ("mov " + arg1 + ", " + loc4);
                }
            }
            return loc5;
        }

        public static function requestContext3D(arg1:flash.display.Stage3D, arg2:String, arg3:*):void
        {
            var stage3D:flash.display.Stage3D;
            var renderMode:String;
            var profile:*;
            var profiles:Array;
            var currentProfile:String;
            var requestNextProfile:Function;
            var onCreated:Function;
            var onError:Function;
            var onFinished:Function;

            var loc1:*;
            profiles = null;
            currentProfile = null;
            requestNextProfile = null;
            onCreated = null;
            onError = null;
            stage3D = arg1;
            renderMode = arg2;
            profile = arg3;
            requestNextProfile = function ():void
            {
                var loc1:*;
                currentProfile = profiles.shift();
                try 
                {
                    starling.utils.execute(stage3D.requestContext3D, renderMode, currentProfile);
                }
                catch (error:Error)
                {
                    if (profiles.length == 0) 
                    {
                        throw error;
                    }
                    else 
                    {
                        flash.utils.setTimeout(requestNextProfile, 1);
                    }
                }
                return;
            }
            onCreated = function (arg1:flash.events.Event):void
            {
                var loc1:*=stage3D.context3D;
                if (renderMode == flash.display3D.Context3DRenderMode.AUTO && !(profiles.length == 0) && !(loc1.driverInfo.indexOf("Software") == -1)) 
                {
                    onError(arg1);
                }
                else 
                {
                    onFinished();
                }
                return;
            }
            onError = function (arg1:flash.events.Event):void
            {
                if (profiles.length == 0) 
                {
                    onFinished();
                }
                else 
                {
                    arg1.stopImmediatePropagation();
                    flash.utils.setTimeout(requestNextProfile, 1);
                }
                return;
            }
            onFinished = function ():void
            {
                stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, onCreated);
                stage3D.removeEventListener(flash.events.ErrorEvent.ERROR, onError);
                return;
            }
            if (profile != "auto") 
            {
                if (profile is String) 
                {
                    profiles = [profile as String];
                }
                else if (profile is Array) 
                {
                    profiles = profile as Array;
                }
                else 
                {
                    throw new ArgumentError("Profile must be of type \'String\' or \'Array\'");
                }
            }
            else 
            {
                profiles = ["standardExtended", "standard", "standardConstrained", "baselineExtended", "baseline", "baselineConstrained"];
            }
            stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, onCreated, false, 100);
            stage3D.addEventListener(flash.events.ErrorEvent.ERROR, onError, false, 100);
            requestNextProfile();
            return;
        }
    }
}


//    class ScaleMode
package starling.utils 
{
    import starling.errors.*;
    
    public class ScaleMode extends Object
    {
        public function ScaleMode()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == NO_BORDER || arg1 == SHOW_ALL;
        }

        public static const NONE:String="none";

        public static const NO_BORDER:String="noBorder";

        public static const SHOW_ALL:String="showAll";
    }
}


//    class StringUtil
package starling.utils 
{
    import starling.errors.*;
    
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function format(arg1:String, ... rest):String
        {
            var loc1:*=0;
            while (loc1 < rest.length) 
            {
                arg1 = arg1.replace(new RegExp("\\{" + loc1 + "\\}", "g"), rest[loc1]);
                ++loc1;
            }
            return arg1;
        }

        public static function clean(arg1:String):String
        {
            return ("_" + arg1).substr(1);
        }

        public static function trimStart(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            return arg1.substring(loc1, loc2);
        }

        public static function trimEnd(arg1:String):String
        {
            var loc1:*=(arg1.length - 1);
            while (loc1 >= 0) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                --loc1;
            }
            return arg1.substring(0, loc1 + 1);
        }

        public static function trim(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            loc2 = (arg1.length - 1);
            while (loc2 >= loc1) 
            {
                if (arg1.charCodeAt(loc2) > 32) 
                {
                    break;
                }
                --loc2;
            }
            return arg1.substring(loc1, loc2 + 1);
        }
    }
}


//    class SystemUtil
package starling.utils 
{
    import flash.display3D.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import starling.errors.*;
    
    public class SystemUtil extends Object
    {
        public function SystemUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function initialize():void
        {
            var nativeAppClass:Object;
            var nativeApp:flash.events.EventDispatcher;
            var appDescriptor:XML;
            var ns:Namespace;
            var ds:String;

            var loc1:*;
            nativeAppClass = null;
            nativeApp = null;
            appDescriptor = null;
            ns = null;
            ds = null;
            if (sInitialized) 
            {
                return;
            }
            sInitialized = true;
            sPlatform = flash.system.Capabilities.version.substr(0, 3);
            sVersion = flash.system.Capabilities.version.substr(4);
            sDesktop = !(new RegExp("(WIN|MAC|LNX)").exec(sPlatform) == null);
            try 
            {
                nativeAppClass = flash.utils.getDefinitionByName("flash.desktop::NativeApplication");
                nativeApp = nativeAppClass["nativeApplication"] as flash.events.EventDispatcher;
                nativeApp.addEventListener(flash.events.Event.ACTIVATE, onActivate, false, 0, true);
                nativeApp.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate, false, 0, true);
                appDescriptor = nativeApp["applicationDescriptor"];
                ns = appDescriptor.namespace();
                ds = appDescriptor.ns::initialWindow.ns::depthAndStencil.toString().toLowerCase();
                sSupportsDepthAndStencil = ds == "true";
                sAIR = true;
            }
            catch (e:Error)
            {
                sAIR = false;
            }
            return;
        }

        internal static function onActivate(arg1:Object):void
        {
            var event:Object;
            var call:Array;

            var loc1:*;
            call = null;
            event = arg1;
            sApplicationActive = true;
            var loc2:*=0;
            var loc3:*=sWaitingCalls;
            for each (call in loc3) 
            {
            };
            sWaitingCalls = [];
            return;
        }

        internal static function onDeactivate(arg1:Object):void
        {
            sApplicationActive = false;
            return;
        }

        public static function executeWhenApplicationIsActive(arg1:Function, ... rest):void
        {
            initialize();
            if (sApplicationActive) 
            {
                arg1.apply(null, rest);
            }
            else 
            {
                sWaitingCalls.push([arg1, rest]);
            }
            return;
        }

        public static function get isApplicationActive():Boolean
        {
            initialize();
            return sApplicationActive;
        }

        public static function get isAIR():Boolean
        {
            initialize();
            return sAIR;
        }

        public static function get isDesktop():Boolean
        {
            initialize();
            return sDesktop;
        }

        public static function get platform():String
        {
            initialize();
            return sPlatform;
        }

        public static function get version():String
        {
            initialize();
            return sVersion;
        }

        public static function get supportsDepthAndStencil():Boolean
        {
            return sSupportsDepthAndStencil;
        }

        public static function get supportsVideoTexture():Boolean
        {
            return flash.display3D.Context3D["supportsVideoTexture"];
        }

        public static function updateEmbeddedFonts():void
        {
            sEmbeddedFonts = null;
            return;
        }

        public static function isEmbeddedFont(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String="embedded"):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            if (sEmbeddedFonts == null) 
            {
                sEmbeddedFonts = flash.text.Font.enumerateFonts(false);
            }
            var loc5:*=0;
            var loc6:*=sEmbeddedFonts;
            for each (loc1 in loc6) 
            {
                loc2 = loc1.fontStyle;
                loc3 = loc2 == flash.text.FontStyle.BOLD || loc2 == flash.text.FontStyle.BOLD_ITALIC;
                loc4 = loc2 == flash.text.FontStyle.ITALIC || loc2 == flash.text.FontStyle.BOLD_ITALIC;
                if (!(arg1 == loc1.fontName && arg2 == loc3 && arg3 == loc4 && arg4 == loc1.fontType)) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        
        {
            sInitialized = false;
            sApplicationActive = true;
            sWaitingCalls = [];
            sEmbeddedFonts = null;
            sSupportsDepthAndStencil = true;
        }

        internal static var sInitialized:Boolean=false;

        internal static var sApplicationActive:Boolean=true;

        internal static var sWaitingCalls:Array;

        internal static var sPlatform:String;

        internal static var sDesktop:Boolean;

        internal static var sVersion:String;

        internal static var sAIR:Boolean;

        internal static var sEmbeddedFonts:Array=null;

        internal static var sSupportsDepthAndStencil:Boolean=true;
    }
}


//    function execute
package starling.utils 
{
    public function execute(arg1:Function, ... rest):void
    {
        var loc1:*=0;
        var loc2:*=0;
        if (arg1 != null) 
        {
            loc2 = arg1.length;
            loc1 = rest.length;
            while (loc1 < loc2) 
            {
                rest[loc1] = null;
                ++loc1;
            }
            var loc3:*=loc2;
            switch (loc3) 
            {
                case 0:
                {
                    arg1();
                    break;
                }
                case 1:
                {
                    arg1(rest[0]);
                    break;
                }
                case 2:
                {
                    arg1(rest[0], rest[1]);
                    break;
                }
                case 3:
                {
                    arg1(rest[0], rest[1], rest[2]);
                    break;
                }
                case 4:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3]);
                    break;
                }
                case 5:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4]);
                    break;
                }
                case 6:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5]);
                    break;
                }
                case 7:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5], rest[6]);
                    break;
                }
                default:
                {
                    arg1.apply(null, rest.slice(0, loc2));
                    break;
                }
            }
        }
        return;
    }
}


