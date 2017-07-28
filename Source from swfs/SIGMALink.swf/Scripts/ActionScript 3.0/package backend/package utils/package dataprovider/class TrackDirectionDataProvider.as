//class TrackDirectionDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrackDirectionDataProvider extends Object
    {
        public function TrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrackDirectionDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTrackDirectionDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


