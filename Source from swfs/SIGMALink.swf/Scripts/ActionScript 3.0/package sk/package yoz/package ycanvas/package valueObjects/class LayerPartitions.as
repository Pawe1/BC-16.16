//class LayerPartitions
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


