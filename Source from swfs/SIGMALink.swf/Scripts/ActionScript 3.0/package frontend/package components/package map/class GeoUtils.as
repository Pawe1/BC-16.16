//class GeoUtils
package frontend.components.map 
{
    import flash.geom.*;
    
    public class GeoUtils extends Object
    {
        public function GeoUtils()
        {
            super();
            return;
        }

        public static function x2lon(arg1:Number):Number
        {
            return arg1 * C_LONGITUDE - 180;
        }

        public static function lon2x(arg1:Number):Number
        {
            return (arg1 + 180) / C_LONGITUDE;
        }

        public static function y2lat(arg1:Number):Number
        {
            return Math.atan(sinh(PI - C_LATITUDE * arg1)) * RAD_DEG;
        }

        public static function lat2y(arg1:Number):Number
        {
            var loc1:*=arg1 * DEG_RAD;
            return (1 - Math.log(Math.tan(loc1) + 1 / Math.cos(loc1)) / PI) * C_LATITUDE2;
        }

        public static function sinh(arg1:Number):Number
        {
            return (Math.exp(arg1) - Math.exp(-arg1)) / 2;
        }

        public static function distance(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=Math.cos(arg2) * Math.cos(arg4) * Math.cos(arg3 - arg1) + Math.sin(arg2) * Math.sin(arg4);
            return loc1 > 1 ? 0 : EARTH_RADIUS * Math.acos(loc1);
        }

        public static function distanceDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return distance(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4 * DEG_RAD);
        }

        public static function destination(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=arg4 / EARTH_RADIUS;
            var loc2:*=Math.asin(Math.sin(arg2) * Math.cos(loc1) + Math.cos(arg2) * Math.sin(loc1) * Math.cos(arg3));
            var loc3:*=arg1 + Math.atan2(Math.sin(arg3) * Math.sin(loc1) * Math.cos(arg2), Math.cos(loc1) - Math.sin(arg2) * Math.sin(loc2));
            return new flash.geom.Point(loc3, loc2);
        }

        public static function destionationDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=destination(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4);
            loc1.x = loc1.x * RAD_DEG;
            loc1.y = loc1.y * RAD_DEG;
            return loc1;
        }

        public static function lonAtDistanceDeg(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return destionationDeg(arg1, arg2, 90, arg3).x;
        }

        public static function latAtDistanceDeg(arg1:Number, arg2:Number):Number
        {
            arg1 = arg1 * DEG_RAD;
            var loc1:*=arg2 / EARTH_RADIUS;
            return Math.asin(Math.sin(arg1) * Math.cos(loc1) + Math.cos(arg1) * Math.sin(loc1)) * RAD_DEG;
        }

        public static function pixelsPerMeter(arg1:Number):Number
        {
            var loc1:*=lat2y(arg1) - lat2y(Math.asin(Math.sin(arg1 * DEG_RAD) * COS_1_EARTH_RADIUS + Math.cos(arg1 * DEG_RAD) * SIN_1_EARTH_RADIUS) * RAD_DEG);
            return loc1 < 0 ? -loc1 : loc1;
        }

        public static function pixelPerMeterByCenter(arg1:flash.geom.Point):Number
        {
            return pixelsPerMeter(y2lat(arg1.y));
        }

        public static function pixelsPerMeterPrecise(arg1:Number, arg2:Number):Number
        {
            var loc1:*=destionationDeg(arg1, arg2, 45, 1);
            var loc2:*=lon2x(arg1) - lon2x(loc1.x);
            var loc3:*=lat2y(arg2) - lat2y(loc1.y);
            return Math.sqrt(loc2 * loc2 + loc3 * loc3);
        }

        public static const DEG_RAD:Number=PI / 180;

        public static const EARTH_RADIUS:uint=6371000;

        public static const MAX_LATITUDE:uint=67108864;

        public static const MAX_LONGITUDE:uint=67108864;

        public static const RAD_DEG:Number=180 / PI;

        internal static const COS_1_EARTH_RADIUS:Number=Math.cos(1 / EARTH_RADIUS);

        internal static const C_LATITUDE:Number=2 * PI / MAX_LATITUDE;

        internal static const C_LATITUDE2:Number=MAX_LATITUDE / 2;

        internal static const C_LONGITUDE:Number=360 / MAX_LONGITUDE;

        internal static const PI:Number=Math.PI;

        internal static const SIN_1_EARTH_RADIUS:Number=Math.sin(1 / EARTH_RADIUS);
    }
}


