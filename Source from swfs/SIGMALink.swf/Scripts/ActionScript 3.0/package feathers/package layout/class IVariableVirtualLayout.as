//class IVariableVirtualLayout
package feathers.layout 
{
    import starling.display.*;
    
    public interface IVariableVirtualLayout extends feathers.layout.IVirtualLayout
    {
        function get hasVariableItemDimensions():Boolean;

        function set hasVariableItemDimensions(arg1:Boolean):void;

        function resetVariableVirtualCache():void;

        function resetVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void;

        function addToVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void;

        function removeFromVariableVirtualCacheAtIndex(arg1:int):void;
    }
}


