//class IPartitionLoader
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


