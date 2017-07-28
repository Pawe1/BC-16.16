//class TransitionMultitouch
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


