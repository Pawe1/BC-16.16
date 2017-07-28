//class IHierarchicalCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    
    public interface IHierarchicalCollectionDataDescriptor
    {
        function isBranch(arg1:Object):Boolean;

        function getLength(arg1:Object, ... rest):int;

        function getItemAt(arg1:Object, arg2:int, ... rest):Object;

        function setItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void;

        function addItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void;

        function removeItemAt(arg1:Object, arg2:int, ... rest):Object;

        function removeAll(arg1:Object):void;

        function getItemLocation(arg1:Object, arg2:Object, arg3:__AS3__.vec.Vector.<int>=null, ... rest):__AS3__.vec.Vector.<int>;
    }
}


