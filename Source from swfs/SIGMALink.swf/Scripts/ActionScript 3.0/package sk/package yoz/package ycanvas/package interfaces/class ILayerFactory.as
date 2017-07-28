//class ILayerFactory
package sk.yoz.ycanvas.interfaces 
{
    import flash.geom.*;
    
    public dynamic interface ILayerFactory
    {
        function create(arg1:Number, arg2:flash.geom.Point):sk.yoz.ycanvas.interfaces.ILayer;

        function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void;
    }
}


