//class CommonGPSiesHandler
package core.gpsies 
{
    import flash.events.*;
    
    public class CommonGPSiesHandler extends flash.events.EventDispatcher
    {
        public function CommonGPSiesHandler()
        {
            super();
            return;
        }

        public static const API_KEY:String="vegaxoqloioztexx";

        public static const GPSIES_URL:String="https://www.gpsies.com";

        public static const ROUTE_POINTS_DECODED:String="routePointsDecoded";

        public static const SIGMA_URL:String="https://gpsies.sigma-dc-control.com";
    }
}


