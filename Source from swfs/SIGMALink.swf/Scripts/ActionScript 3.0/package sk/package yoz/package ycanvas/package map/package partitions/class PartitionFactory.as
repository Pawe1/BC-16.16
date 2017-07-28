//class PartitionFactory
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


