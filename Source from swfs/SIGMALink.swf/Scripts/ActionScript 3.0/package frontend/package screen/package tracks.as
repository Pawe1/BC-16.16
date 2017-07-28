//package tracks
//  package tabs
//    package gpsies
//      class GPSiesHandler
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


//      class GPSiesSearch
package frontend.screen.tracks.tabs.gpsies 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.gps.*;
    import configCache.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class GPSiesSearch extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function GPSiesSearch()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._GPSiesSearch_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GPSiesSearch[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._GPSiesSearch_CustomVScrollContainer1_i(), this._GPSiesSearch_Footer1_i()];
            this.addEventListener("addedToStage", this.___GPSiesSearch_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___GPSiesSearch_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___GPSiesSearch_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set list(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        public function set movie(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._104087344movie;
            if (loc1 !== arg1) 
            {
                this._104087344movie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "movie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get searchButton():feathers.controls.Button
        {
            return this._365389062searchButton;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSEnabled);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().updateGPSPosition();
            return;
        }

        public function set searchButton(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._365389062searchButton;
            if (loc1 !== arg1) 
            {
                this._365389062searchButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "searchButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loading():Boolean
        {
            return this._336650556loading;
        }

        public function set loading(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._336650556loading;
            if (loc1 !== arg1) 
            {
                this._336650556loading = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loading", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _gpsiesInfo():String
        {
            return this._2009185754_gpsiesInfo;
        }

        internal function set _gpsiesInfo(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2009185754_gpsiesInfo;
            if (loc1 !== arg1) 
            {
                this._2009185754_gpsiesInfo = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_gpsiesInfo", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            (this.scroller.layout as feathers.layout.VerticalLayout).gap = 20 * SIGMALink.scaleFactor;
            (this.scroller.layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().infoCallback = this.gpsiesInfoCallback;
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            GPSiesSearch._watcherSetupUtil = arg1;
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSEnabled);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            return;
        }

        internal function onGPSDisabled(arg1:starling.events.Event):void
        {
            this.searchButton.visible = helper.Capabilities_helper.isSimulator() ? true : false;
            return;
        }

        internal function onGPSEnabled(arg1:starling.events.Event):void
        {
            this.searchButton.visible = true;
            return;
        }

        internal function onGPSLocationChanged(arg1:starling.events.Event):void
        {
            this.searchButton.isEnabled = true;
            return;
        }

        protected override function validateProperties():void
        {
            var loc6:*=0;
            var loc9:*=null;
            this.list.removeChildren();
            var loc1:*=new frontend.components.menuList.MenuListItem();
            var loc10:*;
            loc1.text = loc10 = "GPSIES_SEARCH_RADIUS";
            loc1.title = loc10;
            loc1.editable = true;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.useConfigCache = true;
            loc1.unitString = backend.utils.DataUtils.unitStringDistance;
            loc1.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.RADIUS;
            loc1.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.RADIUS, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultRadius);
            loc1.formatter = backend.utils.DataUtils.distanceFormatter;
            loc1.converter = backend.utils.DataUtils.distanceConverter;
            loc1.minimum = 0;
            loc1.maximum = this._maximumRadius;
            this.list.addChild(loc1);
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.text = loc10 = "GPSIES_SEARCH_TYPE";
            loc2.title = loc10;
            loc2.editable = true;
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
            loc2.dataProvider = backend.utils.dataprovider.RouteOptionsDataProvider.getTypeDataProvider();
            loc2.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TYPE, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultType);
            loc2.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TYPE;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.useConfigCache = true;
            this.list.addChild(loc2);
            var loc3:*=new frontend.components.menuList.MenuListItem();
            loc3.text = loc10 = "GPSIES_SEARCH_MAX_DISTANZ";
            loc3.title = loc10;
            loc3.editable = true;
            loc3.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc3.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc3.useConfigCache = true;
            loc3.unitString = backend.utils.DataUtils.unitStringDistance;
            loc3.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.MAX_DISTANCE, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultMaxDistance);
            loc3.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.MAX_DISTANCE;
            loc3.formatter = backend.utils.DataUtils.distanceFormatter;
            loc3.converter = backend.utils.DataUtils.distanceConverter;
            loc3.minimum = 0;
            loc3.maximum = this._maximumMaxDistance;
            this.list.addChild(loc3);
            var loc4:*=backend.utils.dataprovider.RouteOptionsDataProvider.getSuitableDataProvider();
            var loc5:*=configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultSport);
            var loc7:*=loc4.length;
            var loc8:*=new feathers.data.ListCollection();
            loc6 = 0;
            while (loc6 < loc7) 
            {
                if (loc4.getItemAt(loc6).selectable) 
                {
                    loc9 = handler.SportHandler.getInstance().resolveSportById(loc4.getItemAt(loc6).sportId);
                    loc8.push({"label":loc9.name, "data":loc9.sportId, "param":loc4.getItemAt(loc6).param, "selected":loc4.getItemAt(loc6).sportId == loc5});
                }
                ++loc6;
            }
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.text = loc10 = "GPSIES_SEARCH_SUITABLE";
            this.sportsItem.title = loc10;
            this.sportsItem.editable = true;
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT;
            this.sportsItem.dataProvider = loc8;
            this.sportsItem.defaultValue = loc5;
            this.sportsItem.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this.sportsItem.saveCompleteCallback = this.onSuitableItemChanged;
            this.sportsItem.useConfigCache = true;
            this.list.addChild(this.sportsItem);
            this.validateSportsItem();
            return;
        }

        internal function gpsiesInfoCallback(arg1:String):void
        {
            this._gpsiesInfo = arg1;
            return;
        }

        internal function onSuitableItemChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.validateSportsItem();
            return;
        }

        internal function validateSportsItem():void
        {
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 1;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc3:*=new frontend.components.SportIcon();
            loc3.sportId = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultSport);
            this.sportsItem.customLayoutContent.addChild(loc3);
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.startLoading();
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().searchTracks();
            return;
        }

        internal function onTracksLoadedComplete(arg1:starling.events.Event):void
        {
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            this._gpsiesInfo = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            this.stopLoading();
            if (frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.length > 0) 
            {
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        internal function onTracksLoadError(arg1:starling.events.Event):void
        {
            this.stopLoading();
            this._gpsiesInfo = utils.LanguageManager.getString("GPSIES_SEARCH_ERROR");
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            debug.Debug.error("GPSiesSearch > onTracksLoadError");
            return;
        }

        public function startLoading():void
        {
            this.searchButton.isEnabled = false;
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.movie.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
                this.movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0);
                this.loading = true;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            this.searchButton.isEnabled = true;
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
            }
            this.movie.removeChildren();
            return;
        }

        internal function _GPSiesSearch_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._GPSiesSearch_MenuList1_i(), this._GPSiesSearch_Button1_i(), this._GPSiesSearch_Label1_i(), this._GPSiesSearch_LayoutGroup1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _GPSiesSearch_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _GPSiesSearch_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.styleName = "WHITEBUTTON";
            loc1.visible = false;
            loc1.addEventListener("touch", this.__searchButton_touch);
            loc1.id = "searchButton";
            this.searchButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "searchButton", this.searchButton);
            return loc1;
        }

        public function __searchButton_touch(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            return;
        }

        internal function _GPSiesSearch_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_GPSiesSearch_Label1";
            this._GPSiesSearch_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GPSiesSearch_Label1", this._GPSiesSearch_Label1);
            return loc1;
        }

        internal function _GPSiesSearch_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        internal function _GPSiesSearch_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___GPSiesSearch_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___GPSiesSearch_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___GPSiesSearch_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.removedFromStageHandler(arg1);
            return;
        }

        internal function _GPSiesSearch_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("GPSIES_SEARCH_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("GPSIES_SEARCH_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "searchButton.label")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "searchButton.width")
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !loading;
            }, null, "_GPSiesSearch_Label1.includeInLayout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_GPSiesSearch_Label1.maxWidth")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GPSiesSearch_Label1.styleName")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_gpsiesInfo;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GPSiesSearch_Label1.text")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !loading;
            }, null, "_GPSiesSearch_Label1.visible")
            result[11] = new feathers.binding.Binding(this, null, null, "movie.includeInLayout", "loading");
            result[12] = new feathers.binding.Binding(this, null, null, "movie.visible", "loading");
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():frontend.components.menuList.MenuList
        {
            return this._3322014list;
        }

        public var _GPSiesSearch_Label1:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _3322014list:frontend.components.menuList.MenuList;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _365389062searchButton:feathers.controls.Button;

        internal var _2009185754_gpsiesInfo:String="";

        internal var _maximumMaxDistance:Number=500000;

        internal var _maximumRadius:Number=100000;

        internal var movieClip:starling.display.MovieClip;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        internal var _336650556loading:Boolean=false;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//      class GPSiesSearchResult
package frontend.screen.tracks.tabs.gpsies 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.route.*;
    import debug.*;
    import flash.geom.*;
    import utils.*;
    
    public class GPSiesSearchResult extends Object
    {
        public function GPSiesSearchResult()
        {
            this.trackCharacters = new Array();
            this.trackData = new Array();
            this.trackPoints = new Array();
            this.trackTypes = new Array();
            this.waypointData = new Array();
            super();
            return;
        }

        internal function convertGPSiesDateStringToDate(arg1:String):Date
        {
            var loc1:*=arg1.split(" ");
            var loc2:*=loc1[0].toString().split("-");
            var loc3:*=loc1[1].toString().split(":");
            return new Date(loc2[0], (loc2[1] - 1), loc2[2], loc3[0], loc3[1], loc3[2].toString().substr(0, 2));
        }

        public function routeFromJSON(arg1:Object, arg2:core.route.Route):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (!arg1.data.hasOwnProperty("fileId")) 
            {
                return;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1.data.hasOwnProperty("changedDate")) 
            {
                this.changedDate = this.convertGPSiesDateStringToDate(arg1.data.changedDate);
            }
            this.client = arg1.client;
            this.countTrackpoints = arg1.data.countTrackpoints;
            if (arg1.data.hasOwnProperty("createdDate")) 
            {
                this.createdDate = this.convertGPSiesDateStringToDate(arg1.data.createdDate);
            }
            if (arg1.data.hasOwnProperty("description")) 
            {
                this.description = arg1.data.description == null ? "" : arg1.data.description;
            }
            this.fileId = arg1.data.fileId;
            if (arg1.data.hasOwnProperty("startPoint")) 
            {
                this.startPoint = new flash.geom.Point(arg1.data.lon, arg1.data.lat);
            }
            if (arg1.data.hasOwnProperty("distance")) 
            {
                this.distance = arg1.data.length * 1000;
            }
            if (arg1.data.hasOwnProperty("maxHeight")) 
            {
                this.maxHeight = arg1.data.maxHeight * 1000;
            }
            if (arg1.data.hasOwnProperty("minHeight")) 
            {
                this.minHeight = arg1.data.minHeight * 1000;
            }
            this.property = arg1.data.property;
            this.status = arg1.data.status;
            if (arg1.data.hasOwnProperty("totalAscent")) 
            {
                this.totalAscent = arg1.data.totalAscent * 1000;
            }
            if (arg1.data.hasOwnProperty("totalDescent")) 
            {
                this.totalDescent = arg1.data.totalDescent * 1000;
            }
            this.trackName = arg1.data.trackname;
            arg2.creationTimestamp = this.createdDate;
            arg2.modificationDate = this.changedDate.time;
            arg2.routeOptions = new Vector.<core.route.RouteOptions>();
            if (arg1.data.hasOwnProperty("trackTypes")) 
            {
                this.trackTypes = arg1.data.trackTypes as Array;
                loc3 = this.trackTypes.length;
                loc1 = 0;
                while (loc1 < loc3) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.trackTypes[loc1].toString();
                    arg2.routeOptions.push(loc4);
                    ++loc1;
                }
            }
            if (arg1.data.hasOwnProperty("waypointData")) 
            {
                this.waypointData = arg1.data.waypointData as Array;
            }
            if (arg1.data.hasOwnProperty("trackCharacters")) 
            {
                this.trackCharacters = arg1.data.trackCharacters as Array;
                loc3 = this.trackCharacters.length;
                loc1 = 0;
                while (loc1 < loc3) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.trackCharacters[loc1].toString();
                    arg2.routeOptions.push(loc4);
                    ++loc1;
                }
            }
            if (arg1.data.hasOwnProperty("trackData")) 
            {
                this.trackData = arg1.data.trackData as Array;
                arg2.routePoints = new Vector.<core.route.RoutePoint>();
                loc2 = 0;
                while (loc2 < this.trackData.length) 
                {
                    this.trackPoints = this.trackData[loc2] as Array;
                    loc3 = this.trackPoints.length;
                    loc1 = 0;
                    while (loc1 < loc3) 
                    {
                        loc6 = this.trackPoints[loc1] as Object;
                        loc5 = new core.route.RoutePoint();
                        loc5.routeId = arg2.routeId;
                        loc5.altitude = loc6.ele * 1000;
                        loc5.latitude = loc6.lat;
                        loc5.longitude = loc6.lon;
                        loc5.routingType = core.route.RoutingType.IMPORTED;
                        loc5.userPoint = false;
                        arg2.routePoints.push(loc5);
                        ++loc1;
                    }
                    ++loc2;
                }
                core.route.Route.setImportedRouteStartPoints(arg2);
            }
            this.userName = arg1.data.username;
            debug.Debug.debug("track details (" + this.fileId + ")");
            return;
        }

        public function headerFromJSON(arg1:Object):void
        {
            if (!arg1.hasOwnProperty("fileId")) 
            {
                return;
            }
            this.changedDate = this.convertGPSiesDateStringToDate(arg1.changedDate);
            this.client = arg1.client;
            this.createdDate = this.convertGPSiesDateStringToDate(arg1.createdDate);
            this.fileId = arg1.fileId;
            this.startPoint = new flash.geom.Point(arg1.lon, arg1.lat);
            this.distance = arg1.length * 1000;
            this.distanceFormatted = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.distance));
            this.property = arg1.property;
            this.trackName = arg1.trackname;
            this.userName = arg1.username;
            this.tmpRoute = new core.route.Route();
            this.tmpRoute.GUID = utils.GUID.create();
            this.tmpRoute.routeId = 0;
            this.tmpRoute.ownTrack = false;
            this.tmpRoute.distance = this.distance;
            this.tmpRoute.distanceOutputString = this.distanceFormatted;
            this.tmpRoute.creationTimestamp = this.createdDate;
            this.tmpRoute.name = this.trackName;
            this.tmpRoute.isCircuit = this.property == 1;
            this.tmpRoute.webPortalId = this.fileId;
            this.tmpRoute.latitudeStart = this.startPoint.y;
            this.tmpRoute.longitudeStart = this.startPoint.x;
            this.tmpRoute.loadedFrom = core.route.Route.LOADED_FROM_GPSIES;
            return;
        }

        public static const COL_NAME:String="trackName";

        public static const COL_DISTANCE:String="distance";

        public static const COL_DISTANCE_TO_TRACK:String="distanceToTrack";

        public static const COL_MODIFICATION_DATE:String="changedDate";

        public var changedDate:Date;

        public var client:String;

        public var countTrackpoints:int;

        public var createdDate:Date;

        public var description:String;

        public var distance:Number;

        public var distanceFormatted:String;

        public var distanceToTrack:Number;

        public var distanceToTrackFormatted:String;

        public var fileId:String;

        public var maxHeight:Number;

        public var minHeight:Number;

        public var trackData:Array;

        public var trackName:String;

        public var trackPoints:Array;

        public var trackTypes:Array;

        public var userName:String;

        public var waypointData:Array;

        public var status:int;

        public var startPoint:flash.geom.Point;

        public var property:int;

        public var totalAscent:Number;

        public var totalDescent:Number;

        public var trackCharacters:Array;

        public var tmpRoute:core.route.Route;
    }
}


//      class GPSiesTrackRenderer
package frontend.screen.tracks.tabs.gpsies 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    import utils.*;
    
    public class GPSiesTrackRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function GPSiesTrackRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._distanceToTrackPostfix = utils.LanguageManager.getString("GPSIES_DISTANCE_TO_TRACK_POSTFIX");
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, customPadding);
            this._group.addChild(this._name);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_LEFT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._leftValuesGroup = new feathers.controls.LayoutGroup();
            this._leftValuesGroup.layout = this._hLayout;
            this._leftValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, customPadding);
            this._group.addChild(this._leftValuesGroup);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_RIGHT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._rightValuesGroup = new feathers.controls.LayoutGroup();
            this._rightValuesGroup.layout = this._hLayout;
            this._rightValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING, NaN);
            this._group.addChild(this._rightValuesGroup);
            this._imageDistance = new frontend.components.TextureImage();
            this._imageDistance.textureName = frontend.Textures.streckesmall;
            this._imageDistance.touchable = false;
            this._leftValuesGroup.addChild(this._imageDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.width = VALUE_WIDTH;
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._leftValuesGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._leftValuesGroup.addChild(this._labelDistanceUnit);
            this._labelAltitude = new feathers.controls.Label();
            this._labelAltitude.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._rightValuesGroup.addChild(this._labelAltitude);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.track();
            if (!loc1) 
            {
                return;
            }
            this._name.text = loc1.trackName;
            this._name.invalidate(INVALIDATION_FLAG_SIZE);
            this._name.validate();
            this._labelDistance.text = loc1.distanceFormatted;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelAltitude.text = loc1.distanceToTrackFormatted + " " + backend.utils.DataUtils.unitStringDistance + " " + this._distanceToTrackPostfix;
            this._labelAltitude.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitude.validate();
            this._bottomLine.y = height - this._bottomLine.height;
            this._maxLabelWidth = this._group.width - customPadding - customPadding;
            this._name.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal function track():frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult
        {
            if (data is frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult) 
            {
                return data as frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;
            }
            return null;
        }

        
        {
            OPTION_GROUP_WIDTH = 65 * SIGMALink.scaleFactor;
            PADDING = 20 * SIGMALink.scaleFactor;
            VALUE_WIDTH = 100 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _distanceToTrackPostfix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _imageDistance:frontend.components.TextureImage;

        internal var _labelAltitude:feathers.controls.Label;

        internal var _labelAltitudeUnit:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _leftValuesGroup:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _rightValuesGroup:feathers.controls.LayoutGroup;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var PADDING:Number;

        internal static var VALUE_WIDTH:Number;

        internal static var customPadding:Number;
    }
}


//      class GPSiesURLLoader
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


//      class GPSiesURLStream
package frontend.screen.tracks.tabs.gpsies 
{
    import core.route.*;
    import flash.net.*;
    
    public class GPSiesURLStream extends flash.net.URLStream
    {
        public function GPSiesURLStream()
        {
            super();
            return;
        }

        public var route:core.route.Route;
    }
}


//    package list
//      class MyTracksListEvent
package frontend.screen.tracks.tabs.list 
{
    import core.route.*;
    import flash.events.*;
    
    public class MyTracksListEvent extends flash.events.Event
    {
        public function MyTracksListEvent(arg1:String, arg2:core.route.Route=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.route = arg2;
            return;
        }

        public static const DELETE:String="deleteTrackEvent";

        public static const RELOAD:String="reloadTracksEvent";

        public static const UPDATE:String="updateTrackEvent";

        public var route:core.route.Route;
    }
}


//      class MyTracksListItem
package frontend.screen.tracks.tabs.list 
{
    import core.route.*;
    import frontend.components.list.*;
    
    public class MyTracksListItem extends frontend.components.list.SelectableListItem
    {
        public function MyTracksListItem()
        {
            super();
            return;
        }

        public var altitude:String;

        public var altitudeUnit:String;

        public var distance:String;

        public var distanceUnit:String;

        public var icon:String;

        public var track:core.route.Route;
    }
}


//      class MyTracksRenderer
package frontend.screen.tracks.tabs.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class MyTracksRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MyTracksRenderer()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._optionGroup = new feathers.controls.LayoutGroup();
            this._optionGroup.touchGroup = true;
            this._optionGroup.layout = new feathers.layout.AnchorLayout();
            this._optionGroup.width = OPTION_GROUP_WIDTH;
            this._optionGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._optionGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            this._optionGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onUploadTouch);
            this._group.addChild(this._optionGroup);
            this._sendToDeviceIcon = new frontend.components.TextureImage();
            this._sendToDeviceIcon.textureName = frontend.Textures.uploadicon;
            this._sendToDeviceIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._optionGroup.addChild(this._sendToDeviceIcon);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, NAME_PADDING_LEFT);
            this._group.addChild(this._name);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_LEFT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._leftValuesGroup = new feathers.controls.LayoutGroup();
            this._leftValuesGroup.layout = this._hLayout;
            this._leftValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, NAME_PADDING_LEFT);
            this._group.addChild(this._leftValuesGroup);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_RIGHT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._rightValuesGroup = new feathers.controls.LayoutGroup();
            this._rightValuesGroup.layout = this._hLayout;
            this._rightValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING, NaN);
            this._group.addChild(this._rightValuesGroup);
            this._imageDistance = new frontend.components.TextureImage();
            this._imageDistance.textureName = frontend.Textures.streckesmall;
            this._imageDistance.touchable = false;
            this._leftValuesGroup.addChild(this._imageDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.width = VALUE_WIDTH;
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._leftValuesGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._leftValuesGroup.addChild(this._labelDistanceUnit);
            this._imageAltitude = new frontend.components.TextureImage();
            this._imageAltitude.textureName = frontend.Textures.bergauf;
            this._imageAltitude.touchable = false;
            this._rightValuesGroup.addChild(this._imageAltitude);
            this._labelAltitude = new feathers.controls.Label();
            this._labelAltitude.width = VALUE_WIDTH;
            this._labelAltitude.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._rightValuesGroup.addChild(this._labelAltitude);
            this._labelAltitudeUnit = new feathers.controls.Label();
            this._labelAltitudeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._rightValuesGroup.addChild(this._labelAltitudeUnit);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (editState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.route();
            if (loc1.track) 
            {
                this._name.text = loc1.track.name;
            }
            this._name.invalidate(INVALIDATION_FLAG_SIZE);
            this._name.validate();
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = loc1.distanceUnit;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelAltitude.text = loc1.altitude;
            this._labelAltitude.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitude.validate();
            this._labelAltitudeUnit.text = loc1.altitudeUnit;
            this._labelAltitudeUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitudeUnit.validate();
            this._bottomLine.y = height - this._bottomLine.height;
            this._maxLabelWidth = this._group.width - NAME_PADDING_LEFT - customPadding;
            this._name.width = this._maxLabelWidth;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            editGroup.visible = editState;
            var loc1:*;
            this._optionGroup.includeInLayout = loc1 = !editGroup.visible;
            this._optionGroup.visible = loc1;
            checkbox.isSelected = this.route().isSelected();
            return;
        }

        internal function route():frontend.screen.tracks.tabs.list.MyTracksListItem
        {
            if (data is frontend.screen.tracks.tabs.list.MyTracksListItem) 
            {
                return data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            }
            return new frontend.screen.tracks.tabs.list.MyTracksListItem();
        }

        
        {
            NAME_PADDING_LEFT = 85 * SIGMALink.scaleFactor;
            OPTION_GROUP_WIDTH = 75 * SIGMALink.scaleFactor;
            PADDING = 20 * SIGMALink.scaleFactor;
            VALUE_WIDTH = 100 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
            editState = false;
        }

        public function isEditState(arg1:Boolean):void
        {
            editState = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            editState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                this.route().addSelection();
            }
            else 
            {
                this.route().removeSelection();
            }
            return;
        }

        internal function onUploadTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.callBackFunction == null) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            arg1.stopImmediatePropagation();
            this.callBackFunction(this.route());
            return;
        }

        public var callBackFunction:Function;

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _imageAltitude:frontend.components.TextureImage;

        internal var _imageDistance:frontend.components.TextureImage;

        internal var _labelAltitude:feathers.controls.Label;

        internal var _labelAltitudeUnit:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _leftValuesGroup:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _optionGroup:feathers.controls.LayoutGroup;

        internal var _rightValuesGroup:feathers.controls.LayoutGroup;

        internal static var NAME_PADDING_LEFT:Number;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var PADDING:Number;

        internal static var VALUE_WIDTH:Number;

        internal static var customPadding:Number;

        internal static var editState:Boolean=false;

        internal var _sendToDeviceIcon:frontend.components.TextureImage;
    }
}


//    package track
//      package tabs
//        class TracksInformation
package frontend.screen.tracks.tabs.track.tabs 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.route.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.component.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import handler.event.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class TracksInformation extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function TracksInformation()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._3766vl = new feathers.layout.VerticalLayout();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TracksInformation_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_tabs_TracksInformationWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TracksInformation[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("addedToStage", this.___TracksInformation_TabLayoutScroller1_addedToStage);
            this.addEventListener("removedFromStage", this.___TracksInformation_TabLayoutScroller1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function get routeDate():String
        {
            return this._167168407routeDate;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            if (this._myRoute) 
            {
                this.validateValues();
            }
            return;
        }

        internal function set routeDate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._167168407routeDate;
            if (loc1 !== arg1) 
            {
                this._167168407routeDate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeDate", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set myRoute(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.myRoute;
            if (loc1 !== arg1) 
            {
                this._1496932349myRoute = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "myRoute", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeAltitudeDifferencesDownhill():String
        {
            return this._1582889166routeAltitudeDifferencesDownhill;
        }

        internal function set routeAltitudeDifferencesDownhill(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1582889166routeAltitudeDifferencesDownhill;
            if (loc1 !== arg1) 
            {
                this._1582889166routeAltitudeDifferencesDownhill = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeAltitudeDifferencesDownhill", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeDistance():String
        {
            return this._566736546routeDistance;
        }

        internal function onAddedToStage():void
        {
            this.vl.gap = 1 * SIGMALink.scaleFactor;
            handler.RouteHandler.getInstance().addEventListener(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED, this.onRoutePointsLoaded);
            return;
        }

        internal function set routeDistance(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._566736546routeDistance;
            if (loc1 !== arg1) 
            {
                this._566736546routeDistance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeDistance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function get routeAltitudeDifferencesUphill():String
        {
            return this._1012859641routeAltitudeDifferencesUphill;
        }

        internal function set routeAltitudeDifferencesUphill(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1012859641routeAltitudeDifferencesUphill;
            if (loc1 !== arg1) 
            {
                this._1012859641routeAltitudeDifferencesUphill = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeAltitudeDifferencesUphill", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeRating():uint
        {
            return this._2135864646routeRating;
        }

        internal function set routeRating(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2135864646routeRating;
            if (loc1 !== arg1) 
            {
                this._2135864646routeRating = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeRating", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeCategorie():String
        {
            return this._824561902routeCategorie;
        }

        internal function set routeCategorie(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._824561902routeCategorie;
            if (loc1 !== arg1) 
            {
                this._824561902routeCategorie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeCategorie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TracksInformation._watcherSetupUtil = arg1;
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.RouteHandler.getInstance().removeEventListener(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED, this.onRoutePointsLoaded);
            return;
        }

        internal function onRoutePointsLoaded(arg1:handler.event.RouteEvent):void
        {
            if (arg1.route == this._myRoute) 
            {
                this.routeDistance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.distance));
                this.routeRating = this.myRoute.rating;
                this.routeAltitudeDifferencesDownhill = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.altitudeDifferencesUphill));
                this.routeAltitudeDifferencesUphill = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.altitudeDifferencesDownhill));
                this.routeDate = new Date(this.myRoute.creationTimestamp).toDateString();
                handler.RouteHandlerCommon.getInstance().calculateDistances(this.myRoute, true);
                this.chart.entries = handler.RouteHandlerCommon.getInstance().altitudeProfileDP;
            }
            return;
        }

        internal function addChart():void
        {
            this.chart = new frontend.screen.activities.component.ActivityGraphComp();
            this.chart.yAchseLabel = backend.utils.DataUtils.altitudeLabel + " [" + backend.utils.DataUtils.unitStringAltitude + "]";
            this.chart.yLabelConverter = backend.utils.DataUtils.altitudeConverter;
            this.chart.yLabelFormatter = backend.utils.DataUtils.altitudeFormatter;
            this.chart.yValueName = "altitude";
            this.chart.xValueName = "distance";
            this.chart.graphColor = core.general.Colors.ALTITUDE;
            this.chart.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChildAt(this.chart, 5);
            return;
        }

        protected function validateValues():void
        {
            removeChildren();
            this.addListItem("TRACKS_INFO_NAME", core.route.Route.COL_NAME, this.myRoute.name, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD);
            this.addRatingItem();
            this.addListItemNumberInput("TRACKS_INFO_DISTANCE", core.route.Route.COL_DISTANCE, this.myRoute.distance, 0, 0, backend.utils.DataUtils.distanceFormatter, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.unitStringDistance, false);
            this.addListItemNumberInput("TRACKS_INFO_ALTI_UP", core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, this.myRoute.altitudeDifferencesUphill, 0, 0, backend.utils.DataUtils.altitudeFormatter, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.unitStringAltitude, false);
            this.addListItemNumberInput("TRACKS_INFO_ALTI_DOWN", core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, this.myRoute.altitudeDifferencesDownhill, 0, 0, backend.utils.DataUtils.altitudeFormatter, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.unitStringAltitude, false);
            this.addChart();
            this.addCategoriesItem();
            this.addSuitableForItem();
            this.addListItemDateInput("TRACKS_INFO_CREATION_DATE", core.route.Route.COL_CREATIONTIMESTAMP, this.myRoute.creationTimestamp, 0, 0, backend.utils.DataUtils.dateFormatter, false);
            this.modificationItem = this.addListItemDateInput("TRACKS_INFO_LAST_MODIFICATION", core.route.Route.COL_MODIFICATION_DATE, this.myRoute.modificationDate, 0, 0, backend.utils.DataUtils.dateFormatter, false);
            this.addDescriptionItem();
            return;
        }

        internal function validateModificationItem():void
        {
            this.modificationItem.value = this.myRoute.modificationDate;
            return;
        }

        internal function addRatingItem():void
        {
            this.ratingItem = new frontend.components.menuList.MenuListItem();
            var loc1:*;
            this.ratingItem.title = loc1 = "TRACKS_INFO_RATING";
            this.ratingItem.text = loc1;
            this.ratingItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.ratingItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING;
            this.ratingItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.ratingItem.saveCompleteCallback = this.onRatingChanged;
            this.ratingItem.saveToDbUseUpdate = false;
            this.ratingItem.useConfigCache = false;
            this.ratingItem.useLocalesForText = true;
            this.ratingItem.useLocalesForTitle = true;
            this.ratingItem.defaultValue = this.myRoute.rating;
            addChild(this.ratingItem);
            this.validateRatingItem();
            return;
        }

        internal function validateRatingItem():void
        {
            this.ratingItem.customLayoutContent.removeChildren();
            this.ratingItem.customLayoutContent.visible = true;
            this.ratingItem.customLayoutContent.includeInLayout = true;
            this.ratingItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.paddingRight = this.ratingItem.padding;
            this.ratingItem.customLayoutContent.layout = loc1;
            this.ratingItem.customLayoutContent.addChild(frontend.components.menuList.editors.RatingEditor.drawContent(this.myRoute.rating));
            return;
        }

        internal function onRatingChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute.rating = arg2.rawValue as int;
            this.validateRatingItem();
            this.updateRouteInDB();
            return;
        }

        internal function updateRouteInDB():void
        {
            this.myRoute.modificationDate = new Date().time;
            var loc1:*="UPDATE " + core.route.Route.TABLE_NAME + " SET " + core.route.Route.COL_RATING + " = " + this.myRoute.rating + ", " + core.route.Route.COL_MODIFICATION_DATE + " = " + this.myRoute.modificationDate + " WHERE " + core.route.Route.COL_ROUTE_ID + " = " + this.myRoute.routeId;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onRatingChangedComplete, this.onRatingChangedError);
            return;
        }

        internal function onRatingChangedComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.validateModificationItem();
            return;
        }

        internal function onRatingChangedError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onRatingChangedError");
            return;
        }

        internal function addDescriptionItem():void
        {
            this.descriptionItem = new frontend.components.menuList.MenuListItem();
            this.descriptionItem.leftLabelAlignTop = true;
            this.descriptionItem.text = "TRACKS_INFO_DESCRIPTION";
            this.descriptionItem.title = "TRACKS_INFO_DESCRIPTION";
            this.descriptionItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.descriptionItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA;
            this.descriptionItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL * 2;
            this.descriptionItem.saveToDbUseUpdate = true;
            this.descriptionItem.saveToDbUseUpdateObject = this.getDBObject(core.route.Route.COL_DESCRIPTION);
            this.descriptionItem.useConfigCache = false;
            this.descriptionItem.useLocalesForText = true;
            this.descriptionItem.useLocalesForTitle = true;
            this.descriptionItem.saveCompleteCallback = this.onDescriptionChanged;
            this.descriptionItem.defaultValue = this.myRoute.description;
            this.descriptionItem.height = SIGMALink.appHeight / 2;
            addChild(this.descriptionItem);
            this.descriptionItem.leftLabel.layoutData = new feathers.layout.AnchorLayoutData(this.descriptionItem.padding, NaN, NaN, this.descriptionItem.padding);
            this.descriptionItem.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL, this.descriptionItem.padding, this.descriptionItem.padding, this.descriptionItem.padding);
            return;
        }

        internal function onDescriptionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            this.descriptionItem.defaultValue = arg2.rawValue;
            this.descriptionItem.rightLabel.text = arg2.rawValue as String;
            this.validateModificationItem();
            return;
        }

        internal function addCategoriesItem():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=false;
            var loc1:*=[];
            loc4 = this.myRoute.routeOptions.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc1[loc1.length] = this.myRoute.routeOptions[loc3];
                ++loc3;
            }
            var loc2:*=backend.utils.dataprovider.RouteOptionsDataProvider.getCharacteristicsDataProvider();
            loc4 = loc2.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc6 = loc2.getItemAt(loc3);
                loc8 = loc1.length;
                loc9 = false;
                loc7 = 0;
                while (loc7 < loc8) 
                {
                    if ((loc1[loc7] as core.route.RouteOptions).param == loc6.param) 
                    {
                        loc9 = true;
                        break;
                    }
                    ++loc7;
                }
                loc5.push({"label":loc6.label, "data":loc6.param, "selected":loc9});
                ++loc3;
            }
            this.categoriesItem = new frontend.components.menuList.MenuListItem();
            this.categoriesItem.leftLabelAlignTop = true;
            var loc10:*;
            this.categoriesItem.title = loc10 = "TRACKS_INFO_CATEGORY";
            this.categoriesItem.text = loc10;
            this.categoriesItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.categoriesItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING;
            this.categoriesItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.categoriesItem.saveCompleteCallback = this.onRouteCategoriesChanged;
            this.categoriesItem.saveToDbUseUpdate = false;
            this.categoriesItem.useConfigCache = false;
            this.categoriesItem.useLocalesForText = true;
            this.categoriesItem.useLocalesForTitle = true;
            this.categoriesItem.dataProvider = loc5;
            this.categoriesItem.defaultValues = loc1;
            addChild(this.categoriesItem);
            this.validateCategoriesItem();
            return;
        }

        internal function validateCategoriesItem():void
        {
            var loc3:*=0;
            var loc7:*=null;
            this.categoriesItem.customLayoutContent.removeChildren();
            this.categoriesItem.customLayoutContent.visible = true;
            this.categoriesItem.customLayoutContent.includeInLayout = true;
            this.categoriesItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 3;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.categoriesItem.padding;
            loc1.verticalGap = this.categoriesItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.tileHorizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.categoriesItem.padding;
            var loc2:*=new frontend.components.PropertyLabel();
            loc2.text = "XXXXXXXXX";
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            var loc4:*=this.categoriesItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.categoriesItem.dataProvider.getItemAt(loc3).selected) 
                {
                    loc7 = new frontend.components.PropertyLabel();
                    loc7.property = this.categoriesItem.dataProvider.getItemAt(loc3);
                    loc7.text = loc7.property.label;
                    loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                    this.categoriesItem.customLayoutContent.addChild(loc7);
                }
                ++loc3;
            }
            var loc6:*=Math.min(this.categoriesItem.customLayoutContent.numChildren, loc1.requestedColumnCount);
            this.categoriesItem.customLayoutContent.width = loc6 * loc1.typicalItemWidth + (loc6 + 1) * this.categoriesItem.padding;
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.categoriesItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.categoriesItem.customLayoutContent.layout = loc1;
            this.categoriesItem.height = loc1.requestedRowCount * this.categoriesItem.minItemHeight;
            this.categoriesItem.customLayoutContent.height = this.categoriesItem.height;
            return;
        }

        internal function onRouteCategoriesChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            debug.Debug.debug("onRouteCategoriesChanged");
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.RouteOptions.generateDBDeleteAllCategories(this.myRoute.routeId), this.onDeleteRouteCategoriesComplete, this.onDeleteRouteCategoriesError, null, arg2);
            return;
        }

        internal function onDeleteRouteCategoriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=0;
            var loc4:*=null;
            var loc5:*=null;
            this.myRoute.routeOptions = new Vector.<core.route.RouteOptions>();
            var loc2:*=this.categoriesItem.dataProvider.length;
            var loc3:*=[];
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.categoriesItem.dataProvider.getItemAt(loc1).selected) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.categoriesItem.dataProvider.getItemAt(loc1).data;
                    loc4.routeId = this.myRoute.routeId;
                    this.myRoute.routeOptions.push(loc4);
                    loc5 = new backend.utils.dbUtils.DBUtilObject();
                    loc5.stmt = loc4.generateDBInsert().text;
                    loc3.push(loc5);
                }
                ++loc1;
            }
            if (loc3.length > 0) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc3, this.onInsertRouteCategoryComplete, this.onInsertRouteCategoryError, null);
            }
            else 
            {
                this.onInsertRouteOptionComplete();
            }
            return;
        }

        internal function onInsertRouteCategoryComplete(arg1:backend.utils.dbUtils.DBUtilEvent=null):void
        {
            debug.Debug.debug("onInsertRouteCategoryComplete");
            this.validateCategoriesItem();
            this.updateRouteInDB();
            return;
        }

        internal function onInsertRouteCategoryError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteCategoryError");
            return;
        }

        internal function onDeleteRouteCategoriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteRouteCategoriesError");
            return;
        }

        internal function addSuitableForItem():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=false;
            var loc1:*=[];
            loc4 = this.myRoute.routeOptions.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc1[loc1.length] = this.myRoute.routeOptions[loc3];
                ++loc3;
            }
            var loc2:*=backend.utils.dataprovider.RouteOptionsDataProvider.getSuitableDataProvider();
            loc4 = loc2.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (loc2.getItemAt(loc3).selectable) 
                {
                    loc6 = handler.SportHandler.getInstance().resolveSportById(loc2.getItemAt(loc3).sportId);
                    loc8 = loc1.length;
                    loc9 = false;
                    loc7 = 0;
                    while (loc7 < loc8) 
                    {
                        if ((loc1[loc7] as core.route.RouteOptions).sportId == loc6.sportId) 
                        {
                            loc9 = true;
                            break;
                        }
                        ++loc7;
                    }
                    loc5.push({"label":loc6.name, "data":loc6.sportId, "param":loc2.getItemAt(loc3).param, "selected":loc9});
                }
                ++loc3;
            }
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.leftLabelAlignTop = true;
            var loc10:*;
            this.sportsItem.title = loc10 = "TRACKS_INFO_SPORTS";
            this.sportsItem.text = loc10;
            this.sportsItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.sportsItem.saveCompleteCallback = this.onRouteSportsChanged;
            this.sportsItem.saveToDbUseUpdate = false;
            this.sportsItem.useConfigCache = false;
            this.sportsItem.useLocalesForText = true;
            this.sportsItem.useLocalesForTitle = true;
            this.sportsItem.dataProvider = loc5;
            this.sportsItem.defaultValues = loc1;
            addChild(this.sportsItem);
            this.validateSportsItem();
            return;
        }

        internal function validateSportsItem():void
        {
            var loc3:*=0;
            var loc6:*=null;
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 3;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc4:*=this.sportsItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc3).selected) 
                {
                    loc6 = new frontend.components.SportIcon();
                    loc6.sportId = this.sportsItem.dataProvider.getItemAt(loc3).data;
                    this.sportsItem.customLayoutContent.addChild(loc6);
                }
                ++loc3;
            }
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function onRouteSportsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.RouteOptions.generateDBDeleteAllSports(this.myRoute.routeId), this.onDeleteRouteOptionsComplete, this.onDeleteRouteOptionsError, null, arg2);
            return;
        }

        internal function onDeleteRouteOptionsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=0;
            var loc4:*=null;
            var loc5:*=null;
            this.myRoute.routeOptions = new Vector.<core.route.RouteOptions>();
            var loc2:*=this.sportsItem.dataProvider.length;
            var loc3:*=[];
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc1).selected) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.sportsItem.dataProvider.getItemAt(loc1).param;
                    loc4.routeId = this.myRoute.routeId;
                    this.myRoute.routeOptions.push(loc4);
                    loc5 = new backend.utils.dbUtils.DBUtilObject();
                    loc5.stmt = loc4.generateDBInsert().text;
                    loc3.push(loc5);
                }
                ++loc1;
            }
            if (loc3.length > 0) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc3, this.onInsertRouteOptionComplete, this.onInsertRouteOptionError, null);
            }
            else 
            {
                this.onInsertRouteOptionComplete();
            }
            return;
        }

        internal function onInsertRouteOptionComplete(arg1:backend.utils.dbUtils.DBUtilEvent=null):void
        {
            debug.Debug.debug("onInsertRouteOptionComplete");
            this.validateSportsItem();
            this.updateRouteInDB();
            return;
        }

        internal function onDeleteRouteOptionsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteOptionError");
            return;
        }

        internal function onInsertRouteOptionError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteOptionError");
            return;
        }

        protected function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatter=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            loc1.type = arg4;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.saveToDbUseUpdateObject.dateAsString = arg7;
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.unitString = arg8;
            if (arg4 != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE) 
            {
                if (arg5) 
                {
                    loc1.dataProvider = arg5;
                }
                loc1.defaultValue = arg3;
            }
            else 
            {
                loc1.checkable = true;
                loc1.checked = arg3;
            }
            if (arg6) 
            {
                loc1.formatter = arg6;
            }
            addChild(loc1);
            return loc1;
        }

        protected function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String="", arg9:Boolean=true):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = arg9;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.converter = arg7;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            loc1.unitString = arg8;
            addChild(loc1);
            return loc1;
        }

        protected function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=true):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = arg7;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            addChild(loc1);
            return loc1;
        }

        protected function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.keyField = core.route.Route.COL_GUID;
            loc1.keyValue = this.myRoute.GUID;
            loc1.updateField = arg1;
            loc1.table = core.route.Route.TABLE_NAME;
            loc1.updateModificationDate = true;
            return loc1;
        }

        protected function onRouteChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            this.validateModificationItem();
            handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.UPDATE, this.myRoute));
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        public function ___TracksInformation_TabLayoutScroller1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___TracksInformation_TabLayoutScroller1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _TracksInformation_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TRACK.INFORMATION.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            return result;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal const ROW_HEIGHT:Number=65 * SIGMALink.scaleFactor;

        public static const TAB_NAME:String="MYTRACKS_TRACK_INFORMATION";

        internal var _myRoute:core.route.Route;

        internal var categoriesItem:frontend.components.menuList.MenuListItem;

        internal var chart:frontend.screen.activities.component.ActivityGraphComp;

        internal var descriptionItem:frontend.components.menuList.MenuListItem;

        internal var modificationItem:frontend.components.menuList.MenuListItem;

        internal var _1582889166routeAltitudeDifferencesDownhill:String="";

        internal var _1012859641routeAltitudeDifferencesUphill:String="";

        internal var _824561902routeCategorie:String="";

        internal var _167168407routeDate:String="";

        internal var _566736546routeDistance:String="";

        internal var _2135864646routeRating:uint=0;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        internal var _3766vl:feathers.layout.VerticalLayout;

        internal var ratingItem:frontend.components.menuList.MenuListItem;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//        class TracksMap
package frontend.screen.tracks.tabs.track.tabs 
{
    import backend.utils.dbUtils.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import handler.*;
    import handler.event.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class TracksMap extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function TracksMap()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TracksMap_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TracksMap[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._TracksMap_MapView1_i()];
            this.addEventListener("addedToStage", this.___TracksMap_TabLayoutGroup1_addedToStage);
            this.addEventListener("removedFromStage", this.___TracksMap_TabLayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            if (this._drawTrackTimeout != 0) 
            {
                flash.utils.clearTimeout(this._drawTrackTimeout);
                this._drawTrackTimeout = 0;
            }
            if (this._myRoute) 
            {
                this.showContent();
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            this.mapView.mapLockActivated = true;
            this.myRoute = null;
            return;
        }

        public override function showContent():void
        {
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                debug.Debug.debug("draw track later...");
                this._drawTrackTimeout = flash.utils.setTimeout(this.showContent, 100);
                return;
            }
            this.mapView.showMap(this.myRoute.latitudeStart, this.myRoute.latitudeEnd);
            this.mapView.showControls();
            if (this.myRoute.routePoints.length != 0) 
            {
                this.drawTrack();
            }
            else 
            {
                handler.RouteHandler.getInstance().loadRoutePoints(new backend.utils.dbUtils.DBUtilObject(null, this.loadRoutePointsComplete, this.loadRoutePointsError, Workers.worker_DatabaseWorker), this.myRoute.routeId);
            }
            return;
        }

        internal function loadRoutePointsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.RouteHandler.getInstance().loadRoutePointsComplete(arg1.getResult(), this.myRoute);
            this.drawTrack();
            return;
        }

        internal function drawTrack():void
        {
            if (this.myRoute.routePoints.length == 0) 
            {
                return;
            }
            var loc1:*=this.myRoute.routePoints[0].latitude;
            var loc2:*=this.myRoute.routePoints[0].longitude;
            var loc3:*=this.myRoute.routePoints[(this.myRoute.routePoints.length - 1)].latitude;
            var loc4:*=this.myRoute.routePoints[(this.myRoute.routePoints.length - 1)].longitude;
            this.mapView.showRouteTrack(this.myRoute.routePoints);
            this.mapView.showStartMarker(loc1, loc2);
            this.mapView.showEndMarker(loc3, loc4);
            this.mapView.focusTrack();
            var loc5:*=new handler.event.RouteEvent(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED);
            loc5.route = this.myRoute;
            handler.RouteHandler.getInstance().dispatchEvent(loc5);
            return;
        }

        internal function loadRoutePointsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadRoutePointsError");
            return;
        }

        internal function _TracksMap_MapView1_i():frontend.components.map.MapView
        {
            var loc1:*=new frontend.components.map.MapView();
            loc1.showFocusButton = true;
            loc1.showLayerButton = true;
            loc1.showLockButton = true;
            loc1.id = "mapView";
            this.mapView = loc1;
            feathers.binding.BindingManager.executeBindings(this, "mapView", this.mapView);
            return loc1;
        }

        public function ___TracksMap_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___TracksMap_TabLayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _TracksMap_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TRACK.MAP.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - SIGMALink.footerHeight;
            }, null, "mapView.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "mapView.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight + frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "mapView.yStartCorrection")
            return result;
        }

        public function get mapView():frontend.components.map.MapView
        {
            return this._836781601mapView;
        }

        public function set mapView(arg1:frontend.components.map.MapView):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._836781601mapView;
            if (loc1 !== arg1) 
            {
                this._836781601mapView = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "mapView", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set myRoute(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.myRoute;
            if (loc1 !== arg1) 
            {
                this._1496932349myRoute = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "myRoute", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TracksMap._watcherSetupUtil = arg1;
            return;
        }

        public static const TAB_NAME:String="MYTRACKS_TRACK_MAP";

        internal var _836781601mapView:frontend.components.map.MapView;

        internal var _myRoute:core.route.Route;

        internal var _drawTrackTimeout:uint=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//      class TrackDetail
package frontend.screen.tracks.tabs.track 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.map.*;
    import frontend.components.popup.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.component.*;
    import frontend.screen.tracks.tabs.list.*;
    import frontend.screen.tracks.tabs.track.tabs.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class TrackDetail extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TrackDetail()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TrackDetail_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TrackDetail[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._TrackDetail_TabContainer1_i(), this._TrackDetail_Footer1_i()];
            this.addEventListener("initialize", this.___TrackDetail_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onDeleteTrackError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Track konnte nicht gelöscht werden.");
            return;
        }

        internal function _TrackDetail_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = false;
            loc1.addEventListener("tabChanged", this.__detailsTabbar_tabChanged);
            loc1.id = "detailsTabbar";
            this.detailsTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "detailsTabbar", this.detailsTabbar);
            return loc1;
        }

        public function __detailsTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            return;
        }

        internal function downloadTrackHandler(arg1:starling.events.TouchEvent):void
        {
            this.myRoute.modificationDate = new Date().time;
            this.myRoute.loadedFrom = core.route.Route.LOADED_FROM_DATABASE;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(this.myRoute, this.saveRouteComplete, this.saveRouteError, null, true);
            handler.RouteHandler.getInstance().saveRoute(loc1);
            this.validateFooter();
            return;
        }

        internal function _TrackDetail_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___TrackDetail_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _TrackDetail_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "detailsTabbar.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "detailsTabbar.width")
            return result;
        }

        public function set detailsTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._923974976detailsTabbar;
            if (loc1 !== arg1) 
            {
                this._923974976detailsTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "detailsTabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set myRoute(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.myRoute;
            if (loc1 !== arg1) 
            {
                this._1496932349myRoute = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "myRoute", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TrackDetail._watcherSetupUtil = arg1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.buttonNavigateTo = new frontend.components.button.IconButton();
            this.buttonNavigateTo.image = frontend.Textures.mapsicon;
            this.buttonNavigateTo.touchHandler = this.navigateToTrack;
            this.buttonUpload = new frontend.components.button.IconButton();
            this.buttonUpload.image = frontend.Textures.uploadicon;
            this.buttonUpload.touchHandler = this.uploadTrack;
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDelete.image = frontend.Textures.trashicon;
            this.buttonDelete.touchHandler = this.deleteTrackHandler;
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonDownload.image = frontend.Textures.downloadbutton;
            this.buttonDownload.touchHandler = this.downloadTrackHandler;
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=null;
            if (this.trackMap) 
            {
                this.detailsTabbar.tabbar.selectedIndex = 0;
            }
            else 
            {
                this.validateTabs();
            }
            this.validateFooter();
            title = this.myRoute.name;
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                debug.Debug.debug("validateProperties later...");
                flash.utils.setTimeout(this.validateProperties, 100);
                return;
            }
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.trackInfo.myRoute = this.myRoute;
                this.trackMap.myRoute = this.myRoute;
            }
            else 
            {
                loc1 = handler.RouteHandler.getInstance().generateLoadOptions(this.myRoute.routeId);
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadRouteOptionsComplete, this.onLoadRouteError, Workers.worker_DatabaseWorker);
            }
            return;
        }

        internal function loadRouteOptionsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.RouteHandler.getInstance().loadRouteOptionsComplete(arg1.getResult(), this.myRoute);
            this.trackInfo.myRoute = this.myRoute;
            this.trackMap.myRoute = this.myRoute;
            return;
        }

        internal function onLoadRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onLoadRouteError");
            return;
        }

        internal function validateTabs():void
        {
            this.trackMap = new frontend.screen.tracks.tabs.track.tabs.TracksMap();
            this.trackMap.mapView.addEventListener(frontend.components.map.MapView.MAP_LOCK_CHANGED, this.onMapLockChanged);
            this.detailsTabbar.addTab(this.trackMap, true);
            this.trackInfo = new frontend.screen.tracks.tabs.track.tabs.TracksInformation();
            this.detailsTabbar.addTab(this.trackInfo);
            return;
        }

        internal function onMapLockChanged(arg1:starling.events.Event):void
        {
            if (this.trackMap.mapView.mapLockActivated) 
            {
                this.detailsTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                this.detailsTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            return;
        }

        internal function onContentLoadedCallback():void
        {
            if (this.trackMap) 
            {
                this.trackMap.showContent();
            }
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.trackInfo:
                {
                    if (this.trackMap) 
                    {
                        this.trackMap.mapView.mapLockActivated = true;
                    }
                    break;
                }
                case this.trackMap:
                {
                    break;
                }
            }
            this.validateFooter();
            return;
        }

        internal function validateFooter():void
        {
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.trackInfo:
                {
                    this.setInfoFooterButtons();
                    break;
                }
                case this.trackMap:
                {
                    this.setMapFooterButtons();
                    break;
                }
            }
            return;
        }

        internal function setInfoFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.buttonGroup.push(this.buttonDownload);
            }
            else 
            {
                this.buttonGroup.push(this.buttonUpload);
                this.buttonGroup.push(this.buttonNavigateTo);
                this.buttonGroup.push(this.buttonDelete);
            }
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function setMapFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.buttonGroup.push(this.buttonDownload);
            }
            else 
            {
                this.buttonGroup.push(this.buttonUpload);
                this.buttonGroup.push(this.buttonNavigateTo);
                this.buttonGroup.push(this.buttonDelete);
            }
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        public function get detailsTabbar():frontend.components.tab.TabContainer
        {
            return this._923974976detailsTabbar;
        }

        internal function uploadTrack(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":false, "track":this.myRoute}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function navigateToTrack(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (helper.Capabilities_helper.isAndroid()) 
            {
                loc1 = "http://maps.google.com/maps?daddr=" + this.myRoute.latitudeStart + "," + this.myRoute.longitudeStart;
            }
            else 
            {
                loc1 = "http://maps.apple.com/maps?saddr=Current%20Location&daddr=" + this.myRoute.latitudeStart + "," + this.myRoute.longitudeStart;
            }
            flash.net.navigateToURL(new flash.net.URLRequest(loc1), "_blank");
            return;
        }

        internal function saveRouteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("route changed...");
            handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD));
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function saveRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveRouteError");
            return;
        }

        protected function deleteTrackHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACK_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACK_TEXT");
            this.deletePopUp.cancelCallback = this.onPopUpClose;
            this.deletePopUp.deleteCallback = this.onPopUpDelete;
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.Route.prepareDelete(this.myRoute.GUID), this.onDeleteTrackComplete, this.onDeleteTrackError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteTrackComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.info("Track wurde gelöscht.");
            var loc1:*=new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, this.myRoute);
            handler.RouteHandler.getInstance().dispatchEvent(loc1);
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal var _923974976detailsTabbar:frontend.components.tab.TabContainer;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _myRoute:core.route.Route;

        internal var buttonDownload:frontend.components.button.IconButton;

        internal var buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var buttonNavigateTo:frontend.components.button.IconButton;

        internal var buttonUpload:frontend.components.button.IconButton;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var trackInfo:frontend.screen.tracks.tabs.track.tabs.TracksInformation;

        internal var trackMap:frontend.screen.tracks.tabs.track.tabs.TracksMap;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var buttonDelete:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class GPSies
package frontend.screen.tracks.tabs 
{
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.tracks.tabs.gpsies.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.sort.*;
    
    use namespace mx_internal;
    
    public class GPSies extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function GPSies()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._GPSies_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_GPSiesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GPSies[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._GPSies_ListLoader1_i()];
            this.addEventListener("initialize", this.___GPSies_TabLayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get trackList():frontend.components.list.CustomList
        {
            return this._trackList;
        }

        internal function onInit():void
        {
            this._trackList = new frontend.components.list.CustomList();
            this._trackList.allowMultipleSelection = false;
            this._trackList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._trackList.dataProvider = this._dataProvider;
            this._trackList.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this._trackList.itemRendererType = frontend.screen.tracks.tabs.gpsies.GPSiesTrackRenderer;
            this._trackList.width = SIGMALink.appWidth;
            this._trackList.addEventListener(starling.events.Event.TRIGGERED, this.triggeredHandler);
            this.currentSortField = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD, frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE_TO_TRACK);
            this.currentAscending = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.GPSIES_SORT_ASCENDING, true);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            this.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            return;
        }

        internal function onTracksChanged(arg1:starling.events.Event):void
        {
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.sort(this.sortTracks);
            this._dataProvider = new feathers.data.ListCollection(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks);
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            this.listLoader.checkDataProvider();
            return;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            var p_event:starling.events.Event;
            var track:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;

            var loc1:*;
            track = null;
            p_event = arg1;
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            this.listLoader.startLoading();
            try 
            {
                track = p_event.data as frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().loadTrackAsKMZ(track.tmpRoute);
            }
            catch (e:Error)
            {
                debug.Debug.error(e.message);
            }
            return;
        }

        internal function onTrackDetailsLoadedComplete(arg1:starling.events.Event):void
        {
            this.listLoader.stopLoading();
            this._trackList.selectedItem = null;
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRACKDETAIL, {"myRoute":frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().currentRoute}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onTrackDetailsLoadError(arg1:starling.events.Event):void
        {
            this.listLoader.stopLoading();
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
            return;
        }

        public function sortList(arg1:frontend.components.list.ListSortItem):void
        {
            this.currentSortField = arg1.sortField;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD, this.currentSortField);
            this.currentAscending = arg1.ascending;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.GPSIES_SORT_ASCENDING, this.currentAscending);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.sort(this.sortTracks);
            this._dataProvider = new feathers.data.ListCollection(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks);
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function sortTracks(arg1:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult, arg2:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult):Number
        {
            if (this.currentSortField == frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_NAME) 
            {
                return utils.sort.SortUtil.sortOnString(arg1, arg2, this.currentSortField, !this.currentAscending);
            }
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, this.currentSortField, !this.currentAscending);
        }

        internal function _GPSies_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___GPSies_TabLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _GPSies_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.GPSIES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _trackList;
            }, null, "listLoader.list")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _trackList():frontend.components.list.CustomList
        {
            return this._759336182_trackList;
        }

        internal function set _trackList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._759336182_trackList;
            if (loc1 !== arg1) 
            {
                this._759336182_trackList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_trackList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            GPSies._watcherSetupUtil = arg1;
            return;
        }

        public static const TAB_NAME:String="TAB_GPSIES_TRACKS";

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var currentAscending:Boolean;

        public var currentSortField:String;

        internal var _759336182_trackList:frontend.components.list.CustomList;

        internal var _dataProvider:feathers.data.ListCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class MyTracks
package frontend.screen.tracks.tabs 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class MyTracks extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function MyTracks()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MyTracks_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyTracks[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._MyTracks_ListLoader1_i()];
            this.addEventListener("addedToStage", this.___MyTracks_TabLayoutGroup1_addedToStage);
            this.addEventListener("initialize", this.___MyTracks_TabLayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _trackList():frontend.components.list.CustomList
        {
            return this._759336182_trackList;
        }

        internal function set _trackList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._759336182_trackList;
            if (loc1 !== arg1) 
            {
                this._759336182_trackList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_trackList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _dataProvider():feathers.data.ListCollection
        {
            return this._1763739238_dataProvider;
        }

        public function get trackList():frontend.components.list.CustomList
        {
            return this._trackList;
        }

        internal function set _dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1763739238_dataProvider;
            if (loc1 !== arg1) 
            {
                this._1763739238_dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            MyTracks._watcherSetupUtil = arg1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this._trackList = new frontend.components.list.CustomList();
            this._trackList.allowMultipleSelection = false;
            this._trackList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._trackList.dataProvider = this._dataProvider;
            this._trackList.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this._trackList.itemRendererFactory = this.trackListItemRendererUpload;
            this._trackList.width = SIGMALink.appWidth;
            this._trackList.addEventListener(starling.events.Event.TRIGGERED, this.triggeredHandler);
            this.currentSortField = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD, core.route.Route.COL_MODIFICATION_DATE);
            this.currentAscending = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.TRACKS_SORT_ASCENDING, false);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.UPDATE, this.updateTrack);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD, this.loadTracks);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, this.deleteTrack);
            this.loadTracks();
            return;
        }

        internal function trackListItemRendererUpload():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.tracks.tabs.list.MyTracksRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.tracks.tabs.list.MyTracksListItem):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":false, "track":arg1.track}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._trackList.selectedItem = null;
            this.listLoader.setNormalState();
            return;
        }

        internal function loadTracks(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent=null):void
        {
            this.listLoader.startLoading();
            var loc1:*=core.route.Route.statementGetRoutes(0, this.currentSortField, this.currentAscending);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadTracksComplete, this.loadTracksError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadTracksComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            this._dataProvider = new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new core.route.Route();
                loc4.fromDB(loc1[loc2]);
                loc5 = new frontend.screen.tracks.tabs.list.MyTracksListItem();
                loc5.GUID = loc4.GUID;
                loc5.track = loc4;
                loc5.icon = null;
                loc5.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc4.distance));
                loc5.distanceUnit = backend.utils.DataUtils.unitStringDistance;
                loc5.altitude = backend.utils.DataUtils.altitudeFormatter.format(backend.utils.DataUtils.altitudeConverter.convert(loc4.altitudeDifferencesUphill));
                loc5.altitudeUnit = backend.utils.DataUtils.unitStringAltitude;
                this._dataProvider.push(loc5);
                ++loc2;
            }
            if (this.contentLoadedCallback != null) 
            {
                this.contentLoadedCallback();
            }
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.stopLoading();
            this.listLoader.setNormalState();
            this.listLoader.checkDataProvider();
            return;
        }

        internal function loadTracksError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadTracksError");
            this.listLoader.stopLoading();
            return;
        }

        public function updateTrack(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent):void
        {
            if (!arg1.route) 
            {
                return;
            }
            this._routeToFocus = arg1.route;
            this.contentLoadedCallback = this.focusListItem;
            this.loadTracks();
            return;
        }

        internal function focusListItem():void
        {
            var loc1:*=this.getRouteIndex(this._routeToFocus);
            if (loc1 != -1) 
            {
                this._trackList.scrollToDisplayIndex(loc1);
            }
            this._routeToFocus = null;
            this.contentLoadedCallback = null;
            return;
        }

        public function deleteTrack(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent):void
        {
            if (!arg1.route) 
            {
                return;
            }
            var loc1:*=this.getRouteIndex(arg1.route);
            if (loc1 != -1) 
            {
                this._dataProvider.removeItemAt(loc1);
            }
            this.listLoader.checkDataProvider();
            return;
        }

        internal function getRouteIndex(arg1:core.route.Route):int
        {
            var loc2:*=0;
            var loc1:*=-1;
            var loc3:*=this._dataProvider.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (this._dataProvider.getItemAt(loc2).GUID == arg1.GUID) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            var loc1:*=(arg1.data as frontend.screen.tracks.tabs.list.MyTracksListItem).track as core.route.Route;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRACKDETAIL, {"myRoute":loc1}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public function sortList(arg1:frontend.components.list.ListSortItem):void
        {
            this.currentSortField = arg1.sortField;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD, this.currentSortField);
            this.currentAscending = arg1.ascending;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.TRACKS_SORT_ASCENDING, this.currentAscending);
            this.loadTracks();
            return;
        }

        internal function _MyTracks_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___MyTracks_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___MyTracks_TabLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _MyTracks_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "listLoader.height")
            result[2] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _trackList;
            }, null, "listLoader.list")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
        }

        public static const TAB_NAME:String="TAB_MYTRACKS";

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var contentLoadedCallback:Function;

        public var currentAscending:Boolean;

        public var currentSortField:String;

        internal var _759336182_trackList:frontend.components.list.CustomList;

        internal var _1763739238_dataProvider:feathers.data.ListCollection;

        internal var _routeToFocus:core.route.Route;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class Tracks
package frontend.screen.tracks 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import backend.utils.gps.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.popup.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.component.*;
    import frontend.screen.tracks.tabs.*;
    import frontend.screen.tracks.tabs.gpsies.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class Tracks extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function Tracks()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonEdit = new frontend.components.button.IconButton();
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.buttonSearch = new frontend.components.button.IconButton();
            this.buttonSort = new frontend.components.button.IconButton();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._Tracks_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_TracksWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return Tracks[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._Tracks_TabContainer1_i(), this._Tracks_Footer1_i()];
            this.addEventListener("addedToStage", this.___Tracks_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___Tracks_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___Tracks_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onGPSStatusChanged(arg1:starling.events.Event):void
        {
            this.gpsiesTracksTab.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            return;
        }

        internal function validateFooter():void
        {
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.myTracksTab:
                {
                    this.setMyTrackFooterButtons();
                    if (this.myTracksTab.trackList.dataProvider) 
                    {
                        this.buttonSort.isEnabled = this.myTracksTab.trackList.dataProvider.length > 1;
                        this.buttonEdit.isEnabled = this.myTracksTab.trackList.dataProvider.length > 0;
                    }
                    else 
                    {
                        this.buttonSort.isEnabled = false;
                        this.buttonEdit.isEnabled = false;
                    }
                    break;
                }
                case this.gpsiesTracksTab:
                {
                    this.setGPSiesFooterButtons();
                    if (this.gpsiesTracksTab.trackList.dataProvider) 
                    {
                        this.buttonSort.isEnabled = this.gpsiesTracksTab.trackList.dataProvider.length > 1;
                    }
                    else 
                    {
                        this.buttonSort.isEnabled = false;
                    }
                    break;
                }
            }
            return;
        }

        internal function setMyTrackFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myTracksTab.listLoader.listStateHandler.editState) 
            {
                this.myTracksTab.listLoader.noDataIconButtonAnchor = null;
                this.buttonGroup.push(this.buttonDelete);
                this.buttonGroup.push(this.buttonCancel);
            }
            else 
            {
                this.myTracksTab.listLoader.noDataText = utils.LanguageManager.getString("NO_DATA_TRACKS");
                this.myTracksTab.listLoader.noDataIconButtonAnchor = this.buttonDownload;
                this.buttonGroup.push(this.buttonDownload);
                this.buttonGroup.push(this.buttonSort);
                this.buttonGroup.push(this.buttonEdit);
            }
            this.footer.showBackButton = !this.myTracksTab.listLoader.listStateHandler.editState;
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.buttonSort = new frontend.components.button.IconButton();
            this.buttonSort.image = frontend.Textures.sortbutton;
            this.buttonSort.touchHandler = this.footerSortButtonHandler;
            this.buttonEdit = new frontend.components.button.IconButton();
            this.buttonEdit.image = frontend.Textures.editbutton;
            this.buttonEdit.touchHandler = this.footerEditButtonClicked;
            this.buttonSearch = new frontend.components.button.IconButton();
            this.buttonSearch.image = frontend.Textures.lupe_white;
            this.buttonSearch.touchHandler = this.footerSearchButtonHandler;
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDelete.image = frontend.Textures.trashicon;
            this.buttonDelete.touchHandler = this.footerDeleteButtonHandler;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonCancel.image = frontend.Textures.closeicon;
            this.buttonCancel.touchHandler = this.footerCancelButtonHandler;
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonDownload.image = frontend.Textures.downloadbutton;
            this.buttonDownload.touchHandler = this.footerDownloadButtonHandler;
            this.validateTabs();
            return;
        }

        internal function onAddedToStage():void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSStatusChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSStatusChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            this.myTracksTab.listLoader.setNormalState();
            this.validateFooter();
            return;
        }

        internal function setGPSiesFooterButtons():void
        {
            this.gpsiesTracksTab.listLoader.noDataIconButtonAnchor = null;
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.buttonGroup.push(this.buttonSort);
            this.buttonGroup.push(this.buttonSearch);
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function onRemovedFromStage():void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSStatusChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSStatusChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            return;
        }

        internal function validateTabs():void
        {
            this.tracksTabbar.removeTabs();
            this.myTracksTab = new frontend.screen.tracks.tabs.MyTracks();
            this.tracksTabbar.addTab(this.myTracksTab, true);
            this.myTracksTab.showContent();
            this.myTracksTab.contentLoadedCallback = this.onContentLoadedCallback;
            this.gpsiesTracksTab = new frontend.screen.tracks.tabs.GPSies();
            this.gpsiesTracksTab.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this.tracksTabbar.addTab(this.gpsiesTracksTab);
            return;
        }

        internal function onContentLoadedCallback():void
        {
            this.myTracksTab.contentLoadedCallback = null;
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            if (this.selectedTab == this.gpsiesTracksTab && this._initialGPSiesSearchFlag) 
            {
                this._initialGPSiesSearchFlag = false;
                backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onLocationChanged);
                backend.utils.gps.GeoLocationHelper.getInstance().updateGPSPosition();
            }
            this.myTracksTab.listLoader.setNormalState();
            this.validateFooter();
            return;
        }

        internal function onLocationChanged(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onLocationChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().searchTracks();
            return;
        }

        internal function onTracksChanged(arg1:starling.events.Event):void
        {
            this.validateFooter();
            return;
        }

        protected function footerSortButtonHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc1:*=new Vector.<frontend.components.list.ListSortItem>();
            if (this.selectedTab != this.myTracksTab) 
            {
                if (this.gpsiesTracksTab) 
                {
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_NAME, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_MODIFICATION_DATE, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.DISTANCE"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.LOCATION"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE_TO_TRACK, true));
                    loc2 = new frontend.components.popup.SortPopUp(loc1, this.gpsiesTracksTab.currentSortField, this.gpsiesTracksTab.currentAscending);
                    loc2.sortCallback = this.gpsiesTracksTab.sortList;
                }
            }
            else 
            {
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), core.route.Route.COL_NAME, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), core.route.Route.COL_MODIFICATION_DATE, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.DISTANCE"), core.route.Route.COL_DISTANCE, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.ALTI_UP"), core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, true));
                loc2 = new frontend.components.popup.SortPopUp(loc1, this.myTracksTab.currentSortField, this.myTracksTab.currentAscending);
                loc2.sortCallback = this.myTracksTab.sortList;
            }
            if (loc2) 
            {
                frontend.components.popup.PopUpBase.showModalPopUp(loc2, true, true, false, true);
            }
            return;
        }

        internal function footerEditButtonClicked(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerEditButtonClicked");
            if (this.selectedTab == this.myTracksTab) 
            {
                this.myTracksTab.listLoader.swapState();
                this.setMyTrackFooterButtons();
            }
            return;
        }

        internal function footerSearchButtonHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerSearchButtonHandler");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_GPSIES_SEARCH, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function footerDeleteButtonHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc3:*=null;
            this._selectedTracks = new Vector.<frontend.screen.tracks.tabs.list.MyTracksListItem>();
            var loc2:*=this.myTracksTab.trackList.dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.myTracksTab.trackList.dataProvider.data[loc1] as frontend.screen.tracks.tabs.list.MyTracksListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    this._selectedTracks.push(loc3);
                }
                ++loc1;
            }
            if (this._selectedTracks.length > 0) 
            {
                if (!this.deletePopUp) 
                {
                    this.deletePopUp = new frontend.components.popup.DeletePopUp();
                    this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACKS_TITLE");
                    this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACKS_TEXT");
                    this.deletePopUp.cancelCallback = this.onPopUpClose;
                    this.deletePopUp.deleteCallback = this.onPopUpDelete;
                }
            }
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=this._selectedTracks.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this._selectedTracks[loc1] as frontend.screen.tracks.tabs.list.MyTracksListItem;
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.Route.prepareDelete(loc3.track.GUID), this.onDeleteTracksComplete, this.onDeleteTracksError, Workers.worker_DatabaseWorker, loc3);
                ++loc1;
            }
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            this.myTracksTab.listLoader.swapState();
            this.setMyTrackFooterButtons();
            return;
        }

        internal function onDeleteTracksComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.info("Track wurde gelöscht.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            this.myTracksTab.trackList.dataProvider.removeItem(loc1);
            var loc2:*=new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, loc1.track);
            handler.RouteHandler.getInstance().dispatchEvent(loc2);
            loc1.removeSelection();
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function onDeleteTracksError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Track konnte nicht gelöscht werden.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            loc1.removeSelection();
            return;
        }

        internal function footerCancelButtonHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerCancelButtonHandler");
            this.myTracksTab.listLoader.swapState();
            this.setMyTrackFooterButtons();
            return;
        }

        internal function footerDownloadButtonHandler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":true}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        internal function _Tracks_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = false;
            loc1.addEventListener("tabChanged", this.__tracksTabbar_tabChanged);
            loc1.id = "tracksTabbar";
            this.tracksTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tracksTabbar", this.tracksTabbar);
            return loc1;
        }

        public function __tracksTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        internal function _Tracks_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___Tracks_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___Tracks_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___Tracks_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _Tracks_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "tracksTabbar.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tracksTabbar.width")
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tracksTabbar():frontend.components.tab.TabContainer
        {
            return this._1946662662tracksTabbar;
        }

        public function set tracksTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1946662662tracksTabbar;
            if (loc1 !== arg1) 
            {
                this._1946662662tracksTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tracksTabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            Tracks._watcherSetupUtil = arg1;
            return;
        }

        internal var buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var buttonSearch:frontend.components.button.IconButton;

        internal var buttonSort:frontend.components.button.IconButton;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var gpsiesTracksTab:frontend.screen.tracks.tabs.GPSies;

        internal var myTracksTab:frontend.screen.tracks.tabs.MyTracks;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var buttonDelete:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1946662662tracksTabbar:frontend.components.tab.TabContainer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _initialGPSiesSearchFlag:Boolean=true;

        internal var _selectedTracks:__AS3__.vec.Vector.<frontend.screen.tracks.tabs.list.MyTracksListItem>;

        internal var buttonCancel:frontend.components.button.IconButton;

        internal var buttonDownload:frontend.components.button.IconButton;

        internal var buttonEdit:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


