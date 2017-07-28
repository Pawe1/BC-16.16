//class TwoFingerTouch
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


