//class GPSiesURLLoader
package frontend.screen.tracks.tabs.gpsies 
{
    import core.route.*;
    import flash.net.*;
    
    public class GPSiesURLLoader extends flash.net.URLLoader
    {
        public function GPSiesURLLoader(arg1:flash.net.URLRequest=null)
        {
            super(arg1);
            return;
        }

        public var repeatRequestOnError:int=5;

        public var route:core.route.Route;
    }
}


