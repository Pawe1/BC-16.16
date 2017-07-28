//package gps
//  class GeoLocationHelper
package backend.utils.gps 
{
    import debug.*;
    import flash.events.*;
    import flash.sensors.*;
    import flash.system.*;
    import starling.events.*;
    
    public class GeoLocationHelper extends starling.events.EventDispatcher
    {
        public function GeoLocationHelper()
        {
            super();
            return;
        }

        public function updateGPSPosition():void
        {
            if (!flash.sensors.Geolocation.isSupported && !flash.system.Capabilities.isDebugger) 
            {
                dispatchEventWith(GPS_DISABLED);
                return;
            }
            if (!this.geo) 
            {
                this.geo = new flash.sensors.Geolocation();
                this.geo.addEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            }
            this.validateGeoStatus();
            return;
        }

        internal function onGeoStatusChanged(arg1:flash.events.StatusEvent):void
        {
            this.validateGeoStatus();
            return;
        }

        internal function validateGeoStatus():void
        {
            debug.Debug.debug("validateGeoStatus...");
            if (this.geo.muted) 
            {
                dispatchEventWith(GPS_DISABLED);
            }
            else 
            {
                dispatchEventWith(GPS_ENABLED);
                this.geo.addEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            }
            return;
        }

        protected function geoUpdateHandler(arg1:flash.events.GeolocationEvent):void
        {
            this.currentLon = arg1.longitude;
            this.currentLat = arg1.latitude;
            this.geo.removeEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            this.geo.removeEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            this.geo = null;
            dispatchEventWith(LOCATION_CHANGED);
            return;
        }

        public static function getInstance():backend.utils.gps.GeoLocationHelper
        {
            if (!_instance) 
            {
                _instance = new GeoLocationHelper();
            }
            return _instance;
        }

        public static const GPS_DISABLED:String="gpsDisabledEvent";

        public static const GPS_ENABLED:String="gpsEnabledEvent";

        public static const LOCATION_CHANGED:String="locationChangedEvent";

        public var currentLat:Number=49.45981581;

        public var currentLon:Number=8.16105242;

        public var geo:flash.sensors.Geolocation;

        internal static var _instance:backend.utils.gps.GeoLocationHelper;
    }
}


