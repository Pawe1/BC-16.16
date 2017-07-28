//class CommonRouteOptionsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonRouteOptionsDataProvider extends Object
    {
        public function CommonRouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_SUITABLE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HIKING"), "param":"trekking", "sportId":"6", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_WALKING"), "param":"walking", "sportId":"5", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RUNNING"), "param":"jogging", "sportId":"4", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_BICYCLETOUR"), "param":"biking", "sportId":"3", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_MOUNTAINBIKE"), "param":"mountainbiking", "sportId":"2", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RACINGBICYCLE"), "param":"racingbike", "sportId":"1", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_INLINESKATING"), "param":"skating", "sportId":"12", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_CROSSSKATING"), "param":"crossskating", "sportId":"12", "selectable":false}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HANDBIKE"), "param":"handcycle", "sportId":"15", "selectable":true}]);
            V_CHARACTERISTIC_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_FLAT"), "param":"flat"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_HILLY"), "param":"hilly"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_MOUNTAINOUS"), "param":"mountainous"}]);
            V_TYPE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ALL"), "data":0}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ROUND_TRIP"), "data":1}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ONE_WAY_TRIP"), "data":2}]);
            return;
        }

        public static function resolveSportId(arg1:String):uint
        {
            var loc3:*=0;
            var loc2:*=V_SUITABLE_DATA_PROVIDER.length;
            var loc1:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc3].param == arg1) 
                {
                    loc1 = V_SUITABLE_DATA_PROVIDER[loc3].sportId;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public static function resolveSportParams():Array
        {
            return getParams(V_SUITABLE_DATA_PROVIDER);
        }

        public static function resolveSportParam(arg1:int):String
        {
            var loc2:*=0;
            var loc1:*=V_SUITABLE_DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc2].sportId == arg1) 
                {
                    return V_SUITABLE_DATA_PROVIDER[loc2].param;
                }
                ++loc2;
            }
            return "biking";
        }

        public static function resolveCategoryParams():Array
        {
            return getParams(V_CHARACTERISTIC_DATA_PROVIDER);
        }

        internal static function getParams(arg1:__AS3__.vec.Vector.<Object>):Array
        {
            var loc3:*=0;
            var loc2:*=undefined;
            loc2 = arg1;
            var loc1:*=loc2.length;
            var loc4:*=[];
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4[loc4.length] = "\'" + loc2[loc3].param + "\'";
                ++loc3;
            }
            return loc4;
        }

        public static var V_CHARACTERISTIC_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_SUITABLE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_TYPE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


