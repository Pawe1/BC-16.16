//package valueObjects
//  class Limit
package sk.yoz.ycanvas.map.valueObjects 
{
    public class Limit extends Object
    {
        public function Limit()
        {
            super();
            return;
        }

        public var minScale:Number;

        public var maxScale:Number;

        public var minCenterX:Number;

        public var maxCenterX:Number;

        public var minCenterY:Number;

        public var maxCenterY:Number;
    }
}


//  class MapConfig
package sk.yoz.ycanvas.map.valueObjects 
{
    import __AS3__.vec.*;
    
    public class MapConfig extends Object
    {
        public function MapConfig()
        {
            super();
            return;
        }

        public var urlTemplates:__AS3__.vec.Vector.<String>;

        public var tileWidth:uint;

        public var tileHeight:uint;

        public var forTouch:Boolean=true;
    }
}


//  class PartialBounds
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


//  class Transformation
package sk.yoz.ycanvas.map.valueObjects 
{
    public class Transformation extends Object
    {
        public function Transformation()
        {
            super();
            return;
        }

        public var centerX:Number=0;

        public var centerY:Number=0;

        public var scale:Number=1;

        public var rotation:Number=0;
    }
}


