//class IScrollContainer
package feathers.controls 
{
    import feathers.core.*;
    import starling.display.*;
    
    public interface IScrollContainer extends feathers.core.IFeathersControl
    {
        function get numRawChildren():int;

        function getRawChildByName(arg1:String):starling.display.DisplayObject;

        function getRawChildIndex(arg1:starling.display.DisplayObject):int;

        function getRawChildAt(arg1:int):starling.display.DisplayObject;

        function setRawChildIndex(arg1:starling.display.DisplayObject, arg2:int):void;

        function addRawChild(arg1:starling.display.DisplayObject):starling.display.DisplayObject;

        function addRawChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject;

        function removeRawChild(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject;

        function removeRawChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject;

        function swapRawChildren(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void;

        function swapRawChildrenAt(arg1:int, arg2:int):void;

        function sortRawChildren(arg1:Function):void;
    }
}


