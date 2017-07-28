//class TimeZoneDataProvider
package backend.utils.dataprovider 
{
    import core.settings.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TimeZoneDataProvider extends Object
    {
        public function TimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTimeZoneDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER);
            DATA_PROVIDER_GPS_10 = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER_GPS_10);
            return;
        }

        public static function getDataProvider(arg1:core.settings.Settings):feathers.data.ListCollection
        {
            if (arg1 is core.settings.SettingsGps10) 
            {
                return DATA_PROVIDER_GPS_10;
            }
            return DATA_PROVIDER;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_GPS_10:feathers.data.ListCollection;
    }
}


