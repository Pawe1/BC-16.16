//class LatLonHelper
package core.gps 
{
    import avmplus.*;
    import core.route.interfaces.*;
    import flash.errors.*;
    
    public class LatLonHelper extends Object
    {
        public function LatLonHelper(arg1:core.route.interfaces.ILatLon, arg2:core.route.interfaces.ILatLon)
        {
            super();
            if (arg1 == null || arg2 == null) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Start- and End- Latitude and Longitude must not be empty :: " + avmplus.getQualifiedClassName(this));
            }
            _fromLatLong = arg1;
            _toLatLong = arg2;
            init();
            return;
        }

        internal function init():void
        {
            var loc4:*=_fromLatLong.latitude;
            var loc1:*=_toLatLong.latitude;
            var loc6:*=_fromLatLong.longitude;
            var loc8:*=_toLatLong.longitude;
            var loc2:*=angle2rad(90 - loc4);
            var loc3:*=angle2rad(90 - loc1);
            var loc11:*=angle2rad(Math.abs(loc8 - loc6));
            var loc5:*=Math.acos(Math.cos(loc2) * Math.cos(loc3) + Math.sin(loc2) * Math.sin(loc3) * Math.cos(loc11));
            var loc9:*=0;
            var loc12:*=0;
            loc9 = Math.acos((Math.cos(loc2) - Math.cos(loc3) * Math.cos(loc5)) / (Math.sin(loc5) * Math.sin(loc3)));
            loc12 = Math.acos((Math.cos(loc3) - Math.cos(loc5) * Math.cos(loc2)) / (Math.sin(loc5) * Math.sin(loc2)));
            var loc7:*=0 == loc12 ? 0 : 360 - rad2angle(loc12);
            var loc10:*=rad2angle(loc9);
            if (loc8 - loc6 > 0 || loc8 == loc6 && loc4 > loc1) 
            {
                loc7 = 360 - loc7;
                loc10 = 360 - loc10;
            }
            loc7 = Math.round(100 * loc7) / 100;
            loc10 = Math.round(100 * loc10) / 100;
            _startEntryBearing = loc7;
            return;
        }

        public function angle():Number
        {
            return _startEntryBearing;
        }

        internal function rad2angle(arg1:Number):Number
        {
            return 57.2957795131 * arg1;
        }

        internal function angle2rad(arg1:Number):Number
        {
            return 0.0174532925199 * arg1;
        }

        internal const EARTHPLATTUNG:Number=0.00335281066475;

        internal const M_PI:Number=3.14159265359;

        internal const NMFACTOR:Number=1.852216;

        internal const R_EARTH:Number=6371000.785;

        internal var _A:Number;

        internal var _a:Number;

        internal var _alpha:Number;

        internal var _b:Number;

        internal var _beta:Number;

        internal var _c:Number;

        internal var _e:Number;

        internal var _earthRadiusNm:Number=3439664.04836;

        internal var _fromLatLong:core.route.interfaces.ILatLon;

        internal var _gamma:Number;

        internal var _ka:Number;

        internal var _kb:Number;

        internal var _kc:Number;

        internal var _s:Number;

        internal var _ss:Number;

        internal var _startEntryBearing:uint=0;

        internal var _toLatLong:core.route.interfaces.ILatLon;
    }
}


