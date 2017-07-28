//package yoz
//  package math
//    class FastCollisions
package sk.yoz.math 
{
    public class FastCollisions extends Object
    {
        public function FastCollisions()
        {
            super();
            return;
        }

        public static function rectangles(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number, arg13:Number, arg14:Number, arg15:Number, arg16:Number):Boolean
        {
            if (!isProjectedAxisCollision(arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg3, arg4, arg5, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg9, arg10, arg11, arg12, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg11, arg12, arg13, arg14, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)) 
            {
                return false;
            }
            return true;
        }

        public static function isProjectedAxisCollision(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number):Boolean
        {
            var loc6:*=NaN;
            var loc8:*=NaN;
            var loc10:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc7:*=NaN;
            var loc9:*=NaN;
            var loc2:*=NaN;
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            if (arg1 == arg3) 
            {
                loc4 = loc6 = loc8 = loc10 = arg1;
                loc2 = arg6;
                loc5 = arg8;
                loc7 = arg10;
                loc9 = arg12;
                if (arg2 > arg4) 
                {
                    if (loc2 > arg2 && loc5 > arg2 && loc7 > arg2 && loc9 > arg2 || loc2 < arg4 && loc5 < arg4 && loc7 < arg4 && loc9 < arg4) 
                    {
                        return false;
                    }
                }
                else if (loc2 > arg4 && loc5 > arg4 && loc7 > arg4 && loc9 > arg4 || loc2 < arg2 && loc5 < arg2 && loc7 < arg2 && loc9 < arg2) 
                {
                    return false;
                }
                return true;
            }
            if (arg2 != arg4) 
            {
                loc1 = (arg2 - arg4) / (arg1 - arg3);
                loc3 = 1 / loc1;
                loc11 = arg3 * loc1 - arg4;
                loc12 = 1 / (loc1 + loc3);
                loc4 = (arg6 + loc11 + arg5 * loc3) * loc12;
                loc6 = (arg8 + loc11 + arg7 * loc3) * loc12;
                loc8 = (arg10 + loc11 + arg9 * loc3) * loc12;
                loc10 = (arg12 + loc11 + arg11 * loc3) * loc12;
                loc2 = arg6 + (arg5 - loc4) * loc3;
                loc5 = arg8 + (arg7 - loc6) * loc3;
                loc7 = arg10 + (arg9 - loc8) * loc3;
                loc9 = arg12 + (arg11 - loc10) * loc3;
            }
            else 
            {
                loc4 = arg5;
                loc6 = arg7;
                loc8 = arg9;
                loc10 = arg11;
                loc2 = loc5 = loc7 = loc9 = arg2;
            }
            if (arg1 > arg3) 
            {
                if (loc4 > arg1 && loc6 > arg1 && loc8 > arg1 && loc10 > arg1 || loc4 < arg3 && loc6 < arg3 && loc8 < arg3 && loc10 < arg3) 
                {
                    return false;
                }
            }
            else if (loc4 > arg3 && loc6 > arg3 && loc8 > arg3 && loc10 > arg3 || loc4 < arg1 && loc6 < arg1 && loc8 < arg1 && loc10 < arg1) 
            {
                return false;
            }
            return true;
        }

        public static function pointInRectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number):Boolean
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc1:*=NaN;
            if (arg3 != arg5) 
            {
                if (arg4 != arg6) 
                {
                    loc1 = (arg4 - arg6) / (arg3 - arg5);
                    loc2 = (arg2 - arg6 + arg5 * loc1 + arg1 / loc1) / (loc1 + 1 / loc1);
                    loc3 = arg2 + (arg1 - loc2) / loc1;
                }
                else 
                {
                    loc2 = arg1;
                    loc3 = arg4;
                }
            }
            else 
            {
                loc2 = arg3;
                loc3 = arg2;
                if (loc3 > (arg4 > arg6 ? arg4 : arg6)) 
                {
                    return false;
                }
                if (loc3 < (arg4 < arg6 ? arg4 : arg6)) 
                {
                    return false;
                }
            }
            if (loc2 > (arg3 > arg5 ? arg3 : arg5)) 
            {
                return false;
            }
            if (loc2 < (arg3 < arg5 ? arg3 : arg5)) 
            {
                return false;
            }
            if (arg5 != arg7) 
            {
                if (arg6 != arg8) 
                {
                    loc1 = (arg6 - arg8) / (arg5 - arg7);
                    loc2 = (arg2 - arg8 + arg7 * loc1 + arg1 / loc1) / (loc1 + 1 / loc1);
                    loc3 = arg2 + (arg1 - loc2) / loc1;
                }
                else 
                {
                    loc2 = arg1;
                    loc3 = arg6;
                }
            }
            else 
            {
                loc2 = arg5;
                loc3 = arg2;
                if (loc3 > (arg6 > arg8 ? arg6 : arg8)) 
                {
                    return false;
                }
                if (loc3 < (arg6 < arg8 ? arg6 : arg8)) 
                {
                    return false;
                }
            }
            if (loc2 > (arg5 > arg7 ? arg5 : arg7)) 
            {
                return false;
            }
            if (loc2 < (arg5 < arg7 ? arg5 : arg7)) 
            {
                return false;
            }
            return true;
        }

        public static function pointInTriangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):Boolean
        {
            var loc2:*=arg1 - arg3;
            var loc3:*=arg2 - arg4;
            var loc1:*=(arg5 - arg3) * loc3 - (arg6 - arg4) * loc2 > 0;
            if ((arg7 - arg3) * loc3 - (arg8 - arg4) * loc2 > 0 == loc1) 
            {
                return false;
            }
            if ((arg7 - arg5) * (arg2 - arg6) - (arg8 - arg6) * (arg1 - arg5) > 0 != loc1) 
            {
                return false;
            }
            return true;
        }
    }
}


//    class GeometryMath
package sk.yoz.math 
{
    import flash.geom.*;
    
    public class GeometryMath extends Object
    {
        public function GeometryMath()
        {
            super();
            return;
        }

        public static function degreesToRadians(arg1:Number):Number
        {
            return arg1 * 0.0174532925199;
        }

        public static function radiansToDegrees(arg1:Number):Number
        {
            return arg1 * 57.2957795131;
        }

        public static function isLine(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:Boolean=true):Boolean
        {
            var loc2:*=arg1.x - arg2.x;
            var loc4:*=arg2.x - arg3.x;
            var loc1:*=arg1.y - arg2.y;
            var loc3:*=arg2.y - arg3.y;
            if (arg4 && (loc2 > 0 && loc4 < 0 || loc2 < 0 && loc4 > 0 || loc1 < 0 && loc3 > 0 || loc1 < 0 && loc3 > 0)) 
            {
                return false;
            }
            if (!loc3) 
            {
                return !loc1;
            }
            if (!loc4) 
            {
                return !loc2;
            }
            return loc2 / loc4 == loc1 / loc3;
        }

        public static function rotatePoint(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            return rotatePointByRadians(arg1, arg2, arg3 * 0.0174532925199);
        }

        public static function rotatePointByRadians(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            var loc1:*=arg1.x - arg2.x;
            var loc4:*=arg1.y - arg2.y;
            var loc2:*=Math.sqrt(loc1 * loc1 + loc4 * loc4);
            var loc3:*=arg3 + Math.atan2(loc1, -loc4);
            return new flash.geom.Point(Math.sin(loc3) * loc2 + arg2.x, (-Math.cos(loc3)) * loc2 + arg2.y);
        }

        public static function angleOf3Points(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc1:*=Math.sqrt((arg1 - arg3) * (arg1 - arg3) + (arg2 - arg4) * (arg2 - arg4));
            var loc2:*=Math.sqrt((arg3 - arg5) * (arg3 - arg5) + (arg4 - arg6) * (arg4 - arg6));
            var loc3:*=Math.sqrt((arg5 - arg1) * (arg5 - arg1) + (arg6 - arg2) * (arg6 - arg2));
            return Math.acos((loc1 * loc1 + loc3 * loc3 - loc2 * loc2) / (2 * loc1 * loc3));
        }

        public static const TO_RADIANS:Number=0.0174532925199;

        public static const TO_DEGREEES:Number=57.2957795131;
    }
}


//  package touch
//    package events
//      class TransitionMultitouchEvent
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


//      class TwoFingerEvent
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


//    class TransitionMultitouch
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


//    class TwoFingerTouch
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


//  package utils
//    class PathSimplify
package sk.yoz.utils 
{
    import __AS3__.vec.*;
    
    public class PathSimplify extends Object
    {
        public function PathSimplify()
        {
            super();
            return;
        }

        public static function getSquareSegmentDistance(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc2:*=NaN;
            var loc4:*=arg3;
            var loc5:*=arg4;
            var loc1:*=arg5 - loc4;
            var loc3:*=arg6 - loc5;
            if (!(loc1 === 0) || !(loc3 === 0)) 
            {
                if ((loc2 = ((arg1 - loc4) * loc1 + (arg2 - loc5) * loc3) / (loc1 * loc1 + loc3 * loc3)) > 1) 
                {
                    loc4 = arg5;
                    loc5 = arg6;
                }
                else if (loc2 > 0) 
                {
                    loc4 = loc4 + loc1 * loc2;
                    loc5 = loc5 + loc3 * loc2;
                }
            }
            loc1 = arg1 - loc4;
            loc3 = arg2 - loc5;
            return loc1 * loc1 + loc3 * loc3;
        }

        public static function simplifyRadialDistance(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc4:*=NaN;
            var loc1:*=NaN;
            var loc8:*=0;
            var loc9:*=0;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc5:*=NaN;
            var loc7:*=arg1[0];
            var loc10:*=arg1[1];
            var loc6:*=__AS3__.vec.Vector.<Number>([loc7, loc10]);
            loc8 = 2;
            loc9 = 3;
            loc2 = arg1.length;
            while (loc8 < loc2) 
            {
                loc1 = arg1[loc8];
                loc4 = arg1[loc9];
                loc3 = loc1 - loc7;
                loc5 = loc4 - loc10;
                if (loc3 * loc3 + loc5 * loc5 > arg2) 
                {
                    loc6.push(loc1, loc4);
                    loc7 = loc1;
                    loc10 = loc4;
                }
                loc8 = loc8 + 2;
                loc9 = loc9 + 2;
            }
            if (!(loc7 == loc1) || !(loc10 == loc4)) 
            {
                loc6.push(loc1, loc4);
            }
            return loc6;
        }

        public static function simplifyDouglasPeucker(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc3:*=0;
            var loc7:*=NaN;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc6:*=arg1.length;
            var loc10:*=new __AS3__.vec.Vector.<Boolean>(loc6);
            var loc11:*=0;
            var loc1:*=loc6 - 2;
            var loc9:*=new __AS3__.vec.Vector.<uint>();
            var loc2:*=new __AS3__.vec.Vector.<uint>();
            var loc8:*=new __AS3__.vec.Vector.<Number>();
            var loc12:*;
            loc10[loc1] = loc12 = true;
            loc10[loc11] = loc12;
            for (;;) 
            {
                loc7 = 0;
                loc3 = loc11 + 2;
                while (loc3 < loc1) 
                {
                    if ((loc5 = getSquareSegmentDistance(arg1[loc3], arg1[loc3 + 1], arg1[loc11], arg1[loc11 + 1], arg1[loc1], arg1[loc1 + 1])) > loc7) 
                    {
                        loc4 = loc3;
                        loc7 = loc5;
                    }
                    loc3 = loc3 + 2;
                }
                if (loc7 > arg2) 
                {
                    loc10[loc4] = true;
                    loc9.push(loc11, loc4);
                    loc2.push(loc4, loc1);
                }
                if (!loc2.length) 
                {
                    break;
                }
                loc11 = loc9.pop();
                loc1 = loc2.pop();
            }
            loc3 = 0;
            while (loc3 < loc6) 
            {
                if (loc10[loc3]) 
                {
                    loc8.push(arg1[loc3], arg1[loc3 + 1]);
                }
                loc3 = loc3 + 2;
            }
            return loc8;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:Boolean=false):__AS3__.vec.Vector.<Number>
        {
            var loc1:*=arg2 * arg2;
            if (!arg3) 
            {
                arg1 = simplifyRadialDistance(arg1, loc1);
            }
            return simplifyDouglasPeucker(arg1, loc1);
        }
    }
}


//  package ycanvas
//    package interfaces
//      class ILayer
package sk.yoz.ycanvas.interfaces 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    
    public dynamic interface ILayer
    {
        function set center(arg1:flash.geom.Point):void;

        function set scale(arg1:Number):void;

        function get level():uint;

        function get partitions():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;

        function get partitionWidth():uint;

        function get partitionHeight():uint;

        function addPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;

        function getPartition(arg1:int, arg2:int):sk.yoz.ycanvas.interfaces.IPartition;

        function removePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;

        function toString():String;
    }
}


//      class ILayerFactory
package sk.yoz.ycanvas.interfaces 
{
    import flash.geom.*;
    
    public dynamic interface ILayerFactory
    {
        function create(arg1:Number, arg2:flash.geom.Point):sk.yoz.ycanvas.interfaces.ILayer;

        function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;
    }
}


//      class IPartition
package sk.yoz.ycanvas.interfaces 
{
    import flash.display.*;
    import flash.geom.*;
    
    public dynamic interface IPartition
    {
        function get x():int;

        function get y():int;

        function get expectedWidth():uint;

        function get expectedHeight():uint;

        function get concatenatedMatrix():flash.geom.Matrix;

        function applyIBitmapDrawable(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void;

        function toString():String;
    }
}


//      class IPartitionFactory
package sk.yoz.ycanvas.interfaces 
{
    public dynamic interface IPartitionFactory
    {
        function create(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer):sk.yoz.ycanvas.interfaces.IPartition;

        function disposePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;
    }
}


//      class IYCanvasRoot
package sk.yoz.ycanvas.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IYCanvasRoot
    {
        function set x(arg1:Number):void;

        function set y(arg1:Number):void;

        function set rotation(arg1:Number):void;

        function set yCanvasScale(arg1:Number):void;

        function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>;

        function addLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;

        function removeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;

        function dispose():void;
    }
}


//    package map
//      package display
//        class AbstractGraphics
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.map.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class AbstractGraphics extends starling.display.DisplayObject
    {
        public function AbstractGraphics()
        {
            new __AS3__.vec.Vector.<Number>(4)[0] = 1;
            new __AS3__.vec.Vector.<Number>(4)[1] = 1;
            new __AS3__.vec.Vector.<Number>(4)[2] = 1;
            new __AS3__.vec.Vector.<Number>(4)[3] = 1;
            renderAlpha = new __AS3__.vec.Vector.<Number>(4);
            var loc1:*="context3DCreate";
            starling.core.Starling.current.addEventListener(loc1, onContextCreated);
            registerPrograms();
            super();
            return;
        }

        protected function get programName():String
        {
            throw new Error("Method not implemented");
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc3:*=getTransformationMatrix(arg1);
            var loc2:*=starling.utils.MatrixUtil.transformCoords(loc3, bounds.x, bounds.y);
            var loc1:*=starling.utils.MatrixUtil.transformCoords(loc3, bounds.x + bounds.width, bounds.y + bounds.height);
            arg2.setTo(loc2.x, loc2.y, loc1.x - loc2.x, loc1.y - loc2.y);
            return arg2;
        }

        public override function dispose():void
        {
            var loc1:*="context3DCreate";
            starling.core.Starling.current.removeEventListener(loc1, onContextCreated);
            if (vertexBuffer) 
            {
                vertexBuffer.dispose();
            }
            if (indexBuffer) 
            {
                indexBuffer.dispose();
            }
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.batchMesh(new starling.display.Mesh(vertexData, sk.yoz.ycanvas.map.utils.StrokeUtils.indexDataVectorToIndexDataObj(indexData)));
            return;
        }

        protected function updateVertexBuffer():void
        {
            if (vertexBuffer) 
            {
                vertexBuffer.dispose();
            }
            vertexBuffer = starling.core.Starling.context.createVertexBuffer(vertexData.numVertices, vertexData.vertexSizeIn32Bits);
            vertexBuffer.uploadFromByteArray(vertexData.rawData, 0, 0, vertexData.numVertices);
            return;
        }

        protected function updateIndexBuffer():void
        {
            if (indexBuffer) 
            {
                indexBuffer.dispose();
            }
            indexBuffer = starling.core.Starling.context.createIndexBuffer(indexData.length);
            indexBuffer.uploadFromVector(indexData, 0, indexData.length);
            return;
        }

        protected function hitTestIndices(arg1:flash.geom.Point, arg2:uint, arg3:uint):Boolean
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc4:*=0;
            var loc1:*=starling.utils.Pool.getPoint();
            var loc2:*=starling.utils.Pool.getPoint();
            var loc3:*=starling.utils.Pool.getPoint();
            loc4 = arg2;
            while (loc4 <= arg3) 
            {
                loc6 = (loc5 = loc4 + 1) + 1;
                vertexData.getPoint(indexData[loc4], "position", loc1);
                vertexData.getPoint(indexData[loc5], "position", loc2);
                vertexData.getPoint(indexData[loc6], "position", loc3);
                if (sk.yoz.math.FastCollisions.pointInTriangle(arg1.x, arg1.y, loc1.x, loc1.y, loc2.x, loc2.y, loc3.x, loc3.y)) 
                {
                    return true;
                }
                loc4 = loc4 + 3;
            }
            starling.utils.Pool.putPoint(loc1);
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putPoint(loc3);
            return false;
        }

        internal function registerPrograms():void
        {
            if (starling.core.Starling.painter.hasProgram(programName)) 
            {
                return;
            }
            var loc1:*=starling.rendering.Program.fromSource("m44 op, va0, vc0\nmul v0, va1, vc4", "mov oc, v0");
            starling.core.Starling.painter.registerProgram(programName, loc1);
            return;
        }

        protected function onContextCreated(arg1:starling.events.Event):void
        {
            registerPrograms();
            return;
        }

        protected var indexData:__AS3__.vec.Vector.<uint>;

        protected var vertexData:starling.rendering.VertexData;

        internal var indexBuffer:flash.display3D.IndexBuffer3D;

        internal var renderAlpha:__AS3__.vec.Vector.<Number>;

        internal var vertexBuffer:flash.display3D.VertexBuffer3D;
    }
}


//        class MapDisplay
package sk.yoz.ycanvas.map.display 
{
    import flash.geom.*;
    import starling.display.*;
    
    public class MapDisplay extends starling.display.Sprite
    {
        public function MapDisplay()
        {
            super();
            return;
        }

        public override function get height():Number
        {
            return _height;
        }

        public override function set height(arg1:Number):void
        {
            _height = arg1;
            validateClipRect();
            invalidateStarlingViewPort();
            return;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function set width(arg1:Number):void
        {
            _width = arg1;
            validateClipRect();
            invalidateStarlingViewPort();
            return;
        }

        public override function set x(arg1:Number):void
        {
            super(
#error('findrop') x
            ).x = arg1;
            invalidateStarlingViewPort();
            return;
        }

        public override function set y(arg1:Number):void
        {
            super(
#error('findrop') y
            ).y = arg1;
            invalidateStarlingViewPort();
            return;
        }

        internal function get starlingViewPort():flash.geom.Rectangle
        {
            var loc1:*=null;
            if (!_starlingViewPort) 
            {
                loc1 = localToGlobal(new flash.geom.Point(0, 0));
                _starlingViewPort = new flash.geom.Rectangle(loc1.x, loc1.y, width, height);
            }
            return _starlingViewPort;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable) 
            {
                return null;
            }
            var loc2:*=arg1.x;
            var loc1:*=arg1.y;
            var loc3:*;
            if (loc3 = super.hitTest(arg1)) 
            {
                return loc3;
            }
            var loc4:*=localToGlobal(new flash.geom.Point(loc2, loc1));
            return starlingViewPort.contains(loc4.x, loc4.y) ? this : null;
        }

        internal function validateClipRect():void
        {
            mask = new starling.display.Quad(width, height);
            var loc1:*;
            mask.y = loc1 = 0;
            mask.x = loc1;
            return;
        }

        public function invalidateStarlingViewPort():void
        {
            _starlingViewPort = null;
            dispatchEventWith("viewPortUpdated");
            return;
        }

        public static const VIEWPORT_UPDATED:String="viewPortUpdated";

        internal var _height:Number=200;

        internal var _width:Number=200;

        internal var _starlingViewPort:flash.geom.Rectangle;
    }
}


//        class MapLayer
package sk.yoz.ycanvas.map.display 
{
    import flash.geom.*;
    import starling.display.*;
    
    public class MapLayer extends starling.display.Sprite
    {
        public function MapLayer()
        {
            _center = new flash.geom.Point();
            super();
            return;
        }

        public override function set width(arg1:Number):void
        {
            if (width == arg1) 
            {
                return;
            }
            _width = arg1;
            updatePosition();
            return;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function set height(arg1:Number):void
        {
            if (height == arg1) 
            {
                return;
            }
            _height = arg1;
            updatePosition();
            return;
        }

        public override function get height():Number
        {
            return _height;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            if (center == arg1) 
            {
                return;
            }
            _center = arg1;
            updatePosition();
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set mapScale(arg1:Number):void
        {
            if (mapScale == arg1) 
            {
                return;
            }
            _mapScale = scaleX = scaleY = arg1;
            updatePosition();
            return;
        }

        public function get mapScale():Number
        {
            return _mapScale;
        }

        public override function set rotation(arg1:Number):void
        {
            if (rotation == arg1) 
            {
                return;
            }
            super(
#error('findrop') rotation
            ).rotation = arg1;
            updatePosition();
            return;
        }

        internal function updatePosition():void
        {
            var loc2:*=(-center.x) * mapScale;
            var loc3:*=(-center.y) * mapScale;
            var loc4:*=Math.sin(rotation);
            var loc1:*=Math.cos(rotation);
            this.x = loc1 * loc2 - loc4 * loc3 + width / 2;
            this.y = loc1 * loc3 + loc4 * loc2 + height / 2;
            return;
        }

        internal var _width:Number;

        internal var _height:Number;

        internal var _center:flash.geom.Point;

        internal var _mapScale:Number;
    }
}


//        class MapStroke
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import sk.yoz.utils.*;
    
    public class MapStroke extends sk.yoz.ycanvas.map.display.Stroke
    {
        public function MapStroke(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:uint=16777215, arg4:Number=1)
        {
            _basePoints = arg1.concat();
            _originalThickness = arg2;
            super(null, arg2, arg3, arg4, false);
            return;
        }

        public function get basePoints():__AS3__.vec.Vector.<Number>
        {
            return _basePoints;
        }

        public function get layerScale():Number
        {
            return _layerScale;
        }

        public function set layerScale(arg1:Number):void
        {
            if (layerScale == arg1) 
            {
                return;
            }
            _layerScale = arg1;
            thickness = originalThickness / layerScale;
            invalidatePoints();
            return;
        }

        public function get originalThickness():Number
        {
            return _originalThickness;
        }

        internal function invalidatePoints():void
        {
            if (!simplifyTolerance) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            points = null;
            this.autoUpdate = loc1;
            return;
        }

        internal function validatePoints():void
        {
            if (points) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            var loc2:*=simplifyTolerance / layerScale;
            points = simplifyTolerance ? sk.yoz.utils.PathSimplify.simplify(basePoints, loc2, false) : basePoints.concat();
            this.autoUpdate = loc1;
            return;
        }

        public override function update():void
        {
            validatePoints();
            super.update();
            return;
        }

        internal var _basePoints:__AS3__.vec.Vector.<Number>;

        internal var _layerScale:Number;

        internal var _originalThickness:Number;

        public var simplifyTolerance:Number=4;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;
    }
}


//        class MarkerLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import starling.display.*;
    
    public class MarkerLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function MarkerLayer()
        {
            list = new __AS3__.vec.Vector.<starling.display.DisplayObject>();
            super();
            return;
        }

        public override function set rotation(arg1:Number):void
        {
            var loc1:*=0;
            if (rotation == arg1) 
            {
                return;
            }
            super(
#error('findrop') rotation
            ).rotation = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                list[loc1].rotation = -rotation;
            }
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            var loc1:*=0;
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                var loc2:*;
                list[loc1].scaleY = loc2 = 1 / mapScale;
                list[loc1].scaleX = loc2;
            }
            return;
        }

        public function add(arg1:starling.display.DisplayObject):void
        {
            var loc1:*;
            arg1.scaleY = loc1 = 1 / mapScale;
            arg1.scaleX = loc1;
            arg1.rotation = -rotation;
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:starling.display.DisplayObject):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


//        class Stroke
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.utils.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.core.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    
    public class Stroke extends sk.yoz.ycanvas.map.display.AbstractGraphics
    {
        public function Stroke(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:uint=16777215, arg4:Number=1, arg5:Boolean=true)
        {
            _points = arg1;
            _thickness = arg2;
            _color = arg3;
            this.autoUpdate = arg5;
            super();
            this.alpha = arg4;
            if (arg5) 
            {
                update();
            }
            return;
        }

        public override function get bounds():flash.geom.Rectangle
        {
            return _bounds;
        }

        public function get color():uint
        {
            return _color;
        }

        public function set color(arg1:uint):void
        {
            if (color == arg1) 
            {
                return;
            }
            _color = arg1;
            colorChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        public function get points():__AS3__.vec.Vector.<Number>
        {
            return _points;
        }

        public function set points(arg1:__AS3__.vec.Vector.<Number>):void
        {
            if (points == arg1) 
            {
                return;
            }
            _points = arg1;
            pointsChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        public function get thickness():Number
        {
            return _thickness;
        }

        public function set thickness(arg1:Number):void
        {
            if (thickness == arg1) 
            {
                return;
            }
            _thickness = arg1;
            thicknessChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        protected override function get programName():String
        {
            return "YCanvasStroke";
        }

        public function update():void
        {
            if (!pointsChanged && !thicknessChanged && !colorChanged) 
            {
                return;
            }
            var loc2:*=starling.core.Starling.context;
            if (loc2 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            var loc1:*=false;
            var loc3:*=false;
            if (pointsChanged || thicknessChanged) 
            {
                vertexData = sk.yoz.ycanvas.map.utils.StrokeUtils.pointsToVertexData(points, thickness, color);
                loc1 = true;
                indexData = sk.yoz.ycanvas.map.utils.StrokeUtils.vertexDataToIndexData(vertexData);
                loc3 = true;
                updateBounds();
            }
            pointsChanged = false;
            thicknessChanged = false;
            colorChanged = false;
            if (loc1) 
            {
                updateVertexBuffer();
            }
            if (loc3) 
            {
                updateIndexBuffer();
            }
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc3:*=null;
            if (!visible || !touchable) 
            {
                return null;
            }
            if (!bounds.containsPoint(arg1)) 
            {
                return null;
            }
            return null;
            loc2 = 0;
            loc1 = partialBounds.length;
            while (loc2 < loc1) 
            {
                if ((loc3 = partialBounds[loc2]).rectangle.containsPoint(arg1)) 
                {
                    if (hitTestIndices(arg1, loc3.indiceIndexMin, loc3.indiceIndexMax)) 
                    {
                        return this;
                    }
                }
                ++loc2;
            }
            return null;
        }

        protected function updateBounds():void
        {
            partialBounds = sk.yoz.ycanvas.map.utils.VertexDataUtils.getPartialBoundsList(vertexData, verticesPerPartialBounds);
            _bounds = sk.yoz.ycanvas.map.utils.PartialBoundsUtils.mergeListToRectangle(partialBounds);
            return;
        }

        protected override function onContextCreated(arg1:starling.events.Event):void
        {
            pointsChanged = true;
            colorChanged = true;
            thicknessChanged = true;
            super.onContextCreated(arg1);
            update();
            return;
        }

        internal static const PROGRAM_NAME:String="YCanvasStroke";

        public var autoUpdate:Boolean=true;

        internal var _bounds:flash.geom.Rectangle;

        internal var _color:Number;

        internal var _points:__AS3__.vec.Vector.<Number>;

        public var pointsChanged:Boolean=true;

        internal var _thickness:Number;

        protected var verticesPerPartialBounds:uint=256;

        internal var colorChanged:Boolean=true;

        internal var partialBounds:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>;

        internal var thicknessChanged:Boolean=true;
    }
}


//        class StrokeLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    
    public class StrokeLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function StrokeLayer()
        {
            list = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>();
            super();
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            if (autoUpdateThickness) 
            {
                updateThickness();
            }
            return;
        }

        public function updateThickness():void
        {
            var loc2:*=0;
            var loc1:*=null;
            loc2 = list.length;
            while (loc2--) 
            {
                loc1 = list[loc2];
                loc1.layerScale = mapScale;
                if (loc1.autoUpdate) 
                {
                    continue;
                }
                loc1.update();
            }
            return;
        }

        public function add(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            arg1.layerScale = mapScale;
            if (!arg1.autoUpdate) 
            {
                arg1.update();
            }
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>;

        public var autoUpdateThickness:Boolean=true;
    }
}


//      package events
//        class CanvasEvent
package sk.yoz.ycanvas.map.events 
{
    import flash.events.*;
    
    public class CanvasEvent extends flash.events.Event
    {
        public function CanvasEvent(arg1:String)
        {
            super(arg1, false, true);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new sk.yoz.ycanvas.map.events.CanvasEvent(type);
        }

        public static const TRANSFORMATION_STARTED:String="canvasTransformationStarted";

        public static const TRANSFORMATION_FINISHED:String="canvasTransformationFinished";

        public static const CENTER_CHANGED:String="canvasCenterChanged";

        public static const SCALE_CHANGED:String="canvasScaleChanged";

        public static const ROTATION_CHANGED:String="canvasRotationChanged";

        public static const RENDERED:String="canvasRendered";
    }
}


//        class PartitionEvent
package sk.yoz.ycanvas.map.events 
{
    import flash.events.*;
    import sk.yoz.ycanvas.map.partitions.*;
    
    public class PartitionEvent extends flash.events.Event
    {
        public function PartitionEvent(arg1:String, arg2:sk.yoz.ycanvas.map.partitions.Partition)
        {
            super(arg1, false, true);
            _partition = arg2;
            return;
        }

        public function get partition():sk.yoz.ycanvas.map.partitions.Partition
        {
            return _partition;
        }

        public override function clone():flash.events.Event
        {
            return new sk.yoz.ycanvas.map.events.PartitionEvent(type, partition);
        }

        public static const LOADED:String="partitionLoaded";

        internal var _partition:sk.yoz.ycanvas.map.partitions.Partition;
    }
}


//      package layers
//        class Layer
package sk.yoz.ycanvas.map.layers 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    
    public class Layer extends Object implements sk.yoz.ycanvas.starling.interfaces.ILayerStarling
    {
        public function Layer(arg1:uint, arg2:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg3:sk.yoz.ycanvas.interfaces.IPartitionFactory)
        {
            _center = new flash.geom.Point();
            _partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            _content = new starling.display.Sprite();
            super();
            _level = arg1;
            this.config = arg2;
            this.partitionFactory = arg3;
            content.touchable = false;
            return;
        }

        public function get content():starling.display.DisplayObjectContainer
        {
            return _content;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            var loc2:*=0;
            _center = arg1;
            var loc1:*=partitions.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                positionPartition(partitions[loc2]);
                ++loc2;
            }
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set scale(arg1:Number):void
        {
            var loc1:*;
            content.scaleY = loc1 = arg1;
            content.scaleX = loc1;
            return;
        }

        public function get level():uint
        {
            return _level;
        }

        public function get partitions():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            return _partitions;
        }

        public function get partitionWidth():uint
        {
            return config.tileWidth;
        }

        public function get partitionHeight():uint
        {
            return config.tileHeight;
        }

        public function addPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            if (partitions.indexOf(arg1) != -1) 
            {
                return;
            }
            partitions.push(arg1);
            positionPartition(arg1);
            content.addChild((arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling).content);
            return;
        }

        public function getPartition(arg1:int, arg2:int):sk.yoz.ycanvas.interfaces.IPartition
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=partitions.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = partitions[loc3];
                if (loc1.x == arg1 && loc1.y == arg2) 
                {
                    return loc1;
                }
                ++loc3;
            }
            return null;
        }

        public function removePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling;
            if (loc2.content) 
            {
                content.removeChild(loc2.content);
            }
            var loc1:*=partitions.indexOf(arg1);
            if (loc1 != -1) 
            {
                partitions.splice(loc1, 1);
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            if (!partitions.length) 
            {
                return;
            }
            var loc4:*=partitions.concat();
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3];
                removePartition(loc1);
                partitionFactory.disposePartition(loc1);
                ++loc3;
            }
            return;
        }

        internal function positionPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            var loc1:*=arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling;
            loc1.content.x = (arg1.x - center.x) / level;
            loc1.content.y = (arg1.y - center.y) / level;
            return;
        }

        public function toString():String
        {
            return "Layer: [level:" + level + "]";
        }

        public var config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var partitionFactory:sk.yoz.ycanvas.interfaces.IPartitionFactory;

        internal var _level:uint;

        internal var _center:flash.geom.Point;

        internal var _partitions:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;

        internal var _content:starling.display.Sprite;
    }
}


//        class LayerFactory
package sk.yoz.ycanvas.map.layers 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class LayerFactory extends Object implements sk.yoz.ycanvas.interfaces.ILayerFactory
    {
        public function LayerFactory(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg2:sk.yoz.ycanvas.interfaces.IPartitionFactory)
        {
            var loc1:*=0;
            layers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.layers.Layer>();
            super();
            loc1 = 1;
            while (loc1 <= 32768) 
            {
                layers.push(new sk.yoz.ycanvas.map.layers.Layer(loc1, arg1, arg2));
                loc1 = loc1 * 2;
            }
            return;
        }

        public function create(arg1:Number, arg2:flash.geom.Point):sk.yoz.ycanvas.interfaces.ILayer
        {
            return getLayerByScale(arg1);
        }

        public function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            sk.yoz.ycanvas.map.layers.Layer(arg1).dispose();
            return;
        }

        internal function getLayerByScale(arg1:Number):sk.yoz.ycanvas.map.layers.Layer
        {
            return layers[getLayerIndex(arg1)];
        }

        protected function getLayerIndex(arg1:Number):uint
        {
            var loc2:*=0;
            var loc3:*=1 / arg1 * CUSTOM_TILE_SCALE;
            var loc1:*=layers.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (loc3 < 1 << loc2) 
                {
                    break;
                }
                ++loc2;
            }
            return Math.min((loc1 - 1), loc2);
        }

        internal var layers:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.layers.Layer>;

        public static var CUSTOM_SCALE_STEPS:Number=1.5;

        public static var CUSTOM_TILE_SCALE:Number=1;
    }
}


//      package managers
//        class AbstractTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import com.greensock.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.display.*;
    
    public class AbstractTransformationManager extends Object
    {
        public function AbstractTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.5)
        {
            transformation = new sk.yoz.ycanvas.map.valueObjects.Transformation();
            transformationTarget = new sk.yoz.ycanvas.map.valueObjects.Transformation();
            super();
            this.controller = arg1;
            this.limit = arg2;
            this.transitionDuration = arg3;
            allowMove = true;
            allowZoom = true;
            allowRotate = true;
            updateTransformation();
            arg1.addEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            return;
        }

        internal function onTweenComplete():void
        {
            disposeTween();
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationFinished"));
            return;
        }

        public function get allowMove():Boolean
        {
            return _allowMove;
        }

        public function set allowMove(arg1:Boolean):void
        {
            if (allowMove == arg1) 
            {
                return;
            }
            _allowMove = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY));
            return;
        }

        public function get allowRotate():Boolean
        {
            return _allowRotate;
        }

        public function set allowRotate(arg1:Boolean):void
        {
            if (allowRotate == arg1) 
            {
                return;
            }
            _allowRotate = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveRotateToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveRotateTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY), transformation.rotation);
            return;
        }

        public function get allowZoom():Boolean
        {
            return _allowZoom;
        }

        public function set allowZoom(arg1:Boolean):void
        {
            if (allowZoom == arg1) 
            {
                return;
            }
            _allowZoom = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveRotateScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveRotateTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY), transformation.rotation);
            controller.scale = transformation.scale;
            return;
        }

        protected function get allowInteractions():Boolean
        {
            return _allowInteractions;
        }

        protected function set allowInteractions(arg1:Boolean):void
        {
            if (allowInteractions == arg1) 
            {
                return;
            }
            _allowInteractions = arg1;
            return;
        }

        internal function onRotateToTweenUpdate(arg1:flash.geom.Point):Function
        {
            var lock:flash.geom.Point;

            lock = arg1;
            return function ():void
            {
                sk.yoz.ycanvas.utils.TransformationUtils.rotateTo(controller, transformation.rotation, lock);
                var loc1:*;
                transformation.centerX = loc1 = controller.center.x;
                transformationTarget.centerX = loc1;
                transformation.centerY = loc1 = controller.center.y;
                transformationTarget.centerY = loc1;
                return;
            }
        }

        internal function onRotateScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.rotateScaleTo(controller, transformation.rotation, transformation.scale);
            return;
        }

        internal function onScaleToTweenUpdate(arg1:flash.geom.Point):Function
        {
            var lock:flash.geom.Point;

            lock = arg1;
            return function ():void
            {
                sk.yoz.ycanvas.utils.TransformationUtils.scaleTo(controller, transformation.scale, lock);
                var loc1:*;
                transformation.centerX = loc1 = controller.center.x;
                transformationTarget.centerX = loc1;
                transformation.centerY = loc1 = controller.center.y;
                transformationTarget.centerY = loc1;
                return;
            }
        }

        internal function onMoveScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.scaleTo(controller, transformation.scale, new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY));
            controller.center = new flash.geom.Point(transformation.centerX, transformation.centerY);
            return;
        }

        protected function get transforming():Boolean
        {
            return _transforming;
        }

        protected function set transforming(arg1:Boolean):void
        {
            if (transforming == arg1) 
            {
                return;
            }
            _transforming = arg1;
            return;
        }

        internal function onCanvasTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            transforming = false;
            updateTransformation();
            return;
        }

        protected static function normalizeRadians(arg1:Number):Number
        {
            arg1 = arg1 % 6.28318530718;
            if (arg1 > 3.14159265359) 
            {
                arg1 = arg1 - 6.28318530718;
            }
            else if (arg1 < -3.14159265359) 
            {
                arg1 = arg1 + 6.28318530718;
            }
            return arg1;
        }

        internal function validateInteractions():void
        {
            allowInteractions = allowMove || allowZoom || allowRotate;
            return;
        }

        public function dispose():void
        {
            stop();
            disposeTween();
            allowMove = false;
            allowZoom = false;
            allowRotate = false;
            allowInteractions = false;
            controller.removeEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            controller = null;
            return;
        }

        protected function limitScale(arg1:Number):Number
        {
            if (arg1 > limit.minScale) 
            {
                return limit.minScale;
            }
            if (arg1 < limit.maxScale) 
            {
                return limit.maxScale;
            }
            return arg1;
        }

        protected function limitCenterX(arg1:Number):Number
        {
            if (arg1 < limit.minCenterX) 
            {
                return limit.minCenterX;
            }
            if (arg1 > limit.maxCenterX) 
            {
                return limit.maxCenterX;
            }
            return arg1;
        }

        protected function limitCenterY(arg1:Number):Number
        {
            if (arg1 < limit.minCenterY) 
            {
                return limit.minCenterY;
            }
            if (arg1 > limit.maxCenterY) 
            {
                return limit.maxCenterY;
            }
            return arg1;
        }

        protected function stop():void
        {
            return;
        }

        public function rotateByTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            rotateToTween(transformationTarget.rotation + arg1);
            return;
        }

        internal function updateTransformation():void
        {
            var loc1:*;
            transformation.centerX = loc1 = controller.center.x;
            transformationTarget.centerX = loc1;
            transformation.centerY = loc1 = controller.center.y;
            transformationTarget.centerY = loc1;
            transformation.scale = loc1 = controller.scale;
            transformationTarget.scale = loc1;
            transformation.rotation = loc1 = controller.rotation;
            transformationTarget.rotation = loc1;
            return;
        }

        public function moveByTween(arg1:Number, arg2:Number):void
        {
            moveToTween(transformationTarget.centerX + arg1, transformationTarget.centerY + arg2);
            return;
        }

        public function moveToTween(arg1:Number, arg2:Number):void
        {
            doTween(arg1, arg2, NaN, NaN, onMoveToTweenUpdate);
            return;
        }

        public function moveRotateToTween(arg1:Number, arg2:Number, arg3:Number):void
        {
            var loc1:*=normalizeRadians(arg3 - transformationTarget.rotation);
            arg3 = transformationTarget.rotation + loc1;
            doTween(arg1, arg2, NaN, arg3, onMoveRotateToTweenUpdate);
            return;
        }

        public function moveRotateScaleToTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc1:*=normalizeRadians(arg3 - transformationTarget.rotation);
            arg3 = transformationTarget.rotation + loc1;
            doTween(arg1, arg2, arg4, arg3, onMoveRotateScaleToTweenUpdate);
            return;
        }

        public function rotateToTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            var loc1:*=normalizeRadians(arg1 - transformationTarget.rotation);
            arg1 = transformationTarget.rotation + loc1;
            doTween(NaN, NaN, NaN, arg1, onRotateToTweenUpdate(arg2));
            return;
        }

        public function rotateScaleToTween(arg1:Number, arg2:Number):void
        {
            var loc1:*=normalizeRadians(arg1 - transformationTarget.rotation);
            arg1 = transformationTarget.rotation + loc1;
            doTween(NaN, NaN, arg2, arg1, onRotateScaleToTweenUpdate);
            return;
        }

        public function scaleByTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            scaleToTween(transformationTarget.scale * arg1, arg2);
            return;
        }

        public function scaleToTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            doTween(NaN, NaN, arg1, NaN, onScaleToTweenUpdate(arg2));
            return;
        }

        public function showBoundsTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc2:*=(arg1 + arg2) / 2;
            var loc1:*=(arg3 + arg4) / 2;
            var loc11:*=controller.canvasToViewPort(new flash.geom.Point(arg1, arg3));
            var loc12:*=controller.canvasToViewPort(new flash.geom.Point(arg2, arg4));
            var loc5:*=Math.min(loc11.x, loc12.x);
            var loc9:*=Math.max(loc11.x, loc12.x);
            var loc3:*=Math.min(loc11.y, loc12.y);
            var loc10:*=Math.max(loc11.y, loc12.y);
            var loc6:*=Math.abs(controller.viewPort.width) / Math.abs(loc9 - loc5);
            var loc7:*=Math.abs(controller.viewPort.height) / Math.abs(loc10 - loc3);
            var loc8:*=Math.min(loc6, loc7);
            var loc4:*=controller.scale * loc8;
            doTween(loc2, loc1, loc4, controller.rotation, onMoveScaleToTweenUpdate);
            return;
        }

        public function showDisplayObjectTween(arg1:starling.display.DisplayObject):void
        {
            showBoundsTween(arg1.bounds.left - arg1.pivotX, arg1.bounds.right - arg1.pivotX, arg1.bounds.top - arg1.pivotY, arg1.bounds.bottom - arg1.pivotY);
            return;
        }

        internal function doTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Function):void
        {
            var loc1:*={"onUpdate":arg5, "onComplete":onTweenComplete};
            if (isNaN(arg1)) 
            {
                var loc2:*;
                transformation.centerX = loc2 = controller.center.x;
                transformationTarget.centerX = loc2;
            }
            else 
            {
                loc1.centerX = loc2 = limitCenterX(arg1);
                transformationTarget.centerX = loc2;
            }
            if (isNaN(arg2)) 
            {
                transformation.centerY = loc2 = controller.center.y;
                transformationTarget.centerY = loc2;
            }
            else 
            {
                loc1.centerY = loc2 = limitCenterY(arg2);
                transformationTarget.centerY = loc2;
            }
            if (isNaN(arg3)) 
            {
                transformation.scale = loc2 = controller.scale;
                transformationTarget.scale = loc2;
            }
            else 
            {
                loc1.scale = loc2 = limitScale(arg3);
                transformationTarget.scale = loc2;
            }
            if (isNaN(arg4)) 
            {
                transformation.rotation = loc2 = controller.rotation;
                transformationTarget.rotation = loc2;
            }
            else 
            {
                loc1.rotation = loc2 = arg4;
                transformationTarget.rotation = loc2;
            }
            disposeTween();
            tween = com.greensock.TweenNano.to(transformation, transitionDuration, loc1);
            transforming = true;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationStarted"));
            return;
        }

        internal function disposeTween():void
        {
            if (!tween) 
            {
                return;
            }
            tween.kill();
            tween = null;
            return;
        }

        public static const PI2:Number=6.28318530718;

        internal var _allowMove:Boolean;

        internal var _allowRotate:Boolean;

        internal var _allowZoom:Boolean;

        internal var _allowInteractions:Boolean;

        protected var controller:sk.yoz.ycanvas.map.YCanvasMap;

        protected var transformation:sk.yoz.ycanvas.map.valueObjects.Transformation;

        protected var transformationTarget:sk.yoz.ycanvas.map.valueObjects.Transformation;

        internal var _transforming:Boolean;

        protected var transitionDuration:Number=0.25;

        internal var limit:sk.yoz.ycanvas.map.valueObjects.Limit;

        public static var yStartCorrection:Number=0;

        internal var tween:com.greensock.TweenNano;
    }
}


//        class MouseTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.core.*;
    
    public class MouseTransformationManager extends sk.yoz.ycanvas.map.managers.AbstractTransformationManager
    {
        public function MouseTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.5)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function set allowMove(arg1:Boolean):void
        {
            if (allowMove == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowMove
            ).allowMove = arg1;
            if (allowMove) 
            {
                stage.addEventListener("mouseDown", onStageMouseDown);
            }
            else 
            {
                stage.removeEventListener("mouseDown", onStageMouseDown);
            }
            return;
        }

        public override function set allowZoom(arg1:Boolean):void
        {
            if (allowZoom == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowZoom
            ).allowZoom = arg1;
            if (allowZoom) 
            {
                stage.addEventListener("mouseWheel", onStageMouseWheel);
            }
            else 
            {
                stage.removeEventListener("mouseWheel", onStageMouseWheel);
            }
            return;
        }

        protected override function set allowInteractions(arg1:Boolean):void
        {
            if (allowInteractions == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowInteractions
            ).allowInteractions = arg1;
            if (allowInteractions) 
            {
                stage.addEventListener("mouseLeave", onStageMouseLeave);
            }
            else 
            {
                stage.removeEventListener("mouseLeave", onStageMouseLeave);
            }
            return;
        }

        internal function get globalPointInTweenTarget():flash.geom.Point
        {
            var loc1:*=new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY);
            var loc4:*=new flash.geom.Point(stage.mouseX, stage.mouseY);
            var loc3:*=controller.globalToViewPort(loc4);
            var loc2:*=controller.getConversionMatrix(loc1, transformationTarget.scale, transformationTarget.rotation, controller.viewPort);
            loc2.invert();
            return loc2.transformPoint(loc3);
        }

        internal function get globalPointOnCanvas():flash.geom.Point
        {
            return controller.globalToCanvas(new flash.geom.Point(stage.mouseX, stage.mouseY - yStartCorrection));
        }

        internal function get stage():flash.display.Stage
        {
            return starling.core.Starling.current.nativeStage;
        }

        public override function dispose():void
        {
            stage.removeEventListener("mouseWheel", onStageMouseWheel);
            super.dispose();
            return;
        }

        internal function hitTest(arg1:Number, arg2:Number):Boolean
        {
            return controller.hitTestComponent(arg1, arg2);
        }

        protected override function stop():void
        {
            super.stop();
            stage.removeEventListener("mouseUp", onStageMouseUp);
            stage.removeEventListener("mouseMove", onStageMouseMove);
            return;
        }

        internal function onStageMouseDown(arg1:flash.events.MouseEvent):void
        {
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            last = globalPointInTweenTarget;
            stage.addEventListener("mouseUp", onStageMouseUp);
            stage.addEventListener("mouseMove", onStageMouseMove);
            return;
        }

        internal function onStageMouseMove(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=globalPointInTweenTarget;
            moveByTween(last.x - loc1.x, last.y - loc1.y);
            last = globalPointInTweenTarget;
            return;
        }

        internal function onStageMouseUp(arg1:flash.events.MouseEvent):void
        {
            stop();
            return;
        }

        internal function onStageMouseWheel(arg1:flash.events.MouseEvent):void
        {
            var loc2:*=NaN;
            loc2 = 1.25;
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            var loc1:*=arg1.delta < 0 ? 1 / 1.25 : 1.25;
            var loc3:*;
            (loc3 = globalPointOnCanvas).x = limitCenterX(loc3.x);
            loc3.y = limitCenterY(loc3.y);
            scaleByTween(loc1, loc3);
            return;
        }

        internal function onStageMouseLeave(arg1:flash.events.Event):void
        {
            stop();
            return;
        }

        internal var last:flash.geom.Point;
    }
}


//        class TouchTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import sk.yoz.touch.*;
    import sk.yoz.touch.events.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.core.*;
    
    public class TouchTransformationManager extends sk.yoz.ycanvas.map.managers.AbstractTransformationManager
    {
        public function TouchTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.25)
        {
            multitouch = new sk.yoz.touch.TransitionMultitouch();
            flash.ui.Multitouch.inputMode = "touchPoint";
            super(arg1, arg2, arg3);
            multitouch.attach(stage);
            multitouch.transitionDuration = arg3;
            multitouch.addEventListener("transitionMultitouchTransitionComplete", onMultitouchTransitionComplete);
            stage.addEventListener("twoFingerScaleAndRotate", onStageScaleAndRotate);
            stage.addEventListener("touchBegin", onStageTouchBegin);
            stage.addEventListener("touchEnd", onStageTouchEnd);
            stage.addEventListener("touchRollOut", onStageTouchRollOut);
            stage.addEventListener("touchTap", onStageTap);
            return;
        }

        internal function get stage():flash.display.Stage
        {
            return starling.core.Starling.current.nativeStage;
        }

        internal function onStageTap(arg1:flash.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            if (!allowInteractions) 
            {
                return;
            }
            if (multitouch.isTweening || multitouch.countFingers > 1) 
            {
                return;
            }
            ++_tapCount;
            if (_tapCount >= 2) 
            {
                resetTapCount();
                killTween();
                resetTransformationTarget();
                resetTransformation();
                dispatchTransformationStarted();
                loc1 = getGlobalPointInTweenTarget(new flash.geom.Point(arg1.stageX, arg1.stageY - yStartCorrection));
                transformationTarget.centerX = limitCenterX(loc1.x);
                transformationTarget.centerY = limitCenterY(loc1.y);
                transformationTarget.scale = limitScale(controller.scale + 0.125);
                com.greensock.TweenNano.to(transformation, transitionDuration, {"scale":transformationTarget.scale, "centerX":transformationTarget.centerX, "centerY":transformationTarget.centerY, "onUpdate":onScaleTransformationUpdate});
                flash.utils.setTimeout(onZoomFinish, transitionDuration);
                return;
            }
            _tapCountTimeoutId = flash.utils.setTimeout(resetTapCount, 300);
            return;
        }

        internal function onScaleTransformationUpdate():void
        {
            controller.center = new flash.geom.Point(transformation.centerX, transformation.centerY);
            controller.scale = transformation.scale;
            return;
        }

        internal function onZoomFinish():void
        {
            dispatchTransformationFinished();
            resetTransformationTarget();
            resetTransformation();
            resetTapCount();
            return;
        }

        internal function resetTapCount():void
        {
            flash.utils.clearTimeout(_tapCountTimeoutId);
            _tapCount = 0;
            return;
        }

        public override function dispose():void
        {
            multitouch.detach(stage);
            multitouch.removeEventListener("transitionMultitouchTransitionComplete", onMultitouchTransitionComplete);
            multitouch = null;
            stage.removeEventListener("twoFingerScaleAndRotate", onStageScaleAndRotate);
            stage.removeEventListener("touchBegin", onStageTouchBegin);
            stage.removeEventListener("touchEnd", onStageTouchEnd);
            stage.removeEventListener("touchRollOut", onStageTouchRollOut);
            stage.removeEventListener("touchMove", onStageTouchMove, false);
            stage.removeEventListener("touchTap", onStageTap);
            resetTapCount();
            super.dispose();
            return;
        }

        internal function getGlobalPointInTweenTarget(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=controller.globalToViewPort(arg1);
            var loc1:*=controller.getConversionMatrix(new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY), controller.scale, controller.rotation, controller.viewPort);
            loc1.invert();
            return loc1.transformPoint(loc2);
        }

        internal function killTween():void
        {
            com.greensock.TweenNano.killTweensOf(transformation);
            return;
        }

        internal function resetTransformation():void
        {
            transformation.centerX = controller.center.x;
            transformation.centerY = controller.center.y;
            transformation.scale = controller.scale;
            transformation.rotation = controller.rotation;
            return;
        }

        internal function resetTransformationTarget():void
        {
            transformationTarget.centerX = controller.center.x;
            transformationTarget.centerY = controller.center.y;
            transformationTarget.scale = controller.scale;
            transformationTarget.rotation = controller.rotation;
            return;
        }

        internal function dispatchTransformationStarted():void
        {
            if (transforming) 
            {
                return;
            }
            transforming = true;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationStarted"));
            return;
        }

        internal function dispatchTransformationFinished():void
        {
            if (multitouch.isTweening || multitouch.countFingers) 
            {
                return;
            }
            if (!transforming) 
            {
                return;
            }
            transforming = false;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationFinished"));
            return;
        }

        internal function hitTest(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=false;
            try 
            {
                loc1 = controller.hitTestComponent(arg1, arg2);
            }
            catch (e:Error)
            {
                trace("hitTestComponent - error: " + e.message);
            }
            return loc1;
        }

        internal function onStageScaleAndRotate(arg1:sk.yoz.touch.events.TwoFingerEvent):void
        {
            if (!hitTest(arg1.source.stageX, arg1.source.stageY)) 
            {
                return;
            }
            if (arg1.scale == 1 && arg1.rotation == 0) 
            {
                return;
            }
            if (!(multitouch.countFingers == 2) || !allowInteractions || !allowZoom) 
            {
                return;
            }
            dispatchTransformationStarted();
            var loc2:*=controller.globalToCanvas(new flash.geom.Point(arg1.lock.x, arg1.lock.y - yStartCorrection));
            var loc1:*=controller.rotation;
            sk.yoz.ycanvas.utils.TransformationUtils.rotateScaleTo(controller, controller.rotation + normalizeRadians(arg1.rotation), limitScale(controller.scale * arg1.scale), loc2);
            if (!allowRotate) 
            {
                controller.rotation = loc1;
            }
            resetTransformation();
            resetTransformationTarget();
            return;
        }

        internal function onMultitouchTransitionComplete(arg1:sk.yoz.touch.events.TransitionMultitouchEvent):void
        {
            dispatchTransformationFinished();
            return;
        }

        internal function onStageTouchBegin(arg1:flash.events.TouchEvent):void
        {
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            if (!allowInteractions) 
            {
                return;
            }
            killTween();
            resetTransformationTarget();
            previousPosition = getGlobalPointInTweenTarget(multitouch.getPoint(arg1));
            stage.addEventListener("touchMove", onStageTouchMove, false, 1);
            return;
        }

        internal function onStageTouchMove(arg1:flash.events.TouchEvent):void
        {
            dispatchTransformationStarted();
            killTween();
            var loc2:*=multitouch.getPoint(arg1);
            var loc1:*=getGlobalPointInTweenTarget(loc2);
            if (!previousPosition || multitouch.isTweening || !(multitouch.countFingers == 1)) 
            {
                previousPosition = loc1;
                return;
            }
            transformationTarget.centerX = transformationTarget.centerX + (previousPosition.x - loc1.x);
            transformationTarget.centerY = transformationTarget.centerY + (previousPosition.y - loc1.y);
            resetTransformation();
            com.greensock.TweenNano.to(transformation, transitionDuration, {"centerX":transformationTarget.centerX, "centerY":transformationTarget.centerY, "onUpdate":onTransformationUpdate});
            previousPosition = getGlobalPointInTweenTarget(loc2);
            return;
        }

        internal function onStageTouchEnd(arg1:flash.events.TouchEvent):void
        {
            stage.removeEventListener("touchMove", onStageTouchMove, false);
            resetTransformationTarget();
            previousPosition = null;
            dispatchTransformationFinished();
            return;
        }

        internal function onStageTouchRollOut(arg1:flash.events.TouchEvent):void
        {
            onStageTouchEnd(arg1);
            return;
        }

        internal function onTransformationUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY));
            return;
        }

        internal var _tapCount:int=0;

        internal var _tapCountTimeoutId:uint=0;

        internal var multitouch:sk.yoz.touch.TransitionMultitouch;

        internal var previousPosition:flash.geom.Point;
    }
}


//      package partitions
//        class IPartitionLoader
package sk.yoz.ycanvas.map.partitions 
{
    import flash.display.*;
    import flash.net.*;
    import flash.system.*;
    
    public dynamic interface IPartitionLoader
    {
        function load(arg1:flash.net.URLRequest, arg2:flash.system.LoaderContext):flash.display.Loader;

        function disposeLoader(arg1:flash.display.Loader):void;
    }
}


//        class Partition
package sk.yoz.ycanvas.map.partitions 
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class Partition extends Object implements sk.yoz.ycanvas.starling.interfaces.IPartitionStarling
    {
        public function Partition(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer, arg4:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg5:flash.events.IEventDispatcher, arg6:sk.yoz.ycanvas.map.partitions.IPartitionLoader)
        {
            _x = arg1;
            _y = arg2;
            _layer = arg3;
            _config = arg4;
            this.dispatcher = arg5;
            this.partitionLoader = arg6;
            validateEmptyTexture();
            _content = new starling.display.Image(EMPTY_TEXTURE);
            content.touchable = false;
            content.x = arg1;
            content.y = arg2;
            content.alpha = 0;
            super();
            return;
        }

        public function get concatenatedMatrix():flash.geom.Matrix
        {
            return content.getTransformationMatrix(content.stage);
        }

        internal function disposeTween():void
        {
            if (!tween) 
            {
                return;
            }
            tween.kill();
            tween = null;
            return;
        }

        public function get config():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            return _config;
        }

        public function set config(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig):void
        {
            if (config == arg1) 
            {
                return;
            }
            _config = arg1;
            load();
            return;
        }

        internal function validateEmptyTexture():void
        {
            if (EMPTY_TEXTURE) 
            {
                return;
            }
            var loc1:*=new flash.display.BitmapData(expectedWidth, expectedHeight, true, 16777215);
            EMPTY_TEXTURE = starling.textures.Texture.fromBitmapData(loc1);
            return;
        }

        public function get content():starling.display.DisplayObject
        {
            return _content;
        }

        public function get expectedHeight():uint
        {
            return config.tileHeight;
        }

        public function get expectedWidth():uint
        {
            return config.tileWidth;
        }

        public function toString():String
        {
            return "Partition: [x:" + x + ", y:" + y + "]";
        }

        public function get layer():sk.yoz.ycanvas.interfaces.ILayer
        {
            return _layer;
        }

        public function get loaded():Boolean
        {
            return bitmapData || error;
        }

        public function get loading():Boolean
        {
            return !(loader == null);
        }

        internal function onLoaderComplete(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.target);
            if (loc1.content is flash.display.Bitmap) 
            {
                bitmapData = flash.display.Bitmap(loc1.content).bitmapData;
            }
            else if (loc1.content is flash.display.MovieClip) 
            {
                bitmapData = new flash.display.BitmapData((loader.content as flash.display.MovieClip).width, (loader.content as flash.display.MovieClip).height);
                bitmapData.draw(loader.content as flash.display.MovieClip);
            }
            stopLoading();
            tween = com.greensock.TweenNano.to(content, 0.5, {"alpha":1, "onComplete":onRevealComplete});
            var loc2:*="partitionLoaded";
            dispatcher.dispatchEvent(new sk.yoz.ycanvas.map.events.PartitionEvent(loc2, this));
            return;
        }

        public function get x():int
        {
            return _x;
        }

        internal function onLoaderError(arg1:flash.events.Event):void
        {
            error = true;
            bitmapData = null;
            stopLoading();
            return;
        }

        public function get y():int
        {
            return _y;
        }

        protected function get url():String
        {
            var loc1:*=config.urlTemplates;
            var loc2:*=x / 5 + y / 3 + layer.level;
            var loc3:*=loc1[(loc2 < 0 ? -loc2 : loc2) % loc1.length];
            loc3 = loc3.replace("${x}", x / expectedWidth / layer.level);
            loc3 = loc3.replace("${y}", y / expectedHeight / layer.level);
            loc3 = loc3.replace("${z}", 18 - getLevel(layer.level));
            return loc3;
        }

        internal function onRevealComplete():void
        {
            disposeTween();
            return;
        }

        internal function get bitmapData():flash.display.BitmapData
        {
            return _bitmapData;
        }

        internal function set bitmapData(arg1:flash.display.BitmapData):void
        {
            var loc1:*=null;
            if (bitmapData == arg1) 
            {
                return;
            }
            disposeBitmapData();
            disposeTexture();
            _bitmapData = arg1;
            try 
            {
                loc1 = bitmapData ? starling.textures.Texture.fromBitmapData(bitmapData, false) : EMPTY_TEXTURE;
                _content.texture = loc1;
            }
            catch (error:Error)
            {
            };
            return;
        }

        public function getLevel(arg1:uint):uint
        {
            var loc1:*=0;
            while (arg1 > 1) 
            {
                arg1 = arg1 / 2;
                ++loc1;
            }
            return loc1;
        }

        public function load():void
        {
            stopLoading();
            error = false;
            var loc2:*=new flash.system.LoaderContext(true);
            loc2.imageDecodingPolicy = "onLoad";
            var loc1:*=new flash.net.URLRequest(url);
            if (partitionLoader) 
            {
                loader = partitionLoader.load(loc1, loc2);
            }
            else 
            {
                loader = new flash.display.Loader();
                loader.load(loc1, loc2);
            }
            var loc3:*=loader.contentLoaderInfo;
            loc3.addEventListener("complete", onLoaderComplete, false, -1, true);
            loc3.addEventListener("ioError", onLoaderError, false, -1, true);
            return;
        }

        public function stopLoading():void
        {
            if (!loading) 
            {
                return;
            }
            var loc1:*=loader.contentLoaderInfo;
            if (loc1) 
            {
                loc1.removeEventListener("complete", onLoaderComplete, false);
                loc1.removeEventListener("ioError", onLoaderError, false);
            }
            if (partitionLoader) 
            {
                partitionLoader.disposeLoader(loader);
            }
            loader = null;
            return;
        }

        public function applyIBitmapDrawable(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void
        {
            return;
        }

        public function dispose():void
        {
            stopLoading();
            disposeTween();
            disposeBitmapData();
            disposeTexture();
            content.dispose();
            return;
        }

        internal function disposeBitmapData():void
        {
            if (!bitmapData) 
            {
                return;
            }
            _bitmapData = null;
            return;
        }

        internal function disposeTexture():void
        {
            if (!content || !_content.texture || _content.texture == EMPTY_TEXTURE) 
            {
                return;
            }
            _content.texture.dispose();
            return;
        }

        internal var _config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var _content:starling.display.Image;

        internal var _layer:sk.yoz.ycanvas.interfaces.ILayer;

        internal var _x:int;

        internal var _y:int;

        internal var _bitmapData:flash.display.BitmapData;

        internal var partitionLoader:sk.yoz.ycanvas.map.partitions.IPartitionLoader;

        internal var tween:com.greensock.TweenNano;

        internal var dispatcher:flash.events.IEventDispatcher;

        internal var error:Boolean;

        internal var loader:flash.display.Loader;

        internal static var EMPTY_TEXTURE:starling.textures.Texture;
    }
}


//        class PartitionFactory
package sk.yoz.ycanvas.map.partitions 
{
    import flash.events.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class PartitionFactory extends Object implements sk.yoz.ycanvas.interfaces.IPartitionFactory
    {
        public function PartitionFactory(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg2:flash.events.IEventDispatcher, arg3:sk.yoz.ycanvas.map.partitions.IPartitionLoader=null)
        {
            super();
            this.config = arg1;
            this.dispatcher = arg2;
            this.loader = arg3;
            return;
        }

        public function create(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer):sk.yoz.ycanvas.interfaces.IPartition
        {
            return new sk.yoz.ycanvas.map.partitions.Partition(arg1, arg2, arg3, config, dispatcher, loader);
        }

        public function disposePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            sk.yoz.ycanvas.map.partitions.Partition(arg1).dispose();
            return;
        }

        public var config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        protected var dispatcher:flash.events.IEventDispatcher;

        protected var loader:sk.yoz.ycanvas.map.partitions.IPartitionLoader;
    }
}


//      package utils
//        class PartialBoundsUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class PartialBoundsUtils extends Object
    {
        public function PartialBoundsUtils()
        {
            super();
            return;
        }

        public static function mergeListToRectangle(arg1:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>):flash.geom.Rectangle
        {
            var loc7:*=0;
            var loc6:*=0;
            var loc1:*=arg1[0];
            var loc8:*;
            var loc3:*=(loc8 = loc1.rectangle).x;
            var loc2:*=loc8.y;
            var loc5:*=loc8.x + loc8.width;
            var loc4:*=loc8.y + loc8.height;
            loc7 = 1;
            loc6 = arg1.length;
            while (loc7 < loc6) 
            {
                loc1 = arg1[loc7];
                if ((loc8 = loc1.rectangle).x < loc3) 
                {
                    loc3 = loc8.x;
                }
                if (loc8.y < loc2) 
                {
                    loc2 = loc8.y;
                }
                if (loc8.x + loc8.width > loc5) 
                {
                    loc5 = loc8.x + loc8.width;
                }
                if (loc8.y + loc8.height > loc4) 
                {
                    loc4 = loc8.y + loc8.height;
                }
                ++loc7;
            }
            return new flash.geom.Rectangle(loc3, loc2, loc5 - loc3, loc4 - loc2);
        }
    }
}


//        class StrokeUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import starling.rendering.*;
    
    public class StrokeUtils extends Object
    {
        public function StrokeUtils()
        {
            super();
            return;
        }

        public static function pointsToVertexData(arg1:__AS3__.vec.Vector.<Number>, arg2:Number, arg3:uint=16711680):starling.rendering.VertexData
        {
            var loc6:*=0;
            var loc11:*=0;
            var loc5:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc3:*=pointsToVertices(arg1, arg2);
            var loc1:*="position:float2, color:bytes4";
            var loc2:*=starling.rendering.VertexDataFormat.fromString(loc1);
            var loc9:*=new starling.rendering.VertexData(loc2);
            var loc4:*=loc3.length;
            var loc10:*="";
            loc6 = 0;
            loc11 = 0;
            while (loc6 < loc4) 
            {
                loc5 = loc6 + 1;
                loc7 = loc6 + 2;
                loc8 = loc6 + 3;
                loc9.setPoint(loc11, "position", loc3[loc6], loc3[loc5]);
                loc9.setColor(loc11, "color", arg3);
                loc9.setPoint(loc11 + 1, "position", loc3[loc7], loc3[loc8]);
                loc9.setColor(loc11 + 1, "color", arg3);
                loc10 = (loc10 = (loc10 = (loc10 = loc10 + (loc6 + ": " + loc3[loc6] + "\n")) + (loc5 + ": " + loc3[loc5] + "\n")) + (loc7 + ": " + loc3[loc7] + "\n")) + (loc8 + ": " + loc3[loc8] + "\n");
                loc6 = loc6 + 4;
                loc11 = loc11 + 2;
            }
            return loc9;
        }

        public static function vertexDataToIndexData(arg1:starling.rendering.VertexData):__AS3__.vec.Vector.<uint>
        {
            var loc3:*=0;
            var loc1:*=new __AS3__.vec.Vector.<uint>();
            var loc2:*=arg1.numVertices - 2;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1.push(loc3, loc3 + 1, loc3 + 2);
                ++loc3;
            }
            return loc1;
        }

        public static function indexDataVectorToIndexDataObj(arg1:__AS3__.vec.Vector.<uint>):starling.rendering.IndexData
        {
            var loc3:*=0;
            var loc1:*=new starling.rendering.IndexData();
            var loc2:*=arg1.length - 2;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1.addTriangle(arg1[loc3], arg1[loc3 + 1], arg1[loc3 + 2]);
                loc3 = loc3 + 3;
            }
            return loc1;
        }

        internal static function pointsToVertices(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc2:*=0;
            var loc13:*=false;
            var loc8:*=NaN;
            var loc1:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc20:*=NaN;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc12:*=NaN;
            var loc10:*=arg1[0];
            var loc9:*=arg1[1];
            var loc5:*=2;
            var loc3:*=3;
            var loc18:*=arg2 / 2;
            var loc4:*=new __AS3__.vec.Vector.<Number>();
            loc2 = arg1.length;
            while (loc5 < loc2) 
            {
                loc13 = false;
                loc8 = arg1[loc5];
                var loc11:*=arg1[loc3];
                loc1 = Math.atan2(loc11 - loc9, loc8 - loc10);
                loc6 = Math.sin(loc1) * loc18;
                loc7 = Math.cos(loc1) * loc18;
                loc20 = loc10 + loc6;
                var loc19:*=loc9 - loc7;
                loc14 = loc10 - loc6;
                var loc21:*=loc9 + loc7;
                if (loc20 == loc16 && loc19 == loc15 && loc14 == loc12 && loc21 == loc17) 
                {
                    loc13 = true;
                }
                loc16 = loc8 + loc6;
                loc15 = loc11 - loc7;
                loc12 = loc8 - loc6;
                loc17 = loc11 + loc7;
                if (loc13) 
                {
                    loc4.splice(loc4.length - 4, 4);
                    loc4.push(loc16, loc15, loc12, loc17);
                }
                else 
                {
                    loc4.push(loc20, loc19, loc14, loc21, loc16, loc15, loc12, loc17);
                }
                loc10 = loc8;
                loc9 = loc11;
                loc5 = loc5 + 2;
                loc3 = loc3 + 2;
            }
            return loc4;
        }
    }
}


//        class VertexDataUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.rendering.*;
    
    public class VertexDataUtils extends Object
    {
        public function VertexDataUtils()
        {
            super();
            return;
        }

        public static function getPartialBoundsList(arg1:starling.rendering.VertexData, arg2:uint):__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc5:*=0;
            var loc1:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>();
            var loc6:*=arg2 - 2;
            var loc7:*=(arg1.numVertices - 3) * 3;
            var loc4:*=arg1.numVertices;
            loc5 = 0;
            while (loc5 < loc4) 
            {
                loc3 = arg2;
                if (loc5 + loc3 > loc4) 
                {
                    loc3 = loc4 - loc5;
                }
                (loc2 = new sk.yoz.ycanvas.map.valueObjects.PartialBounds()).rectangle = arg1.getBounds("position", null, loc5, loc3);
                loc2.vertexIndexMin = loc5;
                loc2.vertexIndexMax = (loc5 + loc3 - 1);
                loc2.indiceIndexMin = loc2.vertexIndexMin < 2 ? 0 : (loc2.vertexIndexMin - 2) * 3;
                loc2.indiceIndexMax = loc2.vertexIndexMax * 3 > loc7 ? loc7 : loc2.vertexIndexMax * 3;
                loc1.push(loc2);
                loc5 = loc5 + loc6;
            }
            return loc1;
        }
    }
}


//      package valueObjects
//        class Limit
package sk.yoz.ycanvas.map.valueObjects 
{
    public class Limit extends Object
    {
        public function Limit()
        {
            super();
            return;
        }

        public var minScale:Number;

        public var maxScale:Number;

        public var minCenterX:Number;

        public var maxCenterX:Number;

        public var minCenterY:Number;

        public var maxCenterY:Number;
    }
}


//        class MapConfig
package sk.yoz.ycanvas.map.valueObjects 
{
    import __AS3__.vec.*;
    
    public class MapConfig extends Object
    {
        public function MapConfig()
        {
            super();
            return;
        }

        public var urlTemplates:__AS3__.vec.Vector.<String>;

        public var tileWidth:uint;

        public var tileHeight:uint;

        public var forTouch:Boolean=true;
    }
}


//        class PartialBounds
package sk.yoz.ycanvas.map.valueObjects 
{
    import flash.geom.*;
    
    public class PartialBounds extends Object
    {
        public function PartialBounds()
        {
            super();
            return;
        }

        public var rectangle:flash.geom.Rectangle;

        public var vertexIndexMin:uint;

        public var vertexIndexMax:uint;

        public var indiceIndexMin:uint;

        public var indiceIndexMax:uint;
    }
}


//        class Transformation
package sk.yoz.ycanvas.map.valueObjects 
{
    public class Transformation extends Object
    {
        public function Transformation()
        {
            super();
            return;
        }

        public var centerX:Number=0;

        public var centerY:Number=0;

        public var scale:Number=1;

        public var rotation:Number=0;
    }
}


//      class YCanvasMap
package sk.yoz.ycanvas.map 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import sk.yoz.ycanvas.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.partitions.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class YCanvasMap extends sk.yoz.ycanvas.AbstractYCanvas implements flash.events.IEventDispatcher
    {
        public function YCanvasMap(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg2:sk.yoz.ycanvas.map.valueObjects.Transformation, arg3:uint=0, arg4:uint=0)
        {
            dispatcher = new flash.events.EventDispatcher();
            mapLayers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapLayer>();
            timer = new flash.utils.Timer(250, 1);
            _config = arg1;
            this.marginOffset = arg3;
            this.maxLayers = arg4;
            _root = new sk.yoz.ycanvas.starling.YCanvasRootStarling();
            _display = new sk.yoz.ycanvas.map.display.MapDisplay();
            display.addChild(root as sk.yoz.ycanvas.starling.YCanvasRootStarling);
            display.addEventListener("viewPortUpdated", onComponentViewPortUpdated);
            super(getViewPort());
            partitionFactory = new sk.yoz.ycanvas.map.partitions.PartitionFactory(arg1, this);
            layerFactory = new sk.yoz.ycanvas.map.layers.LayerFactory(arg1, partitionFactory);
            center = new flash.geom.Point(arg2.centerX, arg2.centerY);
            scale = arg2.scale;
            rotation = arg2.rotation;
            addEventListener("canvasTransformationStarted", onCanvasTransformationStarted);
            addEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            addEventListener("partitionLoaded", onPartitionLoaded);
            timer.addEventListener("timerComplete", onTimerComplete);
            return;
        }

        public override function set center(arg1:flash.geom.Point):void
        {
            var loc1:*=0;
            super(
#error('findrop') center
            ).center = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].center = arg1;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasCenterChanged"));
            return;
        }

        internal function resetTimer():void
        {
            if (timer.running) 
            {
                return;
            }
            timer.reset();
            timer.start();
            return;
        }

        public function get config():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            return _config;
        }

        public function set config(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig):void
        {
            var loc2:*=0;
            var loc1:*=0;
            if (config == arg1) 
            {
                return;
            }
            _config = arg1;
            if (partitionFactory) 
            {
                (partitionFactory as sk.yoz.ycanvas.map.partitions.PartitionFactory).config = config;
            }
            while (layers.length > 1) 
            {
                disposeLayer(layers[0]);
            }
            (layers[0] as sk.yoz.ycanvas.map.layers.Layer).config = config;
            var loc3:*;
            (loc3 = layers[0].partitions).sort(sortByDistanceFromCenter);
            loc2 = 0;
            loc1 = loc3.length;
            while (loc2 < loc1) 
            {
                (loc3[loc2] as sk.yoz.ycanvas.map.partitions.Partition).config = config;
                ++loc2;
            }
            return;
        }

        internal function onCanvasTransformationStarted(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            resetTimer();
            return;
        }

        public function get display():sk.yoz.ycanvas.map.display.MapDisplay
        {
            return _display;
        }

        public function get mainLayer():sk.yoz.ycanvas.map.layers.Layer
        {
            return layers[(layers.length - 1)] as sk.yoz.ycanvas.map.layers.Layer;
        }

        public override function set rotation(arg1:Number):void
        {
            var loc1:*=0;
            super(
#error('findrop') rotation
            ).rotation = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].rotation = rotation;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasRotationChanged"));
            return;
        }

        public override function set scale(arg1:Number):void
        {
            var loc1:*=0;
            super(
#error('findrop') scale
            ).scale = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].mapScale = arg1;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasScaleChanged"));
            return;
        }

        public override function set viewPort(arg1:flash.geom.Rectangle):void
        {
            var loc1:*=0;
            super(
#error('findrop') viewPort
            ).viewPort = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].width = arg1.width;
                mapLayers[loc1].height = arg1.height;
            }
            resetTimer();
            return;
        }

        internal function onCanvasTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            render();
            return;
        }

        internal function onPartitionLoaded(arg1:sk.yoz.ycanvas.map.events.PartitionEvent):void
        {
            var loc1:*=arg1.partition;
            var loc3:*=loc1.layer;
            if (mainLayer != loc3) 
            {
                return;
            }
            var loc2:*=sk.yoz.ycanvas.utils.IPartitionUtils.getLower(this, loc3, loc1);
            sk.yoz.ycanvas.utils.IPartitionUtils.diposeLayerPartitionsList(this, loc2);
            sk.yoz.ycanvas.utils.ILayerUtils.disposeEmpty(this);
            if (maxLayers) 
            {
                sk.yoz.ycanvas.utils.ILayerUtils.disposeDeep(this, maxLayers);
            }
            return;
        }

        internal function onTimerComplete(arg1:flash.events.Event):void
        {
            render();
            return;
        }

        internal function onComponentViewPortUpdated():void
        {
            viewPort = getViewPort();
            render();
            return;
        }

        public override function render():void
        {
            var loc1:*=null;
            super.render();
            sk.yoz.ycanvas.utils.IPartitionUtils.disposeInvisible(this);
            sk.yoz.ycanvas.utils.ILayerUtils.disposeEmpty(this);
            if (layers.length) 
            {
                loc1 = mainLayer;
                var loc4:*=0;
                var loc3:*=layers;
                for each (var loc2:* in loc3) 
                {
                    loc2 != loc1 ? stopLoading(loc2) : startLoading(loc2);
                }
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasRendered"));
            return;
        }

        public function hitTestComponent(arg1:Number, arg2:Number):Boolean
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (config.forTouch) 
            {
                loc2 = starling.core.Starling.current.viewPort;
                loc3 = new flash.geom.Point(arg1 - loc2.x, arg2 - loc2.y);
                loc1 = display.stage.hitTest(loc3);
                return loc1 == display;
            }
            loc4 = new flash.geom.Point(arg1, arg2);
            return (loc5 = display.globalToLocal(loc4)).x >= display.x && loc5.x <= display.x + display.width && loc5.y >= display.y && loc5.y <= display.y + display.height;
        }

        public function addMapLayer(arg1:sk.yoz.ycanvas.map.display.MapLayer):void
        {
            arg1.width = viewPort.width;
            arg1.height = viewPort.height;
            arg1.center = center;
            arg1.mapScale = scale;
            arg1.rotation = rotation;
            mapLayers.push(arg1);
            display.addChild(arg1);
            return;
        }

        public function removeMapLayer(arg1:sk.yoz.ycanvas.map.display.MapLayer):void
        {
            mapLayers.splice(mapLayers.indexOf(arg1), 1);
            display.removeChild(arg1);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            while (mapLayers.length) 
            {
                loc1 = mapLayers[0];
                loc1.removeChildren();
                removeMapLayer(loc1);
            }
            timer.removeEventListener("timerComplete", onTimerComplete);
            timer.stop();
            timer = null;
            super.dispose();
            return;
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

        internal function startLoading(arg1:sk.yoz.ycanvas.map.layers.Layer):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*;
            (loc4 = arg1.partitions).sort(sortByDistanceFromCenter);
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3] as sk.yoz.ycanvas.map.partitions.Partition;
                if (!loc1.loading && !loc1.loaded) 
                {
                    loc1.load();
                }
                ++loc3;
            }
            return;
        }

        internal function stopLoading(arg1:sk.yoz.ycanvas.map.layers.Layer):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*=arg1.partitions;
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3] as sk.yoz.ycanvas.map.partitions.Partition;
                if (loc1.loading) 
                {
                    loc1.stopLoading();
                }
                ++loc3;
            }
            return;
        }

        internal function getViewPort():flash.geom.Rectangle
        {
            var loc1:*=display.localToGlobal(new flash.geom.Point(0, 0));
            return new flash.geom.Rectangle(starling.core.Starling.current.viewPort.x + loc1.x, starling.core.Starling.current.viewPort.y + loc1.y, display.width, display.height);
        }

        internal function sortByDistanceFromCenter(arg1:sk.yoz.ycanvas.map.partitions.Partition, arg2:sk.yoz.ycanvas.map.partitions.Partition):Number
        {
            var loc2:*=arg1.x + arg1.expectedWidth * 0.5 - center.x;
            var loc1:*=arg1.y + arg1.expectedHeight * 0.5 - center.y;
            var loc4:*=arg2.x + arg2.expectedWidth * 0.5 - center.x;
            var loc3:*=arg2.y + arg2.expectedHeight * 0.5 - center.y;
            return loc2 * loc2 + loc1 * loc1 - (loc4 * loc4 + loc3 * loc3);
        }

        internal var _config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var _display:sk.yoz.ycanvas.map.display.MapDisplay;

        protected var maxLayers:uint;

        internal var dispatcher:flash.events.EventDispatcher;

        internal var mapLayers:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapLayer>;

        internal var timer:flash.utils.Timer;
    }
}


//    package starling
//      package interfaces
//        class ILayerStarling
package sk.yoz.ycanvas.starling.interfaces 
{
    import sk.yoz.ycanvas.interfaces.*;
    import starling.display.*;
    
    public dynamic interface ILayerStarling extends sk.yoz.ycanvas.interfaces.ILayer
    {
        function get content():starling.display.DisplayObjectContainer;
    }
}


//        class IPartitionStarling
package sk.yoz.ycanvas.starling.interfaces 
{
    import sk.yoz.ycanvas.interfaces.*;
    import starling.display.*;
    
    public dynamic interface IPartitionStarling extends sk.yoz.ycanvas.interfaces.IPartition
    {
        function get content():starling.display.DisplayObject;
    }
}


//      class YCanvasRootStarling
package sk.yoz.ycanvas.starling 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    
    public class YCanvasRootStarling extends starling.display.Sprite implements sk.yoz.ycanvas.interfaces.IYCanvasRoot
    {
        public function YCanvasRootStarling()
        {
            _layers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>();
            super();
            return;
        }

        public function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>
        {
            return _layers;
        }

        public function set yCanvasScale(arg1:Number):void
        {
            scaleX = scaleY = arg1;
            return;
        }

        public function addLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.ILayerStarling;
            var loc1:*=layers.indexOf(arg1);
            if (loc1 != -1) 
            {
                if (loc1 != (layers.length - 1)) 
                {
                    setLayerChildIndex(loc2.content, (layers.length - 1));
                    layers.splice(loc1, 1);
                    layers.push(arg1);
                }
            }
            else 
            {
                addLayerChild(loc2.content);
                layers.push(arg1);
            }
            return;
        }

        public function removeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.ILayerStarling;
            removeLayerChild(loc2.content);
            var loc1:*=layers.indexOf(arg1);
            layers.splice(loc1, 1);
            return;
        }

        protected function addLayerChild(arg1:starling.display.DisplayObject):void
        {
            addChild(arg1);
            return;
        }

        protected function setLayerChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            setChildIndex(arg1, arg2);
            return;
        }

        protected function removeLayerChild(arg1:starling.display.DisplayObject):void
        {
            removeChild(arg1);
            return;
        }

        internal var _layers:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>;
    }
}


//    package utils
//      class DisplayObjectUtils
package sk.yoz.ycanvas.utils 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class DisplayObjectUtils extends Object
    {
        public function DisplayObjectUtils()
        {
            super();
            return;
        }

        public static function getConcatenatedMatrix(arg1:flash.display.DisplayObject):flash.geom.Matrix
        {
            var loc1:*=new flash.geom.Matrix();
            var loc2:*=arg1;
            while (loc2) 
            {
                loc1.concat(loc2.transform.matrix);
                loc2 = loc2.parent;
            }
            return loc1;
        }
    }
}


//      class ILayerUtils
package sk.yoz.ycanvas.utils 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.*;
    
    public class ILayerUtils extends Object
    {
        public function ILayerUtils()
        {
            super();
            return;
        }

        public static function disposeDeep(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:uint=1):void
        {
            var loc3:*=0;
            var loc1:*=arg1.layers.concat();
            var loc2:*=Math.max(loc1.length - arg2, 0);
            loc3 = 0;
            while (loc3 < loc2) 
            {
                arg1.disposeLayer(loc1[loc3]);
                ++loc3;
            }
            return;
        }

        public static function disposeEmpty(arg1:sk.yoz.ycanvas.AbstractYCanvas):void
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.layers.concat();
            loc3 = 0;
            loc2 = loc1.length;
            while (loc3 < loc2) 
            {
                if (!loc1[loc3].partitions.length) 
                {
                    arg1.disposeLayer(loc1[loc3]);
                }
                ++loc3;
            }
            return;
        }
    }
}


//      class IPartitionUtils
package sk.yoz.ycanvas.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.valueObjects.*;
    
    public class IPartitionUtils extends Object
    {
        public function IPartitionUtils()
        {
            super();
            return;
        }

        public static function getOverlaping(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 0);
        }

        public static function getLower(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 1);
        }

        public static function getUpper(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 2);
        }

        internal static function getOverlapingByMode(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition, arg4:uint):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            var loc8:*=0;
            var loc5:*=null;
            var loc1:*=null;
            var loc12:*=undefined;
            var loc6:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc10:*=arg1.layers;
            var loc11:*=arg4 == 1;
            var loc9:*=arg4 == 2;
            var loc7:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>();
            loc3 = 0;
            loc2 = loc10.length;
            while (loc3 < loc2) 
            {
                if (!((loc1 = loc10[loc3]) == arg2 || loc11 && loc1.level > arg2.level || loc9 && loc1.level < arg2.level)) 
                {
                    loc8 = (loc12 = loc1.partitions.concat()).length;
                    (loc6 = new sk.yoz.ycanvas.valueObjects.LayerPartitions()).layer = loc1;
                    loc6.partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
                    loc7.push(loc6);
                    loc4 = 0;
                    while (loc4 < loc8) 
                    {
                        loc5 = loc12[loc4];
                        if (isOverlaping(arg2, arg3, loc1, loc5)) 
                        {
                            loc6.partitions.push(loc5);
                        }
                        ++loc4;
                    }
                }
                ++loc3;
            }
            return loc7;
        }

        public static function disposeInvisible(arg1:sk.yoz.ycanvas.AbstractYCanvas):void
        {
            var loc1:*=undefined;
            var loc5:*=null;
            var loc4:*=0;
            var loc3:*=0;
            var loc2:*=arg1.layers;
            loc4 = 0;
            loc3 = loc2.length;
            while (loc4 < loc3) 
            {
                loc5 = loc2[loc4];
                loc1 = getInvisible(arg1, loc5);
                dispose(arg1, loc5, loc1);
                ++loc4;
            }
            return;
        }

        public static function dispose(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>):void
        {
            var loc2:*=0;
            var loc1:*=arg3.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg1.disposePartition(arg2, arg3[loc2]);
                ++loc2;
            }
            return;
        }

        public static function diposeLayerPartitionsList(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>):void
        {
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                dispose(arg1, arg2[loc2].layer, arg2[loc2].partitions);
                ++loc2;
            }
            return;
        }

        public static function getAt(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            var loc1:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc6:*=null;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc2:*=arg1.layers;
            var loc7:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>();
            loc4 = 0;
            loc3 = loc2.length;
            while (loc4 < loc3) 
            {
                loc9 = (loc8 = loc2[loc4]).partitions.length;
                (loc6 = new sk.yoz.ycanvas.valueObjects.LayerPartitions()).layer = loc2[loc4];
                loc6.partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
                loc7.push(loc6);
                loc5 = 0;
                while (loc5 < loc9) 
                {
                    loc1 = loc8.partitions[loc5];
                    if (isOverlapingPoint(arg2, loc8, loc1)) 
                    {
                        loc6.partitions.push(loc1);
                    }
                    ++loc5;
                }
                ++loc4;
            }
            return loc7;
        }

        internal static function isOverlaping(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.interfaces.IPartition, arg3:sk.yoz.ycanvas.interfaces.ILayer, arg4:sk.yoz.ycanvas.interfaces.IPartition):Boolean
        {
            var loc3:*=arg1;
            var loc2:*=arg2;
            var loc1:*=arg3;
            var loc4:*=arg4;
            if (arg1.level > arg3.level) 
            {
                loc3 = arg3;
                loc2 = arg4;
                loc1 = arg1;
                loc4 = arg2;
            }
            return loc2.x >= loc4.x && loc2.x < loc4.x + loc4.expectedWidth * loc1.level && loc2.y >= loc4.y && loc2.y < loc4.y + loc4.expectedHeight * loc1.level;
        }

        internal static function isOverlapingPoint(arg1:flash.geom.Point, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):Boolean
        {
            return arg1.x >= arg3.x && arg1.x < arg3.x + arg3.expectedWidth * arg2.level && arg1.y >= arg3.y && arg1.y < arg3.y + arg3.expectedHeight * arg2.level;
        }

        internal static function getInvisible(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            var loc3:*=null;
            var loc7:*=0;
            var loc4:*=arg2.partitionWidth * arg2.level;
            var loc5:*=arg2.partitionHeight * arg2.level;
            var loc1:*=arg2.partitions.concat();
            var loc2:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            var loc6:*=loc1.length;
            loc7 = 0;
            while (loc7 < loc6) 
            {
                loc3 = loc1[loc7];
                if (!arg1.isCollision(arg1.marginPoints, loc3.x, loc3.y, loc4, loc5)) 
                {
                    loc2.push(loc3);
                }
                ++loc7;
            }
            return loc2;
        }

        internal static const OVERLAP_ALL:uint=0;

        internal static const OVERLAP_LOWER:uint=1;

        internal static const OVERLAP_UPPER:uint=2;
    }
}


//      class TransformationUtils
package sk.yoz.ycanvas.utils 
{
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.*;
    
    public class TransformationUtils extends Object
    {
        public function TransformationUtils()
        {
            super();
            return;
        }

        public static function moveTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point):void
        {
            arg1.center = arg2;
            return;
        }

        public static function scaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=1 - arg1.scale / arg2;
            arg1.center = new flash.geom.Point(arg1.center.x + (arg3.x - arg1.center.x) * loc1, arg1.center.y + (arg3.y - arg1.center.y) * loc1);
            arg1.scale = arg2;
            return;
        }

        public static function rotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=arg1.rotation - arg2;
            arg1.center = sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg3, loc1);
            arg1.rotation = arg2;
            return;
        }

        public static function moveRotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point, arg3:Number):void
        {
            arg1.center = arg2;
            arg1.rotation = arg3;
            return;
        }

        public static function rotateScaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):void
        {
            if (!arg4) 
            {
                arg4 = arg1.center;
            }
            var loc3:*=arg1.rotation - arg2;
            var loc2:*=sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg4, loc3);
            var loc1:*=1 - arg1.scale / arg3;
            loc2.x = loc2.x + (arg4.x - loc2.x) * loc1;
            loc2.y = loc2.y + (arg4.y - loc2.y) * loc1;
            arg1.center = loc2;
            arg1.rotation = arg2;
            arg1.scale = arg3;
            return;
        }
    }
}


//    package valueObjects
//      class LayerPartitions
package sk.yoz.ycanvas.valueObjects 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.interfaces.*;
    
    public class LayerPartitions extends Object
    {
        public function LayerPartitions()
        {
            super();
            return;
        }

        public var layer:sk.yoz.ycanvas.interfaces.ILayer;

        public var partitions:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;
    }
}


//      class MarginPoints
package sk.yoz.ycanvas.valueObjects 
{
    import flash.geom.*;
    
    public class MarginPoints extends Object
    {
        public function MarginPoints()
        {
            super();
            return;
        }

        public function getMinX():Number
        {
            return Math.min(x1, x2, x3, x4);
        }

        public function getMaxX():Number
        {
            return Math.max(x1, x2, x3, x4);
        }

        public function getMinY():Number
        {
            return Math.min(y1, y2, y3, y4);
        }

        public function getMaxY():Number
        {
            return Math.max(y1, y2, y3, y4);
        }

        public static function fromPoints(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            var loc1:*;
            (loc1 = new MarginPoints()).x1 = arg1.x;
            loc1.y1 = arg1.y;
            loc1.x2 = arg2.x;
            loc1.y2 = arg2.y;
            loc1.x3 = arg3.x;
            loc1.y3 = arg3.y;
            loc1.x4 = arg4.x;
            loc1.y4 = arg4.y;
            return loc1;
        }

        public var x1:Number;

        public var y1:Number;

        public var x2:Number;

        public var y2:Number;

        public var x3:Number;

        public var y3:Number;

        public var x4:Number;

        public var y4:Number;
    }
}


//    class AbstractYCanvas
package sk.yoz.ycanvas 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.utils.*;
    import sk.yoz.ycanvas.valueObjects.*;
    
    public class AbstractYCanvas extends Object
    {
        public function AbstractYCanvas(arg1:flash.geom.Rectangle)
        {
            _center = new flash.geom.Point(0, 0);
            _viewPort = new flash.geom.Rectangle(0, 0, 640, 480);
            super();
            this.viewPort = arg1;
            return;
        }

        public function getVisiblePartitionsByMarginPoints(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.valueObjects.MarginPoints):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            var loc7:*=0;
            var loc9:*=0;
            var loc2:*=arg1.partitionWidth * arg1.level;
            var loc4:*=arg1.partitionHeight * arg1.level;
            var loc5:*=Math.floor(arg2.getMinX() / loc2) * loc2;
            var loc8:*=Math.floor(arg2.getMaxX() / loc2) * loc2;
            var loc3:*=Math.floor(arg2.getMinY() / loc4) * loc4;
            var loc6:*=Math.floor(arg2.getMaxY() / loc4) * loc4;
            var loc1:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            loc7 = loc5;
            while (loc7 <= loc8) 
            {
                loc9 = loc3;
                while (loc9 <= loc6) 
                {
                    if (isCollision(arg2, loc7, loc9, loc2, loc4)) 
                    {
                        loc1.push(arg1.getPartition(loc7, loc9) || partitionFactory.create(loc7, loc9, arg1));
                    }
                    loc9 = loc9 + loc4;
                }
                loc7 = loc7 + loc2;
            }
            return loc1;
        }

        public function getMarginPoints(arg1:flash.geom.Rectangle, arg2:uint=0):sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            var loc2:*=arg1.left - arg2;
            var loc4:*=arg1.right + arg2;
            var loc1:*=arg1.top - arg2;
            var loc3:*=arg1.bottom + arg2;
            return sk.yoz.ycanvas.valueObjects.MarginPoints.fromPoints(globalToCanvas(new flash.geom.Point(loc2, loc1)), globalToCanvas(new flash.geom.Point(loc4, loc1)), globalToCanvas(new flash.geom.Point(loc4, loc3)), globalToCanvas(new flash.geom.Point(loc2, loc3)));
        }

        public function applyDisplayObject(arg1:flash.display.DisplayObject):void
        {
            applyIBitmapDrawableWithMatrix(arg1, sk.yoz.ycanvas.utils.DisplayObjectUtils.getConcatenatedMatrix(arg1));
            return;
        }

        public function applyIBitmapDrawableWithMatrix(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc8:*=0;
            var loc7:*=layers;
            for each (var loc4:* in loc7) 
            {
                var loc6:*=0;
                var loc5:*=loc4.partitions;
                for each (var loc2:* in loc5) 
                {
                    loc1 = loc2.concatenatedMatrix;
                    loc1.invert();
                    (loc3 = arg2.clone()).translate(-viewPort.x, -viewPort.y);
                    loc3.concat(loc1);
                    loc2.applyIBitmapDrawable(arg1, loc3);
                }
            }
            return;
        }

        public function set showStats(arg1:Boolean):void
        {
            throw new Error("This method must be overriden.");
        }

        protected function centerRoot():void
        {
            root.x = viewPort.width / 2;
            root.y = viewPort.height / 2;
            return;
        }

        protected function centerLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            arg1.center = center;
            return;
        }

        protected function scaleLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            arg1.scale = arg1.level;
            return;
        }

        protected function addPartitions(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>):void
        {
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg1.addPartition(arg2[loc2]);
                ++loc2;
            }
            return;
        }

        protected function invalidateTransformationCache():void
        {
            cachedConversionMatrix = null;
            cachedMarginPoints = null;
            return;
        }

        public function set viewPort(arg1:flash.geom.Rectangle):void
        {
            _viewPort = arg1;
            invalidateTransformationCache();
            centerRoot();
            return;
        }

        public function get viewPort():flash.geom.Rectangle
        {
            return _viewPort;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            var loc2:*=0;
            var loc1:*=0;
            _center = arg1;
            loc2 = 0;
            loc1 = layers.length;
            while (loc2 < loc1) 
            {
                centerLayer(layers[loc2]);
                ++loc2;
            }
            invalidateTransformationCache();
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set rotation(arg1:Number):void
        {
            var loc1:*;
            root.rotation = loc1 = arg1;
            _rotation = loc1;
            invalidateTransformationCache();
            return;
        }

        public function get rotation():Number
        {
            return _rotation;
        }

        public function set scale(arg1:Number):void
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc3:*;
            root.yCanvasScale = loc3 = arg1;
            _scale = loc3;
            loc2 = 0;
            loc1 = layers.length;
            while (loc2 < loc1) 
            {
                scaleLayer(layers[loc2]);
                ++loc2;
            }
            invalidateTransformationCache();
            return;
        }

        public function get scale():Number
        {
            return _scale;
        }

        public function get root():sk.yoz.ycanvas.interfaces.IYCanvasRoot
        {
            return _root;
        }

        public function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>
        {
            return root.layers;
        }

        public function get conversionMatrix():flash.geom.Matrix
        {
            if (cachedConversionMatrix) 
            {
                return cachedConversionMatrix;
            }
            cachedConversionMatrix = getConversionMatrix(center, scale, rotation, viewPort);
            return cachedConversionMatrix;
        }

        public function get bitmapData():flash.display.BitmapData
        {
            throw new Error("This method must be overriden.");
        }

        public function isCollision(arg1:sk.yoz.ycanvas.valueObjects.MarginPoints, arg2:Number, arg3:Number, arg4:Number, arg5:Number):Boolean
        {
            return sk.yoz.math.FastCollisions.rectangles(arg1.x1, arg1.y1, arg1.x2, arg1.y2, arg1.x3, arg1.y3, arg1.x4, arg1.y4, arg2, arg3, arg2 + arg4, arg3, arg2 + arg4, arg3 + arg5, arg2, arg3 + arg5);
        }

        public function get marginPoints():sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            if (cachedMarginPoints) 
            {
                return cachedMarginPoints;
            }
            cachedMarginPoints = getMarginPoints(viewPort, marginOffset);
            return cachedMarginPoints;
        }

        public function globalToCanvas(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=globalToViewPort(arg1);
            var loc1:*=conversionMatrix.clone();
            loc1.invert();
            return loc1.transformPoint(loc2);
        }

        public function globalToViewPort(arg1:flash.geom.Point):flash.geom.Point
        {
            return new flash.geom.Point(arg1.x - viewPort.x, arg1.y - viewPort.y);
        }

        public function canvasToGlobal(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=conversionMatrix.clone();
            var loc1:*=loc2.transformPoint(arg1);
            return viewPortToGlobal(loc1);
        }

        public function canvasToViewPort(arg1:flash.geom.Point):flash.geom.Point
        {
            return globalToViewPort(canvasToGlobal(arg1));
        }

        public function viewPortToCanvas(arg1:flash.geom.Point):flash.geom.Point
        {
            return globalToCanvas(viewPortToGlobal(arg1));
        }

        public function viewPortToGlobal(arg1:flash.geom.Point):flash.geom.Point
        {
            return new flash.geom.Point(arg1.x + viewPort.x, arg1.y + viewPort.y);
        }

        public function render():void
        {
            var loc1:*=layerFactory.create(scale, center);
            scaleLayer(loc1);
            centerLayer(loc1);
            root.addLayer(loc1);
            addPartitions(loc1, getVisiblePartitions(loc1));
            return;
        }

        public function dispose():void
        {
            while (root.layers.length) 
            {
                disposeLayer(root.layers[0]);
            }
            root.dispose();
            _root = null;
            partitionFactory = null;
            layerFactory = null;
            return;
        }

        public function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            root.removeLayer(arg1);
            layerFactory.disposeLayer(arg1);
            return;
        }

        public function disposePartition(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            arg1.removePartition(arg2);
            partitionFactory.disposePartition(arg2);
            return;
        }

        public function getConversionMatrix(arg1:flash.geom.Point, arg2:Number, arg3:Number, arg4:flash.geom.Rectangle):flash.geom.Matrix
        {
            var loc1:*;
            (loc1 = new flash.geom.Matrix()).translate(-arg1.x, -arg1.y);
            loc1.scale(arg2, arg2);
            loc1.rotate(arg3 % (3.14159265359 * 2));
            loc1.translate(arg4.width / 2, arg4.height / 2);
            return loc1;
        }

        public function getVisiblePartitions(arg1:sk.yoz.ycanvas.interfaces.ILayer):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            return getVisiblePartitionsByMarginPoints(arg1, marginPoints);
        }

        public var partitionFactory:sk.yoz.ycanvas.interfaces.IPartitionFactory;

        public var layerFactory:sk.yoz.ycanvas.interfaces.ILayerFactory;

        protected var _root:sk.yoz.ycanvas.interfaces.IYCanvasRoot;

        protected var marginOffset:uint=0;

        internal var cachedMarginPoints:sk.yoz.ycanvas.valueObjects.MarginPoints;

        internal var _center:flash.geom.Point;

        internal var _rotation:Number=0;

        internal var _scale:Number=1;

        internal var _viewPort:flash.geom.Rectangle;

        internal var cachedConversionMatrix:flash.geom.Matrix;
    }
}


