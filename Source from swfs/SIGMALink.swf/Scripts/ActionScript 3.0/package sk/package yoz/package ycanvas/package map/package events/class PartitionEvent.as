//class PartitionEvent
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


