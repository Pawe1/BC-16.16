//class PolylineUtil
package utils 
{
    import __AS3__.vec.*;
    import core.gps.*;
    import core.route.*;
    
    public class PolylineUtil extends Object
    {
        public function PolylineUtil()
        {
            super();
            return;
        }

        internal function encodePoly(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>):void
        {
            this.longlat = arg1;
            return;
        }

        public function getStartEntryBearing():Number
        {
            if (startEntryBearingLatLongStart && startEntryBearingLatLongEnd) 
            {
                startEntryBearing = new core.gps.LatLonHelper(startEntryBearingLatLongStart, startEntryBearingLatLongEnd).angle();
            }
            return startEntryBearing;
        }

        public function decodePoly(arg1:String):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc2:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc11:*=0;
            var loc6:*=null;
            this.encoded = arg1;
            this.longlat = new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc8:*=0;
            var loc3:*=this.encoded.length;
            var loc10:*=0;
            var loc4:*=0;
            var loc7:*=0;
            var loc9:*=0;
        }

        internal const START_ENTRY_BEARING_POINT_END:uint=5;

        internal const START_ENTRY_BEARING_POINT_START:uint=1;

        public static const PRECISION_5:uint=10000;

        public static const PRECISION_6:uint=100000;

        public var encoded:String;

        public var longlat:__AS3__.vec.Vector.<core.route.RoutePoint>;

        internal var _precision:uint=100000;

        internal var startEntryBearing:Number;

        internal var startEntryBearingLatLongEnd:core.route.RoutePoint;

        internal var startEntryBearingLatLongStart:core.route.RoutePoint;
    }
}


