//class ResizeEvent
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


