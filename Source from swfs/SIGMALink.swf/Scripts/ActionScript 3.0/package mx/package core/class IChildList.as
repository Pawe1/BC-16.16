//class IChildList
package mx.core 
{
    import flash.display.*;
    import flash.geom.*;
    
    public interface IChildList
    {
        function get numChildren():int;

        function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function addChildAt(arg1:flash.display.DisplayObject, arg2:int):flash.display.DisplayObject;

        function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function removeChildAt(arg1:int):flash.display.DisplayObject;

        function getChildAt(arg1:int):flash.display.DisplayObject;

        function getChildByName(arg1:String):flash.display.DisplayObject;

        function getChildIndex(arg1:flash.display.DisplayObject):int;

        function setChildIndex(arg1:flash.display.DisplayObject, arg2:int):void;

        function getObjectsUnderPoint(arg1:flash.geom.Point):Array;

        function contains(arg1:flash.display.DisplayObject):Boolean;
    }
}


