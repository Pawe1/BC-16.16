//class GPSiesHandler
package frontend.screen.tracks.tabs.gpsies 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import backend.utils.gps.*;
    import com.adobe.serialization.json.*;
    import configCache.*;
    import core.gpsies.*;
    import core.route.*;
    import core.route.decode.*;
    import debug.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.sensors.*;
    import frontend.components.map.*;
    import handler.*;
    import starling.events.*;
    import utils.*;
    import utils.dataprovider.*;
    
    public class GPSiesHandler extends starling.events.EventDispatcher
    {
        public function GPSiesHandler()
        {
            super();
            this.tracks = new Vector.<frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult>();
            return;
        }

        internal function onGetTrackDetailsComplete(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target as frontend.screen.tracks.tabs.gpsies.GPSiesURLLoader;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onGetTrackComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onGetTrackDetailsError);
            var loc2:*=com.adobe.serialization.json.JSON.decode(loc1.data as String);
            var loc3:*=new frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult();
            loc3.routeFromJSON(loc2, loc1.route);
            handler.RouteHandler.getInstance().calculateDistances(loc1.route, true);
            this.currentRoute = loc1.route;
            dispatchEventWith(TRACKS_DETAILS_LOADED_COMPLETE);
            return;
        }

        internal function onGetTrackDetailsError(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("onGetTrackDetailsError: " + arg1.text);
            dispatchEventWith(TRACKS_DETAILS_LOAD_ERROR);
            return;
        }

        internal function onGetTrackError(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("onGetTrackError: " + arg1.text);
            dispatchEventWith(TRACKS_DETAILS_LOAD_ERROR);
            return;
        }

        internal function onSecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            debug.Debug.error("onSecurityError: " + arg1.text);
            dispatchEventWith(TRACKS_DETAILS_LOAD_ERROR);
            return;
        }

        internal function generateSearchURL(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Boolean=false):String
        {
            var loc1:*=core.gpsies.CommonGPSiesHandler.SIGMA_URL + "/json.do?key=" + core.gpsies.CommonGPSiesHandler.API_KEY;
            loc1 = loc1 + (arg3 ? "&method=countTracksBbox" : "&method=listTracksBbox&countTracks=false");
            loc1 = loc1 + ("&BBOX=" + arg1.x + "," + arg1.y + "," + arg2.x + "," + arg2.y);
            var loc2:*=configCache.ConfigCache.getInstance().getValue(SPORT, this.defaultSport);
            var loc3:*=utils.dataprovider.CommonRouteOptionsDataProvider.resolveSportParam(loc2);
            loc1 = loc1 + ("&trackTypes=" + loc3);
            var loc4:*=configCache.ConfigCache.getInstance().getValue(TYPE, this.defaultType);
            if (loc4 != 0) 
            {
                loc1 = loc1 + ("&property=" + loc4);
            }
            var loc5:*=int(configCache.ConfigCache.getInstance().getValue(MAX_DISTANCE, this.defaultMaxDistance) / 1000);
            if (loc5 > 0) 
            {
                loc1 = loc1 + ("&maxLength=" + loc5);
            }
            return loc1;
        }

        internal function generateTrackDetailsURL(arg1:String, arg2:Boolean):String
        {
            var loc1:*=core.gpsies.CommonGPSiesHandler.SIGMA_URL + "/json.do?key=" + core.gpsies.CommonGPSiesHandler.API_KEY + "&method=trackDetail" + "&expandResult=true" + "&trackData=" + (arg2 ? "true" : "false") + "&fileId=" + arg1;
            return loc1;
        }

        public function validateInfoText():String
        {
            var loc3:*=null;
            var loc1:*="";
            var loc2:*=frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.length;
            if (flash.sensors.Geolocation.isSupported) 
            {
                if (backend.utils.gps.GeoLocationHelper.getInstance().geo && backend.utils.gps.GeoLocationHelper.getInstance().geo.muted) 
                {
                    loc1 = utils.LanguageManager.getString("PLEASE_ENABLE_GPS");
                }
                else if (loc2 != 0) 
                {
                    if (loc2 != 1) 
                    {
                        loc3 = utils.LanguageManager.getString("GPSIES_SEARCH_RESULTS");
                    }
                    else 
                    {
                        loc3 = utils.LanguageManager.getString("GPSIES_SEARCH_RESULT");
                    }
                    loc1 = loc3.replace("###num", loc2);
                }
                else if (this.startInitialSearch) 
                {
                    loc1 = utils.LanguageManager.getString("GPSIES_SEARCHING");
                }
                else 
                {
                    loc1 = utils.LanguageManager.getString("GPSIES_SEARCH_NO_RESULT");
                }
            }
            else 
            {
                loc1 = utils.LanguageManager.getString("GPSIES_SEARCH_NO_GPS_SUPPORTED");
            }
            debug.Debug.debug(loc1);
            return loc1;
        }

        public static function getInstance():frontend.screen.tracks.tabs.gpsies.GPSiesHandler
        {
            if (!_instance) 
            {
                _instance = new GPSiesHandler();
            }
            return _instance;
        }

        internal function logInfo(arg1:String):void
        {
            if (this.infoCallback != null) 
            {
                this.infoCallback(arg1);
            }
            return;
        }

        public function searchTracks():void
        {
            var loc1:*=configCache.ConfigCache.getInstance().getValue(RADIUS, this.defaultRadius);
            var loc2:*=loc1 / 1000;
            var loc3:*=frontend.components.map.GeoUtils.lonAtDistanceDeg(backend.utils.gps.GeoLocationHelper.getInstance().currentLon, backend.utils.gps.GeoLocationHelper.getInstance().currentLat, -loc1);
            var loc4:*=frontend.components.map.GeoUtils.lonAtDistanceDeg(backend.utils.gps.GeoLocationHelper.getInstance().currentLon, backend.utils.gps.GeoLocationHelper.getInstance().currentLat, loc1);
            var loc5:*=frontend.components.map.GeoUtils.latAtDistanceDeg(backend.utils.gps.GeoLocationHelper.getInstance().currentLat, loc1);
            var loc6:*=frontend.components.map.GeoUtils.latAtDistanceDeg(backend.utils.gps.GeoLocationHelper.getInstance().currentLat, -loc1);
            var loc7:*=new flash.geom.Point(loc3, loc5);
            var loc8:*=new flash.geom.Point(loc4, loc6);
            var loc9:*=this.generateSearchURL(loc7, loc8, false);
            var loc10:*=new flash.net.URLRequest(loc9);
            this.tracks = new Vector.<frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult>();
            var loc11:*=new frontend.screen.tracks.tabs.gpsies.GPSiesURLLoader();
            loc11.addEventListener(flash.events.Event.COMPLETE, this.onSearchTracksComplete);
            loc11.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSearchTracksIOError);
            loc11.load(loc10);
            return;
        }

        internal function onSearchTracksComplete(arg1:flash.events.Event):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=arg1.target as frontend.screen.tracks.tabs.gpsies.GPSiesURLLoader;
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSearchTracksIOError);
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onSearchTracksComplete);
            var loc2:*=com.adobe.serialization.json.JSON.decode(loc1.data as String);
            var loc3:*=configCache.ConfigCache.getInstance().getValue(RADIUS, this.defaultRadius);
            var loc6:*=0;
            var loc7:*=loc2.data.tracks;
            for each (loc4 in loc7) 
            {
                loc5 = new frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult();
                loc5.headerFromJSON(loc4);
                loc5.distanceToTrack = frontend.components.map.GeoUtils.distanceDeg(backend.utils.gps.GeoLocationHelper.getInstance().currentLon, backend.utils.gps.GeoLocationHelper.getInstance().currentLat, loc5.startPoint.x, loc5.startPoint.y);
                if (loc5.distanceToTrack > loc3) 
                {
                    continue;
                }
                loc5.distanceToTrackFormatted = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc5.distanceToTrack));
                this.tracks.push(loc5);
            }
            dispatchEventWith(TRACKS_LOADED_COMPLETE);
            return;
        }

        internal function onSearchTracksIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=arg1.target as frontend.screen.tracks.tabs.gpsies.GPSiesURLLoader;
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSearchTracksIOError);
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onSearchTracksComplete);
            dispatchEventWith(TRACKS_LOAD_ERROR);
            return;
        }

        public function loadTrackAsKMZ(arg1:core.route.Route):void
        {
            var loc1:*=arg1.webPortalId.charAt(0);
            var loc2:*=new frontend.screen.tracks.tabs.gpsies.GPSiesURLStream();
            loc2.route = arg1;
            loc2.addEventListener(flash.events.Event.COMPLETE, this.onGetTrackComplete);
            loc2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onGetTrackError);
            loc2.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            loc2.load(new flash.net.URLRequest(core.gpsies.CommonGPSiesHandler.GPSIES_URL + "/files/kmz/" + loc1 + "/" + arg1.webPortalId + ".kmz"));
            return;
        }

        public function onGetTrackComplete(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target as frontend.screen.tracks.tabs.gpsies.GPSiesURLStream;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onGetTrackComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onGetTrackError);
            loc1.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            var loc2:*=core.route.decode.KMZDecoder.decodeRoute(loc1);
            loc1.route.routePoints = loc2.routePoints;
            if (loc1.route.routePoints.length > 0) 
            {
                loc1.route.latitudeStart = loc1.route.routePoints[0].latitude;
                loc1.route.longitudeStart = loc1.route.routePoints[0].longitude;
                loc1.route.latitudeEnd = loc1.route.routePoints[(loc1.route.routePoints.length - 1)].latitude;
                loc1.route.longitudeEnd = loc1.route.routePoints[(loc1.route.routePoints.length - 1)].longitude;
            }
            this.loadTrackDetailsAsJSON(loc1.route, false);
            return;
        }

        internal function loadTrackDetailsAsJSON(arg1:core.route.Route, arg2:Boolean=false):void
        {
            var loc1:*=new frontend.screen.tracks.tabs.gpsies.GPSiesURLLoader();
            loc1.route = arg1;
            loc1.addEventListener(flash.events.Event.COMPLETE, this.onGetTrackDetailsComplete);
            loc1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onGetTrackDetailsError);
            loc1.load(new flash.net.URLRequest(this.generateTrackDetailsURL(arg1.webPortalId, arg2)));
            return;
        }

        public static const RADIUS:String="gpsies_search_radius_flag";

        public static const SPORT:String="gpsies_search_sport_flag";

        public static const TRACKS_DETAILS_LOADED_COMPLETE:String="tracksDetailsLoadedCompleteEvent";

        public static const TRACKS_DETAILS_LOAD_ERROR:String="tracksDetailsLoadErrorEvent";

        public static const TRACKS_LOADED_COMPLETE:String="tracksLoadedCompleteEvent";

        public static const TRACKS_LOAD_ERROR:String="tracksLoadErrorEvent";

        public static const TYPE:String="gpsies_search_type_flag";

        public static const MAX_DISTANCE:String="gpsies_search_max_distance_flag";

        public var currentRoute:core.route.Route;

        public var defaultMaxDistance:Number=35000;

        public var defaultRadius:Number=5000;

        public var defaultSport:int=3;

        public var defaultType:int=0;

        public var infoCallback:Function;

        public var startInitialSearch:Boolean=true;

        public var tracks:__AS3__.vec.Vector.<frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult>;

        internal static var _instance:frontend.screen.tracks.tabs.gpsies.GPSiesHandler;
    }
}


