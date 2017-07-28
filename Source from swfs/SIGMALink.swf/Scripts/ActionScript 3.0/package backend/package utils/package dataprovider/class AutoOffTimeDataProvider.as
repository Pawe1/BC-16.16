//class AutoOffTimeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class AutoOffTimeDataProvider extends Object
    {
        public function AutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoOffTimeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoOffTimeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


