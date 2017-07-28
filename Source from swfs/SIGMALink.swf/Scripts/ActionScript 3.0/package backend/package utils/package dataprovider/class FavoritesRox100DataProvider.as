//class FavoritesRox100DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox100DataProvider extends Object
    {
        public function FavoritesRox100DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox100DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRIP);
            DATA_PROVIDER_TRACK_ALTI = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRACK_ALTI);
            DATA_PROVIDER_LAP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_LAP);
            DATA_PROVIDER_PAGE_COUNT = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_PAGE_COUNT);
            DATA_PROVIDER_CUSTOM = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_CUSTOM);
            return;
        }

        public static var DATA_PROVIDER_CUSTOM:feathers.data.ListCollection;

        public static var DATA_PROVIDER_LAP:feathers.data.ListCollection;

        public static var DATA_PROVIDER_PAGE_COUNT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRACK_ALTI:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


