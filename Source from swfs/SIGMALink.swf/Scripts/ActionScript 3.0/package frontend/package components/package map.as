//package map
//  class GeoUtils
package frontend.components.map 
{
    import flash.geom.*;
    
    public class GeoUtils extends Object
    {
        public function GeoUtils()
        {
            super();
            return;
        }

        public static function x2lon(arg1:Number):Number
        {
            return arg1 * C_LONGITUDE - 180;
        }

        public static function lon2x(arg1:Number):Number
        {
            return (arg1 + 180) / C_LONGITUDE;
        }

        public static function y2lat(arg1:Number):Number
        {
            return Math.atan(sinh(PI - C_LATITUDE * arg1)) * RAD_DEG;
        }

        public static function lat2y(arg1:Number):Number
        {
            var loc1:*=arg1 * DEG_RAD;
            return (1 - Math.log(Math.tan(loc1) + 1 / Math.cos(loc1)) / PI) * C_LATITUDE2;
        }

        public static function sinh(arg1:Number):Number
        {
            return (Math.exp(arg1) - Math.exp(-arg1)) / 2;
        }

        public static function distance(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=Math.cos(arg2) * Math.cos(arg4) * Math.cos(arg3 - arg1) + Math.sin(arg2) * Math.sin(arg4);
            return loc1 > 1 ? 0 : EARTH_RADIUS * Math.acos(loc1);
        }

        public static function distanceDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return distance(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4 * DEG_RAD);
        }

        public static function destination(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=arg4 / EARTH_RADIUS;
            var loc2:*=Math.asin(Math.sin(arg2) * Math.cos(loc1) + Math.cos(arg2) * Math.sin(loc1) * Math.cos(arg3));
            var loc3:*=arg1 + Math.atan2(Math.sin(arg3) * Math.sin(loc1) * Math.cos(arg2), Math.cos(loc1) - Math.sin(arg2) * Math.sin(loc2));
            return new flash.geom.Point(loc3, loc2);
        }

        public static function destionationDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=destination(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4);
            loc1.x = loc1.x * RAD_DEG;
            loc1.y = loc1.y * RAD_DEG;
            return loc1;
        }

        public static function lonAtDistanceDeg(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return destionationDeg(arg1, arg2, 90, arg3).x;
        }

        public static function latAtDistanceDeg(arg1:Number, arg2:Number):Number
        {
            arg1 = arg1 * DEG_RAD;
            var loc1:*=arg2 / EARTH_RADIUS;
            return Math.asin(Math.sin(arg1) * Math.cos(loc1) + Math.cos(arg1) * Math.sin(loc1)) * RAD_DEG;
        }

        public static function pixelsPerMeter(arg1:Number):Number
        {
            var loc1:*=lat2y(arg1) - lat2y(Math.asin(Math.sin(arg1 * DEG_RAD) * COS_1_EARTH_RADIUS + Math.cos(arg1 * DEG_RAD) * SIN_1_EARTH_RADIUS) * RAD_DEG);
            return loc1 < 0 ? -loc1 : loc1;
        }

        public static function pixelPerMeterByCenter(arg1:flash.geom.Point):Number
        {
            return pixelsPerMeter(y2lat(arg1.y));
        }

        public static function pixelsPerMeterPrecise(arg1:Number, arg2:Number):Number
        {
            var loc1:*=destionationDeg(arg1, arg2, 45, 1);
            var loc2:*=lon2x(arg1) - lon2x(loc1.x);
            var loc3:*=lat2y(arg2) - lat2y(loc1.y);
            return Math.sqrt(loc2 * loc2 + loc3 * loc3);
        }

        public static const DEG_RAD:Number=PI / 180;

        public static const EARTH_RADIUS:uint=6371000;

        public static const MAX_LATITUDE:uint=67108864;

        public static const MAX_LONGITUDE:uint=67108864;

        public static const RAD_DEG:Number=180 / PI;

        internal static const COS_1_EARTH_RADIUS:Number=Math.cos(1 / EARTH_RADIUS);

        internal static const C_LATITUDE:Number=2 * PI / MAX_LATITUDE;

        internal static const C_LATITUDE2:Number=MAX_LATITUDE / 2;

        internal static const C_LONGITUDE:Number=360 / MAX_LONGITUDE;

        internal static const PI:Number=Math.PI;

        internal static const SIN_1_EARTH_RADIUS:Number=Math.sin(1 / EARTH_RADIUS);
    }
}


//  class LoaderOptimizer
package frontend.components.map 
{
    import com.adobe.images.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import helper.*;
    
    public class LoaderOptimizer extends Object
    {
        public function LoaderOptimizer(arg1:frontend.components.map.URLRequestBuffer=null)
        {
            this.created = new flash.utils.Dictionary(true);
            this.released = new flash.utils.Dictionary(true);
            super();
            this.buffer = arg1 ? arg1 : new frontend.components.map.URLRequestBuffer(6, 15000);
            helper.File_helper.createDirIfNotExist(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY);
            return;
        }

        internal function xyzByUrlString(arg1:String):frontend.components.map.MapXyzPartition
        {
            if (arg1 == null || arg1.length <= 0) 
            {
                return null;
            }
            var loc1:*=arg1;
            var loc2:*=loc1.replace(frontend.components.map.MapLayerOptions.URL_MAP, "");
            var loc3:*=loc2.split("/");
            var loc4:*=loc3.pop();
            var loc5:*=loc3.pop();
            var loc6:*=loc3.pop();
            return new frontend.components.map.MapXyzPartition(loc6, loc5, loc4);
        }

        public function load(arg1:flash.net.URLRequest, arg2:flash.system.LoaderContext):flash.display.Loader
        {
            var loc2:*=null;
            var loc3:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = this.xyzByUrlString(arg1.url);
                if (loc2) 
                {
                    loc3 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc2.getPath());
                    if (loc3.exists) 
                    {
                        arg1.url = loc3.url;
                    }
                }
            }
            var loc1:*=this.createLoader();
            this.buffer.push(loc1, arg1, arg2);
            return loc1;
        }

        public function release(arg1:flash.display.Loader):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = arg1.contentLoaderInfo.url;
                if (loc2 && loc2.substr(0, 4) == "http") 
                {
                    loc3 = this.xyzByUrlString(loc2);
                    if (loc3) 
                    {
                        loc4 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc3.getPath());
                        if (!loc4.exists) 
                        {
                            loc5 = com.adobe.images.PNGEncoder.encode((arg1.contentLoaderInfo.content as flash.display.Bitmap).bitmapData);
                            loc6 = new flash.filesystem.FileStream();
                            loc6.open(loc4, flash.filesystem.FileMode.WRITE);
                            loc6.writeBytes(loc5, 0, loc5.length);
                            loc6.close();
                        }
                    }
                }
            }
            loc1 = this.buffer.getWaitingByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeWaitingById(loc1.id);
            }
            loc1 = this.buffer.getActiveByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeActiveById(loc1.id);
            }
            else if (this.released) 
            {
                this.removeLoaderListeners(arg1);
                this.released[arg1] = true;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.created;
            for (loc1 in loc4) 
            {
                loc2 = loc1 as flash.display.Loader;
                this.release(loc2);
                this.removeLoaderListeners(loc2);
                loc2.unloadAndStop(true);
            }
            this.created = null;
            this.released = null;
            this.buffer = null;
            return;
        }

        internal function removeLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false);
            arg1.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false);
            return;
        }

        internal function addLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false, -10, true);
            arg1.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false, -10, true);
            return;
        }

        internal function createLoader():flash.display.Loader
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.released;
            for (loc2 in loc4) 
            {
                loc1 = loc2 as flash.display.Loader;
                delete this.released[loc1];
                break;
            }
            if (!loc1) 
            {
                loc1 = new flash.display.Loader();
                this.created[loc1] = true;
            }
            this.addLoaderListeners(loc1);
            return loc1;
        }

        internal function onLoaderComplete(arg1:flash.events.Event):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal function onLoaderIOError(arg1:flash.events.IOErrorEvent):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal var buffer:frontend.components.map.URLRequestBuffer;

        internal var created:flash.utils.Dictionary;

        internal var released:flash.utils.Dictionary;
    }
}


//  class MapHelperMain
package frontend.components.map 
{
    import __AS3__.vec.*;
    import configCache.*;
    import flash.events.*;
    import flash.geom.*;
    import handler.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.managers.*;
    import sk.yoz.ycanvas.map.partitions.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.display.*;
    import starling.events.*;
    
    public class MapHelperMain extends Object
    {
        public function MapHelperMain(arg1:Number, arg2:Number)
        {
            super();
            sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_TILE_SCALE = SIGMALink.scaleFactor;
            sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS = 0.1;
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.Transformation();
            loc1.centerX = frontend.components.map.GeoUtils.lon2x(arg2);
            loc1.centerY = frontend.components.map.GeoUtils.lat2y(arg1);
            loc1.rotation = 0;
            loc1.scale = 1;
            var loc2:*=new sk.yoz.ycanvas.map.valueObjects.Limit();
            loc2.minScale = SIGMALink.scaleFactor;
            loc2.maxScale = 1 / 65536;
            this.strokeLayer = new sk.yoz.ycanvas.map.display.StrokeLayer();
            this.strokeLayer.autoUpdateThickness = true;
            this.markerLayer = new sk.yoz.ycanvas.map.display.MarkerLayer();
            var loc3:*=createMapConfig();
            var loc4:*=new frontend.components.map.PartitionLoader();
            var loc5:*=new flash.events.EventDispatcher();
            this.map = new sk.yoz.ycanvas.map.YCanvasMap(loc3, loc1, TILE_WIDTH, 3);
            this.map.partitionFactory = new sk.yoz.ycanvas.map.partitions.PartitionFactory(loc3, loc5, loc4);
            this.map.addEventListener(sk.yoz.ycanvas.map.events.CanvasEvent.TRANSFORMATION_FINISHED, this.onMapTransformationFinished);
            this.map.addMapLayer(this.strokeLayer);
            this.map.addMapLayer(this.markerLayer);
            if (this.map.config.forTouch) 
            {
                this.transformationManager = new sk.yoz.ycanvas.map.managers.TouchTransformationManager(this.map, loc2);
            }
            else 
            {
                this.transformationManager = new sk.yoz.ycanvas.map.managers.MouseTransformationManager(this.map, loc2);
            }
            return;
        }

        public function updateCenter(arg1:Number, arg2:Number):void
        {
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.Transformation();
            loc1.centerX = frontend.components.map.GeoUtils.lon2x(arg2);
            loc1.centerY = frontend.components.map.GeoUtils.lat2y(arg1);
            loc1.rotation = 0;
            loc1.scale = 1;
            this.map.center = new flash.geom.Point(loc1.centerX, loc1.centerY);
            this.map.scale = loc1.scale;
            this.map.rotation = loc1.rotation;
            return;
        }

        public function updateConfig():void
        {
            this.map.config = createMapConfig();
            this.map.render();
            return;
        }

        public function addTouchEvents():void
        {
            this.transformationManager.allowMove = true;
            this.transformationManager.allowZoom = true;
            this.transformationManager.allowRotate = false;
            return;
        }

        public function removeTouchEvents():void
        {
            this.transformationManager.allowMove = false;
            this.transformationManager.allowZoom = false;
            this.transformationManager.allowRotate = false;
            return;
        }

        public function addMarkerTouchEvent():void
        {
            this.markerLayer.addEventListener(starling.events.TouchEvent.TOUCH, this.onMarkerLayerTouch);
            return;
        }

        public function dispose():void
        {
            this.markerLayer.removeEventListener(starling.events.TouchEvent.TOUCH, this.onMarkerLayerTouch);
            this.map.removeEventListener(sk.yoz.ycanvas.map.events.CanvasEvent.TRANSFORMATION_FINISHED, this.onMapTransformationFinished);
            this.map.dispose();
            this.map = null;
            this.removeTouchEvents();
            this.transformationManager.dispose();
            this.transformationManager = null;
            this.strokeLayer = null;
            this.markerLayer = null;
            return;
        }

        internal function onMapTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            if (!this.strokeLayer.autoUpdateThickness) 
            {
                this.strokeLayer.updateThickness();
            }
            return;
        }

        internal function onMarkerLayerTouch(arg1:starling.events.TouchEvent):void
        {
            if (arg1.getTouch(this.map.display, starling.events.TouchPhase.ENDED)) 
            {
                if (this.markerTouchFunction != null) 
                {
                    this.markerTouchFunction(arg1.target as starling.display.DisplayObject);
                }
            }
            return;
        }

        public static function get LAYER_CACHE_SUBDIR():String
        {
            _LAYER_CACHE_SUBDIR = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_LAYER_CACHE_SUBDIR, frontend.components.map.MapLayerOptions.URL_DEFAULT);
            return _LAYER_CACHE_SUBDIR;
        }

        public static function set LAYER_CACHE_SUBDIR(arg1:String):void
        {
            _LAYER_CACHE_SUBDIR = arg1;
            configCache.ConfigCache.getInstance().setValue(frontend.components.map.MapLayerOptions.CONFIG_LAYER_CACHE_SUBDIR, arg1);
            return;
        }

        public static function get LAYER_OPTION():String
        {
            _LAYER_OPTION = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_ID, frontend.components.map.MapLayerOptions.URL_MAP + frontend.components.map.MapLayerOptions.URL_DEFAULT);
            return _LAYER_OPTION;
        }

        public static function set LAYER_OPTION(arg1:String):void
        {
            _LAYER_OPTION = arg1;
            configCache.ConfigCache.getInstance().setValue(frontend.components.map.MapLayerOptions.CONFIG_ID, arg1);
            return;
        }

        internal static function createMapConfig():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.MapConfig();
            loc1.urlTemplates = Vector.<String>([frontend.components.map.MapLayerOptions.getLayerURL(LAYER_OPTION)]);
            loc1.tileWidth = TILE_WIDTH;
            loc1.tileHeight = TILE_WIDTH;
            loc1.forTouch = !handler.ApplicationHandler.isSimulator;
            return loc1;
        }

        internal static const TILE_WIDTH:Number=256;

        public var map:sk.yoz.ycanvas.map.YCanvasMap;

        public var markerLayer:sk.yoz.ycanvas.map.display.MarkerLayer;

        public var markerTouchFunction:Function;

        public var strokeLayer:sk.yoz.ycanvas.map.display.StrokeLayer;

        public var transformationManager:sk.yoz.ycanvas.map.managers.AbstractTransformationManager;

        internal static var _LAYER_CACHE_SUBDIR:String;

        internal static var _LAYER_OPTION:String;
    }
}


//  class MapLayerOptions
package frontend.components.map 
{
    import __AS3__.vec.*;
    import configCache.*;
    import flash.filesystem.*;
    import utils.*;
    
    public class MapLayerOptions extends Object
    {
        public function MapLayerOptions()
        {
            super();
            return;
        }

        public static function get BASE_CACHE_DIRECTORY():String
        {
            return flash.filesystem.File.cacheDirectory.nativePath + "/mapcache/";
        }

        public static function get CACHE_DIRECTORY():String
        {
            return BASE_CACHE_DIRECTORY + frontend.components.map.MapHelperMain.LAYER_CACHE_SUBDIR + "/";
        }

        public static function get CACHING_ENABLED():Boolean
        {
            return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ENABLE_MAP_CACHING, true) as Boolean;
        }

        public static function getLayerVector():__AS3__.vec.Vector.<Object>
        {
            var loc1:*=new Vector.<Object>();
            var loc2:*=new Object();
            loc2.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT");
            loc2.data = URL_MAP + URL_DEFAULT;
            loc2.layer = URL_DEFAULT;
            loc1.push(loc2);
            var loc3:*=new Object();
            loc3.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING");
            loc3.data = URL_MAP + URL_DEFAULT_HILLSHADING;
            loc3.layer = URL_DEFAULT_HILLSHADING;
            loc1.push(loc3);
            var loc4:*=new Object();
            loc4.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_ALTITUDE_LAYER");
            loc4.data = URL_MAP + URL_DEFAULT_ALTITUDE_LAYER;
            loc4.layer = URL_DEFAULT_ALTITUDE_LAYER;
            loc1.push(loc4);
            var loc5:*=new Object();
            loc5.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_CYCLEWAYS");
            loc5.data = URL_MAP + URL_DEFAULT_CYCLEWAYS;
            loc5.layer = URL_DEFAULT_CYCLEWAYS;
            loc1.push(loc5);
            var loc6:*=new Object();
            loc6.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_ALTITUDE");
            loc6.data = URL_MAP + URL_DEFAULT_HILLSHADING_ALTITUDE;
            loc6.layer = URL_DEFAULT_HILLSHADING_ALTITUDE;
            loc1.push(loc6);
            var loc7:*=new Object();
            loc7.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_CYCLEWAYS");
            loc7.data = URL_MAP + URL_DEFAULT_HILLSHADING_CYCLEWAYS;
            loc7.layer = URL_DEFAULT_HILLSHADING_CYCLEWAYS;
            loc1.push(loc7);
            var loc8:*=new Object();
            loc8.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_ALTITUDE_CYCLEWAYS");
            loc8.data = URL_MAP + URL_DEFAULT_ALTITUDE_CYCLEWAYS;
            loc8.layer = URL_DEFAULT_ALTITUDE_CYCLEWAYS;
            loc1.push(loc8);
            var loc9:*=new Object();
            loc9.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS");
            loc9.data = URL_MAP + URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS;
            loc9.layer = URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS;
            loc1.push(loc9);
            var loc10:*=new Object();
            loc10.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_MAPBOX");
            loc10.data = URL_MAP_BOX;
            loc10.layer = URL_DEFAULT_MAP_BOX_LAYERDIR;
            loc1.push(loc10);
            return loc1;
        }

        public static function getLayerURL(arg1:String):Array
        {
            var loc1:*=[];
            var loc2:*="${z}/${x}/${y}.png";
            loc1.push(arg1 + loc2);
            return loc1;
        }

        public static const ALTITUDE_LINES:String="AltitudeLines";

        public static const BING_MAP:String="SatteliteBing";

        public static const CONFIG_ID:String="mapLayer";

        public static const CONFIG_LAYER_CACHE_SUBDIR:String="mapLayerCacheSubDir";

        public static const CYCLEWAYS:String="Cycleways";

        public static const DEFAULT:String="Default";

        public static const HILLSHADING:String="Hillshading";

        public static const MAP_BOX_SATTELITE:String="SatteliteMapBox";

        public static const MAP_LIST_GPSIES_TRACKS:String="gpsiesTracks";

        public static const MAP_LIST_OWN_TRACKS:String="ownTracks";

        public static const OVERLAY_CYCLEWAYS:String="OverlayCycleways";

        public static const OVERLAY_NONE:String="OverlayNone";

        public static const OVERLAY_STREETS:String="OverlayStreets";

        public static const URL_DEFAULT:String="layer1/";

        public static const URL_DEFAULT_ALTITUDE_CYCLEWAYS:String="layer7/";

        public static const URL_DEFAULT_ALTITUDE_LAYER:String="layer3/";

        public static const URL_DEFAULT_CYCLEWAYS:String="layer4/";

        public static const URL_DEFAULT_HILLSHADING:String="layer2/";

        public static const URL_DEFAULT_HILLSHADING_ALTITUDE:String="layer5/";

        public static const URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS:String="layer8/";

        public static const URL_DEFAULT_HILLSHADING_CYCLEWAYS:String="layer6/";

        public static const URL_DEFAULT_MAP_BOX_LAYERDIR:String="mapbox/";

        public static const URL_MAP:String="https://tiles1.sigma-dc-control.com/";

        public static const URL_MAP_BOX:String="https://api.tiles.mapbox.com/v2/sigmasport.map-ivt2yzq4/";

        public static const URL_MAP_BOX_STREET:String="layer9/";
    }
}


//  class MapView
package frontend.components.map 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import handler.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.managers.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import utils.*;
    
    public class MapView extends feathers.controls.LayoutGroup
    {
        public function MapView()
        {
            super();
            layout = new feathers.layout.AnchorLayout();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        public function focusTrack():void
        {
            if (this.track) 
            {
                this.focusElement(this.track);
            }
            return;
        }

        public function showStartMarker(arg1:Number, arg2:Number):void
        {
            if (!this.startMarker) 
            {
                this.startMarker = this.createMarker(frontend.Textures.mapstarticon, arg1, arg2);
            }
            if (this.startMarker && !mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.add(this.startMarker);
            }
            return;
        }

        public function get mapLockActivated():Boolean
        {
            return this._mapLockActivated;
        }

        public function set mapLockActivated(arg1:Boolean):void
        {
            this._mapLockActivated = arg1;
            this.validateMapTouch();
            return;
        }

        public function showEndMarker(arg1:Number, arg2:Number):void
        {
            if (!this.endMarker) 
            {
                this.endMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.endMarker && !mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.add(this.endMarker);
            }
            return;
        }

        public function setPointNavigationMarker(arg1:Number, arg2:Number):void
        {
            if (!this.pointNavigationMarker) 
            {
                this.pointNavigationMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.pointNavigationMarker) 
            {
                if (mapMain.markerLayer.contains(this.pointNavigationMarker)) 
                {
                    this.updateMarkerPos(this.pointNavigationMarker as starling.display.Image, arg1, arg2);
                }
                else 
                {
                    mapMain.markerLayer.add(this.pointNavigationMarker);
                }
            }
            return;
        }

        public function showActivityMarkers(arg1:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc2:*=arg1.length;
            var loc4:*="";
            this._markerDic = new flash.utils.Dictionary();
            this._calloutDic = new flash.utils.Dictionary();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                var loc8:*=loc3.type;
                switch (loc8) 
                {
                    case core.general.MarkerType.LAP:
                    {
                        loc5 = frontend.Textures.maplapbubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                    case core.general.MarkerType.AUTO_LAP:
                    {
                        loc5 = frontend.Textures.autoLapBubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                }
                loc6 = this.createMarker(loc5, loc3.latitude, loc3.longitude, loc4);
                if (loc6) 
                {
                    mapMain.markerLayer.add(loc6);
                    this._markerDic[loc6] = loc3;
                    loc7 = this.createCallout(loc3);
                    if (loc7) 
                    {
                        mapMain.markerLayer.add(loc7);
                        this._calloutDic[loc6] = loc7;
                    }
                }
                ++loc1;
            }
            return;
        }

        public function setMapCenterToPointNavigation():void
        {
            if (!this.pointNavigationMarker) 
            {
                return;
            }
            mapMain.transformationManager.showBoundsTween(this.pointNavigationMarker.bounds.left, this.pointNavigationMarker.bounds.right, this.pointNavigationMarker.bounds.top, this.pointNavigationMarker.bounds.bottom + this.pointNavigationMarker.height);
            return;
        }

        internal function createMarker(arg1:String, arg2:Number, arg3:Number, arg4:String=""):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (arg2 == 0 && arg3 == 0) 
            {
                return null;
            }
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(arg1);
            if (loc1) 
            {
                loc3 = new starling.display.Image(loc1);
                if (arg4 == "") 
                {
                    loc2 = loc3;
                }
                else 
                {
                    loc4 = new feathers.controls.Label();
                    loc4.text = arg4;
                    loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                    loc5 = new feathers.controls.LayoutGroup();
                    loc5.touchGroup = true;
                    loc5.addChild(loc3);
                    loc5.addChild(loc4);
                    loc4.validate();
                    loc4.x = (loc1.width - loc4.width) / 2;
                    loc4.y = 8 * SIGMALink.scaleFactor;
                    loc2 = loc5;
                }
            }
            loc2.x = frontend.components.map.GeoUtils.lon2x(arg3);
            loc2.y = frontend.components.map.GeoUtils.lat2y(arg2);
            loc2.pivotX = loc1.width / 2;
            loc2.pivotY = loc1.height;
            return loc2;
        }

        internal function updateMarkerPos(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number):void
        {
            arg1.x = frontend.components.map.GeoUtils.lon2x(arg3);
            arg1.y = frontend.components.map.GeoUtils.lat2y(arg2);
            if (arg1 is starling.display.Image) 
            {
                arg1.pivotX = (arg1 as starling.display.Image).texture.width / 2;
                arg1.pivotY = (arg1 as starling.display.Image).texture.height;
            }
            return;
        }

        internal function createCallout(arg1:core.marker.Marker):starling.display.DisplayObject
        {
            var loc5:*=null;
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.markerPopUpBackground);
            var loc2:*=new flash.geom.Rectangle(loc1.width - BORDER_RADIUS * 2, BORDER_RADIUS, BORDER_RADIUS, loc1.height - BORDER_RADIUS - ARROW_HEIGHT);
            var loc3:*=SIGMALink.appWidth - 2 * OUTER_PADDING;
            var loc4:*=new starling.display.Image(loc1);
            loc4.scale9Grid = loc2;
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.layout = new feathers.layout.HorizontalLayout();
            (loc6.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc6.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc7:*=new feathers.controls.Label();
            loc7.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + (arg1.number + 1);
            loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            loc6.addChild(loc7);
            var loc8:*=new feathers.controls.LayoutGroup();
            loc8.layout = new feathers.layout.HorizontalLayout();
            (loc8.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc8.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc9:*=new feathers.controls.Label();
            loc9.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE");
            loc9.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc8.addChild(loc9);
            var loc10:*=new feathers.controls.Label();
            loc10.text = arg1.distanceOutputString;
            loc10.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc8.addChild(loc10);
            var loc11:*=new feathers.controls.Label();
            loc11.text = backend.utils.DataUtils.unitStringDistance;
            loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc8.addChild(loc11);
            loc8.validate();
            var loc12:*=new feathers.controls.LayoutGroup();
            loc12.layout = new feathers.layout.HorizontalLayout();
            (loc12.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).paddingBottom = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc13:*=new feathers.controls.Label();
            loc13.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAPTIME");
            loc13.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc12.addChild(loc13);
            var loc14:*=new feathers.controls.Label();
            loc14.text = arg1.timeOutputString;
            loc14.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc12.addChild(loc14);
            var loc15:*=new feathers.controls.Label();
            loc15.text = backend.utils.DataUtils.unitStringTimeHours;
            loc15.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc12.addChild(loc15);
            loc12.validate();
            var loc16:*=new feathers.layout.VerticalLayout();
            loc16.padding = 3 * BORDER_RADIUS;
            loc16.gap = 3 * BORDER_RADIUS;
            var loc17:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc18:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc19:*=new feathers.controls.LayoutGroup();
            loc19.layout = loc16;
            loc19.backgroundSkin = loc4;
            loc19.touchGroup = true;
            loc19.addChild(loc6);
            loc19.addChild(loc17);
            loc19.addChild(loc8);
            loc19.addChild(loc18);
            loc19.addChild(loc12);
            loc19.validate();
            var loc20:*=loc19.width - loc16.padding * 2 - (loc8.layout as feathers.layout.HorizontalLayout).gap * 2 - loc10.width - loc11.width;
            var loc21:*=loc19.width - loc16.padding * 2 - (loc12.layout as feathers.layout.HorizontalLayout).gap * 2 - loc14.width - loc15.width;
            var loc22:*=Math.max(loc20, loc21);
            var loc23:*=loc10.width;
            var loc24:*=loc14.width;
            var loc25:*=Math.max(loc23, loc24);
            var loc26:*=loc11.width;
            var loc27:*=loc15.width;
            var loc28:*=Math.max(loc26, loc27);
            loc9.width = loc22;
            loc10.width = loc25;
            loc13.width = loc22;
            loc14.width = loc25;
            var loc29:*;
            loc18.width = loc29 = loc22 + loc25 + loc28 + (loc8.layout as feathers.layout.HorizontalLayout).gap * 2;
            loc17.width = loc29;
            loc5 = loc19;
            loc5.x = frontend.components.map.GeoUtils.lon2x(arg1.longitude);
            loc5.y = frontend.components.map.GeoUtils.lat2y(arg1.latitude);
            loc5.pivotX = loc1.width / 2;
            loc5.pivotY = loc19.height;
            loc5.visible = false;
            return loc5;
        }

        internal function markerCallout(arg1:starling.display.DisplayObject):void
        {
            var loc3:*=null;
            if (!this._calloutDic) 
            {
                return;
            }
            if (!(this._currentCallout == null) && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            var loc1:*=this._calloutDic[arg1] as starling.display.DisplayObject;
            var loc2:*=this._markerDic[arg1] as core.marker.Marker;
            if (loc1) 
            {
                mapMain.markerLayer.swapChildrenAt(mapMain.markerLayer.getChildIndex(loc1), (mapMain.markerLayer.numChildren - 1));
                loc1.visible = true;
                this.focusElement(loc1);
                this._currentCallout = arg1;
            }
            else if (this.markerCalloutTouchCallback != null) 
            {
                loc3 = this._markerDic[this._currentCallout];
                this.markerCalloutTouchCallback(loc3);
            }
            return;
        }

        public function showControls():void
        {
            if (this.showLockButton) 
            {
                this.iconLockButton = new frontend.components.button.IconButton();
                this.iconLockButton.image = frontend.Textures.lockbutton;
                this.iconLockButton.touchHandler = this.onLockButtonTouch;
                this.iconLockButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING);
                addChild(this.iconLockButton);
            }
            if (this.showFocusButton) 
            {
                this.focusButton = new frontend.components.button.IconButton();
                this.focusButton.image = frontend.Textures.focusTrackButton;
                this.focusButton.touchHandler = this.onFocusButtonTouch;
                this.focusButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, PADDING);
                addChild(this.focusButton);
            }
            if (this.showLayerButton) 
            {
                this.layerButton = new frontend.components.button.IconButton();
                this.layerButton.image = frontend.Textures.mapLayerButton;
                this.layerButton.touchHandler = this.onLayerButtonTouch;
                this.layerButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, PADDING);
                addChild(this.layerButton);
            }
            if (this.showSearchButton) 
            {
                this.searchButton = new frontend.components.button.IconButton();
                this.searchButton.image = frontend.Textures.locationSearchIcon;
                this.searchButton.touchHandler = this.onSearchButtonTouch;
                this.searchButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, PADDING);
                addChild(this.searchButton);
            }
            if (this._validateMapTouchFlag) 
            {
                this.validateMapTouch();
            }
            return;
        }

        internal function removeTrack():void
        {
            if (this.track) 
            {
                if (mapMain.strokeLayer.contains(this.track)) 
                {
                    mapMain.strokeLayer.remove(this.track);
                }
                this.track.dispose();
                this.track = null;
            }
            return;
        }

        internal function removeMarkers():void
        {
            var loc1:*=undefined;
            if (this.startMarker && mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.remove(this.startMarker);
            }
            if (this.endMarker && mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.remove(this.endMarker);
            }
            if (this.pointNavigationMarker && mapMain.markerLayer.contains(this.pointNavigationMarker)) 
            {
                mapMain.markerLayer.remove(this.pointNavigationMarker);
            }
            var loc2:*=0;
            var loc3:*=this._markerDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(loc1);
                delete this._markerDic[loc1];
            }
            loc2 = 0;
            loc3 = this._calloutDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(this._calloutDic[loc1]);
                delete this._calloutDic[loc1];
            }
            this.startMarker = null;
            this.endMarker = null;
            return;
        }

        internal function removeMap():void
        {
            if (!mapMain) 
            {
                return;
            }
            this.mapLockActivated = false;
            removeChild(mapMain.map.display);
            mapMain.dispose();
            mapMain = null;
            return;
        }

        internal function removeControls():void
        {
            if (contains(this.iconLockButton)) 
            {
                removeChild(this.iconLockButton);
            }
            if (contains(this.focusButton)) 
            {
                removeChild(this.focusButton);
            }
            if (contains(this.layerButton)) 
            {
                removeChild(this.layerButton);
            }
            if (contains(this.zoomOutButton)) 
            {
                removeChild(this.zoomOutButton);
            }
            if (contains(this.zoomInButton)) 
            {
                removeChild(this.zoomInButton);
            }
            return;
        }

        internal function validateMapTouch():void
        {
            if (!mapMain) 
            {
                this._validateMapTouchFlag = true;
                return;
            }
            this._validateMapTouchFlag = false;
            if (this._mapLockActivated || this.leftMenuOpen) 
            {
                mapMain.removeTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.lockbutton;
                }
            }
            else 
            {
                mapMain.addTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.unlockbutton;
                }
            }
            dispatchEvent(new starling.events.Event(MAP_LOCK_CHANGED));
            return;
        }

        internal function onZoomInButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onZoomOutButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(1 / sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onLockButtonTouch(arg1:starling.events.TouchEvent):void
        {
            this.mapLockActivated = !this.mapLockActivated;
            return;
        }

        internal function onFocusButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapFocusCallback == null) 
            {
                this.focusElement(this.track);
            }
            else 
            {
                this.mapFocusCallback();
            }
            return;
        }

        internal function onLayerButtonTouch(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=new frontend.components.menuList.editors.SpinnerEditor();
            loc1.dataProvider = new feathers.data.ListCollection(frontend.components.map.MapLayerOptions.getLayerVector());
            loc1.owner = new frontend.components.menuList.MenuListItem();
            loc1.rawValue = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_ID, frontend.components.map.MapLayerOptions.DEFAULT);
            loc1.title = utils.LanguageManager.getString("LAYER_SELECT_POPUP_TITLE");
            loc1.saveCompleteCallback = this.onLayerSelectionChanged;
            frontend.components.popup.PopUpBase.showModalPopUp(loc1, true, false);
            return;
        }

        internal function onSearchButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapSearchCallback != null) 
            {
                this.mapSearchCallback();
            }
            return;
        }

        public function focusElement(arg1:starling.display.DisplayObject):void
        {
            if (!arg1) 
            {
                return;
            }
            var loc1:*=3000 * SIGMALink.scaleFactor;
            mapMain.transformationManager.showBoundsTween(arg1.bounds.left - loc1, arg1.bounds.right + loc1, arg1.bounds.top - loc1, arg1.bounds.bottom + loc1);
            return;
        }

        internal function mapTouchHandler(arg1:flash.events.MouseEvent):void
        {
            if (this._calloutDic && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            super.dispose();
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler, false, 100);
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = this.yStartCorrection;
            this.mapLockActivated = this.showLockButton ? true : false;
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = 0;
            this.removeTrack();
            this.removeMarkers();
            this.removeMap();
            this.removeControls();
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            return;
        }

        internal function onLeftMenuToggleChanged(arg1:starling.events.Event):void
        {
            this.leftMenuOpen = arg1.data as Boolean;
            this.validateStarlingClickEvent();
            return;
        }

        internal function validateStarlingClickEvent():void
        {
            if (this.leftMenuOpen) 
            {
                touchable = false;
                hideFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            }
            else 
            {
                touchable = true;
                showFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            }
            return;
        }

        public function showMap(arg1:Number, arg2:Number):void
        {
            if (mapMain) 
            {
                mapMain.dispose();
            }
            mapMain = new frontend.components.map.MapHelperMain(arg1, arg2);
            mapMain.map.display.width = width;
            mapMain.map.display.height = height;
            mapMain.markerTouchFunction = this.markerCallout;
            addChild(mapMain.map.display);
            mapMain.addMarkerTouchEvent();
            return;
        }

        public function getCenterLatitude():Number
        {
            return frontend.components.map.GeoUtils.y2lat(mapMain.map.center.y);
        }

        public function getCenterLongitude():Number
        {
            return frontend.components.map.GeoUtils.x2lon(mapMain.map.center.x);
        }

        internal function onLayerSelectionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            frontend.components.map.MapHelperMain.LAYER_OPTION = arg2.rawValue.toString();
            frontend.components.map.MapHelperMain.LAYER_CACHE_SUBDIR = arg2.selectedDataProviderItem.layer;
            mapMain.updateConfig();
            return;
        }

        public function setMapCenterToLocation(arg1:Number, arg2:Number):void
        {
            var loc1:*=frontend.components.map.GeoUtils.lon2x(arg2);
            var loc2:*=frontend.components.map.GeoUtils.lat2y(arg1);
            mapMain.transformationManager.showBoundsTween(loc1, loc1, loc2, loc2);
            return;
        }

        public function showActivityTrack(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        public function showRouteTrack(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        internal function createTrack(arg1:__AS3__.vec.Vector.<Number>):void
        {
            this.track = new sk.yoz.ycanvas.map.display.MapStroke(arg1, 5 * SIGMALink.scaleFactor, core.general.Colors.DARK_BLUE, 0.6);
            this.track.simplifyTolerance = 1;
            return;
        }

        internal function addTrackPoint(arg1:__AS3__.vec.Vector.<Number>, arg2:Number, arg3:Number):__AS3__.vec.Vector.<Number>
        {
            arg1.push(frontend.components.map.GeoUtils.lon2x(arg2));
            arg1.push(frontend.components.map.GeoUtils.lat2y(arg3));
            return arg1;
        }

        public static const MAP_LOCK_CHANGED:String="mapLockChanged";

        internal static const ARROW_HEIGHT:Number=30 * SIGMALink.scaleFactor;

        internal static const BORDER_RADIUS:Number=5 * SIGMALink.scaleFactor;

        internal static const OUTER_PADDING:Number=50 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=10 * SIGMALink.scaleFactor;

        public var mapFocusCallback:Function;

        internal var _mapLockActivated:Boolean=true;

        public var mapSearchCallback:Function;

        public var markerCalloutTouchCallback:Function;

        public var showFocusButton:Boolean=true;

        public var showLockButton:Boolean=true;

        public var showSearchButton:Boolean=false;

        public var yStartCorrection:Number=0;

        internal var _calloutDic:flash.utils.Dictionary;

        internal var _currentCallout:starling.display.DisplayObject;

        internal var _markerDic:flash.utils.Dictionary;

        internal var _validateMapTouchFlag:Boolean=false;

        internal var endMarker:starling.display.DisplayObject;

        internal var focusButton:frontend.components.button.IconButton;

        internal var iconLockButton:frontend.components.button.IconButton;

        internal var layerButton:frontend.components.button.IconButton;

        internal var leftMenuOpen:Boolean=false;

        internal var pointNavigationMarker:starling.display.DisplayObject;

        internal var searchButton:frontend.components.button.IconButton;

        internal var startMarker:starling.display.DisplayObject;

        internal var track:sk.yoz.ycanvas.map.display.MapStroke;

        internal var zoomInButton:feathers.controls.Button;

        internal var zoomOutButton:feathers.controls.Button;

        public var showLayerButton:Boolean=true;

        internal static var mapMain:frontend.components.map.MapHelperMain;
    }
}


//  class MapXyzPartition
package frontend.components.map 
{
    public class MapXyzPartition extends Object
    {
        public function MapXyzPartition(arg1:String, arg2:String, arg3:String)
        {
            super();
            var loc1:*=arg3.split(".");
            this._dir1 = arg1;
            this._dir2 = arg2;
            this._extension = loc1.pop();
            this._filename = loc1.join("");
            return;
        }

        public function get dir1():String
        {
            return this._dir1;
        }

        public function get dir2():String
        {
            return this._dir2;
        }

        public function get extension():String
        {
            return this._extension;
        }

        public function get filename():String
        {
            return this._filename;
        }

        public function getPath():String
        {
            return this._dir1 + "/" + this._dir2 + "/" + this._filename + "." + this._extension;
        }

        internal var _dir1:String;

        internal var _dir2:String;

        internal var _extension:String;

        internal var _filename:String;
    }
}


//  class PartitionLoader
package frontend.components.map 
{
    import flash.display.*;
    import sk.yoz.ycanvas.map.partitions.*;
    
    public class PartitionLoader extends frontend.components.map.LoaderOptimizer implements sk.yoz.ycanvas.map.partitions.IPartitionLoader
    {
        public function PartitionLoader()
        {
            super();
            return;
        }

        public function disposeLoader(arg1:flash.display.Loader):void
        {
            release(arg1);
            return;
        }
    }
}


//  class URLRequestBuffer
package frontend.components.map 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBuffer extends flash.events.EventDispatcher
    {
        public function URLRequestBuffer(arg1:uint, arg2:uint=3000)
        {
            this.activeList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            this.waitingList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            super();
            this.maxRequests = Math.max(1, arg1);
            this.timeout = arg2;
            return;
        }

        public function get countActive():uint
        {
            return this.activeList.length;
        }

        public function get countWaiting():uint
        {
            return this.waitingList.length;
        }

        protected function get firstWaitingReadyItem():frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=null;
            var loc2:*=this.countWaiting;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.waitingList[loc3];
                if (loc1.ready) 
                {
                    return loc1;
                }
                ++loc3;
            }
            return null;
        }

        public function push(arg1:flash.events.EventDispatcher, arg2:flash.net.URLRequest, arg3:flash.system.LoaderContext=null, arg4:uint=0, arg5:uint=0):frontend.components.map.URLRequestBufferItem
        {
            var loc4:*;
            var loc5:*=((loc4 = this).nextID + 1);
            loc4.nextID = loc5;
            var loc1:*=this.getIndexForPriority(arg4);
            var loc2:*=new frontend.components.map.URLRequestBufferItem(this, this.nextID, arg1, arg2, arg3, arg4, arg5);
            this.waitingList.splice(loc1, 0, loc2);
            var loc3:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc3, false, false, loc2));
            this.loadNext();
            return loc2;
        }

        public function getWaitingItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.waitingList[arg1];
        }

        public function getActiveItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.activeList[arg1];
        }

        protected function getIndexForPriority(arg1:uint):uint
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (arg1 > this.waitingList[loc2].priority) 
                {
                    return loc2;
                }
                ++loc2;
            }
            return loc1;
        }

        public function loadNext():void
        {
            if (this.countActive >= this.maxRequests || !this.countWaiting) 
            {
                return;
            }
            var loc1:*=this.firstWaitingReadyItem;
            if (!loc1) 
            {
                return;
            }
            this.removeWaitingById(loc1.id);
            this.createListeners(loc1.dispatcher);
            loc1.load();
            this.activeList.push(loc1);
            flash.utils.setTimeout(this.onTimeout, this.timeout, loc1.id);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return;
        }

        protected function createListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.addEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function removeListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.removeEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function onComplete(arg1:flash.events.Event):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onTimeout(arg1:uint):void
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return;
            }
            this.removeActiveById(arg1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.REQUEST_TIMEOUT;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return;
        }

        public function getWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].id == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getWaitingByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].loader == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getWaitingById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.waitingList.splice(this.waitingList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return loc1;
        }

        public function getActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].id == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getActiveByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].loader == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.removeListeners(loc1.dispatcher);
            loc1.close();
            this.activeList.splice(this.activeList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return loc1;
        }

        internal var activeList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;

        internal var maxRequests:uint=2;

        internal var nextID:uint=0;

        internal var timeout:uint;

        internal var waitingList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;
    }
}


//  class URLRequestBufferEvent
package frontend.components.map 
{
    import flash.events.*;
    
    public class URLRequestBufferEvent extends flash.events.Event
    {
        public function URLRequestBufferEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:frontend.components.map.URLRequestBufferItem=null)
        {
            super(arg1, arg2, arg3);
            this._item = arg4;
            return;
        }

        public function get item():frontend.components.map.URLRequestBufferItem
        {
            return this._item;
        }

        public override function clone():flash.events.Event
        {
            return new frontend.components.map.URLRequestBufferEvent(type, bubbles, cancelable, this.item);
        }

        public static const ACTIVE_REQUEST_ADDED:String="URLRequestBufferActiveRequestAdded";

        public static const ACTIVE_REQUEST_REMOVED:String="URLRequestBufferActiveRequestRemoved";

        public static const REQUEST_TIMEOUT:String="URLRequestBufferRequestTimeout";

        public static const WAITING_REQUEST_ADDED:String="URLRequestBufferWaitingRequestAdded";

        public static const WAITING_REQUEST_REMOVED:String="URLRequestBufferWaitingRequestRemoved";

        internal var _item:frontend.components.map.URLRequestBufferItem;
    }
}


//  class URLRequestBufferItem
package frontend.components.map 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBufferItem extends Object
    {
        public function URLRequestBufferItem(arg1:frontend.components.map.URLRequestBuffer, arg2:uint, arg3:flash.events.EventDispatcher, arg4:flash.net.URLRequest, arg5:flash.system.LoaderContext, arg6:uint, arg7:uint=0)
        {
            super();
            if (!(arg3 is flash.display.Loader || arg3 is flash.net.URLLoader)) 
            {
                throw new Error("loader must be instance of Loader or " + "URLLoader class");
            }
            this.buffer = arg1;
            this.id = arg2;
            this.loader = arg3;
            this.request = arg4;
            this.context = arg5;
            this.priority = arg6;
            this.delay = arg7;
            this._ready = arg7 ? false : true;
            if (arg7) 
            {
                flash.utils.setTimeout(this.onDelay, arg7);
            }
            return;
        }

        public function get dispatcher():flash.events.EventDispatcher
        {
            return this.loader is flash.display.Loader ? (this.loader as flash.display.Loader).contentLoaderInfo : this.loader as flash.net.URLLoader;
        }

        public function get ready():Boolean
        {
            return this._ready;
        }

        public function load():void
        {
            if (this.loader is flash.display.Loader) 
            {
                (this.loader as flash.display.Loader).load(this.request, this.context);
            }
            else if (this.loader is flash.net.URLLoader) 
            {
                (this.loader as flash.net.URLLoader).load(this.request);
            }
            return;
        }

        public function close():void
        {
            try 
            {
                if (this.loader is flash.display.Loader) 
                {
                    (this.loader as flash.display.Loader).close();
                }
                else if (this.loader is flash.net.URLLoader) 
                {
                    (this.loader as flash.net.URLLoader).close();
                }
            }
            catch (error:Error)
            {
            };
            return;
        }

        protected function onDelay(arg1:flash.events.TimerEvent):void
        {
            this._ready = true;
            this.buffer.loadNext();
            return;
        }

        public static function getLoader(arg1:flash.events.Event):flash.events.EventDispatcher
        {
            return arg1.target is flash.display.LoaderInfo ? (arg1.target as flash.display.LoaderInfo).loader : arg1.target as flash.net.URLLoader;
        }

        public var buffer:frontend.components.map.URLRequestBuffer;

        public var context:flash.system.LoaderContext;

        public var delay:uint;

        public var id:uint;

        public var loader:flash.events.EventDispatcher;

        public var priority:uint;

        protected var _ready:Boolean;

        public var request:flash.net.URLRequest;
    }
}


