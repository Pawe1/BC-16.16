//class PartitionLoader
package frontend.components.map 
{
    import flash.display.*;
    import sk.yoz.ycanvas.map.partitions.*;
    
    public class PartitionLoader extends frontend.components.map.LoaderOptimizer implements sk.yoz.ycanvas.map.partitions.IPartitionLoader
    {
        public function PartitionLoader()
        {
            super();
            return;
        }

        public function disposeLoader(arg1:flash.display.Loader):void
        {
            release(arg1);
            return;
        }
    }
}


