//class ILayer
package sk.yoz.ycanvas.interfaces 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    
    public dynamic interface ILayer
    {
        function set center(arg1:flash.geom.Point):void;

        function set scale(arg1:Number):void;

        function get level():uint;

        function get partitions():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;

        function get partitionWidth():uint;

        function get partitionHeight():uint;

        function addPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;

        function getPartition(arg1:int, arg2:int):sk.yoz.ycanvas.interfaces.IPartition;

        function removePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;

        function toString():String;
    }
}


