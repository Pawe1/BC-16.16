//class DdMmmmmm
package core.gps 
{
    public class DdMmmmmm extends Object
    {
        public function DdMmmmmm(arg1:uint=0, arg2:Number=0, arg3:uint=0)
        {
            super();
            degree = arg1;
            minutes = arg2;
            direction = arg3;
            return;
        }

        public function toLatLon():Number
        {
            var loc1:*=degree + minutes / 60;
        }

        public static function fromLatLon(arg1:Number, arg2:uint):core.gps.DdMmmmmm
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc2:*=NaN;
            var loc1:*=0;
            if (arg2 == 1 || arg2 == 2) 
            {
                loc4 = arg1;
                loc2 = (arg1 - loc4) * 1000000 * 0.6;
            }
            return loc3;
        }

        public static const DIRECTION_EAST:uint=1;

        public static const DIRECTION_NORTH:uint=0;

        public static const DIRECTION_SOUTH:uint=2;

        public static const DIRECTION_WEST:uint=3;

        public static const TYPE_LATITUDE:uint=2;

        public static const TYPE_LONGITUDE:uint=1;

        public var degree:uint;

        public var direction:uint;

        public var minutes:Number;
    }
}


