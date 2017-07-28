//class Pool
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class Pool extends Object
    {
        public function Pool()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getPoint(arg1:Number=0, arg2:Number=0):flash.geom.Point
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Point(arg1, arg2);
            }
            loc1 = sPoints.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            return loc1;
        }

        public static function putPoint(arg1:flash.geom.Point):void
        {
            if (arg1) 
            {
                sPoints[sPoints.length] = arg1;
            }
            return;
        }

        public static function getPoint3D(arg1:Number=0, arg2:Number=0, arg3:Number=0):flash.geom.Vector3D
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Vector3D(arg1, arg2, arg3);
            }
            loc1 = sPoints3D.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            loc1.z = arg3;
            return loc1;
        }

        public static function putPoint3D(arg1:flash.geom.Vector3D):void
        {
            if (arg1) 
            {
                sPoints3D[sPoints3D.length] = arg1;
            }
            return;
        }

        public static function getMatrix(arg1:Number=1, arg2:Number=0, arg3:Number=0, arg4:Number=1, arg5:Number=0, arg6:Number=0):flash.geom.Matrix
        {
            var loc1:*=null;
            if (sMatrices.length == 0) 
            {
                return new flash.geom.Matrix(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            loc1 = sMatrices.pop();
            loc1.setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return loc1;
        }

        public static function putMatrix(arg1:flash.geom.Matrix):void
        {
            if (arg1) 
            {
                sMatrices[sMatrices.length] = arg1;
            }
            return;
        }

        public static function getMatrix3D(arg1:Boolean=true):flash.geom.Matrix3D
        {
            var loc1:*=null;
            if (sMatrices3D.length == 0) 
            {
                return new flash.geom.Matrix3D();
            }
            loc1 = sMatrices3D.pop();
            if (arg1) 
            {
                loc1.identity();
            }
            return loc1;
        }

        public static function putMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                sMatrices3D[sMatrices3D.length] = arg1;
            }
            return;
        }

        public static function getRectangle(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0):flash.geom.Rectangle
        {
            var loc1:*=null;
            if (sRectangles.length == 0) 
            {
                return new flash.geom.Rectangle(arg1, arg2, arg3, arg4);
            }
            loc1 = sRectangles.pop();
            loc1.setTo(arg1, arg2, arg3, arg4);
            return loc1;
        }

        public static function putRectangle(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                sRectangles[sRectangles.length] = arg1;
            }
            return;
        }

        
        {
            sPoints = new Vector.<flash.geom.Point>(0);
            sPoints3D = new Vector.<flash.geom.Vector3D>(0);
            sMatrices = new Vector.<flash.geom.Matrix>(0);
            sMatrices3D = new Vector.<flash.geom.Matrix3D>(0);
            sRectangles = new Vector.<flash.geom.Rectangle>(0);
        }

        internal static var sPoints:__AS3__.vec.Vector.<flash.geom.Point>;

        internal static var sPoints3D:__AS3__.vec.Vector.<flash.geom.Vector3D>;

        internal static var sMatrices:__AS3__.vec.Vector.<flash.geom.Matrix>;

        internal static var sMatrices3D:__AS3__.vec.Vector.<flash.geom.Matrix3D>;

        internal static var sRectangles:__AS3__.vec.Vector.<flash.geom.Rectangle>;
    }
}


