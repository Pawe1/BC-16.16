//class ILayerStarling
package sk.yoz.ycanvas.starling.interfaces 
{
    import sk.yoz.ycanvas.interfaces.*;
    import starling.display.*;
    
    public dynamic interface ILayerStarling extends sk.yoz.ycanvas.interfaces.ILayer
    {
        function get content():starling.display.DisplayObjectContainer;
    }
}


