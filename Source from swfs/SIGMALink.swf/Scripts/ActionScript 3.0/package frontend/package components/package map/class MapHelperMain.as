//class MapHelperMain
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


