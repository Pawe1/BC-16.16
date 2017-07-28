//class MapSearchEngine
package service.openstreetmap 
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import debug.*;
    import flash.events.*;
    import flash.net.*;
    
    public class MapSearchEngine extends flash.events.EventDispatcher
    {
        public function MapSearchEngine()
        {
            super();
            return;
        }

        public function search(arg1:String):void
        {
            var loc1:*=new flash.net.URLRequest(buildSearchRequest(arg1));
            startSearch(loc1);
            return;
        }

        public function searchReverse(arg1:Number, arg2:Number):void
        {
            var loc1:*=new flash.net.URLRequest(buildSearchReverseRequest(arg1, arg2));
            startSearch(loc1);
            return;
        }

        internal function startSearch(arg1:flash.net.URLRequest):void
        {
            var loc1:*=new service.openstreetmap.MapSearchURLLoader();
            loc1.addEventListener("complete", onSearchComplete);
            loc1.addEventListener("ioError", onSearchIOError);
            loc1.load(arg1);
            return;
        }

        internal function buildSearchRequest(arg1:String):String
        {
            var loc1:*="https://nominatim.openstreetmap.org/search?";
            loc1 = loc1 + ("q=" + arg1);
            loc1 = loc1 + "&format=json";
            loc1 = loc1 + "&polygon_geojson=1";
            loc1 = loc1 + "&bounded=0";
            loc1 = loc1 + "&addressdetails=1";
            debug.Debug.debug("buildSearchRequest: " + loc1);
            return loc1;
        }

        internal function buildSearchReverseRequest(arg1:Number, arg2:Number):String
        {
            var loc1:*="https://nominatim.openstreetmap.org/reverse.php?";
            loc1 = loc1 + "&format=json";
            loc1 = loc1 + ("&lat=" + arg1.toString());
            loc1 = loc1 + ("&lon=" + arg2.toString());
            loc1 = loc1 + "&zoom=16";
            debug.Debug.debug("buildSearchReverseRequest: " + loc1);
            return loc1;
        }

        internal function onSearchComplete(arg1:flash.events.Event):void
        {
            var loc4:*;
            (loc4 = arg1.target as service.openstreetmap.MapSearchURLLoader).removeEventListener("ioError", onSearchIOError);
            loc4.removeEventListener("complete", onSearchComplete);
            var loc1:*=com.adobe.serialization.json.JSON.decode(loc4.data as String);
            var loc3:*=new __AS3__.vec.Vector.<service.openstreetmap.MapSearchResult>();
            if (loc1 is Array) 
            {
                var loc6:*=0;
                var loc5:*=loc1;
                for each (var loc2:* in loc5) 
                {
                    loc3.push(mapResultFromObject(loc2));
                }
                dispatchEvent(new service.openstreetmap.MapSearchEvent("searchResult", false, loc3));
            }
            else 
            {
                loc3.push(mapResultFromObject(loc1));
                dispatchEvent(new service.openstreetmap.MapSearchEvent("searchReverseResult", false, loc3));
            }
            return;
        }

        internal function mapResultFromObject(arg1:Object):service.openstreetmap.MapSearchResult
        {
            var loc1:*=new service.openstreetmap.MapSearchResult();
            loc1.latitude = arg1.lat;
            loc1.longitude = arg1.lon;
            loc1.formattedAddress = "";
            var loc2:*=arg1.address;
            if (arg1.hasOwnProperty("display_name")) 
            {
                loc1.formattedAddress = arg1.display_name;
            }
            if (loc2.hasOwnProperty("road")) 
            {
                loc1.road = loc2.road;
            }
            if (loc2.hasOwnProperty("house_number")) 
            {
                loc1.houseNumber = loc2.house_number;
            }
            if (loc2.hasOwnProperty("postcode")) 
            {
                loc1.postalCode = loc2.postcode;
            }
            if (loc2.hasOwnProperty("village")) 
            {
                loc1.village = loc2.village;
            }
            if (loc2.hasOwnProperty("town")) 
            {
                loc1.town = loc2.town;
            }
            if (loc2.hasOwnProperty("city")) 
            {
                loc1.city = loc2.city;
            }
            if (loc2.hasOwnProperty("state")) 
            {
                loc1.state = loc2.state;
            }
            if (loc2.hasOwnProperty("country")) 
            {
                loc1.country = loc2.country;
            }
            return loc1;
        }

        internal function onSearchIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=arg1.target as service.openstreetmap.MapSearchURLLoader;
            loc1.removeEventListener("ioError", onSearchIOError);
            loc1.removeEventListener("complete", onSearchComplete);
            dispatchEvent(new service.openstreetmap.MapSearchEvent("searchError"));
            return;
        }

        internal static const BASE_SEARCH_URL:String="https://nominatim.openstreetmap.org/search?";

        internal static const REVERSE_SEARCH_URL:String="https://nominatim.openstreetmap.org/reverse.php?";
    }
}


