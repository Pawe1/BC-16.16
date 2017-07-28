//package events
//  class TransitionMultitouchEvent
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


//  class TwoFingerEvent
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


