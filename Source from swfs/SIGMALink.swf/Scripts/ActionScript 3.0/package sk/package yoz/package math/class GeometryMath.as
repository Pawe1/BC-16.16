//class GeometryMath
package sk.yoz.math 
{
    import flash.geom.*;
    
    public class GeometryMath extends Object
    {
        public function GeometryMath()
        {
            super();
            return;
        }

        public static function degreesToRadians(arg1:Number):Number
        {
            return arg1 * 0.0174532925199;
        }

        public static function radiansToDegrees(arg1:Number):Number
        {
            return arg1 * 57.2957795131;
        }

        public static function isLine(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:Boolean=true):Boolean
        {
            var loc2:*=arg1.x - arg2.x;
            var loc4:*=arg2.x - arg3.x;
            var loc1:*=arg1.y - arg2.y;
            var loc3:*=arg2.y - arg3.y;
            if (arg4 && (loc2 > 0 && loc4 < 0 || loc2 < 0 && loc4 > 0 || loc1 < 0 && loc3 > 0 || loc1 < 0 && loc3 > 0)) 
            {
                return false;
            }
            if (!loc3) 
            {
                return !loc1;
            }
            if (!loc4) 
            {
                return !loc2;
            }
            return loc2 / loc4 == loc1 / loc3;
        }

        public static function rotatePoint(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            return rotatePointByRadians(arg1, arg2, arg3 * 0.0174532925199);
        }

        public static function rotatePointByRadians(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            var loc1:*=arg1.x - arg2.x;
            var loc4:*=arg1.y - arg2.y;
            var loc2:*=Math.sqrt(loc1 * loc1 + loc4 * loc4);
            var loc3:*=arg3 + Math.atan2(loc1, -loc4);
            return new flash.geom.Point(Math.sin(loc3) * loc2 + arg2.x, (-Math.cos(loc3)) * loc2 + arg2.y);
        }

        public static function angleOf3Points(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc1:*=Math.sqrt((arg1 - arg3) * (arg1 - arg3) + (arg2 - arg4) * (arg2 - arg4));
            var loc2:*=Math.sqrt((arg3 - arg5) * (arg3 - arg5) + (arg4 - arg6) * (arg4 - arg6));
            var loc3:*=Math.sqrt((arg5 - arg1) * (arg5 - arg1) + (arg6 - arg2) * (arg6 - arg2));
            return Math.acos((loc1 * loc1 + loc3 * loc3 - loc2 * loc2) / (2 * loc1 * loc3));
        }

        public static const TO_RADIANS:Number=0.0174532925199;

        public static const TO_DEGREEES:Number=57.2957795131;
    }
}


