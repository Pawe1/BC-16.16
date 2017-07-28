//class AbstractYCanvas
package sk.yoz.ycanvas 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.utils.*;
    import sk.yoz.ycanvas.valueObjects.*;
    
    public class AbstractYCanvas extends Object
    {
        public function AbstractYCanvas(arg1:flash.geom.Rectangle)
        {
            _center = new flash.geom.Point(0, 0);
            _viewPort = new flash.geom.Rectangle(0, 0, 640, 480);
            super();
            this.viewPort = arg1;
            return;
        }

        public function getVisiblePartitionsByMarginPoints(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.valueObjects.MarginPoints):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            var loc7:*=0;
            var loc9:*=0;
            var loc2:*=arg1.partitionWidth * arg1.level;
            var loc4:*=arg1.partitionHeight * arg1.level;
            var loc5:*=Math.floor(arg2.getMinX() / loc2) * loc2;
            var loc8:*=Math.floor(arg2.getMaxX() / loc2) * loc2;
            var loc3:*=Math.floor(arg2.getMinY() / loc4) * loc4;
            var loc6:*=Math.floor(arg2.getMaxY() / loc4) * loc4;
            var loc1:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            loc7 = loc5;
            while (loc7 <= loc8) 
            {
                loc9 = loc3;
                while (loc9 <= loc6) 
                {
                    if (isCollision(arg2, loc7, loc9, loc2, loc4)) 
                    {
                        loc1.push(arg1.getPartition(loc7, loc9) || partitionFactory.create(loc7, loc9, arg1));
                    }
                    loc9 = loc9 + loc4;
                }
                loc7 = loc7 + loc2;
            }
            return loc1;
        }

        public function getMarginPoints(arg1:flash.geom.Rectangle, arg2:uint=0):sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            var loc2:*=arg1.left - arg2;
            var loc4:*=arg1.right + arg2;
            var loc1:*=arg1.top - arg2;
            var loc3:*=arg1.bottom + arg2;
            return sk.yoz.ycanvas.valueObjects.MarginPoints.fromPoints(globalToCanvas(new flash.geom.Point(loc2, loc1)), globalToCanvas(new flash.geom.Point(loc4, loc1)), globalToCanvas(new flash.geom.Point(loc4, loc3)), globalToCanvas(new flash.geom.Point(loc2, loc3)));
        }

        public function applyDisplayObject(arg1:flash.display.DisplayObject):void
        {
            applyIBitmapDrawableWithMatrix(arg1, sk.yoz.ycanvas.utils.DisplayObjectUtils.getConcatenatedMatrix(arg1));
            return;
        }

        public function applyIBitmapDrawableWithMatrix(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc8:*=0;
            var loc7:*=layers;
            for each (var loc4:* in loc7) 
            {
                var loc6:*=0;
                var loc5:*=loc4.partitions;
                for each (var loc2:* in loc5) 
                {
                    loc1 = loc2.concatenatedMatrix;
                    loc1.invert();
                    (loc3 = arg2.clone()).translate(-viewPort.x, -viewPort.y);
                    loc3.concat(loc1);
                    loc2.applyIBitmapDrawable(arg1, loc3);
                }
            }
            return;
        }

        public function set showStats(arg1:Boolean):void
        {
            throw new Error("This method must be overriden.");
        }

        protected function centerRoot():void
        {
            root.x = viewPort.width / 2;
            root.y = viewPort.height / 2;
            return;
        }

        protected function centerLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            arg1.center = center;
            return;
        }

        protected function scaleLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            arg1.scale = arg1.level;
            return;
        }

        protected function addPartitions(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>):void
        {
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg1.addPartition(arg2[loc2]);
                ++loc2;
            }
            return;
        }

        protected function invalidateTransformationCache():void
        {
            cachedConversionMatrix = null;
            cachedMarginPoints = null;
            return;
        }

        public function set viewPort(arg1:flash.geom.Rectangle):void
        {
            _viewPort = arg1;
            invalidateTransformationCache();
            centerRoot();
            return;
        }

        public function get viewPort():flash.geom.Rectangle
        {
            return _viewPort;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            var loc2:*=0;
            var loc1:*=0;
            _center = arg1;
            loc2 = 0;
            loc1 = layers.length;
            while (loc2 < loc1) 
            {
                centerLayer(layers[loc2]);
                ++loc2;
            }
            invalidateTransformationCache();
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set rotation(arg1:Number):void
        {
            var loc1:*;
            root.rotation = loc1 = arg1;
            _rotation = loc1;
            invalidateTransformationCache();
            return;
        }

        public function get rotation():Number
        {
            return _rotation;
        }

        public function set scale(arg1:Number):void
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc3:*;
            root.yCanvasScale = loc3 = arg1;
            _scale = loc3;
            loc2 = 0;
            loc1 = layers.length;
            while (loc2 < loc1) 
            {
                scaleLayer(layers[loc2]);
                ++loc2;
            }
            invalidateTransformationCache();
            return;
        }

        public function get scale():Number
        {
            return _scale;
        }

        public function get root():sk.yoz.ycanvas.interfaces.IYCanvasRoot
        {
            return _root;
        }

        public function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>
        {
            return root.layers;
        }

        public function get conversionMatrix():flash.geom.Matrix
        {
            if (cachedConversionMatrix) 
            {
                return cachedConversionMatrix;
            }
            cachedConversionMatrix = getConversionMatrix(center, scale, rotation, viewPort);
            return cachedConversionMatrix;
        }

        public function get bitmapData():flash.display.BitmapData
        {
            throw new Error("This method must be overriden.");
        }

        public function isCollision(arg1:sk.yoz.ycanvas.valueObjects.MarginPoints, arg2:Number, arg3:Number, arg4:Number, arg5:Number):Boolean
        {
            return sk.yoz.math.FastCollisions.rectangles(arg1.x1, arg1.y1, arg1.x2, arg1.y2, arg1.x3, arg1.y3, arg1.x4, arg1.y4, arg2, arg3, arg2 + arg4, arg3, arg2 + arg4, arg3 + arg5, arg2, arg3 + arg5);
        }

        public function get marginPoints():sk.yoz.ycanvas.valueObjects.MarginPoints
        {
            if (cachedMarginPoints) 
            {
                return cachedMarginPoints;
            }
            cachedMarginPoints = getMarginPoints(viewPort, marginOffset);
            return cachedMarginPoints;
        }

        public function globalToCanvas(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=globalToViewPort(arg1);
            var loc1:*=conversionMatrix.clone();
            loc1.invert();
            return loc1.transformPoint(loc2);
        }

        public function globalToViewPort(arg1:flash.geom.Point):flash.geom.Point
        {
            return new flash.geom.Point(arg1.x - viewPort.x, arg1.y - viewPort.y);
        }

        public function canvasToGlobal(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=conversionMatrix.clone();
            var loc1:*=loc2.transformPoint(arg1);
            return viewPortToGlobal(loc1);
        }

        public function canvasToViewPort(arg1:flash.geom.Point):flash.geom.Point
        {
            return globalToViewPort(canvasToGlobal(arg1));
        }

        public function viewPortToCanvas(arg1:flash.geom.Point):flash.geom.Point
        {
            return globalToCanvas(viewPortToGlobal(arg1));
        }

        public function viewPortToGlobal(arg1:flash.geom.Point):flash.geom.Point
        {
            return new flash.geom.Point(arg1.x + viewPort.x, arg1.y + viewPort.y);
        }

        public function render():void
        {
            var loc1:*=layerFactory.create(scale, center);
            scaleLayer(loc1);
            centerLayer(loc1);
            root.addLayer(loc1);
            addPartitions(loc1, getVisiblePartitions(loc1));
            return;
        }

        public function dispose():void
        {
            while (root.layers.length) 
            {
                disposeLayer(root.layers[0]);
            }
            root.dispose();
            _root = null;
            partitionFactory = null;
            layerFactory = null;
            return;
        }

        public function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            root.removeLayer(arg1);
            layerFactory.disposeLayer(arg1);
            return;
        }

        public function disposePartition(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            arg1.removePartition(arg2);
            partitionFactory.disposePartition(arg2);
            return;
        }

        public function getConversionMatrix(arg1:flash.geom.Point, arg2:Number, arg3:Number, arg4:flash.geom.Rectangle):flash.geom.Matrix
        {
            var loc1:*;
            (loc1 = new flash.geom.Matrix()).translate(-arg1.x, -arg1.y);
            loc1.scale(arg2, arg2);
            loc1.rotate(arg3 % (3.14159265359 * 2));
            loc1.translate(arg4.width / 2, arg4.height / 2);
            return loc1;
        }

        public function getVisiblePartitions(arg1:sk.yoz.ycanvas.interfaces.ILayer):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            return getVisiblePartitionsByMarginPoints(arg1, marginPoints);
        }

        public var partitionFactory:sk.yoz.ycanvas.interfaces.IPartitionFactory;

        public var layerFactory:sk.yoz.ycanvas.interfaces.ILayerFactory;

        protected var _root:sk.yoz.ycanvas.interfaces.IYCanvasRoot;

        protected var marginOffset:uint=0;

        internal var cachedMarginPoints:sk.yoz.ycanvas.valueObjects.MarginPoints;

        internal var _center:flash.geom.Point;

        internal var _rotation:Number=0;

        internal var _scale:Number=1;

        internal var _viewPort:flash.geom.Rectangle;

        internal var cachedConversionMatrix:flash.geom.Matrix;
    }
}


