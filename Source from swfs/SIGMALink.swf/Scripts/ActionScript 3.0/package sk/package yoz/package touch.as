//package touch
//  package events
//    class TransitionMultitouchEvent
package sk.yoz.touch.events 
{
    import flash.events.*;
    
    public class TransitionMultitouchEvent extends flash.events.Event
    {
        public function TransitionMultitouchEvent(arg1:String)
        {
            super(arg1, false, true);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new sk.yoz.touch.events.TransitionMultitouchEvent(type);
        }

        public static const TRANSITION_COMPLETE:String="transitionMultitouchTransitionComplete";
    }
}


//    class TwoFingerEvent
package sk.yoz.touch.events 
{
    import flash.events.*;
    import flash.geom.*;
    
    public class TwoFingerEvent extends flash.events.Event
    {
        public function TwoFingerEvent(arg1:String, arg2:flash.events.TouchEvent, arg3:flash.geom.Point, arg4:Number, arg5:Number)
        {
            super(arg1, false, true);
            _source = arg2;
            _lock = arg3;
            _scale = arg4;
            _rotation = arg5;
            return;
        }

        public function get source():flash.events.TouchEvent
        {
            return _source;
        }

        public function get lock():flash.geom.Point
        {
            return _lock;
        }

        public function get scale():Number
        {
            return _scale;
        }

        public function get rotation():Number
        {
            return _rotation;
        }

        public override function clone():flash.events.Event
        {
            return new sk.yoz.touch.events.TwoFingerEvent(type, source, lock, scale, rotation);
        }

        public static const SCALE_AND_ROTATE:String="twoFingerScaleAndRotate";

        internal var _source:flash.events.TouchEvent;

        internal var _lock:flash.geom.Point;

        internal var _scale:Number;

        internal var _rotation:Number;
    }
}


//  class TransitionMultitouch
package sk.yoz.touch 
{
    import com.greensock.*;
    import flash.events.*;
    import flash.geom.*;
    import sk.yoz.touch.events.*;
    
    public class TransitionMultitouch extends sk.yoz.touch.TwoFingerTouch implements flash.events.IEventDispatcher
    {
        public function TransitionMultitouch()
        {
            transition0 = new flash.geom.Point();
            transition1 = new flash.geom.Point();
            dispatcher = new flash.events.EventDispatcher();
            super();
            return;
        }

        internal function getTransition(arg1:flash.events.TouchEvent):flash.geom.Point
        {
            return arg1.isPrimaryTouchPoint ? transition0 : transition1;
        }

        internal function resetTransitions():void
        {
            if (last0) 
            {
                transition0.x = last0.x;
                transition0.y = last0.y;
            }
            if (last1) 
            {
                transition1.x = last1.x;
                transition1.y = last1.y;
            }
            return;
        }

        public function killTweens():void
        {
            com.greensock.TweenMax.killTweensOf(transition0);
            com.greensock.TweenMax.killTweensOf(transition1);
            return;
        }

        public function get isTweening():Boolean
        {
            return com.greensock.TweenMax.isTweening(transition0) || com.greensock.TweenMax.isTweening(transition1);
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            dispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return dispatcher.dispatchEvent(arg1);
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return dispatcher.hasEventListener(arg1);
        }

        public function willTrigger(arg1:String):Boolean
        {
            return dispatcher.willTrigger(arg1);
        }

        protected override function dispatch(arg1:flash.events.TouchEvent, arg2:flash.geom.Point):void
        {
            var loc1:*=getTransition(arg1);
            com.greensock.TweenMax.to(loc1, transitionDuration, {"x":arg2.x, "y":arg2.y, "onUpdateParams":[arg1, loc1], "onUpdate":super(
#error('findrop') dispatch
            ).dispatch, "onComplete":onTransitionComplete});
            return;
        }

        protected override function onTouchBegin(arg1:flash.events.TouchEvent):void
        {
            super.onTouchBegin(arg1);
            killTweens();
            resetTransitions();
            return;
        }

        protected override function onTouchMove(arg1:flash.events.TouchEvent):void
        {
            if (!(countFingers == 2) && isTweening) 
            {
                return;
            }
            if (countFingers != 2) 
            {
                resetTransitions();
            }
            super.onTouchMove(arg1);
            return;
        }

        protected override function onTouchEnd(arg1:flash.events.TouchEvent):void
        {
            super.onTouchEnd(arg1);
            resetTransitions();
            return;
        }

        protected override function onTouchRollOut(arg1:flash.events.TouchEvent):void
        {
            super.onTouchRollOut(arg1);
            resetTransitions();
            return;
        }

        internal function onTransitionComplete():void
        {
            var loc1:*="transitionMultitouchTransitionComplete";
            dispatcher.dispatchEvent(new sk.yoz.touch.events.TransitionMultitouchEvent(loc1));
            return;
        }

        public var transitionDuration:Number=0.5;

        internal var transition0:flash.geom.Point;

        internal var transition1:flash.geom.Point;

        internal var dispatcher:flash.events.EventDispatcher;
    }
}


//  class TwoFingerTouch
package sk.yoz.touch 
{
    import flash.events.*;
    import flash.geom.*;
    import sk.yoz.touch.events.*;
    
    public class TwoFingerTouch extends Object
    {
        public function TwoFingerTouch()
        {
            super();
            return;
        }

        public function get countFingers():int
        {
            return _countFingers;
        }

        public function attach(arg1:flash.events.IEventDispatcher, arg2:int=0):void
        {
            var loc1:*=null;
            loc1 = "touchBegin";
            arg1.addEventListener(loc1, onTouchBegin, false, 0, true);
            loc1 = "touchMove";
            arg1.addEventListener(loc1, onTouchMove, false, 0, true);
            loc1 = "touchEnd";
            arg1.addEventListener(loc1, onTouchEnd, false, 0, true);
            loc1 = "touchRollOut";
            arg1.addEventListener(loc1, onTouchRollOut, false, 0, true);
            return;
        }

        public function detach(arg1:flash.events.IEventDispatcher):void
        {
            var loc1:*=null;
            loc1 = "touchBegin";
            arg1.removeEventListener(loc1, onTouchBegin, false);
            loc1 = "touchMove";
            arg1.removeEventListener(loc1, onTouchMove, false);
            loc1 = "touchEnd";
            arg1.removeEventListener(loc1, onTouchEnd, false);
            loc1 = "touchRollOut";
            arg1.removeEventListener(loc1, onTouchRollOut, false);
            return;
        }

        public function getPoint(arg1:flash.events.TouchEvent):flash.geom.Point
        {
            return new flash.geom.Point(arg1.stageX, arg1.stageY);
        }

        protected function setLastByEvent(arg1:flash.events.TouchEvent):void
        {
            setLast(arg1, getPoint(arg1));
            return;
        }

        protected function setLast(arg1:flash.events.TouchEvent, arg2:flash.geom.Point):void
        {
            if (arg1.isPrimaryTouchPoint) 
            {
                last0 = arg2;
            }
            else 
            {
                last1 = arg2;
            }
            return;
        }

        public function getLast(arg1:flash.events.TouchEvent):flash.geom.Point
        {
            return arg1.isPrimaryTouchPoint ? last0 : last1;
        }

        protected function getLock(arg1:flash.events.TouchEvent):flash.geom.Point
        {
            return arg1.isPrimaryTouchPoint ? last1 : last0;
        }

        protected function getDispatcher(arg1:flash.events.TouchEvent):flash.events.IEventDispatcher
        {
            return arg1.currentTarget as flash.events.IEventDispatcher;
        }

        protected function dispatch(arg1:flash.events.TouchEvent, arg2:flash.geom.Point):void
        {
            var loc1:*=getLast(arg1);
            var loc2:*=getLock(arg1);
            var loc3:*=process(arg1, arg2, loc1, loc2);
            var loc4:*=getDispatcher(arg1);
            if (loc3 && loc4) 
            {
                loc4.dispatchEvent(loc3);
            }
            setLast(arg1, arg2.clone());
            return;
        }

        protected function onTouchBegin(arg1:flash.events.TouchEvent):void
        {
            ++_countFingers;
            setLastByEvent(arg1);
            return;
        }

        protected function onTouchMove(arg1:flash.events.TouchEvent):void
        {
            if (countFingers != 2) 
            {
                return setLastByEvent(arg1);
            }
            if (stopImmediatePropagation) 
            {
                arg1.stopImmediatePropagation();
            }
            dispatch(arg1, getPoint(arg1));
            return;
        }

        protected function onTouchEnd(arg1:flash.events.TouchEvent):void
        {
            if (_countFingers) 
            {
                --_countFingers;
            }
            return;
        }

        protected function onTouchRollOut(arg1:flash.events.TouchEvent):void
        {
            if (_countFingers) 
            {
                --_countFingers;
            }
            return;
        }

        public static function process(arg1:flash.events.TouchEvent, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):sk.yoz.touch.events.TwoFingerEvent
        {
            var loc9:*=arg3.x - arg4.x;
            var loc8:*=arg3.y - arg4.y;
            var loc7:*=arg2.x - arg4.x;
            var loc10:*=arg2.y - arg4.y;
            var loc3:*=Math.sqrt(loc7 * loc7 + loc10 * loc10) / Math.sqrt(loc9 * loc9 + loc8 * loc8);
            if (isNaN(loc3) || !isFinite(loc3)) 
            {
                return null;
            }
            var loc4:*=Math.atan2(loc8, loc9);
            var loc2:*;
            var loc1:*=(loc2 = Math.atan2(loc10, loc7)) - loc4;
            var loc5:*="twoFingerScaleAndRotate";
            var loc6:*=arg4.clone();
            return new sk.yoz.touch.events.TwoFingerEvent(loc5, arg1, loc6, loc3, loc1);
        }

        public var stopImmediatePropagation:Boolean=true;

        internal var _countFingers:int=0;

        protected var last0:flash.geom.Point;

        protected var last1:flash.geom.Point;
    }
}


