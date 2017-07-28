//package events
//  class CanvasEvent
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


//  class PartitionEvent
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


