//class DataProviderUtil
package backend.utils.dataprovider 
{
    public class DataProviderUtil extends Object
    {
        public function DataProviderUtil()
        {
            super();
            return;
        }

        public static function initDataProviders():void
        {
            backend.utils.dataprovider.AltitudeReferenceMarkDataProvider.init();
            backend.utils.dataprovider.AltitudeUnitDataProvider.init();
            backend.utils.dataprovider.AlarmModeDataProvider.init();
            backend.utils.dataprovider.AutoLapDataProvider.init();
            backend.utils.dataprovider.AutoOffTimeDataProvider.init();
            backend.utils.dataprovider.BacklightTimeDataProvider.init();
            backend.utils.dataprovider.BikeTypeDataProvider.init();
            backend.utils.dataprovider.ClockFormatDataProvider.init();
            backend.utils.dataprovider.DateFormatDataProvider.init();
            backend.utils.dataprovider.DistanceUnitDataProvider.init();
            backend.utils.dataprovider.FavoritesPC2812DataProvider.init();
            backend.utils.dataprovider.FavoritesRoxDataProvider.init();
            backend.utils.dataprovider.FavoritesRox100DataProvider.init();
            backend.utils.dataprovider.FavoritesRox2010DataProvider.init();
            backend.utils.dataprovider.GenderDataProvider.init();
            backend.utils.dataprovider.GPSFormatDataProvider.init();
            backend.utils.dataprovider.HeightUnitDataProvider.init();
            backend.utils.dataprovider.LanguageDataProvider.init();
            backend.utils.dataprovider.MeasurementDataProvider.init();
            backend.utils.dataprovider.SamplingRateDataProvider.init();
            backend.utils.dataprovider.TemperatureUnitDataProvider.init();
            backend.utils.dataprovider.TimeZoneDataProvider.init();
            backend.utils.dataprovider.TireModeDataProvider.init();
            backend.utils.dataprovider.TrainingZoneDataProvider.init();
            backend.utils.dataprovider.WeightUnitDataProvider.init();
            backend.utils.dataprovider.WheelSizeSelectionModeDataProvider.init();
            backend.utils.dataprovider.RouteOptionsDataProvider.init();
            backend.utils.dataprovider.FuelConsumptionDataProvider.init();
            backend.utils.dataprovider.ETAModeDataProvider.init();
            backend.utils.dataprovider.TrackDirectionDataProvider.init();
            backend.utils.dataprovider.TrackDistanceDataProvider.init();
            return;
        }
    }
}


