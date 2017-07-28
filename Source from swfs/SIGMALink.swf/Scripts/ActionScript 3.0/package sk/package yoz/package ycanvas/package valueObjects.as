//package valueObjects
//  class LayerPartitions
package sk.yoz.ycanvas.valueObjects 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.interfaces.*;
    
    public class LayerPartitions extends Object
    {
        public function LayerPartitions()
        {
            super();
            return;
        }

        public var layer:sk.yoz.ycanvas.interfaces.ILayer;

        public var partitions:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;
    }
}


//  class MarginPoints
package sk.yoz.ycanvas.valueObjects 
{
    import flash.geom.*;
    
    public class MarginPoints extends Object
    {
        public function MarginPoints()
        {
            super();
            return;
        }

        public function getMinX():Number
        {
            return Math.min(x1, x2, x3, x4);
        }

        public function getMaxX():Number
        {
            return Math.max(x1, x2, x3, x4);
        }

        public function getMinY():Number
        {
            return Math.min(y1, y2, y3, y4);
        }

        public function getMaxY():Number
        {
            return Math.max(y1, y2, y3, y4);
        }

        public static function fromPoints(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            var loc1:*;
            (loc1 = new MarginPoints()).x1 = arg1.x;
            loc1.y1 = arg1.y;
            loc1.x2 = arg2.x;
            loc1.y2 = arg2.y;
            loc1.x3 = arg3.x;
            loc1.y3 = arg3.y;
            loc1.x4 = arg4.x;
            loc1.y4 = arg4.y;
            return loc1;
        }

        public var x1:Number;

        public var y1:Number;

        public var x2:Number;

        public var y2:Number;

        public var x3:Number;

        public var y3:Number;

        public var x4:Number;

        public var y4:Number;
    }
}


