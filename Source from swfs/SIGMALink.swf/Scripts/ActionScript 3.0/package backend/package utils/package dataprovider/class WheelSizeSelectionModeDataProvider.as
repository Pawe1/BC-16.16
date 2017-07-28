//class WheelSizeSelectionModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class WheelSizeSelectionModeDataProvider extends Object
    {
        public function WheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


