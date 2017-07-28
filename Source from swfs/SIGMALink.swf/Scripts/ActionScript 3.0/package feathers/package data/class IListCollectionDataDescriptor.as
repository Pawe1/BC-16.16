//class IListCollectionDataDescriptor
package feathers.data 
{
    public interface IListCollectionDataDescriptor
    {
        function getLength(arg1:Object):int;

        function getItemAt(arg1:Object, arg2:int):Object;

        function setItemAt(arg1:Object, arg2:Object, arg3:int):void;

        function addItemAt(arg1:Object, arg2:Object, arg3:int):void;

        function removeItemAt(arg1:Object, arg2:int):Object;

        function getItemIndex(arg1:Object, arg2:Object):int;

        function removeAll(arg1:Object):void;
    }
}


