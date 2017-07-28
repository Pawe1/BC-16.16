//class MapLayer
package sk.yoz.ycanvas.map.display 
{
    import flash.geom.*;
    import starling.display.*;
    
    public class MapLayer extends starling.display.Sprite
    {
        public function MapLayer()
        {
            _center = new flash.geom.Point();
            super();
            return;
        }

        public override function set width(arg1:Number):void
        {
            if (width == arg1) 
            {
                return;
            }
            _width = arg1;
            updatePosition();
            return;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function set height(arg1:Number):void
        {
            if (height == arg1) 
            {
                return;
            }
            _height = arg1;
            updatePosition();
            return;
        }

        public override function get height():Number
        {
            return _height;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            if (center == arg1) 
            {
                return;
            }
            _center = arg1;
            updatePosition();
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set mapScale(arg1:Number):void
        {
            if (mapScale == arg1) 
            {
                return;
            }
            _mapScale = scaleX = scaleY = arg1;
            updatePosition();
            return;
        }

        public function get mapScale():Number
        {
            return _mapScale;
        }

        public override function set rotation(arg1:Number):void
        {
            if (rotation == arg1) 
            {
                return;
            }
            super(
#error('findrop') rotation
            ).rotation = arg1;
            updatePosition();
            return;
        }

        internal function updatePosition():void
        {
            var loc2:*=(-center.x) * mapScale;
            var loc3:*=(-center.y) * mapScale;
            var loc4:*=Math.sin(rotation);
            var loc1:*=Math.cos(rotation);
            this.x = loc1 * loc2 - loc4 * loc3 + width / 2;
            this.y = loc1 * loc3 + loc4 * loc2 + height / 2;
            return;
        }

        internal var _width:Number;

        internal var _height:Number;

        internal var _center:flash.geom.Point;

        internal var _mapScale:Number;
    }
}


