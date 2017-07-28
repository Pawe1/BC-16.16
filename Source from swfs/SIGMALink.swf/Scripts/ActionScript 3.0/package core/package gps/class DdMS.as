//class DdMS
package core.gps 
{
    public class DdMS extends Object
    {
        public function DdMS()
        {
            super();
            return;
        }

        public static function decimalDegreesToDegreesMinutesSeconds(arg1:core.gps.LatLon):core.gps.DdMS
        {
            var loc1:*=new DdMS();
            loc1.latitude = arg1.latitude;
            loc1.longitude = arg1.longitude;
            loc1.latDegrees = arg1.latitude;
            loc1.latMinutes = (loc1.latitude - loc1.latDegrees) * 60;
            loc1.latSeconds = (loc1.latitude - loc1.latDegrees - loc1.latMinutes / 60) * 3600;
            loc1.lonDegrees = arg1.longitude;
            loc1.lonMinutes = (loc1.longitude - loc1.lonDegrees) * 60;
            loc1.lonSeconds = (loc1.longitude - loc1.lonDegrees - loc1.lonMinutes / 60) * 3600;
            return loc1;
        }

        public static function degreesMinutesSecondsToDecimalDegrees(arg1:core.gps.DdMS):core.gps.LatLon
        {
            var loc1:*=new core.gps.LatLon();
            loc1.latitude = arg1.latDegrees + arg1.latMinutes / 60 + arg1.latSeconds / 3600;
            loc1.longitude = arg1.lonDegrees + arg1.lonMinutes / 60 + arg1.lonSeconds / 3600;
            return loc1;
        }

        public var latDegrees:Number;

        public var latMinutes:Number;

        public var latSeconds:Number;

        public var latitude:Number;

        public var lonDegrees:Number;

        public var lonMinutes:Number;

        public var lonSeconds:Number;

        public var longitude:Number;

        internal var _point:core.gps.LatLon;
    }
}


