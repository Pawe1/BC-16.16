//class IYCanvasRoot
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


