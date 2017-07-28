//class MeshUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.rendering.*;
    
    public class MeshUtil extends Object
    {
        public function MeshUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function containsPoint(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:flash.geom.Point):Boolean
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=arg2.numIndices;
            var loc4:*=starling.utils.Pool.getPoint();
            var loc5:*=starling.utils.Pool.getPoint();
            var loc6:*=starling.utils.Pool.getPoint();
            loc1 = 0;
            while (loc1 < loc3) 
            {
                arg1.getPoint(arg2.getIndex(loc1), "position", loc4);
                arg1.getPoint(arg2.getIndex(loc1 + 1), "position", loc5);
                arg1.getPoint(arg2.getIndex(loc1 + 2), "position", loc6);
                if (starling.utils.MathUtil.isPointInTriangle(arg3, loc4, loc5, loc6)) 
                {
                    loc2 = true;
                    break;
                }
                loc1 = loc1 + 3;
            }
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putPoint(loc5);
            starling.utils.Pool.putPoint(loc6);
            return loc2;
        }

        public static function calculateBounds(arg1:starling.rendering.VertexData, arg2:starling.display.DisplayObject, arg3:starling.display.DisplayObject, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            var loc1:*=arg2.stage;
            if (arg2.is3D && loc1) 
            {
                loc1.getCameraPosition(arg3, sPoint3D);
                arg2.getTransformationMatrix3D(arg3, sMatrix3D);
                arg1.getBoundsProjected("position", sMatrix3D, sPoint3D, 0, -1, arg4);
            }
            else 
            {
                arg2.getTransformationMatrix(arg3, sMatrix);
                arg1.getBounds("position", sMatrix, 0, -1, arg4);
            }
            return arg4;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


