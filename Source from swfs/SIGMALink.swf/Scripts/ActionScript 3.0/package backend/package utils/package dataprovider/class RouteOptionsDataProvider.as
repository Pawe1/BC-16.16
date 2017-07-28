//class RouteOptionsDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class RouteOptionsDataProvider extends Object
    {
        public function RouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonRouteOptionsDataProvider.init();
            _suitableDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_SUITABLE_DATA_PROVIDER);
            _characteristicsDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_CHARACTERISTIC_DATA_PROVIDER);
            _typeDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_TYPE_DATA_PROVIDER);
            return;
        }

        public static function getSuitableDataProvider():feathers.data.ListCollection
        {
            return _suitableDataProvider;
        }

        public static function getCharacteristicsDataProvider():feathers.data.ListCollection
        {
            return _characteristicsDataProvider;
        }

        public static function getTypeDataProvider():feathers.data.ListCollection
        {
            return _typeDataProvider;
        }

        internal static var _characteristicsDataProvider:feathers.data.ListCollection;

        internal static var _suitableDataProvider:feathers.data.ListCollection;

        internal static var _typeDataProvider:feathers.data.ListCollection;
    }
}


