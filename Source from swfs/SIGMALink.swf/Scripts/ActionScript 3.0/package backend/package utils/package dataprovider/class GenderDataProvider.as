//class GenderDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class GenderDataProvider extends Object
    {
        public function GenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonGenderDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonGenderDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


