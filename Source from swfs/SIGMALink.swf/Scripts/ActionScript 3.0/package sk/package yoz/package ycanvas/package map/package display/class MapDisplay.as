//class MapDisplay
package sk.yoz.ycanvas.map.display 
{
    import flash.geom.*;
    import starling.display.*;
    
    public class MapDisplay extends starling.display.Sprite
    {
        public function MapDisplay()
        {
            super();
            return;
        }

        public override function get height():Number
        {
            return _height;
        }

        public override function set height(arg1:Number):void
        {
            _height = arg1;
            validateClipRect();
            invalidateStarlingViewPort();
            return;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function set width(arg1:Number):void
        {
            _width = arg1;
            validateClipRect();
            invalidateStarlingViewPort();
            return;
        }

        public override function set x(arg1:Number):void
        {
            super(
#error('findrop') x
            ).x = arg1;
            invalidateStarlingViewPort();
            return;
        }

        public override function set y(arg1:Number):void
        {
            super(
#error('findrop') y
            ).y = arg1;
            invalidateStarlingViewPort();
            return;
        }

        internal function get starlingViewPort():flash.geom.Rectangle
        {
            var loc1:*=null;
            if (!_starlingViewPort) 
            {
                loc1 = localToGlobal(new flash.geom.Point(0, 0));
                _starlingViewPort = new flash.geom.Rectangle(loc1.x, loc1.y, width, height);
            }
            return _starlingViewPort;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable) 
            {
                return null;
            }
            var loc2:*=arg1.x;
            var loc1:*=arg1.y;
            var loc3:*;
            if (loc3 = super.hitTest(arg1)) 
            {
                return loc3;
            }
            var loc4:*=localToGlobal(new flash.geom.Point(loc2, loc1));
            return starlingViewPort.contains(loc4.x, loc4.y) ? this : null;
        }

        internal function validateClipRect():void
        {
            mask = new starling.display.Quad(width, height);
            var loc1:*;
            mask.y = loc1 = 0;
            mask.x = loc1;
            return;
        }

        public function invalidateStarlingViewPort():void
        {
            _starlingViewPort = null;
            dispatchEventWith("viewPortUpdated");
            return;
        }

        public static const VIEWPORT_UPDATED:String="viewPortUpdated";

        internal var _height:Number=200;

        internal var _width:Number=200;

        internal var _starlingViewPort:flash.geom.Rectangle;
    }
}


