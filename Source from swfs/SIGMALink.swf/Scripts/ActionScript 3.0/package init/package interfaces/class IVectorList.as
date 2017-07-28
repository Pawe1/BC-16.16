//class IVectorList
package init.interfaces 
{
    import flash.events.*;
    
    public dynamic interface IVectorList extends flash.events.IEventDispatcher
    {
        function get length():int;

        function get source():*;

        function toArray():Array;

        function addItem(arg1:Object):void;

        function contains(arg1:Object):Boolean;

        function getItemAt(arg1:int, arg2:int=0):Object;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;
    }
}


