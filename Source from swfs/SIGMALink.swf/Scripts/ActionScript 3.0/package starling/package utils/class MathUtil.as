//class MathUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.errors.*;
    
    public class MathUtil extends Object
    {
        public function MathUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersectLineWithXYPlane(arg1:flash.geom.Vector3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=arg2.x - arg1.x;
            var loc2:*=arg2.y - arg1.y;
            var loc3:*=arg2.z - arg1.z;
            var loc4:*=(-arg1.z) / loc3;
            arg3.x = arg1.x + loc4 * loc1;
            arg3.y = arg1.y + loc4 * loc2;
            return arg3;
        }

        public static function isPointInTriangle(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):Boolean
        {
            var loc1:*=arg4.x - arg2.x;
            var loc2:*=arg4.y - arg2.y;
            var loc3:*=arg3.x - arg2.x;
            var loc4:*=arg3.y - arg2.y;
            var loc5:*=arg1.x - arg2.x;
            var loc6:*=arg1.y - arg2.y;
            var loc7:*=loc1 * loc1 + loc2 * loc2;
            var loc8:*=loc1 * loc3 + loc2 * loc4;
            var loc9:*=loc1 * loc5 + loc2 * loc6;
            var loc10:*=loc3 * loc3 + loc4 * loc4;
            var loc11:*=loc3 * loc5 + loc4 * loc6;
            var loc12:*=1 / (loc7 * loc10 - loc8 * loc8);
            var loc13:*=(loc10 * loc9 - loc8 * loc11) * loc12;
            var loc14:*=(loc7 * loc11 - loc8 * loc9) * loc12;
            return loc13 >= 0 && loc14 >= 0 && loc13 + loc14 < 1;
        }

        public static function normalizeAngle(arg1:Number):Number
        {
            arg1 = arg1 % TWO_PI;
            if (arg1 < -Math.PI) 
            {
                arg1 = arg1 + TWO_PI;
            }
            if (arg1 > Math.PI) 
            {
                arg1 = arg1 - TWO_PI;
            }
            return arg1;
        }

        public static function getNextPowerOfTwo(arg1:Number):int
        {
            var loc1:*=0;
            if (arg1 is int && arg1 > 0 && (arg1 & (arg1 - 1)) == 0) 
            {
                return arg1;
            }
            loc1 = 1;
            arg1 = arg1 - 1e-009;
            while (loc1 < arg1) 
            {
                loc1 = loc1 << 1;
            }
            return loc1;
        }

        public static function isEquivalent(arg1:Number, arg2:Number, arg3:Number=0.0001):Boolean
        {
            return arg1 - arg3 < arg2 && arg1 + arg3 > arg2;
        }

        public static function max(arg1:Number, arg2:Number):Number
        {
            return arg1 > arg2 ? arg1 : arg2;
        }

        public static function min(arg1:Number, arg2:Number):Number
        {
            return arg1 < arg2 ? arg1 : arg2;
        }

        public static function clamp(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return arg1 < arg2 ? arg2 : arg1 > arg3 ? arg3 : arg1;
        }

        internal static const TWO_PI:Number=Math.PI * 2;
    }
}


