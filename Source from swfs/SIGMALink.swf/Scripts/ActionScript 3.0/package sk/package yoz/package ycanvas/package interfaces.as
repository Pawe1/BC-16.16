//package interfaces
//  class ILayer
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


//  class ILayerFactory
package sk.yoz.ycanvas.interfaces 
{
    import flash.geom.*;
    
    public dynamic interface ILayerFactory
    {
        function create(arg1:Number, arg2:flash.geom.Point):sk.yoz.ycanvas.interfaces.ILayer;

        function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;
    }
}


//  class IPartition
package sk.yoz.ycanvas.interfaces 
{
    import flash.display.*;
    import flash.geom.*;
    
    public dynamic interface IPartition
    {
        function get x():int;

        function get y():int;

        function get expectedWidth():uint;

        function get expectedHeight():uint;

        function get concatenatedMatrix():flash.geom.Matrix;

        function applyIBitmapDrawable(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void;

        function toString():String;
    }
}


//  class IPartitionFactory
package sk.yoz.ycanvas.interfaces 
{
    public dynamic interface IPartitionFactory
    {
        function create(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer):sk.yoz.ycanvas.interfaces.IPartition;

        function disposePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void;
    }
}


//  class IYCanvasRoot
package sk.yoz.ycanvas.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IYCanvasRoot
    {
        function set x(arg1:Number):void;

        function set y(arg1:Number):void;

        function set rotation(arg1:Number):void;

        function set yCanvasScale(arg1:Number):void;

        function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>;

        function addLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;

        function removeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;

        function dispose():void;
    }
}


