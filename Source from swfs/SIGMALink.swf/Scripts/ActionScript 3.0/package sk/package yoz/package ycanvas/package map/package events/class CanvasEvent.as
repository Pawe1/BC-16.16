//class CanvasEvent
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


