//class TrainingZoneDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrainingZoneDataProvider extends Object
    {
        public function TrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrainingZoneDataProvider.init();
            DATA_PROVIDER_FIT_FAT = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_FIT_FAT);
            DATA_PROVIDER_HEARTRATE_LIMITS = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_HEARTRATE_LIMITS);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_RCMOVE = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_RCMOVE);
            return;
        }

        public static var DATA_PROVIDER_FIT_FAT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_HEARTRATE_LIMITS:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RCMOVE:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;
    }
}


