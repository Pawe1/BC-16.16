//class IPartition
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


