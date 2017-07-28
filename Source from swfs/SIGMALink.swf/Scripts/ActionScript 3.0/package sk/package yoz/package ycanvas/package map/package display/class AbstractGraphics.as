//class AbstractGraphics
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


