//class FavoritesPC2812DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesPC2812DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function FavoritesPC2812DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesPC2812DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesPC2812DataProvider.V_DATA_PROVIDER_TRIP);
            return;
        }

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


