//class FavoritesRox2010DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox2010DataProvider extends Object
    {
        public function FavoritesRox2010DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox2010DataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER);
            DATA_PROVIDER_ROX8_1 = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER_ROX8_1);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX8_1:feathers.data.ListCollection;
    }
}


