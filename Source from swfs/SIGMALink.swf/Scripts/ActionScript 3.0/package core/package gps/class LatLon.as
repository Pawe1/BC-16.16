//class LatLon
package core.gps 
{
    import core.route.interfaces.*;
    
    public class LatLon extends Object implements core.route.interfaces.ILatLon
    {
        public function LatLon()
        {
            super();
            return;
        }

        public function get latitude():Number
        {
            return _latitude;
        }

        public function set latitude(arg1:Number):void
        {
            _latitude = arg1;
            return;
        }

        public function get longitude():Number
        {
            return _longitude;
        }

        public function set longitude(arg1:Number):void
        {
            _longitude = arg1;
            return;
        }

        public function equalsRoutePoint(arg1:core.route.interfaces.ILatLon):Boolean
        {
            if (arg1 == null) 
            {
                return false;
            }
            return this.latitude == arg1.latitude && this.longitude == arg1.longitude;
        }

        public function getLatDdMmmmmm():core.gps.DdMmmmmm
        {
            return core.gps.DdMmmmmm.fromLatLon(latitude, 2);
        }

        public function getLonDdMmmmmm():core.gps.DdMmmmmm
        {
            return core.gps.DdMmmmmm.fromLatLon(longitude, 1);
        }

        public function getDegreesToDegreesMinutesSeconds():core.gps.DdMS
        {
            return core.gps.DdMS.decimalDegreesToDegreesMinutesSeconds(this);
        }

        public function setDegreesFromDegreesMinutesSeconds(arg1:core.gps.DdMS):void
        {
            var loc1:*=core.gps.DdMS.degreesMinutesSecondsToDecimalDegrees(arg1);
            latitude = loc1.latitude;
            longitude = loc1.longitude;
            return;
        }

        internal var _latitude:Number;

        internal var _longitude:Number;
    }
}


