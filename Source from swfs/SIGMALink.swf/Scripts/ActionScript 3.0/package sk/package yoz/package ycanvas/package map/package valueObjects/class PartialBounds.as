//class PartialBounds
package sk.yoz.ycanvas.map.valueObjects 
{
    import flash.geom.*;
    
    public class PartialBounds extends Object
    {
        public function PartialBounds()
        {
            super();
            return;
        }

        public var rectangle:flash.geom.Rectangle;

        public var vertexIndexMin:uint;

        public var vertexIndexMax:uint;

        public var indiceIndexMin:uint;

        public var indiceIndexMax:uint;
    }
}


