//class Stroke
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.utils.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.core.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    
    public class Stroke extends sk.yoz.ycanvas.map.display.AbstractGraphics
    {
        public function Stroke(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:uint=16777215, arg4:Number=1, arg5:Boolean=true)
        {
            _points = arg1;
            _thickness = arg2;
            _color = arg3;
            this.autoUpdate = arg5;
            super();
            this.alpha = arg4;
            if (arg5) 
            {
                update();
            }
            return;
        }

        public override function get bounds():flash.geom.Rectangle
        {
            return _bounds;
        }

        public function get color():uint
        {
            return _color;
        }

        public function set color(arg1:uint):void
        {
            if (color == arg1) 
            {
                return;
            }
            _color = arg1;
            colorChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        public function get points():__AS3__.vec.Vector.<Number>
        {
            return _points;
        }

        public function set points(arg1:__AS3__.vec.Vector.<Number>):void
        {
            if (points == arg1) 
            {
                return;
            }
            _points = arg1;
            pointsChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        public function get thickness():Number
        {
            return _thickness;
        }

        public function set thickness(arg1:Number):void
        {
            if (thickness == arg1) 
            {
                return;
            }
            _thickness = arg1;
            thicknessChanged = true;
            if (autoUpdate) 
            {
                update();
            }
            return;
        }

        protected override function get programName():String
        {
            return "YCanvasStroke";
        }

        public function update():void
        {
            if (!pointsChanged && !thicknessChanged && !colorChanged) 
            {
                return;
            }
            var loc2:*=starling.core.Starling.context;
            if (loc2 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            var loc1:*=false;
            var loc3:*=false;
            if (pointsChanged || thicknessChanged) 
            {
                vertexData = sk.yoz.ycanvas.map.utils.StrokeUtils.pointsToVertexData(points, thickness, color);
                loc1 = true;
                indexData = sk.yoz.ycanvas.map.utils.StrokeUtils.vertexDataToIndexData(vertexData);
                loc3 = true;
                updateBounds();
            }
            pointsChanged = false;
            thicknessChanged = false;
            colorChanged = false;
            if (loc1) 
            {
                updateVertexBuffer();
            }
            if (loc3) 
            {
                updateIndexBuffer();
            }
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc3:*=null;
            if (!visible || !touchable) 
            {
                return null;
            }
            if (!bounds.containsPoint(arg1)) 
            {
                return null;
            }
            return null;
            loc2 = 0;
            loc1 = partialBounds.length;
            while (loc2 < loc1) 
            {
                if ((loc3 = partialBounds[loc2]).rectangle.containsPoint(arg1)) 
                {
                    if (hitTestIndices(arg1, loc3.indiceIndexMin, loc3.indiceIndexMax)) 
                    {
                        return this;
                    }
                }
                ++loc2;
            }
            return null;
        }

        protected function updateBounds():void
        {
            partialBounds = sk.yoz.ycanvas.map.utils.VertexDataUtils.getPartialBoundsList(vertexData, verticesPerPartialBounds);
            _bounds = sk.yoz.ycanvas.map.utils.PartialBoundsUtils.mergeListToRectangle(partialBounds);
            return;
        }

        protected override function onContextCreated(arg1:starling.events.Event):void
        {
            pointsChanged = true;
            colorChanged = true;
            thicknessChanged = true;
            super.onContextCreated(arg1);
            update();
            return;
        }

        internal static const PROGRAM_NAME:String="YCanvasStroke";

        public var autoUpdate:Boolean=true;

        internal var _bounds:flash.geom.Rectangle;

        internal var _color:Number;

        internal var _points:__AS3__.vec.Vector.<Number>;

        public var pointsChanged:Boolean=true;

        internal var _thickness:Number;

        protected var verticesPerPartialBounds:uint=256;

        internal var colorChanged:Boolean=true;

        internal var partialBounds:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>;

        internal var thicknessChanged:Boolean=true;
    }
}


