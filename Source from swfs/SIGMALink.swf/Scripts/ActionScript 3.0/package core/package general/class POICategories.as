//class POICategories
package core.general 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class POICategories extends Object
    {
        public function POICategories()
        {
            super();
            return;
        }

        public static function categoryId(arg1:String):int
        {
            var loc2:*=0;
            var loc1:*=DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1 == DATA_PROVIDER[loc2].value) 
                {
                    return DATA_PROVIDER[loc2].id;
                }
                ++loc2;
            }
            return 0;
        }

        public static function categoryType(arg1:int):String
        {
            var loc2:*=0;
            var loc1:*=DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1 == DATA_PROVIDER[loc2].id) 
                {
                    return DATA_PROVIDER[loc2].value;
                }
                ++loc2;
            }
            return "";
        }

        
        {
            new __AS3__.vec.Vector.<Object>(11)[0] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_NOTHING"), "value":"", "id":0};
            new __AS3__.vec.Vector.<Object>(11)[1] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_CYCLING"), "value":"cycling", "id":1};
            new __AS3__.vec.Vector.<Object>(11)[2] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_RESTAURANT"), "value":"sustenance ", "id":2};
            new __AS3__.vec.Vector.<Object>(11)[3] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_HOTEL"), "value":"accommodation", "id":3};
            new __AS3__.vec.Vector.<Object>(11)[4] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_CINEMA"), "value":"entertainment", "id":4};
            new __AS3__.vec.Vector.<Object>(11)[5] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_BANK"), "value":"money", "id":5};
            new __AS3__.vec.Vector.<Object>(11)[6] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_GAS_STATION"), "value":"automobile", "id":6};
            new __AS3__.vec.Vector.<Object>(11)[7] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_HOSPITALS"), "value":"health", "id":7};
            new __AS3__.vec.Vector.<Object>(11)[8] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_TOURIST_INFO"), "value":"tourism", "id":8};
            new __AS3__.vec.Vector.<Object>(11)[9] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_SHOPPING"), "value":"shopping", "id":9};
            new __AS3__.vec.Vector.<Object>(11)[10] = {"label":utils.LanguageManager.getString("ROUTE_POI_CATEGORY_WIKIPEDIA"), "value":"wikipedia", "id":10};
            DATA_PROVIDER = new __AS3__.vec.Vector.<Object>(11);
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


