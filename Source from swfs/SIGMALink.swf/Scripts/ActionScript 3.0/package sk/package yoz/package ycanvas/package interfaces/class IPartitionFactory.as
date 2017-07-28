//class IPartitionFactory
package sk.yoz.ycanvas.interfaces 
{
    public dynamic interface IPartitionFactory
    {
        function create(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer):sk.yoz.ycanvas.interfaces.IPartition;

        function disposePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;
    }
}


