//class MapLayerOptions
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


