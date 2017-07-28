//package gpsies
//  class GPSiesHandler
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


//  class GPSiesSearch
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


//  class GPSiesSearchResult
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


//  class GPSiesTrackRenderer
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


//  class GPSiesURLLoader
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


//  class GPSiesURLStream
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


