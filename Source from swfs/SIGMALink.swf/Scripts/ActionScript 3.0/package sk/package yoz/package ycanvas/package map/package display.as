//package display
//  class AbstractGraphics
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.map.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class AbstractGraphics extends starling.display.DisplayObject
    {
        public function AbstractGraphics()
        {
            new __AS3__.vec.Vector.<Number>(4)[0] = 1;
            new __AS3__.vec.Vector.<Number>(4)[1] = 1;
            new __AS3__.vec.Vector.<Number>(4)[2] = 1;
            new __AS3__.vec.Vector.<Number>(4)[3] = 1;
            renderAlpha = new __AS3__.vec.Vector.<Number>(4);
            var loc1:*="context3DCreate";
            starling.core.Starling.current.addEventListener(loc1, onContextCreated);
            registerPrograms();
            super();
            return;
        }

        protected function get programName():String
        {
            throw new Error("Method not implemented");
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc3:*=getTransformationMatrix(arg1);
            var loc2:*=starling.utils.MatrixUtil.transformCoords(loc3, bounds.x, bounds.y);
            var loc1:*=starling.utils.MatrixUtil.transformCoords(loc3, bounds.x + bounds.width, bounds.y + bounds.height);
            arg2.setTo(loc2.x, loc2.y, loc1.x - loc2.x, loc1.y - loc2.y);
            return arg2;
        }

        public override function dispose():void
        {
            var loc1:*="context3DCreate";
            starling.core.Starling.current.removeEventListener(loc1, onContextCreated);
            if (vertexBuffer) 
            {
                vertexBuffer.dispose();
            }
            if (indexBuffer) 
            {
                indexBuffer.dispose();
            }
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.batchMesh(new starling.display.Mesh(vertexData, sk.yoz.ycanvas.map.utils.StrokeUtils.indexDataVectorToIndexDataObj(indexData)));
            return;
        }

        protected function updateVertexBuffer():void
        {
            if (vertexBuffer) 
            {
                vertexBuffer.dispose();
            }
            vertexBuffer = starling.core.Starling.context.createVertexBuffer(vertexData.numVertices, vertexData.vertexSizeIn32Bits);
            vertexBuffer.uploadFromByteArray(vertexData.rawData, 0, 0, vertexData.numVertices);
            return;
        }

        protected function updateIndexBuffer():void
        {
            if (indexBuffer) 
            {
                indexBuffer.dispose();
            }
            indexBuffer = starling.core.Starling.context.createIndexBuffer(indexData.length);
            indexBuffer.uploadFromVector(indexData, 0, indexData.length);
            return;
        }

        protected function hitTestIndices(arg1:flash.geom.Point, arg2:uint, arg3:uint):Boolean
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc4:*=0;
            var loc1:*=starling.utils.Pool.getPoint();
            var loc2:*=starling.utils.Pool.getPoint();
            var loc3:*=starling.utils.Pool.getPoint();
            loc4 = arg2;
            while (loc4 <= arg3) 
            {
                loc6 = (loc5 = loc4 + 1) + 1;
                vertexData.getPoint(indexData[loc4], "position", loc1);
                vertexData.getPoint(indexData[loc5], "position", loc2);
                vertexData.getPoint(indexData[loc6], "position", loc3);
                if (sk.yoz.math.FastCollisions.pointInTriangle(arg1.x, arg1.y, loc1.x, loc1.y, loc2.x, loc2.y, loc3.x, loc3.y)) 
                {
                    return true;
                }
                loc4 = loc4 + 3;
            }
            starling.utils.Pool.putPoint(loc1);
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putPoint(loc3);
            return false;
        }

        internal function registerPrograms():void
        {
            if (starling.core.Starling.painter.hasProgram(programName)) 
            {
                return;
            }
            var loc1:*=starling.rendering.Program.fromSource("m44 op, va0, vc0\nmul v0, va1, vc4", "mov oc, v0");
            starling.core.Starling.painter.registerProgram(programName, loc1);
            return;
        }

        protected function onContextCreated(arg1:starling.events.Event):void
        {
            registerPrograms();
            return;
        }

        protected var indexData:__AS3__.vec.Vector.<uint>;

        protected var vertexData:starling.rendering.VertexData;

        internal var indexBuffer:flash.display3D.IndexBuffer3D;

        internal var renderAlpha:__AS3__.vec.Vector.<Number>;

        internal var vertexBuffer:flash.display3D.VertexBuffer3D;
    }
}


//  class MapDisplay
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


//  class MapLayer
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


//  class MapStroke
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import sk.yoz.utils.*;
    
    public class MapStroke extends sk.yoz.ycanvas.map.display.Stroke
    {
        public function MapStroke(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:uint=16777215, arg4:Number=1)
        {
            _basePoints = arg1.concat();
            _originalThickness = arg2;
            super(null, arg2, arg3, arg4, false);
            return;
        }

        public function get basePoints():__AS3__.vec.Vector.<Number>
        {
            return _basePoints;
        }

        public function get layerScale():Number
        {
            return _layerScale;
        }

        public function set layerScale(arg1:Number):void
        {
            if (layerScale == arg1) 
            {
                return;
            }
            _layerScale = arg1;
            thickness = originalThickness / layerScale;
            invalidatePoints();
            return;
        }

        public function get originalThickness():Number
        {
            return _originalThickness;
        }

        internal function invalidatePoints():void
        {
            if (!simplifyTolerance) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            points = null;
            this.autoUpdate = loc1;
            return;
        }

        internal function validatePoints():void
        {
            if (points) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            var loc2:*=simplifyTolerance / layerScale;
            points = simplifyTolerance ? sk.yoz.utils.PathSimplify.simplify(basePoints, loc2, false) : basePoints.concat();
            this.autoUpdate = loc1;
            return;
        }

        public override function update():void
        {
            validatePoints();
            super.update();
            return;
        }

        internal var _basePoints:__AS3__.vec.Vector.<Number>;

        internal var _layerScale:Number;

        internal var _originalThickness:Number;

        public var simplifyTolerance:Number=4;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;
    }
}


//  class MarkerLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import starling.display.*;
    
    public class MarkerLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function MarkerLayer()
        {
            list = new __AS3__.vec.Vector.<starling.display.DisplayObject>();
            super();
            return;
        }

        public override function set rotation(arg1:Number):void
        {
            var loc1:*=0;
            if (rotation == arg1) 
            {
                return;
            }
            super(
#error('findrop') rotation
            ).rotation = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                list[loc1].rotation = -rotation;
            }
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            var loc1:*=0;
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                var loc2:*;
                list[loc1].scaleY = loc2 = 1 / mapScale;
                list[loc1].scaleX = loc2;
            }
            return;
        }

        public function add(arg1:starling.display.DisplayObject):void
        {
            var loc1:*;
            arg1.scaleY = loc1 = 1 / mapScale;
            arg1.scaleX = loc1;
            arg1.rotation = -rotation;
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:starling.display.DisplayObject):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


//  class Stroke
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


//  class StrokeLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    
    public class StrokeLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function StrokeLayer()
        {
            list = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>();
            super();
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            if (autoUpdateThickness) 
            {
                updateThickness();
            }
            return;
        }

        public function updateThickness():void
        {
            var loc2:*=0;
            var loc1:*=null;
            loc2 = list.length;
            while (loc2--) 
            {
                loc1 = list[loc2];
                loc1.layerScale = mapScale;
                if (loc1.autoUpdate) 
                {
                    continue;
                }
                loc1.update();
            }
            return;
        }

        public function add(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            arg1.layerScale = mapScale;
            if (!arg1.autoUpdate) 
            {
                arg1.update();
            }
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>;

        public var autoUpdateThickness:Boolean=true;
    }
}


