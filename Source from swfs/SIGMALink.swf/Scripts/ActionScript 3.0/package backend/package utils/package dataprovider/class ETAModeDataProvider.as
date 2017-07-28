//class ETAModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class ETAModeDataProvider extends Object
    {
        public function ETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonETAModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonETAModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


